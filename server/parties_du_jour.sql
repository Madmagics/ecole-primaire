-- ============================================================================
-- parties_du_jour.sql (2026-11-25)
-- Compteur "parties du jour" (limite du controle parental) suivi d'un appareil a l'autre.
-- Avant : compteur garde uniquement dans la sauvegarde locale du navigateur -> repartait de 0
-- sur un autre appareil. Le serveur a deja l'info (evenements 'partie_terminee', voir
-- admin_1_collecte.sql) : fn_recuperer_progression renvoie en plus "parties_par_jour", le nombre
-- de parties terminees par jour sur les 3 derniers jours, {"AAAA-MM-JJ": n}.
-- Jour = champ "jour" du payload (date locale de l'appareil, envoye par le jeu a partir de cette
-- version), sinon date de l'horodatage a l'heure de Paris (parties plus anciennes).
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
		          group by 1) j)
	);
end;
$$;

commit;
