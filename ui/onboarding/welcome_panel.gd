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
##
## Email + captcha obligatoires a la creation (2026-09-15, demande utilisateur, voir
## project_auth_creation_comptes.md) : EmailRow (nouveau champ, apres ConfirmPasswordRow) et
## CaptchaFrame (nouveau cadre, meme principe visuel que ParentalControlFrame, entre ce dernier et
## CreateErrorLabel) - voir TURNSTILE_SITE_KEY/_is_web plus bas pour le detail des 2 chemins (Web :
## widget Turnstile en superposition JS ; hors Web, en pratique seulement l'editeur en dev : bouton
## qui ouvre captcha.html dans le navigateur systeme + champ pour retaper le code). La creation
## passe desormais par SaveManager.create_account_online() (attend la confirmation serveur) au lieu
## de create_account() (offline-first, encore utilisee par SaveManager.DEV_AUTO_LOGIN uniquement).
##
## Controle parental desormais OBLIGATOIRE a la creation (2026-09-16, voir TODO_UI_MODS.md mod 5 -
## "rendre le controle parental systematique, plus optionnel") : ParentalControlCheck passe a
## button_pressed=true/disabled=true dans le .tscn (case cochee, grisee, impossible a decocher)
## plutot que d'etre retiree - _on_parental_control_toggled()/_on_create_pressed() ci-dessous n'ont
## PAS besoin de changer, ils continuent de lire button_pressed normalement (toujours true
## desormais) : le mot de passe de controle parental reste donc toujours demande et valide.
##
## "Mot de passe oublié" + blocage email non confirme (2026-09-16, meme reprise de
## TODO_UI_MODS.md, mods 1 et bug "acces au jeu possible avant confirmation d'email") :
## ForgotPasswordSection (lien depuis LoginSection, voir ForgotPasswordButton) et
## EmailPendingSection (affichee a la place du jeu si login()/create_account_online() reussit mais
## que SaveManager.current_account_needs_email_verification() est vrai) sont deux nouvelles
## sections enfants de Content, au meme niveau que LoginSection/CreateSection - _show_xxx_section()
## masque toujours les 4 en meme temps (voir les nouvelles fonctions plus bas) pour ne jamais en
## avoir deux affichees a la fois. EmailPendingSection ne fait PAS hide() sur ce panneau : tant
## qu'elle est affichee, WelcomePanel reste visible (donc PlayerInputLock reste verrouille, voir
## _on_visibility_changed) meme si SaveManager.current_account_id est deja rempli - c'est le choix
## le plus simple pour reutiliser le jeton de session deja obtenu (necessaire aux boutons "renvoyer
## l'email"/"j'ai confirme, verifier a nouveau") sans redemander une 2e authentification.
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
## GRADE_OPTIONS/ClasseOption retires (2026-09-16, correctif suite a un oubli du mod 4 de
## TODO_UI_MODS.md : "classe" avait ete retire de SectionProfile mais pas du formulaire de creation
## de compte, qui la redemandait encore) - "classe" reste une cle du dictionnaire "profile" (voir
## SectionParentalControl._on_personal_info_save_pressed(), qui la relit en fallback), donc
## _on_create_pressed() lui donne desormais directement une valeur fixe plutot que de la lire sur
## un OptionButton qui n'existe plus (voir plus bas).

## Email + captcha obligatoires a la creation (2026-09-15, demande utilisateur : le jeu est joue
## en priorite DANS UN NAVIGATEUR - desktop, tablette ou telephone, tous "Web" du point de vue de
## Godot, voir _is_web plus bas) - voir project_auth_creation_comptes.md/SaveManager.
## create_account_online(). Site Key Turnstile PUBLIQUE (voir autoload/server_api.gd pour la
## meme logique sur ANON_KEY) - sans danger a coder en dur, concue pour etre embarquee cote client.
const TURNSTILE_SITE_KEY := "0x4AAAAAAE0EDJZpy-RwAN5-"
## Page ouverte dans le navigateur SYSTEME (OS.shell_open, voir _on_captcha_desktop_button_pressed)
## quand ce client tourne HORS export Web - concretement seulement en lancant le jeu depuis
## l'editeur Godot en dev (voir _is_web plus bas), aucun joueur reel ne passe par ce chemin
## puisque le jeu n'est distribue QUE via l'export Web (voir project_deploiement_web.md).
const CAPTCHA_PAGE_URL := "https://www.ecole-primaire.eu/captcha.html"

## Pseudo propose par SaveManager.suggest_login_variant() quand le pseudo choisi a la creation est
## deja pris (voir point 5 de project_auth_creation_comptes.md) - retenu ici le temps que l'enfant
## clique sur LoginSuggestionButton (voir _on_create_pressed()/_on_login_suggestion_button_pressed()).
var _pending_login_suggestion: String = ""

## Valeurs par defaut du formulaire de creation (jour/mois/annee de naissance), capturees
## une seule fois dans _ready() juste apres que year_spin.value ait ete calcule depuis la
## date systeme (voir plus bas) - reutilisees par _show_create_section() pour remettre ces 3
## champs a un etat neutre plutot que de laisser trainer la date du compte precedent (voir
## commentaire de _show_create_section()).
var _default_birth_day: float = 1.0
var _default_birth_month: float = 1.0
var _default_birth_year: float = 2018.0

## true si ce client tourne dans l'export Web (navigateur, quelle que soit la plateforme physique -
## desktop/tablette/telephone comptent tous comme "Web" ici) - decide UNE FOIS dans _ready(),
## controle quelle moitie de CaptchaFrame est visible (voir commentaire de TURNSTILE_SITE_KEY).
var _is_web: bool = false

## Token Turnstile valide obtenu par le widget integre (Web uniquement, voir _start_web_captcha) -
## vide tant qu'aucune verification n'a reussi. PAS encore consomme cote serveur a ce stade (voir
## _on_create_pressed()) : reste utilisable jusqu'a expiration naturelle du token (quelques
## minutes) ou jusqu'a l'appel reel a fn_creer_compte_public.
var _turnstile_token: String = ""

## Reference JS conservee tant que ce panneau existe (voir doc JavaScriptBridge.create_callback :
## "the reference must be kept until the callback happens") - creee une seule fois dans
## _start_web_captcha(), jamais recreee aux tentatives suivantes.
var _turnstile_js_callback: JavaScriptObject

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
@onready var forgot_password_button: LinkButton = $Panel/Margin/Content/LoginSection/ForgotPasswordButton

## "Mot de passe oublié" (2026-09-16, voir TODO_UI_MODS.md mod 1) : petit formulaire separe
## (pseudo/email + bouton d'envoi), pas une simple boite de dialogue - reutilise le meme cadre que
## LoginSection/CreateSection (voir _show_forgot_password_section()).
@onready var forgot_password_section: VBoxContainer = $Panel/Margin/Content/ForgotPasswordSection
@onready var forgot_login_input: LineEdit = $Panel/Margin/Content/ForgotPasswordSection/ForgotLoginRow/ForgotLoginInput
@onready var forgot_send_button: Button = $Panel/Margin/Content/ForgotPasswordSection/ForgotSendButton
@onready var forgot_status_label: Label = $Panel/Margin/Content/ForgotPasswordSection/ForgotStatusLabel
@onready var forgot_back_button: Button = $Panel/Margin/Content/ForgotPasswordSection/ForgotBackButton

## "Vérifie ta boîte mail" (2026-09-16, voir TODO_UI_MODS.md, bug "accès au jeu possible avant
## confirmation d'email") : affichee a la place du jeu tant que l'email du compte connecte n'est
## pas confirme (voir SaveManager.current_account_needs_email_verification()) - voir le commentaire
## de classe pour le detail de ce choix (WelcomePanel reste visible, PAS de hide()).
@onready var email_pending_section: VBoxContainer = $Panel/Margin/Content/EmailPendingSection
@onready var resend_email_button: Button = $Panel/Margin/Content/EmailPendingSection/ResendEmailButton
@onready var resend_email_status_label: Label = $Panel/Margin/Content/EmailPendingSection/ResendEmailStatusLabel
@onready var recheck_email_button: Button = $Panel/Margin/Content/EmailPendingSection/RecheckEmailButton
@onready var recheck_email_status_label: Label = $Panel/Margin/Content/EmailPendingSection/RecheckEmailStatusLabel

@onready var create_list: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList
@onready var parental_control_check: CheckBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalControlCheck
@onready var parental_password_group: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup
@onready var parental_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup/ParentalPasswordRow/ParentalPasswordInput
@onready var parental_password_confirm_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ParentalControlFrame/Margin/Content/ParentalPasswordGroup/ParentalPasswordConfirmRow/ParentalPasswordConfirmInput
@onready var nom_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NomRow/NomInput
@onready var prenom_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/PrenomRow/PrenomInput
@onready var day_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/DaySpin
@onready var month_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/MonthSpin
@onready var year_spin: SpinBox = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/BirthdateRow/YearSpin
@onready var pays_option: OptionButton = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/PaysRow/PaysOption
@onready var new_login_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NewLoginRow/NewLoginInput
@onready var login_suggestion_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/LoginSuggestionButton
@onready var new_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/NewPasswordRow/NewPasswordInput
@onready var confirm_password_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/ConfirmPasswordRow/ConfirmPasswordInput
@onready var email_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/EmailRow/EmailInput
@onready var captcha_web_group: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaWebGroup
@onready var captcha_web_status_label: Label = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaWebGroup/CaptchaWebStatusLabel
@onready var captcha_web_retry_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaWebGroup/CaptchaWebRetryButton
@onready var captcha_desktop_group: VBoxContainer = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaDesktopGroup
@onready var captcha_desktop_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaDesktopGroup/CaptchaDesktopButton
@onready var captcha_code_input: LineEdit = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaDesktopGroup/CaptchaCodeRow/CaptchaCodeInput
@onready var captcha_desktop_status_label: Label = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CaptchaFrame/Margin/Content/CaptchaDesktopGroup/CaptchaDesktopStatusLabel
@onready var create_error_label: Label = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CreateErrorLabel
@onready var create_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/CreateButton
@onready var switch_to_login_button: Button = $Panel/Margin/Content/CreateSection/CreateScroll/ScrollMargin/CreateList/SwitchToLoginButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	## Glissement au doigt possible depuis n'importe quelle zone (pas seulement la fine barre
	## de defilement) sur CreateScroll/LoginSuggestionsScroll - voir ui/common/touch_scroll_fix.gd
	## pour l'explication complete (retour utilisateur 2026-09-18).
	TouchScrollFix.allow_scroll_passthrough(panel)

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
	_default_birth_day = day_spin.value
	_default_birth_month = month_spin.value
	_default_birth_year = year_spin.value

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

	## Decide une seule fois pour toute la duree de vie de ce panneau (voir commentaire de _is_web) -
	## controle quelle moitie de CaptchaFrame reste visible (l'autre est masquee ici, jamais montree
	## par erreur si _show_create_section() est appele avant que ceci ait tourne).
	_is_web = OS.has_feature("web")
	captcha_web_group.visible = _is_web
	captcha_desktop_group.visible = not _is_web
	captcha_desktop_button.pressed.connect(_on_captcha_desktop_button_pressed)
	captcha_web_retry_button.pressed.connect(_on_captcha_web_retry_pressed)

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

	## "Mot de passe oublié" (2026-09-16, mod 1) + blocage email non confirme (meme reprise, voir
	## le bug correspondant dans TODO_UI_MODS.md).
	forgot_password_button.pressed.connect(_show_forgot_password_section)
	forgot_send_button.pressed.connect(_on_forgot_send_pressed)
	forgot_back_button.pressed.connect(_show_login_section)
	resend_email_button.pressed.connect(_on_resend_email_pressed)
	recheck_email_button.pressed.connect(_on_recheck_email_pressed)
	## Une suggestion affichee devient perimee des que l'enfant retouche au champ - on la masque
	## plutot que de la laisser trainer sur un pseudo qui a change.
	new_login_input.text_changed.connect(func(_text: String) -> void: login_suggestion_button.hide())

	## Clavier virtuel mobile qui ne s'affiche pas en plein ecran (2026-09-19, retour utilisateur) :
	## limitation connue et NON RESOLUE cote moteur Godot (voir github.com/godotengine/godot issue
	## #117342, confirmee toujours ouverte au 2026-09-19) - la Fullscreen API des navigateurs mobiles
	## (Android ET iOS) bloque le clavier virtuel tant que la page est en vrai plein ecran, quel que
	## soit le champ concerne. Contournement communautaire (aucun correctif moteur disponible) :
	## sortir du plein ecran des qu'un champ de ce formulaire recoit le focus (le clavier peut alors
	## s'afficher), y revenir des qu'il le perd - SEULEMENT si le joueur avait active le plein ecran
	## (SaveManager.fullscreen), jamais si le jeu tournait deja en fenetre. find_children (recursif,
	## voir docs.godotengine.org/en/4.7/classes/class_node.html#class-node-method-find-children) sur
	## TOUTES les LineEdit du panneau plutot qu'un branchement champ par champ : ce formulaire en
	## compte 12, et un futur champ ajoute ici herite du comportement sans rebranchage manuel.
	## Limite assumee : remettre le plein ecran automatiquement peut echouer sur certains navigateurs
	## mobiles (la Fullscreen API exige parfois un geste utilisateur direct pour se reactiver, un
	## focus perdu n'en est pas toujours un) - dans ce cas le joueur devra retoucher la case "Plein
	## ecran" des Options pour y revenir, degrade mais jamais bloquant. Voir aussi
	## _on_form_field_focus_entered()/_exited() plus bas.
	for field: Node in find_children("*", "LineEdit", true, true):
		var line_edit := field as LineEdit
		line_edit.focus_entered.connect(_on_form_field_focus_entered)
		line_edit.focus_exited.connect(_on_form_field_focus_exited)

	_show_login_section()
	visibility_changed.connect(_on_visibility_changed)
	## Suppression de compte (voir GameMenuPanel._do_delete_account) ou future deconnexion : cet
	## ecran doit revenir tout seul sans qu'il soit besoin de le referencer depuis le menu.
	SaveManager.account_logged_out.connect(_on_account_logged_out)
	## Deconnexion FORCEE par le serveur (2026-09-17, chantier "synchro systematique" - voir le
	## commentaire de SaveManager.server_connection_lost) : logout() (appele par
	## _disconnect_due_to_server_failure()) emet DEJA account_logged_out juste avant ce signal, donc
	## _on_account_logged_out() a deja tourne (champs vides, ecran d'accueil affiche) au moment ou
	## _on_server_connection_lost() ci-dessous s'execute - elle n'a plus qu'a rediriger vers le
	## formulaire de connexion et y superposer le message d'erreur.
	SaveManager.server_connection_lost.connect(_on_server_connection_lost)

	## Personne n'est connecte au demarrage (voir SaveManager._ready()) : cet ecran doit donc
	## s'afficher des le lancement, avant meme toute interaction du joueur avec le parc - sauf si
	## ENABLED est desactive (voir plus haut, bascule temporaire de dev).
	if ENABLED and SaveManager.current_account_id.is_empty():
		show()
		_show_intro_menu()

## Contournement clavier virtuel mobile + plein ecran (voir le commentaire complet dans _ready(),
## juste avant la boucle find_children) - issue moteur non resolue github.com/godotengine/godot
## #117342. Bascule en fenetre le temps de la saisie, uniquement si le plein ecran est actif.
func _on_form_field_focus_entered() -> void:
	if _is_web and SaveManager.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

## Restaure le plein ecran une fois la saisie terminee - peut echouer sur certains navigateurs
## mobiles si la Fullscreen API exige un geste utilisateur direct (voir meme commentaire).
func _on_form_field_focus_exited() -> void:
	if _is_web and SaveManager.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

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

## Reaction a SaveManager.server_connection_lost (2026-09-17, chantier "synchro systematique") :
## _on_account_logged_out() ci-dessus vient deja de remettre cet ecran sur les 2 gros boutons
## (voir son commentaire d'ordre d'emission cote SaveManager) - va ici directement sur le
## formulaire de connexion, PAS sur les 2 boutons, pour que l'enfant/le parent puisse retaper le
## mot de passe et repartir tout de suite, avec le message explicite affiche par-dessus (meme
## pattern que "Pseudo ou mot de passe incorrect."/"Ce compte est déjà connecté..." dans
## _on_login_pressed()).
func _on_server_connection_lost(message: String) -> void:
	if not ENABLED:
		return
	show()
	intro_menu.hide()
	panel.show()
	_show_login_section()
	login_error_label.text = message
	login_error_label.show()

## Etat de depart (et etat de retour apres deconnexion) : image d'accueil + les deux boutons
## "Entrer en classe"/"Quitter", formulaire de connexion masque.
func _show_intro_menu() -> void:
	intro_menu.show()
	panel.hide()
	## Le widget Turnstile (Web) vit dans une superposition JS PAR-DESSUS le canvas du jeu, hors du
	## controle de Godot (voir _start_web_captcha) - sans ce nettoyage, elle resterait affichee a
	## l'ecran meme apres avoir quitte le formulaire de creation.
	if _is_web:
		_remove_turnstile_overlay()

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
	forgot_password_section.hide()
	email_pending_section.hide()
	login_error_label.hide()
	pseudo_forget_button.visible = PseudoCache.has_pseudo(login_input.text)
	login_input.grab_focus()
	## Meme raison que _show_intro_menu() ci-dessus - la superposition Turnstile ne doit jamais
	## rester affichee en dehors du formulaire de creation.
	if _is_web:
		_remove_turnstile_overlay()

## "Mot de passe oublié" (2026-09-16, mod 1) : reprend le pseudo deja tape sur l'ecran de
## connexion (souvent deja rempli, voir PseudoCache) plutot que de repartir d'un champ vide.
func _show_forgot_password_section() -> void:
	login_section.hide()
	create_section.hide()
	email_pending_section.hide()
	forgot_password_section.show()
	forgot_status_label.hide()
	forgot_login_input.text = login_input.text
	forgot_login_input.grab_focus()

## "Vérifie ta boîte mail" (2026-09-16, bug email non confirme) : voir le commentaire de classe -
## WelcomePanel reste VISIBLE (pas de hide()), seule la section affichee a l'interieur change.
func _show_email_pending_section() -> void:
	login_section.hide()
	create_section.hide()
	forgot_password_section.hide()
	email_pending_section.show()
	resend_email_status_label.hide()
	recheck_email_status_label.hide()
	show()

func _show_create_section() -> void:
	login_section.hide()
	forgot_password_section.hide()
	email_pending_section.hide()
	create_section.show()
	create_error_label.hide()
	login_suggestion_button.hide()
	_pending_login_suggestion = ""
	## Formulaire remis a neuf a CHAQUE ouverture (2026-09-17, bug signale par l'utilisateur :
	## "quand je cree un nouveau compte, que j'entre dans le jeu puis je me deconnecte et je cree
	## un autre nouveau compte, le formulaire a garde en memoire les infos de creation du compte
	## precedent" - jusqu'ici seuls email/captcha etaient vides ici, voir plus bas) : nom/prenom/
	## pseudo/mot de passe/confirmation/mot de passe de controle parental restaient tels que tapes
	## pour le compte precedent, et la date de naissance restait sur celle entree la derniere fois
	## au lieu de revenir a sa valeur neutre - un parent qui cree un 2e compte pour un autre enfant
	## sur le meme appareil se retrouvait donc a soumettre par erreur des infos du premier compte
	## s'il ne repensait pas a tout re-effacer lui-meme.
	nom_input.clear()
	prenom_input.clear()
	day_spin.value = _default_birth_day
	month_spin.value = _default_birth_month
	year_spin.value = _default_birth_year
	new_login_input.clear()
	new_password_input.clear()
	confirm_password_input.clear()
	parental_password_input.clear()
	parental_password_confirm_input.clear()
	## Email + captcha obligatoires (voir commentaire de TURNSTILE_SITE_KEY) : repart toujours d'un
	## etat neuf a l'ouverture du formulaire plutot que de conserver un email/code d'une visite
	## precedente - un token/code perime redonnerait une erreur "captcha_invalide" bien plus
	## deroutante pour un enfant qu'un formulaire simplement vide a re-remplir.
	email_input.clear()
	captcha_code_input.clear()
	captcha_desktop_status_label.hide()
	if _is_web:
		_start_web_captcha()
	nom_input.grab_focus()

## Affiche/masque ParentalPasswordGroup au fil de la case a cocher (voir commentaire de classe) -
## vide les 2 champs a la decoche pour ne jamais soumettre un mot de passe tape puis abandonne.
func _on_parental_control_toggled(is_checked: bool) -> void:
	parental_password_group.visible = is_checked
	if not is_checked:
		parental_password_input.clear()
		parental_password_confirm_input.clear()

func _on_login_pressed() -> void:
	## Devenu asynchrone le 2026-09-13 (SaveManager.login() interroge desormais toujours le serveur,
	## meme pour un pseudo deja connu de cet appareil - chantiers "connexion cross-device" ET
	## "conflit de connexion", voir le commentaire de login()) : le bouton est desactive le temps de
	## l'attente reseau (jusqu'a 8s si le VPS est injoignable, voir ServerApi.TIMEOUT_SECONDS) pour
	## eviter qu'un double-clic ne lance deux tentatives en parallele.
	login_button.disabled = true
	login_error_label.hide()
	var success := await SaveManager.login(login_input.text, password_input.text)
	login_button.disabled = false
	if success:
		## Blocage dur avant confirmation d'email (2026-09-16, voir TODO_UI_MODS.md) : verifie a
		## CHAQUE connexion (pas seulement a la creation), voir SaveManager.
		## current_account_needs_email_verification() - reflete la reponse SERVEUR la plus recente
		## obtenue par SaveManager.login() (fn_login renvoie desormais aussi email/email_verifie).
		## [success] ne peut plus etre true sans confirmation serveur depuis le 2026-09-17 (chantier
		## "premiere connexion online obligatoire", voir le commentaire de SaveManager.login()) - ce
		## n'est donc plus jamais une valeur locale perimee ici.
		if SaveManager.current_account_needs_email_verification():
			_show_email_pending_section()
		else:
			hide()
	elif SaveManager.last_login_error == "connexion_requise":
		## 2026-09-17, chantier "premiere connexion online obligatoire" (voir le commentaire de
		## SaveManager.last_login_error) : la connexion serveur a echoue (reseau coupe, VPS
		## injoignable, ou connexion perdue en cours de handshake) - le joueur n'a pas forcement tape
		## un mauvais mot de passe, inutile de le lui laisser croire.
		login_error_label.text = "Impossible de contacter le serveur. Vérifie ta connexion internet et réessaie."
		login_error_label.show()
	else:
		login_error_label.text = "Pseudo ou mot de passe incorrect."
		login_error_label.show()

## Devenue asynchrone le 2026-09-15 (email + captcha obligatoires, voir commentaire de
## TURNSTILE_SITE_KEY) : SaveManager.create_account_online() attend la reponse du serveur avant de
## creer quoi que ce soit en local (contrairement a l'ancien SaveManager.create_account(), encore
## utilise par SaveManager.DEV_AUTO_LOGIN, voir son commentaire) - le bouton est desactive le temps
## de l'attente reseau, meme principe que _on_login_pressed() ci-dessus.
func _on_create_pressed() -> void:
	if new_password_input.text != confirm_password_input.text:
		create_error_label.text = "Les mots de passe ne correspondent pas."
		create_error_label.show()
		return

	var email := email_input.text.strip_edges()
	if email.is_empty():
		create_error_label.text = "L'email est obligatoire pour créer un compte."
		create_error_label.show()
		return
	## Verification volontairement grossiere (presence d'un "@" suivi d'un "." plus loin) - PAS une
	## validation stricte au sens RFC 5322, inutile ici : le vrai controle est le clic sur le lien
	## de confirmation envoye par Brevo (voir fn_verifier_email dans schema.sql). Ca evite juste une
	## faute de frappe evidente avant de consommer un captcha pour rien.
	var arobase := email.find("@")
	if arobase == -1 or not email.substr(arobase).contains("."):
		create_error_label.text = "Cette adresse email n'a pas l'air valide."
		create_error_label.show()
		return

	var turnstile_token := ""
	var code_captcha := ""
	if _is_web:
		if _turnstile_token.is_empty():
			create_error_label.text = "Termine la vérification anti-robot avant de continuer."
			create_error_label.show()
			return
		turnstile_token = _turnstile_token
	else:
		code_captcha = captcha_code_input.text.strip_edges()
		if code_captcha.is_empty():
			create_error_label.text = "Retape le code reçu après la vérification dans le navigateur."
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
		## Valeur fixe (voir commentaire de classe pres de l'ancien GRADE_OPTIONS) : toutes les
		## classes sont accessibles des la creation (GradeUnlock retire le 2026-08-29), "classe" est
		## purement declarative et n'est plus demandee au formulaire - CP choisi comme valeur neutre
		## par defaut, modifiable ensuite si besoin (mod 6, onglet Controle parental).
		"classe": GradeLevel.Grade.CP,
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
	create_button.disabled = true
	create_error_label.hide()
	var error := await SaveManager.create_account_online(new_login_input.text, new_password_input.text, profile, email, turnstile_token, code_captcha)
	create_button.disabled = false
	if error.is_empty():
		## "À la création du compte : au lieu d'entrer dans le jeu, afficher un écran 'Vérifie ta
		## boîte mail'" (2026-09-16, voir TODO_UI_MODS.md) - un compte frais cree via ce formulaire
		## n'a par definition jamais encore confirme son email (email_verifie=false cote serveur).
		_show_email_pending_section()
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
	## Un code retape invalide/expire a deja ete consomme cote serveur si jamais il existait (usage
	## unique, voir defis_captcha dans schema.sql) - jamais reutilisable tel quel, on vide le champ
	## pour eviter un 2e essai voue silencieusement au meme echec.
	if not _is_web:
		captcha_code_input.clear()

## Lance (ou relance, voir _on_captcha_web_retry_pressed) une verification Turnstile sur Web : cree
## une superposition HTML PAR-DESSUS le canvas du jeu (position:fixed, hors du controle de Godot -
## la seule facon d'afficher un vrai widget Turnstile, qui a besoin du DOM/d'un iframe) plutot que
## d'essayer de l'incruster A L'INTERIEUR du canvas (impossible, le canvas est une simple surface
## de rendu WebGL sans DOM). window.turnstile peut ne pas encore etre charge au tout premier appel
## (script "async defer", voir export_presets.cfg > html/head_include) - reessaie pendant 5s avant
## d'abandonner.
func _start_web_captcha() -> void:
	_turnstile_token = ""
	captcha_web_status_label.text = "Vérification anti-robot en cours…"
	## Cree UNE SEULE FOIS pour toute la duree de vie du panneau (voir commentaire de
	## _turnstile_js_callback) - JavaScriptBridge.get_interface("window") expose l'objet global
	## "window" du navigateur, sur lequel on pose une propriete portant la reference Callable :
	## c'est ce qui permet au JS injecte plus bas de rappeler _on_turnstile_token_received().
	if _turnstile_js_callback == null:
		_turnstile_js_callback = JavaScriptBridge.create_callback(_on_turnstile_token_received)
		var window_obj: JavaScriptObject = JavaScriptBridge.get_interface("window")
		window_obj.godotTurnstileCallback = _turnstile_js_callback
	JavaScriptBridge.eval("""
	(function() {
		var ancien = document.getElementById('turnstile-overlay');
		if (ancien) { ancien.remove(); }
		var overlay = document.createElement('div');
		overlay.id = 'turnstile-overlay';
		overlay.style.cssText = 'position:fixed;inset:0;background:rgba(0,0,0,0.55);display:flex;align-items:center;justify-content:center;z-index:9999;padding:16px;';
		var carte = document.createElement('div');
		carte.style.cssText = 'background:#FBF3E7;border-radius:16px;padding:20px;max-width:90vw;';
		overlay.appendChild(carte);
		document.body.appendChild(overlay);
		function essayerAfficher(tentative) {
			if (typeof window.turnstile === 'undefined') {
				if (tentative < 20) { setTimeout(function () { essayerAfficher(tentative + 1); }, 250); }
				return;
			}
			window.turnstile.render(carte, {
				sitekey: '%s',
				callback: function (token) { window.godotTurnstileCallback(token); }
			});
		}
		essayerAfficher(0);
	})();
	""" % TURNSTILE_SITE_KEY, true)

## Retire la superposition Turnstile du DOM si elle existe encore (voir _start_web_captcha) - sans
## effet si elle a deja ete retiree/n'a jamais existe (getElementById renvoie null, rien a faire).
func _remove_turnstile_overlay() -> void:
	JavaScriptBridge.eval("(function () { var o = document.getElementById('turnstile-overlay'); if (o) { o.remove(); } })();", true)

## Callback JS -> GDScript (voir _start_web_captcha) : [args] est TOUJOURS un Array, ses elements
## sont les arguments JS convertis (voir doc JavaScriptBridge.create_callback) - ici un seul, le
## token Turnstile.
func _on_turnstile_token_received(args: Array) -> void:
	_turnstile_token = String(args[0]) if args.size() > 0 else ""
	captcha_web_status_label.text = "Vérification réussie ✅"
	_remove_turnstile_overlay()

func _on_captcha_web_retry_pressed() -> void:
	_start_web_captcha()

## Repli desktop/mobile (voir commentaire de CAPTCHA_PAGE_URL - en pratique seulement l'editeur
## Godot en dev, aucun joueur reel) : ouvre la page dans le navigateur systeme, PAS dans le jeu
## lui-meme (aucun DOM/JS disponible hors export Web pour afficher un widget Turnstile).
func _on_captcha_desktop_button_pressed() -> void:
	OS.shell_open(CAPTCHA_PAGE_URL)
	captcha_desktop_status_label.text = "Reviens ici une fois le code affiché, et retape-le ci-dessus."
	captcha_desktop_status_label.show()

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
		## mouse_filter=Pass (2026-09-16, TODO_UI_MODS.md "Bug - Scroll tactile impossible") : ce
		## bouton cree a la volee vit dans LoginSuggestionsScroll (voir _on_login_input_text_changed
		## plus haut) - sans ca son mouse_filter=Stop par defaut empecherait le glissement tactile
		## d'atteindre ce ScrollContainer quand la liste depasse la hauteur visible.
		button.mouse_filter = Control.MOUSE_FILTER_PASS
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

## "Mot de passe oublié" (2026-09-16, voir TODO_UI_MODS.md mod 1) : message TOUJOURS identique,
## que le pseudo/email existe ou non (voir fn_demander_reinitialisation_mdp dans schema.sql) - ne
## jamais laisser deviner quels comptes existent, meme principe que le login/mot de passe incorrect
## sur l'ecran de connexion. Seul un probleme reseau AVERE change le message (rien a voir avec
## l'existence d'un compte, juste une impossibilite technique de contacter le serveur).
func _on_forgot_send_pressed() -> void:
	var login_or_email := forgot_login_input.text.strip_edges()
	if login_or_email.is_empty():
		forgot_status_label.text = "Tape ton pseudo ou ton email."
		forgot_status_label.show()
		return
	forgot_send_button.disabled = true
	var result := await SaveManager.request_password_reset(login_or_email)
	forgot_send_button.disabled = false
	if not result.get("ok", false) and result.get("type", "") == "reseau":
		forgot_status_label.text = "Impossible de contacter le serveur, vérifie ta connexion internet."
	else:
		forgot_status_label.text = "Si un compte existe avec ce pseudo ou cet email, un lien de réinitialisation vient d'être envoyé."
	forgot_status_label.show()

## "Renvoyer l'email" (ecran EmailPendingSection) - reutilise ServerApi.renvoyer_verification() via
## SaveManager (deja cable pour le bouton "renvoyer" prevu par project_auth_creation_comptes.md,
## jamais relie a un bouton UI jusqu'ici).
func _on_resend_email_pressed() -> void:
	resend_email_button.disabled = true
	var result := await SaveManager.resend_email_verification()
	resend_email_button.disabled = false
	if result.get("ok", false):
		if result.get("data", {}).get("email_envoye", false):
			resend_email_status_label.text = "Email renvoyé, pense à vérifier tes spams."
		else:
			resend_email_status_label.text = "Le renvoi a échoué, réessaie dans quelques minutes."
	else:
		resend_email_status_label.text = "Impossible de contacter le serveur, vérifie ta connexion internet."
	resend_email_status_label.show()

## "J'ai confirmé, vérifier à nouveau" - revient au jeu immediatement si le lien a bien ete
## clique entre-temps (voir SaveManager.recheck_email_verification()), sans exiger de refaire tout
## le formulaire de connexion.
func _on_recheck_email_pressed() -> void:
	recheck_email_button.disabled = true
	var verified := await SaveManager.recheck_email_verification()
	recheck_email_button.disabled = false
	if verified:
		hide()
		return
	recheck_email_status_label.text = "Toujours pas confirmé - clique sur le lien reçu par email, puis réessaie."
	recheck_email_status_label.show()
