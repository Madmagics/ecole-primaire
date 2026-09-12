## Panneau indicateur 2D : declenche un changement de scene complet (SceneTree.change_scene_to_file)
## a l'interaction, plutot que d'ouvrir un panneau UI comme les PNJ/la boutique. Nouvelle brique du
## decoupage multi-scenes (ecole exterieure / ecole dediee / boutique / cirque, voir
## project_scene_split en memoire) : chaque zone est desormais un fichier .tscn independant reliee
## aux autres par ces panneaux, plutot qu'une seule grande scene a cameras multiples.
## Logique directement ici (pas de composant separe type QuestionGiverComponent) : contrairement
## aux PNJ/boutique, cette action ne depend d'aucun etat de jeu ni d'un panneau UI local a la scene,
## juste d'un chemin de scene fixe - un composant dedie n'apporterait aucune reutilisation en plus.
class_name Signpost2D
extends Node2D

## Scene chargee a l'interaction. Vide = panneau inactif (evite un crash si oublie en placeholder).
@export_file("*.tscn") var target_scene_path: String = ""

@onready var interactable: InteractableComponent2D = $InteractableComponent

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted(_who: Node) -> void:
	if target_scene_path.is_empty():
		push_warning("Signpost2D sans target_scene_path : %s" % get_path())
		return
	get_tree().change_scene_to_file(target_scene_path)
