## Petit utilitaire de lecture seule : liste les matières réellement disponibles pour une classe,
## pour la fenêtre "Succès" (voir ui/success/success_panel.gd), qui liste un défi par
## classe/matière indépendamment de tout PNJ.
##
## Se contente de lister les NOMS des sous-dossiers de data/question/resources/<classe>/ (un
## sous-dossier = une matière, voir SubjectType.get_folder_name() et import_questions.gd) plutôt
## que de charger chaque QuestionBankResource comme le fait QuestionGiverComponent._scan_dir() -
## corrige un freeze a l'ouverture de la fenêtre "Succès" (2026-09-06, retour utilisateur :
## "l ouverture de la fenetre apres click sur l icone succes est lente ou freeze pendant une
## seconde") : la version precedente chargeait TOUS les .tres de TOUTES les matieres des 5 classes
## a chaque ouverture, juste pour lire leur QuestionResource.subject - couteux (jusqu'a 1000+
## questions par matiere, voir project_grammaire_conjugaison_orthographe_1000 en memoire projet)
## et inutile, puisque le nom du sous-dossier suffit deja a determiner la matiere.
class_name QuestionBankScanner
extends RefCounted

const _RESOURCES_DIR := "res://data/question/resources"

## Matières disponibles pour [grade], triées sur la valeur de l'enum (même raison que
## QuestionGiverComponent.get_available_subjects : ordre pédagogique stable, indépendant du
## système de fichiers).
static func get_available_subjects(grade: GradeLevel.Grade) -> Array[SubjectType.Subject]:
	var folder_name := GradeLevel.get_folder_name(grade)
	var result: Array[SubjectType.Subject] = []
	if folder_name == "":
		return result
	var dir := DirAccess.open("%s/%s" % [_RESOURCES_DIR, folder_name])
	if dir == null:
		return result
	for subdir_name in dir.get_directories():
		var subject := _subject_for_folder(subdir_name)
		if subject != -1:
			result.append(subject as SubjectType.Subject)
	result.sort()
	return result

## Reciproque de SubjectType.get_folder_name() - renvoie -1 si aucune matiere ne correspond
## (dossier inconnu/mal nomme, ne devrait pas arriver avec le contenu actuel).
static func _subject_for_folder(folder_name: String) -> int:
	for subject in SubjectType.Subject.values():
		if SubjectType.get_folder_name(subject) == folder_name:
			return subject
	return -1
