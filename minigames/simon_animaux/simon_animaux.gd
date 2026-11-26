## Mini-jeu du CE1 n°2 : Simon des animaux (2026-11-25, propose par Jean). Des cases avec des
## animaux de la collection CE1 s'allument l'une apres l'autre ; il faut toucher les memes cases
## dans le meme ordre. A chaque manche reussie, la suite s'allonge d'un animal.
##
## Progression : 4 cases au debut, 6 cases des que la suite atteint SIX_PADS_FROM_LENGTH animaux ;
## l'allumage accelere un peu a chaque manche. Une erreur = 1 vie perdue (3 vies) et la meme suite
## est rejouee. Points : la longueur de chaque suite reussie.
##
## Complementaire du Memory (memoire des positions) : ici, memoire d'un ordre. Tout est dessine
## dans _draw() ; clic ou tap sur une case (evenements souris, tactile emule - voir MiniGame).
class_name SimonAnimaux
extends MiniGame

const GAME_ID := "simon_animaux"
const TITLE := "Simon des animaux"
const RULES := "Regarde bien les animaux qui s'allument, puis touche-les dans le même ordre. À chaque réussite, la suite s'allonge ! Tu as 3 vies."

enum Phase { IDLE, SHOWING, INPUT, PAUSE }

const START_LIVES := 3
const SIX_PADS_FROM_LENGTH := 6
const BASE_ON_SECONDS := 0.6
const ON_SECONDS_PER_STEP := 0.02
const MIN_ON_SECONDS := 0.35
const GAP_SECONDS := 0.25
const START_DELAY := 0.7
const TAP_FLASH_SECONDS := 0.2
const SUCCESS_PAUSE := 0.8
const FAIL_PAUSE := 1.2
const PAD_GAP := 28.0
const PLAY_AREA := Rect2(176, 150, 800, 470)
const STATUS_Y := 125.0

const BACKGROUND_COLOR := Color(0.94, 0.95, 0.99)
const INK_COLOR := Color(0.478431, 0.290196, 0.168627)
## Une note par animal (gamme pentatonique : toutes les notes sonnent bien ensemble). Les 4 premieres
## (do mi sol do aigu) restent les memes quand on passe a 6 animaux.
const PAD_NOTES: Array[float] = [MiniGameSounds.C5, MiniGameSounds.E5, MiniGameSounds.G5, MiniGameSounds.C6, MiniGameSounds.D5, MiniGameSounds.A5]
const PAD_COLORS := [Color(0.95, 0.4, 0.4), Color(0.35, 0.6, 0.95), Color(0.98, 0.8, 0.25), Color(0.4, 0.78, 0.4), Color(0.72, 0.45, 0.9), Color(1.0, 0.6, 0.3)]

var _playing: bool = false
var _phase: Phase = Phase.IDLE
var _sequence: Array[int] = []
var _step: int = 0
var _timer: float = 0.0
var _light_on: bool = false
var _lit_pad: int = -1
var _tap_flash: float = 0.0
var _pad_count: int = 4
var _pad_rects: Array[Rect2] = []
var _pad_textures: Array[Texture2D] = []
var _after_pause: Callable
var _score: int = 0
var _lives: int = START_LIVES
var _pad_style: StyleBoxFlat

@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_pad_style = StyleBoxFlat.new()
	_pad_style.set_corner_radius_all(24)
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)

func _start_game() -> void:
	_score = 0
	_lives = START_LIVES
	_sequence.clear()
	var textures := MiniGame.get_grade_textures(grade)
	textures.shuffle()
	_pad_textures.clear()
	for texture in textures:
		if _pad_textures.size() < PAD_COLORS.size():
			_pad_textures.append(texture)
	_set_pad_count(4)
	_playing = true
	_hud.start_play(START_LIVES)
	_next_round()

func _set_pad_count(count: int) -> void:
	_pad_count = count
	var cols := 2 if count == 4 else 3
	var rows := 2
	var pad_size := minf((PLAY_AREA.size.x - PAD_GAP * (cols - 1)) / cols, (PLAY_AREA.size.y - PAD_GAP * (rows - 1)) / rows)
	var total := Vector2(cols * pad_size + (cols - 1) * PAD_GAP, rows * pad_size + (rows - 1) * PAD_GAP)
	var origin := PLAY_AREA.position + (PLAY_AREA.size - total) * 0.5
	_pad_rects.clear()
	for i in count:
		var col := i % cols
		var row := floori(float(i) / float(cols))
		_pad_rects.append(Rect2(origin + Vector2(col, row) * (pad_size + PAD_GAP), Vector2(pad_size, pad_size)))

func _next_round() -> void:
	if _pad_count == 4 and _sequence.size() + 1 >= SIX_PADS_FROM_LENGTH:
		_set_pad_count(6)
	_sequence.append(randi() % _pad_count)
	_play_sequence()

func _play_sequence() -> void:
	_phase = Phase.SHOWING
	_step = 0
	_light_on = false
	_lit_pad = -1
	_timer = START_DELAY

func _pause(seconds: float, then: Callable) -> void:
	_phase = Phase.PAUSE
	_timer = seconds
	_after_pause = then

func _end_game() -> void:
	_playing = false
	_phase = Phase.IDLE
	_lit_pad = -1
	_hud.show_game_over(_score)

func _close() -> void:
	closed.emit()

func _process(delta: float) -> void:
	if _tap_flash > 0.0:
		_tap_flash -= delta
		if _tap_flash <= 0.0 and _phase != Phase.SHOWING:
			_lit_pad = -1
	match _phase:
		Phase.SHOWING:
			_timer -= delta
			if _timer <= 0.0:
				if _light_on:
					_light_on = false
					_lit_pad = -1
					_step += 1
					_timer = GAP_SECONDS
					if _step >= _sequence.size():
						_phase = Phase.INPUT
						_step = 0
				else:
					_light_on = true
					_lit_pad = _sequence[_step]
					_play_pad_note(_lit_pad)
					_timer = maxf(MIN_ON_SECONDS, BASE_ON_SECONDS - ON_SECONDS_PER_STEP * _sequence.size())
		Phase.PAUSE:
			_timer -= delta
			if _timer <= 0.0:
				_after_pause.call()
	queue_redraw()

func _gui_input(event: InputEvent) -> void:
	if not _playing or _phase != Phase.INPUT:
		return
	var button := event as InputEventMouseButton
	if button == null or button.button_index != MOUSE_BUTTON_LEFT or not button.pressed:
		return
	for pad in _pad_count:
		if _pad_rects[pad].has_point(button.position):
			accept_event()
			_on_pad_pressed(pad)
			return

func _on_pad_pressed(pad: int) -> void:
	_lit_pad = pad
	_tap_flash = TAP_FLASH_SECONDS
	if pad == _sequence[_step]:
		_play_pad_note(pad)
		_step += 1
		if _step >= _sequence.size():
			_score += _sequence.size()
			_hud.set_score(_score)
			MiniGameSounds.play_arpeggio([MiniGameSounds.C6, MiniGameSounds.E6, MiniGameSounds.G6, MiniGameSounds.C7], 0.08, 0.3)
			_pause(SUCCESS_PAUSE, _next_round)
		return
	MiniGameSounds.play_tone(200.0, 0.55, MiniGameSounds.Wave.SQUARE, -10.0, 90.0)
	_lives -= 1
	_hud.set_lives(_lives, START_LIVES)
	if _lives <= 0:
		_end_game()
	else:
		_pause(FAIL_PAUSE, _play_sequence)

func _play_pad_note(pad: int) -> void:
	MiniGameSounds.play_tone(PAD_NOTES[pad % PAD_NOTES.size()], 0.5, MiniGameSounds.Wave.TRIANGLE, -3.0)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), BACKGROUND_COLOR)
	if _pad_rects.is_empty():
		return
	var status := ""
	match _phase:
		Phase.SHOWING:
			status = "Regarde bien..."
		Phase.INPUT:
			status = "À toi ! %d / %d" % [_step, _sequence.size()]
	if not status.is_empty():
		draw_string(get_theme_default_font(), Vector2(0, STATUS_Y), status, HORIZONTAL_ALIGNMENT_CENTER, size.x, 30, INK_COLOR)
	for pad in _pad_count:
		var rect := _pad_rects[pad]
		var lit := pad == _lit_pad
		var color: Color = PAD_COLORS[pad]
		_pad_style.bg_color = color.lightened(0.45) if lit else color.darkened(0.1)
		_pad_style.border_color = Color.WHITE if lit else color.darkened(0.35)
		_pad_style.set_border_width_all(8 if lit else 4)
		draw_style_box(_pad_style, rect.grow(6.0) if lit else rect)
		if pad < _pad_textures.size():
			var texture := _pad_textures[pad]
			var tint := Color.WHITE if lit else Color(1, 1, 1, 0.85)
			draw_texture_rect(texture, MiniGame.fit_rect(texture.get_size(), rect.grow(-18.0)), false, tint)
