## Sauvegarde/charge l'etat qui doit survivre a un REDEMARRAGE du jeu. Gere PLUSIEURS comptes
## locaux (2026-08-01, retour utilisateur : le jeu doit pouvoir etre partage par plusieurs enfants
## sur le meme appareil, chacun avec son propre pseudo/mot de passe) au lieu d'un profil unique :
## chaque compte a son propre profil (nom/prenom/classe/date de naissance/pays) et sa propre
## progression (economie, cartes, stats). Plein ecran reste partage au niveau de l'appareil, PAS
## par compte. Le volume (musique/bruitages) EST par compte depuis le 2026-09-05 (voir
## DEFAULT_VOLUME plus bas) : chaque compte a son propre reglage, et l'ecran d'accueil (personne
## connecte) revient toujours a 50/50, jamais au reglage du dernier compte utilise.
##
## Theme d'interface PAR COMPTE depuis le 2026-09-06 (retour utilisateur : "pour l ecran dintro je
## veux que le theme de couleur soit fixe et ne varie pas de 'fete foraine', des le log in dans un
## compte, le theme du compte prend effet") - remplace l'ancien fonctionnement "partage au niveau
## de l'appareil" decrit ci-dessus (device_settings["ui_theme"] n'est plus ecrit ni relu, une
## ancienne sauvegarde qui le contient encore le voit simplement ignore, meme principe que
## "custom_bindings"/"master_volume" plus bas). Meme mecanique que le volume : ui_theme reflete
## toujours la valeur COURANTE (DEFAULT_UI_THEME "fete_foraine" sur l'ecran d'accueil, ou le theme
## choisi par le compte connecte), stocke dans profile["ui_theme"], voir
## _apply_theme_from_profile()/_reset_theme_to_default() plus bas.
##
## Systeme de reassignation clavier retire (2026-09-02, retour utilisateur : "on supprime tous
## les raccourcis clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") :
## REBINDABLE_ACTIONS/custom_bindings/_default_bindings/rebind_action()/get_binding_label()/etc.
## (et la cle "custom_bindings" de device_settings dans savegame.json) sont retires - le jeu n'a
## plus aucune touche a reassigner (voir la suppression de la section "Commandes" du menu,
## SectionControls). Une ancienne sauvegarde contenant encore "custom_bindings" n'en souffre pas :
## la cle est simplement ignoree au chargement (settings.get() sans elle).
##
## Personne n'est connecte au demarrage (voir current_account_id vide dans _ready()), meme si des
## comptes existent deja sur le disque : WelcomePanel (voir levels/park/park.tscn) demande
## systematiquement pseudo + mot de passe, ou la creation d'un nouveau compte - pas de liste des
## comptes existants affichee (retour utilisateur : on tape son pseudo, on ne le choisit pas dans
## une liste).
##
## Le mot de passe n'est jamais stocke en clair : sha256(sel + mot de passe), sel aleatoire genere
## via Crypto.generate_random_bytes(). Suffisant pour un jeu 100% local destine a des enfants,
## mais ce n'est PAS un hachage "lent" (bcrypt/argon2, absents de Godot) - a garder en tete si ce
## systeme est un jour expose en ligne (voir memoire projet sur la localisation internationale).
extends Node

const SAVE_PATH := "user://savegame.json"
const SALT_BYTE_LENGTH := 16
const MIN_PASSWORD_LENGTH := 4

## Longueur (en octets, voir _generate_random_hex) de l'id genere pour chaque evenement pousse au
## serveur (voir log_event() plus bas) - identique a SALT_BYTE_LENGTH par simplicite, pas de lien
## particulier entre les deux, juste "assez long pour ne jamais entrer en collision".
const EVENT_ID_BYTE_LENGTH := 16
## Intervalle (secondes) entre deux tentatives automatiques de pousser les evenements en attente
## (voir _setup_sync_retry_timer()) - filet de secours pour le cas ou le reseau revient APRES le
## dernier evenement/la derniere connexion (log_event()/login() tentent deja une synchro
## immediate a chaque appel, ce timer ne fait que rattraper les cas ou aucun des deux ne s'est
## reproduit depuis la coupure). Pas trop court : chaque tentative est une requete HTTP, inutile
## de la refaire toutes les secondes tant que rien de nouveau n'attend d'etre envoye (voir la garde
## "pending.is_empty()" dans _flush_pending_events()).
const SYNC_RETRY_INTERVAL_SECONDS := 30.0

## Volume (musique ET bruitages) applique sur l'ecran d'accueil (personne connecte) et pour tout
## compte qui n'a pas encore choisi son propre reglage (2026-09-05, retour utilisateur : "pour
## l'ecran d'arrivee, jaimerai que le son et la musique soient regle de base a 50%, chaque compte
## reglera son volume son et musique mais au retour sur la page intro on aura retour a 50/50") -
## voir _apply_volume_from_profile()/_reset_volume_to_default() plus bas.
const DEFAULT_VOLUME := 0.5

## Numero de version du format ecrit dans savegame.json (cle "version") - permet de distinguer
## une vraie migration de structure future (renommage de cle, changement de type...) du simple
## ajout/retrait de cle deja gere par les .get() avec valeur par defaut partout dans ce fichier.
## A incrementer et a traiter explicitement dans _read_from_path() le jour ou une migration reelle
## est necessaire ; pour l'instant la valeur est juste lue et ignoree (aucune migration a faire).
const SAVE_FORMAT_VERSION := 1

## Themes d'interface disponibles (voir CHARTE_GRAPHIQUE.md) : un identifiant stable (sauvegarde
## dans savegame.json, ne jamais renommer une cle existante) vers la Theme resource correspondante.
## preload() plutot que load() a l'usage : ce sont 4 fichiers fixes, connus a l'avance.
const THEMES := {
	"fete_foraine": preload("res://ui/theme/game_theme.tres"),
	"bonbon": preload("res://ui/theme/theme_bonbon.tres"),
	"tropical": preload("res://ui/theme/theme_tropical.tres"),
	"sombre": preload("res://ui/theme/theme_sombre.tres"),
}
const DEFAULT_UI_THEME := "fete_foraine"

## Apercu compact (libelle + couleurs) pour les vignettes de selection de SectionConfig - tenu a
## jour a la main en cohérence avec la palette de chaque .tres (voir CHARTE_GRAPHIQUE.md). Pas de
## lecture dynamique du Theme resource pour rester simple (3 couleurs suffisent a une vignette).
const THEME_PREVIEWS := {
	"fete_foraine": {"label": "Fête foraine", "bg": Color("FFF0D6"), "border": Color("7A4A2B"), "accent": Color("FFDD57")},
	"bonbon": {"label": "Bonbon", "bg": Color("FFF3F8"), "border": Color("7A3B63"), "accent": Color("FF9BC8")},
	"tropical": {"label": "Aventure tropicale", "bg": Color("EAFBF6"), "border": Color("0E5C52"), "accent": Color("4FD8B0")},
	"sombre": {"label": "Sombre", "bg": Color("2B2E33"), "border": Color("B08D57"), "accent": Color("D9A63C")},
}

## Emis quand une connexion (login()) ou une creation de compte (create_account()) reussit.
signal account_logged_in(profile: Dictionary)
## Emis a la deconnexion (logout()) ou a la suppression du compte connecte (delete_current_account()).
signal account_logged_out

## Reglages geres directement ici. fullscreen reste partage par tous les comptes de l'appareil (pas
## assez de logique propre a chacun pour justifier un autoload dedie, contrairement a Economy/
## CardCollection/ChallengeTracker, qui ont une vraie logique metier). ui_theme etait dans le meme
## cas jusqu'au 2026-09-06 (voir le commentaire de classe) - c'est desormais un reglage PAR COMPTE,
## comme le volume juste en dessous.
##
## Volume musique/bruitages separes (2026-09-04, retour utilisateur : deux barres au lieu d'un
## volume general unique) - chaque valeur pilote le bus AudioServer du meme nom (voir
## default_bus_layout.tres et SoundManager, qui assigne ses AudioStreamPlayer a ces bus).
## PAR COMPTE depuis le 2026-09-05 (retour utilisateur, voir DEFAULT_VOLUME ci-dessus) : ces 2
## variables refletent le volume COURANT (celui de l'ecran d'accueil tant que personne n'est
## connecte, sinon celui du compte connecte) - stockees dans profile["music_volume"]/
## profile["sfx_volume"] (comme daily_game_limit, voir get_daily_game_limit()), PAS dans
## device_settings sur le disque (voir _save_to_disk()/_read_from_path()) : ce n'est plus un
## reglage unique de l'appareil.
var music_volume: float = DEFAULT_VOLUME # 0.0 (muet) a 1.0 (max)
var sfx_volume: float = DEFAULT_VOLUME # 0.0 (muet) a 1.0 (max)
var fullscreen: bool = false
var ui_theme: String = DEFAULT_UI_THEME

## Chaque compte est un Dictionary : {id, login, password_hash, password_salt, profile
## (nom/prenom/classe/date_naissance/pays), economy, cards, stats, grade_unlock}. Pas de classe
## dediee (Resource ou autre) : coherent avec le reste du projet, qui serialise deja Economy/
## CardCollection/etc. en Dictionary bruts plutot qu'en objets typés (voir leurs serialize()).
var _accounts: Array[Dictionary] = []

## Id du compte actuellement connecte, ou "" si personne n'est connecte (WelcomePanel visible).
var current_account_id: String = ""

## Motif du dernier echec de login() (2026-09-13, chantier "conflit de connexion") - vide des le
## debut de chaque appel a login()/_login_from_server(), rempli UNIQUEMENT sur un refus serveur
## explicite "compte_deja_connecte" (voir ces deux fonctions plus bas). WelcomePanel s'en sert pour
## distinguer ce cas d'un simple pseudo/mot de passe incorrect - contrairement a ce dernier cas
## (volontairement indistinct, voir login()), un joueur qui vient de taper SES BONS identifiants
## merite de savoir pourquoi il ne rentre pas, ce n'est pas une information a proteger.
var last_login_error: String = ""

func _ready() -> void:
	_read_from_disk()
	## Toujours deconnecte au demarrage, meme si des comptes existent sur le disque - voir
	## commentaire de classe : WelcomePanel redemande systematiquement pseudo + mot de passe.
	current_account_id = ""
	## Sauvegarde automatique le temps du dev (2026-08-30, retour utilisateur : "la sauvegarde ne
	## fonctionne plus, a chaque connexion je dois tout recommencer") : voir WelcomePanel.ENABLED,
	## desactive depuis le 2026-08-26 pour sauter l'ecran de connexion pendant le developpement.
	## Sans connexion, current_account_id reste vide et save_current_account() ne fait jamais rien
	## (voir sa garde) - la progression vivait donc seulement en memoire et se perdait a chaque
	## relancement. En connectant automatiquement un compte "dev" local ici, la sauvegarde/
	## le chargement disque refonctionnent sans reafficher l'ecran de connexion. A retirer (ou
	## desactiver via DEV_AUTO_LOGIN) quand WelcomePanel.ENABLED repasse a true.
	if DEV_AUTO_LOGIN:
		_auto_login_dev_account()
	_apply_settings()
	## Voir le commentaire de _on_pack_completed_for_daily_limit() plus bas (application de la
	## limite quotidienne, 2026-09-06).
	EventBus.pack_completed.connect(_on_pack_completed_for_daily_limit)
	## Voir le commentaire de _setup_sync_retry_timer() plus bas (chantier "sauvegarde serveur",
	## 2026-09-13).
	_setup_sync_retry_timer()

## Voir le commentaire au point d'appel dans _ready(). Login silencieux (aucune UI a ce stade) sur
## un compte local fixe, cree au tout premier lancement puis simplement reutilise ensuite - permet
## a save_current_account()/reload_current_account() de fonctionner normalement tant que
## WelcomePanel.ENABLED est a false.
##
## Repasse a false le 2026-09-04 (retour utilisateur : ecran d'introduction plein ecran avec menu
## "Entrer en classe"/"Quitter" - voir WelcomePanel.ENABLED, repasse a true le meme jour) : comme
## prevu par le commentaire ci-dessus, ce contournement de dev n'a plus lieu d'etre des que l'ecran
## de connexion redevient actif. Repasser a true redonnerait un compte "dev" connecte
## automatiquement au demarrage, masquant a nouveau l'ecran d'introduction (voir la garde
## "current_account_id.is_empty()" dans WelcomePanel._ready()).
const DEV_AUTO_LOGIN := false
const DEV_ACCOUNT_LOGIN := "dev"
const DEV_ACCOUNT_PASSWORD := "devdev"

func _auto_login_dev_account() -> void:
	if await login(DEV_ACCOUNT_LOGIN, DEV_ACCOUNT_PASSWORD):
		return
	create_account(DEV_ACCOUNT_LOGIN, DEV_ACCOUNT_PASSWORD, {
		"nom": "Dev",
		"prenom": "Dev",
		"classe": GradeLevel.Grade.CP,
		"date_naissance": {"year": 2018, "month": 1, "day": 1},
		"pays": "fr",
	})

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

## --- Comptes ---

func _find_account_index_by_login(login_name: String) -> int:
	var normalized := login_name.strip_edges().to_lower()
	for i in _accounts.size():
		if String(_accounts[i].get("login", "")).to_lower() == normalized:
			return i
	return -1

func is_login_taken(login_name: String) -> bool:
	return _find_account_index_by_login(login_name) != -1

## Propose une variante DISPONIBLE de [base_login] quand il est deja pris (2026-09-13, voir point 5
## de project_auth_creation_comptes.md en memoire projet) - evite que l enfant doive lui-meme
## inventer une variante de plus en plus compliquee a la creation de compte. Ajoute un nombre a 2
## chiffres tire au hasard, retente jusqu a MAX_SUGGESTION_ATTEMPTS fois en cas de nouvelle
## collision (tres improbable en pratique, 90 valeurs possibles a 2 chiffres), puis se rabat sur un
## suffixe a 4 chiffres pour garantir un resultat meme dans un cas degenere.
const MAX_SUGGESTION_ATTEMPTS := 20

func suggest_login_variant(base_login: String) -> String:
	var trimmed := base_login.strip_edges()
	for _attempt in MAX_SUGGESTION_ATTEMPTS:
		var candidate := "%s%d" % [trimmed, randi_range(10, 99)]
		if not is_login_taken(candidate):
			return candidate
	return "%s%d" % [trimmed, randi_range(1000, 9999)]

func _hash_password(password: String, salt: String) -> String:
	return (salt + password).sha256_text()

func _generate_random_hex(byte_length: int) -> String:
	return Crypto.new().generate_random_bytes(byte_length).hex_encode()

## Tente une connexion. Renvoie true et connecte le compte si le pseudo existe et le mot de passe
## correspond, false sinon - pas de distinction entre "pseudo inconnu" et "mauvais mot de passe"
## dans le retour, pour ne pas laisser deviner quels pseudos existent deja (voir last_login_error
## pour la SEULE exception a cette regle). Devenue asynchrone le 2026-09-13 (2 chantiers, voir
## project_save_sync_architecture.md en memoire projet) :
## 1. "connexion cross-device" : un pseudo INCONNU de cet appareil (nouvel appareil/navigateur, ou
##    compte cree par une maitresse pour un enfant qui se connecte ensuite d'ailleurs) declenche une
##    tentative de recuperation aupres du serveur avant d'echouer, voir _login_from_server() plus
##    bas.
## 2. "conflit de connexion" : meme pour un pseudo DEJA connu de cet appareil, une reclamation de
##    session serveur est tentee (voir plus bas) - UNIQUEMENT pour verifier qu'aucun AUTRE appareil
##    ne joue deja sur ce compte en ce moment (voir fn_login dans schema.sql), jamais pour re-
##    verifier le mot de passe (deja fait juste avant, en local). Un probleme reseau/VPS injoignable
##    ici NE BLOQUE PAS la connexion (le jeu doit rester jouable hors-ligne) - seul un refus EXPLICITE
##    "compte_deja_connecte" la bloque reellement.
func login(login_name: String, password: String) -> bool:
	last_login_error = ""
	var index := _find_account_index_by_login(login_name)
	if index == -1:
		return await _login_from_server(login_name, password)
	var account: Dictionary = _accounts[index]
	var expected_hash: String = account.get("password_hash", "")
	var actual_hash := _hash_password(password, String(account.get("password_salt", "")))
	if expected_hash != actual_hash:
		return false

	## Reclame une session serveur MAINTENANT (voir le point 2 du commentaire de fonction) - sert
	## aussi a obtenir un jeton frais tout de suite (evite d'attendre le prochain log_event()/
	## _ensure_server_session() pour ca, voir plus bas dans ce fichier).
	var login_result := await ServerApi.login(login_name, actual_hash)
	if login_result.get("ok", false):
		var data: Dictionary = login_result.get("data", {})
		## Relit l'index : le compte courant (ou la liste) a pu changer pendant l'attente reseau
		## (meme prudence que _do_flush()/_ensure_server_session() plus bas dans ce fichier).
		index = _find_account_index_by_login(login_name)
		if index != -1:
			_accounts[index]["sync_jeton"] = String(data.get("jeton", ""))
	elif login_result.get("type", "") == "serveur" and login_result.get("message", "") == "compte_deja_connecte":
		last_login_error = "compte_deja_connecte"
		return false
	## Tout autre cas (reseau, VPS injoignable, ou tout refus serveur AUTRE que
	## "compte_deja_connecte") : on ignore et on continue en confiance locale, exactement comme
	## avant ce chantier - le mot de passe local vient deja d'etre verifie plus haut.

	index = _find_account_index_by_login(login_name)
	if index == -1: # compte retire localement pendant l'attente reseau (tres improbable) - filet
		return false
	account = _accounts[index]
	current_account_id = String(account.get("id", ""))
	_apply_account_to_runtime(account)
	_apply_volume_from_profile(account.get("profile", {}))
	_apply_theme_from_profile(account.get("profile", {}))
	account_logged_in.emit(account.get("profile", {}))
	## Memorise ce pseudo sur cet appareil (2026-09-13, voir PseudoCache) - permet l autocompletion
	## au prochain retour sur cet ecran, voir WelcomePanel.
	PseudoCache.remember(login_name)
	## Rattrape tout evenement reste en attente d'une session precedente hors-ligne (voir
	## log_event()/_flush_pending_events() plus bas, chantier "sauvegarde serveur" 2026-09-13) -
	## sans effet (retour immediat) si la file est deja vide, jamais bloquant pour ce login.
	_flush_pending_events()
	return true

## Recupere un compte existant cote serveur quand son pseudo est inconnu de CET appareil (voir
## login() ci-dessus) : obtient le VRAI sel via fn_obtenir_sel (impossible de calculer le bon
## mdp_hash sans lui sur un appareil qui n'a jamais stocke ce compte localement, voir
## _hash_password), verifie les identifiants via fn_login (qui applique AUSSI la verification "pas
## deja connecte ailleurs", voir le point 2 du commentaire de login() ci-dessus - ce cas remplit
## last_login_error comme dans login()), puis rapatrie le profil (renvoye par fn_login desormais,
## voir schema.sql - nom/prenom/classe/date de naissance/pays ET controle parental/limite
## quotidienne, stockes dans ce meme "profil" cote client) et la progression via
## fn_recuperer_progression pour reconstruire une entree _accounts locale complete. Renvoie false
## SANS distinction d'erreur dans les autres cas (pseudo inconnu, mauvais mot de passe, hors-ligne,
## VPS injoignable...) - meme principe de discretion que login(), et sans jamais bloquer/planter sur
## un souci reseau ici (ServerApi ne leve aucune erreur Godot, voir son commentaire de classe).
func _login_from_server(login_name: String, password: String) -> bool:
	var trimmed_login := login_name.strip_edges()
	if trimmed_login.is_empty():
		return false

	var sel_result := await ServerApi.obtenir_sel(trimmed_login)
	if not sel_result.get("ok", false):
		return false
	var salt := String(sel_result.get("data", ""))
	var mdp_hash := _hash_password(password, salt)

	var login_result := await ServerApi.login(trimmed_login, mdp_hash)
	if not login_result.get("ok", false):
		if login_result.get("type", "") == "serveur" and login_result.get("message", "") == "compte_deja_connecte":
			last_login_error = "compte_deja_connecte"
		return false
	var login_data: Dictionary = login_result.get("data", {})
	var jeton := String(login_data.get("jeton", ""))
	var compte_id := String(login_data.get("compte_id", ""))
	var profil: Dictionary = login_data.get("profil", {})
	if jeton.is_empty() or compte_id.is_empty():
		return false

	var progression_result := await ServerApi.recuperer_progression(jeton)
	if not progression_result.get("ok", false):
		return false
	var data: Dictionary = progression_result.get("data", {})

	## Repart d'un etat neuf avant d'appliquer la progression distante, meme logique que
	## create_account() plus haut (pas de residu d'un compte precedemment connecte dans cette meme
	## session).
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()
	ProfSkins.reset()
	ClassroomDecor.reset()
	ClassroomMusic.reset()

	var account := {
		"id": compte_id,
		"login": trimmed_login,
		"password_hash": mdp_hash,
		"password_salt": salt,
		"profile": profil,
		"economy": data.get("economy", {}),
		"cards": data.get("cards", {}),
		"defis": data.get("defis", {}),
		"prof_skins": data.get("prof_skins", {"unlocked": {}, "active": {}}),
		"classroom_decor": data.get("classroom_decor", {"unlocked": {}, "active": {}}),
		"classroom_music": data.get("classroom_music", {"unlocked": {}, "active": {}}),
		## Deja rapatrie a l'instant depuis le serveur : un jeton flambant neuf, aucune raison de le
		## jeter puis en redemander un autre au prochain log_event() (voir _ensure_server_session()).
		"sync_jeton": jeton,
		"sync_evenements": [],
		## Le profil VIENT d'etre lu depuis le serveur : par definition synchronise a cet instant
		## (voir "profil_synchronise" dans create_account()/update_current_profile() plus haut/bas).
		"profil_synchronise": true,
	}
	_accounts.append(account)
	current_account_id = compte_id
	_apply_account_to_runtime(account)
	_apply_volume_from_profile(account["profile"])
	_apply_theme_from_profile(account["profile"])
	_save_to_disk()
	account_logged_in.emit(account["profile"])
	PseudoCache.remember(trimmed_login)
	return true

## Cree un nouveau compte et connecte immediatement dessus. [profile] attend les cles nom/prenom/
## classe (int GradeLevel.Grade)/date_naissance (Dictionary annee/mois/jour)/pays (String, "fr"
## pour l'instant, voir assets/flags/). Renvoie "" en cas de succes, ou un message d'erreur a
## afficher tel quel (pseudo deja pris, mot de passe trop court...).
func create_account(login_name: String, password: String, profile: Dictionary) -> String:
	var trimmed_login := login_name.strip_edges()
	if trimmed_login.is_empty():
		return "Le pseudo ne peut pas être vide."
	if password.length() < MIN_PASSWORD_LENGTH:
		return "Le mot de passe doit faire au moins %d caractères." % MIN_PASSWORD_LENGTH
	if is_login_taken(trimmed_login):
		return "Ce pseudo est déjà pris."

	## Repart d'un etat neuf (pas de residu d'un compte precedemment connecte dans cette meme
	## session) - la classe choisie ici reste une donnee de profil purement declarative depuis le
	## retrait de GradeUnlock (2026-08-29) : toutes les classes sont accessibles des le depart.
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()
	ProfSkins.reset()
	ClassroomDecor.reset()
	ClassroomMusic.reset()

	var salt := _generate_random_hex(SALT_BYTE_LENGTH)
	var account := {
		"id": _generate_random_hex(SALT_BYTE_LENGTH),
		"login": trimmed_login,
		"password_hash": _hash_password(password, salt),
		"password_salt": salt,
		"profile": profile.duplicate(true),
		"economy": Economy.serialize(),
		"cards": CardCollection.serialize(),
		"defis": ChallengeTracker.serialize(),
		"prof_skins": ProfSkins.serialize(),
		"classroom_decor": ClassroomDecor.serialize(),
		"classroom_music": ClassroomMusic.serialize(),
		## Chantier "sauvegarde serveur" (2026-09-13, voir log_event()/_flush_pending_events() plus
		## bas) : "sync_jeton" est le jeton de session Supabase courant (vide tant qu'aucune synchro
		## n'a encore reussi, voir _ensure_server_session()) ; "sync_evenements" est la file locale
		## des evenements pas encore confirmes par le serveur (voir fn_pousser_evenements dans
		## schema.sql) - vide a la creation, se remplit au premier gain de pieces/carte/etc.
		"sync_jeton": "",
		"sync_evenements": [],
		## Chantier "connexion cross-device" (2026-09-13, voir update_current_profile() plus bas) :
		## le profil VIENT d'etre envoye tel quel a fn_creer_compte via _register_account_on_server()
		## juste en dessous - synchronise a cet instant, tant qu'aucune modification locale
		## ulterieure (update_current_profile()) ne le repasse a false.
		"profil_synchronise": true,
	}
	_accounts.append(account)
	current_account_id = account["id"]
	_apply_volume_from_profile(account["profile"])
	_apply_theme_from_profile(account["profile"])
	_save_to_disk()
	account_logged_in.emit(account["profile"])
	PseudoCache.remember(trimmed_login)
	## Enregistre le compte cote serveur DES MAINTENANT, sans attendre un premier evenement de
	## progression (2026-09-13, retour utilisateur : une maitresse qui cree des comptes en serie
	## pour toute sa classe ne va pas elle-meme "jouer" pour declencher la 1ere synchro - voir
	## _ensure_server_session()/log_event() plus bas, qui ne synchronisaient jusqu'ici qu'au premier
	## gain de piece/achat/etc. - un enfant doit pouvoir se connecter et retrouver son compte, meme
	## encore vide, depuis un AUTRE appareil des la creation). Fire-and-forget (voir
	## _register_account_on_server() plus bas) : jamais bloquant, la creation locale a deja reussi
	## juste au-dessus et l'ecran a deja bascule sur le jeu, meme hors-ligne.
	_register_account_on_server(_accounts.size() - 1)
	return ""

## Deconnecte le compte courant (sauvegarde d'abord sa progression) et remet Economy/
## CardCollection/ChallengeTracker a un etat neutre, pour que WelcomePanel ne montre
## jamais les donnees d'un compte a un autre pendant la transition. Pas encore appele depuis
## l'UI (aucun bouton "Se deconnecter" cree pour l'instant) - disponible pour plus tard.
func logout() -> void:
	if current_account_id.is_empty():
		return
	save_current_account()
	## Libere IMMEDIATEMENT la place cote serveur (2026-09-13, chantier "conflit de connexion") -
	## sans ca, une reconnexion sur CE MEME appareil resterait bloquee jusqu'a expiration naturelle
	## de la presence (90s, voir fn_login dans schema.sql) meme juste apres une deconnexion
	## volontaire. Fire-and-forget (voir _notify_server_logout() plus bas, meme principe que
	## _delete_account_on_server()) : la deconnexion locale n'attend jamais le reseau. Efface aussi
	## le jeton local tout de suite : il vient d'etre invalide cote serveur, plus la peine de le
	## garder en cache (le prochain login() en obtiendra un nouveau).
	var index := _current_account_index()
	if index != -1:
		var jeton := String(_accounts[index].get("sync_jeton", ""))
		if not jeton.is_empty():
			_notify_server_logout(jeton)
			_accounts[index]["sync_jeton"] = ""
	current_account_id = ""
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()
	ProfSkins.reset()
	ClassroomDecor.reset()
	ClassroomMusic.reset()
	_reset_volume_to_default()
	_reset_theme_to_default()
	account_logged_out.emit()

## Wrapper fire-and-forget autour de ServerApi.deconnecter() (meme raison que
## _register_account_on_server() plus bas : absorber la valeur de retour Dictionary proprement, pas
## de logique en plus ici - la deconnexion locale est deja actee par logout() avant meme cet appel).
func _notify_server_logout(jeton: String) -> void:
	await ServerApi.deconnecter(jeton)

func get_current_profile() -> Dictionary:
	var index := _current_account_index()
	if index == -1:
		return {}
	return _accounts[index].get("profile", {})

## Met a jour le profil (nom/prenom/classe/date de naissance/pays + controle parental/limite
## quotidienne, tout ce qui vit dans ce Dictionary - voir la future section "Informations
## personnelles" du menu) du compte connecte. Ne touche pas au mot de passe ni a la progression.
## Pousse desormais AUSSI vers le serveur (2026-09-13, chantier "connexion cross-device", voir
## project_save_sync_architecture.md en memoire projet - jusqu'ici, seul le profil de CREATION
## etait envoye, une modification ulterieure ne suivait jamais sur un autre appareil) : marque
## "profil_synchronise" a false avant la tentative (retente par le minuteur de secours, voir
## _setup_sync_retry_timer(), si hors-ligne au moment de l'appel), fire-and-forget (voir
## _push_profile_to_server() plus bas, jamais bloquant, meme philosophie que le reste de ce
## fichier).
func update_current_profile(profile: Dictionary) -> void:
	var index := _current_account_index()
	if index == -1:
		return
	_accounts[index]["profile"] = profile.duplicate(true)
	_accounts[index]["profil_synchronise"] = false
	_save_to_disk()
	_push_profile_to_server(index)

## Genere hash+sel pour un mot de passe de controle parental (2026-09-05, retour utilisateur :
## "dans la fenetre de creation du jeu lorsque l'on coche controle parental, il faut proposer de
## creer un mot de passe, le mot de passe doit etre ecrit 2 fois, pas de prerequis si ce n'est de
## mettre 4 caracteres minimum" - voir WelcomePanel._on_create_pressed(), qui reutilise
## MIN_PASSWORD_LENGTH pour cette meme regle). Meme algorithme que le mot de passe de connexion
## (_hash_password ci-dessus, sel independant), mais stocke dans le PROFIL du compte (cles
## "controle_parental_password_hash"/"controle_parental_password_salt"), pas au niveau du compte
## lui-meme - coherent avec "controle_parental" (bool), deja dans le profil (voir
## SectionProfile._on_save_pressed(), qui doit preserver ces 3 cles tant qu'il n'a pas ses propres
## champs). Le mot de passe en clair n'est jamais conserve au-dela de cet appel.
func hash_parental_control_password(password: String) -> Dictionary:
	var salt := _generate_random_hex(SALT_BYTE_LENGTH)
	return {
		"hash": _hash_password(password, salt),
		"salt": salt,
	}

## Verifie [password] contre le hash/sel stockes dans le profil du compte CONNECTE (voir
## hash_parental_control_password() ci-dessus) - utilise par SectionParentalControl pour
## reverrouiller ses options a chaque ouverture (meme retour utilisateur : "si on quitte la
## fenetre on relock le controle parental et tout retour a celui-ci via l'icone controle parental
## doit redemander le pass"). Renvoie toujours false si le compte connecte n'a defini aucun mot de
## passe de controle parental (cle absente/vide - voir SectionParentalControl.refresh(), qui
## traite ce cas comme "rien a proteger" plutot que comme un verrou impossible a lever).
func verify_parental_control_password(password: String) -> bool:
	var profile := get_current_profile()
	var expected_hash: String = profile.get("controle_parental_password_hash", "")
	if expected_hash.is_empty():
		return false
	var actual_hash := _hash_password(password, String(profile.get("controle_parental_password_salt", "")))
	return actual_hash == expected_hash

## Limite quotidienne de jeux (questionnaires) termines configuree pour le compte connecte (2026-
## 09-05, retour utilisateur : "je veux ajouter une limite d'utilisation par jour (se concretise
## par un nombre de jeu termine (questionnaire))") - 0 = aucune limite (valeur par defaut, premiere
## option de SectionParentalControl). Reellement applique depuis le 2026-09-06 (voir
## has_reached_daily_game_limit()/_on_pack_completed_for_daily_limit() plus bas - le decompte et le
## blocage n'existaient pas encore le 2026-09-05, seul ce reglage avait ete construit).
func get_daily_game_limit() -> int:
	return int(get_current_profile().get("daily_game_limit", 0))

## Definit la limite quotidienne pour le compte connecte - ne touche a AUCUNE autre cle du profil
## (nom/prenom/classe/controle_parental/etc.), contrairement a un remplacement direct de tout le
## Dictionary : on lit d'abord le profil existant, on n'y modifie que cette cle, meme prudence que
## SectionProfile._on_save_pressed() pour controle_parental (voir son commentaire).
func set_daily_game_limit(limit: int) -> void:
	var profile := get_current_profile()
	profile["daily_game_limit"] = limit
	update_current_profile(profile)

## --- Volume par compte (2026-09-05) ---
##
## music_volume/sfx_volume (variables plus haut) refletent toujours la valeur COURANTE, deja
## appliquee au bus audio - ces 2 fonctions ne font qu'y ajouter la persistance dans le profil du
## compte connecte, exactement comme set_daily_game_limit() ci-dessus. Pas d'effet si personne
## n'est connecte (update_current_profile() ne fait rien dans ce cas, voir sa garde) : SectionConfig
## (seul appelant) ne vit que dans le menu de jeu, jamais sur l'ecran d'accueil.
func _apply_volume_from_profile(profile: Dictionary) -> void:
	music_volume = float(profile.get("music_volume", DEFAULT_VOLUME))
	sfx_volume = float(profile.get("sfx_volume", DEFAULT_VOLUME))
	_set_bus_volume("Musique", music_volume)
	_set_bus_volume("Bruitages", sfx_volume)

## Remet le volume a 50/50 - appelee a la deconnexion (logout()/delete_current_account()) pour que
## l'ecran d'accueil ne conserve jamais le reglage du compte qui vient de le quitter.
func _reset_volume_to_default() -> void:
	music_volume = DEFAULT_VOLUME
	sfx_volume = DEFAULT_VOLUME
	_set_bus_volume("Musique", music_volume)
	_set_bus_volume("Bruitages", sfx_volume)

## --- Theme d'interface par compte (2026-09-06) ---
##
## Meme principe que _apply_volume_from_profile()/_reset_volume_to_default() ci-dessus : ui_theme
## reflete toujours la valeur COURANTE (celle de l'ecran d'accueil tant que personne n'est
## connecte, sinon celle du compte connecte), stockee dans profile["ui_theme"]. get() avec repli
## sur DEFAULT_UI_THEME et validation via THEMES.has() : protege contre une cle absente (compte
## cree avant ce changement, ou qui n'a jamais choisi de theme) ou invalide (theme renomme/retire
## plus tard) - evite un theme nul plutot qu'un crash dans ces deux cas.
func _apply_theme_from_profile(profile: Dictionary) -> void:
	var saved_theme: String = profile.get("ui_theme", DEFAULT_UI_THEME)
	ui_theme = saved_theme if THEMES.has(saved_theme) else DEFAULT_UI_THEME
	_apply_ui_theme()

## Remet le theme a "fete_foraine" - appelee a la deconnexion (logout()/delete_current_account())
## ET au tout premier demarrage (valeur par defaut de la variable ui_theme, jamais relue depuis le
## disque, voir _read_from_path()) pour que l'ecran d'accueil ne montre jamais le theme du dernier
## compte utilise (retour utilisateur : "pour l ecran dintro je veux que le theme de couleur soit
## fixe et ne varie pas de 'fete foraine'").
func _reset_theme_to_default() -> void:
	ui_theme = DEFAULT_UI_THEME
	_apply_ui_theme()

## --- Application de la limite quotidienne (2026-09-06) ---
##
## Retour utilisateur : "remise a zero a minuit, on applique cette mod maintenant, les enfants ne
## joueront sans doute pas la nuit" - reponse au choix laisse ouvert la veille (minuit vs 24h
## glissantes) plus demande explicite de construire enfin l'application du reglage ci-dessus
## (jusqu'ici seul le reglage existait, voir commentaire de get_daily_game_limit()).
##
## Stockage : cles "daily_game_count" (int) / "daily_game_count_date" (String "AAAA-MM-JJ")
## posees DIRECTEMENT sur le compte (comme "economy"/"cards"/"stats"), PAS dans "profile" (qui
## reste les donnees d'identite + le reglage choisi par le parent, daily_game_limit ci-dessus) :
## ce sont 2 valeurs d'ETAT qui changent a chaque pack termine, pas un reglage. Persistent
## automatiquement avec le reste du compte (_save_to_disk() serialise tout _accounts[] tel quel,
## voir son commentaire) - aucun serialize()/deserialize() dedie a ecrire.
##
## Remise a zero a minuit : PAS de Timer/minuterie, juste une comparaison de date a chaque lecture/
## ecriture (Time.get_date_string_from_system(), heure LOCALE de l'appareil, verifie sur
## docs.godotengine.org/en/stable - class_time) - des que daily_game_count_date differe
## d'aujourd'hui le compteur est traite comme 0, meme si le jeu etait ferme au moment ou minuit a
## sonne (rien ne depend d'un evenement declenche pile a minuit).
func _daily_game_count_for_today(index: int, today: String) -> int:
	var account := _accounts[index]
	if String(account.get("daily_game_count_date", "")) != today:
		return 0
	return int(account.get("daily_game_count", 0))

## Nombre de questionnaires deja termines aujourd'hui par le compte connecte (0 si personne n'est
## connecte, ou si la date enregistree n'est pas celle d'aujourd'hui).
func get_daily_game_count() -> int:
	var index := _current_account_index()
	if index == -1:
		return 0
	return _daily_game_count_for_today(index, Time.get_date_string_from_system())

## true si le compte connecte a atteint (ou depasse) sa limite quotidienne - toujours false si
## get_daily_game_limit() vaut 0 (pas de limite, valeur par defaut). Appelee par
## QuestionGiverComponent._on_interacted() AVANT meme de proposer le choix de matiere (voir son
## commentaire) : bloque le lancement d'un NOUVEAU questionnaire, une session deja en cours n'est
## elle jamais interrompue en plein milieu (le blocage n'agit qu'au moment ou le joueur relance un
## PNJ).
func has_reached_daily_game_limit() -> bool:
	var limit := get_daily_game_limit()
	if limit <= 0:
		return false
	return get_daily_game_count() >= limit

## Incremente le compteur du compte connecte d'un questionnaire termine - branchee sur
## EventBus.pack_completed (voir _ready() plus haut, meme signal ecoute par
## ChallengeTracker.register_success) plutot qu'appelee directement par
## QuestionGiverComponent.resolve_pack(), pour rester decouple comme le reste du projet (voir
## ARCHITECTURE.md). Ne persiste pas elle-meme sur disque : resolve_pack() appelle deja
## SaveManager.save_current_account() juste apres avoir emis ce signal (emission synchrone, cette
## fonction a donc deja tourne a ce moment-la), qui serialise tout le compte d'un coup - meme
## principe que ChallengeTracker, qui ne s'ecrit pas non plus lui-meme.
func _on_pack_completed_for_daily_limit(_subject: SubjectType.Subject, _rarity: CardRarity.Rarity, _correct_count: int, _total_count: int, _reward: int) -> void:
	var index := _current_account_index()
	if index == -1:
		return
	var today := Time.get_date_string_from_system()
	_accounts[index]["daily_game_count"] = _daily_game_count_for_today(index, today) + 1
	_accounts[index]["daily_game_count_date"] = today

## Sauvegarde la progression EN COURS (Economy/CardCollection/ChallengeTracker) dans le
## compte connecte. A appeler apres tout evenement qui doit survivre (achat, pack reussi...) - la
## sauvegarde automatique complete (evenement par evenement) reste a cabler dans ShopPanel/etc.
func save_current_account() -> void:
	var index := _current_account_index()
	if index == -1:
		return
	_accounts[index]["economy"] = Economy.serialize()
	_accounts[index]["cards"] = CardCollection.serialize()
	_accounts[index]["defis"] = ChallengeTracker.serialize()
	_accounts[index]["prof_skins"] = ProfSkins.serialize()
	_accounts[index]["classroom_decor"] = ClassroomDecor.serialize()
	_accounts[index]["classroom_music"] = ClassroomMusic.serialize()
	_save_to_disk()

## Recharge le compte connecte depuis le disque (annule les changements en memoire depuis la
## derniere sauvegarde) - utilise par le bouton "Charger" de SectionSave.
func reload_current_account() -> void:
	if current_account_id.is_empty():
		return
	var keep_id := current_account_id
	_read_from_disk()
	current_account_id = keep_id
	var index := _current_account_index()
	if index != -1:
		_apply_account_to_runtime(_accounts[index])

## Remet a zero la progression (pieces, cartes, stats) du compte connecte -
## garde le profil (nom/prenom/classe/date de naissance/pays) intact. Deja protegee par le
## portail parental (code a 8 caracteres, ParentalGateOverlay) - voir GameMenuPanel.
## _request_gate()/_on_reset_requested(), qui n'appelle cette fonction qu'apres validation du
## code. Commentaire corrige le 2026-09-05 (il disait a tort "pas encore cable" - le cablage
## existait deja via SectionSave/GameMenuPanel, verifie en lisant le vrai chemin d'appel).
func reset_current_account_progress() -> void:
	if current_account_id.is_empty():
		return
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()
	ProfSkins.reset()
	ClassroomDecor.reset()
	ClassroomMusic.reset()
	save_current_account()

## Supprime entierement le compte connecte (profil + progression) et deconnecte - renvoie a
## WelcomePanel pour recreer un compte depuis zero. Deja protegee par le meme portail parental que
## reset_current_account_progress() (voir GameMenuPanel._on_delete_account_requested()) - meme
## correction de commentaire perime que ci-dessus, le 2026-09-05.
func delete_current_account() -> void:
	var index := _current_account_index()
	if index == -1:
		return
	## Instantane des identifiants AVANT de retirer le compte localement (necessaire pour tenter une
	## suppression cote serveur juste apres, voir _delete_account_on_server() plus bas - le compte
	## n'existera plus dans _accounts une fois cette fonction terminee).
	var login_snapshot := String(_accounts[index].get("login", ""))
	var mdp_hash_snapshot := String(_accounts[index].get("password_hash", ""))
	var jeton_snapshot := String(_accounts[index].get("sync_jeton", ""))
	## Oublie ce pseudo du cache local AVANT de retirer le compte (2026-09-13, retour utilisateur :
	## un pseudo supprime restait propose par l'autocompletion de WelcomePanel, mais toute tentative
	## de connexion avec echouait ensuite avec "Pseudo ou mot de passe incorrect", puisque le compte
	## n'existe plus) - voir PseudoCache.forget().
	PseudoCache.forget(login_snapshot)
	_accounts.remove_at(index)
	current_account_id = ""
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()
	ProfSkins.reset()
	ClassroomDecor.reset()
	ClassroomMusic.reset()
	_reset_volume_to_default()
	_reset_theme_to_default()
	_save_to_disk()
	account_logged_out.emit()
	## Suppression cote serveur en tache de fond, best-effort (2026-09-13, retour utilisateur "la
	## suppression se fait correctement en local mais pas sur le serveur Supabase" - AUCUNE fonction
	## serveur n'existait pour ca, voir fn_supprimer_compte dans schema.sql). Volontairement PAS
	## awaited ici (meme principe que log_event()/_flush_pending_events()) : le compte est deja
	## supprime localement et l'ecran est deja revenu a WelcomePanel, la suppression serveur ne doit
	## jamais faire attendre le joueur. CHOIX UTILISATEUR (2026-09-13) : pas de file de retry
	## persistee si ca echoue (hors-ligne pile a cet instant) - la suppression passe deja par le
	## portail parental et se fait normalement en jouant en ligne, un compte orphelin cote serveur
	## dans ce cas rare est assume comme limite connue plutot que de complexifier le code pour un
	## cas jugee marginal.
	if not login_snapshot.is_empty() and not mdp_hash_snapshot.is_empty():
		_delete_account_on_server(login_snapshot, mdp_hash_snapshot, jeton_snapshot)

## Tente de supprimer [login_snapshot] cote serveur - obtient un jeton de session si besoin, meme
## logique que _ensure_server_session() mais sans dependre d'un index dans _accounts (le compte a
## deja ete retire localement quand cette fonction s'execute, voir delete_current_account()).
## Ne cree JAMAIS de compte manquant a la difference de _ensure_server_session() : un compte qui
## n'existait pas encore cote serveur n'a par definition rien a y supprimer.
func _delete_account_on_server(login_snapshot: String, mdp_hash_snapshot: String, jeton_snapshot: String) -> void:
	var jeton := jeton_snapshot
	if jeton.is_empty():
		var login_result := await ServerApi.login(login_snapshot, mdp_hash_snapshot)
		if not login_result.get("ok", false):
			return # hors-ligne, VPS injoignable, ou compte jamais synchronise (rien a supprimer alors)
		var data: Dictionary = login_result.get("data", {})
		jeton = String(data.get("jeton", ""))
	await ServerApi.supprimer_compte(jeton)

func _current_account_index() -> int:
	for i in _accounts.size():
		if String(_accounts[i].get("id", "")) == current_account_id:
			return i
	return -1

func _apply_account_to_runtime(account: Dictionary) -> void:
	Economy.deserialize(account.get("economy", {}))
	CardCollection.deserialize(account.get("cards", {}))
	ChallengeTracker.deserialize(account.get("defis", {}))
	ProfSkins.deserialize(account.get("prof_skins", {}))
	ClassroomDecor.deserialize(account.get("classroom_decor", {}))
	ClassroomMusic.deserialize(account.get("classroom_music", {}))

## --- Synchronisation serveur (2026-09-13) ---
##
## Journal d'evenements idempotent (voir server/schema.sql et project_save_sync_architecture.md en
## memoire projet) : chaque mutation de progression (gain/depense de pieces, carte debloquee, Defi
## reussi, achat/reequipement de skin de prof, deblocage/activation d'un decor ou d'une musique de
## classe) est journalisee ICI via log_event(), appelee par les points d'appel existants juste apres
## chaque mutation (voir question_giver_component.gd/question_panel.gd/shop_panel.gd) - PAS ecoutee
## via un signal (EventBus ou autre) : certains signaux d'autoload (ex. ProfSkins.skin_activated)
## sont aussi emis au CHARGEMENT d'un compte (_apply_account_to_runtime -> deserialize) pour
## rafraichir l'affichage, ce qui creerait de faux evenements a chaque connexion si on les ecoutait
## ici - l'appel explicite au point d'action reste la seule source fiable de "ceci vient vraiment de
## se produire maintenant".
##
## JAMAIS BLOQUANT (voir ServerApi, meme principe) : aucune fonction de cette section ne fait
## planter/attendre l'appelant en cas de probleme reseau - le jeu reste 100% jouable hors-ligne, les
## evenements non confirmes restent simplement dans la file locale (persistee sur disque comme le
## reste du compte, voir "sync_evenements" dans create_account()) jusqu'a la prochaine tentative
## reussie (prochain evenement, prochaine connexion, ou le minuteur de _setup_sync_retry_timer()).

## Cree un minuteur qui retente periodiquement d'envoyer la file d'evenements en attente (voir le
## commentaire de SYNC_RETRY_INTERVAL_SECONDS) - filet de secours pour le cas ou le reseau revient
## sans qu'aucun nouvel evenement/connexion ne se produise entre-temps. _flush_pending_events()
## ressort immediatement si la file est vide (cas normal la plupart du temps), ce minuteur ne coute
## donc quasiment rien quand tout est deja synchronise.
##
## Sert AUSSI (2026-09-13, voir _on_sync_retry_timeout() juste en dessous) de battement de coeur de
## presence et de filet de secours pour un profil pas encore synchronise - un seul minuteur partage
## pour les 3 roles plutot que 3 Timer separes, meme principe d'autoload mince que le reste de ce
## fichier.
func _setup_sync_retry_timer() -> void:
	var timer := Timer.new()
	timer.wait_time = SYNC_RETRY_INTERVAL_SECONDS
	timer.autostart = true
	timer.timeout.connect(_on_sync_retry_timeout)
	add_child(timer)

func _on_sync_retry_timeout() -> void:
	_flush_pending_events()
	_send_session_heartbeat()
	_retry_profile_sync_if_needed()

## "Battement de coeur" de presence (2026-09-13, chantier "conflit de connexion", voir fn_login/
## fn_pulse_session dans schema.sql) - sans effet si personne n'est connecte, hors-ligne, ou si
## aucun jeton n'est encore disponible localement (ne FORCE jamais l'obtention d'un jeton ici, voir
## _ensure_server_session() pour ca - un pulse ne fait que rafraichir une session qui existe deja).
func _send_session_heartbeat() -> void:
	var index := _current_account_index()
	if index == -1:
		return
	var jeton := String(_accounts[index].get("sync_jeton", ""))
	if jeton.is_empty():
		return
	await ServerApi.pulse_session(jeton)

## Filet de secours pour update_current_profile() (2026-09-13, meme chantier que ci-dessus) : si le
## profil du compte connecte n'a pas pu etre pousse au moment de sa modification (hors-ligne a cet
## instant), ce minuteur retente ici - meme role que _flush_pending_events() pour les evenements de
## progression, en plus simple (pas de file, juste un booleen : la derniere valeur du profil "gagne"
## de toute facon, pas besoin de rejouer un historique).
func _retry_profile_sync_if_needed() -> void:
	var index := _current_account_index()
	if index == -1:
		return
	if _accounts[index].get("profil_synchronise", true):
		return
	_push_profile_to_server(index)

## Pousse le profil de _accounts[index] vers le serveur (voir update_current_profile()/
## _retry_profile_sync_if_needed() ci-dessus) - obtient d'abord un jeton si besoin (voir
## _ensure_server_session()), jamais bloquant/sans erreur Godot en cas de souci reseau (meme
## principe que le reste de cette section). Relit l'index via _current_account_index() + comparaison
## d'id APRES chaque attente reseau (meme prudence/idiome que _do_flush() plus haut) : le compte
## connecte a pu changer entre-temps.
func _push_profile_to_server(index: int) -> void:
	var account_id := String(_accounts[index].get("id", ""))
	if not await _ensure_server_session(index):
		return # hors-ligne ou VPS injoignable - _retry_profile_sync_if_needed() retentera plus tard

	var index_now := _current_account_index()
	if index_now == -1 or String(_accounts[index_now].get("id", "")) != account_id:
		return # le compte connecte a change pendant l'attente reseau ci-dessus
	var jeton := String(_accounts[index_now].get("sync_jeton", ""))
	if jeton.is_empty():
		return
	var profile_snapshot: Dictionary = _accounts[index_now].get("profile", {})
	var result := await ServerApi.maj_profil(jeton, profile_snapshot)
	if not result.get("ok", false):
		return # retente au prochain passage du minuteur (voir _retry_profile_sync_if_needed())

	index_now = _current_account_index()
	if index_now == -1 or String(_accounts[index_now].get("id", "")) != account_id:
		return # idem, verifie une 2e fois : cette attente reseau a pu, elle aussi, chevaucher un changement de compte
	## Ne marque "synchronise" que si le profil local n'a PAS change pendant cet appel reseau (sinon
	## la modification la plus recente, pas encore envoyee, se retrouverait marquee a tort comme a
	## jour) - comparaison par egalite de contenu plutot que par un simple flag, pour rester correct
	## meme si update_current_profile() a ete appelee (et a donc remis "profil_synchronise" a false)
	## PENDANT que cette requete etait en vol.
	if _accounts[index_now].get("profile", {}) == profile_snapshot:
		_accounts[index_now]["profil_synchronise"] = true
		_save_to_disk()

## Ajoute un evenement a la file d'attente du compte CONNECTE et tente aussitot un envoi en
## arriere-plan (voir _flush_pending_events()) - ne fait rien si personne n'est connecte, meme garde
## que save_current_account(). [event_type] doit etre une des valeurs de l'enum type_evenement de
## schema.sql (ex. "gain_piece"), [payload] son contenu associe (voir l'en-tete de
## fn_pousser_evenements dans schema.sql pour le detail attendu par type). Persiste tout de suite
## sur disque (comme save_current_account()) : un evenement ne doit jamais pouvoir se perdre entre
## le moment ou il est journalise ici et la prochaine sauvegarde "normale" faite par l'appelant,
## meme si en pratique tous les points d'appel actuels sauvegardent deja juste apres.
func log_event(event_type: String, payload: Dictionary) -> void:
	var index := _current_account_index()
	if index == -1:
		return
	var event := {
		"id": _generate_random_hex(EVENT_ID_BYTE_LENGTH),
		"type": event_type,
		"payload": payload,
		"horodatage_client": Time.get_datetime_string_from_system(true) + "Z",
	}
	var pending: Array = _accounts[index].get("sync_evenements", [])
	pending.append(event)
	_accounts[index]["sync_evenements"] = pending
	_save_to_disk()
	_flush_pending_events()

## true pendant qu'une synchro (fn_pousser_evenements) est deja en vol pour ce compte_id (cle) -
## evite d'en lancer une deuxieme en parallele pour le MEME compte (deux lots concurrents pourraient
## sinon se marcher dessus sur la meme file locale, l'un retirant des evenements pendant que l'autre
## les relit encore). Pas de probleme en revanche si deux comptes DIFFERENTS synchronisaient en
## meme temps (n'arrive de toute facon jamais dans ce jeu, un seul compte connecte a la fois) -
## Dictionary plutot qu'un simple bool pour rester correct si ce jour arrivait.
var _sync_en_cours: Dictionary = {}

## Point d'entree "tenter une synchro maintenant" - appele par log_event()/login() a chaque action
## pertinente, et par le minuteur de secours (_setup_sync_retry_timer()). Toujours sans risque a
## appeler "pour rien" (ressort immediatement si rien n'attend d'etre envoye, ou si une synchro pour
## ce compte est deja en cours) : c'est ce qui permet a tous ces points d'appel differents de
## coexister sans logique de coordination entre eux.
func _flush_pending_events() -> void:
	var index := _current_account_index()
	if index == -1:
		return
	var account_id := current_account_id
	var pending: Array = _accounts[index].get("sync_evenements", [])
	if pending.is_empty():
		return
	if _sync_en_cours.get(account_id, false):
		return
	_sync_en_cours[account_id] = true
	await _do_flush(index, account_id, pending)
	_sync_en_cours.erase(account_id)

## Coeur de la synchro : s'assure d'une session serveur valide (voir _ensure_server_session()) puis
## pousse [sent_events] (l'instantane de la file au moment ou _flush_pending_events() a demarre).
## Relit l'index/la file APRES chaque attente reseau plutot que de garder les references initiales :
## le joueur a pu se deconnecter, changer de compte, ou journaliser de nouveaux evenements pendant
## que cette fonction etait suspendue en attente d'une reponse HTTP (voir les gardes
## "String(...) != account_id" ci-dessous).
func _do_flush(index: int, account_id: String, sent_events: Array) -> void:
	if not await _ensure_server_session(index):
		return # hors-ligne ou VPS injoignable - _flush_pending_events() retentera plus tard
	var index_now := _current_account_index()
	if index_now == -1 or String(_accounts[index_now].get("id", "")) != account_id:
		return # le compte connecte a change pendant l'attente reseau ci-dessus
	var jeton: String = _accounts[index_now].get("sync_jeton", "")
	var result := await ServerApi.pousser_evenements(jeton, sent_events)

	index_now = _current_account_index()
	if index_now == -1 or String(_accounts[index_now].get("id", "")) != account_id:
		return # idem, verifie une 2e fois : cette attente reseau a pu, elle aussi, chevaucher un changement de compte

	if not result.get("ok", false):
		## "session_expiree" : le jeton est perime (>48h, voir fn_login dans schema.sql) - on l'efface
		## pour qu'_ensure_server_session() en redemande un neuf au prochain essai. Toute autre erreur
		## (reseau, ou refus serveur inattendu) : on ne touche a rien, la file entiere reste en
		## attente pour le prochain essai (le minuteur de secours s'en chargera).
		if result.get("type", "") == "serveur" and result.get("message", "") == "session_expiree":
			_accounts[index_now]["sync_jeton"] = ""
		return

	## Le serveur a traite tout le lot envoye (accepte comme nouveau OU deja vu, voir le commentaire
	## de fn_pousser_evenements dans schema.sql - "ids_appliques" ne liste que les evenements
	## REELLEMENT nouveaux, mais un evenement "deja vu" ne doit de toute facon plus jamais etre
	## repousse) : on retire de la file COURANTE tout evenement dont l'id figurait dans [sent_events],
	## plutot que de filtrer sur "ids_appliques" - la file courante peut contenir des evenements plus
	## recents journalises PENDANT cette requete (voir log_event()), qui doivent rester.
	var sent_ids := {}
	for evt in sent_events:
		sent_ids[evt["id"]] = true
	var still_pending: Array = []
	for evt in (_accounts[index_now].get("sync_evenements", []) as Array):
		if not sent_ids.has(evt["id"]):
			still_pending.append(evt)
	_accounts[index_now]["sync_evenements"] = still_pending
	_save_to_disk()

## Wrapper fire-and-forget autour de _ensure_server_session() (2026-09-13, voir le commentaire au
## point d'appel dans create_account()) - une fonction async appelee SANS await depuis un contexte
## synchrone tourne deja en tache de fond en GDScript (meme principe que _flush_pending_events()
## appelee sans await par log_event(), ou _delete_account_on_server() par delete_current_account()),
## mais _ensure_server_session() renvoie un bool : l'appeler telle quelle comme instruction autonome
## depuis create_account() (qui n'a besoin d'aucun resultat ici) declenche un avertissement GDScript
## "valeur de retour ignoree" - ce petit wrapper qui ne renvoie rien evite juste ca proprement.
func _register_account_on_server(index: int) -> void:
	await _ensure_server_session(index)

## S'assure que _accounts[index]["sync_jeton"] contient un jeton de session valide, en obtenant un
## nouveau si necessaire (jeton absent ou efface suite a "session_expiree", voir _do_flush()).
## Renvoie false SANS lever d'erreur en cas de probleme reseau (voir le commentaire de section) -
## l'appelant retentera plus tard. Enregistre RETROACTIVEMENT le compte cote serveur si besoin (voir
## le bloc "identifiants_invalides" ci-dessous) : un compte cree AVANT ce chantier, ou jamais
## synchronise faute de reseau jusqu'ici, n'existe pas encore dans la table `comptes` - fn_creer_
## compte est idempotent sur l'id (voir schema.sql) donc rejouer cet appel plus tard, si jamais il
## avait deja reussi sans que ce client l'ait su, ne cree jamais de doublon.
func _ensure_server_session(index: int) -> bool:
	if not String(_accounts[index].get("sync_jeton", "")).is_empty():
		return true

	var account_id := String(_accounts[index].get("id", ""))
	var login_name := String(_accounts[index].get("login", ""))
	var mdp_hash := String(_accounts[index].get("password_hash", ""))
	var mdp_sel := String(_accounts[index].get("password_salt", ""))
	## Capture avant tout await, comme les 4 lignes ci-dessus : _accounts peut changer pendant
	## l'attente reseau (voir la relecture par id plus bas dans cette fonction).
	var profile_snapshot: Dictionary = _accounts[index].get("profile", {})

	var login_result := await ServerApi.login(login_name, mdp_hash)
	if not login_result.get("ok", false):
		## "compte_deja_connecte" (2026-09-13, chantier "conflit de connexion") : un AUTRE appareil
		## joue deja sur ce compte en ce moment - on ne tente evidemment pas de le "re-creer" dans ce
		## cas (il existe deja), et on n'interrompt PAS non plus la partie en cours sur CET appareil
		## (elle a deja ete autorisee a demarrer par login(), voir son commentaire) : juste un echec
		## de synchro comme un autre, retente au prochain _flush_pending_events()/battement de coeur -
		## meme branche que "hors-ligne, ou refus serveur inattendu" ci-dessous, sans traitement
		## special, LIMITE CONNUE ET ASSUMEE (voir project_save_sync_architecture.md en memoire
		## projet).
		if login_result.get("type", "") != "serveur" or login_result.get("message", "") != "identifiants_invalides":
			return false # hors-ligne, ou refus serveur inattendu - on ne tente pas de creer/recreer dans ce cas
		## BUG CORRIGE le 2026-09-13 (chantier "connexion cross-device") : le profil n'etait jusqu'ici
		## JAMAIS transmis a la creation retroactive du compte (p_profil manquant dans cet appel,
		## repli silencieux sur le "{}" par defaut de ServerApi.creer_compte()) - `comptes.profil`
		## restait donc TOUJOURS vide cote serveur, meme pour un compte cree avec un profil complet
		## (nom/prenom/classe/controle parental...). Invisible jusqu'ici car rien ne relisait encore
		## ce profil (voir fn_login/_login_from_server, memes chantier/date).
		var create_result := await ServerApi.creer_compte(
			account_id, login_name, mdp_hash, mdp_sel, profile_snapshot
		)
		if not create_result.get("ok", false):
			return false
		login_result = await ServerApi.login(login_name, mdp_hash)
		if not login_result.get("ok", false):
			return false

	var index_now := _current_account_index()
	if index_now == -1 or String(_accounts[index_now].get("id", "")) != account_id:
		return true # le compte a change pendant l'attente reseau - la connexion a quand meme reussi, juste inutile a stocker ici
	var data: Dictionary = login_result.get("data", {})
	_accounts[index_now]["sync_jeton"] = String(data.get("jeton", ""))
	return true

## --- Persistance disque ---

## Ecriture atomique (2026-09-05, avant la mise en ligne du jeu - voir project_save_sync_
## architecture.md en memoire projet) : on ecrit d'abord dans un fichier temporaire, PUIS on
## bascule sur le fichier final en un seul renommage. Avant, ce code ouvrait savegame.json
## directement en FileAccess.WRITE (qui le vide immediatement) et y ecrivait au fil de l'eau - un
## crash/fermeture brutale en plein milieu laissait un JSON tronque, et TOUS les comptes de
## l'appareil partageant ce seul fichier auraient ete perdus d'un coup. Avec un renommage, un
## crash pile a ce moment-la laisse soit l'ancien fichier intact, soit le nouveau complet, jamais
## un etat intermediaire.
##
## Copie de secours (.bak) conservee en plus, ecrasee a chaque sauvegarde reussie : sert de filet
## si le fichier principal est un jour illisible malgre tout (voir _read_from_path() plus bas, qui
## retente automatiquement sur ce .bak avant de considerer qu'il n'y a "aucune sauvegarde").
##
## DirAccess.rename_absolute()/copy_absolute() overwrite deja leur destination si elle existe
## (confirme sur docs.godotengine.org/en/stable - class_diraccess), pas besoin de la supprimer a
## la main avant. `file = null` explicite apres close() avant de renommer : voir
## godotengine/godot#73311, un ancien bug ou le ramasse-miettes n'avait pas encore libere le
## descripteur au bon moment - corrige depuis mais autant rester defensif.
func _save_to_disk() -> void:
	var data := {
		"version": SAVE_FORMAT_VERSION,
		## music_volume/sfx_volume/ui_theme ne sont PLUS ecrits ici (music_volume/sfx_volume depuis
		## le 2026-09-05, ui_theme depuis le 2026-09-06) : ce sont desormais des reglages PAR COMPTE
		## (voir profile["music_volume"]/["sfx_volume"]/["ui_theme"] et
		## _apply_volume_from_profile()/_apply_theme_from_profile() plus bas), pas un reglage
		## unique de l'appareil comme fullscreen.
		"device_settings": {
			"fullscreen": fullscreen,
		},
		"accounts": _accounts,
	}

	var tmp_path := SAVE_PATH + ".tmp"
	var file := FileAccess.open(tmp_path, FileAccess.WRITE)
	if file == null:
		push_error("SaveManager: impossible d'ecrire %s (erreur %s)" % [tmp_path, FileAccess.get_open_error()])
		return
	file.store_string(JSON.stringify(data))
	file.flush()
	file.close()
	file = null

	if FileAccess.file_exists(SAVE_PATH):
		var copy_err := DirAccess.copy_absolute(SAVE_PATH, SAVE_PATH + ".bak")
		if copy_err != OK:
			push_error("SaveManager: impossible de mettre a jour %s.bak (erreur %s)" % [SAVE_PATH, copy_err])

	var rename_err := DirAccess.rename_absolute(tmp_path, SAVE_PATH)
	if rename_err != OK:
		push_error("SaveManager: impossible de finaliser l'ecriture de %s (erreur %s)" % [SAVE_PATH, rename_err])

## Lit device_settings + accounts depuis [path] et les applique a l'etat courant. Renvoie true si
## [path] contenait un JSON exploitable, false sinon (fichier absent, illisible, ou pas un
## Dictionary) - permet a _read_from_disk() de retenter sur le .bak sans dupliquer toute la
## logique de parsing.
func _read_from_path(path: String) -> bool:
	if not FileAccess.file_exists(path):
		return false
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return false
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return false
	var data: Dictionary = parsed
	## SAVE_FORMAT_VERSION est ecrit a chaque sauvegarde (voir _save_to_disk()) mais pas encore lu
	## ici : aucune migration de structure n'est necessaire a ce jour (voir sa definition plus
	## haut). Pas de variable locale inutilisee en attendant - le jour ou une vraie migration est
	## necessaire, lire data.get("version", 0) ici et brancher la logique avant d'appliquer
	## settings/accounts ci-dessous.
	var settings: Dictionary = data.get("device_settings", {})
	## "master_volume" (ancienne cle, volume general unique), "music_volume"/"sfx_volume" (cles
	## utilisees ici du 2026-09-04 au 2026-09-05) ET "ui_theme" (cle utilisee ici jusqu'au
	## 2026-09-06, avant que volume ET theme deviennent des reglages PAR COMPTE, voir plus haut)
	## ignorees si presentes dans une sauvegarde anterieure - meme principe que "custom_bindings"
	## plus haut : simplement pas relues, sans migration necessaire. ui_theme (variable membre)
	## reste donc a DEFAULT_UI_THEME tant que personne ne s'est connecte - _apply_theme_from_
	## profile() le remplace au login (voir login()/create_account()).
	fullscreen = bool(settings.get("fullscreen", false))
	var loaded_accounts: Array = data.get("accounts", [])
	_accounts.clear()
	for entry in loaded_accounts:
		if typeof(entry) == TYPE_DICTIONARY:
			_accounts.append(entry)
	return true

## Sans toucher a current_account_id (voir _ready() et reload_current_account(), qui gerent
## chacun cette variable differemment apres l'appel) : tente le fichier principal, puis le .bak
## en secours si le principal est absent/illisible (voir _save_to_disk()) - ne traite "aucun des
## deux fichiers exploitable" comme un vrai "aucune sauvegarde" qu'en tout dernier recours, pour
## qu'une ecriture corrompue ne se traduise jamais par une progression qui semble avoir disparu.
func _read_from_disk() -> void:
	if _read_from_path(SAVE_PATH):
		return
	if _read_from_path(SAVE_PATH + ".bak"):
		push_warning("SaveManager: %s illisible ou absent, sauvegarde restauree depuis %s.bak" % [SAVE_PATH, SAVE_PATH])
		_save_to_disk() # reecrit tout de suite un fichier principal sain a partir du secours

## Applique volume/plein ecran/theme d'interface a l'etat reel du moteur. Appelee une seule fois
## au demarrage (_ready(), avant toute connexion) : music_volume/sfx_volume valent encore
## DEFAULT_VOLUME a ce moment (voir leur declaration plus haut), donc l'ecran d'accueil demarre
## bien a 50/50 - login()/create_account() les remplacent ensuite par le reglage du compte via
## _apply_volume_from_profile().
func _apply_settings() -> void:
	_set_bus_volume("Musique", music_volume)
	_set_bus_volume("Bruitages", sfx_volume)
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	_apply_ui_theme()

## Petit utilitaire partage par _apply_settings()/preview_music_volume()/preview_sfx_volume()/
## _apply_volume_from_profile()/_reset_volume_to_default() - un volume a 0 est mis a -80 dB (silence
## effectif) plutot que de passer par linear_to_db(0.0), qui vaudrait -INF.
func _set_bus_volume(bus_name: String, value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name),
		linear_to_db(value) if value > 0.0 else -80.0)

## Diffuse le theme d'interface courant via EventBus (voir EventBus.ui_theme_changed pour le
## detail : get_tree().root.theme ne suffit pas ici a cause du CanvasLayer "UI" de park.tscn, qui
## coupe la propagation automatique). N'a d'effet que sur les panneaux deja dans l'arbre - chaque
## panneau applique aussi ce theme lui-meme a son _ready() pour le cas ou il n'existe pas encore
## au moment de cet appel (ex: tout premier chargement, avant que park.tscn soit pret).
func _apply_ui_theme() -> void:
	EventBus.ui_theme_changed.emit(THEMES.get(ui_theme, THEMES[DEFAULT_UI_THEME]))

## Change le theme d'interface du compte connecte, l'applique immediatement et persiste dans son
## profil (2026-09-06 : plus un reglage d'appareil, voir le commentaire de classe et
## _apply_theme_from_profile()/_reset_theme_to_default() plus haut) - meme mecanique que
## set_music_volume/set_sfx_volume : sans effet si personne n'est connecte (update_current_
## profile() ne fait rien dans ce cas), SectionConfig (seul appelant) ne vivant que dans le menu de
## jeu. [id] doit etre une des cles de THEMES (voir section_config.gd, qui construit ses vignettes
## a partir de THEMES.keys() plutot que de les coder en dur, pour rester coherent si un theme est
## ajoute/retire plus tard).
func set_ui_theme(id: String) -> void:
	if not THEMES.has(id):
		return
	ui_theme = id
	_apply_ui_theme()
	var profile := get_current_profile()
	profile["ui_theme"] = ui_theme
	update_current_profile(profile)

## Change un volume immediatement (retour sonore instantane) SANS ecrire sur le disque -
## utilise pendant qu'on fait glisser le curseur (voir SectionConfig). set_music_volume/
## set_sfx_volume (avec sauvegarde) sont appeles une seule fois au relachement du curseur.
func preview_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	_set_bus_volume("Musique", music_volume)

## Persiste dans le profil du compte CONNECTE (voir _apply_volume_from_profile() plus haut), pas
## dans device_settings - remplace un _save_to_disk() global depuis le 2026-09-05, le volume
## n'etant plus un reglage unique de l'appareil.
func set_music_volume(value: float) -> void:
	preview_music_volume(value)
	var profile := get_current_profile()
	profile["music_volume"] = music_volume
	update_current_profile(profile)

func preview_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)
	_set_bus_volume("Bruitages", sfx_volume)

func set_sfx_volume(value: float) -> void:
	preview_sfx_volume(value)
	var profile := get_current_profile()
	profile["sfx_volume"] = sfx_volume
	update_current_profile(profile)

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	_save_to_disk()

