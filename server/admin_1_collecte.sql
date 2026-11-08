-- ============================================================================
-- admin_1_collecte.sql (2026-11-08)
-- Etape 1 de la page admin : COLLECTE de nouvelles infos (aucune donnee existante modifiee).
-- * 'partie_terminee' : nouveau type d'evenement (score de chaque serie de questions)
-- * table connexions : 1 ligne par session (debut, fin, raison de fin, navigateur, plateforme)
--   remplie automatiquement par 2 declencheurs sur la table sessions
-- * fn_deconnecter : accepte en plus une raison ('quitte' par defaut, ou 'erreur_serveur')
-- * fn_infos_connexion : le jeu envoie navigateur + plateforme juste apres la connexion
-- A lancer avec le compte postgres.
-- ============================================================================

-- 1. Nouveau type d'evenement (doit etre hors transaction, comme doublons_echanges.sql)
alter type type_evenement add value if not exists 'partie_terminee';

begin;

-- 2. Journal des connexions
create table if not exists connexions (
	id          bigint generated always as identity primary key,
	compte_id   text not null references comptes(id) on delete cascade,
	jeton_hash  text not null unique,      -- empreinte du jeton de session (jamais le jeton lui-meme)
	debut       timestamptz not null default now(),
	fin         timestamptz,               -- null = session encore ouverte
	raison_fin  text,                      -- quitte / remplacee / interrompue / erreur_serveur
	detail_fin  text,
	navigateur  text,                      -- texte "user agent" brut du navigateur
	plateforme  text
);
create index if not exists connexions_compte_debut_idx on connexions (compte_id, debut);
alter table connexions enable row level security;
revoke all on connexions from anon, authenticated;

-- 3. Declencheur : une session creee => une ligne de connexion ouverte
create or replace function fn_trg_session_ouverte()
returns trigger
language plpgsql
security definer
set search_path = public, extensions
as $$
begin
	insert into connexions (compte_id, jeton_hash, debut)
	values (new.compte_id, encode(digest(new.jeton, 'sha256'), 'hex'), new.cree_le)
	on conflict (jeton_hash) do nothing;
	return new;
end;
$$;

drop trigger if exists trg_session_ouverte on sessions;
create trigger trg_session_ouverte after insert on sessions
	for each row execute function fn_trg_session_ouverte();

-- 4. Declencheur : une session supprimee => la ligne de connexion est fermee avec sa raison
--    * raison donnee par fn_deconnecter (quitte / erreur_serveur)
--    * sinon, plus d'activite depuis 2 min => 'interrompue' (onglet ferme, reseau coupe, veille),
--      heure de fin = derniere activite connue
--    * sinon => 'remplacee' (le meme compte vient de se connecter ailleurs, voir fn_login)
create or replace function fn_trg_session_fermee()
returns trigger
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_raison text := nullif(current_setting('ecole.raison_fin', true), '');
	v_detail text := nullif(current_setting('ecole.detail_fin', true), '');
	v_fin    timestamptz := now();
begin
	if v_raison is null then
		if now() - old.derniere_activite > interval '2 minutes' then
			v_raison := 'interrompue';
			v_fin := old.derniere_activite;
		else
			v_raison := 'remplacee';
		end if;
	end if;
	update connexions set fin = v_fin, raison_fin = v_raison, detail_fin = v_detail
	where jeton_hash = encode(digest(old.jeton, 'sha256'), 'hex') and fin is null;
	return old;
end;
$$;

drop trigger if exists trg_session_fermee on sessions;
create trigger trg_session_fermee after delete on sessions
	for each row execute function fn_trg_session_fermee();

-- 5. fn_deconnecter : meme comportement qu'avant + raison facultative.
--    Un ancien jeu (cache navigateur) qui n'envoie que p_jeton continue de fonctionner.
drop function if exists fn_deconnecter(text);
create or replace function fn_deconnecter(p_jeton text, p_raison text default 'quitte', p_detail text default null)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
begin
	if p_raison is null or p_raison not in ('quitte', 'erreur_serveur') then
		p_raison := 'quitte';
	end if;
	perform set_config('ecole.raison_fin', p_raison, true);
	perform set_config('ecole.detail_fin', left(coalesce(p_detail, ''), 200), true);
	delete from sessions where jeton = p_jeton;
	return jsonb_build_object('ok', true);
end;
$$;

-- 6. fn_infos_connexion : navigateur + plateforme de la session en cours
create or replace function fn_infos_connexion(p_jeton text, p_navigateur text, p_plateforme text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
begin
	if not exists (select 1 from sessions where jeton = p_jeton and expire_le > now()) then
		raise exception 'session_expiree';
	end if;
	update connexions
	set navigateur = left(p_navigateur, 400), plateforme = left(p_plateforme, 60)
	where jeton_hash = encode(digest(p_jeton, 'sha256'), 'hex');
	return jsonb_build_object('ok', true);
end;
$$;

commit;

-- Demande a l'API de relire la liste des fonctions
notify pgrst, 'reload schema';
