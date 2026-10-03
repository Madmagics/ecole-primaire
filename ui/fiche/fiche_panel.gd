## Fenetre d'une fiche de cours (2026-09-29) : pages fixes, jamais de defilement, navigation
## precedent/suivant comme le livre des cartes (CardAlbum). Meme chrome que les autres fenetres
## (Panel du Theme : fond creme, bordure, coins arrondis, TitleLabel + HSeparator), plus une
## pastille de la classe a gauche du titre.
##
## Une fiche = un Dictionary venu du paquet de contenu (voir ContentLibrary.get_fiches) :
## {"id", "notion", "titre", "contenu"}. Le contenu est decoupe en pages sur la balise [page] ;
## chaque page est construite par FichePage.build(). Si une page est trop haute pour la zone
## disponible, elle est reduite a l'echelle (_fit_page) plutot que de deborder : la fiche doit
## rester lisible sans jamais defiler.
##
## La fenetre occupe toute la place de son noeud racine : c'est le parent qui la positionne
## (CoursPanel : meme emplacement que la fenetre Cours, a cote de la colonne de droite ;
## tools/fiche_test/ : presque plein ecran). Croix de fermeture en haut a droite de CHAQUE fiche
## (demande Steve 2026-09-29) : cache la fiche et emet [signal closed].
##
## Fond "papier" fixe (creme + bordure brune), independant du theme d'interface choisi : le texte
## et les dessins des fiches sont en encre foncee, ils doivent rester lisibles meme avec le theme
## sombre.
class_name FichePanel
extends Control

## Emis quand le joueur ferme la fiche avec la croix.
signal closed

const PAPER := Color(1, 0.941176, 0.839216)
const PAPER_BORDER := Color(0.478431, 0.290196, 0.168627)

const PAGE_TAG := "[page]"

@onready var badge: PanelContainer = %ClassBadge
@onready var badge_label: Label = %ClassBadgeLabel
@onready var title_label: Label = %TitleLabel
@onready var page_area: Control = %PageArea
@onready var prev_button: Button = %PrevButton
@onready var next_button: Button = %NextButton
@onready var page_dots: Control = %PageDots
@onready var close_button: Button = %CloseButton
@onready var panel: Panel = $Panel

var _pages: PackedStringArray = []
var _index := 0
var _classe_color := Color("42A5F5")
var _bold_font: FontVariation
var _current_page: Control

func _ready() -> void:
	_bold_font = FontVariation.new()
	_bold_font.base_font = get_theme_default_font()
	_bold_font.variation_embolden = 0.7
	var paper := StyleBoxFlat.new()
	paper.bg_color = PAPER
	paper.border_color = PAPER_BORDER
	paper.set_border_width_all(4)
	paper.set_corner_radius_all(20)
	panel.add_theme_stylebox_override("panel", paper)
	title_label.add_theme_color_override("font_color", PAPER_BORDER)
	close_button.pressed.connect(close)
	prev_button.pressed.connect(func() -> void: _show_page(_index - 1))
	next_button.pressed.connect(func() -> void: _show_page(_index + 1))
	page_dots.draw.connect(_draw_dots)
	page_area.resized.connect(func() -> void:
		if _current_page != null:
			_fit_page(_current_page))

func open_fiche(grade: GradeLevel.Grade, fiche: Dictionary) -> void:
	_classe_color = GradeLevel.get_color(grade)
	badge_label.text = GradeLevel.get_label(grade)
	var style := StyleBoxFlat.new()
	style.bg_color = _classe_color
	style.set_corner_radius_all(10)
	style.content_margin_left = 12
	style.content_margin_right = 12
	badge.add_theme_stylebox_override("panel", style)
	title_label.text = str(fiche.get("titre", ""))
	_pages = PackedStringArray()
	for page: String in str(fiche.get("contenu", "")).split(PAGE_TAG):
		if page.strip_edges() != "":
			_pages.append(page)
	visible = true
	_show_page(0)

func close() -> void:
	if not visible:
		return
	hide()
	closed.emit()

func _show_page(index: int) -> void:
	if _pages.is_empty():
		return
	_index = clampi(index, 0, _pages.size() - 1)
	if _current_page != null:
		_current_page.queue_free()
	_current_page = FichePage.build(_pages[_index], _classe_color, _bold_font)
	_current_page.modulate.a = 0.0
	page_area.add_child(_current_page)
	prev_button.disabled = _index == 0
	next_button.disabled = _index == _pages.size() - 1
	prev_button.modulate.a = 0.25 if prev_button.disabled else 1.0
	next_button.modulate.a = 0.25 if next_button.disabled else 1.0
	page_dots.queue_redraw()
	_fit_page(_current_page)

## Donne a la page toute la largeur de la zone, attend que les RichTextLabel aient calcule leur
## hauteur, puis reduit l'echelle si la page depasse en hauteur. La page reste invisible pendant
## ce calcul (modulate.a = 0) pour ne jamais montrer un premier affichage qui deborde.
func _fit_page(page: Control) -> void:
	page.scale = Vector2.ONE
	page.position = Vector2.ZERO
	page.size = Vector2(page_area.size.x, 0)
	await get_tree().process_frame
	await get_tree().process_frame
	if not is_instance_valid(page) or page != _current_page:
		return
	var needed := page.get_combined_minimum_size().y
	var available := page_area.size.y
	var s := 1.0
	if needed > available and needed > 0.0:
		s = available / needed
	page.scale = Vector2(s, s)
	page.size = Vector2(page_area.size.x / s, needed)
	# Page plus courte que la zone : on la centre verticalement
	page.position = Vector2(0, maxf(0.0, (available - needed * s) / 2.0))
	page.modulate.a = 1.0

func _draw_dots() -> void:
	var count := _pages.size()
	if count <= 1:
		return
	# CE2 (jaune, couleur trop claire) : point actif orange et autres points beige, sinon
	# invisibles sur le papier creme (2026-10-01). Les autres classes gardent leur couleur.
	var active_color := _classe_color
	var other_color := _classe_color.lerp(Color.WHITE, 0.6)
	if FichePage.is_light(_classe_color):
		active_color = FichePage.UNITES.darkened(0.15)
		other_color = PAPER_BORDER.lerp(PAPER, 0.6)
	var spacing := 22.0
	var start := (page_dots.size.x - (count - 1) * spacing) / 2.0
	for i: int in count:
		var center := Vector2(start + i * spacing, page_dots.size.y / 2.0)
		if i == _index:
			page_dots.draw_circle(center, 7.0, active_color)
		else:
			page_dots.draw_circle(center, 5.0, other_color)
