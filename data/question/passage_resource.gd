## Un texte a lire pour la matiere "Comprehension de texte" (SubjectType.Subject.READING).
## Les QuestionResource qui portent sur ce texte le referencent directement via leur champ
## "passage" (voir question_resource.gd) - pas d'id manuel a faire correspondre. Depuis aout
## 2026, un passage et toutes ses questions vivent comme sous-ressources d'UN MEME fichier
## QuestionBankResource (un fichier par CSV, voir tools/admin/import_reading.gd) : la comparaison
## "==" entre QuestionResource.passage et un PassageResource pioche ailleurs (voir
## QuestionGiverComponent._start_reading_pack) est fiable parce que ce PassageResource est
## directement repioche dans le question_pool deja charge en memoire (meme instance), plus par
## un second chargement depuis le disque comme avant - voir QuestionGiverComponent pour le detail.
## Voir FRANCAIS_DIFFICULTE.md pour l'algorithme de difficulte (longueur, phrases, score de
## lisibilite) qui a servi a calibrer ces textes par classe.
class_name PassageResource
extends Resource

const Grade = GradeLevel.Grade

## Classe scolaire ciblee (CP a CM2), meme role que QuestionResource.grade.
@export var grade: Grade = Grade.CP
@export var text: String = ""
