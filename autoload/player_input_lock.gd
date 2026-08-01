## Bloque les deplacements/interactions du joueur pendant qu'une fenetre modale est ouverte
## (question, boutique, choix de classe...). Compteur plutot que booleen simple : gere le cas
## ou plusieurs panels se chevauchent (ex: fermeture de l'un pendant l'ouverture d'un autre)
## sans deverrouiller trop tot.
extends Node

signal lock_changed(is_locked: bool)

var _open_count: int = 0

func lock() -> void:
	_open_count += 1
	if _open_count == 1:
		lock_changed.emit(true)

func unlock() -> void:
	_open_count = maxi(0, _open_count - 1)
	if _open_count == 0:
		lock_changed.emit(false)

func is_locked() -> bool:
	return _open_count > 0
