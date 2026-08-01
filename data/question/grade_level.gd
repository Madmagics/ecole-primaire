## Niveaux scolaires (CP a CM2) et leur correspondance avec la rarete des pieces gagnees.
## Classe utilitaire statique, meme principe que SubjectType et CardRarity.
class_name GradeLevel
extends RefCounted

## Valeurs numeriques figees explicitement (meme regle que CardRarity : ne jamais les
## changer une fois des questions sauvegardees).
enum Grade { CP = 0, CE1 = 1, CE2 = 2, CM1 = 3, CM2 = 4 }

static func get_label(grade: Grade) -> String:
	match grade:
		Grade.CP:
			return "CP"
		Grade.CE1:
			return "CE1"
		Grade.CE2:
			return "CE2"
		Grade.CM1:
			return "CM1"
		Grade.CM2:
			return "CM2"
	return "?"

## Nom de dossier (sous data/question/resources/ et csv/questions/) associe a cette classe -
## voir tools/admin/import_questions.gd pour la creation de cette arborescence. Utilise par
## QuestionGiverComponent pour ne scanner que le sous-dossier de sa propre classe.
static func get_folder_name(grade: Grade) -> String:
	match grade:
		Grade.CP:
			return "cp"
		Grade.CE1:
			return "ce1"
		Grade.CE2:
			return "ce2"
		Grade.CM1:
			return "cm1"
		Grade.CM2:
			return "cm2"
	return ""

## Couleur d'affichage d'une classe (cadre de carte dans l'album, voir ui/collection/card_slot.gd).
## Depuis le 2026-07-26, les CardResource n'ont plus de champ "rarity" propre - c'est la classe qui
## determine la couleur, en reutilisant la palette existante de CardRarity via get_rarity() ci-dessous
## (memes couleurs, mais le concept "carte -> rarete" a disparu au profit de "carte -> classe").
static func get_color(grade: Grade) -> Color:
	return CardRarity.get_color(get_rarity(grade))

## Correspondance niveau -> rarete des pieces gagnees pour un pack reussi a ce niveau :
## plus la classe est avancee, plus la recompense est elevee. Ca empeche un enfant de se
## "declarer" plus jeune pour farmer des pieces sur des questions faciles : le gain reste
## plafonne a la rarete de la classe choisie, quel que soit le score.
static func get_rarity(grade: Grade) -> CardRarity.Rarity:
	match grade:
		Grade.CP:
			return CardRarity.Rarity.COMMON
		Grade.CE1:
			return CardRarity.Rarity.UNCOMMON
		Grade.CE2:
			return CardRarity.Rarity.RARE
		Grade.CM1:
			return CardRarity.Rarity.EPIC
		Grade.CM2:
			return CardRarity.Rarity.LEGENDARY
	return CardRarity.Rarity.COMMON
