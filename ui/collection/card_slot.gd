## Vignette reutilisable pour afficher une carte (possedee ou non decouverte) dans l'album.
## Instanciee en boucle par CardAlbum.gd. Design "carte a collectionner" valide avec Steve
## (2026-07-25) : cadre epais colore selon GradeLevel.get_color(), fond creme, ombre plate
## decalee de 3px (pas de flou, esprit cartoon), icone du pet en haut, pastille de nom en bas.
## (2026-07-26 : la couleur venait de CardRarity.get_color(card.rarity) - le champ "rarity" a
## disparu de CardResource, remplace par "grade" ; GradeLevel.get_color() fait le pont vers la
## meme palette de couleurs, voir data/question/grade_level.gd.)
##
## (2026-07-26 : "Portrait" (dans card_slot.tscn) est passe de Control a MarginContainer, marge
## de 3px sur les 4 cotes + clip_contents=true, egalement sur InnerPanel - l'art du pet debordait
## du cadre et des cartes voisines dans l'album faute de marge/clipping, corrige ici plutot que
## de retoucher chaque texture source.)
##
## Tant qu'aucune image reelle n'existe pour une carte (data/card/art/<id>.png, voir
## tools/admin/import_cards.gd), l'icone generique de PetPlaceholderIcon est affichee a la
## place - le remplacement par la vraie texture est automatique des que card.texture est
## renseigne, aucun changement a faire ici.
##
## Une carte non decouverte (quantity == 0) garde le meme cadre mais en gris neutre (jamais la
## vraie couleur de classe, pour ne pas la reveler avant l'obtention) et affiche "?" a la place
## de l'icone et du nom. Le PREMIER exemplaire obtenu fixe la carte dans le livre (nom +
## couleur). Les exemplaires supplementaires s'affichent en badge "+N" en bas a droite (ces
## doublons seront plus tard echangeables/revendables, pas encore implemente).
##
## 2026-07-26 : ombre de la pastille de nom supprimee (NamePlateShadow retire de card_slot.tscn),
## et hauteur de la pastille reduite de 2px (45 -> 43px) a la demande de Steve. L'ombre plate
## generale de la carte (ShadowPanel, cf. plus haut) reste inchangee.
class_name CardSlot
extends Control

## Tailles x1.5 depuis le 2026-07-26 (refonte "5 cartes d'une categorie par page", voir
## card_album.gd) : une page n'affiche plus qu'une seule rangee de 5 cartes (une categorie =
## exactement 5 variantes depuis le passage rarete->classe), donc plus de hauteur disponible
## par carte - toutes les proportions ci-dessous sont juste l'ancien jeu de valeurs x1.5,
## le design (cadre/ombre/pastille) ne change pas, seule l'echelle change.
const CARD_SIZE := Vector2(189, 285)
const FRAME := 9.0
const OUTER_RADIUS := 30
const INNER_RADIUS := 21
const NAME_HEIGHT := 43 # 2026-07-26 : 45 -> 43 (demande Steve)
const SHADOW_OFFSET := 4.5

## Couleurs reprises telles quelles de la charte graphique existante (ui/theme/game_theme.tres)
## pour rester coherent avec le reste de l'UI.
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
## 2026-07-26 : assombri de #888780 (gris moyen) a #5F5E5A (gris fonce) a la demande de Steve.
const SHADOW_COLOR := Color(0.372549, 0.368627, 0.352941) # #5F5E5A
const BORDER_COLOR := Color(0.827451, 0.819608, 0.788235) # #D3D1C7
const UNKNOWN_COLOR := Color(0.694118, 0.690196, 0.662745) # gris neutre, carte non decouverte

@onready var shadow_panel: Panel = $ShadowPanel
@onready var card_frame: Panel = $CardFrame
@onready var inner_panel: Panel = $CardFrame/InnerPanel
@onready var pet_texture: TextureRect = $CardFrame/InnerPanel/VBox/Portrait/PetTexture
@onready var placeholder_icon: PetPlaceholderIcon = $CardFrame/InnerPanel/VBox/Portrait/PlaceholderIcon
@onready var unknown_mark: Label = $CardFrame/InnerPanel/VBox/Portrait/UnknownMark
@onready var nameplate: Panel = $CardFrame/InnerPanel/VBox/NameWrap/NamePlate
@onready var name_label: Label = $CardFrame/InnerPanel/VBox/NameWrap/NamePlate/NameLabel
@onready var extra_label: Label = $ExtraLabel

func _ready() -> void:
	custom_minimum_size = CARD_SIZE + Vector2(SHADOW_OFFSET, SHADOW_OFFSET)
	pet_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	## Sans ca, TextureRect impose sa taille minimum = resolution native de la texture (512x612,
	## voir project_card_art_spec.md), ce qui ecrase la mise en page du VBox (Portrait/NameWrap) :
	## la pastille de nom se retrouve poussee hors des limites visibles et clip_contents la
	## masque, et l'image est affichee "cover"/zoomee-recadree au lieu d'un vrai "contain".
	## EXPAND_IGNORE_SIZE laisse le control retrecir en dessous de la taille de la texture, pour
	## que STRETCH_KEEP_ASPECT_CENTERED fasse vraiment tenir l'image entiere dans la carte.
	pet_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_apply_flat_style(shadow_panel, SHADOW_COLOR, OUTER_RADIUS)
	_apply_flat_style(inner_panel, CREAM_COLOR, INNER_RADIUS)

## quantity : nombre d'exemplaires possedes (0 = pas encore obtenue).
func display(card: CardResource, quantity: int) -> void:
	var owned := quantity > 0
	var frame_color := GradeLevel.get_color(card.grade) if owned else UNKNOWN_COLOR
	var text_color := Color.WHITE if (owned and card.grade == GradeLevel.Grade.CM2) else INK_COLOR

	_apply_flat_style(card_frame, frame_color, OUTER_RADIUS, BORDER_COLOR, 1)
	_apply_flat_style(nameplate, frame_color, NAME_HEIGHT / 2)

	pet_texture.visible = owned and card.texture != null
	pet_texture.texture = card.texture if owned else null
	placeholder_icon.visible = owned and card.texture == null
	placeholder_icon.set_colors(frame_color, text_color)
	unknown_mark.visible = not owned

	name_label.text = card.display_name if owned else "?"
	name_label.add_theme_color_override("font_color", text_color)

	var extra := quantity - 1
	extra_label.visible = extra > 0
	if extra > 0:
		extra_label.text = "+%d" % extra

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon) sur un Panel.
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
