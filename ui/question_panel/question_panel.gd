## Fenetre 2D generique pour poser un pack de questions les unes apres les autres :
## fonctionne pour toute matiere/rarete, le contenu vient entierement des QuestionResource
## passees en parametre.
## Mode de reponse : boutons QCM des qu'une question a des choix (choice_2/3/4 dans le CSV),
## sur toutes les plateformes (evite de deviner a l'aveugle la forme attendue d'un texte a
## trous au clavier). Sinon, saisie clavier + Entree OU bouton "Valider". A la fin du pack, affiche un
## tableau recapitulatif (une ligne par question : reponse donnee en vert si juste, en rouge
## avec la correction a cote si fausse) qui reste affiche jusqu'a fermeture manuelle.
## Se ferme (sans recompense si le pack n'est pas termine, la recompense ayant deja ete versee
## des l'affichage du recapitulatif sinon) si le joueur quitte la bulle du PNJ en cours, ou via la
## croix de fermeture.
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## (Echap pour fermer) est retire - close_button fait deja ca a la souris/au tactile. La saisie
## texte + Entree pour valider (ligne ci-dessus) N'EST PAS concernee : c'est un champ de texte
## (LineEdit.text_submitted), pas un raccourci - fonctionne au clavier physique comme au clavier
## virtuel tactile, le bouton "Valider" restant de toute facon l'equivalent souris/tactile direct.
##
## Floutage d'arriere-plan (2026-09-04, retour utilisateur : "on va uniformiser le floutage arriere
## pour toutes les fenetres quand celles ci sont actives... je veux appliquer la meme chose aux
## questions et menus proposes par les npc") : meme mecanisme que BackpackMenu.blur_bg_path (voir
## ui/hud/backpack_menu.gd) - blur_bg_path pointe vers NpcBlurBG (ColorRect partage avec
## SubjectSelectPanel et ReadingIntroPanel dans game_ui.tscn, place avant les 3 pour se dessiner en
## dessous), bascule sa visibilite dans _on_visibility_changed() en meme temps que PlayerInputLock.
##
## Menus masques + Echap reintroduit pour cette fenetre uniquement (2026-09-04, retour utilisateur :
## "lorsque les questions sont ouvertes, il faut desactiver les 2 menus (les masquer), la touche
## echap ou la croix permettent de quitter une session de questions en cours, attention echap apres
## l apparition des resultats n invalidera pas la session mais quittera simplement l ecran de
## correction") :
## - open_menu_button_path/backpack_button_path pointent vers OpenMenuButton/BackpackButton
##   (game_ui.tscn) - masques (visible = false) tant que ce panneau est visible, pour empecher
##   d'ouvrir un des 2 menus pendant une session de questions ; remis visibles a la fermeture.
## - _unhandled_input() reapparait ICI SEULEMENT (contrairement au reste du jeu, voir plus haut,
##   2026-09-02 : "on supprime tous les raccourcis clavier") : Echap appelle le meme _abort_pack()
##   que close_button, donc le meme comportement s'applique deja aux deux - si le recapitulatif est
##   deja affiche (_show_result deja appelee), la recompense a deja ete versee (voir commentaire de
##   _abort_pack plus bas) : fermer ne fait qu'arreter l'affichage, "invalider la session" n'a alors
##   plus de sens puisqu'elle est deja terminee. Uniquement quand le panneau est visible (sinon Echap
##   couperait par erreur la fermeture d'une autre fenetre, ex. GameMenuPanel).
class_name QuestionPanel
extends Control

## Emis quand le joueur a repondu a toutes les questions du pack. "source" est renvoye tel
## quel depuis display_pack : ce panneau etant partage par tous les PNJ, c'est ce qui permet
## a chacun de savoir si CE pack termine est bien le sien avant de verser une recompense.
signal pack_completed(source: Node, correct_count: int)

const RESULT_DISPLAY_SECONDS := 2.5

const CORRECT_COLOR := Color(0.42, 0.85, 0.42)
const WRONG_COLOR := Color(0.92, 0.35, 0.35)

## Largeur minimale d'une case de reponse QCM (voir _populate_choice_buttons), en proportion de
## la largeur du cadre - evite des cases trop etroites quand la reponse la plus longue est tres
## courte (ex. un seul chiffre).
const MIN_CHOICE_WIDTH_RATIO := 0.3

## Logique (2026-08-04) : certaines reponses de cette matiere sont des emojis/symboles (🍎 ● etc.)
## au lieu de texte - illisibles a la taille de bouton standard (retour utilisateur ingame), d'ou
## l'agrandissement ci-dessous. Mais Logique melange aussi des questions purement textuelles
## (nombres, lettres, mots - voir csv/questions/*/logique/generated.csv), qui doivent rester a la
## police standard comme les autres matieres (retour utilisateur 2026-08-04, 5e passe : la
## distinction se fait par REPONSE, pas par matiere entiere - voir _is_emoji_choice). Grille 2
## colonnes x 2 lignes (au lieu de l'empilement vertical habituel) appliquee a toute question de
## Logique en revanche, texte ou emoji, pour rester lisible sur petit ecran mobile.
## ChoicesContainer a aussi size_flags_horizontal = SIZE_SHRINK_CENTER dans la .tscn (au lieu du
## FILL par defaut) : sans ca, la grille 2 colonnes restait calee a gauche du cadre au lieu d'etre
## centree (le VBoxContainer parent lui laisse toute la largeur, mais une GridContainer ne centre
## pas son propre bloc de colonnes dedans).
const LOGIC_CHOICE_COLUMNS := 2

## x2 = exactement le double de la police standard du theme actif (retour utilisateur 2026-08-04,
## 5e passe : "le double de la taille prevue de la police utilisee", pas un multiplicateur
## approximatif). Applique uniquement aux reponses detectees comme emoji/symbole (voir
## _is_emoji_choice), jamais aux reponses textuelles ni a QuestionLabel.
const LOGIC_CHOICE_FONT_MULTIPLIER := 2

## Sans reduction de marge, forcer une police x2 rendrait la case enorme (retour utilisateur
## 2026-08-04, 3e/4e passe) : la marge interne du bouton (voir _apply_logic_choice_padding, x0.7
## sur le style du theme) et ce plancher de hauteur/largeur explicite (0.3 -> 0.21, la largeur de
## plancher n'affecte QUE les reponses emoji - MIN_CHOICE_WIDTH_RATIO plus haut reste le plancher
## des reponses textuelles, Logique inclue) compensent le symbole agrandi SANS jamais toucher a la
## taille de la police elle-meme.
const LOGIC_CHOICE_MIN_HEIGHT := 61.6
const LOGIC_CHOICE_WIDTH_RATIO := 0.21
const LOGIC_CHOICE_PADDING_SCALE := 0.7

## Marge haut/bas des cases emoji reduite plus fort que la marge gauche/droite (retour utilisateur
## 2026-08-05 : les formes rondes/emoji ont le haut tronque). Cause : la case reste plafonnee a
## LOGIC_CHOICE_MIN_HEIGHT (le plancher explicite ne bouge jamais tant que le contenu tient dedans,
## voir _apply_logic_choice_padding), et un glyphe emoji/rond de police systeme (rendu via fallback,
## voir feedback_font_emoji_risk en memoire) deborde souvent au-dessus de l'ascendant que la police
## declare - la marge du haut lui laissait alors trop peu de place avant le bord de la case. Reduire
## cette marge SANS toucher LOGIC_CHOICE_MIN_HEIGHT (donc sans changer la hauteur de la case) rend
## cet espace au contenu au lieu du vide autour. Marge gauche/droite laissee a LOGIC_CHOICE_PADDING_SCALE
## (aucun signalement de troncature horizontale).
const LOGIC_CHOICE_VERTICAL_PADDING_SCALE := 0.2

## Codepoint Unicode a partir duquel un caractere est considere comme un symbole/emoji plutot que
## du texte (voir _is_emoji_choice) : U+2190 (fleches) est bien au-dela de tout caractere latin/
## accentue utilise par le contenu du jeu (French/English + accents ne depassent jamais Latin
## Extended-A, ~U+0180), donc aucun risque de faux positif sur un mot ou un nombre.
const EMOJI_CODEPOINT_THRESHOLD := 0x2190

## Taille affichee de l'icone piece dans la pastille d'en-tete, a cote du texte de resultat (voir
## _show_result). Plus petite que CoinHUD.ICON_SIZE (48) : ici l'icone est en ligne avec du texte
## de la taille TitleLabel standard, pas dans une bande dediee.
const PROGRESS_ICON_SIZE := 28

## Flou plein ecran derriere ce panneau (voir commentaire de classe, 2026-09-04) : NodePath vers
## NpcBlurBG, ColorRect EXTERNE partage avec SubjectSelectPanel/ReadingIntroPanel dans game_ui.tscn -
## assigne la-bas, meme convention que BackpackMenu.blur_bg_path.
@export var blur_bg_path: NodePath
## Boutons d'ouverture des 2 menus (game_ui.tscn), masques tant que ce panneau est visible (voir
## commentaire de classe, 2026-09-04) - assignes dans game_ui.tscn.
@export var open_menu_button_path: NodePath
@export var backpack_button_path: NodePath

@onready var panel: PanelContainer = $Panel
## Marge du cadre (Panel/Margin) - lue dynamiquement (get_theme_constant) dans
## _populate_choice_buttons pour plafonner la largeur des boutons QCM, plutot que dupliquer les
## valeurs 28/28 du .tscn en dur (voir commentaire de _populate_choice_buttons, 2026-09-11).
@onready var content_margin: MarginContainer = $Panel/Margin
@onready var progress_badge_row: HBoxContainer = $Panel/Margin/Content/HeaderRow/ProgressBadge/ProgressBadgeRow
@onready var progress_label: Label = $Panel/Margin/Content/HeaderRow/ProgressBadge/ProgressBadgeRow/ProgressLabel
## QuestionCard/AnswerRow/ChoicesContainer sont maintenant dans QuestionScroll (ScrollContainer,
## voir commentaire de classe et _update_question_label_max_width, 2026-09-11) : un pack CM2 dont
## la question ET les 4 reponses sont tres longues peut demander plus de hauteur que le cadre n'en
## a (0.08-0.92 de l'ecran, voir la .tscn) - avant ce changement, Content (VBoxContainer) imposait
## alors cette hauteur au Panel entier, qui grandissait (grow_vertical = 2) au-dela de l'ecran par
## le haut ET le bas a la fois. Le ScrollContainer absorbe ce surplus en scroll interne, exactement
## comme ResultScroll le fait deja pour le tableau recapitulatif juste en dessous.
## BUG CORRIGE 2026-09-11 (retour utilisateur : "grande marge entre le cadre resultat et les
## reponses corrigees") : QuestionScroll lui-meme (le ScrollContainer, pas seulement QuestionCard/
## choices_container/answer_input/validate_button a l'interieur) doit etre masque quand le
## recapitulatif s'affiche (voir _show_result) et remontre quand une question s'affiche (voir
## _display_current_question/show_message) - sinon il reste visible, vide mais size_flags_vertical
## = SIZE_EXPAND_FILL, et se partage l'espace disponible de Content a parts egales avec
## ResultScroll (les 2 sont EXPAND_FILL) au lieu de lui laisser toute la place.
@onready var question_scroll: ScrollContainer = $Panel/Margin/Content/QuestionScroll
@onready var question_card: PanelContainer = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/QuestionCard
## RichTextLabel (pas Label, depuis 2026-08-04) : necessaire pour agrandir uniquement les
## emojis/symboles d'une question Logique via BBCode ([font_size=X]) tout en gardant le reste du
## texte a la taille TitleLabel standard - voir _build_question_bbcode. Le theme (les 4 variantes,
## voir ui/theme/*.tres) porte les cles normal_font_size/default_color en plus de font_size/
## font_color pour que ce changement de type de noeud ne change pas l'apparence des questions
## sans emoji.
@onready var question_label: RichTextLabel = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/QuestionCard/QuestionCardMargin/QuestionLabel
## Marge de QuestionCard (voir question_card plus haut) - lue dynamiquement dans
## _get_question_scroll_content_width, meme role que content_margin/question_scroll_margin.
@onready var question_card_margin: MarginContainer = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/QuestionCard/QuestionCardMargin
@onready var answer_input: LineEdit = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/AnswerRow/AnswerInput
@onready var choices_container: GridContainer = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/ChoicesContainer
@onready var validate_button: Button = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin/QuestionScrollContent/AnswerRow/ValidateButton
## Marge droite (10px) reservee a la scrollbar de QuestionScroll (voir question_card plus haut) -
## meme role que ResultRowsMargin pour ResultScroll : lue dynamiquement dans
## _populate_choice_buttons pour ne pas laisser un bouton QCM deborder sous la scrollbar.
@onready var question_scroll_margin: MarginContainer = $Panel/Margin/Content/QuestionScroll/QuestionScrollMargin
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton
@onready var result_scroll: ScrollContainer = $Panel/Margin/Content/ResultScroll
@onready var result_rows_container: VBoxContainer = $Panel/Margin/Content/ResultScroll/ResultRowsMargin/ResultRows
## Ligne "Défi" ajoutee au recapitulatif pour un pack sans faute (voir _show_result()) -
## noeud statique du .tscn (comme les autres @onready ci-dessus), masque par defaut.
@onready var challenge_label: Label = $Panel/Margin/Content/ChallengeLabel
## Petit popup flottant (voir _show_challenge_popup()) - enfant direct de la racine pour se
## dessiner au-dessus de Panel, pas de _progress_icon (voir plus bas) : c'est un evenement
## distinct de la recompense en pieces, jamais affiche en meme temps que la fanfare
## PACK_REWARD (voir SoundManager.Sfx).
@onready var challenge_popup: PanelContainer = $ChallengePopup
@onready var challenge_popup_label: Label = $ChallengePopup/ChallengePopupMargin/ChallengePopupLabel

## Marge interne d'une ligne du tableau recapitulatif (voir _add_result_row) - assez large pour
## une lecture confortable sans gonfler artificiellement la hauteur de chaque ligne.
const RESULT_ROW_MARGIN := 10
## Part de largeur laissee vide avant la reponse/correction (voir _build_indented_line) : decale
## ces deux lignes de 20% vers la droite par rapport a la question, pour bien les distinguer d'un
## simple coup d'oeil (retour utilisateur 2026-08-01).
const RESULT_INDENT_RATIO := 0.2

## Taille visee pour Panel (voir _update_panel_max_size), mise en cache ici plutot que relue via
## panel.size a chaque calcul de largeur (_get_question_scroll_content_width,
## _update_question_label_max_width, _populate_choice_buttons) : panel.size ne reflete l'effet de
## custom_maximum_size qu'apres que le moteur ait retraite la mise en page (differe d'au moins une
## frame apres un show()), donc juste apres display_pack()/show_message() il peut encore renvoyer
## l'ANCIENNE taille - ce qui recreait exactement le meme bug de troncature/debordement que ce
## fichier corrige (retour utilisateur 2026-09-11 : "toutes les lignes sont coupees"). _panel_target_
## size, lui, est calcule directement depuis les ancres (voir _update_panel_max_size), donc toujours
## a jour instantanement, sans dependre du rythme de la mise en page du moteur.
var _panel_target_size: Vector2 = Vector2.ZERO

var _source: Node
var _questions: Array[QuestionResource] = []
var _rarity: CardRarity.Rarity = CardRarity.Rarity.COMMON
var _current_index: int = 0
var _correct_count: int = 0
## Historique du pack en cours, une entree par question repondue, dans l'ordre : sert a
## construire le tableau recapitulatif affiche par _show_result.
var _history: Array[Dictionary] = []

## Icone piece coloree affichee dans la pastille de resultat (voir _show_result) - creee au
## runtime comme les icones de CoinHUD, plutot que posee dans la .tscn : masquee (visible = false)
## tant qu'aucun resultat n'est affiche (pastille reutilisee pour "Question X/Y" et les messages
## temporaires, voir show_message/_display_current_question).
var _progress_icon: TextureRect

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	## Glissement au doigt possible depuis n'importe quelle zone (pas seulement la fine barre
	## de defilement) - voir ui/common/touch_scroll_fix.gd (retour utilisateur 2026-09-18).
	TouchScrollFix.allow_scroll_passthrough(self)
	answer_input.text_submitted.connect(_on_answer_submitted)
	validate_button.pressed.connect(_on_validate_pressed)
	close_button.pressed.connect(_on_close_pressed)
	## Fige le joueur (deplacement + interaction) tant que ce panneau est visible.
	visibility_changed.connect(_on_visibility_changed)
	## Meme pattern que CoinHUD._ready() (icone creee en code, jamais posee dans la .tscn) :
	## expand_mode = EXPAND_IGNORE_SIZE, sinon get_minimum_size() renvoie la taille native de la
	## texture (120x120) au lieu de respecter custom_minimum_size - voir le commentaire detaille
	## dans coin_hud.gd.
	_progress_icon = TextureRect.new()
	_progress_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_progress_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	_progress_icon.custom_minimum_size = Vector2(PROGRESS_ICON_SIZE, PROGRESS_ICON_SIZE)
	_progress_icon.visible = false
	progress_badge_row.add_child(_progress_icon)
	## Filet de securite (2026-09-11, retour utilisateur : meme apres le plafond de largeur des
	## boutons QCM et le passage de la zone question en ScrollContainer, "le cadre deborde encore
	## de la fenetre de jeu") : quel que soit ce qui, plus bas dans l'arbre, exige encore une taille
	## minimale trop grande pour Panel (un contenu tres long peut toujours faire remonter un besoin
	## de hauteur/largeur superieur a ce que ses ancres lui allouent), Panel ne peut desormais plus
	## JAMAIS depasser physiquement la zone qui lui est reservee a l'ecran. custom_maximum_size est
	## un veritable plafond applique par le moteur sur la taille finale du Control (voir
	## Control::_size_changed()/get_combined_maximum_size() dans scene/gui/control.cpp, source
	## Godot 4.7) - contrairement au custom_maximum_size de QuestionLabel plus bas, qui ne sert lui
	## qu'a calculer un retour a la ligne (voir _update_question_label_max_width). Le contenu qui ne
	## rentre plus dans ce plafond est desormais contraint de scroller a l'interieur de
	## QuestionScroll/ResultScroll (deja en place) au lieu de pousser Panel hors ecran.
	_update_panel_max_size()
	## Recalcule si la fenetre change de taille (canvas_items ne change pas les ancres, mais la
	## taille reelle en pixels change) - QuestionPanel (ce script) couvre tout l'ecran (ancres 0-1),
	## donc son propre "resized" reflete fidelement chaque changement de taille du viewport.
	resized.connect(_update_panel_max_size)

func _on_visibility_changed() -> void:
	var blur_bg := get_node_or_null(blur_bg_path) as CanvasItem
	if blur_bg:
		blur_bg.visible = visible
	var open_menu_button := get_node_or_null(open_menu_button_path) as CanvasItem
	if open_menu_button:
		open_menu_button.visible = not visible
	var backpack_button := get_node_or_null(backpack_button_path) as CanvasItem
	if backpack_button:
		backpack_button.visible = not visible
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Echap = meme action que close_button (voir commentaire de classe, 2026-09-04) : seule fenetre du
## jeu a reintroduire un raccourci clavier depuis la suppression generale du 2026-09-02, sur demande
## explicite. Ignore tout evenement tant que ce panneau n'est pas visible, pour ne jamais intercepter
## l'Echap destine a une autre fenetre (ex. GameMenuPanel).
func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_abort_pack()

## Affiche un message temporaire (ex: "pas encore de questions pour ce niveau") puis se
## referme toute seule, comme l'ecran de resultat. Reutilise pour QuestionGiverComponent.
## pack_unavailable ; le "source" en parametre n'est pas utilise ici, l'affichage seul suffit -
## nomme differemment de la variable membre _source (voir plus haut) pour eviter de la masquer
## par erreur (elle suit le PNJ du pack EN COURS, pas celui d'un simple message).
func show_message(_unused_source: Node, message: String) -> void:
	result_scroll.visible = false
	challenge_label.visible = false
	question_scroll.visible = true
	question_card.visible = true
	progress_label.text = ""
	_progress_icon.visible = false
	_update_question_label_max_width()
	question_label.text = _build_question_bbcode(message)
	_clear_choice_buttons()
	choices_container.visible = false
	answer_input.visible = false
	validate_button.visible = false
	show()
	await get_tree().create_timer(RESULT_DISPLAY_SECONDS).timeout
	hide()

func display_pack(source: Node, questions: Array[QuestionResource], rarity: CardRarity.Rarity) -> void:
	if questions.is_empty():
		return
	_source = source
	_questions = questions
	_rarity = rarity
	_current_index = 0
	_correct_count = 0
	_history = []
	result_scroll.visible = false
	challenge_label.visible = false
	show()
	_display_current_question()

func _display_current_question() -> void:
	question_scroll.visible = true
	question_card.visible = true
	var question := _questions[_current_index]
	progress_label.text = "Question %d/%d" % [_current_index + 1, _questions.size()]
	_progress_icon.visible = false
	_update_question_label_max_width()
	question_label.text = _build_question_bbcode(question.text)
	_clear_choice_buttons()

	## QCM par boutons des qu'une question a des choix, sur toutes les plateformes (y compris
	## clavier desktop) : pour un texte a trous, le joueur n'a sinon aucun moyen de deviner la
	## forme exacte attendue (accord, orthographe...) sans les options sous les yeux. Seules les
	## questions sans choix (choice_2/3/4 vides dans le CSV) restent en saisie clavier.
	var use_buttons := not question.choices.is_empty()
	choices_container.visible = use_buttons
	answer_input.visible = not use_buttons
	validate_button.visible = not use_buttons
	if use_buttons:
		_populate_choice_buttons(question)
	else:
		answer_input.editable = true
		answer_input.text = ""
		## call_deferred : grab_focus() appele juste apres un text_submitted peut ne pas
		## "prendre" tout de suite (Godot traite encore l'evenement Enter en cours), on le
		## reporte donc a la frame suivante pour que le curseur soit fiable a chaque question.
		answer_input.grab_focus.call_deferred()

func _populate_choice_buttons(question: QuestionResource) -> void:
	var options: Array = question.choices.duplicate()
	options.append(question.correct_answer)
	options.shuffle()

	## Grille 2x2 agrandie pour Logique (voir LOGIC_CHOICE_* plus haut), sinon empilement vertical
	## habituel (1 seule colonne) - remis a jour a chaque question au cas ou un pack melangerait
	## les matieres (aucun cas actuel, mais pas de raison de le supposer).
	var is_logic := question.subject == SubjectType.Subject.LOGIC
	choices_container.columns = LOGIC_CHOICE_COLUMNS if is_logic else 1

	var buttons: Array[Button] = []
	var max_width := 0.0
	## true des qu'au moins une reponse de cette question est un emoji/symbole (voir
	## _is_emoji_choice) : decide le plancher de largeur applique a TOUTES les cases juste apres
	## la boucle (une seule largeur commune pour l'ensemble, voir plus bas) - en pratique jamais
	## melange dans le contenu actuel (une question Logique est soit toute textuelle, soit toute
	## symbolique, voir csv/questions/*/logique/generated.csv), mais calcule au cas ou.
	var has_emoji_choice := false
	for option_text in options:
		var button := Button.new()
		button.text = str(option_text)
		button.pressed.connect(_on_choice_pressed.bind(option_text))
		choices_container.add_child(button)
		## mouse_filter=Pass (retour utilisateur 2026-09-19, meme bug/fix que TODO_UI_MODS.md
		## "Scroll tactile impossible" et welcome_panel.gd/_on_login_input_text_changed) : ce
		## bouton QCM est cree a la volee dans QuestionScroll - sans ca son mouse_filter=Stop par
		## defaut empecherait un glissement tactile demarre sur une case de faire defiler
		## QuestionScroll (retour utilisateur : questions/reponses longues qui debordent).
		button.mouse_filter = Control.MOUSE_FILTER_PASS
		if _is_emoji_choice(str(option_text)):
			has_emoji_choice = true
			## Applique avant la mesure de largeur ci-dessous, pour que max_width tienne compte
			## du symbole agrandi (sinon les cases resteraient dimensionnees pour la petite taille
			## et le texte deborderait). Multiplie la taille heritee du theme plutot qu'une valeur
			## en dur, pour rester correct si le theme actif change (4 variantes, voir game_theme.tres).
			var base_font_size := button.get_theme_font_size("font_size")
			button.add_theme_font_size_override("font_size", roundi(base_font_size * LOGIC_CHOICE_FONT_MULTIPLIER))
			button.custom_minimum_size.y = LOGIC_CHOICE_MIN_HEIGHT
			## Retrecit la marge interne du bouton (voir LOGIC_CHOICE_PADDING_SCALE plus haut) SANS
			## toucher a la police : c'est cette marge, pas le symbole, qui doit se reduire pour que
			## la case suive la taille demandee (retour utilisateur 2026-08-04, 3e passe).
			_apply_logic_choice_padding(button)
		## Mesuree avant d'activer l'autowrap ci-dessous : une fois l'autowrap actif, la largeur
		## minimale rapportee par le moteur ne correspond plus qu'au mot le plus long (le texte
		## pouvant se replier), pas a la reponse entiere sur une ligne. On veut ici la largeur
		## naturelle sur une seule ligne, pour ensuite l'appliquer a toutes les cases.
		max_width = maxf(max_width, button.get_minimum_size().x)
		## Une reponse malgre tout tres longue passe sur 2 lignes au lieu de deborder du bouton
		## (celui-ci grandit tout seul en hauteur - retour utilisateur 2026-08-01).
		button.autowrap_mode = TextServer.AUTOWRAP_WORD
		## Case non etiree sur toute la largeur du cadre par defaut (SIZE_FILL) mais reduite a son
		## contenu et centree - la largeur commune (max_width) est appliquee juste apres, une fois
		## toutes les cases mesurees (retour utilisateur 2026-08-01 : cases trop larges, la
		## reponse la plus longue doit fixer la taille des autres).
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		buttons.append(button)

	## Plancher a 30% de la largeur du cadre (21% si au moins une reponse est un emoji, voir
	## LOGIC_CHOICE_WIDTH_RATIO plus haut - MIN_CHOICE_WIDTH_RATIO reste le plancher des reponses
	## textuelles, Logique inclue) - le panneau entier de la question, pas la sous-zone des choix :
	## une reponse la plus longue trop courte (ex. un seul chiffre) donnait des cases trop etroites
	## une fois reduites a leur contenu (retour utilisateur 2026-08-01). _panel_target_size (voir sa
	## declaration), pas panel.size ni choices_container.size : les deux peuvent encore refleter une
	## ancienne taille juste apres display_pack()/show_message() (retri differe d'au moins une frame),
	## la ou _panel_target_size est fiable des l'appel.
	var width_ratio := LOGIC_CHOICE_WIDTH_RATIO if has_emoji_choice else MIN_CHOICE_WIDTH_RATIO
	max_width = maxf(max_width, _panel_target_size.x * width_ratio)
	## Plafond ajoute le 2026-09-11 (retour utilisateur : question/reponses de comprehension de
	## texte CM2 tres longues poussaient le cadre au-dela de l'ecran). Avant ce plafond, max_width
	## restait la largeur naturelle sur UNE SEULE ligne de la reponse la plus longue (mesuree plus
	## haut, avant l'activation de l'autowrap sur chaque bouton) : pour une reponse-phrase complete
	## (courant en comprehension de texte), cette largeur peut largement depasser celle du cadre.
	## custom_minimum_size.x etant un plancher que Godot respecte meme au-dela du rect du parent
	## (voir docs.godotengine.org/en/4.7/tutorials/ui/size_and_anchors.html), la case forcait alors
	## Content, puis Margin, puis Panel a s'elargir - et Panel grandissant dans les 2 sens
	## (grow_horizontal = 2, voir la .tscn), il debordait de l'ecran a la fois a gauche et a droite.
	## En plafonnant ici a la largeur reellement disponible dans le cadre, l'autowrap deja actif sur
	## chaque bouton (button.autowrap_mode plus haut) prend enfin le relais et la reponse passe sur
	## plusieurs lignes (le bouton grandit alors en hauteur, comportement deja supporte) au lieu de
	## deborder en largeur.
	var available_width := _get_question_scroll_content_width()
	if is_logic:
		## 2 colonnes cote a cote (voir LOGIC_CHOICE_COLUMNS) : chaque case ne dispose que de la
		## moitie de available_width, moins l'ecart entre les 2 colonnes.
		available_width = (available_width - choices_container.get_theme_constant("h_separation")) / float(LOGIC_CHOICE_COLUMNS)
	max_width = minf(max_width, available_width)
	for button in buttons:
		button.custom_minimum_size.x = max_width

## Reduit la marge interne (content_margin) des styles normal/survol/presse/desactive de ce
## bouton, sans toucher a la police ni aux couleurs/bordures : ce sont ces marges, heritees du
## theme (14px/8px, voir game_theme.tres), qui font que la case reste grande une fois la police
## fixee - reduire uniquement LOGIC_CHOICE_MIN_HEIGHT/WIDTH_RATIO plus haut n'aurait aucun effet,
## un bouton ne peut jamais descendre sous le minimum impose par police + marge. Marge haut/bas
## reduite plus fort (LOGIC_CHOICE_VERTICAL_PADDING_SCALE) que gauche/droite (LOGIC_CHOICE_PADDING_
## SCALE) pour laisser plus de place verticale au glyphe sans agrandir la case (voir commentaire de
## LOGIC_CHOICE_VERTICAL_PADDING_SCALE - retour utilisateur 2026-08-05, formes rondes tronquees en
## haut). Duplique chaque style (jamais modifie le theme partage directement - toucherait tous les
## boutons du jeu, pas seulement Logique) et l'applique en tant que theme override local a ce
## bouton uniquement (voir add_theme_stylebox_override sur docs.godotengine.org/en/stable/classes/
## class_control.html). "focus" deliberement ignore : c'est un contour decoratif dessine par dessus
## le bouton, sans marge de contenu ni impact sur sa taille minimale.
func _apply_logic_choice_padding(button: Button) -> void:
	for state_name in ["normal", "hover", "pressed", "disabled"]:
		var original := button.get_theme_stylebox(state_name)
		var flat := original as StyleBoxFlat
		if flat == null:
			continue
		var scaled: StyleBoxFlat = flat.duplicate()
		scaled.content_margin_left *= LOGIC_CHOICE_PADDING_SCALE
		scaled.content_margin_top *= LOGIC_CHOICE_VERTICAL_PADDING_SCALE
		scaled.content_margin_right *= LOGIC_CHOICE_PADDING_SCALE
		scaled.content_margin_bottom *= LOGIC_CHOICE_VERTICAL_PADDING_SCALE
		button.add_theme_stylebox_override(state_name, scaled)

## true si ce texte de reponse contient au moins un emoji/symbole (voir EMOJI_CODEPOINT_THRESHOLD
## plus haut) - decide, par REPONSE et non par matiere entiere, si _populate_choice_buttons doit
## agrandir la police/reduire la marge de ce bouton precis (retour utilisateur 2026-08-04, 5e
## passe : Logique melange questions textuelles et symboliques, voir csv/questions/*/logique/).
func _is_emoji_choice(text: String) -> bool:
	for character in text:
		if character.unicode_at(0) >= EMOJI_CODEPOINT_THRESHOLD:
			return true
	return false

## Taille de police pour un emoji/symbole affiche dans la question, calee sur EXACTEMENT la meme
## taille que dans les reponses (retour utilisateur 2026-08-04, 6e passe : "la meme taille
## d'emoji... en gardant la taille de police inchangee"). Interroge le theme "comme si"
## [reference] etait un Button (theme_type="Button" explicite) plutot que d'utiliser la propre
## taille de base de QuestionLabel (TitleLabel, 24px - differente de celle des boutons, 20px) :
## c'est cette meme reference (Button/font_size) que _populate_choice_buttons multiplie deja par
## LOGIC_CHOICE_FONT_MULTIPLIER, donc les deux calculs restent forcement identiques quel que soit
## le theme actif (4 variantes, voir ui/theme/*.tres).
func _logic_emoji_font_size(reference: Control) -> int:
	var base_font_size := reference.get_theme_font_size("font_size", "Button")
	return roundi(base_font_size * LOGIC_CHOICE_FONT_MULTIPLIER)

## Construit le texte BBCode de QuestionLabel (RichTextLabel, voir plus haut) : chaque emoji/
## symbole (voir _is_emoji_choice) est entoure de [font_size=X] pour s'afficher agrandi, le reste
## du texte garde la taille TitleLabel standard (24px, inchangee) - retour utilisateur 2026-08-04,
## 6e passe. Applique a TOUT texte affiche par QuestionLabel (question ou message temporaire,
## Logique ou non) : sans emoji, cette fonction ne fait qu'echapper un eventuel crochet litteral
## du texte source (peu probable dans ce contenu mais defensif - [lb] est l'echappement BBCode
## officiel pour "[", voir doc_bbcode_in_richtextlabel), donc sans risque pour les autres matieres.
func _build_question_bbcode(text: String) -> String:
	var emoji_font_size := _logic_emoji_font_size(question_label)
	var result := ""
	var current_run := ""
	var current_is_emoji := false
	var has_run := false
	for character in text:
		var char_is_emoji := character.unicode_at(0) >= EMOJI_CODEPOINT_THRESHOLD
		if has_run and char_is_emoji != current_is_emoji:
			result += _wrap_bbcode_run(current_run, current_is_emoji, emoji_font_size)
			current_run = ""
		current_run += character
		current_is_emoji = char_is_emoji
		has_run = true
	if has_run:
		result += _wrap_bbcode_run(current_run, current_is_emoji, emoji_font_size)
	return result

func _wrap_bbcode_run(run: String, is_emoji: bool, emoji_font_size: int) -> String:
	if is_emoji:
		return "[font_size=%d]%s[/font_size]" % [emoji_font_size, run]
	return run.replace("[", "[lb]")

## Plafonne la taille REELLE de Panel a la portion d'ecran que ses ancres lui reservent (voir
## commentaire dans _ready()) - "size" ici est celle de QuestionPanel (racine de ce script), qui
## couvre tout l'ecran (ancres 0-1, voir la .tscn) : la meme reference que get_viewport_rect().size
## en pratique, mais sans dependre du viewport si ce panneau etait un jour reparente. Les ratios
## sont lus depuis les ancres de Panel elle-meme plutot que dupliques en dur (0.8/0.84), pour rester
## corrects si ces ancres changent un jour dans la .tscn.
## Met aussi en cache _panel_target_size (voir sa declaration) : panel.size lui-meme ne refletera
## ce plafond qu'apres que le moteur ait retraite la mise en page (differe d'au moins une frame
## apres un show()) - _get_question_scroll_content_width et _update_question_label_max_width
## utilisent donc ce cache, jamais panel.size directement, pour ne pas recalculer une largeur
## disponible perimee juste apres display_pack()/show_message().
func _update_panel_max_size() -> void:
	var ratio := Vector2(panel.anchor_right - panel.anchor_left, panel.anchor_bottom - panel.anchor_top)
	_panel_target_size = size * ratio
	panel.custom_maximum_size = _panel_target_size

## Largeur reellement disponible pour le contenu direct de QuestionScrollContent (QuestionCard,
## boutons QCM dans ChoicesContainer) : _panel_target_size (fiable immediatement, voir sa
## declaration) moins les marges imbriquees jusqu'a ce niveau.
## CORRECTION 2026-09-11 (2e passe, retour utilisateur : toujours tronque cote droit apres la 1ere
## correction) : il manquait la marge INTERNE du style de Panel lui-meme. "Panel" est un
## PanelContainer brut (pas de theme_type_variation), donc il herite du style par defaut
## PanelContainer/styles/panel du theme (StyleBoxFlat_row dans game_theme.tres) qui porte
## content_margin_left/right = 12 - un espace invisible dans l'editeur de scene (ce n'est pas un
## MarginContainer, donc pas de theme_override_constants a voir dans la .tscn) mais bien reel a
## l'affichage. Cette marge etait sans consequence tant que Panel pouvait grandir librement (avant
## le plafond de _update_panel_max_size) : le cadre s'agrandissait simplement de 24px de trop,
## invisible. Une fois Panel plafonne, ces 24px manquants dans le calcul font deborder le contenu
## de 24px a droite - d'ou la marge encore lue ici via get_theme_stylebox("panel").get_margin(...),
## jamais dupliquee en dur, pour rester correcte si le theme actif change (4 variantes, voir
## ui/theme/*.tres - toutes basees sur la meme structure).
func _get_question_scroll_content_width() -> float:
	var panel_style := panel.get_theme_stylebox("panel")
	return _panel_target_size.x \
			- panel_style.get_margin(SIDE_LEFT) \
			- panel_style.get_margin(SIDE_RIGHT) \
			- content_margin.get_theme_constant("margin_left") \
			- content_margin.get_theme_constant("margin_right") \
			- question_scroll_margin.get_theme_constant("margin_right")

## BUG CORRIGE 2026-08-04 : sans ceci, QuestionLabel (RichTextLabel + fit_content + autowrap,
## voir plus haut) restait invisible pour TOUTES les questions, pas seulement Logique - la doc
## officielle de RichTextLabel previent explicitement que fit_content+autowrap "must have a
## custom maximum width configured to work correctly" (voir docs.godotengine.org/en/stable/
## classes/class_richtextlabel.html, membre fit_content) : sans largeur maximale, le moteur ne
## peut pas calculer le retour a la ligne ni la hauteur de contenu qui en decoule, et le label
## s'effondre a une taille degeneree (0 ou incoherente) au lieu de s'afficher.
## Largeur precise (2026-09-11, remplace l'ancien "panel.size.x brut, surestimation sans
## consequence") : cette approximation etait fausse des que Panel ne peut plus grandir librement
## (voir _update_panel_max_size) - surestimer la largeur de retour a la ligne faisait alors
## déborder/tronquer le texte au lieu de le faire passer a la ligne, la vraie largeur disponible
## etant plus etroite que ce plafond. _get_question_scroll_content_width() moins la marge INTERNE
## du style de QuestionCard (meme cas que Panel juste au-dessus - QuestionCard est aussi un
## PanelContainer brut, meme style par defaut 12px gauche/droite) moins la marge de
## QuestionCardMargin (question_card_margin) donne la largeur exacte que QuestionLabel recevra.
func _update_question_label_max_width() -> void:
	var card_style := question_card.get_theme_stylebox("panel")
	question_label.custom_maximum_size.x = _get_question_scroll_content_width() \
			- card_style.get_margin(SIDE_LEFT) \
			- card_style.get_margin(SIDE_RIGHT) \
			- question_card_margin.get_theme_constant("margin_left") \
			- question_card_margin.get_theme_constant("margin_right")

func _clear_choice_buttons() -> void:
	for child in choices_container.get_children():
		child.queue_free()

func _on_choice_pressed(chosen_text: String) -> void:
	_submit_answer(chosen_text)

func _on_answer_submitted(new_text: String) -> void:
	if _questions.is_empty() or new_text.strip_edges().is_empty():
		return
	_submit_answer(new_text)

func _on_validate_pressed() -> void:
	_on_answer_submitted(answer_input.text)

func _on_close_pressed() -> void:
	_abort_pack()

## Ferme la fenetre (croix, ou joueur qui s'eloigne du PNJ en cours). Si le pack etait
## deja termine (tableau recapitulatif affiche), la recompense a deja ete versee dans
## _show_result : fermer ici ne fait qu'arreter l'affichage, rien n'est perdu pour le joueur.
func _abort_pack() -> void:
	_source = null
	_questions = []
	_history = []
	_clear_choice_buttons()
	_clear_result_rows()
	result_scroll.visible = false
	hide()

func _submit_answer(answer_text: String) -> void:
	var question := _questions[_current_index]
	var is_correct := question.is_correct(answer_text)
	## Retour sonore immediat a chaque question, avant meme la mise a jour de _correct_count
	## (voir autoload/sound_manager.gd).
	SoundManager.play(SoundManager.Sfx.CORRECT if is_correct else SoundManager.Sfx.WRONG)
	if is_correct:
		_correct_count += 1
	_history.append({
		"question_text": question.text,
		"given_answer": answer_text,
		"correct_answer": question.correct_answer,
		"is_correct": is_correct,
		"subject": question.subject,
	})
	_current_index += 1
	if _current_index >= _questions.size():
		_show_result()
	else:
		_display_current_question()

## Affiche le tableau recapitulatif du pack (une ligne par question, reponse en vert si juste,
## en rouge avec la correction a cote si fausse). Reste affiche jusqu'a fermeture manuelle (croix,
## voir _on_close_pressed) : contrairement a show_message, pas de fermeture automatique, pour
## laisser le temps de relire le detail.
func _show_result() -> void:
	var correct := _correct_count
	var total := _questions.size()
	var reward := CardRarity.get_pack_reward(_rarity, correct, total)
	## Petite fanfare de fin de pack, seulement si une recompense est effectivement gagnee.
	if reward > 0:
		SoundManager.play(SoundManager.Sfx.PACK_REWARD)
	## "Score" et "Résultat" fusionnes dans la pastille d'en-tete (ProgressBadge) - plus de carte
	## question separee pour l'afficher, elle est masquee ci-dessous. HeaderSpacer (entre pastille
	## et croix) reste actif comme en mode question : la pastille est collee a gauche et la croix
	## epinglee en haut a droite du cadre, quelle que soit la largeur du texte (retour utilisateur
	## 2026-08-01).
	## Nom de classe (CP/CE1/...) plutot que de rarete ("Commune"/"Peu commune"/...) depuis la
	## section "Récompenses" (2026-08-29, retour utilisateur : "on enleve le systeme commun peu
	## commun etc et on remplace juste par le nom des classes") - voir GradeLevel.get_grade_for_rarity.
	var grade := GradeLevel.get_grade_for_rarity(_rarity)
	## "pièce(s) {classe}" remplace par l'icone piece coloree de la classe (2026-08-31, retour
	## utilisateur : "remplace 'piece CP' par l icone de piece de la bonne couleur... pour toutes
	## les classes toutes les matieres") - le texte s'arrete desormais au nombre, l'icone (creee
	## dans _ready(), voir _progress_icon) prend le relais juste apres dans ProgressBadgeRow.
	progress_label.text = "Résultat : %d/%d, tu gagnes %d" % [correct, total, reward]
	_progress_icon.texture = load(GradeLevel.get_coin_icon_path(grade))
	_progress_icon.visible = true
	question_scroll.visible = false
	question_card.visible = false
	_clear_choice_buttons()
	choices_container.visible = false
	answer_input.visible = false
	validate_button.visible = false
	_populate_result_table()
	result_scroll.visible = true
	## Défi "classe + matière" (2026-09-05, voir ChallengeTracker) : incremente uniquement pour un
	## pack SANS FAUTE (retour utilisateur : "l'incrementation de succes se fait pour un resultat
	## sans faute"), donc plus exigeant que le seuil de 50% qui donne deja une recompense en pieces
	## ci-dessus. _questions (toujours la liste complete a ce stade, remise a [] juste apres) donne
	## la matiere du pack : uniforme sur tout le pack, jamais mélangée en cours de route, meme pour
	## un pack de revision qui pioche dans plusieurs classes anterieures (voir FRANCAIS_DIFFICULTE.md).
	## Popup + son (Sfx.CHALLENGE_SUCCESS) distincts de la fanfare PACK_REWARD ci-dessus : un
	## evenement different (progression Défis), pas la recompense en pieces - retour utilisateur :
	## "on precise l'incrementation de succes avec une popup et un petit son de reussite".
	if correct == total and total > 0:
		var subject: SubjectType.Subject = _questions[0].subject
		var new_count := ChallengeTracker.register_success(grade, subject)
		## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
		## juste apres la mutation reelle (ChallengeTracker.register_success ci-dessus).
		SaveManager.log_event("defi_reussi", {"grade": int(grade), "subject": int(subject), "nouveau_total": new_count})
		var challenge_text := "Défi \"%s\" (%s) : sans faute ! %d / %d réussites" % [
			SubjectType.get_label(subject), GradeLevel.get_label(grade), new_count, ChallengeTracker.GOLD_GOAL,
		]
		challenge_label.text = challenge_text
		challenge_label.visible = true
		_show_challenge_popup(challenge_text)
		SoundManager.play(SoundManager.Sfx.CHALLENGE_SUCCESS)
	else:
		challenge_label.visible = false
	_questions = []
	pack_completed.emit(_source, correct)

## Petit encart flottant confirmant la progression d'un Défi (voir _show_result()) - reste
## affiche RESULT_DISPLAY_SECONDS (meme duree que show_message()) puis se masque tout seul, sans
## bloquer la fermeture du recapitulatif (mouse_filter=2/IGNORE sur ChallengePopup, voir le .tscn).
func _show_challenge_popup(text: String) -> void:
	challenge_popup_label.text = text
	challenge_popup.visible = true
	await get_tree().create_timer(RESULT_DISPLAY_SECONDS).timeout
	challenge_popup.visible = false

func _clear_result_rows() -> void:
	for child in result_rows_container.get_children():
		child.queue_free()

func _populate_result_table() -> void:
	_clear_result_rows()
	for record in _history:
		var correction: String = "" if record["is_correct"] else str(record["correct_answer"])
		_add_result_row(
			str(record["question_text"]),
			str(record["given_answer"]),
			correction,
			record["is_correct"],
			record["subject"]
		)

## Une carte par question repondue, en 3 lignes empilees plutot qu'un tableau a colonnes (ancien
## format retour utilisateur 2026-07-28 : question/reponse/correction serrees cote a cote rendaient
## le texte ecrase et peu lisible). Ligne 1 = question en pleine largeur. Ligne 2 = reponse donnee
## (verte si juste, rouge si fausse), ligne 3 = correction (verte, seulement si la reponse etait
## fausse - rien a corriger sinon) ; ces deux lignes sont decalees de 20% vers la droite par
## rapport a la question (voir _build_indented_line) pour bien les distinguer d'un coup d'oeil
## (retour utilisateur 2026-08-01).
func _add_result_row(question_text: String, given_text: String, correction_text: String, is_correct: bool, subject: SubjectType.Subject) -> void:
	## Logique (2026-08-04) : la reponse/correction peut etre un emoji ou une forme Unicode -
	## le modulate rouge/vert (voir _build_indented_line) teinte les glyphes couleur au lieu de se
	## limiter au texte, ce qui denature le symbole (retour utilisateur ingame). Pour cette
	## matiere, seul le prefixe ("Ta réponse : "/"Correction : ") reste teinte ; le symbole garde
	## sa couleur d'origine - la pastille ResultIcon (a cote) indique deja juste/faux sans avoir
	## besoin de teinter le symbole.
	var tint_value := subject != SubjectType.Subject.LOGIC
	var lines := VBoxContainer.new()
	## Explicite plutot que de compter sur le FILL par defaut (1, sans EXPAND) : dans cette chaine
	## de conteneurs crees par script, la carte restait comprimee a la largeur minimale de son
	## contenu au lieu de prendre toute la largeur de la ligne (rate visuel du 2026-08-01) - EXPAND
	## force explicitement chaque conteneur de la chaine a occuper l'espace disponible.
	lines.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	lines.add_theme_constant_override("separation", 4)

	var q_label := Label.new()
	q_label.text = question_text
	q_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	## Sans ceci, le Label garde sa largeur minimale (juste assez pour le mot le plus long) au lieu
	## de prendre toute la largeur offerte par la ligne : l'autowrap coupait alors apres chaque mot,
	## produisant une colonne verticale d'un seul mot par ligne (rate visuel du 2026-08-01).
	q_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	## Jamais de modulate sur cette ligne (contrairement aux lignes reponse/correction ci-dessous) :
	## sans ceci elle gardait la couleur blanche par defaut du moteur pour Label.font_color,
	## illisible sur le fond clair des panneaux.
	q_label.theme_type_variation = &"TitleLabel"
	lines.add_child(q_label)

	var answer_icon := ResultIcon.new()
	answer_icon.is_correct = is_correct
	answer_icon.badge_color = CORRECT_COLOR if is_correct else WRONG_COLOR
	lines.add_child(_build_indented_line(
		"Ta réponse : ", given_text,
		CORRECT_COLOR if is_correct else WRONG_COLOR,
		tint_value,
		answer_icon
	))
	if not correction_text.is_empty():
		lines.add_child(_build_indented_line("Correction : ", correction_text, CORRECT_COLOR, tint_value))

	var row_margin := MarginContainer.new()
	row_margin.add_theme_constant_override("margin_left", RESULT_ROW_MARGIN)
	row_margin.add_theme_constant_override("margin_top", RESULT_ROW_MARGIN)
	row_margin.add_theme_constant_override("margin_right", RESULT_ROW_MARGIN)
	row_margin.add_theme_constant_override("margin_bottom", RESULT_ROW_MARGIN)
	row_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row_margin.add_child(lines)
	var row_card := PanelContainer.new()
	row_card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row_card.add_child(row_margin)
	result_rows_container.add_child(row_card)

## Ligne "reponse"/"correction" : une zone de marge (RESULT_INDENT_RATIO de la largeur) suivie du
## texte ("prefix" + "value" separes, voir tint_value ci-dessous), pour que le texte demarre a 20%
## depuis la gauche au lieu de s'aligner sous la question. "icon" (optionnel) se place dans cette
## marge, colle contre le texte (retour utilisateur 2026-08-01 : coche verte/croix rouge a cote de
## la reponse donnee par le joueur) - un HBoxContainer aligne a droite avec un spacer avant l'icone
## plutot qu'un simple Control vide.
## "prefix" ("Ta réponse : "/"Correction : ") est toujours teinte de [color]. "value" (la reponse/
## correction elle-meme) n'est teinte que si tint_value est vrai : pour Logique, value peut etre
## un emoji/une forme Unicode - le modulate rouge/vert teinterait alors le glyphe couleur au lieu
## de rester un simple habillage de texte (retour utilisateur ingame 2026-08-04), d'ou la scission
## en 2 Labels au lieu d'un seul avec le texte complet (comportement inchange pour les autres
## matieres : prefix + value restent tous deux teintes).
func _build_indented_line(prefix: String, value: String, color: Color, tint_value: bool, icon: Control = null) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var margin_zone := HBoxContainer.new()
	margin_zone.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin_zone.size_flags_stretch_ratio = RESULT_INDENT_RATIO
	margin_zone.alignment = BoxContainer.ALIGNMENT_END
	if icon != null:
		margin_zone.add_theme_constant_override("separation", 8)
		margin_zone.add_child(icon)
	row.add_child(margin_zone)

	var text_row := HBoxContainer.new()
	text_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_row.size_flags_stretch_ratio = 1.0 - RESULT_INDENT_RATIO

	## add_theme_color_override, pas modulate (corrige 2026-08-04, meme cause que CoinHUD - voir
	## son commentaire detaille) : modulate multipliait le font_color de base du theme, et
	## assombrissait [color] (vert/rouge) des qu'un theme a defini un font_color pour Label.
	var prefix_label := Label.new()
	prefix_label.text = prefix
	prefix_label.add_theme_color_override("font_color", color)
	text_row.add_child(prefix_label)

	var value_label := Label.new()
	value_label.text = value
	value_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	value_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if tint_value:
		value_label.add_theme_color_override("font_color", color)
	text_row.add_child(value_label)

	row.add_child(text_row)
	return row
