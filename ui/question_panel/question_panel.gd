## Fenetre 2D generique pour poser un pack de questions les unes apres les autres :
## fonctionne pour toute matiere/rarete, le contenu vient entierement des QuestionResource
## passees en parametre.
## Mode de reponse : boutons QCM des qu'une question a des choix (choice_2/3/4 dans le CSV),
## sur toutes les plateformes (evite de deviner a l'aveugle la forme attendue d'un texte a
## trous au clavier). Sinon, saisie clavier + Entree OU bouton "Valider". A la fin du pack, affiche un
## tableau recapitulatif (une ligne par question : reponse donnee en vert si juste, en rouge
## avec la correction a cote si fausse) qui reste affiche jusqu'a fermeture manuelle.
## Se ferme (sans recompense si le pack n'est pas termine, la recompense ayant deja ete versee
## des l'affichage du recapitulatif sinon) si le joueur quitte la bulle du PNJ en cours, via la
## croix de fermeture, ou avec Echap.
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

@onready var panel: PanelContainer = $Panel
@onready var progress_label: Label = $Panel/Margin/Content/HeaderRow/ProgressBadge/ProgressLabel
@onready var question_card: PanelContainer = $Panel/Margin/Content/QuestionCard
## RichTextLabel (pas Label, depuis 2026-08-04) : necessaire pour agrandir uniquement les
## emojis/symboles d'une question Logique via BBCode ([font_size=X]) tout en gardant le reste du
## texte a la taille TitleLabel standard - voir _build_question_bbcode. Le theme (les 4 variantes,
## voir ui/theme/*.tres) porte les cles normal_font_size/default_color en plus de font_size/
## font_color pour que ce changement de type de noeud ne change pas l'apparence des questions
## sans emoji.
@onready var question_label: RichTextLabel = $Panel/Margin/Content/QuestionCard/QuestionCardMargin/QuestionLabel
@onready var answer_input: LineEdit = $Panel/Margin/Content/AnswerRow/AnswerInput
@onready var choices_container: GridContainer = $Panel/Margin/Content/ChoicesContainer
@onready var validate_button: Button = $Panel/Margin/Content/AnswerRow/ValidateButton
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton
@onready var result_scroll: ScrollContainer = $Panel/Margin/Content/ResultScroll
@onready var result_rows_container: VBoxContainer = $Panel/Margin/Content/ResultScroll/ResultRowsMargin/ResultRows

## Marge interne d'une ligne du tableau recapitulatif (voir _add_result_row) - assez large pour
## une lecture confortable sans gonfler artificiellement la hauteur de chaque ligne.
const RESULT_ROW_MARGIN := 10.0
## Part de largeur laissee vide avant la reponse/correction (voir _build_indented_line) : decale
## ces deux lignes de 20% vers la droite par rapport a la question, pour bien les distinguer d'un
## simple coup d'oeil (retour utilisateur 2026-08-01).
const RESULT_INDENT_RATIO := 0.2

var _source: Node
var _questions: Array[QuestionResource] = []
var _rarity: CardRarity.Rarity = CardRarity.Rarity.COMMON
var _current_index: int = 0
var _correct_count: int = 0
## Historique du pack en cours, une entree par question repondue, dans l'ordre : sert a
## construire le tableau recapitulatif affiche par _show_result.
var _history: Array[Dictionary] = []

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	answer_input.text_submitted.connect(_on_answer_submitted)
	validate_button.pressed.connect(_on_validate_pressed)
	close_button.pressed.connect(_on_close_pressed)
	## Se ferme si le PNJ dont le pack est en cours sort de la portee du joueur (le joueur
	## s'est eloigne). Compare via le parent commun (InteractableComponent et
	## QuestionGiverComponent sont freres sous le meme noeud PNJ), sans lien direct entre les
	## composants (voir la regle EventBus du projet).
	EventBus.interactable_unfocused.connect(_on_interactable_unfocused)
	## Fige le joueur (deplacement + interaction) tant que ce panneau est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Affiche un message temporaire (ex: "pas encore de questions pour ce niveau") puis se
## referme toute seule, comme l'ecran de resultat. Reutilise pour QuestionGiverComponent.
## pack_unavailable ; le "source" en parametre n'est pas utilise ici, l'affichage seul suffit.
func show_message(_source: Node, message: String) -> void:
	result_scroll.visible = false
	question_card.visible = true
	progress_label.text = ""
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
	show()
	_display_current_question()

func _display_current_question() -> void:
	question_card.visible = true
	var question := _questions[_current_index]
	progress_label.text = "Question %d/%d" % [_current_index + 1, _questions.size()]
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
	## une fois reduites a leur contenu (retour utilisateur 2026-08-01). "panel" plutot que
	## "choices_container" : ce dernier bascule visible=false/true a chaque question (voir
	## _display_current_question), et son "size" n'est pas garanti a jour au moment precis ou ce
	## code s'execute (le retri d'un conteneur suite a un changement de visibilite peut n'avoir
	## lieu qu'a la frame suivante) - ce qui expliquait que le plancher restait sans effet. "panel"
	## (le cadre) reste toujours visible et dimensionne par ses ancres des le demarrage, sa taille
	## est donc fiable a cet instant.
	var width_ratio := LOGIC_CHOICE_WIDTH_RATIO if has_emoji_choice else MIN_CHOICE_WIDTH_RATIO
	max_width = maxf(max_width, panel.size.x * width_ratio)
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

## BUG CORRIGE 2026-08-04 : sans ceci, QuestionLabel (RichTextLabel + fit_content + autowrap,
## voir plus haut) restait invisible pour TOUTES les questions, pas seulement Logique - la doc
## officielle de RichTextLabel previent explicitement que fit_content+autowrap "must have a
## custom maximum width configured to work correctly" (voir docs.godotengine.org/en/stable/
## classes/class_richtextlabel.html, membre fit_content) : sans largeur maximale, le moteur ne
## peut pas calculer le retour a la ligne ni la hauteur de contenu qui en decoule, et le label
## s'effondre a une taille degeneree (0 ou incoherente) au lieu de s'afficher. "panel.size.x" est
## la meme reference fiable deja utilisee dans _populate_choice_buttons (toujours visible et
## dimensionne par ses ancres des le demarrage, contrairement a des conteneurs qui bascule
## visible=false/true) - la valeur donnee ici est un PLAFOND (Control.custom_maximum_size), pas
## une largeur imposee : le conteneur parent (QuestionCardMargin) continue de donner sa largeur
## reelle, toujours <= panel.size.x, donc surestimer legerement ce plafond est sans consequence.
func _update_question_label_max_width() -> void:
	question_label.custom_maximum_size.x = panel.size.x

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

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_abort_pack()
		get_viewport().set_input_as_handled()

## Node (pas InteractableComponent) : recoit indifferemment un interactable 3D ou 2D depuis le
## passage du jeu en 2D (voir InteractorComponent.gd).
func _on_interactable_unfocused(interactable: Node) -> void:
	if _source == null or interactable == null:
		return
	if _source.get_parent() == interactable.get_parent():
		_abort_pack()

## Ferme la fenetre (croix, Echap, ou joueur qui s'eloigne du PNJ en cours). Si le pack etait
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
## en rouge avec la correction a cote si fausse). Reste affiche jusqu'a fermeture manuelle
## (croix ou Echap, geres globalement par _on_close_pressed / _unhandled_input) : contrairement
## a show_message, pas de fermeture automatique, pour laisser le temps de relire le detail.
func _show_result() -> void:
	var correct := _correct_count
	var total := _questions.size()
	var reward := CardRarity.get_pack_reward(_rarity, correct, total)
	## "Score" et "Résultat" fusionnes dans la pastille d'en-tete (ProgressBadge) - plus de carte
	## question separee pour l'afficher, elle est masquee ci-dessous. HeaderSpacer (entre pastille
	## et croix) reste actif comme en mode question : la pastille est collee a gauche et la croix
	## epinglee en haut a droite du cadre, quelle que soit la largeur du texte (retour utilisateur
	## 2026-08-01).
	var piece_word := "pièce" if reward <= 1 else "pièces"
	progress_label.text = "Résultat : %d/%d, tu gagnes %d %s %s" % [correct, total, reward, piece_word, CardRarity.get_label(_rarity)]
	question_card.visible = false
	_clear_choice_buttons()
	choices_container.visible = false
	answer_input.visible = false
	validate_button.visible = false
	_populate_result_table()
	result_scroll.visible = true
	_questions = []
	pack_completed.emit(_source, correct)

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
