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
## Histoire-Geographie (2026-11-06) : [planisphere] [horloge] [terre] [frise] [roue] [plan] [arbre]
## [periodes] [relief] [cours_eau] ; CE2 (2026-11-07) : [carte] [quartiers], voir la
## section "histoire-geographie" en fin de fichier.
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
		"planisphere":
			return _plani_size() + Vector2(0, 6)
		"horloge":
			return Vector2(_horloges().size() * (HORLOGE_R * 2.0 + 50.0) - 50.0, HORLOGE_R * 2.0 + 50.0)
		"terre":
			return Vector2(560, 236)
		"frise":
			return Vector2(maxf(560.0, _liste("points").size() * 130.0), 90)
		"roue":
			return Vector2(ROUE_R * 2.0 + 80.0, ROUE_R * 2.0 + 50.0)
		"plan":
			return Vector2(640, 352)
		"arbre":
			return Vector2(640, 250)
		"periodes":
			return Vector2(PERIODE_W * 5.0 + 80.0, 140)
		"relief":
			return Vector2(700, 248)
		"cours_eau":
			return Vector2(700, 248)
		"paysage":
			return Vector2(790, 262)
		"carte":
			return _carte_min_size()
		"quartiers":
			return Vector2(720, 270)
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
		"planisphere":
			_draw_planisphere()
		"horloge":
			_draw_horloge()
		"terre":
			_draw_terre()
		"frise":
			_draw_frise()
		"roue":
			_draw_roue()
		"plan":
			_draw_plan()
		"arbre":
			_draw_arbre()
		"periodes":
			_draw_periodes()
		"relief":
			_draw_relief()
		"cours_eau":
			_draw_cours_eau()
		"paysage":
			_draw_paysage()
		"carte":
			_draw_carte()
		"quartiers":
			_draw_quartiers()

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

# ---------------------------------------------------------------- histoire-geographie (2026-11-06)
# Dessins des fiches d'Histoire et de Geographie, traces a la main comme les autres (aucune image) :
#   [planisphere noms=oui oceans=oui france=oui cardinaux=oui seul=afrique largeur=720]
#   [horloge heures=3h,9h30 numerique=oui]   [terre]   [plan]
#   [frise points=hier,aujourd'hui,demain marque=2 debut=passé fin=futur]  ("_" = espace)
#   [roue liste=lundi,mardi,... marque=1]   [arbre] (arbre genealogique sur 3 generations)

const PlaniData := preload("res://ui/fiche/planisphere_data.gd")
const PLANI_LAT_N := 84.0
const PLANI_LAT_S := -78.0
const MER := Color("BFE3F5")
const MER_TEXTE := Color("1F5F8B")
## code -> [couleur, nom, position du nom (longitude, latitude)]
const PLANI_CONTINENTS := {
	"amerique_nord": [Color("7CC47F"), "Amérique du Nord", Vector2(-102, 47)],
	"amerique_sud": [Color("F6D55C"), "Amérique du Sud", Vector2(-60, -12)],
	"europe": [Color("A98BE0"), "Europe", Vector2(24, 57)],
	"afrique": [Color("EDA84A"), "Afrique", Vector2(20, 6)],
	"asie": [Color("E57373"), "Asie", Vector2(95, 52)],
	"oceanie": [Color("F08CC0"), "Océanie", Vector2(134, -25)],
	"antarctique": [Color("FFFFFF"), "Antarctique", Vector2(20, -71)],
}
## [nom, position, principal (un des 3 grands oceans du CP)]
const PLANI_OCEANS := [
	["Atlantique", Vector2(-38, 22), true],
	["Pacifique", Vector2(-140, 2), true],
	["Pacifique", Vector2(170, 12), true],
	["Indien", Vector2(78, -22), true],
	["Arctique", Vector2(-165, 77), false],
	["Austral", Vector2(-100, -60), false],
]
const HORLOGE_R := 56.0
const ROUE_R := 140.0

func _txt(s: String) -> String:
	return s.replace("_", " ")

func _liste(key: String) -> PackedStringArray:
	var out := PackedStringArray()
	for s: String in str(params.get(key, "")).split(",", false):
		out.append(_txt(s))
	return out

## Texte centre sur [center] (ligne de base calculee), avec un contour clair pour rester lisible.
func _label(center: Vector2, text: String, font_size: int, color: Color, outline: Color = Color.TRANSPARENT) -> void:
	var w := _font().get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x + 4.0
	var pos := Vector2(center.x - w / 2.0, center.y + font_size * 0.35)
	if outline.a > 0.0:
		draw_string_outline(_font(), pos, text, HORIZONTAL_ALIGNMENT_CENTER, w, font_size, 5, outline)
	draw_string(_font(), pos, text, HORIZONTAL_ALIGNMENT_CENTER, w, font_size, color)

## Le trait s'arrete a la base de la pointe (1 px de recouvrement pour ne pas laisser de jour) :
## s'il allait jusqu'au bout, son epaisseur depassait du triangle et la pointe paraissait
## emoussee (retour Steve 2026-11-07).
func _fleche(from: Vector2, to: Vector2, color: Color, width: float = 3.0, head: float = 12.0) -> void:
	var dir := (to - from).normalized()
	var n := Vector2(-dir.y, dir.x)
	var base := to - dir * (head - 1.0)
	if (base - from).dot(dir) > 0.0:
		draw_line(from, base, color, width, true)
	draw_colored_polygon(PackedVector2Array([to, to - dir * head + n * head * 0.55, to - dir * head - n * head * 0.55]), color)

# -------- planisphere

## Bornes affichees [lon0, lat0, lon1, lat1] : le monde entier, ou cadre=lon0,lat0,lon1,lat1 (CM1, 2026-11-07)
## pour zoomer sur une partie du planisphere (continents et traces decoupes au bord du cadre).
func _plani_bornes() -> Array:
	var c := str(params.get("cadre", "")).split(",", false)
	if c.size() == 4:
		return [float(c[0]), float(c[1]), float(c[2]), float(c[3])]
	return [-180.0, PLANI_LAT_S, 180.0, PLANI_LAT_N]

func _plani_size() -> Vector2:
	var w := float(params.get("largeur", 720))
	var b := _plani_bornes()
	return Vector2(w, w * (b[3] - b[1]) / (b[2] - b[0]))

func _geo(r: Rect2, lon: float, lat: float) -> Vector2:
	var b := _plani_bornes()
	return r.position + Vector2((lon - b[0]) / (b[2] - b[0]) * r.size.x, (b[3] - lat) / (b[3] - b[1]) * r.size.y)

func _rect_poly(r: Rect2) -> PackedVector2Array:
	return PackedVector2Array([r.position, Vector2(r.end.x, r.position.y), r.end, Vector2(r.position.x, r.end.y)])

## Polygone decoupe au cadre de la carte (seulement si cadre= est donne).
func _clip_poly(pts: PackedVector2Array, r: Rect2) -> Array:
	if str(params.get("cadre", "")) == "":
		return [pts]
	return Geometry2D.intersect_polygons(pts, _rect_poly(r))

func _clip_ligne(pts: PackedVector2Array, r: Rect2) -> Array:
	if str(params.get("cadre", "")) == "":
		return [pts]
	return Geometry2D.intersect_polyline_with_polygon(pts, _rect_poly(r))

func _label_dans(r: Rect2, c: Vector2, text: String, fs: int, color: Color, outline: Color = Color.TRANSPARENT) -> void:
	if r.has_point(c):
		_label(c, text, fs, color, outline)

func _draw_planisphere() -> void:
	var ps := _plani_size()
	var r := Rect2(Vector2((size.x - ps.x) / 2.0, 2.0), ps)
	var k := r.size.x / 720.0
	draw_rect(r, MER)
	var seul := str(params.get("seul", ""))
	for code: String in PlaniData.CONTINENTS:
		var fill: Color = PLANI_CONTINENTS[code][0]
		if seul != "" and code != seul:
			fill = fill.lerp(Color("EFEAE0"), 0.8)
		elif _on("pale"):
			fill = fill.lerp(Color("F4EFE6"), 0.75)
		for ring: Array in PlaniData.CONTINENTS[code]:
			var pts := PackedVector2Array()
			for i: int in range(0, ring.size(), 2):
				pts.append(_geo(r, float(ring[i]), float(ring[i + 1])))
			for poly: PackedVector2Array in _clip_poly(pts, r):
				if poly.size() < 3:
					continue
				draw_colored_polygon(poly, fill)
				poly.append(poly[0])
				draw_polyline(poly, INK.lerp(MER, 0.4), 1.2, true)
	_draw_plani_couches(r, k)
	if str(params.get("oceans", "")) != "":
		var tous := str(params.get("oceans", "")) == "tous"
		for o: Array in PLANI_OCEANS:
			if o[2] or tous:
				var c := _geo(r, o[1].x, o[1].y)
				var fs := int(round((18.0 if o[2] else 14.0) * k))
				_label(c - Vector2(0, fs * 0.6), "océan", fs - 2, MER_TEXTE)
				_label(c + Vector2(0, fs * 0.6), o[0], fs, MER_TEXTE)
	if str(params.get("noms", "")) == "oui":
		for code: String in PLANI_CONTINENTS:
			if seul == "" or code == seul:
				var info: Array = PLANI_CONTINENTS[code]
				_label_dans(r, _geo(r, info[2].x, info[2].y), info[1], int(round(20.0 * k)), INK, Color(1, 1, 1, 0.85))
	if str(params.get("france", "")) == "oui":
		var f := _geo(r, PlaniData.FRANCE.x, PlaniData.FRANCE.y)
		draw_circle(f, 6.0 * k, Color("C62828"))
		draw_arc(f, 6.0 * k, 0.0, TAU, 20, Color.WHITE, 2.0, true)
		_label(f + Vector2(-46.0 * k, 0), "France", int(round(16.0 * k)), Color("C62828"), Color(1, 1, 1, 0.9))
	if str(params.get("cardinaux", "")) == "oui":
		_rose(_geo(r, -158, -36), 34.0 * k)
	draw_rect(r, INK, false, 2.0)

## Rose des vents : N en haut, puis E, S, O dans le sens des aiguilles d'une montre.
func _rose(c: Vector2, l: float) -> void:
	var col := INK
	for d: Vector2 in [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]:
		var n := Vector2(-d.y, d.x)
		draw_colored_polygon(PackedVector2Array([c + d * l, c + n * l * 0.2, c - n * l * 0.2]),
			Color("C62828") if d == Vector2.UP else col)
	var fs := int(l * 0.55)
	_label(c + Vector2(0, -l - fs * 0.7), "N", fs, Color("C62828"), Color.WHITE)
	_label(c + Vector2(l + fs * 0.7, 0), "E", fs, col, Color.WHITE)
	_label(c + Vector2(0, l + fs * 0.7), "S", fs, col, Color.WHITE)
	_label(c + Vector2(-l - fs * 0.7, 0), "O", fs, col, Color.WHITE)

# -------- horloge

func _horloges() -> Array:
	var out := []
	for s: String in str(params.get("heures", "3h")).split(",", false):
		var parts := s.split("h")
		out.append([int(parts[0]), int(parts[1]) if parts.size() > 1 and parts[1] != "" else 0])
	return out

func _draw_horloge() -> void:
	var hs := _horloges()
	var cell := HORLOGE_R * 2.0 + 50.0
	var x := (size.x - (hs.size() * cell - 50.0)) / 2.0 + HORLOGE_R
	var numerique := str(params.get("numerique", "")) == "oui"
	for hm: Array in hs:
		var c := Vector2(x, HORLOGE_R + 4.0)
		draw_circle(c, HORLOGE_R, Color.WHITE)
		draw_arc(c, HORLOGE_R, 0.0, TAU, 48, classe_color.darkened(0.2), 5.0, true)
		for i: int in 60:
			var a := TAU * i / 60.0
			var d := Vector2(sin(a), -cos(a))
			var long := 8.0 if i % 5 == 0 else 3.0
			draw_line(c + d * (HORLOGE_R - 4.0), c + d * (HORLOGE_R - 4.0 - long), INK, 2.0 if i % 5 == 0 else 1.0, true)
		for n: int in range(1, 13):
			var a := TAU * n / 12.0
			_label(c + Vector2(sin(a), -cos(a)) * (HORLOGE_R - 22.0), str(n), 15, INK)
		var h: int = hm[0]
		var m: int = hm[1]
		var ah := TAU * ((h % 12) + m / 60.0) / 12.0
		var am := TAU * m / 60.0
		draw_line(c, c + Vector2(sin(am), -cos(am)) * (HORLOGE_R - 12.0), classe_color.darkened(0.3), 4.0, true)
		draw_line(c, c + Vector2(sin(ah), -cos(ah)) * (HORLOGE_R * 0.52), INK, 7.0, true)
		draw_circle(c, 5.0, INK)
		var y := HORLOGE_R * 2.0 + 30.0
		var txt := "%d h" % h if m == 0 else "%d h %02d" % [h, m]
		if numerique:
			var box := Rect2(Vector2(x - 46.0, y - 22.0), Vector2(92.0, 34.0))
			draw_rect(box, Color("263238"))
			_label(box.get_center(), "%d:%02d" % [h, m], 22, Color("8CF59B"))
		else:
			_label(Vector2(x, y - 4.0), txt, 20, INK)
		x += cell

# -------- terre (jour / nuit)

func _draw_terre() -> void:
	var cy := 112.0
	var sun := Vector2(size.x / 2.0 - 190.0, cy)
	var earth := Vector2(size.x / 2.0 + 120.0, cy)
	var er := 74.0
	for i: int in 12:
		var a := TAU * i / 12.0
		var d := Vector2(cos(a), sin(a))
		draw_line(sun + d * 50.0, sun + d * 66.0, Color("F9A825"), 4.0, true)
	draw_circle(sun, 44.0, Color("FFD54F"))
	draw_arc(sun, 44.0, 0.0, TAU, 40, Color("F9A825"), 3.0, true)
	_label(sun + Vector2(0, 92), "le Soleil", 19, INK)
	for dy: float in [-44.0, 0.0, 44.0]:
		_fleche(sun + Vector2(76, dy * 0.6), earth + Vector2(-er - 14.0, dy), Color("F9A825"), 2.5, 10.0)
	draw_circle(earth, er, Color("27365E"))
	var lit := PackedVector2Array()
	for i: int in 33:
		var a := PI / 2.0 + PI * i / 32.0
		lit.append(earth + Vector2(cos(a), sin(a)) * er)
	draw_colored_polygon(lit, Color("6EC6F0"))
	draw_arc(earth, er, 0.0, TAU, 48, INK, 2.5, true)
	_label(earth + Vector2(-er * 0.48, 0), "jour", 20, INK)
	_label(earth + Vector2(er * 0.48, 0), "nuit", 20, Color.WHITE)
	_label(earth + Vector2(0, er + 20.0), "la Terre", 19, INK)
	# fleche courbe : la Terre tourne sur elle-meme. La pointe suit la tangente de l'arc a son bout
	# (angle croissant = sens des aiguilles d'une montre a l'ecran, y vers le bas).
	var a_fin := PI * 1.85
	var ar := er + 16.0
	draw_arc(earth, ar, PI * 1.15, a_fin - 0.08, 24, classe_color.darkened(0.2), 4.0, true)
	var bout := earth + Vector2(cos(a_fin), sin(a_fin)) * ar
	var tangente := Vector2(-sin(a_fin), cos(a_fin))
	_fleche(bout - tangente * 16.0, bout + tangente * 4.0, classe_color.darkened(0.2), 4.0, 16.0)

# -------- frise

func _draw_frise() -> void:
	var pts := _liste("points")
	var marque := int(params.get("marque", 0))
	var y := 40.0
	var x0 := 20.0
	var x1 := size.x - 20.0
	var col := classe_color.darkened(0.15)
	# La pointe va jusqu'au bord du dessin (18 px plus loin que la base de calcul des points)
	# pour laisser de l'air entre le dernier point et la fleche (retour Steve 2026-11-07).
	var x_pointe := size.x - 2.0
	_fleche(Vector2(x0, y), Vector2(x_pointe, y), col, 6.0, 20.0)
	var debut := _txt(str(params.get("debut", "")))
	var fin := _txt(str(params.get("fin", "")))
	# Etiquettes calees sur les bords (et non centrees pres du bord) : un nom long comme
	# « IIIe République » ne doit pas sortir du dessin.
	if debut != "":
		var t_debut := "← " + debut
		_label(Vector2(x0 + _font().get_string_size(t_debut, HORIZONTAL_ALIGNMENT_LEFT, -1, 17).x / 2.0 + 2.0, y - 24.0), t_debut, 17, col)
	if fin != "":
		var t_fin := fin + " →"
		_label(Vector2(x_pointe - _font().get_string_size(t_fin, HORIZONTAL_ALIGNMENT_LEFT, -1, 17).x / 2.0 - 2.0, y - 24.0), t_fin, 17, col)
	var n := pts.size()
	for i: int in n:
		var px := x0 + 40.0 + (x1 - x0 - 110.0) * (i / maxf(1.0, n - 1.0))
		var on := i + 1 == marque
		draw_circle(Vector2(px, y), 11.0 if on else 8.0, UNITES if on else Color.WHITE)
		draw_arc(Vector2(px, y), 11.0 if on else 8.0, 0.0, TAU, 20, UNITES.darkened(0.3) if on else col, 3.0, true)
		_label(Vector2(px, y + 34.0), pts[i], 19 if on else 18, UNITES.darkened(0.35) if on else INK)

# -------- roue (temps cyclique)

func _draw_roue() -> void:
	var items := _liste("liste")
	var marque := int(params.get("marque", 0))
	var n := items.size()
	var c := Vector2(size.x / 2.0, ROUE_R + 24.0)
	var light := classe_color.lerp(Color.WHITE, 0.7)
	var alt := UNITES.lerp(Color.WHITE, 0.6)
	for i: int in n:
		var a0 := -PI / 2.0 + TAU * i / n
		var a1 := a0 + TAU / n
		var poly := PackedVector2Array([c])
		for j: int in 13:
			var a := a0 + (a1 - a0) * j / 12.0
			poly.append(c + Vector2(cos(a), sin(a)) * ROUE_R)
		var fill := UNITES if i + 1 == marque else (light if i % 2 == 0 else alt)
		draw_colored_polygon(poly, fill)
		poly.append(c)
		draw_polyline(poly, classe_color.darkened(0.25), 2.0, true)
		var am := (a0 + a1) / 2.0
		_label(c + Vector2(cos(am), sin(am)) * ROUE_R * 0.66, items[i], 17, INK)
	draw_circle(c, 16.0, classe_color.darkened(0.2))
	# sens de lecture : fleche courbe autour de la roue (sens des aiguilles d'une montre)
	# L'arc s'arrete dans la pointe, qui suit la tangente de l'arc a son bout (comme pour la Terre)
	var a_fin := -PI / 2.0 + 0.5
	draw_arc(c, ROUE_R + 12.0, -PI / 2.0 - 0.5, a_fin - 0.06, 16, INK, 3.0, true)
	var e := c + Vector2(cos(a_fin), sin(a_fin)) * (ROUE_R + 12.0)
	var tangente := Vector2(-sin(a_fin), cos(a_fin))
	_fleche(e - tangente * 12.0, e + tangente * 4.0, INK, 3.0, 12.0)

# -------- plan de la classe (vu de dessus)

func _draw_plan() -> void:
	var r := Rect2(Vector2((size.x - 520.0) / 2.0, 10.0), Vector2(520.0, 300.0))
	draw_rect(r, Color("FFF8EC"))
	draw_rect(r, INK, false, 6.0)
	# fenetres sur le mur de gauche
	for fy: float in [70.0, 170.0]:
		draw_line(r.position + Vector2(0, fy), r.position + Vector2(0, fy + 60.0), Color("6EC6F0"), 8.0)
	_label(r.position + Vector2(-46, 136), "fenêtres", 15, MER_TEXTE)
	# porte sur le mur de droite, en bas (ouverture + battant + arc)
	var hinge := r.end - Vector2(0, 16)
	draw_line(hinge, hinge - Vector2(0, 62), Color("FFF8EC"), 8.0)
	draw_line(hinge, hinge - Vector2(58, 0), Color("8D5524"), 4.0)
	draw_arc(hinge, 58.0, PI, PI * 1.5, 16, Color("8D5524"), 1.5, true)
	_label(hinge + Vector2(34, -30), "porte", 15, Color("8D5524"))
	# tableau en haut
	var tb := Rect2(r.position + Vector2(170, 8), Vector2(180, 16))
	draw_rect(tb, Color("2E7D32"))
	_label(tb.get_center() + Vector2(0, 26), "tableau", 16, Color("2E7D32"))
	# bureau de la maitresse / du maitre
	var bu := Rect2(r.position + Vector2(40, 40), Vector2(80, 40))
	draw_rect(bu, Color("BCAAA4"))
	draw_rect(bu, Color("6D4C41"), false, 2.0)
	_label(bu.get_center(), "bureau", 14, INK)
	# tables des eleves : 3 rangees de 3 tables doubles, chaises (ronds) cote tableau oppose
	var fill := classe_color.lerp(Color.WHITE, 0.55)
	for row: int in 3:
		for col: int in 3:
			var t := Rect2(r.position + Vector2(130 + col * 120, 112 + row * 62), Vector2(90, 30))
			draw_rect(t, fill)
			draw_rect(t, classe_color.darkened(0.3), false, 2.0)
			for k: int in 2:
				draw_circle(t.position + Vector2(24 + k * 42, 42), 7.0, UNITES)
	_label(r.position + Vector2(r.size.x / 2.0 + 10.0, r.size.y + 26.0), "tables des élèves (les ronds sont les chaises)", 15, INK)

# -------- arbre genealogique (3 generations)

func _boite(c: Vector2, text: String, w: float, fill: Color, line: Color, fs: int = 18) -> void:
	var r := Rect2(c - Vector2(w / 2.0, 22.0), Vector2(w, 44.0))
	draw_rect(r, fill)
	draw_rect(r, line, false, 2.5)
	_label(c, text, fs, INK)

func _draw_arbre() -> void:
	var line := classe_color.darkened(0.3)
	var fill := classe_color.lerp(Color.WHITE, 0.65)
	var alt := UNITES.lerp(Color.WHITE, 0.6)
	var cx := size.x / 2.0
	var y1 := 30.0
	var y2 := 125.0
	var y3 := 220.0
	var gx := [cx - 255.0, cx - 115.0, cx + 115.0, cx + 255.0]
	var px := [cx - 185.0, cx + 185.0]
	# traits : couple -> enfant
	for i: int in 2:
		var mid: float = (gx[i * 2] + gx[i * 2 + 1]) / 2.0
		draw_line(Vector2(gx[i * 2], y1), Vector2(gx[i * 2 + 1], y1), line, 3.0)
		draw_line(Vector2(mid, y1), Vector2(mid, y1 + 40.0), line, 3.0)
		draw_line(Vector2(mid, y1 + 40.0), Vector2(px[i], y1 + 40.0), line, 3.0)
		draw_line(Vector2(px[i], y1 + 40.0), Vector2(px[i], y2), line, 3.0)
	draw_line(Vector2(px[0], y2), Vector2(px[1], y2), line, 3.0)
	draw_line(Vector2(cx, y2), Vector2(cx, y3), line, 3.0)
	for i: int in 4:
		_boite(Vector2(gx[i], y1), "grand-père" if i % 2 == 0 else "grand-mère", 128.0, alt, line, 17)
	_boite(Vector2(px[0], y2), "papa", 128.0, fill, line)
	_boite(Vector2(px[1], y2), "maman", 128.0, fill, line)
	_boite(Vector2(cx, y3), "moi", 110.0, UNITES, line, 20)

# -------- CE1 (2026-11-06) : couches du planisphere, grandes periodes, relief, cours d'eau
#   [planisphere pale=oui zones=oui fleuves=oui montagnes=oui villes=oui forets=oui deserts=oui]
#   [periodes marque=3]   [relief]   [cours_eau]

## [nom, points (lon, lat), position du nom]
const PLANI_FLEUVES := [
	["Amazone", [-76, -5, -73.2, -3.7, -70, -4.2, -65, -3.3, -60, -3.1, -55, -2.2, -51, -1, -49.5, 0], Vector2(-60, 3.5)],
	["Nil", [33, -1, 32.6, 3.5, 31.6, 9.5, 32.5, 15.6, 33.9, 19, 31.5, 21, 32.9, 24.1, 31.2, 30, 31, 31.4], Vector2(24, 20)],
	["Mississippi", [-95.2, 47.2, -91, 44.5, -90.2, 38.6, -89.2, 36.8, -90, 35.1, -91.1, 32.3, -90.1, 30, -89.3, 29.2], Vector2(-80, 34)],
]
const PLANI_MONTAGNES := [
	["Rocheuses", [-125, 58, -116, 49, -110, 42, -106, 35], Vector2(-134, 44)],
	["Andes", [-77, 6, -78, -2, -72, -15, -69, -25, -71, -38, -73, -48], Vector2(-86, -24)],
	["Alpes", [6, 44.5, 8, 46, 12, 47, 15, 47.3], Vector2(11, 52)],
	["Atlas", [-9, 30.5, -4, 32.5, 1, 34, 7, 35.5], Vector2(-10, 26)],
	["Himalaya", [74, 35, 80, 31, 86, 28, 95, 28], Vector2(85, 37)],
]
## [nom, position, nom a gauche du point]
const PLANI_VILLES := [
	["Paris", Vector2(2.35, 48.85), true],
	["Tokyo", Vector2(139.7, 35.7), false],
	["Lagos", Vector2(3.4, 6.5), true],
	["New York", Vector2(-74, 40.7), false],
	["São Paulo", Vector2(-46.6, -23.5), false],
	["Sydney", Vector2(151.2, -33.9), true],
]
## [nom, centre, demi-largeur, demi-hauteur (degres)]
const PLANI_FORETS := [
	["forêt amazonienne", Vector2(-62, -6), 11.0, 6.0],
	["forêt du Congo", Vector2(22, -1), 7.0, 4.5],
	["forêt d'Indonésie", Vector2(113, 0), 9.0, 3.0],
]
const PLANI_DESERTS := [
	["Sahara", Vector2(10, 23), 20.0, 6.0],
]
## Les 3 grands foyers de peuplement du monde (programme CE1)
const PLANI_FOYERS := [
	["Asie de l'Est", Vector2(115, 32), 12.0, 8.0],
	["Asie du Sud", Vector2(80, 22), 8.0, 7.0],
	["Europe", Vector2(12, 49), 12.0, 5.0],
]
const ZONE_FROIDE := Color("6FA8DC")
const ZONE_TEMPEREE := Color("7CC47F")
const ZONE_CHAUDE := Color("F2A541")

func _poly_geo(r: Rect2, flat: Array) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i: int in range(0, flat.size(), 2):
		pts.append(_geo(r, float(flat[i]), float(flat[i + 1])))
	return pts

func _on(key: String) -> bool:
	return str(params.get(key, "")) == "oui"

## Couches thematiques dessinees par-dessus les continents (CE1).
func _draw_plani_couches(r: Rect2, k: float) -> void:
	_draw_plani_cm(r, k)
	if _on("zones"):
		var bands := [[90.0, 66.5, ZONE_FROIDE, "zone froide"], [66.5, 23.5, ZONE_TEMPEREE, "zone tempérée"],
			[23.5, -23.5, ZONE_CHAUDE, "zone chaude"], [-23.5, -66.5, ZONE_TEMPEREE, "zone tempérée"],
			[-66.5, -90.0, ZONE_FROIDE, "zone froide"]]
		for b: Array in bands:
			var top := _geo(r, -180, minf(b[0], PLANI_LAT_N)).y
			var bot := _geo(r, -180, maxf(b[1], PLANI_LAT_S)).y
			var col: Color = b[2]
			draw_rect(Rect2(r.position.x, top, r.size.x, bot - top), Color(col, 0.42))
			if b[1] > -90.0 and b[1] > PLANI_LAT_S:
				_tirets(Vector2(r.position.x, bot), Vector2(r.end.x, bot), col.darkened(0.35))
			_label_gauche(Vector2(r.position.x + 6.0, (top + bot) / 2.0), b[3], int(round(15.0 * k)), col.darkened(0.55))
	if _on("foyers"):
		for f: Array in PLANI_FOYERS:
			_nuage_points(r, f[1], f[2], f[3], Color("C62828"), 4.5 * k)
			_label(_geo(r, f[1].x, f[1].y - f[3] - 4.5), f[0], int(round(15.0 * k)), Color("B71C1C"), Color(1, 1, 1, 0.9))
	if _on("forets"):
		for f: Array in PLANI_FORETS:
			_nuage_points(r, f[1], f[2], f[3], Color("2E7D32"), 5.0 * k)
			_label(_geo(r, f[1].x, f[1].y - f[3] - 4.0), f[0], int(round(15.0 * k)), Color("1B5E20"), Color(1, 1, 1, 0.9))
	if _on("deserts"):
		for d: Array in PLANI_DESERTS:
			_nuage_points(r, d[1], d[2], d[3], Color("C7922F"), 3.5 * k)
			_label(_geo(r, d[1].x, d[1].y), d[0], int(round(17.0 * k)), Color("6D4C1F"), Color(1, 1, 1, 0.9))
	if _on("fleuves"):
		for f: Array in PLANI_FLEUVES:
			draw_polyline(_poly_geo(r, f[1]), Color("1565C0"), 3.5 * k, true)
			_label(_geo(r, f[2].x, f[2].y), f[0], int(round(16.0 * k)), Color("0D47A1"), Color(1, 1, 1, 0.9))
	if _on("montagnes"):
		for m: Array in PLANI_MONTAGNES:
			var pts := _poly_geo(r, m[1])
			for i: int in pts.size() - 1:
				var n := maxi(1, int(pts[i].distance_to(pts[i + 1]) / (11.0 * k)))
				for j: int in n:
					_sommet(pts[i].lerp(pts[i + 1], (j + 0.5) / n), 7.0 * k)
			_label(_geo(r, m[2].x, m[2].y), m[0], int(round(16.0 * k)), Color("4E342E"), Color(1, 1, 1, 0.9))
	if _on("villes"):
		for v: Array in PLANI_VILLES:
			var p := _geo(r, v[1].x, v[1].y)
			draw_circle(p, 5.5 * k, Color("C62828"))
			draw_arc(p, 5.5 * k, 0.0, TAU, 16, Color.WHITE, 1.5, true)
			var fs := int(round(16.0 * k))
			var w := _font().get_string_size(v[0], HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
			var dx := -(w / 2.0 + 10.0 * k) if v[2] else (w / 2.0 + 10.0 * k)
			_label(p + Vector2(dx, 0), v[0], fs, Color("B71C1C"), Color(1, 1, 1, 0.9))

func _sommet(c: Vector2, s: float) -> void:
	draw_colored_polygon(PackedVector2Array([c + Vector2(0, -s), c + Vector2(s * 0.9, s * 0.6), c + Vector2(-s * 0.9, s * 0.6)]), Color("8D6E63"))
	draw_colored_polygon(PackedVector2Array([c + Vector2(0, -s), c + Vector2(s * 0.3, -s * 0.35), c + Vector2(-s * 0.3, -s * 0.35)]), Color.WHITE)

## Points repartis regulierement dans une ellipse (foret, desert) - pas d'aleatoire : rendu stable.
func _nuage_points(r: Rect2, c: Vector2, rx: float, ry: float, col: Color, rad: float) -> void:
	var step := 2.6
	var y := -ry
	var row := 0
	while y <= ry:
		var x := -rx + (step / 2.0 if row % 2 == 1 else 0.0)
		while x <= rx:
			if (x * x) / (rx * rx) + (y * y) / (ry * ry) <= 1.0:
				draw_circle(_geo(r, c.x + x, c.y + y), rad * 0.5, col)
			x += step
		y += step * 0.8
		row += 1

func _tirets(a: Vector2, b: Vector2, col: Color) -> void:
	var d := a.distance_to(b)
	var n := int(d / 12.0)
	for i: int in n:
		if i % 2 == 0:
			draw_line(a.lerp(b, float(i) / n), a.lerp(b, float(i + 1) / n), col, 1.5)

func _label_gauche(left_mid: Vector2, text: String, fs: int, color: Color) -> void:
	var w := _font().get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
	_label(left_mid + Vector2(w / 2.0 + 2.0, 0), text, fs, color, Color(1, 1, 1, 0.85))

# -------- les 5 grandes periodes

const PERIODES := [
	["Préhistoire", Color("A1887F")], ["Antiquité", Color("F6C445")], ["Moyen Âge", Color("7CB342")],
	["Temps modernes", Color("4FA3E0")], ["Époque contemporaine", Color("E57373")],
]
const PERIODES_BORNES := ["premiers humains", "3000 av. J.-C.", "476", "1492", "1789", "aujourd'hui"]
const PERIODE_W := 150.0

func _draw_periodes() -> void:
	var marque := int(params.get("marque", 0))
	var x0 := (size.x - PERIODE_W * 5.0) / 2.0
	var y := 14.0
	var h := 70.0
	for i: int in 5:
		var col: Color = PERIODES[i][1]
		if marque > 0 and i + 1 != marque:
			col = col.lerp(Color("EFEAE0"), 0.7)
		var rect := Rect2(Vector2(x0 + i * PERIODE_W, y), Vector2(PERIODE_W, h))
		draw_rect(rect, col)
		draw_rect(rect, INK, false, 2.0)
		var nom: String = PERIODES[i][0]
		var parts := nom.split(" ", false, 1)
		if parts.size() == 2 and _font().get_string_size(nom, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x > PERIODE_W - 12.0:
			_label(rect.get_center() - Vector2(0, 11), parts[0], 18, INK)
			_label(rect.get_center() + Vector2(0, 11), parts[1], 18, INK)
		else:
			_label(rect.get_center(), nom, 18, INK)
	_fleche(Vector2(x0 + PERIODE_W * 5.0, y + h / 2.0), Vector2(x0 + PERIODE_W * 5.0 + 34.0, y + h / 2.0), INK, 4.0, 14.0)
	for i: int in 6:
		var bx := x0 + i * PERIODE_W
		draw_line(Vector2(bx, y + h), Vector2(bx, y + h + 10.0), INK, 2.0)
		var b: String = PERIODES_BORNES[i]
		var bp := b.split(" ", false, 1)
		if i == 0 or i == 5:
			_label(Vector2(bx, y + h + 24.0), bp[0], 15, INK)
			if bp.size() > 1:
				_label(Vector2(bx, y + h + 42.0), bp[1], 15, INK)
		else:
			_label(Vector2(bx, y + h + 26.0), b, 18, Color("B71C1C"))

# -------- relief (vu de cote)

func _draw_relief() -> void:
	var w := 680.0
	var x0 := (size.x - w) / 2.0
	var base := 230.0
	var sol := Color("8BC34A")
	var roche := Color("A1887F")
	draw_rect(Rect2(Vector2(x0, 20), Vector2(w, base - 20)), Color("E3F2FD"))
	var p := PackedVector2Array([
		Vector2(x0, base), Vector2(x0, 186), Vector2(x0 + 170, 186),           # plaine
		Vector2(x0 + 250, 60), Vector2(x0 + 290, 120), Vector2(x0 + 318, 182),   # montagne 1 puis vallee
		Vector2(x0 + 362, 182), Vector2(x0 + 395, 112), Vector2(x0 + 440, 46),   # montagne 2
		Vector2(x0 + 490, 120), Vector2(x0 + 520, 96), Vector2(x0 + 660, 96),    # plateau
		Vector2(x0 + w, 150), Vector2(x0 + w, base)])
	draw_colored_polygon(p, sol)
	var line := p.duplicate()
	draw_polyline(line, Color("33691E"), 3.0, true)
	# neige des sommets
	for pk: Vector2 in [Vector2(x0 + 250, 60), Vector2(x0 + 440, 46)]:
		draw_colored_polygon(PackedVector2Array([pk, pk + Vector2(16, 20), pk + Vector2(-14, 20)]), Color.WHITE)
	draw_rect(Rect2(Vector2(x0 + 326, 178), Vector2(28, 6)), Color("1E88E5"))
	draw_line(Vector2(x0, base), Vector2(x0 + w, base), Color("5D4037"), 3.0)
	draw_rect(Rect2(Vector2(x0, base), Vector2(w, 10)), roche)
	var lab := Color("3E2723")
	_label(Vector2(x0 + 85, 160), "plaine", 19, lab, Color(1, 1, 1, 0.9))
	_label(Vector2(x0 + 250, 36), "montagne", 19, lab, Color(1, 1, 1, 0.9))
	_label(Vector2(x0 + 340, 212), "vallée", 19, lab, Color(1, 1, 1, 0.9))
	_label(Vector2(x0 + 590, 74), "plateau", 19, lab, Color(1, 1, 1, 0.9))
	_fleche(Vector2(x0 + 340, 200), Vector2(x0 + 340, 186), lab, 2.0, 8.0)

# -------- fleuve et riviere (vu de dessus)

func _draw_cours_eau() -> void:
	var w := 680.0
	var x0 := (size.x - w) / 2.0
	draw_rect(Rect2(Vector2(x0, 10), Vector2(w, 230)), Color("EAF4D9"))
	var mer := Rect2(Vector2(x0 + w - 110, 10), Vector2(110, 230))
	draw_rect(mer, MER)
	_label(mer.get_center(), "la mer", 19, MER_TEXTE)
	for s: Vector2 in [Vector2(x0 + 40, 70), Vector2(x0 + 62, 64), Vector2(x0 + 52, 210), Vector2(x0 + 74, 204)]:
		_sommet(s, 14.0)
	var bleu := Color("1E88E5")
	var fleuve := PackedVector2Array([Vector2(x0 + 70, 86), Vector2(x0 + 170, 110), Vector2(x0 + 270, 98),
		Vector2(x0 + 380, 128), Vector2(x0 + 480, 120), Vector2(x0 + w - 110, 132)])
	draw_polyline(fleuve, bleu, 8.0, true)
	var riviere := PackedVector2Array([Vector2(x0 + 80, 196), Vector2(x0 + 180, 186), Vector2(x0 + 270, 170), Vector2(x0 + 380, 128)])
	draw_polyline(riviere, bleu, 4.0, true)
	var lab := Color("0D47A1")
	_label(Vector2(x0 + 70, 40), "source", 17, INK)
	_fleche(Vector2(x0 + 70, 50), Vector2(x0 + 70, 80), INK, 2.0, 8.0)
	_label(Vector2(x0 + 220, 78), "le fleuve", 20, lab, Color(1, 1, 1, 0.9))
	_label(Vector2(x0 + 230, 205), "la rivière", 20, lab, Color(1, 1, 1, 0.9))
	_label(Vector2(x0 + w - 150, 165), "embouchure", 17, INK, Color(1, 1, 1, 0.9))
	_fleche(Vector2(x0 + w - 150, 152), Vector2(x0 + w - 116, 136), INK, 2.0, 8.0)

# -------- paysage : premier plan / arriere-plan

func _draw_paysage() -> void:
	var w := 520.0
	var x0 := (size.x - w - 250.0) / 2.0
	var r := Rect2(Vector2(x0, 8), Vector2(w, 250))
	draw_rect(r, Color("DCEFFB"))
	# arriere-plan : montagnes lointaines, petites et pales
	draw_colored_polygon(PackedVector2Array([Vector2(x0, 130), Vector2(x0 + 90, 60), Vector2(x0 + 170, 120),
		Vector2(x0 + 260, 50), Vector2(x0 + 360, 125), Vector2(x0 + 440, 70), Vector2(x0 + w, 120), Vector2(x0 + w, 140), Vector2(x0, 140)]), Color("A9B8C9"))
	for i: int in 6:
		_sommet(Vector2(x0 + 270 + i * 18, 128), 6.0)
	# premier plan : champ, grand arbre, fleurs
	draw_colored_polygon(PackedVector2Array([Vector2(x0, 140), Vector2(x0 + w, 132), Vector2(x0 + w, r.end.y), Vector2(x0, r.end.y)]), Color("8BC34A"))
	draw_rect(Rect2(Vector2(x0 + 70, 160), Vector2(20, 80)), Color("6D4C41"))
	draw_circle(Vector2(x0 + 80, 150), 46.0, Color("388E3C"))
	for i: int in 7:
		draw_circle(Vector2(x0 + 180 + i * 40, 222 + (i % 2) * 14), 7.0, Color("F06292") if i % 2 == 0 else Color("FFD54F"))
	draw_rect(r, INK, false, 2.0)
	_label_gauche(Vector2(x0 + w + 14, 90), "← arrière-plan : au fond", 18, Color("37474F"))
	_label_gauche(Vector2(x0 + w + 14, 210), "← premier plan : devant", 18, Color("1B5E20"))

# -------- CE2 (2026-11-07) : cartes de France et de l'empire romain
#   [carte vue=france densites=oui villes=oui]        -> fortes / faibles densites + 5 agglomerations
#   [carte vue=france massifs=oui fleuves=oui]         -> massifs de montagne et grands fleuves
#   [carte vue=france domaines=987,1223,1483]          -> petites cartes cote a cote : domaine du roi
#   [carte vue=france alesia=oui]                      -> point d'Alesia
#   [carte vue=empire empire=oui gaule=oui]            -> empire romain a son apogee, Rome, la Gaule
#   largeur=<px> : largeur d'une carte (420 par defaut, la hauteur suit la vue)
# CM1-CM2 (2026-11-07) :
#   [carte vue=europe fondateurs=oui noms=oui]          -> Union europeenne, 6 pays fondateurs plus fonces
#   [carte vue=france regions=oui]                      -> les 13 Regions de metropole et leur capitale
#   [carte vue=france tgv=oui villes=oui]               -> lignes a grande vitesse
#   [carte vue=france fleuves=oui lacs=oui]             -> 3 lacs (naturels et artificiel)
#   [carte vue=france front=oui]                        -> ligne de front 1914-1918, Verdun, la Somme
#   [carte vue=france occupation=oui]                   -> zone occupee / zone libre (1940), debarquement

const CarteData := preload("res://ui/fiche/carte_data.gd")
const CARTE_TERRE := Color("EFE8DA")
const CARTE_FRANCE := Color("FFF1C9")
const CARTE_DENSE := Color("E0603F")
const CARTE_MASSIF := Color("A1795A")
const CARTE_FLEUVE := Color("1E6FD0")
const CARTE_DOMAINE := Color("3F64C8")
const CARTE_EMPIRE := Color("E39A63")
const CARTE_GAP := 26.0
const CARTE_UE := Color("9CC2EE")
const REGION_COULEURS := [Color("F8BBD0"), Color("C5E1A5"), Color("FFE082"), Color("B3E5FC"), Color("D1C4E9"),
	Color("FFCCBC"), Color("B2DFDB"), Color("F0F4C3")]

## Points rouges et leur nom : [nom, lon, lat, nom a gauche du point]
func _carte_points(r: Rect2, k: float, liste: Array) -> void:
	for v: Array in liste:
		var p := _cgeo(r, v[1], v[2])
		draw_circle(p, 5.0 * k, Color("7A1010"))
		draw_arc(p, 5.0 * k, 0.0, TAU, 16, Color.WHITE, 1.6, true)
		var fs := int(round(15.0 * k))
		var w := _font().get_string_size(v[0], HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
		var dx := -(w / 2.0 + 9.0 * k) if v[3] else (w / 2.0 + 9.0 * k)
		_label(p + Vector2(dx, 0), v[0], fs, Color("7A1010"), Color(1, 1, 1, 0.9))

func _carte_vue() -> Array:
	return CarteData.VUES.get(str(params.get("vue", "france")), CarteData.VUES["france"])

func _carte_size() -> Vector2:
	var v := _carte_vue()
	var w := float(params.get("largeur", 420))
	var kx := cos(deg_to_rad((v[1] + v[3]) / 2.0))
	return Vector2(w, w * (v[3] - v[1]) / ((v[2] - v[0]) * kx))

func _carte_domaines() -> PackedStringArray:
	return str(params.get("domaines", "")).split(",", false)

func _carte_min_size() -> Vector2:
	var cs := _carte_size()
	var n := _carte_domaines().size()
	if n > 0:
		return Vector2(n * (cs.x + CARTE_GAP) - CARTE_GAP, cs.y + 40.0)
	return cs + Vector2(0, 6)

func _cgeo(r: Rect2, lon: float, lat: float) -> Vector2:
	var v := _carte_vue()
	return r.position + Vector2((lon - v[0]) / (v[2] - v[0]) * r.size.x, (v[3] - lat) / (v[3] - v[1]) * r.size.y)

func _cpoly(r: Rect2, flat: Array) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i: int in range(0, flat.size(), 2):
		pts.append(_cgeo(r, float(flat[i]), float(flat[i + 1])))
	return pts

func _cfill(r: Rect2, rings: Array, fill: Color, border: Color = Color.TRANSPARENT, bw: float = 1.2) -> void:
	for ring: Array in rings:
		var pts := _cpoly(r, ring)
		if pts.size() < 3:
			continue
		draw_colored_polygon(pts, fill)
		if border.a > 0.0:
			pts.append(pts[0])
			draw_polyline(pts, border, bw, true)

func _draw_carte() -> void:
	var cs := _carte_size()
	var doms := _carte_domaines()
	if doms.size() > 0:
		var x := (size.x - (doms.size() * (cs.x + CARTE_GAP) - CARTE_GAP)) / 2.0
		for d: String in doms:
			var r := Rect2(Vector2(x, 2.0), cs)
			_carte_fond(r)
			_cfill(r, CarteData.DOMAINES.get(d, []), CARTE_DOMAINE)
			var p := _cgeo(r, 2.35, 48.86)
			draw_circle(p, 3.5, Color.WHITE)
			draw_rect(r, INK, false, 2.0)
			_label(Vector2(r.get_center().x, r.end.y + 20.0), "en " + d, 20, Color("B71C1C"))
			x += cs.x + CARTE_GAP
		return
	var r := Rect2(Vector2((size.x - cs.x) / 2.0, 2.0), cs)
	var k := cs.x / 420.0
	_carte_fond(r)
	if str(params.get("vue", "france")) == "europe":
		_cfill(r, CarteData.UE, CARTE_UE, Color.WHITE, 0.8)
		if _on("fondateurs"):
			_cfill(r, CarteData.FONDATEURS, CARTE_DOMAINE, Color.WHITE, 0.8)
		if _on("noms"):
			for n: Array in CarteData.PAYS_NOMS:
				_label(_cgeo(r, n[1], n[2]), n[0], int(round(15.0 * k)), Color("0D2A6B") if n[3] else INK, Color(1, 1, 1, 0.92))
		draw_rect(r, INK, false, 2.0)
		return
	if _on("regions"):
		for i: int in CarteData.REGIONS.size():
			_cfill(r, CarteData.REGIONS[i], REGION_COULEURS[i % REGION_COULEURS.size()], Color.WHITE, 1.5)
		for ring: Array in CarteData.FRANCE:
			var pts := _cpoly(r, ring)
			pts.append(pts[0])
			draw_polyline(pts, INK, 1.6, true)
		_carte_points(r, k, CarteData.CAPITALES)
	if _on("occupation"):
		_cfill(r, CarteData.ZONE_OCCUPEE, Color("9E9E9E"))
		var lig := _cpoly(r, CarteData.LIGNE_DEMARCATION)
		draw_polyline(lig, Color("B71C1C"), 3.0 * k, true)
		_label(_cgeo(r, 2.4, 48.0), "zone occupée", int(round(17.0 * k)), Color.WHITE, Color(0.2, 0.2, 0.2, 0.9))
		_label(_cgeo(r, 3.6, 45.0), "zone libre", int(round(17.0 * k)), INK, Color(1, 1, 1, 0.9))
		_carte_points(r, k, [["Paris", 2.35, 48.86, false], ["Vichy", 3.43, 46.13, true]])
		var d := _cgeo(r, -0.6, 49.35)
		_fleche(d + Vector2(-34.0, -40.0) * k, d, Color("1565C0"), 4.0 * k, 14.0 * k)
		_label(d + Vector2(-60.0, -54.0) * k, "débarquement", int(round(15.0 * k)), Color("0D47A1"), Color(1, 1, 1, 0.9))
	if _on("front"):
		draw_polyline(_cpoly(r, CarteData.FRONT_1418), Color("B71C1C"), 5.0 * k, true)
		_carte_points(r, k, [["Paris", 2.35, 48.86, true], ["Verdun", 5.38, 49.16, false]])
		_label(_cgeo(r, 1.4, 50.05), "la Somme", int(round(16.0 * k)), Color("B71C1C"), Color(1, 1, 1, 0.9))
		_label(_cgeo(r, 6.4, 50.5), "front", int(round(17.0 * k)), Color("B71C1C"), Color(1, 1, 1, 0.9))
	if _on("tgv"):
		for l: Array in CarteData.TGV:
			draw_polyline(_cpoly(r, l), Color("6A1B9A"), 3.5 * k, true)
	if str(params.get("vue", "france")) == "empire":
		_cfill(r, CarteData.EMPIRE, CARTE_EMPIRE, CARTE_EMPIRE.darkened(0.3))
		if _on("gaule"):
			for ring: Array in CarteData.GAULE:
				var pts := _cpoly(r, ring)
				pts.append(pts[0])
				for i: int in pts.size() - 1:
					_tirets_carte(pts[i], pts[i + 1], Color("5D2E0C"))
			_label(_cgeo(r, 2.0, 47.0), "la Gaule", int(round(17.0 * k)), Color("5D2E0C"), Color(1, 1, 1, 0.9))
		var rome := _cgeo(r, 12.5, 41.9)
		draw_circle(rome, 5.5 * k, Color("B71C1C"))
		draw_arc(rome, 5.5 * k, 0.0, TAU, 16, Color.WHITE, 1.5, true)
		_label(rome + Vector2(26.0 * k, -12.0 * k), "Rome", int(round(17.0 * k)), Color("B71C1C"), Color(1, 1, 1, 0.9))
		_label(_cgeo(r, 18.5, 34.3), "mer Méditerranée", int(round(15.0 * k)), MER_TEXTE)
		draw_rect(r, INK, false, 2.0)
		return
	if _on("densites"):
		for rings: Array in CarteData.DENSES:
			_cfill(r, rings, CARTE_DENSE)
	if _on("massifs"):
		for m: Array in CarteData.MASSIFS:
			_cfill(r, m[1], Color(CARTE_MASSIF, 0.75))
		for m: Array in CarteData.MASSIFS:
			_label(_cgeo(r, m[2][0], m[2][1]), m[0], int(round(15.0 * k)), Color("3E2723"), Color(1, 1, 1, 0.9))
	if _on("fleuves"):
		for f: Array in CarteData.FLEUVES:
			draw_polyline(_cpoly(r, f[1]), CARTE_FLEUVE, 3.0 * k, true)
		for f: Array in CarteData.FLEUVES:
			_label(_cgeo(r, f[2][0], f[2][1]), f[0], int(round(16.0 * k)), Color("0D47A1"), Color(1, 1, 1, 0.9))
	if _on("villes"):
		for v: Array in CarteData.VILLES:
			var p := _cgeo(r, v[1], v[2])
			draw_circle(p, 6.0 * k, Color("7A1010"))
			draw_arc(p, 6.0 * k, 0.0, TAU, 16, Color.WHITE, 1.8, true)
			var fs := int(round(17.0 * k))
			var w := _font().get_string_size(v[0], HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
			var dx := -(w / 2.0 + 10.0 * k) if v[3] else (w / 2.0 + 10.0 * k)
			_label(p + Vector2(dx, 0), v[0], fs, Color("7A1010"), Color(1, 1, 1, 0.9))
	if _on("lacs"):
		for l: Array in CarteData.LACS:
			var p := _cgeo(r, l[1], l[2])
			draw_circle(p, 6.0 * k, Color("1E88E5"))
			var fs := int(round(14.0 * k))
			var w := _font().get_string_size(l[0], HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
			_label(p + Vector2(-(w / 2.0 + 9.0 * k) if l[3] else (w / 2.0 + 9.0 * k), 0), l[0], fs, Color("0D47A1"), Color(1, 1, 1, 0.9))
	if _on("alesia"):
		var a := _cgeo(r, 4.5, 47.54)
		draw_circle(a, 6.0 * k, Color("B71C1C"))
		draw_arc(a, 6.0 * k, 0.0, TAU, 16, Color.WHITE, 1.8, true)
		_label(a + Vector2(36.0 * k, 0), "Alésia", int(round(17.0 * k)), Color("B71C1C"), Color(1, 1, 1, 0.9))
	draw_rect(r, INK, false, 2.0)

## Mer, terres voisines (pales) puis la France (vue france) ou les terres (vue empire).
func _carte_fond(r: Rect2) -> void:
	draw_rect(r, MER)
	if str(params.get("vue", "france")) == "empire":
		_cfill(r, CarteData.TERRE_EMPIRE, CARTE_TERRE, INK.lerp(MER, 0.5), 1.0)
		return
	if str(params.get("vue", "france")) == "europe":
		_cfill(r, CarteData.TERRE_EUROPE, CARTE_TERRE, INK.lerp(MER, 0.5), 1.0)
		return
	_cfill(r, CarteData.TERRE_FRANCE, CARTE_TERRE, INK.lerp(MER, 0.5), 1.0)
	_cfill(r, CarteData.FRANCE, CARTE_FRANCE, INK, 1.6)

func _carte_legende(r: Rect2, k: float, items: Array) -> void:
	var fs := int(round(14.0 * k))
	var y := _cgeo(r, -5.2, 43.6).y
	var x := r.position.x + 8.0 * k
	for it: Array in items:
		var sq := Rect2(Vector2(x, y - 8.0 * k), Vector2(16.0, 16.0) * k)
		draw_rect(sq, it[0])
		draw_rect(sq, INK, false, 1.0)
		_label_gauche(Vector2(x + 20.0 * k, y), it[1], fs, INK)
		y += 22.0 * k

func _tirets_carte(a: Vector2, b: Vector2, col: Color) -> void:
	var d := a.distance_to(b)
	var n := maxi(1, int(d / 6.0))
	for i: int in n:
		if i % 2 == 0:
			draw_line(a.lerp(b, float(i) / n), a.lerp(b, float(i + 1) / n), col, 2.0)

# -------- CE2 (2026-11-07) : [quartiers] du centre-ville vers la campagne (vu de dessus, schema)

func _ellipse(c: Vector2, rx: float, ry: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i: int in 48:
		var a := TAU * i / 48.0
		pts.append(c + Vector2(cos(a) * rx, sin(a) * ry))
	return pts

func _draw_quartiers() -> void:
	var c := Vector2(size.x / 2.0 - 120.0, 134.0)
	draw_rect(Rect2(Vector2(c.x - 240.0, 6.0), Vector2(480.0, 256.0)), Color("C5E1A5"))
	var anneaux := [[226.0, 118.0, Color("F3E5AB"), "lotissements pavillonnaires"],
		[160.0, 84.0, Color("FFCC80"), "grands ensembles et quartiers récents"],
		[78.0, 42.0, Color("E57373"), "centre-ville historique"]]
	for a: Array in anneaux:
		var pts := _ellipse(c, a[0], a[1])
		draw_colored_polygon(pts, a[2])
		pts.append(pts[0])
		draw_polyline(pts, INK, 1.5, true)
	draw_rect(Rect2(Vector2(c.x - 240.0, 6.0), Vector2(480.0, 256.0)), INK, false, 2.0)
	# villages dans la campagne
	for v: Vector2 in [Vector2(-222, -104), Vector2(214, 104), Vector2(-216, 100)]:
		draw_circle(c + v, 9.0, Color("8D6E63"))
	var lx := c.x + 270.0
	var ys := [56.0, 104.0, 152.0, 200.0]
	var cibles := [c + Vector2(0, -8), c + Vector2(118, -30), c + Vector2(198, -30), c + Vector2(214, 104)]
	var noms := ["centre-ville historique", "grands ensembles,", "lotissements", "campagne et villages"]
	var noms2 := ["", "quartiers récents", "pavillonnaires", ""]
	var cols := [Color("E57373"), Color("FFCC80"), Color("F3E5AB"), Color("C5E1A5")]
	for i: int in 4:
		var y: float = ys[i]
		draw_rect(Rect2(Vector2(lx, y - 9.0), Vector2(18, 18)), cols[i])
		draw_rect(Rect2(Vector2(lx, y - 9.0), Vector2(18, 18)), INK, false, 1.0)
		if noms2[i] == "":
			_label_gauche(Vector2(lx + 26.0, y), noms[i], 18, INK)
		else:
			_label_gauche(Vector2(lx + 26.0, y - 10.0), noms[i], 18, INK)
			_label_gauche(Vector2(lx + 26.0, y + 11.0), noms2[i], 18, INK)
	_label(c, "centre", 17, Color.WHITE)

# -------- CM1-CM2 (2026-11-07) : couches du planisphere
#   [planisphere aires=oui]        -> noms des grandes aires regionales (inegalites)
#   [planisphere cables=oui]       -> principaux cables sous-marins d'Internet
#   [planisphere voyages=oui]      -> voyages de Christophe Colomb (1492) et de Magellan (1519-1522)
#   [planisphere empires=oui]      -> premiers empires coloniaux en Amerique (XVIe-XVIIe siecles)
#   [planisphere triangulaire=oui] -> commerce triangulaire
#   [planisphere colonies=oui]     -> empire colonial francais vers 1914
#   cadre=lon0,lat0,lon1,lat1      -> ne montre qu'une partie du monde (zoom)

## Zones : [nom, centre (lon, lat), demi-largeur, demi-hauteur (degres), couleur, position du nom]
const PLANI_ZONES := {
	"empires": [
		["empire espagnol", Vector2(-95, 22), 13.0, 8.0, Color("E53935"), Vector2(-100, 10)],
		["", Vector2(-72, -14), 6.0, 16.0, Color("E53935"), Vector2.ZERO],
		["empire portugais", Vector2(-48, -10), 9.0, 11.0, Color("43A047"), Vector2(-40, -25)],
		["Nouvelle-France", Vector2(-75, 49), 11.0, 5.0, Color("1E88E5"), Vector2(-88, 58)],
		["colonies anglaises", Vector2(-77, 38), 3.5, 5.0, Color("8E24AA"), Vector2(-56, 37)],
	],
	"colonies": [
		["", Vector2(3, 32), 10.0, 4.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(-4, 16), 13.0, 7.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(16, 3), 5.0, 9.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(47, -19), 2.5, 6.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(106, 15), 3.0, 7.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(-53, 4), 2.0, 2.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(-61, 15.5), 1.6, 1.6, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(165, -21), 2.0, 2.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(-149, -17), 2.0, 2.0, Color("1E5BD8"), Vector2.ZERO],
		["", Vector2(55.5, -21), 1.5, 1.5, Color("1E5BD8"), Vector2.ZERO],
	],
}
## Noms poses sur le planisphere : [nom, position]
const PLANI_NOMS := {
	"aires": [["Amérique du Nord", Vector2(-102, 46)], ["Amérique du Sud", Vector2(-60, -14)], ["Europe", Vector2(16, 53)],
		["Maghreb", Vector2(2, 30)], ["Afrique subsaharienne", Vector2(22, -3)], ["Asie de l'Est", Vector2(112, 38)],
		["Asie du Sud-Est", Vector2(110, 5)], ["Océanie", Vector2(134, -26)]],
	"colonies": [["Afrique du Nord", Vector2(3, 38)], ["Afrique-Occidentale", Vector2(-12, 7)],
		["Afrique-Équatoriale", Vector2(28, -6)], ["Madagascar", Vector2(60, -12)], ["Indochine", Vector2(120, 22)],
		["Guyane", Vector2(-50, -4)], ["Antilles", Vector2(-72, 22)], ["Nouvelle-Calédonie", Vector2(160, -32)]],
}
## Traces : [nom, points (lon, lat), position du nom, couleur, fleche au bout]
const PLANI_TRACES := {
	"voyages": [
		["Colomb 1492", [-6.9, 37.2, -15.5, 28, -40, 25, -74.5, 24.1], Vector2(-38, 33), Color("C62828"), true],
		["Magellan 1519-1522", [-6.35, 36.8, -17, 14, -35, -8, -43, -23, -58, -38, -70, -53, -90, -35, -140, -12, -180, 6],
			Vector2(-118, -30), Color("1565C0"), false],
		["", [180, 8, 145, 13, 125, 10, 127, -1, 110, -9, 80, -22, 20, -35, 0, -10, -17, 14, -6.35, 36.8], Vector2.ZERO,
			Color("1565C0"), true],
	],
	"triangulaire": [
		["tissus, armes, alcool", [-1.55, 47.2, -10, 30, 3, 6], Vector2(-20, 22), Color("6D4C41"), true],
		["esclaves", [3, 6, -30, 10, -61, 16], Vector2(-30, 4), Color("B71C1C"), true],
		["sucre, café, coton", [-61, 16, -40, 38, -1.55, 47.2], Vector2(-40, 46), Color("2E7D32"), true],
	],
	"cables": [
		["", [-74, 40, -40, 47, -5, 50], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-74, 40, -40, 40, -9, 38.7], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-122, 37, -180, 36], Vector2.ZERO, Color("6A1B9A"), false],
		["", [180, 36, 140, 35], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-122, 37, -160, 21, -180, 0], Vector2.ZERO, Color("6A1B9A"), false],
		["", [180, 0, 151, -34], Vector2.ZERO, Color("6A1B9A"), false],
		["", [5, 43, 32, 31.5, 43, 12, 73, 15, 80, 6, 103, 1.3, 121, 25, 140, 35], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-9, 38.7, -17, 14.7, 3, 6, 13, -9, 18, -34], Vector2.ZERO, Color("6A1B9A"), false],
		["", [43, 12, 40, -4, 32, -29], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-74, 40, -80, 25, -66, 18, -38, -4, -43, -23], Vector2.ZERO, Color("6A1B9A"), false],
		["", [-38, -4, 13, -9], Vector2.ZERO, Color("6A1B9A"), false],
		["", [103, 1.3, 115, -32], Vector2.ZERO, Color("6A1B9A"), false],
	],
}

func _draw_plani_cm(r: Rect2, k: float) -> void:
	for couche: String in PLANI_ZONES:
		if not _on(couche):
			continue
		for z: Array in PLANI_ZONES[couche]:
			var pts := PackedVector2Array()
			for i: int in 40:
				var a := TAU * i / 40.0
				pts.append(_geo(r, z[1].x + cos(a) * z[2], z[1].y + sin(a) * z[3]))
			for poly: PackedVector2Array in _clip_poly(pts, r):
				if poly.size() < 3:
					continue
				draw_colored_polygon(poly, Color(z[4], 0.55))
				poly.append(poly[0])
				draw_polyline(poly, z[4].darkened(0.3), 1.5, true)
	for couche: String in PLANI_TRACES:
		if not _on(couche):
			continue
		for t: Array in PLANI_TRACES[couche]:
			var pts := _poly_geo(r, t[1])
			for ligne: PackedVector2Array in _clip_ligne(pts, r):
				draw_polyline(ligne, t[3], (2.0 if couche == "cables" else 3.5) * k, true)
			if t[4] and r.has_point(pts[pts.size() - 1]):
				var n := pts.size()
				_fleche(pts[n - 1].lerp(pts[n - 2], 0.25), pts[n - 1], t[3], 3.5 * k, 14.0 * k)
	for couche: String in PLANI_ZONES:
		if _on(couche):
			for z: Array in PLANI_ZONES[couche]:
				if z[0] != "":
					_label_dans(r, _geo(r, z[5].x, z[5].y), z[0], int(maxf(14.0, round(15.0 * k))), z[4].darkened(0.45), Color(1, 1, 1, 0.9))
	for couche: String in PLANI_TRACES:
		if _on(couche):
			for t: Array in PLANI_TRACES[couche]:
				if t[0] != "":
					_label_dans(r, _geo(r, t[2].x, t[2].y), t[0], int(maxf(14.0, round(15.0 * k))), t[3].darkened(0.3), Color(1, 1, 1, 0.9))
	for couche: String in PLANI_NOMS:
		if _on(couche):
			for nm: Array in PLANI_NOMS[couche]:
				_label_dans(r, _geo(r, nm[1].x, nm[1].y), nm[0], int(maxf(15.0, round(16.0 * k))), INK, Color(1, 1, 1, 0.9))
