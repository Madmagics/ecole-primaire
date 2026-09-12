## Case de musiques de classe (onglet "Succes" de la boutique, 2eme ligne - 2026-09-06, retour
## utilisateur : "ajoute 5 cases en 2eme ligne de l onglet succes. lorsque les defis sont aux
## niveaux argent on debloquera de nouvelles musiques que je provisionnerai plus tard") - voir
## ClassroomMusic pour l'etat debloque/verrouille (palier ARGENT, contrairement a ClassroomDecor
## qui exige l'or) et shop_panel.gd pour l'instanciation (une case par classe, ajoutee au MEME
## ItemGrid que ClassroomDecorItem - 10 cases sur 5 colonnes forment naturellement 2 lignes, pas
## besoin d'un 2e GridContainer). Meme construction a cadre unique que CrateItem/ProfSkinItem/
## ClassroomDecorItem (Frame = fond+bordure en un seul Panel, Button racine flat=true) - voir
## project_shop_tab_frame en memoire projet pour l'historique de cette convention.
##
## MusicIcon : musique-on.webp (icone de reglage son existante, la plus proche du concept
## "musique" disponible dans le projet) utilisee en PLACEHOLDER en attendant la vraie icone/les
## vrais morceaux ("que je provisionnerai plus tard", retour utilisateur) - a remplacer ici des
## qu'un asset dedie existe.
##
## ChallengeIcon/CountLabel : identique a ClassroomDecorItem (meme icone defis.webp partagee, meme
## affichage "valides/requis" au palier argent plutot qu'au palier or) - voir son commentaire de
## classe pour le detail, non duplique ici.
##
## Selection/desactivation (2026-09-06, 2e passe, retour utilisateur : "afin de pouvoir
## selectionner le decor de classe de base ou la musique originale: selectionner une case fera
## changer le decor ou la musique, recliquer sur une case active deselectionnera celle si et
## retournera le decor ou la musique de base, active cette fonction") - identique a
## ClassroomDecorItem (meme mecanique bordure doree/active, meme case qui reste cliquable une
## fois debloquee car le reclic EST l'action de desactivation) - voir son commentaire de classe
## pour le detail, non duplique ici.
class_name ClassroomMusicItem
extends Button

signal purchase_requested(grade: GradeLevel.Grade)
## Emis au clic sur une case deja debloquee (active OU inactive) - ClassroomMusic.toggle_active
## fait le travail reel, voir ShopPanel._on_classroom_music_toggle_requested.
signal toggle_requested(grade: GradeLevel.Grade)

const OUTER_RADIUS := 16
## Couleurs reprises de CrateItem/ProfSkinItem/ClassroomDecorItem pour rester coherent.
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const NORMAL_BORDER_WIDTH := 2
## Bordure "surbrillance" de la musique actuellement appliquee - meme jaune que
## ClassroomDecorItem.ACTIVE_BORDER_*.
const ACTIVE_BORDER_COLOR := Color(1, 0.85, 0.2)
const ACTIVE_BORDER_WIDTH := 4
## Teinte appliquee a l'icone tant que les musiques ne sont pas debloquees - meme valeur que
## ClassroomDecorItem.ICON_LOCKED_TINT.
const ICON_LOCKED_TINT := Color(0.55, 0.55, 0.55)

## Classe representee par cette case - fixee une fois pour toutes par ShopPanel a l'instanciation
## (voir shop_panel.gd), jamais modifiee ensuite.
@export var grade: GradeLevel.Grade

@onready var frame_panel: Panel = $Frame
@onready var music_icon: TextureRect = $Frame/MusicIcon
@onready var challenge_icon: TextureRect = $Frame/ChallengeIcon
@onready var count_label: Label = $Frame/ChallengeIcon/CountLabel

func _ready() -> void:
	music_icon.texture = load("res://assets/classe2.0/icones/musique-on.webp")
	challenge_icon.texture = load("res://assets/classe2.0/icones/defis.webp")
	pressed.connect(_on_pressed)
	refresh()

## Rappelee a la creation, a chaque ouverture de la boutique et apres tout achat/pack/bascule
## termine sans faute (voir ShopPanel._refresh_classroom_music_items) - meme raison que
## ClassroomDecorItem.refresh().
func refresh() -> void:
	var owned := ClassroomMusic.is_unlocked(grade)
	var active := ClassroomMusic.is_active(grade)

	music_icon.modulate = Color.WHITE if owned else ICON_LOCKED_TINT

	if active:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, ACTIVE_BORDER_COLOR, ACTIVE_BORDER_WIDTH)
	else:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, INK_COLOR, NORMAL_BORDER_WIDTH)

	challenge_icon.visible = not owned
	if not owned:
		count_label.text = "%d/%d" % [ClassroomMusic.get_validated_count(grade), ClassroomMusic.get_required_count(grade)]

	## Reste cliquable meme une fois debloquee (et meme active) - meme raison que
	## ClassroomDecorItem.refresh().
	disabled = false

func _on_pressed() -> void:
	if ClassroomMusic.is_unlocked(grade):
		toggle_requested.emit(grade)
	else:
		purchase_requested.emit(grade)

## Cree et applique un StyleBoxFlat plat, meme technique que CrateItem._apply_flat_style/
## ProfSkinItem._apply_flat_style/ClassroomDecorItem._apply_flat_style.
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
