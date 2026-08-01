## Regroupe toutes les QuestionResource issues d'UN fichier CSV source en une seule ressource
## .tres, plutot qu'un fichier par question (voir tools/admin/import_questions.gd et
## import_reading.gd). Au chargement, un PNJ n'ouvre desormais qu'un fichier par CSV/matiere au
## lieu d'un fichier par question (jusqu'a 1000+ questions par matiere depuis les extensions
## maths de debut aout 2026) : reduit fortement le nombre d'ouvertures de fichier au demarrage
## (voir ARCHITECTURE.md) sans changer le format des CSV sources ni le nombre de QuestionResource
## obtenues en memoire une fois chargees.
##
## Pour "Comprehension de texte" (READING), le PassageResource de chaque question
## (QuestionResource.passage, @export) reste embarque dans ce meme fichier comme sous-ressource
## partagee : tout etant sauvegarde en un seul appel ResourceSaver.save(), Godot deduplique
## automatiquement le PassageResource reference par plusieurs QuestionResource d'un meme CSV -
## plus besoin du take_over_path() qu'exigeait l'ancien decoupage un-fichier-par-ressource (ce
## trick ne servait qu'a lier des ressources vivant dans des FICHIERS separes, voir historique de
## import_reading.gd).
class_name QuestionBankResource
extends Resource

@export var questions: Array[QuestionResource] = []
