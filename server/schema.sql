-- ============================================================================
-- Schéma de synchronisation cloud (Supabase / Postgres self-hébergé sur le VPS OVH).
-- VERSION "NOYAU" (2026-09-13) : sans captcha/honeypot/vérification email pour l'instant, voir
-- project_auth_creation_comptes.md (mémoire projet) pour la version complète prévue plus tard.
-- Peut être collée telle quelle dans Supabase Studio > SQL Editor et exécutée en une fois.
--
-- CORRECTIF sur le brouillon précédent (server/schema.sql) : la colonne "stats" y était décrite
-- comme "miroir StatsTracker.serialize()" - or StatsTracker a été entièrement retiré du jeu le
-- 2026-09-05 (remplacé par ChallengeTracker / "défis", voir challenge_tracker.gd ligne 2-4), donc
-- cette colonne ne correspondait plus à rien. Vérifié directement dans save_manager.gd : les
-- VRAIS champs sauvegardés par compte sont economy/cards/defis/prof_skins/classroom_decor/
-- classroom_music - c'est ce que ce schéma reflète ci-dessous.
-- ============================================================================
--
-- REMISE A ZERO (ajoutée le 2026-09-13, suite à l'erreur "column login_normalise does not exist") :
-- un brouillon précédent (2026-09-12) avait déjà créé les tables comptes/progressions/evenements
-- avec une structure différente (sans login_normalise, sans dernier_evenement_id...) - "create
-- table if not exists" ne les recrée donc pas avec la bonne structure, il les laisse telles
-- quelles. Comme le jeu n'appelle encore AUCUNE de ces tables (SaveManager sauvegarde toujours en
-- local uniquement, tâches #3/#4 pas commencées), il n'y a aucune vraie donnée de joueur à
-- perdre ici - on peut donc tout supprimer et repartir propre sans risque.
--
-- ATTENTION (ajoutée le 2026-09-13, ajout de fn_supprimer_compte) : ce n'est plus le cas ci-dessus -
-- le chantier "sauvegarde serveur" est confirmé fonctionnel de bout en bout et de vraies parties
-- (comptes de test + tout futur joueur réel) existent désormais dans ces tables. NE PLUS RE-COLLER
-- CE FICHIER EN ENTIER SUR L'INSTANCE DEJA DEPLOYEE - les DROP TABLE ci-dessous effaceraient tout.
-- Ce fichier reste la référence texte du schéma complet voulu (utile pour une réinstallation sur
-- une instance neuve), mais toute évolution sur l'instance existante se déploie désormais en
-- collant SEULEMENT le nouveau bloc CREATE OR REPLACE FUNCTION concerné dans Supabase Studio.
--
-- AJOUT (2026-09-13, chantiers "connexion cross-device" complète + "conflit de connexion") : sur
-- l'instance déjà déployée, coller UNIQUEMENT, dans cet ordre, le ALTER TABLE sur "sessions" puis
-- chaque CREATE OR REPLACE FUNCTION modifié/ajouté par ces 2 chantiers (fn_login, fn_maj_profil,
-- fn_pulse_session, fn_deconnecter, fn_pousser_evenements, fn_recuperer_progression) - PAS ce
-- fichier en entier, pour la même raison que ci-dessus.
drop function if exists fn_deconnecter(text);
drop function if exists fn_pulse_session(text);
drop function if exists fn_maj_profil(text, jsonb);
drop function if exists fn_supprimer_compte(text);
drop function if exists fn_pousser_evenements(text, jsonb);
drop function if exists fn_recuperer_progression(text);
drop function if exists fn_login(text, text);
drop function if exists fn_creer_compte(text, text, text, text, jsonb);
drop function if exists fn_obtenir_sel(text);
drop table if exists sessions;
drop table if exists evenements;
drop table if exists progressions;
drop table if exists creations_recentes;
drop table if exists verifications_email;
drop table if exists comptes;
drop type if exists type_evenement;
-- ============================================================================

-- 1. comptes — identité + authentification (1 ligne par compte joueur)
create table if not exists comptes (
	id                  text primary key,               -- format hex 32 car., généré côté client
	login               text not null,
	login_normalise     text generated always as (lower(login)) stored,
	mdp_hash            text not null,                   -- sha256(sel + mdp), déjà haché côté client
	mdp_sel             text not null,
	email               text,                             -- optionnel, pas utilisé cette passe
	email_verifie       boolean not null default false,   -- pas encore exploité (pas de gate dessus)
	profil              jsonb not null default '{}',
	cree_le             timestamptz not null default now(),
	maj_le              timestamptz not null default now()
);
create unique index if not exists comptes_login_normalise_idx on comptes (login_normalise);

-- 2. progressions — état courant agrégé (1 ligne par compte, ne grossit pas avec le temps)
create table if not exists progressions (
	compte_id             text primary key references comptes(id) on delete cascade,
	economy               jsonb not null default '{}',   -- miroir Economy.serialize()
	cards                 jsonb not null default '{}',   -- miroir CardCollection.serialize()
	defis                 jsonb not null default '{}',   -- miroir ChallengeTracker.serialize()
	prof_skins            jsonb not null default '{"unlocked":{},"active":{}}', -- miroir ProfSkins.serialize()
	classroom_decor       jsonb not null default '{"unlocked":{},"active":{}}', -- miroir ClassroomDecor.serialize()
	classroom_music       jsonb not null default '{"unlocked":{},"active":{}}', -- miroir ClassroomMusic.serialize()
	dernier_evenement_id  text,
	maj_le                timestamptz not null default now()
);

-- 3. evenements — journal des mutations, source de l'idempotence (dédup sur id)
create type type_evenement as enum (
	'gain_piece',
	'depense_piece',
	'carte_debloquee',
	'defi_reussi',
	'achat_skin_prof',
	'skin_actif_change',
	'decor_debloque',
	'decor_actif_change',
	'musique_debloquee',
	'musique_active_change'
);

create table if not exists evenements (
	id                  text primary key,                -- id unique généré CÔTÉ CLIENT (idempotence)
	compte_id           text not null references comptes(id) on delete cascade,
	type                type_evenement not null,
	payload             jsonb not null default '{}',
	horodatage_client   timestamptz not null,
	recu_le             timestamptz not null default now()
);
create index if not exists evenements_compte_recu_idx on evenements (compte_id, recu_le);

-- 4. sessions — jetons de connexion de courte durée (48h), évite de faire circuler mdp_hash partout.
-- derniere_activite (ajoutée le 2026-09-13, chantier "conflit de connexion") : distincte de
-- expire_le - expire_le borne la durée de vie du JETON comme identifiant (48h, pour la synchro en
-- tâche de fond même app fermée puis rouverte), derniere_activite mesure la PRESENCE réelle
-- (rafraîchie par fn_login/fn_pulse_session/fn_pousser_evenements/fn_recuperer_progression), voir
-- fn_login pour la fenêtre de tolérance utilisée pour juger un compte "déjà connecté".
create table if not exists sessions (
	jeton               text primary key,
	compte_id           text not null references comptes(id) on delete cascade,
	cree_le             timestamptz not null default now(),
	expire_le           timestamptz not null,
	derniere_activite   timestamptz not null default now()
);
create index if not exists sessions_compte_idx on sessions (compte_id);
create index if not exists sessions_expire_idx on sessions (expire_le);
create index if not exists sessions_activite_idx on sessions (compte_id, derniere_activite);

-- ============================================================================
-- Sécurité : RLS fermée sur les 4 tables, aucun accès direct via la clé anon publique. Tout passe
-- par les fonctions SECURITY DEFINER ci-dessous, exposées automatiquement par Supabase comme
-- endpoints RPC (/rest/v1/rpc/<nom_fonction>).
-- ============================================================================
alter table comptes       enable row level security;
alter table progressions  enable row level security;
alter table evenements    enable row level security;
alter table sessions      enable row level security;

-- Extension nécessaire pour gen_random_bytes (jetons de session, sel) et digest (hash côté serveur
-- si besoin) - déjà présente par défaut sur la plupart des images Supabase, "if not exists" ne
-- fait rien si c'est déjà le cas.
--
-- BUG FIX (2026-09-13, test de bout en bout du chantier "sauvegarde serveur" - fn_login échouait
-- avec "function gen_random_bytes(integer) does not exist") : sur cette instance self-hosted,
-- pgcrypto était déjà installée mais dans le schéma "extensions" (convention Supabase), pas
-- "public" - "create extension if not exists" ne la déplace pas puisqu'elle existe déjà ailleurs.
-- Chaque fonction ci-dessous ne cherchait que dans "public" (`set search_path = public`), donc ne
-- trouvait jamais gen_random_bytes/digest. Toutes les fonctions ont été mises à jour en
-- `set search_path = public, extensions` pour les trouver quel que soit le schéma réel de
-- pgcrypto sur l'instance.
create extension if not exists pgcrypto;

-- ============================================================================
-- fn_obtenir_sel : étape préalable à la connexion. Le client doit connaître le sel AVANT de
-- pouvoir calculer mdp_hash = sha256(sel + mot_de_passe) à envoyer à fn_login - sur un appareil qui
-- n'a jamais stocké ce compte localement (nouvel appareil), ce sel n'est connu que du serveur.
-- Renvoie un sel FACTICE mais déterministe (dérivé du login, jamais aléatoire à chaque appel) si le
-- compte n'existe pas, pour qu'un attaquant ne puisse pas deviner l'existence d'un pseudo en
-- observant si la réponse change de forme (un sel "trouvé" a toujours la même forme qu'un sel
-- "inventé" - la réponse à fn_login échouera de toute façon ensuite, au même endroit dans les deux
-- cas).
-- ============================================================================
create or replace function fn_obtenir_sel(p_login text)
returns text
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_sel text;
begin
	select mdp_sel into v_sel from comptes where login_normalise = lower(p_login);
	if v_sel is null then
		-- sel factice deterministe (meme forme qu'un vrai sel hex), jamais stocke, ne revele rien
		return encode(digest('sel_absent:' || lower(p_login), 'sha256'), 'hex');
	end if;
	return v_sel;
end;
$$;

-- ============================================================================
-- fn_creer_compte : version NOYAU, sans captcha/honeypot/email (voir en-tête de fichier). Le sel
-- et le hash sont calculés CÔTÉ CLIENT (voir save_manager.gd _hash_password) - le serveur les
-- stocke tels quels. p_id est généré côté client (même format que les comptes locaux existants).
-- ============================================================================
create or replace function fn_creer_compte(
	p_id text,
	p_login text,
	p_mdp_hash text,
	p_mdp_sel text,
	p_profil jsonb default '{}'
)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_login text := trim(p_login);
	v_tentative int := 0;
	v_login_existant text;
begin
	-- Idempotence sur l'ID (ajoutee le 2026-09-13, pour le chantier "sauvegarde serveur" cote
	-- Godot - voir SaveManager._ensure_server_session()) : un appareil peut rejouer cet appel apres
	-- une coupure reseau sans savoir si la premiere tentative avait deja reussi cote serveur. Sans
	-- ce garde-fou, rejouer l'appel levait a tort "pseudo_indisponible" (la boucle ci-dessous ne
	-- sait gerer qu'une collision de LOGIN, pas de cet ID - qui, lui, ne peut appartenir qu'au MEME
	-- compte puisque genere aleatoirement cote client, voir SaveManager._generate_random_hex) - on
	-- renvoie directement les infos existantes plutot que d'echouer sur un id deja present.
	select login into v_login_existant from comptes where id = p_id;
	if v_login_existant is not null then
		return jsonb_build_object('id', p_id, 'login', v_login_existant);
	end if;

	if v_login = '' then
		raise exception 'login_vide';
	end if;
	-- Filet de securite contre une course (deux creations quasi simultanees du meme pseudo) : le
	-- CLIENT est cense avoir deja verifie/suggere une variante avant d'arriver ici (voir
	-- SaveManager.suggest_login_variant()) - on retente juste avec un suffixe si la collision
	-- survient malgre tout, plutot que d'echouer sec.
	loop
		begin
			insert into comptes (id, login, mdp_hash, mdp_sel, profil)
			values (p_id, v_login, p_mdp_hash, p_mdp_sel, p_profil);
			exit;
		exception when unique_violation then
			v_tentative := v_tentative + 1;
			if v_tentative > 5 then
				raise exception 'pseudo_indisponible';
			end if;
			v_login := trim(p_login) || (floor(random() * 90 + 10))::int::text;
		end;
	end loop;
	insert into progressions (compte_id) values (p_id) on conflict (compte_id) do nothing;
	return jsonb_build_object('id', p_id, 'login', v_login);
end;
$$;

-- ============================================================================
-- fn_login : verifie le hash (deja calcule cote client avec le sel obtenu via fn_obtenir_sel),
-- emet un jeton de session. Purge paresseuse des jetons expires au passage.
--
-- MODIFIEE le 2026-09-13 (2 chantiers a la fois, voir project_save_sync_architecture.md en memoire
-- projet) :
-- 1. "profil" ajoute au retour jsonb - necessaire pour qu'un appareil qui recupere un compte
--    EXISTANT (connexion cross-device, un pseudo inconnu de cet appareil) restaure aussi
--    nom/prenom/classe/date de naissance/pays ET le controle parental (mot de passe/limite
--    quotidienne, stockes dans ce meme "profil" cote client - voir SaveManager) - avant cette
--    modification, seule la PROGRESSION de jeu (via fn_recuperer_progression) etait recuperee.
-- 2. "compte_deja_connecte" : refuse la connexion si une AUTRE session de ce compte est encore
--    active a l'instant (derniere_activite recente, voir la colonne ajoutee sur "sessions" et
--    v_delai_presence ci-dessous) - evite que 2 appareils jouent SIMULTANEMENT sur le meme compte
--    (conflit d'ecriture sur la progression). Le seuil (90s) tolere 2-3 battements de coeur
--    manques (SaveManager.pulse_session(), toutes les 30s cote client, voir
--    SYNC_RETRY_INTERVAL_SECONDS) avant de considerer une session comme abandonnee (app fermee/
--    crashee sans deconnexion propre) - LIMITE CONNUE ET ASSUMEE : apres une fermeture brutale
--    (pas de clic sur "Se deconnecter"), CE MEME appareil doit attendre jusqu'a 90s avant de
--    pouvoir se reconnecter au meme compte. fn_deconnecter (voir plus bas) libere la session
--    IMMEDIATEMENT sur une deconnexion volontaire, pour eviter cette attente dans le cas normal.
-- ============================================================================
-- MODIFIEE le 2026-09-16 (voir TODO_UI_MODS.md, bug "acces au jeu possible avant confirmation
-- d'email") : "email"/"email_verifie" ajoutes au retour jsonb - le client (SaveManager.login()/
-- _login_from_server()) doit pouvoir decider, a CHAQUE connexion, si l'email du compte est encore
-- a confirmer, sans appel RPC supplementaire (fn_statut_email, ajoutee la meme session, ne sert
-- qu'au recheck MANUEL depuis l'ecran "Vérifie ta boîte mail", pendant qu'une session est deja
-- ouverte).
create or replace function fn_login(p_login text, p_mdp_hash text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_jeton text;
	v_profil jsonb;
	v_email text;
	v_email_verifie boolean;
	v_deja_connecte boolean;
	-- Fenetre de tolerance de presence (voir commentaire de fonction ci-dessus) - reprise a
	-- l'identique dans fn_pulse_session plus bas, aucune autre fonction n'a besoin de la connaitre.
	v_delai_presence interval := interval '90 seconds';
begin
	delete from sessions where expire_le < now();

	select id, profil, email, email_verifie into v_compte_id, v_profil, v_email, v_email_verifie
	from comptes
	where login_normalise = lower(p_login) and mdp_hash = p_mdp_hash;

	if v_compte_id is null then
		raise exception 'identifiants_invalides';
	end if;

	select exists(
		select 1 from sessions
		where compte_id = v_compte_id and derniere_activite > now() - v_delai_presence
	) into v_deja_connecte;
	if v_deja_connecte then
		raise exception 'compte_deja_connecte';
	end if;

	v_jeton := encode(gen_random_bytes(32), 'hex');
	insert into sessions (jeton, compte_id, expire_le, derniere_activite)
	values (v_jeton, v_compte_id, now() + interval '48 hours', now());

	return jsonb_build_object(
		'jeton', v_jeton,
		'compte_id', v_compte_id,
		'profil', v_profil,
		'email', coalesce(v_email, ''),
		'email_verifie', v_email_verifie
	);
end;
$$;

-- ============================================================================
-- fn_maj_profil : remplace le "profil" du compte (nom/prenom/classe/date de naissance/pays +
-- controle parental/limite quotidienne, voir SaveManager - c'est le MEME dictionnaire cote client,
-- pousse ici tel quel). Ajoutee le 2026-09-13 : jusqu'ici, "profil" n'etait ecrit qu'UNE FOIS a la
-- creation du compte (fn_creer_compte) et ne recevait plus jamais aucune mise a jour ulterieure -
-- une modification du profil (classe, controle parental, limite quotidienne...) APRES la creation
-- ne suivait donc PAS sur un autre appareil. Remplacement complet (pas de fusion cle par cle) : le
-- client envoie deja le dictionnaire "profile" complet a chaque appel (voir
-- SaveManager.update_current_profile()), le meme choix que le client fait deja localement.
-- Rafraichit aussi derniere_activite au passage (une mise a jour de profil est une preuve de
-- presence comme une autre, voir fn_login pour le detail de cette mecanique).
-- ============================================================================
create or replace function fn_maj_profil(p_jeton text, p_profil jsonb)
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

	update comptes set profil = p_profil, maj_le = now() where id = v_compte_id;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true);
end;
$$;

-- ============================================================================
-- fn_pulse_session : "battement de coeur" de presence (chantier "conflit de connexion", voir
-- fn_login ci-dessus) - rafraichit derniere_activite pour un jeton encore valide, sans rien lire ni
-- ecrire d'autre. Appelee par SaveManager toutes les SYNC_RETRY_INTERVAL_SECONDS (30s) tant qu'un
-- compte est connecte ET qu'un jeton est deja disponible localement (jamais de creation de session
-- ici, voir fn_login pour ca).
-- ============================================================================
create or replace function fn_pulse_session(p_jeton text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
begin
	update sessions set derniere_activite = now()
	where jeton = p_jeton and expire_le > now()
	returning compte_id into v_compte_id;

	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;

	return jsonb_build_object('ok', true);
end;
$$;

-- ============================================================================
-- fn_deconnecter : libere IMMEDIATEMENT la session (chantier "conflit de connexion", voir fn_login
-- ci-dessus) - appelee par SaveManager.logout() sur une deconnexion VOLONTAIRE, pour que cet
-- appareil (ou un autre) puisse se reconnecter au meme compte sans attendre l'expiration naturelle
-- de la presence (90s, voir fn_login). Idempotente/best-effort a dessein (meme principe que
-- fn_supprimer_compte pour la logique de suppression cote client) : un jeton deja absent/expire ne
-- leve PAS d'erreur, la deconnexion locale ne doit jamais rester bloquee sur ca.
-- ============================================================================
create or replace function fn_deconnecter(p_jeton text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
begin
	delete from sessions where jeton = p_jeton;
	return jsonb_build_object('ok', true);
end;
$$;

-- ============================================================================
-- fn_recuperer_progression : lecture seule, accessible meme sans email verifie (pas de gate ici).
-- ============================================================================
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
	-- Preuve de presence (2026-09-13, chantier "conflit de connexion", voir fn_login) - meme
	-- raison que dans fn_pousser_evenements ci-dessus.
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
		'classroom_music', v_ligne.classroom_music
	);
end;
$$;

-- ============================================================================
-- fn_pousser_evenements : coeur de l'idempotence. p_evenements est un tableau jsonb, un element
-- par evenement en attente cote client :
--   {"id": "...", "type": "gain_piece", "payload": {...}, "horodatage_client": "2026-09-13T10:00:00Z"}
--
-- Formats de payload par type (a respecter cote Godot, voir tache #4 du tracker) :
--   gain_piece / depense_piece   : {"rarity": <int>, "montant": <int>}
--   carte_debloquee              : {"card_id": "<string>"}
--   defi_reussi                  : {"grade": <int>, "subject": <int>, "nouveau_total": <int>}
--   achat_skin_prof              : {"grade": <int>, "skin_index": <int>}   -- achat + equipement immediat (ProfSkins.try_unlock)
--   skin_actif_change            : {"grade": <int>, "skin_index": <int>}   -- reequipement gratuit d'un skin deja possede (ProfSkins.set_active)
--   decor_debloque                : {"grade": <int>}                       -- ClassroomDecor.try_unlock (deblocage par Defis, gratuit, PAS d'auto-activation)
--   decor_actif_change            : {"grade": <int>, "actif": <bool>}      -- ClassroomDecor.toggle_active
--   musique_debloquee             : {"grade": <int>}                       -- ClassroomMusic.try_unlock
--   musique_active_change         : {"grade": <int>, "actif": <bool>}      -- ClassroomMusic.toggle_active
--
-- Decision de portee (revisee 2026-09-13, retour utilisateur "il faut que les options du jeu
-- suivent partout") : dorenavant "unlocked" ET "active" sont synchronises pour classroom_decor et
-- classroom_music. Un seul decor actif a la fois toutes classes confondues (et separement, une
-- seule musique a la fois) - voir ClassroomDecor.toggle_active/ClassroomMusic.toggle_active pour
-- cette regle d'exclusivite cote client - donc decor_actif_change/musique_active_change avec
-- "actif":true remet explicitement toutes les AUTRES classes a false dans le sous-objet "active"
-- avant de poser celle-ci a true (repliqué ci-dessous cote SQL), pour rester coherent avec un
-- appareil qui aurait active un decor pendant qu'un autre etait hors-ligne.
-- ============================================================================
create or replace function fn_pousser_evenements(p_jeton text, p_evenements jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_evt jsonb;
	v_id text;
	v_type text;
	v_payload jsonb;
	v_horodatage timestamptz;
	v_ids_appliques text[] := '{}';
	v_deja_inseree boolean;
	v_rarity text;
	v_montant int;
	v_card_id text;
	v_grade text;
	v_subject text;
	v_actif boolean;
	v_active_reset jsonb;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	-- Preuve de presence (2026-09-13, chantier "conflit de connexion", voir fn_login) - une poussee
	-- d'evenements est une activite comme une autre, pas la peine d'attendre le prochain
	-- fn_pulse_session() dedie pour la refleter.
	update sessions set derniere_activite = now() where jeton = p_jeton;

	for v_evt in select * from jsonb_array_elements(p_evenements)
	loop
		v_id := v_evt->>'id';
		v_type := v_evt->>'type';
		v_payload := v_evt->'payload';
		v_horodatage := (v_evt->>'horodatage_client')::timestamptz;

		insert into evenements (id, compte_id, type, payload, horodatage_client)
		values (v_id, v_compte_id, v_type::type_evenement, v_payload, v_horodatage)
		on conflict (id) do nothing;

		get diagnostics v_deja_inseree = row_count;
		-- row_count = 1 si la ligne vient d'etre inseree (nouvelle), 0 si elle existait deja
		-- (ON CONFLICT DO NOTHING) : on n'applique l'effet sur "progressions" QUE pour une ligne
		-- reellement nouvelle - un renvoi apres coupure reseau ne double donc jamais l'effet.
		if v_deja_inseree then
			if v_type = 'gain_piece' then
				v_rarity := (v_payload->>'rarity');
				v_montant := (v_payload->>'montant')::int;
				update progressions set
					economy = jsonb_set(
						economy, array[v_rarity],
						to_jsonb(coalesce((economy->>v_rarity)::int, 0) + v_montant)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'depense_piece' then
				v_rarity := (v_payload->>'rarity');
				v_montant := (v_payload->>'montant')::int;
				update progressions set
					economy = jsonb_set(
						economy, array[v_rarity],
						to_jsonb(greatest(coalesce((economy->>v_rarity)::int, 0) - v_montant, 0))
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'carte_debloquee' then
				v_card_id := (v_payload->>'card_id');
				update progressions set
					cards = jsonb_set(
						cards, array[v_card_id],
						to_jsonb(coalesce((cards->>v_card_id)::int, 0) + 1)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'defi_reussi' then
				v_grade := (v_payload->>'grade');
				v_subject := (v_payload->>'subject');
				update progressions set
					defis = jsonb_set(
						coalesce(defis, '{}'::jsonb),
						array[v_grade],
						coalesce(defis->v_grade, '{}'::jsonb) || jsonb_build_object(v_subject, (v_payload->>'nouveau_total')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'achat_skin_prof' then
				v_grade := (v_payload->>'grade');
				update progressions set
					prof_skins = jsonb_set(
						jsonb_set(
							prof_skins, array['unlocked', v_grade],
							(
								select coalesce(jsonb_agg(distinct e), '[]'::jsonb)
								from (
									select jsonb_array_elements(coalesce(prof_skins->'unlocked'->v_grade, '[]'::jsonb)) as e
									union
									select to_jsonb((v_payload->>'skin_index')::int)
								) x
							)
						),
						array['active', v_grade],
						to_jsonb((v_payload->>'skin_index')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'skin_actif_change' then
				-- Reequipement gratuit d'un skin deja possede (pas d'unlock a toucher ici, contrairement
				-- a achat_skin_prof ci-dessus) - pas d'exclusivite entre classes pour les skins de prof
				-- (chaque classe a son propre skin actif independant, contrairement au decor/musique).
				v_grade := (v_payload->>'grade');
				update progressions set
					prof_skins = jsonb_set(
						prof_skins, array['active', v_grade], to_jsonb((v_payload->>'skin_index')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'decor_debloque' then
				v_grade := (v_payload->>'grade');
				update progressions set
					classroom_decor = jsonb_set(
						classroom_decor, array['unlocked', v_grade], 'true'::jsonb
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'decor_actif_change' then
				-- Un seul decor actif a la fois, toutes classes confondues (meme regle d'exclusivite que
				-- ClassroomDecor.toggle_active cote client) : si "actif" est vrai, on remet d'abord TOUTES
				-- les classes deja connues du sous-objet "active" a false avant de poser celle-ci a true -
				-- reproduit ici plutot que suppose deja coherent, au cas ou un autre appareil aurait
				-- active une autre classe pendant que celui-ci etait hors-ligne.
				v_grade := (v_payload->>'grade');
				v_actif := (v_payload->>'actif')::boolean;
				select coalesce(jsonb_object_agg(key, 'false'::jsonb), '{}'::jsonb) into v_active_reset
				from jsonb_object_keys(coalesce((select classroom_decor->'active' from progressions where compte_id = v_compte_id), '{}'::jsonb)) as key;
				if v_actif then
					update progressions set
						classroom_decor = jsonb_set(
							jsonb_set(classroom_decor, array['active'], v_active_reset),
							array['active', v_grade], 'true'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				else
					update progressions set
						classroom_decor = jsonb_set(
							classroom_decor, array['active', v_grade], 'false'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				end if;

			elsif v_type = 'musique_debloquee' then
				v_grade := (v_payload->>'grade');
				update progressions set
					classroom_music = jsonb_set(
						classroom_music, array['unlocked', v_grade], 'true'::jsonb
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'musique_active_change' then
				-- Meme logique d'exclusivite que decor_actif_change ci-dessus, appliquee a
				-- classroom_music (deux ensembles independants : activer une musique ne touche jamais
				-- au decor actif, et inversement).
				v_grade := (v_payload->>'grade');
				v_actif := (v_payload->>'actif')::boolean;
				select coalesce(jsonb_object_agg(key, 'false'::jsonb), '{}'::jsonb) into v_active_reset
				from jsonb_object_keys(coalesce((select classroom_music->'active' from progressions where compte_id = v_compte_id), '{}'::jsonb)) as key;
				if v_actif then
					update progressions set
						classroom_music = jsonb_set(
							jsonb_set(classroom_music, array['active'], v_active_reset),
							array['active', v_grade], 'true'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				else
					update progressions set
						classroom_music = jsonb_set(
							classroom_music, array['active', v_grade], 'false'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				end if;
			end if;

			v_ids_appliques := array_append(v_ids_appliques, v_id);
		end if;
	end loop;

	update progressions set dernier_evenement_id = v_ids_appliques[array_length(v_ids_appliques, 1)]
	where compte_id = v_compte_id and array_length(v_ids_appliques, 1) > 0;

	return jsonb_build_object('ids_appliques', to_jsonb(v_ids_appliques));
end;
$$;

-- ============================================================================
-- fn_supprimer_compte : supprime DEFINITIVEMENT le compte associe au jeton (comptes, avec cascade
-- automatique sur progressions/evenements/sessions via "on delete cascade" dans leurs "references",
-- voir les 4 "create table" plus haut - une seule instruction delete suffit donc).
--
-- Ajoutée le 2026-09-13 (retour utilisateur : "la suppression se fait correctement en local mais
-- pas sur le serveur Supabase") - AUCUNE fonction équivalente n'existait avant : côté Godot,
-- delete_current_account() (save_manager.gd) ne faisait que nettoyer l'état local, sans jamais
-- appeler le serveur.
--
-- Si le jeton est absent/expiré, on lève "session_expiree" comme les autres fonctions basées sur un
-- jeton (fn_recuperer_progression/fn_pousser_evenements) plutôt que de supposer que "pas de session
-- valide" = "compte déjà supprimé" - CHOIX UTILISATEUR (2026-09-13, voir project_save_sync_
-- architecture.md) : la suppression est appelée en best-effort, sans file de retry persistée côté
-- client si ça échoue (cas jugé rare, la suppression passe déjà par le portail parental et se fait
-- normalement en jouant en ligne) - un compte jamais synchronisé ou dont le jeton est périmé pile à
-- ce moment-là peut donc rester orphelin côté serveur, assumé comme limite connue plutôt que
-- masqué par un succès silencieux trompeur.
-- ============================================================================
create or replace function fn_supprimer_compte(p_jeton text)
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

	delete from comptes where id = v_compte_id;

	return jsonb_build_object('ok', true);
end;
$$;

-- Ne pas oublier, une fois testé : revoquer explicitement l'accès direct aux tables pour les rôles
-- publics (RLS activé + aucune policy suffit déjà en théorie, ceci est une double sécurité) :
-- revoke all on comptes, progressions, evenements, sessions from anon, authenticated;
-- Les fonctions elles-mêmes restent appelables (SECURITY DEFINER + exposées via PostgREST RPC).

-- ============================================================================
-- CRÉATION DE COMPTE "EN LIGNE" (email + captcha) - ajoutée le 2026-09-14, voir
-- project_auth_creation_comptes.md (mémoire projet) pour les décisions de conception (points 1-7).
-- Complète fn_creer_compte (noyau, ci-dessus) sans le remplacer : fn_creer_compte reste utilisée
-- tel quel par SaveManager._ensure_server_session() (enregistrement silencieux en arrière-plan d'un
-- compte créé/connu localement, ex. re-création rétroactive après un jeton perdu - pas un nouveau
-- venu, pas de captcha à demander à ce moment-là). fn_creer_compte_public ci-dessous est le NOUVEAU
-- point d'entrée prévu pour le formulaire de création en ligne (câblage côté client Godot = tâche
-- suivante, pas encore fait à ce stade).
-- ============================================================================

-- 5. config_secrets — clés d'API externes (Brevo, Turnstile). JAMAIS de valeur réelle dans ce
-- fichier texte (qui est versionné sur GitHub) : les vraies valeurs sont insérées à la main,
-- UNE FOIS, directement dans Supabase Studio (voir instructions données à part). RLS activé sans
-- policy comme les autres tables - lisible uniquement par les fonctions SECURITY DEFINER ci-dessous.
create table if not exists config_secrets (
	cle     text primary key,
	valeur  text not null
);
alter table config_secrets enable row level security;
-- Lignes attendues (à insérer séparément, jamais ici) : 'brevo_api_key', 'turnstile_secret_key'.

-- 6. verifications_email — un token de vérification en attente par compte (le renvoi remplace le
-- précédent plutôt que d'en empiler plusieurs). Seul le HACHÉ du token est stocké, même logique que
-- mdp_hash - un accès en lecture à cette table ne permet donc pas de vérifier un email à la place
-- du destinataire réel.
create table if not exists verifications_email (
	compte_id          text primary key references comptes(id) on delete cascade,
	token_hash         text not null,
	expire_le          timestamptz not null,
	dernier_envoi_le   timestamptz not null default now()
);
alter table verifications_email enable row level security;

-- 7. creations_recentes — limite de VITESSE (burst) de création de compte, PAS un plafond de
-- volume total (voir point 4 de project_auth_creation_comptes.md : un plafond total casserait le
-- cas d'une classe entière créée depuis la même IP/le même email). Une ligne par tentative
-- (honeypot rempli exclu, voir fn_creer_compte_public), purge paresseuse par la fonction elle-même
-- (delete des lignes de plus de 10 minutes à chaque appel) - aucune rétention longue durée, donc
-- aucune question RGPD de conservation de l'IP à se poser ici.
create table if not exists creations_recentes (
	id           bigserial primary key,
	cle          text not null,
	horodatage   timestamptz not null default now()
);
create index if not exists creations_recentes_cle_horodatage_idx on creations_recentes (cle, horodatage);
alter table creations_recentes enable row level security;

-- 8. defis_captcha — code court (6 caractères) à usage unique prouvant qu'un token Turnstile
-- valide a déjà été vérifié, pour les plateformes desktop/mobile où le client Godot n'a aucun
-- moteur JS pour afficher le widget Turnstile lui-même (ajouté 2026-09-15, voir
-- project_auth_creation_comptes.md). Parcours : une page web (captcha.html, sur le domaine du jeu,
-- ouverte dans le navigateur système via OS.shell_open) affiche le widget Turnstile, envoie le
-- token obtenu à fn_verifier_turnstile_creer_code ci-dessous, affiche le code renvoyé - l'enfant/
-- le parent le retape dans le jeu, qui l'envoie à fn_creer_compte_public (paramètre
-- p_code_captcha) à la place d'un token direct. Seul le HACHÉ du code est stocké, même logique que
-- mdp_hash/token_hash - un accès en lecture à cette table ne permet donc pas d'utiliser un code à
-- la place de son destinataire réel.
create table if not exists defis_captcha (
	code_hash    text primary key,
	expire_le    timestamptz not null,
	utilise      boolean not null default false
);
create index if not exists defis_captcha_expire_le_idx on defis_captcha (expire_le);
alter table defis_captcha enable row level security;

-- ============================================================================
-- fn_creer_compte_public : point d'entrée du formulaire de création en ligne. Enchaîne, dans
-- l'ordre : honeypot (rejet silencieux) -> limite de vitesse par IP et par email -> vérification
-- Turnstile (appel HTTP sortant via l'extension "http") -> création du compte proprement dite
-- (réutilise fn_creer_compte, aucune logique dupliquée) -> enregistrement de l'email + génération
-- du token de vérification -> envoi de l'email via Brevo (appel HTTP sortant). L'échec de l'ENVOI
-- de l'email (Brevo injoignable, quota dépassé...) ne fait PAS échouer la création du compte - le
-- compte existe et reste jouable, "email_envoye" à false dans le retour permet au client d'inviter
-- à cliquer sur "renvoyer" (fn_renvoyer_verification ci-dessous) plutôt que de bloquer l'enfant.
-- p_ip est lu depuis les en-têtes de la requête PostgREST (x-forwarded-for, transmis par Caddy) -
-- si ce réglage n'est pas exposé tel quel sur cette instance, la lecture échoue silencieusement et
-- seule la limite par EMAIL continue de s'appliquer (dégradation, pas un blocage).
-- p_code_captcha (ajouté 2026-09-15, repli desktop/mobile) : si fourni (non vide), remplace
-- p_turnstile_token - vérifié contre defis_captcha au lieu d'un appel direct à Cloudflare, voir
-- commentaire de cette table et fn_verifier_turnstile_creer_code. Signature changée par rapport à
-- la version du 2026-09-14 : drop explicite ci-dessous (create or replace ne suffit pas quand la
-- liste de paramètres change, ça créerait une 2e fonction en doublon au lieu de remplacer).
-- ============================================================================
drop function if exists fn_creer_compte_public(text, text, text, text, jsonb, text, text, text);

create or replace function fn_creer_compte_public(
	p_id text,
	p_login text,
	p_mdp_hash text,
	p_mdp_sel text,
	p_profil jsonb,
	p_email text,
	p_turnstile_token text default '',
	p_code_captcha text default '',
	p_honeypot text default ''
)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_ip                text;
	v_cle_ip            text;
	v_cle_email         text;
	v_nb_tentatives      int;
	v_turnstile_secret   text;
	v_reponse_turnstile  http_response;
	v_captcha_ok         boolean;
	v_resultat           jsonb;
	v_compte_id          text;
	v_email              text := nullif(trim(p_email), '');
	v_token              text;
	v_brevo_ok           boolean := false;
begin
	-- Honeypot : un vrai enfant/parent ne remplit jamais ce champ (caché en CSS côté formulaire) -
	-- un bot qui remplit tous les champs du formulaire, si. Rejet générique, même message qu'un
	-- captcha invalide - ne pas donner d'indice à un bot sur la raison précise du refus.
	if p_honeypot is not null and p_honeypot <> '' then
		raise exception 'captcha_invalide';
	end if;

	begin
		v_ip := (current_setting('request.headers', true)::jsonb ->> 'x-forwarded-for');
	exception when others then
		v_ip := null;
	end;

	-- Purge paresseuse (voir commentaire de la table).
	delete from creations_recentes where horodatage < now() - interval '10 minutes';

	v_cle_ip := 'ip:' || coalesce(v_ip, '');
	v_cle_email := 'email:' || lower(coalesce(v_email, ''));

	-- BUG CORRIGÉ le 2026-09-14 (repéré en relisant le code juste après le 1er déploiement, avant
	-- toute donnée réelle) : la vérification de la limite de vitesse doit se faire AVANT l'appel à
	-- Turnstile (lecture seule des tentatives déjà enregistrées, évite un appel HTTP inutile si le
	-- quota est déjà dépassé) - l'ENREGISTREMENT de la tentative, lui, ne peut se faire qu'APRÈS un
	-- captcha validé (voir plus bas) : un `raise exception` plus loin dans la fonction annule toute
	-- la transaction de l'appel, y compris une insertion faite plus tôt dans le même appel - une
	-- tentative enregistrée AVANT l'échec du captcha aurait donc toujours été effacée avant de
	-- pouvoir compter, rendant la limite de vitesse inopérante contre les captchas invalides en
	-- boucle (Cloudflare Turnstile freine déjà ce cas de son côté, donc pas une faille critique en
	-- soi, mais la fonction n'aurait pas fait ce qu'elle prétend faire).
	if v_ip is not null then
		select count(*) into v_nb_tentatives from creations_recentes
		where cle = v_cle_ip and horodatage > now() - interval '1 minute';
		if v_nb_tentatives >= 5 then
			raise exception 'trop_de_creations';
		end if;
	end if;
	if v_email is not null then
		select count(*) into v_nb_tentatives from creations_recentes
		where cle = v_cle_email and horodatage > now() - interval '1 minute';
		if v_nb_tentatives >= 5 then
			raise exception 'trop_de_creations';
		end if;
	end if;

	if p_code_captcha is not null and p_code_captcha <> '' then
		-- Repli desktop/mobile (voir commentaire de defis_captcha) : le code vient de captcha.html,
		-- déjà vérifié auprès de Cloudflare par fn_verifier_turnstile_creer_code à sa génération -
		-- ici on vérifie seulement qu'il existe, n'a pas expiré, et pas déjà été utilisé (usage
		-- unique, comme un token Turnstile). upper()/trim() : le code affiché est tout en
		-- majuscules, insensible à la casse à la retape pour ne pas ajouter de friction inutile.
		delete from defis_captcha where expire_le < now();
		update defis_captcha
			set utilise = true
			where code_hash = encode(digest(upper(trim(p_code_captcha)), 'sha256'), 'hex')
				and not utilise
				and expire_le > now()
			returning true into v_captcha_ok;
		v_captcha_ok := coalesce(v_captcha_ok, false);
	else
		-- Plateforme Web : widget Turnstile affiché directement dans la page, vérification classique.
		select valeur into v_turnstile_secret from config_secrets where cle = 'turnstile_secret_key';
		if v_turnstile_secret is null then
			-- Config manquante côté serveur (clé pas encore insérée) - on ne laisse jamais passer une
			-- création "par défaut" faute de captcha configurable, on échoue explicitement.
			raise exception 'captcha_non_configure';
		end if;

		select * into v_reponse_turnstile from http_post(
			'https://challenges.cloudflare.com/turnstile/v0/siteverify',
			jsonb_build_object('secret', v_turnstile_secret, 'response', p_turnstile_token)::text,
			'application/json'
		);
		v_captcha_ok := coalesce((v_reponse_turnstile.content::jsonb ->> 'success')::boolean, false);
	end if;

	if not v_captcha_ok then
		raise exception 'captcha_invalide';
	end if;

	-- Enregistré seulement maintenant (captcha validé) : fait partie du chemin de succès, ne sera
	-- donc jamais annulé par un échec ultérieur - ne compte que les tentatives réellement humaines.
	insert into creations_recentes (cle) values (v_cle_ip);
	if v_email is not null then
		insert into creations_recentes (cle) values (v_cle_email);
	end if;

	-- Création proprement dite : réutilise fn_creer_compte (idempotence sur l'id, gestion de
	-- collision de login déjà gérées là-bas, pas de raison de dupliquer cette logique ici).
	select fn_creer_compte(p_id, p_login, p_mdp_hash, p_mdp_sel, p_profil) into v_resultat;
	v_compte_id := v_resultat ->> 'id';

	if v_email is not null then
		update comptes set email = v_email, email_verifie = false where id = v_compte_id;

		v_token := encode(gen_random_bytes(32), 'hex');
		insert into verifications_email (compte_id, token_hash, expire_le, dernier_envoi_le)
		values (v_compte_id, encode(digest(v_token, 'sha256'), 'hex'), now() + interval '24 hours', now())
		on conflict (compte_id) do update
			set token_hash = excluded.token_hash,
			    expire_le = excluded.expire_le,
			    dernier_envoi_le = excluded.dernier_envoi_le;

		-- L'échec d'envoi ne doit jamais faire échouer la création du compte (voir en-tête de
		-- fonction) - capturé ici, jamais propagé.
		begin
			v_brevo_ok := fn_envoyer_email_verification(v_email, v_token);
		exception when others then
			v_brevo_ok := false;
		end;
	end if;

	return jsonb_build_object(
		'id', v_compte_id,
		'login', v_resultat ->> 'login',
		'email_envoye', v_brevo_ok
	);
end;
$$;

-- ============================================================================
-- fn_envoyer_email_verification : envoi de l'email de vérification via l'API transactionnelle
-- Brevo. Fonction interne (appelée par fn_creer_compte_public et fn_renvoyer_verification), PAS
-- pensée pour être appelée directement depuis le client - elle n'a aucune vérification d'identité
-- de son cru (elle fait confiance à ses deux appelants, qui ont déjà authentifié la demande avant
-- de l'appeler). Le lien pointe vers une page de confirmation SUR LE DOMAINE DU JEU (pas une
-- réponse API brute) - cette page reste à créer côté client (tâche suivante), elle devra lire le
-- paramètre ?token=... dans l'URL et appeler fn_verifier_email avec.
-- ============================================================================
create or replace function fn_envoyer_email_verification(p_email text, p_token text)
returns boolean
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_brevo_api_key   text;
	v_lien            text;
	v_corps           jsonb;
	v_reponse         http_response;
begin
	select valeur into v_brevo_api_key from config_secrets where cle = 'brevo_api_key';
	if v_brevo_api_key is null then
		return false;
	end if;

	v_lien := 'https://www.ecole-primaire.eu/verifier-email.html?token=' || p_token;

	v_corps := jsonb_build_object(
		'sender', jsonb_build_object('name', 'École Primaire', 'email', 'noreply@ecole-primaire.eu'),
		'to', jsonb_build_array(jsonb_build_object('email', p_email)),
		'subject', 'Confirmez votre adresse email',
		'htmlContent',
			'<p>Bonjour,</p>' ||
			'<p>Un compte a été créé sur le jeu École Primaire avec cette adresse email.</p>' ||
			'<p><a href="' || v_lien || '">Cliquez ici pour confirmer votre adresse email</a></p>' ||
			'<p>Ce lien expire dans 24 heures. Si vous n''êtes pas à l''origine de cette demande, ignorez cet email.</p>' ||
			'<p>Cette adresse ne sert qu''à la vérification et à la récupération de compte, elle n''est jamais partagée ni utilisée à d''autres fins.</p>'
	);

	-- BUG CORRIGE le 2026-09-15 (repere au 1er vrai test d'envoi email, voir project_auth_creation_
	-- comptes.md) : "http_headers(...)" n'existe PAS dans l'extension http (confirme sur le depot
	-- pramsey/pgsql-http) - seule la fonction SINGULIER "http_header(field, value)" existe, qui
	-- construit UN seul en-tete (type compose) ; plusieurs en-tetes s'assemblent dans un tableau
	-- ARRAY[...]::http_header[], le type reellement attendu par le champ "headers" de
	-- http_request. Cette fonction n'avait encore jamais ete exercee de bout en bout (le test du
	-- 2026-09-14 n'avait verifie que l'appel Turnstile, qui utilise http_post() et non http_header,
	-- voir project_auth_creation_comptes.md) - l'erreur passait donc inapercue depuis sa creation.
	select * into v_reponse from http((
		'POST',
		'https://api.brevo.com/v3/smtp/email',
		ARRAY[http_header('api-key', v_brevo_api_key), http_header('Accept', 'application/json')],
		'application/json',
		v_corps::text
	)::http_request);

	return v_reponse.status = 201;
end;
$$;

-- SECURITE : contrairement aux autres fonctions de ce fichier, fn_envoyer_email_verification n'a
-- AUCUNE vérification d'identité de son cru (elle fait confiance à ses appelants internes) - si
-- elle restait appelable directement via l'API publique PostgREST (comportement par défaut pour
-- toute fonction du schéma public), n'importe qui pourrait l'utiliser pour envoyer des emails
-- arbitraires via notre compte Brevo (abus de relais). Retrait explicite du droit d'exécution pour
-- les rôles publics - seul l'appel INTERNE depuis fn_creer_compte_public/fn_renvoyer_verification
-- (SECURITY DEFINER, donc exécuté avec les privilèges du propriétaire de la fonction) continue de
-- fonctionner, un appel RPC direct sera refusé.
revoke execute on function fn_envoyer_email_verification(text, text) from anon, authenticated;

-- ============================================================================
-- fn_verifier_email : appelée par la page de confirmation (task client à venir) avec le token lu
-- dans l'URL. Le HACHÉ est comparé, jamais le token en clair stocké nulle part côté serveur.
-- ============================================================================
create or replace function fn_verifier_email(p_token text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id   text;
	v_expire_le   timestamptz;
begin
	select compte_id, expire_le into v_compte_id, v_expire_le
	from verifications_email
	where token_hash = encode(digest(p_token, 'sha256'), 'hex');

	if v_compte_id is null then
		raise exception 'token_invalide';
	end if;
	if v_expire_le < now() then
		raise exception 'token_expire';
	end if;

	update comptes set email_verifie = true where id = v_compte_id;
	delete from verifications_email where compte_id = v_compte_id;

	return jsonb_build_object('ok', true);
end;
$$;

-- ============================================================================
-- fn_renvoyer_verification : bouton "renvoyer l'email" côté client (task à venir), protégé par un
-- cooldown de 5 minutes (voir point 3 de project_auth_creation_comptes.md) pour ne pas déplacer
-- l'abus vers cette fonction d'envoi. Authentifiée par jeton de session, comme fn_maj_profil.
-- ============================================================================
create or replace function fn_renvoyer_verification(p_jeton text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id        text;
	v_email            text;
	v_dernier_envoi    timestamptz;
	v_token            text;
	v_brevo_ok         boolean := false;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;

	select email into v_email from comptes where id = v_compte_id;
	if v_email is null then
		raise exception 'email_absent';
	end if;

	select dernier_envoi_le into v_dernier_envoi from verifications_email where compte_id = v_compte_id;
	if v_dernier_envoi is not null and v_dernier_envoi > now() - interval '5 minutes' then
		raise exception 'attendre_avant_renvoi';
	end if;

	v_token := encode(gen_random_bytes(32), 'hex');
	insert into verifications_email (compte_id, token_hash, expire_le, dernier_envoi_le)
	values (v_compte_id, encode(digest(v_token, 'sha256'), 'hex'), now() + interval '24 hours', now())
	on conflict (compte_id) do update
		set token_hash = excluded.token_hash,
		    expire_le = excluded.expire_le,
		    dernier_envoi_le = excluded.dernier_envoi_le;

	begin
		v_brevo_ok := fn_envoyer_email_verification(v_email, v_token);
	exception when others then
		v_brevo_ok := false;
	end;

	return jsonb_build_object('ok', true, 'email_envoye', v_brevo_ok);
end;
$$;

-- ============================================================================
-- Reprise du 2026-09-16 (voir TODO_UI_MODS.md, mods 1/6/7 et le bug "acces au jeu possible avant
-- confirmation d'email") : 3 fonctions authentifiees par jeton (meme convention que fn_maj_profil)
-- pour laisser un parent (depuis Contrôle parental, voir section_parental_control.gd) changer le
-- pseudo/l'email/le mot de passe DU COMPTE (colonnes de "comptes", distinctes du jsonb "profil"
-- deja gere par fn_maj_profil), + le flux complet "mot de passe oublié" (table dediee, envoi
-- d'email, reinitialisation par lien) et une fonction de consultation du statut de verification
-- d'email pour le bouton "j'ai confirmé, vérifier à nouveau".
-- ============================================================================

-- fn_changer_login : meme regle d'unicite que fn_creer_compte (login_normalise), mais REFUSE
-- explicitement plutot que de suffixer automatiquement - un pseudo choisi a la main par un parent
-- doit rester EXACTEMENT celui demande ou echouer clairement, pas devenir "pseudo7" en silence.
create or replace function fn_changer_login(p_jeton text, p_nouveau_login text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_nouveau_login text := trim(p_nouveau_login);
begin
	select compte_id into v_compte_id from sessions where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	if v_nouveau_login = '' then
		raise exception 'login_vide';
	end if;
	if exists(
		select 1 from comptes where login_normalise = lower(v_nouveau_login) and id <> v_compte_id
	) then
		raise exception 'pseudo_indisponible';
	end if;

	update comptes set login = v_nouveau_login, maj_le = now() where id = v_compte_id;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true, 'login', v_nouveau_login);
end;
$$;

-- fn_changer_email : remplace l'email ET repart de zero sur la verification (email_verifie remis a
-- false, nouveau token envoye, meme mecanique que fn_creer_compte_public) - une adresse qui vient
-- de remplacer une adresse confirmee n'est PAS elle-meme confirmee pour autant. Meme prudence
-- "l'echec d'ENVOI ne fait pas echouer l'operation" que fn_creer_compte_public/
-- fn_renvoyer_verification (voir "email_envoye" dans le retour).
create or replace function fn_changer_email(p_jeton text, p_nouvel_email text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_email text := trim(p_nouvel_email);
	v_token text;
	v_brevo_ok boolean := false;
begin
	select compte_id into v_compte_id from sessions where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	if v_email = '' or position('@' in v_email) = 0 then
		raise exception 'email_invalide';
	end if;

	update comptes set email = v_email, email_verifie = false, maj_le = now() where id = v_compte_id;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	v_token := encode(gen_random_bytes(32), 'hex');
	insert into verifications_email (compte_id, token_hash, expire_le, dernier_envoi_le)
	values (v_compte_id, encode(digest(v_token, 'sha256'), 'hex'), now() + interval '24 hours', now())
	on conflict (compte_id) do update
		set token_hash = excluded.token_hash,
		    expire_le = excluded.expire_le,
		    dernier_envoi_le = excluded.dernier_envoi_le;

	begin
		v_brevo_ok := fn_envoyer_email_verification(v_email, v_token);
	exception when others then
		v_brevo_ok := false;
	end;

	return jsonb_build_object('ok', true, 'email_envoye', v_brevo_ok);
end;
$$;

-- fn_changer_mot_de_passe : le hash+sel sont deja recalcules CÔTE CLIENT avec un sel FRAIS (voir
-- SaveManager.change_password()) - le serveur se contente de les stocker, meme principe que
-- fn_creer_compte (jamais de calcul de hash cote serveur, le mot de passe en clair ne le traverse
-- jamais).
create or replace function fn_changer_mot_de_passe(p_jeton text, p_nouveau_mdp_hash text, p_nouveau_mdp_sel text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
begin
	select compte_id into v_compte_id from sessions where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;

	update comptes set mdp_hash = p_nouveau_mdp_hash, mdp_sel = p_nouveau_mdp_sel, maj_le = now()
	where id = v_compte_id;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true);
end;
$$;

-- fn_statut_email : consultation seule (pas de mutation autre que le rafraichissement de presence
-- habituel), utilisee par le bouton "j'ai confirmé, vérifier à nouveau" de WelcomePanel pendant
-- qu'une session est deja ouverte - evite de repasser par un fn_login complet juste pour ca.
create or replace function fn_statut_email(p_jeton text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id text;
	v_verifie boolean;
begin
	select compte_id into v_compte_id from sessions where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;

	select email_verifie into v_verifie from comptes where id = v_compte_id;
	update sessions set derniere_activite = now() where jeton = p_jeton;

	return jsonb_build_object('ok', true, 'email_verifie', coalesce(v_verifie, true));
end;
$$;

-- 9. reinitialisations_mdp — un token de reinitialisation de mot de passe en attente par compte
-- (meme structure/logique que verifications_email : le renvoi remplace le precedent, seul le
-- HACHE du token est stocke).
create table if not exists reinitialisations_mdp (
	compte_id          text primary key references comptes(id) on delete cascade,
	token_hash         text not null,
	expire_le          timestamptz not null,
	demande_le         timestamptz not null default now()
);
alter table reinitialisations_mdp enable row level security;

-- fn_envoyer_email_reinitialisation : meme mecanique que fn_envoyer_email_verification (voir son
-- commentaire pour le detail de l'appel Brevo) - fonction INTERNE, jamais appelable directement en
-- RPC public (voir le revoke juste en dessous), le lien pointe vers reinitialiser-mdp.html (a
-- creer cote client web, PAS dans ce client Godot - meme logique que verifier-email.html).
create or replace function fn_envoyer_email_reinitialisation(p_email text, p_token text)
returns boolean
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_brevo_api_key   text;
	v_lien            text;
	v_corps           jsonb;
	v_reponse         http_response;
begin
	select valeur into v_brevo_api_key from config_secrets where cle = 'brevo_api_key';
	if v_brevo_api_key is null then
		return false;
	end if;

	v_lien := 'https://www.ecole-primaire.eu/reinitialiser-mdp.html?token=' || p_token;

	v_corps := jsonb_build_object(
		'sender', jsonb_build_object('name', 'École Primaire', 'email', 'noreply@ecole-primaire.eu'),
		'to', jsonb_build_array(jsonb_build_object('email', p_email)),
		'subject', 'Réinitialisation de votre mot de passe',
		'htmlContent',
			'<p>Bonjour,</p>' ||
			'<p>Une réinitialisation de mot de passe a été demandée pour le compte associé à cette adresse email sur le jeu École Primaire.</p>' ||
			'<p><a href="' || v_lien || '">Cliquez ici pour choisir un nouveau mot de passe</a></p>' ||
			'<p>Ce lien expire dans 1 heure. Si vous n''êtes pas à l''origine de cette demande, ignorez cet email : votre mot de passe actuel reste inchangé.</p>'
	);

	select * into v_reponse from http((
		'POST',
		'https://api.brevo.com/v3/smtp/email',
		ARRAY[http_header('api-key', v_brevo_api_key), http_header('Accept', 'application/json')],
		'application/json',
		v_corps::text
	)::http_request);

	return v_reponse.status = 201;
end;
$$;

revoke execute on function fn_envoyer_email_reinitialisation(text, text) from anon, authenticated;

-- fn_demander_reinitialisation_mdp : [p_login_ou_email] essaie d'abord un pseudo, puis un email -
-- renvoie TOUJOURS {"ok": true}, que le compte existe ou non et qu'il ait un email ou non (jamais
-- laisser deviner quels comptes existent, meme principe que fn_obtenir_sel). Cooldown 5 minutes
-- par compte (meme duree que fn_renvoyer_verification) pour eviter l'abus - silencieux lui aussi
-- (toujours {"ok": true}), pas d'exception distincte qui revelerait qu'un envoi recent a eu lieu.
create or replace function fn_demander_reinitialisation_mdp(p_login_ou_email text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_saisie text := trim(p_login_ou_email);
	v_compte_id text;
	v_email text;
	v_dernier_envoi timestamptz;
	v_token text;
begin
	select id, email into v_compte_id, v_email from comptes where login_normalise = lower(v_saisie);
	if v_compte_id is null then
		select id, email into v_compte_id, v_email from comptes
		where email is not null and lower(email) = lower(v_saisie);
	end if;

	if v_compte_id is null or v_email is null or v_email = '' then
		return jsonb_build_object('ok', true);
	end if;

	select demande_le into v_dernier_envoi from reinitialisations_mdp where compte_id = v_compte_id;
	if v_dernier_envoi is not null and v_dernier_envoi > now() - interval '5 minutes' then
		return jsonb_build_object('ok', true);
	end if;

	v_token := encode(gen_random_bytes(32), 'hex');
	insert into reinitialisations_mdp (compte_id, token_hash, expire_le, demande_le)
	values (v_compte_id, encode(digest(v_token, 'sha256'), 'hex'), now() + interval '1 hour', now())
	on conflict (compte_id) do update
		set token_hash = excluded.token_hash,
		    expire_le = excluded.expire_le,
		    demande_le = excluded.demande_le;

	begin
		perform fn_envoyer_email_reinitialisation(v_email, v_token);
	exception when others then
		null; -- echec d'envoi silencieux, meme principe que partout ailleurs dans ce fichier
	end;

	return jsonb_build_object('ok', true);
end;
$$;

-- fn_reinitialiser_mdp : appelee par reinitialiser-mdp.html avec le token lu dans l'URL et un
-- nouveau hash+sel calcules CÔTE PAGE WEB (Web Crypto API, meme algorithme sha256(sel+mdp) que le
-- client Godot - voir _hash_password() dans save_manager.gd) - PAS d'authentification par jeton de
-- SESSION ici (le joueur ne peut par definition pas se connecter, c'est son mot de passe qui est
-- oublie), le token de reinitialisation en tient lieu. Invalide TOUTES les sessions existantes du
-- compte (un mot de passe oublie/compromis justifie de forcer une reconnexion partout) - voir
-- SaveManager.login(), qui sait deja se resynchroniser sur un hash local perime dans ce cas
-- precis (_resync_password_from_server()).
create or replace function fn_reinitialiser_mdp(p_token text, p_nouveau_mdp_hash text, p_nouveau_mdp_sel text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_compte_id   text;
	v_expire_le   timestamptz;
begin
	select compte_id, expire_le into v_compte_id, v_expire_le
	from reinitialisations_mdp
	where token_hash = encode(digest(p_token, 'sha256'), 'hex');

	if v_compte_id is null then
		raise exception 'token_invalide';
	end if;
	if v_expire_le < now() then
		raise exception 'token_expire';
	end if;

	update comptes set mdp_hash = p_nouveau_mdp_hash, mdp_sel = p_nouveau_mdp_sel, maj_le = now()
	where id = v_compte_id;
	delete from reinitialisations_mdp where compte_id = v_compte_id;
	delete from sessions where compte_id = v_compte_id;

	return jsonb_build_object('ok', true);
end;
$$;
