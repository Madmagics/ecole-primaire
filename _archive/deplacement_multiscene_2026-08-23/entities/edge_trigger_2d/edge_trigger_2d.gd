## Bord d'ecran automatique entre 2 scenes exterieures voisines (voir project_multi_scene_split en
## memoire) : contrairement a Signpost2D (appui sur la touche interagir), ce declencheur change de
## scene DES QUE le joueur entre dans la zone, comme un bord d'ecran classique de plateforme a
## scenes multiples. Place aux extremites horizontales des scenes qui ont un voisin lateral
## (ecole exterieure <-> boutique <-> cirque) - jamais a la porte de l'ecole, qui reste un
## Signpost2D avec une entree "au centre" (voir SceneTransition pour le detail de la distinction).
class_name EdgeTrigger2D
extends Area2D

## Scene chargee automatiquement a l'entree du joueur dans cette zone.
@export_file("*.tscn") var target_scene_path: String = ""
## Bord de la scene SUIVANTE ou le joueur doit apparaitre : LEFT si ce declencheur est au bord
## DROIT de la scene actuelle (le joueur sort a droite -> apparait a gauche de la suivante), RIGHT
## dans le cas inverse. Voir Player2D._apply_pending_entry_edge pour la lecture cote arrivee.
@export var entry_edge: SceneEdge.Edge = SceneEdge.Edge.NONE

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if target_scene_path.is_empty():
		push_warning("EdgeTrigger2D sans target_scene_path : %s" % get_path())
		return
	SceneTransition.go_to_scene(target_scene_path, entry_edge)
