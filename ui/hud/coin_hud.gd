## Affiche les soldes de pieces par rarete et se met a jour via le signal d'Economy.
## Ne connait rien d'autre que l'autoload Economy : reutilisable sur n'importe quel ecran.
## Les labels sont crees au runtime (un par rarete listee dans DISPLAYED_RARITIES), pour
## qu'ajouter une nouvelle rarete jouable plus tard n'implique pas de retoucher la scene.
class_name CoinHUD
extends Control

## Raretes affichees dans le HUD. Toutes les 5 pour l'instant (pratique en dev/test pour
## suivre les soldes de la boutique complete) ; a reduire si besoin une fois le contenu
## CE1-CM2 en place et le jeu presente a un vrai joueur (voir Economy.STARTING_BALANCE_FOR_TESTING).
const DISPLAYED_RARITIES: Array[CardRarity.Rarity] = [
	CardRarity.Rarity.COMMON,
	CardRarity.Rarity.UNCOMMON,
	CardRarity.Rarity.RARE,
	CardRarity.Rarity.EPIC,
	CardRarity.Rarity.LEGENDARY,
]

@onready var container: HBoxContainer = $HBoxContainer

var _labels: Dictionary = {}

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	for rarity in DISPLAYED_RARITIES:
		var label := Label.new()
		label.modulate = CardRarity.get_color(rarity)
		## Contour noir : certaines couleurs de rarete (ex: blanc pour "commune") seraient
		## illisibles sans contour sur un fond clair. add_theme_constant_override, pas
		## add_theme_font_size_override - outline_size est une constante de theme, pas une taille
		## de police ; avec la mauvaise categorie l'override etait silencieusement ignore et
		## aucun contour ne s'affichait (bug repere le 2026-07-28 via section_stats.gd).
		label.add_theme_color_override("font_outline_color", Color.BLACK)
		label.add_theme_constant_override("outline_size", 6)
		container.add_child(label)
		_labels[rarity] = label
	Economy.balance_changed.connect(_on_balance_changed)
	_refresh()

func _refresh() -> void:
	for rarity in DISPLAYED_RARITIES:
		_labels[rarity].text = "%s : %d" % [CardRarity.get_label(rarity), Economy.get_balance(rarity)]

func _on_balance_changed(_rarity: CardRarity.Rarity, _amount: int) -> void:
	_refresh()
