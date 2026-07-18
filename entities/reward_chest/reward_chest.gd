## Coffre/lot ouvrable : tire une carte via sa LootTableResource des que le joueur interagit.
## Reutilise le meme InteractableComponent que les PNJ et la boutique.
class_name RewardChest
extends Node3D

@export var loot_table: LootTableResource

@onready var interactable: InteractableComponent = $InteractableComponent

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted(_who: Node) -> void:
	open()

func open() -> CardResource:
	if loot_table == null:
		return null
	var card := loot_table.draw_card()
	if card:
		CardCollection.add_card(card)
		EventBus.card_obtained.emit(card)
	return card
