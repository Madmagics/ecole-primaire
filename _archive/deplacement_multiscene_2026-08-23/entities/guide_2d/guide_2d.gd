## Racine du PNJ guide : meme principe de composition que npc_2d.gd, mais avec GuideComponent
## (aide/tuto statique) au lieu de QuestionGiverComponent (questions de classe). Un seul guide par
## partie pour l'instant (scene ecole exterieure, voir project_scene_split en memoire) - pas de
## groupe "npc" partage avec les PNJ de questions, ce n'est pas le meme role.
class_name Guide2D
extends Node2D

@onready var guide: GuideComponent = $GuideComponent

func _ready() -> void:
	add_to_group("guide")
