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
## pass") : LockGroup (champ mot de passe + Valider) masque OptionsContent tant que SaveManager.
## verify_parental_control_password() n'a pas reussi. refresh() est appelee par GameMenuPanel a
## CHAQUE ouverture (voir _show_parental_control()) et reverrouille systematiquement - "quitter la
## fenetre" est donc traite au sens large : fermer tout le menu OU simplement changer de section
## puis revenir suffit deja a redemander le mot de passe, exactement la garantie demandee, sans
## code de fermeture dedie ici.
##
## Cas d'un compte avec controle_parental=true mais SANS mot de passe enregistre (aucun compte
## cree apres le 2026-09-05 ne peut se retrouver dans ce cas, voir WelcomePanel._on_create_pressed(),
## qui exige desormais ce mot de passe des que la case est cochee) : refresh() choisit de ne PAS
## verrouiller plutot que de bloquer definitivement l'acces aux options.
##
## Limite quotidienne (2026-09-05, reglage initial) : DailyLimitSpin est un SpinBox (memes fleches
## +/- que DaySpin/MonthSpin/YearSpin ailleurs dans le jeu), DailyLimitValidateButton enregistre la
## valeur via SaveManager.set_daily_game_limit() (cle "daily_game_limit" du profil, 0 = aucune
## limite), et DailyLimitCurrentLabel affiche la valeur ENREGISTREE (pas la valeur en cours
## d'edition dans le SpinBox tant que "Valider" n'a pas ete clique - meme convention que
## SectionProfile). Le reglage est REELLEMENT applique depuis le 2026-09-06 (compteur + remise a
## zero a minuit + blocage, voir SaveManager et QuestionGiverComponent).
##
## 2026-09-05, retour utilisateur (reprise) : "enleve la ligne 'limite dutilisation par jour' et
## modifie nombre de jeux par jour en : 'limite de jeux par jour:'. De plus recendre le chiffre
## dans la case. ajoute une ligne en dessous avec 'Nombre de jeux illimité' et une case a cocher.
## Quand cette option est validee la ligne au dessus doit etre grisee et le chiffre ne peut plus
## etre incremente et decremente." :
## - DailyLimitTitle (le grand intitule "Limite d'utilisation par jour" au-dessus de la ligne)
##   supprime, la ligne DailyLimitRow porte desormais l'explication a elle seule.
## - DailyLimitLabel : "Nombre de jeux par jour" -> "Limite de jeux par jour :".
## - DailyLimitSpin.get_line_edit().alignment recentre en CENTER (par defaut un SpinBox
##   aligne son chiffre a gauche).
## - UnlimitedRow/UnlimitedCheck (CheckBox) ajoutee juste en dessous de DailyLimitRow : cochee =
##   jeu illimite. 0 etait DEJA la valeur "aucune limite" cote SaveManager (voir
##   has_reached_daily_game_limit()), cette case n'est donc qu'une facon plus claire de choisir 0 -
##   aucun nouveau champ de sauvegarde necessaire. Cochee/decochee synchronisee sur la valeur
##   enregistree a chaque _show_options() (limite <= 0 -> case cochee). Toggle immediat (visuel
##   seulement, comme l'edition du SpinBox) : grise DailyLimitRow (modulate alpha) et passe
##   DailyLimitSpin.editable a false (desactive aussi les fleches +/-, propriete native de SpinBox).
##   "Valider" (le meme bouton qu'avant) enregistre 0 si la case est cochee, sinon la valeur du
##   SpinBox.
class_name SectionParentalControl
extends Control

@onready var lock_group: VBoxContainer = $VBoxContainer/LockGroup
@onready var password_input: LineEdit = $VBoxContainer/LockGroup/PasswordRow/PasswordInput
@onready var error_label: Label = $VBoxContainer/LockGroup/ErrorLabel
@onready var validate_button: Button = $VBoxContainer/LockGroup/ValidateButton

@onready var options_content: VBoxContainer = $VBoxContainer/OptionsContent
@onready var daily_limit_row: HBoxContainer = $VBoxContainer/OptionsContent/DailyLimitRow
@onready var daily_limit_spin: SpinBox = $VBoxContainer/OptionsContent/DailyLimitRow/DailyLimitSpin
@onready var unlimited_check: CheckBox = $VBoxContainer/OptionsContent/UnlimitedRow/UnlimitedCheck
@onready var daily_limit_validate_button: Button = $VBoxContainer/OptionsContent/DailyLimitValidateButton
@onready var daily_limit_current_label: Label = $VBoxContainer/OptionsContent/DailyLimitCurrentLabel

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
	options_content.hide()
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

## Affiche les options et synchronise le SpinBox + la case "illimite" + le texte de rappel sur la
## valeur ACTUELLEMENT enregistree (pas une valeur en cours d'edition, il n'y en a pas encore a ce
## stade).
func _show_options() -> void:
	options_content.show()
	var limit := SaveManager.get_daily_game_limit()
	daily_limit_spin.value = limit
	unlimited_check.set_pressed_no_signal(limit <= 0)
	_update_unlimited_state()
	_update_daily_limit_label()

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
