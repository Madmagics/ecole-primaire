## Tapis d'herbe DENSE (plusieurs milliers de brins) rendu via MultiMeshInstance3D - une seule
## instance de rendu par variante de mesh source, quel que soit le nombre de brins (contrairement
## a une scene par brin comme l'ancien systeme, qui multipliait les draw calls - voir
## docs.godotengine.org/en/4.7/tutorials/performance/using_multimesh.html : "MultiMesh... can draw
## thousands of instances with a single draw call"). Repond au retour utilisateur du 2026-07-29 :
## le gazon precedent (touffes eparses sur un sol vide) ne ressemblait pas a un parc - il fallait
## du "gazon touffu".
##
## Purement decoratif : aucune collision (jamais necessaire pour du gazon).
##
## Limite connue : contrairement a SeasonalSkin (voir seasonal_skin.gd), ce champ ne verifie PAS
## entities/decor/seasons/<saison>/ - un MultiMesh partage un seul Mesh pour toutes ses instances,
## donc une skin hivernale devrait remplacer le Mesh entier du MultiMesh plutot qu'echanger des
## noeuds. A etendre (meme principe de resolution de chemin que SeasonalSkin, applique a
## _extract_mesh) si une variante d'herbe saisonniere devient necessaire.
class_name GrassField
extends Node3D

@export var grass_scenes: Array[PackedScene] = []
@export var total_instances: int = 2400

## Demi-etendue (x, z) du rectangle de dispersion, centre sur ce noeud.
@export var area_half_extents: Vector2 = Vector2(24.0, 24.0)

## Centres (x, z), en coordonnees locales a ce noeud, a eviter - PNJ, kiosque, spawn... - pour ne
## pas faire pousser d'herbe en plein dans un objet deja present.
@export var exclusion_centers: Array[Vector2] = []
@export var exclusion_radius: float = 2.0

## Variation d'echelle aleatoire par brin : casse encore un peu plus la repetition visuelle et
## renforce l'effet "touffu" (des touffes plus grosses cote a cote de plus petites).
@export var min_scale: float = 0.85
@export var max_scale: float = 1.3

func _ready() -> void:
	if grass_scenes.is_empty():
		return
	var per_variant := maxi(1, total_instances / grass_scenes.size())
	for scene in grass_scenes:
		var mesh := _extract_mesh(scene)
		if mesh == null:
			push_warning("GrassField: aucun MeshInstance3D trouve dans '%s', variante ignoree." % scene.resource_path)
			continue
		_spawn_multimesh(mesh, per_variant)

## Les fichiers glTF s'importent comme PackedScene (racine Node3D + MeshInstance3D enfant), pas
## comme Mesh directement : on instancie une fois pour recuperer le Mesh partage, puis on jette
## l'instance temporaire (le Mesh reste valide, reference par le MultiMesh).
func _extract_mesh(scene: PackedScene) -> Mesh:
	var temp := scene.instantiate()
	var mesh_instance := _find_mesh_instance(temp)
	var mesh: Mesh = mesh_instance.mesh if mesh_instance != null else null
	temp.free()
	return mesh

func _find_mesh_instance(node: Node) -> MeshInstance3D:
	if node is MeshInstance3D:
		return node
	for child in node.get_children():
		var found := _find_mesh_instance(child)
		if found != null:
			return found
	return null

func _spawn_multimesh(mesh: Mesh, instance_count: int) -> void:
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = mesh
	multimesh.instance_count = instance_count
	var placed := 0
	var attempts := 0
	while placed < instance_count and attempts < instance_count * 5:
		attempts += 1
		var x := randf_range(-area_half_extents.x, area_half_extents.x)
		var z := randf_range(-area_half_extents.y, area_half_extents.y)
		if _is_excluded(x, z):
			continue
		var s := randf_range(min_scale, max_scale)
		var basis := Basis(Vector3.UP, randf_range(0.0, TAU)).scaled(Vector3(s, s, s))
		multimesh.set_instance_transform(placed, Transform3D(basis, Vector3(x, 0.0, z)))
		placed += 1
	multimesh.visible_instance_count = placed
	var mm_instance := MultiMeshInstance3D.new()
	mm_instance.multimesh = multimesh
	add_child(mm_instance)

func _is_excluded(x: float, z: float) -> bool:
	var point := Vector2(x, z)
	for center in exclusion_centers:
		if point.distance_to(center) < exclusion_radius:
			return true
	return false
