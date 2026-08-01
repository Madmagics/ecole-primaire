## Section "Sauvegarde" du menu de jeu : sauvegarder/charger manuellement, ou tout
## reinitialiser. Reinitialiser est destructif (pieces, cartes, stats perdues) donc protege par
## une confirmation en 2 clics plutot qu'une popup separee, pour rester leger (voir
## feedback_lightweight_game.md).
class_name SectionSave
extends Control

@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var load_button: Button = $VBoxContainer/LoadButton
@onready var reset_button: Button = $VBoxContainer/ResetButton
@onready var status_label: Label = $VBoxContainer/StatusLabel

var _reset_armed: bool = false
const RESET_LABEL_DEFAULT := "Tout réinitialiser"
const RESET_LABEL_CONFIRM := "Sûr ? Cliquer à nouveau pour confirmer"

func _ready() -> void:
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	reset_button.text = RESET_LABEL_DEFAULT

func refresh() -> void:
	_disarm_reset()
	status_label.text = ""
	load_button.disabled = not SaveManager.has_save()

func _on_save_pressed() -> void:
	SaveManager.save_game()
	_disarm_reset()
	status_label.text = "Partie sauvegardée."
	load_button.disabled = false

func _on_load_pressed() -> void:
	SaveManager.load_game()
	_disarm_reset()
	status_label.text = "Partie chargée."

func _on_reset_pressed() -> void:
	if not _reset_armed:
		_reset_armed = true
		reset_button.text = RESET_LABEL_CONFIRM
		return
	SaveManager.reset_progress()
	_disarm_reset()
	status_label.text = "Progression réinitialisée."
	load_button.disabled = true

func _disarm_reset() -> void:
	_reset_armed = false
	reset_button.text = RESET_LABEL_DEFAULT
