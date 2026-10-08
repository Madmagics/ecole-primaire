## Etiquette nom + titre du prof, affichee en permanence aux pieds du PNJ (2026-10-08, demande de
## Steve : "la bulle flottante [...] devra flotter en permanence aux pieds des npc et etre avec 20%
## de transparence"). Purement decorative, jamais cliquable (mouse_filter=IGNORE partout).
##
## Comme SpeechBubble, ce Control est enfant direct d'un Node2D (le PNJ) : pas d'ancrage utile, on
## place la racine a la main. Le haut-centre de l'etiquette est colle au point "pieds" du
## ProfVisual frere (bas du sprite au repos), recalcule chaque frame : ProfVisual garde ce point
## fixe pendant sa respiration, donc l'etiquette ne bouge pas avec l'animation idle, et suit
## automatiquement un changement de skin (hauteur de texture differente).
##
## Classe lue sur le QuestionGiverComponent frere (scene d'ecole). S'il n'y en a pas (demo-tutoriel,
## dont les profs ne sont que des images), on retombe sur l'export "grade" pose sur l'instance.
## @tool : apercu direct dans l'editeur (aucun autoload utilise ici).
@tool
class_name NameTag
extends PanelContainer

## Classe de repli quand aucun QuestionGiverComponent frere n'existe (voir commentaire de tete).
@export var grade: GradeLevel.Grade = GradeLevel.Grade.CP:
	set(value):
		grade = value
		_refresh_texts()
## Opacite globale : 0.8 = 20 % de transparence.
@export_range(0.0, 1.0, 0.05) var opacity: float = 0.8:
	set(value):
		opacity = value
		modulate.a = value
## Decalage vertical par rapport au bas du sprite (positif = plus bas), au cas ou le dessin du prof
## aurait une marge transparente sous les pieds.
@export var feet_offset_y: float = 0.0

@onready var _name_label: Label = $VBox/NameLabel
@onready var _title_label: Label = $VBox/TitleLabel

var _prof_visual: ProfVisual

func _ready() -> void:
	modulate.a = opacity
	var parent := get_parent()
	if parent:
		for child in parent.get_children():
			if child is ProfVisual:
				_prof_visual = child
			elif child is QuestionGiverComponent:
				grade = (child as QuestionGiverComponent).grade
	_refresh_texts()

func _refresh_texts() -> void:
	if _name_label == null: # setter appele avant l'arrivee des @onready (chargement de la scene)
		return
	_name_label.text = TeacherIdentity.get_teacher_name(grade)
	_title_label.text = TeacherIdentity.get_teacher_title(grade)

func _process(_delta: float) -> void:
	var feet := Vector2.ZERO
	if _prof_visual and _prof_visual.texture:
		# Bas du sprite (centered=true) : position + moitie de la hauteur affichee. ProfVisual
		# compense son etirement idle sur position.y, donc cette somme reste constante.
		var half_h: float = _prof_visual.texture.get_height() * absf(_prof_visual.scale.y) * 0.5
		feet = _prof_visual.position + Vector2(0.0, half_h)
	position = feet + Vector2(-size.x * 0.5, feet_offset_y)
