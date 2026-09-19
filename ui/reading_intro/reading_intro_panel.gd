## Fenetre affichee entre l'interaction avec un PNJ et le pack de questions, uniquement pour la
## matiere "Comprehension de texte" (Subject.READING) : montre le texte du passage tire au sort
## par QuestionGiverComponent (voir reading_pack_started), puis relaie vers QuestionPanel une
## fois le bouton "Commencer" presse. Volontairement AUCUN moyen de revenir au texte une fois
## les questions lancees (pas de bouton retour, ce panneau se ferme et oublie son contenu) :
## demande explicite de l'utilisateur, pour que les questions testent la memorisation plutot
## qu'une relecture continue.
##
## CloseButton ajoute (2026-09-02, retour utilisateur : "on supprime tous les raccourcis clavier,
## je veux un jeu qui se joue uniquement a la souris ou au tactile") : ce panneau n'avait
## JUSQU'ICI aucun moyen souris/tactile d'abandonner avant de cliquer "Commencer" - seul Echap
## (_unhandled_input, retire) le permettait, ce qui aurait purement et simplement disparu avec les
## raccourcis clavier. Nouveau HeaderRow (TitleLabel + CloseButton "X", meme composant que
## SubjectSelectPanel/QuestionPanel) au-dessus du texte, connecte a _abort() : preserve la
## fonctionnalite d'abandon existante, juste par un autre chemin. Ne change rien a la regle "pas de
## retour au texte une fois les questions lancees" (voir plus haut) - _abort() ne s'applique
## qu'AVANT le clic sur "Commencer".
##
## Floutage d'arriere-plan (2026-09-04, retour utilisateur : "on va uniformiser le floutage arriere
## pour toutes les fenetres quand celles ci sont actives... je veux appliquer la meme chose aux
## questions et menus proposes par les npc") : meme mecanisme que BackpackMenu.blur_bg_path (voir
## ui/hud/backpack_menu.gd) - blur_bg_path pointe vers NpcBlurBG (ColorRect partage avec
## QuestionPanel/SubjectSelectPanel dans game_ui.tscn), bascule dans _on_visibility_changed().
##
## Menus masques (2026-09-04, 2e passe, retour utilisateur : "les icones de menu droit et gauche
## sont touours la quand jouvre un menu npc") : le premier passage n'avait masque les 2 boutons de
## menu que depuis QuestionPanel - manquant ici, ce panneau (etape intermediaire du flux PNJ, entre
## SubjectSelectPanel et QuestionPanel) laissait les 2 icones cliquables. Meme mecanisme
## (open_menu_button_path/backpack_button_path, voir QuestionPanel) applique ici aussi.
class_name ReadingIntroPanel
extends Control

## Emis quand le joueur clique "Commencer" : "source" et "rarity" sont retransmis tels quels
## (memes conventions que les autres panneaux, voir QuestionPanel/SubjectSelectPanel) pour que
## QuestionPanel sache a qui repondre et quelle rarete de piece verser a la fin.
signal questions_requested(source: Node, questions: Array[QuestionResource], rarity: CardRarity.Rarity)

## Flou plein ecran derriere ce panneau (voir commentaire de classe, 2026-09-04) : NodePath vers
## NpcBlurBG, ColorRect EXTERNE partage avec QuestionPanel/SubjectSelectPanel dans game_ui.tscn.
@export var blur_bg_path: NodePath
## Boutons d'ouverture des 2 menus (game_ui.tscn), masques tant que ce panneau est visible (voir
## commentaire de classe, 2026-09-04) - assignes dans game_ui.tscn.
@export var open_menu_button_path: NodePath
@export var backpack_button_path: NodePath

@onready var panel: PanelContainer = $Panel
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton
@onready var text_scroll: ScrollContainer = $Panel/Margin/Content/TextScroll
@onready var text_label: Label = $Panel/Margin/Content/TextScroll/TextContent/TextLabel
@onready var start_button: Button = $Panel/Margin/Content/TextScroll/TextContent/StartButton

var _source: Node
var _questions: Array[QuestionResource] = []
var _rarity: CardRarity.Rarity = CardRarity.Rarity.COMMON

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	## Glissement au doigt possible depuis n'importe quelle zone (pas seulement la fine barre
	## de defilement) - voir ui/common/touch_scroll_fix.gd (retour utilisateur 2026-09-18).
	TouchScrollFix.allow_scroll_passthrough(self)
	## Autowrap + expansion en code plutot que dans le .tscn : evite de coder en dur la valeur
	## numerique de l'enum TextServer.AutowrapMode dans un fichier texte.
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	start_button.pressed.connect(_on_start_pressed)
	close_button.pressed.connect(_abort)
	## Fige le joueur (deplacement + interaction) tant que ce panneau est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	var blur_bg := get_node_or_null(blur_bg_path) as CanvasItem
	if blur_bg:
		blur_bg.visible = visible
	var open_menu_button := get_node_or_null(open_menu_button_path) as CanvasItem
	if open_menu_button:
		open_menu_button.visible = not visible
	var backpack_button := get_node_or_null(backpack_button_path) as CanvasItem
	if backpack_button:
		backpack_button.visible = not visible
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Appele par le PNJ (QuestionGiverComponent.reading_pack_started) une fois un passage et ses
## questions tires au sort.
func open_for(source: Node, passage: PassageResource, questions: Array[QuestionResource], rarity: CardRarity.Rarity) -> void:
	_source = source
	_questions = questions
	_rarity = rarity
	text_label.text = passage.text
	show()
	## Remet le defilement en haut a chaque nouvelle ouverture (retour utilisateur 2026-09-19) :
	## sans ce reset, le ScrollContainer gardait la position de defilement du texte precedent, si
	## bien qu'un nouveau texte de lecture pouvait s'afficher deja scrolle vers le bas. Le
	## ScrollContainer ne recalcule sa plage de defilement qu'apres que le nouveau texte du Label
	## a ete mis en page (NOTIFICATION_SORT_CHILDREN) : fixer scroll_vertical avant cette frame ne
	## servirait a rien, d'ou l'attente d'une frame complete avant de le remettre a 0.
	await get_tree().process_frame
	text_scroll.scroll_vertical = 0

func _on_start_pressed() -> void:
	var source := _source
	var questions := _questions
	var rarity := _rarity
	_abort()
	questions_requested.emit(source, questions, rarity)

## Ferme le panneau et oublie tout ce qu'il affichait - que ce soit un abandon (croix) ou un vrai
## demarrage des questions, il n'y a de toute facon plus moyen de revenir au texte apres (voir
## commentaire de classe).
func _abort() -> void:
	_source = null
	_questions = []
	hide()
