## Habillage commun a tous les mini-jeux (2026-11-25, sorti de Pluie de biscuits a l'arrivee du
## 2e jeu) : boutons Quitter + TOP, score, coeurs, fenetres "Jouer" / "Partie terminee" et
## classement des 10 meilleurs joueurs. Chaque jeu l'instancie en DERNIER enfant de sa racine
## (dessine par-dessus le terrain), l'appelle via setup()/start_play()/set_score()/set_lives()/
## show_game_over() et ecoute play_pressed / quit_pressed - il ne garde que son gameplay.
##
## Racine en mouse_filter IGNORE : hors boutons et fenetres, les clics/taps traversent jusqu'au
## jeu (son _gui_input). Bouton TOP actif seulement hors partie.
##
## Prix d'une partie (2026-11-25) : GAME_PRICE pieces de la classe du jeu, debitees a chaque clic
## sur Jouer/Rejouer (Economy + journal "depense_piece" + sauvegarde, exactement comme un achat en
## boutique). Le solde de la classe est affiche en haut ; boutons desactives et message explicatif
## si pieces insuffisantes ou collection de la classe incomplete.
##
## Scores : show_game_over() envoie le score au serveur (SaveManager.submit_minigame_score, table
## scores_minijeux) qui ne garde que le meilleur par joueur ; le classement (fn_top_scores) montre
## chaque pseudo une seule fois. Echec reseau = message, jamais de deconnexion forcee.
class_name MiniGameHud
extends Control

signal play_pressed
signal quit_pressed

const GAME_PRICE := 10
const HEART_COLOR := Color(0.9, 0.22, 0.3)
const HEART_EMPTY_COLOR := Color(1, 1, 1, 0.5)

var _game_id: String = ""
var _grade: GradeLevel.Grade = GradeLevel.Grade.CP
var _accent: Color = Color.WHITE
var _playing: bool = false
var _lives: int = 0
var _max_lives: int = 0
## Numeros de requete : ignore une reponse serveur arrivee apres une nouvelle action du joueur.
var _top_request_id: int = 0
var _over_request_id: int = 0

@onready var _quit_button: Button = %QuitButton
@onready var _top_button: Button = %TopButton
@onready var _score_label: Label = %ScoreLabel
@onready var _start_panel: Control = %StartPanel
@onready var _start_title: Label = %StartTitle
@onready var _rules_label: Label = %RulesLabel
@onready var _play_button: Button = %PlayButton
@onready var _over_panel: Control = %OverPanel
@onready var _over_title: Label = %OverTitle
@onready var _over_label: Label = %OverLabel
@onready var _replay_button: Button = %ReplayButton
@onready var _back_button: Button = %BackButton
@onready var _top_panel: Control = %TopPanel
@onready var _top_status: Label = %TopStatus
@onready var _top_list: VBoxContainer = %TopList
@onready var _my_best_label: Label = %MyBestLabel
@onready var _top_close_button: Button = %TopCloseButton
@onready var _coin_icon: TextureRect = %CoinIcon
@onready var _coin_label: Label = %CoinLabel
@onready var _start_cost_label: Label = %StartCostLabel
@onready var _over_cost_label: Label = %OverCostLabel

func _ready() -> void:
	_quit_button.pressed.connect(_on_quit_pressed)
	_back_button.pressed.connect(_on_quit_pressed)
	_play_button.pressed.connect(_on_play_pressed)
	_replay_button.pressed.connect(_on_play_pressed)
	_top_button.pressed.connect(_open_top)
	_top_close_button.pressed.connect(_close_top)
	_top_panel.hide()
	_over_panel.hide()
	_start_panel.show()
	set_score(0)
	Economy.balance_changed.connect(_on_balance_changed)

## A appeler dans le _ready() du jeu. [game_id] = identifiant serveur (minuscules, chiffres, _),
## [grade] = classe du jeu (monnaie depensee, couleurs).
func setup(game_id: String, title: String, rules: String, grade: GradeLevel.Grade) -> void:
	_game_id = game_id
	_grade = grade
	_start_title.text = title
	_rules_label.text = rules
	_accent = GradeLevel.get_color(grade)
	_coin_icon.texture = load(GradeLevel.get_coin_pile_icon_path(grade)) as Texture2D
	_refresh_coins()

func start_play(max_lives: int) -> void:
	_playing = true
	_over_request_id += 1
	_start_panel.hide()
	_over_panel.hide()
	_close_top()
	_top_button.disabled = true
	set_score(0)
	set_lives(max_lives, max_lives)

func set_score(score: int) -> void:
	_score_label.text = "Points : %d" % score

func set_lives(lives: int, max_lives: int) -> void:
	_lives = lives
	_max_lives = max_lives
	queue_redraw()

## Fin de partie : fenetre de fin + envoi du score. [title] permet un titre propre au jeu
## (ex. "Le serpent t'a mordu !").
func show_game_over(score: int, title: String = "Partie terminée !") -> void:
	_playing = false
	_top_button.disabled = false
	_over_request_id += 1
	var request_id := _over_request_id
	_over_title.text = title
	_over_label.text = "Tu as fait %d points.\nEnregistrement du score..." % score
	SoundManager.play(SoundManager.Sfx.PACK_REWARD)
	_over_panel.show()
	var result := await SaveManager.submit_minigame_score(_game_id, score)
	if request_id != _over_request_id:
		return # une nouvelle partie a commence pendant l'envoi
	if result.is_empty():
		_over_label.text = "Tu as fait %d points.\nLe score n'a pas pu être enregistré." % score
	elif bool(result.get("nouveau_record", false)) and score > 0:
		_over_label.text = "Nouveau record : %d points !" % score
	else:
		_over_label.text = "Tu as fait %d points.\nTon record : %d points." % [score, int(result.get("meilleur_score", score))]

## Debite GAME_PRICE pieces de la classe puis lance la partie (meme sequence qu'un achat en
## boutique : Economy.try_spend, journal serveur, sauvegarde).
func _on_play_pressed() -> void:
	if not _can_play():
		_refresh_coins()
		return
	var rarity := GradeLevel.get_rarity(_grade)
	if not Economy.try_spend(rarity, GAME_PRICE):
		_refresh_coins()
		return
	SaveManager.log_event("depense_piece", {"rarity": int(rarity), "montant": GAME_PRICE})
	SaveManager.save_current_account()
	play_pressed.emit()

func _get_balance() -> int:
	return Economy.get_balance(GradeLevel.get_rarity(_grade))

func _can_play() -> bool:
	return PlaygroundChildPopup.is_collection_complete(_grade) and _get_balance() >= GAME_PRICE

func _on_balance_changed(_rarity: CardRarity.Rarity, _amount: int) -> void:
	_refresh_coins()

## Solde affiche en haut + message de prix sous les regles (debut) et sous le score (fin).
func _refresh_coins() -> void:
	var balance := _get_balance()
	var grade_label := GradeLevel.get_label(_grade)
	_coin_label.text = str(balance)
	var text := ""
	if not PlaygroundChildPopup.is_collection_complete(_grade):
		text = "Il te faut toutes les cartes du %s pour jouer à ce jeu." % grade_label
	elif balance >= GAME_PRICE:
		text = "Chaque partie coûte %d pièces du %s, gagnées en répondant aux questions en classe. Il t'en reste %d." % [GAME_PRICE, grade_label, balance]
	else:
		text = "Il te faut %d pièces du %s pour jouer et tu en as %d. Retourne en classe répondre aux questions pour en gagner !" % [GAME_PRICE, grade_label, balance]
	_start_cost_label.text = text
	_over_cost_label.text = text
	_play_button.disabled = not _can_play()
	_replay_button.disabled = not _can_play()

func _on_quit_pressed() -> void:
	quit_pressed.emit()

## Fenetre des 10 meilleurs joueurs : jamais pendant une partie (bouton TOP desactive).
func _open_top() -> void:
	if _playing:
		return
	for row in _top_list.get_children():
		row.queue_free()
	_top_status.text = "Chargement..."
	_top_status.show()
	_my_best_label.text = ""
	_top_panel.show()
	_top_request_id += 1
	var request_id := _top_request_id
	var data := await SaveManager.fetch_minigame_top(_game_id)
	if request_id != _top_request_id or not _top_panel.visible:
		return
	if data.is_empty():
		_top_status.text = "Impossible de charger les scores. Vérifie ta connexion et réessaie."
		return
	var my_score: Variant = data.get("mon_score")
	_my_best_label.text = "Ton record : %d points" % int(my_score) if my_score != null else "Tu n'as pas encore de score."
	var top: Array = data.get("top", [])
	if top.is_empty():
		_top_status.text = "Personne n'a encore de score. Sois le premier !"
		return
	_top_status.hide()
	for i in top.size():
		var entry := top[i] as Dictionary
		_top_list.add_child(_make_top_row(i + 1, String(entry.get("pseudo", "")), int(entry.get("score", 0)), bool(entry.get("moi", false))))

func _close_top() -> void:
	_top_request_id += 1
	_top_panel.hide()

## Une ligne du classement : rang, pseudo, score. La ligne du joueur connecte est en couleur.
func _make_top_row(rank: int, pseudo: String, score: int, is_me: bool) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)
	var rank_label := Label.new()
	rank_label.text = "%d." % rank
	rank_label.custom_minimum_size = Vector2(40, 0)
	rank_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	var name_label := Label.new()
	name_label.text = pseudo
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.clip_text = true
	var score_label := Label.new()
	score_label.text = "%d" % score
	score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	for label: Label in [rank_label, name_label, score_label]:
		if is_me:
			label.add_theme_color_override("font_color", _accent.darkened(0.3))
		row.add_child(label)
	return row

## Coeurs en haut a droite (dessines sous les fenetres, qui sont des enfants).
func _draw() -> void:
	for i in _max_lives:
		var center := Vector2(size.x - 40.0 - 44.0 * i, 42.0)
		var color := HEART_COLOR if i < _lives else HEART_EMPTY_COLOR
		draw_circle(center + Vector2(-7, -4), 9.0, color)
		draw_circle(center + Vector2(7, -4), 9.0, color)
		draw_colored_polygon(PackedVector2Array([center + Vector2(-15.5, -1), center + Vector2(15.5, -1), center + Vector2(0, 16)]), color)
