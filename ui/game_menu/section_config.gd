## Section "Configuration" du menu de jeu : volume general et plein ecran. Applique
## immediatement (retour visuel/sonore instantane) mais n'ecrit sur le disque qu'au
## relachement du curseur / au changement de case, pour ne pas ecrire le fichier de
## sauvegarde a chaque frame pendant qu'on fait glisser le volume.
class_name SectionConfig
extends Control

@onready var volume_slider: HSlider = $VBoxContainer/VolumeSlider
@onready var fullscreen_check: CheckBox = $VBoxContainer/FullscreenCheck
@onready var theme_container: HBoxContainer = $VBoxContainer/ThemeContainer

## Un seul ButtonGroup pour les 4 vignettes : toggle_mode + button_group donne gratuitement le
## comportement "un seul choix actif a la fois" (comme des boutons radio), sans logique a la main.
var _theme_button_group := ButtonGroup.new()
var _theme_buttons: Dictionary = {} # id (String) -> Button

func _ready() -> void:
	volume_slider.min_value = 0.0
	volume_slider.max_value = 1.0
	volume_slider.step = 0.01
	volume_slider.value_changed.connect(SaveManager.preview_master_volume)
	volume_slider.drag_ended.connect(_on_volume_drag_ended)
	fullscreen_check.toggled.connect(SaveManager.set_fullscreen)
	## Construit les vignettes a partir de SaveManager.THEMES.keys() (pas code en dur) : un futur
	## theme ajoute a THEMES/THEME_PREVIEWS apparait ici sans toucher a cette scene.
	for id in SaveManager.THEMES.keys():
		_add_theme_swatch(id)

func _add_theme_swatch(id: String) -> void:
	var preview: Dictionary = SaveManager.THEME_PREVIEWS.get(id, {})
	var bg: Color = preview.get("bg", Color.WHITE)
	var border: Color = preview.get("border", Color.BLACK)
	var accent: Color = preview.get("accent", Color.GRAY)

	var normal_style := StyleBoxFlat.new()
	normal_style.bg_color = bg
	normal_style.border_color = border
	normal_style.border_width_left = 3
	normal_style.border_width_top = 3
	normal_style.border_width_right = 3
	normal_style.border_width_bottom = 3
	normal_style.corner_radius_top_left = 12
	normal_style.corner_radius_top_right = 12
	normal_style.corner_radius_bottom_right = 12
	normal_style.corner_radius_bottom_left = 12

	## Etat "selectionne" (pressed) : meme fond, contour plus epais et colore avec l'accent du
	## theme, pour reperer d'un coup d'oeil laquelle est active.
	var pressed_style := StyleBoxFlat.new()
	pressed_style.bg_color = bg
	pressed_style.border_color = accent
	pressed_style.border_width_left = 5
	pressed_style.border_width_top = 5
	pressed_style.border_width_right = 5
	pressed_style.border_width_bottom = 5
	pressed_style.corner_radius_top_left = 12
	pressed_style.corner_radius_top_right = 12
	pressed_style.corner_radius_bottom_right = 12
	pressed_style.corner_radius_bottom_left = 12

	var button := Button.new()
	button.custom_minimum_size = Vector2(120, 80)
	button.toggle_mode = true
	button.button_group = _theme_button_group
	## Le texte n'est pas porte par le Button lui-meme : Button ne supporte pas l'autowrap
	## (verifie sur le tracker Godot - une seule ligne, coupee sans retour a la ligne possible).
	## Un Label enfant avec autowrap + mouse_filter=IGNORE (laisse passer le clic au Button
	## parent) permet un vrai retour a la ligne pour les libelles longs ("Aventure tropicale").
	button.text = ""
	## Overrides locaux au bouton (pas le Theme global) : chaque vignette doit montrer SA PROPRE
	## palette en permanence, quel que soit le theme d'interface actuellement actif.
	button.add_theme_stylebox_override("normal", normal_style)
	button.add_theme_stylebox_override("hover", normal_style)
	button.add_theme_stylebox_override("pressed", pressed_style)
	button.add_theme_stylebox_override("hover_pressed", pressed_style)
	button.add_theme_stylebox_override("disabled", normal_style)
	button.pressed.connect(SaveManager.set_ui_theme.bind(id))

	var label := Label.new()
	label.text = preview.get("label", id)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	## Ancre/marges explicites plutot que set_anchors_and_offsets_preset() : pas d'ambiguite sur
	## le comportement du parametre resize_mode, meme convention que le reste du projet (Panel,
	## ContentArea...).
	label.anchor_left = 0.0
	label.anchor_top = 0.0
	label.anchor_right = 1.0
	label.anchor_bottom = 1.0
	label.offset_left = 8.0
	label.offset_top = 8.0
	label.offset_right = -8.0
	label.offset_bottom = -8.0
	## Police reduite d'un cran par rapport au reste de l'UI (20 par defaut) pour laisser de la
	## place au retour a la ligne dans une vignette de taille compacte.
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", border)
	button.add_child(label)

	theme_container.add_child(button)
	_theme_buttons[id] = button

func refresh() -> void:
	volume_slider.value = SaveManager.master_volume
	fullscreen_check.button_pressed = SaveManager.fullscreen
	for id in _theme_buttons.keys():
		_theme_buttons[id].button_pressed = (id == SaveManager.ui_theme)

func _on_volume_drag_ended(_value_changed: bool) -> void:
	SaveManager.set_master_volume(volume_slider.value)
