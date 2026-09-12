## Case de decor de classe (nouvel onglet "Succes" de la boutique, 2026-09-06, retour utilisateur :
## "je veux me servir des succes remportés comme monnaie pour debloquer de nouveaux environnements
## de classe (nouveau decor) achetable si les succes sont validés (5 pour le cp et 7 pour les
## autres) on creera 5 cases a acheter licone sera 'defis' pour remplacer licone de pieces des
## autres onglets, litem a acheter (icone) sera créé prochainement") - voir ClassroomDecor pour
## l'etat debloque/verrouille et shop_panel.gd pour l'instanciation (une case par classe, meme
## PROF_SKIN_GRADES que les onglets de skins). Meme construction a cadre unique que CrateItem/
## ProfSkinItem (Frame = fond+bordure en un seul Panel, Button racine flat=true) - voir
## project_shop_tab_frame en memoire projet pour l'historique de cette convention et le bug de
## double cadre qu'elle evite.
##
## DecorIcon : badge-<classe>.webp (GradeLevel.get_badge_icon_path) utilise en PLACEHOLDER en
## attendant la vraie icone de decor par classe ("litem a acheter (icone) sera cree prochainement",
## retour utilisateur) - a remplacer ici des qu'un asset dedie existe.
##
## ChallengeIcon/CountLabel : meme role/position que CoinIcon/PriceLabel de CrateItem/ProfSkinItem
## (icone sans cadre propre, fond transparent), mais avec assets/classe2.0/icones/defis.webp
## (icone unique partagee, pas de variante par classe comme piece-<classe>.webp - "l'icone sera
## defis") et un texte "valides/requis" (ex: "3/7", voir refresh()) plutot qu'un prix fixe : rien
## n'est jamais depense ici (ClassroomDecor.get_validated_count ne redescend jamais), donc une
## progression a affichier plutot qu'un cout.
##
## Selection/desactivation (2026-09-06, 2e passe, retour utilisateur : "afin de pouvoir
## selectionner le decor de classe de base ou la musique originale: selectionner une case fera
## changer le decor ou la musique, recliquer sur une case active deselectionnera celle si et
## retournera le decor ou la musique de base, active cette fonction") - meme mecanique bordure
## doree/active que ProfSkinItem (ACTIVE_BORDER_*, voir refresh()), avec UNE DIFFERENCE
## deliberee : une case debloquee reste CLIQUABLE meme quand elle est active (disabled = false
## dans tous les cas des que debloque), contrairement a ProfSkinItem qui desactive la case du
## skin actuellement porte (disabled = active, reclic = no-op) - ici un 2e clic sur une case
## active EST l'action de desactivation (voir _on_pressed), donc la case ne doit jamais devenir
## non-cliquable une fois debloquee.
class_name ClassroomDecorItem
extends Button

signal purchase_requested(grade: GradeLevel.Grade)
## Emis au clic sur une case deja debloquee (active OU inactive) - ClassroomDecor.toggle_active
## fait le travail reel, voir ShopPanel._on_classroom_decor_toggle_requested.
signal toggle_requested(grade: GradeLevel.Grade)

const OUTER_RADIUS := 16
## Couleurs reprises de CrateItem/ProfSkinItem pour rester coherent avec le reste de l'UI.
const CREAM_COLOR := Color(1, 0.941176, 0.839216) # #FFF0D6
const INK_COLOR := Color(0.478431, 0.290196, 0.168627) # #7A4A2B
const NORMAL_BORDER_WIDTH := 2
## Bordure "surbrillance" du decor actuellement applique - meme jaune que ProfSkinItem.
## ACTIVE_BORDER_* (seul autre accent dore deja utilise dans l'UI du jeu).
const ACTIVE_BORDER_COLOR := Color(1, 0.85, 0.2)
const ACTIVE_BORDER_WIDTH := 4
## Teinte appliquee au badge tant que le decor n'est pas debloque - meme valeur que
## ProfSkinItem.ICON_LOCKED_TINT.
const ICON_LOCKED_TINT := Color(0.55, 0.55, 0.55)

## Classe representee par cette case - fixee une fois pour toutes par ShopPanel a l'instanciation
## (voir shop_panel.gd), jamais modifiee ensuite.
@export var grade: GradeLevel.Grade

@onready var frame_panel: Panel = $Frame
@onready var decor_icon: TextureRect = $Frame/DecorIcon
@onready var challenge_icon: TextureRect = $Frame/ChallengeIcon
@onready var count_label: Label = $Frame/ChallengeIcon/CountLabel

func _ready() -> void:
	decor_icon.texture = load(GradeLevel.get_badge_icon_path(grade))
	challenge_icon.texture = load("res://assets/classe2.0/icones/defis.webp")
	pressed.connect(_on_pressed)
	refresh()

## Rappelee a la creation, a chaque ouverture de la boutique et apres tout achat/pack/bascule
## termine sans faute (voir ShopPanel._refresh_classroom_decor_items) - un pack reussi ailleurs
## peut faire progresser un Defi qui concerne cette case, meme raison que
## CrateItem.refresh_availability.
func refresh() -> void:
	var owned := ClassroomDecor.is_unlocked(grade)
	var active := ClassroomDecor.is_active(grade)

	decor_icon.modulate = Color.WHITE if owned else ICON_LOCKED_TINT

	## Bordure encre simple par defaut, doree et plus epaisse quand ce decor est actuellement
	## applique - meme logique que ProfSkinItem.refresh (appelee ici a chaque refresh() plutot
	## qu'une seule fois dans _ready(), puisque l'etat actif peut changer).
	if active:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, ACTIVE_BORDER_COLOR, ACTIVE_BORDER_WIDTH)
	else:
		_apply_flat_style(frame_panel, CREAM_COLOR, OUTER_RADIUS, INK_COLOR, NORMAL_BORDER_WIDTH)

	challenge_icon.visible = not owned
	if not owned:
		count_label.text = "%d/%d" % [ClassroomDecor.get_validated_count(grade), ClassroomDecor.get_required_count(grade)]

	## Reste cliquable meme une fois debloque (et meme actif) - contrairement a ProfSkinItem, un
	## reclic sur une case active EST l'action de desactivation, voir le commentaire de classe.
	disabled = false

func _on_pressed() -> void:
	if ClassroomDecor.is_unlocked(grade):
		toggle_requested.emit(grade)
	else:
		purchase_requested.emit(grade)

## Cree et applique un StyleBoxFlat plat (pas de degrade/flou, esprit cartoon), meme technique que
## CrateItem._apply_flat_style/ProfSkinItem._apply_flat_style.
func _apply_flat_style(panel: Panel, color: Color, radius: int, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(radius)
	if border_width > 0:
		style.set_border_width_all(border_width)
		style.border_color = border_color
	panel.add_theme_stylebox_override("panel", style)
