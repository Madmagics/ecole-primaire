## Niveaux de rarete des cartes pet-shop et leur couleur/libelle d'affichage.
class_name CardRarity
extends RefCounted

## Valeurs numeriques figees explicitement : ne jamais les changer une fois des
## cartes sauvegardees, sous peine de changer la rarete de cartes existantes.
## Pour ajouter une rarete plus tard, lui donner un nouveau numero (ex: 5), jamais
## reutiliser/decaler les numeros existants.
enum Rarity { COMMON = 0, UNCOMMON = 4, RARE = 1, EPIC = 2, LEGENDARY = 3 }

## Code couleur des raretes (utilise pour les cartes, l'album et les coffres de la boutique) :
## commune = blanc, peu commune = vert, rare = bleu, epique = violet, legendaire = orange.
static func get_color(rarity: Rarity) -> Color:
	match rarity:
		Rarity.COMMON:
			return Color("FFFFFF")
		Rarity.UNCOMMON:
			return Color("81C784")
		Rarity.RARE:
			return Color("4FC3F7")
		Rarity.EPIC:
			return Color("BA68C8")
		Rarity.LEGENDARY:
			return Color("FF9800")
	return Color.WHITE

static func get_label(rarity: Rarity) -> String:
	match rarity:
		Rarity.COMMON:
			return "Commune"
		Rarity.UNCOMMON:
			return "Peu commune"
		Rarity.RARE:
			return "Rare"
		Rarity.EPIC:
			return "Épique"
		Rarity.LEGENDARY:
			return "Légendaire"
	return "?"

## Poids de tirage par defaut suggere pour une table de loot equilibree
## (a ajuster par coffre dans l'inspecteur, ceci n'est qu'un point de depart).
static func get_default_weight(rarity: Rarity) -> float:
	match rarity:
		Rarity.COMMON:
			return 50.0
		Rarity.UNCOMMON:
			return 25.0
		Rarity.RARE:
			return 15.0
		Rarity.EPIC:
			return 8.0
		Rarity.LEGENDARY:
			return 2.0
	return 1.0

## Recompense en pieces (de la meme rarete que le pack) selon le pourcentage de reussite,
## puis mise a l'echelle sur la taille reelle du pack. Bareme d'origine defini sur un pack de
## 10 questions (100%->10, 90%->5, 80%->4, 70%->3, 60%->2, 50%->1, <50%->0). La mise a l'echelle
## generique (roundi(base_for_10 * total_count / 10.0)) est conservee meme si, depuis le
## plafonnement de tous les packs a QuestionGiverComponent.PACK_SIZE (10) le 2026-08-01, elle
## retombe toujours sur le bareme d'origine - pas de raison de la refixer en dur. Meme bareme
## pour toutes les raretes actuellement (seul le TYPE de piece change avec la rarete/classe,
## pas encore l'exigence).
static func get_pack_reward(_rarity: Rarity, correct_count: int, total_count: int) -> int:
	if total_count <= 0:
		return 0
	var ratio := float(correct_count) / float(total_count)
	var base_for_10 := 0
	if ratio >= 1.0:
		base_for_10 = 10
	elif ratio >= 0.9:
		base_for_10 = 5
	elif ratio >= 0.8:
		base_for_10 = 4
	elif ratio >= 0.7:
		base_for_10 = 3
	elif ratio >= 0.6:
		base_for_10 = 2
	elif ratio >= 0.5:
		base_for_10 = 1
	return roundi(base_for_10 * total_count / 10.0)
