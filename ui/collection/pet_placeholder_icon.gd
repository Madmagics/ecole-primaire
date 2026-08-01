## Icone generique de pet affichee dans une carte tant qu'aucune image reelle n'est disponible
## (voir data/card/art/<id>.png et tools/admin/import_cards.gd : des qu'un fichier art est
## depose puis reimporte, CardResource.texture est renseigne et cette icone n'est plus utilisee -
## voir CardSlot.display()). Bonhomme chibi generique portant un t-shirt marque d'un "?" : le
## t-shirt reprend la couleur de rarete de la carte (passee via set_colors), volontairement pas
## une espece de pet particuliere - design valide avec Steve le 2026-07-25 (mockup avant portage
## en jeu, cf. conversation "propose moi 10 design de cartes").
class_name PetPlaceholderIcon
extends Control

const INK := Color(0.478431, 0.290196, 0.168627) # #7A4A2B, cf. CHARTE_GRAPHIQUE.md
const SKIN := Color(0.94902, 0.894118, 0.784314) # #F2E4C8, teinte neutre (pas liee a une espece)

var _shirt_color := Color(0.533333, 0.529412, 0.501961) # gris neutre par defaut
var _mark_color := INK

func _ready() -> void:
	resized.connect(queue_redraw)

## A appeler par CardSlot avec la couleur de rarete de la carte et une couleur de "?" lisible
## dessus (meme logique de contraste que la pastille de nom : encre sauf legendaire en blanc).
func set_colors(shirt_color: Color, mark_color: Color) -> void:
	_shirt_color = shirt_color
	_mark_color = mark_color
	queue_redraw()

func _draw() -> void:
	## Dessine sur un repere fixe 60x70 (memes proportions que le mockup valide), mis a l'echelle
	## et centre dans le rectangle reel du Control ("contain", comme un TextureRect en keep-aspect).
	var s := minf(size.x / 60.0, size.y / 70.0)
	var ox := (size.x - 60.0 * s) * 0.5
	var oy := (size.y - 70.0 * s) * 0.5

	var sleeve_style := StyleBoxFlat.new()
	sleeve_style.bg_color = _shirt_color
	sleeve_style.set_corner_radius_all(int(6 * s))
	sleeve_style.set_border_width_all(maxi(1, int(2.5 * s)))
	sleeve_style.border_color = INK

	var torso_style := StyleBoxFlat.new()
	torso_style.bg_color = _shirt_color
	torso_style.set_corner_radius_all(int(11 * s))
	torso_style.set_border_width_all(maxi(1, int(3 * s)))
	torso_style.border_color = INK

	draw_style_box(sleeve_style, Rect2(Vector2(ox + 10 * s, oy + 38 * s), Vector2(12 * s, 15 * s)))
	draw_style_box(sleeve_style, Rect2(Vector2(ox + 38 * s, oy + 38 * s), Vector2(12 * s, 15 * s)))
	draw_style_box(torso_style, Rect2(Vector2(ox + 15 * s, oy + 36 * s), Vector2(30 * s, 30 * s)))

	# "?" du t-shirt, centre sur la largeur du torse - decale de 1px vers le bas par rapport au
	# premier essai, cf. retour de Steve.
	draw_string(
		get_theme_default_font(),
		Vector2(ox + 15 * s, oy + 57 * s),
		"?",
		HORIZONTAL_ALIGNMENT_CENTER,
		30 * s,
		int(17 * s),
		_mark_color
	)

	_circle_outline(Vector2(ox + 30 * s, oy + 22 * s), 20 * s, SKIN, 3.5 * s)
	_circle_outline(Vector2(ox + 21.5 * s, oy + 20 * s), 7 * s, Color.WHITE, 2 * s)
	_circle_outline(Vector2(ox + 38.5 * s, oy + 20 * s), 7 * s, Color.WHITE, 2 * s)
	draw_circle(Vector2(ox + 22.5 * s, oy + 21 * s), 2.8 * s, INK)
	draw_circle(Vector2(ox + 37.5 * s, oy + 21 * s), 2.8 * s, INK)

## Simule un cercle "rempli + contour" (pas de stroke natif sur draw_circle) en dessinant un
## disque plus grand dans la couleur d'encre puis un disque plus petit par-dessus.
func _circle_outline(center: Vector2, radius: float, fill_color: Color, stroke_width: float) -> void:
	draw_circle(center, radius, INK)
	draw_circle(center, maxf(radius - stroke_width, 0.0), fill_color)
