## Fenetre generique pour le guide/tuto (voir entities/guide_2d) : affiche un titre + un texte
## d'aide fixe, sans mecanique de jeu derriere (contrairement a QuestionPanel/ShopPanel). Meme
## structure et conventions que ReadingIntroPanel (theme, fermeture sur eloignement du PNJ/Echap,
## PlayerInputLock pendant l'affichage) mais avec un simple bouton "Fermer" au lieu d'un
## "Commencer" qui enchainerait sur autre chose.
class_name HelpPanel
extends Control

@onready var panel: PanelContainer = $Panel
@onready var title_label: Label = $Panel/Margin/Content/TitleLabel
@onready var text_label: Label = $Panel/Margin/Content/TextScroll/TextContent/TextLabel
@onready var close_button: Button = $Panel/Margin/Content/TextScroll/TextContent/CloseButton

var _source: Node

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	close_button.pressed.connect(_abort)
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	## Fige le joueur (deplacement + interaction) tant que ce panneau est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Appele par le guide (GuideComponent.help_requested) a l'interaction.
func open_for(source: Node, title: String, message: String) -> void:
	_source = source
	title_label.text = title
	text_label.text = message
	show()

## Node (pas InteractableComponent) : recoit indifferemment un interactable 3D ou 2D depuis le
## passage du jeu en 2D (voir InteractorComponent.gd), meme note que ReadingIntroPanel.
func _on_interactable_unfocused(interactable: Node) -> void:
	if _source == null or interactable == null:
		return
	if _source.get_parent() == interactable.get_parent():
		_abort()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_abort()
		get_viewport().set_input_as_handled()

func _abort() -> void:
	_source = null
	hide()
