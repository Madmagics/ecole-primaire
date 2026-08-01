## Disperse des GROUPES d'instances de [scene_to_scatter] plutot que des instances isolees : tire
## [cluster_count] centres de grappe au hasard dans un rectangle (moins les zones d'exclusion),
## puis place [cluster_size] instances autour de chaque centre avec un leger decalage aleatoire
## ([cluster_radius]). Donne un rendu "bosquet"/"massif" coherent - voir park.tscn (TreeGroves,
## FlowerClusters) - plutot que du decor eparpille sans logique (retour utilisateur du
## 2026-07-29 : le decor precedent, une instance isolee par point, ne ressemblait "pas a un parc").
##
## Se retire a chaque lancement du jeu (pas de graine fixe) - acceptable ici car purement
## cosmetique ; fixer une graine (seed()) plus tard si un rendu identique d'une partie a l'autre
## devenait necessaire.
class_name ClusterScatter
extends Node3D

@export var scene_to_scatter: PackedScene
@export var cluster_count: int = 6
@export var cluster_size: int = 3
## Rayon de dispersion des instances autour du centre de chaque grappe.
@export var cluster_radius: float = 2.5

## Demi-etendue (x, z) du rectangle de dispersion, centre sur ce noeud.
@export var area_half_extents: Vector2 = Vector2(24.0, 24.0)

## Rectangle central (demi-etendues) entierement exclu - garde un couloir degage au milieu du
## parc (ex : aucun arbre au centre). Laisser a (0, 0) pour ne rien exclure.
@export var center_exclusion_half_extents: Vector2 = Vector2(0.0, 0.0)

## Centres (x, z), en coordonnees locales a ce noeud, a eviter pour le CENTRE d'une grappe (PNJ,
## kiosque, spawn...) - une grappe ne peut pas naitre la, mais ses instances individuelles peuvent
## deborder legerement dessus (cluster_radius), ce qui reste acceptable visuellement pour du decor.
@export var exclusion_centers: Array[Vector2] = []
@export var exclusion_radius: float = 2.0

func _ready() -> void:
	if scene_to_scatter == null:
		return
	var placed_clusters := 0
	var attempts := 0
	## Nombre d'essais borne plutot qu'une boucle "tant que pas assez de grappes placees" : si les
	## zones d'exclusion couvraient un jour une trop grande part du rectangle, on s'arrete
	## proprement avec un peu moins de grappes plutot que de boucler indefiniment.
	while placed_clusters < cluster_count and attempts < cluster_count * 30:
		attempts += 1
		var cx := randf_range(-area_half_extents.x, area_half_extents.x)
		var cz := randf_range(-area_half_extents.y, area_half_extents.y)
		if _is_in_center_zone(cx, cz) or _is_excluded(cx, cz):
			continue
		_place_cluster(cx, cz)
		placed_clusters += 1

func _place_cluster(cx: float, cz: float) -> void:
	for i in cluster_size:
		var instance := scene_to_scatter.instantiate() as Node3D
		if instance == null:
			continue
		add_child(instance)
		instance.position = Vector3(
			cx + randf_range(-cluster_radius, cluster_radius),
			0.0,
			cz + randf_range(-cluster_radius, cluster_radius)
		)

func _is_in_center_zone(x: float, z: float) -> bool:
	return absf(x) < center_exclusion_half_extents.x and absf(z) < center_exclusion_half_extents.y

func _is_excluded(x: float, z: float) -> bool:
	var point := Vector2(x, z)
	for center in exclusion_centers:
		if point.distance_to(center) < exclusion_radius:
			return true
	return false
