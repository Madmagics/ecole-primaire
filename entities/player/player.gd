## Racine du joueur : assemble les composants (mouvement, interaction) par composition.
## Ce script reste volontairement court ; toute la logique vit dans les composants enfants.
class_name Player
extends CharacterBody3D

@onready var movement: MovementComponent = $MovementComponent
@onready var interactor: InteractorComponent = $InteractorComponent

func _ready() -> void:
	add_to_group("player")
	movement.body = self
