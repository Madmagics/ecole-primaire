## Outil admin : cree/met a jour les PassageResource et QuestionResource (matiere READING,
## "Comprehension de texte") a partir des CSV de csv/questions/<classe>/lecture/, regroupees en
## UN SEUL QuestionBankResource (.tres) PAR CSV (voir data/question/question_bank_resource.gd -
## evolution d'aout 2026, meme principe que import_questions.gd). Usage : ouvrir ce script dans
## l'editeur Godot puis File > Run (ou Ctrl+Shift+X).
##
## Format different du reste du projet (une question de lecture est toujours liee a un texte,
## voir FRANCAIS_DIFFICULTE.md) : ne passe donc pas par CsvResourceImporter (1 ligne = 1
## Resource independante, voir import_questions.gd) mais par ce script dedie, qui garde en
## memoire le dernier passage rencontre pour lier chaque question qui suit - un meme fichier
## CSV peut contenir plusieurs passages (plusieurs histoires pour une meme classe). Passage(s) et
## questions d'un meme CSV finissent comme sous-ressources du MEME fichier .tres de sortie : plus
## besoin de take_over_path() (voir plus bas) pour eviter qu'un passage soit duplique au lieu
## d'etre partage, puisqu'un seul appel ResourceSaver.save() ecrit tout le fichier d'un coup et
## que Godot deduplique nativement les sous-ressources partagees au sein d'un meme fichier.
##
## Colonnes attendues : id;type;text;correct_answer;choice_2;choice_3;choice_4;passage_id;qtype
## - type=passage : une ligne par texte (id = id du passage, text = texte complet, le reste vide).
## - type=question : passage_id doit correspondre a l'id (colonne "id") d'une ligne passage
##   PRECEDENTE dans le meme fichier. qtype (L/V/I, voir FRANCAIS_DIFFICULTE.md) est une
##   metadonnee d'auteur/QA pour verifier le quota de types de question par classe - pas stockee
##   sur QuestionResource (pas de champ equivalent, comme documente dans FRANCAIS_DIFFICULTE.md).
##
## MIGRATION : voir la note en tete de import_questions.gd (anciens .tres un-par-ressource a
## nettoyer a la main une fois le nouvel import verifie).
@tool
extends EditorScript

const CSV_ROOT := "res://csv/questions"
const OUTPUT_DIR := "res://data/question/resources"
const SUBJECT_FOLDER := "lecture"

const PassageResourceScript := preload("res://data/question/passage_resource.gd")
const QuestionResourceScript := preload("res://data/question/question_resource.gd")
const QuestionBankResourceScript := preload("res://data/question/question_bank_resource.gd")

const GRADE_FOLDERS := {
	"cp": GradeLevel.Grade.CP,
	"ce1": GradeLevel.Grade.CE1,
	"ce2": GradeLevel.Grade.CE2,
	"cm1": GradeLevel.Grade.CM1,
	"cm2": GradeLevel.Grade.CM2,
}

func _run() -> void:
	EditorInterface.get_resource_filesystem().scan()
	var total := 0
	for grade_folder in GRADE_FOLDERS.keys():
		var grade: GradeLevel.Grade = GRADE_FOLDERS[grade_folder]
		var folder_path := "%s/%s/%s" % [CSV_ROOT, grade_folder, SUBJECT_FOLDER]
		if not DirAccess.dir_exists_absolute(folder_path):
			continue
		var output_folder := "%s/%s/%s" % [OUTPUT_DIR, grade_folder, SUBJECT_FOLDER]
		var csv_files: Array[String] = []
		for file_name in DirAccess.get_files_at(folder_path):
			if file_name.ends_with(".csv"):
				csv_files.append(file_name)
		## Meme regle que import_questions.gd : nom de la matiere si un seul CSV dans le
		## dossier, sinon nom du CSV (cas courant ici - generated.csv + histoires_generated.csv
		## cohabitent dans chaque lecture/, donc "lecture.tres" seul serait ambigu).
		for file_name in csv_files:
			var bank_name := SUBJECT_FOLDER if csv_files.size() == 1 else file_name.get_basename()
			total += _import_file("%s/%s" % [folder_path, file_name], output_folder, bank_name, grade)
	print("import_reading: %d ressource(s) importee(s)/mise(s) a jour au total" % total)

## Lit tout [csv_path] et regroupe ses questions (avec leur(s) PassageResource embarque(s) comme
## sous-ressources, voir passage.passage plus bas) dans UN SEUL QuestionBankResource, sauvegarde
## sous "<output_folder>/<bank_name>.tres" (voir l'appelant pour le choix de bank_name). Renvoie
## le nombre de questions ecrites (les lignes "passage" ne comptent pas, seulement les questions
## qui les referencent).
func _import_file(csv_path: String, output_folder: String, bank_name: String, grade: GradeLevel.Grade) -> int:
	var file := FileAccess.open(csv_path, FileAccess.READ)
	if file == null:
		push_error("import_reading: impossible d'ouvrir %s (erreur %s)" % [csv_path, FileAccess.get_open_error()])
		return 0

	var headers: PackedStringArray = file.get_csv_line(";")
	## csv id (colonne "id") -> PassageResource cree pour ce fichier : permet de lier les
	## questions qui suivent une ligne passage, meme si plusieurs passages partagent un fichier.
	var passages_by_csv_id: Dictionary = {}
	var bank: QuestionBankResource = QuestionBankResourceScript.new()

	while not file.eof_reached():
		var row: PackedStringArray = file.get_csv_line(";")
		if row.is_empty() or (row.size() == 1 and row[0].strip_edges() == ""):
			continue
		var values := CsvResourceImporter.row_to_dict(headers, row)
		var id_str: String = str(values.get("id", "")).strip_edges()
		if id_str == "":
			continue
		var row_type: String = str(values.get("type", "")).strip_edges()

		if row_type == "passage":
			var passage: PassageResource = PassageResourceScript.new()
			passage.grade = grade
			passage.text = values.get("text", "")
			## Pas de take_over_path() ici (contrairement a l'ancienne version un-fichier-par-
			## ressource) : ce passage et les questions qui le referencent plus bas finissent
			## sous-ressources du MEME QuestionBankResource, sauvegarde en un seul appel
			## ResourceSaver.save() - Godot deduplique deja les references partagees au sein d'un
			## meme fichier, voir data/question/question_bank_resource.gd.
			passages_by_csv_id[id_str] = passage
		elif row_type == "question":
			var question: QuestionResource = QuestionResourceScript.new()
			question.subject = SubjectType.Subject.READING
			question.grade = grade
			question.text = values.get("text", "")
			question.correct_answer = values.get("correct_answer", "")
			var choices: Array[String] = []
			for key in ["choice_2", "choice_3", "choice_4"]:
				var value: String = str(values.get(key, "")).strip_edges()
				if value != "":
					choices.append(value)
			question.choices = choices
			var passage_id: String = str(values.get("passage_id", "")).strip_edges()
			if passages_by_csv_id.has(passage_id):
				question.passage = passages_by_csv_id[passage_id]
			else:
				push_warning("import_reading: passage_id '%s' introuvable pour la question %s (%s)" % [passage_id, id_str, csv_path])
			bank.questions.append(question)
		else:
			push_warning("import_reading: type '%s' inconnu (ligne id=%s), ignoree." % [row_type, id_str])

	if bank.questions.is_empty():
		return 0

	DirAccess.make_dir_recursive_absolute(output_folder)
	var out_path := "%s/%s.tres" % [output_folder, bank_name]
	var err := ResourceSaver.save(bank, out_path)
	if err != OK:
		push_error("import_reading: echec sauvegarde %s (code %d)" % [out_path, err])
		return 0

	if Engine.is_editor_hint():
		EditorInterface.get_resource_filesystem().scan()
	return bank.questions.size()
