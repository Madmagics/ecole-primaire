## Section "Informations personnelles" du menu de jeu (2026-08-01) : affiche le profil du compte
## CONNECTE (nom/prenom/date de naissance/pays), cree a l'origine par WelcomePanel.
##
## Passee en LECTURE SEULE le 2026-09-16 (voir TODO_UI_MODS.md, mods 3 et 4 - "l'enfant ne doit pas
## pouvoir modifier son profil - affiche grise/lecture seule, a titre informatif uniquement" et
## "supprimer 'classe' (juge sans utilite reelle)") : SaveButton/DeleteAccountButton et le signal
## delete_account_requested sont retires, tout comme ClasseRow/ClasseOption - toute modification
## (nom/prenom/date de naissance/pays/login/email/mot de passe) ainsi que la suppression du compte
## vivent desormais dans SectionParentalControl (deja verrouillee par son propre mot de passe,
## "c'est aux parents de gerer ca, pas a l'enfant"). Les champs restent des LineEdit/SpinBox
## (editable=false/focus_mode=0/mouse_filter=IGNORE dans le .tscn) plutot que de simples Label :
## ca reutilise exactement le meme rendu/alignement qu'avant sans dupliquer de mise en page, seul
## ReadOnlyGroup (modulate alpha 0.6, voir le .tscn) grise visuellement l'ensemble.
##
## DailyLimitInfoLabel (meme mod) : "avec reaffichage de la limitation quotidienne si elle est
## utilisee" - rappel informatif de la limite de jeux/jour reglee dans Contrôle parental, masque si
## aucune limite n'est active (0 = illimite, voir SaveManager.get_daily_game_limit()).
class_name SectionProfile
extends Control

const COUNTRY_FLAG_FRANCE := preload("res://assets/flags/flag_fr.svg")

@onready var nom_input: LineEdit = $VBoxContainer/ReadOnlyGroup/NomRow/NomInput
@onready var prenom_input: LineEdit = $VBoxContainer/ReadOnlyGroup/PrenomRow/PrenomInput
@onready var day_spin: SpinBox = $VBoxContainer/ReadOnlyGroup/BirthdateRow/DaySpin
@onready var month_spin: SpinBox = $VBoxContainer/ReadOnlyGroup/BirthdateRow/MonthSpin
@onready var year_spin: SpinBox = $VBoxContainer/ReadOnlyGroup/BirthdateRow/YearSpin
@onready var pays_option: OptionButton = $VBoxContainer/ReadOnlyGroup/PaysRow/PaysOption
@onready var daily_limit_info_label: Label = $VBoxContainer/DailyLimitInfoLabel

func _ready() -> void:
	## Choix du pays DESACTIVE pour l'instant (2026-09-05, retour utilisateur : "desactive le choix
	## du pays... on laisse de cote l'option du pays") : PaysRow masque dans le .tscn (visible=false).
	## Le code ci-dessous continue de peupler pays_option (un seul item, France, voir assets/flags/)
	## pour ne rien casser si PaysRow redevient visible plus tard.
	pays_option.add_icon_item(COUNTRY_FLAG_FRANCE, "France")
	var current_year: int = Time.get_date_dict_from_system(false).get("year", 2026)
	year_spin.min_value = current_year - 99
	year_spin.max_value = current_year

## Recharge les champs a partir du profil du compte connecte - appele a chaque ouverture de cette
## section (voir GameMenuPanel._show_profile()), pas seulement a _ready(), pour refleter un
## eventuel changement de compte OU une modification faite entre-temps depuis Contrôle parental.
func refresh() -> void:
	var profile := SaveManager.get_current_profile()
	nom_input.text = String(profile.get("nom", ""))
	prenom_input.text = String(profile.get("prenom", ""))
	var birthdate: Dictionary = profile.get("date_naissance", {})
	day_spin.value = int(birthdate.get("day", 1))
	month_spin.value = int(birthdate.get("month", 1))
	year_spin.value = int(birthdate.get("year", year_spin.max_value))
	## pays_option n'a qu'un seul item pour l'instant (France) : rien a selectionner tant qu'un
	## deuxieme pays n'existe pas.

	var limit := SaveManager.get_daily_game_limit()
	daily_limit_info_label.visible = limit > 0
	if limit > 0:
		daily_limit_info_label.text = "Limite de jeux par jour : %d" % limit
