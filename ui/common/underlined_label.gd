## Label souligne (2026-10-08, retour utilisateur : "souligne les titres aussi dans les 3 onglets
## aide"). Label/LabelSettings n'ont aucune option de soulignement en Godot 4.x (verifie dans la
## doc de reference) : on trace donc le trait nous-memes dans _draw(), sous la 1re ligne de texte,
## a la largeur du texte et dans la couleur de police du theme. Utilise pour les titres de
## HelpOverlay (ui/onboarding/help_overlay.tscn).
@tool
class_name UnderlinedLabel
extends Label

func _draw() -> void:
	if text.is_empty():
		return
	var font: Font = get_theme_font("font")
	var font_size: int = get_theme_font_size("font_size")
	var normal_style: StyleBox = get_theme_stylebox("normal")
	var left: float = normal_style.get_margin(SIDE_LEFT)
	var top: float = normal_style.get_margin(SIDE_TOP)
	var available: float = size.x - left - normal_style.get_margin(SIDE_RIGHT)
	var width: float = minf(font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x, available)
	var x: float = left
	if horizontal_alignment == HORIZONTAL_ALIGNMENT_CENTER:
		x = left + (available - width) / 2.0
	elif horizontal_alignment == HORIZONTAL_ALIGNMENT_RIGHT:
		x = left + available - width
	var thickness: float = maxf(2.0, font.get_underline_thickness(font_size))
	var y: float = top + font.get_ascent(font_size) + font.get_underline_position(font_size) + thickness
	draw_line(Vector2(x, y), Vector2(x + width, y), get_theme_color("font_color"), thickness)
