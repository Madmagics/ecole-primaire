## Menu de jeu principal : coquille de navigation entre 3 entrees (Configuration, Sauvegarde,
## Informations personnelles - "Commandes" retiree le 2026-09-02, "Statistiques" retiree le
## 2026-09-05, voir plus bas), plus "Controle parental" quand le compte connecte y a droit.
## Meme convention que les autres panneaux modaux du jeu (CardAlbum, ShopPanel, QuestionPanel) :
## Control racine, Panel visuel, verrouille les deplacements du joueur via PlayerInputLock tant
## qu'il est ouvert, se ferme au clic sur le CloseButton en haut de la colonne (voir plus bas,
## 2026-08-29 - plus de croix propre a la fenetre ; 2026-09-02 - plus d'Echap non plus, voir plus
## bas). Evolutif par construction : ajouter une section = ajouter un bouton de nav + un enfant
## Section*, sans toucher au reste (voir ARCHITECTURE.md).
##
## "Informations personnelles" (2026-08-01) n'a volontairement pas de raccourci clavier propre
## (contrairement a Config/Sauvegarde/Commandes/Statistiques, cette derniere retiree depuis) :
## ouverture uniquement au clic, pour ne pas avoir a choisir/reserver une lettre supplementaire
## sans demande explicite.
##
## "Statistiques" retiree (2026-09-05, retour utilisateur : "on va supprimer l'icone et la
## fenetre de statistique qui est au final inutile") : StatsButton/SectionStats et l'autoload
## StatsTracker supprimes (voir ChallengeTracker, qui reprend le seul morceau utile - le suivi
## de progression - pour la fenetre "Succes", voir ui/success/success_panel.gd).
##
## Mise en page des rubriques egalisee + police reduite (2026-08-25, retour utilisateur : "on va
## reprendre la mise en page des rubriques du menu option et les egaliser... reduit la marge de
## droite reduit la police de 1 taille pour tous les menus d'options") : chaque Section* avait deja
## la meme structure (VBoxContainer, marges 20px, separation 16 - sauf Informations personnelles a
## 14, alignee sur 16 ce jour-la) ; la marge de droite de leur VBoxContainer passe de 20 a 10px sur
## les 6 sections. Police reduite d'un cran (20->18 par defaut, 24->22 pour TitleLabel) via un
## theme minimal dedie (ui/theme/menu_options_font.tres, seulement default_font_size et
## TitleLabel/font_sizes - aucune couleur) assigne une seule fois sur Panel/ContentArea (voir le
## .tscn) : Godot fusionne les themes le long de l'arbre (theme le plus proche prioritaire par
## item, voir Control.theme) donc ce theme ne fait que reduire les tailles de police, les couleurs
## continuent de venir du theme de palette actif (SaveManager.ui_theme) assigne plus haut sur ce
## noeud racine - un seul fichier a modifier au lieu de repeter la reduction dans chacune des 6
## scenes Section*.
##
## Navigation refaite en bande d'icones (2026-08-25, retour utilisateur : icones fraichement
## integrees "trop grandes et mal adaptees" dans l'ancien NavContainer pleine largeur icone+texte).
## Les boutons de section vivent desormais dans IconDock/IconList (voir game_menu_panel.tscn) :
## boutons icone seule (expand_icon, pas de texte, plus de cadre visuel - flat = true).
##
## Disposition horizontale (2026-08-25, retour utilisateur : "decale le bord gauche de toutes les
## fenetres liees au menu je veux limite ecran gauche / marge / icone / marge / fenetre / marge /
## limite bord droit de l'ecran, la marge doit etre la meme qu'actuellement autour des fenetres") :
## IconDock et Panel sont tous deux enfants directs de ce noeud racine. Marge initiale reprise de
## celle de Panel (40px), puis reduite de 50% le meme jour (retour utilisateur suivant : "reduit la
## marge de chaque cote des icones de 50%") - marge desormais 20px entre le bord ecran et IconDock
## et entre IconDock et Panel ; la marge droite de Panel (bord ecran, -40) reste inchangee car ce
## n'est pas une marge "autour des icones".
##
## Cadre autour du bloc d'icones (2026-08-25, retour utilisateur : "on va faire un cadre autour du
## bloc des icones du menu principale, utilise la hauteur de la fenetre des menus et adapte la
## largeur de la colonne avec marges, on utilisera meme theme que la fenetre de la rubrique du
## menu") : IconDock passe de Control a Panel (type de base, sans theme_type_variation, exactement
## comme le noeud Panel de la fenetre) - meme theme assigne sur ce noeud racine, meme StyleBox donc
## meme cadre visuel que la fenetre. Hauteur alignee sur celle de Panel (offset_top=40/
## offset_bottom=-40 identiques). Largeur elargie de 108 a 148px pour loger une marge interne de
## 20px de chaque cote de la colonne d'icones (IconList, desormais offset_left=20/offset_right=-20
## au lieu de coller aux bords du cadre) - IconDock va donc de x=20 a x=168, Panel commence a x=188
## (168 + 20).
##
## Flou plein ecran (meme retour utilisateur, "applique la flou sur toute la fenetre quand le menu
## est actif") : BlurBG (ColorRect, meme shader icon_dock_blur.gdshader qu'avant) est desormais un
## enfant direct de ce noeud racine couvrant tout l'ecran, en premier dans l'arbre (donc dessine en
## dessous de Panel et IconDock) - remplace l'ancien BlurBG local, confine a la seule bande
## IconDock. Teinte noire du shader (tint_color) passee de 10% a 40% d'opacite le meme jour (retour
## utilisateur : "en plus du flou de fond applique un noir transparent de 40%").
##
## Raccourci clavier affiche a cote du titre, plus sur l'icone (2026-08-25, retour utilisateur :
## "enleve la touche raccourci accolee a l'icone et place la a cote du titre de la fenetre pour
## information") : ShortcutBadge (voir Panel/TitleRow dans le .tscn) montre la touche de LA
## SECTION ACTUELLEMENT AFFICHEE, mise a jour par _update_header() a chaque changement de section
## (voir SECTION_SHORTCUT_ACTIONS) - masque si la section n'a pas de raccourci propre
## (Informations personnelles).
##
## Contenu des rubriques colle a gauche (2026-08-25, retour utilisateur : "toutes les fenetres de
## menus doivent voir leurs contenus colles a gauche avec une marge equivalente a la marge entre la
## fenetre et le bord de l ecran") : ContentArea (parent commun des 6 Section*, voir plus bas)
## avait un offset_left de 260px, herite de l'ancienne navigation verticale qui vivait autrefois a
## l'interieur de Panel (avant IconDock, aujourd'hui completement externe a Panel - voir plus haut)
## - ce grand vide a gauche du contenu n'avait plus lieu d'etre. Reduit a 40px, la meme marge que
## celle utilisee entre Panel et le bord de l'ecran (offset_top/offset_bottom), pour que la marge
## interieure du contenu soit visuellement coherente avec la marge exterieure de la fenetre.
##
## Ligne de separation sous le titre (2026-08-25, retour utilisateur : "je veux aussi une ligne de
## separation entre le titre et le reste de la fenetre, le trait est de meme design que le trait de
## contour de la fenetre") : TitleSeparator (HSeparator, entre TitleRow et ContentArea) utilise le
## theme item HSeparator/styles/separator (StyleBoxLine), ajoute aux 4 fichiers de theme
## (game_theme/theme_bonbon/theme_tropical/theme_sombre.tres) avec la meme couleur et epaisseur
## (4px) que border_color/border_width du Panel/styles/panel de chaque theme - le trait reprend
## donc exactement le style du contour de la fenetre, quel que soit le theme actif.
##
## Retouche du meme jour (retour utilisateur : "la barre de separation titre/contenu trop haute,
## applique une marge basse en dessous du titre, ensuite reduit la case raccourci en hauteur, met
## le raccourci en majuscule ..., passe le cadre de la lettre raccourci en forme carree") :
## - TitleSeparator descend de offset_top/bottom=48/52 a 55/59 (marge sous le titre agrandie de 8
##   a 15px) ; ContentArea suit et descend de 60 a 64 pour garder un ecart apres le trait.
## - ShortcutBadge n'utilise plus TitleLabel (24px, pense pour un titre, pas une pastille) mais un
##   theme_type_variation dedie ("ShortcutBadge", base PanelContainer) ajoute aux 4 themes : petit
##   cadre carre (bg/bordure reprenant les couleurs du Panel de chaque theme, bordure 2px au lieu
##   de 4, coins 6px, marges internes 4px) au lieu de la StyleBoxFlat_row (pensee pour des lignes
##   de liste, pas une pastille). custom_minimum_size passe de 32x32 a 28x28.
## - ShortcutBadgeLabel abandonne aussi TitleLabel au profit d'un font_size direct de 16px (au lieu
##   de 24) : mis bout a bout avec .to_upper() (voir _update_header ci-dessous), le contenu tient
##   desormais dans le cadre reduit sans le forcer a s'agrandir au-dela de sa taille minimale.
##
## CloseButton aligne sur la meme taille que ShortcutBadge (2026-08-26, retour utilisateur : "la
## pastille raccourci est parfaite applique la meme taille pour le X de fermeture") : offsets
## passes a 28x28 (offset_right/offset_bottom inchanges, -20/40, coin superieur droit de Panel ;
## seuls offset_left -60->-48 et offset_top 8->12 bougent) - INSUFFISANT a lui seul (retour
## utilisateur suivant : "toujours aussi grande, aucun changement") : Button calcule sa propre
## taille minimale a partir de son texte ("X" a 20px, la taille de police par defaut du theme) et
## des marges de son StyleBox (14px gauche/droite, 8px haut/bas sur le Button de base, pense pour
## un vrai bouton texte) - cette taille minimale (~40px) l'emportait sur les offsets 28x28 tant
## qu'elle restait plus grande qu'eux (Godot ne descend jamais en dessous du minimum calcule).
## Fix : nouveau theme_type_variation dedie ("CloseButton", base Button, ajoute aux 4 themes) avec
## les memes couleurs que le Button normal/hover/pressed de chaque theme mais des marges reduites
## (5px/3px au lieu de 14px/8px), une bordure 2px (au lieu de 3-6) et une police dediee de 16px
## (CloseButton/font_sizes/font_size) - ramene la taille minimale reelle sous 28x28, les offsets du
## noeud font desormais foi. Meme raison que ShortcutBadge/ShortcutBadgeLabel plus haut, meme
## solution (police + marges reduites) : seule la taille change, pas la nature du bouton (reste un
## vrai Button cliquable avec l'accent colore du theme, contrairement a ShortcutBadge qui n'est
## qu'une pastille d'affichage).
##
## Collection, Sac de pieces et Inventaire (sac a dos) ne font plus partie de ce menu (2026-08-25,
## retour utilisateur : "separer les icones... les placer en haut a droite de l'ecran de maniere
## permanente comme le menu, [...] ces fenetres n'ouvriront pas le menu principal, les autres
## icones resteront enfant du menu principal") : ce sont desormais 3 icones permanentes dans
## game_ui.tscn, ouvrant directement CardAlbum/InventoryPanel/BackpackPanel (voir ces classes),
## totalement independantes de ce panneau.
##
## ContentArea/offset_top remonte de 64 a 80 (2026-08-26, retour utilisateur : "saut de ligne ou
## marge entre trait de separation et nom avec case qui touche la separation actuellement") : le
## trait TitleSeparator (offset_bottom=59) et le premier champ de chaque section (via l'offset_top
## =20 du VBoxContainer interne, voir SectionProfile.tscn) etaient trop rapproches. +16px (meme
## unite que les separations utilisees dans les VBoxContainer des sections) redonne de l'air, pour
## les 5 sections a la fois puisque ContentArea est leur parent commun.
##
## IconDock devient une scene partagee + Defis quitte le menu (2026-08-26, retour utilisateur : "on
## va partir sur un nouveau modele de groupes d'icones situe a droite de l'ecran... exactement
## pareil que du cote gauche... pour le design, on va utiliser la colonne et les dimensions de la
## colonne de gauche, je la veux commune si bien que si on modifie une l'autre sera modifiee
## aussi") : le Panel+VBoxContainer autrefois codes en dur ici vivent desormais dans ui/game_menu/
## icon_dock.tscn (cadre + marges + separation, sans bouton), instancie ICI (5 icones : Config/
## Save/Controls/Informations/Stats) ET dans le nouveau ui/hud/backpack_menu.tscn (colonne
## symetrique en haut a droite) - modifier icon_dock.tscn met a jour les deux colonnes a la fois,
## chaque instance ajoutant ses propres boutons en enfants editables (voir [editable path] en bas
## du .tscn). Defis (SectionDefis, 6e entree jusque-la) quitte ce panneau : renomme "Succes", il
## devient ui/success/success_panel.gd, un panneau modal autonome ouvert depuis ce nouveau dock de
## droite, sur le meme moule que les autres panneaux modaux du jeu - voir backpack_menu.gd pour le
## detail du nouveau dock.
##
## ATTENTION EDITEUR : IconDock/IconList contient les boutons de ce menu comme enfants "editables"
## d'une scene instanciee (voir icon_dock.tscn) - meme mecanisme que les instances NPC de school.
## tscn, ou desactiver "Editable Children" sur une instance a deja fait perdre silencieusement tous
## ses enfants/overrides au prochain enregistrement dans l'editeur (incident documente en memoire
## projet). Ne JAMAIS decocher "Editable Children" sur le noeud IconDock ici (ni dans backpack_menu.
## tscn) sous peine de perdre les boutons de navigation au prochain Ctrl+S dans l'editeur.
##
## Largeur de colonne et tailles d'icones (2026-08-26, deux retours utilisateur le meme jour) :
## d'abord retrecie de 25% ("on va reduire la largeur des colonnes de 25%" - IconDock 148->111px,
## marge IconList 20->15px, icones a native x0,45), puis revenue en arriere sur la taille des
## icones ("taille d icone retour a la taille precedente") tout en gardant la colonne etroite via
## la marge interieure seule, reduite a 5px ("on reduit la marge interieur a 5 px") - les icones
## des 5 boutons de ce dock retrouvent leur taille native x0,6 d'origine (convention du 2026-08-25),
## seule la marge autour d'elles a change. IconDock (icon_dock.tscn, partage avec BackpackMenu) fait
## desormais 93px de large (icone la plus large du dock partage, SuccesButton a 83px cote
## BackpackMenu, + 5px de marge de chaque cote) au lieu de 148px a l'origine. Panel.offset_left suit
## (133, etait 188) pour garder la formule "limite ecran gauche / marge 20px / icone 93px / marge
## 20px / fenetre" intacte.
##
## Croix de fermeture unique en haut de la colonne (2026-08-29, retour utilisateur : "dorenavant la
## fermeture de l ensemble colonne d icone et fermeture fenetre soperera par la touche ECHAP ou une
## croix situee en haut de la colonne au lieu de la croix dans chaque fenetre qui sera a enlever") :
## l'ancien Panel/CloseButton (coin superieur droit de la fenetre) est retire. Un nouveau CloseButton
## est ajoute DANS icon_dock.tscn (scene de base partagee avec BackpackMenu, voir plus haut) comme
## enfant DIRECT d'IconDock (pas d'IconList) - visible en haut de la colonne des DEUX cotes a la
## fois sans dupliquer le noeud (meme principe que le cadre/les marges d'IconDock deja partages).
## Chaque script cote (game_menu_panel.gd ici, backpack_menu.gd en face) connecte ce bouton a son
## PROPRE close() - seul le noeud visuel est partage, pas le comportement, puisque IconDock
## lui-meme n'a pas de script.
##
## Croix collee au bord superieur du Panel (2026-08-29, meme jour, retour utilisateur suivant :
## "colle la croix en haut de la colonne des 2 cotés") : d'abord placee comme premier enfant
## d'IconList (alignment=1/centre, donc en haut du BLOC centre d'icones, pas du Panel lui-meme si
## le bloc ne remplit pas toute la hauteur) - retour du jour meme : ca ne suffisait pas, la croix
## devait etre fixe en haut du Panel independamment du centrage des icones en dessous. Sortie
## d'IconList, devient un enfant separe d'IconDock, ancree en haut/centree horizontalement
## (anchor_left=anchor_right=0.5, offset_top=8, taille 28x28). IconList.offset_top passe de 14 a 44
## pour liberer la place sous la croix (8 marge + 28 croix + 8 d'ecart avant la liste, qui reste
## centree dans l'espace RESTANT en dessous).
##
## Marges resserrees, coherence gauche/droite (2026-08-29, retour utilisateur suite a un comparatif
## des marges demande entre les deux colonnes : "on va passer a 10px de chaque cote entre la colonne
## et la fenetre, on va aussi reduire toutes les marges exterieures entre fenetre et bord de l ecran
## en haut en bas a droite et a gauche, applique cette mod a toutes les fentres et tous les menus du
## jeu" - portee precisee ensuite aux seules fenetres ouvertes depuis une colonne d'icones, les
## questions via NPC gardant leur propre design). Marge ecran (haut/bas/gauche/droite) 40->20px sur
## IconDock ET Panel (IconDock n'avait deja que 20px en horizontal, desormais aussi en vertical -
## offset_top/bottom 40/-40 -> 20/-20 partout). Marge colonne<->fenetre 20->10px (IconDock finit
## toujours a x=113, Panel.offset_left = 20 (marge ecran) + 93 (icone) + 10 (nouvelle marge) = 123,
## etait 133). Panel.offset_right passe de -40 a -20 (marge ecran droite alignee sur les 3 autres
## cotes). Meme formule appliquee en miroir sur BackpackMenu/SuccessPanel/CardAlbum - voir leurs .gd
## respectifs (l'ancien InventoryPanel, retire le 2026-08-29 au profit de ShopPanel, avait aussi
## recu cette formule a l'epoque).
##
## Marge au-dessus de la croix alignee sur 10px (2026-08-29, meme jour, retour utilisateur : "appplique
## la meme marge au dessus des croix de fermeture des menu colonne que sur les cotes 10px?") : offset_top
## de CloseButton passe de 8 a 10 (icon_dock.tscn), pour reprendre la meme valeur que la marge
## colonne<->fenetre de 10px etablie ci-dessus. offset_bottom suit (36->38, hauteur 28px inchangee).
## IconList.offset_top passe de 44 a 46 (+2) pour conserver le meme ecart de 8px entre le bas de la
## croix et le haut de la liste d'icones - seule la marge du HAUT change, pas l'espacement interne.
##
## Icone de titre clonee du bouton de la colonne (2026-09-02, retour utilisateur : "je veux que
## l icone de chaque fenetre apparaisse aussi a gauche du titre de la fenetre dans la fenetre, cela
## donnera une correspondance entre la fenetre exploree et l icone de menu, il faut que l icone
## dans la fentre a cote du titre soit un clone de celle du menu, en changeant un on change
## l autre") : TitleIcon (TextureRect, voir le .tscn, premier enfant de TitleRow avant TitleLabel,
## 28x28 - meme taille que l'ancien ShortcutBadge, retire le meme jour, voir plus bas) n'a AUCUNE
## texture assignee en dur dans le .tscn - _update_header() lui assigne button.icon du bouton
## IconDock de la section active (voir _icon_button_for() plus bas) a chaque changement de
## section. "Clone qui se met a jour tout seul" au sens demande : pas de fichier duplique, juste
## une lecture de la MEME Texture2D deja chargee par le bouton - modifier l'icone d'un bouton (ou
## remplacer son fichier source sur disque) met donc a jour le titre automatiquement, sans toucher
## a ce script. Meme mecanisme de reference deja utilise par CardRevealOverlay.book_icon_path
## (voir game_ui.tscn) pour cibler LivreButton.
##
## Jeu 100% souris/tactile, plus aucun raccourci clavier (2026-09-02, retour utilisateur :
## "changement de plans, on supprime tous les raccourcis clavier, je veux un jeu qui se joue
## uniquement a la souris ou au tactile") :
##  - Section "Commandes" (SectionControls, reassignation des touches) entierement supprimee -
##    n'avait plus lieu d'etre puisqu'il n'y a plus rien a reassigner. ControlsButton retire
##    d'IconDock/IconList, section_controls.gd/.tscn et l'icone control.webp supprimes du disque,
##    SaveManager perd tout son systeme de rebinding (voir son commentaire de classe).
##    SECTION_TITLES/_hide_all_sections()/_show_controls() perdent leur entree "controls".
##  - ShortcutBadge (pastille affichant la touche de la section active a cote du titre, voir
##    l'entree "Raccourci clavier affiche a cote du titre" plus haut) retiree du .tscn : n'a plus
##    aucune raison d'etre sans raccourcis. SECTION_SHORTCUT_ACTIONS et shortcut_badge/
##    shortcut_badge_label disparaissent avec elle. Le theme_type_variation "ShortcutBadge"
##    lui-meme RESTE dans les 4 fichiers de theme - toujours utilise par ProfSkinItem.PriceBadge
##    (voir CHARTE_GRAPHIQUE.md, entree du meme jour), seul cet usage-ci est retire.
##  - _unhandled_input() disparait entierement : chaque action qu'il gerait (ouvrir/fermer le menu,
##    basculer sur une section, fermer via Echap) a deja son propre equivalent souris/tactile
##    (OpenMenuButton/BackpackButton, boutons d'IconDock, CloseButton de la colonne) - il ne restait
##    plus que des raccourcis strictement redondants a supprimer.
##
## Icone "Quitter" tout en bas de la colonne (2026-09-04, retour utilisateur : "ajoute dans le menu
## de gauche, tout en bas en respectant les marges: l icone quitter... quand on click dessus une
## petite fenetre apparait proposant : deconnexion (retour page intro) ou quitter (fermer le jeu)")
## : QuitterButton est un enfant DIRECT d'IconDock (pas d'IconList, contrairement aux 4 icones de
## navigation ci-dessus) - IconList centre son groupe de boutons (alignment=1) dans l'espace
## restant sous CloseButton, ce qui aurait fait flotter un 5e bouton au milieu du bloc au lieu de
## le clouer "tout en bas" comme demande. Ancre en bas/centree horizontalement d'IconDock (voir
## icon_dock.tscn), meme marge de 10px que CloseButton en haut (symetrique). N'ouvre pas une
## section de CE panneau mais QuitOverlay (ui/game_menu/quit_overlay.tscn), un noeud EXTERNE
## (voir quit_overlay_path, meme mecanisme de NodePath que BackpackMenu.wallet_panel_path) car
## Echap doit pouvoir l'ouvrir aussi quand ce panneau-ci est ferme (voir le commentaire de classe
## de QuitOverlay pour le detail complet).
##
## Icone "Contrôle parental" (2026-09-04, retour utilisateur : "quand la case controle parental
## est cochee, on fera apparaitre une nouvelle icone dans le menu deplie a gauche... creer une
## fenetre sur la meme base que les autres fenetres de menu et apres on va y integrer des
## options") : 5e bouton d'IconList (contrairement a QuitterButton ci-dessus, celui-ci EST une
## section de navigation normale, comme Config/Save/Informations/Stats). Cache par defaut dans le
## .tscn (visible=false) - _update_parental_control_visibility() ne le montre que si le compte
## connecte a controle_parental=true dans son profil (voir WelcomePanel.parental_control_check),
## et reagit a SaveManager.account_logged_in/account_logged_out pour rester juste apres un
## changement de compte, sans qu'il soit besoin de rouvrir ce menu. SectionParentalControl
## (ui/game_menu/section_parental_control.gd) est volontairement vide pour l'instant - voir son
## commentaire de classe.
class_name GameMenuPanel
extends Control

## Titre affiche en tete de panneau pour chaque section (voir title_label) - indexe par la meme
## StringName que _current_section.
const SECTION_TITLES := {
	&"config": "Configuration",
	&"save": "Sauvegarde",
	&"profile": "Informations personnelles",
	&"parental_control": "Contrôle parental",
}

## Titre affiche en haut du panneau (2026-08-25, retour utilisateur : "le titre de la fenetre ne
## doit pas etre menu mais le nom de la fenetre") - remplace le texte fixe "Menu" (voir le .tscn,
## desormais juste une valeur de depart sans effet une fois _ready() passe) par le nom de la
## section active, mis a jour par _update_header() a chaque _show_xxx().

## NodePath vers QuitOverlay (game_ui.tscn) - meme raison que BackpackMenu.wallet_panel_path
## (voir son commentaire) : ce n'est pas un enfant de ce panneau, assigne dans game_ui.tscn.
@export var quit_overlay_path: NodePath

@onready var title_icon: TextureRect = $Panel/TitleRow/TitleIcon
@onready var title_label: Label = $Panel/TitleRow/TitleLabel
@onready var close_column_button: Button = $IconDock/CloseButton
@onready var config_button: Button = $IconDock/IconList/ConfigButton
@onready var save_button: Button = $IconDock/IconList/SaveButton
@onready var informations_button: Button = $IconDock/IconList/InformationsButton
@onready var parental_control_button: Button = $IconDock/IconList/ParentalControlButton
@onready var quit_button: Button = $IconDock/QuitterButton

@onready var section_config: SectionConfig = $Panel/ContentArea/SectionConfig
@onready var section_save: SectionSave = $Panel/ContentArea/SectionSave
@onready var section_profile: SectionProfile = $Panel/ContentArea/SectionProfile
@onready var section_parental_control: SectionParentalControl = $Panel/ContentArea/SectionParentalControl

@onready var parental_gate: ParentalGateOverlay = $ParentalGate

## Action a executer si le portail parental est valide (voir _request_gate/_on_gate_confirmed) -
## meme convention que ShopPanel._pending_purchase.
var _pending_gated_action: Callable

## Section actuellement affichee ("config"/"save"/"profile"/"stats"/"" si fermee).
var _current_section: StringName = &""

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_column_button.pressed.connect(close)
	quit_button.pressed.connect(_on_quit_button_pressed)
	config_button.pressed.connect(_show_config)
	save_button.pressed.connect(_show_save)
	informations_button.pressed.connect(_show_profile)
	parental_control_button.pressed.connect(_show_parental_control)
	section_save.reset_requested.connect(_on_reset_requested)
	section_profile.delete_account_requested.connect(_on_delete_account_requested)
	parental_gate.confirmed.connect(_on_gate_confirmed)
	visibility_changed.connect(_on_visibility_changed)

	## Icone visible seulement pour un compte avec controle_parental=true (voir commentaire de
	## classe) - etat initial (utile si un compte est deja connecte a _ready(), ex. DEV_AUTO_LOGIN)
	## PUIS reactif a tout changement de compte, sans devoir rouvrir ce menu.
	_update_parental_control_visibility(SaveManager.get_current_profile())
	SaveManager.account_logged_in.connect(_update_parental_control_visibility)
	SaveManager.account_logged_out.connect(func() -> void: parental_control_button.visible = false)

func open() -> void:
	show()
	_show_config()

func close() -> void:
	hide()
	_current_section = &""

## Bascule le menu ouvert/ferme sur un seul clic (bouton "M" du HUD).
func toggle() -> void:
	if visible:
		close()
	else:
		open()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Met a jour le titre et son icone en tete de panneau pour [id] (voir SECTION_TITLES) - appele
## par chaque _show_xxx() apres avoir fixe _current_section.
func _update_header(id: StringName) -> void:
	title_label.text = SECTION_TITLES[id]
	title_icon.texture = _icon_button_for(id).icon

## Bouton de la colonne IconDock correspondant a [id] (voir title_icon plus haut) - seule source de
## verite pour l'icone de chaque section, jamais dupliquee.
func _icon_button_for(id: StringName) -> Button:
	match id:
		&"config":
			return config_button
		&"save":
			return save_button
		&"profile":
			return informations_button
		&"parental_control":
			return parental_control_button
	return config_button

func _hide_all_sections() -> void:
	section_config.hide()
	section_save.hide()
	section_profile.hide()
	section_parental_control.hide()

func _show_config() -> void:
	_hide_all_sections()
	section_config.refresh()
	section_config.show()
	_current_section = &"config"
	_update_header(_current_section)

func _show_save() -> void:
	_hide_all_sections()
	section_save.refresh()
	section_save.show()
	_current_section = &"save"
	_update_header(_current_section)

func _show_profile() -> void:
	_hide_all_sections()
	section_profile.refresh()
	section_profile.show()
	_current_section = &"profile"
	_update_header(_current_section)

func _show_parental_control() -> void:
	_hide_all_sections()
	section_parental_control.refresh()
	section_parental_control.show()
	_current_section = &"parental_control"
	_update_header(_current_section)

func _update_parental_control_visibility(profile: Dictionary) -> void:
	parental_control_button.visible = bool(profile.get("controle_parental", false))

func _on_reset_requested() -> void:
	_request_gate(_do_reset_progress)

func _do_reset_progress() -> void:
	SaveManager.reset_current_account_progress()
	section_save.notify_reset_done()

## Supprimer le compte ferme ce menu (comme quitter la Collection) : SaveManager.
## current_account_id redevient vide, WelcomePanel se raffiche tout seul (voir son abonnement a
## SaveManager.account_logged_out) sans qu'il soit besoin de le referencer ici.
func _on_delete_account_requested() -> void:
	_request_gate(_do_delete_account)

func _do_delete_account() -> void:
	SaveManager.delete_current_account()
	close()

## Ouvre le portail parental (code a 8 caracteres) ; [action] n'est execute que si le joueur
## recopie le bon code (voir ParentalGateOverlay/_on_gate_confirmed). Annuler (Echap/"Annuler")
## ne fait rien - aucune action destructive n'est jamais executee sans passer par ce portail.
func _request_gate(action: Callable) -> void:
	_pending_gated_action = action
	parental_gate.open()

func _on_gate_confirmed() -> void:
	var action := _pending_gated_action
	_pending_gated_action = Callable()
	if action.is_valid():
		action.call()

## Ouvre QuitOverlay SANS fermer ce menu (meme logique que ParentalGate, qui reste au-dessus du
## Panel/IconDock ouverts) - c'est QuitOverlay qui decide ensuite quoi faire (deconnexion/quitter/
## annuler), voir son commentaire de classe.
func _on_quit_button_pressed() -> void:
	var overlay := get_node_or_null(quit_overlay_path)
	if overlay and overlay.has_method("open"):
		overlay.open()
