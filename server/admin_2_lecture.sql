-- ============================================================================
-- admin_2_lecture.sql (2026-11-08)
-- Etape 3 de la page admin : 3 fonctions de LECTURE SEULE pour https://admin.ecole-primaire.eu
-- * fn_admin_resume()        : chiffres globaux + creations de comptes par jour
-- * fn_admin_comptes()       : 1 ligne par compte (tableau filtrable de la page)
-- * fn_admin_compte(p_id)    : fiche detaillee d'un compte
-- Aucune ne modifie quoi que ce soit (que des select). Reservees au role service_role (la cle
-- que Caddy ajoute pour admin.ecole-primaire.eu) : interdites a anon/authenticated, donc
-- inaccessibles depuis le jeu ou depuis l'adresse api.ecole-primaire.eu avec la cle publique.
-- Les infos sensibles du profil (mot de passe du controle parental, date de naissance) ne sont
-- jamais renvoyees. A lancer avec le compte postgres.
-- ============================================================================
begin;

-- Derniere activite connue d'un compte (toutes sources confondues)
create or replace function fn_admin_derniere_activite(p_id text)
returns timestamptz
language sql
stable
security definer
set search_path = public, extensions
as $$
	select greatest(
		(select max(greatest(debut, coalesce(fin, debut))) from connexions where compte_id = p_id),
		(select max(recu_le) from evenements where compte_id = p_id),
		(select max(maj_le) from tirages where compte_id = p_id),
		(select max(derniere_activite) from sessions where compte_id = p_id)
	);
$$;

-- 1. Resume global
create or replace function fn_admin_resume()
returns jsonb
language sql
stable
security definer
set search_path = public, extensions
as $$
	with act as (
		select id, fn_admin_derniere_activite(id) as derniere from comptes
	)
	select jsonb_build_object(
		'genere_le', now(),
		'total_comptes', (select count(*) from comptes),
		'emails_verifies', (select count(*) from comptes where email_verifie),
		'actifs_24h', (select count(*) from act where derniere > now() - interval '24 hours'),
		'actifs_7j', (select count(*) from act where derniere > now() - interval '7 days'),
		'actifs_30j', (select count(*) from act where derniere > now() - interval '30 days'),
		'connectes_maintenant', (select count(distinct compte_id) from sessions
			where derniere_activite > now() - interval '2 minutes'),
		'parties_total', (select count(*) from evenements where type = 'partie_terminee'),
		'parties_7j', (select count(*) from evenements where type = 'partie_terminee'
			and recu_le > now() - interval '7 days'),
		'reussite_moyenne', (select round(avg((payload->>'bonnes')::numeric * 100
			/ nullif((payload->>'total')::numeric, 0)), 1)
			from evenements where type = 'partie_terminee'),
		'creations', coalesce((
			select jsonb_agg(jsonb_build_object('jour', jour, 'n', n) order by jour)
			from (select (cree_le at time zone 'Europe/Paris')::date as jour, count(*) as n
				from comptes group by 1) j
		), '[]'::jsonb),
		'deconnexions', coalesce((
			select jsonb_object_agg(coalesce(raison_fin, 'en_cours'), n)
			from (select raison_fin, count(*) as n from connexions group by 1) r
		), '{}'::jsonb),
		'navigateurs', coalesce((
			select jsonb_agg(jsonb_build_object('navigateur', navigateur, 'plateforme', plateforme, 'n', n))
			from (select navigateur, plateforme, count(*) as n from connexions
				where debut > now() - interval '30 days' and navigateur is not null
				group by 1, 2 order by 3 desc limit 200) nv
		), '[]'::jsonb),
		'parties_par_matiere', coalesce((
			select jsonb_agg(jsonb_build_object('grade', g, 'subject', s, 'parties', n, 'moyenne', m)
				order by g, s)
			from (select (payload->>'grade')::int as g, (payload->>'subject')::int as s, count(*) as n,
					round(avg((payload->>'bonnes')::numeric * 100
						/ nullif((payload->>'total')::numeric, 0)), 1) as m
				from evenements where type = 'partie_terminee' group by 1, 2) pm
		), '[]'::jsonb)
	);
$$;

-- 2. Liste des comptes
create or replace function fn_admin_comptes()
returns jsonb
language sql
stable
security definer
set search_path = public, extensions
as $$
	select coalesce(jsonb_agg(ligne order by (ligne->>'cree_le') desc), '[]'::jsonb)
	from (
		select jsonb_build_object(
			'id', c.id,
			'login', c.login,
			'prenom', c.profil->>'prenom',
			'nom', c.profil->>'nom',
			'classe', c.profil->'classe',
			'email', c.email,
			'email_verifie', c.email_verifie,
			'cree_le', c.cree_le,
			'derniere_activite', fn_admin_derniere_activite(c.id),
			'dernier_jeu', (select jsonb_build_object('grade', e.payload->'grade', 'subject', e.payload->'subject',
					'bonnes', e.payload->'bonnes', 'total', e.payload->'total', 'date', e.recu_le)
				from evenements e where e.compte_id = c.id and e.type = 'partie_terminee'
				order by e.recu_le desc limit 1),
			'dernier_tirage', (select jsonb_build_object('cle', t.cle, 'date', t.maj_le)
				from tirages t where t.compte_id = c.id order by t.maj_le desc limit 1),
			'parties', (select count(*) from evenements e
				where e.compte_id = c.id and e.type = 'partie_terminee'),
			'moyenne', (select round(avg((e.payload->>'bonnes')::numeric * 100
					/ nullif((e.payload->>'total')::numeric, 0)), 1)
				from evenements e where e.compte_id = c.id and e.type = 'partie_terminee'),
			'cartes_distinctes', (select count(*) from jsonb_object_keys(coalesce(p.cards, '{}'::jsonb))),
			'cartes_total', (select coalesce(sum(v::int), 0) from jsonb_each_text(coalesce(p.cards, '{}'::jsonb)) as x(k, v)),
			'defis_total', (select coalesce(sum(s.v::int), 0)
				from jsonb_each(coalesce(p.defis, '{}'::jsonb)) as g(k, val),
					lateral jsonb_each_text(case when jsonb_typeof(g.val) = 'object' then g.val else '{}'::jsonb end) as s(k, v)),
			'connexions', (select count(*) from connexions x where x.compte_id = c.id),
			'deconnexions', coalesce((select jsonb_object_agg(r, n) from (
				select coalesce(raison_fin, 'en_cours') as r, count(*) as n
				from connexions x where x.compte_id = c.id group by 1) d), '{}'::jsonb)
		) as ligne
		from comptes c
		left join progressions p on p.compte_id = c.id
	) l;
$$;

-- 3. Fiche detaillee d'un compte
create or replace function fn_admin_compte(p_id text)
returns jsonb
language sql
stable
security definer
set search_path = public, extensions
as $$
	select jsonb_build_object(
		'id', c.id,
		'login', c.login,
		'prenom', c.profil->>'prenom',
		'nom', c.profil->>'nom',
		'classe', c.profil->'classe',
		'pays', c.profil->>'pays',
		'email', c.email,
		'email_verifie', c.email_verifie,
		'cree_le', c.cree_le,
		'derniere_activite', fn_admin_derniere_activite(c.id),
		'pieces', coalesce(p.economy, '{}'::jsonb),
		'cartes', coalesce(p.cards, '{}'::jsonb),
		'defis', coalesce(p.defis, '{}'::jsonb),
		'parties_par_matiere', coalesce((
			select jsonb_agg(jsonb_build_object('grade', g, 'subject', s, 'parties', n, 'moyenne', m,
				'meilleure', b, 'derniere', d) order by g, s)
			from (select (payload->>'grade')::int as g, (payload->>'subject')::int as s, count(*) as n,
					round(avg((payload->>'bonnes')::numeric * 100
						/ nullif((payload->>'total')::numeric, 0)), 1) as m,
					max(round((payload->>'bonnes')::numeric * 100
						/ nullif((payload->>'total')::numeric, 0))) as b,
					max(recu_le) as d
				from evenements where compte_id = c.id and type = 'partie_terminee' group by 1, 2) pm
		), '[]'::jsonb),
		'parties_recentes', coalesce((
			select jsonb_agg(jsonb_build_object('grade', payload->'grade', 'subject', payload->'subject',
				'bonnes', payload->'bonnes', 'total', payload->'total', 'date', recu_le) order by recu_le desc)
			from (select payload, recu_le from evenements
				where compte_id = c.id and type = 'partie_terminee'
				order by recu_le desc limit 50) pr
		), '[]'::jsonb),
		'tirages', coalesce((
			select jsonb_agg(jsonb_build_object('cle', cle, 'date', maj_le) order by maj_le desc)
			from tirages where compte_id = c.id
		), '[]'::jsonb),
		'connexions', coalesce((
			select jsonb_agg(jsonb_build_object('debut', debut, 'fin', fin, 'raison', raison_fin,
				'detail', detail_fin, 'navigateur', navigateur, 'plateforme', plateforme) order by debut desc)
			from (select * from connexions where compte_id = c.id order by debut desc limit 100) cx
		), '[]'::jsonb)
	)
	from comptes c
	left join progressions p on p.compte_id = c.id
	where c.id = p_id;
$$;

-- Droits : uniquement service_role (cle ajoutee par Caddy sur admin.ecole-primaire.eu)
revoke execute on function fn_admin_derniere_activite(text) from public, anon, authenticated;
revoke execute on function fn_admin_resume() from public, anon, authenticated;
revoke execute on function fn_admin_comptes() from public, anon, authenticated;
revoke execute on function fn_admin_compte(text) from public, anon, authenticated;
grant execute on function fn_admin_derniere_activite(text) to service_role;
grant execute on function fn_admin_resume() to service_role;
grant execute on function fn_admin_comptes() to service_role;
grant execute on function fn_admin_compte(text) to service_role;

commit;

notify pgrst, 'reload schema';
