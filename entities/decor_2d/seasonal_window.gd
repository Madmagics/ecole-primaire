## Fenêtre de décor qui affiche l'une des 4 illustrations saisonnières (assets/classe2.0/
## fenetre_*.webp) selon la date réelle de l'appareil, au lancement de la partie. Bascule aux
## dates d'équinoxe/solstice usuelles (dates fixes, pas le calcul astronomique exact qui varie de
## +/-1 jour selon les années - largement suffisant pour un habillage visuel) :
## printemps 20 mars, été 21 juin, automne 21 septembre, hiver 21 décembre.
## Pas de mise à jour en cours de partie (une bascule de saison en session ne justifie pas un
## timer) - un redémarrage du jeu suffit à refléter un changement de saison.
class_name SeasonalWindow
extends Sprite2D

@export var texture_winter: Texture2D
@export var texture_spring: Texture2D
@export var texture_summer: Texture2D
@export var texture_autumn: Texture2D

func _ready() -> void:
	var today := Time.get_date_dict_from_system()
	texture = _texture_for_date(today.month, today.day)

## Bornes inclusives sur la date de bascule (ex: le 21 septembre est déjà l'automne).
func _texture_for_date(month: int, day: int) -> Texture2D:
	if (month == 12 and day >= 21) or month == 1 or month == 2 or (month == 3 and day < 20):
		return texture_winter
	elif (month == 3 and day >= 20) or month == 4 or month == 5 or (month == 6 and day < 21):
		return texture_spring
	elif (month == 6 and day >= 21) or month == 7 or month == 8 or (month == 9 and day < 21):
		return texture_summer
	else:
		return texture_autumn
