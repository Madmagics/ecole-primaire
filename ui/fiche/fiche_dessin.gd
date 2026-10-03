## Petit dessin vectoriel d'une fiche de cours (2026-09-29), trace a la main dans _draw() : aucune
## image a charger, le jeu reste leger. Cree par FichePage a partir d'une balise ecrite seule sur
## sa ligne dans le texte de la fiche (contenu_cours.contenu dans Supabase), par exemple :
##   [billes groupes=3,2 couleurs=bleu,rouge total=oui]  -> groupes de billes + "=" + total
##   [file de=0 a=10 bonds=4:7]                          -> file de nombres avec des bonds
##   [cubes d=1 u=5]                                     -> barres de dizaines + cubes unites
##   [cubes d=1 u=8 vers=2:8]                            -> avant, fleche "+10", apres
##   [cases n=10 bleu=3]                                 -> rangee de cases, les premieres coloriees
## Soustraction (2026-09-30) :
##   [billes groupes=5 barrees=2 total=oui]              -> 5 billes dont 2 barrees, "=" + les 3 restantes
##   [file de=0 a=10 bonds=7:4]                          -> bond en arriere (fleche vers la gauche, "-3")
##   [cubes d=2 u=8 vers=1:8]                            -> avant, fleche "-10", apres
##   [cases n=10 bleu=10 barrees=3]                      -> les 3 dernieres cases barrees
## Maths CP (2026-09-30) :
##   [file de=0 a=10 points=3,7]                         -> nombres marques, sans bond
##   [cubes d=2 u=6 vers=1:3 fleche=moitié]              -> etiquette libre sur la fleche
##   [paires n=7]                                        -> billes rangees par 2 (pair / impair)
##   [formes liste=carre,triangle,rond cotes=oui]        -> formes geometriques + nombre de cotes
## Maths CE1 (2026-10-01) :
##   [cubes c=2 d=3 u=4]                                 -> plaques de centaines (10 x 10) en plus
##   [cubes c=1 d=2 u=5 vers=2:2:5]                      -> "vers" a 3 nombres = centaines:dizaines:unites
##   [file de=0 a=500 pas=100 bonds=100:200]             -> une graduation tous les "pas"
##   [billes groupes=4,4,4 signes=non]                   -> groupes sans "+" (partages)
##   [grille lignes=3 colonnes=5]                        -> quadrillage (multiplication 3 x 5)
##   [tarte parts=2,3,4 colorees=1 noms=oui]             -> tartes coupees en parts egales
##   [rect long=10 larg=6 unite=cm]                      -> rectangle avec la longueur de ses cotes
## Maths CM1-CM2 (2026-10-03) :
##   [tarte parts=2,4 colorees=1,2]                      -> nombre de parts colorees par tarte
##   [grille lignes=10 colonnes=10 case=18 colorees=25]  -> petites cases, les 25 premieres colorees
##   [grille lignes=4 colonnes=6 forme=6,6,3,3]          -> nombre de cases par ligne (figure en L)
##   [potence dividende=293 diviseur=6]                  -> division posee "en potence", etapes
##                                                          calculees ici (quotient + reste)
##   [pave long=4 larg=3 haut=2 unite=cm]                -> pave droit en petits cubes (volume)
##   [droite de=0 a=2 parts=8 points=3,5 noms=fraction]  -> droite graduee entre deux entiers,
##                                                          "parts" = graduations ; noms=decimal
##                                                          ecrit 0,3 au lieu de 3/10
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
const PLAQUE_GAP := 8.0
const GRILLE := 34.0
const TARTE_R := 54.0
const TARTE_GAP := 50.0
const TARTE_NOMS := {2: "une moitié", 3: "un tiers", 4: "un quart"}
const FORME := 84.0
const FORME_GAP := 34.0
const FORMES_NOMS := {
	"carre": "carré", "rectangle": "rectangle", "triangle": "triangle", "rond": "rond",
	"losange": "losange", "pentagone": "pentagone", "hexagone": "hexagone",
}

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
		"grille":
			return Vector2(int(params.get("colonnes", 5)) * _grille_case(), int(params.get("lignes", 3)) * _grille_case() + 4.0)
		"tarte":
			var n_tartes := _ints("parts").size()
			var h_tarte := TARTE_R * 2.0 + 8.0 + (30.0 if str(params.get("noms", "")) == "oui" else 0.0)
			return Vector2(n_tartes * (TARTE_R * 2.0 + TARTE_GAP) - TARTE_GAP + 20.0, h_tarte)
		"rect":
			var rs := _rect_size()
			return Vector2(rs.x + 150.0, rs.y + 70.0)
		"cases":
			var n := int(params.get("n", 10))
			return Vector2(n * CASE, CASE + 8.0)
		"paires":
			var cols := ceili(int(params.get("n", 0)) / 2.0)
			return Vector2(cols * _paire_col_w(), 2.0 * (BILLE_R * 2.0 + BILLE_GAP) + 22.0)
		"potence":
			return _potence_size()
		"pave":
			return _pave_size()
		"droite":
			return Vector2(560, 112)
		"formes":
			var count := _formes_liste().size()
			var h := FORME + 34.0 + (26.0 if str(params.get("cotes", "")) == "oui" else 0.0)
			return Vector2(count * (_forme_w() + FORME_GAP) - FORME_GAP, h)
	return Vector2.ZERO

func _billes_groups() -> PackedInt32Array:
	var groups := _ints("groupes")
	if str(params.get("total", "")) == "oui":
		var total := 0
		for g: int in groups:
			total += g
		groups.append(maxi(0, total - _barrees()))
	return groups

## Nombre de billes (ou de cases) barrees, prises a la fin : ce qu'on enleve dans une soustraction.
func _barrees() -> int:
	return maxi(0, int(params.get("barrees", 0)))

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

## Un "etat" de cubes = c plaques de centaines + d barres de dizaines + u cubes unites (x, y, z).
## [cubes d=1 u=8 vers=2:8] dessine deux etats sur une ligne, relies par une fleche "+10"
## (avant -> apres) ; "vers" a 3 nombres (c:d:u) pour les centaines.
func _cubes_states() -> Array[Vector3i]:
	var states: Array[Vector3i] = [Vector3i(int(params.get("c", 0)), int(params.get("d", 0)), int(params.get("u", 0)))]
	var vers := str(params.get("vers", "")).split(":")
	if vers.size() == 2:
		states.append(Vector3i(0, int(vers[0]), int(vers[1])))
	elif vers.size() == 3:
		states.append(Vector3i(int(vers[0]), int(vers[1]), int(vers[2])))
	return states

func _label_width(text: String) -> float:
	return _font().get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, CUBE_LABEL_SIZE).x

func _centaine_label(c: int) -> String:
	return "%d centaine%s" % [c, "s" if c > 1 else ""]

func _dizaine_label(d: int) -> String:
	return "%d dizaine%s" % [d, "s" if d > 1 else ""]

func _unite_label(u: int) -> String:
	return "%d unité%s" % [u, "s" if u > 1 else ""]

## Largeurs [groupe centaines, groupe dizaines, groupe unites] d'un etat, etiquettes comprises.
func _cubes_group_widths(state: Vector3i) -> Vector3:
	var cw := 0.0
	if state.x > 0:
		cw = maxf(state.x * (10 * CUBE + PLAQUE_GAP) - PLAQUE_GAP, _label_width(_centaine_label(state.x)))
	var dw := 0.0
	if state.y > 0:
		dw = maxf(state.y * (CUBE + 8.0) - 8.0, _label_width(_dizaine_label(state.y)))
	var uw := 0.0
	if state.z > 0:
		uw = maxf(ceili(state.z / 10.0) * (CUBE + 6.0) - 6.0, _label_width(_unite_label(state.z)))
	return Vector3(cw, dw, uw)

func _cubes_state_width(state: Vector3i) -> float:
	var g := _cubes_group_widths(state)
	var used := 0
	for w: float in [g.x, g.y, g.z]:
		if w > 0.0:
			used += 1
	return g.x + g.y + g.z + CUBE_GROUP_GAP * maxi(0, used - 1)

func _cubes_width() -> float:
	var states := _cubes_states()
	var w := 0.0
	for s: Vector3i in states:
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
		"paires":
			_draw_paires()
		"formes":
			_draw_formes()
		"grille":
			_draw_grille()
		"tarte":
			_draw_tarte()
		"rect":
			_draw_rect()
		"potence":
			_draw_potence()
		"pave":
			_draw_pave()
		"droite":
			_draw_droite()

func _font() -> Font:
	return get_theme_default_font()

func _text(pos: Vector2, text: String, font_size: int, color: Color = INK, width: float = -1.0) -> void:
	var align := HORIZONTAL_ALIGNMENT_CENTER if width > 0.0 else HORIZONTAL_ALIGNMENT_LEFT
	draw_string(_font(), pos, text, align, width, font_size, color)

func _bille(center: Vector2, color: Color, barree: bool = false) -> void:
	if barree:
		# Bille enlevee : palie puis barree d'une croix
		color = color.lerp(Color.WHITE, 0.6)
	draw_circle(center, BILLE_R, color.darkened(0.25))
	draw_circle(center, BILLE_R - 2.5, color)
	draw_circle(center + Vector2(-4, -4), 3.5, Color(1, 1, 1, 0.65))
	if barree:
		_croix(center, BILLE_R + 2.0)

## Croix rouge fonce qui barre un objet enleve (bille ou case).
func _croix(center: Vector2, half: float) -> void:
	var col := Color("C62828")
	draw_line(center + Vector2(-half, -half), center + Vector2(half, half), col, 4.0, true)
	draw_line(center + Vector2(-half, half), center + Vector2(half, -half), col, 4.0, true)

func _draw_billes() -> void:
	var groups := _ints("groupes")
	var names := str(params.get("couleurs", "bleu,rouge")).split(",", false)
	var colors: Array[Color] = []
	for i: int in groups.size():
		colors.append(_color_named(names[i] if i < names.size() else "bleu", classe_color))
	var show_total := str(params.get("total", "")) == "oui"
	var barrees := _barrees()
	var box_h := _billes_box_height()
	var x := maxf(0.0, (size.x - custom_minimum_size.x) / 2.0)
	var y := 4.0
	var cell := BILLE_R * 2.0 + BILLE_GAP
	for i: int in groups.size():
		if i > 0:
			if str(params.get("signes", "")) != "non":
				_text(Vector2(x, y + box_h / 2.0 + 12.0), "+", 34, INK, 44.0)
			x += 44.0
		# Les billes barrees sont les dernieres du dernier groupe
		var crossed := barrees if i == groups.size() - 1 else 0
		x += _draw_bille_box(Vector2(x, y), box_h, [groups[i]], [colors[i]], cell, crossed)
	if show_total:
		_text(Vector2(x, y + box_h / 2.0 + 12.0), "=", 34, INK, 44.0)
		x += 44.0
		if barrees > 0:
			var total := 0
			for g: int in groups:
				total += g
			_draw_bille_box(Vector2(x, y), box_h, [maxi(0, total - barrees)], [colors[0]], cell)
		else:
			_draw_bille_box(Vector2(x, y), box_h, Array(groups), colors, cell)

## Une boite arrondie contenant les billes (plusieurs couleurs a la suite pour le total).
## Les "crossed" dernieres billes sont barrees. Renvoie la largeur occupee.
func _draw_bille_box(origin: Vector2, box_h: float, counts: Array, colors: Array, cell: float, crossed: int = 0) -> float:
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
			_bille(center, colors[g], index >= total - crossed)
			index += 1
	return box.x

func _draw_file() -> void:
	var from := int(params.get("de", 0))
	var to := int(params.get("a", 10))
	# "pas" : une graduation tous les pas (de 10 en 10, de 100 en 100...)
	var pas := maxi(1, int(params.get("pas", 1)))
	## Division entiere volontaire : nombre de graduations entier.
	@warning_ignore("integer_division")
	var count := maxi(1, (to - from) / pas)
	var margin := 20.0
	var step := minf(56.0 if pas == 1 else 84.0, (size.x - margin * 2.0) / count)
	var width := step * count
	var x0 := (size.x - width) / 2.0
	var line_y := 74.0
	var line_col := INK.lerp(Color.WHITE, 0.25)
	draw_line(Vector2(x0 - 10, line_y), Vector2(x0 + width + 14, line_y), line_col, 3.0, true)
	# Pointe de fleche au bout de la file
	draw_colored_polygon(PackedVector2Array([
		Vector2(x0 + width + 22, line_y), Vector2(x0 + width + 10, line_y - 7), Vector2(x0 + width + 10, line_y + 7)]), line_col)
	var marked: Dictionary = {}
	for p: String in str(params.get("points", "")).split(",", false):
		marked[int(p)] = true
	var bonds: Array[Vector2i] = []
	for pair: String in str(params.get("bonds", "")).split(",", false):
		var ab := pair.split(":")
		if ab.size() == 2:
			bonds.append(Vector2i(int(ab[0]), int(ab[1])))
			marked[int(ab[0])] = true
			marked[int(ab[1])] = true
	for i: int in count + 1:
		var n := from + i * pas
		var x := x0 + i * step
		var is_marked: bool = marked.has(n)
		draw_line(Vector2(x, line_y - 8), Vector2(x, line_y + 8), line_col, 2.0, true)
		if is_marked:
			draw_circle(Vector2(x, line_y), 7.0, classe_color)
		_text(Vector2(x - 30, line_y + 32), str(n), 22 if is_marked else 18, INK if is_marked else INK.lerp(Color.WHITE, 0.3), 60.0)
	var palette: Array[Color] = [UNITES, classe_color.darkened(0.15)]
	for b: int in bonds.size():
		var a := x0 + float(bonds[b].x - from) / pas * step
		var c := x0 + float(bonds[b].y - from) / pas * step
		var col := palette[b % palette.size()]
		var center := Vector2((a + c) / 2.0, line_y - 6.0)
		var radius := absf(c - a) / 2.0
		var height := minf(radius, 42.0)
		# Arc aplati : demi-ellipse tracee point par point
		var pts := PackedVector2Array()
		for s: int in 25:
			var t := PI + PI * s / 24.0
			pts.append(center + Vector2(cos(t) * radius, sin(t) * height))
		# Bond en arriere (soustraction) : l'arc part de la droite, la pointe arrive a gauche
		if bonds[b].y < bonds[b].x:
			pts.reverse()
		draw_polyline(pts, col, 4.0, true)
		var tip := pts[pts.size() - 1]
		draw_colored_polygon(PackedVector2Array([tip + Vector2(0, 4), tip + Vector2(-8, -8), tip + Vector2(8, -8)]), col)
		_text(Vector2(center.x - 30, center.y - height - 6), "%+d" % (bonds[b].y - bonds[b].x), 22, col.darkened(0.2), 60.0)

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
			var diff := (states[1].x - states[0].x) * 100 + (states[1].y - states[0].y) * 10 + (states[1].z - states[0].z)
			var label := str(params.get("fleche", "%+d" % diff))
			_text(Vector2(x - 20, y - 14), label, 22, UNITES.darkened(0.25), CUBE_ARROW_W + 40.0)
			x += CUBE_ARROW_W
		_draw_cubes_state(x, states[i])
		x += _cubes_state_width(states[i])

func _draw_cubes_state(x: float, state: Vector3i) -> void:
	var widths := _cubes_group_widths(state)
	var top := 2.0
	var label_y := top + 10 * CUBE + 24.0
	if state.x > 0:
		# Plaques de centaines : 10 x 10 petits carres, couleur de la classe assombrie
		var plaques_w := state.x * (10 * CUBE + PLAQUE_GAP) - PLAQUE_GAP
		var px := x + (widths.x - plaques_w) / 2.0
		var plaque_col := classe_color.darkened(0.2)
		for i: int in state.x:
			for k: int in 100:
				_cube(Rect2(px + i * (10 * CUBE + PLAQUE_GAP) + (k % 10) * CUBE, top + floori(k / 10.0) * CUBE, CUBE, CUBE), plaque_col)
		_text(Vector2(x, label_y), _centaine_label(state.x), CUBE_LABEL_SIZE, plaque_col.darkened(0.35), widths.x)
		x += widths.x + CUBE_GROUP_GAP
	if state.y > 0:
		var bars_w := state.y * (CUBE + 8.0) - 8.0
		var bx := x + (widths.y - bars_w) / 2.0
		for i: int in state.y:
			for k: int in 10:
				_cube(Rect2(bx + i * (CUBE + 8.0), top + k * CUBE, CUBE, CUBE), classe_color)
		_text(Vector2(x, label_y), _dizaine_label(state.y), CUBE_LABEL_SIZE, classe_color.darkened(0.35), widths.y)
		x += widths.y + CUBE_GROUP_GAP
	if state.z > 0:
		var cols := ceili(state.z / 10.0)
		var cubes_w := cols * (CUBE + 6.0) - 6.0
		var ux := x + (widths.z - cubes_w) / 2.0
		for i: int in state.z:
			# Les unites s'empilent depuis le bas, colonne par colonne
			_cube(Rect2(ux + floori(i / 10.0) * (CUBE + 6.0), top + (9 - i % 10) * CUBE, CUBE, CUBE), UNITES)
		_text(Vector2(x, label_y), _unite_label(state.z), CUBE_LABEL_SIZE, UNITES.darkened(0.35), widths.z)

func _draw_cases() -> void:
	var n := int(params.get("n", 10))
	var colored := int(params.get("bleu", 0))
	var crossed := _barrees()
	var x0 := (size.x - n * CASE) / 2.0
	for i: int in n:
		var rect := Rect2(x0 + i * CASE, 2.0, CASE, CASE)
		var fill := classe_color if i < colored else JAUNE
		var barree := i >= n - crossed
		draw_rect(rect, fill.lerp(Color.WHITE, 0.6) if barree else fill)
		draw_rect(rect, INK.lerp(Color.WHITE, 0.2), false, 2.0)
		if barree:
			_croix(rect.get_center(), CASE / 2.0 - 8.0)

# ---------------------------------------------------------------- paires (pair / impair)

func _paire_col_w() -> float:
	return BILLE_R * 2.0 + BILLE_GAP + 14.0

## Billes rangees par colonnes de 2 : chaque paire est entouree. S'il en reste une toute seule
## (nombre impair), elle est dessinee en orange, sans partenaire.
func _draw_paires() -> void:
	var n := int(params.get("n", 0))
	var cols := ceili(n / 2.0)
	var col_w := _paire_col_w()
	var cell := BILLE_R * 2.0 + BILLE_GAP
	var x0 := (size.x - cols * col_w) / 2.0
	for c: int in cols:
		var in_col := mini(2, n - c * 2)
		var rect := Rect2(x0 + c * col_w + 4.0, 2.0, col_w - 8.0, in_col * cell + 8.0)
		var style := StyleBoxFlat.new()
		style.bg_color = Color(1, 1, 1, 0.9)
		style.border_color = (UNITES if in_col == 1 else INK.lerp(Color.WHITE, 0.55))
		style.set_border_width_all(2)
		style.set_corner_radius_all(10)
		draw_style_box(style, rect)
		for r: int in in_col:
			var center := Vector2(rect.get_center().x, rect.position.y + 4.0 + BILLE_GAP / 2.0 + BILLE_R + r * cell)
			_bille(center, UNITES if in_col == 1 else classe_color)

# ---------------------------------------------------------------- formes geometriques

func _formes_liste() -> PackedStringArray:
	return str(params.get("liste", "")).split(",", false)

func _forme_w() -> float:
	return FORME + 26.0

## Sommets d'une forme dans un carre de cote FORME (vide pour le rond).
func _forme_points(forme: String, o: Vector2) -> PackedVector2Array:
	var f := FORME
	match forme:
		"carre":
			return PackedVector2Array([o + Vector2(8, 8), o + Vector2(f - 8, 8), o + Vector2(f - 8, f - 8), o + Vector2(8, f - 8)])
		"rectangle":
			return PackedVector2Array([o + Vector2(-8, 20), o + Vector2(f + 8, 20), o + Vector2(f + 8, f - 12), o + Vector2(-8, f - 12)])
		"triangle":
			return PackedVector2Array([o + Vector2(f / 2.0, 6), o + Vector2(f - 4, f - 8), o + Vector2(4, f - 8)])
		"losange":
			return PackedVector2Array([o + Vector2(f / 2.0, 2), o + Vector2(f - 18, f / 2.0), o + Vector2(f / 2.0, f - 2), o + Vector2(18, f / 2.0)])
		"pentagone", "hexagone":
			var k := 5 if forme == "pentagone" else 6
			var pts := PackedVector2Array()
			for i: int in k:
				var a := -PI / 2.0 + TAU * i / k
				pts.append(o + Vector2(f / 2.0, f / 2.0 + 3.0) + Vector2(cos(a), sin(a)) * (f / 2.0 - 4.0))
			return pts
	return PackedVector2Array()

func _draw_formes() -> void:
	var liste := _formes_liste()
	var show_cotes := str(params.get("cotes", "")) == "oui"
	var w := _forme_w()
	var x := (size.x - (liste.size() * (w + FORME_GAP) - FORME_GAP)) / 2.0
	var fill := classe_color.lerp(Color.WHITE, 0.55)
	var line := classe_color.darkened(0.3)
	for forme: String in liste:
		var o := Vector2(x + (w - FORME) / 2.0, 2.0)
		var pts := _forme_points(forme, o)
		var cotes := pts.size()
		if forme == "rond":
			var c := o + Vector2(FORME / 2.0, FORME / 2.0)
			draw_circle(c, FORME / 2.0 - 4.0, fill)
			draw_arc(c, FORME / 2.0 - 4.0, 0.0, TAU, 48, line, 4.0, true)
		else:
			draw_colored_polygon(pts, fill)
			var closed := pts.duplicate()
			closed.append(pts[0])
			draw_polyline(closed, line, 4.0, true)
			for p: Vector2 in pts:
				draw_circle(p, 5.0, UNITES)
		_text(Vector2(x, FORME + 28.0), str(FORMES_NOMS.get(forme, forme)), 20, INK, w)
		if show_cotes:
			var txt := "0 côté" if cotes == 0 else "%d côtés" % cotes
			_text(Vector2(x, FORME + 54.0), txt, 18, UNITES.darkened(0.3), w)
		x += w + FORME_GAP

# ---------------------------------------------------------------- grille (multiplication)

## Quadrillage de lignes x colonnes cases : 3 lignes de 5 cases = 3 x 5 = 15.
func _draw_grille() -> void:
	var lignes := int(params.get("lignes", 3))
	var colonnes := int(params.get("colonnes", 5))
	var cote := _grille_case()
	var x0 := (size.x - colonnes * cote) / 2.0
	var fill := classe_color.lerp(Color.WHITE, 0.45)
	# CM (2026-10-03) : "forme" = nombre de cases de chaque ligne (figure en L pour l'aire),
	# "colorees" = les N premieres cases en couleur pleine, les autres en jaune pale (pourcentages)
	var forme := _ints("forme")
	var colorees := int(params.get("colorees", -1))
	var index := 0
	for l: int in lignes:
		# Une ligne sur deux un peu plus claire, pour bien voir les rangees
		var col := fill if l % 2 == 0 else fill.lerp(Color.WHITE, 0.35)
		var n_cases := forme[l] if l < forme.size() else colonnes
		for c: int in n_cases:
			var rect := Rect2(x0 + c * cote, 2.0 + l * cote, cote, cote)
			var case_col := col
			if colorees >= 0:
				case_col = classe_color.lerp(Color.WHITE, 0.2) if index < colorees else JAUNE.lerp(Color.WHITE, 0.55)
			draw_rect(rect, case_col)
			draw_rect(rect, classe_color.darkened(0.3), false, 2.0)
			index += 1

## Cote d'une case du quadrillage : GRILLE par defaut, "case=20" pour un grand quadrillage (10 x 10).
func _grille_case() -> float:
	return float(params.get("case", GRILLE))

# ---------------------------------------------------------------- tartes (fractions simples)

## Tartes coupees en parts egales ; les "colorees" premieres parts sont dans la couleur de la classe.
func _draw_tarte() -> void:
	var parts_list := _ints("parts")
	# "colorees" : un nombre pour toutes les tartes, ou une liste (2026-10-03 : colorees=1,2 pour
	# montrer que 1/2 = 2/4)
	var colorees_list := _ints("colorees")
	if colorees_list.is_empty():
		colorees_list.append(1)
	var t := 0
	var show_noms := str(params.get("noms", "")) == "oui"
	var w := parts_list.size() * (TARTE_R * 2.0 + TARTE_GAP) - TARTE_GAP
	var x := (size.x - w) / 2.0
	for parts: int in parts_list:
		var colorees := colorees_list[mini(t, colorees_list.size() - 1)]
		t += 1
		var center := Vector2(x + TARTE_R, 4.0 + TARTE_R)
		for p: int in parts:
			var a0 := -PI / 2.0 + TAU * p / parts
			var a1 := -PI / 2.0 + TAU * (p + 1) / parts
			var pts := PackedVector2Array([center])
			for k: int in 17:
				var a := lerpf(a0, a1, k / 16.0)
				pts.append(center + Vector2(cos(a), sin(a)) * TARTE_R)
			draw_colored_polygon(pts, classe_color if p < colorees else JAUNE.lerp(Color.WHITE, 0.4))
		draw_arc(center, TARTE_R, 0.0, TAU, 64, INK.lerp(Color.WHITE, 0.2), 3.0, true)
		for p: int in parts:
			var a := -PI / 2.0 + TAU * p / parts
			draw_line(center, center + Vector2(cos(a), sin(a)) * TARTE_R, INK.lerp(Color.WHITE, 0.2), 3.0, true)
		if show_noms:
			_text(Vector2(x - 20, TARTE_R * 2.0 + 32.0), _tarte_nom(parts, colorees), 20, INK, TARTE_R * 2.0 + 40.0)
		x += TARTE_R * 2.0 + TARTE_GAP

## Nom ecrit sous une tarte : "un quart" pour 1 part, sinon la fraction ("2/4").
func _tarte_nom(parts: int, colorees: int) -> String:
	if colorees == 1:
		return str(TARTE_NOMS.get(parts, "1 part sur %d" % parts))
	return "%d/%d" % [colorees, parts]

# ---------------------------------------------------------------- rectangle (perimetre)

## Taille a l'ecran du rectangle : au plus 300 x 200 px, en gardant la proportion (2026-10-03 :
## un carre de 8 cm sur 8 cm est dessine carre, et non plus etire en 300 x 200).
func _rect_size() -> Vector2:
	var longueur := maxf(1.0, float(params.get("long", 10)))
	var largeur := maxf(1.0, float(params.get("larg", 6)))
	var echelle := minf(300.0 / longueur, 200.0 / largeur)
	return Vector2(maxf(120.0, longueur * echelle), clampf(largeur * echelle, 50.0, 200.0))

## Rectangle avec la mesure de chaque cote : les longueurs dans la couleur de la classe,
## les largeurs en orange, pour bien voir les 2 paires de cotes egaux.
func _draw_rect() -> void:
	var unite := str(params.get("unite", "cm"))
	var rs := _rect_size()
	var o := Vector2((size.x - rs.x) / 2.0, 32.0)
	var r := Rect2(o, rs)
	draw_rect(r, classe_color.lerp(Color.WHITE, 0.75))
	var c_long := FichePage.token_color(classe_color).darkened(0.2)
	var c_larg := UNITES.darkened(0.1)
	draw_line(r.position, r.position + Vector2(rs.x, 0), c_long, 5.0, true)
	draw_line(r.position + Vector2(0, rs.y), r.end, c_long, 5.0, true)
	draw_line(r.position, r.position + Vector2(0, rs.y), c_larg, 5.0, true)
	draw_line(r.position + Vector2(rs.x, 0), r.end, c_larg, 5.0, true)
	var t_long := "%s %s" % [str(params.get("long", 10)), unite]
	var t_larg := "%s %s" % [str(params.get("larg", 6)), unite]
	_text(Vector2(o.x, o.y - 10.0), t_long, 22, c_long.darkened(0.2), rs.x)
	_text(Vector2(o.x, o.y + rs.y + 28.0), t_long, 22, c_long.darkened(0.2), rs.x)
	_text(Vector2(o.x - 80.0, o.y + rs.y / 2.0 + 8.0), t_larg, 22, c_larg.darkened(0.2), 72.0)
	_text(Vector2(o.x + rs.x + 8.0, o.y + rs.y / 2.0 + 8.0), t_larg, 22, c_larg.darkened(0.2), 72.0)

# ---------------------------------------------------------------- potence (division posee, CM)

const POT_W := 26.0
const POT_H := 34.0
const POT_SIZE := 26

## Calcule les etapes de la division posee de "dividende" par "diviseur", comme a l'ecole :
## on prend assez de chiffres pour pouvoir diviser, on soustrait, on abaisse le chiffre suivant.
## Renvoie {lignes: [{texte, fin, moins, abaisse}], quotient, reste} ; "fin" = colonne du dernier
## chiffre (0 = premier chiffre du dividende).
func _potence_calc() -> Dictionary:
	var dividende := str(params.get("dividende", "0"))
	var diviseur := maxi(1, int(params.get("diviseur", 1)))
	var n := dividende.length()
	var fin := 0
	var partiel := int(dividende.substr(0, 1))
	while partiel < diviseur and fin < n - 1:
		fin += 1
		partiel = partiel * 10 + int(dividende[fin])
	var lignes: Array[Dictionary] = []
	var quotient := ""
	var reste := partiel
	while true:
		## Division entiere volontaire : chiffre du quotient (division posee).
		@warning_ignore("integer_division")
		var q := partiel / diviseur
		quotient += str(q)
		reste = partiel - q * diviseur
		if q > 0:
			lignes.append({"texte": str(q * diviseur), "fin": fin, "moins": true, "abaisse": false})
			lignes.append({"texte": str(reste), "fin": fin, "moins": false, "abaisse": false})
		if fin >= n - 1:
			break
		fin += 1
		partiel = reste * 10 + int(dividende[fin])
		if lignes.is_empty():
			# Rien a soustraire encore (0 au quotient tout de suite) : on reste sur le dividende
			continue
		var derniere: Dictionary = lignes[lignes.size() - 1]
		derniere["texte"] = str(partiel)
		derniere["fin"] = fin
		derniere["abaisse"] = true
	return {"lignes": lignes, "quotient": quotient, "reste": reste, "n": n, "diviseur": str(diviseur)}

func _potence_size() -> Vector2:
	var calc := _potence_calc()
	var n: int = calc["n"]
	var droite := maxf(str(calc["diviseur"]).length(), str(calc["quotient"]).length()) * POT_W
	var rows: int = 1 + (calc["lignes"] as Array).size()
	return Vector2((n + 1) * POT_W + 24.0 + droite + 150.0, rows * POT_H + 16.0)

## Abscisse de la colonne "col" (la colonne 0 du dessin est reservee au signe "-").
func _pot_x(x0: float, col: int) -> float:
	return x0 + (col + 1) * POT_W

## Ligne de base du texte de la rangee "row".
func _pot_y(row: int) -> float:
	return 4.0 + row * POT_H + POT_H - 8.0

func _draw_potence() -> void:
	var calc := _potence_calc()
	var n: int = calc["n"]
	var lignes: Array = calc["lignes"]
	var dividende := str(params.get("dividende", "0"))
	var droite := maxf(str(calc["diviseur"]).length(), str(calc["quotient"]).length()) * POT_W
	var total_w := (n + 1) * POT_W + 24.0 + droite + 150.0
	var x0 := (size.x - total_w) / 2.0
	var col_ink := INK
	var col_classe := FichePage.token_color(classe_color).darkened(0.15)
	var col_reste := UNITES.darkened(0.3)
	var line_col := INK.lerp(Color.WHITE, 0.2)
	for i: int in n:
		_text(Vector2(_pot_x(x0, i), _pot_y(0)), dividende[i], POT_SIZE, col_ink, POT_W)
	for r: int in lignes.size():
		var ligne: Dictionary = lignes[r]
		var texte := str(ligne["texte"])
		var fin: int = ligne["fin"]
		var debut := fin - texte.length() + 1
		var est_reste := r == lignes.size() - 1
		for k: int in texte.length():
			var col := col_ink
			if est_reste:
				col = col_reste
			elif bool(ligne["abaisse"]) and k == texte.length() - 1:
				col = col_classe
			_text(Vector2(_pot_x(x0, debut + k), _pot_y(r + 1)), texte[k], POT_SIZE, col, POT_W)
		if bool(ligne["moins"]):
			_text(Vector2(_pot_x(x0, debut - 1), _pot_y(r + 1)), "-", POT_SIZE, col_ink, POT_W)
			var y := 4.0 + (r + 2) * POT_H - 3.0
			draw_line(Vector2(_pot_x(x0, debut - 1) + 4.0, y), Vector2(_pot_x(x0, fin) + POT_W, y), line_col, 2.0, true)
		if est_reste:
			_text(Vector2(_pot_x(x0, fin) + POT_W + 8.0, _pot_y(r + 1) - 2.0), "← reste", 18, col_reste)
	if lignes.is_empty():
		# Dividende plus petit que le diviseur : le reste est le dividende lui-meme
		_text(Vector2(_pot_x(x0, n - 1) + POT_W + 8.0, _pot_y(0) + POT_H), "reste = %s" % dividende, 18, col_reste)
	# La potence : contour vertical apres le dividende, contour horizontal sous le diviseur
	var xv := _pot_x(x0, n - 1) + POT_W + 14.0
	var h := maxf(2, lignes.size() + 1) * POT_H
	draw_line(Vector2(xv, 2.0), Vector2(xv, 2.0 + h), line_col, 3.0, true)
	draw_line(Vector2(xv, 2.0 + POT_H), Vector2(xv + droite + 24.0, 2.0 + POT_H), line_col, 3.0, true)
	var div_txt := str(calc["diviseur"])
	var quot := str(calc["quotient"])
	for k: int in div_txt.length():
		_text(Vector2(xv + 12.0 + k * POT_W, _pot_y(0)), div_txt[k], POT_SIZE, col_ink, POT_W)
	for k: int in quot.length():
		_text(Vector2(xv + 12.0 + k * POT_W, _pot_y(1)), quot[k], POT_SIZE, col_classe, POT_W)
	_text(Vector2(xv + 8.0, _pot_y(2) - 4.0), "quotient", 18, col_classe)

# ---------------------------------------------------------------- pave droit (volume, CM2)

## Taille d'un petit cube a l'ecran : le pave doit tenir dans environ 300 x 190 px.
func _pave_cube() -> float:
	var lo := maxf(1.0, float(params.get("long", 4)))
	var la := maxf(1.0, float(params.get("larg", 3)))
	var ha := maxf(1.0, float(params.get("haut", 2)))
	return clampf(minf(300.0 / (lo + la * 0.5), 190.0 / (ha + la * 0.5)), 14.0, 40.0)

func _pave_size() -> Vector2:
	var s := _pave_cube()
	var lo := float(params.get("long", 4))
	var la := float(params.get("larg", 3))
	var ha := float(params.get("haut", 2))
	return Vector2((lo + la * 0.5) * s + 190.0, (ha + la * 0.5) * s + 44.0)

## Pave droit fait de petits cubes, dessine en perspective cavaliere (la profondeur part en haut
## a droite). Les cubes sont traces du fond vers l'avant, de bas en haut et de gauche a droite :
## chaque cube recouvre ceux qu'il cache.
func _draw_pave() -> void:
	var s := _pave_cube()
	var lo := int(params.get("long", 4))
	var la := int(params.get("larg", 3))
	var ha := int(params.get("haut", 2))
	var unite := str(params.get("unite", ""))
	var w := (lo + la * 0.5) * s
	var ox := (size.x - w) / 2.0 - 20.0
	var oy := 8.0 + (ha + la * 0.5) * s
	var dep := Vector2(s * 0.5, -s * 0.5)
	var face := classe_color.lerp(Color.WHITE, 0.35)
	var dessus := classe_color.lerp(Color.WHITE, 0.65)
	var cote := classe_color.darkened(0.15)
	var contour := INK.lerp(Color.WHITE, 0.15)
	for y: int in range(la - 1, -1, -1):
		for z: int in ha:
			for x: int in lo:
				var p := Vector2(ox + x * s, oy - z * s) + dep * y
				var avant := PackedVector2Array([p, p + Vector2(s, 0), p + Vector2(s, -s), p + Vector2(0, -s)])
				var haut_f := PackedVector2Array([p + Vector2(0, -s), p + Vector2(s, -s), p + Vector2(s, -s) + dep, p + Vector2(0, -s) + dep])
				var droite_f := PackedVector2Array([p + Vector2(s, 0), p + Vector2(s, 0) + dep, p + Vector2(s, -s) + dep, p + Vector2(s, -s)])
				for poly: Array in [[droite_f, cote], [haut_f, dessus], [avant, face]]:
					var pts: PackedVector2Array = poly[0]
					draw_colored_polygon(pts, poly[1])
					var ferme := pts.duplicate()
					ferme.append(pts[0])
					draw_polyline(ferme, contour, 1.5, true)
	if unite == "":
		return
	var c_long := FichePage.token_color(classe_color).darkened(0.25)
	var c_larg := UNITES.darkened(0.2)
	var c_haut := Color("2E7D32")
	# Longueur sous l'arete avant, largeur le long de la profondeur, hauteur a gauche
	_text(Vector2(ox, oy + 26.0), "%d %s" % [lo, unite], 20, c_long, lo * s)
	var mid_depth := Vector2(ox + lo * s, oy) + dep * (la * 0.5)
	_text(mid_depth + Vector2(12.0, 14.0), "%d %s" % [la, unite], 20, c_larg)
	_text(Vector2(ox - 78.0, oy - ha * s * 0.5 + 8.0), "%d %s" % [ha, unite], 20, c_haut, 70.0)

# ---------------------------------------------------------------- droite graduee (fractions, decimaux)

func _draw_droite() -> void:
	var from := int(params.get("de", 0))
	var to := maxi(from + 1, int(params.get("a", 1)))
	var parts := maxi(1, int(params.get("parts", 10)))
	## Division entiere volontaire : graduations par unite, entier.
	@warning_ignore("integer_division")
	var par_unite := maxi(1, parts / (to - from))
	var noms := str(params.get("noms", "fraction"))
	var margin := 40.0
	var width := size.x - margin * 2.0
	var x0 := margin
	var line_y := 60.0
	var line_col := INK.lerp(Color.WHITE, 0.25)
	draw_line(Vector2(x0 - 10, line_y), Vector2(x0 + width + 14, line_y), line_col, 3.0, true)
	draw_colored_polygon(PackedVector2Array([
		Vector2(x0 + width + 22, line_y), Vector2(x0 + width + 10, line_y - 7), Vector2(x0 + width + 10, line_y + 7)]), line_col)
	var marked: Dictionary = {}
	for p: String in str(params.get("points", "")).split(",", false):
		marked[int(p)] = true
	var col_point := FichePage.token_color(classe_color).darkened(0.1)
	for i: int in parts + 1:
		var x := x0 + width * i / parts
		var entier := i % par_unite == 0
		draw_line(Vector2(x, line_y - (12 if entier else 7)), Vector2(x, line_y + (12 if entier else 7)), line_col, 3.0 if entier else 2.0, true)
		if entier:
			## Division entiere volontaire : valeur entiere affichee sous la graduation.
			@warning_ignore("integer_division")
			_text(Vector2(x - 30, line_y + 38), str(from + i / par_unite), 24, INK, 60.0)
		if marked.has(i):
			draw_circle(Vector2(x, line_y), 8.0, col_point)
			var label := ""
			if noms == "decimal":
				var v := from + float(i) / par_unite
				label = String.num(v, 3).replace(".", ",")
			else:
				label = "%d/%d" % [i + from * par_unite, par_unite]
			_text(Vector2(x - 40, line_y - 18), label, 22, col_point, 80.0)
