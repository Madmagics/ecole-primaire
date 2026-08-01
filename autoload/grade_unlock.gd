## Progression des classes accessibles aupres des PNJ. Au tout debut de la partie, seule la
## premiere classe (CP) est debloquee : les suivantes (CE1 a CM2) se debloquent une a une en
## boutique contre UNLOCK_PRICE pieces - de la monnaie de la classe la plus avancee DEJA
## debloquee (celle avec laquelle le joueur a accumule ses pieces jusque-la). Voir ShopPanel
## pour l'achat et QuestionGiverComponent pour le grisage/blocage des PNJ non debloques.
## Autoload volontairement minimal, meme principe qu'Economy/StatsTracker/CardCollection.
extends Node

const Grade = GradeLevel.Grade
const Rarity = CardRarity.Rarity

## Ordre de progression : indexe par le meme entier que GradeLevel.Grade (0=CP ... 4=CM2), donc
## deja dans le bon ordre sans tri explicite.
const GRADE_ORDER: Array[Grade] = [Grade.CP, Grade.CE1, Grade.CE2, Grade.CM1, Grade.CM2]

const UNLOCK_PRICE := 500

## Emis a chaque deblocage reussi (le nouveau grade debloque en parametre) : les PNJ
## (QuestionGiverComponent) ecoutent ce signal pour se regriser/degriser sans recharger la
## scene - "le systeme doit se repercuter sur tous les PNJ" a chaque achat, pas seulement au
## prochain _ready().
signal grade_unlocked(grade: Grade)

## Index dans GRADE_ORDER de la classe la plus avancee debloquee. 0 au demarrage (seul CP
## accessible), comme le reste de la progression (voir Economy.STARTING_BALANCE_FOR_TESTING
## pour le solde de depart qui permet de tester ce systeme sans farmer).
var _highest_unlocked_index: int = 0

func is_unlocked(grade: Grade) -> bool:
	var idx := GRADE_ORDER.find(grade)
	return idx != -1 and idx <= _highest_unlocked_index

func get_highest_unlocked_grade() -> Grade:
	return GRADE_ORDER[_highest_unlocked_index]

func has_next_grade() -> bool:
	return _highest_unlocked_index < GRADE_ORDER.size() - 1

## Classe suivante a debloquer. Ne pas appeler sans verifier has_next_grade() d'abord.
func get_next_grade() -> Grade:
	return GRADE_ORDER[_highest_unlocked_index + 1]

## Monnaie a depenser pour debloquer la classe suivante : celle de la classe la plus avancee
## deja debloquee (voir commentaire de classe).
func get_unlock_currency() -> Rarity:
	return GradeLevel.get_rarity(get_highest_unlocked_grade())

## Tente de debloquer la classe suivante. Renvoie false (rien depense) si tout est deja
## debloque ou si le solde est insuffisant.
func try_unlock_next() -> bool:
	if not has_next_grade():
		return false
	if not Economy.try_spend(get_unlock_currency(), UNLOCK_PRICE):
		return false
	_highest_unlocked_index += 1
	grade_unlocked.emit(get_highest_unlocked_grade())
	return true

## Remet la progression a zero (voir SaveManager.reset_progress) : seul CP redevient
## accessible.
func reset() -> void:
	_highest_unlocked_index = 0
	grade_unlocked.emit(get_highest_unlocked_grade())

func serialize() -> Dictionary:
	return {"highest_unlocked_index": _highest_unlocked_index}

func deserialize(data: Dictionary) -> void:
	_highest_unlocked_index = clampi(int(data.get("highest_unlocked_index", 0)), 0, GRADE_ORDER.size() - 1)
	grade_unlocked.emit(get_highest_unlocked_grade())
