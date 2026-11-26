## Mini-jeu du CE2 n°1 : Saute-mouton (2026-11-25, propose par Clementine). Un animal de la
## collection CE2 court tout seul ; un clic ou un tap n'importe ou le fait sauter par-dessus les
## obstacles. 1 point par obstacle franchi ; toucher un obstacle = 1 vie perdue (3 vies), avec un
## court moment d'invincibilite (l'animal clignote).
##
## Progression : la course accelere a chaque point ; apparaissent ensuite des barrieres hautes
## (a partir de FENCE_FROM_SCORE points) puis des doubles buissons (DOUBLE_FROM_SCORE points).
## Un seul geste (taper) : ideal sur tablette. Un tap juste avant d'atterrir est garde en memoire
## (JUMP_BUFFER) pour ne pas punir un enfant un peu en avance.
##
## Tout est dessine dans _draw(). background_texture (optionnel) : image de fond fixe a la place
## du ciel et des collines dessines ; le sol (GROUND_Y) reste dessine par-dessus.
class_name SauteMouton
extends MiniGame

const GAME_ID := "saute_mouton"
const TITLE := "Saute-mouton"
const RULES := "Ton animal court tout seul : touche l'écran ou clique pour le faire sauter par-dessus les obstacles. Attention, ça va de plus en plus vite ! Tu as 3 vies."

enum Kind { BUSH, ROCK, FENCE, DOUBLE }

class Obstacle:
	var kind: int = 0
	var rect: Rect2 = Rect2()
	var passed: bool = false
	var hit: bool = false

const START_LIVES := 3
const GROUND_Y := 540.0
const RUNNER_X := 220.0
const RUNNER_HEIGHT := 110.0
const GRAVITY := 2600.0
const JUMP_VELOCITY := -980.0
const JUMP_BUFFER := 0.12
const BASE_SPEED := 320.0
const SPEED_PER_POINT := 8.0
const MAX_SPEED := 680.0
const MIN_GAP_SECONDS := 0.95
const MAX_GAP_SECONDS := 1.8
const INVINCIBLE_SECONDS := 1.2
const FENCE_FROM_SCORE := 10
const DOUBLE_FROM_SCORE := 20
const HITBOX_SHRINK := 0.25

const SKY_COLOR := Color(0.65, 0.85, 0.98)
const HILL_COLOR := Color(0.55, 0.78, 0.5)
const GROUND_COLOR := Color(0.85, 0.7, 0.45)
const GROUND_LINE_COLOR := Color(0.47, 0.73, 0.38)
const GROUND_DASH_COLOR := Color(0.75, 0.6, 0.38)
const BUSH_COLOR := Color(0.3, 0.62, 0.3)
const ROCK_COLOR := Color(0.55, 0.55, 0.58)
const FENCE_COLOR := Color(0.62, 0.42, 0.25)

@export var background_texture: Texture2D

var _playing: bool = false
var _score: int = 0
var _lives: int = START_LIVES
var _runner_y: float = GROUND_Y
var _velocity_y: float = 0.0
var _jump_buffer: float = 0.0
var _invincible: float = 0.0
var _distance: float = 0.0
var _next_obstacle_in: float = 0.0
var _obstacles: Array[Obstacle] = []
var _runner_texture: Texture2D = null
var _runner_size: Vector2 = Vector2(80, RUNNER_HEIGHT)

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	var textures := MiniGame.get_grade_textures(grade)
	if not textures.is_empty():
		_runner_texture = textures.pick_random()
		var texture_size := _runner_texture.get_size()
		_runner_size = Vector2(RUNNER_HEIGHT * texture_size.x / texture_size.y, RUNNER_HEIGHT)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_score = 0
	_lives = START_LIVES
	_runner_y = GROUND_Y
	_velocity_y = 0.0
	_jump_buffer = 0.0
	_invincible = 0.0
	_obstacles.clear()
	_next_obstacle_in = 1.2 * BASE_SPEED
	_playing = true
	_hud.start_play(START_LIVES)

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score)

func _close() -> void:
	closed.emit()

func _speed() -> float:
	return minf(MAX_SPEED, BASE_SPEED + SPEED_PER_POINT * float(_score))

func _on_ground() -> bool:
	return _runner_y >= GROUND_Y and _velocity_y >= 0.0

func _gui_input(event: InputEvent) -> void:
	if not _playing:
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT or not button.pressed:
		return
	accept_event()
	if _on_ground():
		_jump()
	else:
		_jump_buffer = JUMP_BUFFER

func _jump() -> void:
	_velocity_y = JUMP_VELOCITY
	_jump_buffer = 0.0
	SoundManager.play(SoundManager.Sfx.CLICK)

func _process(delta: float) -> void:
	if _playing:
		_update_game(delta)
	queue_redraw()

func _update_game(delta: float) -> void:
	var speed := _speed()
	_distance += speed * delta
	_invincible = maxf(0.0, _invincible - delta)
	_jump_buffer = maxf(0.0, _jump_buffer - delta)
	## Saut.
	_velocity_y += GRAVITY * delta
	_runner_y += _velocity_y * delta
	if _runner_y >= GROUND_Y:
		_runner_y = GROUND_Y
		_velocity_y = 0.0
		if _jump_buffer > 0.0:
			_jump()
	## Obstacles.
	_next_obstacle_in -= speed * delta
	if _next_obstacle_in <= 0.0:
		_spawn_obstacle()
		_next_obstacle_in = speed * randf_range(MIN_GAP_SECONDS, MAX_GAP_SECONDS)
	var hitbox := _runner_rect().grow_individual(-_runner_size.x * HITBOX_SHRINK, -_runner_size.y * HITBOX_SHRINK, -_runner_size.x * HITBOX_SHRINK, 0.0)
	for i in range(_obstacles.size() - 1, -1, -1):
		var obstacle := _obstacles[i]
		obstacle.rect.position.x -= speed * delta
		if obstacle.rect.end.x < -50.0:
			_obstacles.remove_at(i)
			continue
		if not obstacle.hit and _invincible <= 0.0 and hitbox.intersects(obstacle.rect):
			obstacle.hit = true
			_lives -= 1
			_invincible = INVINCIBLE_SECONDS
			SoundManager.play(SoundManager.Sfx.WRONG)
			_hud.set_lives(_lives, START_LIVES)
			if _lives <= 0:
				_end_game()
				return
		if not obstacle.passed and obstacle.rect.end.x < hitbox.position.x:
			obstacle.passed = true
			if not obstacle.hit:
				_score += 1
				_hud.set_score(_score)
				SoundManager.play(SoundManager.Sfx.CORRECT)

func _spawn_obstacle() -> void:
	var kinds: Array[int] = [Kind.BUSH, Kind.ROCK]
	if _score >= FENCE_FROM_SCORE:
		kinds.append(Kind.FENCE)
	if _score >= DOUBLE_FROM_SCORE:
		kinds.append(Kind.DOUBLE)
	var obstacle := Obstacle.new()
	obstacle.kind = kinds.pick_random()
	var obstacle_size := Vector2(56, 52)
	match obstacle.kind:
		Kind.ROCK:
			obstacle_size = Vector2(50, 42)
		Kind.FENCE:
			obstacle_size = Vector2(34, 86)
		Kind.DOUBLE:
			obstacle_size = Vector2(112, 52)
	obstacle.rect = Rect2(Vector2(size.x + 20.0, GROUND_Y - obstacle_size.y), obstacle_size)
	_obstacles.append(obstacle)

func _runner_rect() -> Rect2:
	return Rect2(Vector2(RUNNER_X - _runner_size.x * 0.5, _runner_y - _runner_size.y + 8.0), _runner_size)

func _draw() -> void:
	if background_texture:
		draw_texture_rect(background_texture, Rect2(Vector2.ZERO, size), false)
	else:
		draw_rect(Rect2(0, 0, size.x, GROUND_Y), SKY_COLOR)
		## Collines qui defilent lentement (effet de profondeur).
		var hill_offset := fmod(_distance * 0.25, 360.0)
		var x := -hill_offset
		while x < size.x + 360.0:
			draw_circle(Vector2(x + 180.0, GROUND_Y + 40.0), 200.0, HILL_COLOR)
			x += 360.0
	draw_rect(Rect2(0, GROUND_Y, size.x, size.y - GROUND_Y), GROUND_COLOR)
	draw_rect(Rect2(0, GROUND_Y - 4.0, size.x, 8.0), GROUND_LINE_COLOR)
	var dash_offset := fmod(_distance, 80.0)
	var dash_x := -dash_offset
	while dash_x < size.x:
		draw_rect(Rect2(dash_x, GROUND_Y + 30.0, 36.0, 6.0), GROUND_DASH_COLOR)
		dash_x += 80.0
	for obstacle in _obstacles:
		_draw_obstacle(obstacle)
	## Clignote pendant l'invincibilite.
	if _invincible > 0.0 and fmod(_invincible, 0.2) < 0.1:
		return
	if _runner_texture:
		draw_texture_rect(_runner_texture, _runner_rect(), false)
	else:
		draw_rect(_runner_rect(), GradeLevel.get_color(grade))

func _draw_obstacle(obstacle: Obstacle) -> void:
	var rect := obstacle.rect
	match obstacle.kind:
		Kind.BUSH, Kind.DOUBLE:
			var bush_count := 2 if obstacle.kind == Kind.DOUBLE else 1
			var bush_width := rect.size.x / bush_count
			for b in bush_count:
				var left := rect.position.x + bush_width * b
				var radius := bush_width * 0.32
				draw_circle(Vector2(left + bush_width * 0.3, rect.end.y - radius), radius, BUSH_COLOR)
				draw_circle(Vector2(left + bush_width * 0.7, rect.end.y - radius), radius, BUSH_COLOR)
				draw_circle(Vector2(left + bush_width * 0.5, rect.position.y + radius), radius, BUSH_COLOR)
				draw_rect(Rect2(left + bush_width * 0.2, rect.position.y + radius, bush_width * 0.6, rect.size.y - radius), BUSH_COLOR)
		Kind.ROCK:
			var points := PackedVector2Array([
				Vector2(rect.position.x, rect.end.y), Vector2(rect.position.x + rect.size.x * 0.15, rect.position.y + rect.size.y * 0.3),
				Vector2(rect.position.x + rect.size.x * 0.55, rect.position.y), Vector2(rect.end.x - rect.size.x * 0.1, rect.position.y + rect.size.y * 0.35),
				Vector2(rect.end.x, rect.end.y)])
			draw_colored_polygon(points, ROCK_COLOR)
		Kind.FENCE:
			draw_rect(Rect2(rect.position.x + 4.0, rect.position.y, 10.0, rect.size.y), FENCE_COLOR)
			draw_rect(Rect2(rect.end.x - 14.0, rect.position.y, 10.0, rect.size.y), FENCE_COLOR)
			draw_rect(Rect2(rect.position.x, rect.position.y + 14.0, rect.size.x, 9.0), FENCE_COLOR)
			draw_rect(Rect2(rect.position.x, rect.position.y + 48.0, rect.size.x, 9.0), FENCE_COLOR)
