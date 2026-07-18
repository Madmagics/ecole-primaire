## Collection de cartes possedees par le joueur (album pet-shop).
extends Node

signal card_added(card: CardResource, is_new: bool)

var _owned: Dictionary = {} # StringName id -> int quantite

func has_card(card_id: StringName) -> bool:
	return _owned.get(card_id, 0) > 0

func get_quantity(card_id: StringName) -> int:
	return _owned.get(card_id, 0)

func add_card(card: CardResource) -> void:
	if card == null:
		return
	var is_new := not has_card(card.id)
	_owned[card.id] = get_quantity(card.id) + 1
	card_added.emit(card, is_new)
