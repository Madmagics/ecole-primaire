## Client HTTP vers les fonctions RPC Supabase (voir server/schema.sql pour le detail des 6
## fonctions fn_obtenir_sel/fn_creer_compte/fn_login/fn_pousser_evenements/fn_recuperer_progression/
## fn_supprimer_compte, toutes exposees automatiquement par PostgREST comme endpoints POST
## /rest/v1/rpc/<nom_fonction>).
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
