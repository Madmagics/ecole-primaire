-- ============================================================================
-- Vues de lecture pour le Table Editor de Supabase Studio (2026-09-26).
-- Ne modifie AUCUNE donnée. Peut être recollé sans risque (create or replace).
-- security_invoker = true : la vue respecte les droits de celui qui la lit
-- -> le rôle public (anon, utilisé par le jeu) ne voit rien, comme pour les tables.
-- ============================================================================

-- Toutes les questions, une colonne par mauvais choix + titre du cours lié
create or replace view vue_questions with (security_invoker = true) as
select
	q.id, q.classe, q.matiere, q.statut,
	q.enonce, q.bonne_reponse,
	q.mauvais_choix[1] as choix_1,
	q.mauvais_choix[2] as choix_2,
	q.mauvais_choix[3] as choix_3,
	cardinality(q.mauvais_choix) + 1 as nb_reponses,
	q.passage_id, q.type_lecture,
	array_to_string(q.grille, ' | ') as grille,
	q.cours_id, c.titre as cours_titre,
	q.modifie_le
from contenu_questions q
left join contenu_cours c on c.id = q.cours_id;

-- Lecture : chaque question avec le début de son texte à côté
create or replace view vue_lecture with (security_invoker = true) as
select
	q.id, q.classe, q.statut,
	q.passage_id,
	left(replace(p.texte, E'\n', ' '), 120) || '…' as debut_texte,
	q.type_lecture,
	q.enonce, q.bonne_reponse,
	q.mauvais_choix[1] as choix_1,
	q.mauvais_choix[2] as choix_2,
	q.mauvais_choix[3] as choix_3
from contenu_questions q
join contenu_passages p on p.id = q.passage_id;

-- Tableau de bord : nombre de questions par classe et matière + version publiée
create or replace view vue_stats with (security_invoker = true) as
select
	q.classe, q.matiere,
	count(*) as total,
	count(*) filter (where q.statut = 'publie') as publiees,
	count(*) filter (where q.statut = 'brouillon') as brouillons,
	count(*) filter (where q.statut = 'archive') as archivees,
	count(*) filter (where cardinality(q.mauvais_choix) = 1) as a_2_reponses,
	count(*) filter (where q.cours_id is not null) as avec_cours,
	pk.version as version_publiee,
	pk.publie_le as derniere_publication
from contenu_questions q
left join contenu_paquets pk on pk.classe = q.classe and pk.matiere = q.matiere
group by q.classe, q.matiere, pk.version, pk.publie_le;

revoke all on vue_questions, vue_lecture, vue_stats from anon, authenticated;
