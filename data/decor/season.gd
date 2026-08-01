## Saison courante du jeu, deduite de la date systeme : pilote les decors saisonniers (voir
## entities/decor/seasonal_skin.gd) et pourra plus tard piloter d'autres contenus lies a la
## saison (theme, evenements...). Classe utilitaire statique, meme principe que GradeLevel/
## CardRarity/SubjectType (voir ARCHITECTURE.md).
class_name Season
extends RefCounted

## Decoupage meteorologique (par mois calendaire, hemisphere nord) plutot qu'astronomique (dates
## de solstice/equinoxe variables d'une annee sur l'autre) : plus simple a coder et largement
## suffisant pour un habillage de decor.
enum Kind { PRINTEMPS = 0, ETE = 1, AUTOMNE = 2, HIVER = 3 }

## Saison actuelle d'apres l'horloge systeme (heure locale). Voir from_month() pour la logique
## pure, independante de Time.get_date_dict_from_system() et donc testable directement.
static func current() -> Kind:
	var month: int = Time.get_date_dict_from_system().month
	return from_month(month)

## Fonction pure (mois -> saison), separee de current() pour rester testable sans dependre de
## l'horloge systeme.
static func from_month(month: int) -> Kind:
	match month:
		12, 1, 2:
			return Kind.HIVER
		3, 4, 5:
			return Kind.PRINTEMPS
		6, 7, 8:
			return Kind.ETE
		9, 10, 11:
			return Kind.AUTOMNE
	return Kind.ETE # mois hors 1-12 (ne devrait pas arriver) : repli neutre

## Nom du sous-dossier associe sous entities/decor/seasons/ - utilise pour resoudre les skins
## (voir SeasonalSkin) et pour creer l'arborescence attendue par les artistes.
static func get_folder_name(season: Kind) -> String:
	match season:
		Kind.PRINTEMPS:
			return "printemps"
		Kind.ETE:
			return "ete"
		Kind.AUTOMNE:
			return "automne"
		Kind.HIVER:
			return "hiver"
	return ""
