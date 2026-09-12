## Autoload retenant, entre deux scenes, par quel bord le joueur doit apparaitre dans la scene
## suivante (voir entities/edge_trigger_2d et data/scene_edge.gd) - une sortie de scene par le bord
## droit doit faire apparaitre le joueur a GAUCHE de la scene voisine, et inversement (retour
## utilisateur 2026-08-10). Ne concerne QUE les bords automatiques entre scenes exterieures
## voisines (ecole exterieure / boutique / cirque) : la porte de l'ecole (Signpost2D, appui sur la
## touche interagir) appelle get_tree().change_scene_to_file() directement, jamais ce singleton,
## et garde donc une entree "au centre" (position par defaut de la scene, voir consume_entry_edge).
extends Node

var _pending_entry_edge: SceneEdge.Edge = SceneEdge.Edge.NONE

## Appele par EdgeTrigger2D a la place d'un get_tree().change_scene_to_file() direct.
func go_to_scene(scene_path: String, entry_edge: SceneEdge.Edge) -> void:
	_pending_entry_edge = entry_edge
	get_tree().change_scene_to_file(scene_path)

## A appeler UNE FOIS par Player2D._ready() : renvoie le bord a utiliser puis l'oublie, pour qu'un
## rechargement ulterieur de la meme scene (reload manuel, mort/respawn futur...) ne repositionne
## jamais le joueur a tort.
func consume_entry_edge() -> SceneEdge.Edge:
	var edge := _pending_entry_edge
	_pending_entry_edge = SceneEdge.Edge.NONE
	return edge
