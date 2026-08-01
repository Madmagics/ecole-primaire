## Portail au fond du parc (mur nord) : possede un etat ouvert/ferme qui pilote a la fois
## l'aspect (deux vantaux qui coulissent le long de l'axe X local) et la collision (passage
## libre ou bloque). Design de base uniquement : le declencheur de l'ouverture (progression du
## joueur, evenement de jeu...) n'est pas encore defini - is_open se pilote pour l'instant depuis
## l'inspecteur ou via set_open(), a brancher plus tard (ex: EventBus, GradeUnlock) une fois le
## contenu de la fete foraine construit derriere ce portail.
class_name ParkGate
extends Node3D

## Etat courant du portail. Modifiable depuis l'inspecteur (snap immediat) ou via set_open() une
## fois la scene en jeu (transition animee).
@export var is_open: bool = false:
	set(value):
		var changed := value != is_open
		is_open = value
		if is_inside_tree() and changed:
			_apply_state(true)

## Decalage en X (position locale) d'un vantail ferme : les deux vantaux se rejoignent au centre.
@export var door_closed_offset: float = 1.5
## Decalage en X d'un vantail ouvert : recule derriere son pilier, hors de l'ouverture.
@export var door_open_offset: float = 4.5
## Duree du coulissement, en secondes.
@export var slide_duration: float = 1.2

@onready var _door_left: Node3D = $DoorLeft
@onready var _door_right: Node3D = $DoorRight
@onready var _barrier_shape: CollisionShape3D = $GateBarrier/CollisionShape3D

func _ready() -> void:
	_apply_state(false)

## Point d'entree public pour la logique de jeu future (voir note en tete de fichier).
func set_open(value: bool) -> void:
	is_open = value

func toggle() -> void:
	set_open(not is_open)

func _apply_state(animate: bool) -> void:
	_barrier_shape.disabled = is_open
	var target := door_open_offset if is_open else door_closed_offset
	if animate:
		var tween := create_tween().set_parallel(true)
		tween.tween_property(_door_left, "position:x", -target, slide_duration)
		tween.tween_property(_door_right, "position:x", target, slide_duration)
	else:
		_door_left.position.x = -target
		_door_right.position.x = target
