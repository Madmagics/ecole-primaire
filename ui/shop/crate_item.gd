## Case carree representant un lot/coffre achetable dans la boutique - meme technique que
## CardSlot (ui/collection/card_slot.gd) : cadre colore + fond creme + pastille en bas, mais a
## plus petite echelle et sans nom (l'icone du coffre suffit, voir CHARTE_GRAPHIQUE.md 2026-08-01).
## Toute la case reste reactive au clic (CrateItem est lui-meme le Button) : un clic emet
## purchase_requested pour la quantite actuellement selectionnee (voir QuantityRow), a charge de
## ShopPanel d'afficher une confirmation avant l'achat reel - inchange sur ce point (retour
## utilisateur 2026-08-04 : "on garde la validation de l'achat sur la case existante, et on garde
## la popup de validation finale"). Le prix affiche est prix_de_base * quantite (meme retour).
## Un appui maintenu sur "+"/"-" (2026-08-04) declenche apres 1 seconde (voir
## AUTO_REPEAT_DELAY_SECONDS) une repetition automatique a 5 unites/seconde jusqu'au relachement
## (voir _setup_auto_repeat) - un appui bref reste un pas unique.
##
## CoinIcon colore (2026-08-29, retour utilisateur : "pose la couleur correspondant aux pieces
## listees dans la fenetre") : concept_piece.svg etait une base grise neutre concue des le depart
## pour etre teintee par modulate (voir le commentaire dans le fichier SVG) mais ce modulate
## n'etait en realite jamais applique - corrige ce jour-la via un modulate enfin applique.
##
## CoinIcon = fichier colore par classe, plus de modulate (2026-08-30, retour utilisateur : "je
## les ai faites en webp avec leur couleur... les pieces a utiliser pour les achat sont les icones
## pieces... en fonction de la classe correspondante") : concept_piece.svg (base grise + modulate)
## retire au profit de piece-<classe>.webp (voir GradeLevel.get_coin_icon_path()), deja fini en
## couleur - assigner modulate par-dessus re-teinterait une image deja coloree. Couleur du cadre/
## de la bulle de prix passee de CardRarity.get_color(loot_table.rarity) a
## GradeLevel.get_color(grade) au meme moment : nouveau code couleur unifie du jeu (bleu/vert/
## jaune/violet/rouge pour CP/CE1/CE2/CM1/CM2), independant de l'ancienne palette par rarete.
##
## ItemIcon repasse de boutique.webp a coffre.webp (2026-08-30, retour utilisateur : "remplace
## l'icone boutique par l'icone coffre") - la aussi simple changement de texture (pas de
## modulate, meme raison que ci-dessus).
##
## Reamenagement des coins (meme jour, meme retour) : "deplace l'icone en haut a gauche de la
## case, ensuite ajoute une piece en haut a droite ... et place le cout cumule dans la piece" -
## ItemIcon et CoinIcon quittent VBox/IconWrap/PriceWrap/PriceBubble/PriceRow (tout retire) pour
## devenir des enfants directs de Frame (meme technique que ProfSkinItem.CoinIcon, ancre
## bas-droite la-bas), CoinIcon a la meme taille que celui de ProfSkinItem
## (custom_minimum_size 51x50) ; PriceLabel devient un enfant direct de CoinIcon (plein rect +
## centre), affiche le cout cumule (prix de base * quantite, voir refresh_availability)
## directement superpose sur la piece - remplace l'ancienne PriceBubble (pastille coloree
## separee en bas de case).
##
## Meme jour, disposition finale (retour utilisateur suivant, sur le premier essai ci-dessus) :
## "le coffre est centre en haut, la piece avec le nombre en bas a droite et le -x+ en bas a
## gauche aligne avec la piece" - ItemIcon repasse de haut-gauche a haut-centre
## (anchors_preset=5/CENTER_TOP, grandit vers le bas depuis le centre) ; CoinIcon repasse de
## haut-droite a bas-droite (anchors_preset=3/BOTTOM_RIGHT, comme ProfSkinItem.CoinIcon) ;
## QuantityRow quitte VBox (retire, plus aucun enfant a organiser en colonne) pour devenir lui
## aussi un enfant direct de Frame, ancre bas-gauche (anchors_preset=2/BOTTOM_LEFT) avec le
## meme offset_bottom (-10) que CoinIcon pour partager sa ligne de base ("aligne avec la
## piece").
##
## 12e passe (2026-08-31, retour utilisateur : "enleve le cadre de couleur des cadres de cartes,
## ajoute une marge de 5px tout autour de la case a l'interieur de la case") : Frame perd sa
## couleur de classe (GradeLevel.get_color(grade) retire de _ready(), variable "color" devenue
## inutile et supprimee avec) au profit d'un fond transparent + bordure INK_COLOR seule - meme
## principe que ProfSkinItem.Frame (voir prof_skin_item.gd), pour que la case ne porte plus
## qu'une seule couleur de classe (celle de CoinIcon) plutot que deux redondantes. A ce sujet, la
## toute premiere phrase de ce commentaire de classe ("cadre colore + fond creme...") decrit un
## etat qui n'existe plus : le cadre n'est plus colore, ni porte par InnerPanel (retire, voir la
## 14e passe plus bas) - voir directement Frame.
## Second changement, meme retour : la marge interieure passe uniformement de 6px a 5px - a la
## fois Margin (theme_override_constants) et les offsets de ItemIcon/CoinIcon/QuantityRow (qui
## replique cette meme valeur en dur puisqu'ils sont enfants directs de Frame et non de Margin,
## voir le paragraphe "disposition finale" ci-dessus) ont ete ajustes ensemble pour rester
## visuellement coherents.

##
## 13e passe (2026-08-31, meme jour, retour utilisateur sur capture d'ecran de la 12e passe :
## "par marge interne je voulais augmenter la distance entre le coffre et le cadre... alors que
## la ils se touchent") : la 12e passe n'a pas suffi visuellement (5px trop fin sur une case de
## 140x140 avec des elements deja grands - coffre 80x78, piece 51x50) - marge doublee a 10px sur
## les 4 cotes, memes emplacements que la 12e passe (Margin + offsets ItemIcon/CoinIcon/
## QuantityRow).
##
## 14e passe (2026-09-03, retour utilisateur : "en ce qui concerne les cases achetable des
## coffres, il y a toujours le double cadre. ne laisse que le cadre visible qui est le meme que
## celui autour des tab") : Margin/InnerPanel retires (n'avaient plus aucun enfant depuis la
## "disposition finale" ci-dessus - ItemIcon/CoinIcon/QuantityRow sont deja des enfants directs
## de Frame - ne servaient plus qu'a peindre un second rectangle creme arrondi, insere de 10px,
## a l'interieur du contour encre de Frame : un "double cadre" purement visuel, sans utilite
## structurelle). Frame porte desormais lui-meme le fond creme (CREAM_COLOR au lieu de
## Color.TRANSPARENT) en plus de sa bordure encre existante (INK_COLOR, inchangee) - un seul
## rectangle a la fois fond + bordure, meme principe qu'un onglet de la boutique (un seul
## StyleBoxFlat combinant les deux plutot que deux Panel empiles).
##
## 15e passe (2026-09-03, meme jour, retour utilisateur avec capture d'ecran de la 14e passe :
## "les cadres autour des cases de coffres ont toujours un double cadre qui renforce la taille
## des coins") : la 14e passe n'avait fusionne QUE Frame/InnerPanel - restait un troisieme cadre
## insoupconne, celui du Button racine (CrateItem lui-meme) : contrairement a ProfSkinItem (voir
## prof_skin_item.gd, flat=true depuis le 2026-08-30 - "je vois encore trop de cadres superposes
## (3) supprime le cadre le plus profond"), CrateItem n'avait jamais recu ce meme flat=true. Le
## Button racine dessinait donc encore son style theme par defaut (StyleBoxFlat_btn_normal - fond
## rose, rayon 10, bordure asymetrique 3/3/3/6px "cartoon") sur tout le rect, SOUS Frame (rayon
## 16, rempli de creme) : les deux rayons differents (10 contre 16) font que la courbe plus
## generause de Frame decoupe davantage aux coins que celle, plus carree, du bouton en dessous -
## un petit bout de son fond/sa bordure depasse exactement la ou les deux courbes divergent le
## plus, ce qui "renforce" visuellement les coins. flat=true (voir le .tscn) regle le probleme a
## la source, meme correctif que ProfSkinItem en 2026-08-30.
class_name CrateItem
extends Button

signal purchase_requested(loot_table: LootTableResource, quantity: int)

const OUTER_RADIUS := 16
## Couleurs reprises de CardSlot/theme pour rester coherent avec le reste de l'UI.
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
## Gris neutre repris de GradeUnlockItem.GREY_COLOR (etat desactive des boutons +/-, voir
## _style_quantity_button) - meme teinte que le style "disabled" du theme, dupliquee ici pour ne
## pas dependre d'une autre scene pour une seule constante.
const GREY_COLOR := Color(0.878431, 0.862745, 0.827451)

@export var loot_table: LootTableResource

@onready var frame_panel: Panel = $Frame
@onready var coin_icon: TextureRect = $Frame/CoinIcon
@onready var price_label: Label = $Frame/CoinIcon/PriceLabel
@onready var minus_button: Button = $Frame/QuantityRow/MinusButton
@onready var quantity_label: Label = $Frame/QuantityRow/QuantityLabel
@onready var plus_button: Button = $Frame/QuantityRow/PlusButton

## Nombre de coffres selectionnes pour l'achat en cours (2026-08-04) : plafonne dans
## refresh_availability() au nombre de coffres que le solde actuel permet d'acheter, jamais au
## dela - voir _get_max_affordable(). Repart a 1 apres chaque achat reussi (voir reset_quantity,
## appele par ShopPanel._do_purchase_crate).
var _quantity: int = 1

func _ready() -> void:
	## Cree dynamiquement (pas dans le _ready() du panneau parent) : se corrige donc soi-meme
	## pour rester attrapable au doigt en glissement depuis un ScrollContainer parent, plutot
	## que de dependre du moment ou ce panneau a ete peuple - voir ui/common/touch_scroll_fix.gd
	## (retour utilisateur 2026-09-18).
	mouse_filter = Control.MOUSE_FILTER_PASS
	if loot_table:
		var grade := GradeLevel.get_grade_for_rarity(loot_table.rarity)
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, INK_COLOR, 2)
		coin_icon.texture = load(GradeLevel.get_coin_icon_path(grade))
	## QuantityLabel repose visuellement sur le fond creme de Frame (voir _ready ci-dessus,
	## 14e passe) : couleur fixee en dur ici, pas laissee au theme actif (2026-08-04, retour
	## utilisateur "pas lisible sur fond blanc creme/beige" - voir aussi le correctif de fond
	## ajoute dans les 4 fichiers ui/theme/*.tres, qui ne suffirait pas seul ici puisque ce fond
	## creme reste fixe quel que soit le theme choisi, contrairement au reste de l'UI).
	quantity_label.add_theme_color_override("font_color", INK_COLOR)
	pressed.connect(func() -> void: purchase_requested.emit(loot_table, _quantity))
	## MinusButton/PlusButton sont des Button independants places au-dessus de la case (qui est
	## elle-meme un Button) : leur mouse_filter par defaut (STOP) suffit a empecher leur clic de se
	## propager jusqu'au "pressed" de la case - ajuster la quantite ne declenche jamais un achat.
	## L'appui simple ET l'appui maintenu passent par button_down/button_up (voir
	## _setup_auto_repeat) plutot que par le signal "pressed" : ce dernier ne s'emet qu'au
	## relachement (BaseButton.action_mode par defaut), ce qui aurait ajoute un pas en trop a la
	## fin d'un appui long deja gere par la repetition automatique.
	_setup_auto_repeat(minus_button, _on_minus_pressed)
	_setup_auto_repeat(plus_button, _on_plus_pressed)
	_style_quantity_button(minus_button)
	_style_quantity_button(plus_button)
	refresh_availability()

## Delai avant que le maintien d'un appui ne declenche la repetition automatique (retour
## utilisateur 2026-08-04 : d'abord 3 secondes, ramene a 1 seconde le meme jour).
const AUTO_REPEAT_DELAY_SECONDS := 1.0
## Cadence de la repetition automatique une fois declenchee : 5 unites/seconde = un pas toutes les
## 0.2s (meme retour utilisateur).
const AUTO_REPEAT_INTERVAL_SECONDS := 1.0 / 5.0

## Branche [button] pour qu'un appui simple execute [step] une fois immediatement (button_down),
## et qu'un appui maintenu au dela de AUTO_REPEAT_DELAY_SECONDS enchaine [step] toutes les
## AUTO_REPEAT_INTERVAL_SECONDS jusqu'au relachement (button_up) - factorise ici plutot que
## duplique pour MinusButton/PlusButton. Les deux Timer sont crees en code (pas dans le .tscn) et
## captures par les Callable ci-dessous : pas besoin de variables de classe, ils restent en vie
## tant que ce noeud existe (enfants de CrateItem).
func _setup_auto_repeat(button: Button, step: Callable) -> void:
	var hold_delay := Timer.new()
	hold_delay.wait_time = AUTO_REPEAT_DELAY_SECONDS
	hold_delay.one_shot = true
	add_child(hold_delay)

	var repeat := Timer.new()
	repeat.wait_time = AUTO_REPEAT_INTERVAL_SECONDS
	repeat.one_shot = false
	add_child(repeat)

	button.button_down.connect(func() -> void:
		step.call()
		hold_delay.start()
	)
	## Si le bouton est desactive pendant qu'il est maintenu (voir refresh_availability, quantite
	## qui atteint sa borne), Godot emet button_up automatiquement (voir doc BaseButton.disabled) -
	## la repetition s'arrete donc toute seule sans logique supplementaire ici.
	button.button_up.connect(func() -> void:
		hold_delay.stop()
		repeat.stop()
	)
	hold_delay.timeout.connect(func() -> void: repeat.start())
	repeat.timeout.connect(step)

## Rappele a la creation, a chaque ouverture de la boutique et apres tout achat (voir
## ShopPanel._refresh_crate_items) : recalcule le plafond de quantite achetable selon le solde
## actuel (Economy.get_balance) et remet a jour prix affiche + etat des boutons +/-. Un achat sur
## une AUTRE case de la meme rarete change ce solde sans que cette case le sache autrement -
## d'ou l'appel systematique plutot qu'une ecoute ponctuelle d'un signal.
func refresh_availability() -> void:
	if not loot_table:
		return
	var max_affordable: int = _get_max_affordable()
	_quantity = clampi(_quantity, 1, maxi(1, max_affordable))
	quantity_label.text = str(_quantity)
	minus_button.disabled = _quantity <= 1
	plus_button.disabled = _quantity >= max_affordable
	price_label.text = str(loot_table.crate_price * _quantity)

## Nombre maximum de coffres achetables avec le solde actuel de la rarete concernee (division
## entiere : arrondie vers le bas, jamais au dela de ce que le joueur possede reellement).
func _get_max_affordable() -> int:
	if loot_table.crate_price <= 0:
		return 1
	@warning_ignore("integer_division")
	return Economy.get_balance(loot_table.rarity) / loot_table.crate_price

func _on_minus_pressed() -> void:
	_quantity = maxi(1, _quantity - 1)
	refresh_availability()

func _on_plus_pressed() -> void:
	_quantity = mini(_get_max_affordable(), _quantity + 1)
	refresh_availability()

## Appele par ShopPanel apres un achat reussi sur CETTE case : on repart de 1 plutot que de garder
## la derniere quantite choisie (retour utilisateur implicite - la quantite est liee a un achat
## ponctuel, pas une preference durable).
func reset_quantity() -> void:
	_quantity = 1
	refresh_availability()

## Style compact et carre pour les boutons +/- (2026-08-04, retour utilisateur : "diminue la
## hauteur des cases + et -, je veux qu'elles soient carrees"). Le style "Button" par defaut du
## theme actif est pense pour des boutons texte plus grands (marges 14/8px + bordure basse
## epaissie a 6px, effet "cartoon") : applique tel quel a un bouton d'un seul caractere, il rend
## nettement plus haut que large - meme cause que "Badge pas carré" deja documente dans
## CHARTE_GRAPHIQUE.md (2026-08-02) pour KeyBadge. Ici la correction est inverse : plutot que de
## relever le plancher au dessus du contenu, on reduit le contenu (marges/bordure fines et
## symetriques) puis on fixe un plancher carre (28x28, voir le .tscn) confortablement au dessus du
## nouveau besoin reel sur les deux axes - le plancher domine alors uniformement, garantissant un
## carre. Les 4 etats (normal/survol/presse/desactive) recoivent le meme gabarit de marges/bordure
## (seule la couleur de fond change) pour que la taille ne bouge jamais en changeant d'etat.
func _style_quantity_button(button: Button) -> void:
	button.add_theme_stylebox_override("normal", _flat_button_style(CREAM_COLOR))
	button.add_theme_stylebox_override("hover", _flat_button_style(Color.WHITE))
	button.add_theme_stylebox_override("pressed", _flat_button_style(Color(0.941176, 0.905882, 0.815686)))
	button.add_theme_stylebox_override("disabled", _flat_button_style(GREY_COLOR))
	button.add_theme_color_override("font_color", INK_COLOR)
	button.add_theme_color_override("font_hover_color", INK_COLOR)
	button.add_theme_color_override("font_pressed_color", INK_COLOR)
	button.add_theme_color_override("font_disabled_color", INK_COLOR)

## StyleBoxFlat compact partage par les 4 etats de _style_quantity_button : marges/bordure fines
## et symetriques (a la difference du style "Button" global, voir commentaire ci-dessus), seule la
## couleur de fond varie d'un etat a l'autre.
func _flat_button_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(7)
	style.set_border_width_all(2)
	style.border_color = INK_COLOR
	style.set_content_margin_all(2)
	return style

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon), meme technique
## que CardSlot._apply_flat_style (border_color/border_width optionnels).
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
