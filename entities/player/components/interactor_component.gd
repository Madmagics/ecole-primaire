## Composant qui memorise l'InteractableComponent le plus recent en portee et gere la touche
## d'interaction. Ecoute EventBus plutot que de referencer les objets interactifs directement.
## Necessite l'action d'input "interact" (Input Map, touche E par defaut).
## Type Node (pas InteractableComponent) sur le signal/la variable ci-dessous : depuis le passage
## du jeu en 2D, ce composant recoit indifferemment un InteractableComponent (3D, historique) ou
## un InteractableComponent2D (voir entities/interactable/interactable_component_2d.gd) - les deux
## exposent la meme API (trigger_interact, prompt_text) mais n'ont pas de classe de base commune
## utile a part Node.
class_name InteractorComponent
extends Node

signal interactable_changed(interactable: Node)

var _current: Node

func _ready() -> void:
	EventBus.interactable_focused.connect(_on_focused)
	EventBus.interactable_unfocused.connect(_on_unfocused)

func _unhandled_input(event: InputEvent) -> void:
	if _current and not PlayerInputLock.is_locked() and event.is_action_pressed("interact"):
		_current.trigger_interact(get_parent())

func _on_focused(interactable: Node) -> void:
	_current = interactable
	interactable_changed.emit(_current)

func _on_unfocused(interactable: Node) -> void:
	if _current == interactable:
		_current = null
		interactable_changed.emit(null)
