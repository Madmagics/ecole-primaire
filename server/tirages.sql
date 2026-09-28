-- ============================================================================
-- tirages.sql (2026-09-28)
-- Historique des tirages de questions/textes par compte, sauvegarde sur le serveur pour suivre
-- le joueur d'un appareil a l'autre (voir QuestionDraw et SaveManager.set_draw_state cote jeu).
-- * table tirages : 1 ligne par compte + "classe/matiere" (ex. "ce2/math"), etat complet en jsonb,
--   remplacee a chaque serie (derniere ecriture gagnante, pas d'historique qui grossit).
-- * fn_maj_tirage : ecriture d'une ligne, authentifiee par jeton comme fn_maj_profil.
-- * fn_recuperer_progression : renvoie en plus "tirages" a la connexion.
-- ============================================================================
begin;

create table if not exists tirages (
	compte_id  text not null references comptes(id) on delete cascade,
	cle        text not null check (cle ~ '^[a-z0-9]+/[a-z]+$'),
	etat       jsonb not null default '{}',
	maj_le     timestamptz not null default now(),
	primary key (compte_id, cle)
);
alter table tirages enable row level security;
revoke all on tirages from anon, authenticated;

create or replace function fn_maj_tirage(p_jeton text, p_cle text, p_etat jsonb)
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
	if jsonb_typeof(p_etat) <> 'object' or length(p_etat::text) > 200000 then
		raise exception 'tirage_invalide';
	end if;

	insert into tirages (compte_id, cle, etat) values (v_compte_id, p_cle, p_etat)
	on conflict (compte_id, cle) do update set etat = excluded.etat, maj_le = now();
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true);
end;
$$;

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
		            from tirages t where t.compte_id = v_compte_id)
	);
end;
$$;

commit;
