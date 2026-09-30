## Petit dessin vectoriel d'une fiche de cours (2026-09-29), trace a la main dans _draw() : aucune
## image a charger, le jeu reste leger. Cree par FichePage a partir d'une balise ecrite seule sur
## sa ligne dans le texte de la fiche (contenu_cours.contenu dans Supabase), par exemple :
##   [billes groupes=3,2 couleurs=bleu,rouge total=oui]  -> groupes de billes + "=" + total
##   [file de=0 a=10 bonds=4:7]                          -> file de nombres avec des bonds
##   [cubes d=1 u=5]                                     -> barres de dizaines + cubes unites
##   [cubes d=1 u=8 vers=2:8]                            -> avant, fleche "+10", apres
##   [cases n=10 bleu=3]                                 -> rangee de cases, les premieres coloriees
## Les couleurs "classe" suivent le code couleur de la classe (GradeLevel.get_color).
class_name FicheDessin
extends Control

const INK := Color("3b2a1e")
const UNITES := Color("F2A541")
const JAUNE := Color("FFD54F")
const NAMED_COLORS := {
	"bleu": Color("42A5F5"), "rouge": Color("EF5350"), "vert": Color("66BB6A"),
	"jaune": Color("FFD54F"), "orange": Color("F2A541"), "violet": Color("AB47BC"),
}

const BILLE_R := 13.0
const BILLE_GAP := 6.0
const CUBE := 12.0
const CASE := 42.0
const CUBE_LABEL_SIZE := 18
const CUBE_GROUP_GAP := 28.0
const CUBE_ARROW_W := 90.0

var kind: String = ""
var params: Dictionary = {}
var classe_color: Color = Color("42A5F5")

func setup(p_kind: String, p_params: Dictionary, p_classe_color: Color) -> void:
	kind = p_kind
	params = p_params
	classe_color = p_classe_color
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	custom_minimum_size = _compute_min_size()
	queue_redraw()

## Lit les parametres "cle=valeur" d'une balise, ex. " groupes=3,2 total=oui".
static func parse_params(raw: String) -> Dictionary:
	var result: Dictionary = {}
	for part: String in raw.strip_edges().split(" ", false):
		var eq := part.find("=")
		if eq > 0:
			result[part.substr(0, eq)] = part.substr(eq + 1)
	return result

func _ints(key: String) -> PackedInt32Array:
	var out := PackedInt32Array()
	for s: String in str(params.get(key, "")).split(",", false):
		out.append(int(s))
	return out

func _color_named(color_name: String, fallback: Color) -> Color:
	if color_name == "classe":
		return classe_color
	return NAMED_COLORS.get(color_name, fallback)

# ---------------------------------------------------------------- tailles

func _compute_min_size() -> Vector2:
	match kind:
		"billes":
			var total_w := 0.0
			for w: float in _billes_layout_widths():
				total_w += w
			return Vector2(total_w, _billes_box_height() + 8.0)
		"file":
			return Vector2(300, 112)
		"cubes":
			return Vector2(_cubes_width(), 10 * CUBE + 32.0)
		"cases":
			var n := int(params.get("n", 10))
			return Vector2(n * CASE, CASE + 8.0)
	return Vector2.ZERO

func _billes_groups() -> PackedInt32Array:
	var groups := _ints("groupes")
	if str(params.get("total", "")) == "oui":
		var total := 0
		for g: int in groups:
			total += g
		groups.append(total)
	return groups

func _billes_box_size(count: int) -> Vector2:
	var cols := clampi(count, 1, 5)
	var rows := maxi(1, ceili(count / 5.0))
	var cell := BILLE_R * 2.0 + BILLE_GAP
	return Vector2(cols * cell + BILLE_GAP + 8.0, rows * cell + BILLE_GAP + 8.0)

func _billes_box_height() -> float:
	var h := 0.0
	for g: int in _billes_groups():
		h = maxf(h, _billes_box_size(g).y)
	return h

## Largeurs successives : boite, signe, boite, signe...
func _billes_layout_widths() -> Array[float]:
	var widths: Array[float] = []
	var groups := _billes_groups()
	for i: int in groups.size():
		if i > 0:
			widths.append(44.0)
		widths.append(_billes_box_size(maxi(groups[i], 1)).x)
	return widths

## Un "etat" de cubes = d barres de dizaines + u cubes unites. [cubes d=1 u=8 vers=2:8] dessine
## deux etats sur une ligne, relies par une fleche "+10" (avant -> apres).
func _cubes_states() -> Array[Vector2i]:
	var states: Array[Vector2i] = [Vector2i(int(params.get("d", 0)), int(params.get("u", 0)))]
	var vers := str(params.get("vers", "")).split(":")
	if vers.size() == 2:
		states.append(Vector2i(int(vers[0]), int(vers[1])))
	return states

func _label_width(text: String) -> float:
	return _font().get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, CUBE_LABEL_SIZE).x

func _dizaine_label(d: int) -> String:
	return "%d dizaine%s" % [d, "s" if d > 1 else ""]

func _unite_label(u: int) -> String:
	return "%d unité%s" % [u, "s" if u > 1 else ""]

## Largeurs [groupe dizaines, groupe unites] d'un etat, etiquettes comprises.
func _cubes_group_widths(state: Vector2i) -> Vector2:
	var dw := 0.0
	if state.x > 0:
		dw = maxf(state.x * (CUBE + 8.0) - 8.0, _label_width(_dizaine_label(state.x)))
	var uw := 0.0
	if state.y > 0:
		uw = maxf(ceili(state.y / 10.0) * (CUBE + 6.0) - 6.0, _label_width(_unite_label(state.y)))
	return Vector2(dw, uw)

func _cubes_state_width(state: Vector2i) -> float:
	var g := _cubes_group_widths(state)
	return g.x + g.y + (CUBE_GROUP_GAP if g.x > 0.0 and g.y > 0.0 else 0.0)

func _cubes_width() -> float:
	var states := _cubes_states()
	var w := 0.0
	for s: Vector2i in states:
		w += _cubes_state_width(s)
	if states.size() == 2:
		w += CUBE_ARROW_W
	return w

# ---------------------------------------------------------------- dessin

func _draw() -> void:
	match kind:
		"billes":
			_draw_billes()
		"file":
			_draw_file()
		"cubes":
			_draw_cubes()
		"cases":
			_draw_cases()

func _font() -> Font:
	return get_theme_default_font()

func _text(pos: Vector2, text: String, font_size: int, color: Color = INK, width: float = -1.0) -> void:
	var align := HORIZONTAL_ALIGNMENT_CENTER if width > 0.0 else HORIZONTAL_ALIGNMENT_LEFT
	draw_string(_font(), pos, text, align, width, font_size, color)

func _bille(center: Vector2, color: Color) -> void:
	draw_circle(center, BILLE_R, color.darkened(0.25))
	draw_circle(center, BILLE_R - 2.5, color)
	draw_circle(center + Vector2(-4, -4), 3.5, Color(1, 1, 1, 0.65))

func _draw_billes() -> void:
	var groups := _ints("groupes")
	var names := str(params.get("couleurs", "bleu,rouge")).split(",", false)
	var colors: Array[Color] = []
	for i: int in groups.size():
		colors.append(_color_named(names[i] if i < names.size() else "bleu", classe_color))
	var show_total := str(params.get("total", "")) == "oui"
	var box_h := _billes_box_height()
	var x := maxf(0.0, (size.x - custom_minimum_size.x) / 2.0)
	var y := 4.0
	var cell := BILLE_R * 2.0 + BILLE_GAP
	for i: int in groups.size():
		if i > 0:
			_text(Vector2(x, y + box_h / 2.0 + 12.0), "+", 34, INK, 44.0)
			x += 44.0
		x += _draw_bille_box(Vector2(x, y), box_h, [groups[i]], [colors[i]], cell)
	if show_total:
		_text(Vector2(x, y + box_h / 2.0 + 12.0), "=", 34, INK, 44.0)
		x += 44.0
		_draw_bille_box(Vector2(x, y), box_h, Array(groups), colors, cell)

## Une boite arrondie contenant les billes (plusieurs couleurs a la suite pour le total).
## Renvoie la largeur occupee.
func _draw_bille_box(origin: Vector2, box_h: float, counts: Array, colors: Array, cell: float) -> float:
	var total := 0
	for c: int in counts:
		total += c
	var box := _billes_box_size(maxi(total, 1))
	var rect := Rect2(origin + Vector2(0, (box_h - box.y) / 2.0), box)
	var style := StyleBoxFlat.new()
	style.bg_color = Color(1, 1, 1, 0.9)
	style.border_color = INK.lerp(Color.WHITE, 0.55)
	style.set_border_width_all(2)
	style.set_corner_radius_all(12)
	draw_style_box(style, rect)
	var index := 0
	for g: int in counts.size():
		for k: int in counts[g]:
			var col := index % 5
			var row := floori(index / 5.0)
			var center := rect.position + Vector2(4.0 + BILLE_GAP + BILLE_R + col * cell, 4.0 + BILLE_GAP + BILLE_R + row * cell)
			_bille(center, colors[g])
			index += 1
	return box.x

func _draw_file() -> void:
	var from := int(params.get("de", 0))
	var to := int(params.get("a", 10))
	var count := maxi(1, to - from)
	var margin := 20.0
	var step := minf(56.0, (size.x - margin * 2.0) / count)
	var width := step * count
	var x0 := (size.x - width) / 2.0
	var line_y := 74.0
	var line_col := INK.lerp(Color.WHITE, 0.25)
	draw_line(Vector2(x0 - 10, line_y), Vector2(x0 + width + 14, line_y), line_col, 3.0, true)
	# Pointe de fleche au bout de la file
	draw_colored_polygon(PackedVector2Array([
		Vector2(x0 + width + 22, line_y), Vector2(x0 + width + 10, line_y - 7), Vector2(x0 + width + 10, line_y + 7)]), line_col)
	var marked: Dictionary = {}
	var bonds: Array[Vector2i] = []
	for pair: String in str(params.get("bonds", "")).split(",", false):
		var ab := pair.split(":")
		if ab.size() == 2:
			bonds.append(Vector2i(int(ab[0]), int(ab[1])))
			marked[int(ab[0])] = true
			marked[int(ab[1])] = true
	for i: int in count + 1:
		var n := from + i
		var x := x0 + i * step
		var is_marked: bool = marked.has(n)
		draw_line(Vector2(x, line_y - 8), Vector2(x, line_y + 8), line_col, 2.0, true)
		if is_marked:
			draw_circle(Vector2(x, line_y), 7.0, classe_color)
		_text(Vector2(x - 20, line_y + 32), str(n), 22 if is_marked else 18, INK if is_marked else INK.lerp(Color.WHITE, 0.3), 40.0)
	var palette: Array[Color] = [UNITES, classe_color.darkened(0.15)]
	for b: int in bonds.size():
		var a := x0 + (bonds[b].x - from) * step
		var c := x0 + (bonds[b].y - from) * step
		var col := palette[b % palette.size()]
		var center := Vector2((a + c) / 2.0, line_y - 6.0)
		var radius := absf(c - a) / 2.0
		var height := minf(radius, 42.0)
		# Arc aplati : demi-ellipse tracee point par point
		var pts := PackedVector2Array()
		for s: int in 25:
			var t := PI + PI * s / 24.0
			pts.append(center + Vector2(cos(t) * radius, sin(t) * height))
		draw_polyline(pts, col, 4.0, true)
		var tip := pts[pts.size() - 1]
		draw_colored_polygon(PackedVector2Array([tip + Vector2(0, 4), tip + Vector2(-8, -8), tip + Vector2(8, -8)]), col)
		_text(Vector2(center.x - 30, center.y - height - 6), "+%d" % (bonds[b].y - bonds[b].x), 22, col.darkened(0.2), 60.0)

func _cube(rect: Rect2, color: Color) -> void:
	draw_rect(rect, color)
	draw_rect(rect, color.darkened(0.35), false, 1.5)

func _draw_cubes() -> void:
	var states := _cubes_states()
	var x := maxf(0.0, (size.x - _cubes_width()) / 2.0)
	for i: int in states.size():
		if i > 0:
			var y := 5 * CUBE
			var col := INK.lerp(Color.WHITE, 0.2)
			draw_line(Vector2(x + 14, y), Vector2(x + CUBE_ARROW_W - 22, y), col, 4.0, true)
			draw_colored_polygon(PackedVector2Array([Vector2(x + CUBE_ARROW_W - 12, y),
				Vector2(x + CUBE_ARROW_W - 24, y - 9), Vector2(x + CUBE_ARROW_W - 24, y + 9)]), col)
			var diff := (states[1].x - states[0].x) * 10 + (states[1].y - states[0].y)
			_text(Vector2(x, y - 14), "%+d" % diff, 22, UNITES.darkened(0.25), CUBE_ARROW_W)
			x += CUBE_ARROW_W
		_draw_cubes_state(x, states[i])
		x += _cubes_state_width(states[i])

func _draw_cubes_state(x: float, state: Vector2i) -> void:
	var widths := _cubes_group_widths(state)
	var top := 2.0
	var label_y := top + 10 * CUBE + 24.0
	if state.x > 0:
		var bars_w := state.x * (CUBE + 8.0) - 8.0
		var bx := x + (widths.x - bars_w) / 2.0
		for i: int in state.x:
			for k: int in 10:
				_cube(Rect2(bx + i * (CUBE + 8.0), top + k * CUBE, CUBE, CUBE), classe_color)
		_text(Vector2(x, label_y), _dizaine_label(state.x), CUBE_LABEL_SIZE, classe_color.darkened(0.35), widths.x)
		x += widths.x + CUBE_GROUP_GAP
	if state.y > 0:
		var cols := ceili(state.y / 10.0)
		var cubes_w := cols * (CUBE + 6.0) - 6.0
		var ux := x + (widths.y - cubes_w) / 2.0
		for i: int in state.y:
			# Les unites s'empilent depuis le bas, colonne par colonne
			_cube(Rect2(ux + floori(i / 10.0) * (CUBE + 6.0), top + (9 - i % 10) * CUBE, CUBE, CUBE), UNITES)
		_text(Vector2(x, label_y), _unite_label(state.y), CUBE_LABEL_SIZE, UNITES.darkened(0.35), widths.y)

func _draw_cases() -> void:
	var n := int(params.get("n", 10))
	var colored := int(params.get("bleu", 0))
	var x0 := (size.x - n * CASE) / 2.0
	for i: int in n:
		var rect := Rect2(x0 + i * CASE, 2.0, CASE, CASE)
		draw_rect(rect, classe_color if i < colored else JAUNE)
		draw_rect(rect, INK.lerp(Color.WHITE, 0.2), false, 2.0)
