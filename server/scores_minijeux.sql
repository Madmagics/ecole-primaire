-- ============================================================================
-- scores_minijeux.sql (2026-11-25)
-- Meilleurs scores des mini-jeux de la cour de recre (premier jeu : "pluie_de_biscuits", CP).
-- * table scores_minijeux : 1 ligne par compte ET par jeu = le MEILLEUR score de ce joueur.
--   La cle primaire (compte_id, jeu) garantit qu'un pseudo n'apparait qu'une fois au classement.
-- * fn_enregistrer_score : envoye a chaque fin de partie, ne garde que le meilleur (greatest).
-- * fn_top_scores : les 10 meilleurs joueurs d'un jeu (pseudo + score) + le record du joueur.
-- Authentifie par jeton comme fn_maj_tirage. Ajout pur : aucune table existante modifiee.
-- ============================================================================
begin;

create table if not exists scores_minijeux (
	compte_id       text not null references comptes(id) on delete cascade,
	jeu             text not null check (jeu ~ '^[a-z0-9_]+$'),
	meilleur_score  integer not null check (meilleur_score >= 0),
	maj_le          timestamptz not null default now(),
	primary key (compte_id, jeu)
);
create index if not exists scores_minijeux_classement_idx on scores_minijeux (jeu, meilleur_score desc, maj_le);
alter table scores_minijeux enable row level security;
revoke all on scores_minijeux from anon, authenticated;

create or replace function fn_enregistrer_score(p_jeton text, p_jeu text, p_score integer)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_ancien integer;
	v_meilleur integer;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	if p_score is null or p_score < 0 or p_score > 100000 or p_jeu !~ '^[a-z0-9_]+$' then
		raise exception 'score_invalide';
	end if;

	select meilleur_score into v_ancien from scores_minijeux
	where compte_id = v_compte_id and jeu = p_jeu;

	-- maj_le ne bouge que si le record est battu : a egalite, le premier arrive reste devant.
	insert into scores_minijeux (compte_id, jeu, meilleur_score) values (v_compte_id, p_jeu, p_score)
	on conflict (compte_id, jeu) do update set
		meilleur_score = greatest(scores_minijeux.meilleur_score, excluded.meilleur_score),
		maj_le = case when excluded.meilleur_score > scores_minijeux.meilleur_score
		              then now() else scores_minijeux.maj_le end
	returning meilleur_score into v_meilleur;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object(
		'ok', true,
		'meilleur_score', v_meilleur,
		'nouveau_record', v_ancien is null or p_score > v_ancien
	);
end;
$$;

create or replace function fn_top_scores(p_jeton text, p_jeu text)
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
	update sessions set derniere_activite = now() where jeton = p_jeton;

	-- Seul le pseudo (login) sort, jamais le nom/prenom du profil. Scores a 0 exclus.
	return jsonb_build_object(
		'top', (select coalesce(jsonb_agg(jsonb_build_object(
		            'pseudo', t.login, 'score', t.meilleur_score, 'moi', t.compte_id = v_compte_id)
		            order by t.meilleur_score desc, t.maj_le), '[]'::jsonb)
		        from (select s.compte_id, s.meilleur_score, s.maj_le, c.login
		              from scores_minijeux s join comptes c on c.id = s.compte_id
		              where s.jeu = p_jeu and s.meilleur_score > 0
		              order by s.meilleur_score desc, s.maj_le
		              limit 10) t),
		'mon_score', (select meilleur_score from scores_minijeux
		              where compte_id = v_compte_id and jeu = p_jeu)
	);
end;
$$;

commit;
