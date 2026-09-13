## Livre de collection en plein ecran. Une page = 1 ligne de 5 cartes = une seule categorie
## (chat, chien...) : depuis le passage rarete->classe (2026-07-26), une categorie a toujours
## exactement 5 variantes (une par classe CP-CM2), donc une page = une categorie complete, sans
## exception a gerer. Autant de pages que necessaire (= nombre d'especes), navigables via
## Precedent/Suivant. Scanne data/card/resources/ au demarrage (voir CsvResourceImporter/
## import_cards.gd) : aucune liste a maintenir a la main.
## S'ouvre via l'icone "Livre" de la colonne BackpackMenu, se ferme via le CloseButton en haut de
## cette meme colonne (plus de croix de fermeture propre depuis le 2026-08-29, voir plus bas ;
## plus aucun raccourci clavier depuis le 2026-09-02, voir plus bas).
##
## 2026-07-26 : passage de 2 lignes/10 cartes a 1 ligne/5 cartes par page (refonte demandee par
## Steve), ce qui libere de la place verticale -> les cartes sont passees a l'echelle x1.5 en
## meme temps (voir CARD_SIZE dans CardSlot). Voir card_album.tscn pour les dimensions du
## ScrollContainer, a ajuster ensemble si la taille de carte change encore.
##
## 2026-07-26 (suite) : fond "parchemin" ajoute (voir AtlasBackground) derriere tout le Panel,
## titre souligne (TitleUnderline) au lieu d'un encadre, et categorie de la page affichee sous
## le titre (CategoryLabel, rempli ici dans _refresh()). Le double lisere du parchemin est tres
## pres du bord du Panel : la grille de cartes et la barre de navigation ont ete reculees en
## consequence (voir offsets dans card_album.tscn) pour ne jamais le chevaucher.
##
## 2026-07-26 (suite) : la carte de gauche touchait le lisere interieur sur certaines resolutions.
## Cause : un ScrollContainer redimensionne son enfant unique au plein format des qu'il a le flag
## EXPAND, mais sans le centrer - le GridContainer s'etalait donc depuis le bord gauche exact du
## ScrollContainer. Fix : GridContainer deplace dans un CenterContainer (Panel/ScrollContainer/
## CenterContainer/GridContainer), qui le laisse a sa taille naturelle et le centre - la marge
## devient donc symetrique des deux cotes. h_separation reduit de 16 a 8 en complement, pour
## degager encore plus de marge de part et d'autre de la rangee.
##
## 2026-07-26 (suite) : page 1 vide au tout premier affichage (les cartes n'apparaissaient
## qu'apres avoir tourne une page). Cause : card_album.tscn etait le seul panneau de l'UI a ne
## PAS avoir "visible = false" sur son noeud racine (contrairement a SubjectSelectPanel,
## ShopPanel, etc.) - il demarrait donc affiche par defaut, avant tout appel a open(), qui est
## le seul endroit qui declenchait _refresh() (donc le seul qui peuplait la grille). Fix : ajout
## de "visible = false" sur le noeud racine dans card_album.tscn (aligne sur les autres panneaux)
## + appel de _refresh() ici en plus de _load_pages(), par securite si jamais le livre redevient
## visible par un autre chemin que open().
## Panel retreci a droite (offset_right -40 -> -113) pour border directement IconDock de BackpackMenu
## (2026-08-26, retour utilisateur, capture d'ecran comparant menu de gauche/droite : "le click sur
## l icone fait apparaitre la fenetre correspondant a l icone a cote de la colonne menu... en ce qui
## concerne le livre de cartes, on va garder le contenu mais on va passer sur un contour de fenetre
## identique aux autres fenetre des menus") : meme format de fenetre que InventoryPanel/SuccessPanel
## desormais (voir leurs .gd respectifs). Le contenu (5 cartes par page) est conserve tel quel comme
## demande - seul ScrollContainer (centre sur Panel, largeur fixe) retrecit en consequence, de 1040
## a 990px (offset ±520 -> ±495), pour continuer a loger les 5 cartes (5 x 193,5px + 4 x 8px de
## separation = 967,5px de large) sans les faire deborder du Panel desormais plus etroit (999px de
## large disponible, marge ~4,5px de chaque cote - volontairement serre, coherent avec la reduction
## des marges demandee ailleurs le meme jour). TitleBlock/PageLabel/PrevButton/NextButton n'ont pas
## eu besoin de changer : ancres en pourcentage/cote-relatif au Panel, ils suivent automatiquement.
##
## Marges resserrees (2026-08-29, meme retour utilisateur qu'InventoryPanel.gd/SuccessPanel.gd, voir
## leurs commentaires pour le detail complet) : offset_left 40->20, offset_top/bottom 40/-40->20/-20
## (marge ecran), offset_right -113->-123 (marge colonne<->fenetre 0->10px) - le Panel regagne au
## final 10px de large net (999->1009px) malgre la marge colonne qui augmente, grace a la marge
## ecran qui baisse de 20px de plus. ScrollContainer suit et s'elargit de 990 a 1000px (offset
## ±495 -> ±500) pour garder les memes ~4,5px de marge de chaque cote autour de la grille de cartes.
##
## Croix de fermeture retiree (2026-08-29, meme jour, retour utilisateur suivant : "dorenavant la
## fermeture de l ensemble colonne d icone et fermeture fenetre soperera par la touche ECHAP ou une
## croix situee en haut de la colonne au lieu de la croix dans chaque fenetre qui sera a enlever") :
## se ferme desormais via Echap (_unhandled_input/ui_cancel, voir plus bas - inchange) ou via le nouveau
## CloseButton en haut d'IconDock (voir BackpackMenu.gd/icon_dock.tscn) quand ouvert par la colonne ;
## le raccourci "L" (open_album) referme aussi directement, meme mecanisme qu'avant.
##
## Deja conforme au passage d'uniformisation ShopPanel/SuccessPanel (2026-08-29, meme jour, retour
## utilisateur : "applique la configuration des fenetres de gauche a celle de la boutique... pareil
## pour livre des animaux, on refondra le design du livre plus tard pour l instant je veux
## uniformiser toutes les fenetres") : contrairement a ShopPanel (Panel etait un PanelContainer,
## voir son commentaire) et SuccessPanel (titre non centre, pas de separateur), CardAlbum a deja le
## bon type Panel (fond creme, voir l'entree du 2026-08-26 plus haut) et TitleLabel deja centre
## (horizontal_alignment=1 dans TitleBlock). Aucun changement de chrome ici. TitleUnderline (trait
## decoratif double, voir title_underline.gd) reste en place a la place d'un HSeparator standard :
## design specifique au livre demande par Steve le 2026-07-26, explicitement laisse de cote par ce
## meme retour ("on refondra le design du livre plus tard") - a revisiter avec le reste de la
## refonte, pas une incoherence a corriger maintenant.
##
## Icone de titre clonee du bouton "Livre" (2026-09-02, retour utilisateur : "je veux que l icone
## de chaque fenetre apparaisse aussi a gauche du titre de la fenetre... il faut que l icone dans
## la fentre a cote du titre soit un clone de celle du menu, en changeant un on change l autre") :
## TitleLabel quitte TitleBlock directement pour un nouveau TitleRow (HBoxContainer, alignment=1)
## intercale entre TitleBlock et lui - TitleIcon vient avant TitleLabel dans ce groupe, tous deux
## centres ensemble (horizontal_alignment=1 sur TitleLabel devient donc redondant, retire).
## TitleUnderline/CategoryLabel restent des enfants directs de TitleBlock, inchanges - seul le
## titre lui-meme gagne l'icone, le design "livre" reste par ailleurs tel quel (voir entree
## ci-dessus). title_icon_source_path (NodePath, assigne dans game_ui.tscn vers ../BackpackMenu/
## IconDock/IconList/LivreButton) et title_icon.texture = bouton.icon en _ready(), jamais un
## fichier duplique - meme mecanisme que ShopPanel.title_icon (voir son commentaire de classe).
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _input() (fleches
## gauche/droite pour changer de page) et _unhandled_input() ("L"/open_album pour basculer,
## Echap pour fermer) sont tous les deux retires - PrevButton/NextButton et le CloseButton en haut
## de la colonne BackpackMenu (ou l'icone "Livre" elle-meme) font deja tout ca a la souris/au
## tactile.
##
## 2026-09-03 : premiere passe de la refonte "encyclopedie" (Steve : "on va refaire l'encyclopedie
## des animaux, commencons par le type d'affichage") - ajout d'un OptionsBar (2 groupes de
## CheckBox exclusives via ButtonGroup, voir card_album.tscn) : filtre (cartes trouvees
## uniquement / toutes les cartes) et tri (par classe / par type). _load_pages() gagne donc deux
## branches : le filtre saute les cartes non possedees des la construction de all_cards (une page/
## un groupe avec 0 carte restante disparait simplement, pas de case vide) ; le tri choisit la cle
## de regroupement (categorie vs grade) - "par classe" reordonne explicitement CP->CM2 (l'ordre
## d'apparition suivrait sinon la classe de la premiere carte trouvee, pas forcement CP en
## premier une fois le filtre applique). CategoryLabel (renomme nulle part, encore ce nom dans le
## code/la scene pour limiter le churn) affiche donc soit la categorie soit le libelle de classe
## selon le tri actif - voir _refresh(). ScrollContainer profite du passage pour un ancrage
## haut/bas plutot que centre+demi-hauteur fixe (voir l'entree "carte de gauche touchait le
## lisere" plus haut pour le probleme que ca posait deja) : anchor_top=0/anchor_bottom=1 avec
## offset_top=140 (sous le nouvel OptionsBar) / offset_bottom=-60 (au-dessus de la barre de
## navigation), ce qui suit desormais la hauteur reelle du Panel a toute resolution au lieu d'un
## bloc de 320px fige centre sur le milieu du Panel.
##
## 2026-09-03 (suite) : PageLabel ("Page X / Y") supprime (Steve : "je veux enlever la
## numerotation de page"), gain de place recupere par ScrollContainer (offset_top 140 -> 108,
## remonte juste sous TitleBlock). OptionsBar deplace a l'ancienne place de PageLabel, entre
## PrevButton et NextButton (memes offsets verticaux -52/-22), largeur elargie a 700px (etait
## 200px pour un simple Label) pour loger les 4 CheckBox sur une ligne. FilterFoundCheck : texte
## raccourci de "Cartes trouvees uniquement" a "Cartes trouvees" (meme demande).
##
## 2026-09-03 (suite) : les 4 CheckBox n'etaient pas alignees visuellement - le style CheckBox du
## Theme (partage avec le reste du jeu, voir welcome_panel.tscn/section_config.tscn) rend l'etat
## "normal" totalement transparent/sans bordure mais l'etat "pressed" en pastille pleine coloree
## avec bordure : les options cochees ressortaient comme des boutons, les autres comme du texte nu
## qui flotte. Nouvelle variation de theme "OptionCheck" (base_type CheckBox, ajoutee aux 4
## fichiers theme) : memes styles hover/pressed que CheckBox, mais un style "normal" avec la meme
## bordure/les memes coins arrondis que "pressed" (juste sans le fond colore) - les 4 cases ont
## donc toujours le meme gabarit de pastille, cochees ou non. Applique uniquement aux 4 CheckBox
## de cet ecran (theme_type_variation), le CheckBox global (parental control, config) est
## inchange.
##
## 2026-09-03 (suite) : PrevButton/NextButton passent de texte ("< Precedent"/"Suivant >") aux
## icones fleche-gauche.webp/fleche-droite.webp (assets/classe2.0/icones/, memes fichiers que
## partout ailleurs dans l'UI) - memes proprietes icon/expand_icon/icon_alignment que les boutons
## d'IconDock (voir game_menu_panel.tscn). Largeur reduite de 120 a 40px (n'ont plus besoin de
## loger du texte).
##
## 2026-09-03 (suite) : retour au chrome de fenetre standard (Steve : "on reprend le design des
## autres fenetres en ce qui concerne les bordures et les coins arrondis, de meme que le titre et
## la ligne de separation") - AtlasBackground (fond parchemin dessine a la main, voir l'entree
## "fond parchemin" plus haut) retire de card_album.tscn : Panel n'est plus repeint par-dessus,
## son propre style de Theme (fond creme + bordure 4px + coins arrondis 20px, partage avec
## ShopPanel/SuccessPanel/etc.) redevient visible tel quel, sans code supplementaire. TitleUnderline
## (soulignement double dessine a la main) remplace par un HSeparator standard (meme node type que
## ShopPanel.TitleSeparator, style deja fourni par le Theme - HSeparator/styles/separator). Les
## fichiers atlas_background.gd/title_underline.gd n'ont plus aucun appelant, supprimes. TitleBlock
## remonte (offset_top 28 -> 10, offset_bottom 100 -> 80) : le nouveau bord de 4px ne demande plus
## la grosse marge de securite qu'exigeait le double lisere du parchemin (~17-20px). CategoryLabel
## (sous-titre categorie/classe) est conserve tel quel : specifique a ce livre, aucune des autres
## fenetres n'a d'equivalent, la demande ne portait que sur bordures/coins/titre/separateur.
##
## 2026-09-03 (suite) : PrevButton/NextButton agrandis +200% (40x30 -> 120x90, Steve : "augmente
## leur taille de 200%") et flat=true (Steve : "enleve le cadre autour des icones fleches" - retire
## le fond/la bordure du Theme Button, ne laisse que l'icone). Repositionnes en consequence
## (offset_top -52 -> -112, bas toujours cale a -22) ; OptionsBar remonte au milieu de cette
## nouvelle hauteur (-52/-22 -> -82/-52) pour rester visuellement centre entre les deux icones,
## desormais bien plus hautes qu'elle ; ScrollContainer recule d'autant (offset_bottom -60 -> -122)
## pour ne pas chevaucher les icones agrandies.
##
## Zoom sur une carte (2026-09-05, retour utilisateur : "lorsque on clique sur une carte, je veux
## quelle apparaisse avec une taille de 200% au centre de l'ecran avec le fond floute, un 2eme
## click sur la carte ou ECHAP permet de revenir au livre... le but est de pouvoir voir la carte
## et l observer en grand") : chaque CardSlot de la grille recoit desormais un gui_input (voir
## _refresh ci-dessous) ; un clic instancie une DEUXIEME CardSlot (memes card/quantity, voir
## CardSlotScene) centree sur l'ecran et mise a l'echelle ZOOM_SCALE (2.0 = "taille de 200%").
##
## Flou EXTERNE, pas local (2026-09-05, suite, retour utilisateur : "cest le livre qui reapparait
## en fond et est floute, le menu de droite doit apparaitre aussi et doit etre floute au meme
## titre que le livre") : premiere version de ce zoom utilisait un ZoomBlurBG local a
## card_album.tscn, donc incapable de flouter BackpackMenu (la colonne de droite - Recompenses/
## Livre/Succes) puisque celle-ci est un noeud SEPARE, place APRES CardAlbum dans game_ui.tscn
## (donc dessine PAR-DESSUS lui, y compris par-dessus tout ZoomBlurBG local). Fix : le flou vit
## desormais dans game_ui.tscn (CardZoomBlurBG, ColorRect, place APRES BackpackMenu - meme shader/
## memes parametres que NpcBlurBG/BackpackBlurBG, voir icon_dock_blur.gdshader pour la technique
## de flou par mipmap, reutilise directement leur SubResource ShaderMaterial_backpack_blur) : en
## capturant l'ecran juste derriere lui, il floute d'un seul coup TOUT ce qui est deja dessine a ce
## stade - le livre (CardAlbum, dessine avant) ET la colonne (BackpackMenu, dessinee juste avant
## lui aussi) - exactement l'effet "menu de droite floute au meme titre que le livre" demande.
## zoom_blur_bg_path (NodePath, assigne dans game_ui.tscn vers ../CardZoomBlurBG) remplace
## l'ancien @onready var zoom_blur_bg local. La CardSlot zoomee est ajoutee comme enfant de ce
## MEME ColorRect externe (add_child dessus, pas sur self) plutot que sur CardAlbum : elle se
## retrouve ainsi elle aussi apres BackpackMenu dans l'ordre de dessin, donc par-dessus le flou -
## un add_child sur CardAlbum (dessine AVANT BackpackMenu) l'aurait laissee sous la colonne.
## CardZoomBlurBG garde son mouse_filter par defaut (STOP, PAS mouse_filter=2/IGNORE comme
## NpcBlurBG/BackpackBlurBG qui ne sont que visuels) : ici il doit aussi BLOQUER les clics vers la
## grille/OptionsBar/PrevButton/NextButton ET vers BackpackMenu en dessous tant qu'une carte est
## zoomee (contrairement a NpcBlurBG/BackpackBlurBG qui ne separent que l'UI du reste du jeu, deja
## bloque autrement par PlayerInputLock) - resout au passage un probleme qui existait deja avant ce
## fix : BackpackMenu restait cliquable PAR-DESSUS l'ancien ZoomBlurBG local (ses boutons
## Recompenses/Succes auraient pu ouvrir un autre panneau sous la carte zoomee).
##
## Fermeture par clic sur la carte zoomee (_on_zoom_card_gui_input) ou par ECHAP (_unhandled_input,
## NOUVELLE exception au jeu "souris/tactile uniquement" du 2026-09-02 - demandee explicitement ici
## par Steve - troisieme exception du genre avec QuestionPanel._abort_pack et QuitOverlay, voir
## leurs commentaires respectifs). Comme dans CardRevealOverlay (meme pattern, voir son commentaire
## de classe "Declenchement du vol par le joueur"/"Masque plein ecran bloquant") : tous les enfants
## de la CardSlot zoomee passent en MOUSE_FILTER_IGNORE (_force_mouse_filter_ignore) pour qu'un
## clic n'importe ou SUR la carte remonte bien jusqu'a son gui_input, pas absorbe par un Panel
## interne (CardFrame/InnerPanel/NamePlate...). _close_zoom() est aussi appele si le livre entier
## se ferme pendant qu'une carte est zoomee (_on_visibility_changed), pour ne jamais rouvrir le
## livre plus tard avec un zoom fantome deja affiche.
class_name CardAlbum
extends Control

const CardSlotScene := preload("res://ui/collection/card_slot.tscn")
const CARDS_DIR := "res://data/card/resources"

const CARDS_PER_ROW := 5
const ROWS_PER_PAGE := 1
const CARDS_PER_PAGE := CARDS_PER_ROW * ROWS_PER_PAGE # 5

## Voir "Zoom sur une carte" plus bas (2026-09-05) : grossissement applique a la carte agrandie,
## centree a l'ecran par-dessus un fond floute.
const ZOOM_SCALE := 2.0

## Que montrer : toutes les cartes (les non-decouvertes en "?") ou seulement celles possedees.
enum FilterMode { ALL, OWNED_ONLY }
## Comment regrouper les pages : une page = une espece (categorie) ou une page = une classe.
enum SortMode { BY_TYPE, BY_CLASS }

## Bouton IconDock a cloner pour title_icon (voir commentaire de classe) - assigne dans game_ui.tscn.
@export var title_icon_source_path: NodePath
## CardZoomBlurBG (voir "Zoom sur une carte"/"Flou EXTERNE" plus haut) - NodePath vers un noeud
## EXTERNE (sibling dans game_ui.tscn, pas un enfant de cette scene), assigne dans game_ui.tscn.
@export var zoom_blur_bg_path: NodePath

@onready var grid: GridContainer = $Panel/ScrollContainer/CenterContainer/GridContainer
@onready var title_icon: TextureRect = $Panel/TitleRow/TitleIcon
@onready var category_label: Label = $Panel/CategoryLabel
@onready var filter_found_check: CheckBox = $Panel/OptionsBar/OptionsRow/FilterGroup/FilterFoundCheck
@onready var filter_all_check: CheckBox = $Panel/OptionsBar/OptionsRow/FilterGroup/FilterAllCheck
@onready var sort_class_check: CheckBox = $Panel/OptionsBar/OptionsRow/SortGroup/SortClassCheck
@onready var sort_type_check: CheckBox = $Panel/OptionsBar/OptionsRow/SortGroup/SortTypeCheck
@onready var prev_button: Button = $Panel/PrevButton
@onready var next_button: Button = $Panel/NextButton

## Une page = un Array[CardResource] de 5 cartes maximum, toutes du meme groupe (categorie ou
## classe selon _sort_mode).
var _pages: Array = []
var _page_index: int = 0
## Par defaut : cartes trouvees uniquement + tri par classe (2026-09-03, retour utilisateur :
## "je veux que de base l option carte trouvee uniquement et l option par classe soient
## selectionnee") - doit rester coherent avec les button_pressed=true dans card_album.tscn
## (FilterFoundCheck/SortClassCheck), sinon l'etat visuel des CheckBox au premier affichage ne
## correspondrait pas a l'etat logique lu ici avant meme le premier toggled().
var _filter_mode: FilterMode = FilterMode.OWNED_ONLY
var _sort_mode: SortMode = SortMode.BY_CLASS

## CardSlot actuellement affichee en grand (voir "Zoom sur une carte" plus bas), ou null si aucune.
var _zoom_slot: CardSlot = null

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	_apply_theme_colors(theme)
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void:
		theme = new_theme
		_apply_theme_colors(new_theme)
	)
	var icon_source := get_node_or_null(title_icon_source_path) as Button
	if icon_source:
		title_icon.texture = icon_source.icon
	_load_pages()
	_refresh()
	CardCollection.card_added.connect(_on_card_added)
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	visibility_changed.connect(_on_visibility_changed)

	## Chaque paire de CheckBox partage un ButtonGroup (voir card_album.tscn) : les deux emettent
	## "toggled", on ne reagit qu'a celle qui devient cochee (l'autre emet toggled(false) au meme
	## moment, a ignorer sous peine de repartir en arriere).
	filter_found_check.toggled.connect(func(pressed: bool) -> void:
		if pressed:
			_filter_mode = FilterMode.OWNED_ONLY
			_reload_and_refresh()
	)
	filter_all_check.toggled.connect(func(pressed: bool) -> void:
		if pressed:
			_filter_mode = FilterMode.ALL
			_reload_and_refresh()
	)
	sort_class_check.toggled.connect(func(pressed: bool) -> void:
		if pressed:
			_sort_mode = SortMode.BY_CLASS
			_reload_and_refresh()
	)
	sort_type_check.toggled.connect(func(pressed: bool) -> void:
		if pressed:
			_sort_mode = SortMode.BY_TYPE
			_reload_and_refresh()
	)

func _reload_and_refresh() -> void:
	_page_index = 0
	_load_pages()
	_refresh()

## Assortit la couleur de CategoryLabel a la palette du theme d'interface actif (accent =
## bg_color du Button/styles/normal, voir game_theme/theme_bonbon/theme_sombre/theme_tropical
## .tres) - Panel/TitleSeparator suivent deja automatiquement le Theme sans code (styles standard
## partages avec ShopPanel/SuccessPanel/etc., voir l'entree "retour au chrome de fenetre standard"
## plus haut). Appele au demarrage et a chaque changement de theme.
func _apply_theme_colors(active_theme: Theme) -> void:
	var accent_style := active_theme.get_stylebox(&"normal", &"Button") as StyleBoxFlat
	if accent_style == null:
		return
	category_label.add_theme_color_override("font_color", accent_style.bg_color)

## 2026-09-05 : livre vide a la toute premiere ouverture (Steve : "quand on ouvre le livre pour
## la premiere fois dans le jeu, il n'y a aucune carte affichee"). Cause : _load_pages() n'etait
## appele qu'une fois dans _ready() (au chargement de la scene, donc avant que le joueur ait pu
## obtenir la moindre carte) et par _on_card_added() - mais seulement "if visible", donc jamais
## pendant que le livre est ferme, ce qui est le cas ordinaire (le joueur obtient des cartes en
## jouant, livre ferme). open() ne rappelait que _refresh() : il reaffichait donc _pages tel que
## fige a _ready(), potentiellement vide ou perime, sans jamais le recalculer avec la collection
## actuelle. Fix : open() appelle desormais _load_pages() avant _refresh(), comme
## _reload_and_refresh() ci-dessus - chaque ouverture reflete donc toujours l'etat courant de
## CardCollection, pas un instantane du demarrage de la partie.
func open() -> void:
	_page_index = 0
	_load_pages()
	show()
	_refresh()

func close() -> void:
	hide()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()
		## Voir "Zoom sur une carte" (commentaire de classe) : ne jamais rouvrir le livre plus tard
		## avec un zoom fantome deja affiche.
		_close_zoom()

## Enumeration via ResourceLoader.list_directory(), PAS DirAccess (2026-09-13, bug "livre toujours
## vide en ligne") : meme cause et meme correctif que le clic PNJ mort du 2026-09-12 (voir
## question_giver_component.gd._scan_dir) - DirAccess.get_files_at()/list_dir_begin() sur un dossier
## res:// est documente comme non fiable sur un projet EXPORTE (PCK), meme si parfaitement fiable
## dans l'editeur (github.com/godotengine/godot #87552/#99047, godot-proposals#13122). Cette
## fonction-ci utilisait encore l'ancienne methode : le symptome (livre vide malgre des cartes
## bien enregistrees dans CardCollection, y compris apres rechargement) ne se voyait donc que sur
## la version en ligne, jamais en testant depuis l'editeur - jusqu'ici passe inapercu car ce fix
## n'avait ete applique qu'a question_giver_component.gd, pas ici. ResourceLoader.list_directory()
## renvoie des noms "propres" (pas de suffixe .import/.remap a filtrer, pas de sous-dossier ici).
func _load_pages() -> void:
	var all_cards: Array[CardResource] = []
	for file_name in ResourceLoader.list_directory(CARDS_DIR):
		if not file_name.ends_with(".tres"):
			continue
		var card := load("%s/%s" % [CARDS_DIR, file_name]) as CardResource
		if card == null:
			continue
		## Filtre "cartes trouvees uniquement" : une carte non possedee disparait completement
		## de la liste (pas de case "?" a sa place) - un groupe qui n'a plus aucune carte apres
		## filtre n'aura simplement pas de page du tout, voir plus bas.
		if _filter_mode == FilterMode.OWNED_ONLY and CardCollection.get_quantity(card.id) <= 0:
			continue
		all_cards.append(card)
	## Tri numerique sur l'id (les id sont des chaines : un tri texte mettrait "10" avant "2").
	all_cards.sort_custom(func(a: CardResource, b: CardResource) -> bool:
		return int(String(a.id)) < int(String(b.id))
	)

	## Regroupe soit par categorie ("par type", une page = une espece), soit par classe ("par
	## classe", une page = une classe toutes especes confondues) selon _sort_mode. Cle mixte
	## (StringName ou GradeLevel.Grade) : un Dictionary GDScript n'est pas type sur la cle, aucun
	## souci a alterner entre les deux selon le mode.
	var groups: Dictionary = {}
	var group_order: Array = [] # ordre d'apparition (= ordre des id), reecrit ci-dessous en BY_CLASS
	for card in all_cards:
		## Cle volontairement de type mixte (StringName ou GradeLevel.Grade) selon _sort_mode -
		## voir le commentaire juste au-dessus de "groups" : un Dictionary GDScript n'est pas type
		## sur la cle, donc aucun probleme reel a alterner entre les deux ici.
		@warning_ignore("incompatible_ternary")
		var key = card.category if _sort_mode == SortMode.BY_TYPE else card.grade
		if not groups.has(key):
			groups[key] = []
			group_order.append(key)
		groups[key].append(card)

	if _sort_mode == SortMode.BY_CLASS:
		## L'ordre d'apparition suivrait la classe de la premiere carte trouvee (pas forcement CP
		## en premier une fois le filtre "trouvees uniquement" applique) : on force CP->CM2.
		var all_grades: Array = [GradeLevel.Grade.CP, GradeLevel.Grade.CE1, GradeLevel.Grade.CE2, GradeLevel.Grade.CM1, GradeLevel.Grade.CM2]
		group_order = all_grades.filter(func(grade: GradeLevel.Grade) -> bool: return groups.has(grade))

	_pages.clear()
	for key in group_order:
		var cards_in_group: Array = groups[key]
		var i := 0
		while i < cards_in_group.size():
			_pages.append(cards_in_group.slice(i, mini(i + CARDS_PER_PAGE, cards_in_group.size())))
			i += CARDS_PER_PAGE
	if _pages.is_empty():
		_pages.append([])
	_page_index = clampi(_page_index, 0, _pages.size() - 1)

func _on_card_added(_card: CardResource, _is_new: bool) -> void:
	if visible:
		## _load_pages() (pas juste _refresh()) : avec le filtre "trouvees uniquement" actif,
		## obtenir une nouvelle carte change l'ensemble des pages, pas juste leur contenu affiche.
		_load_pages()
		_refresh()

func _on_prev_pressed() -> void:
	_page_index = maxi(0, _page_index - 1)
	_refresh()

func _on_next_pressed() -> void:
	_page_index = mini(_pages.size() - 1, _page_index + 1)
	_refresh()

func _refresh() -> void:
	for child in grid.get_children():
		child.queue_free()
	var page: Array = _pages[_page_index]
	for card in page:
		var quantity := CardCollection.get_quantity(card.id)
		var slot := CardSlotScene.instantiate() as CardSlot
		grid.add_child(slot)
		slot.display(card, quantity)
		## Voir "Zoom sur une carte" (commentaire de classe) : un clic sur cette case de la grille
		## affiche la meme carte en grand. _force_mouse_filter_ignore sinon un Panel interne de
		## CardSlot (CardFrame/InnerPanel/...) absorbe le clic avant qu'il remonte jusqu'ici.
		_force_mouse_filter_ignore(slot)
		slot.gui_input.connect(_on_grid_card_gui_input.bind(card, quantity))

	## "Par type" : nom de l'espece (comme avant). "Par classe" : libelle de la classe (CP-CM2),
	## puisqu'une page melange alors plusieurs especes qui partagent toutes la meme classe.
	if page.is_empty():
		category_label.text = ""
	elif _sort_mode == SortMode.BY_TYPE:
		category_label.text = String((page[0] as CardResource).category).capitalize()
	else:
		category_label.text = GradeLevel.get_label((page[0] as CardResource).grade)
	prev_button.disabled = _page_index <= 0
	next_button.disabled = _page_index >= _pages.size() - 1

## Clic (ou tap, voir _on_card_gui_input dans card_reveal_overlay.gd pour le meme raisonnement sur
## InputEventMouseButton vs InputEventScreenTouch) sur une case de la grille : ouvre le zoom sur
## cette carte, sauf si une carte est deja zoomee (ne devrait pas arriver puisque CardZoomBlurBG
## bloque alors les clics vers la grille, mais gardé par securite).
func _on_grid_card_gui_input(event: InputEvent, card: CardResource, quantity: int) -> void:
	if _zoom_slot != null:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_open_zoom(card, quantity)

## Voir "Zoom sur une carte" (commentaire de classe) : instancie une CardSlot independante de
## celle de la grille, agrandie ZOOM_SCALE et centree sur l'ecran (size/2, taille de CardAlbum
## lui-meme qui couvre tout l'ecran - meme calcul que CardRevealOverlay._reveal_card).
func _open_zoom(card: CardResource, quantity: int) -> void:
	## Externe (voir "Flou EXTERNE" dans le commentaire de classe) : add_child SUR ce ColorRect,
	## pas sur self, pour que la carte zoomee se retrouve elle aussi apres BackpackMenu dans
	## l'ordre de dessin (donc par-dessus le flou, comme BackpackMenu lui-meme).
	var zoom_blur_bg := get_node_or_null(zoom_blur_bg_path) as CanvasItem
	if zoom_blur_bg == null:
		return
	zoom_blur_bg.visible = true
	_zoom_slot = CardSlotScene.instantiate() as CardSlot
	zoom_blur_bg.add_child(_zoom_slot)
	_zoom_slot.display(card, quantity)
	_force_mouse_filter_ignore(_zoom_slot)
	var card_rect_size: Vector2 = CardSlot.CARD_SIZE + Vector2(CardSlot.SHADOW_OFFSET, CardSlot.SHADOW_OFFSET)
	## Pivot au centre (voir doc Control.pivot_offset) : le scale ci-dessous reste centre sur la
	## carte au lieu de partir de son coin haut-gauche.
	_zoom_slot.pivot_offset = card_rect_size / 2.0
	var center: Vector2 = size / 2.0
	_zoom_slot.position = center - card_rect_size / 2.0
	_zoom_slot.scale = Vector2.ONE * ZOOM_SCALE
	_zoom_slot.gui_input.connect(_on_zoom_card_gui_input)

## 2eme clic sur la carte zoomee : referme le zoom (voir commentaire de classe).
func _on_zoom_card_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_close_zoom()

## ECHAP referme le zoom si une carte est actuellement affichee en grand (voir commentaire de
## classe pour cette nouvelle exception au jeu "souris/tactile uniquement"). set_input_as_handled
## pour ne pas laisser cet Echap atteindre QuestionPanel/QuitOverlay dans la meme frame.
func _unhandled_input(event: InputEvent) -> void:
	if _zoom_slot != null and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_close_zoom()

func _close_zoom() -> void:
	if _zoom_slot == null:
		return
	_zoom_slot.queue_free()
	_zoom_slot = null
	var zoom_blur_bg := get_node_or_null(zoom_blur_bg_path) as CanvasItem
	if zoom_blur_bg:
		zoom_blur_bg.visible = false

## Force tous les descendants Control de [node] en MOUSE_FILTER_IGNORE - la racine, elle, garde
## son MOUSE_FILTER_STOP par defaut. Meme fonction que CardRevealOverlay._force_mouse_filter_ignore
## (voir son commentaire de classe pour le detail), dupliquee ici plutot que partagee : les deux
## fichiers n'ont sinon aucune dependance l'un envers l'autre, et c'est la seule fonction en commun.
func _force_mouse_filter_ignore(node: Node) -> void:
	for child in node.get_children():
		if child is Control:
			(child as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
		_force_mouse_filter_ignore(child)
