## Fait pivoter le joueur et l'interactable actif l'un vers l'autre ("face a face") pendant une
## interaction activee (E -> panneau modal ouvert - voir CameraRig, qui reagit au meme instant
## pour zoomer), et les ramene a leur orientation d'avant l'activation des que le panneau se
## ferme, en douceur, en meme temps que la camera dezoome.
##
## Tourne la racine de l'interactable (le parent du InteractableComponent : NPC, ShopKiosk...),
## pas le InteractableComponent lui-meme qui n'est qu'une zone de detection Area3D sans maillage
## visible (voir interactable_component.gd - InteractableComponent est toujours un enfant direct
## de la racine visible/physique de l'entite). Generique par construction : marche pour tout
## interactable dont le parent est un Node3D ; un objet statique/symetrique tourne "pour rien"
## (aucun effet visible a l'ecran), pas besoin de le traiter comme un cas particulier.
##
## Composant independant de CameraRig (pas d'appel direct entre les deux) : les deux ecoutent les
## memes signaux globaux (PlayerInputLock, EventBus.interactable_focused/unfocused), comme le
## reste du projet qui couple ses composants via les autoloads plutot que par reference directe.
class_name InteractionFacing
extends Node

## Le joueur a faire pivoter. Assigne par player.gd, meme pattern que les autres composants.
@export var target: CharacterBody3D
## Vitesse de rotation pendant le face-a-face (radians/s), comme MovementComponent.turn_speed.
@export var turn_speed: float = 8.0
## Duree du retour a l'orientation d'origine une fois le panneau ferme (secondes). Au-dela, on
## arrete d'y toucher meme si l'angle n'est pas parfaitement retombe - imperceptible en pratique
## vu la vitesse de rotation, et evite d'avoir a guetter une convergence exacte.
@export var return_duration: float = 0.4

var _current_interactable: Node3D
var _interactable_owner: Node3D
var _is_focused: bool = false
var _returning: bool = false
var _return_time_left: float = 0.0
var _player_rest_angle: float = 0.0
var _owner_rest_angle: float = 0.0

func _ready() -> void:
	EventBus.interactable_focused.connect(_on_interactable_focused)
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	PlayerInputLock.lock_changed.connect(_on_lock_changed)

func _process(delta: float) -> void:
	if _is_focused:
		_face_each_other(delta)
	elif _returning:
		_return_to_rest(delta)

## Chaque frame pendant l'activation : le joueur et le proprietaire de l'interactable tournent
## l'un vers l'autre le long de l'axe qui les separe (horizontal, Y ignore).
func _face_each_other(delta: float) -> void:
	if target == null or _interactable_owner == null:
		return
	var offset := _interactable_owner.global_position - target.global_position
	offset.y = 0.0
	if offset.length_squared() < 0.0001:
		return
	var t := clampf(turn_speed * delta, 0.0, 1.0)
	target.rotation.y = lerp_angle(target.rotation.y, atan2(-offset.x, -offset.z), t)
	_interactable_owner.rotation.y = lerp_angle(_interactable_owner.rotation.y, atan2(offset.x, offset.z), t)

## Chaque frame apres la fermeture du panneau, pendant return_duration secondes : ramene les deux
## a l'angle capture avant l'activation.
func _return_to_rest(delta: float) -> void:
	_return_time_left -= delta
	var t := clampf(turn_speed * delta, 0.0, 1.0)
	## Ne touche pas a la rotation du joueur s'il est deja reparti se deplacer : MovementComponent
	## a repris la main sur target.rotation.y des que le verrou saute, la lui laisser evite que
	## les deux composants se disputent la meme propriete la meme frame.
	var player_moving := Input.get_vector("move_left", "move_right", "move_up", "move_down").length_squared() > 0.0001
	if target and not player_moving:
		target.rotation.y = lerp_angle(target.rotation.y, _player_rest_angle, t)
	if _interactable_owner:
		_interactable_owner.rotation.y = lerp_angle(_interactable_owner.rotation.y, _owner_rest_angle, t)
	if _return_time_left <= 0.0:
		_returning = false
		_interactable_owner = null

## Suit en continu le dernier interactable en portee (avant meme l'appui sur E), meme logique que
## CameraRig._on_interactable_focused - ne declenche rien tant que le panneau n'est pas ouvert.
func _on_interactable_focused(interactable: Node) -> void:
	_current_interactable = interactable as Node3D

func _on_interactable_unfocused(interactable: Node) -> void:
	if _current_interactable == interactable:
		_current_interactable = null

## PlayerInputLock se verrouille exactement quand une interaction s'active (E), pas au simple
## passage a proximite - meme declencheur que CameraRig._on_lock_changed. On ne demarre le
## face-a-face que si un interactable est bien a l'origine du verrouillage (le menu/l'album
## ouverts via un bouton d'interface n'en ont pas) : le joueur reste alors immobile de toute
## facon (PlayerInputLock coupe le mouvement), rien a faire tourner.
func _on_lock_changed(is_locked: bool) -> void:
	if is_locked and _current_interactable:
		_interactable_owner = _current_interactable.get_parent() as Node3D
		if target:
			_player_rest_angle = target.rotation.y
		if _interactable_owner:
			_owner_rest_angle = _interactable_owner.rotation.y
		_is_focused = true
		_returning = false
	else:
		_is_focused = false
		## _interactable_owner n'est non-null que si le verrouillage precedent avait bien un
		## interactable (voir la branche ci-dessus) : un menu/album ouvert sans interactable ne
		## doit declencher aucun retour, il n'y a jamais rien eu a faire tourner.
		if _interactable_owner != null:
			_returning = true
			_return_time_left = return_duration
