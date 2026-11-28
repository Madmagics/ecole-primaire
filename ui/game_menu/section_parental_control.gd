## Section "Contrôle parental" du menu de jeu (2026-09-04, retour utilisateur : "quand la case
## controle parental est cochee, on fera apparaitre une nouvelle icone dans le menu deplie a
## gauche... creer une fenetre sur la meme base que les autres fenetres de menu et apres on va y
## integrer des options"). Voir WelcomePanel.parental_control_check (case a cocher a la creation
## de compte, stockee dans profile.controle_parental) et feedback_parental_control_checkbox.md.
##
## Le bouton d'icone qui ouvre cette section (ParentalControlButton, voir game_menu_panel.tscn/.gd)
## n'est visible dans IconDock que si le compte connecte a controle_parental=true (voir
## GameMenuPanel._ready(), reagit a SaveManager.account_logged_in/account_logged_out) - cette
## section elle-meme ne fait aucune verification de ce booleen, elle n'existe simplement pas dans
## la navigation si la case n'a pas ete cochee a l'inscription.
##
## Verrouillee par mot de passe (2026-09-05, retour utilisateur : "dans la fenetre controle
## parental on va deja ajouter une premiere case entrer le mot de passe, celui-ci activera
## l'affichage des autres options de controle parental, si on quitte la fenetre on relock le
## controle parental et tout retour a celui-ci via l'icone controle parental doit redemander le
## pass") : LockGroup (champ mot de passe + Valider) masque OptionsScroll tant que SaveManager.
## verify_parental_control_password() n'a pas reussi. refresh() est appelee par GameMenuPanel a
## CHAQUE ouverture (voir _show_parental_control()) et reverrouille systematiquement.
##
## Cas d'un compte avec controle_parental=true mais SANS mot de passe enregistre : refresh()
## choisit de ne PAS verrouiller plutot que de bloquer definitivement l'acces aux options - devenu
## impossible depuis le 2026-09-16 (mot de passe de controle parental desormais obligatoire a la
## creation, voir WelcomePanel/TODO_UI_MODS.md mod 5), garde conservee pour les comptes crees avant
## ce changement.
##
## AGRANDIE le 2026-09-16 (voir TODO_UI_MODS.md, mods 2/6/7/8 - reprise du chantier "mods UI") :
## cette section concentre desormais TOUT ce qui touche au compte et etait auparavant reparti
## entre SectionSave (reinitialiser la progression, onglet supprime en entier, mod 9) et
## SectionProfile (modification des infos personnelles + suppression du compte, cette derniere
## passee en lecture seule, mod 3/4) - "c'est aux parents de gerer ca, pas a l'enfant" (mod 6).
## OptionsContent est desormais dans un ScrollContainer (OptionsScroll) : le contenu ne tient plus
## sans defiler sur un petit ecran une fois toutes ces options ajoutees.
## - ResetProgressButton/ResetStatusLabel : repris tels quels de SectionSave.gd (meme signal
##   reset_requested, GameMenuPanel n'a besoin de changer QUE le noeud connecte, voir son
##   commentaire de classe) - toujours protege par le portail parental a 8 caracteres
##   (ParentalGateOverlay) EN PLUS du mot de passe qui verrouille deja cette section entiere :
##   double confirmation assumee pour un geste destructif, plutot qu'une regression de securite.
## - NomRow/PrenomRow/BirthdateRow/PaysRow/LoginRow/EmailRow + PersonalInfoSaveButton : nom/prenom/
##   date de naissance/pays restent dans le "profil" (SaveManager.update_current_profile(), comme
##   avant dans SectionProfile) ; pseudo/email sont des colonnes du COMPTE, pas du profil - voir
##   SaveManager.change_login()/change_email() (nouvelles fonctions, chacune un appel serveur
##   dedie, schema.sql). "Classe" n'est PAS reprise ici (mod 4 : jugee sans utilite reelle,
##   simplement retiree, pas deplacee).
## - CurrentPasswordRow/NewPasswordRow/ConfirmNewPasswordRow + ChangePasswordButton : voir
##   SaveManager.change_password() (verifie l'ancien mot de passe localement avant d'envoyer un
##   nouveau hash+sel au serveur).
## - DeleteAccountButton : repris de SectionProfile.gd (meme signal delete_account_requested,
##   meme raison que ResetProgressButton ci-dessus).
class_name SectionParentalControl
extends Control

signal reset_requested
signal delete_account_requested

const COUNTRY_FLAG_FRANCE := preload("res://assets/flags/flag_fr.svg")

@onready var lock_group: VBoxContainer = $VBoxContainer/LockGroup
@onready var password_input: LineEdit = $VBoxContainer/LockGroup/PasswordRow/PasswordInput
@onready var error_label: Label = $VBoxContainer/LockGroup/ErrorLabel
@onready var validate_button: Button = $VBoxContainer/LockGroup/ValidateButton

@onready var options_scroll: ScrollContainer = $VBoxContainer/OptionsScroll
@onready var limits_tree: VBoxContainer = $VBoxContainer/OptionsScroll/OptionsContent/LimitsTree
@onready var limits_validate_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/LimitsValidateButton
@onready var limits_status_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/LimitsStatusLabel

@onready var reset_progress_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/ResetProgressButton
@onready var reset_status_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/ResetStatusLabel

@onready var nom_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/NomRow/NomInput
@onready var prenom_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/PrenomRow/PrenomInput
@onready var day_spin: SpinBox = $VBoxContainer/OptionsScroll/OptionsContent/BirthdateRow/DaySpin
@onready var month_spin: SpinBox = $VBoxContainer/OptionsScroll/OptionsContent/BirthdateRow/MonthSpin
@onready var year_spin: SpinBox = $VBoxContainer/OptionsScroll/OptionsContent/BirthdateRow/YearSpin
@onready var pays_option: OptionButton = $VBoxContainer/OptionsScroll/OptionsContent/PaysRow/PaysOption
@onready var login_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/LoginRow/LoginInput
@onready var email_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/EmailRow/EmailInput
@onready var personal_info_error_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/PersonalInfoErrorLabel
@onready var personal_info_save_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/PersonalInfoSaveButton
@onready var personal_info_status_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/PersonalInfoStatusLabel

@onready var current_password_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/CurrentPasswordRow/CurrentPasswordInput
@onready var new_password_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/NewPasswordRow/NewPasswordInput
@onready var confirm_new_password_input: LineEdit = $VBoxContainer/OptionsScroll/OptionsContent/ConfirmNewPasswordRow/ConfirmNewPasswordInput
@onready var change_password_error_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/ChangePasswordErrorLabel
@onready var change_password_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/ChangePasswordButton
@onready var change_password_status_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/ChangePasswordStatusLabel

@onready var delete_account_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/DeleteAccountButton

func _ready() -> void:
	## Glissement au doigt possible depuis n'importe quelle zone (pas seulement la fine barre
	## de defilement) - voir ui/common/touch_scroll_fix.gd (retour utilisateur 2026-09-18).
	TouchScrollFix.allow_scroll_passthrough(self)

	validate_button.pressed.connect(_on_validate_pressed)
	## Entree valide directement le mot de passe (LineEdit.text_submitted) - meme convention que
	## WelcomePanel pour ses propres champs pseudo/mot de passe.
	password_input.text_submitted.connect(func(_text: String) -> void: _on_validate_pressed())
	limits_validate_button.pressed.connect(_on_limits_validate_pressed)

	reset_progress_button.pressed.connect(func() -> void: reset_requested.emit())
	pays_option.add_icon_item(COUNTRY_FLAG_FRANCE, "France")
	var current_year: int = Time.get_date_dict_from_system(false).get("year", 2026)
	year_spin.min_value = current_year - 99
	year_spin.max_value = current_year
	personal_info_save_button.pressed.connect(_on_personal_info_save_pressed)
	change_password_button.pressed.connect(_on_change_password_pressed)
	delete_account_button.pressed.connect(func() -> void: delete_account_requested.emit())

## Appelee par GameMenuPanel a chaque ouverture (voir _show_parental_control()) - reverrouille et
## vide le champ mot de passe a chaque fois, jamais d'options affichees par defaut (sauf le cas
## "aucun mot de passe enregistre" documente ci-dessus).
func refresh() -> void:
	var has_password := not String(SaveManager.get_current_profile().get(
		"controle_parental_password_hash", "")).is_empty()
	if not has_password:
		lock_group.hide()
		_show_options()
		return
	lock_group.show()
	options_scroll.hide()
	error_label.hide()
	password_input.clear()
	password_input.grab_focus()

func _on_validate_pressed() -> void:
	if SaveManager.verify_parental_control_password(password_input.text):
		lock_group.hide()
		_show_options()
	else:
		error_label.text = "Mot de passe incorrect."
		error_label.show()
		password_input.clear()
		password_input.grab_focus()

## Affiche les options et synchronise chaque champ sur la valeur ACTUELLEMENT enregistree (pas une
## valeur en cours d'edition, il n'y en a pas encore a ce stade).
func _show_options() -> void:
	options_scroll.show()
	reset_status_label.hide()
	personal_info_error_label.hide()
	personal_info_status_label.hide()
	change_password_error_label.hide()
	change_password_status_label.hide()
	current_password_input.clear()
	new_password_input.clear()
	confirm_new_password_input.clear()

	## Brouillon des limites relu depuis le reglage enregistre, toutes les classes repliees.
	_limits_draft = SaveManager.get_all_grade_limits()
	_expanded.clear()
	limits_status_label.hide()
	_rebuild_limits_tree()

	var profile := SaveManager.get_current_profile()
	nom_input.text = String(profile.get("nom", ""))
	prenom_input.text = String(profile.get("prenom", ""))
	var birthdate: Dictionary = profile.get("date_naissance", {})
	day_spin.value = int(birthdate.get("day", 1))
	month_spin.value = int(birthdate.get("month", 1))
	year_spin.value = int(birthdate.get("year", year_spin.max_value))
	login_input.text = SaveManager.get_current_login()
	email_input.text = SaveManager.get_current_email()

## --- Limites de jeu par classe et par matiere (2026-11-28) ---
##
## Remplace l'ancienne limite unique (SpinBox + case "illimite"). Une branche depliable par classe
## (fleche devant la classe), avec 4 modes au choix (voir SaveManager.PARENTAL_MODE_*) :
## - Illimité : rien a regler ;
## - Limite libre : un seul reglage, nombre de parties par jour, matieres au choix de l'enfant ;
## - Par matière : chaque matiere de la classe est Illimitée / Limitée (avec son reglage) / Bloquée ;
## - Bloquée : toute la classe est fermee.
## Tout se fait sur un brouillon (_limits_draft) : rien n'est enregistre avant "Valider les limites",
## meme principe que l'ancien bouton "Valider". Liste des matieres lue dans ContentLibrary (comme les
## PNJ), jamais figee ici : une nouvelle matiere apparait toute seule.
var _mode_choices: Array = [
	[SaveManager.PARENTAL_MODE_UNLIMITED, "Illimité"],
	[SaveManager.PARENTAL_MODE_FREE, "Limite libre"],
	[SaveManager.PARENTAL_MODE_BY_SUBJECT, "Par matière"],
	[SaveManager.PARENTAL_MODE_BLOCKED, "Bloquée"],
]
var _subject_choices: Array = [
	[SaveManager.SUBJECT_STATE_UNLIMITED, "Illimitée"],
	[SaveManager.SUBJECT_STATE_LIMITED, "Limitée"],
	[SaveManager.SUBJECT_STATE_BLOCKED, "Bloquée"],
]
## (var et non const : les constantes d'un autoload ne sont pas garanties utilisables dans une
## expression constante, d'ou aussi les if/elif plutot que des match plus bas.)
## Fleche devant chaque classe (tournee vers le bas quand la classe est depliee).
const ARROW_ICON := preload("res://assets/classe2.0/icones/fleche-droite.webp")
const _ARROW_SIZE := 24.0
## Deplacement maximal (pixels) entre appui et relachement pour compter comme un "tap" sur l'en-tete.
const _TAP_MAX_DISTANCE := 12.0
var _header_press_position := Vector2.ZERO
## Duree de la rotation de la fleche quand une classe s'ouvre ou se ferme.
const ARROW_TURN_SECONDS := 0.15
## Fleche de chaque classe affichee (cle = classe) et animation en cours.
var _arrows: Dictionary = {}
var _arrow_tween: Tween
## Marge a gauche du contenu d'une classe depliee, pour qu'il se lise "sous" son en-tete.
const _BRANCH_INDENT := 28

## Reglages en cours d'edition (meme format que SaveManager.get_all_grade_limits) et classes depliees.
var _limits_draft: Dictionary = {}
var _expanded: Dictionary = {}
## Libelle de resume de chaque en-tete, mis a jour sans tout reconstruire quand un reglage change.
var _summary_labels: Dictionary = {}

func _rebuild_limits_tree() -> void:
	for child in limits_tree.get_children():
		child.queue_free()
	_summary_labels.clear()
	_arrows.clear()
	for grade: GradeLevel.Grade in GradeLevel.Grade.values():
		if grade != GradeLevel.Grade.CP:
			limits_tree.add_child(_build_grade_separator())
		limits_tree.add_child(_build_grade_header(grade))
		if _expanded.get(grade, false):
			limits_tree.add_child(_build_grade_body(grade))

## Trait fin (1px) entre deux classes (2026-11-28, demande de Steve). Couleur = celle du texte du
## theme actif, adoucie, pour rester lisible sur les 4 themes (clairs comme sombres).
func _build_grade_separator() -> HSeparator:
	var separator := HSeparator.new()
	var line := StyleBoxLine.new()
	line.thickness = 1
	var text_color := get_theme_color("font_color", "Label")
	line.color = Color(text_color, 0.25)
	separator.add_theme_stylebox_override("separator", line)
	separator.add_theme_constant_override("separation", 1)
	return separator

func _grade_draft(grade: GradeLevel.Grade) -> Dictionary:
	return _limits_draft[str(int(grade))]

## En-tete d'une classe : fleche (droite = repliee, bas = depliee), pastille aplatie de la couleur
## de la classe, puis resume du reglage (2026-11-28, retour de Steve : fleche devant la classe a la
## place du bouton "Régler", case de classe moins haute). Cliquer sur la fleche, la pastille ou le
## resume deplie/replie la classe. La fleche est l'icone du jeu (fleche-droite.webp) tournee de 90°
## quand la classe est depliee - pas de caractere "▸", absent de la police du jeu.
func _build_grade_header(grade: GradeLevel.Grade) -> Control:
	var is_open: bool = _expanded.get(grade, false)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)
	## Clic n'importe ou sur la ligne (gui_input) : plus facile a viser au doigt que la seule fleche.
	## Declenche au RELACHEMENT et seulement si le doigt n'a presque pas bouge : un glissement pour
	## faire defiler la fenetre au tactile ne deplie pas la classe par erreur.
	row.mouse_filter = Control.MOUSE_FILTER_PASS
	row.gui_input.connect(func(event: InputEvent) -> void:
		var mouse_event := event as InputEventMouseButton
		if mouse_event == null or mouse_event.button_index != MOUSE_BUTTON_LEFT:
			return
		if mouse_event.pressed:
			_header_press_position = mouse_event.global_position
		elif mouse_event.global_position.distance_to(_header_press_position) < _TAP_MAX_DISTANCE:
			_toggle_grade(grade))

	## La fleche est posee dans un simple Control (pas un conteneur) : un Container remet la rotation
	## de ses enfants directs a 0 a chaque placement, la fleche serait revenue a l'horizontale apres
	## chaque reconstruction de la liste (bug vu par Steve le 2026-11-28).
	var arrow_holder := Control.new()
	arrow_holder.custom_minimum_size = Vector2(_ARROW_SIZE, _ARROW_SIZE)
	arrow_holder.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	arrow_holder.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var arrow := TextureRect.new()
	arrow.texture = ARROW_ICON
	arrow.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	arrow.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	arrow.size = Vector2(_ARROW_SIZE, _ARROW_SIZE)
	## Rotation autour du centre de l'icone (taille fixe, pivot connu d'avance).
	arrow.pivot_offset = Vector2(_ARROW_SIZE, _ARROW_SIZE) / 2.0
	arrow.rotation_degrees = 90.0 if is_open else 0.0
	arrow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	arrow_holder.add_child(arrow)
	row.add_child(arrow_holder)
	_arrows[grade] = arrow

	var pill := PanelContainer.new()
	var pill_style := StyleBoxFlat.new()
	pill_style.bg_color = GradeLevel.get_color(grade)
	pill_style.set_corner_radius_all(8)
	pill_style.content_margin_left = 12
	pill_style.content_margin_right = 12
	pill_style.content_margin_top = 0
	pill_style.content_margin_bottom = 0
	pill.add_theme_stylebox_override("panel", pill_style)
	pill.custom_minimum_size = Vector2(72, 0)
	## SHRINK_CENTER : la pastille garde la hauteur de son texte au lieu de s'etirer sur la ligne.
	pill.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	pill.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var pill_label := Label.new()
	pill_label.text = GradeLevel.get_label(grade)
	pill_label.theme_type_variation = &"TitleLabel"
	pill_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pill.add_child(pill_label)
	row.add_child(pill)

	var summary := Label.new()
	summary.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	summary.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	summary.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	summary.text = _draft_summary(grade)
	summary.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(summary)
	_summary_labels[grade] = summary
	return row

## Une seule classe depliee a la fois (2026-11-28, retour de Steve) : ouvrir une classe referme
## celle qui etait ouverte. Les fleches tournent d'abord (sens horaire, 90° = vers le bas, en
## ARROW_TURN_SECONDS), puis la liste est reconstruite avec le nouveau contenu.
func _toggle_grade(grade: GradeLevel.Grade) -> void:
	if _arrow_tween and _arrow_tween.is_running():
		return
	var opening: bool = not _expanded.get(grade, false)
	var previous: Array = _expanded.keys().filter(func(g: Variant) -> bool: return _expanded[g])
	_expanded.clear()
	if opening:
		_expanded[grade] = true
	## Fleches a tourner : celles des classes qui se ferment (retour a droite), et celle de la classe
	## qui s'ouvre (vers le bas).
	var turns: Array = []
	for g: Variant in previous:
		if _arrows.get(g):
			turns.append([_arrows[g], 0.0])
	if opening and _arrows.get(grade):
		turns.append([_arrows[grade], 90.0])
	if turns.is_empty():
		_rebuild_limits_tree.call_deferred()
		return
	_arrow_tween = create_tween().set_parallel(true)
	for turn: Array in turns:
		_arrow_tween.tween_property(turn[0], "rotation_degrees", turn[1], ARROW_TURN_SECONDS)
	## Reconstruction une fois les fleches tournees (et hors du gui_input de la ligne cliquee).
	_arrow_tween.finished.connect(_rebuild_limits_tree)

## Resume d'une classe d'apres le BROUILLON (pas le reglage enregistre).
func _draft_summary(grade: GradeLevel.Grade) -> String:
	var draft := _grade_draft(grade)
	var mode := String(draft.get("mode"))
	if mode == SaveManager.PARENTAL_MODE_FREE:
		return "Limite libre : %d parties par jour, matières au choix" % int(draft.get("max"))
	if mode == SaveManager.PARENTAL_MODE_BLOCKED:
		return "Classe bloquée"
	if mode == SaveManager.PARENTAL_MODE_BY_SUBJECT:
		var limited := 0
		var blocked := 0
		var subjects: Dictionary = draft.get("matieres", {})
		for key: Variant in subjects:
			var state := String((subjects[key] as Dictionary).get("etat"))
			if state == SaveManager.SUBJECT_STATE_LIMITED:
				limited += 1
			elif state == SaveManager.SUBJECT_STATE_BLOCKED:
				blocked += 1
		var parts: Array[String] = ["Par matière"]
		if limited > 0:
			parts.append("%d limitée%s" % [limited, "s" if limited > 1 else ""])
		if blocked > 0:
			parts.append("%d bloquée%s" % [blocked, "s" if blocked > 1 else ""])
		if limited == 0 and blocked == 0:
			parts.append("aucune règle")
		return " · ".join(parts)
	return "Illimité"

func _refresh_summary(grade: GradeLevel.Grade) -> void:
	var label: Label = _summary_labels.get(grade)
	if label:
		label.text = _draft_summary(grade)

## Contenu d'une classe depliee : choix du mode, puis le reglage qui correspond a ce mode.
func _build_grade_body(grade: GradeLevel.Grade) -> Control:
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", _BRANCH_INDENT)
	margin.add_theme_constant_override("margin_bottom", 8)
	var body := VBoxContainer.new()
	body.add_theme_constant_override("separation", 10)
	margin.add_child(body)

	var draft := _grade_draft(grade)
	var mode := String(draft.get("mode"))
	body.add_child(_build_choice_row(_mode_choices, mode, func(new_mode: String) -> void:
		draft["mode"] = new_mode
		_rebuild_limits_tree()))

	if mode == SaveManager.PARENTAL_MODE_UNLIMITED:
		body.add_child(_build_hint("Aucune limite dans cette classe."))
	elif mode == SaveManager.PARENTAL_MODE_BLOCKED:
		body.add_child(_build_hint("Toute la classe est fermée : l'enfant verra « %s »" % TeacherIdentity.get_unavailable_message(grade).get_slice("\n", 0)))
	elif mode == SaveManager.PARENTAL_MODE_FREE:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 12)
		var label := Label.new()
		label.text = "Parties par jour, matières au choix de l'enfant"
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(label)
		var stepper := LimitStepper.new()
		stepper.setup(SaveManager.PARENTAL_LIMIT_MIN, SaveManager.PARENTAL_LIMIT_MAX, int(draft.get("max")))
		stepper.value_changed.connect(func(new_value: int) -> void:
			draft["max"] = new_value
			_refresh_summary(grade))
		row.add_child(stepper)
		body.add_child(row)
	elif mode == SaveManager.PARENTAL_MODE_BY_SUBJECT:
		var subjects := ContentLibrary.get_available_subjects(grade)
		if subjects.is_empty():
			body.add_child(_build_hint("Matières en cours de chargement… rouvre cette fenêtre dans un instant."))
		for i in subjects.size():
			## Trait fin (1 px) entre deux lignes de matiere (2026-11-28, retour de Steve).
			if i > 0:
				body.add_child(_build_thin_separator())
			body.add_child(_build_subject_row(grade, subjects[i]))
	return margin

## Une ligne de matiere (mode "Par matière") : pastille de couleur + nom, Illimitée/Limitée/Bloquée,
## et le reglage du nombre de parties seulement si "Limitée".
func _build_subject_row(grade: GradeLevel.Grade, subject: SubjectType.Subject) -> Control:
	var draft := _grade_draft(grade)
	var subjects: Dictionary = draft.get("matieres", {})
	draft["matieres"] = subjects
	var key := str(int(subject))
	if not subjects.has(key):
		subjects[key] = {"etat": SaveManager.SUBJECT_STATE_UNLIMITED, "max": SaveManager.PARENTAL_LIMIT_DEFAULT}
	var rule: Dictionary = subjects[key]
	var state := String(rule.get("etat"))

	var row := VBoxContainer.new()
	row.add_theme_constant_override("separation", 4)
	var name_row := HBoxContainer.new()
	name_row.add_theme_constant_override("separation", 8)
	var dot := ColorRect.new()
	dot.color = SubjectType.get_color(subject)
	dot.custom_minimum_size = Vector2(14, 14)
	dot.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	name_row.add_child(dot)
	var name_label := Label.new()
	name_label.text = SubjectType.get_label(subject)
	if state == SaveManager.SUBJECT_STATE_BLOCKED:
		name_label.modulate = Color(1, 1, 1, 0.5)
	name_row.add_child(name_label)
	row.add_child(name_row)

	var controls := HBoxContainer.new()
	controls.add_theme_constant_override("separation", 12)
	controls.add_child(_build_choice_row(_subject_choices, state, func(new_state: String) -> void:
		rule["etat"] = new_state
		_rebuild_limits_tree()))
	if state == SaveManager.SUBJECT_STATE_LIMITED:
		var stepper := LimitStepper.new()
		stepper.setup(SaveManager.PARENTAL_LIMIT_MIN, SaveManager.PARENTAL_LIMIT_MAX, int(rule.get("max")))
		stepper.value_changed.connect(func(new_value: int) -> void:
			rule["max"] = new_value)
		controls.add_child(stepper)
	row.add_child(controls)
	return row

## Rangee de boutons a choix unique (ButtonGroup) - [choices] = liste de [valeur, libelle].
## [on_pick] recoit la valeur choisie (seulement si elle change).
func _build_choice_row(choices: Array, current: String, on_pick: Callable) -> Control:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 4)
	var group := ButtonGroup.new()
	for choice: Array in choices:
		var button := Button.new()
		button.text = String(choice[1])
		button.toggle_mode = true
		button.button_group = group
		button.focus_mode = Control.FOCUS_NONE
		button.button_pressed = String(choice[0]) == current
		var picked := String(choice[0])
		button.pressed.connect(func() -> void:
			if picked != current:
				on_pick.call(picked))
		row.add_child(button)
	return row

## Trait horizontal de 1 px, gris semi-transparent : lisible sur les fonds clairs comme sombres des
## 4 themes, sans reprendre le separateur epais du theme (reserve aux grandes sections).
func _build_thin_separator() -> HSeparator:
	var separator := HSeparator.new()
	var line := StyleBoxLine.new()
	line.color = Color(0.5, 0.5, 0.5, 0.45)
	line.thickness = 1
	separator.add_theme_stylebox_override("separator", line)
	separator.add_theme_constant_override("separation", 1)
	return separator

func _build_hint(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.modulate = Color(1, 1, 1, 0.75)
	return label

func _on_limits_validate_pressed() -> void:
	SaveManager.set_all_grade_limits(_limits_draft)
	## Relit le reglage enregistre (normalise) pour que la fenetre montre exactement ce qui compte.
	_limits_draft = SaveManager.get_all_grade_limits()
	_rebuild_limits_tree()
	limits_status_label.show()

## Appele par GameMenuPanel une fois le portail parental valide (voir reset_requested) - cette
## section n'appelle jamais SaveManager.reset_current_account_progress() elle-meme (voir
## _do_reset_progress() dans game_menu_panel.gd).
func notify_reset_done() -> void:
	reset_status_label.text = "Progression réinitialisée."
	reset_status_label.show()

## "Enregistrer les informations" : nom/prenom/date de naissance/pays vont dans le "profil" (comme
## avant dans SectionProfile), pseudo/email sont des colonnes du COMPTE - deux appels distincts
## (voir SaveManager.change_login()/change_email()), chacun peut echouer independamment (ex.
## pseudo deja pris) sans annuler l'autre ni le profil, deja enregistre a ce moment-la.
func _on_personal_info_save_pressed() -> void:
	personal_info_error_label.hide()
	personal_info_status_label.hide()

	## Part du profil existant (copie) et ne remplace QUE les champs de ce formulaire : toutes les
	## autres cles (classe, mot de passe du controle parental, limites par classe, volume, theme...)
	## sont gardees telles quelles - avant le 2026-11-28 la liste des cles a recopier etait ecrite a
	## la main, et une cle oubliee etait effacee a chaque "Enregistrer".
	var profile := SaveManager.get_current_profile().duplicate(true)
	profile["nom"] = nom_input.text.strip_edges()
	profile["prenom"] = prenom_input.text.strip_edges()
	profile["date_naissance"] = {
		"year": int(year_spin.value),
		"month": int(month_spin.value),
		"day": int(day_spin.value),
	}
	profile["pays"] = "fr"
	SaveManager.update_current_profile(profile)

	var errors: Array[String] = []
	var new_login := login_input.text.strip_edges()
	if new_login != SaveManager.get_current_login():
		var login_error := await SaveManager.change_login(new_login)
		if not login_error.is_empty():
			errors.append(login_error)

	var new_email := email_input.text.strip_edges()
	if new_email != SaveManager.get_current_email():
		var email_error := await SaveManager.change_email(new_email)
		if not email_error.is_empty():
			errors.append(email_error)

	if errors.is_empty():
		personal_info_status_label.text = "Informations enregistrées."
		personal_info_status_label.show()
	else:
		personal_info_error_label.text = "\n".join(errors)
		personal_info_error_label.show()

func _on_change_password_pressed() -> void:
	change_password_error_label.hide()
	change_password_status_label.hide()
	if new_password_input.text != confirm_new_password_input.text:
		change_password_error_label.text = "Les mots de passe ne correspondent pas."
		change_password_error_label.show()
		return
	if new_password_input.text.length() < SaveManager.MIN_PASSWORD_LENGTH:
		change_password_error_label.text = "Le mot de passe doit faire au moins %d caractères." % SaveManager.MIN_PASSWORD_LENGTH
		change_password_error_label.show()
		return
	change_password_button.disabled = true
	var error := await SaveManager.change_password(current_password_input.text, new_password_input.text)
	change_password_button.disabled = false
	if error.is_empty():
		current_password_input.clear()
		new_password_input.clear()
		confirm_new_password_input.clear()
		change_password_status_label.text = "Mot de passe changé."
		change_password_status_label.show()
	else:
		change_password_error_label.text = error
		change_password_error_label.show()
