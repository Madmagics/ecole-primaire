## Album complet : instancie un CardSlot.tscn par carte connue du jeu (all_cards).
## Ajouter une carte a l'album = l'ajouter a all_cards, la grille se construit toute seule.
class_name CardAlbum
extends Control

const CardSlotScene := preload("res://ui/collection/card_slot.tscn")

@export var all_cards: Array[CardResource] = []

@onready var grid: GridContainer = $ScrollContainer/GridContainer

func _ready() -> void:
	refresh()

func refresh() -> void:
	for child in grid.get_children():
		child.queue_free()
	for card in all_cards:
		var slot := CardSlotScene.instantiate() as CardSlot
		grid.add_child(slot)
		slot.display(card, CardCollection.has_card(card.id))
