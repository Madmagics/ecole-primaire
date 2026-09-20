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

## Code couleur des classes, valable dans tout le jeu (2026-08-30, retour utilisateur : "on va
## instaurer un nouveau code couleur valable pour tout le jeu : cp=bleu, ce1=vert, ce2=jaune,
## cm1=violet, cm2=rouge") : remplace l'ancien systeme qui reutilisait la palette de CardRarity via
## get_rarity() (heritage de l'epoque ou chaque carte avait une rarete propre, retiree le
## 2026-07-26 - get_rarity() ci-dessous ne sert plus qu'a la cle de stockage interne d'Economy,
## plus a la couleur). Palette fixee ici directement, independante de CardRarity -
## CardRarity.get_color() n'avait plus aucun autre appelant et a ete retire (voir card_rarity.gd).
## Utilisee pour le cadre de carte (card_slot.gd, y compris dans CardRevealOverlay qui le
## reinstancie - voir son commentaire de classe), et les icones de pieces
## (voir get_coin_icon_path()/get_coin_pile_icon_path() ci-dessous).
static func get_color(grade: Grade) -> Color:
	match grade:
		Grade.CP:
			return Color("42A5F5") # bleu
		Grade.CE1:
			return Color("66BB6A") # vert
		Grade.CE2:
			return Color("FDD835") # jaune
		Grade.CM1:
			return Color("AB47BC") # violet
		Grade.CM2:
			return Color("E53935") # rouge
	return Color.WHITE

## Chemin de la scene de decor de classe recompense (voir autoload/classroom_decor.gd,
## ClassroomDecor.get_active_scene_path()) pour cette classe - school1.tscn pour CP, school2.tscn
## pour CE1, etc (ordre de l'enum Grade + 1, school.tscn de base restant gere directement par
## ClassroomDecor.BASE_SCENE_PATH). Ajoutee le 2026-09-20 (retour utilisateur : selectionner le
## decor CP dans la boutique ne changeait pas la scene affichee).
static func get_decor_scene_path(grade: Grade) -> String:
	return "res://levels/school/school%d.tscn" % (int(grade) + 1)

## Chemin de l'icone "piece" (une seule piece, affichee a cote d'un prix a payer dans la boutique -
## voir CrateItem/ProfSkinItem) pour cette classe. Fichier deja colore selon get_color() ci-dessus
## (2026-08-30, retour utilisateur : "je les ai faites en webp avec leur couleur... les pieces a
## utiliser pour les achat sont les icones pieces... en fonction de la classe correspondante") -
## pas de modulate a appliquer par l'appelant, contrairement a l'ancienne base grise neutre
## concept_piece.svg (retiree, jamais correctement teintee de toute facon).
static func get_coin_icon_path(grade: Grade) -> String:
	return "res://assets/classe2.0/icones/piece-%s.webp" % get_label(grade)

## Chemin de l'icone "tas de pieces" (total du solde du joueur par classe, voir CoinHUD/
## RewardsBand) pour cette classe - meme convention/meme date que get_coin_icon_path() ci-dessus,
## fichier distinct (illustration : plusieurs pieces empilees plutot qu'une seule, retour
## utilisateur : "les icones pour le total de piece du joueur sappellent tasdepiece").
static func get_coin_pile_icon_path(grade: Grade) -> String:
	return "res://assets/classe2.0/icones/tasdepiece-%s.webp" % get_label(grade)

## Chemin de l'icone "badge" (medaille ronde coloree + lettres de la classe, voir
## assets/classe2.0/icones/badge-<CLASSE>.webp) - meme convention que get_coin_icon_path() /
## get_coin_pile_icon_path() ci-dessus : fichier deja fini en couleur par classe, pas de modulate
## a appliquer par l'appelant. Utilisee par card_slot.gd (coin haut-gauche du portrait, 2026-09-03 :
## remplace un badge dessine en code (Panel+Label) - Steve voulait en fait ces icones existantes,
## pas un badge genere).
static func get_badge_icon_path(grade: Grade) -> String:
	return "res://assets/classe2.0/icones/badge-%s.webp" % get_label(grade)

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

## Reciproque de get_rarity() ci-dessus (2026-08-29, section "Récompenses" - retour utilisateur :
## "on enleve le systeme commun peu commun etc et on remplace juste par le nom des classes") :
## quand seule la Rarity d'une piece est connue (Economy est reste code par rarete en interne,
## voir economy.gd) mais qu'il faut l'afficher au joueur sous son nom de classe (CP/CE1/...), pas
## sous son nom de rarete ("Commune"/"Peu commune"/...). Bijection fixe, meme mapping que
## get_rarity() en sens inverse.
static func get_grade_for_rarity(rarity: CardRarity.Rarity) -> Grade:
	match rarity:
		CardRarity.Rarity.COMMON:
			return Grade.CP
		CardRarity.Rarity.UNCOMMON:
			return Grade.CE1
		CardRarity.Rarity.RARE:
			return Grade.CE2
		CardRarity.Rarity.EPIC:
			return Grade.CM1
		CardRarity.Rarity.LEGENDARY:
			return Grade.CM2
	return Grade.CP
