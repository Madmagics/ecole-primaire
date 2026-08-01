## Portefeuille du joueur : une reserve de pieces par rarete (commune, peu commune, rare,
## epique, legendaire). Les pieces d'une rarete donnee servent a acheter les coffres de
## cette meme rarete en boutique. Autoload volontairement minimal : uniquement l'etat qui
## doit survivre aux changements de scene.
extends Node

const Rarity = CardRarity.Rarity

signal balance_changed(rarity: Rarity, new_amount: int)

## DEV/TEST : allocation de depart pour pouvoir tester toute la boutique (les 5 coffres) et
## l'obtention de cartes sans devoir farmer des packs. Relevee de 1000 a 10000 le 2026-08-01
## (retour utilisateur) pour avoir largement de quoi tester les cartes et la boutique. A remettre
## a 0 avant une vraie sortie du jeu.
const STARTING_BALANCE_FOR_TESTING := 10000

var _balances: Dictionary = {
	Rarity.COMMON: STARTING_BALANCE_FOR_TESTING,
	Rarity.UNCOMMON: STARTING_BALANCE_FOR_TESTING,
	Rarity.RARE: STARTING_BALANCE_FOR_TESTING,
	Rarity.EPIC: STARTING_BALANCE_FOR_TESTING,
	Rarity.LEGENDARY: STARTING_BALANCE_FOR_TESTING,
}

func get_balance(rarity: Rarity) -> int:
	return _balances.get(rarity, 0)

func add_coins(rarity: Rarity, amount: int) -> void:
	if amount <= 0:
		return
	_balances[rarity] = get_balance(rarity) + amount
	balance_changed.emit(rarity, _balances[rarity])

## Renvoie false et ne depense rien si le solde est insuffisant.
func try_spend(rarity: Rarity, amount: int) -> bool:
	if get_balance(rarity) < amount:
		return false
	_balances[rarity] -= amount
	balance_changed.emit(rarity, _balances[rarity])
	return true

## Remet chaque solde a la valeur de depart (voir SaveManager.reset_progress).
func reset() -> void:
	for rarity in _balances.keys():
		_balances[rarity] = STARTING_BALANCE_FOR_TESTING
		balance_changed.emit(rarity, _balances[rarity])

## Instantane serialisable pour la sauvegarde (voir SaveManager). Les cles Dictionary de
## GDScript restent des int ici (l'enum Rarity), mais JSON n'accepte que des cles String :
## JSON.stringify les convertit automatiquement en "0", "4"... ce qui suffit puisque ces
## valeurs numeriques sont figees a vie (voir CardRarity.Rarity) et se reconvertissent sans
## ambiguite avec int().
func serialize() -> Dictionary:
	return _balances.duplicate()

func deserialize(data: Dictionary) -> void:
	for key in data.keys():
		var rarity: int = int(key)
		var amount: int = int(data[key])
		_balances[rarity] = amount
		balance_changed.emit(rarity, amount)
