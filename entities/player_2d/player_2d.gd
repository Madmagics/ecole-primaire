## Racine du joueur (plateformer 2D) : assemble les composants par composition, meme principe que
## player.gd (version 3D, conservee intacte). InteractorComponent est REUTILISE tel quel depuis
## entities/player/components/interactor_component.gd - il ne connait que des signaux/EventBus,
## aucune dependance 3D, donc aucune raison d'en dupliquer une copie 2D.
class_name Player2D
extends CharacterBody2D

@onready var movement: MovementComponent2D = $MovementComponent2D
@onready var interactor: InteractorComponent = $InteractorComponent
@onready var camera: Camera2D = $Camera2D

## Bornes de scroll de la camera (voir Camera2D.limit_left/right officiel) : exportees ici plutot
## que reglees a la main sur le Camera2D interne, pour que chaque niveau (voir park_2d.tscn) les
## fixe simplement en overridant ces deux valeurs sur l'instance du joueur, comme le reste du
## projet le fait deja pour d'autres reglages par instance (ex: grade sur QuestionGiverComponent).
@export var camera_limit_left: int = -10000000
@export var camera_limit_right: int = 10000000

func _ready() -> void:
	add_to_group("player")
	movement.body = self
	camera.limit_left = camera_limit_left
	camera.limit_right = camera_limit_right
