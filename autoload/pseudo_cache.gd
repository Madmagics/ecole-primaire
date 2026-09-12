## Mémorisation locale des pseudos déjà utilisés AVEC SUCCÈS sur CET APPAREIL (2026-09-13, voir
## project_auth_creation_comptes.md en mémoire projet, point 6 - conçu en prévision de la version
## en ligne mais déjà utile aujourd'hui en local, un même appareil pouvant servir à plusieurs
## enfants, voir le commentaire de classe de SaveManager). JAMAIS le mot de passe ici (uniquement
## le pseudo) - le mot de passe reste toujours redemandé à la connexion, ce cache ne fait qu'éviter
## de retaper/re-choisir le pseudo. Fichier séparé de savegame.json à dessein : ce n'est PAS une
## donnée de progression (perdre ce cache ne fait perdre qu'un confort de saisie, jamais une
## partie), une écriture simple suffit donc ici (pas besoin de la ceremonie fichier temporaire +
## renommage atomique + copie .bak de SaveManager._save_to_disk(), réservée aux vraies données de
## jeu).
##
## Comparaison insensible à la casse UNIQUEMENT (to_lower(), pas de retrait d'accents) - volontaire,
## pour rester cohérent avec la seule normalisation qui existe réellement ailleurs dans le projet :
## SaveManager._find_account_index_by_login() (comparaison locale) et login_normalise dans
## server/schema.sql (lower(login) côté serveur, pas de repli d'accents non plus).
extends Node

const CACHE_PATH := "user://pseudo_cache.json"

## Nombre d'entrées conservées au maximum (2026-09-13, retour utilisateur : éviter qu'une liste sur
## un PC de classe partagé par toute une année scolaire ne devienne interminable - pas un risque de
## sécurité en soi, un pseudo n'est pas une donnée sensible, mais un souci de propreté/discrétion
## vis-à-vis des autres élèves). Au-delà, l'entrée la MOINS récemment utilisée est retirée.
const MAX_ENTRIES := 6

## Liste de Dictionary {"pseudo": String, "derniere_utilisation": int (Time.get_unix_time_from_system)}
## triée de la plus récente à la plus ancienne (index 0 = dernière utilisée).
var _entries: Array[Dictionary] = []

func _ready() -> void:
	_read_from_disk()

## À appeler après une connexion OU une création de compte réussie (voir WelcomePanel). Si [pseudo]
## est déjà dans le cache, le remonte simplement en position la plus récente plutôt que de créer un
## doublon.
func remember(pseudo: String) -> void:
	var trimmed := pseudo.strip_edges()
	if trimmed.is_empty():
		return
	_entries = _entries.filter(func(entry: Dictionary) -> bool:
		return String(entry.get("pseudo", "")).to_lower() != trimmed.to_lower())
	_entries.push_front({"pseudo": trimmed, "derniere_utilisation": Time.get_unix_time_from_system()})
	if _entries.size() > MAX_ENTRIES:
		_entries.resize(MAX_ENTRIES)
	_save_to_disk()

## "Oublier ce compte sur cet appareil" (2026-09-13, voir point 6 de project_auth_creation_comptes.md)
## - retire [pseudo] du cache s'il y est, ne fait rien sinon (aucune erreur à gérer côté UI).
func forget(pseudo: String) -> void:
	var normalized := pseudo.strip_edges().to_lower()
	var before := _entries.size()
	_entries = _entries.filter(func(entry: Dictionary) -> bool:
		return String(entry.get("pseudo", "")).to_lower() != normalized)
	if _entries.size() != before:
		_save_to_disk()

## true si [pseudo] est actuellement mémorisé sur cet appareil - utilisé par WelcomePanel pour
## n'afficher le bouton "Oublier ce pseudo sur cet appareil" que quand il a un effet réel.
func has_pseudo(pseudo: String) -> bool:
	var normalized := pseudo.strip_edges().to_lower()
	for entry in _entries:
		if String(entry.get("pseudo", "")).to_lower() == normalized:
			return true
	return false

## Suggestions par PRÉFIXE (pas de liste complète affichée au focus, voir point 7 de
## project_auth_creation_comptes.md - déclenché par WelcomePanel seulement à partir de 2 caractères
## tapés), dans l'ordre du plus récemment utilisé au moins récent.
func get_suggestions(prefix: String) -> Array[String]:
	var normalized_prefix := prefix.strip_edges().to_lower()
	var result: Array[String] = []
	if normalized_prefix.is_empty():
		return result
	for entry in _entries:
		var pseudo := String(entry.get("pseudo", ""))
		if pseudo.to_lower().begins_with(normalized_prefix):
			result.append(pseudo)
	return result

func _save_to_disk() -> void:
	var file := FileAccess.open(CACHE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("PseudoCache: impossible d'ecrire %s (erreur %s)" % [CACHE_PATH, FileAccess.get_open_error()])
		return
	file.store_string(JSON.stringify({"entries": _entries}))
	file.close()

func _read_from_disk() -> void:
	if not FileAccess.file_exists(CACHE_PATH):
		return
	var file := FileAccess.open(CACHE_PATH, FileAccess.READ)
	if file == null:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var loaded: Array = parsed.get("entries", [])
	_entries.clear()
	for entry in loaded:
		if typeof(entry) == TYPE_DICTIONARY and entry.has("pseudo"):
			_entries.append(entry)
