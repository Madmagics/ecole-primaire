## Portefeuille du joueur : une reserve de pieces par matiere (math / francais).
## Autoload volontairement minimal : uniquement l'etat qui doit survivre aux changements de scene.
extends Node

signal balance_changed(subject: SubjectType.Subject, new_amount: int)

var _balances: Dictionary = {
	SubjectType.Subject.MATH: 0,
	SubjectType.Subject.FRENCH: 0,
}

func get_balance(subject: SubjectType.Subject) -> int:
	return _balances.get(subject, 0)

func add_coins(subject: SubjectType.Subject, amount: int) -> void:
	if amount <= 0:
		return
	_balances[subject] = get_balance(subject) + amount
	balance_changed.emit(subject, _balances[subject])

## Renvoie false et ne depense rien si le solde est insuffisant.
func try_spend(subject: SubjectType.Subject, amount: int) -> bool:
	if get_balance(subject) < amount:
		return false
	_balances[subject] -= amount
	balance_changed.emit(subject, _balances[subject])
	return true
