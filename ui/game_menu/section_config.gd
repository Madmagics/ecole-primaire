## Section "Configuration" du menu de jeu : volume musique, volume bruitages (2026-09-04,
## retour utilisateur : deux barres separees au lieu d'un volume general unique - voir
## SaveManager.music_volume/sfx_volume) et plein ecran. Applique immediatement (retour
## visuel/sonore instantane) mais n'ecrit sur le disque qu'au relachement du curseur / au
## changement de case, pour ne pas ecrire le fichier de sauvegarde a chaque frame pendant
## qu'on fait glisser un volume.
##
## Icone son/musique (2026-09-04, retour utilisateur : une icone a droite de chaque barre,
## icone_off a 0, icone_on de 1 a 100%, cliquer sur icone_on coupe le son et bascule sur
## icone_off) : utilise musique-on/off.webp et son-on/off.webp, deja fournis par
## l'utilisateur dans assets/classe2.0/icones/ (memes fichiers que le reste des icones du
## menu, voir project_ui_icons_integration en memoire). _music_volume_before_mute/
## _sfx_volume_before_mute retiennent la derniere valeur non nulle du curseur : un clic sur
## l'icone_off restaure cette valeur plutot que de rouvrir a 100% a chaque fois (comportement
## non precise explicitement par l'utilisateur mais necessaire pour que l'icone soit un vrai
## bouton bascule et non une coupure a sens unique).
class_name SectionConfig
extends Control

const _MUSIC_ICON_ON := preload("res://assets/classe2.0/icones/musique-on.webp")
const _MUSIC_ICON_OFF := preload("res://assets/classe2.0/icones/musique-off.webp")
const _SFX_ICON_ON := preload("res://assets/classe2.0/icones/son-on.webp")
const _SFX_ICON_OFF := preload("res://assets/classe2.0/icones/son-off.webp")

@onready var music_volume_slider: HSlider = $VBoxContainer/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $VBoxContainer/SfxVolumeSlider
@onready var music_mute_button: TextureButton = $VBoxContainer/MusicVolumeRow/MusicMuteButton
@onready var sfx_mute_button: TextureButton = $VBoxContainer/SfxVolumeRow/SfxMuteButton
@onready var fullscreen_check: CheckBox = $VBoxContainer/FullscreenCheck
@onready var theme_container: HBoxContainer = $VBoxContainer/ThemeContainer

var _music_volume_before_mute := 1.0
var _sfx_volume_before_mute := 1.0

## Un seul ButtonGroup pour les 4 vignettes : toggle_mode + button_group donne gratuitement le
## comportement "un seul choix actif a la fois" (comme des boutons radio), sans logique a la main.
var _theme_button_group := ButtonGroup.new()
var _theme_buttons: Dictionary = {} # id (String) -> Button

func _ready() -> void:
	for slider in [music_volume_slider, sfx_volume_slider]:
		slider.min_value = 0.0
		slider.max_value = 1.0
		slider.step = 0.01
	music_volume_slider.value_changed.connect(SaveManager.preview_music_volume)
	music_volume_slider.value_changed.connect(_update_music_icon)
	music_volume_slider.drag_ended.connect(_on_music_volume_drag_ended)
	sfx_volume_slider.value_changed.connect(SaveManager.preview_sfx_volume)
	sfx_volume_slider.value_changed.connect(_update_sfx_icon)
	sfx_volume_slider.drag_ended.connect(_on_sfx_volume_drag_ended)
	music_mute_button.pressed.connect(_on_music_mute_pressed)
	sfx_mute_button.pressed.connect(_on_sfx_mute_pressed)
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
	## Police reduite par rapport au reste de l'UI (18 par defaut dans ce menu depuis
	## menu_options_font.tres, voir game_menu_panel.tscn/ContentArea) pour laisser de la place au
	## retour a la ligne dans une vignette de taille compacte - valeur hardcodee (16) volontairement
	## laissee telle quelle, pas concernee par la reduction generale de police du 2026-08-25.
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", border)
	button.add_child(label)

	theme_container.add_child(button)
	_theme_buttons[id] = button

func refresh() -> void:
	music_volume_slider.value = SaveManager.music_volume
	sfx_volume_slider.value = SaveManager.sfx_volume
	## Au cas ou value_changed ne se serait pas declenche (valeur inchangee depuis la
	## derniere ouverture - Range.value ne re-emet pas si la valeur assignee est identique) :
	## garantit que les icones refletent toujours l'etat courant a l'ouverture du panneau.
	_update_music_icon(music_volume_slider.value)
	_update_sfx_icon(sfx_volume_slider.value)
	fullscreen_check.button_pressed = SaveManager.fullscreen
	for id in _theme_buttons.keys():
		_theme_buttons[id].button_pressed = (id == SaveManager.ui_theme)

func _on_music_volume_drag_ended(_value_changed: bool) -> void:
	SaveManager.set_music_volume(music_volume_slider.value)

func _on_sfx_volume_drag_ended(_value_changed: bool) -> void:
	SaveManager.set_sfx_volume(sfx_volume_slider.value)

## Reflete l'etat du curseur musique sur l'icone (icone_off a 0, icone_on de 1 a 100%) et
## retient la derniere valeur non nulle pour un futur clic de retablissement sur l'icone_off
## (voir _on_music_mute_pressed) - appele a chaque changement du curseur, glisse ou
## programmatique (voir refresh()), pas seulement au relachement.
func _update_music_icon(value: float) -> void:
	music_mute_button.texture_normal = _MUSIC_ICON_ON if value > 0.0 else _MUSIC_ICON_OFF
	if value > 0.0:
		_music_volume_before_mute = value

## Meme principe que _update_music_icon, pour le curseur bruitages.
func _update_sfx_icon(value: float) -> void:
	sfx_mute_button.texture_normal = _SFX_ICON_ON if value > 0.0 else _SFX_ICON_OFF
	if value > 0.0:
		_sfx_volume_before_mute = value

## Clic sur l'icone musique : coupe le son (curseur a 0) si actif, ou retablit la derniere
## valeur non nulle si deja coupe - sauvegarde immediatement (comme _on_music_volume_drag_
## ended), un clic etant une action ponctuelle, pas un glisse en cours.
func _on_music_mute_pressed() -> void:
	var new_value := 0.0 if music_volume_slider.value > 0.0 else _music_volume_before_mute
	music_volume_slider.value = new_value
	## Explicite plutot que de compter uniquement sur value_changed : Range n'emet pas ce
	## signal si la valeur assignee est identique a la valeur courante (cas degenere sans
	## consequence pratique ici, mais l'icone doit rester correcte quoi qu'il arrive).
	_update_music_icon(new_value)
	SaveManager.set_music_volume(new_value)

## Meme principe que _on_music_mute_pressed, pour l'icone bruitages.
func _on_sfx_mute_pressed() -> void:
	var new_value := 0.0 if sfx_volume_slider.value > 0.0 else _sfx_volume_before_mute
	sfx_volume_slider.value = new_value
	_update_sfx_icon(new_value)
	SaveManager.set_sfx_volume(new_value)
