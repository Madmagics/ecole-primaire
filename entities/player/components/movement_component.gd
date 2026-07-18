## Composant de deplacement 3e personne. Independant : ne connait que le CharacterBody3D qu'on
## lui donne (body), reutilisable tel quel sur un futur second personnage jouable.
## Necessite les actions d'input "move_left", "move_right", "move_up", "move_down" (Input Map).
class_name MovementComponent
extends Node

@export var body: CharacterBody3D
@export var speed: float = 5.0
@export var gravity: float = 9.8

func _physics_process(delta: float) -> void:
	if body == null:
		return

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_dir.x, 0.0, input_dir.y).normalized()

	body.velocity.x = direction.x * speed
	body.velocity.z = direction.z * speed
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta
	else:
		body.velocity.y = 0.0

	body.move_and_slide()
