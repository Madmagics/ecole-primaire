## Table de loot d'un coffre/lot de boutique : liste ponderee de cartes possibles + prix.
## Un fichier .tres par coffre (commun, rare, evenementiel...) : reutilisable sans code.
class_name LootTableResource
extends Resource

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (SubjectType.Subject) ; on "importe" l'enum dans une const locale.
const Subject = SubjectType.Subject

@export var crate_name: String = ""
@export var crate_price: int = 0
@export var crate_currency: Subject = Subject.MATH
@export var entries: Array[LootEntry] = []

## Tire une carte au hasard selon les poids definis dans entries.
func draw_card() -> CardResource:
	var cards: Array = []
	var weights: Array[float] = []
	for entry in entries:
		if entry == null or entry.card == null:
			continue
		cards.append(entry.card)
		weights.append(entry.weight)
	return WeightedRandom.pick(cards, weights) as CardResource
