## Association carte + poids de tirage, utilisee a l'interieur d'une LootTableResource.
class_name LootEntry
extends Resource

@export var card: CardResource
@export_range(0.0, 100.0, 0.1) var weight: float = 1.0
