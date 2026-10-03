## Fenetre "Cours" (2026-09-29, demande Steve) : sommaire des fiches de cours, ouvert par l'icone
## "Cours" en haut de la colonne de droite (BackpackMenu). Meme emplacement et meme chrome que les
## autres fenetres de cette colonne (CardAlbum, SuccessPanel, ShopPanel) ; icone de titre clonee
## du bouton de la colonne (title_icon_source_path), comme elles.
##
## Trois niveaux :
## 1. une rangee de pastilles de classe (CP -> CM2, aux couleurs de GradeLevel.get_color) ;
## 2. les matieres de la classe choisie, presentees comme dans la fenetre de choix des PNJ
##    (SubjectSelectPanel : carte coloree SubjectType.get_color + bouton SubjectButton). Une
##    matiere n'est active que si elle a au moins une fiche publiee ;
## 3. les notions de la matiere (ContentLibrary.get_notions) : un bouton par notion, actif s'il
##    existe une fiche, qui ouvre alors la fiche (FichePanel, place par-dessus ce sommaire au meme
##    endroit ; sa croix ramene ici).
class_name CoursPanel
extends Control

const Subject = SubjectType.Subject
const Grade = GradeLevel.Grade

const _FRAME_THICKNESS := 4.0
const _FRAME_CORNER_RADIUS := 16
const _DISABLED_ALPHA := 0.4
## Nombre de notions au-dela duquel la liste passe de 2 a 3 colonnes (5 lignes de 2 au plus).
const _MAX_NOTIONS_2_COLONNES := 10

## Bouton de la colonne a cloner pour l'icone de titre - assigne dans game_ui.tscn.
@export var title_icon_source_path: NodePath

@onready var title_icon: TextureRect = $Panel/TitleRow/TitleIcon
@onready var grade_row: HBoxContainer = %GradeRow
@onready var subjects_view: CenterContainer = %SubjectsView
@onready var subject_grid: GridContainer = %SubjectGrid
@onready var notions_view: VBoxContainer = %NotionsView
@onready var back_button: Button = %BackButton
@onready var subject_label: Label = %SubjectLabel
@onready var notion_grid: GridContainer = %NotionGrid
@onready var fiche_panel: FichePanel = %FichePanel

var _grade: Grade = Grade.CP
var _subject: Subject = Subject.MATH
var _showing_notions := false
var _grade_group := ButtonGroup.new()

func _ready() -> void:
	## Meme raison que les autres fenetres : le CanvasLayer "UI" coupe la propagation du Theme.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	var icon_source := get_node_or_null(title_icon_source_path) as Button
	if icon_source:
		title_icon.texture = icon_source.icon
	back_button.pressed.connect(_show_subjects)
	ContentLibrary.content_updated.connect(func() -> void:
		if visible:
			_refresh())
	_build_grade_row()

func open() -> void:
	fiche_panel.hide()
	_showing_notions = false
	show()
	_refresh()

func close() -> void:
	fiche_panel.hide()
	hide()

func _refresh() -> void:
	if _showing_notions:
		_show_notions(_subject)
	else:
		_show_subjects()

# ---------------------------------------------------------------- classes

func _build_grade_row() -> void:
	for grade: Grade in Grade.values():
		var button := Button.new()
		button.text = GradeLevel.get_label(grade)
		button.toggle_mode = true
		button.button_group = _grade_group
		button.button_pressed = grade == _grade
		button.custom_minimum_size = Vector2(76, 38)
		button.focus_mode = Control.FOCUS_NONE
		var color := GradeLevel.get_color(grade)
		button.add_theme_stylebox_override("normal", _pill(Color.WHITE, color))
		button.add_theme_stylebox_override("hover", _pill(color.lerp(Color.WHITE, 0.7), color))
		button.add_theme_stylebox_override("pressed", _pill(color, color.darkened(0.25)))
		button.add_theme_stylebox_override("hover_pressed", _pill(color, color.darkened(0.25)))
		button.add_theme_color_override("font_color", color.darkened(0.4))
		button.add_theme_color_override("font_hover_color", color.darkened(0.4))
		button.add_theme_color_override("font_pressed_color", Color.WHITE)
		button.add_theme_color_override("font_hover_pressed_color", Color.WHITE)
		button.pressed.connect(_on_grade_pressed.bind(grade))
		grade_row.add_child(button)

func _pill(bg: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(3)
	style.set_corner_radius_all(19)
	style.content_margin_left = 12
	style.content_margin_right = 12
	return style

func _on_grade_pressed(grade: Grade) -> void:
	_grade = grade
	_show_subjects()

# ---------------------------------------------------------------- matieres

func _show_subjects() -> void:
	_showing_notions = false
	notions_view.hide()
	subjects_view.show()
	for child in subject_grid.get_children():
		child.queue_free()
	var subjects := ContentLibrary.get_available_subjects(_grade)
	# Pas de fiches pour la Lecture (2026-10-01, choix de Steve) : les questions portent sur un
	# texte precis, rien a revoir dans une fiche -> matiere masquee du livre de cours.
	subjects.erase(Subject.READING)
	subject_grid.columns = 2 if subjects.size() >= 5 else 1
	for subject: Subject in subjects:
		var has_fiche := not ContentLibrary.get_fiches(_grade, subject).is_empty()
		var frame := _colored_frame(SubjectType.get_color(subject), SubjectType.get_label(subject), Vector2(220, 44))
		var button := frame.get_child(0) as Button
		button.disabled = not has_fiche
		if has_fiche:
			button.pressed.connect(_show_notions.bind(subject))
		else:
			frame.modulate.a = _DISABLED_ALPHA
			button.tooltip_text = "Fiches bientôt disponibles"
		subject_grid.add_child(frame)

## Carte coloree + bouton, meme rendu que SubjectSelectPanel._build_subject_frame.
func _colored_frame(color: Color, text: String, min_size: Vector2) -> PanelContainer:
	var frame := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(_FRAME_CORNER_RADIUS)
	style.set_content_margin_all(_FRAME_THICKNESS)
	frame.add_theme_stylebox_override("panel", style)
	var button := Button.new()
	button.theme_type_variation = &"SubjectButton"
	button.text = text
	button.custom_minimum_size = min_size
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	frame.add_child(button)
	return frame

# ---------------------------------------------------------------- notions

func _show_notions(subject: Subject) -> void:
	_subject = subject
	_showing_notions = true
	subjects_view.hide()
	notions_view.show()
	subject_label.text = "%s - %s" % [SubjectType.get_label(subject), GradeLevel.get_label(_grade)]
	subject_label.add_theme_color_override("font_color", SubjectType.get_color(subject).darkened(0.3))
	for child in notion_grid.get_children():
		child.queue_free()
	var fiches_by_notion: Dictionary = {}
	for fiche: Dictionary in ContentLibrary.get_fiches(_grade, subject):
		fiches_by_notion[str(fiche.get("notion", ""))] = fiche
	var notions := ContentLibrary.get_notions(_grade, subject)
	# Au-dela de 10 notions (5 lignes), 3 colonnes plus etroites (2026-10-03, demande Steve) :
	# en 2 colonnes, la 6e ligne sortait du cadre des qu'un libelle passait sur 2 lignes (CM2).
	notion_grid.columns = 3 if notions.size() > _MAX_NOTIONS_2_COLONNES else 2
	var width := 300.0 if notion_grid.columns == 3 else 360.0
	for notion: Dictionary in notions:
		var code := str(notion.get("code", ""))
		var frame := _colored_frame(SubjectType.get_color(subject), str(notion.get("libelle", code)), Vector2(width, 40))
		var button := frame.get_child(0) as Button
		if fiches_by_notion.has(code):
			button.pressed.connect(_open_fiche.bind(fiches_by_notion[code]))
		else:
			button.disabled = true
			frame.modulate.a = _DISABLED_ALPHA
			button.tooltip_text = "Fiche bientôt disponible"
		notion_grid.add_child(frame)

func _open_fiche(fiche: Dictionary) -> void:
	fiche_panel.open_fiche(_grade, fiche)
