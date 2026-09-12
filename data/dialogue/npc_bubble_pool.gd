## Pool partage de textes pour les bulles de dialogue des PNJ (voir
## ui/speech_bubble/speech_bubble.gd). Charge une seule fois via des membres static (voir
## question_bank_resource.gd pour le meme reflexe "un seul chargement partage" applique aux
## questions) : les 5 PNJ appellent NpcBubblePool.get_random_line(grade), pas 5 lectures separees
## du meme fichier csv/dialogue/npc_bubbles.csv.
## Meme lecteur CSV que tools/admin/import_questions.gd (FileAccess.get_csv_line(";")) plutot
## qu'un split(";") manuel, pour rester coherent avec le reste du projet (gere aussi les guillemets
## si un texte venait a contenir un ";").
## Format csv (2026-09-05, retour utilisateur "specifier plus explicitement le niveau de chaque
## prof ainsi que les matieres proposees") : id;classe;texte - une colonne "classe" (memes libelles
## que GradeLevel.get_label : "CP","CE1",...) en plus du texte, chaque ligne citant explicitement
## la classe et une ou deux matieres reellement proposees par ce PNJ (voir
## QuestionGiverComponent.get_available_subjects pour la liste reelle par classe). Groupe des
## lignes PAR classe (_lines_by_grade_label) plutot qu'un pool unique commun aux 5 PNJ : un texte
## de CP ne doit jamais s'afficher au-dessus du PNJ de CM2.
class_name NpcBubblePool
extends RefCounted

const CSV_PATH := "res://csv/dialogue/npc_bubbles.csv"

## Grade.CP/CE1/... (int de l'enum) -> Array[String], rempli par _ensure_loaded.
static var _lines_by_grade: Dictionary = {}
static var _loaded: bool = false

## Renvoie un texte au hasard parmi ceux de "grade", ou une chaine vide si le csv est introuvable/
## vide pour cette classe (l'appelant - speech_bubble.gd - doit alors simplement ne rien afficher).
static func get_random_line(grade: GradeLevel.Grade) -> String:
	_ensure_loaded()
	var pool: Array = _lines_by_grade.get(grade, [])
	if pool.is_empty():
		return ""
	return pool[randi() % pool.size()]

static func _ensure_loaded() -> void:
	if _loaded:
		return
	_loaded = true
	var file := FileAccess.open(CSV_PATH, FileAccess.READ)
	if file == null:
		push_warning("NpcBubblePool: impossible d'ouvrir %s (erreur %s)" % [CSV_PATH, FileAccess.get_open_error()])
		return
	file.get_csv_line(";") # en-tete "id;classe;texte", ignoree
	while not file.eof_reached():
		var row: PackedStringArray = file.get_csv_line(";")
		if row.size() < 3 or row[2].is_empty():
			continue
		var grade := _parse_grade(row[1])
		if grade == -1:
			push_warning("NpcBubblePool: classe inconnue '%s' (ligne id=%s), ignoree" % [row[1], row[0]])
			continue
		if not _lines_by_grade.has(grade):
			_lines_by_grade[grade] = []
		_lines_by_grade[grade].append(row[2])

## Comparaison directe sur GradeLevel.get_label() (pas de logique de tolerance case/accents comme
## import_cards.gd._parse_grade - ce csv est ecrit a la main dans ce projet, pas rempli par un
## tableur externe) : -1 si le texte ne correspond a aucune classe connue.
static func _parse_grade(label: String) -> int:
	for grade in [GradeLevel.Grade.CP, GradeLevel.Grade.CE1, GradeLevel.Grade.CE2, GradeLevel.Grade.CM1, GradeLevel.Grade.CM2]:
		if GradeLevel.get_label(grade) == label:
			return grade
	return -1
