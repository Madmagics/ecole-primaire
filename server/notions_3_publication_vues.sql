-- ============================================================================
-- NOTIONS - étape 3/3 : publication + vues Studio (2026-09-27)
-- * Retire l'ancienne colonne questions.cours_id (vide : aucune fiche n'existe encore),
--   remplacée par le lien notion : fiche (notion + classe) -> questions de la même notion + classe.
-- * fn_publier : envoie la notion de chaque question au jeu, et les fiches de la classe
--   dont la notion est présente dans le paquet ; refuse une fiche publiée sans question.
-- * Vues : vue_notions (tableau récap), vue_questions (+ notion), vue_stats.
-- ============================================================================
begin;

-- Sécurité : on s'arrête si des questions avaient quand même un cours rattaché
do $$ begin
	if exists (select 1 from contenu_questions where cours_id is not null) then
		raise exception 'ANNULÉ : des questions ont un cours_id, à examiner avant de continuer';
	end if;
end $$;

drop view if exists vue_questions;
drop view if exists vue_stats;
alter table contenu_questions drop column cours_id;

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


revoke execute on function fn_publier(boolean) from public, anon, authenticated;

-- Tableau récap : une ligne par notion, nombre de questions par classe, nombre de fiches
create or replace view vue_notions with (security_invoker = true) as
select
	n.domaine, n.libelle as notion, n.code,
	count(q.id) filter (where q.classe = 'cp')  as cp,
	count(q.id) filter (where q.classe = 'ce1') as ce1,
	count(q.id) filter (where q.classe = 'ce2') as ce2,
	count(q.id) filter (where q.classe = 'cm1') as cm1,
	count(q.id) filter (where q.classe = 'cm2') as cm2,
	count(q.id) as total,
	count(q.id) filter (where q.statut = 'brouillon') as brouillons,
	coalesce(string_agg(distinct q.matiere, ', '), '') as matieres,
	(select count(*) from contenu_cours c where c.notion_id = n.id and c.statut <> 'archive') as fiches,
	(select coalesce(string_agg(c.classe, ', ' order by c.classe), '') from contenu_cours c
	 where c.notion_id = n.id and c.statut <> 'archive') as fiches_classes,
	n.ordre
from contenu_notions n
left join contenu_questions q on q.notion_id = n.id and q.statut <> 'archive'
group by n.id
order by n.ordre;

-- Toutes les questions avec leur notion (filtrer sur notion + classe = le contenu d'une fiche)
create or replace view vue_questions with (security_invoker = true) as
select
	q.id, q.classe, q.matiere, n.domaine, n.libelle as notion, n.code as notion_code, q.statut,
	q.enonce, q.bonne_reponse,
	q.mauvais_choix[1] as choix_1,
	q.mauvais_choix[2] as choix_2,
	q.mauvais_choix[3] as choix_3,
	cardinality(q.mauvais_choix) + 1 as nb_reponses,
	q.passage_id, q.type_lecture,
	array_to_string(q.grille, ' | ') as grille,
	c.id as fiche_id, c.titre as fiche_titre,
	q.modifie_le
from contenu_questions q
join contenu_notions n on n.id = q.notion_id
left join contenu_cours c on c.notion_id = q.notion_id and c.classe = q.classe and c.statut <> 'archive';

create or replace view vue_stats with (security_invoker = true) as
select
	q.classe, q.matiere,
	count(*) as total,
	count(*) filter (where q.statut = 'publie') as publiees,
	count(*) filter (where q.statut = 'brouillon') as brouillons,
	count(*) filter (where q.statut = 'archive') as archivees,
	count(*) filter (where cardinality(q.mauvais_choix) = 1) as a_2_reponses,
	count(distinct q.notion_id) as notions,
	pk.version as version_publiee,
	pk.publie_le as derniere_publication
from contenu_questions q
left join contenu_paquets pk on pk.classe = q.classe and pk.matiere = q.matiere
group by q.classe, q.matiere, pk.version, pk.publie_le;

revoke all on vue_notions, vue_questions, vue_stats from anon, authenticated;

commit;
