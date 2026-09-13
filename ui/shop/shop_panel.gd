## Boutique : onglets horizontaux, "Cartes" (coffres par rarete) et "Classe" (deblocage des 5
## classes). Instancie un CrateItem.tscn par lot dans l'onglet Cartes, et un GradeUnlockItem.tscn
## par classe (CP a CM2) dans l'onglet Classe - meme base visuelle carree dans les deux onglets
## (voir CrateItem/GradeUnlockItem, retour utilisateur 2026-08-01 : "place les items a acheter
## sur la meme base que le premier onglet"). Les 5 classes restent TOUJOURS presentes dans
## l'onglet (memes retour : "les 5 classes doivent etre presentes"), sinon l'onglet finit vide
## une fois toute la progression achetee - chaque GradeUnlockItem se grise et affiche un "-" a la
## place du prix des qu'il est achete (voir GradeUnlockItem.refresh() pour le detail des etats).
## Ajouter un coffre au jeu = ajouter une LootTableResource a available_crates, sans code. Chaque
## case (coffre ou classe) est reactive au clic (pas de bouton "Acheter" dedie) : cliquer dessus
## ouvre une popup de confirmation (Oui/Annuler) avant tout achat reel. Chaque CrateItem a en plus
## (2026-08-04) un selecteur de quantite (+/-) sous le prix : le prix affiche = prix de base *
## quantite, et le "+" est plafonne au nombre de coffres que le solde actuel permet d'acheter (voir
## CrateItem.refresh_availability / _refresh_crate_items) - le clic sur la case reste le seul moyen
## de declencher l'achat, toujours via la meme popup de confirmation.
##
## Devient aussi la fenetre de la section "Récompenses" du menu colonne droite (2026-08-29, retour
## utilisateur : "licone sac de piece devient la section Récompenses : dans la fenetre correpondante
## on aura la fenetre boutique actuelle") : BackpackMenu.wallet_panel_path pointe desormais sur ce
## noeud (voir game_ui.tscn) au lieu de l'ancien InventoryPanel (retire, doublon - son role de
## resume des soldes est repris par RewardsBand ci-dessous). ShopPanel reste ouvrable comme avant
## par le kiosque de la scene ET desormais par l'icone "Récompenses" de BackpackMenu - les deux
## chemins ouvrent le meme noeud, pas une copie.
##
## RewardsBand (voir le .tscn, premier enfant de Content, avant Tabs) : instance de CoinHUD (ui/hud/coin_hud.gd/
## .tscn, jusque-la codee mais jamais instanciee nulle part) - la "bande en haut avec les pieces
## gagnées" demandee. Se met a jour toute seule via Economy.balance_changed, rien a cabler ici.
##
## ATTENTION ORDRE DES NOEUDS dans game_ui.tscn : ce panneau (racine plein ecran, mouse_filter par
## defaut STOP - volontaire, bloque les clics vers le monde du jeu pendant qu'il est ouvert, meme
## principe que GameMenuPanel/CardAlbum/SuccessPanel) DOIT rester place AVANT BackpackMenu dans
## l'arbre (donc dessine EN DESSOUS d'IconDock), sinon sa zone vide plein ecran intercepte les
## clics destines aux boutons Livre/Succes du dock (meme bug que celui corrige sur BackpackMenu
## lui-meme le 2026-08-29, voir son commentaire de classe - IconDock ne chevauche pas
## geometriquement ce Panel, mais son noeud racine plein ecran si, tant qu'il est topmost).
##
## Raccourci clavier "I" (2026-08-29, meme retour utilisateur) : recupere de l'ancien InventoryPanel
## ("I" ouvrait/fermait le solde de pieces) - voir _unhandled_input ci-dessous, meme mecanisme que
## CardAlbum/"L" (bascule ouvert/ferme sur une seule touche, pas juste une ouverture).
##
## Fenetre redimensionnee au format des autres fenetres (2026-08-29, retour utilisateur suivant :
## "ajuste la taille de la fenetre pour etre de la meme taille que les autres fenetres") : Panel
## (reste un PanelContainer, style/chrome inchange - seule la TAILLE etait visee, pas l'habillage)
## passe d'ancres en pourcentage (0.1/0.08/0.9/0.92, occupant ~80% de l'ecran) a la meme formule en
## pixels fixes que les 3 autres fenetres de la colonne droite (offset_left=20, offset_top=20,
## offset_right=-123, offset_bottom=-20 - borde IconDock a droite, voir InventoryPanel/SuccessPanel/
## CardAlbum du 2026-08-26 pour l'origine de cette formule). S'applique aussi bien quand ce panneau
## est ouvert par le kiosque que par l'icone "Récompenses" (meme noeud, voir plus haut).
##
## En-tete aligne sur GameMenuPanel (2026-08-29, retour utilisateur : "applique la meme mise en
## page de fenetre que les menu gauche, le titre en haut avec une barre de separation, pas besoin
## de l icone coffre") : TitleIcon (boutique.webp) retire de HeaderRow - GameMenuPanel n'a pas
## d'icone dans son propre TitleRow, juste TitleLabel. TitleSeparator (HSeparator) ajoute juste
## apres HeaderRow, meme convention que TitleSeparator dans game_menu_panel.tscn (deja stylee dans
## les 4 themes, voir CHARTE_GRAPHIQUE.md "Ligne de separation sous le titre") - remplace
## l'ancien RewardsSeparator qui se trouvait plus bas (entre RewardsBand et Tabs, mauvais
## emplacement par rapport a ce que demandait ce retour : un seul trait, sous le titre).
##
## Croix de fermeture retiree (2026-08-29, meme jour, retour utilisateur suivant : "dorenavant la
## fermeture de l ensemble colonne d icone et fermeture fenetre soperera par la touche ECHAP ou une
## croix situee en haut de la colonne au lieu de la croix dans chaque fenetre qui sera a enlever") :
## HeaderSpacer (qui ne servait qu'a pousser cette croix a droite) retire aussi, devenu inutile.
## S'applique aussi bien quand ce panneau est ouvert par le kiosque que par l'icone "Récompenses" -
## se ferme desormais uniquement via Echap (_unhandled_input ci-dessous, inchange) ou via le
## nouveau CloseButton en haut d'IconDock (voir BackpackMenu.gd/icon_dock.tscn) quand ouvert par la
## colonne ; le kiosque n'a pas de colonne d'icones, Echap reste alors le seul moyen de fermer.
##
## Chrome uniformise sur GameMenuPanel (2026-08-29, meme jour, retour utilisateur : "applique la
## configuration des fenetres de gauche a celle de la boutique, positionnement du titre, barre de
## separation couleur de fond theme etc") : la ligne 42-43 ci-dessus notait que Panel restait un
## PanelContainer (style/chrome inchange) apres le redimensionnement - ce n'est plus vrai. Panel
## passe a son tour de PanelContainer a Panel (fond creme, bordure 4px, coins arrondis 20 -
## Panel/styles/panel - au lieu du blanc/coins 14 pense pour des lignes de liste, meme correction
## que celle appliquee a SuccessPanel/CardAlbum le 2026-08-26). Margin passe de layout_mode=2
## (arrange automatiquement par PanelContainer) a layout_mode=1 + anchors_preset=15 (Panel ne
## gere pas la disposition de ses enfants, meme resultat visuel qu'avant). HeaderRow gagne
## alignment=1 pour centrer TitleLabel, comme TitleRow dans game_menu_panel.tscn.
##
## Geometrie du titre/separateur calquee pixel pour pixel sur GameMenuPanel (2026-08-29, meme jour,
## retour utilisateur avec captures d'ecran : "ca fait plusieurs fois que je demande la meme config
## d ui entre les fenetre ouvertes depuis icone de gauche et droite... a droite on a une ligne
## flottante plus bas mais pas comme sauvegarde et les autres fenetres du menu de gauche") : le
## correctif precedent (alignment=1 sur HeaderRow, TitleSeparator dans le flux du VBoxContainer
## Content avec separation=18) donnait un resultat proche mais pas identique - la position du
## separateur dependait de la hauteur reelle du Label (police, line height) au lieu d'un offset
## fixe, donc elle derivait de celle du menu de gauche. HeaderRow/TitleLabel/TitleSeparator sortent
## entierement du flux Margin/Content : TitleRow (HBoxContainer, alignment=1) et TitleSeparator
## deviennent des enfants directs de Panel avec les MEMES offsets que TitleRow/TitleSeparator dans
## game_menu_panel.tscn (offset_top=10/bottom=40 pour le titre, offset_top=55/bottom=59 pour le
## separateur - anchors_preset=10, ancres sur toute la largeur). Margin (RewardsBand+Tabs) demarre
## desormais a offset_top=80, meme valeur que ContentArea dans game_menu_panel.tscn, avec
## margin_top=0 en interne (l'offset_top gere deja l'espace sous le separateur).
##
## Kiosque en jeu retire (2026-08-29, retour utilisateur : "on retire le module boutique pose dans
## le jeu en 2d, il n a plus a apparaitre la car il se trouve dans le menu") : le noeud ShopKiosk
## (entities/shop_kiosk_2d/shop_kiosk_2d.tscn, instancie dans levels/school/school.tscn) est
## supprime des les deux fichiers - le seul chemin d'ouverture de ce panneau est desormais l'icone
## "Récompenses" de BackpackMenu (et le raccourci "I", voir open()/_unhandled_input). Toutes les
## mentions ci-dessus de "kiosque"/"ouvrable par le kiosque" (lignes ~21-23, ~47-48, ~63-66)
## decrivaient un etat qui n'existe plus - laissees telles quelles comme journal de l'evolution du
## fichier, voir cette entree pour l'etat actuel. open() perd son parametre "who" (devenu inutile,
## voir son commentaire).
##
## Onglet "Classe" retire (2026-08-29, retour utilisateur : plus de deblocage de classe payant,
## un enfant qui commence par exemple au CE2 n'a aucun interet a payer pour acceder aux autres
## classes - a l'inverse, un acces total des le depart lui permet de reviser les classes
## precedentes ou de tester les classes superieures) : l'onglet "Classe" et les 5 GradeUnlockItem
## sont retires de ce script et de shop_panel.tscn (GradeUnlockItemScene/class_item_grid/
## _grade_unlock_items/_refresh_grade_items), ainsi que l'autoload GradeUnlock lui-meme (plus
## personne ne verifie GradeUnlock.is_unlocked(), voir QuestionGiverComponent) - toutes les
## mentions ci-dessus de l'onglet "Classe"/GradeUnlock decrivent un etat qui n'existe plus.
##
## 5 nouveaux onglets "skins de prof" (2026-08-29, meme jour, retour utilisateur : un onglet par
## classe - CP a CM2 - avec les 10 skins de prof de cette classe, 2 lignes de 5, grises si pas
## achetes, en surbrillance si actif, en couleur normale si possede mais pas porte ; activer un
## skin possede change le skin du prof de la classe concernee) : ProfSkinItemScene/
## prof_skin_grids/_prof_skin_items instancient un ProfSkinItem par (classe, index de skin) dans
## chacun des 5 onglets - voir ProfSkinCatalog pour le catalogue de textures et autoload/
## prof_skins.gd pour l'etat possede/actif serialise par compte. Achat = popup de confirmation
## habituelle (_on_prof_skin_purchase_requested) ; reequiper un skin deja possede est immediat,
## sans confirmation (_on_prof_skin_equip_requested).
##
## Onglet "Cartes" : hauteur reduite de moitie (2026-08-30, retour utilisateur : "reduit de
## moitie la hauteur on se garde la 2eme ligne pour d'autres achats plus tard") - item_grid
## (5 coffres actuels, 1 seule ligne reelle vu columns=5) partage desormais l'espace vertical
## avec un Control "ReservedRow" vide via un VBoxContainer "Layout" intercale dans TabMargin
## (voir le .tscn), les deux en SIZE_EXPAND_FILL a parts egales : item_grid n'occupe donc plus
## que la moitie superieure de l'onglet (meme hauteur de case que les onglets skins de prof, 1
## rangee sur 2 possibles), l'autre moitie restant vide, prete a recevoir un futur 2e type
## d'achat sans reprendre toute la mise en page. Meme retour utilisateur, en meme temps :
## "ajuste la taille des onglets de la boutique, meme taille que le premier pour tous quel que
## soit le contenu" - deja garanti par la chaine Panel (taille fixe, non pilotee par le
## contenu) -> Margin -> Content (VBoxContainer) -> Tabs (SIZE_EXPAND_FILL) : chaque onglet
## recoit toujours exactement le meme espace, quel que soit ce qu'il contient - cette reduction
## de moitie ne fait donc que liberer de l'espace VIDE dans l'onglet Cartes, sans jamais
## rapetisser la fenetre de la boutique elle-meme.
##
## Onglets tous a la meme largeur + premier onglet decale (2026-08-31, retour utilisateur :
## "decale le premier onglet de 5px vers la droite, ensuite applique la meme largeur d'onglet a
## tous les onglets (meme largeurs que cartes)") : TabBar (utilise en interne par TabContainer,
## voir get_tab_bar()) n'expose aucune largeur minimale/uniforme par onglet - seulement
## max_tab_width, un PLAFOND qui n'aurait pu que retrecir "Cartes" (le plus large), jamais
## elargir "CP"/"CE1"/... (verifie dans la doc officielle TabBar avant d'ecrire ce qui suit).
## Decalage du premier onglet : theme_override_constants/side_margin sur le noeud Tabs (voir le
## .tscn), qui vaut 8 par defaut quand non surcharge (aucun theme de ui/theme/*.tres ne le
## surcharge) - passe a 13 (8+5). Largeur uniforme : _equalize_tab_widths() ci-dessous.
##
## _equalize_tab_widths(), 15e passe (meme jour, retour utilisateur suivant sur le premier essai
## ci-dessus : "recentre les titres, CP etc au milieu de l'onglet") : le premier essai comblait
## l'ecart de largeur avec une icone invisible posee uniquement AVANT le texte (via
## set_tab_icon) - or TabBar ne laisse aucun espace apres le texte, donc ce padding a gauche
## seule poussait le titre visible vers la droite au lieu de le centrer. Remplace par un padding
## SYMETRIQUE directement dans le titre (espaces ajoutes avant ET apres, mesures via le Font
## reellement utilise par TabBar - get_theme_font/get_theme_font_size - plutot que supposes en
## dur) : le texte visible reste ainsi au centre exact de la largeur ajoutee. L'unique
## alternative native pour un espace a DROITE du texte aurait ete set_tab_button_icon, mais cet
## element est cliquable (tab_button_pressed) et un clic dessus ne selectionne pas l'onglet -
## ecarte pour ne pas introduire de zone morte au clic.
##
## Icone de titre de retour, clonee du bouton "Récompenses" (2026-09-02, retour utilisateur : "je
## veux que l icone de chaque fenetre apparaisse aussi a gauche du titre de la fenetre... il faut
## que l icone dans la fentre a cote du titre soit un clone de celle du menu, en changeant un on
## change l autre") : contrairement au 2026-08-29 ("pas besoin de l icone coffre", voir plus haut)
## qui retirait l'ancienne TitleIcon(boutique.webp) codee en dur, celle-ci revient sous une forme
## differente - title_icon_source_path (NodePath, assigne dans game_ui.tscn vers
## ../BackpackMenu/IconDock/IconList/SacDePiecesButton) et title_icon.texture = bouton.icon en
## _ready(), jamais un fichier duplique. Meme mecanisme que GameMenuPanel.title_icon (voir son
## commentaire de classe) et que CardRevealOverlay.book_icon_path.
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## est retire (gerait "I"/open_inventory pour basculer la fenetre, et Echap pour la fermer ou
## annuler la popup d'achat) - CloseButton (colonne BackpackMenu), CancelButton (ConfirmOverlay) et
## l'icone "Récompenses" font deja tout ca a la souris/au tactile, ces raccourcis etaient
## strictement redondants.
class_name ShopPanel
extends Control

const CrateItemScene := preload("res://ui/shop/crate_item.tscn")
const ProfSkinItemScene := preload("res://ui/shop/prof_skin_item.tscn")
const ClassroomDecorItemScene := preload("res://ui/shop/classroom_decor_item.tscn")
const ClassroomMusicItemScene := preload("res://ui/shop/classroom_music_item.tscn")

## Duree d'affichage du popup "insuffisant" (voir _show_insufficient_funds()) avant qu'il ne se
## masque tout seul.
const INSUFFICIENT_FUNDS_SECONDS := 2.5
## 2 causes possibles pour ce meme popup (voir _show_insufficient_funds()) : solde de pieces
## insuffisant (coffres/skins de prof) ou Defis pas encore tous valides (onglet "Succes", voir
## ClassroomDecor) - meme structure de popup, texte different selon la cause.
const INSUFFICIENT_COINS_TEXT := "Pièces nécessaires insuffisantes"
const INSUFFICIENT_CHALLENGES_TEXT := "Défis nécessaires insuffisants"

## Ordre d'affichage des raretes dans l'onglet Cartes : les valeurs de l'enum CardRarity.Rarity
## ne sont pas dans l'ordre "logique" (UNCOMMON=4 vient apres LEGENDARY=3, voir card_rarity.gd,
## commentaire au dessus de l'enum), donc un tri numerique naif melangerait l'affichage - liste
## explicite du moins au plus rare.
const RARITY_DISPLAY_ORDER: Array[CardRarity.Rarity] = [
	CardRarity.Rarity.COMMON,
	CardRarity.Rarity.UNCOMMON,
	CardRarity.Rarity.RARE,
	CardRarity.Rarity.EPIC,
	CardRarity.Rarity.LEGENDARY,
]

## Ordre des 5 onglets de skins de prof - simple ordre de classe, pas de notion de rarete/tri ici
## (a la difference de RARITY_DISPLAY_ORDER) puisque chaque classe a son propre onglet dedie.
const PROF_SKIN_GRADES: Array[GradeLevel.Grade] = [
	GradeLevel.Grade.CP,
	GradeLevel.Grade.CE1,
	GradeLevel.Grade.CE2,
	GradeLevel.Grade.CM1,
	GradeLevel.Grade.CM2,
]

@export var available_crates: Array[LootTableResource] = []
## Bouton IconDock a cloner pour title_icon (voir commentaire de classe) - assigne dans game_ui.tscn.
@export var title_icon_source_path: NodePath

@onready var title_icon: TextureRect = $Panel/TitleRow/TitleIcon
@onready var tabs: TabContainer = $Panel/Margin/Content/Tabs
@onready var item_grid: GridContainer = $Panel/Margin/Content/Tabs/Cartes/TabMargin/Layout/ItemGrid
## Un GridContainer par classe, cle par GradeLevel.Grade - voir _ready() pour le remplissage et
## PROF_SKIN_GRADES pour l'ordre d'iteration.
@onready var prof_skin_grids: Dictionary = {
	GradeLevel.Grade.CP: $Panel/Margin/Content/Tabs/CP/TabMargin/ItemGrid,
	GradeLevel.Grade.CE1: $Panel/Margin/Content/Tabs/CE1/TabMargin/ItemGrid,
	GradeLevel.Grade.CE2: $Panel/Margin/Content/Tabs/CE2/TabMargin/ItemGrid,
	GradeLevel.Grade.CM1: $Panel/Margin/Content/Tabs/CM1/TabMargin/ItemGrid,
	GradeLevel.Grade.CM2: $Panel/Margin/Content/Tabs/CM2/TabMargin/ItemGrid,
}
@onready var confirm_overlay: Control = $ConfirmOverlay
@onready var confirm_label: Label = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmLabel
@onready var cancel_button: Button = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmButtonRow/CancelButton
@onready var confirm_button: Button = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmButtonRow/ConfirmButton
## Voir _show_insufficient_funds().
@onready var insufficient_funds_overlay: Control = $InsufficientFundsOverlay
## Texte reutilise entre les 2 causes possibles (pieces ou Defis, voir _show_insufficient_funds).
@onready var insufficient_funds_label: Label = $InsufficientFundsOverlay/InsufficientFundsCard/InsufficientFundsMargin/InsufficientFundsLabel
## Case de decor de classe de l'onglet "Succes" (voir ClassroomDecorItem) - une par classe, cle
## par GradeLevel.Grade, meme principe que prof_skin_grids.
@onready var classroom_decor_grid: GridContainer = $Panel/Margin/Content/Tabs/Succès/TabMargin/ItemGrid

## Les cases de coffres de l'onglet Cartes (2026-08-04, selecteur de quantite) : conservees pour
## pouvoir rafraichir leur plafond +/- d'un coup apres tout achat (voir _refresh_crate_items) -
## un achat sur une case peut changer le solde affecte a une AUTRE case de la meme rarete.
var _crate_items: Array[CrateItem] = []

## Les 50 cases de skins de prof (5 classes x 10 skins), tous onglets confondus - conservees pour
## pouvoir toutes les rafraichir d'un coup, meme principe que _crate_items.
var _prof_skin_items: Array[ProfSkinItem] = []

## Les 5 cases de decor de classe de l'onglet "Succes" (une par classe) - conservees pour pouvoir
## toutes les rafraichir d'un coup, meme principe que _prof_skin_items.
var _classroom_decor_items: Array[ClassroomDecorItem] = []

## Les 5 cases de musiques de classe, 2eme ligne du MEME ItemGrid que _classroom_decor_items (voir
## _ready()) - conservees separement pour pouvoir les rafraichir sans toucher aux cases de decor.
var _classroom_music_items: Array[ClassroomMusicItem] = []

## Achat en attente de validation par la popup de confirmation (voir _ask_confirm) : n'est
## execute que si le joueur clique "Oui" ou valide avec Entree, jamais directement au clic sur
## une case.
var _pending_purchase: Callable

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	var icon_source := get_node_or_null(title_icon_source_path) as Button
	if icon_source:
		title_icon.texture = icon_source.icon

	confirm_overlay.hide()
	cancel_button.pressed.connect(_close_confirm)
	confirm_button.pressed.connect(_on_confirm_accepted)

	## Pas d'intitule de rarete affiche au-dessus de chaque groupe (retour utilisateur 2026-08-01 :
	## faisait repetition avec le nom du lot et la couleur de la piece) - RARITY_DISPLAY_ORDER ne
	## sert plus qu'a trier les lots du moins au plus rare, sans en-tete visuel. Les coffres sont
	## des cases carrees dans ItemGrid plutot que des lignes pleine largeur.
	for rarity in RARITY_DISPLAY_ORDER:
		var crates_of_rarity: Array = available_crates.filter(
			func(c: LootTableResource) -> bool: return c.rarity == rarity
		)
		for crate in crates_of_rarity:
			var item := CrateItemScene.instantiate() as CrateItem
			item.loot_table = crate
			item.purchase_requested.connect(_on_purchase_requested)
			item_grid.add_child(item)
			_crate_items.append(item)

	for grade in PROF_SKIN_GRADES:
		var grid: GridContainer = prof_skin_grids[grade]
		for skin_index in ProfSkinCatalog.SKINS_PER_GRADE:
			var skin_item := ProfSkinItemScene.instantiate() as ProfSkinItem
			skin_item.grade = grade
			skin_item.skin_index = skin_index
			skin_item.purchase_requested.connect(_on_prof_skin_purchase_requested)
			skin_item.equip_requested.connect(_on_prof_skin_equip_requested)
			grid.add_child(skin_item)
			_prof_skin_items.append(skin_item)

	## Meme PROF_SKIN_GRADES (5 classes) pour l'onglet "Succes" : une seule case par classe, pas
	## de boucle interne comme pour les skins (pas d'index, un decor par classe).
	for grade in PROF_SKIN_GRADES:
		var decor_item := ClassroomDecorItemScene.instantiate() as ClassroomDecorItem
		decor_item.grade = grade
		decor_item.purchase_requested.connect(_on_classroom_decor_purchase_requested)
		decor_item.toggle_requested.connect(_on_classroom_decor_toggle_requested)
		classroom_decor_grid.add_child(decor_item)
		_classroom_decor_items.append(decor_item)

	## 2e ligne du MEME ItemGrid (2026-09-06, retour utilisateur : "ajoute 5 cases en 2eme ligne
	## de l onglet succes") : ajoutees APRES les 5 cases de decor ci-dessus dans le meme
	## classroom_decor_grid (GridContainer, columns=5) - 10 enfants sur 5 colonnes forment
	## naturellement 2 lignes, aucun 2e GridContainer necessaire.
	for grade in PROF_SKIN_GRADES:
		var music_item := ClassroomMusicItemScene.instantiate() as ClassroomMusicItem
		music_item.grade = grade
		music_item.purchase_requested.connect(_on_classroom_music_purchase_requested)
		music_item.toggle_requested.connect(_on_classroom_music_toggle_requested)
		classroom_decor_grid.add_child(music_item)
		_classroom_music_items.append(music_item)

	## Fige le joueur (deplacement + interaction) tant que la boutique est visible.
	visibility_changed.connect(_on_visibility_changed)

	_equalize_tab_widths()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
		## Le solde (donc le plafond +/- de chaque coffre) a pu changer depuis la derniere ouverture
		## (packs de questions reussis entre-temps) : recalcule a chaque ouverture plutot qu'une seule
		## fois a _ready().
		_refresh_crate_items()
		_refresh_prof_skin_items()
		_refresh_classroom_decor_items()
		_refresh_classroom_music_items()
	else:
		PlayerInputLock.unlock()
		_close_confirm()
		insufficient_funds_overlay.hide()

## Appele par BackpackMenu (icone "Récompenses"). N'a plus de parametre "who" depuis le retrait du
## kiosque en jeu (2026-08-29, voir commentaire de classe) - c'etait l'InteractableComponent.
## interacted du kiosque qui envoyait ce parametre, aucun appelant restant n'en a besoin.
func open() -> void:
	show()

## Appele par le CloseButton en haut d'IconDock et par BackpackMenu.close() (voir son commentaire
## de classe - ferme ce panneau avec la colonne).
func close() -> void:
	hide()

func _on_purchase_requested(loot_table: LootTableResource, quantity: int) -> void:
	if loot_table == null or quantity <= 0:
		return
	## Prix total = prix de base * quantite selectionnee sur la case (2026-08-04, voir
	## CrateItem._quantity) - la popup de confirmation affiche donc toujours le montant reel qui
	## sera depense, pas seulement le prix unitaire.
	var total_price := loot_table.crate_price * quantity
	## Message rouge a la place de la popup de confirmation si le solde est insuffisant (2026-09-05,
	## retour utilisateur : "je veux que le fait de cliquer sur la case d achat avec un montant de
	## pieces insuffisant affiche le message en popup a la place de la demande de confirmation
	## dachat") - necessaire car la case reste cliquable a quantite 1 meme inabordable (voir
	## _do_purchase_crate : CrateItem ne desactive que les boutons +/-, jamais la case elle-meme).
	## Verifie donc le solde ICI, avant _ask_confirm, plutot que de laisser la popup s'ouvrir pour
	## rien.
	if Economy.get_balance(loot_table.rarity) < total_price:
		_show_insufficient_funds()
		return
	var question: String
	if quantity > 1:
		question = "Acheter %d x « %s » pour %d ?" % [quantity, loot_table.crate_name, total_price]
	else:
		question = "Acheter « %s » pour %d ?" % [loot_table.crate_name, total_price]
	_ask_confirm(question, _do_purchase_crate.bind(loot_table, quantity))

func _do_purchase_crate(loot_table: LootTableResource, quantity: int) -> void:
	var total_price := loot_table.crate_price * quantity
	## Filet de securite (2026-09-05) : le solde insuffisant est desormais deja intercepte plus tot,
	## dans _on_purchase_requested, avant meme l'ouverture de la popup de confirmation - ce check ne
	## devrait donc plus jamais echouer en pratique (rien ne peut faire baisser le solde entre le
	## clic et la confirmation, le reste du jeu est verrouille tant que la popup est ouverte), mais
	## reste en place au cas ou, meme principe que le filet de securite de _do_prof_skin_purchase.
	if not Economy.try_spend(loot_table.rarity, total_price):
		_show_insufficient_funds()
		return
	## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
	## juste apres la mutation reelle (Economy.try_spend ci-dessus).
	SaveManager.log_event("depense_piece", {"rarity": int(loot_table.rarity), "montant": total_price})
	for i in quantity:
		var card := loot_table.draw_card()
		if card:
			CardCollection.add_card(card)
			EventBus.card_obtained.emit(card)
			SaveManager.log_event("carte_debloquee", {"card_id": str(card.id)})
	## Recalcule le plafond +/- des autres coffres de la meme rarete (voir _refresh_crate_items) :
	## la case achetee repart a 1, les autres voient juste leur plafond +/- recalcule.
	_refresh_crate_items(loot_table)
	## Un coffre commun/peu commun peut avoir depense la meme monnaie qu'un skin de prof (voir
	## ProfSkins.SKIN_PRICE, meme monnaie que GradeLevel.get_rarity) : rafraichit aussi les
	## skins pour regriser ceux devenus inabordables.
	_refresh_prof_skin_items()
	## Sauvegarde automatique (2026-08-01) : un achat modifie Economy et CardCollection,
	## autant persister tout de suite plutot que de compter sur le bouton manuel du menu.
	SaveManager.save_current_account()

## Affiche la popup de confirmation d'achat au dessus de tout le panneau (voir
## _on_purchase_requested). Le bouton
## "Oui" recoit le focus par defaut : Entree/ui_accept le declenche donc directement. Echap
## (ui_cancel, voir _unhandled_input) annule sans rien acheter.
func _ask_confirm(text: String, on_confirm: Callable) -> void:
	confirm_label.text = text
	_pending_purchase = on_confirm
	confirm_overlay.show()
	confirm_button.grab_focus()

func _on_confirm_accepted() -> void:
	var callback := _pending_purchase
	_close_confirm()
	if callback.is_valid():
		callback.call()

func _close_confirm() -> void:
	confirm_overlay.hide()
	_pending_purchase = Callable()

## Popup rouge temporaire (2026-09-05, retour utilisateur : "lorsque la somme de piece nest pas
## suffisante pour achter un item de la boutique , met un message : 'Pieces necessaires
## insuffisantes' en rouge") - InsufficientFundsOverlay est un vrai popup plein ecran (Dimmer +
## carte centree), meme structure que ConfirmOverlay (Dimmer + ConfirmCard) mais sans boutons - un
## simple message qui se masque tout seul, pas de choix a faire. Auto-masque apres
## INSUFFICIENT_FUNDS_SECONDS - meme technique que CardRevealOverlay._spawn_sparkles
## (create_tree().create_timer plutot qu'un Timer noeud dedie, pas besoin de le reutiliser/
## l'arreter ailleurs) ; un second appel pendant que le message est deja visible relance
## simplement un nouveau minuteur (avec le nouveau texte s'il differe), sans consequence. Le
## Dimmer bloque les clics vers le reste du panneau tant que le popup est affiche, meme
## comportement que ConfirmOverlay.
##
## [message] parametrable (2026-09-06, voir INSUFFICIENT_COINS_TEXT/INSUFFICIENT_CHALLENGES_TEXT)
## depuis l'ajout de l'onglet "Succes" : ce popup sert desormais 2 causes differentes (pieces ou
## Defis insuffisants), meme mecanique, texte different - defaut sur le texte pieces pour ne pas
## casser les appels existants (_do_purchase_crate/_do_prof_skin_purchase).
func _show_insufficient_funds(message: String = INSUFFICIENT_COINS_TEXT) -> void:
	insufficient_funds_label.text = message
	insufficient_funds_overlay.show()
	get_tree().create_timer(INSUFFICIENT_FUNDS_SECONDS).timeout.connect(insufficient_funds_overlay.hide)

## Rafraichit le plafond +/- de chaque case de coffre (voir CrateItem.refresh_availability) :
## [just_purchased], si fourni, repart specifiquement a 1 (voir CrateItem.reset_quantity) plutot
## que de garder la quantite choisie pour l'achat qui vient d'avoir lieu ; les autres cases de la
## meme rarete ne font que voir leur plafond recalcule avec le nouveau solde.
func _refresh_crate_items(just_purchased: LootTableResource = null) -> void:
	for crate_item in _crate_items:
		if just_purchased != null and crate_item.loot_table == just_purchased:
			crate_item.reset_quantity()
		else:
			crate_item.refresh_availability()

func _on_prof_skin_purchase_requested(grade: GradeLevel.Grade, skin_index: int) -> void:
	## Meme verification prealable que _on_purchase_requested (2026-09-05) : en pratique ProfSkinItem
	## se desactive deja quand le solde est insuffisant (voir refresh()), ce cas ne devrait donc pas
	## se produire ici - garde tout de meme la meme coherence de comportement (message rouge plutot
	## que popup de confirmation) si jamais atteint.
	if Economy.get_balance(GradeLevel.get_rarity(grade)) < ProfSkins.SKIN_PRICE:
		_show_insufficient_funds()
		return
	var question := "Débloquer ce skin de Prof du %s pour %d ?" % [GradeLevel.get_label(grade), ProfSkins.SKIN_PRICE]
	_ask_confirm(question, _do_prof_skin_purchase.bind(grade, skin_index))

func _do_prof_skin_purchase(grade: GradeLevel.Grade, skin_index: int) -> void:
	## Contrairement a l'achat de coffre (deja couvert par Sfx.CARD_REVEAL via
	## card_reveal_overlay.gd), un skin de prof n'a pas d'animation dediee - son propre son.
	## En pratique try_unlock() n'echoue quasiment jamais ici (solde insuffisant OU deja possede) :
	## ProfSkinItem se desactive deja des que le solde est insuffisant (voir refresh()), et un
	## skin deja possede emet equip_requested plutot que purchase_requested (voir _on_pressed) -
	## le message rouge reste un filet de securite (2026-09-05, voir _show_insufficient_funds()),
	## pas le chemin normal.
	if ProfSkins.try_unlock(grade, skin_index):
		SoundManager.play(SoundManager.Sfx.PURCHASE)
		## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
		## try_unlock() spend ET equipe en un seul appel (voir ProfSkins.try_unlock), donc 2
		## evenements distincts ici pour refleter les 2 effets separement cote serveur (economy
		## d'un cote, prof_skins de l'autre - voir schema.sql).
		SaveManager.log_event("depense_piece", {"rarity": int(GradeLevel.get_rarity(grade)), "montant": ProfSkins.SKIN_PRICE})
		SaveManager.log_event("achat_skin_prof", {"grade": int(grade), "skin_index": skin_index})
	else:
		_show_insufficient_funds()
	_refresh_prof_skin_items()
	## Sauvegarde automatique (2026-08-01) : voir le meme commentaire dans _do_purchase_crate.
	SaveManager.save_current_account()

## Reequipement d'un skin deja possede : gratuit, aucune popup de confirmation (voir
## ProfSkinItem._on_pressed et le commentaire de classe) - applique et sauvegarde directement.
func _on_prof_skin_equip_requested(grade: GradeLevel.Grade, skin_index: int) -> void:
	ProfSkins.set_active(grade, skin_index)
	## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) -
	## distinct de "achat_skin_prof" ci-dessus : ici aucun achat, juste un changement d'equipement
	## gratuit d'un skin deja possede.
	SaveManager.log_event("skin_actif_change", {"grade": int(grade), "skin_index": skin_index})
	_refresh_prof_skin_items()
	SaveManager.save_current_account()

## Rafraichit les 50 cases de skins de prof d'un coup (voir ProfSkinItem.refresh()) : plus simple
## qu'identifier laquelle a besoin d'etre mise a jour, meme raison que _refresh_grade_items avant
## son retrait.
func _refresh_prof_skin_items() -> void:
	for skin_item in _prof_skin_items:
		skin_item.refresh()

## Onglet "Succes" (2026-09-06, retour utilisateur : "je veux me servir des succes remportés
## comme monnaie pour debloquer de nouveaux environnements de classe (nouveau decor) achetable si
## les succes sont validés") - meme schema que _on_purchase_requested/_on_prof_skin_purchase_
## requested : verifie ClassroomDecor.can_unlock AVANT d'ouvrir la popup de confirmation, popup
## "insuffisant" (texte Defis) sinon, jamais de popup de confirmation vouee a l'echec.
func _on_classroom_decor_purchase_requested(grade: GradeLevel.Grade) -> void:
	if not ClassroomDecor.can_unlock(grade):
		_show_insufficient_funds(INSUFFICIENT_CHALLENGES_TEXT)
		return
	var question := "Débloquer le décor de la classe %s ?" % GradeLevel.get_label(grade)
	_ask_confirm(question, _do_classroom_decor_purchase.bind(grade))

func _do_classroom_decor_purchase(grade: GradeLevel.Grade) -> void:
	## Filet de securite (meme raison que _do_purchase_crate/_do_prof_skin_purchase) : ne devrait
	## plus jamais echouer en pratique, le solde de Defis valides ne peut pas baisser entre le
	## clic et la confirmation.
	if not ClassroomDecor.try_unlock(grade):
		_show_insufficient_funds(INSUFFICIENT_CHALLENGES_TEXT)
		return
	## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
	## deblocage via les Defis, jamais de piece depensee ici (voir ClassroomDecor.try_unlock).
	SaveManager.log_event("decor_debloque", {"grade": int(grade)})
	SoundManager.play(SoundManager.Sfx.PURCHASE)
	_refresh_classroom_decor_items()
	## Sauvegarde automatique (2026-08-01) : voir le meme commentaire dans _do_purchase_crate.
	SaveManager.save_current_account()

## Rafraichit les 5 cases de decor de classe d'un coup (voir ClassroomDecorItem.refresh()) - meme
## principe que _refresh_prof_skin_items.
func _refresh_classroom_decor_items() -> void:
	for decor_item in _classroom_decor_items:
		decor_item.refresh()

## Bascule active/inactive (2026-09-06, 2e passe, retour utilisateur : "afin de pouvoir
## selectionner le decor de classe de base ou la musique originale: selectionner une case fera
## changer le decor ou la musique, recliquer sur une case active deselectionnera celle si et
## retournera le decor ou la musique de base") - emis uniquement par une case DEJA debloquee (voir
## ClassroomDecorItem._on_pressed), action gratuite et instantanee, meme schema que
## _on_prof_skin_equip_requested (pas de popup de confirmation, ClassroomDecor.toggle_active ne
## peut pas echouer sur une case debloquee).
func _on_classroom_decor_toggle_requested(grade: GradeLevel.Grade) -> void:
	var new_active := ClassroomDecor.toggle_active(grade)
	## Journal d'evenements pour la synchro serveur (2026-09-13, retour utilisateur "il faut que les
	## options du jeu suivent partout" - voir SaveManager.log_event() et fn_pousser_evenements dans
	## schema.sql pour la regle d'exclusivite repliquee cote serveur).
	SaveManager.log_event("decor_actif_change", {"grade": int(grade), "actif": new_active})
	_refresh_classroom_decor_items()
	SaveManager.save_current_account()

## 2e ligne de l'onglet "Succes" (2026-09-06, retour utilisateur : "ajoute 5 cases en 2eme ligne
## de l onglet succes. lorsque les defis sont aux niveaux argent on debloquera de nouvelles
## musiques que je provisionnerai plus tard") - meme schema que _on_classroom_decor_purchase_
## requested, seuil different (ClassroomMusic.can_unlock, palier argent) et texte de confirmation
## different. Reutilise le meme INSUFFICIENT_CHALLENGES_TEXT que le decor ("Défis nécessaires
## insuffisants" reste correct quel que soit le palier vise).
func _on_classroom_music_purchase_requested(grade: GradeLevel.Grade) -> void:
	if not ClassroomMusic.can_unlock(grade):
		_show_insufficient_funds(INSUFFICIENT_CHALLENGES_TEXT)
		return
	var question := "Débloquer les musiques de la classe %s ?" % GradeLevel.get_label(grade)
	_ask_confirm(question, _do_classroom_music_purchase.bind(grade))

func _do_classroom_music_purchase(grade: GradeLevel.Grade) -> void:
	## Filet de securite (meme raison que _do_classroom_decor_purchase).
	if not ClassroomMusic.try_unlock(grade):
		_show_insufficient_funds(INSUFFICIENT_CHALLENGES_TEXT)
		return
	## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
	## deblocage via les Defis, jamais de piece depensee ici (voir ClassroomMusic.try_unlock).
	SaveManager.log_event("musique_debloquee", {"grade": int(grade)})
	SoundManager.play(SoundManager.Sfx.PURCHASE)
	_refresh_classroom_music_items()
	## Sauvegarde automatique (2026-08-01) : voir le meme commentaire dans _do_purchase_crate.
	SaveManager.save_current_account()

## Rafraichit les 5 cases de musiques de classe d'un coup (voir ClassroomMusicItem.refresh()) -
## meme principe que _refresh_classroom_decor_items.
func _refresh_classroom_music_items() -> void:
	for music_item in _classroom_music_items:
		music_item.refresh()

## Bascule active/inactive de la 2e ligne (meme mecanique que _on_classroom_decor_toggle_
## requested, voir son commentaire pour le detail).
func _on_classroom_music_toggle_requested(grade: GradeLevel.Grade) -> void:
	var new_active := ClassroomMusic.toggle_active(grade)
	## Journal d'evenements pour la synchro serveur (2026-09-13) - meme raison que
	## _on_classroom_decor_toggle_requested ci-dessus.
	SaveManager.log_event("musique_active_change", {"grade": int(grade), "actif": new_active})
	_refresh_classroom_music_items()
	SaveManager.save_current_account()

## Force chaque onglet a la largeur du plus large ET garde son titre centre (voir le
## commentaire de classe, 15e passe, pour l'historique complet). Attend une frame (await
## process_frame) car TabBar ne calcule la largeur naturelle de chaque onglet (get_tab_rect,
## basee sur les metriques de la police) qu'apres un premier passage de mise en page - avant ca
## toutes les largeurs remonteraient a 0. Pour chaque onglet plus etroit que le plus large, le
## titre recoit le meme nombre d'espaces avant et apres (mesures en pixels via le Font
## reellement utilise par TabBar, pas suppose en dur) pour combler exactement la moitie de
## l'ecart de chaque cote - le texte visible reste donc centre.
func _equalize_tab_widths() -> void:
	await get_tree().process_frame
	var tab_bar := tabs.get_tab_bar()
	var font: Font = tab_bar.get_theme_font("font")
	var font_size: int = tab_bar.get_theme_font_size("font_size")
	var space_width: float = font.get_string_size(" ", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var titles: Array[String] = []
	var widths: Array[float] = []
	for i in tab_bar.tab_count:
		titles.append(tab_bar.get_tab_title(i))
		widths.append(tab_bar.get_tab_rect(i).size.x)
	var max_width: float = widths.max()
	for i in tab_bar.tab_count:
		var gap := max_width - widths[i]
		if gap <= 0.0 or space_width <= 0.0:
			continue
		var side_spaces: int = maxi(0, roundi(gap / 2.0 / space_width))
		if side_spaces == 0:
			continue
		var padding: String = " ".repeat(side_spaces)
		tab_bar.set_tab_title(i, padding + titles[i] + padding)
