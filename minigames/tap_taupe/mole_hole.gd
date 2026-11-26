## Un trou de Tap taupe (2026-11-25). Le noeud couvre la zone AU-DESSUS du trou + le trou : le
## centre du trou ovale est en bas au milieu, a HOLE_DEPTH du bord inferieur. A placer dans le
## jeu sur chaque trou du decor (vue a 45 degres par le haut).
##
## La creature (taupe, taupe en or, serpent) est dessinee dans l'enfant Clip, qui coupe tout ce
## qui depasse sous la ligne du centre du trou : elle semble sortir du trou et y replonger.
## show_hole dessine un trou ovale provisoire - a decocher quand le decor a ses propres trous.
##
## Toucher (clic ou tap) n'importe ou dans la zone pendant que la creature est sortie = touche :
## zone genereuse expres pour les petits doigts sur tablette.
class_name MoleHole
extends Control

signal whacked(hole: MoleHole, kind: int)
signal escaped(hole: MoleHole, kind: int)

enum Kind { MOLE, GOLD, SNAKE }
enum Phase { EMPTY, RISING, UP, HIT, SINKING }

const RISE_SECONDS := 0.15
const HIT_SECONDS := 0.35
## Distance entre le centre du trou et le bas du noeud (= bas de Clip dans la scene).
const HOLE_DEPTH := 30.0
const HOLE_RADII := Vector2(60, 24)
const CREATURE_SIZE := Vector2(96, 110)

const HOLE_RIM_COLOR := Color(0.45, 0.32, 0.2)
const HOLE_COLOR := Color(0.18, 0.12, 0.08)
const MOLE_COLOR := Color(0.45, 0.31, 0.22)
const GOLD_COLOR := Color(1.0, 0.78, 0.2)
const SNAKE_COLOR := Color(0.35, 0.7, 0.3)
const SNAKE_STRIPE_COLOR := Color(0.2, 0.5, 0.18)
const NOSE_COLOR := Color(1.0, 0.6, 0.7)
const EYE_COLOR := Color(0.1, 0.08, 0.06)
const SNAKE_EYE_COLOR := Color(1.0, 0.9, 0.2)
const TONGUE_COLOR := Color(0.9, 0.15, 0.2)
const SPARKLE_COLOR := Color(1, 1, 1, 0.9)
const HIT_STAR_COLOR := Color(1.0, 0.85, 0.2)
const HIT_TINT := Color(1, 0.6, 0.6)

@export var show_hole: bool = true:
	set(value):
		show_hole = value
		queue_redraw()

var kind: int = Kind.MOLE
var _phase: Phase = Phase.EMPTY
var _timer: float = 0.0
var _up_seconds: float = 1.0
var _rise: float = 0.0
var _was_hit: bool = false
## Visuels optionnels fournis par le jeu (Kind -> Texture2D) ; sinon dessin provisoire.
var _textures: Dictionary = {}

@onready var _clip: Control = $Clip

func _ready() -> void:
	_clip.draw.connect(_draw_creature)
	_clip.gui_input.connect(_on_clip_gui_input)

func is_free() -> bool:
	return _phase == Phase.EMPTY

func set_textures(textures: Dictionary) -> void:
	_textures = textures

func pop(new_kind: int, up_seconds: float) -> void:
	kind = new_kind
	_up_seconds = up_seconds
	_phase = Phase.RISING
	_timer = 0.0
	_rise = 0.0
	_was_hit = false

func clear() -> void:
	_phase = Phase.EMPTY
	_rise = 0.0
	_clip.queue_redraw()

func _process(delta: float) -> void:
	if _phase == Phase.EMPTY:
		return
	_timer += delta
	match _phase:
		Phase.RISING:
			_rise = minf(1.0, _timer / RISE_SECONDS)
			if _rise >= 1.0:
				_phase = Phase.UP
				_timer = 0.0
		Phase.UP:
			if _timer >= _up_seconds:
				_phase = Phase.SINKING
				_timer = 0.0
		Phase.HIT:
			if _timer >= HIT_SECONDS:
				_phase = Phase.SINKING
				_timer = 0.0
		Phase.SINKING:
			_rise = maxf(0.0, 1.0 - _timer / RISE_SECONDS)
			if _rise <= 0.0:
				_phase = Phase.EMPTY
				if not _was_hit:
					escaped.emit(self, kind)
	_clip.queue_redraw()

func _on_clip_gui_input(event: InputEvent) -> void:
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT or not button.pressed:
		return
	if _phase != Phase.RISING and _phase != Phase.UP:
		return
	_was_hit = true
	_phase = Phase.HIT
	_timer = 0.0
	_clip.accept_event()
	whacked.emit(self, kind)

func _draw() -> void:
	if not show_hole:
		return
	var center := Vector2(size.x * 0.5, size.y - HOLE_DEPTH)
	draw_colored_polygon(_ellipse(center, HOLE_RADII + Vector2(8, 5)), HOLE_RIM_COLOR)
	draw_colored_polygon(_ellipse(center, HOLE_RADII), HOLE_COLOR)

## Dessine dans Clip (connecte a son signal draw).
func _draw_creature() -> void:
	if _rise <= 0.0:
		return
	var top := _clip.size.y + 12.0 - CREATURE_SIZE.y * _rise
	var rect := Rect2(_clip.size.x * 0.5 - CREATURE_SIZE.x * 0.5, top, CREATURE_SIZE.x, CREATURE_SIZE.y)
	var texture := _textures.get(kind) as Texture2D
	if texture:
		_clip.draw_texture_rect(texture, rect, false, HIT_TINT if _phase == Phase.HIT else Color.WHITE)
	elif kind == Kind.SNAKE:
		_draw_snake(rect)
	else:
		_draw_mole(rect, kind == Kind.GOLD)
	if _phase == Phase.HIT:
		for offset in [Vector2(-34, 6), Vector2(0, -8), Vector2(34, 6)]:
			_clip.draw_colored_polygon(_star(rect.position + Vector2(rect.size.x * 0.5, 0) + (offset as Vector2), 9.0), HIT_STAR_COLOR)

func _draw_mole(rect: Rect2, gold: bool) -> void:
	var body := GOLD_COLOR if gold else MOLE_COLOR
	var cx := rect.position.x + rect.size.x * 0.5
	var y := rect.position.y
	_clip.draw_rect(Rect2(cx - 40.0, y + 40.0, 80.0, rect.size.y - 40.0), body)
	_clip.draw_circle(Vector2(cx, y + 40.0), 40.0, body)
	_draw_eyes(Vector2(cx, y + 32.0), 14.0, EYE_COLOR)
	_clip.draw_circle(Vector2(cx, y + 48.0), 9.0, NOSE_COLOR)
	_clip.draw_rect(Rect2(cx - 6.0, y + 57.0, 12.0, 9.0), Color.WHITE)
	if gold:
		for offset in [Vector2(-30, 8), Vector2(32, 20)]:
			_clip.draw_colored_polygon(_star(Vector2(cx, y) + (offset as Vector2), 6.0), SPARKLE_COLOR)

func _draw_snake(rect: Rect2) -> void:
	var cx := rect.position.x + rect.size.x * 0.5
	var y := rect.position.y
	_clip.draw_rect(Rect2(cx - 22.0, y + 30.0, 44.0, rect.size.y - 30.0), SNAKE_COLOR)
	var stripe_y := y + 60.0
	while stripe_y < rect.end.y:
		_clip.draw_rect(Rect2(cx - 22.0, stripe_y, 44.0, 7.0), SNAKE_STRIPE_COLOR)
		stripe_y += 20.0
	_clip.draw_circle(Vector2(cx, y + 30.0), 28.0, SNAKE_COLOR)
	_draw_eyes(Vector2(cx, y + 24.0), 12.0, SNAKE_EYE_COLOR)
	if _phase != Phase.HIT:
		var tongue := PackedVector2Array([Vector2(cx, y + 50.0), Vector2(cx, y + 64.0), Vector2(cx - 6.0, y + 71.0)])
		_clip.draw_polyline(tongue, TONGUE_COLOR, 3.0)
		_clip.draw_line(Vector2(cx, y + 64.0), Vector2(cx + 6.0, y + 71.0), TONGUE_COLOR, 3.0)

## Deux yeux ; en croix quand la creature vient d'etre touchee.
func _draw_eyes(center: Vector2, spacing: float, color: Color) -> void:
	for side in [-1.0, 1.0]:
		var eye := center + Vector2(spacing * float(side), 0)
		if _phase == Phase.HIT:
			_clip.draw_line(eye + Vector2(-5, -5), eye + Vector2(5, 5), EYE_COLOR, 3.0)
			_clip.draw_line(eye + Vector2(-5, 5), eye + Vector2(5, -5), EYE_COLOR, 3.0)
		else:
			_clip.draw_circle(eye, 6.0, color)
			_clip.draw_circle(eye + Vector2(-1.5, -1.5), 1.8, Color.WHITE if color == EYE_COLOR else EYE_COLOR)

static func _ellipse(center: Vector2, radii: Vector2) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in 32:
		var angle := TAU * i / 32.0
		points.append(center + Vector2(cos(angle) * radii.x, sin(angle) * radii.y))
	return points

static func _star(center: Vector2, radius: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in 10:
		var r := radius if i % 2 == 0 else radius * 0.45
		points.append(center + Vector2.UP.rotated(TAU * i / 10.0) * r)
	return points
