## Fenetre affichee entre l'interaction avec un PNJ et le pack de questions, uniquement pour la
## matiere "Comprehension de texte" (Subject.READING) : montre le texte du passage tire au sort
## par QuestionGiverComponent (voir reading_pack_started), puis relaie vers QuestionPanel une
## fois le bouton "Commencer" presse. Volontairement AUCUN moyen de revenir au texte une fois
## les questions lancees (pas de bouton retour, ce panneau se ferme et oublie son contenu) :
## demande explicite de l'utilisateur, pour que les questions testent la memorisation plutot
## qu'une relecture continue.
class_name ReadingIntroPanel
extends Control

## Emis quand le joueur clique "Commencer" : "source" et "rarity" sont retransmis tels quels
## (memes conventions que les autres panneaux, voir QuestionPanel/SubjectSelectPanel) pour que
## QuestionPanel sache a qui repondre et quelle rarete de piece verser a la fin.
signal questions_requested(source: Node, questions: Array[QuestionResource], rarity: CardRarity.Rarity)

@onready var panel: PanelContainer = $Panel
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
	## Autowrap + expansion en code plutot que dans le .tscn : evite de coder en dur la valeur
	## numerique de l'enum TextServer.AutowrapMode dans un fichier texte.
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	start_button.pressed.connect(_on_start_pressed)
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	## Fige le joueur (deplacement + interaction) tant que ce panneau est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
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

func _on_start_pressed() -> void:
	var source := _source
	var questions := _questions
	var rarity := _rarity
	_abort()
	questions_requested.emit(source, questions, rarity)

## Node (pas InteractableComponent) : recoit indifferemment un interactable 3D ou 2D depuis le
## passage du jeu en 2D (voir InteractorComponent.gd).
func _on_interactable_unfocused(interactable: Node) -> void:
	if _source == null or interactable == null:
		return
	if _source.get_parent() == interactable.get_parent():
		_abort()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_abort()
		get_viewport().set_input_as_handled()

## Ferme le panneau et oublie tout ce qu'il affichait - que ce soit un abandon (croix/Echap/
## eloignement) ou un vrai demarrage des questions, il n'y a de toute facon plus moyen de
## revenir au texte apres (voir commentaire de classe).
func _abort() -> void:
	_source = null
	_questions = []
	hide()
