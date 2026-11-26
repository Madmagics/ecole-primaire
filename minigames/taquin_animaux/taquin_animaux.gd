## Mini-jeu du CM1 n°2 : Taquin des animaux (2026-11-25, propose par John). Une image d'animal
## de la collection CM1 est decoupee en cases, melangees ; une case est vide. Toucher une case
## voisine de la case vide la fait glisser. Il faut reconstituer l'image (modele a droite) avant
## la fin du temps. Chaque case porte un petit numero pour aider.
##
## Progression : 3x3, puis 4x4, puis 5x5 (qui se repete ensuite avec 15 % de temps en moins).
## Points par image reconstituee : 10 x taille de la grille + la moitie des secondes restantes.
## Partie finie quand le temps est ecoule.
##
## Le melange part de l'image resolue et fait des deplacements valides au hasard : chaque
## grille est donc toujours faisable.
class_name TaquinAnimaux
extends MiniGame

const GAME_ID := "taquin_animaux"
const TITLE := "Taquin des animaux"
const RULES := "Fais glisser les cases en touchant celles qui sont à côté de la case vide, pour reconstituer l'image de l'animal avant la fin du temps. Le modèle est à droite !"

const SIZES := [3, 4, 5]
const SECONDS_BY_SIZE := {3: 120.0, 4: 240.0, 5: 360.0}
const TIME_FACTOR_AFTER_LAST_SIZE := 0.85
const SHUFFLE_MOVES_PER_CELL := 20
const SLIDE_SPEED := 2000.0
const NEXT_PUZZLE_DELAY := 1.2
const BOARD := Rect2(300, 116, 500, 500)
const PREVIEW := Rect2(850, 160, 220, 220)
const TIME_BAR := Rect2(300, 92, 500, 14)

const BACKGROUND_COLOR := Color(0.95, 0.92, 0.98)
const BOARD_COLOR := Color(0.3, 0.25, 0.35)
const TILE_COLOR := Color(1.0, 0.97, 0.9)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)
const BAR_BACK_COLOR := Color(0, 0, 0, 0.15)
const BAR_OK_COLOR := Color(0.3, 0.7, 0.3)
const BAR_LOW_COLOR := Color(0.9, 0.3, 0.25)

var _playing: bool = false
var _score: int = 0
var _puzzle_index: int = 0
var _n: int = 3
var _board: Array[int] = [] ## case -> numero de la piece (n*n - 1 = vide)
var _visual: Array[Vector2] = [] ## piece -> position affichee (glisse vers sa case)
var _moves: int = 0
var _time_left: float = 0.0
var _round_time: float = 1.0
var _next_timer: float = 0.0
var _texture: Texture2D = null
var _region: Rect2 = Rect2()
var _textures: Array[Texture2D] = []

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_textures = MiniGame.get_grade_textures(grade)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_score = 0
	_puzzle_index = 0
	_playing = true
	_hud.start_play(0)
	_start_puzzle()

func _start_puzzle() -> void:
	_n = SIZES[mini(_puzzle_index, SIZES.size() - 1)]
	var extra := maxi(0, _puzzle_index - (SIZES.size() - 1))
	_round_time = float(SECONDS_BY_SIZE[_n]) * pow(TIME_FACTOR_AFTER_LAST_SIZE, extra)
	_time_left = _round_time
	_moves = 0
	_next_timer = 0.0
	_texture = _textures.pick_random() if not _textures.is_empty() else null
	if _texture:
		## Carre centre dans l'image (portrait) de l'animal.
		var texture_size := _texture.get_size()
		var side := minf(texture_size.x, texture_size.y)
		_region = Rect2((texture_size - Vector2(side, side)) * 0.5, Vector2(side, side))
	_board.clear()
	for i in _n * _n:
		_board.append(i)
	_shuffle()
	_visual.clear()
	_visual.resize(_n * _n)
	for cell in _board.size():
		_visual[_board[cell]] = _cell_position(cell)

func _shuffle() -> void:
	var empty := _board.find(_n * _n - 1)
	var previous := -1
	for _move_index in _n * _n * SHUFFLE_MOVES_PER_CELL:
		var options := _neighbours(empty)
		options.erase(previous)
		var cell: int = options.pick_random()
		_board[empty] = _board[cell]
		_board[cell] = _n * _n - 1
		previous = empty
		empty = cell
	if _is_solved():
		_shuffle()

func _neighbours(cell: int) -> Array[int]:
	var result: Array[int] = []
	var col := cell % _n
	var row := floori(float(cell) / float(_n))
	if col > 0:
		result.append(cell - 1)
	if col < _n - 1:
		result.append(cell + 1)
	if row > 0:
		result.append(cell - _n)
	if row < _n - 1:
		result.append(cell + _n)
	return result

func _is_solved() -> bool:
	for i in _board.size():
		if _board[i] != i:
			return false
	return true

func _tile_size() -> float:
	return BOARD.size.x / _n

func _cell_position(cell: int) -> Vector2:
	var col := cell % _n
	var row := floori(float(cell) / float(_n))
	return BOARD.position + Vector2(col, row) * _tile_size()

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score, "Temps écoulé !")

func _close() -> void:
	closed.emit()

func _gui_input(event: InputEvent) -> void:
	if not _playing or _next_timer > 0.0:
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT or not button.pressed:
		return
	if not BOARD.has_point(button.position):
		return
	accept_event()
	var local := (button.position - BOARD.position) / _tile_size()
	var cell := mini(floori(local.y), _n - 1) * _n + mini(floori(local.x), _n - 1)
	var empty := _board.find(_n * _n - 1)
	if not _neighbours(empty).has(cell):
		return
	_board[empty] = _board[cell]
	_board[cell] = _n * _n - 1
	_moves += 1
	SoundManager.play(SoundManager.Sfx.CLICK)
	if _is_solved():
		var points := 10 * _n + int(_time_left * 0.5)
		_score += points
		_hud.set_score(_score)
		SoundManager.play(SoundManager.Sfx.PACK_REWARD)
		_puzzle_index += 1
		_next_timer = NEXT_PUZZLE_DELAY

func _process(delta: float) -> void:
	for cell in _board.size():
		var piece := _board[cell]
		_visual[piece] = _visual[piece].move_toward(_cell_position(cell), SLIDE_SPEED * delta)
	if _playing:
		if _next_timer > 0.0:
			_next_timer -= delta
			if _next_timer <= 0.0:
				_start_puzzle()
		else:
			_time_left -= delta
			if _time_left <= 0.0:
				_time_left = 0.0
				_end_game()
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	if _board.is_empty():
		return
	draw_rect(TIME_BAR, BAR_BACK_COLOR)
	var ratio := clampf(_time_left / _round_time, 0.0, 1.0)
	draw_rect(Rect2(TIME_BAR.position, Vector2(TIME_BAR.size.x * ratio, TIME_BAR.size.y)), BAR_LOW_COLOR if ratio < 0.25 else BAR_OK_COLOR)
	draw_rect(BOARD.grow(8.0), BOARD_COLOR)
	var tile := _tile_size()
	var font := get_theme_default_font()
	var solved := _next_timer > 0.0
	for piece in _board.size():
		if piece == _n * _n - 1 and not solved:
			continue ## case vide (affichee une fois l'image reconstituee)
		var rect := Rect2(_visual[piece], Vector2(tile, tile)).grow(-2.0)
		draw_rect(rect, TILE_COLOR)
		if _texture:
			var piece_col := piece % _n
			var piece_row := floori(float(piece) / float(_n))
			var part := _region.size.x / _n
			var source := Rect2(_region.position + Vector2(piece_col, piece_row) * part, Vector2(part, part))
			draw_texture_rect_region(_texture, rect, source)
		if not solved:
			draw_string(font, rect.position + Vector2(6, 22), str(piece + 1), HORIZONTAL_ALIGNMENT_LEFT, -1, 18, INK_COLOR)
	## Modele et compteur de coups.
	draw_string(font, Vector2(PREVIEW.position.x, PREVIEW.position.y - 14.0), "Modèle", HORIZONTAL_ALIGNMENT_LEFT, -1, 24, INK_COLOR)
	draw_rect(PREVIEW.grow(4.0), BOARD_COLOR)
	draw_rect(PREVIEW, TILE_COLOR)
	if _texture:
		draw_texture_rect_region(_texture, PREVIEW, _region)
	draw_string(font, Vector2(PREVIEW.position.x, PREVIEW.end.y + 44.0), "Coups : %d" % _moves, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, INK_COLOR)
	draw_string(font, Vector2(PREVIEW.position.x, PREVIEW.end.y + 80.0), "Grille %d x %d" % [_n, _n], HORIZONTAL_ALIGNMENT_LEFT, -1, 24, INK_COLOR)
