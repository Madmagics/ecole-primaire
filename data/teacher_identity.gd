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
