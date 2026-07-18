## Composant PNJ : propose une question au hasard dans son pool quand le joueur interagit.
## La matiere et les questions sont des donnees (QuestionResource), pas du code : un PNJ de
## maths et un PNJ de francais utilisent exactement ce meme script avec des ressources differentes.
class_name QuestionGiverComponent
extends Node

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (SubjectType.Subject) ; on "importe" l'enum dans une const locale.
const Subject = SubjectType.Subject

signal question_started(question: QuestionResource)

@export var subject: Subject = Subject.MATH
@export var question_pool: Array[QuestionResource] = []

func _ready() -> void:
	var interactable := _find_sibling_interactable()
	if interactable:
		interactable.interacted.connect(_on_interacted)

func _find_sibling_interactable() -> InteractableComponent:
	for child in get_parent().get_children():
		if child is InteractableComponent:
			return child
	return null

func _on_interacted(_who: Node) -> void:
	if question_pool.is_empty():
		return
	var question: QuestionResource = question_pool.pick_random()
	question_started.emit(question)

## Appele par l'UI (QuestionPanel) une fois que le joueur a repondu.
func resolve_answer(question: QuestionResource, is_correct: bool) -> void:
	if is_correct:
		Economy.add_coins(question.subject, question.coin_reward)
	EventBus.question_answered.emit(question.subject, is_correct)
