## Racine du joueur (plateformer 2D) : assemble les composants par composition, meme principe que
## player.gd (version 3D, conservee intacte). InteractorComponent est REUTILISE tel quel depuis
## entities/player/components/interactor_component.gd - il ne connait que des signaux/EventBus,
## aucune dependance 3D, donc aucune raison d'en dupliquer une copie 2D.
class_name Player2D
extends CharacterBody2D

@onready var movement: MovementComponent2D = $MovementComponent2D
@onready var interactor: InteractorComponent = $InteractorComponent
@onready var avatar_sprite: Sprite2D = $AvatarSprite

## Distance (en px) entre le joueur et le bord exact de la zone quand il apparait via un
## EdgeTrigger2D : jamais 0, sinon le joueur apparaitrait littéralement a cheval sur le
## EdgeTrigger2D voisin de la scene d'arrivee (meme bord, voir project_multi_scene_split) et
## repartirait aussitot dans l'autre sens (aller-retour infini).
const _EDGE_SPAWN_INSET := 70.0

func _ready() -> void:
	add_to_group("player")
	movement.body = self
	_apply_pending_entry_edge()
	_refresh_avatar_sprite()
	## Le joueur est deja instancie dans park_2d.tscn AVANT que WelcomePanel ne connecte ou cree un
	## compte (voir SaveManager._ready() : current_account_id vide au demarrage) - _ready() seul ne
	## verrait donc jamais l'avatar choisi. account_logged_in couvre a la fois la creation de compte
	## et un futur changement de compte (logout/login) sans avoir a redemarrer la scene.
	SaveManager.account_logged_in.connect(func(_profile: Dictionary) -> void: _refresh_avatar_sprite())

## Consomme le bord en attente (voir SceneTransition.consume_entry_edge) et repositionne le joueur
## en consequence : NONE laisse la position deja fixee dans la scene (.tscn) telle quelle - c'est
## le cas normal au lancement du jeu et pour toute entree "au centre" (porte de l'ecole, voir
## entities/signpost_2d, qui n'ecrit jamais dans SceneTransition).
func _apply_pending_entry_edge() -> void:
	match SceneTransition.consume_entry_edge():
		SceneEdge.Edge.LEFT:
			position.x = movement.zone_min_x + _EDGE_SPAWN_INSET
		SceneEdge.Edge.RIGHT:
			position.x = movement.zone_max_x - _EDGE_SPAWN_INSET

func _refresh_avatar_sprite() -> void:
	var avatar_id: String = String(SaveManager.get_current_profile().get("avatar", PlayerAvatars.DEFAULT_AVATAR_ID))
	avatar_sprite.texture = PlayerAvatars.get_texture(avatar_id)
