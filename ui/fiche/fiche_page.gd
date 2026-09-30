## Construit UNE page de fiche de cours (2026-09-29) a partir de son texte, pour FichePanel.
## Le texte d'une fiche (contenu_cours.contenu dans Supabase) est du BBCode Godot, decoupe en
## pages par la balise [page] (voir FichePanel), plus quelques balises "maison" traitees ici :
##   [titre]...[/titre]                 -> titre de la page, couleur de la classe
##   [cadre]...[/cadre]                 -> encadre "a retenir"
##   [cadre=astuce]...[/cadre]          -> encadre "Astuce"
##   [billes ...] [file ...] [cubes ...] [cases ...] seules sur leur ligne -> FicheDessin
##   [table=N]...[/table] seul sur sa ligne -> tableau Godot natif, centre
## Tout le reste est du texte BBCode affiche dans un RichTextLabel.
## Jetons de couleur utilisables dans le BBCode (remplaces avant affichage, pour qu'une meme
## ecriture marche pour toutes les classes) : #classe, #classe_clair, #unites, #unites_clair.
class_name FichePage
extends RefCounted

const INK := Color("3b2a1e")
const UNITES := Color("F2A541")
const ASTUCE := Color("E08A1E")
const BODY_SIZE := 22
const TITLE_SIZE := 30

static var _block_regex: RegEx

## Couleur de texte lisible sur fond creme, derivee de la couleur de classe (le jaune CE2 est
## illisible tel quel).
static func title_color(classe: Color) -> Color:
	return classe.darkened(0.35)

static func light_color(classe: Color) -> Color:
	return classe.lerp(Color.WHITE, 0.82)

## Remplace les jetons de couleur par les vraies couleurs de la classe.
static func apply_color_tokens(text: String, classe: Color) -> String:
	return text \
		.replace("#classe_clair", "#" + light_color(classe).to_html(false)) \
		.replace("#classe", "#" + classe.to_html(false)) \
		.replace("#unites_clair", "#" + UNITES.lerp(Color.WHITE, 0.8).to_html(false)) \
		.replace("#unites", "#" + UNITES.to_html(false))

static func build(page_text: String, classe: Color, bold_font: Font) -> VBoxContainer:
	if _block_regex == null:
		_block_regex = RegEx.new()
		_block_regex.compile(
			"(?ms)\\[titre\\](.*?)\\[/titre\\]"
			+ "|\\[cadre(?:=(\\w+))?\\](.*?)\\[/cadre\\]"
			+ "|^[ \\t]*\\[(billes|file|cubes|cases)((?: [^\\]]*)?)\\][ \\t]*$"
			+ "|^[ \\t]*(\\[table=.*?\\[/table\\])[ \\t]*$")
	var text := apply_color_tokens(page_text, classe)
	var root := VBoxContainer.new()
	root.add_theme_constant_override("separation", 12)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var cursor := 0
	for m: RegExMatch in _block_regex.search_all(text):
		_add_text(root, text.substr(cursor, m.get_start() - cursor), bold_font)
		cursor = m.get_end()
		if m.get_start(1) >= 0:
			root.add_child(_title(m.get_string(1), classe, bold_font))
		elif m.get_start(3) >= 0:
			root.add_child(_cadre(m.get_string(3).strip_edges(), m.get_string(2), classe, bold_font))
		elif m.get_start(4) >= 0:
			var dessin := FicheDessin.new()
			dessin.setup(m.get_string(4), FicheDessin.parse_params(m.get_string(5)), classe)
			root.add_child(dessin)
		elif m.get_start(6) >= 0:
			root.add_child(_table(m.get_string(6), bold_font))
	_add_text(root, text.substr(cursor), bold_font)
	return root

static func _add_text(root: VBoxContainer, raw: String, bold_font: Font) -> void:
	var t := raw.strip_edges()
	if t != "":
		root.add_child(_rich(t, bold_font, true))

static func _rich(bbcode: String, bold_font: Font, word_wrap: bool) -> RichTextLabel:
	var label := RichTextLabel.new()
	label.bbcode_enabled = true
	label.fit_content = true
	label.scroll_active = false
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART if word_wrap else TextServer.AUTOWRAP_OFF
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_color_override("default_color", INK)
	label.add_theme_font_size_override("normal_font_size", BODY_SIZE)
	label.add_theme_font_size_override("bold_font_size", BODY_SIZE)
	label.add_theme_font_override("bold_font", bold_font)
	label.add_theme_constant_override("line_separation", 2)
	label.text = bbcode
	return label

## Tableau Godot natif, centre. Les bordures des cases du bord gauche et du haut etaient
## rognees (le RichTextLabel coupe ce qui depasse de son cadre, et ces traits sont poses pile
## sur le bord) : on laisse une marge de 2 px tout autour, sans ajouter de cadre (retour Steve
## 2026-09-29 : un cadre en plus faisait des doubles lignes).
static func _table(bbcode: String, bold_font: Font) -> RichTextLabel:
	var table := _rich(bbcode, bold_font, false)
	table.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var margin := StyleBoxEmpty.new()
	margin.set_content_margin_all(2)
	table.add_theme_stylebox_override("normal", margin)
	table.clip_contents = false
	return table

static func _title(text: String, classe: Color, bold_font: Font) -> Label:
	var label := Label.new()
	label.text = text.strip_edges()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_override("font", bold_font)
	label.add_theme_font_size_override("font_size", TITLE_SIZE)
	label.add_theme_color_override("font_color", title_color(classe))
	return label

static func _cadre(bbcode: String, variant: String, classe: Color, bold_font: Font) -> PanelContainer:
	var is_astuce := variant == "astuce"
	var accent := ASTUCE if is_astuce else classe
	var box := PanelContainer.new()
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color("FFF4D6") if is_astuce else light_color(classe)
	style.border_color = accent
	style.set_border_width_all(3)
	style.set_corner_radius_all(14)
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	box.add_theme_stylebox_override("panel", style)
	var body := bbcode
	if is_astuce:
		body = "[color=#%s][b]Astuce[/b][/color]\n%s" % [ASTUCE.darkened(0.2).to_html(false), bbcode]
	box.add_child(_rich(body, bold_font, true))
	return box
