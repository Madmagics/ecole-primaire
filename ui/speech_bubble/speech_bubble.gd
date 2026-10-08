## Bulle de dialogue BD au-dessus des PNJ (2026-09-05, voir CHARTE_GRAPHIQUE.md pour les maquettes
## proposees et l'option "petits ronds" validee par l'utilisateur). Purement decorative : signale a
## l'enfant que le PNJ a quelque chose a proposer, ne gene jamais le reticule d'interaction
## (ui/interact_prompt/) - mouse_filter=IGNORE partout, jamais cliquable.
##
## La racine (position locale (0,0) de ce Control) est la pointe de la file de petits ronds,
## resynchronisee chaque frame juste au-dessus de la tete du ProfVisual frere (voir
## _sync_head_anchor) - meme "recherche du frere par type" que
## QuestionGiverComponent._find_sibling_interactable / ProfVisual._find_sibling_question_giver.
## Ce Control est un enfant direct du NPC2D (CharacterBody2D, donc un Node2D) et pas d'un Control :
## les ancres n'ont alors aucun effet utile (toutes collees a l'origine du parent faute de rect
## de reference - comportement documente de Godot pour un Control sous un CanvasItem non-Control),
## d'ou l'usage exclusif de position/scale manuels ci-dessous plutot que du systeme d'ancrage.
##
## Affichage pilote de l'exterieur par NpcBubbleScheduler (autoload) depuis le 2026-09-05 (retour
## utilisateur : "eviter que 2 bulles n'arrivent en meme temps [...] a tour de role au hasard
## pendant 10 secondes puis [...] au professeur suivant") - avant cette date, chaque PNJ tirait sa
## propre pause aleatoire independamment des autres et pouvait donc se retrouver a afficher sa
## bulle en meme temps qu'un autre PNJ par pur hasard. Ce script n'a plus de minuterie a lui : il
## s'enregistre au scheduler (_ready) et expose seulement show_bubble()/hide_bubble(), que le
## scheduler appelle a tour de role, jamais deux a la fois. _process ne fait plus que suivre la
## tete du PNJ (_sync_head_anchor) et le leger mouvement idle pendant l'affichage ("bouge un peu").
class_name SpeechBubble
extends Control

const _DOT_SIZE_NEAR := 6.0
const _DOT_SIZE_MID := 10.0
const _DOT_SIZE_FAR := 14.0
const _DOT_GAP := 5.0
const _TAIL_TO_BODY_GAP := 4.0
const _HEAD_MARGIN := 12.0 ## espace entre le haut du sprite du PNJ et la pointe de la file de ronds

## Decalage horizontal des ronds (retour utilisateur 2026-09-05, "la petite fixe la moyenne
## decalee de 5px et la 3e de 2px de plus") : DotNear reste pile sous la pointe (0px), DotMid part
## de 5px, DotFar de 5+2=7px - la file dessine ainsi une legere diagonale montante plutot qu'une
## colonne parfaitement verticale, plus proche d'une vraie file de bulles BD.
const _DOT_MID_OFFSET_X := 5.0
const _DOT_FAR_OFFSET_X := 7.0

@export_range(0.0, 10.0, 0.5) var idle_bob_amplitude: float = 3.0
## Largeur du texte adaptee a sa longueur (2026-10-08, retour de Steve "adapter la taille de la
## bulle en fonction de la longueur des textes" apres la reecriture des bulles a la 1re personne,
## 53 a 129 caracteres) : remplace l'ancienne largeur fixe bubble_text_width (200 px), qui donnait
## une bulle haute et etroite sur les textes longs. Voir _fit_label_width.
## Un texte qui tient sur une ligne en dessous de bubble_max_width garde sa largeur naturelle
## (plancher bubble_min_width) ; au-dela, il est reparti sur le nombre de lignes minimal, a
## largeur egale, pour une bulle equilibree plutot qu'une ligne pleine suivie d'un mot seul.
@export var bubble_min_width: float = 140.0
@export var bubble_max_width: float = 340.0
## Marge laissee entre la bulle et le bord de l'ecran (voir _keep_inside_screen).
@export var screen_edge_margin: float = 8.0

@onready var _body: PanelContainer = $Body
@onready var _label: Label = $Body/Margin/Label
@onready var _dot_near: Panel = $DotNear
@onready var _dot_mid: Panel = $DotMid
@onready var _dot_far: Panel = $DotFar

var _prof_visual: ProfVisual
var _grade: GradeLevel.Grade
var _anchor_position: Vector2 = Vector2.ZERO
var _idle_time: float = 0.0
var _is_showing: bool = false

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	modulate.a = 0.0
	pivot_offset = Vector2.ZERO
	_prof_visual = _find_sibling_prof_visual()
	var question_giver := _find_sibling_question_giver()
	if question_giver:
		_grade = question_giver.grade
	# Si le PNJ n'a pas (encore) de ProfVisual/QuestionGiverComponent - cas non attendu
	# aujourd'hui, tous les PNJ de school.tscn en ont, mais la scene partagee npc_2d.tscn ne peut
	# pas le garantir - la bulle ne s'enregistre pas au scheduler et reste simplement invisible
	# plutot que de planter sur un ancrage introuvable ou une classe inconnue.
	var is_valid := _prof_visual != null and question_giver != null
	set_process(is_valid)
	if is_valid:
		NpcBubbleScheduler.register(self)

func _exit_tree() -> void:
	NpcBubbleScheduler.unregister(self)

func _process(delta: float) -> void:
	_sync_head_anchor()
	if _is_showing:
		_idle_time += delta
		position = _anchor_position + Vector2(0.0, sin(_idle_time * 2.0) * idle_bob_amplitude)
	else:
		position = _anchor_position

func _sync_head_anchor() -> void:
	if _prof_visual.texture == null:
		return
	var half_height: float = _prof_visual.texture.get_height() * _prof_visual.scale.y * 0.5
	_anchor_position = _prof_visual.position - Vector2(0.0, half_height + _HEAD_MARGIN)

func _find_sibling_prof_visual() -> ProfVisual:
	for child in get_parent().get_children():
		if child is ProfVisual:
			return child
	return null

## Meme "recherche du frere par type" que _find_sibling_prof_visual ci-dessus - utilisee ici pour
## connaitre la classe (grade) reelle de ce PNJ, afin de piocher les bulles dans le bon sous-pool
## de NpcBubblePool (voir _ready).
func _find_sibling_question_giver() -> QuestionGiverComponent:
	for child in get_parent().get_children():
		if child is QuestionGiverComponent:
			return child
	return null

## Appelee par NpcBubbleScheduler quand c'est le tour de ce PNJ : tire un texte au hasard, puis
## joue le pop-in. Ne renvoie rien tant que la bulle n'est pas pleinement visible - le scheduler
## attend cette fonction avant de decompter la duree du tour (voir npc_bubble_scheduler.gd).
func show_bubble() -> void:
	var text := NpcBubblePool.get_random_line(_grade)
	if text.is_empty():
		return
	_label.text = text
	_fit_label_width(text)
	await get_tree().process_frame # laisse le Label recalculer sa hauteur (retour a la ligne) sur la nouvelle largeur
	## Un Control ne retrecit jamais tout seul quand sa taille minimale baisse : sans reset_size(),
	## la bulle garderait la taille du texte precedent, plus long (doc Control.reset_size).
	_body.reset_size()
	await get_tree().process_frame
	_body.reset_size()
	_layout_bubble()
	_keep_inside_screen()
	_is_showing = true
	await _pop_in()

## Appelee par NpcBubbleScheduler a la fin du tour de ce PNJ : joue le pop-out et ne renvoie rien
## tant que la bulle n'est pas pleinement invisible - garantit qu'aucune autre bulle ne commence a
## apparaitre pendant que celle-ci disparait encore.
func hide_bubble() -> void:
	await _pop_out()
	_is_showing = false

## Place Body et les 3 ronds au-dessus de la pointe (0,0), une fois la taille du Body connue -
## variable a chaque cycle puisque le texte change (voir show_bubble).
func _layout_bubble() -> void:
	var body_size: Vector2 = _body.size
	var trail_height := _DOT_GAP * 2.0 + _DOT_SIZE_NEAR + _DOT_SIZE_MID + _DOT_SIZE_FAR
	_body.position = Vector2(-body_size.x * 0.5, -body_size.y - _TAIL_TO_BODY_GAP - trail_height)
	_dot_near.position = Vector2(-_DOT_SIZE_NEAR * 0.5, -_DOT_SIZE_NEAR)
	_dot_mid.position = Vector2(-_DOT_SIZE_MID * 0.5 + _DOT_MID_OFFSET_X, -_DOT_SIZE_NEAR - _DOT_GAP - _DOT_SIZE_MID)
	_dot_far.position = Vector2(-_DOT_SIZE_FAR * 0.5 + _DOT_FAR_OFFSET_X, -_DOT_SIZE_NEAR - _DOT_GAP - _DOT_SIZE_MID - _DOT_GAP - _DOT_SIZE_FAR)

## Calcule la largeur du Label selon la longueur reelle du texte, mesuree avec la police et la
## taille effectivement utilisees par le Label (Font.get_string_size, une seule ligne).
func _fit_label_width(text: String) -> void:
	var font: Font = _label.get_theme_font("font")
	var font_size: int = _label.get_theme_font_size("font_size")
	var natural_width: float = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size).x
	var width: float = natural_width
	if natural_width > bubble_max_width:
		var line_count: float = ceilf(natural_width / bubble_max_width)
		## +10 % : le retour a la ligne se fait par mots entiers, chaque ligne perd donc un peu de
		## place - sans cette marge, le dernier mot passerait souvent sur une ligne de plus.
		width = minf(bubble_max_width, natural_width / line_count * 1.1)
	_label.custom_minimum_size.x = clampf(ceilf(width), bubble_min_width, bubble_max_width)

## Decale horizontalement le corps de la bulle (pas les petits ronds, qui restent sous la tete du
## PNJ) s'il deborde de l'ecran - cas du PNJ du CM2, proche du bord droit, avec un texte long.
## Coordonnees ecran via get_global_transform_with_canvas() (tient compte de la camera).
func _keep_inside_screen() -> void:
	var screen_width: float = get_viewport_rect().size.x
	var anchor_x: float = get_global_transform_with_canvas().origin.x
	var body_left: float = anchor_x + _body.position.x
	var body_right: float = body_left + _body.size.x
	var shift: float = 0.0
	if body_left < screen_edge_margin:
		shift = screen_edge_margin - body_left
	elif body_right > screen_width - screen_edge_margin:
		shift = (screen_width - screen_edge_margin) - body_right
	## Jamais au point que les petits ronds sortent de sous la bulle.
	var max_shift: float = maxf(0.0, _body.size.x * 0.5 - 24.0)
	_body.position.x += clampf(shift, -max_shift, max_shift)

func _pop_in() -> void:
	scale = Vector2(0.6, 0.6)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate:a", 1.0, 0.54)
	tween.tween_property(self, "scale", Vector2.ONE, 0.66).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tween.finished

func _pop_out() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.45)
	tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
