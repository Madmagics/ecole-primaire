-- Fiches de cours (2026-09-29) : chaque paquet de contenu (classe + matière) contient désormais
-- la liste de ses notions avec leur libellé ("notions": [{"code", "libelle"}], dans l'ordre des
-- notions). Le jeu en a besoin pour le sommaire des cours (fenêtre "Cours" : liste des notions
-- d'une matière, avec un lien vers la fiche quand elle existe).
-- Seul changement par rapport à notions_3_publication_vues.sql : le bloc 'notions' ajouté dans
-- la construction des paquets (étape d). Tous les paquets changent donc une fois de version et
-- seront retéléchargés une fois par les joueurs (quelques centaines de Ko au total).
--
-- À lancer sur le VPS avec le compte postgres (propriétaire de la fonction) :
--   sudo docker exec -i supabase-db psql -U postgres -d postgres -v ON_ERROR_STOP=1 < ~/fiches_1_notions_paquets.sql

create or replace function fn_publier(p_forcer boolean default false)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_paire record;
	v_donnees jsonb;
	v_empreinte text;
	v_nb integer;
	v_ancien contenu_paquets%rowtype;
	v_rapport jsonb := '[]'::jsonb;
	v_probleme text;
begin
	-- a) Cohérence de la lecture
	select 'question ' || q.id || ' publiée mais son texte ' || q.passage_id || ' ne l''est pas' into v_probleme
	from contenu_questions q join contenu_passages p on p.id = q.passage_id
	where q.statut = 'publie' and p.statut <> 'publie' limit 1;
	if v_probleme is not null then raise exception 'publication_refusee: %', v_probleme; end if;

	select 'texte ' || p.id || ' publié sans aucune question publiée' into v_probleme
	from contenu_passages p
	where p.statut = 'publie'
	  and not exists (select 1 from contenu_questions q where q.passage_id = p.id and q.statut = 'publie')
	limit 1;
	if v_probleme is not null then raise exception 'publication_refusee: %', v_probleme; end if;

	select 'question ' || q.id || ' (' || q.classe || ') liée au texte ' || p.id || ' d''une autre classe (' || p.classe || ')' into v_probleme
	from contenu_questions q join contenu_passages p on p.id = q.passage_id
	where q.statut = 'publie' and q.classe <> p.classe limit 1;
	if v_probleme is not null then raise exception 'publication_refusee: %', v_probleme; end if;

	-- b) Fiches publiées : chacune doit avoir au moins une question publiée de sa notion, dans sa classe
	select 'fiche ' || c.id || ' (' || c.classe || ', notion ' || n.code || ') publiée sans aucune question publiée' into v_probleme
	from contenu_cours c join contenu_notions n on n.id = c.notion_id
	where c.statut = 'publie'
	  and not exists (select 1 from contenu_questions q where q.notion_id = c.notion_id and q.classe = c.classe and q.statut = 'publie')
	limit 1;
	if v_probleme is not null then raise exception 'publication_refusee: %', v_probleme; end if;

	select 'fiche ' || c.id || ' publiée sans notion' into v_probleme
	from contenu_cours c where c.statut = 'publie' and c.notion_id is null limit 1;
	if v_probleme is not null then raise exception 'publication_refusee: %', v_probleme; end if;

	-- c) Un paquet existant ne doit pas disparaître en silence
	select 'le paquet ' || pk.classe || '/' || pk.matiere || ' n''aurait plus aucune question' into v_probleme
	from contenu_paquets pk
	where not exists (select 1 from contenu_questions q where q.classe = pk.classe and q.matiere = pk.matiere and q.statut = 'publie')
	limit 1;
	if v_probleme is not null and not p_forcer then raise exception 'publication_refusee: %', v_probleme; end if;

	-- d) Construction des paquets, un par classe + matière
	for v_paire in
		select distinct classe, matiere from contenu_questions where statut = 'publie' order by 1, 2
	loop
		select jsonb_build_object(
			'questions', coalesce((
				select jsonb_agg(jsonb_strip_nulls(jsonb_build_object(
					'id', q.id, 'enonce', q.enonce, 'reponse', q.bonne_reponse,
					'choix', to_jsonb(q.mauvais_choix), 'grille', to_jsonb(q.grille),
					'passage', q.passage_id, 'type', q.type_lecture, 'notion', n.code
				)) order by q.id)
				from contenu_questions q
				join contenu_notions n on n.id = q.notion_id
				where q.classe = v_paire.classe and q.matiere = v_paire.matiere and q.statut = 'publie'
			), '[]'::jsonb),
			'passages', coalesce((
				select jsonb_agg(jsonb_build_object('id', p.id, 'texte', p.texte) order by p.id)
				from contenu_passages p
				where p.statut = 'publie' and p.id in (
					select q.passage_id from contenu_questions q
					where q.classe = v_paire.classe and q.matiere = v_paire.matiere and q.statut = 'publie')
			), '[]'::jsonb),
			'notions', coalesce((
				select jsonb_agg(jsonb_build_object('code', n.code, 'libelle', n.libelle) order by n.ordre)
				from contenu_notions n
				where n.id in (
					select q.notion_id from contenu_questions q
					where q.classe = v_paire.classe and q.matiere = v_paire.matiere and q.statut = 'publie')
			), '[]'::jsonb),
			'cours', coalesce((
				select jsonb_agg(jsonb_build_object('id', c.id, 'notion', n.code, 'titre', c.titre, 'contenu', c.contenu) order by n.ordre)
				from contenu_cours c
				join contenu_notions n on n.id = c.notion_id
				where c.statut = 'publie' and c.classe = v_paire.classe and c.notion_id in (
					select q.notion_id from contenu_questions q
					where q.classe = v_paire.classe and q.matiere = v_paire.matiere and q.statut = 'publie')
			), '[]'::jsonb)
		) into v_donnees;

		v_nb := jsonb_array_length(v_donnees -> 'questions');
		v_empreinte := md5(v_donnees::text);

		select * into v_ancien from contenu_paquets where classe = v_paire.classe and matiere = v_paire.matiere;
		if found then
			if v_ancien.empreinte = v_empreinte then
				continue; -- rien n'a changé : on garde la même version
			end if;
			if v_nb < v_ancien.nb_questions / 2 and not p_forcer then
				raise exception 'publication_refusee: %/% passerait de % à % questions (relancer avec fn_publier(true) si c''est voulu)',
					v_paire.classe, v_paire.matiere, v_ancien.nb_questions, v_nb;
			end if;
			update contenu_paquets
			set version = version + 1, empreinte = v_empreinte, nb_questions = v_nb, donnees = v_donnees, publie_le = now()
			where classe = v_paire.classe and matiere = v_paire.matiere;
		else
			insert into contenu_paquets (classe, matiere, empreinte, nb_questions, donnees)
			values (v_paire.classe, v_paire.matiere, v_empreinte, v_nb, v_donnees);
		end if;

		v_rapport := v_rapport || jsonb_build_object('paquet', v_paire.classe || '/' || v_paire.matiere, 'questions', v_nb);
	end loop;

	-- e) Paquets devenus vides (seulement possible avec p_forcer) : retirés
	delete from contenu_paquets pk
	where not exists (select 1 from contenu_questions q where q.classe = pk.classe and q.matiere = pk.matiere and q.statut = 'publie');

	return jsonb_build_object('paquets_mis_a_jour', v_rapport);
end;
$$;

-- Reconstruit tout de suite les paquets avec leurs notions
select fn_publier();
