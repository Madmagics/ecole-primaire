## Niveaux de rarete des cartes pet-shop et leur couleur/libelle d'affichage.
class_name CardRarity
extends RefCounted

## Valeurs numeriques figees explicitement : ne jamais les changer une fois des
## cartes sauvegardees, sous peine de changer la rarete de cartes existantes.
## Pour ajouter une rarete plus tard, lui donner un nouveau numero (ex: 5), jamais
## reutiliser/decaler les numeros existants.
enum Rarity { COMMON = 0, UNCOMMON = 4, RARE = 1, EPIC = 2, LEGENDARY = 3 }

## get_color() (palette par rarete : commune=blanc, peu commune=vert, rare=bleu, epique=violet,
## legendaire=orange) retire le 2026-08-30 (retour utilisateur : "on va instaurer un nouveau code
## couleur valable pour tout le jeu : cp=bleu, ce1=vert, ce2=jaune, cm1=violet, cm2=rouge") :
## GradeLevel.get_color() a sa propre palette fixe desormais, independante de CardRarity - dernier
## appelant de cette fonction (GradeLevel.get_color(), qui faisait le pont rarete->couleur) mis a
## jour pour ne plus en dependre. Voir GradeLevel.get_color()/get_coin_icon_path() pour le systeme
## actuel.

## get_label() (libelles "Commune"/"Peu commune"/etc) retire le 2026-08-29 (section "Récompenses",
## retour utilisateur : "on enleve le systeme commun peu commun etc et on remplace juste par le nom
## des classes CP, CE1 etc") : plus aucun texte joueur n'affiche de nom de rarete, uniquement des
## noms de classe (voir GradeLevel.get_label, GradeLevel.get_grade_for_rarity). CardRarity ne sert
## plus qu'en interne (cle Economy, couleurs, poids de tirage, calcul de recompense) - dernier
## appelant de get_label() supprime dans coin_hud.gd/inventory_row.gd(retire)/question_panel.gd/
## question_giver_component.gd/build_loot_tables.gd, voir CHARTE_GRAPHIQUE.md pour le detail complet.

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
