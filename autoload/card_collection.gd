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

## Ids des cartes possedees (au moins un exemplaire), pour l'ecran Statistiques (collection
## complete a X%) sans exposer directement _owned.
func get_owned_card_ids() -> Array[StringName]:
	var ids: Array[StringName] = []
	for id in _owned.keys():
		ids.append(id)
	return ids

## Vide la collection (voir SaveManager.reset_progress).
func reset() -> void:
	_owned.clear()

## Instantane serialisable pour la sauvegarde (voir SaveManager). StringName -> String car
## JSON n'a pas de type StringName ; reconverti a la lecture.
func serialize() -> Dictionary:
	var data := {}
	for id in _owned.keys():
		data[String(id)] = _owned[id]
	return data

func deserialize(data: Dictionary) -> void:
	_owned.clear()
	for id_str in data.keys():
		_owned[StringName(id_str)] = int(data[id_str])
