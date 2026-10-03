-- ============================================================================
-- signalements.sql (2026-10-03)
-- Signalement d'un probleme sur une question par un joueur (bouton BUG de QuestionPanel).
-- * table signalements : 1 ligne par (compte, question) - un 2e signalement de la meme question
--   par le meme joueur est ignore. statut : nouveau -> analyse / corrige / rejete.
-- * fn_signaler_question : appelee par le jeu, authentifiee par jeton comme fn_maj_tirage.
-- * vue_signalements : pour Steve dans Supabase Studio (1 ligne par question, avec les pseudos).
-- * vue_signalements_claude : meme chose SANS les pseudos, lisible par claude_contenu pour la
--   verification automatique ; claude_contenu peut aussi mettre a jour statut/note/traite_le.
-- ============================================================================
begin;

create table if not exists signalements (
	id           bigint primary key generated always as identity,
	compte_id    text not null references comptes(id) on delete cascade,
	question_id  integer not null references contenu_questions(id),
	cree_le      timestamptz not null default now(),
	statut       text not null default 'nouveau'
	             check (statut in ('nouveau', 'analyse', 'corrige', 'rejete')),
	note         text,
	traite_le    timestamptz,
	unique (compte_id, question_id)
);
create index if not exists signalements_statut_idx on signalements (statut, question_id);
alter table signalements enable row level security;
revoke all on signalements from anon, authenticated;

create or replace function fn_signaler_question(p_jeton text, p_question_id integer)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	if not exists (select 1 from contenu_questions where id = p_question_id) then
		raise exception 'question_inconnue';
	end if;
	-- Garde-fou anti-abus : 30 signalements maximum par compte et par 24 h.
	if (select count(*) from signalements
	    where compte_id = v_compte_id and cree_le > now() - interval '24 hours') >= 30 then
		raise exception 'trop_de_signalements';
	end if;

	insert into signalements (compte_id, question_id) values (v_compte_id, p_question_id)
	on conflict (compte_id, question_id) do nothing;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true);
end;
$$;

-- Vue Studio (Steve) : une ligne par question signalee et par statut.
create or replace view vue_signalements as
select
	s.question_id,
	q.classe,
	q.matiere,
	q.enonce,
	q.bonne_reponse,
	q.mauvais_choix,
	s.statut,
	count(*)                                  as nb_signalements,
	min(s.cree_le)                            as premier_signalement,
	max(s.cree_le)                            as dernier_signalement,
	string_agg(distinct c.login, ', ')        as joueurs,
	max(s.note)                               as note,
	max(s.traite_le)                          as traite_le
from signalements s
join contenu_questions q on q.id = s.question_id
left join comptes c on c.id = s.compte_id
group by s.question_id, q.classe, q.matiere, q.enonce, q.bonne_reponse, q.mauvais_choix, s.statut
order by (s.statut = 'nouveau') desc, max(s.cree_le) desc;

-- Vue pour la verification automatique (claude_contenu) : sans aucune info joueur.
create or replace view vue_signalements_claude as
select
	s.question_id,
	q.classe,
	q.matiere,
	q.passage_id,
	q.enonce,
	q.bonne_reponse,
	q.mauvais_choix,
	q.grille,
	s.statut,
	count(*)        as nb_signalements,
	min(s.cree_le)  as premier_signalement,
	max(s.note)     as note
from signalements s
join contenu_questions q on q.id = s.question_id
group by s.question_id, q.classe, q.matiere, q.passage_id, q.enonce, q.bonne_reponse,
         q.mauvais_choix, q.grille, s.statut;

revoke all on vue_signalements, vue_signalements_claude from anon, authenticated;
grant select on vue_signalements_claude to claude_contenu;
grant select (id, question_id, cree_le, statut, note, traite_le) on signalements to claude_contenu;
grant update (statut, note, traite_le) on signalements to claude_contenu;
-- RLS : meme principe que les tables contenu_* (policy reservee a claude_contenu, les colonnes
-- accessibles restant limitees par les grant ci-dessus - jamais compte_id).
drop policy if exists claude_contenu_acces on signalements;
create policy claude_contenu_acces on signalements for all to claude_contenu using (true) with check (true);

commit;
