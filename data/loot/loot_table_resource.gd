## Table de loot d'un coffre/lot de boutique : liste ponderee de cartes possibles + prix.
## Un fichier .tres par coffre (commun, rare, evenementiel...) : reutilisable sans code.
class_name LootTableResource
extends Resource

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (CardRarity.Rarity) ; on "importe" l'enum dans une const locale.
const Rarity = CardRarity.Rarity

@export var crate_name: String = ""
@export var crate_price: int = 0
## Rarete de ce coffre : c'est A LA FOIS la devise requise pour l'acheter (pieces de
## cette rarete, voir Economy) ET son theme visuel dans la boutique - converti en classe via
## GradeLevel.get_grade_for_rarity() puis colore via GradeLevel.get_color() (2026-08-30, nouveau
## code couleur unifie par classe ; CardRarity.get_color() n'existe plus, voir CrateItem.gd).
## Les cartes qu'il contient (entries) n'ont pas besoin de correspondre exactement, mais
## c'est la convention utilisee par build_loot_tables.gd.
@export var rarity: Rarity = Rarity.COMMON
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
