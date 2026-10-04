## Fait defiler des sprites decoratifs (nuages de school1, vaisseaux de school5...) dans la zone
## definie par le polygone de ce noeud (ex: "zone-nuages" dans school1.tscn, "zone-vaisseaux"
## dans school5.tscn). Le polygone ne sert que de zone de donnees (bornes horizontale/verticale) :
## il est masque en code (visible = false) pour ne jamais s'afficher comme forme pleine. Les
## sprites generes sont ajoutes comme enfants du noeud PARENT pour rester visibles
## independamment de ce masquage.
## Deux sources de sprites, melangees dans le meme tirage :
## - cloud_textures : textures simples, de gauche a droite a l'horizontale (nuages de school1) ;
## - entries : un ScrollingSpriteEntry par sprite avec son propre sens et son propre angle
##   (vaisseaux de school5).
## Chaque sprite apparait totalement hors-zone du cote de depart, se deplace a vitesse constante
## (aleatoire et lente) le long de sa trajectoire, puis n'est libere qu'une fois totalement sorti
## de l'ecran - il ne disparait jamais pendant qu'il est visible.
## La hauteur est tiree dans la zone au milieu de la traversee : avec un angle, le debut et la fin
## de la trajectoire peuvent deborder de la zone (c'est voulu, la diagonale reste centree dessus).
class_name CloudScroller
extends Polygon2D

## Textures simples qui defilent de GAUCHE a DROITE a l'horizontale (ex: nuage1..7).
@export var cloud_textures: Array[Texture2D] = []
## Sprites avec sens et angle propres (ex: un par vaisseau dans school5).
@export var entries: Array[ScrollingSpriteEntry] = []
## Incline le sprite selon l'angle de sa trajectoire (nez dans le sens du vol).
@export var tilt_with_angle: bool = true
## Nombre maximum de sprites visibles simultanement.
@export var max_concurrent_clouds: int = 3
## Vitesse de defilement en pixels/seconde, piochee aleatoirement par sprite entre ces deux bornes.
@export var speed_min_px_per_sec: float = 15.0
@export var speed_max_px_per_sec: float = 35.0
## Intervalle (secondes) entre deux tentatives de faire apparaitre un nouveau sprite.
@export var spawn_interval_min: float = 2.0
@export var spawn_interval_max: float = 5.0
## Echelle appliquee a chaque sprite genere (ex: 0.35 pour des vaisseaux de ~500 px de large).
@export var sprite_scale: float = 1.0
## z_index de chaque sprite genere (ex: -1 pour passer derriere le fond de classe a 0).
@export var sprite_z_index: int = 0

## Marge (pixels) au-dela de la largeur du sprite, gardee avant/apres la zone pour etre certain
## qu'il apparait/disparait totalement hors-zone (jamais coupe pendant qu'il y est visible).
const _EDGE_BUFFER: float = 20.0

var _rng := RandomNumberGenerator.new()
var _spawn_timer: float = 0.0
## "Sac" d'indices (dans le pool cloud_textures + textures_right_to_left) melange : chaque texture
## passe une fois avant qu'une texture deja vue ne repasse, puis le sac est re-melange.
var _bag: Array[int] = []
var _last_pick: int = -1
## Chaque entree : {"sprite": Sprite2D, "velocity": Vector2}.
var _active_clouds: Array[Dictionary] = []

var _zone_min_x: float
var _zone_max_x: float
var _zone_min_y: float
var _zone_max_y: float


func _ready() -> void:
	visible = false
	_rng.randomize()
	_compute_zone_bounds()
	_spawn_timer = _rng.randf_range(0.0, spawn_interval_min)


func _process(delta: float) -> void:
	_spawn_timer -= delta
	var has_textures: bool = not cloud_textures.is_empty() or not entries.is_empty()
	if _spawn_timer <= 0.0 and _active_clouds.size() < max_concurrent_clouds and has_textures:
		_spawn_cloud()
		_spawn_timer = _rng.randf_range(spawn_interval_min, spawn_interval_max)
	for i in range(_active_clouds.size() - 1, -1, -1):
		var cloud: Dictionary = _active_clouds[i]
		var sprite: Sprite2D = cloud["sprite"]
		var velocity: Vector2 = cloud["velocity"]
		sprite.position += velocity * delta
		var half_size: float = _half_extent(sprite)
		var gone_right: bool = velocity.x > 0.0 and sprite.position.x - half_size > _zone_max_x + _EDGE_BUFFER
		var gone_left: bool = velocity.x < 0.0 and sprite.position.x + half_size < _zone_min_x - _EDGE_BUFFER
		# Angle fort : le sprite peut quitter l'ecran par le haut/bas bien avant le bord lateral.
		# (Camera fixe sur l'ecran 1152x648 : coordonnees du parent = coordonnees ecran.)
		var screen: Rect2 = get_viewport_rect()
		var gone_up: bool = velocity.y < 0.0 and sprite.position.y + half_size < screen.position.y - _EDGE_BUFFER
		var gone_down: bool = velocity.y > 0.0 and sprite.position.y - half_size > screen.end.y + _EDGE_BUFFER
		if gone_right or gone_left or gone_up or gone_down:
			sprite.queue_free()
			_active_clouds.remove_at(i)


## Calcule les bornes de la zone dans l'espace local du noeud PARENT (celui qui recoit les
## sprites), en tenant compte du transform de ce noeud - robuste meme si la zone est deplacee/
## redimensionnee dans l'editeur.
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


## Demi-diagonale du sprite a l'echelle : marge sure quelle que soit son inclinaison.
func _half_extent(sprite: Sprite2D) -> float:
	return sprite.texture.get_size().length() * absf(sprite.scale.x) * 0.5


func _spawn_cloud() -> void:
	var pick: int = _draw_from_bag()
	var cloud_tex: Texture2D
	var goes_left: bool = false
	var angle_deg: float = 0.0
	if pick < cloud_textures.size():
		cloud_tex = cloud_textures[pick]
	else:
		var entry: ScrollingSpriteEntry = entries[pick - cloud_textures.size()]
		if entry == null or entry.texture == null:
			return
		cloud_tex = entry.texture
		goes_left = entry.direction == ScrollingSpriteEntry.Direction.RIGHT_TO_LEFT
		angle_deg = entry.angle_deg
	var sprite := Sprite2D.new()
	sprite.texture = cloud_tex
	sprite.scale = Vector2(sprite_scale, sprite_scale)
	sprite.z_index = sprite_z_index
	var angle_rad: float = deg_to_rad(angle_deg)
	var dir_x: float = -1.0 if goes_left else 1.0
	if tilt_with_angle:
		# Rotation positive = sens horaire a l'ecran : nez a droite -> +angle pour descendre,
		# nez a gauche -> -angle pour descendre.
		sprite.rotation = angle_rad * dir_x
	var half_size: float = _half_extent(sprite)
	var speed: float = _rng.randf_range(speed_min_px_per_sec, speed_max_px_per_sec)
	var velocity := Vector2(dir_x * cos(angle_rad), sin(angle_rad)) * speed
	var start_x: float = _zone_min_x - half_size - _EDGE_BUFFER
	if goes_left:
		start_x = _zone_max_x + half_size + _EDGE_BUFFER
	# Hauteur tiree au milieu horizontal de la zone, puis reportee au point de depart le long de
	# la trajectoire : la diagonale traverse ainsi toujours la zone en son centre.
	var mid_x: float = (_zone_min_x + _zone_max_x) * 0.5
	var mid_y: float = _rng.randf_range(_zone_min_y, _zone_max_y)
	var start_y: float = mid_y - (mid_x - start_x) * dir_x * tan(angle_rad)
	sprite.position = Vector2(start_x, start_y)
	get_parent().add_child(sprite)
	_active_clouds.append({
		"sprite": sprite,
		"velocity": velocity,
	})


## Tire le prochain indice du sac ; le re-remplit et le re-melange quand il est vide, en evitant
## que le premier du nouveau tour soit identique au dernier du tour precedent.
func _draw_from_bag() -> int:
	if _bag.is_empty():
		var total: int = cloud_textures.size() + entries.size()
		for i in total:
			_bag.append(i)
		# Melange de Fisher-Yates avec notre RNG (Array.shuffle() utilise le RNG global).
		for i in range(total - 1, 0, -1):
			var j: int = _rng.randi_range(0, i)
			var tmp: int = _bag[i]
			_bag[i] = _bag[j]
			_bag[j] = tmp
		if total > 1 and _bag.back() == _last_pick:
			var swap_with: int = _rng.randi_range(0, total - 2)
			var tmp2: int = _bag[total - 1]
			_bag[total - 1] = _bag[swap_with]
			_bag[swap_with] = tmp2
	_last_pick = _bag.pop_back()
	return _last_pick
