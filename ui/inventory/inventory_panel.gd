## Fenetre "Inventaire" : liste le solde de pieces de chaque rarete (voir autoload Economy).
## Meme format que les autres panneaux modaux du jeu (ShopPanel, CardAlbum, QuestionPanel) :
## cadre en pourcentage d'ecran, croix de fermeture toujours en haut a droite, verrouille les
## deplacements du joueur tant qu'elle est visible, se ferme avec la croix ou Echap.
## Ouverte depuis GameMenuPanel (bouton "Inventaire") : une fenetre dediee plutot qu'une section
## generique du menu, meme principe que Collection/CardAlbum (voir game_menu_panel.gd).
class_name InventoryPanel
extends Control

const InventoryRowScene := preload("res://ui/inventory/inventory_row.tscn")

## Ordre d'affichage des raretes : voir la meme constante/le meme commentaire dans ShopPanel
## (l'enum CardRarity.Rarity n'est pas dans l'ordre "logique", UNCOMMON=4 vient apres LEGENDARY=3).
const DISPLAYED_RARITIES: Array[CardRarity.Rarity] = [
	CardRarity.Rarity.COMMON,
	CardRarity.Rarity.UNCOMMON,
	CardRarity.Rarity.RARE,
	CardRarity.Rarity.EPIC,
	CardRarity.Rarity.LEGENDARY,
]

@onready var list_container: VBoxContainer = $Panel/Margin/Content/ListScroll/ListContainer
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton

var _rows: Dictionary = {}

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)
	for rarity in DISPLAYED_RARITIES:
		var row := InventoryRowScene.instantiate() as InventoryRow
		list_container.add_child(row)
		_rows[rarity] = row
	Economy.balance_changed.connect(_on_balance_changed)
	visibility_changed.connect(_on_visibility_changed)

func _refresh() -> void:
	for rarity in DISPLAYED_RARITIES:
		_rows[rarity].display(rarity, Economy.get_balance(rarity))

## Rafraichit uniquement si visible : evite de mettre a jour des labels caches inutilement a
## chaque achat en boutique pendant que l'inventaire n'est pas ouvert.
func _on_balance_changed(_rarity: CardRarity.Rarity, _amount: int) -> void:
	if visible:
		_refresh()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
		_refresh()
	else:
		PlayerInputLock.unlock()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()

## Appele par GameMenuPanel (bouton "Inventaire").
func open() -> void:
	show()

func close() -> void:
	hide()
