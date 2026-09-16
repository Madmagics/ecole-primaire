## Client HTTP vers les fonctions RPC Supabase (voir server/schema.sql pour le detail des 11
## fonctions fn_obtenir_sel/fn_creer_compte/fn_login/fn_pousser_evenements/fn_recuperer_progression/
## fn_supprimer_compte/fn_maj_profil/fn_pulse_session/fn_deconnecter/fn_creer_compte_public/
## fn_renvoyer_verification, toutes exposees automatiquement par PostgREST comme endpoints POST
## /rest/v1/rpc/<nom_fonction> - fn_verifier_email et fn_verifier_turnstile_creer_code (2026-09-15)
## NE SONT PAS ici : appelees directement en JS depuis les pages statiques web/verifier-email.html
## et web/captcha.html, jamais depuis ce client Godot. Idem pour fn_reinitialiser_mdp (2026-09-16,
## appelee depuis web/reinitialiser-mdp.html) - seule fn_demander_reinitialisation_mdp (declenchee
## DEPUIS le jeu, voir "Mot de passe oublié" dans WelcomePanel) a besoin d'un wrapper ici.
##
## fn_changer_login/fn_changer_email/fn_changer_mot_de_passe/fn_statut_email (2026-09-16, voir
## TODO_UI_MODS.md mods 6/7 et le bug de blocage email) ajoutees a cette meme liste de fonctions
## RPC, memes conventions (authentifiees par jeton comme fn_maj_profil).
## Autoload volontairement mince (meme principe qu'Economy/CardCollection : pas de logique metier
## lourde) : encapsule uniquement le TRANSPORT (HTTPRequest, en-tetes, parsing JSON, distinction
## erreur reseau / erreur serveur) - aucune logique de sauvegarde/file d'evenements ici, ca reste le
## role de SaveManager (chantier suivant, pas encore ecrit au moment de ce fichier, 2026-09-13).
##
## JAMAIS BLOQUANT : chaque fonction est `async` (a appeler avec `await`) et renvoie TOUJOURS un
## Dictionary {"ok": bool, ...} plutot que de lever une erreur Godot - le jeu doit rester 100%
## jouable hors-ligne (voir project_save_sync_architecture.md), donc un appelant qui n'a pas de
## reseau/dont le VPS est injoignable recoit juste {"ok": false, "type": "reseau", ...} et peut
## continuer a fonctionner en local, jamais un crash ni un blocage. Se distingue de
## {"ok": false, "type": "serveur", ...} : le VPS A repondu mais a refuse la demande (ex.
## "identifiants_invalides", "pseudo_indisponible", "session_expiree") - ce sont exactement les
## messages des `raise exception` de schema.sql, PostgREST les renvoie tels quels dans le champ
## "message" d'une reponse HTTP 400, remonte ici sans transformation pour que l'appelant puisse
## les comparer a une chaine connue plutot qu'a un code HTTP generique.
##
## Une instance HTTPRequest est creee puis liberee A LA VOLEE pour chaque appel plutot qu'un noeud
## unique partage : HTTPRequest ne traite qu'une requete a la fois, un noeud partage bloquerait un
## 2e appel lance pendant qu'un 1er est encore en vol (ex. une pousee d'evenements en cours pendant
## qu'une autre scene tente une recuperation de progression) - cout negligeable vu la frequence
## d'appel prevue (pas un flux temps reel).
extends Node

## Cle publique "anon" Supabase - PAS un secret (concue pour etre embarquee dans un client, voir
## Project Settings > API dans Supabase Studio, "API URL"/"anon key" recuperees le 2026-09-13) :
## uniquement une porte d'entree vers PostgREST, tout le vrai controle d'acces se fait dans les
## fonctions SECURITY DEFINER elles-memes (RLS fermee sans la moindre policy sur les 4 tables, voir
## schema.sql) - a l'inverse de la "service_role key" (jamais a mettre ici, elle contourne RLS).
const ANON_KEY := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InN1cGFiYXNlIiwiaWF0IjoxNzg5MjMyOTUyLCJleHAiOjE5NDY5MTI5NTJ9.U5jI5pXgwMonbnpiOvlHKtxUShJ8jLWtgdMHwkecoXQ"
const BASE_URL := "https://api.ecole-primaire.eu/rest/v1/rpc/"

## Delai avant d'abandonner un appel (secondes) - evite qu'un joueur reste bloque tres longtemps si
## le VPS est injoignable (un pare-feu peut laisser une connexion "pendre" plutot que la refuser
## immediatement, contrairement a un simple refus de port).
const TIMEOUT_SECONDS := 8.0

## Recupere le sel du compte [p_login] (etape prealable a login(), voir commentaire de
## fn_obtenir_sel dans schema.sql) - data (si ok) : String.
func obtenir_sel(p_login: String) -> Dictionary:
	return await _call_rpc("fn_obtenir_sel", {"p_login": p_login})

## Cree un compte - data (si ok) : {"id": String, "login": String} (le login peut differer de
## [p_login] si le serveur a du ajouter un suffixe pour cause de doublon, voir fn_creer_compte).
func creer_compte(p_id: String, p_login: String, p_mdp_hash: String, p_mdp_sel: String, p_profil: Dictionary = {}) -> Dictionary:
	return await _call_rpc("fn_creer_compte", {
		"p_id": p_id,
		"p_login": p_login,
		"p_mdp_hash": p_mdp_hash,
		"p_mdp_sel": p_mdp_sel,
		"p_profil": p_profil,
	})

## Cree un compte DEPUIS LE FORMULAIRE DE CREATION EN LIGNE (email + captcha, voir
## fn_creer_compte_public dans schema.sql) - a la difference de creer_compte() ci-dessus, TOUJOURS
## utilisee par WelcomePanel (creer_compte() reste reservee a SaveManager._ensure_server_session(),
## l'enregistrement silencieux en arriere-plan d'un compte deja connu localement, sans captcha a
## demander a ce moment-la). Exactement UN des deux [p_turnstile_token]/[p_code_captcha] doit etre
## non vide : [p_turnstile_token] sur Web (widget Turnstile integre directement dans la page),
## [p_code_captcha] sur desktop/mobile (code a 6 caracteres retape depuis captcha.html, voir
## WelcomePanel._on_create_pressed()). [p_email] optionnel (chaine vide si non fourni).
## data (si ok) : {"id": String, "login": String, "email_envoye": bool} - "email_envoye" a false
## n'est PAS un echec de creation (voir commentaire de fn_creer_compte_public), juste une invitation
## a proposer "renvoyer" (renvoyer_verification() ci-dessous).
func creer_compte_public(p_id: String, p_login: String, p_mdp_hash: String, p_mdp_sel: String, p_profil: Dictionary, p_email: String, p_turnstile_token: String = "", p_code_captcha: String = "") -> Dictionary:
	return await _call_rpc("fn_creer_compte_public", {
		"p_id": p_id,
		"p_login": p_login,
		"p_mdp_hash": p_mdp_hash,
		"p_mdp_sel": p_mdp_sel,
		"p_profil": p_profil,
		"p_email": p_email,
		"p_turnstile_token": p_turnstile_token,
		"p_code_captcha": p_code_captcha,
		## Toujours vide cote client (champ honeypot, voir fn_creer_compte_public dans schema.sql) :
		## un vrai joueur ne le remplit jamais, aucun champ de formulaire n'y est meme relie ici -
		## seul un appel direct a l'API RPC (en dehors de ce client) pourrait le remplir.
		"p_honeypot": "",
	})

## Renvoie l'email de verification (bouton "renvoyer l'email", voir fn_renvoyer_verification dans
## schema.sql) - authentifie par jeton de session, cooldown 5 min cote serveur ("message":
## "attendre_avant_renvoi" si declenche trop tot). data (si ok) : {"ok": true, "email_envoye": bool}.
func renvoyer_verification(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_renvoyer_verification", {"p_jeton": p_jeton})

## Connexion - data (si ok) : {"jeton": String, "compte_id": String}. [p_mdp_hash] doit deja etre
## calcule cote appelant avec le sel obtenu via obtenir_sel() (voir save_manager.gd _hash_password),
## jamais le mot de passe en clair.
func login(p_login: String, p_mdp_hash: String) -> Dictionary:
	return await _call_rpc("fn_login", {"p_login": p_login, "p_mdp_hash": p_mdp_hash})

## Pousse un lot d'evenements en attente - data (si ok) : {"ids_appliques": Array[String]} (les
## evenements reellement nouveaux cote serveur, voir fn_pousser_evenements ; un evenement deja recu
## avant - ex. renvoye apres coupure reseau - n'apparait pas dans cette liste mais n'est PAS une
## erreur, l'appelant peut quand meme le retirer de sa file locale). Format attendu par element de
## [p_evenements], voir l'en-tete de fn_pousser_evenements dans schema.sql pour les payloads par
## type :
##   {"id": "<id unique genere cote client>", "type": "<type_evenement>", "payload": {...},
##    "horodatage_client": "<ISO 8601>"}
func pousser_evenements(p_jeton: String, p_evenements: Array) -> Dictionary:
	return await _call_rpc("fn_pousser_evenements", {"p_jeton": p_jeton, "p_evenements": p_evenements})

## Recupere l'etat agrege courant du compte - data (si ok) : {"economy":..., "cards":...,
## "defis":..., "prof_skins":..., "classroom_decor":..., "classroom_music":...} (memes formes que
## Economy.serialize()/CardCollection.serialize()/etc., voir fn_recuperer_progression).
func recuperer_progression(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_recuperer_progression", {"p_jeton": p_jeton})

## Supprime definitivement le compte associe au jeton (+ toute sa progression/ses evenements,
## cascade cote SQL, voir fn_supprimer_compte dans schema.sql) - data (si ok) : {"ok": true}.
func supprimer_compte(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_supprimer_compte", {"p_jeton": p_jeton})

## Remplace le profil (nom/prenom/classe/date de naissance/pays + controle parental/limite
## quotidienne, voir SaveManager.update_current_profile()) du compte associe au jeton - data (si ok)
## : {"ok": true}. Chantier "connexion cross-device" 2026-09-13, voir fn_maj_profil dans schema.sql
## pour le detail (remplacement complet, pas de fusion cle par cle).
func maj_profil(p_jeton: String, p_profil: Dictionary) -> Dictionary:
	return await _call_rpc("fn_maj_profil", {"p_jeton": p_jeton, "p_profil": p_profil})

## "Battement de coeur" de presence (chantier "conflit de connexion" 2026-09-13, voir fn_pulse_session
## dans schema.sql) - rafraichit derniere_activite pour ce jeton, sans rien lire/ecrire d'autre. A
## appeler periodiquement tant qu'un compte est connecte, voir SaveManager._send_session_heartbeat().
func pulse_session(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_pulse_session", {"p_jeton": p_jeton})

## Libere immediatement la session associee au jeton (chantier "conflit de connexion" 2026-09-13,
## voir fn_deconnecter dans schema.sql) - a appeler sur une deconnexion VOLONTAIRE (SaveManager.
## logout()) pour que ce compte redevienne connectable ailleurs sans attendre l'expiration naturelle
## de la presence. Idempotente/best-effort (data (si ok) : {"ok": true} meme sur un jeton deja
## absent/expire).
func deconnecter(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_deconnecter", {"p_jeton": p_jeton})

## Change le pseudo du compte associe au jeton - data (si ok) : {"login": String} (voir
## fn_changer_login dans schema.sql, qui peut refuser avec "pseudo_indisponible").
func changer_login(p_jeton: String, p_nouveau_login: String) -> Dictionary:
	return await _call_rpc("fn_changer_login", {"p_jeton": p_jeton, "p_nouveau_login": p_nouveau_login})

## Change l'email du compte associe au jeton (repart d'une verification neuve, voir
## fn_changer_email dans schema.sql) - data (si ok) : {"email_envoye": bool}, meme convention que
## creer_compte_public()/renvoyer_verification() ci-dessus (l'echec d'ENVOI n'est pas un echec de
## l'operation elle-meme).
func changer_email(p_jeton: String, p_nouvel_email: String) -> Dictionary:
	return await _call_rpc("fn_changer_email", {"p_jeton": p_jeton, "p_nouvel_email": p_nouvel_email})

## Change le mot de passe du compte associe au jeton - [p_nouveau_mdp_hash]/[p_nouveau_mdp_sel]
## deja calcules cote appelant avec un sel FRAIS (voir SaveManager.change_password()), jamais le
## mot de passe en clair. data (si ok) : {"ok": true}.
func changer_mot_de_passe(p_jeton: String, p_nouveau_mdp_hash: String, p_nouveau_mdp_sel: String) -> Dictionary:
	return await _call_rpc("fn_changer_mot_de_passe", {
		"p_jeton": p_jeton,
		"p_nouveau_mdp_hash": p_nouveau_mdp_hash,
		"p_nouveau_mdp_sel": p_nouveau_mdp_sel,
	})

## Etat de confirmation de l'email du compte associe au jeton (2026-09-16, voir fn_statut_email
## dans schema.sql) - data (si ok) : {"email_verifie": bool}. Utilisee par le bouton "j'ai
## confirmé, vérifier à nouveau" (WelcomePanel) sans repasser par un login() complet.
func statut_email(p_jeton: String) -> Dictionary:
	return await _call_rpc("fn_statut_email", {"p_jeton": p_jeton})

## "Mot de passe oublié" (2026-09-16, voir fn_demander_reinitialisation_mdp dans schema.sql) -
## PAS de jeton (c'est justement le mot de passe qui est oublie) : [p_login_ou_email] peut etre un
## pseudo OU un email, le serveur essaie les deux. data (si ok) : {"ok": true} INCONDITIONNEL, que
## le compte existe ou non (voir le commentaire de la fonction SQL - jamais laisser deviner quels
## comptes existent).
func demander_reinitialisation_mdp(p_login_ou_email: String) -> Dictionary:
	return await _call_rpc("fn_demander_reinitialisation_mdp", {"p_login_ou_email": p_login_ou_email})

## Coeur du client : POST vers BASE_URL + [fn_name], [params] comme corps JSON - les cles de
## [params] doivent correspondre EXACTEMENT aux noms de parametres SQL (p_xxx compris), c'est la
## convention PostgREST pour appeler une fonction RPC par son nom. Renvoie toujours un Dictionary,
## jamais une erreur Godot (voir commentaire de classe) :
##   - reussite         : {"ok": true, "data": <resultat jsonb de la fonction, deja parse>}
##   - refus du serveur  : {"ok": false, "type": "serveur", "message": "<ex: identifiants_invalides>"}
##   - probleme reseau  : {"ok": false, "type": "reseau", "message": "<detail technique>"}
func _call_rpc(fn_name: String, params: Dictionary) -> Dictionary:
	var http := HTTPRequest.new()
	http.timeout = TIMEOUT_SECONDS
	add_child(http)

	var headers := PackedStringArray([
		"Content-Type: application/json",
		"apikey: " + ANON_KEY,
		"Authorization: Bearer " + ANON_KEY,
	])
	var body := JSON.stringify(params)
	var launch_error := http.request(BASE_URL + fn_name, headers, HTTPClient.METHOD_POST, body)
	if launch_error != OK:
		http.queue_free()
		return {"ok": false, "type": "reseau", "message": "echec_lancement_requete (%d)" % launch_error}

	# Un signal Godot avec plusieurs arguments (ici 4 : result, response_code, headers, body) est
	# recu par `await` sous forme d'Array des valeurs emises, dans l'ordre de declaration du signal
	# request_completed(result, response_code, headers, body) - voir doc HTTPRequest.
	var signal_args: Array = await http.request_completed
	var request_result: int = signal_args[0]
	var status_code: int = signal_args[1]
	var response_body: PackedByteArray = signal_args[3]
	http.queue_free()

	if request_result != HTTPRequest.RESULT_SUCCESS:
		return {"ok": false, "type": "reseau", "message": "echec_reseau (code %d)" % request_result}

	var response_text := response_body.get_string_from_utf8()
	var parsed: Variant = JSON.parse_string(response_text) if response_text != "" else null

	if status_code >= 200 and status_code < 300:
		return {"ok": true, "data": parsed}

	# PostgREST renvoie les `raise exception '<message>'` de schema.sql dans le champ "message" d'un
	# corps d'erreur JSON ({"code":"P0001", "message":"identifiants_invalides", ...}) - remonte tel
	# quel, avec un repli generique si jamais le corps n'a pas cette forme (ex. Caddy/Kong en panne
	# renvoyant une page d'erreur HTML plutot qu'un JSON PostgREST).
	var server_message := "erreur_serveur (code %d)" % status_code
	if parsed is Dictionary and parsed.has("message"):
		server_message = str(parsed["message"])
	return {"ok": false, "type": "serveur", "message": server_message}
