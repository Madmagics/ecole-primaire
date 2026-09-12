## Section "Informations personnelles" du menu de jeu (2026-08-01) : modifie le profil du compte
## CONNECTE (nom/prenom/classe/date de naissance/pays), cree a l'origine par WelcomePanel. Ne
## touche ni au pseudo ni au mot de passe (pas de champ ici pour l'instant) ni a la progression
## reelle (Economy/CardCollection) - "Classe" est une simple donnee de profil declarative
## (2026-08-29, retrait de l'ancien GradeUnlock : toutes les classes sont accessibles des le
## depart, ce champ ne debloque plus rien).
##
## A la difference de SectionConfig (volume/plein ecran, appliques immediatement), les
## changements ne sont ecrits qu'au clic sur "Enregistrer" - plusieurs champs texte a la fois,
## sauvegarder a chaque frappe n'aurait pas de sens.
##
## "Supprimer le compte" (2026-08-01) efface le profil ET la progression, protege par le portail
## parental (voir ParentalGateOverlay) - cette section se contente d'emettre
## delete_account_requested, c'est GameMenuPanel qui orchestre l'ouverture du portail et n'appelle
## SaveManager.delete_current_account() qu'apres confirmation (meme mecanisme que
## SectionSave.reset_requested, voir GameMenuPanel._request_gate()).
##
## SaveButton/DeleteAccountButton en size_flags_horizontal = SIZE_SHRINK_BEGIN (0) depuis
## 2026-08-26 (retour utilisateur : "reduit de moitie la longueur des pushbutton, ils prennent
## actuellement toute la largeur de la fenetre") : sans ce flag explicite, un Button enfant direct
## d'un VBoxContainer herite du FILL par defaut sur l'axe transversal (horizontal ici) et s'etire
## a toute la largeur du conteneur, meme sans le flag EXPAND (contrairement a un HBoxContainer, ou
## FILL seul dimensionne au minimum naturel - voir la note de LineEdit/OptionButton plus bas dans
## le projet). SHRINK_BEGIN ramene le bouton a sa taille naturelle (texte + marges du style actif)
## et l'aligne a gauche, coherent avec "contenu colle a gauche" deja applique aux rubriques du menu.
##
## StatusLabel masque quand il est vide (2026-08-26, retour utilisateur : "un saut de ligne
## inutile entre enregistrer et supprimer le compte") : un Label vide garde quand meme une hauteur
## minimale (une ligne de police), ce qui creusait un blanc visible entre les deux boutons avec les
## deux separations de 16px du VBoxContainer de part et d'autre. Cache par defaut (visible = false
## dans la scene) et dans refresh(), montre uniquement quand _on_save_pressed() lui donne un texte.
##
## PaysOption/icon_max_width = 84 (2026-08-26, retour utilisateur : "drapeau a reduire taille
## -30%") : le drapeau (assets/flags/flag_fr.svg, 120x80 natif, voir son .import) s'affichait a sa
## taille native dans l'OptionButton faute de limite - le theme_item icon_max_width de Button (dont
## OptionButton herite) plafonne la largeur et ajuste la hauteur au ratio (120 * 0.7 = 84).
class_name SectionProfile
extends Control

signal delete_account_requested

const COUNTRY_FLAG_FRANCE := preload("res://assets/flags/flag_fr.svg")

## Ordre d'affichage dans ClasseOption : index dans ce tableau == index selectionne, voir
## refresh()/_on_save_pressed().
const GRADE_OPTIONS: Array[GradeLevel.Grade] = [
	GradeLevel.Grade.CP,
	GradeLevel.Grade.CE1,
	GradeLevel.Grade.CE2,
	GradeLevel.Grade.CM1,
	GradeLevel.Grade.CM2,
]

@onready var nom_input: LineEdit = $VBoxContainer/NomRow/NomInput
@onready var prenom_input: LineEdit = $VBoxContainer/PrenomRow/PrenomInput
@onready var classe_option: OptionButton = $VBoxContainer/ClasseRow/ClasseOption
@onready var day_spin: SpinBox = $VBoxContainer/BirthdateRow/DaySpin
@onready var month_spin: SpinBox = $VBoxContainer/BirthdateRow/MonthSpin
@onready var year_spin: SpinBox = $VBoxContainer/BirthdateRow/YearSpin
@onready var pays_option: OptionButton = $VBoxContainer/PaysRow/PaysOption
@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var status_label: Label = $VBoxContainer/StatusLabel
@onready var delete_account_button: Button = $VBoxContainer/DeleteAccountButton

func _ready() -> void:
	for grade in GRADE_OPTIONS:
		classe_option.add_item(GradeLevel.get_label(grade))
	## Choix du pays DESACTIVE pour l'instant (2026-09-05, meme retour utilisateur que WelcomePanel :
	## "desactive le choix du pays... on laisse de cote l'option du pays") : PaysRow masque dans le
	## .tscn (visible=false). Le code ci-dessous continue de peupler pays_option (un seul item,
	## France, voir assets/flags/) pour ne rien casser si PaysRow redevient visible plus tard.
	pays_option.add_icon_item(COUNTRY_FLAG_FRANCE, "France")
	## Meme plage large que WelcomePanel (0-99 ans, voir son commentaire) pour rester coherent -
	## c'est un parent qui remplit ce champ, pas une contrainte de gameplay.
	var current_year: int = Time.get_date_dict_from_system(false).get("year", 2026)
	year_spin.min_value = current_year - 99
	year_spin.max_value = current_year
	save_button.pressed.connect(_on_save_pressed)
	delete_account_button.pressed.connect(func() -> void: delete_account_requested.emit())

## Recharge les champs a partir du profil du compte connecte - appele a chaque ouverture de cette
## section (voir GameMenuPanel._show_profile()), pas seulement a _ready(), pour refleter un
## eventuel changement de compte entre deux ouvertures du menu.
func refresh() -> void:
	status_label.text = ""
	status_label.visible = false
	var profile := SaveManager.get_current_profile()
	nom_input.text = String(profile.get("nom", ""))
	prenom_input.text = String(profile.get("prenom", ""))
	var grade: GradeLevel.Grade = int(profile.get("classe", GradeLevel.Grade.CP)) as GradeLevel.Grade
	var grade_index := GRADE_OPTIONS.find(grade)
	classe_option.selected = maxi(0, grade_index)
	var birthdate: Dictionary = profile.get("date_naissance", {})
	day_spin.value = int(birthdate.get("day", 1))
	month_spin.value = int(birthdate.get("month", 1))
	year_spin.value = int(birthdate.get("year", year_spin.max_value))
	## pays_option n'a qu'un seul item pour l'instant (France) : rien a selectionner tant qu'un
	## deuxieme pays n'existe pas.

func _on_save_pressed() -> void:
	var existing_profile := SaveManager.get_current_profile()
	var profile := {
		"nom": nom_input.text.strip_edges(),
		"prenom": prenom_input.text.strip_edges(),
		"classe": GRADE_OPTIONS[classe_option.selected],
		"date_naissance": {
			"year": int(year_spin.value),
			"month": int(month_spin.value),
			"day": int(day_spin.value),
		},
		"pays": "fr",
		## "Controle parental" (WelcomePanel, case a cocher + mot de passe dedie a l'inscription,
		## 2026-09-04/05) : pas encore de champ ici pour les modifier - repris tels quels du profil
		## existant (bool + hash/sel du mot de passe, voir SaveManager.
		## hash_parental_control_password()) pour ne pas les ecraser a chaque "Enregistrer". A
		## remplacer par une vraie case a cocher/un vrai champ le jour ou cette section gagne ses
		## propres options de controle parental (voir memoire projet).
		"controle_parental": existing_profile.get("controle_parental", false),
		"controle_parental_password_hash": existing_profile.get("controle_parental_password_hash", ""),
		"controle_parental_password_salt": existing_profile.get("controle_parental_password_salt", ""),
		## Limite quotidienne de jeux (SectionParentalControl, 2026-09-05) : meme prudence, aucun
		## champ ici pour la modifier, reprise telle quelle pour ne pas la reinitialiser a 0.
		"daily_game_limit": existing_profile.get("daily_game_limit", 0),
	}
	SaveManager.update_current_profile(profile)
	status_label.text = "Profil enregistré."
	status_label.visible = true
