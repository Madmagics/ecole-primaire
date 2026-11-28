## Badge discret (bas gauche de l'ecran) indiquant la progression du jour vis-a-vis de la limite
## de controle parental (2026-09-06, retour utilisateur : "on peut ajouter un badge discret en bas
## a gauche de l'ecran avec explication en popup si click ou activation touch") - suite directe de
## l'application reelle de la limite quotidienne (compteur + remise a zero a minuit + blocage),
## voir feedback_parental_control_checkbox.md en memoire projet.
##
## Visible SEULEMENT si le compte connecte a une limite reellement definie
## (SaveManager.get_daily_game_limit() > 0) - rien a signaler sinon, y compris si personne n'est
## connecte (get_daily_game_limit() renvoie deja 0 dans ce cas, profil vide - pas besoin de
## verifier current_account_id separement ici) - ET si aucune fenetre du jeu n'est ouverte par-
## dessus la classe (2026-09-06, retour utilisateur : "le badge ne doit apparaitre que dans la
## grande fenetre de classe comme actuellement, je ne la veux pas dans les autres fenetres" - le
## badge restait affiche par-dessus GameMenuPanel/ShopPanel/etc., signale explicitement comme un
## defaut dans le commentaire de la version precedente). Voir hidden_when_visible_paths ci-dessous,
## meme principe que MenuToggleButton.toggled_panel_paths (ui/hud/menu_toggle_button.gd) : liste
## generique de Control a surveiller, assignee depuis game_ui.tscn plutot que codee en dur ici.
## Se rafraichit a la connexion/deconnexion d'un compte, a chaque questionnaire termine
## (EventBus.pack_completed, meme signal que SaveManager/StatsTracker pour ce compteur), et a
## chaque changement de visibilite d'une des fenetres surveillees.
##
## Le popup explicatif (ui/hud/daily_limit_popup.tscn, meme moule BlurBG+Card que QuitOverlay/
## ParentalGateOverlay) est un noeud EXTERNE (voir popup_path, meme mecanisme de NodePath que
## GameMenuPanel.quit_overlay_path) plutot qu'imbrique ici : ce bouton n'occupe qu'un petit
## rectangle en bas a gauche de l'ecran (anchors BOTTOM_LEFT) - un enfant a lui ne pourrait jamais
## couvrir tout l'ecran (les ancres d'un enfant se calculent par rapport au rectangle du PARENT,
## pas du viewport).
##
## 2026-11-28 (limites par classe et par matiere, demande de Steve : "on affiche uniquement la
## classe et si on clique dessus une popup detaille les limitations et l'etat actuel des parties") :
## le badge n'est plus un simple bouton "X/Y" mais une petite rangee avec l'icone du controle
## parental et une etiquette par classe ayant une regle (couleur de la classe). Un clic sur une
## etiquette ouvre DailyLimitPopup sur CETTE classe. Masque si aucune classe n'a de regle.
class_name DailyLimitBadge
extends PanelContainer

const PARENTAL_ICON := preload("res://assets/classe2.0/icones/controle-parental.webp")

@export var popup_path: NodePath

## Fenetres du jeu dont la visibilite masque ce badge (voir commentaire de classe) - assignee
## depuis game_ui.tscn, jamais codee en dur ici (badge reutilisable, comme MenuToggleButton).
@export var hidden_when_visible_paths: Array[NodePath] = []

var _hidden_when_visible: Array[CanvasItem] = []
var _row: HBoxContainer
## Classes actuellement affichees en boutons (voir _refresh).
var _shown_grades: Array[GradeLevel.Grade] = []

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce badge est un enfant
	## direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	_row = HBoxContainer.new()
	_row.add_theme_constant_override("separation", 6)
	add_child(_row)
	SaveManager.account_logged_in.connect(func(_profile: Dictionary) -> void: _refresh())
	SaveManager.account_logged_out.connect(_refresh)
	SaveManager.parental_limits_changed.connect(_refresh)
	EventBus.pack_completed.connect(_on_pack_completed)
	for path in hidden_when_visible_paths:
		var panel := get_node_or_null(path) as CanvasItem
		if panel:
			_hidden_when_visible.append(panel)
			panel.visibility_changed.connect(_refresh)
	_refresh()

func _on_pack_completed(_subject: SubjectType.Subject, _rarity: CardRarity.Rarity, _correct_count: int, _total_count: int, _reward: int) -> void:
	_refresh()

func _any_other_window_visible() -> bool:
	for panel in _hidden_when_visible:
		if panel.visible:
			return true
	return false

func _limited_grades() -> Array[GradeLevel.Grade]:
	var result: Array[GradeLevel.Grade] = []
	for grade: GradeLevel.Grade in GradeLevel.Grade.values():
		if SaveManager.grade_has_parental_limit(grade):
			result.append(grade)
	return result

## Les boutons ne sont reconstruits QUE si la liste des classes limitees a change (correctif
## 2026-11-28) : _refresh est appelee a chaque changement de visibilite des fenetres surveillees,
## et une reconstruction entre l'appui et le relachement detruisait le bouton touche, d'ou "plus
## rien n'apparait en cliquant".
func _refresh() -> void:
	var grades := _limited_grades()
	visible = not grades.is_empty() and not _any_other_window_visible()
	if not visible or grades == _shown_grades:
		return
	_shown_grades = grades
	for child in _row.get_children():
		child.queue_free()
	var icon := TextureRect.new()
	icon.texture = PARENTAL_ICON
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.custom_minimum_size = Vector2(32, 32)
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_row.add_child(icon)
	for grade in grades:
		_row.add_child(_build_grade_button(grade))

## Etiquette d'une classe : meme pastille que dans la fenetre Controle parental (fond plein de la
## couleur de la classe, coins arrondis, forme aplatie - voir SectionParentalControl.
## _build_grade_header), mais cliquable (2026-11-28, retour de Steve). Le fond s'eclaircit au
## survol et s'assombrit a l'appui, pour garder un retour visuel de bouton.
func _build_grade_button(grade: GradeLevel.Grade) -> Control:
	var button := Button.new()
	button.text = GradeLevel.get_label(grade)
	button.focus_mode = Control.FOCUS_NONE
	## Reagit des l'appui (pas au relachement) : un toucher bref suffit, meme si l'ecran bouge.
	button.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
	button.theme_type_variation = &"TitleLabel"
	button.custom_minimum_size = Vector2(64, 0)
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	var color := GradeLevel.get_color(grade)
	button.add_theme_stylebox_override("normal", _pill_style(color))
	button.add_theme_stylebox_override("hover", _pill_style(color.lightened(0.15)))
	button.add_theme_stylebox_override("pressed", _pill_style(color.darkened(0.15)))
	button.add_theme_stylebox_override("hover_pressed", _pill_style(color.darkened(0.15)))
	for state in ["font_color", "font_hover_color", "font_pressed_color", "font_hover_pressed_color"]:
		button.add_theme_color_override(state, Color.WHITE)
	## Clic -> fenetre de detail de CETTE classe (ligne oubliee lors du passage au style pastille).
	button.pressed.connect(_on_grade_pressed.bind(grade))
	return button

func _pill_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(8)
	style.content_margin_left = 12
	style.content_margin_right = 12
	style.content_margin_top = 0
	style.content_margin_bottom = 0
	return style

func _on_grade_pressed(grade: GradeLevel.Grade) -> void:
	var popup := get_node_or_null(popup_path)
	if popup and popup.has_method("open"):
		popup.open(grade)
