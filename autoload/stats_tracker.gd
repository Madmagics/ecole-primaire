## Suivi de la progression du joueur (packs de questions reussis, precision...), pour l'ecran
## Statistiques du menu de jeu. Ecoute EventBus plutot que d'etre appele directement par les
## PNJ (decouplage, meme regle que le reste du projet - voir ARCHITECTURE.md).
extends Node

## Emis a chaque mise a jour (nouveau pack termine, ou rechargement d'une sauvegarde) : la
## section Statistiques n'a pas besoin d'ecouter ce signal (elle se rafraichit a l'affichage),
## mais reste disponible pour un futur affichage "en direct" (ex: HUD).
signal stats_changed

var packs_completed: int = 0
var questions_answered: int = 0
var questions_correct: int = 0
## SubjectType.Subject -> int (nombre de packs reussis pour cette matiere).
var packs_completed_by_subject: Dictionary = {}

func _ready() -> void:
	EventBus.pack_completed.connect(_on_pack_completed)

func _on_pack_completed(subject: SubjectType.Subject, _rarity: CardRarity.Rarity, correct_count: int, total_count: int, _reward: int) -> void:
	packs_completed += 1
	questions_answered += total_count
	questions_correct += correct_count
	packs_completed_by_subject[subject] = packs_completed_by_subject.get(subject, 0) + 1
	stats_changed.emit()

func get_accuracy_percent() -> float:
	if questions_answered == 0:
		return 0.0
	return 100.0 * float(questions_correct) / float(questions_answered)

## Remet tous les compteurs a zero (voir SaveManager.reset_progress).
func reset() -> void:
	packs_completed = 0
	questions_answered = 0
	questions_correct = 0
	packs_completed_by_subject.clear()
	stats_changed.emit()

func serialize() -> Dictionary:
	return {
		"packs_completed": packs_completed,
		"questions_answered": questions_answered,
		"questions_correct": questions_correct,
		"packs_completed_by_subject": packs_completed_by_subject.duplicate(),
	}

func deserialize(data: Dictionary) -> void:
	packs_completed = int(data.get("packs_completed", 0))
	questions_answered = int(data.get("questions_answered", 0))
	questions_correct = int(data.get("questions_correct", 0))
	var by_subject: Dictionary = data.get("packs_completed_by_subject", {})
	packs_completed_by_subject.clear()
	for key in by_subject.keys():
		packs_completed_by_subject[int(key)] = int(by_subject[key])
	stats_changed.emit()
