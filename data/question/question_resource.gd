## Une question de quizz reutilisable, editable dans l'inspecteur (fichier .tres).
## Depuis aout 2026, plusieurs QuestionResource (toutes celles d'un meme CSV source) sont
## regroupees comme sous-ressources dans UN SEUL fichier .tres via QuestionBankResource (voir ce
## fichier et tools/admin/import_questions.gd) plutot qu'un fichier par question - la source de
## verite editable reste le CSV, pas ce .tres genere.
class_name QuestionResource
extends Resource

## Alias locaux : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe ; on "importe" l'enum dans une const locale.
const Subject = SubjectType.Subject
const Grade = GradeLevel.Grade

@export var subject: Subject = Subject.MATH
## Classe scolaire ciblee (CP a CM2) : determine la rarete des pieces gagnees si cette
## question fait partie d'un pack reussi (voir GradeLevel.get_rarity).
@export var grade: Grade = Grade.CP
@export var text: String = ""
## Reponse attendue, saisie au clavier par le joueur (comparaison texte, insensible aux espaces).
@export var correct_answer: String = ""
## Mauvaises reponses pour le mode QCM (boutons, plateformes tactiles). Vide = pas de QCM
## pour cette question : seule la saisie clavier (desktop) sera proposee.
@export var choices: Array[String] = []
## Texte associe (uniquement pour Subject.READING - une question de "Comprehension de texte"
## est toujours liee a un passage) : reference directe plutot qu'un id manuel a faire
## correspondre a la main (voir PassageResource). Laisser null pour toutes les autres matieres.
@export var passage: PassageResource = null

## Comparaison insensible aux espaces ET a la casse (public jeune, clavier tactile).
func is_correct(answer: String) -> bool:
	return answer.strip_edges().to_lower() == correct_answer.strip_edges().to_lower()
