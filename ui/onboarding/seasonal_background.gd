## Fond d'ecran de l'ecran d'accueil (WelcomePanel/Background) qui affiche l'une des 4
## illustrations saisonnieres (assets/classe2.0/intro/{ete,automne,hiver,printemps}.webp) selon la
## date REELLE de l'appareil, au lancement de la partie (2026-09-06, retour utilisateur : "jai
## cree 3 autres images pour le fond d'ecran d'introduction correspondant au printemps, hiver,
## automne, le fichier webp nomme intro est l'ete... on s'accordera sur le meme systeme que dans
## la classe ou la fenetre change en fonction de la saison") :
## - Meme principe ET memes bornes de date (equinoxe/solstice usuels : printemps 20 mars, ete 21
##   juin, automne 21 septembre, hiver 21 decembre - PAS le calcul astronomique exact, qui varie
##   de +/-1 jour selon les annees) que SeasonalWindow (entities/decor_2d/seasonal_window.gd, la
##   fenetre saisonniere de la salle de classe demandee comme reference).
## - Logique DUPLIQUEE a l'identique plutot que partagee : ce fond d'ecran (TextureRect, ecran
##   d'accueil) et cette fenetre (Sprite2D, salle de classe) sont 2 scenes totalement distinctes,
##   sans classe commune deja en place pour cette logique (la classe Season de data/decor/
##   season.gd existe mais n'est utilisee nulle part et a une granularite differente, par mois
##   calendaire plutot qu'au jour pres - pas le meme systeme que SeasonalWindow).
## - Pas de mise a jour en cours de partie (une bascule de saison en session ne justifie pas un
##   timer) - un redemarrage du jeu suffit a refleter un changement de saison, meme convention que
##   SeasonalWindow.
class_name SeasonalBackground
extends TextureRect

@export var texture_winter: Texture2D
@export var texture_spring: Texture2D
@export var texture_summer: Texture2D
@export var texture_autumn: Texture2D

func _ready() -> void:
	var today := Time.get_date_dict_from_system()
	texture = _texture_for_date(today.month, today.day)

## Bornes inclusives sur la date de bascule (ex: le 21 septembre est deja l'automne) - identique a
## SeasonalWindow._texture_for_date(), voir le commentaire de classe ci-dessus.
func _texture_for_date(month: int, day: int) -> Texture2D:
	if (month == 12 and day >= 21) or month == 1 or month == 2 or (month == 3 and day < 20):
		return texture_winter
	elif (month == 3 and day >= 20) or month == 4 or month == 5 or (month == 6 and day < 21):
		return texture_spring
	elif (month == 6 and day >= 21) or month == 7 or month == 8 or (month == 9 and day < 21):
		return texture_summer
	else:
		return texture_autumn
