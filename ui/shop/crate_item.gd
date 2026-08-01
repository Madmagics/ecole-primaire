## Case carree representant un lot/coffre achetable dans la boutique - meme technique que
## CardSlot (ui/collection/card_slot.gd) : cadre colore + fond creme + pastille en bas, mais a
## plus petite echelle et sans nom (l'icone du coffre suffit, voir CHARTE_GRAPHIQUE.md 2026-08-01).
## Toute la case reste reactive au clic (CrateItem est lui-meme le Button) : un clic emet
## purchase_requested, a charge de ShopPanel d'afficher une confirmation avant l'achat reel.
class_name CrateItem
extends Button

signal purchase_requested(loot_table: LootTableResource)

const OUTER_RADIUS := 16
const INNER_RADIUS := 11
const PRICE_RADIUS := 12
## Couleurs reprises de CardSlot/theme pour rester coherent avec le reste de l'UI.
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6

@export var loot_table: LootTableResource

@onready var frame_panel: Panel = $Frame
@onready var inner_panel: Panel = $Frame/Margin/InnerPanel
@onready var price_bubble: Panel = $Frame/Margin/InnerPanel/VBox/PriceWrap/PriceBubble
@onready var price_label: Label = $Frame/Margin/InnerPanel/VBox/PriceWrap/PriceBubble/PriceRow/PriceLabel

func _ready() -> void:
	_apply_flat_style(inner_panel, CREAM_COLOR, INNER_RADIUS)
	if loot_table:
		var color := CardRarity.get_color(loot_table.rarity)
		## Meme regle de contraste que CardSlot (grade/rarete "Legendaire" = orange, texte encre
		## trop peu contraste dessus, bascule en blanc - les autres raretes restent en encre).
		var text_color := Color.WHITE if loot_table.rarity == CardRarity.Rarity.LEGENDARY else INK_COLOR
		## Frame et PriceBubble partagent la meme couleur de rarete (la bulle "flotte" dans le bas
		## du cadre, meme role que NamePlate sur CardSlot) - sans contour propre, les deux aplats
		## identiques se fondaient l'un dans l'autre a la jonction ("couleurs en superposition",
		## retour utilisateur 2026-08-01). Contour encre de 2px ajoute sur les deux pour les
		## separer visuellement, meme mecanisme que le contour optionnel de CardSlot._apply_flat_style.
		_apply_flat_style(frame_panel, color, OUTER_RADIUS, INK_COLOR, 2)
		_apply_flat_style(price_bubble, color, PRICE_RADIUS, INK_COLOR, 2)
		price_label.text = str(loot_table.crate_price)
		price_label.add_theme_color_override("font_color", text_color)
	pressed.connect(func() -> void: purchase_requested.emit(loot_table))

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon), meme technique
## que CardSlot._apply_flat_style (border_color/border_width optionnels).
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
