## Utilitaire reutilisable de tirage aleatoire pondere (loot de coffres, questions, etc.).
## Petit fichier independant : peut servir a n'importe quel systeme du jeu.
class_name WeightedRandom
extends RefCounted

## Tire un element de items selon les poids paralleles dans weights (meme taille).
static func pick(items: Array, weights: Array[float]) -> Variant:
	if items.is_empty() or items.size() != weights.size():
		return null
	var total := 0.0
	for w in weights:
		total += w
	if total <= 0.0:
		return items.pick_random()
	var roll := randf() * total
	var cumulative := 0.0
	for i in items.size():
		cumulative += weights[i]
		if roll <= cumulative:
			return items[i]
	return items.back()
