## Mini-jeu du CE1 n°1 : Memory des animaux (2026-11-25, propose par Julie). Les cartes sont
## retournees face cachee ; on en retourne deux a la fois pour retrouver les paires d'animaux de
## la collection CE1. Chaque grille doit etre terminee avant la fin du temps (barre en haut).
##
## Progression : grilles de 4x3, 4x4, 5x4 puis 6x4 ; ensuite la 6x4 se repete avec 15 % de temps
## en moins a chaque fois. Une erreur fait perdre MISMATCH_PENALTY seconde (pas de vies : plus doux
## a 7 ans). Points : 10 par paire + 5 par paire enchainee sans erreur + les secondes restantes a la
## fin de chaque grille. Partie finie quand le temps est ecoule.
##
## Tout est dessine dans _draw() (cartes, barre de temps) ; clic ou tap sur une carte (evenements
## souris, tactile emule - voir MiniGame).
class_name MemoryAnimaux
extends MiniGame

const GAME_ID := "memory_animaux"
const TITLE := "Memory des animaux"
const RULES := "Retourne les cartes deux par deux pour retrouver les paires d'animaux. Termine chaque grille avant la fin du temps ! Une erreur te fait perdre une seconde."

## Grilles successives (colonnes, lignes) ; la derniere se repete ensuite.
const GRIDS := [Vector2i(4, 3), Vector2i(4, 4), Vector2i(5, 4), Vector2i(6, 4)]
const SECONDS_PER_PAIR := 6.0
const TIME_FACTOR_AFTER_LAST_GRID := 0.85
const MISMATCH_PENALTY := 1.0
const MISMATCH_SHOW_SECONDS := 0.8
const NEXT_GRID_DELAY := 0.8
const FLIP_SECONDS := 0.15
const PAIR_POINTS := 10
const COMBO_POINTS := 5
const PLAY_AREA := Rect2(80, 120, 992, 500)
const CARD_GAP := 12.0
const CARD_RATIO := 0.75 ## largeur / hauteur d'une carte
const TIME_BAR := Rect2(80, 92, 992, 14)

const BACKGROUND_COLOR := Color(0.93, 0.96, 0.88)
const FACE_COLOR := Color(1.0, 0.97, 0.9)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)
const MATCHED_COLOR := Color(0.3, 0.7, 0.3)
const BAR_BACK_COLOR := Color(0, 0, 0, 0.15)
const BAR_OK_COLOR := Color(0.3, 0.7, 0.3)
const BAR_LOW_COLOR := Color(0.9, 0.3, 0.25)

class Card:
	var texture: Texture2D = null
	var pair_id: int = 0
	var rect: Rect2 = Rect2()
	var face_up: bool = false
	var matched: bool = false
	var flip: float = 0.0 ## 0 = dos visible, 1 = face visible (anime dans _process)

var _playing: bool = false
var _cards: Array[Card] = []
var _selected: Array[Card] = []
var _mismatch_timer: float = 0.0
var _next_grid_timer: float = 0.0
var _round: int = 0
var _round_time: float = 1.0
var _time_left: float = 0.0
var _score: int = 0
var _combo: int = 0
var _textures: Array[Texture2D] = []
var _back_style: StyleBoxFlat
var _face_style: StyleBoxFlat
var _matched_style: StyleBoxFlat

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_textures = MiniGame.get_grade_textures(grade)
	_back_style = _make_style(GradeLevel.get_color(grade), INK_COLOR)
	_face_style = _make_style(FACE_COLOR, INK_COLOR)
	_matched_style = _make_style(FACE_COLOR, MATCHED_COLOR)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _make_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(3)
	style.set_corner_radius_all(10)
	return style

func _start_game() -> void:
	_score = 0
	_combo = 0
	_round = 0
	_playing = true
	_hud.start_play(0)
	_start_round()

func _start_round() -> void:
	var grid: Vector2i = GRIDS[mini(_round, GRIDS.size() - 1)]
	var pair_count := mini(int(grid.x * grid.y * 0.5), _textures.size())
	var textures := _textures.duplicate()
	textures.shuffle()
	var pair_ids: Array[int] = []
	for i in pair_count:
		pair_ids.append(i)
		pair_ids.append(i)
	pair_ids.shuffle()
	var card_h := minf((PLAY_AREA.size.y - CARD_GAP * (grid.y - 1)) / grid.y, ((PLAY_AREA.size.x - CARD_GAP * (grid.x - 1)) / grid.x) / CARD_RATIO)
	var card_w := card_h * CARD_RATIO
	var total := Vector2(grid.x * card_w + (grid.x - 1) * CARD_GAP, grid.y * card_h + (grid.y - 1) * CARD_GAP)
	var origin := PLAY_AREA.position + (PLAY_AREA.size - total) * 0.5
	_cards.clear()
	for i in pair_ids.size():
		var card := Card.new()
		card.pair_id = pair_ids[i]
		card.texture = textures[card.pair_id]
		var col := i % grid.x
		var row := floori(float(i) / float(grid.x))
		card.rect = Rect2(origin + Vector2(col * (card_w + CARD_GAP), row * (card_h + CARD_GAP)), Vector2(card_w, card_h))
		_cards.append(card)
	var extra_rounds := maxi(0, _round - (GRIDS.size() - 1))
	_round_time = pair_count * SECONDS_PER_PAIR * pow(TIME_FACTOR_AFTER_LAST_GRID, extra_rounds)
	_time_left = _round_time
	_selected.clear()
	_mismatch_timer = 0.0
	_next_grid_timer = 0.0

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score, "Temps écoulé !")

func _close() -> void:
	closed.emit()

func _gui_input(event: InputEvent) -> void:
	if not _playing or _mismatch_timer > 0.0 or _next_grid_timer > 0.0:
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT or not button.pressed:
		return
	for card in _cards:
		if card.rect.has_point(button.position) and not card.face_up and not card.matched:
			_reveal(card)
			accept_event()
			return

func _reveal(card: Card) -> void:
	card.face_up = true
	_selected.append(card)
	if _selected.size() < 2:
		SoundManager.play(SoundManager.Sfx.CLICK)
		return
	var first := _selected[0]
	var second := _selected[1]
	if first.pair_id == second.pair_id:
		first.matched = true
		second.matched = true
		_selected.clear()
		_combo += 1
		_score += PAIR_POINTS + COMBO_POINTS * (_combo - 1)
		_hud.set_score(_score)
		SoundManager.play(SoundManager.Sfx.CORRECT)
		if _all_matched():
			_score += int(_time_left)
			_hud.set_score(_score)
			_round += 1
			_next_grid_timer = NEXT_GRID_DELAY
	else:
		_combo = 0
		_time_left -= MISMATCH_PENALTY
		_mismatch_timer = MISMATCH_SHOW_SECONDS
		SoundManager.play(SoundManager.Sfx.WRONG)

func _all_matched() -> bool:
	for card in _cards:
		if not card.matched:
			return false
	return true

func _process(delta: float) -> void:
	for card in _cards:
		card.flip = move_toward(card.flip, 1.0 if card.face_up else 0.0, delta / FLIP_SECONDS)
	if _playing:
		if _next_grid_timer > 0.0:
			_next_grid_timer -= delta
			if _next_grid_timer <= 0.0:
				_start_round()
		else:
			if _mismatch_timer > 0.0:
				_mismatch_timer -= delta
				if _mismatch_timer <= 0.0:
					for card in _selected:
						card.face_up = false
					_selected.clear()
			_time_left -= delta
			if _time_left <= 0.0:
				_time_left = 0.0
				_end_game()
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	if _cards.is_empty():
		return
	draw_rect(TIME_BAR, BAR_BACK_COLOR)
	var ratio := clampf(_time_left / _round_time, 0.0, 1.0)
	draw_rect(Rect2(TIME_BAR.position, Vector2(TIME_BAR.size.x * ratio, TIME_BAR.size.y)), BAR_LOW_COLOR if ratio < 0.25 else BAR_OK_COLOR)
	var font := get_theme_default_font()
	for card in _cards:
		## Retournement : la carte s'aplatit jusqu'a la moitie de l'animation puis s'elargit sur
		## l'autre face.
		var width_factor := absf(1.0 - 2.0 * card.flip)
		var rect := card.rect
		rect.position.x += rect.size.x * (1.0 - width_factor) * 0.5
		rect.size.x *= maxf(width_factor, 0.02)
		if card.flip >= 0.5:
			draw_style_box(_matched_style if card.matched else _face_style, rect)
			if card.texture:
				draw_texture_rect(card.texture, MiniGame.fit_rect(card.texture.get_size(), rect.grow(-8.0)), false)
		else:
			draw_style_box(_back_style, rect)
			if width_factor > 0.5:
				draw_string(font, Vector2(rect.position.x, rect.get_center().y + 14.0), "?", HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 40, Color.WHITE)
