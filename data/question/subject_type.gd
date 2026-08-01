## Definit les matieres disponibles pour les questions, et l'affichage associe (couleur, libelle).
## Classe utilitaire statique : pas d'instance, on utilise SubjectType.Subject.XXX partout.
class_name SubjectType
extends RefCounted

## Valeurs numeriques figees explicitement (meme regle que CardRarity.Rarity) : ne jamais changer
## le numero d'une matiere existante, des QuestionResource.subject sont deja serialises avec ces
## valeurs. Pour ajouter une matiere, lui donner le prochain numero libre.
## GRAMMAR ne couvre plus que la grammaire pure (accords, nature des mots) depuis le 2026-07-20 :
## CONJUGATION et SPELLING ont ete separes du meme contenu francais d'origine (voir
## MATIERES_CANDIDATES.md). ENGLISH et READING reserves pour les prochains chantiers (vocabulaire
## anglais et lecture/comprehension), ajoutes ici a l'avance pour figer leur numero.
enum Subject { MATH = 0, FRENCH = 1, GRAMMAR = 2, CONJUGATION = 3, SPELLING = 4, ENGLISH = 5, READING = 6 }

## Couleur de la piece recompense pour cette matiere (HUD, popups...) - reutilisee telle quelle
## comme code couleur des cadres de matiere dans SubjectSelectPanel (un seul systeme de couleurs
## a apprendre pour le joueur, voir CHARTE_GRAPHIQUE.md). Palette revue le 2026-07-28 (retour
## utilisateur) : les 3 "sous-matieres" francaises (GRAMMAR/CONJUGATION/SPELLING, issues du meme
## contenu francais d'origine - voir plus haut) en couleurs chaudes rouge/orange/jaune, READING en
## marron, ENGLISH en vert, MATH inchange en bleu. FRENCH (id historique, plus utilise pour de
## nouvelles questions depuis la scission) garde son ancienne couleur, non affichee dans les menus
## actuels. SPELLING utilise un jaune plutot dore (E0A100) qu'un jaune pale : verifie au ratio de
## contraste WCAG contre le fond des 4 themes, un jaune plus clair y devenait difficile a lire.
static func get_color(subject: Subject) -> Color:
	match subject:
		Subject.MATH:
			return Color("4C9AFF") # bleu
		Subject.FRENCH:
			return Color("FF6B6B") # rouge (ancien, non affiche dans les menus actuels)
		Subject.GRAMMAR:
			return Color("E64545") # rouge
		Subject.CONJUGATION:
			return Color("FF9800") # orange
		Subject.SPELLING:
			return Color("E0A100") # jaune dore
		Subject.ENGLISH:
			return Color("66BB6A") # vert
		Subject.READING:
			return Color("8B5E34") # marron
	return Color.WHITE

## Nom de dossier (sous csv/questions/<classe>/ et data/question/resources/<classe>/) associe a
## cette matiere - voir tools/admin/import_questions.gd (SUBJECT_FOLDERS) pour la creation de
## cette arborescence. Utilise par QuestionGiverComponent pour retrouver le pool d'une matiere
## dans une classe anterieure (mecanique de pack de revision, voir FRANCAIS_DIFFICULTE.md).
static func get_folder_name(subject: Subject) -> String:
	match subject:
		Subject.MATH:
			return "math"
		Subject.FRENCH:
			return "french"
		Subject.GRAMMAR:
			return "grammaire"
		Subject.CONJUGATION:
			return "conjugaison"
		Subject.SPELLING:
			return "orthographe"
		Subject.ENGLISH:
			return "english"
		Subject.READING:
			return "lecture"
	return ""

static func get_label(subject: Subject) -> String:
	match subject:
		Subject.MATH:
			return "Mathématiques"
		Subject.FRENCH:
			return "Français"
		Subject.GRAMMAR:
			return "Grammaire"
		Subject.CONJUGATION:
			return "Conjugaison"
		Subject.SPELLING:
			return "Orthographe"
		Subject.ENGLISH:
			return "Anglais"
		Subject.READING:
			return "Compréhension de texte"
	return "?"
