## Composant PNJ : represente un "maitre/maitresse" d'une CLASSE fixe (comme a l'ecole primaire
## reelle, ou un seul enseignant couvre toutes les matieres d'une classe - contrairement a un
## college/lycee ou chaque matiere a son propre professeur). A l'interaction, demande d'abord au
## joueur quelle matiere il veut travailler (parmi celles disponibles pour cette classe, voir
## get_available_subjects), puis compose un pack de questions de cette matiere et le lance : soit
## PACK_SIZE questions au total (10, voir retour utilisateur 2026-08-01 "questionnaires a
## rallonge" - avant cette date, un "pack de revision" pouvait monter a 10-25 questions), soit
## tirees uniquement dans la classe de ce PNJ (Maths, Lecture), soit reparties avec les classes
## anterieures pour Grammaire/Conjugaison/Orthographe/Anglais (voir REVIEW_SUBJECTS,
## _build_review_pack, et FRANCAIS_DIFFICULTE.md pour le detail du bareme).
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
const RESOURCES_DIR := "res://data/question/resources"

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
## Toutes les questions de ce PNJ, toutes matieres confondues (filtrees par matiere choisie au
## moment de l'interaction, voir start_pack_for_subject). Laisser VIDE dans l'inspecteur pour
## charger automatiquement toutes les QuestionResource de RESOURCES_DIR/<classe>/ correspondant
## a "grade" (voir _ready) : evite de re-cabler chaque PNJ a la main a chaque ajout de contenu en
## masse. Ne remplir ce champ a la main que si un PNJ doit un jour se limiter a un sous-ensemble
## specifique de questions.
@export var question_pool: Array[QuestionResource] = []

## Matieres avec "pack de revision" (voir _build_review_pack) : en plus des questions de la
## classe de ce PNJ, le pack pioche aussi dans les classes anterieures pour faire reviser les
## acquis, evitant que le joueur oublie une notion vue l'annee precedente. Exclut Maths (les
## acquis y sont deja cumulatifs par construction - un probleme de CM2 suppose les tables et les
## 4 operations - reviser au hasard des additions de CP n'apporterait rien) et Lecture (mecanique
## dediee au passage, pas de pack "plat"). Voir FRANCAIS_DIFFICULTE.md pour le detail du bareme.
const REVIEW_SUBJECTS: Array[Subject] = [Subject.GRAMMAR, Subject.CONJUGATION, Subject.SPELLING, Subject.ENGLISH]

## Rarete des pieces gagnees par ce PNJ, fixee une fois pour toutes par sa classe (voir grade).
var _rarity: Rarity = Rarity.COMMON
## Matiere et taille du pack en cours (determinees au lancement), memorisees pour resolve_pack.
var _current_subject: Subject = Subject.MATH
var _current_pack_size: int = PACK_SIZE

func _ready() -> void:
	_rarity = GradeLevel.get_rarity(grade)
	if question_pool.is_empty():
		question_pool = _load_all_for_grade(grade)
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

## Scanne RESOURCES_DIR/<classe>/ (et ses sous-dossiers matiere, voir import_questions.gd) et
## renvoie toutes les QuestionResource qui s'y trouvent, toutes matieres confondues (le filtrage
## par matiere se fait ensuite dans start_pack_for_subject, au moment ou le joueur choisit).
## Depuis aout 2026, chaque .tres rencontre est un QuestionBankResource regroupant toutes les
## questions d'UN CSV source (voir data/question/question_bank_resource.gd) plutot qu'une
## QuestionResource isolee : un fichier par CSV/matiere au lieu d'un fichier par question, pour
## eviter des milliers d'ouvertures de fichier a chaque demarrage (voir ARCHITECTURE.md).
func _load_all_for_grade(target_grade: Grade) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	var folder_name := GradeLevel.get_folder_name(target_grade)
	if folder_name == "":
		return result
	_scan_dir(RESOURCES_DIR + "/" + folder_name, result)
	return result

## Enumeration via ResourceLoader.list_directory(), PAS DirAccess (2026-09-12, bug clic PNJ
## inactif sur la version en ligne) : DirAccess.open()/list_dir_begin()/get_next() sur un dossier
## res:// est un cas documente comme non fiable sur un projet EXPORTE (PCK), meme si parfaitement
## fiable dans l'editeur (confirme via github.com/godotengine/godot issues #87552/#99047 et la
## proposition officielle godot-proposals#13122 qui documente cette incoherence editeur/export) -
## ce projet n'ayant qu'un seul export (Web, voir export_presets.cfg), le symptome se voit
## uniquement "en ligne", jamais en testant depuis l'editeur. Consequence concrete ici : dir restait
## null (ou la liste vide) sur la version deployee -> question_pool restait vide pour les 5 PNJ ->
## _on_interacted() ci-dessous sortait des sa toute premiere ligne (question_pool.is_empty()) sans
## rien faire, ni signal ni erreur - d'ou l'impression d'un clic totalement mort sur les PNJ.
## ResourceLoader.list_directory() est le contournement confirme fonctionnel a l'export (meme
## proposition #13122) : renvoie les noms de ressources "propres" (pas de suffixe .import/.remap a
## filtrer) avec un "/" final pour les sous-dossiers.
func _scan_dir(dir_path: String, result: Array[QuestionResource]) -> void:
	for entry: String in ResourceLoader.list_directory(dir_path):
		if entry.ends_with("/"):
			_scan_dir("%s/%s" % [dir_path, entry.trim_suffix("/")], result)
		elif entry.ends_with(".tres"):
			var bank := load("%s/%s" % [dir_path, entry]) as QuestionBankResource
			if bank:
				result.append_array(bank.questions)

## Matieres reellement disponibles pour ce PNJ (donc cette classe), deduites du contenu charge
## plutot que d'une liste figee a la main : une nouvelle matiere apparait automatiquement des
## qu'un CSV est importe pour cette classe (voir MATIERES_CANDIDATES.md). Triee sur la valeur de
## l'enum Subject plutot que laissee dans l'ordre de scan du dossier (qui depend du systeme de
## fichiers et rendait l'ordre du menu incoherent d'un PNJ/d'une machine a l'autre - voir retour
## utilisateur 2026-07-28) : l'enum est deja range dans un ordre pedagogique voulu (maths, puis
## les 3 competences francaises regroupees, anglais et lecture en dernier).
func get_available_subjects() -> Array[Subject]:
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
	if question_pool.is_empty():
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
	var sample: Array[QuestionResource] = _build_review_pack(subject) if subject in REVIEW_SUBJECTS else _sample_own_grade(subject, PACK_SIZE)
	if sample.is_empty():
		pack_unavailable.emit(self, "Pas encore de questions de %s pour le %s !" % [SubjectType.get_label(subject), GradeLevel.get_label(grade)])
		return
	sample.shuffle()
	_current_subject = subject
	_current_pack_size = sample.size()
	pack_started.emit(self, sample, _rarity)

## Matiere "Comprehension de texte" : tire un passage au hasard parmi ceux de cette classe,
## reunit TOUTES les questions liees a ce passage (pas un echantillon plat comme les autres
## matieres - uniquement celles du texte tire), puis n'en garde que PACK_SIZE tirees au hasard
## parmi elles (voir PACK_SIZE) : la banque par texte peut contenir plus de questions que
## PACK_SIZE (CE1 a CM2 : 20 questions en banque, 10 jouees a chaque fois) afin qu'une relecture
## du meme texte ne repose pas systematiquement les 20 memes questions dans le meme ordre - voir
## retour utilisateur 2026-07-31. Au CP, la banque ne compte que 10 questions (= PACK_SIZE) : le
## tirage y est donc toujours integral, sans variation possible, ce qui est attendu (pas de pool
## plus large prevu pour cette classe). L'UI affiche d'abord le texte (ReadingIntroPanel) avant
## d'enchainer sur les questions, voir reading_pack_started.
func _start_reading_pack(_source: Node) -> void:
	var passages := _load_passages_for_grade(grade)
	if passages.is_empty():
		pack_unavailable.emit(self, "Pas encore de texte de %s pour le %s !" % [SubjectType.get_label(Subject.READING), GradeLevel.get_label(grade)])
		return
	var passage: PassageResource = passages.pick_random()
	var pool: Array[QuestionResource] = []
	for question in question_pool:
		if question.subject == Subject.READING and question.passage == passage:
			pool.append(question)
	if pool.is_empty():
		pack_unavailable.emit(self, "Ce texte n'a pas encore de questions !")
		return
	pool.shuffle()
	var questions: Array[QuestionResource] = pool.slice(0, mini(PACK_SIZE, pool.size()))
	_current_subject = Subject.READING
	_current_pack_size = questions.size()
	reading_pack_started.emit(self, passage, questions, _rarity)

## Renvoie tous les PassageResource distincts reference par les questions READING de
## question_pool (deja charge en memoire par _load_all_for_grade au _ready) - PAS un nouveau
## scan/chargement depuis le disque. Important depuis le passage aux QuestionBankResource (aout
## 2026, voir _scan_dir) : un second load() independant du meme fichier .tres pourrait renvoyer
## une INSTANCE DIFFERENTE du meme passage si le QuestionBankResource charge une premiere fois
## au _ready n'est plus reference nulle part (son cache memoire n'est alors plus garanti), ce qui
## casserait la comparaison par reference "question.passage == passage" plus bas dans
## _start_reading_pack (meme bug que celui documente dans passage_resource.gd, evite ici en ne
## rechargeant jamais depuis le disque une donnee deja en memoire).
func _load_passages_for_grade(_target_grade: Grade) -> Array[PassageResource]:
	var seen: Dictionary = {}
	var result: Array[PassageResource] = []
	for question in question_pool:
		if question.subject == Subject.READING and question.passage != null and not seen.has(question.passage):
			seen[question.passage] = true
			result.append(question.passage)
	return result

## Matiere "plate" (Maths, Lecture) : tire au hasard dans le pool de la classe de ce PNJ
## uniquement, comme avant l'introduction du pack de revision.
func _sample_own_grade(subject: Subject, count: int) -> Array[QuestionResource]:
	var matching: Array[QuestionResource] = []
	for question in question_pool:
		if question.subject == subject:
			matching.append(question)
	matching.shuffle()
	return matching.slice(0, mini(count, matching.size()))

## Matiere "avec revision" (voir REVIEW_SUBJECTS) : compose le pack en piochant a la fois dans
## la classe de ce PNJ et dans les classes anterieures ou cette matiere existe, selon un bareme
## qui augmente avec la classe (voir _compute_review_quotas) - documente et valide avec
## l'utilisateur dans FRANCAIS_DIFFICULTE.md.
func _build_review_pack(subject: Subject) -> Array[QuestionResource]:
	var scope := _get_subject_grade_scope(subject)
	var idx := scope.find(grade)
	if idx == -1:
		return []
	var result: Array[QuestionResource] = []
	for quota in _compute_review_quotas(scope, idx):
		var source_grade: Grade = quota[0]
		var count: int = quota[1]
		var pool := question_pool if source_grade == grade else _load_subject_for_grade(subject, source_grade)
		var matching: Array[QuestionResource] = []
		for question in pool:
			if question.subject == subject:
				matching.append(question)
		matching.shuffle()
		result.append_array(matching.slice(0, mini(count, matching.size())))
	return result

## Bareme de revision (voir FRANCAIS_DIFFICULTE.md) : pour une matiere qui existe sur N classes
## (ex. Anglais : CP a CM2, N=5 ; Grammaire/Conjugaison/Orthographe : CE1 a CM2, N=4), la classe
## d'index idx (0 = premiere classe ou la matiere existe) determine des POIDS relatifs entre les
## classes concernees, puis _distribute_quota les convertit en un nombre entier de questions dont
## la somme fait toujours PACK_SIZE (10) au total - avant le 2026-08-01 le total montait jusqu'a
## 25 (poids fixes multiplies par le nombre de classes anterieures au lieu d'etre mis a l'echelle,
## retour utilisateur "questionnaires a rallonge") :
## - idx == 0 (premiere classe) : PACK_SIZE questions de sa propre classe uniquement.
## - idx == derniere classe : poids egal (1) pour CHAQUE classe du parcours (y compris la sienne)
##   - revision egalitaire de toutes les annees avant l'entree au college.
## - sinon : poids double (2) pour sa propre classe par rapport a chaque classe anterieure (poids
##   1 chacune) - reprend le ratio 10:5 de l'ancien bareme fixe, juste mis a l'echelle.
func _compute_review_quotas(scope: Array[Grade], idx: int) -> Array:
	if idx == 0:
		return [[scope[0], PACK_SIZE]]
	if idx == scope.size() - 1:
		var equal_weights: Array[float] = []
		for _g in scope:
			equal_weights.append(1.0)
		var equal_counts := _distribute_quota(equal_weights, PACK_SIZE)
		var equal_quotas: Array = []
		for i in scope.size():
			equal_quotas.append([scope[i], equal_counts[i]])
		return equal_quotas
	var weights: Array[float] = [2.0]
	for _i in range(idx):
		weights.append(1.0)
	var counts := _distribute_quota(weights, PACK_SIZE)
	var quotas: Array = [[scope[idx], counts[0]]]
	for i in range(idx):
		quotas.append([scope[i], counts[i + 1]])
	return quotas

## Convertit des poids relatifs en quotas entiers dont la somme vaut exactement "total" (methode
## du plus grand reste : un arrondi naif poids par poids peut sinon totaliser un de plus ou de
## moins que "total", ex. 3 poids egaux pour 10 questions donnerait 3+3+3=9 sans cette correction).
func _distribute_quota(weights: Array[float], total: int) -> Array[int]:
	var weight_sum := 0.0
	for w in weights:
		weight_sum += w
	var shares: Array[float] = []
	var quotas: Array[int] = []
	var assigned := 0
	for w in weights:
		var share: float = w / weight_sum * total
		shares.append(share)
		var floor_share := int(share)
		quotas.append(floor_share)
		assigned += floor_share
	var remaining := total - assigned
	var order := range(weights.size())
	order.sort_custom(func(a: int, b: int) -> bool: return (shares[a] - quotas[a]) > (shares[b] - quotas[b]))
	for i in range(remaining):
		quotas[order[i]] += 1
	return quotas

## Liste ordonnee (CP -> CM2) des classes ou cette matiere a effectivement du contenu sur le
## disque - deduite de l'arborescence plutot que figee en dur, meme principe data-driven que
## get_available_subjects (une matiere qui gagne une classe supplementaire plus tard n'a rien
## a toucher ici).
func _get_subject_grade_scope(subject: Subject) -> Array[Grade]:
	var subject_folder := SubjectType.get_folder_name(subject)
	var result: Array[Grade] = []
	for g in [Grade.CP, Grade.CE1, Grade.CE2, Grade.CM1, Grade.CM2]:
		var path := "%s/%s/%s" % [RESOURCES_DIR, GradeLevel.get_folder_name(g), subject_folder]
		if DirAccess.dir_exists_absolute(path):
			result.append(g)
	return result

## Charge uniquement les QuestionResource d'UNE matiere pour UNE classe anterieure (pas tout le
## pool de cette classe comme _load_all_for_grade) : utilise par _build_review_pack pour aller
## chercher les questions de revision sans recharger des matieres non concernees.
func _load_subject_for_grade(subject: Subject, target_grade: Grade) -> Array[QuestionResource]:
	var subject_folder := SubjectType.get_folder_name(subject)
	var path := "%s/%s/%s" % [RESOURCES_DIR, GradeLevel.get_folder_name(target_grade), subject_folder]
	var result: Array[QuestionResource] = []
	_scan_dir(path, result)
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
	EventBus.pack_completed.emit(_current_subject, _rarity, correct_count, _current_pack_size, reward)
	## Sauvegarde automatique (2026-08-01) : un pack reussi met a jour les pieces (Economy) et les
	## statistiques (StatsTracker, deja a jour a ce stade - il ecoute ce meme signal
	## EventBus.pack_completed, emis juste au-dessus, de facon synchrone) - autant persister tout
	## de suite plutot que de compter sur une sauvegarde manuelle depuis le menu.
	SaveManager.save_current_account()
