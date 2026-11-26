## Mini-jeu du CE2 n°2 : Tetri-Star (2026-11-25, propose par Carlos ; ex Empile-briques). Un Tetris simplifie :
## les briques tombent, on les deplace et les tourne pour remplir des lignes completes, qui
## disparaissent. Partie finie quand une nouvelle brique ne peut plus entrer en haut.
##
## Controles (souris et tactile) : 4 gros boutons a l'ecran - Gauche / Droite a gauche de la
## grille (appui long = deplacement continu), Tourner / Descendre a droite (Descendre maintenu =
## chute rapide). Toucher la grille fait aussi tourner la brique. Une ombre montre ou la brique va
## tomber (aide pour les 8 ans).
## Clavier (PC) : fleches gauche/droite = deplacer (maintenu = continu), fleche bas maintenue =
## chute rapide, Espace = tourner. GAME_ID garde "empile_briques" pour conserver le TOP 10.
##
## Progression : au debut seulement 4 formes simples (carre, barre, L, J) ; les 3 autres (T, S, Z)
## arrivent apres ALL_PIECES_FROM_LINES lignes. La chute accelere a chaque ligne.
## Points : 1 / 3 / 5 / 8 pour 1 / 2 / 3 / 4 lignes d'un coup.
class_name EmpileBriques
extends MiniGame

const GAME_ID := "empile_briques"
const TITLE := "Tetri-Star"
const RULES := "Déplace et tourne les briques qui tombent pour remplir des lignes entières : elles disparaissent ! La partie s'arrête quand les briques touchent le haut.\nAu clavier : flèches gauche/droite pour déplacer, flèche du bas pour descendre, Espace pour tourner."

const COLS := 10
const ROWS := 18
const CELL := 30.0
const GRID_ORIGIN := Vector2(426, 86)
const BASE_FALL_SECONDS := 0.8
const FALL_SECONDS_PER_LINE := 0.04
const MIN_FALL_SECONDS := 0.12
const FAST_FALL_SECONDS := 0.05
const REPEAT_DELAY := 0.25
const REPEAT_SECONDS := 0.1
const ALL_PIECES_FROM_LINES := 5
const LINE_POINTS := [0, 1, 3, 5, 8]
const EASY_PIECES := ["O", "I", "L", "J"]
const ALL_PIECES := ["O", "I", "L", "J", "T", "S", "Z"]
## Cases de chaque forme autour de son pivot (0, 0) ; y vers le bas.
const SHAPES := {
	"O": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)],
	"I": [Vector2i(-1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0)],
	"L": [Vector2i(-1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, -1)],
	"J": [Vector2i(-1, -1), Vector2i(-1, 0), Vector2i(0, 0), Vector2i(1, 0)],
	"T": [Vector2i(-1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, -1)],
	"S": [Vector2i(-1, 0), Vector2i(0, 0), Vector2i(0, -1), Vector2i(1, -1)],
	"Z": [Vector2i(-1, -1), Vector2i(0, -1), Vector2i(0, 0), Vector2i(1, 0)],
}
const PIECE_COLORS := {
	"O": Color(0.98, 0.8, 0.25), "I": Color(0.35, 0.8, 0.95), "L": Color(1.0, 0.6, 0.3),
	"J": Color(0.35, 0.5, 0.95), "T": Color(0.72, 0.45, 0.9), "S": Color(0.4, 0.78, 0.4), "Z": Color(0.95, 0.4, 0.4),
}
const BACKGROUND_COLOR := Color(0.95, 0.93, 0.88)
const GRID_COLOR := Color(0.2, 0.18, 0.22)
const GRID_LINE_COLOR := Color(1, 1, 1, 0.06)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)

var _playing: bool = false
var _board: Array = [] ## ROWS lignes de COLS cases : "" = vide, sinon nom de la forme (couleur)
var _piece_name: String = ""
var _piece_cells: Array[Vector2i] = []
var _piece_pos: Vector2i = Vector2i.ZERO
var _next_name: String = ""
var _fall_timer: float = 0.0
var _lines: int = 0
var _score: int = 0
var _held_dir: int = 0
var _repeat_timer: float = 0.0
var _fast_fall: bool = false
var _controls: Control

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_create_buttons()
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

## Boutons crees ici, places SOUS le Hud (ses fenetres restent par-dessus).
func _create_buttons() -> void:
	_controls = Control.new()
	_controls.set_anchors_preset(Control.PRESET_FULL_RECT)
	_controls.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_controls)
	move_child(_controls, 0)
	var left := _make_button("<", Rect2(110, 420, 130, 110))
	left.button_down.connect(_on_move_down.bind(-1))
	left.button_up.connect(_on_move_up.bind(-1))
	var right := _make_button(">", Rect2(260, 420, 130, 110))
	right.button_down.connect(_on_move_down.bind(1))
	right.button_up.connect(_on_move_up.bind(1))
	var rotate := _make_button("Tourner", Rect2(780, 300, 250, 100))
	rotate.button_down.connect(_rotate)
	var drop := _make_button("Descendre", Rect2(780, 420, 250, 110))
	drop.button_down.connect(func() -> void: _fast_fall = true)
	drop.button_up.connect(func() -> void: _fast_fall = false)
	_controls.hide()

func _make_button(text: String, rect: Rect2) -> Button:
	var button := Button.new()
	button.text = text
	button.position = rect.position
	button.size = rect.size
	button.add_theme_font_size_override("font_size", 36 if text.length() == 1 else 26)
	button.focus_mode = Control.FOCUS_NONE
	_controls.add_child(button)
	return button

func _start_game() -> void:
	_board.clear()
	for row in ROWS:
		var line: Array[String] = []
		line.resize(COLS)
		line.fill("")
		_board.append(line)
	_lines = 0
	_score = 0
	_held_dir = 0
	_fast_fall = false
	_next_name = _random_piece()
	_playing = true
	_controls.show()
	_hud.start_play(0)
	_spawn_piece()

func _end_game() -> void:
	_playing = false
	_controls.hide()
	_hud.show_game_over(_score, "Les briques touchent le haut !")

func _close() -> void:
	closed.emit()

func _random_piece() -> String:
	var pool: Array = ALL_PIECES if _lines >= ALL_PIECES_FROM_LINES else EASY_PIECES
	return pool.pick_random()

func _spawn_piece() -> void:
	_piece_name = _next_name
	_next_name = _random_piece()
	_piece_cells.clear()
	for cell in SHAPES[_piece_name]:
		_piece_cells.append(cell)
	_piece_pos = Vector2i(4, 1)
	_fall_timer = 0.0
	if not _fits(_piece_cells, _piece_pos):
		_end_game()

func _fits(cells: Array[Vector2i], pos: Vector2i) -> bool:
	for cell in cells:
		var c := cell + pos
		if c.x < 0 or c.x >= COLS or c.y >= ROWS:
			return false
		if c.y >= 0 and String(_board[c.y][c.x]) != "":
			return false
	return true

func _move(dir: int) -> bool:
	if not _playing:
		return false
	var target := _piece_pos + Vector2i(dir, 0)
	if _fits(_piece_cells, target):
		_piece_pos = target
		return true
	return false

func _rotate() -> void:
	if not _playing or _piece_name == "O":
		return
	var rotated: Array[Vector2i] = []
	for cell in _piece_cells:
		rotated.append(Vector2i(-cell.y, cell.x))
	## Petit decalage si la brique tournee touche un bord ou une autre brique.
	for kick in [0, -1, 1, -2, 2]:
		var target := _piece_pos + Vector2i(int(kick), 0)
		if _fits(rotated, target):
			_piece_cells = rotated
			_piece_pos = target
			SoundManager.play(SoundManager.Sfx.CLICK)
			return

func _on_move_down(dir: int) -> void:
	_held_dir = dir
	_repeat_timer = REPEAT_DELAY
	_move(dir)

func _on_move_up(dir: int) -> void:
	if _held_dir == dir:
		_held_dir = 0

## _input plutot que _unhandled_key_input : un bouton du HUD qui garderait le focus avalerait
## Espace (ui_accept) avant nous.
func _input(event: InputEvent) -> void:
	if not _playing:
		return
	var key := event as InputEventKey
	if key == null:
		return
	match key.physical_keycode:
		KEY_LEFT, KEY_RIGHT:
			var dir := -1 if key.physical_keycode == KEY_LEFT else 1
			if not key.pressed:
				_on_move_up(dir)
			elif not key.echo:
				_on_move_down(dir)
		KEY_DOWN:
			_fast_fall = key.pressed
		KEY_SPACE:
			if key.pressed and not key.echo:
				_rotate()
		_:
			return
	get_viewport().set_input_as_handled()

func _gui_input(event: InputEvent) -> void:
	if not _playing:
		return
	var button := event as InputEventMouseButton
	if button and button.button_index == MOUSE_BUTTON_LEFT and button.pressed:
		if Rect2(GRID_ORIGIN, Vector2(COLS, ROWS) * CELL).has_point(button.position):
			accept_event()
			_rotate()

func _process(delta: float) -> void:
	if _playing:
		if _held_dir != 0:
			_repeat_timer -= delta
			if _repeat_timer <= 0.0:
				_move(_held_dir)
				_repeat_timer = REPEAT_SECONDS
		_fall_timer += delta
		var fall_seconds := FAST_FALL_SECONDS if _fast_fall else maxf(MIN_FALL_SECONDS, BASE_FALL_SECONDS - FALL_SECONDS_PER_LINE * _lines)
		if _fall_timer >= fall_seconds:
			_fall_timer = 0.0
			_step_down()
	queue_redraw()

func _step_down() -> void:
	var target := _piece_pos + Vector2i(0, 1)
	if _fits(_piece_cells, target):
		_piece_pos = target
		return
	_lock_piece()

func _lock_piece() -> void:
	for cell in _piece_cells:
		var c := cell + _piece_pos
		if c.y < 0:
			_end_game()
			return
		_board[c.y][c.x] = _piece_name
	var cleared := 0
	var row := ROWS - 1
	while row >= 0:
		var full := true
		for col in COLS:
			if String(_board[row][col]) == "":
				full = false
				break
		if full:
			_board.remove_at(row)
			var empty_line: Array[String] = []
			empty_line.resize(COLS)
			empty_line.fill("")
			_board.insert(0, empty_line)
			cleared += 1
		else:
			row -= 1
	if cleared > 0:
		_lines += cleared
		_score += int(LINE_POINTS[mini(cleared, 4)])
		_hud.set_score(_score)
		SoundManager.play(SoundManager.Sfx.CORRECT)
	_spawn_piece()

func _ghost_pos() -> Vector2i:
	var pos := _piece_pos
	while _fits(_piece_cells, pos + Vector2i(0, 1)):
		pos += Vector2i(0, 1)
	return pos

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	var grid_rect := Rect2(GRID_ORIGIN, Vector2(COLS, ROWS) * CELL)
	draw_rect(grid_rect.grow(6.0), INK_COLOR)
	draw_rect(grid_rect, GRID_COLOR)
	for col in range(1, COLS):
		draw_line(GRID_ORIGIN + Vector2(col * CELL, 0), GRID_ORIGIN + Vector2(col * CELL, ROWS * CELL), GRID_LINE_COLOR)
	if _board.is_empty():
		return
	for row in ROWS:
		for col in COLS:
			var piece := String(_board[row][col])
			if piece != "":
				_draw_cell(GRID_ORIGIN + Vector2(col, row) * CELL, PIECE_COLORS[piece], 1.0)
	if _playing:
		var ghost := _ghost_pos()
		for cell in _piece_cells:
			var c := cell + ghost
			if c.y >= 0:
				_draw_cell(GRID_ORIGIN + Vector2(c) * CELL, PIECE_COLORS[_piece_name], 0.25)
		for cell in _piece_cells:
			var c := cell + _piece_pos
			if c.y >= 0:
				_draw_cell(GRID_ORIGIN + Vector2(c) * CELL, PIECE_COLORS[_piece_name], 1.0)
	## Brique suivante + lignes.
	var font := get_theme_default_font()
	draw_string(font, Vector2(780, 120), "Suivante", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, INK_COLOR)
	if _next_name != "":
		for cell in SHAPES[_next_name]:
			_draw_cell(Vector2(840, 180) + Vector2(cell) * CELL, PIECE_COLORS[_next_name], 1.0)
	draw_string(font, Vector2(110, 140), "Lignes : %d" % _lines, HORIZONTAL_ALIGNMENT_LEFT, -1, 26, INK_COLOR)

func _draw_cell(top_left: Vector2, color: Color, alpha: float) -> void:
	var rect := Rect2(top_left, Vector2(CELL, CELL)).grow(-1.0)
	var fill := color
	fill.a = alpha
	draw_rect(rect, fill)
	if alpha >= 1.0:
		draw_rect(Rect2(rect.position, Vector2(rect.size.x, 4.0)), color.lightened(0.35))
		draw_rect(Rect2(rect.position + Vector2(0, rect.size.y - 4.0), Vector2(rect.size.x, 4.0)), color.darkened(0.3))
