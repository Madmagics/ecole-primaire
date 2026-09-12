## Suivi de la progression des "Défis" (un défi = une classe + une matière), pour la fenêtre
## "Succès" (voir ui/success/success_panel.gd). Remplace StatsTracker/SectionStats, retirés le
## 2026-09-05 (retour utilisateur : "on va supprimer l'icone et la fenetre de statistique qui est
## au final inutile") - même principe que StatsTracker : autoload minimal, sans logique metier
## lourde, ne connaît aucun PNJ ni panneau directement. Appelé directement par
## QuestionPanel._show_result() (voir son commentaire de classe) une fois le score d'un pack
## connu, plutôt qu'écouté via EventBus.pack_completed comme le faisait StatsTracker : le résultat
## a besoin du total à jour TOUT DE SUITE pour l'afficher (ligne du récapitulatif + popup), pas au
## prochain rafraîchissement de SuccessPanel.
##
## Un "succès" ne compte que pour un pack terminé SANS FAUTE (retour utilisateur : "je rajoute que
## l'incrementation de succes se fait pour un resultat sans faute") - un seuil plus exigeant que
## les 50% qui donnent déjà une récompense en pièces (voir CardRarity.get_pack_reward) : un Défi
## valide une compétence complètement maîtrisée, pas juste "réussie".
##
## Palier unique par défi (une seule barre de progression, recolorée au fil des paliers plutôt que
## plusieurs barres séparées - voir success_panel.gd _tier_color(), 4 couleurs : gris foncé avant
## BRONZE_GOAL, bronze, argent, or) : BRONZE_GOAL (5) réussites démarrent le palier bronze,
## SILVER_GOAL (20, cumulé) démarre l'argent, GOLD_GOAL (50, cumulé - abaissé de 70 le 2026-09-06,
## retour utilisateur : "reduit à 50 la barre de defis") termine l'or - le défi est alors terminé.
## Le compteur ne dépasse jamais GOLD_GOAL (voir register_success) : un pack sans faute
## supplémentaire une fois le défi terminé ne fait plus rien ici.
extends Node

const BRONZE_GOAL := 5
const SILVER_GOAL := 20
const GOLD_GOAL := 50

## grade(int) -> { subject(int) -> reussites(int) }. Clés en int (jamais les enums directement) :
## même convention que StatsTracker.packs_completed_by_subject avant son retrait, nécessaire dès
## qu'une Dictionary est sérialisée en JSON (voir serialize()/deserialize()).
var _reussites: Dictionary = {}

## Nombre de réussites (packs sans faute) enregistrées pour ce défi [grade]/[subject].
func get_count(grade: GradeLevel.Grade, subject: SubjectType.Subject) -> int:
	var by_subject: Dictionary = _reussites.get(int(grade), {})
	return int(by_subject.get(int(subject), 0))

## Incrémente le défi [grade]/[subject] d'une réussite et renvoie le nouveau total (plafonné à
## GOLD_GOAL, voir commentaire de classe). Appelé une seule fois par pack terminé sans faute,
## depuis QuestionPanel._show_result().
func register_success(grade: GradeLevel.Grade, subject: SubjectType.Subject) -> int:
	var by_subject: Dictionary = _reussites.get(int(grade), {})
	var count: int = int(by_subject.get(int(subject), 0))
	if count < GOLD_GOAL:
		count += 1
	by_subject[int(subject)] = count
	_reussites[int(grade)] = by_subject
	return count

## Remet tous les défis à zéro (voir SaveManager.reset_current_account_progress).
func reset() -> void:
	_reussites.clear()

func serialize() -> Dictionary:
	var out: Dictionary = {}
	for grade_key in _reussites.keys():
		out[str(grade_key)] = (_reussites[grade_key] as Dictionary).duplicate()
	return out

func deserialize(data: Dictionary) -> void:
	_reussites.clear()
	for grade_key in data.keys():
		var by_subject_in: Dictionary = data[grade_key]
		var by_subject_out: Dictionary = {}
		for subject_key in by_subject_in.keys():
			by_subject_out[int(subject_key)] = int(by_subject_in[subject_key])
		_reussites[int(grade_key)] = by_subject_out
