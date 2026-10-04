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

## Nombre de doublons (exemplaires en plus du premier) parmi [cards] - utilise par la ligne
## "coffres a doublons" de la boutique (voir DuplicateCrateItem, 2026-10-04) avec les cartes d'une
## seule classe, pour afficher le decompte "x/10" de cette classe.
func count_duplicates(cards: Array[CardResource]) -> int:
	var total := 0
	for card in cards:
		total += maxi(0, get_quantity(card.id) - 1)
	return total

## Retire [amount] doublons parmi [cards] (2026-10-04, echange "10 doublons = 1 coffre", voir
## ShopPanel._do_duplicate_crate_purchase) : toujours pris sur la carte qui a le PLUS d'exemplaires
## a ce moment-la, et jamais le dernier exemplaire d'une carte (une carte possedee reste possedee).
## Renvoie {card_id (String): nombre retire} pour le journal d'evenements serveur
## ("doublons_echanges"), ou {} sans rien retirer si [cards] n'a pas assez de doublons.
func consume_duplicates(cards: Array[CardResource], amount: int) -> Dictionary:
	if amount <= 0 or count_duplicates(cards) < amount:
		return {}
	var removed := {}
	for i in amount:
		var best: CardResource = null
		for card in cards:
			if get_quantity(card.id) > 1 and (best == null or get_quantity(card.id) > get_quantity(best.id)):
				best = card
		_owned[best.id] = get_quantity(best.id) - 1
		var key := String(best.id)
		removed[key] = int(removed.get(key, 0)) + 1
	return removed

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
