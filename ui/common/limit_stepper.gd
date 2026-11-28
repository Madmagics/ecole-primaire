## Petit reglage "−  10  +" du controle parental (2026-11-28, demande de Steve : "les +/- sont bien
## par contre si appui long incremente vite, 5 par sec, appui court pour ajuster").
##
## Appui court : un seul pas, des que le bouton est enfonce (button_down, pas pressed, pour ne pas
## compter deux fois). Appui long : apres HOLD_DELAY_SECONDS sans relacher, la valeur avance de
## REPEAT_PER_SECOND pas par seconde jusqu'au relachement (button_up) - signaux de BaseButton
## verifies sur docs.godotengine.org (4.7 stable). Construit entierement en code (pas de .tscn) :
## un seul script reutilisable par toutes les lignes de la fenetre Controle parental.
##
## Securite : si le doigt glisse hors du bouton (defilement de la fenetre au tactile), le bouton
## n'est plus dessine "enfonce" (get_draw_mode) et la repetition s'arrete d'elle-meme, meme si
## button_up n'arrive jamais.
class_name LimitStepper
extends HBoxContainer

signal value_changed(value: int)

const HOLD_DELAY_SECONDS := 0.4
const REPEAT_PER_SECOND := 5.0

var min_value := 1
var max_value := 50
var value := 10:
	set(new_value):
		value = clampi(new_value, min_value, max_value)
		if _value_label:
			_value_label.text = str(value)

var _minus_button: Button
var _plus_button: Button
var _value_label: Label
var _delay_timer: Timer
var _repeat_timer: Timer
## Bouton actuellement maintenu (null si aucun) et sens du pas (+1 ou -1).
var _held_button: Button
var _held_step := 0

func _init() -> void:
	add_theme_constant_override("separation", 6)
	_minus_button = _make_button("-")
	_value_label = Label.new()
	_value_label.custom_minimum_size = Vector2(44, 0)
	_value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_value_label.theme_type_variation = &"TitleLabel"
	_value_label.text = str(value)
	_plus_button = _make_button("+")
	add_child(_minus_button)
	add_child(_value_label)
	add_child(_plus_button)

	_delay_timer = Timer.new()
	_delay_timer.one_shot = true
	_delay_timer.wait_time = HOLD_DELAY_SECONDS
	_delay_timer.timeout.connect(_on_delay_timeout)
	add_child(_delay_timer)
	_repeat_timer = Timer.new()
	_repeat_timer.wait_time = 1.0 / REPEAT_PER_SECOND
	_repeat_timer.timeout.connect(_on_repeat_timeout)
	add_child(_repeat_timer)

	_minus_button.button_down.connect(_on_button_down.bind(_minus_button, -1))
	_plus_button.button_down.connect(_on_button_down.bind(_plus_button, 1))
	_minus_button.button_up.connect(_stop_hold)
	_plus_button.button_up.connect(_stop_hold)
	visibility_changed.connect(_stop_hold)
	tree_exiting.connect(_stop_hold)

## Fixe bornes et valeur d'un coup, sans emettre value_changed (valeur initiale lue du reglage).
func setup(new_min: int, new_max: int, new_value: int) -> void:
	min_value = new_min
	max_value = new_max
	value = new_value

func _make_button(label: String) -> Button:
	var button := Button.new()
	button.text = label
	button.custom_minimum_size = Vector2(44, 40)
	button.focus_mode = Control.FOCUS_NONE
	return button

func _on_button_down(button: Button, step: int) -> void:
	_held_button = button
	_held_step = step
	_apply_step()
	_repeat_timer.stop()
	_delay_timer.start()

func _on_delay_timeout() -> void:
	if _still_held():
		_repeat_timer.start()
	else:
		_stop_hold()

func _on_repeat_timeout() -> void:
	if _still_held():
		_apply_step()
	else:
		_stop_hold()

func _still_held() -> bool:
	if _held_button == null:
		return false
	var mode := _held_button.get_draw_mode()
	return mode == BaseButton.DRAW_PRESSED or mode == BaseButton.DRAW_HOVER_PRESSED

func _stop_hold() -> void:
	_held_button = null
	_held_step = 0
	if _delay_timer:
		_delay_timer.stop()
	if _repeat_timer:
		_repeat_timer.stop()

func _apply_step() -> void:
	var before := value
	value = value + _held_step
	if value != before:
		value_changed.emit(value)
	elif _held_step != 0:
		## Borne atteinte : inutile de continuer a repeter.
		_repeat_timer.stop()
