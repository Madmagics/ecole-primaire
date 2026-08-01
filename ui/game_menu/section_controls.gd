## Section "Commandes" du menu de jeu : reassignation clavier. Une ligne (Label + Button) par
## action de SaveManager.REBINDABLE_ACTIONS, construite dynamiquement (meme pattern que
## SubjectSelectPanel pour ses boutons de matiere) plutot que codee en dur dans la scene, pour
## rester evolutif si REBINDABLE_ACTIONS change.
class_name SectionControls
extends Control

## Libelles lisibles pour les actions reassignables (voir SaveManager.REBINDABLE_ACTIONS).
const ACTION_LABELS := {
	"move_left": "Aller à gauche",
	"move_right": "Aller à droite",
	"move_up": "Aller en haut",
	"move_down": "Aller en bas",
	"interact": "Interagir",
	"open_album": "Ouvrir le livre",
	"open_config": "Ouvrir Configuration",
	"open_save": "Ouvrir Sauvegarde",
	"open_controls": "Ouvrir Commandes",
	"open_stats": "Ouvrir Statistiques",
	"open_menu": "Ouvrir/fermer le menu",
}

@onready var rows_container: VBoxContainer = $VBoxContainer/ScrollContainer/RowsContainer

var _listening_action: String = ""
var _action_buttons: Dictionary = {} # action (String) -> Button

func _ready() -> void:
	for action in SaveManager.REBINDABLE_ACTIONS:
		_add_row(action)

func _add_row(action: String) -> void:
	var row := HBoxContainer.new()

	var label := Label.new()
	label.text = ACTION_LABELS.get(action, action)
	label.custom_minimum_size.x = 200
	## Sans ceci, le label garde la couleur de police blanche par defaut du theme (reservee aux
	## labels qui utilisent modulate pour coder une rarete/un resultat - voir CHARTE_GRAPHIQUE.md) :
	## illisible sur le fond creme des panneaux.
	label.theme_type_variation = &"TitleLabel"
	row.add_child(label)

	var button := Button.new()
	button.custom_minimum_size.x = 160
	button.pressed.connect(_on_rebind_button_pressed.bind(action))
	row.add_child(button)

	rows_container.add_child(row)
	_action_buttons[action] = button

func refresh() -> void:
	_listening_action = ""
	for action in _action_buttons.keys():
		_action_buttons[action].text = SaveManager.get_binding_label(action)

func _on_rebind_button_pressed(action: String) -> void:
	_listening_action = action
	_action_buttons[action].text = "Appuyez sur une touche..."

func _unhandled_key_input(event: InputEvent) -> void:
	if _listening_action == "":
		return
	if event is InputEventKey and event.pressed and not event.echo:
		var action := _listening_action
		_listening_action = ""
		SaveManager.rebind_action(action, event.physical_keycode)
		_action_buttons[action].text = SaveManager.get_binding_label(action)
		get_viewport().set_input_as_handled()
