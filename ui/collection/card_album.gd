## Livre de collection en plein ecran. Une page = 1 ligne de 5 cartes = une seule categorie
## (chat, chien...) : depuis le passage rarete->classe (2026-07-26), une categorie a toujours
## exactement 5 variantes (une par classe CP-CM2), donc une page = une categorie complete, sans
## exception a gerer. Autant de pages que necessaire (= nombre d'especes), navigables via
## Precedent/Suivant. Scanne data/card/resources/ au demarrage (voir CsvResourceImporter/
## import_cards.gd) : aucune liste a maintenir a la main.
## S'ouvre/se ferme avec la touche "open_album" (voir Input Map), la croix, ou Echap.
##
## 2026-07-26 : passage de 2 lignes/10 cartes a 1 ligne/5 cartes par page (refonte demandee par
## Steve), ce qui libere de la place verticale -> les cartes sont passees a l'echelle x1.5 en
## meme temps (voir CARD_SIZE dans CardSlot). Voir card_album.tscn pour les dimensions du
## ScrollContainer, a ajuster ensemble si la taille de carte change encore.
##
## 2026-07-26 (suite) : fond "parchemin" ajoute (voir AtlasBackground) derriere tout le Panel,
## titre souligne (TitleUnderline) au lieu d'un encadre, et categorie de la page affichee sous
## le titre (CategoryLabel, rempli ici dans _refresh()). Le double lisere du parchemin est tres
## pres du bord du Panel : la grille de cartes et la barre de navigation ont ete reculees en
## consequence (voir offsets dans card_album.tscn) pour ne jamais le chevaucher.
##
## 2026-07-26 (suite) : la carte de gauche touchait le lisere interieur sur certaines resolutions.
## Cause : un ScrollContainer redimensionne son enfant unique au plein format des qu'il a le flag
## EXPAND, mais sans le centrer - le GridContainer s'etalait donc depuis le bord gauche exact du
## ScrollContainer. Fix : GridContainer deplace dans un CenterContainer (Panel/ScrollContainer/
## CenterContainer/GridContainer), qui le laisse a sa taille naturelle et le centre - la marge
## devient donc symetrique des deux cotes. h_separation reduit de 16 a 8 en complement, pour
## degager encore plus de marge de part et d'autre de la rangee.
##
## 2026-07-26 (suite) : page 1 vide au tout premier affichage (les cartes n'apparaissaient
## qu'apres avoir tourne une page). Cause : card_album.tscn etait le seul panneau de l'UI a ne
## PAS avoir "visible = false" sur son noeud racine (contrairement a SubjectSelectPanel,
## ShopPanel, etc.) - il demarrait donc affiche par defaut, avant tout appel a open(), qui est
## le seul endroit qui declenchait _refresh() (donc le seul qui peuplait la grille). Fix : ajout
## de "visible = false" sur le noeud racine dans card_album.tscn (aligne sur les autres panneaux)
## + appel de _refresh() ici en plus de _load_pages(), par securite si jamais le livre redevient
## visible par un autre chemin que open().
class_name CardAlbum
extends Control

const CardSlotScene := preload("res://ui/collection/card_slot.tscn")
const CARDS_DIR := "res://data/card/resources"

const CARDS_PER_ROW := 5
const ROWS_PER_PAGE := 1
const CARDS_PER_PAGE := CARDS_PER_ROW * ROWS_PER_PAGE # 5

@onready var grid: GridContainer = $Panel/ScrollContainer/CenterContainer/GridContainer
@onready var atlas_background: AtlasBackground = $Panel/AtlasBackground
@onready var title_underline: TitleUnderline = $Panel/TitleBlock/TitleUnderline
@onready var category_label: Label = $Panel/TitleBlock/CategoryLabel
@onready var page_label: Label = $Panel/PageLabel
@onready var prev_button: Button = $Panel/PrevButton
@onready var next_button: Button = $Panel/NextButton
@onready var close_button: Button = $Panel/CloseButton

## Une page = un Array[CardResource] de 25 cartes maximum, toutes de la meme categorie.
var _pages: Array = []
var _page_index: int = 0

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_apply_theme_colors(theme)
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void:
		theme = new_theme
		_apply_theme_colors(new_theme)
	)
	_load_pages()
	_refresh()
	CardCollection.card_added.connect(_on_card_added)
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	close_button.pressed.connect(close)
	visibility_changed.connect(_on_visibility_changed)

## Assortit le fond parchemin (AtlasBackground), le soulignement du titre (TitleUnderline) et
## la couleur de CategoryLabel a la palette du theme d'interface actif : le "papier" reprend le
## bg_color du Panel/styles/panel du theme, l'"encre" son border_color, et l'accent de la
## categorie le bg_color du Button/styles/normal (voir game_theme/theme_bonbon/theme_sombre/
## theme_tropical .tres). Ainsi les 4 themes gardent un atlas coherent avec le reste de l'UI au
## lieu d'un parchemin toujours beige. Appele au demarrage et a chaque changement de theme.
func _apply_theme_colors(active_theme: Theme) -> void:
	var panel_style := active_theme.get_stylebox(&"panel", &"Panel") as StyleBoxFlat
	var accent_style := active_theme.get_stylebox(&"normal", &"Button") as StyleBoxFlat
	if panel_style == null or accent_style == null:
		return
	atlas_background.set_palette(panel_style.bg_color, panel_style.border_color)
	title_underline.set_ink_color(panel_style.border_color)
	category_label.add_theme_color_override("font_color", accent_style.bg_color)

## Fleches gauche/droite = page precedente/suivante quand le livre est ouvert. En _input() (et
## non _unhandled_input()) pour intercepter la touche AVANT que la navigation de focus des
## Controls (PrevButton/NextButton/CloseButton) ne la consomme pour deplacer le focus au lieu de
## tourner la page.
func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_left"):
		_on_prev_pressed()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_right"):
		_on_next_pressed()
		get_viewport().set_input_as_handled()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_album"):
		if visible:
			close()
		else:
			open()
		get_viewport().set_input_as_handled()
	elif visible and event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()

func open() -> void:
	_page_index = 0
	show()
	_refresh()

func close() -> void:
	hide()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

func _load_pages() -> void:
	var all_cards: Array[CardResource] = []
	for file_name in DirAccess.get_files_at(CARDS_DIR):
		if not file_name.ends_with(".tres"):
			continue
		var card := load("%s/%s" % [CARDS_DIR, file_name]) as CardResource
		if card:
			all_cards.append(card)
	## Tri numerique sur l'id (les id sont des chaines : un tri texte mettrait "10" avant "2").
	all_cards.sort_custom(func(a: CardResource, b: CardResource) -> bool:
		return int(String(a.id)) < int(String(b.id))
	)

	## Regroupe par categorie, dans l'ordre de premiere apparition (donc l'ordre des id).
	var by_category: Dictionary = {} # StringName categorie -> Array[CardResource]
	for card in all_cards:
		if not by_category.has(card.category):
			by_category[card.category] = []
		by_category[card.category].append(card)

	_pages.clear()
	for category in by_category.keys():
		var cards_in_category: Array = by_category[category]
		var i := 0
		while i < cards_in_category.size():
			_pages.append(cards_in_category.slice(i, mini(i + CARDS_PER_PAGE, cards_in_category.size())))
			i += CARDS_PER_PAGE
	if _pages.is_empty():
		_pages.append([])

func _on_card_added(_card: CardResource, _is_new: bool) -> void:
	if visible:
		_refresh()

func _on_prev_pressed() -> void:
	_page_index = maxi(0, _page_index - 1)
	_refresh()

func _on_next_pressed() -> void:
	_page_index = mini(_pages.size() - 1, _page_index + 1)
	_refresh()

func _refresh() -> void:
	for child in grid.get_children():
		child.queue_free()
	var page: Array = _pages[_page_index]
	for card in page:
		var slot := CardSlotScene.instantiate() as CardSlot
		grid.add_child(slot)
		slot.display(card, CardCollection.get_quantity(card.id))

	category_label.text = String((page[0] as CardResource).category).capitalize() if not page.is_empty() else ""
	page_label.text = "Page %d / %d" % [_page_index + 1, _pages.size()]
	prev_button.disabled = _page_index <= 0
	next_button.disabled = _page_index >= _pages.size() - 1
