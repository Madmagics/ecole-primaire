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
@onready var daily_limit_row: HBoxContainer = $VBoxContainer/OptionsScroll/OptionsContent/DailyLimitRow
@onready var daily_limit_spin: SpinBox = $VBoxContainer/OptionsScroll/OptionsContent/DailyLimitRow/DailyLimitSpin
@onready var unlimited_check: CheckBox = $VBoxContainer/OptionsScroll/OptionsContent/UnlimitedRow/UnlimitedCheck
@onready var daily_limit_validate_button: Button = $VBoxContainer/OptionsScroll/OptionsContent/DailyLimitValidateButton
@onready var daily_limit_current_label: Label = $VBoxContainer/OptionsScroll/OptionsContent/DailyLimitCurrentLabel

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
	validate_button.pressed.connect(_on_validate_pressed)
	## Entree valide directement le mot de passe (LineEdit.text_submitted) - meme convention que
	## WelcomePanel pour ses propres champs pseudo/mot de passe.
	password_input.text_submitted.connect(func(_text: String) -> void: _on_validate_pressed())
	daily_limit_validate_button.pressed.connect(_on_daily_limit_validate_pressed)
	unlimited_check.toggled.connect(func(_pressed: bool) -> void: _update_unlimited_state())
	## Chiffre centre dans la case (retour utilisateur 2026-09-05) - un SpinBox aligne son texte a
	## gauche par defaut, il faut passer par son LineEdit interne pour changer ca.
	daily_limit_spin.get_line_edit().alignment = HORIZONTAL_ALIGNMENT_CENTER

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

	var limit := SaveManager.get_daily_game_limit()
	daily_limit_spin.value = limit
	unlimited_check.set_pressed_no_signal(limit <= 0)
	_update_unlimited_state()
	_update_daily_limit_label()

	var profile := SaveManager.get_current_profile()
	nom_input.text = String(profile.get("nom", ""))
	prenom_input.text = String(profile.get("prenom", ""))
	var birthdate: Dictionary = profile.get("date_naissance", {})
	day_spin.value = int(birthdate.get("day", 1))
	month_spin.value = int(birthdate.get("month", 1))
	year_spin.value = int(birthdate.get("year", year_spin.max_value))
	login_input.text = SaveManager.get_current_login()
	email_input.text = SaveManager.get_current_email()

func _on_daily_limit_validate_pressed() -> void:
	var new_limit := 0 if unlimited_check.button_pressed else int(daily_limit_spin.value)
	SaveManager.set_daily_game_limit(new_limit)
	_update_daily_limit_label()

## Grise DailyLimitRow et desactive le SpinBox (edition ET fleches +/-) tant que "illimite" est
## coche - purement visuel/immediat, comme l'edition du SpinBox lui-meme, "Valider" reste le seul
## geste qui enregistre reellement.
func _update_unlimited_state() -> void:
	var unlimited := unlimited_check.button_pressed
	daily_limit_spin.editable = not unlimited
	daily_limit_row.modulate = Color(1, 1, 1, 0.4) if unlimited else Color(1, 1, 1, 1)

func _update_daily_limit_label() -> void:
	daily_limit_current_label.text = "Limite actuelle de jeu : %d" % SaveManager.get_daily_game_limit()

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

	var existing_profile := SaveManager.get_current_profile()
	var profile := {
		"nom": nom_input.text.strip_edges(),
		"prenom": prenom_input.text.strip_edges(),
		## "Classe" retiree de cette section (mod 4, jugee sans utilite reelle) - reprise telle
		## quelle du profil existant pour ne pas la remettre a une valeur par defaut a chaque
		## "Enregistrer".
		"classe": existing_profile.get("classe", GradeLevel.Grade.CP),
		"date_naissance": {
			"year": int(year_spin.value),
			"month": int(month_spin.value),
			"day": int(day_spin.value),
		},
		"pays": "fr",
		"controle_parental": existing_profile.get("controle_parental", false),
		"controle_parental_password_hash": existing_profile.get("controle_parental_password_hash", ""),
		"controle_parental_password_salt": existing_profile.get("controle_parental_password_salt", ""),
		"daily_game_limit": existing_profile.get("daily_game_limit", 0),
	}
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
