-- Schéma de synchronisation cloud (Supabase / Postgres self-hébergé sur le VPS OVH).
-- Voir project_deploiement_web.md et project_save_sync_architecture.md (mémoire projet) pour le
-- contexte complet des décisions. Ce fichier est la référence pour la tâche #7 (création du
-- schéma) et #8 (RLS + fonctions security definer) du tracker.
--
-- Principe général : le jeu garde SON PROPRE système pseudo/mot de passe (pas Supabase Auth,
-- voir save_manager.gd - le mot de passe est déjà haché+salé côté client avant d'atteindre ce
-- fichier, jamais en clair). Les tables ci-dessous ne sont donc JAMAIS accessibles directement
-- via la clé anon/authenticated de Supabase (RLS fermée en dur) : tout passe par des fonctions
-- Postgres SECURITY DEFINER, exposées automatiquement par Supabase comme endpoints RPC
-- (/rest/v1/rpc/<nom_fonction>), appelées depuis Godot via le noeud HTTPRequest standard.
--
-- Format des identifiants de compte : on garde le format déjà utilisé en local par SaveManager
-- (32 caractères hex = Crypto.new().generate_random_bytes(16).hex_encode()) plutôt que de faire
-- basculer le client sur un uuid Postgres natif - évite une réécriture inutile de la génération
-- d'id côté client (voir feedback_lightweight_game.md, on évite le travail non justifié). D'où
-- des clés primaires en `text`, pas en `uuid`, sur comptes/evenements.
--
-- Création de compte en ligne (2026-09-06, révisé 2026-09-13, voir project_auth_creation_comptes.md
-- en mémoire projet pour la discussion complète) : un compte indépendant par enfant (pseudo unique
-- + mot de passe, inchangé), email NON unique (fratrie ou classe entière) sans plafond fixe, anti-
-- abus par CAPTCHA + limite de VITESSE (burst) plutôt que par un volume total par IP/email - un
-- plafond total casserait l'usage légitime d'une classe entière créée depuis la même IP/le même
-- email. Voir tables verifications_email/creations_recentes et fn_creer_compte/fn_verifier_email
-- plus bas.

-- ============================================================================
-- 1. comptes — identité + authentification (1 ligne par compte joueur)
-- ============================================================================
create table if not exists comptes (
	id                  text primary key,               -- format hex 32 car., généré côté client
	login               text not null,
	login_normalise     text generated always as (lower(login)) stored,
	mdp_hash            text not null,                   -- sha256(sel + mdp), déjà haché côté client
	mdp_sel             text not null,
	email               text,                             -- optionnel, PAS unique (voir plus haut) -
	                                                      -- une même adresse peut être rattachée à
	                                                      -- plusieurs comptes (fratrie/classe)
	email_verifie       boolean not null default false,   -- passe à true par fn_verifier_email()
	profil              jsonb not null default '{}',     -- nom/prenom/classe/date_naissance/pays/
	                                                      -- controle_parental/controle_parental_*
	                                                      -- (dict brut, miroir du profile client -
	                                                      -- voir remarque jsonb plus bas)
	cree_le             timestamptz not null default now(),
	maj_le              timestamptz not null default now()
);

create unique index if not exists comptes_login_normalise_idx on comptes (login_normalise);
create index if not exists comptes_email_idx on comptes (email) where email is not null;

-- ============================================================================
-- 2. verifications_email — double opt-in (2026-09-06) : à la création (ou à un "renvoyer l'email"),
--    un token aléatoire est généré côté serveur, SEUL SON HACHÉ est stocké ici (même logique que
--    mdp_hash sur comptes - jamais le token en clair en base). Le lien envoyé par email pointe vers
--    une page de confirmation sur le domaine du jeu, qui appelle fn_verifier_email(token en clair) -
--    c'est cette fonction qui recalcule le hash pour comparer, jamais l'inverse.
-- ============================================================================
create table if not exists verifications_email (
	id                  bigint generated always as identity primary key,
	compte_id           text not null references comptes(id) on delete cascade,
	token_hash          text not null,                    -- sha256(token), même fonction que mdp_hash
	cree_le             timestamptz not null default now(),
	expire_le           timestamptz not null              -- ex: now() + interval '24 hours'
);

create index if not exists verifications_email_compte_idx on verifications_email (compte_id);

-- ============================================================================
-- 3. creations_recentes — compteur de VITESSE (burst) anti-abus (révisé 2026-09-13 : remplace un
--    plafond total par IP/email, écarté car il cassait l'usage légitime d'une classe entière créée
--    depuis la même IP scolaire ou avec l'email de la maîtresse - voir project_auth_creation_
--    comptes.md, points 2 et 4). Ce qui distingue un bot d'un humain n'est pas le volume total mais
--    la VITESSE : fn_creer_compte rejette une création si plus de MAX_CREATIONS_PAR_FENETRE lignes
--    existent déjà pour la même clé sur la fenêtre glissante des DERNIÈRES ~60 secondes (constantes
--    à fixer au moment de coder la fonction, pas au niveau du schéma). Durée de vie très courte par
--    construction (quelques minutes) : purge paresseuse à chaque appel de fn_creer_compte (delete
--    where horodatage < now() - interval '10 minutes'), pas de job dédié, et pas de question RGPD
--    de rétention longue durée puisque la donnée n'a jamais vocation à survivre plus de quelques
--    minutes.
-- ============================================================================
create table if not exists creations_recentes (
	id                  bigint generated always as identity primary key,
	cle                 text not null,                    -- 'ip:<ip>' ou 'email:<email normalisé>'
	horodatage          timestamptz not null default now()
);

create index if not exists creations_recentes_cle_idx on creations_recentes (cle, horodatage);

-- ============================================================================
-- 4. progressions — état courant agrégé (1 ligne par compte, taille bornée, ne grossit PAS avec
--    le temps - c'est un instantané tenu à jour par les fonctions ci-dessous, pas un journal)
-- ============================================================================
create table if not exists progressions (
	compte_id           text primary key references comptes(id) on delete cascade,
	economy             jsonb not null default '{}',     -- miroir Economy.serialize()
	cards               jsonb not null default '{}',     -- miroir CardCollection.serialize()
	stats               jsonb not null default '{}',     -- miroir StatsTracker.serialize()
	prof_skins          jsonb not null default '{}',      -- miroir ProfSkins.serialize()
	dernier_evenement_id text,                            -- dernier evenements.id appliqué, pour
	                                                       -- debug/audit uniquement
	maj_le              timestamptz not null default now()
);

-- ============================================================================
-- 5. evenements — journal des mutations, source de l'idempotence et de la réconciliation.
--    Rétention courte (30-90 jours à trancher, tâche #16) : purgé après agrégation dans
--    stats_agregees, ne doit donc pas grossir indéfiniment (voir estimation de poids dans
--    project_save_sync_architecture.md).
-- ============================================================================
create type type_evenement as enum (
	'gain_piece',
	'depense_piece',
	'carte_debloquee',
	'stat_incrementee',
	'achat_skin'
	-- liste volontairement non exhaustive au stade du schéma - complétée à la tâche #9
	-- (format des événements) au fil des mutations réellement instrumentées dans SaveManager.
	-- ajouter une valeur plus tard : ALTER TYPE type_evenement ADD VALUE 'xxx' (non bloquant,
	-- ne casse jamais les lignes existantes).
);

create table if not exists evenements (
	id                  text primary key,                -- id unique généré CÔTÉ CLIENT (clé
	                                                      -- d'idempotence - un renvoi après coupure
	                                                      -- réseau retombe sur la même ligne, voir
	                                                      -- fn_pousser_evenements plus bas)
	compte_id           text not null references comptes(id) on delete cascade,
	type                type_evenement not null,
	payload             jsonb not null default '{}',      -- contenu minimal (ex: {"montant": 5})
	horodatage_client   timestamptz not null,              -- informatif seulement, JAMAIS utilisé
	                                                       -- pour arbitrer un conflit (horloge de
	                                                       -- PC d'école pas fiable, voir discussion)
	recu_le             timestamptz not null default now() -- seule date qui fait foi côté serveur
);

create index if not exists evenements_compte_recu_idx on evenements (compte_id, recu_le);

-- ============================================================================
-- 6. stats_agregees — rollup périodique (tâche #16), alimente le futur tableau de bord d'usage
--    par matière ET sert de trace longue durée une fois les evenements bruts purgés. Reste petit
--    indéfiniment : une ligne par compte x matière x jour, pas par événement.
-- ============================================================================
create table if not exists stats_agregees (
	compte_id           text not null references comptes(id) on delete cascade,
	matiere             text,                              -- null si l'événement n'est pas rattaché
	                                                       -- à une matière (ex: achat_skin)
	periode             date not null,                     -- granularité jour
	nb_evenements       integer not null default 0,
	pieces_gagnees      integer not null default 0,
	pieces_depensees    integer not null default 0,
	cartes_debloquees   integer not null default 0,
	nb_bonnes_reponses  integer not null default 0,
	nb_questions        integer not null default 0,
	primary key (compte_id, matiere, periode)
);

-- ============================================================================
-- 7. sessions — jetons de connexion de courte durée, validés le 2026-09-05 : évite de faire
--    circuler mdp_hash à CHAQUE appel (fn_pousser_evenements, fn_recuperer_progression...) ;
--    fn_login est la SEULE fonction qui vérifie encore le hash, et émet ce jeton en échange.
--    Nettoyage des jetons expirés : suppression paresseuse (delete where expire_le < now()) au
--    moment de fn_login, pas besoin d'un job dédié tant que le volume reste faible.
-- ============================================================================
create table if not exists sessions (
	jeton               text primary key,                -- aléatoire, généré côté serveur (ex:
	                                                      -- encode(gen_random_bytes(32), 'hex'))
	compte_id           text not null references comptes(id) on delete cascade,
	cree_le             timestamptz not null default now(),
	expire_le           timestamptz not null              -- ex: now() + interval '48 hours'
);

create index if not exists sessions_compte_idx on sessions (compte_id);
create index if not exists sessions_expire_idx on sessions (expire_le);

-- ============================================================================
-- Sécurité : RLS fermée sur les 7 tables, aucun accès direct via la clé anon publique. Tout passe
-- par des fonctions SECURITY DEFINER (squelette ci-dessous - à détailler tâche #8/#11/#12/#13,
-- ne pas coder le corps complet avant d'avoir validé le format exact des événements, tâche #9).
-- ============================================================================
alter table comptes             enable row level security;
alter table verifications_email enable row level security;
alter table creations_recentes  enable row level security;
alter table progressions        enable row level security;
alter table evenements          enable row level security;
alter table stats_agregees      enable row level security;
alter table sessions            enable row level security;
-- Aucune policy créée = aucun accès pour anon/authenticated par défaut avec RLS activé. On
-- pourrait aussi révoquer explicitement les privilèges de table pour être doublement sûr :
-- revoke all on comptes, verifications_email, creations_recentes, progressions, evenements,
--   stats_agregees, sessions from anon, authenticated;

-- ============================================================================
-- Fonctions SECURITY DEFINER (squelettes commentés - PAS ENCORE DÉPLOYÉES, voir
-- project_auth_creation_comptes.md en mémoire projet pour la conception complète). Nécessitent
-- l'extension `pgcrypto` (gen_random_bytes, déjà utilisée par sessions.jeton) et, pour les DEUX
-- appels réseau sortants (vérification Turnstile + envoi de l'email via l'API du prestataire,
-- ex. Brevo), l'extension `http` ou `pg_net` - à activer au moment du déploiement sur le VPS
-- (tâche d'infra, pas une question de schéma). Les clés secrètes (Turnstile secret key, clé API
-- Brevo) NE DOIVENT PAS être codées en dur ici : à stocker via un mécanisme de configuration
-- serveur (ex. Vault Supabase, ou une variable d'environnement lue par une Edge Function
-- intermédiaire si l'extension `http` s'avère trop limitée pour porter des en-têtes secrets).
-- ============================================================================

-- fn_creer_compte(p_login, p_mdp_hash, p_mdp_sel, p_email, p_profil, p_captcha_token, p_honeypot,
--   p_ip) -> jsonb {id, login (éventuellement suffixé si collision), email_verifie: false}
--   1. Honeypot : si p_honeypot n'est pas vide, lever une erreur générique (ne jamais indiquer au
--      bot QUE c'est le honeypot qui a été détecté).
--   2. Captcha : vérifier p_captcha_token auprès de Cloudflare Turnstile (appel http/pg_net vers
--      https://challenges.cloudflare.com/turnstile/v0/siteverify) - échec => erreur "captcha
--      invalide".
--   3. Vitesse (voir creations_recentes) : purge paresseuse des lignes de plus de 10 minutes, puis
--      compte les lignes pour cle='ip:'||p_ip et, si p_email non vide, cle='email:'||lower(p_email)
--      sur la fenêtre glissante d'1 minute - si l'une des deux dépasse le seuil (ex. 5), lever une
--      erreur "trop de créations, réessayez dans un instant" (PAS un blocage permanent).
--   4. Collision de pseudo : si login_normalise existe déjà, NE PAS échouer directement côté
--      serveur - le CLIENT est censé avoir déjà proposé une variante via une vérification préalable
--      (voir SaveManager.suggest_login_variant() côté GDScript) ; en pur filet de sécurité contre
--      une course (deux créations quasi simultanées du même pseudo), retenter avec un suffixe
--      aléatoire (2 chiffres) jusqu'à quelques tentatives avant d'abandonner avec une erreur.
--   5. Insertion dans `comptes` (email_verifie=false même si p_email est vide - reste simplement
--      non pertinent dans ce cas, aucune vérification n'est jamais déclenchée pour un compte sans
--      email), puis génération d'un token aléatoire (gen_random_bytes), insertion de son HACHÉ
--      (jamais le token en clair) dans `verifications_email` avec expire_le = now() + 24h - UNIQUEMENT
--      si p_email n'est pas vide.
--   6. Insertion des 2 lignes de comptage dans `creations_recentes` (ip + email si fourni).
--   7. Si un email est fourni : déclenche l'envoi du mail de vérification (appel API Brevo, token EN
--      CLAIR uniquement dans ce lien-là, jamais renvoyé ni stocké ailleurs) contenant un lien vers la
--      page de confirmation du domaine du jeu.
--
-- fn_verifier_email(p_token) -> boolean (true si vérifié)
--   Calcule sha256(p_token), cherche une ligne verifications_email avec ce token_hash ET
--   expire_le > now() ; si trouvée, met comptes.email_verifie = true pour le compte associé,
--   supprime la ligne de verifications_email (usage unique), et en profite pour purger les lignes
--   expirées d'autres comptes (delete where expire_le < now()). Renvoie false si rien ne correspond
--   (token invalide, déjà utilisé, ou expiré) - message générique côté client dans tous les cas,
--   ne JAMAIS révéler lequel des trois s'est produit (même logique que login() pour pseudo/mdp).
--
-- fn_renvoyer_verification(p_compte_id) -> boolean
--   Cooldown anti-abus (~5 min) : si une ligne verifications_email pour ce compte a été créée il y
--   a moins de 5 minutes, ne rien faire (renvoie false, le client affiche "patiente encore un peu").
--   Sinon, même logique que l'étape 5/7 de fn_creer_compte (nouveau token, nouvelle ligne, nouvel
--   envoi), en supprimant l'ancienne ligne pour ce compte au passage (un seul token valide à la
--   fois par compte).
--
-- fn_login(p_login, p_mdp_hash) -> vérifie le hash, crée une ligne dans `sessions` et renvoie son
--   jeton (ou null si échec) - SEULE fonction qui manipule mdp_hash. Ne dépend PAS de
--   email_verifie : un compte non vérifié reste connectable, seule la synchro cloud lui est
--   refusée (voir fn_pousser_evenements/fn_recuperer_progression ci-dessous).
-- fn_pousser_evenements(p_jeton, p_evenements jsonb[]) -> résout compte_id via `sessions` (jeton
--   valide et non expiré, sinon erreur "session expirée" - le client relance fn_login), vérifie
--   ENSUITE comptes.email_verifie = true pour ce compte_id (sinon erreur "email non vérifié", le
--   jeu continue de fonctionner en local sans bloquer - voir project_auth_creation_comptes.md,
--   point 3), applique chaque événement à `progressions` en dédoublonnant sur evenements.id via
--   ON CONFLICT (id) DO NOTHING (un envoi en double ne déclenche jamais deux fois l'application),
--   renvoie la liste des ids appliqués avec succès
-- fn_recuperer_progression(p_jeton) -> résout compte_id via `sessions`, renvoie la ligne
--   progressions courante du compte (accessible même sans email vérifié - lecture seule, seule la
--   PUSH d'événements est bloquée par email_verifie, pas la lecture)
