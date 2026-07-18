## Une question de quizz reutilisable, editable dans l'inspecteur (fichier .tres).
## Un fichier .tres par question = facile a dupliquer, pas de script geant.
class_name QuestionResource
extends Resource

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (SubjectType.Subject) ; on "importe" l'enum dans une const locale.
const Subject = SubjectType.Subject

@export var subject: Subject = Subject.MATH
@export var text: String = ""
## Reponse attendue, saisie au clavier par le joueur (comparaison texte, insensible aux espaces).
@export var correct_answer: String = ""
@export_range(1, 3) var difficulty: int = 1
@export var coin_reward: int = 1

func is_correct(answer: String) -> bool:
	return answer.strip_edges() == correct_answer.strip_edges()
