## Boutique : liste des lots/coffres achetables, instancie un CrateItem.tscn par lot.
## Ajouter un coffre au jeu = ajouter une LootTableResource a available_crates, sans code.
class_name ShopPanel
extends Control

const CrateItemScene := preload("res://ui/shop/crate_item.tscn")

@export var available_crates: Array[LootTableResource] = []

@onready var list_container: VBoxContainer = $Panel/ScrollContainer/ListContainer

func _ready() -> void:
	for crate in available_crates:
		var item := CrateItemScene.instantiate() as CrateItem
		item.loot_table = crate
		item.purchase_requested.connect(_on_purchase_requested)
		list_container.add_child(item)

func _on_purchase_requested(loot_table: LootTableResource) -> void:
	if loot_table == null:
		return
	if Economy.try_spend(loot_table.crate_currency, loot_table.crate_price):
		var card := loot_table.draw_card()
		if card:
			CardCollection.add_card(card)
			EventBus.card_obtained.emit(card)
