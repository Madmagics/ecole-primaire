## Voile noir transparent (50 %) plein ecran du tutoriel, perce d'un cercle autour de la cible du
## moment (PNJ du CP, icone de menu, coffre...). Tout ce qui est sous le voile est inactif : ce
## Control arrete les clics (mouse_filter STOP), SAUF dans le cercle, ou _has_point() renvoie
## false - le clic "traverse" alors vers ce qui est dessous (bouton d'UI, ou zone de clic Area2D du
## PNJ via le picking physique du viewport, qui ne recoit l'evenement que si aucun Control ne l'a
## pris). _has_point : methode virtuelle de Control, coordonnees locales (doc Godot 4.x).
## Le cercle suit sa cible a chaque frame (respiration du prof, mise en page des menus).
class_name TutorialSpotlight
extends ColorRect

const RING_MARGIN := 14.0

var _target: CanvasItem = null
var _fixed_radius: float = 0.0
var _hole_center := Vector2.ZERO
var _hole_radius := 0.0

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	color = Color(0, 0, 0, 0)

## Voile avec un cercle autour de [target] (Control ou Node2D). [radius] <= 0 : rayon deduit de la
## taille de la cible.
func focus_on(target: CanvasItem, radius: float = 0.0) -> void:
	_target = target
	_fixed_radius = radius
	show()
	_update_hole()

## Voile plein, sans trou (tout est inactif).
func dim_all() -> void:
	_target = null
	show()
	_update_hole()

func clear() -> void:
	_target = null
	hide()

func _process(_delta: float) -> void:
	if visible:
		_update_hole()

func _update_hole() -> void:
	var has_hole := _target != null and is_instance_valid(_target) and _target.is_visible_in_tree()
	if has_hole:
		if _target is Control:
			var rect := (_target as Control).get_global_rect()
			_hole_center = rect.get_center()
			_hole_radius = _fixed_radius if _fixed_radius > 0.0 else maxf(rect.size.x, rect.size.y) * 0.5 + RING_MARGIN
		else:
			_hole_center = _target.get_global_transform_with_canvas().origin
			_hole_radius = _fixed_radius
	var mat := material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("rect_size", size)
		mat.set_shader_parameter("has_hole", has_hole)
		mat.set_shader_parameter("hole_center", _hole_center)
		mat.set_shader_parameter("hole_radius", _hole_radius)
	if not has_hole:
		_hole_radius = 0.0

func _has_point(point: Vector2) -> bool:
	if _hole_radius > 0.0 and point.distance_to(_hole_center) <= _hole_radius:
		return false
	return Rect2(Vector2.ZERO, size).has_point(point)
