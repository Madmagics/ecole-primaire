## Mini-jeu du CM1 n°1 : Casse-briques (2026-11-25, propose par Valerie). La raquette suit la
## souris ou le doigt ; la balle rebondit pour casser toutes les briques du niveau. Balle perdue
## en bas = 1 vie perdue (3 vies). Toucher l'ecran lance la balle posee sur la raquette.
##
## Progression : chaque niveau ajoute une rangee de briques (jusqu'a MAX_ROWS), plus de briques
## solides (2 coups) et une balle un peu plus rapide. Bonus qui tombent parfois d'une brique
## cassee (a attraper avec la raquette) : "x2" = balles supplementaires, "<>" = raquette plus
## large pendant LARGE_SECONDS secondes.
## Points : 1 par brique cassee + LEVEL_BONUS par niveau termine.
##
## La balle avance par petits pas (MAX_STEP) pour ne jamais traverser une brique a grande vitesse.
class_name CasseBriques
extends MiniGame

const GAME_ID := "casse_briques"
const TITLE := "Casse-briques"
const RULES := "Déplace la raquette avec la souris ou le doigt pour renvoyer la balle et casser toutes les briques. Touche l'écran pour lancer la balle. Tu as 3 vies !"

enum Bonus { MULTI, LARGE }

class Ball:
	var pos: Vector2 = Vector2.ZERO
	var vel: Vector2 = Vector2.ZERO
	var stuck: bool = true

class Brick:
	var rect: Rect2 = Rect2()
	var hits: int = 1
	var color: Color = Color.WHITE

class Capsule:
	var pos: Vector2 = Vector2.ZERO
	var kind: int = 0

const START_LIVES := 3
const FIELD := Rect2(40, 80, 1072, 568)
const PADDLE_Y := 600.0
const PADDLE_HEIGHT := 18.0
const PADDLE_WIDTH := 150.0
const LARGE_PADDLE_WIDTH := 230.0
const PADDLE_SPEED := 1600.0
const BALL_RADIUS := 10.0
const BASE_BALL_SPEED := 360.0
const BALL_SPEED_PER_LEVEL := 25.0
const MAX_BALL_SPEED := 600.0
const MAX_BOUNCE_ANGLE := 1.047 ## 60 degres
const MAX_STEP := 6.0
const BRICK_COLS := 10
const BASE_ROWS := 3
const MAX_ROWS := 7
const BRICK_HEIGHT := 28.0
const BRICK_GAP := 6.0
const BRICKS_TOP := 112.0
const SOLID_CHANCE_PER_LEVEL := 0.1
const MAX_SOLID_CHANCE := 0.5
const HOLE_CHANCE := 0.08
const BONUS_CHANCE := 0.12
const CAPSULE_SPEED := 180.0
const CAPSULE_SIZE := Vector2(46, 24)
const LARGE_SECONDS := 10.0
const LEVEL_BONUS := 10

## Bandeau du haut clair (le texte du Hud y reste lisible), terrain sombre.
const BACKGROUND_COLOR := Color(0.92, 0.94, 0.98)
const FIELD_COLOR := Color(0.16, 0.2, 0.35)
const ROW_COLORS := [Color(0.95, 0.4, 0.4), Color(1.0, 0.6, 0.3), Color(0.98, 0.8, 0.25), Color(0.4, 0.78, 0.4), Color(0.35, 0.6, 0.95), Color(0.72, 0.45, 0.9), Color(0.95, 0.5, 0.75)]
const PADDLE_COLOR := Color(0.98, 0.95, 0.85)
const TEXT_COLOR := Color(1, 1, 1, 0.9)

var _playing: bool = false
var _score: int = 0
var _lives: int = START_LIVES
var _level: int = 0
var _paddle_x: float = 576.0
var _target_x: float = 576.0
var _large_timer: float = 0.0
var _balls: Array[Ball] = []
var _bricks: Array[Brick] = []
var _capsules: Array[Capsule] = []
var _paddle_style: StyleBoxFlat

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_paddle_style = StyleBoxFlat.new()
	_paddle_style.bg_color = PADDLE_COLOR
	_paddle_style.set_corner_radius_all(9)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_score = 0
	_lives = START_LIVES
	_level = 0
	_large_timer = 0.0
	_capsules.clear()
	_paddle_x = FIELD.get_center().x
	_target_x = _paddle_x
	_build_level()
	_reset_ball()
	_playing = true
	_hud.start_play(START_LIVES)

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score)

func _close() -> void:
	closed.emit()

func _ball_speed() -> float:
	return minf(MAX_BALL_SPEED, BASE_BALL_SPEED + BALL_SPEED_PER_LEVEL * _level)

func _paddle_width() -> float:
	return LARGE_PADDLE_WIDTH if _large_timer > 0.0 else PADDLE_WIDTH

func _paddle_rect() -> Rect2:
	var width := _paddle_width()
	return Rect2(_paddle_x - width * 0.5, PADDLE_Y, width, PADDLE_HEIGHT)

func _build_level() -> void:
	_bricks.clear()
	var rows := mini(BASE_ROWS + _level, MAX_ROWS)
	var solid_chance := minf(MAX_SOLID_CHANCE, SOLID_CHANCE_PER_LEVEL * _level)
	var width := (FIELD.size.x - BRICK_GAP * (BRICK_COLS - 1)) / BRICK_COLS
	for row in rows:
		for col in BRICK_COLS:
			if _level > 0 and randf() < HOLE_CHANCE:
				continue
			var brick := Brick.new()
			brick.rect = Rect2(FIELD.position.x + col * (width + BRICK_GAP), BRICKS_TOP + row * (BRICK_HEIGHT + BRICK_GAP), width, BRICK_HEIGHT)
			brick.hits = 2 if randf() < solid_chance else 1
			brick.color = ROW_COLORS[row % ROW_COLORS.size()]
			_bricks.append(brick)

## Une seule balle, posee sur la raquette, en attente d'un tap.
func _reset_ball() -> void:
	_balls.clear()
	var ball := Ball.new()
	ball.stuck = true
	_balls.append(ball)

func _launch_balls() -> void:
	for ball in _balls:
		if ball.stuck:
			ball.stuck = false
			ball.vel = Vector2(randf_range(-0.4, 0.4), -1.0).normalized() * _ball_speed()

func _gui_input(event: InputEvent) -> void:
	if not _playing:
		return
	var mouse := event as InputEventMouse
	if mouse == null:
		return
	if event is InputEventMouseMotion or (event is InputEventMouseButton and (event as InputEventMouseButton).pressed):
		var half := _paddle_width() * 0.5
		_target_x = clampf(mouse.position.x, FIELD.position.x + half, FIELD.end.x - half)
		accept_event()
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		_launch_balls()

func _process(delta: float) -> void:
	if _playing:
		_update_game(delta)
	queue_redraw()

func _update_game(delta: float) -> void:
	_large_timer = maxf(0.0, _large_timer - delta)
	var half := _paddle_width() * 0.5
	_target_x = clampf(_target_x, FIELD.position.x + half, FIELD.end.x - half)
	_paddle_x = move_toward(_paddle_x, _target_x, PADDLE_SPEED * delta)
	_update_capsules(delta)
	for i in range(_balls.size() - 1, -1, -1):
		var ball := _balls[i]
		if ball.stuck:
			ball.pos = Vector2(_paddle_x, PADDLE_Y - BALL_RADIUS - 1.0)
			continue
		var distance := ball.vel.length() * delta
		var steps := maxi(1, ceili(distance / MAX_STEP))
		for _step in steps:
			ball.pos += ball.vel * (delta / steps)
			_collide_walls(ball)
			_collide_paddle(ball)
			if _collide_bricks(ball):
				break
		if ball.pos.y - BALL_RADIUS > size.y:
			_balls.remove_at(i)
	if _balls.is_empty():
		_lives -= 1
		SoundManager.play(SoundManager.Sfx.WRONG)
		_hud.set_lives(_lives, START_LIVES)
		if _lives <= 0:
			_end_game()
			return
		_capsules.clear()
		_reset_ball()
	if _bricks.is_empty():
		_score += LEVEL_BONUS
		_hud.set_score(_score)
		SoundManager.play(SoundManager.Sfx.PACK_REWARD)
		_level += 1
		_capsules.clear()
		_build_level()
		_reset_ball()

func _collide_walls(ball: Ball) -> void:
	if ball.pos.x - BALL_RADIUS < FIELD.position.x:
		ball.pos.x = FIELD.position.x + BALL_RADIUS
		ball.vel.x = absf(ball.vel.x)
	elif ball.pos.x + BALL_RADIUS > FIELD.end.x:
		ball.pos.x = FIELD.end.x - BALL_RADIUS
		ball.vel.x = -absf(ball.vel.x)
	if ball.pos.y - BALL_RADIUS < FIELD.position.y:
		ball.pos.y = FIELD.position.y + BALL_RADIUS
		ball.vel.y = absf(ball.vel.y)

## L'angle de renvoi depend de l'endroit ou la balle touche la raquette (bord = plus penche).
func _collide_paddle(ball: Ball) -> void:
	if ball.vel.y <= 0.0:
		return
	var paddle := _paddle_rect()
	if paddle.grow(BALL_RADIUS).has_point(ball.pos) and ball.pos.y < PADDLE_Y + PADDLE_HEIGHT * 0.5:
		var offset := clampf((ball.pos.x - _paddle_x) / (paddle.size.x * 0.5), -1.0, 1.0)
		var angle := offset * MAX_BOUNCE_ANGLE
		ball.vel = Vector2(sin(angle), -cos(angle)) * _ball_speed()
		ball.pos.y = PADDLE_Y - BALL_RADIUS
		SoundManager.play(SoundManager.Sfx.CLICK)

func _collide_bricks(ball: Ball) -> bool:
	for i in _bricks.size():
		var brick := _bricks[i]
		var closest := Vector2(clampf(ball.pos.x, brick.rect.position.x, brick.rect.end.x), clampf(ball.pos.y, brick.rect.position.y, brick.rect.end.y))
		if ball.pos.distance_to(closest) > BALL_RADIUS:
			continue
		## Rebond sur l'axe ou la balle s'enfonce le moins dans la brique.
		var overlap_x := minf(ball.pos.x + BALL_RADIUS - brick.rect.position.x, brick.rect.end.x - (ball.pos.x - BALL_RADIUS))
		var overlap_y := minf(ball.pos.y + BALL_RADIUS - brick.rect.position.y, brick.rect.end.y - (ball.pos.y - BALL_RADIUS))
		if overlap_x < overlap_y:
			ball.vel.x = -ball.vel.x
		else:
			ball.vel.y = -ball.vel.y
		brick.hits -= 1
		if brick.hits <= 0:
			_bricks.remove_at(i)
			_score += 1
			_hud.set_score(_score)
			SoundManager.play(SoundManager.Sfx.CORRECT)
			if randf() < BONUS_CHANCE:
				var capsule := Capsule.new()
				capsule.pos = brick.rect.get_center()
				capsule.kind = [Bonus.MULTI, Bonus.LARGE].pick_random()
				_capsules.append(capsule)
		else:
			SoundManager.play(SoundManager.Sfx.CLICK)
		return true
	return false

func _update_capsules(delta: float) -> void:
	var paddle := _paddle_rect()
	for i in range(_capsules.size() - 1, -1, -1):
		var capsule := _capsules[i]
		capsule.pos.y += CAPSULE_SPEED * delta
		var rect := Rect2(capsule.pos - CAPSULE_SIZE * 0.5, CAPSULE_SIZE)
		if rect.intersects(paddle):
			_capsules.remove_at(i)
			_apply_bonus(capsule.kind)
		elif capsule.pos.y > size.y + CAPSULE_SIZE.y:
			_capsules.remove_at(i)

func _apply_bonus(kind: int) -> void:
	SoundManager.play(SoundManager.Sfx.PURCHASE)
	if kind == Bonus.LARGE:
		_large_timer = LARGE_SECONDS
		return
	var source: Ball = null
	for ball in _balls:
		if not ball.stuck:
			source = ball
			break
	if source == null:
		return
	for angle in [-0.35, 0.35]:
		var extra := Ball.new()
		extra.stuck = false
		extra.pos = source.pos
		extra.vel = source.vel.rotated(float(angle))
		_balls.append(extra)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	draw_rect(FIELD, FIELD_COLOR)
	for brick in _bricks:
		var rect := brick.rect
		draw_rect(rect, brick.color.darkened(0.25) if brick.hits > 1 else brick.color)
		draw_rect(Rect2(rect.position, Vector2(rect.size.x, 5.0)), brick.color.lightened(0.35))
		if brick.hits > 1:
			draw_rect(rect, Color(1, 1, 1, 0.8), false, 3.0)
	var font := get_theme_default_font()
	for capsule in _capsules:
		var rect := Rect2(capsule.pos - CAPSULE_SIZE * 0.5, CAPSULE_SIZE)
		draw_rect(rect, Color(0.98, 0.8, 0.25) if capsule.kind == Bonus.MULTI else Color(0.4, 0.85, 0.95))
		draw_string(font, Vector2(rect.position.x, rect.position.y + 19.0), "x2" if capsule.kind == Bonus.MULTI else "<>", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 18, Color(0.15, 0.15, 0.2))
	if _playing or not _bricks.is_empty():
		draw_style_box(_paddle_style, _paddle_rect())
	for ball in _balls:
		draw_circle(ball.pos, BALL_RADIUS, Color.WHITE)
	if _playing and not _balls.is_empty() and _balls[0].stuck:
		draw_string(font, Vector2(0, 470), "Touche l'écran pour lancer la balle", HORIZONTAL_ALIGNMENT_CENTER, size.x, 26, TEXT_COLOR)
	if _playing:
		draw_string(font, Vector2(FIELD.position.x, 100), "Niveau %d" % (_level + 1), HORIZONTAL_ALIGNMENT_LEFT, -1, 20, TEXT_COLOR)
