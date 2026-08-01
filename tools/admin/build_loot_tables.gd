## Outil admin : (re)genere les 5 coffres de la boutique (un par rarete), a partir
## de toutes les CardResource presentes dans data/card/resources/.
## Usage : ouvrir ce script dans l'editeur Godot puis File > Run (ou Ctrl+Shift+X).
## A relancer a chaque fois que de nouvelles cartes sont ajoutees (via import_cards.gd)
## pour que les coffres les incluent.
##
## Comportement :
## - Chaque coffre regroupe uniquement les cartes de SA rarete (poids egal entre elles).
## - Depuis le 2026-07-26, CardResource n'a plus de champ "rarity" propre (remplace par "grade",
##   voir card_resource.gd) : la rarete d'une carte pour le regroupement en coffres est deduite
##   via GradeLevel.get_rarity(card.grade) - les coffres/l'economie de la boutique restent
##   inchanges, seule la source de la rarete a change (calculee, plus stockee sur la carte).
## - Si un coffre existe deja, son crate_price N'EST PAS ecrase (modifiable librement dans
##   l'inspecteur) : seuls crate_name, rarity et entries sont regeneres. A la toute premiere
##   creation, un prix par defaut (DEFAULT_PRICES) est utilise.
@tool
extends EditorScript

const CARDS_DIR := "res://data/card/resources"
const OUTPUT_DIR := "res://data/loot/resources"

## Prix par defaut, utilise uniquement a la toute premiere creation d'un coffre. Uniformise a
## 50 pour toutes les raretes le 2026-07-21 (a la demande de l'utilisateur - les 5 coffres
## existants ont ete edites a la main au meme prix, voir crate_price dans chaque .tres).
const DEFAULT_PRICES := {
	CardRarity.Rarity.COMMON: 50,
	CardRarity.Rarity.UNCOMMON: 50,
	CardRarity.Rarity.RARE: 50,
	CardRarity.Rarity.EPIC: 50,
	CardRarity.Rarity.LEGENDARY: 50,
}

## Nom de fichier (sans extension) par rarete.
const FILE_NAMES := {
	CardRarity.Rarity.COMMON: "crate_commun",
	CardRarity.Rarity.UNCOMMON: "crate_peu_commun",
	CardRarity.Rarity.RARE: "crate_rare",
	CardRarity.Rarity.EPIC: "crate_epique",
	CardRarity.Rarity.LEGENDARY: "crate_legendaire",
}

func _run() -> void:
	EditorInterface.get_resource_filesystem().scan()

	var cards_by_rarity: Dictionary = {}
	for rarity in FILE_NAMES.keys():
		cards_by_rarity[rarity] = []

	var file_names := DirAccess.get_files_at(CARDS_DIR)
	for file_name in file_names:
		if not file_name.ends_with(".tres"):
			continue
		var card_path := "%s/%s" % [CARDS_DIR, file_name]
		var card := ResourceLoader.load(card_path, "", ResourceLoader.CACHE_MODE_IGNORE) as CardResource
		if card == null:
			continue
		var derived_rarity := GradeLevel.get_rarity(card.grade)
		if cards_by_rarity.has(derived_rarity):
			cards_by_rarity[derived_rarity].append(card)

	var written := 0
	for rarity in FILE_NAMES.keys():
		var out_path := "%s/%s.tres" % [OUTPUT_DIR, FILE_NAMES[rarity]]
		var crate: LootTableResource
		if ResourceLoader.exists(out_path):
			crate = ResourceLoader.load(out_path, "", ResourceLoader.CACHE_MODE_IGNORE) as LootTableResource
		if crate == null:
			crate = LootTableResource.new()
			crate.crate_price = DEFAULT_PRICES[rarity]

		crate.crate_name = "Coffre %s" % CardRarity.get_label(rarity)
		crate.rarity = rarity

		var entries: Array[LootEntry] = []
		for card in cards_by_rarity[rarity]:
			var entry := LootEntry.new()
			entry.card = card
			entry.weight = 1.0
			entries.append(entry)
		crate.entries = entries

		var err := ResourceSaver.save(crate, out_path)
		if err != OK:
			push_error("build_loot_tables: echec sauvegarde %s (code %d)" % [out_path, err])
			continue
		written += 1
		print("build_loot_tables: %s -> %d carte(s)" % [out_path, entries.size()])

	EditorInterface.get_resource_filesystem().scan()
	print("build_loot_tables: %d coffre(s) mis a jour" % written)
