## Petit prompt "Appuyer sur E" reutilisable, pilote par InteractorComponent.gd du joueur.
class_name InteractPrompt
extends Control

@onready var label: Label = $Label

func _ready() -> void:
	visible = false

func show_for(interactable: InteractableComponent) -> void:
	if interactable == null:
		visible = false
		return
	label.text = interactable.prompt_text
	visible = true
