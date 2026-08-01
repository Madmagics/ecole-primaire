## Choisit au hasard, a chaque _ready(), l'un des modeles fournis dans [variants] et l'instancie
## comme enfant. Permet de varier l'apparence (essences d'arbre, touffes d'herbe...) sans creer
## une scene par variante dans park.tscn : une seule instance de ce composant "pioche" elle-meme
## parmi les modeles disponibles a chaque placement.
##
## Si [collision_shape] est fourni, le modele choisi est enveloppe dans un StaticBody3D/
## CollisionShape3D (consistance physique - ex : troncs d'arbre). Sinon il est ajoute tel quel,
## purement decoratif et sans aucun cout physique (ex : herbe, fleurs) - important quand ce
## composant est repete en tres grand nombre dans le parc (voir DecorScatter).
class_name RandomVariant
extends Node3D

@export var variants: Array[PackedScene] = []

## Forme de collision optionnelle a placer autour du modele choisi. Laisser vide (par defaut) pour
## un decor purement visuel.
@export var collision_shape: Shape3D

## Decalage vertical de la forme de collision par rapport a l'origine du modele - les modeles ont
## leur origine au sol, une forme de collision (cylindre de tronc, par exemple) est generalement
## centree plus haut.
@export var collision_offset_y: float = 0.0

## Rotation aleatoire autour de l'axe vertical : casse la repetition visuelle quand le meme modele
## se retrouve instancie plusieurs fois a proximite, sans avoir a varier chaque instance a la main
## dans l'editeur.
@export var random_y_rotation: bool = true

func _ready() -> void:
	if variants.is_empty():
		return
	var chosen: PackedScene = variants[randi() % variants.size()]
	## instantiate() renvoie un Node de base : cast explicite necessaire pour acceder a
	## rotation/position (typage statique GDScript 4.x) - voir garde ci-dessous si jamais la
	## scene fournie n'a pas une racine Node3D.
	var instance := chosen.instantiate() as Node3D
	if instance == null:
		push_warning("RandomVariant: '%s' n'a pas de racine Node3D, ignoree." % chosen.resource_path)
		return
	if random_y_rotation:
		instance.rotation.y = randf_range(0.0, TAU)
	if collision_shape != null:
		var body := StaticBody3D.new()
		var shape_node := CollisionShape3D.new()
		shape_node.shape = collision_shape
		shape_node.position.y = collision_offset_y
		body.add_child(shape_node)
		body.add_child(instance)
		add_child(body)
	else:
		add_child(instance)
