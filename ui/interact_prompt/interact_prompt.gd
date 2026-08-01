## Petit prompt "Appuyer sur E" reutilisable, pilote par InteractorComponent.gd du joueur.
class_name InteractPrompt
extends Control

@onready var label: Label = $Label

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	visible = false

func show_for(interactable: InteractableComponent) -> void:
	if interactable == null:
		visible = false
		return
	label.text = interactable.prompt_text
	visible = true
