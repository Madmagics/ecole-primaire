## Racine d'un PNJ : assemble InteractableComponent + QuestionGiverComponent par composition.
## Un PNJ de maths et un PNJ de francais partagent cette meme scene, seules les ressources
## (question_pool, subject) exportees dans l'inspecteur changent.
class_name NPC
extends CharacterBody3D

@onready var question_giver: QuestionGiverComponent = $QuestionGiverComponent

func _ready() -> void:
	add_to_group("npc")


func display_question(question: QuestionResource) -> void:
	pass # Replace with function body.
