## Series fixes du tutoriel (2026-10-08, demande Steve : "une seule serie de questions" par matiere,
## 10 questions, niveau CP) : ecrites ici plutot que tirees de Supabase pour que la demo soit
## toujours identique et fonctionne meme hors ligne / avant le premier telechargement des paquets.
## Format de chaque entree : [texte, bonne reponse, [3 mauvaises reponses]] - meme modele que
## QuestionResource (choices = mauvaises reponses seulement, QuestionPanel ajoute la bonne).
class_name TutorialQuestions
extends RefCounted

const _MATH := [
	["Combien font 2 + 3 ?", "5", ["4", "6", "7"]],
	["Combien font 6 + 2 ?", "8", ["7", "9", "6"]],
	["Combien font 5 - 2 ?", "3", ["2", "4", "7"]],
	["Quel nombre vient juste après 9 ?", "10", ["8", "11", "19"]],
	["Quel nombre vient juste avant 7 ?", "6", ["8", "5", "17"]],
	["Combien font 10 + 10 ?", "20", ["11", "100", "19"]],
	["Quel est le plus grand nombre parmi 12, 21, 8 et 15 ?", "21", ["12", "8", "15"]],
	["Combien font 3 + 3 + 3 ?", "9", ["6", "8", "12"]],
	["Léa a 4 billes et en gagne 3. Combien de billes a-t-elle maintenant ?", "7", ["6", "8", "1"]],
	["Combien font 8 - 8 ?", "0", ["8", "1", "16"]],
]

const _FRENCH := [
	["Quel mot commence par le son « ch » ?", "chat", ["rat", "lune", "vélo"]],
	["Complète la phrase : Le chat boit du ___.", "lait", ["pain", "ciel", "stylo"]],
	["Quel groupe de mots est au pluriel ?", "les pommes", ["la pomme", "une pomme", "ma pomme"]],
	["Complète la phrase : ___ maison est grande.", "La", ["Le", "Les", "Un"]],
	["Combien de syllabes y a-t-il dans le mot « lapin » ?", "2", ["1", "3", "4"]],
	["Quel mot rime avec « bateau » ?", "gâteau", ["bonbon", "tapis", "lune"]],
	["Complète la phrase : Le soleil brille dans le ___.", "ciel", ["lit", "sac", "bol"]],
	["Quel est le contraire de « grand » ?", "petit", ["gros", "long", "haut"]],
	["Complète la phrase : Tom ___ à l'école.", "va", ["vont", "aller", "vas"]],
	["Quelle est la bonne orthographe ?", "maison", ["mézon", "maisson", "maizon"]],
]

## Serie de [subject] (MATH ou FRENCH), vide pour toute autre matiere. Nouvelles instances a
## chaque appel (jamais sauvegardees).
static func get_series(subject: SubjectType.Subject) -> Array[QuestionResource]:
	var source: Array = []
	match subject:
		SubjectType.Subject.MATH:
			source = _MATH
		SubjectType.Subject.FRENCH:
			source = _FRENCH
	var result: Array[QuestionResource] = []
	for entry: Array in source:
		var question := QuestionResource.new()
		question.subject = subject
		question.grade = GradeLevel.Grade.CP
		question.text = entry[0]
		question.correct_answer = entry[1]
		var wrong: Array[String] = []
		wrong.assign(entry[2])
		question.choices = wrong
		result.append(question)
	return result
