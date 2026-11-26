## Popup d'un enfant de la cour de recre (2026-11-25). Au clic sur un enfant, il "regarde" la
## collection du joueur pour SA classe (grade de l'enfant) :
## - toutes les cartes de cette classe possedees -> l'enfant propose SON jeu (GAMES) ;
## - sinon -> l'enfant donne le compte de cartes et demande de revenir avec la collection complete.
## Une phrase par ligne dans les messages (2026-11-25, retour utilisateur).
## Cliquer un jeu ferme la popup et emet game_requested : la cour (playground.gd) lance le jeu.
class_name PlaygroundChildPopup
extends Control

## Meme dossier que le livre de cartes (CardAlbum.CARDS_DIR), meme lecture via
## ResourceLoader.list_directory() qui fonctionne aussi dans l'export Web.
const CARDS_DIR := "res://data/card/resources"

signal game_requested(scene_path: String, grade: GradeLevel.Grade)

## Jeu propose par chaque enfant (2026-11-25 : 2 enfants donc 2 jeux par classe) : classe ->
## liste des jeux dans l'ordre des enfants (game_slot 1 = 1er element). Chaque jeu = nom affiche +
## scene (racine MiniGame). Enfant sans jeu dans la liste = "je prepare un jeu, reviens bientot".
const GAMES := {
	GradeLevel.Grade.CP: [
		{"name": "Pluie de biscuits", "scene": "res://minigames/pluie_de_biscuits/pluie_de_biscuits.tscn"},
		{"name": "Tap taupe", "scene": "res://minigames/tap_taupe/tap_taupe.tscn"},
	],
	GradeLevel.Grade.CE1: [
		{"name": "Memory des animaux", "scene": "res://minigames/memory_animaux/memory_animaux.tscn"},
		{"name": "Simon des animaux", "scene": "res://minigames/simon_animaux/simon_animaux.tscn"},
	],
	GradeLevel.Grade.CE2: [
		{"name": "Saute-mouton", "scene": "res://minigames/saute_mouton/saute_mouton.tscn"},
		{"name": "Tetri-Star", "scene": "res://minigames/empile_briques/empile_briques.tscn"},
	],
	GradeLevel.Grade.CM1: [
		{"name": "Casse-briques", "scene": "res://minigames/casse_briques/casse_briques.tscn"},
		{"name": "Taquin des animaux", "scene": "res://minigames/taquin_animaux/taquin_animaux.tscn"},
	],
	GradeLevel.Grade.CM2: [
		{"name": "2048 des animaux", "scene": "res://minigames/animaux_2048/animaux_2048.tscn"},
		{"name": "3 animaux alignés", "scene": "res://minigames/animaux_alignes/animaux_alignes.tscn"},
	],
}

## Id des cartes de chaque classe, calcule une seule fois (les cartes ne changent pas en jeu).
static var _card_ids_by_grade: Dictionary = {}

@onready var _title_label: Label = %TitleLabel
@onready var _message_label: Label = %MessageLabel
@onready var _games_list: VBoxContainer = %GamesList
@onready var _close_button: Button = %CloseButton

func _ready() -> void:
	hide()
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(_on_ui_theme_changed)
	_close_button.pressed.connect(close)

func _on_ui_theme_changed(new_theme: Theme) -> void:
	theme = new_theme

func open_for(grade: GradeLevel.Grade, game_slot: int, first_name: String = "") -> void:
	var card_ids := get_card_ids(grade)
	var owned := count_owned(grade)
	var grade_label := GradeLevel.get_label(grade)
	_title_label.text = ("%s, élève du %s" % [first_name, grade_label]) if not first_name.is_empty() else ("Un élève du %s" % grade_label)
	for old_button in _games_list.get_children():
		old_button.queue_free()

	if is_collection_complete(grade):
		var games: Array = GAMES.get(grade, [])
		if game_slot < 1 or game_slot > games.size():
			_message_label.text = "Waouh, tu as toutes les cartes du %s !\nJe prépare un jeu pour toi.\nReviens bientôt !" % grade_label
		else:
			var game: Dictionary = games[game_slot - 1]
			_message_label.text = "Waouh, tu as toutes les cartes du %s !\nTu veux jouer avec moi ?\nUne partie coûte %d pièces du %s." % [grade_label, MiniGameHud.GAME_PRICE, grade_label]
			var button := Button.new()
			button.text = String(game["name"])
			button.custom_minimum_size = Vector2(0, 52)
			button.pressed.connect(_on_game_pressed.bind(String(game["scene"]), grade))
			_games_list.add_child(button)
	else:
		_message_label.text = "Montre-moi ta collection du %s...\nTu as %d cartes sur %d.\nReviens me voir quand tu les auras toutes !" % [grade_label, owned, card_ids.size()]
	show()

func close() -> void:
	hide()

func _on_game_pressed(scene_path: String, grade: GradeLevel.Grade) -> void:
	close()
	game_requested.emit(scene_path, grade)

## Nom du jeu propose par l'enfant [game_slot] de la classe [grade], "" s'il n'en a pas encore.
static func get_game_name(grade: GradeLevel.Grade, game_slot: int) -> String:
	var games: Array = GAMES.get(grade, [])
	if game_slot < 1 or game_slot > games.size():
		return ""
	return String((games[game_slot - 1] as Dictionary)["name"])

## Nombre de cartes de la classe [grade] possedees par le joueur connecte.
static func count_owned(grade: GradeLevel.Grade) -> int:
	var owned := 0
	for card_id in get_card_ids(grade):
		if CardCollection.has_card(card_id):
			owned += 1
	return owned

static func is_collection_complete(grade: GradeLevel.Grade) -> bool:
	var total := get_card_ids(grade).size()
	return total > 0 and count_owned(grade) == total

## Condition d'entree dans la cour de recre (2026-11-25) : au moins une collection de classe complete.
static func has_any_complete_collection() -> bool:
	for grade_value: int in GradeLevel.Grade.values():
		if is_collection_complete(grade_value as GradeLevel.Grade):
			return true
	return false

static func get_card_ids(grade: GradeLevel.Grade) -> Array[StringName]:
	if _card_ids_by_grade.is_empty():
		for file_name in ResourceLoader.list_directory(CARDS_DIR):
			if not file_name.ends_with(".tres"):
				continue
			var card := load("%s/%s" % [CARDS_DIR, file_name]) as CardResource
			if card == null:
				continue
			if not _card_ids_by_grade.has(card.grade):
				var ids: Array[StringName] = []
				_card_ids_by_grade[card.grade] = ids
			_card_ids_by_grade[card.grade].append(card.id)
	var empty: Array[StringName] = []
	return _card_ids_by_grade.get(grade, empty)
