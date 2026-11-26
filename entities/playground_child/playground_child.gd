## Enfant de la cour de recre (2026-11-25, retour utilisateur : "5 capsules 2d qui seront les
## enfants a cliquer comme pour les profs"). Un enfant par classe (grade) : la capsule prend la
## couleur de la classe (GradeLevel.get_color) et affiche son nom (CP, CE1...) au lancement du jeu
## - dans l'editeur les capsules ont la couleur par defaut de Capsule2D, se reperer a leur nom de
## noeud (Enfant_CP_1, Enfant_CE1_2...). Le clic passe par InteractableComponent2D, exactement
## comme les profs (relachement du clic gauche, tactile via "Emulate Mouse From Touch").
##
## 10 enfants dans la cour (2026-11-25, retour utilisateur : "2 enfants/jeux par classe") : chaque
## enfant propose UN jeu, repere par sa classe (grade) + son numero de jeu dans la classe
## (game_slot, 1 ou 2) - voir PlaygroundChildPopup.GAMES.
##
## Skin : un Sprite2D (le visuel de l'enfant, "Skin") enfant DIRECT de l'instance. Des qu'il est
## present, au lancement :
## - la capsule et son etiquette se masquent ;
## - le Skin "respire" comme les profs (meme mouvement que ProfVisual : etirement vertical doux,
##   pieds fixes, pauses de duree aleatoire pour que les enfants ne respirent pas a l'unisson) ;
## - une etiquette sous les pieds affiche le prenom (first_name) + le nom du jeu propose (NameTag,
##   meme composant que les profs) ;
## - une bulle de dialogue (SpeechBubble, meme composant que les profs) est disponible via
##   [member bubble] - pilotee par les dialogues de la cour (playground_chatter.gd).
class_name PlaygroundChild
extends Node2D

signal clicked(child: PlaygroundChild)

const NameTagScene := preload("res://ui/name_tag/name_tag.tscn")
const SpeechBubbleScene := preload("res://ui/speech_bubble/speech_bubble.tscn")

## Respiration : memes valeurs que les reglages par defaut de ProfVisual.
const BREATH_AMPLITUDE := 0.025
const BREATH_MIN_SECONDS := 4.0
const BREATH_MAX_SECONDS := 5.0
const BREATH_PAUSE_MIN := 2.0
const BREATH_PAUSE_MAX := 4.0
## Au-dessus des autres enfants (tries par hauteur dans la cour) pour rester lisible.
const BUBBLE_Z_INDEX := 20
const NO_GAME_TITLE := "Bientôt un jeu"

@export var grade: GradeLevel.Grade = GradeLevel.Grade.CP
## Numero du jeu propose par cet enfant parmi ceux de sa classe.
@export_range(1, 2) var game_slot: int = 1
@export var first_name: String = ""

## Bulle de dialogue de l'enfant (null sans Skin).
var bubble: SpeechBubble = null

var _skin: Sprite2D = null
var _rest_scale: Vector2 = Vector2.ONE
var _half_height_rest: float = 0.0
var _feet_anchor: Vector2 = Vector2.ZERO
var _is_breathing: bool = false
var _pause_left: float = 0.0
var _breath_elapsed: float = 0.0
var _breath_duration: float = 0.0

@onready var _capsule: Capsule2D = $CapsuleVisual
@onready var _grade_label: Label = $GradeLabel
@onready var _interactable: InteractableComponent2D = $InteractableComponent

func _ready() -> void:
	_capsule.color = GradeLevel.get_color(grade)
	_grade_label.text = "%s %d" % [GradeLevel.get_label(grade), game_slot]
	_interactable.interacted.connect(_on_interacted)
	_skin = _find_skin()
	set_process(_skin != null)
	if _skin == null:
		return
	_capsule.hide()
	_grade_label.hide()
	_setup_breathing()
	var tag := NameTagScene.instantiate() as NameTag
	## Classe entre parentheses a cote du prenom (2026-11-25), ex. "Vanessa (CP)".
	tag.custom_name = "%s (%s)" % [first_name, GradeLevel.get_label(grade)]
	var game_name := PlaygroundChildPopup.get_game_name(grade, game_slot)
	tag.custom_title = game_name if not game_name.is_empty() else NO_GAME_TITLE
	add_child(tag)
	bubble = SpeechBubbleScene.instantiate() as SpeechBubble
	bubble.z_index = BUBBLE_Z_INDEX
	add_child(bubble)

func _on_interacted(_who: Node) -> void:
	clicked.emit(self)

func _find_skin() -> Sprite2D:
	for node in get_children():
		if node is Sprite2D:
			return node
	return null

func _setup_breathing() -> void:
	_rest_scale = _skin.scale
	_half_height_rest = (_skin.texture.get_height() * absf(_rest_scale.y) * 0.5) if _skin.texture else 0.0
	_feet_anchor = _skin.position + Vector2(0.0, _half_height_rest)
	_pause_left = randf_range(BREATH_PAUSE_MIN, BREATH_PAUSE_MAX)

## Meme mouvement que ProfVisual._process : demi-sinusoide d'etirement vertical, pieds fixes.
func _process(delta: float) -> void:
	var stretch := 0.0
	if _is_breathing:
		_breath_elapsed += delta
		if _breath_elapsed >= _breath_duration:
			_is_breathing = false
			_pause_left = randf_range(BREATH_PAUSE_MIN, BREATH_PAUSE_MAX)
		else:
			stretch = BREATH_AMPLITUDE * sin(_breath_elapsed / _breath_duration * PI)
	else:
		_pause_left -= delta
		if _pause_left <= 0.0:
			_is_breathing = true
			_breath_elapsed = 0.0
			_breath_duration = randf_range(BREATH_MIN_SECONDS, BREATH_MAX_SECONDS)
	_skin.scale.y = _rest_scale.y * (1.0 + stretch)
	_skin.position = _feet_anchor - Vector2(0.0, _half_height_rest * (1.0 + stretch))
