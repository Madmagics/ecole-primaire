-- ============================================================================
-- parties_du_jour_detail.sql (2026-11-28)
-- Limites du controle parental PAR CLASSE et PAR MATIERE : le jeu doit retrouver, d'un appareil
-- a l'autre, combien de parties ont ete faites aujourd'hui dans chaque classe/matiere.
-- fn_recuperer_progression renvoie en plus "parties_detail_par_jour" :
--   {"AAAA-MM-JJ": {"<classe>/<matiere>": n}}   (ex. "0/3" = CP / Conjugaison)
-- sur les 3 derniers jours, a partir des evenements 'partie_terminee' (payload grade/subject/jour,
-- deja envoyes par le jeu). Reprend a l'identique la version de parties_du_jour.sql (2026-11-25),
-- "parties_par_jour" reste renvoye pour les anciennes versions du jeu.
-- LECTURE SEULE : aucune donnee joueur modifiee.
-- ============================================================================
begin;

create or replace function fn_recuperer_progression(p_jeton text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_ligne progressions%rowtype;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	-- Preuve de presence (2026-09-13, chantier "conflit de connexion", voir fn_login).
	update sessions set derniere_activite = now() where jeton = p_jeton;

	select * into v_ligne from progressions where compte_id = v_compte_id;
	if not found then
		raise exception 'compte_introuvable';
	end if;

	return jsonb_build_object(
		'economy', v_ligne.economy,
		'cards', v_ligne.cards,
		'defis', v_ligne.defis,
		'prof_skins', v_ligne.prof_skins,
		'classroom_decor', v_ligne.classroom_decor,
		'classroom_music', v_ligne.classroom_music,
		'tirages', (select coalesce(jsonb_object_agg(t.cle, t.etat), '{}'::jsonb)
		            from tirages t where t.compte_id = v_compte_id),
		'parties_par_jour', (select coalesce(jsonb_object_agg(j.jour, j.nb), '{}'::jsonb)
		    from (select coalesce(e.payload->>'jour',
		                          to_char(e.horodatage_client at time zone 'Europe/Paris', 'YYYY-MM-DD')) as jour,
		                 count(*) as nb
		          from evenements e
		          where e.compte_id = v_compte_id
		            and e.type = 'partie_terminee'
		            and e.recu_le > now() - interval '3 days'
		          group by 1) j),
		'parties_detail_par_jour', (select coalesce(jsonb_object_agg(d.jour, d.detail), '{}'::jsonb)
		    from (select c.jour, jsonb_object_agg(c.cle, c.nb) as detail
		          from (select coalesce(e.payload->>'jour',
		                                to_char(e.horodatage_client at time zone 'Europe/Paris', 'YYYY-MM-DD')) as jour,
		                       (e.payload->>'grade') || '/' || (e.payload->>'subject') as cle,
		                       count(*) as nb
		                from evenements e
		                where e.compte_id = v_compte_id
		                  and e.type = 'partie_terminee'
		                  and e.recu_le > now() - interval '3 days'
		                  and e.payload ? 'grade' and e.payload ? 'subject'
		                group by 1, 2) c
		          group by c.jour) d)
	);
end;
$$;

commit;
