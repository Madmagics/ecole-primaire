## Mini-jeu du CM2 n°1 : 2048 des animaux (2026-11-25, propose par Sophie). Grille 4x4 ; on fait
## glisser toutes les tuiles dans une direction (glisser le doigt ou la souris). Deux tuiles
## identiques qui se touchent fusionnent en la tuile suivante. Chaque niveau de tuile = un animal
## de la collection CM2 (2 = 1er animal, 4 = 2e, 8 = 3e...) : fusionner fait "evoluer" l'animal.
## Apres chaque glissement, une nouvelle tuile (2, parfois 4) apparait. Partie finie quand plus
## aucun mouvement n'est possible. Points : la valeur de chaque fusion (regles du 2048 classique).
##
## Glissement suivi (2026-11-25, retour utilisateur : "a chaque slide tout le jeu se remixe,
## impossible a suivre") : les tuiles sont des objets qui se deplacent vraiment.
## - Pendant le glisser, les tuiles qui vont bouger SUIVENT le doigt / la souris, chacune jusqu'a
##   sa case d'arrivee au maximum (on voit a l'avance ce qui va se passer).
## - Au relacher (au moins SWIPE_MIN_DISTANCE), elles finissent de glisser (SLIDE_SECONDS), PUIS
##   les fusions se font et la nouvelle tuile apparait. Relacher trop tot = tout revient en place.
class_name Animaux2048
extends MiniGame

const GAME_ID := "animaux_2048"
const TITLE := "2048 des animaux"
const RULES := "Fais glisser ton doigt ou la souris pour pousser toutes les tuiles. Deux animaux identiques qui se touchent fusionnent et se transforment en un nouvel animal. Jusqu'où iras-tu ?"

class Tile:
	var level: int = 1
	var cell: int = 0
	var pos: Vector2 = Vector2.ZERO ## position affichee
	var from_pos: Vector2 = Vector2.ZERO ## position au debut de l'animation de glissement
	var target_cell: int = 0
	var dies: bool = false ## absorbee par une autre tuile a la fin du glissement
	var grows: bool = false ## monte d'un niveau a la fin du glissement
	var pop: float = 0.0

const SIZE := 4
const BOARD := Rect2(326, 110, 500, 500)
const CELL_GAP := 12.0
const SWIPE_MIN_DISTANCE := 40.0
const DRAG_DEAD_ZONE := 8.0
const FOUR_CHANCE := 0.1
const POP_SECONDS := 0.18
const SLIDE_SECONDS := 0.12
const RETURN_SPEED := 2500.0

const BACKGROUND_COLOR := Color(0.98, 0.94, 0.9)
const BOARD_COLOR := Color(0.6, 0.48, 0.4)
const EMPTY_COLOR := Color(0.78, 0.68, 0.6)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)

var _playing: bool = false
var _score: int = 0
var _tiles: Array[Tile] = []
var _dragging: bool = false
var _drag_start: Vector2 = Vector2.ZERO
var _drag_delta: Vector2 = Vector2.ZERO
var _animating: bool = false
var _anim_t: float = 0.0
var _textures: Array[Texture2D] = []
var _tile_style: StyleBoxFlat

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_textures = MiniGame.get_grade_textures(grade)
	_tile_style = StyleBoxFlat.new()
	_tile_style.set_corner_radius_all(12)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_score = 0
	_tiles.clear()
	_dragging = false
	_animating = false
	_spawn_tile()
	_spawn_tile()
	_playing = true
	_hud.start_play(0)

func _end_game() -> void:
	_playing = false
	_hud.show_game_over(_score, "Plus aucun mouvement !")

func _close() -> void:
	closed.emit()

# --- Grille -------------------------------------------------------------------------------------

func _cell_size() -> float:
	return (BOARD.size.x - CELL_GAP * (SIZE - 1)) / SIZE

func _cell_position(cell: int) -> Vector2:
	var col := cell % SIZE
	var row := floori(float(cell) / float(SIZE))
	return BOARD.position + Vector2(col, row) * (_cell_size() + CELL_GAP)

func _tile_at(cell: int) -> Tile:
	for tile in _tiles:
		if tile.cell == cell:
			return tile
	return null

## Cases d'une ligne (ou colonne), dans l'ordre en partant du bord vers lequel on pousse.
func _line_cells(dir: Vector2i, index: int) -> Array[int]:
	var cells: Array[int] = []
	for k in SIZE:
		var step := k if dir.x < 0 or dir.y < 0 else SIZE - 1 - k
		if dir.x != 0:
			cells.append(index * SIZE + step)
		else:
			cells.append(step * SIZE + index)
	return cells

## Calcule ou va chaque tuile pour une direction (target_cell, dies, grows) sans rien changer
## d'autre. Renvoie true si au moins une tuile bouge ou fusionne.
func _plan(dir: Vector2i) -> bool:
	var changes := false
	for tile in _tiles:
		tile.target_cell = tile.cell
		tile.dies = false
		tile.grows = false
	for index in SIZE:
		var cells := _line_cells(dir, index)
		var last: Tile = null
		var last_merged := false
		var slot := -1
		for cell in cells:
			var tile := _tile_at(cell)
			if tile == null:
				continue
			if last != null and last.level == tile.level and not last_merged:
				tile.target_cell = last.target_cell
				tile.dies = true
				last.grows = true
				last_merged = true
				changes = true
			else:
				slot += 1
				tile.target_cell = cells[slot]
				if tile.target_cell != tile.cell:
					changes = true
				last = tile
				last_merged = false
	return changes

static func _drag_direction(delta: Vector2) -> Vector2i:
	if absf(delta.x) > absf(delta.y):
		return Vector2i(1, 0) if delta.x > 0.0 else Vector2i(-1, 0)
	return Vector2i(0, 1) if delta.y > 0.0 else Vector2i(0, -1)

# --- Controles ----------------------------------------------------------------------------------

func _gui_input(event: InputEvent) -> void:
	if not _playing or _animating:
		return
	if event is InputEventMouseMotion and _dragging:
		_drag_delta = (event as InputEventMouseMotion).position - _drag_start
		accept_event()
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT:
		return
	accept_event()
	if button.pressed:
		_dragging = true
		_drag_start = button.position
		_drag_delta = Vector2.ZERO
		return
	if not _dragging:
		return
	_dragging = false
	_drag_delta = button.position - _drag_start
	if _drag_delta.length() >= SWIPE_MIN_DISTANCE and _plan(_drag_direction(_drag_delta)):
		_start_slide()
	_drag_delta = Vector2.ZERO

func _start_slide() -> void:
	for tile in _tiles:
		tile.from_pos = tile.pos
	_animating = true
	_anim_t = 0.0

## Fin du glissement : les fusions s'appliquent, puis la nouvelle tuile apparait.
func _finish_slide() -> void:
	_animating = false
	var gained := 0
	for i in range(_tiles.size() - 1, -1, -1):
		var tile := _tiles[i]
		if tile.dies:
			_tiles.remove_at(i)
			continue
		tile.cell = tile.target_cell
		tile.pos = _cell_position(tile.cell)
		if tile.grows:
			tile.level += 1
			tile.grows = false
			tile.pop = 1.0
			gained += 1 << tile.level
	if gained > 0:
		_score += gained
		_hud.set_score(_score)
		SoundManager.play(SoundManager.Sfx.CORRECT)
	else:
		SoundManager.play(SoundManager.Sfx.CLICK)
	_spawn_tile()
	if not _can_move():
		_end_game()

func _spawn_tile() -> void:
	var empty: Array[int] = []
	for cell in SIZE * SIZE:
		if _tile_at(cell) == null:
			empty.append(cell)
	if empty.is_empty():
		return
	var tile := Tile.new()
	tile.cell = empty.pick_random()
	tile.target_cell = tile.cell
	tile.level = 2 if randf() < FOUR_CHANCE else 1
	tile.pos = _cell_position(tile.cell)
	tile.pop = 1.0
	_tiles.append(tile)

func _can_move() -> bool:
	if _tiles.size() < SIZE * SIZE:
		return true
	for tile in _tiles:
		var col := tile.cell % SIZE
		var row := floori(float(tile.cell) / float(SIZE))
		if col < SIZE - 1 and _tile_at(tile.cell + 1).level == tile.level:
			return true
		if row < SIZE - 1 and _tile_at(tile.cell + SIZE).level == tile.level:
			return true
	return false

# --- Animation ----------------------------------------------------------------------------------

func _process(delta: float) -> void:
	for tile in _tiles:
		tile.pop = maxf(0.0, tile.pop - delta / POP_SECONDS)
	if _animating:
		_anim_t = minf(1.0, _anim_t + delta / SLIDE_SECONDS)
		var eased := 1.0 - pow(1.0 - _anim_t, 2.0)
		for tile in _tiles:
			tile.pos = tile.from_pos.lerp(_cell_position(tile.target_cell), eased)
		if _anim_t >= 1.0:
			_finish_slide()
	elif _dragging and _drag_delta.length() > DRAG_DEAD_ZONE:
		## Apercu : les tuiles qui vont bouger suivent le doigt, chacune jusqu'a sa case d'arrivee.
		var dir := _drag_direction(_drag_delta)
		_plan(dir)
		var along := maxf(0.0, _drag_delta.dot(Vector2(dir)))
		for tile in _tiles:
			var start := _cell_position(tile.cell)
			var travel := _cell_position(tile.target_cell) - start
			tile.pos = start + travel.normalized() * minf(along, travel.length()) if travel.length() > 0.0 else start
	else:
		## Relache trop tot (ou au repos) : chaque tuile revient doucement a sa case.
		for tile in _tiles:
			tile.pos = tile.pos.move_toward(_cell_position(tile.cell), RETURN_SPEED * delta)
	queue_redraw()

# --- Dessin -------------------------------------------------------------------------------------

func _texture_for(level: int) -> Texture2D:
	if _textures.is_empty():
		return null
	return _textures[(level - 1) % _textures.size()]

func _tile_color(level: int) -> Color:
	return Color.from_hsv(fmod(0.08 + level * 0.09, 1.0), 0.45, 1.0)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	if not _playing and _tiles.is_empty():
		return
	_tile_style.bg_color = BOARD_COLOR
	draw_style_box(_tile_style, BOARD.grow(CELL_GAP))
	var cell_size := _cell_size()
	_tile_style.bg_color = EMPTY_COLOR
	for cell in SIZE * SIZE:
		draw_style_box(_tile_style, Rect2(_cell_position(cell), Vector2(cell_size, cell_size)))
	## Les tuiles absorbees d'abord, pour qu'elles passent sous celle qui grandit.
	var best := 0
	for pass_index in 2:
		for tile in _tiles:
			if tile.dies != (pass_index == 0):
				continue
			best = maxi(best, tile.level)
			_draw_tile(tile, cell_size)
	if best > 0:
		_draw_best(best)

func _draw_tile(tile: Tile, cell_size: float) -> void:
	var bounce := 8.0 * sin(tile.pop * PI)
	var rect := Rect2(tile.pos, Vector2(cell_size, cell_size)).grow(bounce)
	_tile_style.bg_color = _tile_color(tile.level)
	draw_style_box(_tile_style, rect)
	var texture := _texture_for(tile.level)
	if texture:
		draw_texture_rect(texture, MiniGame.fit_rect(texture.get_size(), Rect2(rect.position + Vector2(8, 6), rect.size - Vector2(16, 34))), false)
	draw_string(get_theme_default_font(), Vector2(rect.position.x, rect.end.y - 8.0), str(1 << tile.level), HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 22, INK_COLOR)

## Meilleur animal obtenu, a droite.
func _draw_best(best: int) -> void:
	var font := get_theme_default_font()
	draw_string(font, Vector2(880, 150), "Ton plus bel animal", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, INK_COLOR)
	var best_rect := Rect2(890, 170, 180, 200)
	_tile_style.bg_color = _tile_color(best)
	draw_style_box(_tile_style, best_rect)
	var best_texture := _texture_for(best)
	if best_texture:
		draw_texture_rect(best_texture, MiniGame.fit_rect(best_texture.get_size(), best_rect.grow(-12.0)), false)
	draw_string(font, Vector2(best_rect.position.x, best_rect.end.y + 34.0), str(1 << best), HORIZONTAL_ALIGNMENT_CENTER, best_rect.size.x, 30, INK_COLOR)
