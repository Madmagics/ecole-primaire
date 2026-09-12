## Icone "aide" de l'ecran d'accueil (2026-09-06, retour utilisateur : "en bas a droite de lecran
## d intro et uniquement la on va placer l'icone help...") - vit UNIQUEMENT dans WelcomePanel
## (welcome_panel.tscn), jamais ailleurs dans le jeu : contrairement a DailyLimitBadge (bas-gauche,
## visible dans la salle de classe, voir ui/hud/daily_limit_badge.gd), ce bouton n'a besoin
## d'aucune logique de masquage conditionnelle - il disparait tout seul avec le reste de
## WelcomePanel des qu'un compte est connecte (WelcomePanel.hide(), voir welcome_panel.gd).
##
## Animation - 3e passe le 2026-09-06 (retour utilisateur : "modifie le mouvement de l icone help,
## toujours pas fluide, on stoppe le zoom progressif, fait une rotation centrale complete de
## l icone sur elle meme qui se repete") : la pulsation de zoom (2 versions precedentes, la
## derniere deja une oscillation continue via sin() sur `scale`) est abandonnee au profit d'une
## rotation. Choix delibere de NE PAS utiliser Tween ni aucune easing curve (TRANS_SINE et
## consorts ralentissent puis accelerent, ce qui est justement la source des "pas fluide"
## precedents) : `rotation` est incremente lineairement a chaque frame dans `_process`, vitesse
## angulaire CONSTANTE du debut a la fin - aucune deceleration nulle part, donc aucun a-coup
## possible, contrairement a une sinusoide qui repasse par une vitesse nulle a chaque extremum.
## fmod() garde `rotation` dans [0, TAU) pour eviter une derive numerique sur une session longue
## (purement cosmetique, aucun effet visuel - une rotation modulo 2*PI est identique a elle-meme).
## pivot_offset deja fixe au centre du bouton dans le .tscn (herite des versions precedentes) :
## la rotation est donc bien centree sur l'icone, pas sur le coin haut-gauche.
class_name HelpButton
extends Button

const ROTATION_PERIOD_SECONDS := 4.0

@export var overlay_path: NodePath

func _ready() -> void:
	pressed.connect(_on_pressed)

func _process(delta: float) -> void:
	rotation = fmod(rotation + (TAU / ROTATION_PERIOD_SECONDS) * delta, TAU)

func _on_pressed() -> void:
	var overlay := get_node_or_null(overlay_path)
	if overlay and overlay.has_method("open"):
		overlay.open()
