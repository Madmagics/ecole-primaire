## Utilitaire partage (2026-10-03, demande Steve : "dans les fiches ou sont presentes des fleches
## pour passer d'une feuille a l'autre (cartes d'animaux, cours), je veux pouvoir scroller
## horizontalement en mode tactile") : un glissement horizontal du doigt sur [member area] tourne
## la page, exactement comme un appui sur la fleche correspondante. Doigt vers la gauche = page
## suivante, doigt vers la droite = page precedente (sens habituel d'un livre / d'une galerie).
##
## Ecoute dans _input() (et non gui_input) : le geste doit marcher meme s'il demarre sur un enfant
## qui absorbe les evenements (carte, texte de la fiche...). Seuls les vrais evenements tactiles
## (InputEventScreenTouch / InputEventScreenDrag) sont pris en compte : a la souris sur PC, rien
## ne change, on garde les fleches.
##
## [method has_moved] permet a un element "tapable" place dans la zone (ex. carte de l'album qui
## s'agrandit au clic) de ne PAS reagir quand le doigt a glisse : sur mobile, Godot envoie aussi
## un clic souris emule a partir du toucher (Emulate Mouse From Touch, actif par defaut), et sans
## ce garde-fou un glissement commence sur une carte l'ouvrirait en grand.
class_name SwipePager
extends Node

## Distance horizontale minimale (en pixels du viewport de base 1152x648) pour tourner la page.
const SWIPE_MIN_DISTANCE := 60.0
## Le geste doit etre nettement plus horizontal que vertical (evite les faux positifs).
const HORIZONTAL_RATIO := 1.5
## Au-dela de cette distance, le geste n'est plus considere comme un simple tap (voir has_moved).
const TAP_MAX_DISTANCE := 20.0

var area: Control
var on_prev: Callable
var on_next: Callable
## Optionnel : renvoie false pour desactiver temporairement le glissement (ex. carte zoomee).
var can_swipe: Callable

var _touch_index := -1
var _start := Vector2.ZERO
var _moved := false

## Cree le detecteur et l'ajoute comme enfant de [param swipe_area] (il vit et meurt avec elle).
static func attach(swipe_area: Control, prev_callback: Callable, next_callback: Callable,
		enabled_callback: Callable = Callable()) -> SwipePager:
	var pager := SwipePager.new()
	pager.name = "SwipePager"
	pager.area = swipe_area
	pager.on_prev = prev_callback
	pager.on_next = next_callback
	pager.can_swipe = enabled_callback
	swipe_area.add_child(pager)
	return pager

## Vrai si le doigt actuellement (ou dernierement) pose a glisse au-dela d'un simple tap.
func has_moved() -> bool:
	return _moved

func _input(event: InputEvent) -> void:
	if area == null or not area.is_visible_in_tree() \
			or (can_swipe.is_valid() and not can_swipe.call()):
		_touch_index = -1
		return
	if event is InputEventScreenTouch:
		var touch := event as InputEventScreenTouch
		if touch.pressed:
			if _touch_index == -1 and _contains(touch.position):
				_touch_index = touch.index
				_start = touch.position
				_moved = false
		elif touch.index == _touch_index:
			_touch_index = -1
			if touch.canceled:
				return
			var delta := touch.position - _start
			if absf(delta.x) >= SWIPE_MIN_DISTANCE and absf(delta.x) > absf(delta.y) * HORIZONTAL_RATIO:
				if delta.x < 0.0:
					on_next.call()
				else:
					on_prev.call()
	elif event is InputEventScreenDrag:
		var drag := event as InputEventScreenDrag
		if drag.index == _touch_index and drag.position.distance_to(_start) > TAP_MAX_DISTANCE:
			_moved = true

## Position du toucher (coordonnees du viewport) convertie dans le repere local de la zone :
## get_global_transform_with_canvas() tient compte du CanvasLayer "UI" eventuel.
func _contains(viewport_position: Vector2) -> bool:
	var local_position := area.get_global_transform_with_canvas().affine_inverse() * viewport_position
	return Rect2(Vector2.ZERO, area.size).has_point(local_position)
