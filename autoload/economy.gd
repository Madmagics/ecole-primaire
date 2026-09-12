## Portefeuille du joueur : une reserve de pieces par rarete (commune, peu commune, rare,
## epique, legendaire). Les pieces d'une rarete donnee servent a acheter les coffres de
## cette meme rarete en boutique. Autoload volontairement minimal : uniquement l'etat qui
## doit survivre aux changements de scene.
extends Node

const Rarity = CardRarity.Rarity

signal balance_changed(rarity: Rarity, new_amount: int)

## Solde de depart d'un compte (2026-09-05, retour utilisateur : "reinitialise le nombre de
## pieces pour tous les nouveaux comptes crees") : remis a 0, comme prevu de longue date (voir
## l'ancien commentaire ci-dessous, conserve pour l'historique). Etait a 10000 depuis le
## 2026-08-01 (retour utilisateur de l'epoque : "avoir largement de quoi tester les cartes et la
## boutique") - facilite de dev/test qui n'a plus lieu d'etre, chaque compte etant desormais cense
## partir a zero.
const STARTING_BALANCE := 0

var _balances: Dictionary = {
	Rarity.COMMON: STARTING_BALANCE,
	Rarity.UNCOMMON: STARTING_BALANCE,
	Rarity.RARE: STARTING_BALANCE,
	Rarity.EPIC: STARTING_BALANCE,
	Rarity.LEGENDARY: STARTING_BALANCE,
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

## Remet chaque solde a la valeur de depart (0, voir STARTING_BALANCE) - utilise a la fois par
## SaveManager.create_account() (nouveau compte) et SaveManager.reset_current_account_progress()
## (reinitialisation de la progression d'un compte existant, derriere le portail parental) : les
## deux doivent repartir de zero de la meme facon.
func reset() -> void:
	for rarity in _balances.keys():
		_balances[rarity] = STARTING_BALANCE
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
