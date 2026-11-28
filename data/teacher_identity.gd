## Identite des 5 profs (nom + titre), source unique (2026-10-08, demande de Steve) : utilisee par
## l'etiquette flottante aux pieds des PNJ (ui/name_tag/name_tag.gd) et par le prompt
## d'interaction (QuestionGiverComponent, prompt_text). Classe utilitaire statique, meme principe
## que GradeLevel/SubjectType.
class_name TeacherIdentity
extends RefCounted

const _NAMES := {
	GradeLevel.Grade.CP: "Anna Nasse",
	GradeLevel.Grade.CE1: "Paul Hochon",
	GradeLevel.Grade.CE2: "Laure Loge",
	GradeLevel.Grade.CM1: "Jean Peuplu",
	GradeLevel.Grade.CM2: "Maud Zarella",
}

const _TITLES := {
	GradeLevel.Grade.CP: "Maîtresse du CP",
	GradeLevel.Grade.CE1: "Maître du CE1",
	GradeLevel.Grade.CE2: "Maîtresse du CE2",
	GradeLevel.Grade.CM1: "Maître du CM1",
	GradeLevel.Grade.CM2: "Maîtresse du CM2",
}

static func get_teacher_name(grade: GradeLevel.Grade) -> String:
	return _NAMES.get(grade, "")

static func get_teacher_title(grade: GradeLevel.Grade) -> String:
	return _TITLES.get(grade, GradeLevel.get_label(grade))

## Message doux affiche quand le controle parental ferme cette classe pour le moment (classe
## bloquee ou parties du jour terminees, 2026-11-28, demande de Steve : "un message moins negatif,
## genre le maitre ou la maitresse n'est pas disponible pour le moment"). Ex. "La maîtresse du CP
## n'est pas disponible pour le moment." - le titre vient de _TITLES (meme source que l'etiquette).
static func get_unavailable_message(grade: GradeLevel.Grade) -> String:
	var title := get_teacher_title(grade)
	var is_female := title.begins_with("Maîtresse")
	var article := "La " if is_female else "Le "
	## Seule la 1re lettre passe en minuscule ("maîtresse du CP", pas "maîtresse du cp").
	var lowered := title.left(1).to_lower() + title.substr(1)
	return "%s%s n'est pas disponible pour le moment.\nReviens %s voir un peu plus tard !" % [
		article, lowered, "la" if is_female else "le"]
