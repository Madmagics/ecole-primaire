## Cour de recre (2026-11-25, retour utilisateur : "le raccourci ouvre une autre scene en 2d, j'y
## placerai le decor, actuellement place y 5 capsules 2d qui seront les enfants a cliquer").
##
## Scene separee, editable a part dans l'editeur (Background = image de fond, Decor = objets
## places a la main, Children = les 5 enfants). Elle n'est PAS chargee via change_scene : toute
## l'interface du jeu (connexion, menus, sauvegarde...) vit dans school.tscn, qu'on perdrait en
## changeant de scene. school.gd l'instancie donc par-dessus la classe (masquee et desactivee le
## temps de la visite) et la libere au retour - voir school.gd, _open_playground().
## Memes coordonnees que la classe (camera fixe centree sur 576x324, ecran 1152x648).
class_name Playground
extends Node2D

signal exit_requested

@onready var _children_root: Node2D = $Children
@onready var _popup: PlaygroundChildPopup = $UI/ChildPopup
@onready var _back_button: Button = $UI/BackButton
## Calque au-dessus de TOUTE l'interface du jeu (layer 2 > layer 1 de UI dans school.tscn) : un
## mini-jeu plein ecran cache aussi les boutons de menu, pas de clic parasite pendant une partie.
@onready var _game_layer: CanvasLayer = $GameLayer

var _game: MiniGame = null

func _ready() -> void:
	_back_button.theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(_on_ui_theme_changed)
	_back_button.pressed.connect(_on_back_pressed)
	_popup.game_requested.connect(_on_game_requested)
	## Binomes par classe pour les dialogues (classe -> {numero de jeu: enfant}).
	var pairs := {}
	for node in _children_root.get_children():
		var kid := node as PlaygroundChild
		if kid:
			kid.clicked.connect(_on_child_clicked)
			if not pairs.has(kid.grade):
				pairs[kid.grade] = {}
			pairs[kid.grade][kid.game_slot] = kid
	var chatter := PlaygroundChatter.new()
	add_child(chatter)
	chatter.start(pairs)

func _on_ui_theme_changed(new_theme: Theme) -> void:
	_back_button.theme = new_theme

func _on_back_pressed() -> void:
	exit_requested.emit()

func _on_child_clicked(kid: PlaygroundChild) -> void:
	if _popup.visible or _game != null:
		return
	_popup.open_for(kid.grade, kid.game_slot, kid.first_name)

func _on_game_requested(scene_path: String, grade: GradeLevel.Grade) -> void:
	if _game != null:
		return
	var packed: PackedScene = load(scene_path)
	_game = packed.instantiate() as MiniGame
	if _game == null:
		push_error("Playground: %s n'a pas une racine MiniGame." % scene_path)
		return
	_game.grade = grade
	_game.closed.connect(_on_game_closed)
	_game_layer.add_child(_game)

func _on_game_closed() -> void:
	if _game == null:
		return
	_game.queue_free()
	_game = null
