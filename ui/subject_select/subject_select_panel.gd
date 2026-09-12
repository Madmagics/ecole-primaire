## Petit menu affiche a l'interaction avec un PNJ (le "maitre/maitresse" d'une classe fixe,
## voir QuestionGiverComponent) : le joueur choisit la matiere avec laquelle il veut travailler,
## parmi celles reellement disponibles pour cette classe (transmises par le signal, pas une
## liste figee ici - une nouvelle matiere apparait automatiquement des qu'un PNJ en propose une).
## Partage par tous les PNJ, meme principe de "source" que QuestionPanel pour savoir a qui
## repondre. Remplace l'ancien GradeSelectPanel (classe/matiere ont echange leurs roles, voir
## MATIERES_CANDIDATES.md).
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## (Echap pour fermer) est retire - close_button fait deja ca a la souris/au tactile.
##
## Floutage d'arriere-plan (2026-09-04, retour utilisateur : "on va uniformiser le floutage arriere
## pour toutes les fenetres quand celles ci sont actives... je veux appliquer la meme chose aux
## questions et menus proposes par les npc") : meme mecanisme que BackpackMenu.blur_bg_path (voir
## ui/hud/backpack_menu.gd) - blur_bg_path pointe vers NpcBlurBG (ColorRect partage avec QuestionPanel
## et ReadingIntroPanel dans game_ui.tscn), bascule dans _on_visibility_changed().
##
## Menus masques (2026-09-04, 2e passe, retour utilisateur : "les icones de menu droit et gauche
## sont touours la quand jouvre un menu npc") : le premier passage n'avait masque les 2 boutons de
## menu que depuis QuestionPanel - manquant ici, ce panneau (premiere fenetre du flux PNJ, avant
## QuestionPanel) laissait les 2 icones cliquables. Meme mecanisme (open_menu_button_path/
## backpack_button_path, voir QuestionPanel) applique ici aussi.
class_name SubjectSelectPanel
extends Control

## Flou plein ecran derriere ce panneau (voir commentaire de classe, 2026-09-04) : NodePath vers
## NpcBlurBG, ColorRect EXTERNE partage avec QuestionPanel/ReadingIntroPanel dans game_ui.tscn.
@export var blur_bg_path: NodePath
## Boutons d'ouverture des 2 menus (game_ui.tscn), masques tant que ce panneau est visible (voir
## commentaire de classe, 2026-09-04) - assignes dans game_ui.tscn.
@export var open_menu_button_path: NodePath
@export var backpack_button_path: NodePath

@onready var title_label: Label = $Panel/Margin/Content/HeaderRow/TitleLabel
@onready var buttons_container: GridContainer = $Panel/Margin/Content/Center/ButtonsContainer
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton

## A partir de ce nombre de matieres proposees, la liste bascule sur 2 colonnes (voir
## _rebuild_buttons) plutot que de continuer a s'empiler verticalement - evite un panneau trop
## haut qui deborderait de l'ecran avec beaucoup de matieres (voir retour utilisateur 2026-07-28).
const TWO_COLUMNS_THRESHOLD := 5

## Chaque bouton de matiere est encadre d'une carte pleine de la couleur de la matiere (voir
## _build_subject_frame) : le bouton lui-meme garde le style natif du theme (fond/bordure), seul
## un anneau visible autour (via content_margin) porte la couleur - ca evite de recolorer la
## bordure du bouton directement, ce qui se confondait avec son propre fond selon le theme (voir
## retour utilisateur 2026-07-28). L'anneau touche le fond du PANNEAU (toujours peu sature dans
## les 4 themes), pas le fond du bouton (tres sature) - contraste beaucoup plus fiable.
## Epaisseur alignee sur border_width_* de StyleBoxFlat_panel (4px, voir *.tres) - meme epaisseur
## que le cadre du panneau principal et les autres cadres du menu (retour utilisateur 2026-07-28,
## l'anneau a 7px faisait plus epais que les autres cadres).
const _FRAME_THICKNESS := 4.0
const _FRAME_CORNER_RADIUS := 16

var _source: Node

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(_on_close_pressed)
	## Fige le joueur (deplacement + interaction) tant que ce menu est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	var blur_bg := get_node_or_null(blur_bg_path) as CanvasItem
	if blur_bg:
		blur_bg.visible = visible
	var open_menu_button := get_node_or_null(open_menu_button_path) as CanvasItem
	if open_menu_button:
		open_menu_button.visible = not visible
	var backpack_button := get_node_or_null(backpack_button_path) as CanvasItem
	if backpack_button:
		backpack_button.visible = not visible
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Appele par le PNJ (QuestionGiverComponent) a l'interaction, avant de lancer un pack.
func open_for(source: Node, grade: GradeLevel.Grade, available_subjects: Array[SubjectType.Subject]) -> void:
	_source = source
	title_label.text = "Choisis ta matière (%s)" % GradeLevel.get_label(grade)
	_rebuild_buttons(available_subjects)
	show()

func _rebuild_buttons(available_subjects: Array[SubjectType.Subject]) -> void:
	for child in buttons_container.get_children():
		child.queue_free()
	buttons_container.columns = 2 if available_subjects.size() >= TWO_COLUMNS_THRESHOLD else 1
	for subject in available_subjects:
		buttons_container.add_child(_build_subject_frame(subject))

## Une "case" = carte coloree (couleur de la matiere) contenant le bouton natif du theme, legerement
## inset (voir _FRAME_THICKNESS) pour laisser apparaitre un anneau colore tout autour - une seule
## cellule pour le GridContainer parent. Taille naturelle (pas d'expand) : avec une seule colonne,
## le CenterContainer parent (voir .tscn) centre le bloc au lieu de l'etirer sur toute la largeur.
func _build_subject_frame(subject: SubjectType.Subject) -> PanelContainer:
	var frame := PanelContainer.new()
	var frame_style := StyleBoxFlat.new()
	frame_style.bg_color = SubjectType.get_color(subject)
	frame_style.set_corner_radius_all(_FRAME_CORNER_RADIUS)
	frame_style.set_content_margin_all(_FRAME_THICKNESS)
	frame.add_theme_stylebox_override("panel", frame_style)

	var button := Button.new()
	## Variante de theme dediee (voir *.tres, section SubjectButton) : meme fond que le Button
	## global du theme mais SANS bordure - la carte coloree autour (fond de "frame" ci-dessus)
	## joue deja ce role, une double bordure (bouton + carte) faisait surcharge visuellement (voir
	## retour utilisateur 2026-07-28). Au survol, le bouton passe juste a la teinte "douce" deja
	## utilisee comme couleur de survol dans chaque theme (pas de reduction de bordure a gerer
	## puisqu'il n'y en a plus).
	button.theme_type_variation = &"SubjectButton"
	button.text = SubjectType.get_label(subject)
	button.custom_minimum_size = Vector2(200, 44)
	button.pressed.connect(_on_subject_pressed.bind(subject))
	frame.add_child(button)

	return frame

## Diffuse via EventBus (pas un signal local) : QuestionGiverComponent.start_pack_for_subject
## s'auto-connecte a EventBus.subject_selected dans son _ready() (voir event_bus.gd pour le
## pourquoi - une connexion posee dans le .tscn s'est perdue plusieurs fois).
func _on_subject_pressed(subject: SubjectType.Subject) -> void:
	var source := _source
	_source = null
	hide()
	EventBus.subject_selected.emit(source, subject)

func _on_close_pressed() -> void:
	_close()

func _close() -> void:
	_source = null
	hide()
