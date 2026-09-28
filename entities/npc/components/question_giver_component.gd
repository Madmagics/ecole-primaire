## Composant PNJ : represente un "maitre/maitresse" d'une CLASSE fixe (comme a l'ecole primaire
## reelle, ou un seul enseignant couvre toutes les matieres d'une classe - contrairement a un
## college/lycee ou chaque matiere a son propre professeur). A l'interaction, demande d'abord au
## joueur quelle matiere il veut travailler (parmi celles disponibles pour cette classe, voir
## get_available_subjects), puis compose un pack de questions de cette matiere et le lance : soit
## PACK_SIZE questions (10), tirees UNIQUEMENT dans la classe de ce PNJ. Depuis le 2026-09-28
## (retour d'utilisateurs "toujours les memes questions/textes"), le tirage passe par QuestionDraw :
## au moins une question par notion, pas de repetition avant d'avoir epuise une notion, textes de
## lecture tous lus avant d'en revoir un. L'ancien "pack de revision" qui melangeait les classes
## anterieures (Grammaire/Conjugaison/Orthographe/Anglais) est supprime.
## Recompense finale en pieces de la rarete liee a la classe de ce PNJ (voir GradeLevel.get_rarity),
## mise a l'echelle sur la taille reelle du pack (voir CardRarity.get_pack_reward) : impossible de
## "se declarer" plus jeune pour farmer des pieces, le gain reste plafonne a la classe du PNJ
## interroge.
## La classe et les matieres sont des donnees (QuestionResource), pas du code : un PNJ de CP et un
## PNJ de CM2 utilisent exactement ce meme script avec des ressources differentes.
class_name QuestionGiverComponent
extends Node

## Alias locaux : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe ; on "importe" l'enum dans une const locale.
const Subject = SubjectType.Subject
const Rarity = CardRarity.Rarity
const Grade = GradeLevel.Grade

## Emis a l'interaction : l'UI (SubjectSelectPanel) doit alors demander au joueur quelle matiere
## il veut travailler, parmi celles reellement disponibles pour cette classe.
signal subject_selection_requested(source: Node, grade: Grade, available_subjects: Array[Subject])
## Emis une fois la matiere choisie et 10 questions tirees : l'UI (QuestionPanel) pilote
## alors les questions une a une jusqu'a la fin du pack.
signal pack_started(source: Node, questions: Array[QuestionResource], rarity: Rarity)
## Emis si la matiere choisie n'a pas (encore) de questions dans ce PNJ.
signal pack_unavailable(source: Node, message: String)
## Emis specifiquement quand la limite d'utilisation quotidienne (controle parental) est deja
## atteinte a l'interaction (voir _on_interacted) - VOLONTAIREMENT distinct de pack_unavailable
## (2026-09-06, retour utilisateur : "lorsque la limite est atteinte jaimerais que le click sur un
## npc ouvre une popup reduite comme celle dun manque de piece pour la boutique avec un message en
## rouge. actuellement cest une fenetre avec un cadre titre vide inutile" - pack_unavailable ouvre
## la fenetre COMPLETE de QuestionPanel via show_message, pensee pour un vrai message de contenu
## indisponible, pas pour un simple avertissement) : cable vers un petit popup dedie
## (DailyLimitReachedOverlay, voir school.tscn) plutot que de reutiliser pack_unavailable.
signal daily_limit_reached(source: Node)
## Emis specifiquement pour Subject.READING ("Comprehension de texte") : contrairement a
## pack_started (questions immediates), il faut d'abord montrer le texte du passage tire au
## sort - l'UI (ReadingIntroPanel) l'affiche, puis relaie vers QuestionPanel une fois le bouton
## "Commencer" presse, sans retour possible sur le texte (voir FRANCAIS_DIFFICULTE.md).
signal reading_pack_started(source: Node, passage: PassageResource, questions: Array[QuestionResource], rarity: Rarity)

const PACK_SIZE := 10

## Titre affiche dans le bouton du reticule central (voir InteractPrompt) quand ce PNJ est en
## portee - pose sur l'InteractableComponent (prompt_text) au _ready. Genre (Maitre/Maitresse)
## choisi au hasard par classe pour l'instant, juste pour avoir un texte plausible a l'ecran :
## PAS de systeme de genre a construire ici, ces titres seront corriges/rendus coherents avec le
## personnage reel une fois les modeles 3D des PNJ en place (retour Steve, 2026-08-02).
const _GRADE_TEACHER_TITLES := {
	GradeLevel.Grade.CP: "Maîtresse du CP",
	GradeLevel.Grade.CE1: "Maître du CE1",
	GradeLevel.Grade.CE2: "Maîtresse du CE2",
	GradeLevel.Grade.CM1: "Maître du CM1",
	GradeLevel.Grade.CM2: "Maîtresse du CM2",
}

## Classe fixe de ce PNJ (contrairement a l'ancienne version ou c'etait la matiere qui etait
## fixe et la classe choisie a l'interaction - voir MATIERES_CANDIDATES.md pour le contexte de
## ce changement).
@export var grade: Grade = Grade.CP
## Questions forcees a la main pour ce PNJ (toutes matieres confondues). Laisser VIDE dans
## l'inspecteur (cas normal) : les questions viennent alors de ContentLibrary (paquets Supabase,
## depuis le 2026-09-27 - avant, scan des .tres de data/question/resources), demandees a chaque
## lancement de pack (voir _get_pool) pour profiter d'une publication recue en cours de session.
@export var question_pool: Array[QuestionResource] = []

## Rarete des pieces gagnees par ce PNJ, fixee une fois pour toutes par sa classe (voir grade).
var _rarity: Rarity = Rarity.COMMON
## Matiere et taille du pack en cours (determinees au lancement), memorisees pour resolve_pack.
var _current_subject: Subject = Subject.MATH
var _current_pack_size: int = PACK_SIZE

func _ready() -> void:
	_rarity = GradeLevel.get_rarity(grade)
	## Le jeu est desormais 2D uniquement (voir entities/npc_2d/npc_2d.tscn) - la branche 3D
	## historique (InteractableComponent/npc.tscn) a ete retiree avec le reste du park 3D
	## (voir project_2d_pivot en memoire ; recuperable via la branche git "backup3d" si besoin).
	var interactable := _find_sibling_interactable()
	if interactable:
		interactable.interacted.connect(_on_interacted)
		interactable.prompt_text = _GRADE_TEACHER_TITLES.get(grade, GradeLevel.get_label(grade))
	## Auto-connexion via EventBus (pas une connexion posee dans le .tscn) : voir event_bus.gd,
	## une connexion de scene pour ce signal s'est perdue plusieurs fois (reconstruction de
	## scene, ou ecrasee par un enregistrement depuis l'editeur). start_pack_for_subject
	## s'auto-filtre deja sur "source", donc chaque PNJ peut s'abonner sans risque au signal
	## diffuse a tous.
	EventBus.subject_selected.connect(start_pack_for_subject)

func _find_sibling_interactable() -> InteractableComponent2D:
	for child in get_parent().get_children():
		if child is InteractableComponent2D:
			return child
	return null

## Questions d'UNE matiere pour ce PNJ : question_pool si rempli a la main, sinon ContentLibrary.
## Renvoie toujours une COPIE (les appelants font des shuffle()).
func _get_pool(subject: Subject) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	if question_pool.is_empty():
		result.assign(ContentLibrary.get_questions(grade, subject))
		return result
	for question in question_pool:
		if question.subject == subject:
			result.append(question)
	return result

## Matieres reellement disponibles pour ce PNJ (donc cette classe), deduites du contenu charge
## plutot que d'une liste figee a la main : une nouvelle matiere apparait automatiquement des
## qu'un CSV est importe pour cette classe (voir MATIERES_CANDIDATES.md). Triee sur la valeur de
## l'enum Subject plutot que laissee dans l'ordre de scan du dossier (qui depend du systeme de
## fichiers et rendait l'ordre du menu incoherent d'un PNJ/d'une machine a l'autre - voir retour
## utilisateur 2026-07-28) : l'enum est deja range dans un ordre pedagogique voulu (maths, puis
## les 3 competences francaises regroupees, anglais et lecture en dernier).
func get_available_subjects() -> Array[Subject]:
	if question_pool.is_empty():
		return ContentLibrary.get_available_subjects(grade)
	var seen: Dictionary = {}
	var result: Array[Subject] = []
	for question in question_pool:
		if not seen.has(question.subject):
			seen[question.subject] = true
			result.append(question.subject)
	result.sort()
	return result

## Toutes les classes sont accessibles des le depart (2026-08-29, retour utilisateur : plus de
## deblocage payant - un enfant qui commence a un niveau donne peut reviser les classes
## precedentes ou tester les classes superieures sans rien acheter) : l'ancien blocage via
## GradeUnlock.is_unlocked() est retire ici, ainsi que l'ecoute de GradeUnlock.grade_unlocked et
## le grisage de la capsule dans _ready() (deja invisible en jeu, voir school.tscn -
## CapsuleVisual/visible=false, remplace par ProfVisual).
## Limite quotidienne de jeu (2026-09-06, retour utilisateur : "remise a zero a minuit, on
## applique cette mod maintenant") : verifiee ICI, avant meme de proposer le choix de matiere -
## une session DEJA en cours (SubjectSelectPanel ou QuestionPanel deja ouvert) n'est jamais
## interrompue par cette limite, seul le lancement d'un NOUVEAU pack est bloque. Emet
## daily_limit_reached (voir son commentaire ci-dessus) plutot que pack_unavailable depuis le
## 2026-09-06, 2e passe - petit popup dedie au lieu de la fenetre complete de QuestionPanel.
func _on_interacted(_who: Node) -> void:
	if get_available_subjects().is_empty():
		## Tout premier lancement du jeu sur cet appareil : paquets encore en telechargement.
		pack_unavailable.emit(self, "Chargement des questions en cours… réessaie dans un instant !")
		return
	if SaveManager.has_reached_daily_game_limit():
		daily_limit_reached.emit(self)
		return
	subject_selection_requested.emit(self, grade, get_available_subjects())

## Appele via EventBus.subject_selected (voir _ready et event_bus.gd), pas via une connexion
## posee dans le .tscn. Diffuse a tous les PNJ a la fois - le filtre "source != self" ci-dessous
## est donc essentiel, pas une securite superflue.
func start_pack_for_subject(source: Node, subject: Subject) -> void:
	if source != self:
		return
	if subject == Subject.READING:
		_start_reading_pack(source)
		return
	var key := _draw_key(subject)
	var state := SaveManager.get_draw_state(key)
	var sample := QuestionDraw.draw_questions(_get_pool(subject), PACK_SIZE, state)
	if sample.is_empty():
		pack_unavailable.emit(self, "Pas encore de questions de %s pour le %s !" % [SubjectType.get_label(subject), GradeLevel.get_label(grade)])
		return
	SaveManager.set_draw_state(key, state)
	_current_subject = subject
	_current_pack_size = sample.size()
	pack_started.emit(self, sample, _rarity)

## Matiere "Comprehension de texte" : tire un texte de cette classe pas encore lu dans le cycle en
## cours (voir QuestionDraw.draw_passage), puis PACK_SIZE questions parmi celles de CE texte (au
## moins une par notion, sans repetition avant d'avoir epuise la banque du texte). Banque par
## texte : 10 questions au CP (donc toujours les 10, ordre melange), 20 du CE1 au CM2. L'UI
## affiche d'abord le texte (ReadingIntroPanel), voir reading_pack_started.
func _start_reading_pack(_source: Node) -> void:
	var reading_pool := _get_pool(Subject.READING)
	var passages := _get_passages(reading_pool)
	if passages.is_empty():
		pack_unavailable.emit(self, "Pas encore de texte de %s pour le %s !" % [SubjectType.get_label(Subject.READING), GradeLevel.get_label(grade)])
		return
	var key := _draw_key(Subject.READING)
	var state := SaveManager.get_draw_state(key)
	var passage := QuestionDraw.draw_passage(passages, state)
	var pool: Array[QuestionResource] = []
	for question in reading_pool:
		if question.passage == passage:
			pool.append(question)
	if pool.is_empty():
		pack_unavailable.emit(self, "Ce texte n'a pas encore de questions !")
		return
	var questions := QuestionDraw.draw_questions(pool, PACK_SIZE, state)
	SaveManager.set_draw_state(key, state)
	_current_subject = Subject.READING
	_current_pack_size = questions.size()
	reading_pack_started.emit(self, passage, questions, _rarity)

## Cle de l'historique de tirage du compte (voir SaveManager.get_draw_state), ex. "ce2/math".
func _draw_key(subject: Subject) -> String:
	return "%s/%s" % [GradeLevel.get_folder_name(grade), SubjectType.get_folder_name(subject)]

## PassageResource distincts references par [pool] - meme instance partagee par toutes les
## questions d'un meme paquet (voir ContentLibrary._build_questions), d'ou la comparaison "=="
## fiable dans _start_reading_pack.
func _get_passages(pool: Array[QuestionResource]) -> Array[PassageResource]:
	var seen: Dictionary = {}
	var result: Array[PassageResource] = []
	for question in pool:
		if question.passage != null and not seen.has(question.passage):
			seen[question.passage] = true
			result.append(question.passage)
	return result

## Appele par l'UI (QuestionPanel, partagee par tous les PNJ) une fois que le joueur a
## repondu aux questions d'UN pack. "source" identifie quel PNJ a lance ce pack : si ce
## n'est pas celui-ci, on ignore (evite de recompenser tous les PNJ a la fois).
func resolve_pack(source: Node, correct_count: int) -> void:
	if source != self:
		return
	var reward := CardRarity.get_pack_reward(_rarity, correct_count, _current_pack_size)
	if reward > 0:
		Economy.add_coins(_rarity, reward)
		## Journal d'evenements pour la synchro serveur (2026-09-13, voir SaveManager.log_event()) :
		## juste apres la mutation reelle (Economy.add_coins ci-dessus), jamais avant.
		SaveManager.log_event("gain_piece", {"rarity": int(_rarity), "montant": reward})
	EventBus.pack_completed.emit(_current_subject, _rarity, correct_count, _current_pack_size, reward)
	## Sauvegarde automatique (2026-08-01) : un pack reussi met a jour les pieces (Economy) et les
	## statistiques (StatsTracker, deja a jour a ce stade - il ecoute ce meme signal
	## EventBus.pack_completed, emis juste au-dessus, de facon synchrone) - autant persister tout
	## de suite plutot que de compter sur une sauvegarde manuelle depuis le menu.
	SaveManager.save_current_account()
