## Fond "parchemin" de l'atlas de cartes. Dessine a la main (draw_rect/draw_circle/draw_line
## dans _draw(), pas de texture ni de degrade, conforme a la charte graphique flat) un papier
## ancien avec quelques taches d'anciennete, un double lisere avec petits reperes, et des
## fleurons d'angle. Purement decoratif, ne gere aucune interaction.
##
## Doit rester un pur rectangle plein (draw_rect en premier) : il sert aussi a masquer le style
## de fond par defaut du Panel parent.
##
## 2026-07-26 : cree suite a la maquette "parchemin classique" (mcp visualize), amelioree ensuite
## a la demande de Steve (titre souligne + categorie, cf. TitleUnderline). Le double lisere est
## volontairement tres proche du bord (voir MARGIN/INNER_INSET) : card_album.tscn doit garder
## le contenu (titre, grille de cartes, navigation) a distance de cette bande pour ne pas
## chevaucher les traits - voir les offsets dans card_album.tscn.
##
## 2026-07-26 (suite) : plus de couleurs figees. paper_color/ink_color sont pilotes depuis
## l'exterieur (voir set_palette(), appele par CardAlbum a partir du Theme actif) pour que le
## parchemin s'adapte aux 4 themes du jeu (voir game_theme/theme_bonbon/theme_sombre/
## theme_tropical .tres) au lieu de rester toujours "papier ancien" beige. Les taches
## d'anciennete sont deduites par melange paper->ink (pas de 3e couleur a maintenir a la main).
class_name AtlasBackground
extends Control

## Valeurs par defaut = ancien rendu "parchemin classique" (theme game_theme), au cas ou
## set_palette() n'est jamais appele.
@export var paper_color := Color(0.937255, 0.874510, 0.721569) # #EFDFB8
@export var ink_color := Color(0.478431, 0.290196, 0.168627) # #7A4A2B

const MARGIN := 10.0 # distance du lisere exterieur par rapport au bord du panneau
const OUTER_BORDER_WIDTH := 2.5
const INNER_INSET := 7.0 # distance entre le lisere exterieur et le lisere interieur
const INNER_BORDER_WIDTH := 1.0
const FLEURON_SIZE := 18.0

## Ratios de melange paper_color -> ink_color pour les 2 nuances de taches d'anciennete
## ("legere" et "marquee"). Fonctionne aussi bien sur papier clair (assombrit, effet tache de
## cafe) que sur fond sombre (theme_sombre : eclaircit legerement vers le lisere dore/bronze).
const SPOT_RATIO_LIGHT := 0.12
const SPOT_RATIO_STRONG := 0.22

## Position (proportion 0-1 de la taille du panneau) et rayon (proportion de la largeur) des
## taches d'anciennete. Choisies a la main pour rappeler la maquette, valeurs fixes (pas de
## random) pour un rendu stable d'une ouverture de l'atlas a l'autre.
const SPOTS := [
	{"pos": Vector2(0.09, 0.82), "radius": 0.028, "color": 0},
	{"pos": Vector2(0.88, 0.24), "radius": 0.024, "color": 1},
	{"pos": Vector2(0.82, 0.88), "radius": 0.016, "color": 1},
	{"pos": Vector2(0.08, 0.16), "radius": 0.018, "color": 1},
	{"pos": Vector2(0.52, 0.92), "radius": 0.008, "color": 0},
	{"pos": Vector2(0.19, 0.06), "radius": 0.006, "color": 1},
]

func _ready() -> void:
	resized.connect(queue_redraw)

## Change la palette (papier + encre) et redessine. Appele par CardAlbum a partir du
## StyleBoxFlat "panel" du Theme actif (bg_color -> paper_color, border_color -> ink_color).
func set_palette(new_paper_color: Color, new_ink_color: Color) -> void:
	paper_color = new_paper_color
	ink_color = new_ink_color
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), paper_color, true)

	var spot_color_light := paper_color.lerp(ink_color, SPOT_RATIO_LIGHT)
	var spot_color_strong := paper_color.lerp(ink_color, SPOT_RATIO_STRONG)
	for spot in SPOTS:
		var pos: Vector2 = spot.pos * size
		var radius: float = spot.radius * size.x
		var color: Color = spot_color_light if spot.color == 0 else spot_color_strong
		draw_circle(pos, radius, color)

	_draw_double_border()
	_draw_corner_fleurons()

func _draw_double_border() -> void:
	var outer := Rect2(Vector2(MARGIN, MARGIN), size - Vector2(MARGIN, MARGIN) * 2)
	draw_rect(outer, ink_color, false, OUTER_BORDER_WIDTH)
	var inner := outer.grow(-INNER_INSET)
	draw_rect(inner, ink_color, false, INNER_BORDER_WIDTH)

	## Petits reperes : deux traits courts perpendiculaires au lisere exterieur, pres de chaque
	## coin (huit au total).
	var tick := 8.0
	for off in [18.0, 38.0]:
		draw_line(Vector2(outer.position.x, outer.position.y + off), Vector2(outer.position.x + tick, outer.position.y + off), ink_color, 1.0)
		draw_line(Vector2(outer.end.x - tick, outer.position.y + off), Vector2(outer.end.x, outer.position.y + off), ink_color, 1.0)
		draw_line(Vector2(outer.position.x, outer.end.y - off), Vector2(outer.position.x + tick, outer.end.y - off), ink_color, 1.0)
		draw_line(Vector2(outer.end.x - tick, outer.end.y - off), Vector2(outer.end.x, outer.end.y - off), ink_color, 1.0)
		draw_line(Vector2(outer.position.x + off, outer.position.y), Vector2(outer.position.x + off, outer.position.y + tick), ink_color, 1.0)
		draw_line(Vector2(outer.end.x - off, outer.position.y), Vector2(outer.end.x - off, outer.position.y + tick), ink_color, 1.0)
		draw_line(Vector2(outer.position.x + off, outer.end.y - tick), Vector2(outer.position.x + off, outer.end.y), ink_color, 1.0)
		draw_line(Vector2(outer.end.x - off, outer.end.y - tick), Vector2(outer.end.x - off, outer.end.y), ink_color, 1.0)

func _draw_corner_fleurons() -> void:
	_draw_fleuron(Vector2(MARGIN, MARGIN), Vector2(1, 1))
	_draw_fleuron(Vector2(size.x - MARGIN, MARGIN), Vector2(-1, 1))
	_draw_fleuron(Vector2(MARGIN, size.y - MARGIN), Vector2(1, -1))
	_draw_fleuron(Vector2(size.x - MARGIN, size.y - MARGIN), Vector2(-1, -1))

## Petite volute ("fleuron") tracee comme une courbe quadratique approchee point par point,
## depuis le coin "origin" vers l'interieur du panneau, dans la direction "dir" (1 ou -1 par
## axe). Purement ornemental.
func _draw_fleuron(origin: Vector2, dir: Vector2) -> void:
	var p1 := origin + Vector2(FLEURON_SIZE * dir.x, 0)
	var p2 := origin + Vector2(0, FLEURON_SIZE * dir.y)
	var ctrl := origin + Vector2(FLEURON_SIZE * 0.55 * dir.x, FLEURON_SIZE * 0.55 * dir.y)
	var steps := 12
	var prev := p1
	for i in range(1, steps + 1):
		var t := float(i) / steps
		var a := p1.lerp(ctrl, t)
		var b := ctrl.lerp(p2, t)
		var point := a.lerp(b, t)
		draw_line(prev, point, ink_color, 1.5)
		prev = point
