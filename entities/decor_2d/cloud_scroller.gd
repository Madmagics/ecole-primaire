## Fait defiler des nuages (assets/classe2.0/decor-cp/nuage*.webp) de gauche a droite dans la
## zone definie par le polygone de ce noeud (ex: "zone-nuages" dans school1.tscn). Le polygone ne
## sert que de zone de donnees (bornes horizontale/verticale) : il est masque en code
## (visible = false) pour ne jamais s'afficher comme forme pleine (couleur de remplissage par
## defaut sinon un aplat blanc opaque). Les nuages generes sont ajoutes comme enfants du noeud
## PARENT (ex: "Background", juste apres ClasseVide dans school1.tscn) pour rester visibles
## independamment de ce masquage, et pour bien s'afficher au-dessus du fond.
## Chaque nuage apparait totalement hors-zone a gauche, se deplace a vitesse constante (mais
## aleatoire et lente) puis n'est libere qu'une fois totalement sorti a droite de la zone - il ne
## disparait jamais pendant qu'il est visible dedans.
class_name CloudScroller
extends Polygon2D

## Textures a piocher aleatoirement pour chaque nouveau nuage (ex: nuage1.webp a nuage4.webp) -
## assignees dans l'Inspecteur (voir zone-nuages dans school1.tscn).
@export var cloud_textures: Array[Texture2D] = []
## Nombre maximum de nuages visibles simultanement.
@export var max_concurrent_clouds: int = 3
## Vitesse de defilement en pixels/seconde, piochee aleatoirement par nuage entre ces deux bornes.
@export var speed_min_px_per_sec: float = 15.0
@export var speed_max_px_per_sec: float = 35.0

## Intervalle (secondes) entre deux tentatives de faire apparaitre un nouveau nuage.
const _SPAWN_INTERVAL_MIN: float = 2.0
const _SPAWN_INTERVAL_MAX: float = 5.0
## Marge (pixels) au-dela de la largeur du nuage, gardee avant/apres la zone pour etre certain
## qu'il apparait/disparait totalement hors-zone (jamais coupe pendant qu'il y est visible).
const _EDGE_BUFFER: float = 20.0

var _rng := RandomNumberGenerator.new()
var _spawn_timer: float = 0.0
## Chaque entree : {"sprite": Sprite2D, "speed": float}.
var _active_clouds: Array[Dictionary] = []

var _zone_min_x: float
var _zone_max_x: float
var _zone_min_y: float
var _zone_max_y: float


func _ready() -> void:
	visible = false
	_rng.randomize()
	_compute_zone_bounds()
	_spawn_timer = _rng.randf_range(0.0, _SPAWN_INTERVAL_MIN)


func _process(delta: float) -> void:
	_spawn_timer -= delta
	if _spawn_timer <= 0.0 and _active_clouds.size() < max_concurrent_clouds and not cloud_textures.is_empty():
		_spawn_cloud()
		_spawn_timer = _rng.randf_range(_SPAWN_INTERVAL_MIN, _SPAWN_INTERVAL_MAX)
	for i in range(_active_clouds.size() - 1, -1, -1):
		var cloud: Dictionary = _active_clouds[i]
		var sprite: Sprite2D = cloud["sprite"]
		sprite.position.x += float(cloud["speed"]) * delta
		var half_width: float = (sprite.texture.get_width() * sprite.scale.x) * 0.5
		if sprite.position.x - half_width > _zone_max_x + _EDGE_BUFFER:
			sprite.queue_free()
			_active_clouds.remove_at(i)


## Calcule les bornes de la zone dans l'espace local du noeud PARENT (celui qui recoit les
## nuages), en tenant compte du transform de ce noeud - robuste meme si "zone-nuages" est deplace/
## redimensionne dans l'editeur.
func _compute_zone_bounds() -> void:
	var min_x: float = INF
	var max_x: float = -INF
	var min_y: float = INF
	var max_y: float = -INF
	for local_point in polygon:
		var point_in_parent: Vector2 = transform * local_point
		min_x = minf(min_x, point_in_parent.x)
		max_x = maxf(max_x, point_in_parent.x)
		min_y = minf(min_y, point_in_parent.y)
		max_y = maxf(max_y, point_in_parent.y)
	_zone_min_x = min_x
	_zone_max_x = max_x
	_zone_min_y = min_y
	_zone_max_y = max_y


func _spawn_cloud() -> void:
	var sprite := Sprite2D.new()
	sprite.texture = cloud_textures[_rng.randi_range(0, cloud_textures.size() - 1)]
	var half_width: float = sprite.texture.get_width() * 0.5
	sprite.position.x = _zone_min_x - half_width - _EDGE_BUFFER
	sprite.position.y = _rng.randf_range(_zone_min_y, _zone_max_y)
	get_parent().add_child(sprite)
	_active_clouds.append({
		"sprite": sprite,
		"speed": _rng.randf_range(speed_min_px_per_sec, speed_max_px_per_sec),
	})
