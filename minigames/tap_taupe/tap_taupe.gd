## Mini-jeu du CP n°2 : Tap taupe (2026-11-25). Jeu de vitesse : des taupes sortent des trous,
## restent un instant puis replongent. Les taper rapporte des points (taupe = 1, taupe en or = 3,
## plus rapide a disparaitre). Une taupe qui replonge sans avoir ete touchee = 1 vie perdue
## (3 vies). Des serpents sortent aussi : en toucher un fait perdre la partie. Rythme, temps de
## sortie et nombre de taupes simultanees augmentent avec le score.
##
## Decor (vue a 45 degres par le haut) : mettre l'image dans Background (texture) - sans image,
## fond vert provisoire. Chaque noeud de Holes (MoleHole) se place sur un trou ovale du decor :
## centre du trou = bas-milieu du noeud, a 30 px du bord inferieur (voir mole_hole.gd). Ajouter
## ou retirer des trous dans Holes suffit, le jeu les trouve tout seul. Decocher show_hole sur
## chaque trou une fois le decor en place (il dessine sinon un trou provisoire).
## Visuels de taupe/serpent optionnels via les 3 exports *_texture (dessin provisoire sinon).
##
## Controle : clic ou tap sur la creature (evenements souris, tactile emule - voir MiniGame).
class_name TapTaupe
extends MiniGame

## Identifiant du jeu cote serveur (colonne scores_minijeux.jeu).
const GAME_ID := "tap_taupe"
const TITLE := "Tap taupe"
const RULES := "Tape vite sur les taupes avant qu'elles replongent ! Une taupe en or vaut 3 points. Si une taupe t'échappe, tu perds une vie. Et surtout, ne touche pas les serpents !"

const START_LIVES := 3
const MOLE_POINTS := 1
const GOLD_POINTS := 3
const BASE_UP_SECONDS := 1.4
const UP_SECONDS_PER_POINT := 0.02
const MIN_UP_SECONDS := 0.65
const GOLD_UP_FACTOR := 0.7
const SNAKE_UP_FACTOR := 1.2
const FIRST_SPAWN_DELAY := 0.6
const BASE_SPAWN_INTERVAL := 1.0
const SPAWN_INTERVAL_PER_POINT := 0.015
const MIN_SPAWN_INTERVAL := 0.45
const GOLD_CHANCE := 0.1
const BASE_SNAKE_CHANCE := 0.1
const SNAKE_CHANCE_PER_POINT := 0.003
const MAX_SNAKE_CHANCE := 0.22
## Une creature de plus en meme temps tous les N points, jusqu'a MAX_ACTIVE.
const POINTS_PER_EXTRA_CREATURE := 10
const MAX_ACTIVE := 3
const GRASS_COLOR := Color(0.47, 0.73, 0.38)

@export var mole_texture: Texture2D
@export var gold_mole_texture: Texture2D
@export var snake_texture: Texture2D

var _playing: bool = false
var _score: int = 0
var _lives: int = START_LIVES
var _spawn_timer: float = 0.0
var _holes: Array[MoleHole] = []

@onready var _background: TextureRect = $Background
@onready var _holes_root: Control = $Holes
@onready var _hud: MiniGameHud = $Hud

func _ready() -> void:
	## Enfant d'un CanvasLayer : le theme choisi ne descend pas tout seul (meme cas que BackpackMenu).
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_hud.setup(GAME_ID, TITLE, RULES, grade)
	_hud.play_pressed.connect(_start_game)
	_hud.quit_pressed.connect(_close)
	var textures := {}
	if mole_texture:
		textures[MoleHole.Kind.MOLE] = mole_texture
	if gold_mole_texture:
		textures[MoleHole.Kind.GOLD] = gold_mole_texture
	if snake_texture:
		textures[MoleHole.Kind.SNAKE] = snake_texture
	for node in _holes_root.get_children():
		var hole := node as MoleHole
		if hole == null:
			continue
		hole.set_textures(textures)
		hole.whacked.connect(_on_whacked)
		hole.escaped.connect(_on_escaped)
		_holes.append(hole)

func _draw() -> void:
	if _background.texture == null:
		draw_rect(Rect2(Vector2.ZERO, size), GRASS_COLOR)

func _start_game() -> void:
	_score = 0
	_lives = START_LIVES
	_spawn_timer = FIRST_SPAWN_DELAY
	for hole in _holes:
		hole.clear()
	_playing = true
	_hud.start_play(START_LIVES)

func _end_game(title: String = "Partie terminée !") -> void:
	_playing = false
	for hole in _holes:
		hole.clear()
	_hud.show_game_over(_score, title)

func _close() -> void:
	closed.emit()

func _process(delta: float) -> void:
	if not _playing:
		return
	_spawn_timer -= delta
	if _spawn_timer <= 0.0:
		_spawn_creature()
		_spawn_timer = maxf(MIN_SPAWN_INTERVAL, BASE_SPAWN_INTERVAL - SPAWN_INTERVAL_PER_POINT * float(_score))

func _spawn_creature() -> void:
	var free_holes: Array[MoleHole] = []
	var active := 0
	for hole in _holes:
		if hole.is_free():
			free_holes.append(hole)
		else:
			active += 1
	var max_active := mini(MAX_ACTIVE, 1 + int(float(_score) / float(POINTS_PER_EXTRA_CREATURE)))
	if free_holes.is_empty() or active >= max_active:
		return
	var hole: MoleHole = free_holes.pick_random()
	var up_seconds := maxf(MIN_UP_SECONDS, BASE_UP_SECONDS - UP_SECONDS_PER_POINT * float(_score))
	var snake_chance := minf(MAX_SNAKE_CHANCE, BASE_SNAKE_CHANCE + SNAKE_CHANCE_PER_POINT * float(_score))
	var roll := randf()
	if roll < snake_chance:
		hole.pop(MoleHole.Kind.SNAKE, up_seconds * SNAKE_UP_FACTOR)
		MiniGameSounds.play_tone(1.0, 0.4, MiniGameSounds.Wave.NOISE, -16.0) ## sifflement
	else:
		if roll < snake_chance + GOLD_CHANCE:
			hole.pop(MoleHole.Kind.GOLD, up_seconds * GOLD_UP_FACTOR)
		else:
			hole.pop(MoleHole.Kind.MOLE, up_seconds)
		MiniGameSounds.play_tone(300.0, 0.12, MiniGameSounds.Wave.SINE, -12.0, 750.0) ## "pop"

func _on_whacked(_hole: MoleHole, kind: int) -> void:
	if not _playing:
		return
	match kind:
		MoleHole.Kind.MOLE:
			_play_bonk()
			_add_points(MOLE_POINTS)
		MoleHole.Kind.GOLD:
			_play_bonk()
			MiniGameSounds.play_arpeggio([MiniGameSounds.E6, MiniGameSounds.G6, MiniGameSounds.C7], 0.07, 0.05)
			_add_points(GOLD_POINTS)
		MoleHole.Kind.SNAKE:
			MiniGameSounds.play_tone(1.0, 0.5, MiniGameSounds.Wave.NOISE, -8.0)
			SoundManager.play(SoundManager.Sfx.WRONG)
			_end_game("Le serpent t'a mordu !")

## Taupe ratee = 1 vie ; un serpent qui repart tout seul ne compte pas.
func _on_escaped(_hole: MoleHole, kind: int) -> void:
	if not _playing or kind == MoleHole.Kind.SNAKE:
		return
	_lives -= 1
	MiniGameSounds.play_tone(420.0, 0.35, MiniGameSounds.Wave.TRIANGLE, -6.0, 160.0) ## "rate !"
	_hud.set_lives(_lives, START_LIVES)
	if _lives <= 0:
		_end_game()

## "Bonk" de marteau : son court qui descend.
func _play_bonk() -> void:
	MiniGameSounds.play_tone(600.0, 0.16, MiniGameSounds.Wave.TRIANGLE, -2.0, 160.0)

func _add_points(points: int) -> void:
	_score += points
	_hud.set_score(_score)
