## Mini-jeu du CM2 n°2 : 3 animaux alignes (2026-11-25, propose par Edouard, remplace la Chasse
## aux noisettes / demineur). Un "match-3" avec les animaux de la collection CM2 : on echange deux
## animaux voisins pour en aligner 3 ou plus (en ligne ou en colonne). Ils disparaissent, ceux du
## dessus tombent, de nouveaux arrivent par le haut - et les alignements en cascade font des
## combos (points multiplies). Un echange qui n'aligne rien est annule.
##
## Controles (souris et tactile) : glisser un animal vers son voisin, OU toucher un animal puis un
## voisin. Contre la montre (START_SECONDS) : un alignement de 4 rend BONUS_SECONDS_4 secondes, de
## 5 ou plus BONUS_SECONDS_5. Points : POINTS_PER_TILE par animal x niveau de combo.
## S'il n'y a plus aucun echange possible, la grille est remelangee automatiquement.
##
## 2026-11-25 (retour Steve) : les mini-images d'animaux rendaient la grille illisible. Elles sont
## retirees : chaque case est un bonbon de couleur vive (KIND_COLORS) avec relief, reflet et brillance.
## La case choisie pulse, les cases alignees blanchissent en disparaissant.
class_name AnimauxAlignes
extends MiniGame

const GAME_ID := "animaux_alignes"
const TITLE := "3 animaux alignés"
const RULES := "Échange deux cases voisines pour aligner 3 couleurs identiques ou plus : elles disparaissent et les autres tombent. Enchaîne les combos avant la fin du temps ! Un alignement de 4 ou 5 te rend du temps."

class Tile:
	var kind: int = 0
	var pos: Vector2 = Vector2.ZERO
	var clearing: bool = false
	var clear_t: float = 0.0

enum State { IDLE, SWAPPING, SWAPPING_BACK, CLEARING, FALLING }

const COLS := 8
const ROWS := 8
const CELL := 62.0
const BOARD_ORIGIN := Vector2(328, 110)
const KINDS := 6
const START_SECONDS := 90.0
const BONUS_SECONDS_4 := 2.0
const BONUS_SECONDS_5 := 4.0
const POINTS_PER_TILE := 10
const SWAP_SPEED := 700.0
const FALL_SPEED := 1100.0
const CLEAR_SECONDS := 0.22
const SWIPE_MIN_DISTANCE := 24.0
const TIME_BAR := Rect2(328, 88, 496, 12)

const BACKGROUND_COLOR := Color(0.97, 0.95, 0.9)
const BOARD_COLOR := Color(0.35, 0.3, 0.4)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)
const BAR_BACK_COLOR := Color(0, 0, 0, 0.15)
const BAR_OK_COLOR := Color(0.3, 0.7, 0.3)
const BAR_LOW_COLOR := Color(0.9, 0.3, 0.25)
const KIND_COLORS := [Color(0.93, 0.27, 0.3), Color(0.22, 0.52, 0.95), Color(1.0, 0.8, 0.15), Color(0.26, 0.76, 0.35), Color(0.66, 0.38, 0.92), Color(1.0, 0.55, 0.15)]
const BEVEL := 5.0 ## epaisseur du relief sombre en bas de chaque case

var _playing: bool = false
var _state: State = State.IDLE
var _grid: Array = [] ## COLS * ROWS cases : Tile ou null
var _selected: int = -1
var _press_cell: int = -1
var _press_position: Vector2 = Vector2.ZERO
var _swap_a: int = -1
var _swap_b: int = -1
var _combo: int = 0
var _time_left: float = 0.0
var _score: int = 0
var _tile_style: StyleBoxFlat
var _gloss_style: StyleBoxFlat
var _select_style: StyleBoxFlat

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_tile_style = StyleBoxFlat.new()
	_tile_style.set_corner_radius_all(12)
	_gloss_style = StyleBoxFlat.new()
	_gloss_style.set_corner_radius_all(9)
	_select_style = StyleBoxFlat.new()
	_select_style.set_corner_radius_all(14)
	_select_style.draw_center = false
	_select_style.set_border_width_all(4)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_fill_board()
	_score = 0
	_combo = 0
	_selected = -1
	_press_cell = -1
	_time_left = START_SECONDS
	_state = State.IDLE
	_playing = true
	_hud.start_play(0)

func _end_game() -> void:
	_playing = false
	_selected = -1
	_hud.show_game_over(_score, "Temps écoulé !")

func _close() -> void:
	closed.emit()

# --- Grille -------------------------------------------------------------------------------------

func _cell_position(cell: int) -> Vector2:
	return BOARD_ORIGIN + Vector2(cell % COLS, floori(float(cell) / float(COLS))) * CELL

func _cell_at(point: Vector2) -> int:
	var local := (point - BOARD_ORIGIN) / CELL
	if local.x < 0.0 or local.y < 0.0 or local.x >= COLS or local.y >= ROWS:
		return -1
	return floori(local.y) * COLS + floori(local.x)

func _are_neighbours(a: int, b: int) -> bool:
	var ax := a % COLS
	var bx := b % COLS
	return (absi(a - b) == 1 and floori(float(a) / float(COLS)) == floori(float(b) / float(COLS)) and absi(ax - bx) == 1) or absi(a - b) == COLS

func _kind_at(cell: int) -> int:
	var tile := _grid[cell] as Tile
	return tile.kind if tile else -1

## Grille de depart sans alignement tout fait, avec au moins un echange possible.
func _fill_board() -> void:
	for _attempt in 50:
		_grid.clear()
		_grid.resize(COLS * ROWS)
		for cell in COLS * ROWS:
			var col := cell % COLS
			var row := floori(float(cell) / float(COLS))
			var kind := randi() % KINDS
			for _try in 10:
				var makes_row := col >= 2 and _kind_at(cell - 1) == kind and _kind_at(cell - 2) == kind
				var makes_col := row >= 2 and _kind_at(cell - COLS) == kind and _kind_at(cell - 2 * COLS) == kind
				if not makes_row and not makes_col:
					break
				kind = randi() % KINDS
			var tile := Tile.new()
			tile.kind = kind
			tile.pos = _cell_position(cell)
			_grid[cell] = tile
		if _find_matches()["cells"].is_empty() and _has_move():
			return

## Cases alignees (3 ou plus) + secondes bonus des alignements de 4 et 5.
func _find_matches() -> Dictionary:
	var cells := {}
	var bonus := 0.0
	for line in 2:
		var outer := ROWS if line == 0 else COLS
		var inner := COLS if line == 0 else ROWS
		for o in outer:
			var run_start := 0
			for i in range(1, inner + 1):
				var current := _line_cell(line, o, i) if i < inner else -1
				var start_cell := _line_cell(line, o, run_start)
				if i < inner and _kind_at(current) != -1 and _kind_at(current) == _kind_at(start_cell):
					continue
				var run_length := i - run_start
				if run_length >= 3 and _kind_at(start_cell) != -1:
					for k in range(run_start, i):
						cells[_line_cell(line, o, k)] = true
					if run_length >= 5:
						bonus += BONUS_SECONDS_5
					elif run_length == 4:
						bonus += BONUS_SECONDS_4
				run_start = i
	return {"cells": cells.keys(), "bonus": bonus}

## Case n°[index] de la ligne (line = 0) ou colonne (line = 1) numero [outer].
func _line_cell(line: int, outer: int, index: int) -> int:
	return outer * COLS + index if line == 0 else index * COLS + outer

func _swap_cells(a: int, b: int) -> void:
	var temp: Variant = _grid[a]
	_grid[a] = _grid[b]
	_grid[b] = temp

func _has_move() -> bool:
	for cell in COLS * ROWS:
		for other in [cell + 1, cell + COLS]:
			var target: int = other
			if target >= COLS * ROWS or not _are_neighbours(cell, target):
				continue
			_swap_cells(cell, target)
			var found: bool = not _find_matches()["cells"].is_empty()
			_swap_cells(cell, target)
			if found:
				return true
	return false

# --- Controles ----------------------------------------------------------------------------------

func _gui_input(event: InputEvent) -> void:
	if not _playing or _state != State.IDLE:
		return
	if event is InputEventMouseMotion and _press_cell != -1:
		var delta := (event as InputEventMouseMotion).position - _press_position
		if delta.length() >= SWIPE_MIN_DISTANCE:
			var target := _press_cell
			if absf(delta.x) > absf(delta.y):
				target += 1 if delta.x > 0.0 else -1
			else:
				target += COLS if delta.y > 0.0 else -COLS
			var from := _press_cell
			_press_cell = -1
			_selected = -1
			if target >= 0 and target < COLS * ROWS and _are_neighbours(from, target):
				_try_swap(from, target)
		accept_event()
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT:
		return
	accept_event()
	var cell := _cell_at(button.position)
	if button.pressed:
		_press_cell = cell
		_press_position = button.position
		return
	## Relache sans avoir glisse : selection par taps successifs.
	if _press_cell == -1 or cell == -1:
		_press_cell = -1
		return
	_press_cell = -1
	if _selected == -1:
		_selected = cell
	elif _selected == cell:
		_selected = -1
	elif _are_neighbours(_selected, cell):
		var from := _selected
		_selected = -1
		_try_swap(from, cell)
	else:
		_selected = cell

func _try_swap(a: int, b: int) -> void:
	_swap_cells(a, b)
	_swap_a = a
	_swap_b = b
	_state = State.SWAPPING
	SoundManager.play(SoundManager.Sfx.CLICK)

# --- Deroulement --------------------------------------------------------------------------------

func _process(delta: float) -> void:
	if not _playing:
		queue_redraw()
		return
	_time_left = maxf(0.0, _time_left - delta)
	var speed := FALL_SPEED if _state == State.FALLING else SWAP_SPEED
	var arrived := true
	for cell in COLS * ROWS:
		var tile := _grid[cell] as Tile
		if tile == null:
			continue
		var target := _cell_position(cell)
		tile.pos = tile.pos.move_toward(target, speed * delta)
		if tile.pos != target:
			arrived = false
	match _state:
		State.IDLE:
			if _time_left <= 0.0:
				_end_game()
		State.SWAPPING:
			if arrived:
				var result := _find_matches()
				if result["cells"].is_empty():
					_swap_cells(_swap_a, _swap_b) ## pas d'alignement : on annule l'echange
					_state = State.SWAPPING_BACK
				else:
					_combo = 1
					_start_clear(result)
		State.SWAPPING_BACK:
			if arrived:
				_state = State.IDLE
		State.CLEARING:
			var done := false
			for cell in COLS * ROWS:
				var tile := _grid[cell] as Tile
				if tile and tile.clearing:
					tile.clear_t += delta
					if tile.clear_t >= CLEAR_SECONDS:
						done = true
			if done:
				for cell in COLS * ROWS:
					var tile := _grid[cell] as Tile
					if tile and tile.clearing:
						_grid[cell] = null
				_apply_gravity()
				_state = State.FALLING
		State.FALLING:
			if arrived:
				var result := _find_matches()
				if not result["cells"].is_empty():
					_combo += 1
					_start_clear(result)
				else:
					_combo = 0
					if not _has_move():
						_fill_board()
					_state = State.IDLE
	queue_redraw()

func _start_clear(result: Dictionary) -> void:
	var cells: Array = result["cells"]
	for cell in cells:
		(_grid[cell] as Tile).clearing = true
	_score += cells.size() * POINTS_PER_TILE * _combo
	_time_left += float(result["bonus"])
	_hud.set_score(_score)
	SoundManager.play(SoundManager.Sfx.PACK_REWARD if _combo > 1 else SoundManager.Sfx.CORRECT)
	_state = State.CLEARING

## Les animaux tombent dans les trous ; de nouveaux arrivent par le haut.
func _apply_gravity() -> void:
	for col in COLS:
		var write_row := ROWS - 1
		for row in range(ROWS - 1, -1, -1):
			var cell := row * COLS + col
			if _grid[cell] != null:
				if row != write_row:
					_grid[write_row * COLS + col] = _grid[cell]
					_grid[cell] = null
				write_row -= 1
		var missing := write_row + 1
		for row in range(write_row, -1, -1):
			var tile := Tile.new()
			tile.kind = randi() % KINDS
			tile.pos = _cell_position(row * COLS + col) - Vector2(0, missing * CELL)
			_grid[row * COLS + col] = tile

# --- Dessin -------------------------------------------------------------------------------------

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	if _grid.is_empty():
		return
	draw_rect(TIME_BAR, BAR_BACK_COLOR)
	var ratio := clampf(_time_left / START_SECONDS, 0.0, 1.0)
	draw_rect(Rect2(TIME_BAR.position, Vector2(TIME_BAR.size.x * ratio, TIME_BAR.size.y)), BAR_LOW_COLOR if ratio < 0.2 else BAR_OK_COLOR)
	var board := Rect2(BOARD_ORIGIN, Vector2(COLS, ROWS) * CELL)
	draw_rect(board.grow(6.0), BOARD_COLOR)
	for cell in COLS * ROWS:
		var tile := _grid[cell] as Tile
		if tile == null or tile.pos.y < BOARD_ORIGIN.y - CELL * 0.5:
			continue ## pas encore entre dans la grille
		var scale_factor := 1.0 - clampf(tile.clear_t / CLEAR_SECONDS, 0.0, 1.0) if tile.clearing else 1.0
		var rect := Rect2(tile.pos, Vector2(CELL, CELL)).grow(-3.0)
		rect = Rect2(rect.get_center() - rect.size * scale_factor * 0.5, rect.size * scale_factor)
		var base: Color = KIND_COLORS[tile.kind % KIND_COLORS.size()]
		if tile.clearing:
			base = base.lerp(Color.WHITE, clampf(tile.clear_t / CLEAR_SECONDS, 0.0, 1.0))
		_draw_tile(rect, base, cell == _selected)
	var font := get_theme_default_font()
	draw_string(font, Vector2(860, 170), "Temps : %d s" % ceili(_time_left), HORIZONTAL_ALIGNMENT_LEFT, -1, 26, INK_COLOR)
	if _combo > 1:
		draw_string(font, Vector2(860, 230), "Combo x%d !" % _combo, HORIZONTAL_ALIGNMENT_LEFT, -1, 34, BAR_LOW_COLOR)

## Case "bonbon" : relief sombre en bas, corps colore, bande de reflet en haut et point de brillance.
## La case selectionnee est entouree d'un halo blanc qui pulse.
func _draw_tile(rect: Rect2, base: Color, selected: bool) -> void:
	if selected:
		var pulse := 0.6 + 0.4 * sin(Time.get_ticks_msec() * 0.012)
		_select_style.border_color = Color(1, 1, 1, pulse)
		draw_style_box(_select_style, rect.grow(3.0))
	_tile_style.bg_color = base.darkened(0.35)
	draw_style_box(_tile_style, rect)
	_tile_style.bg_color = base
	draw_style_box(_tile_style, Rect2(rect.position, rect.size - Vector2(0, BEVEL)))
	var gloss := Rect2(rect.position + rect.size * Vector2(0.14, 0.09), rect.size * Vector2(0.72, 0.32))
	_gloss_style.bg_color = Color(1, 1, 1, 0.35)
	draw_style_box(_gloss_style, gloss)
	draw_circle(rect.position + rect.size * Vector2(0.27, 0.24), rect.size.x * 0.07, Color(1, 1, 1, 0.85))
