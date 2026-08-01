## Racine du joueur : assemble les composants (mouvement, interaction) par composition.
## Ce script reste volontairement court ; toute la logique vit dans les composants enfants.
class_name Player
extends CharacterBody3D

@onready var movement: MovementComponent = $MovementComponent
@onready var interactor: InteractorComponent = $InteractorComponent
@onready var camera_rig: CameraRig = $CameraRig
@onready var interaction_facing: InteractionFacing = $InteractionFacing

func _ready() -> void:
	add_to_group("player")
	movement.body = self
	camera_rig.target = self
	camera_rig.snap_to_target()
	interaction_facing.target = self
