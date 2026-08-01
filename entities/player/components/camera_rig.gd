## Camera du joueur : deux cadrages distincts, sans jamais tourner en reponse aux touches de
## deplacement (public 5-10 ans, voir ARCHITECTURE.md "Camera et deplacement") :
##
## - Cadrage "suivi" (par defaut) : plongee fixe (~40 degres), style Animal Crossing, qui suit
##   le joueur sans jamais pivoter - seule sa position glisse.
## - Cadrage "activation" : quand un interactable est reellement active (touche E -> panneau
##   modal ouvert, voir PlayerInputLock), la camera se repositionne face a l'interactable, a
##   hauteur d'yeux (sans angle haut) et zoomee pour montrer le joueur ET l'interactable a
##   l'ecran. Le joueur est fige pendant ce temps (voir MovementComponent.gd), donc ce
##   changement de cadrage ne contredit pas la regle "la camera ne tourne jamais en reponse
##   aux deplacements" : ce n'est pas le deplacement qui la fait tourner, c'est un changement
##   d'etat de jeu explicite (E), pendant lequel le joueur ne peut de toute facon plus bouger.
##
## Implementation : plutot qu'un SpringArm3D (bras rigide a une seule inclinaison fixe), le
## script calcule chaque frame une position ("oeil") et un point vise ("look_at") desires selon
## le mode actif, puis fait glisser la camera reelle vers ces valeurs (lerp de position +
## look_at recalcule chaque frame sur la position lissee => la rotation suit en douceur, sans
## avoir a geree un slerp de quaternion a la main). Le SpringArm3D a ete abandonne ici car son
## pivot+ressort suppose une seule inclinaison fixe ; le cadrage "activation" a besoin d'une
## orientation arbitraire (face a l'interactable, qui differe pour chaque NPC/boutique) que le
## ressort ne peut pas exprimer simplement.
## Contrepartie : l'evitement de collision automatique du SpringArm3D est perdu - a reintroduire
## (ex: raycast oeil -> cible, ou re-projection si un obstacle est touche) si le decor futur
## ajoute des obstacles hauts pres de la camera.
class_name CameraRig
extends Node3D

@onready var camera: Camera3D = $Camera3D

## Cible suivie (le joueur). Assignee par player.gd, meme pattern que MovementComponent.body.
@export var target: Node3D

## -- Cadrage "suivi" --
## Inclinaison fixe de la camera, en degres sous l'horizontale. ~35-40 = vue "Animal Crossing"
## (montre bien les visages/facades des futurs modeles) ; plus proche de 90 = vue du dessus pure
## (moins flatteuse pour du decor 3D, aplati en silhouettes).
@export var pitch_degrees: float = 40.0
## Direction horizontale (degres, autour de Y) d'ou vient la camera par rapport au joueur. A
## retoucher si le cadrage de depart semble "a l'envers" par rapport a la disposition du decor.
@export var heading_degrees: float = 0.0
## Distance de la camera au point vise en mode suivi.
@export var distance: float = 9.0
## Hauteur du point vise au-dessus de l'origine de la cible (le CharacterBody3D a son origine
## aux pieds) : vise a peu pres la poitrine/tete plutot que le sol.
@export var pivot_height: float = 1.2
## Vitesse de rattrapage de la camera vers sa position visee en mode suivi (plus haut = plus
## reactif/moins de retard visible). Une camera trop "molle" peut donner le mal des transports
## a de jeunes joueurs.
@export var follow_speed: float = 10.0

## -- Cadrage "activation" --
## Hauteur du regard en mode activation (hauteur d'yeux/poitrine) : volontairement plate, pas de
## plongee, pour repondre a la demande "en face, sans angle haut".
@export var focus_eye_height: float = 1.5
## Distance minimale entre la camera et l'interactable en mode activation (garantit un cadrage
## resserre/zoome meme si le joueur est deja tres proche de l'interactable au moment du E).
@export var focus_min_distance: float = 4.0
## Marge ajoutee au-dela de la distance joueur<->interactable, pour que la camera se place assez
## en retrait du joueur et garde les deux dans le cadre.
@export var focus_back_margin: float = 2.0
## Poids du point vise entre l'interactable (0.0) et le joueur (1.0) en mode activation :
## legerement cote interactable pour qu'il reste le sujet principal du cadrage.
@export_range(0.0, 1.0) var focus_look_weight: float = 0.35
## Vitesse de transition vers/depuis le cadrage active (plus lente que follow_speed : effet
## "travelling" volontaire plutot qu'un saut brusque de camera).
@export var focus_transition_speed: float = 4.0

var _current_interactable: Node3D
var _is_focused: bool = false
var _eye: Vector3
var _look_at: Vector3

func _ready() -> void:
	EventBus.interactable_focused.connect(_on_interactable_focused)
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	PlayerInputLock.lock_changed.connect(_on_lock_changed)

## A appeler juste apres avoir assigne "target" (voir player.gd) : positionne la camera
## directement sur le joueur sans le lerp de suivi habituel. Necessaire car les enfants sont
## _ready() avant leur parent dans Godot - au moment ou CameraRig._ready() tourne, Player._ready()
## n'a pas encore eu la chance d'assigner "target".
func snap_to_target() -> void:
	if target == null:
		return
	_eye = _follow_eye()
	_look_at = _follow_look_at()
	_apply_camera_transform()

func _process(delta: float) -> void:
	if target == null:
		return
	var desired_eye: Vector3
	var desired_look_at: Vector3
	var speed: float
	if _is_focused and _current_interactable:
		desired_eye = _focus_eye()
		desired_look_at = _focus_look_at()
		speed = focus_transition_speed
	else:
		desired_eye = _follow_eye()
		desired_look_at = _follow_look_at()
		speed = follow_speed
	var t := clampf(speed * delta, 0.0, 1.0)
	_eye = _eye.lerp(desired_eye, t)
	_look_at = _look_at.lerp(desired_look_at, t)
	_apply_camera_transform()

func _apply_camera_transform() -> void:
	camera.global_position = _eye
	if _eye.distance_squared_to(_look_at) > 0.0001:
		camera.look_at(_look_at, Vector3.UP)

## -- Cadrage suivi : position/orientation constantes par rapport a la cible (jamais de rotation
## en reponse au deplacement), seule la position de la cible fait glisser la camera. --
func _follow_look_at() -> Vector3:
	return target.global_position + Vector3(0.0, pivot_height, 0.0)

func _follow_eye() -> Vector3:
	var pitch := deg_to_rad(pitch_degrees)
	var heading := deg_to_rad(heading_degrees)
	var horizontal := Vector3(sin(heading), 0.0, cos(heading)) * distance * cos(pitch)
	var vertical := distance * sin(pitch)
	return _follow_look_at() + horizontal + Vector3(0.0, vertical, 0.0)

## -- Cadrage activation : camera alignee sur l'axe interactable -> joueur (le joueur doit
## forcement s'approcher de l'interactable pour l'activer, donc cet axe donne une direction
## "de face" raisonnable sans qu'aucun interactable n'ait besoin de definir sa propre orientation
## "avant"), a hauteur d'yeux, positionnee au-dela du joueur pour garder les deux dans le cadre. --
func _focus_axis() -> Vector3:
	var to_player := target.global_position - _current_interactable.global_position
	to_player.y = 0.0
	if to_player.length_squared() < 0.0001:
		return Vector3.BACK
	return to_player.normalized()

func _focus_look_at() -> Vector3:
	var point := _current_interactable.global_position.lerp(target.global_position, focus_look_weight)
	return point + Vector3(0.0, focus_eye_height, 0.0)

func _focus_eye() -> Vector3:
	var axis := _focus_axis()
	var gap := _current_interactable.global_position.distance_to(target.global_position)
	var dist := maxf(focus_min_distance, gap + focus_back_margin)
	return _current_interactable.global_position + axis * dist + Vector3(0.0, focus_eye_height, 0.0)

## Suit en continu le dernier interactable en portee (avant meme l'appui sur E) : simple mise a
## jour de reference, ne deplace pas encore la camera (voir _on_lock_changed pour le moment ou
## le recadrage se declenche reellement).
func _on_interactable_focused(interactable: Node) -> void:
	_current_interactable = interactable as Node3D

func _on_interactable_unfocused(interactable: Node) -> void:
	if _current_interactable == interactable:
		_current_interactable = null

## PlayerInputLock se verrouille des qu'un panneau modal s'ouvre (question, dialogue, boutique...)
## - c'est-a-dire exactement quand une interaction "s'active" reellement (touche E), pas au simple
## passage a proximite. On recadre la camera a ce moment-la, mais uniquement si un interactable
## est bien a l'origine du verrouillage : le menu ou l'album ouverts via un bouton d'interface
## n'ont pas d'interactable associe, donc la camera reste simplement ou elle est (seul le flou,
## voir world_view_blur.gd, reagit dans ce cas). On revient au suivi normal quand le panneau ferme.
func _on_lock_changed(is_locked: bool) -> void:
	_is_focused = is_locked and _current_interactable != null
