## Composant reutilisable : rend n'importe quelle scene "interactive" (PNJ, coffre, boutique...).
## A placer comme noeud Area3D (avec une CollisionShape3D enfant) sur la scene qui l'utilise.
class_name InteractableComponent
extends Area3D

## Emis quand le joueur entre dans la zone : l'UI peut afficher "Appuyer sur E".
signal focused
signal unfocused
## Emis quand le joueur declenche reellement l'interaction (touche interact).
signal interacted(who: Node)

@export var prompt_text: String = "Appuyer sur E"

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		focused.emit()
		EventBus.interactable_focused.emit(self)

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		unfocused.emit()
		EventBus.interactable_unfocused.emit(self)

## Appele par le composant d'interaction du joueur quand la touche est pressee.
func trigger_interact(who: Node) -> void:
	interacted.emit(who)
