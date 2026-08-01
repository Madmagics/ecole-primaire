## Sauvegarde/charge l'etat qui doit survivre a un REDEMARRAGE du jeu (contrairement aux
## autres autoloads, qui ne survivent que d'une scene a l'autre). Rassemble un instantane de
## chaque autoload concerne (voir serialize/deserialize sur Economy, CardCollection,
## StatsTracker) + les reglages (volume, plein ecran, touches personnalisees) dans un seul
## fichier JSON, pour rester simple (voir feedback_lightweight_game.md : un seul fichier, pas
## de systeme de sauvegarde multi-slots ni de format binaire).
extends Node

const SAVE_PATH := "user://savegame.json"

## Actions reassignables depuis la section Commandes du menu (clavier uniquement, coherent
## avec le schema de controle actuel du jeu). "ui_cancel" (Echap, fermeture des fenetres) et
## le bouton "M" (menu, clic uniquement pour l'instant) ne sont volontairement pas
## reassignables ici.
const REBINDABLE_ACTIONS := [
	"move_left", "move_right", "move_up", "move_down", "interact", "open_album",
	"open_config", "open_save", "open_controls", "open_stats", "open_menu",
]

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

## Reglages geres directement ici : pas assez de logique propre a chacun pour justifier un
## autoload dedie (contrairement a Economy/CardCollection/StatsTracker, qui ont une vraie
## logique metier).
var master_volume: float = 1.0 # 0.0 (muet) a 1.0 (max)
var fullscreen: bool = false
var ui_theme: String = DEFAULT_UI_THEME
## action (String) -> physical_keycode (int) ; seules les actions reassignees a la main sont
## presentes ici, les autres gardent leur binding par defaut de project.godot.
var custom_bindings: Dictionary = {}

## action (String) -> physical_keycode (int) par defaut, tel que defini dans project.godot -
## capture une seule fois avant tout chargement de sauvegarde (voir _capture_default_bindings),
## pour pouvoir remettre une action a son binding d'origine sans avoir a le coder en dur ici et
## le desynchroniser un jour du fichier project.godot. Sert de filet de secours pour les
## collisions (voir _resolve_binding_collisions/rebind_action).
var _default_bindings: Dictionary = {}

func _ready() -> void:
	_capture_default_bindings()
	load_game()

func _capture_default_bindings() -> void:
	for action in REBINDABLE_ACTIONS:
		for event in InputMap.action_get_events(action):
			if event is InputEventKey:
				_default_bindings[action] = event.physical_keycode
				break

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func save_game() -> void:
	var data := {
		"economy": Economy.serialize(),
		"cards": CardCollection.serialize(),
		"stats": StatsTracker.serialize(),
		"grade_unlock": GradeUnlock.serialize(),
		"settings": {
			"master_volume": master_volume,
			"fullscreen": fullscreen,
			"custom_bindings": custom_bindings,
			"ui_theme": ui_theme,
		},
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("SaveManager: impossible d'ecrire %s (erreur %s)" % [SAVE_PATH, FileAccess.get_open_error()])
		return
	file.store_string(JSON.stringify(data))

## Charge la sauvegarde si elle existe (sinon garde l'etat par defaut de chaque systeme), puis
## applique dans tous les cas les reglages (volume/plein ecran/touches) au moteur - a appeler
## au demarrage et depuis le bouton "Charger" de la section Sauvegarde.
func load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file != null:
			var parsed = JSON.parse_string(file.get_as_text())
			if typeof(parsed) == TYPE_DICTIONARY:
				var data: Dictionary = parsed
				Economy.deserialize(data.get("economy", {}))
				CardCollection.deserialize(data.get("cards", {}))
				StatsTracker.deserialize(data.get("stats", {}))
				GradeUnlock.deserialize(data.get("grade_unlock", {}))
				var settings: Dictionary = data.get("settings", {})
				master_volume = float(settings.get("master_volume", 1.0))
				fullscreen = bool(settings.get("fullscreen", false))
				custom_bindings = settings.get("custom_bindings", {})
				## Corrige une sauvegarde plus ancienne qui aurait fige deux actions sur la meme
				## touche (voir _resolve_binding_collisions - ex. Commandes/Statistiques
				## partageant la meme touche, remonte le 2026-07-23).
				_resolve_binding_collisions()
				## get() avec repli sur DEFAULT_UI_THEME : protege contre une cle invalide
				## (theme renomme/supprime plus tard, ne devrait pas arriver mais evite un
				## theme nul plutot qu'un crash si ca arrivait quand meme).
				var saved_theme: String = settings.get("ui_theme", DEFAULT_UI_THEME)
				ui_theme = saved_theme if THEMES.has(saved_theme) else DEFAULT_UI_THEME
	_apply_settings()

## Remet la progression (pieces, cartes, statistiques) a zero et supprime le fichier de
## sauvegarde. Les reglages (volume, plein ecran, touches) ne sont pas touches.
func reset_progress() -> void:
	Economy.reset()
	CardCollection.reset()
	StatsTracker.reset()
	GradeUnlock.reset()
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

## Applique volume/plein ecran/touches personnalisees/theme d'interface a l'etat reel du moteur.
func _apply_settings() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
		linear_to_db(master_volume) if master_volume > 0.0 else -80.0)
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	for action in custom_bindings.keys():
		_apply_binding(action, int(custom_bindings[action]))
	## Filet de securite final (voir _enforce_no_runtime_collisions) : verifie l'etat REELLEMENT
	## applique a InputMap, pas seulement custom_bindings - couvre le cas ou _resolve_binding_
	## collisions() aurait deja tourne sur une sauvegarde plus ancienne sans que le fichier disque
	## ait ete reecrit depuis (la collision revenait donc a chaque chargement sans jamais etre
	## corrigee "pour de bon").
	_enforce_no_runtime_collisions()
	_apply_ui_theme()

## Diffuse le theme d'interface courant via EventBus (voir EventBus.ui_theme_changed pour le
## detail : get_tree().root.theme ne suffit pas ici a cause du CanvasLayer "UI" de park.tscn, qui
## coupe la propagation automatique). N'a d'effet que sur les panneaux deja dans l'arbre - chaque
## panneau applique aussi ce theme lui-meme a son _ready() pour le cas ou il n'existe pas encore
## au moment de cet appel (ex: tout premier chargement, avant que park.tscn soit pret).
func _apply_ui_theme() -> void:
	EventBus.ui_theme_changed.emit(THEMES.get(ui_theme, THEMES[DEFAULT_UI_THEME]))

## Change le theme d'interface, l'applique immediatement et sauvegarde. [id] doit etre une des
## cles de THEMES (voir section_config.gd, qui construit ses vignettes a partir de THEMES.keys()
## plutot que de les coder en dur, pour rester coherent si un theme est ajoute/retire plus tard).
func set_ui_theme(id: String) -> void:
	if not THEMES.has(id):
		return
	ui_theme = id
	_apply_ui_theme()
	save_game()

## Change le volume immediatement (retour sonore instantane) SANS ecrire sur le disque -
## utilise pendant qu'on fait glisser le curseur (voir SectionConfig). set_master_volume
## (avec sauvegarde) est appele une seule fois au relachement du curseur.
func preview_master_volume(value: float) -> void:
	master_volume = clampf(value, 0.0, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
		linear_to_db(master_volume) if master_volume > 0.0 else -80.0)

func set_master_volume(value: float) -> void:
	preview_master_volume(value)
	save_game()

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	save_game()

## Reassigne [action] a une seule touche (remplace tout binding existant). Si une AUTRE action
## rebindable utilise deja cette touche, elle est remise a son binding par defaut (jamais deux
## actions sur la meme touche en meme temps - voir feedback utilisateur du 2026-07-23 : Commandes
## et Statistiques s'ouvraient toutes les deux avec la meme touche).
func rebind_action(action: String, physical_keycode: int) -> void:
	if not REBINDABLE_ACTIONS.has(action):
		return
	for other_action in REBINDABLE_ACTIONS:
		if other_action != action and _current_binding_for(other_action) == physical_keycode:
			custom_bindings.erase(other_action)
			_apply_binding(other_action, _default_bindings.get(other_action, physical_keycode))
	custom_bindings[action] = physical_keycode
	_apply_binding(action, physical_keycode)
	save_game()

func _current_binding_for(action: String) -> int:
	return int(custom_bindings.get(action, _default_bindings.get(action, -1)))

## Corrige une collision deja presente dans custom_bindings (ex: chargee depuis une sauvegarde
## plus ancienne, avant l'ajout de la garde dans rebind_action ci-dessus). Parcourt
## REBINDABLE_ACTIONS dans son ordre fixe : en cas de collision, l'action la plus a GAUCHE dans
## cette liste garde sa touche personnalisee, les suivantes retrouvent leur binding par defaut -
## ordre deterministe, pas de dependance a l'ordre (non garanti) des cles du JSON charge.
func _resolve_binding_collisions() -> void:
	var claimed_keycodes: Dictionary = {} # physical_keycode (int) -> action (String) qui le garde
	for action in REBINDABLE_ACTIONS:
		if not custom_bindings.has(action):
			continue
		var keycode: int = int(custom_bindings[action])
		if claimed_keycodes.has(keycode):
			custom_bindings.erase(action)
		else:
			claimed_keycodes[keycode] = action

## Deuxieme filet de securite, complementaire a _resolve_binding_collisions() ci-dessus : celle-ci
## ne nettoie QUE le dictionnaire custom_bindings tel que lu du JSON, au moment du chargement.
## Celle-ci verifie l'etat REEL d'InputMap une fois tous les bindings (par defaut + personnalises)
## appliques - donc correcte quelle que soit la cause d'une collision residuelle - et surtout
## SAUVEGARDE immediatement le nettoyage (contrairement a _resolve_binding_collisions, qui ne
## faisait que corriger la memoire sans jamais reecrire le fichier : une sauvegarde deja corrompue
## semblait donc "revenir" a chaque partie tant qu'on ne rejouait pas dans la foulee).
func _enforce_no_runtime_collisions() -> void:
	var claimed: Dictionary = {} # physical_keycode (int) -> action (String) qui le garde
	var changed := false
	for action in REBINDABLE_ACTIONS:
		var keycode: int = _current_binding_for(action)
		if claimed.has(keycode):
			var fallback: int = _default_bindings.get(action, keycode)
			custom_bindings.erase(action)
			_apply_binding(action, fallback)
			changed = true
		else:
			claimed[keycode] = action
	if changed:
		save_game()

func _apply_binding(action: String, physical_keycode: int) -> void:
	if not InputMap.has_action(action):
		return
	InputMap.action_erase_events(action)
	var event := InputEventKey.new()
	event.physical_keycode = physical_keycode
	InputMap.action_add_event(action, event)

## Libelle lisible de la touche actuellement assignee a [action] (personnalisee si presente,
## sinon celle par defaut de project.godot). physical_keycode est positionnel, reference sur un
## clavier QWERTY (ex: KEY_M correspond a la position du point-virgule sur un clavier AZERTY,
## ou M et ; sont permutes par rapport a QWERTY) : afficher directement OS.get_keycode_string()
## dessus donnerait un libelle qui ne correspond pas a la touche imprimee sur le clavier du
## joueur. DisplayServer.keyboard_get_label_from_physical() convertit vers le caractere reellement
## imprime sur la disposition clavier active (verifie sur la doc/le tracker Godot 4).
func get_binding_label(action: String) -> String:
	for event in InputMap.action_get_events(action):
		if event is InputEventKey:
			var localized_key: Key = DisplayServer.keyboard_get_label_from_physical(event.physical_keycode)
			return OS.get_keycode_string(localized_key)
	return "?"
