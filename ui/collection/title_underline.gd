## Trait decoratif double sous le titre de l'atlas : remplace l'idee initiale de bandeau/ruban
## encadre par un simple soulignement, a la demande de Steve (2026-07-26, maquette "parchemin
## classique" amelioree). Dessine deux traits horizontaux centres sur une fraction de la largeur
## du conteneur parent (le titre lui-meme n'a pas une largeur fixe/previsible selon la police).
##
## 2026-07-26 (suite) : ink_color n'est plus fige, pilote par CardAlbum depuis le border_color
## du Theme actif (voir set_ink_color()), pour rester assorti au reste de l'UI (cf. AtlasBackground
## qui suit la meme logique pour le fond).
class_name TitleUnderline
extends Control

## Valeur par defaut = ancienne couleur figee (theme game_theme), au cas ou set_ink_color()
## n'est jamais appele.
@export var ink_color := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const WIDTH_RATIO := 0.55
const INSET_SHORT_LINE := 20.0

func _ready() -> void:
	resized.connect(queue_redraw)

func set_ink_color(new_ink_color: Color) -> void:
	ink_color = new_ink_color
	queue_redraw()

func _draw() -> void:
	var line_width := size.x * WIDTH_RATIO
	var start_x := (size.x - line_width) / 2.0
	draw_line(Vector2(start_x, 2), Vector2(start_x + line_width, 2), ink_color, 2.0)
	draw_line(Vector2(start_x + INSET_SHORT_LINE, 6), Vector2(start_x + line_width - INSET_SHORT_LINE, 6), ink_color, 1.0)
