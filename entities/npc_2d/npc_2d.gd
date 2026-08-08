## Racine d'un PNJ 2D : twin de npc.gd (version 3D, conservee intacte) - assemble
## InteractableComponent2D + QuestionGiverComponent par composition. QuestionGiverComponent est
## REUTILISE tel quel (voir entities/npc/components/question_giver_component.gd, qui sait
## maintenant gerer un InteractableComponent2D et une capsule 2D en plus des versions 3D).
class_name NPC2D
extends CharacterBody2D

@onready var question_giver: QuestionGiverComponent = $QuestionGiverComponent

func _ready() -> void:
	add_to_group("npc")
