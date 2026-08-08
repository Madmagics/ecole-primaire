## Petit menu affiche a l'interaction avec un PNJ (le "maitre/maitresse" d'une classe fixe,
## voir QuestionGiverComponent) : le joueur choisit la matiere avec laquelle il veut travailler,
## parmi celles reellement disponibles pour cette classe (transmises par le signal, pas une
## liste figee ici - une nouvelle matiere apparait automatiquement des qu'un PNJ en propose une).
## Partage par tous les PNJ, meme principe de "source" que QuestionPanel pour savoir a qui
## repondre. Remplace l'ancien GradeSelectPanel (classe/matiere ont echange leurs roles, voir
## MATIERES_CANDIDATES.md).
class_name SubjectSelectPanel
extends Control

## Emis quand le joueur a choisi une matiere.
signal subject_selected(source: Node, subject: SubjectType.Subject)

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
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	## Fige le joueur (deplacement + interaction) tant que ce menu est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
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

func _on_subject_pressed(subject: SubjectType.Subject) -> void:
	var source := _source
	_source = null
	hide()
	subject_selected.emit(source, subject)

func _on_close_pressed() -> void:
	_close()

## Node (pas InteractableComponent) : recoit indifferemment un interactable 3D ou 2D depuis le
## passage du jeu en 2D (voir InteractorComponent.gd).
func _on_interactable_unfocused(interactable: Node) -> void:
	if _source == null or interactable == null:
		return
	if _source.get_parent() == interactable.get_parent():
		_close()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_close()
		get_viewport().set_input_as_handled()

func _close() -> void:
	_source = null
	hide()
