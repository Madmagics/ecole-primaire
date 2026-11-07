## Icone "aide" de l'ecran d'accueil (2026-09-06, retour utilisateur : "en bas a droite de lecran
## d intro et uniquement la on va placer l'icone help...") - vit UNIQUEMENT dans WelcomePanel
## (welcome_panel.tscn), jamais ailleurs dans le jeu : contrairement a DailyLimitBadge (bas-gauche,
## visible dans la salle de classe, voir ui/hud/daily_limit_badge.gd), ce bouton n'a besoin
## d'aucune logique de masquage conditionnelle - il disparait tout seul avec le reste de
## WelcomePanel des qu'un compte est connecte (WelcomePanel.hide(), voir welcome_panel.gd).
##
## Animation - 4e passe le 2026-11-07 (retour Steve : "on arrete sa rotation, j'aimerais a la place
## y ajouter une aura de couleur qui varie sur plusieurs tons pastels") : l'icone reste droite,
## alignee sur la rangee de boutons de l'intro. Derriere elle, un halo rond (degrade radial, enfant
## dessine SOUS le bouton grace a show_behind_parent) dont la teinte tourne en continu sur la roue
## des couleurs avec une saturation basse (= tons pastel) et qui "respire" doucement. Comme pour
## l'ancienne rotation, la teinte avance a vitesse CONSTANTE dans _process (pas de Tween ni
## d'easing), donc aucun a-coup ; seule la respiration utilise un sin(), volontairement lente.
class_name HelpButton
extends Button

## Duree d'un tour complet des couleurs, et d'une respiration du halo.
const HUE_PERIOD_SECONDS := 6.0
const BREATH_PERIOD_SECONDS := 2.4
## Taille du halo par rapport au bouton, saturation/valeur des tons pastel.
const AURA_SCALE := 1.5
const PASTEL_SATURATION := 0.5
const PASTEL_VALUE := 1.0

@export var overlay_path: NodePath

var _aura: TextureRect
var _hue := 0.0
var _time := 0.0

func _ready() -> void:
	pressed.connect(_on_pressed)
	rotation = 0.0
	_aura = _build_aura()
	add_child(_aura)
	resized.connect(_place_aura)
	_place_aura()

func _process(delta: float) -> void:
	_hue = fmod(_hue + delta / HUE_PERIOD_SECONDS, 1.0)
	_time = fmod(_time + delta, BREATH_PERIOD_SECONDS)
	var breath := 0.5 + 0.5 * sin(TAU * _time / BREATH_PERIOD_SECONDS)
	_aura.modulate = Color.from_hsv(_hue, PASTEL_SATURATION, PASTEL_VALUE, 0.8 + 0.2 * breath)
	_aura.scale = Vector2.ONE * (0.92 + 0.12 * breath)

func _build_aura() -> TextureRect:
	var gradient := Gradient.new()
	gradient.set_color(0, Color(1, 1, 1, 1))
	gradient.set_color(1, Color(1, 1, 1, 0))
	gradient.add_point(0.5, Color(1, 1, 1, 0.9))
	var tex := GradientTexture2D.new()
	tex.gradient = gradient
	tex.fill = GradientTexture2D.FILL_RADIAL
	tex.fill_from = Vector2(0.5, 0.5)
	tex.fill_to = Vector2(0.5, 0.0)
	tex.width = 128
	tex.height = 128
	var aura := TextureRect.new()
	aura.texture = tex
	aura.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	aura.stretch_mode = TextureRect.STRETCH_SCALE
	aura.mouse_filter = Control.MOUSE_FILTER_IGNORE
	aura.show_behind_parent = true
	return aura

## Halo centre sur le bouton, AURA_SCALE fois plus grand, pivot au centre pour la respiration.
func _place_aura() -> void:
	var s := size * AURA_SCALE
	_aura.size = s
	_aura.position = (size - s) / 2.0
	_aura.pivot_offset = s / 2.0

func _on_pressed() -> void:
	var overlay := get_node_or_null(overlay_path)
	if overlay and overlay.has_method("open"):
		overlay.open()
