## Twin 2D de interactable_component.gd (voir ce fichier pour le detail des signaux) : meme
## logique exacte, seul le type de noeud physique change (Area2D au lieu de Area3D) suite au
## passage du jeu en 2D plateformer vue de cote. A placer comme noeud Area2D (avec une
## CollisionShape2D enfant) sur la scene qui l'utilise.
class_name InteractableComponent2D
extends Area2D

## Emis quand le joueur entre dans la zone : l'UI peut afficher le reticule/bouton d'interaction
## (voir InteractPrompt).
signal focused
signal unfocused
## Emis quand le joueur declenche reellement l'interaction (touche interact).
signal interacted(who: Node)

## Libelle court affiche dans le bouton du reticule central quand cet interactable est en portee
## (voir InteractPrompt.show_for) - un mot ou un titre court ("Boutique", "Maître du CP"...).
@export var prompt_text: String = "Interagir"

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		focused.emit()
		EventBus.interactable_focused.emit(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		unfocused.emit()
		EventBus.interactable_unfocused.emit(self)

## Appele par le composant d'interaction du joueur quand la touche est pressee.
func trigger_interact(who: Node) -> void:
	interacted.emit(who)
