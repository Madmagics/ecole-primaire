## Colonne d'icones "Sac a dos" en haut a droite de l'ecran (2026-08-26, retour utilisateur : "on
## va partir sur un nouveau modele de groupes d'icones situe a droite de l'ecran; on va faire
## exactement pareil que du cote gauche: cest a dire une icone principale : le sac a dos: qui ouvre
## un menu colonne avec le sac de piece et le livre"). Meme composant visuel que la colonne de
## gauche de GameMenuPanel (voir ui/game_menu/icon_dock.tscn, instancie ici ET la-bas : modifier son
## cadre/ses marges/sa hauteur met a jour les deux colonnes a la fois, comme demande - "je la veux
## commune si bien que si on modifie une l'autre sera modifiee aussi") mais SANS fenetre de contenu
## integree : chaque icone ouvre directement son propre panneau modal existant (Sac de pieces ->
## InventoryPanel, Livre -> CardAlbum, Succes -> SuccessPanel), exactement comme le faisaient les 3
## icones permanentes qu'elle remplace (CollectionButton/WalletButton/InventoryButton, voir
## l'ancien game_ui.tscn).
##
## Le bouton "sac a dos" (voir BackpackButton dans game_ui.tscn) ne fait qu'ouvrir/fermer cette
## colonne via toggle() - il n'a plus d'ecran propre : BackpackPanel ("Bientot disponible !") est
## retire, son role de hub est repris par cette colonne (retour utilisateur : "on y ajoutera du
## contenu plus tard directement en relation avec les gains du jeu" - le contenu futur s'ajoutera
## ICI, comme nouvelles icones de la colonne, pas dans un ecran separe).
##
## "Defis" quitte GameMenuPanel et rejoint cette colonne, renomme "Succes" (meme retour
## utilisateur : "on va y transferer l'icone actuelle defis qu'on va renommer en succes") : voir
## SuccesButton ci-dessus et ui/success/success_panel.gd (nouveau panneau modal autonome, meme
## moule que BackpackPanel avant sa retraite, remplace SectionDefis).
##
## "Sac de pieces" devient "Récompenses" (2026-08-29, retour utilisateur : "licone sac de piece
## devient la section Récompenses : dans la fenetre correpondante on aura la fenetre boutique
## actuelle") : SacDePiecesButton (nom de noeud/variable INCHANGE, meme convention que
## InventoryPanel qui garde son nom historique - voir son .gd - seul le libelle visible change)
## ouvre desormais ShopPanel (wallet_panel_path pointe sur "../ShopPanel" dans game_ui.tscn) au
## lieu de l'ancien InventoryPanel, retire (doublon - son role de resume des soldes est repris par
## RewardsBand dans ShopPanel, voir shop_panel.gd). ShopPanel reste aussi ouvrable par le kiosque
## de la scene, independamment de cette colonne - les deux chemins ouvrent le meme noeud.
##
## Chaque bouton ouvre son panneau SANS fermer la colonne (2026-08-26, retour utilisateur : "je
## veux aussi que les fenetre et la colonne de droite apparaissent en meme temps comme pour la
## colonne de gauche avec ses menus et fenetres") : jusque-la _open_panel() appelait close() juste
## apres panel.open() (comportement de menu deroulant, la colonne se refermait des qu'on choisissait
## une icone) - retire pour que la colonne reste visible en meme temps que le panneau ouvert, exactement
## comme IconDock reste visible a cote du Panel de contenu dans GameMenuPanel.
##
## Un seul panneau visible a la fois (meme retour utilisateur, comparaison explicite avec le menu de
## gauche : "un click sur une autre icone fait disparaitre la premiere fenetre et apparaitre
## lautre") : _open_panel() ferme les 2 autres panneaux de cette colonne avant d'ouvrir le nouveau -
## voir son commentaire pour le detail.
##
## Verrouille les deplacements du joueur tant qu'elle est visible (PlayerInputLock, compteur - reste
## verrouille le temps que le panneau ouvert prenne le relais, voir player_input_lock.gd), se ferme
## avec Echap ou en re-cliquant sur BackpackButton (toggle()).
##
## ATTENTION EDITEUR : IconDock/IconList contient les 3 boutons ci-dessus comme enfants "editables"
## d'une scene instanciee (icon_dock.tscn, voir game_menu_panel.gd pour le meme mecanisme cote
## gauche) - ne JAMAIS decocher "Editable Children" sur le noeud IconDock sous peine de perdre ces
## 3 boutons au prochain enregistrement dans l'editeur (incident deja rencontre sur les instances
## NPC de school.tscn, documente en memoire projet).
##
## Largeur de colonne et tailles d'icones (2026-08-26, deux retours utilisateur le meme jour) :
## d'abord retrecie de 25% (icones a native x0,45, marge IconList 20->15px), puis revenue en
## arriere sur la taille des icones ("taille d icone retour a la taille precedente") tout en
## gardant la colonne etroite via la marge interieure seule, reduite a 5px ("on reduit la marge
## interieur a 5 px") - les icones gardent leur taille native x0,6 d'origine, seule la marge
## autour d'elles a change. IconDock (partage avec GameMenuPanel, voir icon_dock.tscn) fait
## desormais 93px de large (icone la plus large, SuccesButton a 83px, + 5px de marge de chaque
## cote) au lieu de 148px a l'origine. offset_left suit (-113, etait -168) pour garder la meme
## largeur en miroir du dock de gauche. Chaque bouton garde size_flags_horizontal = SIZE_SHRINK_
## CENTER (4, deja en place) pour rester centre dans IconList quelle que soit sa propre largeur.
##
## Marges resserrees, coherence gauche/droite (2026-08-29, retour utilisateur suite a un comparatif
## demande entre les marges des colonnes gauche et droite - la colonne droite etait collee a ses
## fenetres (0px) alors que la gauche gardait 20px : "on va passer a 10px de chaque cote entre la
## colonne et la fenetre, on va aussi reduire toutes les marges exterieures entre fenetre et bord de
## l ecran en haut en bas a droite et a gauche, applique cette mod a toutes les fentres et tous les
## menus du jeu" - portee precisee aux seules fenetres ouvertes depuis une colonne d'icones (celles
## de GameMenuPanel/BackpackMenu), pas aux fenetres NPC/Boutique qui gardent leur propre design.
## IconDock passe de 40/-40 a 20/-20 en haut/bas (etait deja a 20px en horizontal, desormais
## uniforme sur les 4 cotes) - voir game_menu_panel.gd pour le detail complet de la formule.
##
## Echap ferme la colonne ET le panneau ouvert (2026-08-29, retour utilisateur : "l action ECHAP
## doit fermer le menu ET la fenetre, actuellement ca fonctionne bien avec la colonne de gauche mais
## a droite la fenetre reste ouverte"). Cause : contrairement a GameMenuPanel (un seul noeud racine
## contenant IconDock ET Panel - un close() ferme les deux d'un coup), BackpackMenu et ses 3
## panneaux (InventoryPanel/CardAlbum/SuccessPanel) sont des noeuds SEPARES de UI, chacun avec son
## propre _unhandled_input sur "ui_cancel". Le premier noeud traite dans l'ordre de parcours de
## l'arbre consomme l'evenement (set_input_as_handled()) et empeche l'autre de le recevoir - si
## BackpackMenu passe en premier, il se ferme mais le panneau ouvert ne voit jamais l'Echap. Fix :
## close() ferme desormais explicitement les 3 panneaux externes en plus de la colonne elle-meme
## (meme liste que _open_panel(), voir plus bas) - qu'importe qui consomme l'evenement en premier,
## fermer la colonne ferme toujours tout avec elle. S'applique aussi au clic sur BackpackButton
## (toggle()), pas seulement a Echap, pour un comportement homogene.
##
## mouse_filter = 2 (IGNORE) sur ce noeud racine (2026-08-29, retour utilisateur : "check les croix
## de fermeture sur les fenetre du menu de droite, elles ne fonctionne plus au click") : BackpackMenu
## est un Control PLEIN ECRAN (anchors_preset=15) ajoute apres InventoryPanel/CardAlbum/SuccessPanel
## dans game_ui.tscn (donc dessine par-dessus). Par defaut (mouse_filter=STOP), sa zone vide en
## dehors d'IconDock capturait tous les clics de l'ecran, y compris ceux destines aux croix de
## fermeture de ces 3 panneaux SIBLINGS situes en dessous - aucun rapport avec IconDock lui-meme
## (Panel, reste a mouse_filter par defaut, continue de capter normalement les clics sur ses propres
## boutons). Meme fix que BlurBG dans game_menu_panel.tscn (deja a mouse_filter=2 pour la meme
## raison, zone plein ecran vide au-dessus d'elements cliquables).
##
## Croix de fermeture unique en haut de la colonne (2026-08-29, retour utilisateur : "dorenavant la
## fermeture de l ensemble colonne d icone et fermeture fenetre soperera par la touche ECHAP ou une
## croix situee en haut de la colonne au lieu de la croix dans chaque fenetre qui sera a enlever") :
## les croix individuelles de ShopPanel/CardAlbum/SuccessPanel sont retirees (voir leurs .gd/.tscn
## respectifs) - CloseButton vit desormais DANS icon_dock.tscn (scene de base partagee avec
## GameMenuPanel, voir plus haut), enfant DIRECT d'IconDock (pas d'IconList), visible en haut de la
## colonne des DEUX cotes a la fois sans dupliquer le noeud. Connecte ici a close() (ferme la
## colonne ET les 3 panneaux externes, voir plus bas) - meme comportement que Echap, juste un autre
## moyen d'y acceder.
##
## Croix collee au bord superieur du Panel (2026-08-29, meme jour, retour utilisateur suivant :
## "colle la croix en haut de la colonne des 2 cotés") : d'abord placee comme premier enfant
## d'IconList (alignment=1/centre) - retour du jour meme : elle suivait alors le centrage du bloc
## d'icones au lieu de rester fixe en haut du Panel. Sortie d'IconList, ancree en haut/centree
## horizontalement d'IconDock (voir icon_dock.tscn) - meme changement que game_menu_panel.gd/
## game_menu_panel.tscn, partage entre les deux colonnes comme le reste d'IconDock.
##
## Page de base a l'ouverture + flou plein ecran cote droit (2026-08-29, retour utilisateur : "tout
## comme le menu de gauche ouvre une colonne d icones et la page configuration avec du floutage en
## arriere plan, je veux que le menu de droite ouvre la boutique comme page de base, que le fond en
## arriere plan soit floute de la meme maniere que l autre menu") :
## - **Page de base** : open() appelle desormais _open_panel(wallet_panel_path) juste apres show(),
##   donc ShopPanel (Boutique/Récompenses) s'affiche automatiquement des l'ouverture de la colonne,
##   meme si aucune icone n'a ete cliquee - exactement comme GameMenuPanel.open() affiche toujours
##   Configuration via _show_config(). Cliquer sur Livre/Succes bascule ensuite normalement (voir
##   _open_panel), et re-ouvrir la colonne apres fermeture revient toujours a la Boutique (pas de
##   memoire du dernier panneau consulte - meme comportement que le menu de gauche).
## - **Flou** : contrairement a GameMenuPanel, ou BlurBG est un enfant DIRECT du panneau (peut donc
##   se dessiner sous son propre Panel/IconDock sans rien connaitre d'autre), ShopPanel/CardAlbum/
##   SuccessPanel sont des noeuds SEPARES de BackpackMenu dans game_ui.tscn (voir plus haut) - un
##   BlurBG enfant de BackpackMenu se dessinerait PAR-DESSUS ces panneaux (puisque BackpackMenu est
##   place apres eux dans l'arbre, voir "mouse_filter = 2" plus haut), donc flouterait aussi leur
##   contenu au lieu de rester derriere. Un nouveau noeud BackpackBlurBG (meme shader/materiau que
##   BlurBG cote gauche, meme ext_resource icon_dock_blur.gdshader) est ajoute directement dans
##   game_ui.tscn, PLACE AVANT CardAlbum/SuccessPanel/ShopPanel (donc dessine en dessous des trois)
##   mais controle depuis ici via blur_bg_path (nouveau NodePath export, voir plus haut) -
##   _on_visibility_changed() synchronise sa visibilite sur celle de la colonne, meme mecanisme que
##   les 3 panneaux externes deja pilotes par NodePath (wallet_panel_path etc.).
##
## Marge au-dessus de la croix alignee sur 10px (2026-08-29, meme jour, retour utilisateur : "appplique
## la meme marge au dessus des croix de fermeture des menu colonne que sur les cotes 10px?") : correctif
## dans icon_dock.tscn (partage avec GameMenuPanel, voir son commentaire de classe pour le detail
## complet) - offset_top de CloseButton 8->10 (reprend la marge colonne<->fenetre de 10px deja utilisee
## ailleurs), IconList.offset_top 44->46 pour garder le meme ecart de 8px sous la croix.
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## (Echap pour fermer la colonne et le panneau ouvert) est retire - close_column_button fait deja
## exactement ca a la souris/au tactile (voir close() ci-dessous, logique inchangee).
class_name BackpackMenu
extends Control

## NodePaths plutot que des exports directs de type Control (meme raison que MenuToggleButton.
## toggled_panel_paths, voir son commentaire) : assignes dans game_ui.tscn.
@export var wallet_panel_path: NodePath
@export var collection_panel_path: NodePath
@export var success_panel_path: NodePath
## Flou plein ecran derriere la colonne + le panneau ouvert (voir commentaire d'entete, "Page de
## base a l'ouverture + flou plein ecran cote droit") : NodePath vers BackpackBlurBG (game_ui.tscn),
## un ColorRect EXTERNE a cette scene (pas un enfant, contrairement a BlurBG dans
## game_menu_panel.tscn) - doit rester positionne AVANT CardAlbum/SuccessPanel/ShopPanel dans
## game_ui.tscn pour se dessiner sous eux (pas de commentaire dans le .tscn lui-meme, voir cette
## entree pour le detail).
@export var blur_bg_path: NodePath

@onready var close_column_button: Button = $IconDock/CloseButton
@onready var sac_de_pieces_button: Button = $IconDock/IconList/SacDePiecesButton
@onready var livre_button: Button = $IconDock/IconList/LivreButton
@onready var succes_button: Button = $IconDock/IconList/SuccesButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_column_button.pressed.connect(close)
	sac_de_pieces_button.pressed.connect(_open_panel.bind(wallet_panel_path))
	livre_button.pressed.connect(_open_panel.bind(collection_panel_path))
	succes_button.pressed.connect(_open_panel.bind(success_panel_path))
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	var blur_bg := get_node_or_null(blur_bg_path) as CanvasItem
	if blur_bg:
		blur_bg.visible = visible
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Ouvre le panneau vise par [panel_path] SANS fermer la colonne (voir commentaire d'entete :
## "les fenetre et la colonne de droite [doivent] apparaitre en meme temps"), mais ferme les 2
## AUTRES panneaux de cette colonne au passage (2026-08-26, retour utilisateur : "un click sur une
## autre icone fait disparaitre la premiere fenetre et apparaitre lautre") - un seul panneau visible
## a la fois, meme principe que _hide_all_sections()/_show_xxx() dans GameMenuPanel, adapte ici a 3
## panneaux externes (pas des enfants de cette scene) plutot qu'a des sections internes.
func _open_panel(panel_path: NodePath) -> void:
	for other_path in [wallet_panel_path, collection_panel_path, success_panel_path]:
		if other_path == panel_path:
			continue
		var other := get_node(other_path) as Control
		if other and other.has_method("close"):
			other.close()
	var panel := get_node(panel_path) as Control
	if panel and panel.has_method("open"):
		panel.open()

## Appele par BackpackButton (voir game_ui.tscn). Ouvre aussi la Boutique par defaut (voir
## commentaire d'entete, "Page de base a l'ouverture") - meme principe que GameMenuPanel.open()
## qui affiche toujours Configuration.
func open() -> void:
	show()
	_open_panel(wallet_panel_path)

## Ferme aussi les 3 panneaux externes de la colonne (2026-08-29, retour utilisateur : "l action
## ECHAP doit fermer le menu ET la fenetre, actuellement ca fonctionne bien avec la colonne de
## gauche mais a droite la fenetre reste ouverte") - voir le commentaire d'entete pour le detail.
func close() -> void:
	for path in [wallet_panel_path, collection_panel_path, success_panel_path]:
		var panel := get_node(path) as Control
		if panel and panel.has_method("close"):
			panel.close()
	hide()

func toggle() -> void:
	if visible:
		close()
	else:
		open()
