## Case "coffre a doublons" de l'onglet Cartes de la boutique (2e ligne, sous les coffres achetes
## en pieces - 2026-10-04, demande de Steve). Une case par classe, meme gabarit que CrateItem
## (meme cadre creme + bordure encre, meme coffre centre en haut) avec 3 differences :
## - un badge NEW (assets/classe2.0/icones/NEW.webp) a 50% de la taille du coffre, en bas a droite
##   du coffre ;
## - a la place du selecteur de quantite -x+ : le decompte des doublons possedes dans cette
##   classe sur DUPLICATES_PER_CRATE ("7/10"), ou "Complet" quand toutes les cartes de la classe
##   sont deja possedees ;
## - la monnaie en bas a droite est l'icone doublon-<classe>.webp, avec le prix (10) dessus.
## La case ne devient cliquable (disabled = false) qu'a partir de 10 doublons ET s'il reste au
## moins une carte non possedee dans la classe - le coffre donne toujours une carte NOUVELLE (voir
## ShopPanel._do_duplicate_crate_purchase). Les cartes de la classe sont lues dans les entrees du
## coffre en pieces de la meme classe (loot_table), deja la liste complete des cartes de la classe :
## aucune liste a maintenir en double.
class_name DuplicateCrateItem
extends Button

signal purchase_requested(loot_table: LootTableResource)

## Nombre de doublons echanges contre un coffre.
const DUPLICATES_PER_CRATE := 10
const OUTER_RADIUS := 16
## Memes couleurs que CrateItem (cadre, texte).
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
## Coffre attenue tant que la case n'est pas achetable (moins de 10 doublons ou classe complete).
const LOCKED_ICON_MODULATE := Color(1, 1, 1, 0.45)

@export var loot_table: LootTableResource

@onready var frame_panel: Panel = $Frame
@onready var item_icon: TextureRect = $Frame/ItemIcon
@onready var currency_icon: TextureRect = $Frame/CurrencyIcon
@onready var price_label: Label = $Frame/CurrencyIcon/PriceLabel
@onready var count_label: Label = $Frame/CountLabel

func _ready() -> void:
	## Meme raison que CrateItem._ready : reste attrapable au doigt depuis le ScrollContainer parent.
	mouse_filter = Control.MOUSE_FILTER_PASS
	var style := StyleBoxFlat.new()
	style.bg_color = CREAM_COLOR
	style.set_corner_radius_all(OUTER_RADIUS)
	style.set_border_width_all(2)
	style.border_color = INK_COLOR
	frame_panel.add_theme_stylebox_override("panel", style)
	count_label.add_theme_color_override("font_color", INK_COLOR)
	price_label.text = str(DUPLICATES_PER_CRATE)
	if loot_table:
		currency_icon.texture = load(GradeLevel.get_doublon_icon_path(get_grade()))
	pressed.connect(func() -> void: purchase_requested.emit(loot_table))
	refresh()

func get_grade() -> GradeLevel.Grade:
	return GradeLevel.get_grade_for_rarity(loot_table.rarity)

## Toutes les cartes de la classe (sans doublon d'entree), lues dans le coffre en pieces associe.
func get_grade_cards() -> Array[CardResource]:
	var cards: Array[CardResource] = []
	var seen := {}
	if loot_table == null:
		return cards
	for entry in loot_table.entries:
		if entry == null or entry.card == null or seen.has(entry.card.id):
			continue
		seen[entry.card.id] = true
		cards.append(entry.card)
	return cards

## Cartes de la classe pas encore possedees (candidates du coffre).
func get_missing_cards() -> Array[CardResource]:
	## Boucle plutot que filter() : filter() renvoie un Array non type, refuse par le type de
	## retour Array[CardResource].
	var missing: Array[CardResource] = []
	for card in get_grade_cards():
		if not CardCollection.has_card(card.id):
			missing.append(card)
	return missing

## Rappele par ShopPanel a chaque ouverture et apres tout achat de carte (un coffre en pieces peut
## donner un doublon, un coffre a doublons en consomme 10).
func refresh() -> void:
	if loot_table == null:
		return
	var duplicates := CardCollection.count_duplicates(get_grade_cards())
	var complete := get_missing_cards().is_empty()
	count_label.text = "Complet" if complete else "%d/%d" % [duplicates, DUPLICATES_PER_CRATE]
	disabled = complete or duplicates < DUPLICATES_PER_CRATE
	item_icon.modulate = LOCKED_ICON_MODULATE if disabled else Color.WHITE
	mouse_default_cursor_shape = Control.CURSOR_ARROW if disabled else Control.CURSOR_POINTING_HAND
