## Fenetre "Succes" : page vide en reserve pour un futur systeme de succes/objectifs (evenements
## cles offrant des recompenses, pas encore concu - a construire plus tard, voir memoire projet).
## Remplace SectionDefis (2026-08-26, retour utilisateur : "on va y transferer l'icone actuelle
## defis qu'on va renommer en succes, on y mettra des succes plus tard correspondant a des
## evenements cles offrant des recompenses") : jusque-la une section interne de GameMenuPanel,
## Defis quitte le menu de la meme facon que Collection/Sac de pieces/Inventaire l'avaient fait le
## 2026-08-25 - devient un panneau modal autonome, ouvert depuis le nouveau dock "Sac a dos" en
## haut a droite (voir ui/hud/backpack_menu.gd), pas depuis GameMenuPanel.
## Meme convention que les autres panneaux modaux du jeu (CardAlbum, InventoryPanel, BackpackPanel
## avant sa retraite) : cadre en pourcentage d'ecran, verrouille les deplacements du joueur tant
## qu'elle est visible, se ferme avec Echap ou le CloseButton en haut de la colonne (voir plus bas,
## 2026-08-29 - plus de croix propre a la fenetre). Pas de raccourci clavier propre (meme raison que
## Defis avant elle : rien a reserver sans besoin reel, page encore vide).
##
## Panel racine en Panel (pas PanelContainer) avec marges fixes 40px sur les 4 cotes, meme format
## que GameMenuPanel/CardAlbum (2026-08-26, retour utilisateur : "les fenetres qui popent suite a
## l activation des menus de la colonne de droite doivent avoir le meme format que les fenetres
## qui souvrent par le menu de gauche") - voir InventoryPanel.gd pour le detail du mecanisme
## (PanelContainer/panel = style "ligne de liste" blanc/fin, pas adapte a une fenetre entiere).
##
## offset_right passe a -113 (etait -40) le meme jour, retour utilisateur suivant : la fenetre doit
## border directement IconDock (93px + 20px de marge ecran), pas flotter avec un vide visible entre
## les deux - meme raison qu'InventoryPanel.gd, voir son commentaire pour le detail. Un seul
## panneau de la colonne BackpackMenu reste visible a la fois (voir BackpackMenu._open_panel()).
##
## Marges resserrees (2026-08-29, meme retour utilisateur qu'InventoryPanel.gd, voir son commentaire
## pour le detail) : offset_left 40->20, offset_top/bottom 40/-40->20/-20 (marge ecran), offset_right
## -113->-123 (marge colonne<->fenetre 0->10px).
##
## Croix de fermeture retiree (2026-08-29, retour utilisateur : "dorenavant la fermeture de
## l ensemble colonne d icone et fermeture fenetre soperera par la touche ECHAP ou une croix situee
## en haut de la colonne au lieu de la croix dans chaque fenetre qui sera a enlever") : HeaderSpacer
## (qui ne servait qu'a pousser cette croix a droite) retire aussi, devenu inutile. Cette fenetre se
## ferme desormais uniquement via Echap (_unhandled_input ci-dessous, inchange) ou via le nouveau
## CloseButton en haut d'IconDock (voir BackpackMenu.gd/icon_dock.tscn).
##
## Titre centre + barre de separation (2026-08-29, meme jour, retour utilisateur : "applique la
## configuration des fenetres de gauche a celle de la boutique, positionnement du titre, barre de
## separation couleur de fond theme etc, pareil pour defis") : HeaderRow gagne alignment=1 (centre
## TitleLabel, comme TitleRow dans game_menu_panel.tscn - jusque-la aligne a gauche par defaut).
## TitleSeparator (HSeparator) ajoute juste apres HeaderRow, meme convention que GameMenuPanel/
## ShopPanel (deja stylee dans les 4 themes, voir CHARTE_GRAPHIQUE.md). Cette fenetre n'avait
## jamais eu de separateur : sa page etant encore vide (PlaceholderLabel), l'absence ne se voyait
## pas visuellement autant qu'ailleurs, mais cassait l'uniformite demandee ici.
##
## Geometrie du titre/separateur calquee pixel pour pixel sur GameMenuPanel (2026-08-29, meme jour,
## retour utilisateur avec captures d'ecran, voir le commentaire de classe de shop_panel.gd pour le
## detail complet du probleme) : meme correctif qu'applique a ShopPanel - HeaderRow/TitleLabel/
## TitleSeparator sortent du flux Margin/Content (leur position derivait de la hauteur du Label,
## donc n'etait pas pixel-identique a gauche malgre alignment=1). TitleRow et TitleSeparator
## deviennent des enfants directs de Panel avec les memes offsets que dans game_menu_panel.tscn
## (titre : offset_top=10/bottom=40 ; separateur : offset_top=55/bottom=59). Margin (PlaceholderLabel)
## demarre a offset_top=80, margin_top=0 en interne.
##
## Icone de titre clonee du bouton "Succès" (2026-09-02, retour utilisateur : "je veux que l icone
## de chaque fenetre apparaisse aussi a gauche du titre de la fenetre... il faut que l icone dans
## la fentre a cote du titre soit un clone de celle du menu, en changeant un on change l autre") :
## title_icon_source_path (NodePath, assigne dans game_ui.tscn vers ../BackpackMenu/IconDock/
## IconList/SuccesButton) et title_icon.texture = bouton.icon en _ready(), jamais un fichier
## duplique - meme mecanisme que ShopPanel.title_icon (voir son commentaire de classe).
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## (Echap pour fermer) est retire - CloseButton en haut de la colonne BackpackMenu fait deja ca a
## la souris/au tactile.
class_name SuccessPanel
extends Control

## Contenu "Défis" (2026-09-05, retour utilisateur : "dans la fenetre DEFIS, on va lister des
## defis a realiser... on va faire des blocs de defis par classe, reussite dans chaque matiere") -
## remplace le PlaceholderLabel ("Bientôt disponible !") : garde le nom "Succès" affiché (retour
## utilisateur explicite : "on garde le nom succes") - seul le CONTENU de cette fenêtre, jusque-là
## vide, change. Un défi = une classe + une matière, avec une seule barre de progression recolorée
## bronze/argent/or au fil des paliers (voir _tier_color) plutôt que 3 barres séparées - le
## detail des seuils et de l'incrémentation vit dans ChallengeTracker (nouvel autoload, voir son
## commentaire de classe), cette fenêtre ne fait que lire ChallengeTracker/QuestionBankScanner et
## reconstruire ses lignes au runtime, sans dupliquer leurs données (même règle que SectionStats
## avant son retrait le même jour, voir feedback_lightweight_game.md).
##
## Un cadre par classe (VBoxContainer de lignes "matière"), même carte que toutes les fenêtres du
## jeu (StyleBox "Panel" du thème actif dupliqué) mais bordure recolorée en GradeLevel.get_color()
## (voir _build_grade_frame - 2026-09-06, retour utilisateur : "on a un double cadre autour des
## classes, laisse uniquement le cadre de couleur de la classe" : la 1ère version empilait ce
## cadre colore ET un 2e PanelContainer interne pour un effet d'anneau, comme
## SubjectSelectPanel._build_subject_frame - mais ce 2e panneau avait sa PROPRE bordure de theme
## en plus de la 1ere, d'ou le double cadre). Une ligne "matière" par matière RÉELLEMENT disponible
## pour cette classe (QuestionBankScanner.get_available_subjects, pas une liste figée - une classe
## comme le CP, jamais scindée en Grammaire/Conjugaison/Orthographe, n'affiche qu'un seul défi
## "Français" là où CE1-CM2 en affichent 3, reflet honnête du contenu réel).

## Bouton IconDock a cloner pour title_icon (voir commentaire de classe) - assigne dans game_ui.tscn.
@export var title_icon_source_path: NodePath

## Palier avant meme le bronze (2026-09-06, retour utilisateur : "la couleur de depart devrait
## etre gris fonce entre 0 et 4 defis reussis") - 4 couleurs au total pour 4 paliers, voir
## _tier_color().
const _UNSTARTED_COLOR := Color("6E6E6E")
const _BRONZE_COLOR := Color("CD7F32")
const _SILVER_COLOR := Color("C0C0C0")
const _GOLD_COLOR := Color("FFD700")

## Ordre d'affichage des cadres de classe (CP en premier) - l'enum GradeLevel.Grade est deja range
## dans cet ordre mais on l'explicite ici plutot que de dependre de son ordre de declaration.
const _GRADES: Array[GradeLevel.Grade] = [
	GradeLevel.Grade.CP,
	GradeLevel.Grade.CE1,
	GradeLevel.Grade.CE2,
	GradeLevel.Grade.CM1,
	GradeLevel.Grade.CM2,
]

## Separation interne des lignes matiere (le VBox des cadres de classe utilise sa propre valeur,
## fixee dans le .tscn - voir GradesContainer).
const _ROW_SEPARATION := 10

@onready var title_icon: TextureRect = $Panel/TitleRow/TitleIcon
@onready var grades_container: VBoxContainer = $Panel/Margin/Content/ScrollContainer/GradesContainer

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	## Glissement au doigt possible depuis n'importe quelle zone (pas seulement la fine barre
	## de defilement) - voir ui/common/touch_scroll_fix.gd (retour utilisateur 2026-09-18).
	TouchScrollFix.allow_scroll_passthrough(self)
	var icon_source := get_node_or_null(title_icon_source_path) as Button
	if icon_source:
		title_icon.texture = icon_source.icon
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
		refresh()
	else:
		PlayerInputLock.unlock()

## Appele par BackpackMenu (colonne "Sac a dos", voir ui/hud/backpack_menu.gd).
func open() -> void:
	show()

func close() -> void:
	hide()

## Reconstruit entierement la liste des Défis (voir commentaire de classe) - appelee a chaque
## ouverture (_on_visibility_changed ci-dessus), jamais mise a jour ligne par ligne : la fenetre
## ne peut de toute facon pas rester ouverte pendant qu'un pack est en cours (voir
## SubjectSelectPanel, qui masque le dock "Sac a dos" tant qu'un PNJ est actif), donc rien ne
## change tant qu'elle est visible.
func refresh() -> void:
	for child in grades_container.get_children():
		child.queue_free()
	for grade in _GRADES:
		grades_container.add_child(_build_grade_frame(grade))

func _build_grade_frame(grade: GradeLevel.Grade) -> PanelContainer:
	var frame := PanelContainer.new()
	## Duplique le style "Panel" du theme actif (meme fond/coins/epaisseur de bordure que TOUTES
	## les fenetres du jeu, voir game_theme.tres StyleBoxFlat_panel) et recolore uniquement sa
	## bordure - un seul StyleBox donc un seul cadre visible (voir commentaire de classe, retour
	## utilisateur du 2026-09-06). .duplicate() est indispensable ici : sans lui, cette
	## modification s'appliquerait au StyleBox PARTAGE par toutes les fenetres du theme.
	var base_style := get_theme_stylebox("panel", "Panel")
	var frame_style := (base_style.duplicate() if base_style else StyleBoxFlat.new()) as StyleBoxFlat
	frame_style.border_color = GradeLevel.get_color(grade)
	frame.add_theme_stylebox_override("panel", frame_style)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 12)
	frame.add_child(margin)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", _ROW_SEPARATION)
	margin.add_child(content)

	var title := Label.new()
	title.theme_type_variation = &"TitleLabel"
	title.text = GradeLevel.get_label(grade)
	content.add_child(title)

	for subject in QuestionBankScanner.get_available_subjects(grade):
		content.add_child(_build_subject_row(grade, subject))

	return frame

## Une ligne = un défi : libellé de matière (couleur SubjectType.get_color, meme code couleur que
## partout ailleurs dans le jeu) + barre de progression + décompte "X / GOLD_GOAL" a droite (retour
## utilisateur : "une barre de progression... et un decompte de progression apres la barre").
func _build_subject_row(grade: GradeLevel.Grade, subject: SubjectType.Subject) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)

	var label := Label.new()
	label.text = SubjectType.get_label(subject)
	label.add_theme_color_override("font_color", SubjectType.get_color(subject))
	## 240px (etait 190) : "Comprehension de texte" (le libelle le plus long) etait rogne par la
	## barre juste apres (2026-09-06, retour utilisateur : "comprehension de texte est coupe par
	## la barre, decale le debut des barres pour eviter de rogner du texte"). clip_text reste en
	## securite si un futur libelle depassait quand meme cette largeur.
	label.custom_minimum_size = Vector2(240, 0)
	label.clip_text = true
	row.add_child(label)

	var count := ChallengeTracker.get_count(grade, subject)

	var bar := ProgressBar.new()
	bar.min_value = 0
	bar.max_value = ChallengeTracker.GOLD_GOAL
	bar.value = count
	bar.show_percentage = false
	bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bar.custom_minimum_size = Vector2(0, 22)
	var fill_style := StyleBoxFlat.new()
	fill_style.bg_color = _tier_color(count)
	fill_style.set_corner_radius_all(8)
	bar.add_theme_stylebox_override("fill", fill_style)
	row.add_child(bar)

	var count_label := Label.new()
	count_label.text = "%d / %d" % [count, ChallengeTracker.GOLD_GOAL]
	count_label.custom_minimum_size = Vector2(64, 0)
	count_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	row.add_child(count_label)

	return row

## Couleur de la barre selon le palier en cours (voir ChallengeTracker.BRONZE_GOAL/SILVER_GOAL/
## GOLD_GOAL) - la barre elle-meme reste continue de 0 a GOLD_GOAL (voir _build_subject_row),
## seule sa couleur change en franchissant chaque seuil. 4 paliers (2026-09-06, retour
## utilisateur) : gris fonce (0-4, defi pas encore commence) -> bronze (5-19) -> argent (20-49) ->
## or (GOLD_GOAL, defi termine).
func _tier_color(count: int) -> Color:
	if count >= ChallengeTracker.GOLD_GOAL:
		return _GOLD_COLOR
	if count >= ChallengeTracker.SILVER_GOAL:
		return _SILVER_COLOR
	if count >= ChallengeTracker.BRONZE_GOAL:
		return _BRONZE_COLOR
	return _UNSTARTED_COLOR
