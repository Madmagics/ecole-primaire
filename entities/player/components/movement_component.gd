## Composant de deplacement 3e personne. Independant : ne connait que le CharacterBody3D qu'on
## lui donne (body), reutilisable tel quel sur un futur second personnage jouable.
## Necessite les actions d'input "move_left", "move_right", "move_up", "move_down" (Input Map).
##
## Controles "world-relative" (gauche = gauche a l'ecran, quelle que soit l'orientation du
## personnage) : c'est volontaire, pas un oubli. Adapte a un public 5-10 ans qui n'a pas a
## reflechir a une direction relative a une camera - voir ARCHITECTURE.md ("Camera et
## deplacement"). Le personnage tourne quand meme visuellement pour faire face a sa direction
## de deplacement (voir _update_facing) : c'est purement cosmetique, ca ne change ni les
## touches ni la logique de deplacement ci-dessus (body.velocity.x/z restent en axes du monde).
class_name MovementComponent
extends Node

@export var body: CharacterBody3D
@export var speed: float = 5.0
@export var gravity: float = 9.8
## Vitesse de rotation du personnage vers sa direction de deplacement (radians/s). Volontairement
## rapide (pas un vrai "turn radius" de vehicule) : a cet age, un personnage qui met du temps a
## se tourner est percu comme un bug/de la lenteur, pas comme du realisme.
@export var turn_speed: float = 12.0

func _physics_process(delta: float) -> void:
	if body == null:
		return
	## Fige completement le joueur pendant qu'une fenetre modale est ouverte (question,
	## boutique, choix de classe...) : Input.get_vector() lit l'etat brut du clavier et
	## ignore le focus des champs de texte, donc sans ce garde-fou taper une reponse
	## deplacerait quand meme le personnage.
	if PlayerInputLock.is_locked():
		body.velocity = Vector3.ZERO
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

	if direction.length_squared() > 0.0001:
		_update_facing(direction, delta)

## Fait pivoter "body" pour qu'il regarde dans "direction" (axes du monde, Y ignore), en tournant
## progressivement plutot que d'un coup (lerp_angle) pour un mouvement plus doux. La formule
## atan2(-direction.x, -direction.z) suppose la convention Godot par defaut ("avant" = -Z local
## a rotation nulle) : si un futur modele importe est oriente vers +Z, corriger via une rotation
## locale fixe sur le MeshInstance3D (pas ici) plutot que de changer cette formule.
func _update_facing(direction: Vector3, delta: float) -> void:
	var target_angle := atan2(-direction.x, -direction.z)
	body.rotation.y = lerp_angle(body.rotation.y, target_angle, turn_speed * delta)
