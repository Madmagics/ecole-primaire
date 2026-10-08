## Demo-tutoriel (2026-10-08, demande Steve) : copie simplifiee de school.tscn lancee depuis
## l'ecran d'intro (bouton "Tutoriel", voir WelcomePanel), SANS compte connecte. Un seul PNJ actif
## (la maitresse du CP), les 4 autres profs ne sont que des images. Un voile noir a 50 % (voir
## TutorialSpotlight) rend tout inactif sauf un cercle autour de la cible de la quete en cours, et
## une info-bulle permanente (Bubble) deroule les quetes :
##   1-2. Une serie de 10 questions en Mathematiques puis en Francais (series fixes, voir
##        TutorialQuestions ; les autres matieres sont grisees, une matiere faite se grise aussi).
##   3. Ouvrir le menu de droite.   4. Recompenses : ouvrir un coffre du CP (seul le CP est actif,
##   voir ShopPanel.tutorial_cp_only).   5. Le Livre.   6. Les succes.
##   7. Les cours : Mathematiques CP, 1re notion, lire la fiche jusqu'a la derniere page, la fermer.
##   8. Controle parental : ouvrir le menu de gauche, l'icone est montree mais inactive (on n'entre
##      pas dedans - DemoMenuDock n'est qu'une copie visuelle du dock de GameMenuPanel).
##   9. Contenu du jeu (chiffres calcules en direct, voir _content_text).   10. Fin.
## Les pieces/cartes gagnees ne vivent qu'en memoire : Economy/CardCollection/ChallengeTracker sont
## remis a zero en entrant ET en sortant du tutoriel (sinon elles se retrouveraient dans le
## prochain compte cree ou connecte sur l'appareil). Retour a l'ecran d'intro par
## change_scene_to_file (aucun compte connecte, donc pas de session serveur a fermer).
extends Node2D

const SCHOOL_SCENE := "res://levels/school/school.tscn"
const Subject = SubjectType.Subject
const Grade = GradeLevel.Grade

## Matieres affichees dans le choix de matiere (celles du vrai CP) - seules MATH et FRENCH sont
## jouables, les autres restent grisees.
const SHOWN_SUBJECTS: Array[Subject] = [Subject.MATH, Subject.FRENCH, Subject.ENGLISH, Subject.READING, Subject.LOGIC]
const PLAYABLE_SUBJECTS: Array[Subject] = [Subject.MATH, Subject.FRENCH]

enum Step {
	NPC, CHOOSE, ANSWER, RESULT, OPEN_MENU, SHOP, REVEAL, OPEN_BOOK, BOOK, SUCCESS,
	COURS, COURS_NOTION, COURS_FICHE, COURS_FICHE_END, COURS_CLOSE,
	OPEN_LEFT, PARENTAL, CONTENT, DONE,
}
enum Place { TOP, BOTTOM, BOTTOM_RIGHT, CENTER }

const QUEST_TITLES := [
	"Ta première série", "Ta deuxième série", "Le menu", "Les récompenses",
	"Le Livre", "Les succès", "Les cours", "Le contrôle parental", "Le contenu du jeu",
	"Fin de la visite",
]
const BUBBLE_WIDTH := 620.0
## Bulle "compacte" pendant une serie de questions : une seule ligne, tenue dans la marge du haut de
## QuestionPanel (8 % de 648 px) pour ne cacher ni la question ni le resultat.
const BUBBLE_WIDTH_COMPACT := 900.0
const BUBBLE_MARGIN := 8.0
const BUBBLE_MARGIN_COMPACT := 3.0
## Style propre a l'info-bulle (2026-10-08, retour Steve : meme fond que les fenetres du jeu, "ca
## fait fouillis") : lavande pastel + bordure violette + ombre portee, pour qu'elle se lise comme
## une couche posee PAR-DESSUS le jeu et ne se confonde avec aucune fenetre (aucune n'utilise de
## violet, couleur seulement associee au CM1 dans le code couleur des classes).
const BUBBLE_BG := Color("EEE6FF")
const BUBBLE_BORDER := Color("7E57C2")
const BUBBLE_TEXT := Color("3E2470")

@onready var _npc_click: InteractableComponent2D = $NPCs/NPC_CP/InteractableComponent
@onready var _npc_visual: Sprite2D = $NPCs/NPC_CP/ProfVisual
@onready var _question_panel: QuestionPanel = $UI/QuestionPanel
@onready var _subject_panel: SubjectSelectPanel = $UI/SubjectSelectPanel
@onready var _shop_panel: ShopPanel = $UI/ShopPanel
@onready var _card_album: Control = $UI/CardAlbum
@onready var _success_panel: Control = $UI/SuccessPanel
@onready var _cours_panel: Control = $UI/CoursPanel
@onready var _backpack_menu: BackpackMenu = $UI/BackpackMenu
@onready var _backpack_button: Button = $UI/BackpackButton
@onready var _open_menu_button: Button = $UI/OpenMenuButton
@onready var _demo_menu_dock: Control = $UI/DemoMenuDock
@onready var _demo_blur: CanvasItem = $UI/BackpackBlurBG
@onready var _cours: CoursPanel = $UI/CoursPanel
@onready var _reveal_mask: Control = $UI/CardRevealOverlay/InputMask
@onready var _tutorial_root: Control = $TutorialLayer/Root
@onready var _spotlight: TutorialSpotlight = $TutorialLayer/Root/Spotlight
@onready var _bubble: PanelContainer = $TutorialLayer/Root/Bubble
@onready var _quest_label: Label = $TutorialLayer/Root/Bubble/Margin/Content/HeaderRow/QuestLabel
@onready var _skip_button: Button = $TutorialLayer/Root/Bubble/Margin/Content/HeaderRow/SkipButton
@onready var _text_label: Label = $TutorialLayer/Root/Bubble/Margin/Content/TextLabel
@onready var _finish_button: Button = $TutorialLayer/Root/Bubble/Margin/Content/FinishButton
@onready var _next_button: Button = $TutorialLayer/Root/Bubble/Margin/Content/NextButton
@onready var _bubble_margin: MarginContainer = $TutorialLayer/Root/Bubble/Margin

var _step: Step = Step.NPC
var _done_subjects: Array[Subject] = []
var _current_subject: Subject = Subject.MATH
var _current_total: int = 0
var _place: Place = Place.BOTTOM
var _compact := false
## Fiches de cours pas (encore) disponibles (paquets Supabase non telecharges, ex. hors ligne) :
## la quete 7 saute directement a "ferme le menu".
var _cours_unavailable := false

func _ready() -> void:
	_reset_demo_progress()
	## CanvasLayer coupe la propagation du Theme (meme raison que les autres fenetres).
	_tutorial_root.theme = SaveManager.THEMES[SaveManager.ui_theme]
	_text_label.custom_minimum_size.x = BUBBLE_WIDTH - 40.0
	_apply_bubble_style()

	_npc_click.interacted.connect(_on_npc_clicked)
	_subject_panel.visibility_changed.connect(_on_subject_panel_visibility_changed)
	EventBus.subject_selected.connect(_on_subject_selected)
	_question_panel.pack_completed.connect(_on_pack_completed)
	_question_panel.visibility_changed.connect(_on_question_panel_visibility_changed)
	_backpack_button.pressed.connect(_backpack_menu.toggle)
	_backpack_menu.visibility_changed.connect(_on_backpack_menu_visibility_changed)
	EventBus.card_obtained.connect(_on_card_obtained)
	_reveal_mask.visibility_changed.connect(_on_reveal_mask_visibility_changed)
	_card_album.visibility_changed.connect(_on_panel_opened.bind(_card_album, Step.OPEN_BOOK, Step.BOOK))
	_success_panel.visibility_changed.connect(_on_panel_opened.bind(_success_panel, Step.BOOK, Step.SUCCESS))
	_cours_panel.visibility_changed.connect(_on_panel_opened.bind(_cours_panel, Step.SUCCESS, Step.COURS))
	for overlay_name in ["ConfirmOverlay", "InsufficientFundsOverlay"]:
		var overlay := _shop_panel.get_node(overlay_name) as Control
		overlay.visibility_changed.connect(_refresh_spotlight)
	_cours.notions_view.visibility_changed.connect(_on_cours_notions_visibility_changed)
	_cours.fiche_panel.visibility_changed.connect(_on_fiche_visibility_changed)
	_cours.fiche_panel.closed.connect(_on_fiche_closed)
	ContentLibrary.content_updated.connect(func() -> void: _refresh_spotlight.call_deferred())
	_demo_menu_dock.theme = _tutorial_root.theme
	_demo_menu_dock.hide()
	for button in _demo_menu_dock.find_children("*", "Button", true, false):
		(button as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE # vitrine : on n'entre pas dedans
	_open_menu_button.pressed.connect(_on_open_menu_pressed)
	_next_button.pressed.connect(_on_next_pressed)
	_skip_button.pressed.connect(_leave_tutorial)
	_finish_button.pressed.connect(_leave_tutorial)
	_bubble.resized.connect(_place_bubble)

	_go(Step.NPC)

func _apply_bubble_style() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = BUBBLE_BG
	style.border_color = BUBBLE_BORDER
	style.set_border_width_all(4)
	style.set_corner_radius_all(18)
	style.shadow_color = Color(0, 0, 0, 0.35)
	style.shadow_size = 10
	style.shadow_offset = Vector2(0, 5)
	_bubble.add_theme_stylebox_override("panel", style)
	_text_label.add_theme_color_override("font_color", BUBBLE_TEXT)
	_quest_label.add_theme_color_override("font_color", BUBBLE_BORDER)

## --- Deroule des quetes ---

func _go(step: Step) -> void:
	_step = step
	_compact = step in [Step.ANSWER, Step.RESULT]
	var quest_text := "Quête %d/%d : %s" % [_quest_index() + 1, QUEST_TITLES.size(), QUEST_TITLES[_quest_index()]]
	_quest_label.text = _step_text() if _compact else quest_text
	_quest_label.add_theme_font_size_override("font_size", 17 if _compact else 16)
	_text_label.visible = not _compact
	_text_label.text = _step_text()
	for side in ["margin_top", "margin_bottom"]:
		_bubble_margin.add_theme_constant_override(side, 2 if _compact else (8 if side == "margin_top" else 10))
	_finish_button.visible = step == Step.DONE
	_next_button.visible = step in [Step.PARENTAL, Step.CONTENT]
	_skip_button.visible = step != Step.DONE
	match step:
		Step.CHOOSE, Step.ANSWER, Step.RESULT:
			_place = Place.TOP
		Step.DONE, Step.CONTENT:
			_place = Place.CENTER
		Step.NPC:
			_place = Place.BOTTOM_RIGHT # a l'ecart du cercle autour de la maitresse (a gauche)
		_:
			_place = Place.BOTTOM
	_refresh_spotlight()
	## 2e passage differe : certaines cibles (cases du livre de cours) ne sont construites que
	## juste apres l'ouverture de leur fenetre.
	_refresh_spotlight.call_deferred()
	_place_bubble.call_deferred()
	if step in [Step.COURS, Step.COURS_NOTION]:
		_check_cours_available.call_deferred()

func _process(_delta: float) -> void:
	## Fiche lue jusqu'au bout = bouton "page suivante" desactive (derniere page, voir FichePanel).
	if _step == Step.COURS_FICHE and _cours.fiche_panel.visible and _cours.fiche_panel.next_button.disabled:
		_go(Step.COURS_FICHE_END)

func _quest_index() -> int:
	match _step:
		Step.NPC, Step.CHOOSE, Step.ANSWER:
			return mini(_done_subjects.size(), 1)
		Step.RESULT:
			return _done_subjects.size() - 1
		Step.OPEN_MENU:
			return 2
		Step.SHOP, Step.REVEAL:
			return 3
		Step.OPEN_BOOK, Step.BOOK:
			return 4
		Step.SUCCESS:
			return 5
		Step.COURS, Step.COURS_NOTION, Step.COURS_FICHE, Step.COURS_FICHE_END, Step.COURS_CLOSE:
			return 6
		Step.OPEN_LEFT, Step.PARENTAL:
			return 7
		Step.CONTENT:
			return 8
	return 9

func _step_text() -> String:
	match _step:
		Step.NPC:
			if _done_subjects.is_empty():
				return "Bienvenue dans ta classe ! Voici la maîtresse du CP. Clique sur elle pour commencer."
			return "Bravo ! Clique de nouveau sur la maîtresse pour faire l'autre matière."
		Step.CHOOSE:
			if _done_subjects.is_empty():
				return "Choisis Mathématiques ou Français. Les autres matières sont grisées pendant la visite."
			return "Choisis maintenant %s." % SubjectType.get_label(_remaining_subject())
		Step.ANSWER:
			return "Réponds aux 10 questions en cliquant sur la bonne réponse."
		Step.RESULT:
			return "Plus de la moitié de bonnes réponses = des pièces ! Ferme avec la croix."
		Step.OPEN_MENU:
			return "Tes pièces t'attendent dans le menu de droite. Clique sur cette icône pour l'ouvrir."
		Step.SHOP:
			return "Voici la Boutique : avec tes pièces, tu ouvres des coffres de cartes. La maîtresse complète ta bourse : achète un coffre du CP !"
		Step.REVEAL:
			return "Une nouvelle carte ! Clique dessus pour la ranger."
		Step.OPEN_BOOK:
			return "Ta carte est rangée dans le Livre. Clique sur le Livre pour la voir."
		Step.BOOK:
			return "Le Livre garde toute ta collection de cartes. Clique maintenant sur Succès."
		Step.SUCCESS:
			return "Chaque sans-faute fait avancer un défi (bronze, argent, or) qui débloque des musiques et des décors de classe. Clique sur Cours."
		Step.COURS:
			return "Les cours sont des fiches pour réviser chaque notion. Clique sur Mathématiques."
		Step.COURS_NOTION:
			return "Voici les notions de mathématiques du CP. Clique sur la première."
		Step.COURS_FICHE:
			return "Lis la fiche et passe à la page suivante avec la flèche, jusqu'à la dernière page."
		Step.COURS_FICHE_END:
			return "Bravo, tu as lu toute la fiche ! Ferme-la avec la croix."
		Step.COURS_CLOSE:
			if _cours_unavailable:
				return "Les fiches de cours ne sont pas encore chargées. Ferme le menu avec la croix."
			return "Tu sais réviser une notion avec les cours. Ferme le menu avec la croix."
		Step.OPEN_LEFT:
			return "Un conseil pour les parents ! Ouvre le menu de gauche."
		Step.PARENTAL:
			return "Dans le menu de gauche, l'icône Contrôle parental permet de changer le nombre de parties autorisées par jour. Elle est protégée par le mot de passe parental, obligatoire à la création du compte. Aujourd'hui, on n'entre pas dedans !"
		Step.CONTENT:
			return _content_text()
	return "Bravo, tu connais l'essentiel ! Pour jouer pour de vrai et garder tes pièces et tes cartes, crée un compte avec un adulte. À bientôt en classe !"

func _remaining_subject() -> Subject:
	for subject in PLAYABLE_SUBJECTS:
		if subject not in _done_subjects:
			return subject
	return Subject.MATH

## Cercle de mise en valeur de l'etape en cours (aucun pendant les fenetres de questions, qui ont
## deja leur propre flou, ni par-dessus une popup de la boutique a valider).
func _refresh_spotlight() -> void:
	match _step:
		Step.NPC:
			var radius := _npc_visual.texture.get_height() * absf(_npc_visual.global_scale.y) * 0.55
			_spotlight.focus_on(_npc_visual, radius)
		Step.OPEN_MENU:
			_spotlight.focus_on(_backpack_button)
		Step.SHOP:
			var popup_open := (_shop_panel.get_node("ConfirmOverlay") as Control).visible \
				or (_shop_panel.get_node("InsufficientFundsOverlay") as Control).visible
			if popup_open:
				_spotlight.clear()
			else:
				_spotlight.focus_on(_shop_panel.get_crate_item(Grade.CP))
		Step.OPEN_BOOK, Step.BOOK, Step.SUCCESS, Step.COURS_CLOSE:
			_spotlight.focus_on(_backpack_menu.get_node(_dock_target_path()))
		Step.COURS:
			_spotlight.focus_on(_cours_target())
		Step.COURS_NOTION:
			_spotlight.focus_on(_cours_target())
		Step.COURS_FICHE:
			_spotlight.focus_on(_cours.fiche_panel.next_button)
		Step.COURS_FICHE_END:
			_spotlight.focus_on(_cours.fiche_panel.close_button)
		Step.OPEN_LEFT:
			_spotlight.focus_on(_open_menu_button)
		Step.PARENTAL:
			_spotlight.focus_on(_demo_menu_dock.get_node("IconList/ParentalControlButton"))
		Step.DONE, Step.CONTENT:
			_spotlight.dim_all()
		_:
			_spotlight.clear()

func _dock_target_path() -> NodePath:
	match _step:
		Step.OPEN_BOOK:
			return ^"IconDock/IconList/LivreButton"
		Step.BOOK:
			return ^"IconDock/IconList/SuccesButton"
		Step.SUCCESS:
			return ^"IconDock/IconList/CoursButton"
	return ^"IconDock/CloseButton"

## Case a viser dans le livre de cours : Mathematiques (etape COURS) ou 1re notion ayant une fiche
## (etape COURS_NOTION). null tant que la grille n'est pas construite.
func _cours_target() -> Button:
	if _step == Step.COURS:
		var math_button := _find_live_button(_cours.subject_grid, SubjectType.get_label(Subject.MATH))
		return math_button if math_button != null and not math_button.disabled else null
	return _find_live_button(_cours.notion_grid, "")

## Verifie (en differe, une fois la grille reconstruite par CoursPanel) qu'il y a bien une fiche a
## montrer - sinon la quete 7 passe directement a "ferme le menu".
func _check_cours_available() -> void:
	if _step in [Step.COURS, Step.COURS_NOTION] and _cours_target() == null:
		_cours_unavailable = true
		_go(Step.COURS_CLOSE)

## Bouton (cree en code dans un cadre colore, voir CoursPanel._colored_frame) d'une grille du livre
## de cours : celui dont le texte vaut [text], ou le 1er bouton actif si [text] est vide. Ignore
## les cases en cours de suppression (la grille est reconstruite a chaque affichage).
func _find_live_button(grid: Node, text: String) -> Button:
	for frame in grid.get_children():
		if frame.is_queued_for_deletion() or frame.get_child_count() == 0:
			continue
		var button := frame.get_child(0) as Button
		if button == null:
			continue
		if (text.is_empty() and not button.disabled) or button.text == text:
			return button
	return null

func _place_bubble() -> void:
	var view := get_viewport().get_visible_rect().size
	var width := BUBBLE_WIDTH_COMPACT if _compact else BUBBLE_WIDTH
	_bubble.size = Vector2(width, 0.0)
	var bubble_size := _bubble.get_combined_minimum_size()
	bubble_size.x = maxf(bubble_size.x, width)
	_bubble.size = bubble_size
	var x := (view.x - bubble_size.x) * 0.5
	match _place:
		Place.TOP:
			_bubble.position = Vector2(x, BUBBLE_MARGIN_COMPACT if _compact else BUBBLE_MARGIN)
		Place.CENTER:
			_bubble.position = (view - bubble_size) * 0.5
		Place.BOTTOM_RIGHT:
			_bubble.position = view - bubble_size - Vector2(BUBBLE_MARGIN, BUBBLE_MARGIN)
		_:
			_bubble.position = Vector2(x, view.y - bubble_size.y - BUBBLE_MARGIN)

## --- Reactions aux actions du joueur ---

func _on_npc_clicked(_who: Node) -> void:
	if _step != Step.NPC:
		return
	var disabled: Array[Subject] = []
	for subject in SHOWN_SUBJECTS:
		if subject not in PLAYABLE_SUBJECTS or subject in _done_subjects:
			disabled.append(subject)
	_go(Step.CHOOSE)
	_subject_panel.open_for(_npc_click, Grade.CP, SHOWN_SUBJECTS, disabled)

## SubjectSelectPanel se cache AVANT d'emettre EventBus.subject_selected : verification differee
## pour laisser passer le choix - seule une fermeture par la croix ramene a l'etape "clique".
func _on_subject_panel_visibility_changed() -> void:
	if not _subject_panel.visible:
		_back_to_npc_if_still_choosing.call_deferred()

func _back_to_npc_if_still_choosing() -> void:
	if _step == Step.CHOOSE:
		_go(Step.NPC)

func _on_subject_selected(source: Node, subject: Subject) -> void:
	if source != _npc_click or _step != Step.CHOOSE:
		return
	var questions := TutorialQuestions.get_series(subject)
	if questions.is_empty():
		return
	_current_subject = subject
	_current_total = questions.size()
	_go(Step.ANSWER)
	_question_panel.display_pack(_npc_click, questions, GradeLevel.get_rarity(Grade.CP))

## Pieces reellement creditees (en memoire seulement, voir commentaire de classe) : elles
## apparaissent dans les Recompenses a la quete 4.
func _on_pack_completed(source: Node, correct_count: int) -> void:
	if source != _npc_click or _step != Step.ANSWER:
		return
	var rarity := GradeLevel.get_rarity(Grade.CP)
	Economy.add_coins(rarity, CardRarity.get_pack_reward(rarity, correct_count, _current_total))
	_done_subjects.append(_current_subject)
	_go(Step.RESULT)

func _on_question_panel_visibility_changed() -> void:
	if _question_panel.visible:
		return
	if _step == Step.ANSWER:
		_go(Step.NPC) # serie abandonnee avant la fin : on peut la recommencer
	elif _step == Step.RESULT:
		_go(Step.OPEN_MENU if _done_subjects.size() >= PLAYABLE_SUBJECTS.size() else Step.NPC)

func _on_backpack_menu_visibility_changed() -> void:
	if _backpack_menu.visible:
		if _step == Step.OPEN_MENU:
			_top_up_for_cp_crate()
			_shop_panel.tabs.current_tab = 0
			_go(Step.SHOP)
	elif _step == Step.COURS_CLOSE:
		_go(Step.OPEN_LEFT)
	elif _step in [Step.SHOP, Step.OPEN_BOOK, Step.BOOK, Step.SUCCESS, Step.COURS, Step.COURS_NOTION, Step.COURS_FICHE, Step.COURS_FICHE_END]:
		_go(Step.OPEN_MENU)

## "La maitresse complete ta bourse" : de quoi acheter au moins un coffre du CP, meme apres deux
## series ratees.
func _top_up_for_cp_crate() -> void:
	var rarity := GradeLevel.get_rarity(Grade.CP)
	for crate: LootTableResource in _shop_panel.available_crates:
		if crate.rarity == rarity:
			var missing := crate.crate_price - Economy.get_balance(rarity)
			if missing > 0:
				Economy.add_coins(rarity, missing)
			return

func _on_card_obtained(_card: CardResource) -> void:
	if _step == Step.SHOP:
		_go(Step.REVEAL)

func _on_reveal_mask_visibility_changed() -> void:
	if not _reveal_mask.visible and _step == Step.REVEAL:
		_go(Step.OPEN_BOOK)

func _on_panel_opened(panel: Control, from_step: Step, to_step: Step) -> void:
	if panel.visible and _step == from_step:
		_go(to_step)

func _on_cours_notions_visibility_changed() -> void:
	if _cours.notions_view.visible and _step == Step.COURS:
		_go(Step.COURS_NOTION)

func _on_fiche_visibility_changed() -> void:
	if _cours.fiche_panel.visible and _step == Step.COURS_NOTION:
		_go(Step.COURS_FICHE)

func _on_fiche_closed() -> void:
	if _step in [Step.COURS_FICHE, Step.COURS_FICHE_END]:
		_go(Step.COURS_CLOSE)

func _on_open_menu_pressed() -> void:
	if _step != Step.OPEN_LEFT:
		return
	_demo_menu_dock.show()
	_demo_blur.visible = true
	_go(Step.PARENTAL)

func _on_next_pressed() -> void:
	match _step:
		Step.PARENTAL:
			_demo_menu_dock.hide()
			_demo_blur.visible = false
			_go(Step.CONTENT)
		Step.CONTENT:
			_go(Step.DONE)

## Chiffres du jeu complet, calcules en direct : cartes = cartes distinctes des 5 coffres, tenues =
## 9 achetables par classe (la tenue n°0 est offerte), questions = tous les paquets deja
## telecharges (texte generique si rien n'est encore charge, ex. 1er lancement hors ligne).
func _content_text() -> String:
	var cards: Dictionary = {}
	for crate: LootTableResource in _shop_panel.available_crates:
		for entry: LootEntry in crate.entries:
			if entry.card != null:
				cards[entry.card.id] = true
	var grade_count := Grade.size()
	var outfits := (ProfSkinCatalog.SKINS_PER_GRADE - 1) * grade_count
	var questions := 0
	for grade: Grade in Grade.values():
		for subject: Subject in ContentLibrary.get_available_subjects(grade):
			questions += ContentLibrary.get_questions(grade, subject).size()
	var questions_text := "des milliers de questions" if questions == 0 else "%s questions" % _format_number(questions)
	return "Le jeu complet, c'est %s du CP au CM2, %d cartes d'animaux à collectionner, %d tenues de professeurs, %d décors et %d musiques de classe à débloquer !" % [
		questions_text, cards.size(), outfits, grade_count, grade_count,
	]

## 12345 -> "12 345" (espace des milliers, usage francais).
func _format_number(value: int) -> String:
	var digits := str(value)
	var result := ""
	for i in digits.length():
		if i > 0 and (digits.length() - i) % 3 == 0:
			result += " "
		result += digits[i]
	return result

## --- Entree / sortie ---

func _reset_demo_progress() -> void:
	## Garde-fou : le tutoriel ne se lance que depuis l'ecran d'intro (aucun compte connecte).
	if not SaveManager.current_account_id.is_empty():
		return
	Economy.reset()
	CardCollection.reset()
	ChallengeTracker.reset()

func _leave_tutorial() -> void:
	_reset_demo_progress()
	get_tree().change_scene_to_file(SCHOOL_SCENE)
