## Ligne reutilisable representant un lot/coffre achetable dans la boutique.
## Instanciee en boucle par ShopPanel.gd, une par LootTableResource disponible.
class_name CrateItem
extends PanelContainer

signal purchase_requested(loot_table: LootTableResource)

@export var loot_table: LootTableResource

@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var price_label: Label = $HBoxContainer/PriceLabel
@onready var buy_button: Button = $HBoxContainer/BuyButton

func _ready() -> void:
	if loot_table:
		name_label.text = loot_table.crate_name
		price_label.text = str(loot_table.crate_price)
	buy_button.pressed.connect(func() -> void: purchase_requested.emit(loot_table))
