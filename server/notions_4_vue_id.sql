-- ============================================================================
-- notions_4_vue_id.sql (2026-09-28)
-- Ajoute l'ID de la notion (notion_id) en 2e colonne de vue_notions, pour
-- faire le lien avec la colonne notion_id de contenu_questions / contenu_cours.
-- Postgres ne sait pas insérer une colonne au milieu d'une vue existante :
-- on la supprime et on la recrée (aucune autre vue n'en dépend, vérifié).
-- ============================================================================
begin;

drop view if exists vue_notions;

create view vue_notions with (security_invoker = true) as
select
	n.domaine, n.id as notion_id, n.libelle as notion, n.code,
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

-- Mêmes droits qu'avant : pas d'accès public, lecture pour l'accès Claude
revoke all on vue_notions from anon, authenticated;
grant select on vue_notions to claude_contenu;

commit;
