## Bibliotheque de contenu pedagogique (2026-09-27) : les questions, textes de lecture et fiches de
## cours viennent desormais de Supabase (paquets publies par fn_publier(), voir
## server/contenu_schema.sql et server/notions_3_publication_vues.sql), plus des .tres embarques
## dans le jeu (data/question/resources, genere depuis les CSV - ancien systeme).
##
## Fonctionnement :
## - Au demarrage, lit UNIQUEMENT le manifeste deja en cache (user://contenu/manifeste.json) :
##   instantane, les paquets eux-memes ne sont lus sur le disque que lorsqu'on en a besoin.
## - Puis, en arriere-plan (jamais bloquant), demande les versions au serveur (fn_manifeste) et
##   telecharge EN PARALLELE uniquement les paquets qui ont change (fn_paquet). Recommence a chaque
##   connexion d'un compte (SaveManager.account_logged_in) : une publication arrive donc chez les
##   joueurs a leur prochaine connexion, sans nouvel export du jeu.
## - Les QuestionResource/PassageResource sont fabriquees en memoire (jamais sauvegardees) a la
##   premiere demande d'une classe+matiere, puis gardees en memoire (voir get_questions). Un meme
##   paquet partage UNE instance de PassageResource entre toutes ses questions : la comparaison
##   "question.passage == passage" de QuestionGiverComponent._start_reading_pack reste fiable.
##
## Cles de paquet : "<classe>/<matiere>", ex. "cp/math", construites avec
## GradeLevel.get_folder_name() et SubjectType.get_folder_name() (memes noms que cote serveur).
extends Node

const Subject = SubjectType.Subject
const Grade = GradeLevel.Grade

## Emis apres chaque rafraichissement termine (reussi ou non), pour les fenetres qui listent les
## matieres (ex. fenetre Succes) si elles veulent se mettre a jour.
signal content_updated

const CACHE_DIR := "user://contenu"
const MANIFEST_PATH := CACHE_DIR + "/manifeste.json"

## Versions des paquets PRESENTS dans le cache local, ex. {"cp/math": 3}.
var _manifest: Dictionary = {}
## Paquets deja fabriques en memoire : cle -> Array[QuestionResource].
var _built: Dictionary = {}
## Fiches de cours deja lues : cle -> Array[Dictionary] {"id", "notion", "titre", "contenu"}.
var _fiches: Dictionary = {}
## Notions de chaque paquet : cle -> Array[Dictionary] {"code", "libelle"}.
var _notions: Dictionary = {}
var _refreshing := false
var _pending_downloads := 0

signal _downloads_finished

func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(CACHE_DIR)
	var cached: Variant = _read_json(MANIFEST_PATH)
	if cached is Dictionary:
		_manifest = cached
	SaveManager.account_logged_in.connect(func(_profile: Dictionary) -> void: refresh())
	refresh()

## Vrai des qu'au moins un paquet est disponible (cache ou reseau).
func is_ready() -> bool:
	return not _manifest.is_empty()

func has_pack(grade: Grade, subject: Subject) -> bool:
	return _manifest.has(_key(grade, subject))

## Matieres disponibles pour [grade], triees sur l'enum Subject (ordre pedagogique, voir
## QuestionGiverComponent.get_available_subjects). Liste vide tant que rien n'est charge.
func get_available_subjects(grade: Grade) -> Array[Subject]:
	var result: Array[Subject] = []
	for subject: Subject in Subject.values():
		if has_pack(grade, subject):
			result.append(subject)
	result.sort()
	return result

## Toutes les questions d'une classe+matiere (tableau vide si le paquet n'est pas disponible).
## NE PAS modifier le tableau renvoye (partage) : le dupliquer avant un shuffle().
func get_questions(grade: Grade, subject: Subject) -> Array[QuestionResource]:
	var key := _key(grade, subject)
	if _built.has(key):
		return _built[key]
	var empty: Array[QuestionResource] = []
	if not _manifest.has(key):
		return empty
	var data: Variant = _read_json(_pack_path(key))
	if not (data is Dictionary):
		return empty
	var questions := _build_questions(grade, subject, data)
	_built[key] = questions
	return questions

## Fiches de cours PUBLIEES d'une classe+matiere (tableau vide si aucune). Chaque fiche :
## {"id": int, "notion": code de notion, "titre": String, "contenu": BBCode avec balises [page]},
## triees dans l'ordre des notions. Envoyees dans le meme paquet que les questions (champ "cours"
## de fn_publier) : aucun telechargement en plus.
func get_fiches(grade: Grade, subject: Subject) -> Array[Dictionary]:
	var key := _key(grade, subject)
	_load_extras(key)
	return _fiches.get(key, [] as Array[Dictionary])

## Notions d'une classe+matiere, dans l'ordre pedagogique : [{"code", "libelle"}] (champ
## "notions" du paquet, voir server/fiches_1_notions_paquets.sql). Pour un paquet publie avant ce
## champ, on retombe sur les codes des questions (libelle = titre de la fiche s'il y en a une,
## sinon le code lui-meme).
func get_notions(grade: Grade, subject: Subject) -> Array[Dictionary]:
	var key := _key(grade, subject)
	_load_extras(key)
	return _notions.get(key, [] as Array[Dictionary])

## Lit une seule fois les fiches et notions d'un paquet du cache (les questions, elles, sont
## fabriquees a part par get_questions).
func _load_extras(key: String) -> void:
	if _fiches.has(key):
		return
	var fiches: Array[Dictionary] = []
	var notions: Array[Dictionary] = []
	var data: Variant = _read_json(_pack_path(key)) if _manifest.has(key) else null
	if data is Dictionary:
		for c: Variant in data.get("cours", []):
			if c is Dictionary:
				fiches.append(c)
		for n: Variant in data.get("notions", []):
			if n is Dictionary:
				notions.append(n)
		if notions.is_empty():
			var seen: Dictionary = {}
			for q: Variant in data.get("questions", []):
				var code := str((q as Dictionary).get("notion", "")) if q is Dictionary else ""
				if code != "" and not seen.has(code):
					seen[code] = true
					var libelle := code
					for fiche: Dictionary in fiches:
						if str(fiche.get("notion", "")) == code:
							libelle = str(fiche.get("titre", code))
					notions.append({"code": code, "libelle": libelle})
	_fiches[key] = fiches
	_notions[key] = notions

## La fiche d'une notion (code, ex. "addition") pour une classe, toutes matieres confondues ;
## Dictionary vide si elle n'existe pas (encore).
func find_fiche(grade: Grade, notion: String) -> Dictionary:
	for subject: Subject in get_available_subjects(grade):
		for fiche: Dictionary in get_fiches(grade, subject):
			if str(fiche.get("notion", "")) == notion:
				return fiche
	return {}

## Compare les versions du serveur au cache et telecharge ce qui a change. Sans effet si un
## rafraichissement est deja en cours. Hors-ligne : on garde simplement le cache.
func refresh() -> void:
	if _refreshing:
		return
	_refreshing = true
	var res: Dictionary = await ServerApi.obtenir_manifeste()
	if res.get("ok", false) and res.get("data") is Dictionary:
		var server_manifest: Dictionary = res["data"]
		# Paquets retires cote serveur : on les oublie.
		for key: String in _manifest.keys():
			if not server_manifest.has(key):
				_manifest.erase(key)
				_built.erase(key)
				_fiches.erase(key)
				_notions.erase(key)
				DirAccess.remove_absolute(_pack_path(key))
		# Paquets nouveaux ou modifies : telechargement en parallele.
		for key: String in server_manifest.keys():
			var version := int(server_manifest[key])
			if int(_manifest.get(key, -1)) != version:
				_pending_downloads += 1
				_download_pack(key, version)
		if _pending_downloads > 0:
			await _downloads_finished
		_write_json(MANIFEST_PATH, _manifest)
	_refreshing = false
	content_updated.emit()

func _download_pack(key: String, version: int) -> void:
	var parts := key.split("/")
	var res: Dictionary = await ServerApi.obtenir_paquet(parts[0], parts[1])
	var data: Variant = res.get("data")
	if res.get("ok", false) and data is Dictionary and data.get("questions") is Array:
		if _write_json(_pack_path(key), data):
			_manifest[key] = version
			_built.erase(key)
			_fiches.erase(key)
			_notions.erase(key)
	_pending_downloads -= 1
	if _pending_downloads == 0:
		_downloads_finished.emit()

func _build_questions(grade: Grade, subject: Subject, data: Dictionary) -> Array[QuestionResource]:
	var passages: Dictionary = {}
	for p: Variant in data.get("passages", []):
		if p is Dictionary:
			var passage := PassageResource.new()
			passage.id = int(p.get("id", 0))
			passage.grade = grade
			passage.text = str(p.get("texte", ""))
			passages[int(p.get("id", 0))] = passage
	var result: Array[QuestionResource] = []
	for q: Variant in data.get("questions", []):
		if not (q is Dictionary):
			continue
		var question := QuestionResource.new()
		question.id = int(q.get("id", 0))
		question.subject = subject
		question.grade = grade
		question.notion = str(q.get("notion", ""))
		question.text = str(q.get("enonce", ""))
		question.correct_answer = str(q.get("reponse", ""))
		for choice: Variant in q.get("choix", []):
			question.choices.append(str(choice))
		for cell: Variant in q.get("grille", []):
			question.grid_cells.append(str(cell))
		if q.has("passage"):
			question.passage = passages.get(int(q["passage"]))
		result.append(question)
	return result

func _key(grade: Grade, subject: Subject) -> String:
	return "%s/%s" % [GradeLevel.get_folder_name(grade), SubjectType.get_folder_name(subject)]

func _pack_path(key: String) -> String:
	return "%s/%s.json" % [CACHE_DIR, key.replace("/", "_")]

func _read_json(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		return null
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return null
	return JSON.parse_string(file.get_as_text())

func _write_json(path: String, value: Variant) -> bool:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_warning("ContentLibrary : ecriture impossible de %s (%d)" % [path, FileAccess.get_open_error()])
		return false
	file.store_string(JSON.stringify(value))
	return true
