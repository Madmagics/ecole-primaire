## Fenetre 2D generique pour poser une question : fonctionne pour toute matiere/question,
## le contenu vient entierement d'un QuestionResource passe en parametre.
## Saisie au clavier (numerique ou texte) + Entree pour valider, plutot que des boutons a choix.
class_name QuestionPanel
extends Control

signal answered(question: QuestionResource, is_correct: bool)

@onready var question_label: Label = $Panel/QuestionLabel
@onready var answer_input: LineEdit = $Panel/AnswerInput

var _current_question: QuestionResource

func _ready() -> void:
	answer_input.text_submitted.connect(_on_answer_submitted)

func display_question(question: QuestionResource) -> void:
	_current_question = question
	question_label.text = question.text
	answer_input.text = ""
	show()
	answer_input.grab_focus()

func _on_answer_submitted(new_text: String) -> void:
	if _current_question == null or new_text.strip_edges().is_empty():
		return
	var is_correct := _current_question.is_correct(new_text)
	answered.emit(_current_question, is_correct)
	hide()
