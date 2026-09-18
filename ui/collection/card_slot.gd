## Vignette reutilisable pour afficher une carte (possedee ou non decouverte) dans l'album.
## Instanciee en boucle par CardAlbum.gd. Design "carte a collectionner" valide avec Steve
## (2026-07-25) : cadre epais colore selon GradeLevel.get_color(), fond creme, ombre plate
## decalee de 3px (pas de flou, esprit cartoon), icone du pet en haut, pastille de nom en bas.
## (2026-07-26 : la couleur venait de CardRarity.get_color(card.rarity) - le champ "rarity" a
## disparu de CardResource, remplace par "grade" ; GradeLevel.get_color() faisait alors le pont
## vers la meme palette de couleurs, voir data/question/grade_level.gd. 2026-08-30 : GradeLevel a
## desormais sa propre palette fixe par classe (bleu/vert/jaune/violet/rouge), independante de
## CardRarity - le cadre de cette carte suit donc automatiquement le nouveau code couleur.)
##
## (2026-07-26 : "Portrait" (dans card_slot.tscn) est passe de Control a MarginContainer, marge
## de 3px sur les 4 cotes + clip_contents=true, egalement sur InnerPanel - l'art du pet debordait
## du cadre et des cartes voisines dans l'album faute de marge/clipping, corrige ici plutot que
## de retoucher chaque texture source.)
##
## Tant qu'aucune image reelle n'existe pour une carte (assets/classe2.0/pets/<id>.webp, voir
## tools/admin/import_cards.gd - dossier deplace le 2026-08-30, etait data/card/art/ avant),
## l'icone generique de PetPlaceholderIcon est affichee a la place - le remplacement par la vraie
## texture est automatique des que card.texture est renseigne, aucun changement a faire ici.
## Les 125 cartes ont toutes leur art depuis ce meme jour (assets/classe2.0/pets/ couvre 1-125
## sans trou) : cette branche placeholder reste en place pour une future carte sans art, mais
## n'est plus declenchee actuellement.
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
##
## 2026-09-03 : "nom" dans cards.csv contient desormais un prenom (Grisou, Suki, ...) au lieu du
## descriptif de variante (Sauvage, Siamois, ...) - voir csv/prenoms_cartes.csv pour la
## correspondance. name_label affiche donc automatiquement le prenom (aucun changement de code
## necessaire ici, juste la donnee). En echange, la classe (CP-CM2) n'etait plus lisible nulle
## part sur la carte : ajout d'un badge (GradeBadge, TextureRect) en haut a gauche du portrait,
## par-dessus le dessin mais volontairement petit pour ne pas le recouvrir - utilise l'icone
## medaille deja existante assets/classe2.0/icones/badge-<CLASSE>.webp (voir
## GradeLevel.get_badge_icon_path(), premiere version dessinee en code/Panel+Label corrigee tout
## de suite apres, Steve voulait ces icones-la). Meme regle de decouverte que le reste de la
## carte : cache tant que la carte n'est pas possedee (owned == false), pour ne pas reveler la
## classe avant l'obtention.
class_name CardSlot
extends Control

## Tailles x1.5 depuis le 2026-07-26 (refonte "5 cartes d'une categorie par page", voir
## card_album.gd) : une page n'affiche plus qu'une seule rangee de 5 cartes (une categorie =
## exactement 5 variantes depuis le passage rarete->classe), donc plus de hauteur disponible
## par carte - toutes les proportions ci-dessous sont juste l'ancien jeu de valeurs x1.5,
## le design (cadre/ombre/pastille) ne change pas, seule l'echelle change.
##
## 2026-09-03 : x0.95 supplementaire (Steve : "diminue la taille des cartes de 5%", refonte du
## style du livre) - meme principe que le x1.5 ci-dessus, toutes les proportions reduites du
## meme facteur (voir aussi les offsets de card_slot.tscn, mis a jour en consequence).
const CARD_SIZE := Vector2(179.55, 270.75)
const FRAME := 8.55
const OUTER_RADIUS := 29
const INNER_RADIUS := 20
const NAME_HEIGHT := 41 # 2026-07-26 : 45 -> 43 (demande Steve), 2026-09-03 : 43 -> 41 (x0.95)
const SHADOW_OFFSET := 4.28

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
@onready var grade_badge: TextureRect = $CardFrame/InnerPanel/GradeBadge
@onready var extra_label: Label = $ExtraLabel

func _ready() -> void:
	## Cree dynamiquement (pas dans le _ready() du panneau parent) : se corrige donc soi-meme
	## pour rester attrapable au doigt en glissement depuis un ScrollContainer parent, plutot
	## que de dependre du moment ou ce panneau a ete peuple - voir ui/common/touch_scroll_fix.gd
	## (retour utilisateur 2026-09-18).
	mouse_filter = Control.MOUSE_FILTER_PASS
	custom_minimum_size = CARD_SIZE + Vector2(SHADOW_OFFSET, SHADOW_OFFSET)
	pet_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	## Sans ca, TextureRect impose sa taille minimum = resolution native de la texture (512x612,
	## voir project_card_art_spec.md), ce qui ecrase la mise en page du VBox (Portrait/NameWrap) :
	## la pastille de nom se retrouve poussee hors des limites visibles et clip_contents la
	## masque, et l'image est affichee "cover"/zoomee-recadree au lieu d'un vrai "contain".
	## EXPAND_IGNORE_SIZE laisse le control retrecir en dessous de la taille de la texture, pour
	## que STRETCH_KEEP_ASPECT_CENTERED fasse vraiment tenir l'image entiere dans la carte.
	pet_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	## Meme raison que pet_texture ci-dessus : les icones badge-<CLASSE>.webp font ~100x120px
	## nativement, largement plus que les 34x42px voulus ici (voir offsets dans card_slot.tscn).
	grade_badge.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	grade_badge.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_apply_flat_style(shadow_panel, SHADOW_COLOR, OUTER_RADIUS)
	_apply_flat_style(inner_panel, CREAM_COLOR, INNER_RADIUS)

## quantity : nombre d'exemplaires possedes (0 = pas encore obtenue).
func display(card: CardResource, quantity: int) -> void:
	var owned := quantity > 0
	var frame_color := GradeLevel.get_color(card.grade) if owned else UNKNOWN_COLOR
	var text_color := Color.WHITE if (owned and card.grade == GradeLevel.Grade.CM2) else INK_COLOR

	_apply_flat_style(card_frame, frame_color, OUTER_RADIUS, BORDER_COLOR, 1)
	## Division entiere volontaire : _apply_flat_style attend un rayon en pixels (int), la perte
	## de la partie decimale (43/2 = 21 au lieu de 21.5) est invisible a l'ecran.
	@warning_ignore("integer_division")
	_apply_flat_style(nameplate, frame_color, NAME_HEIGHT / 2)

	pet_texture.visible = owned and card.texture != null
	pet_texture.texture = card.texture if owned else null
	placeholder_icon.visible = owned and card.texture == null
	placeholder_icon.set_colors(frame_color, text_color)
	unknown_mark.visible = not owned

	name_label.text = card.display_name if owned else "?"
	name_label.add_theme_color_override("font_color", text_color)

	## Cache tant que la carte n'est pas possedee : meme regle que le cadre/le nom, la classe ne
	## doit pas se deviner avant l'obtention.
	grade_badge.visible = owned
	if owned:
		grade_badge.texture = load(GradeLevel.get_badge_icon_path(card.grade))

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
