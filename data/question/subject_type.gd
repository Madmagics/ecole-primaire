## Definit les matieres disponibles pour les questions, et l'affichage associe (couleur, libelle).
## Classe utilitaire statique : pas d'instance, on utilise SubjectType.Subject.XXX partout.
class_name SubjectType
extends RefCounted

enum Subject { MATH, FRENCH }

## Couleur de la piece recompense pour cette matiere (HUD, popups...).
static func get_color(subject: Subject) -> Color:
	match subject:
		Subject.MATH:
			return Color("4C9AFF") # piece bleue
		Subject.FRENCH:
			return Color("FF6B6B") # piece rouge
	return Color.WHITE

static func get_label(subject: Subject) -> String:
	match subject:
		Subject.MATH:
			return "Mathematiques"
		Subject.FRENCH:
			return "Francais"
	return "?"
