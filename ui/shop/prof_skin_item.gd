## Case representant un skin de "prof" achetable/equipable en boutique (voir ProfSkinCatalog
## pour le catalogue de textures et autoload/prof_skins.gd pour l'etat possede/actif), taille
## extensible (SIZE_EXPAND_FILL sur les 2 axes, 112x112 en plancher - voir ItemGrid dans
## shop_panel.tscn qui distribue 100% largeur/hauteur de l'onglet sur 5 colonnes x 2 lignes).
##
## Portrait (SkinIcon) en STRETCH_KEEP_ASPECT_CENTERED (2026-08-30, retour utilisateur :
## "fait en sorte que les images gardent leur ratio de taille et fasse la hauteur de la case") -
## meme mode que CardSlot/CrateItem : le portrait occupe toute la hauteur de la case (dimension
## limitante pour ces portraits plus hauts que larges) sans etre deforme, centre horizontalement
## (letterboxing gauche/droite si la case est plus large que le portrait a cette hauteur). Etait
## passe par STRETCH_SCALE (etirement, deformant) puis STRETCH_KEEP_ASPECT_COVERED (recadrage)
## avant cette passe - voir project_prof_skins.md pour l'historique complet.
##
## Cadre : Frame ne prenait jamais la couleur de la classe ni de fond (transparent) - seule sa
## BORDURE changeait (encre fine par defaut, doree et plus epaisse quand le skin est actif, voir
## ACTIVE_BORDER_*) - etat qui n'existe plus, voir la fusion du 2026-09-03 plus bas (Frame porte
## desormais aussi le fond). Le Button racine reste flat=true (2026-08-30, retour utilisateur :
## "je vois encore trop de cadres superposes (3) supprime le cadre le plus profond") pour ne pas
## dessiner son propre decor de fond par defaut sous Frame.
##
## Prix : plus de cadre/bulle separe - le chiffre est directement superpose sur CoinIcon
## (fichier piece-<classe>.webp, deja colore par classe, voir GradeLevel.get_coin_icon_path()),
## lui-meme ancre en bas a droite du Frame (pas de clip, peut deborder legerement sur
## le portrait et la bordure comme une etiquette de prix) (2026-08-30, retour utilisateur : "on
## essaie de mettre le prix dans l'icone a taille normale placee en bas a droite du cadre de
## l'objet en vente"). CoinIcon affiche a moitie de sa taille native mesuree (~103x101px ->
## custom_minimum_size 51x50, EXPAND_IGNORE_SIZE) - meme retour utilisateur, passage suivant :
## "reduit de moitie la taille de la piece et place la en bas a droite du cadre". PriceLabel
## est un enfant direct de CoinIcon, ancre en plein rect + centre horizontalement/verticalement,
## pour rester cale sur l'icone quelle que soit sa taille. Visible uniquement tant que le skin
## n'est pas achete (voir refresh()).
##
## 3 etats visuels (retour utilisateur d'origine, 2026-08-29) :
##  - pas encore achete : portrait grise, bordure encre fine, CoinIcon+prix visible - case
##    desactivee si le solde est insuffisant.
##  - achete mais pas porte actuellement ("couleur normale") : portrait en couleur, bordure encre
##    fine, CoinIcon cache (plus rien a payer).
##  - achete ET actuellement porte ("surbrillance") : portrait en couleur, bordure doree epaisse,
##    CoinIcon cache - case desactivee, rien a faire de plus dessus.
## Toute la case est reactive au clic (ProfSkinItem est lui-meme le Button, comme CrateItem) : un
## clic sur une case non achetee emet purchase_requested (a charge de ShopPanel d'afficher la
## popup de confirmation habituelle, comme tout achat dans cette boutique) ; un clic sur une case
## deja achetee mais pas active emet equip_requested (immediat, SANS confirmation - reequiper un
## skin deja possede ne coute rien, voir ProfSkins.set_active()).
##
## 3 retouches du 2026-09-02 (retour utilisateur avec capture d'ecran des 10 skins) : "les images
## de prof sont toujours trop grande (au moins 50%) et ne sont pas adaptées a la case d achat.
## ensuite il manque un cadre autour du prix+icone avec fond unis selon le theme pour lisibilité.
## ensuite le cadre superflu autour de la case d achat est toujours present, enleve le."
##  - **Portrait retreci** : SkinIcon gagne une marge de 20px sur les 4 cotes (etait colle aux
##    bords d'InnerPanel, 100x100 -> 60x60 visible) - le mode STRETCH_KEEP_ASPECT_CENTERED (voir
##    plus haut) continue de s'appliquer sur cette zone reduite, plus de fond CREAM_COLOR visible
##    tout autour du portrait qu'avant.
##  - **Cadre prix+icone** : etat qui n'existe plus, voir la passe du 2026-09-03 plus bas qui
##    retire ce badge (CoinIcon redevient un enfant direct de Frame, fond transparent) - a
##    l'epoque CoinIcon (et PriceLabel, son enfant) devenaient enfants d'un nouveau PriceBadge
##    (PanelContainer, theme_type_variation="ShortcutBadge" - meme pastille cadre/fond par theme
##    deja utilisee pour la touche de raccourci dans GameMenuPanel) avec un fond uni + bordure
##    fine derriere, aux couleurs du theme actif.
##  - **Bordure de case retiree sauf skin actif** (voir refresh()) : etat qui n'existe plus, voir
##    la passe du 2026-09-03 ci-dessous qui reintroduit une bordure encre par defaut - a l'epoque
##    Frame ne dessinait plus AUCUNE bordure quand le skin n'etait pas actuellement porte (fine
##    bordure encre permanente jugee peu utile), seule la bordure doree du skin actif subsistait.
##
## Marge interieure du portrait reduite de 20 a 10px (2026-09-03, retour utilisateur : "dans les
## cases passe la marge interieur de 20 a 10px et donc la taille des images a 80px") : SkinIcon
## (voir le .tscn) passe de 60x60 a 80x80 visible dans l'InnerPanel de 100x100 - moins de fond
## CREAM_COLOR visible autour du portrait qu'avec la marge de 20px de la passe precedente.
##
## Bordure encre simple reintroduite (2026-09-03, meme jour, retour utilisateur : "remet aussi un
## cadre simple comme ceux autour des onglets mais autour de chaque case de produit a acheter, ce
## cadre changera si cest celui qui est choisi pour appliquer la tenue du prof") : Frame retrouve
## une bordure encre fine (INK_COLOR/NORMAL_BORDER_WIDTH, memes valeurs que CrateItem.Frame) par
## defaut dans refresh() - la suppression totale de la passe precedente allait finalement trop
## loin (case totalement sans cadre). La bordure doree (ACTIVE_BORDER_*) reste la seule a
## remplacer cette bordure simple quand le skin est celui actuellement porte, plutot que de s'y
## ajouter - un seul cadre visible a la fois, jamais deux superposes.
##
## Fusion Frame/InnerPanel (2026-09-03, meme jour, retour utilisateur suite a un audit demande :
## "les cases de l onglet cartes sont differentes de celles des autres onglet, on dirait qu il y
## a 2 cadres differentes superposés surtout aux coins... les angles ont 2 arrondis differentes,
## audit et feedback" puis "on fait ca") : Frame ayant retrouve sa bordure ci-dessus, la case
## souffrait du MEME defaut deja corrige sur CrateItem (voir sa 14e passe) - Frame (bordure seule,
## transparent) et InnerPanel (fond creme separe, rayon 11, en retrait de 6px) affichaient chacun
## un contour visible (bordure encre d'un cote, limite de couleur fond-creme/fond-onglet de
## l'autre), surtout perceptible aux coins ou les deux courbes sont proches. Margin/InnerPanel
## retires ; Frame porte desormais lui-meme le fond creme (comme CrateItem.Frame) ET recoit
## clip_contents=true (role auparavant tenu par InnerPanel, necessaire car SkinIcon en
## STRETCH_KEEP_ASPECT_CENTERED peut deborder verticalement) ; SkinIcon devient un enfant direct
## de Frame, ses offsets passent de 10px (relatifs a InnerPanel) a 16px (= 6px de Margin + 10px
## d'origine, relatifs a Frame desormais) pour conserver exactement le meme retrait visuel du
## portrait qu'avant la fusion.
##
## PriceBadge retire (2026-09-03, meme jour, retour utilisateur : "jaimerais que enleves la cadre
## autour des pieces necessaires pour achter un item, je veux un fond transparent derriere la
## piece qui a son prix en chiffre dessus") : revient sur le badge ShortcutBadge ajoute le
## 2026-09-02 (voir "3 retouches du 2026-09-02" plus haut, paragraphe "Cadre prix+icone") - le
## PanelContainer/ShortcutBadge est retire, CoinIcon (et PriceLabel, son enfant) redeviennent des
## enfants directs de Frame, memes ancre/offsets (bas-droite, -4) que le badge avait. Fond
## transparent derriere la piece par construction (CoinIcon est un TextureRect sans stylebox,
## jamais un Panel) - meme technique que CrateItem.CoinIcon, qui n'a jamais eu ce badge.
class_name ProfSkinItem
extends Button

signal purchase_requested(grade: GradeLevel.Grade, skin_index: int)
signal equip_requested(grade: GradeLevel.Grade, skin_index: int)

const OUTER_RADIUS := 16
## Couleurs reprises de CrateItem/CardSlot pour rester coherent avec le reste de l'UI.
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
## Bordure encre par defaut (voir refresh()) - meme epaisseur que CrateItem.Frame.
const NORMAL_BORDER_WIDTH := 2
## Bordure "surbrillance" du skin actuellement porte - meme jaune que le badge "+N" de CardSlot
## (ExtraLabel), seul autre accent dore deja utilise dans l'UI du jeu.
const ACTIVE_BORDER_COLOR := Color(1, 0.85, 0.2)
const ACTIVE_BORDER_WIDTH := 4
## Teinte appliquee au portrait tant qu'il n'est pas achete - assombrit/desature l'icone sans la
## masquer completement (le joueur voit quel skin il achete, juste "grise").
const ICON_LOCKED_TINT := Color(0.55, 0.55, 0.55)

## Classe et index de skin representes par cette case - fixes une fois pour toutes par ShopPanel
## a l'instanciation (voir shop_panel.gd), jamais modifies ensuite.
@export var grade: GradeLevel.Grade
@export var skin_index: int

@onready var frame_panel: Panel = $Frame
@onready var skin_icon: TextureRect = $Frame/SkinIcon
@onready var coin_icon: TextureRect = $Frame/CoinIcon
@onready var price_label: Label = $Frame/CoinIcon/PriceLabel

func _ready() -> void:
	## Fond creme porte par Frame desormais (voir refresh(), appele en fin de _ready() - et le
	## commentaire de classe, fusion Frame/InnerPanel) : visible dans le letterboxing gauche/
	## droite de SkinIcon (STRETCH_KEEP_ASPECT_CENTERED) quand la case est plus large que le
	## portrait a hauteur egale, et filet de secours si jamais la texture ne charge pas.
	skin_icon.texture = ProfSkinCatalog.get_texture(grade, skin_index)
	## Fichier colore par classe, fixe une fois pour toutes (2026-08-30, retour utilisateur : "je
	## les ai faites en webp avec leur couleur... en fonction de la classe correspondante") - grade
	## est un @export fixe par ShopPanel a l'instanciation, pas besoin de le refaire a chaque
	## refresh(). Remplace concept_piece.svg + modulate (fichier supprime, cassait le chargement de
	## la scene - voir GradeLevel.get_coin_icon_path()).
	coin_icon.texture = load(GradeLevel.get_coin_icon_path(grade))
	pressed.connect(_on_pressed)
	refresh()

## Rappele a la creation, a chaque ouverture de la boutique et apres tout achat/equipement (voir
## ShopPanel._refresh_prof_skin_items) - un achat sur une AUTRE case (skin ou coffre) peut changer
## le solde ou l'etat actif affecte a celle-ci, meme raison que CrateItem.refresh_availability.
func refresh() -> void:
	var owned := ProfSkins.is_unlocked(grade, skin_index)
	var active := owned and ProfSkins.get_active_skin(grade) == skin_index

	skin_icon.modulate = Color.WHITE if owned else ICON_LOCKED_TINT

	## Bordure encre simple par defaut, doree et plus epaisse quand le skin est celui actuellement
	## porte (2026-09-03, voir le commentaire de classe) - un seul cadre visible a la fois, la
	## bordure doree REMPLACE la bordure encre plutot que de s'y ajouter.
	if active:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, ACTIVE_BORDER_COLOR, ACTIVE_BORDER_WIDTH)
	else:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, INK_COLOR, NORMAL_BORDER_WIDTH)

	## Plus rien a payer une fois possede (achete ou deja actif) : le prix n'a de sens que sur
	## une case pas encore achetee. coin_icon (son enfant PriceLabel suit) : plus de PriceBadge a
	## cacher separement depuis son retrait (voir le .tscn et le commentaire de classe).
	coin_icon.visible = not owned
	if not owned:
		price_label.text = str(ProfSkins.SKIN_PRICE)
		## RESTE CLIQUABLE meme si le solde est insuffisant (2026-09-05, retour utilisateur :
		## "pour lachat de tenue npc, cliquer actuellement sur une case sans le montant
		## correspondant ne fait aucune action, je veux un popup") - desactiver le bouton ici
		## empechait purchase_requested de partir du tout (un Button.disabled ne recoit jamais
		## "pressed"), donc ShopPanel._on_prof_skin_purchase_requested n'avait jamais l'occasion
		## d'afficher le message. Le controle de solde se fait desormais entierement cote
		## ShopPanel (voir _on_prof_skin_purchase_requested), au clic, plutot qu'ici en amont.
		disabled = false
	else:
		## Deja porte : rien a faire de plus sur cette case (voir commentaire de classe) - les
		## cases "possede mais pas actif" restent cliquables pour switcher.
		disabled = active

func _on_pressed() -> void:
	if ProfSkins.is_unlocked(grade, skin_index):
		equip_requested.emit(grade, skin_index)
	else:
		purchase_requested.emit(grade, skin_index)

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon), meme technique
## que CrateItem._apply_flat_style.
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
