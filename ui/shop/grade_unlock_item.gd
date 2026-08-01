## Case carree pour l'achat d'une classe donnee (voir autoload GradeUnlock), dans l'onglet
## "Classe" de la boutique - meme base visuelle que CrateItem (cadre colore + fond creme +
## pastille de prix). A la difference de CrateItem, ce n'est PAS la classe suivante qui determine
## quelles cases existent : les 5 classes (CP a CM2) sont TOUJOURS presentes, une par instance
## (voir @export var grade), sinon l'onglet finirait vide une fois tout debloque - et l'onglet
## est destine a accueillir d'autres "goodies" plus tard (retour utilisateur 2026-08-01 : "je
## compte ajouter d'autres goodies dans cet onglet dc je prefere le garder tel quel").
##
## refresh() calcule l'etat de CETTE case a partir de son grade et de la progression courante :
##  - deja debloquee (GradeUnlock.is_unlocked) : case grisee, desactivee, prix remplace par un
##    trait "-" (retour utilisateur 2026-08-01).
##  - classe suivante a debloquer (GradeUnlock.get_next_grade()) : case active, coloree par la
##    monnaie a depenser (GradeUnlock.get_unlock_currency(), pas la couleur de la classe elle
##    meme - meme convention que l'ancienne version), prix reel affiche.
##  - verrouillee mais pas encore accessible (plus loin dans la progression) : case grisee comme
##    la premiere, mais garde son prix visible (pas de "-", elle n'est pas achetee) - simple
##    indication visuelle de ce qui reste a venir.
## Toute la case est reactive : GradeUnlockItem est lui-meme le Button (voir
## grade_unlock_item.tscn, pas de bouton "Acheter" dedie) - un clic emet purchase_requested, a
## charge de ShopPanel d'afficher une confirmation avant l'achat reel. Seule la case "active"
## n'est jamais desactivee, les deux autres etats coupent le clic via `disabled`.
class_name GradeUnlockItem
extends Button

signal purchase_requested

const OUTER_RADIUS := 16
const INNER_RADIUS := 11
const PRICE_RADIUS := 12
## Couleurs reprises de CrateItem/CardSlot pour rester coherent avec le reste de l'UI.
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
## Gris neutre reutilise du style "disabled" du theme (StyleBoxFlat_btn_disabled) : case deja
## achetee ou pas encore accessible, dans les deux cas ni la couleur de rarete ni l'interaction
## ne s'appliquent plus.
const GREY_COLOR := Color(0.878431, 0.862745, 0.827451)

## Classe representee par cette case - fixee une fois pour toutes par ShopPanel a
## l'instanciation (voir shop_panel.gd), jamais modifiee ensuite.
@export var grade: GradeLevel.Grade

@onready var frame_panel: Panel = $Frame
@onready var inner_panel: Panel = $Frame/Margin/InnerPanel
@onready var grade_label: Label = $Frame/Margin/InnerPanel/VBox/IconWrap/GradeLabel
@onready var coin_icon: TextureRect = $Frame/Margin/InnerPanel/VBox/PriceWrap/PriceBubble/PriceRow/CoinIcon
@onready var price_label: Label = $Frame/Margin/InnerPanel/VBox/PriceWrap/PriceBubble/PriceRow/PriceLabel
@onready var price_bubble: Panel = $Frame/Margin/InnerPanel/VBox/PriceWrap/PriceBubble

func _ready() -> void:
	## Fond creme et nom de classe : statiques, ne dependent jamais de l'etat d'achat (a la
	## difference du cadre/de la pastille, voir refresh()).
	_apply_flat_style(inner_panel, CREAM_COLOR, INNER_RADIUS)
	grade_label.text = GradeLevel.get_label(grade)
	grade_label.add_theme_color_override("font_color", INK_COLOR)
	pressed.connect(func() -> void: purchase_requested.emit())
	refresh()

## Recalcule l'affichage de cette case a partir de l'etat courant de GradeUnlock (voir le
## commentaire de classe pour le detail des 3 etats). Appelee a l'ouverture de la boutique et
## apres chaque achat (coffre ou deblocage, meme si un coffre n'affecte jamais directement une
## classe verrouillee - simplicite, un seul point de rafraichissement pour tout l'onglet), voir
## ShopPanel._refresh_grade_items().
func refresh() -> void:
	if GradeUnlock.is_unlocked(grade):
		disabled = true
		_apply_flat_style(frame_panel, GREY_COLOR, OUTER_RADIUS, INK_COLOR, 2)
		_apply_flat_style(price_bubble, GREY_COLOR, PRICE_RADIUS, INK_COLOR, 2)
		coin_icon.hide()
		price_label.show()
		price_label.text = "-"
		price_label.add_theme_color_override("font_color", INK_COLOR)
		return

	coin_icon.show()
	price_label.text = str(GradeUnlock.UNLOCK_PRICE)

	if GradeUnlock.has_next_grade() and grade == GradeUnlock.get_next_grade():
		disabled = false
		var currency := GradeUnlock.get_unlock_currency()
		var color := CardRarity.get_color(currency)
		## Meme regle de contraste que CrateItem (rarete "Legendaire" = orange, texte encre trop
		## peu contraste dessus, bascule en blanc).
		var text_color := Color.WHITE if currency == CardRarity.Rarity.LEGENDARY else INK_COLOR
		_apply_flat_style(frame_panel, color, OUTER_RADIUS, INK_COLOR, 2)
		_apply_flat_style(price_bubble, color, PRICE_RADIUS, INK_COLOR, 2)
		price_label.add_theme_color_override("font_color", text_color)
		disabled = Economy.get_balance(currency) < GradeUnlock.UNLOCK_PRICE
	else:
		disabled = true
		_apply_flat_style(frame_panel, GREY_COLOR, OUTER_RADIUS, INK_COLOR, 2)
		_apply_flat_style(price_bubble, GREY_COLOR, PRICE_RADIUS, INK_COLOR, 2)
		price_label.add_theme_color_override("font_color", INK_COLOR)

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon), meme technique
## que CrateItem._apply_flat_style (duplique ici plutot que partage : deux petites scenes
## independantes, meme convention que CardSlot/CrateItem).
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
