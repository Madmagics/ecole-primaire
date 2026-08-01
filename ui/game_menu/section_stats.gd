## Section "Statistiques" du menu de jeu : lecture seule, resume la progression (packs
## reussis, precision, repartition par matiere, pieces, collection). Construit ses lignes au
## runtime a partir de StatsTracker/Economy/CardCollection plutot que de dupliquer leurs
## donnees, pour rester a jour sans logique propre (voir feedback_lightweight_game.md).
class_name SectionStats
extends Control

const CARDS_DIR := "res://data/card/resources"

@onready var packs_label: Label = $VBoxContainer/PacksLabel
@onready var accuracy_label: Label = $VBoxContainer/AccuracyLabel
@onready var by_subject_container: VBoxContainer = $VBoxContainer/BySubjectContainer
@onready var coins_container: HBoxContainer = $VBoxContainer/CoinsContainer
@onready var collection_label: Label = $VBoxContainer/CollectionLabel

func refresh() -> void:
	packs_label.text = "Packs de questions réussis : %d" % StatsTracker.packs_completed
	accuracy_label.text = "Précision : %d %% (%d / %d bonnes réponses)" % [
		roundi(StatsTracker.get_accuracy_percent()),
		StatsTracker.questions_correct,
		StatsTracker.questions_answered,
	]
	_refresh_by_subject()
	_refresh_coins()
	_refresh_collection()

func _refresh_by_subject() -> void:
	for child in by_subject_container.get_children():
		child.queue_free()
	for subject in [SubjectType.Subject.MATH, SubjectType.Subject.FRENCH]:
		var count: int = StatsTracker.packs_completed_by_subject.get(subject, 0)
		var label := Label.new()
		## Sans ceci, le label garde la couleur blanche par defaut du moteur pour Label.font_color
		## (le theme global ne la fixe jamais expres, voir CHARTE_GRAPHIQUE.md) : illisible sur le
		## fond clair des panneaux (retour utilisateur 2026-07-28).
		label.theme_type_variation = &"TitleLabel"
		label.text = "  %s : %d pack(s)" % [SubjectType.get_label(subject), count]
		by_subject_container.add_child(label)

func _refresh_coins() -> void:
	for child in coins_container.get_children():
		child.queue_free()
	for rarity in [
		CardRarity.Rarity.COMMON,
		CardRarity.Rarity.UNCOMMON,
		CardRarity.Rarity.RARE,
		CardRarity.Rarity.EPIC,
		CardRarity.Rarity.LEGENDARY,
	]:
		var label := Label.new()
		label.modulate = CardRarity.get_color(rarity)
		## "commune" est blanc (voir CardRarity.get_color) : illisible sur le fond clair des
		## panneaux sans contour. add_theme_constant_override, pas add_theme_font_size_override -
		## outline_size est une constante de theme (voir doc Label), pas une taille de police ;
		## avec la mauvaise categorie l'override est silencieusement ignore et aucun contour ne
		## s'affiche (bug repere le 2026-07-28 : le contour cense assurer la lisibilite n'existait
		## en fait jamais).
		label.add_theme_color_override("font_outline_color", Color.BLACK)
		label.add_theme_constant_override("outline_size", 6)
		label.text = "%s : %d" % [CardRarity.get_label(rarity), Economy.get_balance(rarity)]
		coins_container.add_child(label)

func _refresh_collection() -> void:
	var total := 0
	for file_name in DirAccess.get_files_at(CARDS_DIR):
		if file_name.ends_with(".tres"):
			total += 1
	var owned := CardCollection.get_owned_card_ids().size()
	var percent := 0 if total == 0 else roundi(100.0 * float(owned) / float(total))
	collection_label.text = "Collection : %d / %d cartes (%d %%)" % [owned, total, percent]
