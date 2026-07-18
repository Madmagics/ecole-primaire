## Niveaux de rarete des cartes pet-shop et leur couleur/libelle d'affichage.
class_name CardRarity
extends RefCounted

enum Rarity { COMMON, RARE, EPIC, LEGENDARY }

static func get_color(rarity: Rarity) -> Color:
	match rarity:
		Rarity.COMMON:
			return Color("B0BEC5")
		Rarity.RARE:
			return Color("4FC3F7")
		Rarity.EPIC:
			return Color("BA68C8")
		Rarity.LEGENDARY:
			return Color("FFD54F")
	return Color.WHITE

static func get_label(rarity: Rarity) -> String:
	match rarity:
		Rarity.COMMON:
			return "Commune"
		Rarity.RARE:
			return "Rare"
		Rarity.EPIC:
			return "Epique"
		Rarity.LEGENDARY:
			return "Legendaire"
	return "?"
