## Clavier virtuel "version jeu" (2026-09-27, retour utilisateur : trop de problemes avec le clavier
## natif des smartphones/tablettes - il ne s'affiche pas en plein ecran sur le Web, voir issue moteur
## github.com/godotengine/godot #117342, et le contournement "sortir du plein ecran le temps de la
## saisie" etait instable). Ce clavier remplace completement le clavier natif sur les ecrans
## tactiles : AZERTY + ligne de chiffres + @ . - _ (strict minimum pour e-mail/identifiant, pas
## d'accents ni de variantes, choix utilisateur).
##
## Fonctionnement (autoload, aucun branchement a faire dans les panneaux) :
## - Viewport.gui_focus_changed (docs.godotengine.org/en/4.7/classes/class_viewport.html) previent
##   a chaque prise de focus : si c'est une LineEdit editable, le clavier s'affiche pour elle. Tout
##   champ ajoute plus tard dans le jeu en profite donc automatiquement.
## - LineEdit.virtual_keyboard_enabled = false sur ce champ pour que le clavier natif ne s'ouvre
##   jamais par-dessus (en plus de html/experimental_virtual_keyboard=false dans l'export Web).
## - Chaque touche est un Button en FOCUS_NONE : le toucher ne vole jamais le focus a la LineEdit
##   (viewport.cpp 4.7 : un clic sur un Control non focusable a mouse_filter STOP n'y touche pas).
## - La frappe est injectee via Input.parse_input_event(InputEventKey) plutot qu'en modifiant
##   LineEdit.text : exactement le meme chemin qu'un vrai clavier, donc text_changed (suggestions de
##   pseudos du formulaire de connexion) et max_length marchent sans rien changer dans les panneaux
##   existants. Seule exception : OK (voir _on_ok_pressed).
## - Mode "saisie isolee" (2026-09-27, 2e retour utilisateur : le clavier occupe la moitie basse de
##   l'ecran et masquait les cases situees en bas des formulaires) : tout l'ecran derriere est
##   floute (meme shader que les menus, icon_dock_blur.gdshader) et une copie de la case, avec son
##   descriptif a cote, est affichee centree au-dessus du clavier. Le vrai champ garde le focus et
##   recoit la frappe ; la copie ne fait que l'afficher (points si LineEdit.secret). Toucher le fond
##   floute = Fermer. Descriptif : voir _describe().
## - Suggestions (2026-09-27, 3e retour utilisateur) : un panneau peut proposer des mots a
##   completer (ex: pseudos deja utilises sur l'appareil, voir welcome_panel.gd) via 2 metas sur la
##   LineEdit, SUGGESTIONS_META et SUGGESTION_CHOSEN_META (voir _refresh_suggestions()). Elles
##   s'affichent en une ligne horizontale de boutons juste AU-DESSUS du clavier, superposee a la
##   zone floutee : la carte de la case reste a sa place, rien n'est pousse vers le haut.
##
## Affiche UNIQUEMENT si DisplayServer.is_touchscreen_available() (Android/iOS, ou ecran tactile
## detecte par le navigateur sur le Web) - sur PC souris + clavier physique, rien ne change.
extends CanvasLayer

## Au-dessus de toutes les fenetres du jeu (CanvasLayer "UI" de game_ui.tscn = couche 1).
const LAYER := 100
const KEY_HEIGHT := 50.0
const KEY_SPACING := 6
const KEY_FONT_SIZE := 26
const PREVIEW_FONT_SIZE := 30
const DESCRIPTION_FONT_SIZE := 26
const SECRET_CHAR := "•"
const CARET_CHAR := "|"
## Largeur mini de la copie de la case (sur 1152 de large), assez pour une adresse e-mail entiere.
const PREVIEW_MIN_WIDTH := 520.0
## Au-dela, le descriptif passe AU-DESSUS de la case plutot qu'a cote (enonce de question, consigne
## du code parental...), avec retour a la ligne dans LONG_DESCRIPTION_WIDTH.
const SIDE_DESCRIPTION_MAX_CHARS := 30
const LONG_DESCRIPTION_WIDTH := 760.0
## Descriptif impose par un panneau quand la case n'a pas de Label voisin exploitable :
## line_edit.set_meta(GameKeyboard.DESCRIPTION_META, "...") - voir _describe().
const DESCRIPTION_META := &"keyboard_description"
## Callable(texte_actuel: String) -> Array[String] : les suggestions a afficher pour ce texte
## (tableau vide = aucune). Rappelee a chaque changement du texte.
const SUGGESTIONS_META := &"keyboard_suggestions"
## Callable(suggestion: String) optionnelle, appelee quand l'enfant touche une suggestion. Absente :
## le clavier remplace simplement le texte du champ par la suggestion.
const SUGGESTION_CHOSEN_META := &"keyboard_suggestion_chosen"
const SUGGESTION_HEIGHT := 46.0
const SUGGESTION_FONT_SIZE := 24
const BLUR_SHADER := preload("res://ui/game_menu/icon_dock_blur.gdshader")
## Meme reglage que NpcBlurBG (game_ui.tscn) : flou 2 + voile noir 40 %.
const BLUR_AMOUNT := 2.0
const BLUR_TINT := Color(0, 0, 0, 0.4)

## Rangees de touches caractere. Les touches speciales (Maj, effacer, Fermer, espace, OK) sont
## ajoutees dans _build_ui(). Largeurs relatives via size_flags_stretch_ratio : chaque rangee
## totalise 10 unites pour que toutes les touches lettres aient la meme largeur.
const ROW_DIGITS := "1234567890"
const ROW_TOP := "azertyuiop"
const ROW_MIDDLE := "qsdfghjklm"
const ROW_BOTTOM := "wxcvbn"

enum ShiftState { OFF, ONCE, LOCKED }

var _target: LineEdit = null
var _shift: ShiftState = ShiftState.OFF
var _letter_buttons: Array[Button] = []
var _shift_button: Button
var _root: Control
var _panel: PanelContainer
var _card: PanelContainer
var _card_box: BoxContainer
var _description_label: Label
var _preview_panel: PanelContainer
var _preview_label: Label
var _suggestions_row: HBoxContainer
## Texte pour lequel la ligne de suggestions a ete calculee (evite de reconstruire les boutons a
## chaque image, seulement quand le texte change).
var _suggestions_for_text: String = ""

func _ready() -> void:
	layer = LAYER
	## _process ne tourne que clavier ouvert (voir _on_gui_focus_changed) - coupe ici des le depart,
	## sinon il tournerait aussi sur PC ou le clavier n'est jamais construit (_root null).
	set_process(false)
	if not DisplayServer.is_touchscreen_available():
		return
	_build_ui()
	## Meme mecanique de theme que les autres fenetres (voir quit_overlay.gd) : un CanvasLayer coupe
	## la propagation automatique du Theme depuis la racine.
	_apply_theme(SaveManager.THEMES[SaveManager.ui_theme])
	EventBus.ui_theme_changed.connect(_apply_theme)
	get_viewport().gui_focus_changed.connect(_on_gui_focus_changed)
	_close()

## Tant que le clavier est ouvert : se referme tout seul si le champ disparait (fenetre fermee,
## deconnexion...) ou perd le focus, et garde l'apercu a jour.
func _process(_delta: float) -> void:
	if not is_instance_valid(_target) or not _target.is_visible_in_tree() or not _target.has_focus():
		_close()
		return
	_update_preview()
	if _target.text != _suggestions_for_text:
		_refresh_suggestions()

func _on_gui_focus_changed(node: Control) -> void:
	var line_edit := node as LineEdit
	if line_edit == null or not line_edit.editable:
		_close()
		return
	_target = line_edit
	_target.virtual_keyboard_enabled = false
	_set_shift(ShiftState.OFF)
	_show_description(_describe(line_edit))
	_root.show()
	set_process(true)
	_update_preview()
	_refresh_suggestions()

## true si le clavier du jeu remplace le clavier natif sur cet appareil - permet a un panneau de
## ne pas afficher sa propre liste de suggestions (elle serait cachee sous le flou).
func is_enabled() -> bool:
	return _root != null

func _close() -> void:
	_target = null
	if _root == null:
		return
	_root.hide()
	set_process(false)

## Copie de la case : texte (ou points) + curseur a sa position reelle ; indication grisee du champ
## (placeholder_text) tant qu'il est vide.
func _update_preview() -> void:
	var text := _target.text
	if text.is_empty() and not _target.placeholder_text.is_empty():
		_preview_label.text = _target.placeholder_text
		_preview_label.modulate.a = 0.5
		return
	var shown := SECRET_CHAR.repeat(text.length()) if _target.secret else text
	var caret := clampi(_target.caret_column, 0, shown.length())
	_preview_label.text = shown.left(caret) + CARET_CHAR + shown.substr(caret)
	_preview_label.modulate.a = 1.0

## Descriptif affiche a cote de la copie, par ordre de priorite :
## 1. meta DESCRIPTION_META posee par le panneau (enonce de la question, code parental a recopier -
##    textes dynamiques caches sous le flou, voir question_panel.gd/parental_gate_overlay.gd) ;
## 2. le Label voisin dans la meme rangee HBoxContainer - convention de tous les formulaires du
##    jeu (LoginRow = LoginLabel "Pseudo" + LoginInput...), aucun branchement a faire ;
## 3. rien (la copie garde alors son placeholder_text grise comme indication).
func _describe(line_edit: LineEdit) -> String:
	if line_edit.has_meta(DESCRIPTION_META):
		return str(line_edit.get_meta(DESCRIPTION_META))
	var row := line_edit.get_parent() as HBoxContainer
	if row != null:
		for child in row.get_children():
			if child is Label:
				return (child as Label).text
	return ""

## Descriptif court = a gauche de la case ; long = au-dessus, sur plusieurs lignes.
func _show_description(description: String) -> void:
	_description_label.text = description
	_description_label.visible = not description.is_empty()
	var is_long := description.length() > SIDE_DESCRIPTION_MAX_CHARS
	_card_box.vertical = is_long
	_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART if is_long else TextServer.AUTOWRAP_OFF
	_description_label.custom_minimum_size.x = LONG_DESCRIPTION_WIDTH if is_long else 0.0
	_description_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER if is_long else HORIZONTAL_ALIGNMENT_RIGHT

# --- Frappe -------------------------------------------------------------------------------------

func _type_char(character: String) -> void:
	var to_type := character
	if _shift != ShiftState.OFF:
		to_type = character.to_upper()
	_send_key(KEY_NONE, to_type.unicode_at(0))
	if _shift == ShiftState.ONCE:
		_set_shift(ShiftState.OFF)

func _on_backspace_pressed() -> void:
	_send_key(KEY_BACKSPACE, 0)

## OK = touche Entree : emet LineEdit.text_submitted (connexion, reponse...) puis referme le
## clavier. Emis directement plutot qu'injecte via parse_input_event : les evenements injectes sont
## mis en tampon jusqu'a l'image suivante (Input.use_accumulated_input, actif par defaut - voir
## core/input/input.cpp 4.7), l'Entree arriverait donc APRES le release_focus() ci-dessous et serait
## perdue. Les lettres, elles, n'ont pas ce probleme (le champ garde le focus). Si le panneau
## redonne le focus au champ juste apres (QuestionPanel, question suivante), gui_focus_changed
## rouvre le clavier automatiquement.
func _on_ok_pressed() -> void:
	var line_edit := _target
	_close()
	if not is_instance_valid(line_edit):
		return
	line_edit.release_focus()
	line_edit.text_submitted.emit(line_edit.text)

## Reconstruit la ligne de suggestions pour le texte actuel du champ (voir SUGGESTIONS_META).
func _refresh_suggestions() -> void:
	_suggestions_for_text = _target.text
	for child in _suggestions_row.get_children():
		child.queue_free()
	var suggestions: Array = []
	if _target.has_meta(SUGGESTIONS_META):
		suggestions = (_target.get_meta(SUGGESTIONS_META) as Callable).call(_target.text)
	## Une suggestion identique au texte deja tape n'apporte rien : on la retire.
	suggestions = suggestions.filter(func(suggestion: String) -> bool:
		return suggestion.to_lower() != _target.text.to_lower())
	for suggestion: String in suggestions:
		var button := Button.new()
		button.text = suggestion
		button.focus_mode = Control.FOCUS_NONE
		button.custom_minimum_size.y = SUGGESTION_HEIGHT
		button.add_theme_font_size_override("font_size", SUGGESTION_FONT_SIZE)
		button.pressed.connect(_on_suggestion_pressed.bind(suggestion))
		_suggestions_row.add_child(button)
	_suggestions_row.visible = not suggestions.is_empty()

func _on_suggestion_pressed(suggestion: String) -> void:
	var line_edit := _target
	if line_edit.has_meta(SUGGESTION_CHOSEN_META):
		## Le panneau decide de la suite (ex: connexion -> passe au mot de passe ; le changement de
		## focus met a jour le clavier tout seul).
		(line_edit.get_meta(SUGGESTION_CHOSEN_META) as Callable).call(suggestion)
	else:
		line_edit.text = suggestion
		line_edit.caret_column = suggestion.length()
	if _target == line_edit:
		_refresh_suggestions()

## Toucher le fond floute = Fermer.
func _on_blur_gui_input(event: InputEvent) -> void:
	var click := event as InputEventMouseButton
	if click != null and click.pressed and click.button_index == MOUSE_BUTTON_LEFT:
		_on_close_pressed()

func _on_close_pressed() -> void:
	if is_instance_valid(_target):
		_target.release_focus()
	_close()

## Maj : un appui = une seule majuscule, deuxieme appui = verrouille (pratique pour le code
## parental tout en majuscules), troisieme appui = retour en minuscules.
func _on_shift_pressed() -> void:
	match _shift:
		ShiftState.OFF:
			_set_shift(ShiftState.ONCE)
		ShiftState.ONCE:
			_set_shift(ShiftState.LOCKED)
		ShiftState.LOCKED:
			_set_shift(ShiftState.OFF)

func _set_shift(state: ShiftState) -> void:
	_shift = state
	for button in _letter_buttons:
		var letter: String = button.get_meta(&"char")
		button.text = letter.to_upper() if state != ShiftState.OFF else letter
	_shift_button.text = "MAJ" if state == ShiftState.LOCKED else "Maj"
	_shift_button.button_pressed = state != ShiftState.OFF

## Injecte un appui + relachement comme un vrai clavier (voir commentaire de classe).
func _send_key(keycode: Key, unicode: int) -> void:
	for pressed: bool in [true, false]:
		var event := InputEventKey.new()
		event.pressed = pressed
		event.keycode = keycode
		event.physical_keycode = keycode
		if pressed:
			event.unicode = unicode
		Input.parse_input_event(event)

# --- Construction de l'interface ---------------------------------------------------------------

func _build_ui() -> void:
	_root = Control.new()
	_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_root)

	## Fond floute plein ecran : cache le reste du jeu ET bloque les touchers (saisie modale).
	var blur := ColorRect.new()
	blur.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var blur_material := ShaderMaterial.new()
	blur_material.shader = BLUR_SHADER
	blur_material.set_shader_parameter(&"blur_amount", BLUR_AMOUNT)
	blur_material.set_shader_parameter(&"tint_color", BLUR_TINT)
	blur.material = blur_material
	blur.gui_input.connect(_on_blur_gui_input)
	_root.add_child(blur)

	## Colonne plein ecran : zone de la case (tout l'espace restant) puis clavier en bas. Les deux
	## conteneurs laissent passer les touchers (IGNORE) jusqu'au fond floute.
	var layout := VBoxContainer.new()
	layout.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layout.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layout.add_theme_constant_override("separation", 0)
	_root.add_child(layout)

	## Zone au-dessus du clavier : la carte centree ET, par-dessus, la ligne de suggestions collee
	## en bas. Deux enfants independants d'un simple Control (pas un conteneur) : la ligne de
	## suggestions n'influe jamais sur la position de la carte.
	var upper_area := Control.new()
	upper_area.size_flags_vertical = Control.SIZE_EXPAND_FILL
	upper_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layout.add_child(upper_area)

	var field_area := CenterContainer.new()
	field_area.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	field_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	upper_area.add_child(field_area)

	_suggestions_row = HBoxContainer.new()
	_suggestions_row.anchor_left = 0.0
	_suggestions_row.anchor_right = 1.0
	_suggestions_row.anchor_top = 1.0
	_suggestions_row.anchor_bottom = 1.0
	_suggestions_row.offset_left = 8.0
	_suggestions_row.offset_right = -8.0
	_suggestions_row.offset_bottom = -8.0
	_suggestions_row.grow_vertical = Control.GROW_DIRECTION_BEGIN
	_suggestions_row.alignment = BoxContainer.ALIGNMENT_CENTER
	_suggestions_row.add_theme_constant_override("separation", KEY_SPACING * 2)
	_suggestions_row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_suggestions_row.hide()
	upper_area.add_child(_suggestions_row)

	_card = PanelContainer.new()
	field_area.add_child(_card)
	var card_margin := MarginContainer.new()
	for side: String in ["left", "right", "top", "bottom"]:
		card_margin.add_theme_constant_override("margin_" + side, 16)
	_card.add_child(card_margin)
	_card_box = BoxContainer.new()
	_card_box.alignment = BoxContainer.ALIGNMENT_CENTER
	_card_box.add_theme_constant_override("separation", 14)
	card_margin.add_child(_card_box)

	_description_label = Label.new()
	_description_label.add_theme_font_size_override("font_size", DESCRIPTION_FONT_SIZE)
	_description_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_card_box.add_child(_description_label)

	_preview_panel = PanelContainer.new()
	_preview_panel.custom_minimum_size.x = PREVIEW_MIN_WIDTH
	_card_box.add_child(_preview_panel)
	_preview_label = Label.new()
	_preview_label.add_theme_font_size_override("font_size", PREVIEW_FONT_SIZE)
	_preview_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_preview_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_preview_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_CHAR
	_preview_label.clip_text = true
	_preview_panel.add_child(_preview_label)

	_panel = PanelContainer.new()
	layout.add_child(_panel)

	var margin := MarginContainer.new()
	for side: String in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 8)
	_panel.add_child(margin)

	var rows := VBoxContainer.new()
	rows.add_theme_constant_override("separation", KEY_SPACING)
	margin.add_child(rows)

	_add_char_row(rows, ROW_DIGITS)
	_add_char_row(rows, ROW_TOP)
	_add_char_row(rows, ROW_MIDDLE)

	var bottom := _new_row(rows)
	_shift_button = _new_key(bottom, "Maj", 2.0, _on_shift_pressed)
	_shift_button.toggle_mode = true
	for character in ROW_BOTTOM:
		_add_char_key(bottom, character)
	_new_key(bottom, "⌫", 2.0, _on_backspace_pressed)

	var last := _new_row(rows)
	_new_key(last, "Fermer", 1.5, _on_close_pressed)
	_add_char_key(last, "@")
	_add_char_key(last, ".")
	_new_key(last, "espace", 3.0, _type_char.bind(" "))
	_add_char_key(last, "-")
	_add_char_key(last, "_")
	_new_key(last, "OK", 1.5, _on_ok_pressed)

## Fond du clavier et de la carte = style des fenetres (Panel), fond de la copie = style "normal"
## des LineEdit du theme courant pour qu'elle ressemble a une case de saisie. Reapplique a chaque
## changement de theme.
func _apply_theme(new_theme: Theme) -> void:
	_root.theme = new_theme
	if new_theme.has_stylebox(&"panel", &"Panel"):
		var panel_style := new_theme.get_stylebox(&"panel", &"Panel")
		_panel.add_theme_stylebox_override("panel", panel_style)
		_card.add_theme_stylebox_override("panel", panel_style)
	if new_theme.has_stylebox(&"normal", &"LineEdit"):
		_preview_panel.add_theme_stylebox_override("panel", new_theme.get_stylebox(&"normal", &"LineEdit"))

func _add_char_row(parent: Container, characters: String) -> void:
	var row := _new_row(parent)
	for character in characters:
		_add_char_key(row, character)

func _add_char_key(row: HBoxContainer, character: String) -> void:
	var button := _new_key(row, character, 1.0, _type_char.bind(character))
	if character.to_upper() != character:
		button.set_meta(&"char", character)
		_letter_buttons.append(button)

func _new_row(parent: Container) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", KEY_SPACING)
	parent.add_child(row)
	return row

func _new_key(row: HBoxContainer, label: String, width_ratio: float, on_pressed: Callable) -> Button:
	var button := Button.new()
	button.text = label
	## Ne vole jamais le focus a la LineEdit en cours de saisie (voir commentaire de classe).
	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size.y = KEY_HEIGHT
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_stretch_ratio = width_ratio
	button.add_theme_font_size_override("font_size", KEY_FONT_SIZE)
	button.pressed.connect(on_pressed)
	row.add_child(button)
	return button
