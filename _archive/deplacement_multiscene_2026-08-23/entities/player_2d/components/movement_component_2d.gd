## Composant de deplacement plateformer 2D. Independant : ne connait que le CharacterBody2D qu'on
## lui donne (body), meme principe de composition que movement_component.gd (version 3D,
## conservee intacte pour l'ancienne scene park.tscn - voir ARCHITECTURE.md pour l'historique du
## passage en 2D). Necessite les actions d'input "move_left"/"move_right" (deja dans l'Input Map)
## et reutilise "move_up" comme declencheur de saut plutot que d'ajouter une nouvelle action -
## evite de devoir saisir un code de touche a la main dans project.godot sans pouvoir le tester
## dans l'editeur reel ; a remplacer par une vraie action "jump" dediee si besoin plus tard.
class_name MovementComponent2D
extends Node

@export var body: CharacterBody2D
@export var speed: float = 220.0
@export var gravity: float = 1200.0
@export var jump_velocity: float = -420.0
## Noeud a retourner horizontalement (scale.x) selon la direction de deplacement - la capsule
## placeholder (voir entities/decor_2d/capsule_2d.gd) pour l'instant, un futur AnimatedSprite2D
## plus tard. Optionnel : laisser vide ne casse rien, juste pas de retournement visuel.
@export var sprite: Node2D
## Bornes horizontales (position.x locale, meme repere que body.position) de la zone dans laquelle
## le joueur reste confine. Remplace l'ancien systeme camera_limit_left/right de Player2D : la
## camera est maintenant fixe (voir park_2d.tscn) et ne suit plus le joueur, donc c'est au joueur
## de rester dans le cadre plutot qu'a la camera de le suivre. Chaque niveau fixe ces deux valeurs
## sur l'instance pour qu'elles correspondent au champ de vision de sa camera fixe. Par defaut
## illimite (INF) pour ne rien casser si un niveau ne les configure pas encore.
@export var zone_min_x: float = -INF
@export var zone_max_x: float = INF

func _physics_process(delta: float) -> void:
	if body == null:
		return
	## Fige completement le joueur pendant qu'une fenetre modale est ouverte (question, boutique,
	## choix de classe...), meme garde-fou que la version 3D (voir movement_component.gd).
	if PlayerInputLock.is_locked():
		body.velocity = Vector2.ZERO
		return

	if body.is_on_floor():
		body.velocity.y = 0.0
		if Input.is_action_just_pressed("move_up"):
			body.velocity.y = jump_velocity
	else:
		body.velocity.y += gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	body.velocity.x = direction * speed

	body.move_and_slide()
	body.position.x = clampf(body.position.x, zone_min_x, zone_max_x)

	if sprite and absf(direction) > 0.001:
		sprite.scale.x = -1.0 if direction < 0.0 else 1.0
