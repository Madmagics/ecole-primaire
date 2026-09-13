## Ecran d'accueil : premiere chose visible au lancement tant que personne n'est connecte (voir
## SaveManager.current_account_id, toujours vide au demarrage). Propose de se connecter (pseudo +
## mot de passe) OU de creer un nouveau compte - PAS de liste des comptes existants affichee
## (retour utilisateur 2026-08-01 : on tape son pseudo, on ne le choisit pas dans une liste). Meme
## cadre visuel que les autres fenetres du jeu (Boutique/Inventaire/Album).
##
## La classe choisie a la creation est purement declarative (2026-08-29, retour utilisateur :
## suppression du deblocage de classe payant - toutes les classes sont accessibles des le depart,
## un enfant qui commence au CE2 peut reviser le CP/CE1 ou tester le CM1/CM2 sans rien acheter,
## voir QuestionGiverComponent) : elle sert seulement a pre-remplir le profil, l'ancien
## GradeUnlock.set_starting_grade() qui la figeait comme progression de depart est retire. La
## date de naissance n'est capturee que comme donnee de reference (aucun calcul d'age fait ici) -
## voir la memoire projet sur la localisation internationale pour son usage futur prevu.
##
## Selecteur d'avatar retire (2026-08-30, retour utilisateur : "jai supprime les assets de
## character car inutile au jeu, corrige le code pour faire disparaitre toute trace relative aux
## character (player) on ne garde que les npc") : AvatarRow/AvatarOptions (5 TextureButton) et la
## classe PlayerAvatars (ui/onboarding/player_avatars.gd, supprimee) referencaient
## assets/characters/player/*.png, vestige d'un ancien Player2D deja retire d'une session
## precedente (le jeu est en vue fixe/clic depuis le pivot CLASSE2.0, aucun personnage joueur a
## incarner). Le profil cree ici n'a plus de cle "avatar" - jamais lue nulle part ailleurs
## (SaveManager.create_account() ne l'attendait deja pas dans son propre commentaire de schema).
class_name WelcomePanel
extends Control

## Ecran desactive temporairement pendant le developpement (2026-08-26, demande utilisateur : "on
## desactive pour le moment l ecran darrivee login/pass le temps du dev, je te redirai dactiver ce
## menu d entree quand je voudrai l ameliorer") - repasser a true pour reactiver l'ecran d'accueil
## (connexion/creation de compte) au demarrage et apres suppression de compte. Tant que c'est a
## false, aucun compte n'est jamais connecte (current_account_id reste vide) : la progression
## (Economy/CardCollection/StatsTracker/GradeUnlock) fonctionne normalement en memoire mais n'est
## jamais ecrite sur le disque (SaveManager.save_current_account() ne fait rien sans compte
## connecte) - attendu le temps du dev, a garder en tete si une regression de sauvegarde semble
## apparaitre pendant que ce drapeau est desactive.
##
## Repasse a true le 2026-09-04 (retour utilisateur : ecran d'introduction plein ecran, image
## d'accueil placee dans assets/classe2.0/intro/) - voir aussi SaveManager.DEV_AUTO_LOGIN, repasse
## a false le meme jour (les deux ne doivent jamais etre actifs en meme temps, voir son
## commentaire). Cet ecran affiche desormais Background (image plein ecran) + IntroMenu (boutons
## "Entrer en classe"/"Quitter") au lieu d'aller directement au formulaire de connexion : Panel
## (formulaire pseudo/mot de passe ou creation de compte) ne s'affiche qu'au clic sur "Entrer en
## classe" (voir _on_enter_pressed ci-dessous). Reste l'ecran affiche a la fois au tout premier
## lancement ET apres une deconnexion/suppression de compte (voir _on_account_logged_out) - "cet
## ecran sera l'ecran de demarrage si on veut changer de compte ou se deconnecter" (demande
## utilisateur).
##
## EntrerButton/QuitterButton en TextureButton (2026-09-04, meme jour, retour utilisateur :
## "remplace les 2 boutons par les fichiers webp : quitter up/down et enter up/down") - au lieu de
## Button+text : texture_normal/texture_pressed pour l'etat relache/enfonce (confirme via
## docs.godotengine.org/en/4.7/classes/class_texturebutton.html), ignore_texture_size=true +
## stretch_mode=STRETCH_KEEP_ASPECT_CENTERED (5, meme enum que TextureRect) pour afficher ces
## grandes images source (~1020px de large) a une taille reduite (custom_minimum_size) sans
## deformer le ratio - meme combinaison que TitleIcon ailleurs dans le menu. Le texte du bouton est
## desormais dans l'image elle-meme, plus dans une propriete "text" separee.
##
## Mot de passe de controle parental (2026-09-05, retour utilisateur : "dans la fenetre de
## creation du jeu lorsque l'on coche controle parental, il faut proposer de creer un mot de
## passe, le mot de passe doit etre ecrit 2 fois, pas de prerequis si ce n'est de mettre 4
## caracteres minimum") : ParentalPasswordGroup (2 champs, masque par defaut) n'apparait que si
## ParentalControlCheck est coche (voir _on_parental_control_toggled) - reutilise
## SaveManager.MIN_PASSWORD_LENGTH (deja 4, meme regle que le mot de passe de connexion) plutot
## que de re-coder ce chiffre. Le hash+sel (SaveManager.hash_parental_control_password(), JAMAIS
## le mot de passe en clair) est stocke dans le profil - voir SectionParentalControl, qui le
## verifie pour (de)verrouiller ses options.
##
## ParentalControlFrame (2026-09-05, meme jour, 2e retour utilisateur : "on va decaler la case a
## cocher ainsi que le mot de passe et confirmation dans le panel : on les place contre confirmer
## le mot de passe de compte et la case creer le compte... jaimerais aussi placer ces 3 items dans
## un cadre pour separer legerement du reste du formulaire") : le trio ParentalControlCheck/
## ParentalPasswordGroup, initialement tout en haut de CreateList, deplace juste apres
## ConfirmPasswordRow (confirmation du mot de passe DE CONNEXION, a ne pas confondre) et avant
## CreateErrorLabel/CreateButton - regroupe dans un PanelContainer (style de cadre par defaut du
## theme, meme principe que Panel/Margin/Content au niveau de la fenetre elle-meme, voir plus haut)
## pour le separer visuellement du reste des champs d'inscription.
##
## ScrollMargin (2026-09-05, meme jour, 3e retour utilisateur : "applique une marge entre la barre
## de defilement et le contenu a sa gauche (exemple le cadre autour de controle parental touche la
## barre)") : MarginContainer insere entre CreateScroll (le ScrollContainer) et CreateList, avec
## seulement margin_right (16px) - la barre de defilement verticale de CreateScroll se dessine a
## droite, ce cadre laisse un espace entre elle et le contenu (dont ParentalControlFrame) au lieu
## de le laisser toucher la barre. Tous les chemins @onready sous CreateList (ci-dessous) passent
## desormais par ce noeud intermediaire.
##
## TitleRow/TitleSeparator (2026-09-05, meme jour, 4e retour utilisateur : "sur le modele des
## menus dans le jeu, applique une barre de separation entre le titre dans la fenetre et le
## contenu") : premiere version (HSeparator simple dans Content, flux VBoxContainer) remplacee le
## jour meme (5e retour, avec capture d'ecran : "la barre de separation doit toucher les bord du
## cadre de la fenetre et faire la meme epaisseur de trait que le cadre") par la VRAIE structure
## de GameMenuPanel/ShopPanel : Panel est repasse de PanelContainer a Panel (type de base, sans
## logique d'agencement automatique) pour pouvoir positionner TitleRow (titre + CloseButton) et
## TitleSeparator par ancres/offsets absolus, DIRECTEMENT enfants de Panel, EN DEHORS de Margin -
## Margin ne contient plus que Login/CreateSection, decale de offset_top=80 pour laisser la place
## a TitleRow (10-40) et TitleSeparator (55-59). 2 raisons a ce changement : (1) un PanelContainer
## ne peut pas empiler plusieurs enfants a des hauteurs fixes different (il les etire tous au meme
## rectangle), impossible d'obtenir un bandeau-titre fixe + une fine ligne + un contenu variable
## sans passer par un Panel classique comme les autres fenetres ; (2) PanelContainer utilisait le
## style de theme "PanelContainer/styles/panel" (StyleBoxFlat_row, bordure 3px) au lieu de
## "Panel/styles/panel" (StyleBoxFlat_panel, bordure 4px, LA MEME que "cadre" visuel des autres
## fenetres) - la separation HSeparator (StyleBoxLine_title_separator, epaisseur 4, meme couleur
## que StyleBoxFlat_panel) ne pouvait donc jamais correspondre exactement au cadre de CETTE
## fenetre tant qu'elle restait en PanelContainer, meme bien positionnee.
##
## ScrollMargin.margin_top = 6 (meme retour utilisateur, meme capture : la case Nom, premier
## champ de CreateList, avait sa bordure du HAUT invisible) : NomInput recoit le focus des
## l'ouverture de CreateSection (voir _show_create_section(), nom_input.grab_focus()) - l'anneau
## de focus du LineEdit deborde legerement au-dessus de son propre rectangle, et CreateScroll
## (ScrollContainer, qui coupe tout ce qui depasse sa zone visible) rognait ce debordement quand
## ScrollMargin n'avait aucune marge en haut (NomRow colle au bord superieur de la zone de
## defilement). Les 6px laissent la place a cet anneau de se dessiner en entier.
const ENABLED := true

const COUNTRY_FLAG_FRANCE := preload("res://assets/flags/flag_fr.svg")

## LoginButton/SwitchToCreateButton/CreateButton/SwitchToLoginButton en size_flags_horizontal =
## SIZE_SHRINK_BEGIN (0) depuis 2026-08-26 (retour utilisateur : "reduit de moitie la longueur des
## pushbutton, ils prennent actuellement toute la largeur de la fenetre") - voir SectionProfile.gd
## pour le detail du mecanisme (FILL par defaut = pleine largeur sur l'axe transversal d'un
## VBoxContainer, meme sans le flag EXPAND).
##
## PaysOption/icon_max_width = 84 depuis 2026-08-26 (retour utilisateur : "drapeau a reduire
## taille -30%") - meme correctif que SectionProfile.gd, sur le meme drapeau (flag_fr.svg, 120x80
## natif) partage entre les deux ecrans.
##
## Ordre d'affichage dans ClasseOption : index dans ce tableau == index selectionne dans
## l'OptionButton, voir _on_create_pressed().
const GRADE_OPTIONS: Array[GradeLevel.Grade] = [
	GradeLevel.Grade.CP,
	GradeLevel.Grade.CE1,
	GradeLevel.Grade.CE2,
	GradeLevel.Grade.CM1,
	GradeLevel.Grade.CM2,
]

## Pseudo propose par SaveManager.suggest_login_variant() quand le pseudo choisi a la creation est
## deja pris (voir point 5 de project_auth_creation_comptes.md) - retenu ici le temps que l'enfant
## clique sur LoginSuggestionButton (voir _on_create_pressed()/_on_login_suggestion_button_pressed()).
var _pending_login_suggestion: String = ""

@onready var background: TextureRect = $Background
@onready var intro_menu: HBoxContainer = $IntroMenu
@onready var enter_button: TextureButton = $IntroMenu/EntrerButton
@onready var quit_button: TextureButton = $IntroMenu/QuitterButton
@onready var panel: Panel = $Panel

@onready var close_button: Button = $Panel/TitleRow/CloseButton

@onready var login_section: VBoxContainer = $Panel/Margin/Content/LoginSection
@onready var create_section: VBoxContainer = $Panel/Margin/Content/CreateSection

@onready var login_input: LineEdit = $Panel/Margin/Content/LoginSection/LoginRow/LoginInput
@onready var password_input: LineEdit = $Panel/Margin/Content/LoginSection/PasswordRow/PasswordInput
@onready var login_error_label: Label = $Panel/Margin/Content/LoginSection/LoginErrorLabel
@onready var login_button: Button = $Panel/Margin/Content/LoginSection/LoginButton
@onready var switch_to_create_button: Button = $Panel/Margin/Content/LoginSection/SwitchToCreateButton
## Menu deroulant flottant des pseudos memorises (voir _on_login_input_text_changed et
## _position_login_suggestions_dropdown ci-dessous) : top_level=true dans le .tscn l'exclut de la
## mise en page de LoginSection (VBoxContainer) - sans ca, chaque suggestion repousserait
## PasswordRow/LoginButton vers le bas au lieu de flotter par-dessus. Declare EN DERNIER dans
## LoginSection (apres SwitchToCreateButton) pour se dessiner par-dessus les champs sous le pseudo
## (l'ordre de declaration des enfants d'un meme parent = l'ordre de dessin en Godot 4). Le
## ScrollContainer interne (LoginSuggestionsScroll) plafonne la hauteur affichee a 160px (~4-5
## suggestions) : au-dela, une barre de defilement apparait plutot que d'agrandir indefiniment le
## menu si beaucoup de pseudos partagent un prefixe commun (retour utilisateur 2026-09-09).
@onready var login_suggestions_dropdown: PanelContainer = $Panel/Margin/Content/LoginSection/LoginSuggestionsDropdown
@onready var login_suggestions_box: VBoxContainer = $Panel/Margin/Content/LoginSection/LoginSuggestionsDropdown/LoginSuggestionsScroll/LoginSuggestionsBox
@onready var pseudo_forget_button: Button = $Panel/Margin/Content/LoginSection/PseudoForgetButton

@onready var create_list: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList
@onready var parental_control_check: CheckBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalControlCheck
@onready var parental_password_group: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup
@onready var parental_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup/ParentalPasswordRow/ParentalPasswordInput
@onready var parental_password_confirm_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup/ParentalPasswordConfirmRow/ParentalPasswordConfirmInput
@onready var nom_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NomRow/NomInput
@onready var prenom_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/PrenomRow/PrenomInput
@onready var classe_option: OptionButton = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ClasseRow/ClasseOption
@onready var day_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/DaySpin
@onready var month_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/MonthSpin
@onready var year_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/YearSpin
@onready var pays_option: OptionButton = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/PaysRow/PaysOption
@onready var new_login_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NewLoginRow/NewLoginInput
@onready var login_suggestion_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/LoginSuggestionButton
@onready var new_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NewPasswordRow/NewPasswordInput
@onready var confirm_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ConfirmPasswordRow/ConfirmPasswordInput
@onready var create_error_label: Label = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CreateErrorLabel
@onready var create_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CreateButton
@onready var switch_to_login_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/SwitchToLoginButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	for grade in GRADE_OPTIONS:
		classe_option.add_item(GradeLevel.get_label(grade))
	## Choix du pays DESACTIVE pour l'instant (2026-09-05, retour utilisateur : "desactive le choix
	## du pays, si le jeu se developpe on y reviendra plus tard, en attendant on laisse de cote
	## l'option du pays") : PaysRow masque dans le .tscn (visible=false), voir aussi
	## SectionProfile, meme traitement. Le code ci-dessous continue de peupler pays_option (un seul
	## item, France, voir assets/flags/) et le profil garde "pays": "fr" en dur (voir
	## _on_create_pressed()) pour ne rien casser - il suffira de repasser PaysRow.visible a true le
	## jour ou un vrai choix multi-pays est redemande (voir memoire projet, localisation
	## internationale).
	pays_option.add_icon_item(COUNTRY_FLAG_FRANCE, "France")

	## Bornes de l'annee de naissance non figees en dur dans le .tscn : calculees a partir de la
	## date systeme (voir Time, confirme via docs.godotengine.org/en/4.7) pour ne jamais devenir
	## fausses au fil des annees. Plage large (0-99 ans, 2026-09-05 : "pour la date de naissance on
	## doit pouvoir entrer jusqu a un age de 99ans" - initialement 0-17 ans) plutot qu'etroite :
	## c'est un parent qui remplit ce champ, pas une contrainte de gameplay.
	var current_year: int = Time.get_date_dict_from_system(false).get("year", 2026)
	year_spin.min_value = current_year - 99
	year_spin.max_value = current_year
	year_spin.value = current_year - 7

	enter_button.pressed.connect(_on_enter_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	## Bouton "Quitter" retire sur la version Web (2026-09-12, retour utilisateur : "Quitter" fige
	## la page d'intro au lieu de fermer quoi que ce soit) : get_tree().quit() arrete la boucle du
	## moteur mais ne ferme jamais l'onglet - comportement documente du moteur sur export Web, pas
	## un bug (voir github.com/godotengine/godot issues #42783/#23010). Fermer l'onglet par script
	## (JavaScriptBridge.eval("window.close()")) ne fonctionnerait pas non plus : un navigateur ne
	## laisse un site fermer par script que les onglets QU'IL A LUI-MEME ouverts par script, jamais
	## un onglet ouvert normalement par le joueur (URL tapee, favori, lien) - restriction de securite
	## de tous les navigateurs, voir developer.mozilla.org/docs/Web/API/Window/close. "Quitter"
	## n'ayant donc pas de sens dans un onglet de navigateur, on le masque entierement sur le web ;
	## HBoxContainer (intro_menu) recentre automatiquement EntrerButton une fois QuitterButton caché.
	if OS.has_feature("web"):
		quit_button.hide()
	## Meme convention que ReadingIntroPanel/QuestionPanel/SubjectSelectPanel (HeaderRow + CloseButton
	## en haut a droite) - retour utilisateur : "ajoute une croix de fermeture a la fenetre en haut a
	## droite" (2026-09-04). Revient a l'ecran d'intro (les 2 gros boutons), PAS hide() : ce formulaire
	## n'est qu'une etape intermediaire, fermer ne veut pas dire "compte connecte".
	close_button.pressed.connect(_show_intro_menu)

	## Champs mot de passe de controle parental affiches seulement si la case est cochee (voir
	## commentaire de classe) - synchronise l'etat initial (case decochee par defaut dans le
	## .tscn) en plus de reagir a chaque bascule.
	parental_control_check.toggled.connect(_on_parental_control_toggled)
	_on_parental_control_toggled(parental_control_check.button_pressed)

	login_button.pressed.connect(_on_login_pressed)
	## Entree valide directement la connexion depuis l'un ou l'autre champ (LineEdit.
	## text_submitted, emis par Godot a l'appui sur Entree) - la creation de compte reste
	## volontairement au clic uniquement (retour utilisateur 2026-08-03), pas de _on_create_pressed
	## branche ici.
	login_input.text_submitted.connect(func(_text: String) -> void: _on_login_pressed())
	password_input.text_submitted.connect(func(_text: String) -> void: _on_login_pressed())
	switch_to_create_button.pressed.connect(_show_create_section)
	create_button.pressed.connect(_on_create_pressed)
	switch_to_login_button.pressed.connect(_show_login_section)

	## Autocompletion pseudo (2026-09-13, voir point 7 de project_auth_creation_comptes.md) +
	## suggestion de variante a la creation (point 5, meme fichier).
	login_input.text_changed.connect(_on_login_input_text_changed)
	pseudo_forget_button.pressed.connect(_on_pseudo_forget_pressed)
	login_suggestion_button.pressed.connect(_on_login_suggestion_button_pressed)
	## Une suggestion affichee devient perimee des que l'enfant retouche au champ - on la masque
	## plutot que de la laisser trainer sur un pseudo qui a change.
	new_login_input.text_changed.connect(func(_text: String) -> void: login_suggestion_button.hide())

	_show_login_section()
	visibility_changed.connect(_on_visibility_changed)
	## Suppression de compte (voir GameMenuPanel._do_delete_account) ou future deconnexion : cet
	## ecran doit revenir tout seul sans qu'il soit besoin de le referencer depuis le menu.
	SaveManager.account_logged_out.connect(_on_account_logged_out)

	## Personne n'est connecte au demarrage (voir SaveManager._ready()) : cet ecran doit donc
	## s'afficher des le lancement, avant meme toute interaction du joueur avec le parc - sauf si
	## ENABLED est desactive (voir plus haut, bascule temporaire de dev).
	if ENABLED and SaveManager.current_account_id.is_empty():
		show()
		_show_intro_menu()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

func _on_account_logged_out() -> void:
	if not ENABLED:
		return
	## Champs pseudo/mot de passe vides au retour sur l'ecran d'intro apres une deconnexion
	## (2026-09-05, retour utilisateur : "lorsqu on revient sur la page d intro apres setre
	## deconnecter, je veux que les cases log et pass soitent vierge") - sinon les identifiants du
	## compte qui vient de se deconnecter restaient affiches, pre-remplis pour le prochain compte a
	## se connecter sur le meme appareil.
	login_input.text = ""
	password_input.text = ""
	login_error_label.hide()
	pseudo_forget_button.hide()
	_clear_login_suggestions()
	show()
	_show_intro_menu()

## Etat de depart (et etat de retour apres deconnexion) : image d'accueil + les deux boutons
## "Entrer en classe"/"Quitter", formulaire de connexion masque.
func _show_intro_menu() -> void:
	intro_menu.show()
	panel.hide()

## "Entrer en classe" : bascule vers le formulaire (Panel), toujours sur l'onglet connexion
## (_show_login_section) - la creation de compte reste accessible depuis la, via
## SwitchToCreateButton, comme avant.
func _on_enter_pressed() -> void:
	intro_menu.hide()
	panel.show()
	_show_login_section()

## "Quitter" : ferme entierement le jeu (SceneTree.quit(), voir docs.godotengine.org/en/4.7/
## classes/class_scenetree.html - inchange depuis les versions precedentes de Godot).
func _on_quit_pressed() -> void:
	get_tree().quit()

func _show_login_section() -> void:
	login_section.show()
	create_section.hide()
	login_error_label.hide()
	pseudo_forget_button.visible = PseudoCache.has_pseudo(login_input.text)
	login_input.grab_focus()

func _show_create_section() -> void:
	login_section.hide()
	create_section.show()
	create_error_label.hide()
	login_suggestion_button.hide()
	nom_input.grab_focus()

## Affiche/masque ParentalPasswordGroup au fil de la case a cocher (voir commentaire de classe) -
## vide les 2 champs a la decoche pour ne jamais soumettre un mot de passe tape puis abandonne.
func _on_parental_control_toggled(is_checked: bool) -> void:
	parental_password_group.visible = is_checked
	if not is_checked:
		parental_password_input.clear()
		parental_password_confirm_input.clear()

func _on_login_pressed() -> void:
	if SaveManager.login(login_input.text, password_input.text):
		hide()
	else:
		login_error_label.text = "Pseudo ou mot de passe incorrect."
		login_error_label.show()

func _on_create_pressed() -> void:
	if new_password_input.text != confirm_password_input.text:
		create_error_label.text = "Les mots de passe ne correspondent pas."
		create_error_label.show()
		return
	## Mot de passe de controle parental (voir commentaire de classe) : memes regles que le mot de
	## passe de connexion (SaveManager.MIN_PASSWORD_LENGTH, ecrit 2 fois) mais uniquement si la
	## case est cochee - aucune contrainte si elle ne l'est pas.
	var is_parental_control := parental_control_check.button_pressed
	if is_parental_control:
		if parental_password_input.text.length() < SaveManager.MIN_PASSWORD_LENGTH:
			create_error_label.text = "Le mot de passe de contrôle parental doit faire au moins %d caractères." % SaveManager.MIN_PASSWORD_LENGTH
			create_error_label.show()
			return
		if parental_password_input.text != parental_password_confirm_input.text:
			create_error_label.text = "Les mots de passe de contrôle parental ne correspondent pas."
			create_error_label.show()
			return
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
		## Case a cocher ajoutee au debut du formulaire (2026-09-04, retour utilisateur : "on va
		## ajouter une case a cocher au debut : Controle parental, si celui ci est coche a
		## l'inscription on ajoutera des options dans le profil, garde en memoire controle parental
		## on y reviendra plus tard") : seule la valeur est capturee et stockee pour l'instant,
		## aucune option de controle parental construite derriere (voir memoire projet). Rejoint
		## SectionProfile._on_save_pressed(), qui doit la preserver tant qu'elle n'a pas sa propre
		## case a cocher (sinon un "Enregistrer" ecraserait ce choix, voir son commentaire).
		"controle_parental": is_parental_control,
	}
	if is_parental_control:
		## Hash+sel generes par SaveManager (jamais le mot de passe en clair) - voir
		## hash_parental_control_password() et SectionParentalControl, qui les verifie.
		var hashed := SaveManager.hash_parental_control_password(parental_password_input.text)
		profile["controle_parental_password_hash"] = hashed["hash"]
		profile["controle_parental_password_salt"] = hashed["salt"]
	var error := SaveManager.create_account(new_login_input.text, new_password_input.text, profile)
	if error.is_empty():
		hide()
		return
	create_error_label.text = error
	create_error_label.show()
	## Suggestion automatique de variante (2026-09-13, voir point 5 de project_auth_creation_
	## comptes.md) : plutot que de laisser l'enfant inventer lui-meme une variante de plus en plus
	## compliquee, on lui en propose une toute prete, qu'il peut accepter d'un clic.
	if error == "Ce pseudo est déjà pris.":
		_pending_login_suggestion = SaveManager.suggest_login_variant(new_login_input.text.strip_edges())
		login_suggestion_button.text = "Utiliser « %s » ?" % _pending_login_suggestion
		login_suggestion_button.show()
	else:
		login_suggestion_button.hide()

func _on_login_suggestion_button_pressed() -> void:
	new_login_input.text = _pending_login_suggestion
	login_suggestion_button.hide()
	create_error_label.hide()

## Autocompletion du pseudo a la connexion (2026-09-13, voir point 7 de project_auth_creation_
## comptes.md) : PAS de liste affichee au focus (trop visible sur un PC partage, retour utilisateur
## 2026-08-01 deja applique a la creation de compte, voir commentaire de classe) - les suggestions
## n'apparaissent qu'a partir de 2 caracteres tapes, filtrees par prefixe sur PseudoCache (pseudos
## deja utilises avec succes SUR CET APPAREIL). LoginSuggestionsBox (VBoxContainer de Button crees a
## la volee), PAS un PopupMenu/Window : un Popup capte le clavier des son ouverture dans Godot 4 et
## ferait perdre le focus au LineEdit en plein milieu de la frappe, ce qui casserait exactement
## l'usage vise ici (continuer a taper pendant que des suggestions s'affichent).
func _on_login_input_text_changed(new_text: String) -> void:
	pseudo_forget_button.visible = PseudoCache.has_pseudo(new_text)
	_clear_login_suggestions()
	if new_text.length() < 2:
		return
	for suggestion in PseudoCache.get_suggestions(new_text):
		var button := Button.new()
		button.text = suggestion
		button.size_flags_horizontal = 3
		## Capture par valeur (suggestion est une variable de boucle, voir GDScript closures) -
		## chaque bouton reste bien associe a SON propre pseudo.
		button.pressed.connect(func() -> void: _on_login_suggestion_chosen(suggestion))
		login_suggestions_box.add_child(button)
	if login_suggestions_box.get_child_count() > 0:
		_position_login_suggestions_dropdown()
		login_suggestions_dropdown.show()

## Ancre le menu deroulant a DROITE de LoginInput (2026-09-13, retour utilisateur : "decale les
## propositions de login a droite de la case de saisie pseudo" - remplace le positionnement sous le
## champ) - recalcule a chaque appel plutot que fige une fois (voir _on_login_input_text_changed)
## car global_position n'est fiable qu'une fois LoginInput reellement mis en page par son
## HBoxContainer parent. Largeur inchangee (meme largeur que le champ) : seul le cote change.
func _position_login_suggestions_dropdown() -> void:
	login_suggestions_dropdown.custom_minimum_size.x = login_input.size.x
	login_suggestions_dropdown.global_position = login_input.global_position + Vector2(login_input.size.x + 12.0, 0.0)

func _on_login_suggestion_chosen(pseudo: String) -> void:
	login_input.text = pseudo
	pseudo_forget_button.visible = true
	_clear_login_suggestions()
	password_input.grab_focus()

func _clear_login_suggestions() -> void:
	for child in login_suggestions_box.get_children():
		child.queue_free()
	login_suggestions_dropdown.hide()

## "Oublier ce pseudo sur cet appareil" (meme point 7) - ne touche qu'au cache local (PseudoCache),
## jamais au compte lui-meme, aucun mot de passe implique.
func _on_pseudo_forget_pressed() -> void:
	PseudoCache.forget(login_input.text)
	pseudo_forget_button.hide()
