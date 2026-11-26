## Mini-jeu du CP : Pluie de biscuits (2026-11-25, d'abord nomme "Attrape-friandises"). Un animal
## de la collection CP du joueur avance en bas de l'ecran et attrape ce qui tombe : biscuit =
## 1 point, etoile = 3 points, caillou = 1 vie perdue (3 vies). Ca tombe de plus en plus vite et
## souvent au fil des points. Rater un biscuit ne fait rien perdre (adapte au CP).
##
## Controle (PC et tactile, voir MiniGame) : l'animal file vers la position X du pointeur -
## survol de la souris, clic, tap ou glissement du doigt. Il se deplace a vitesse limitee
## (CATCHER_SPEED) plutot que de se teleporter, pour qu'un simple tap sur tablette reste jouable.
##
## Tout le terrain (ciel, sol, objets, animal, "+1") est dessine dans _draw() : pas de noeud par
## objet qui tombe, le jeu reste tres leger. Boutons, score, coeurs, fenetres et meilleurs scores
## = l'habillage commun MiniGameHud (noeud Hud).
class_name PluieDeBiscuits
extends MiniGame

## Identifiant du jeu cote serveur (colonne scores_minijeux.jeu).
const GAME_ID := "pluie_de_biscuits"
const TITLE := "Pluie de biscuits"
const RULES := "Déplace ton animal avec la souris ou avec ton doigt. Attrape les biscuits et les étoiles, mais attention aux cailloux : tu n'as que 3 vies !"

enum Kind { TREAT, STAR, ROCK }

class FallingItem:
	var kind: int = 0
	var pos: Vector2 = Vector2.ZERO
	var speed: float = 0.0
	var spin: float = 0.0

const GROUND_HEIGHT := 70.0
const CATCHER_HEIGHT := 130.0
const CATCHER_SPEED := 1100.0
const ITEM_RADIUS := 22.0
const START_LIVES := 3
const BASE_FALL_SPEED := 170.0
const FALL_SPEED_PER_POINT := 10.0
const MAX_FALL_SPEED := 520.0
const BASE_SPAWN_INTERVAL := 1.1
const SPAWN_INTERVAL_PER_POINT := 0.02
const MIN_SPAWN_INTERVAL := 0.45
const STAR_CHANCE := 0.06
const BASE_ROCK_CHANCE := 0.2
const ROCK_CHANCE_PER_POINT := 0.01
const MAX_ROCK_CHANCE := 0.4
const HIT_FLASH_SECONDS := 0.35
const POPUP_SECONDS := 0.8
const POPUP_FONT_SIZE := 30

const SKY_COLOR := Color(0.62, 0.84, 0.97)
const GROUND_COLOR := Color(0.47, 0.73, 0.38)
const TREAT_COLOR := Color(0.82, 0.56, 0.28)
const TREAT_CHIP_COLOR := Color(0.42, 0.24, 0.12)
const STAR_COLOR := Color(1.0, 0.82, 0.2)
const ROCK_COLOR := Color(0.55, 0.55, 0.58)
const ROCK_EDGE_COLOR := Color(0.35, 0.35, 0.38)
const HIT_TINT := Color(1, 0.45, 0.45)
const POINTS_COLOR := Color(0.2, 0.45, 0.15)
const OUCH_COLOR := Color(0.9, 0.22, 0.3)

## Forme du caillou (rayon 1), mise a l'echelle de ITEM_RADIUS au dessin.
const ROCK_SHAPE := [Vector2(-1, 0.1), Vector2(-0.7, -0.75), Vector2(0.1, -0.95), Vector2(0.85, -0.5), Vector2(1, 0.35), Vector2(0.4, 0.9), Vector2(-0.55, 0.8)]

## Fond d'ecran du jeu (2026-11-25), dessine en premier dans _draw() - pas un TextureRect enfant,
## qui se dessinerait PAR-DESSUS les biscuits (les enfants d'un Control passent apres son _draw).
## Sans image : ciel + herbe provisoires. L'animal a toujours les pieds a GROUND_HEIGHT du bas.
@export var background_texture: Texture2D

var _playing: bool = false
var _items: Array[FallingItem] = []
var _popups: Array[Dictionary] = []
var _score: int = 0
var _lives: int = START_LIVES
var _spawn_timer: float = 0.0
var _catcher_x: float = -1.0
var _target_x: float = 0.0
var _hit_flash: float = 0.0
var _catcher_texture: Texture2D = null
var _catcher_size: Vector2 = Vector2(90, CATCHER_HEIGHT)

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_load_catcher_texture()
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

## L'animal joue = une carte au hasard de la classe du jeu (le joueur les a toutes pour entrer).
func _load_catcher_texture() -> void:
	var card_ids := PlaygroundChildPopup.get_card_ids(grade)
	if card_ids.is_empty():
		return
	var card := load("%s/%s.tres" % [PlaygroundChildPopup.CARDS_DIR, card_ids.pick_random()]) as CardResource
	if card == null or card.texture == null:
		return
	_catcher_texture = card.texture
	var texture_size := card.texture.get_size()
	_catcher_size = Vector2(CATCHER_HEIGHT * texture_size.x / texture_size.y, CATCHER_HEIGHT)

func _start_game() -> void:
	_items.clear()
	_popups.clear()
	_score = 0
	_lives = START_LIVES
	_spawn_timer = 0.0
	_hit_flash = 0.0
	_catcher_x = size.x * 0.5
	_target_x = _catcher_x
	_playing = true
	_hud.start_play(START_LIVES)

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score)

func _close() -> void:
	closed.emit()

func _gui_input(event: InputEvent) -> void:
	if not _playing:
		return
	var follows_pointer := event is InputEventMouseMotion
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		follows_pointer = true
	if not follows_pointer:
		return
	var half_width := _catcher_size.x * 0.5
	_target_x = clampf((event as InputEventMouse).position.x, half_width, size.x - half_width)
	accept_event()

func _process(delta: float) -> void:
	_hit_flash = maxf(0.0, _hit_flash - delta)
	_update_popups(delta)
	if _playing:
		_update_game(delta)
	queue_redraw()

func _update_game(delta: float) -> void:
	_catcher_x = move_toward(_catcher_x, _target_x, CATCHER_SPEED * delta)
	_spawn_timer -= delta
	if _spawn_timer <= 0.0:
		_spawn_item()
		_spawn_timer = _current_spawn_interval()
	var catch_rect := _get_catch_rect()
	var ground_y := size.y - GROUND_HEIGHT
	for i in range(_items.size() - 1, -1, -1):
		var item := _items[i]
		item.pos.y += item.speed * delta
		item.spin += delta * 2.0
		if catch_rect.has_point(item.pos):
			_items.remove_at(i)
			_on_item_caught(item)
			if not _playing:
				return
		elif item.pos.y - ITEM_RADIUS > ground_y:
			_items.remove_at(i)

func _spawn_item() -> void:
	var item := FallingItem.new()
	var roll := randf()
	if roll < STAR_CHANCE:
		item.kind = Kind.STAR
	elif roll < STAR_CHANCE + _current_rock_chance():
		item.kind = Kind.ROCK
	else:
		item.kind = Kind.TREAT
	item.pos = Vector2(randf_range(ITEM_RADIUS * 2.0, size.x - ITEM_RADIUS * 2.0), -ITEM_RADIUS)
	item.speed = _current_fall_speed() * randf_range(0.9, 1.15)
	item.spin = randf() * TAU
	_items.append(item)

func _on_item_caught(item: FallingItem) -> void:
	match item.kind:
		Kind.TREAT:
			_add_points(1, item.pos)
		Kind.STAR:
			_add_points(3, item.pos)
		Kind.ROCK:
			_lives -= 1
			_hit_flash = HIT_FLASH_SECONDS
			SoundManager.play(SoundManager.Sfx.WRONG)
			_add_popup("Aïe !", item.pos, OUCH_COLOR)
			_hud.set_lives(_lives, START_LIVES)
			if _lives <= 0:
				_end_game()

func _add_points(points: int, at: Vector2) -> void:
	_score += points
	SoundManager.play(SoundManager.Sfx.CORRECT)
	_add_popup("+%d" % points, at, POINTS_COLOR)
	_hud.set_score(_score)

## Difficulte : monte avec le score, plafonnee pour rester jouable au CP.
func _current_fall_speed() -> float:
	return minf(MAX_FALL_SPEED, BASE_FALL_SPEED + FALL_SPEED_PER_POINT * float(_score))

func _current_spawn_interval() -> float:
	return maxf(MIN_SPAWN_INTERVAL, BASE_SPAWN_INTERVAL - SPAWN_INTERVAL_PER_POINT * float(_score))

func _current_rock_chance() -> float:
	return minf(MAX_ROCK_CHANCE, BASE_ROCK_CHANCE + ROCK_CHANCE_PER_POINT * float(_score))

## Rectangle ou l'animal est dessine (pieds un peu enfonces dans l'herbe).
func _get_catcher_rect() -> Rect2:
	var center_x := _catcher_x if _catcher_x >= 0.0 else size.x * 0.5
	var ground_y := size.y - GROUND_HEIGHT
	return Rect2(center_x - _catcher_size.x * 0.5, ground_y - _catcher_size.y + 12.0, _catcher_size.x, _catcher_size.y)

## Zone d'attrape = moitie haute de l'animal, elargie du rayon d'un objet.
func _get_catch_rect() -> Rect2:
	var body := _get_catcher_rect()
	return Rect2(body.position.x + body.size.x * 0.05 - ITEM_RADIUS, body.position.y - ITEM_RADIUS, body.size.x * 0.9 + ITEM_RADIUS * 2.0, body.size.y * 0.5 + ITEM_RADIUS)

func _add_popup(text: String, at: Vector2, color: Color) -> void:
	_popups.append({"text": text, "pos": at, "color": color, "time": POPUP_SECONDS})

func _update_popups(delta: float) -> void:
	for i in range(_popups.size() - 1, -1, -1):
		var popup := _popups[i]
		popup["time"] = float(popup["time"]) - delta
		popup["pos"] = (popup["pos"] as Vector2) + Vector2(0, -60.0 * delta)
		if float(popup["time"]) <= 0.0:
			_popups.remove_at(i)

func _draw() -> void:
	if background_texture:
		draw_texture_rect(background_texture, Rect2(Vector2.ZERO, size), false)
	else:
		var ground_y := size.y - GROUND_HEIGHT
		draw_rect(Rect2(0, 0, size.x, ground_y), SKY_COLOR)
		draw_rect(Rect2(0, ground_y, size.x, GROUND_HEIGHT), GROUND_COLOR)
	for item in _items:
		_draw_item(item)
	var tint := HIT_TINT if _hit_flash > 0.0 else Color.WHITE
	if _catcher_texture:
		draw_texture_rect(_catcher_texture, _get_catcher_rect(), false, tint)
	else:
		draw_rect(_get_catcher_rect(), GradeLevel.get_color(grade) * tint)
	_draw_popups()

func _draw_item(item: FallingItem) -> void:
	match item.kind:
		Kind.TREAT:
			draw_circle(item.pos, ITEM_RADIUS, TREAT_COLOR)
			for chip in [Vector2(-0.4, -0.3), Vector2(0.35, -0.1), Vector2(-0.05, 0.45)]:
				draw_circle(item.pos + (chip as Vector2).rotated(item.spin) * ITEM_RADIUS, ITEM_RADIUS * 0.16, TREAT_CHIP_COLOR)
		Kind.STAR:
			var points := PackedVector2Array()
			for i in 10:
				var radius := ITEM_RADIUS * (1.15 if i % 2 == 0 else 0.5)
				points.append(item.pos + Vector2.UP.rotated(item.spin + TAU * i / 10.0) * radius)
			draw_colored_polygon(points, STAR_COLOR)
		Kind.ROCK:
			var points := PackedVector2Array()
			for corner in ROCK_SHAPE:
				points.append(item.pos + (corner as Vector2) * ITEM_RADIUS)
			draw_colored_polygon(points, ROCK_COLOR)
			points.append(points[0])
			draw_polyline(points, ROCK_EDGE_COLOR, 3.0)

func _draw_popups() -> void:
	var font := get_theme_default_font()
	for popup in _popups:
		var color := popup["color"] as Color
		color.a = clampf(float(popup["time"]) / POPUP_SECONDS, 0.0, 1.0)
		var at := popup["pos"] as Vector2
		draw_string(font, at - Vector2(60, 0), str(popup["text"]), HORIZONTAL_ALIGNMENT_CENTER, 120.0, POPUP_FONT_SIZE, color)
