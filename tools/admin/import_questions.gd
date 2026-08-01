## Outil admin : cree/met a jour les QuestionResource a partir de(s) CSV, regroupees en UN SEUL
## fichier QuestionBankResource (.tres) PAR CSV plutot qu'un fichier par question (voir
## data/question/question_bank_resource.gd - evolution d'aout 2026 pour limiter le nombre
## d'ouvertures de fichier au demarrage, une fois les banques de questions passees a plusieurs
## milliers d'entrees). Usage : ouvrir ce script dans l'editeur Godot puis File > Run (ou
## Ctrl+Shift+X).
##
## Architecture des fichiers : un dossier par CLASSE (cp/ce1/ce2/cm1/cm2), puis un sous-dossier
## par matiere, chacun pouvant contenir AUTANT DE FICHIERS CSV QUE VOULU, ex :
##   csv/questions/cp/math/addition.csv
##   csv/questions/cp/math/tables.csv
##   csv/questions/cp/french/...
## Classe en premier (et non matiere en premier) car de nouvelles matieres apparaitront a partir
## des classes superieures (ex: anglais a partir du CE1) sans exister a toutes les classes -
## un dossier classe/matiere absent est simplement ignore (voir boucle ci-dessous), alors que
## l'inverse (matiere/classe) supposait a tort que chaque matiere couvre toutes les classes.
## La classe ET la matiere sont deduites du CHEMIN DU DOSSIER, pas de colonnes : pas besoin de
## les repeter sur chaque ligne. (CSV = un tableau plat, pas de "sheets" comme dans Excel ; si tu
## travailles depuis Excel, exporte chaque onglet en CSV separe et depose-le dans le bon dossier
## classe/matiere.) Tous les CSV du projet vivent sous "csv/" a la racine.
##
## Colonnes attendues dans chaque CSV (separees par ";", format Excel FR) :
##   id;text;correct_answer;choice_2;choice_3;choice_4
## - id : numero unique de la question (les questions ne sont pas echangees entre joueurs donc
##   pas de contrainte de stabilite aussi stricte que les cartes, mais eviter quand meme de
##   reutiliser un id deja assigne - voir csv/questions/ID_RANGES.md).
## - choice_2/3/4 : mauvaises reponses pour le mode QCM tactile (colonnes optionnelles,
##   laisser vide si non utilisees -> la question restera saisie au clavier uniquement).
##
## Le fichier .tres genere prend le nom de la MATIERE (ex: "math.tres") quand un seul CSV existe
## dans son dossier (cas courant, 28 des 33 dossiers actuels), ou le nom du CSV source si
## plusieurs CSV cohabitent dans le meme dossier (ex: "lecture/" avec generated.csv +
## histoires_generated.csv) - le nom de la matiere seul serait alors ambigu entre les deux (voir
## _run ci-dessous pour le detail de cette regle). Meme sous-dossier classe/matiere que sous
## data/question/resources/ (arborescence inchangee, juste moins de fichiers a l'interieur).
## Relancer le script apres avoir modifie un CSV pour pousser la mise a jour : chaque CSV ecrase
## entierement son .tres correspondant (aucun champ "reserve a l'inspecteur" a preserver,
## contrairement aux cartes).
##
## MIGRATION (une fois, apres la premiere execution suivant cette evolution) : les anciens
## fichiers .tres un-par-question (nommes par id, ex "2000.tres") restent sur le disque a cote
## des nouveaux tant qu'ils ne sont pas supprimes a la main (noms differents, pas d'ecrasement
## automatique) - a nettoyer une fois le nouvel import verifie en jeu, voir ARCHITECTURE.md.
@tool
extends EditorScript

const CSV_ROOT := "res://csv/questions"
## Meme arborescence classe/matiere que CSV_ROOT (voir plus haut) : autrement le dossier
## deviendrait vite injouable a parcourir dans le dock Godot une fois plusieurs milliers de
## questions importees (voir feedback_lightweight_game.md - lisibilite du projet).
const OUTPUT_DIR := "res://data/question/resources"

## Preload explicite plutot que de compter sur "QuestionResource.new()" : bug connu de
## Godot 4 (voir godotengine/godot#66123 et #58957), "Invalid call. Nonexistent function
## 'new' in base 'GDScript'", quand une classe class_name n'a encore jamais ete instanciee
## ailleurs dans le projet au moment ou ce script tourne (table des classes globales pas
## encore "rechauffee"). Le preload garantit un GDScript charge, sans dependre de cet ordre.
const QuestionResourceScript := preload("res://data/question/question_resource.gd")
const QuestionBankResourceScript := preload("res://data/question/question_bank_resource.gd")

## Sous-dossier (sous chaque classe) -> matiere associee. Ajouter une matiere ici (ex: "anglais")
## suffit a la rendre importable, meme si son dossier n'existe encore que sous certaines classes.
const SUBJECT_FOLDERS := {
	"math": SubjectType.Subject.MATH,
	"french": SubjectType.Subject.FRENCH,
	"grammaire": SubjectType.Subject.GRAMMAR,
	"conjugaison": SubjectType.Subject.CONJUGATION,
	"orthographe": SubjectType.Subject.SPELLING,
	"english": SubjectType.Subject.ENGLISH,
	## "lecture" (READING) n'est PAS ici : une question de lecture est toujours liee a un texte
	## (voir MATIERES_CANDIDATES.md), donc pas compatible avec l'import "1 ligne CSV = 1
	## QuestionResource" de ce script - elle aura son propre outil d'import dedie.
}

## Dossier (sous CSV_ROOT) -> classe associee.
const GRADE_FOLDERS := {
	"cp": GradeLevel.Grade.CP,
	"ce1": GradeLevel.Grade.CE1,
	"ce2": GradeLevel.Grade.CE2,
	"cm1": GradeLevel.Grade.CM1,
	"cm2": GradeLevel.Grade.CM2,
}

func _run() -> void:
	EditorInterface.get_resource_filesystem().scan()

	var total_questions := 0
	var total_banks := 0
	for grade_folder in GRADE_FOLDERS.keys():
		var grade: GradeLevel.Grade = GRADE_FOLDERS[grade_folder]
		for subject_folder: String in SUBJECT_FOLDERS.keys():
			var subject: SubjectType.Subject = SUBJECT_FOLDERS[subject_folder]
			var folder_path := "%s/%s/%s" % [CSV_ROOT, grade_folder, subject_folder]
			## Dossier absent = matiere pas encore introduite a cette classe (voir plus haut) :
			## on passe simplement au suivant, pas une erreur.
			if not DirAccess.dir_exists_absolute(folder_path):
				continue
			var output_folder := "%s/%s/%s" % [OUTPUT_DIR, grade_folder, subject_folder]
			var csv_files: Array[String] = []
			for file_name in DirAccess.get_files_at(folder_path):
				if file_name.ends_with(".csv"):
					csv_files.append(file_name)
			## Un seul CSV dans ce dossier matiere (cas courant, 28 des 33 dossiers actuels) :
			## nommer le .tres d'apres la matiere ("math.tres") plutot que d'apres le CSV
			## ("generated.tres", identique dans presque tous les dossiers - illisible dans la
			## recherche rapide/les onglets Godot une fois plusieurs matieres ouvertes a la fois,
			## voir retour utilisateur 2026-08-01). S'il y a plusieurs CSV dans le meme dossier,
			## garder le nom de chaque CSV pour rester unique (cas de lecture/, voir plus bas).
			for file_name in csv_files:
				var csv_path := "%s/%s" % [folder_path, file_name]
				var bank_name := subject_folder if csv_files.size() == 1 else file_name.get_basename()
				var written := _import_file(csv_path, output_folder, bank_name, subject, grade)
				print("import_questions: %s -> %d question(s) (1 fichier .tres)" % [csv_path, written])
				total_questions += written
				if written > 0:
					total_banks += 1

	print("import_questions: %d question(s) dans %d fichier(s) .tres importee(s)/mise(s) a jour au total" % [total_questions, total_banks])

## Lit tout [csv_path] et regroupe ses questions dans UN SEUL QuestionBankResource, sauvegarde
## sous "<output_folder>/<bank_name>.tres" (voir l'appelant pour le choix de bank_name : nom de
## la matiere si un seul CSV dans le dossier, sinon nom du CSV) - voir
## data/question/question_bank_resource.gd. Renvoie le nombre de questions ecrites (0 si le
## fichier est vide/illisible, aucun .tres n'est alors cree/mis a jour).
func _import_file(csv_path: String, output_folder: String, bank_name: String, subject: SubjectType.Subject, grade: GradeLevel.Grade) -> int:
	var file := FileAccess.open(csv_path, FileAccess.READ)
	if file == null:
		push_error("import_questions: impossible d'ouvrir %s (erreur %s)" % [csv_path, FileAccess.get_open_error()])
		return 0

	var headers: PackedStringArray = file.get_csv_line(";")
	var bank: QuestionBankResource = QuestionBankResourceScript.new()

	while not file.eof_reached():
		var row: PackedStringArray = file.get_csv_line(";")
		if row.is_empty() or (row.size() == 1 and row[0].strip_edges() == ""):
			continue
		var question := _build_question(headers, row, subject, grade)
		if question != null:
			bank.questions.append(question)

	if bank.questions.is_empty():
		return 0

	DirAccess.make_dir_recursive_absolute(output_folder)
	var out_path := "%s/%s.tres" % [output_folder, bank_name]
	var err := ResourceSaver.save(bank, out_path)
	if err != OK:
		push_error("import_questions: echec sauvegarde %s (code %d)" % [out_path, err])
		return 0

	if Engine.is_editor_hint():
		EditorInterface.get_resource_filesystem().scan()
	return bank.questions.size()

func _build_question(headers: PackedStringArray, row: PackedStringArray, subject: SubjectType.Subject, grade: GradeLevel.Grade) -> QuestionResource:
	var values := CsvResourceImporter.row_to_dict(headers, row)
	var id: String = values.get("id", "")
	if id == "":
		return null

	## Pas besoin de recharger un .tres existant ici (contrairement a import_cards.gd) : aucun
	## champ de QuestionResource n'est reserve a l'edition manuelle, tout vient du CSV.
	var question: QuestionResource = QuestionResourceScript.new()

	question.subject = subject
	question.grade = grade
	question.text = values.get("text", "")
	question.correct_answer = values.get("correct_answer", "")

	var choices: Array[String] = []
	for key in ["choice_2", "choice_3", "choice_4"]:
		var value: String = str(values.get(key, "")).strip_edges()
		if value != "":
			choices.append(value)
	question.choices = choices

	return question
