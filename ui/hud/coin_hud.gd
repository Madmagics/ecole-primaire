## Affiche les soldes de pieces par CLASSE (CP a CM2) et se met a jour via le signal d'Economy.
## Ne connait rien d'autre que l'autoload Economy (+ GradeLevel pour l'affichage) : reutilisable
## sur n'importe quel ecran. Les labels sont crees au runtime (un par classe listee dans
## DISPLAYED_GRADES), pour qu'ajouter une nouvelle classe jouable plus tard n'implique pas de
## retoucher la scene.
##
## Devenu la "bande" de la section Récompenses (2026-08-29, retour utilisateur : "licone sac de
## piece devient la section Récompenses... on y ajoute une bande en haut avec les pieces gagnées") :
## cette scene existait deja mais n'etait instanciee nulle part avant ce jour - voir ShopPanel/
## shop_panel.tscn (RewardsBand) pour son premier vrai usage en jeu. A cette occasion, bascule de
## l'affichage par RARETE ("Commune"/"Peu commune"/...) a l'affichage par CLASSE ("CP"/"CE1"/...),
## meme retour utilisateur que le reste de la section Récompenses : Economy reste code par Rarity
## en interne (aucune migration de sauvegarde necessaire), seule la couche d'affichage change -
## chaque classe consulte son solde via Economy.get_balance(GradeLevel.get_rarity(grade)).
class_name CoinHUD
extends Control

## Icone "tas de pieces" affichee devant chaque solde : un fichier PAR CLASSE, deja colore
## (2026-08-30, retour utilisateur : "je les ai faites en webp avec leur couleur... les icones
## pour le total de piece du joueur sappellent tasdepiece") - remplace l'ancienne icone unique
## piece.webp coloree par modulate (2026-08-29). Voir GradeLevel.get_coin_pile_icon_path().
## Taille affichee de l'icone piece (2026-08-29) - voir le commentaire sur expand_mode dans _ready().
const ICON_SIZE := 48

## Classes affichees dans le HUD, dans l'ordre CP->CM2 (2026-08-29, remplace DISPLAYED_RARITIES -
## voir commentaire de classe). Toutes les 5 pour l'instant (pratique en dev/test pour suivre les
## soldes de la boutique complete) ; a reduire si besoin une fois le jeu presente a un vrai joueur
## (voir Economy.STARTING_BALANCE, desormais 0 - 2026-09-05).
const DISPLAYED_GRADES: Array[GradeLevel.Grade] = [
	GradeLevel.Grade.CP,
	GradeLevel.Grade.CE1,
	GradeLevel.Grade.CE2,
	GradeLevel.Grade.CM1,
	GradeLevel.Grade.CM2,
]

@onready var container: HBoxContainer = $HBoxContainer

var _labels: Dictionary = {}

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	for grade in DISPLAYED_GRADES:
		var color := GradeLevel.get_color(grade)
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 4)
		var icon := TextureRect.new()
		icon.texture = load(GradeLevel.get_coin_pile_icon_path(grade))
		## expand_mode = EXPAND_IGNORE_SIZE (2026-08-29, retour utilisateur : "reduit la taille des
		## icones de 60%") : sans lui, TextureRect.get_minimum_size() renvoie la taille NATIVE de la
		## texture (120x120px) au lieu de respecter custom_minimum_size - Godot prend le maximum des
		## deux, donc l'icone s'affichait a 120px malgre le custom_minimum_size vise ici (bug jamais
		## remarque avant que CoinHUD ne soit reellement instanciee, voir shop_panel.gd).
		## ICON_SIZE = 48 = 120 * 0.4, soit une reduction de 60% par rapport a la taille (buggee)
		## effectivement affichee a l'ecran.
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.custom_minimum_size = Vector2(ICON_SIZE, ICON_SIZE)
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		## Pas de modulate ici (2026-08-30) : chaque fichier tasdepiece-<classe>.webp est deja
		## colore, contrairement a l'ancienne icone unique - un modulate re-teinterait une image
		## deja en couleur au lieu de partir d'une base neutre.
		row.add_child(icon)
		var label := Label.new()
		## add_theme_color_override, pas modulate (corrige 2026-08-04) : modulate multiplie TOUTE
		## la couleur deja affichee par le Label, y compris son font_color de theme - ca ne
		## "rendait" la couleur de classe que par coincidence, tant qu'aucun theme ne definissait de
		## font_color de base pour Label (blanc quasi pur par defaut du moteur, blanc x couleur =
		## couleur). Des qu'un theme a defini Label/colors/font_color (voir ui/theme/*.tres, correctif
		## texte illisible du meme jour), ce blanc a disparu et modulate a assombri chaque couleur de
		## classe en la multipliant par l'encre du theme (visible sur tous les themes clairs, pas sur
		## theme_sombre dont le Label de base est presque blanc - d'ou le symptome "les couleurs
		## restent normales en mode sombre"). add_theme_color_override fixe directement le
		## font_color reel du Label, independamment du theme actif.
		label.add_theme_color_override("font_color", color)
		## Contour noir : certaines couleurs de classe (ex: blanc pour CP) seraient illisibles sans
		## contour sur un fond clair. add_theme_constant_override, pas add_theme_font_size_override -
		## outline_size est une constante de theme, pas une taille de police ; avec la mauvaise
		## categorie l'override etait silencieusement ignore et aucun contour ne s'affichait (bug
		## repere le 2026-07-28 via section_stats.gd).
		label.add_theme_color_override("font_outline_color", Color.BLACK)
		label.add_theme_constant_override("outline_size", 6)
		row.add_child(label)
		container.add_child(row)
		_labels[grade] = label
	Economy.balance_changed.connect(_on_balance_changed)
	_refresh()

func _refresh() -> void:
	for grade in DISPLAYED_GRADES:
		_labels[grade].text = "%s : %d" % [GradeLevel.get_label(grade), Economy.get_balance(GradeLevel.get_rarity(grade))]

func _on_balance_changed(_rarity: CardRarity.Rarity, _amount: int) -> void:
	_refresh()
