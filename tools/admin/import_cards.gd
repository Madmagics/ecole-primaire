## Outil admin : cree/met a jour les CardResource (.tres) a partir d'un CSV.
## Usage : ouvrir ce script dans l'editeur Godot puis File > Run (ou Ctrl+Shift+X).
## Colonnes attendues dans csv/cards.csv (separees par ";", format Excel FR) :
##   id;categorie;nom;classe
## - id : numero unique de la carte. Convention : blocs de 5 id consecutifs par
##   espece/design (un par variante, une variante = une classe), ex: 1-5 = Chat (CP->CM2),
##   6-10 = Chien... (la rarete a ete retiree du systeme de cartes le 2026-07-26 : chaque carte
##   a maintenant une classe, plus de palier de rarete separe - voir GradeLevel.get_color()).
## - categorie : chien, chat, robot, extraterrestre, etc. (determine le design/art plus tard)
## - classe accepte (insensible a la casse/accents) : CP, CE1, CE2, CM1, CM2.
## Relancer le script apres avoir modifie le CSV pour pousser la mise a jour : les cartes
## existantes (meme id) sont mises a jour sans perdre leur description assignee a la main
## dans l'inspecteur (ce script ne touche pas a ce champ).
## Image : depose un fichier "data/card/art/<id>.webp" (format recommande - voir echange sur le
## poids des images, ~59Ko en 512x612 contre 1.8Mo en PNG a la meme scene) ou "<id>.png" (ex:
## "1.webp" pour la carte id=1) et il sera assigne automatiquement au champ Texture de la carte
## au prochain import. .webp est cherche en premier si les deux existent pour le meme id.
@tool
extends EditorScript

const CSV_PATH := "res://csv/cards.csv"
const OUTPUT_DIR := "res://data/card/resources"
const ART_DIR := "res://data/card/art"

func _run() -> void:
	# Rescanne d'abord pour que les .png tout juste deposes soient importes et chargeables.
	EditorInterface.get_resource_filesystem().scan()

	var written := CsvResourceImporter.import(CSV_PATH, OUTPUT_DIR, _build_card)
	print("import_cards: %d carte(s) importee(s)/mise(s) a jour depuis %s" % [written, CSV_PATH])

func _build_card(headers: PackedStringArray, row: PackedStringArray) -> Resource:
	var values := CsvResourceImporter.row_to_dict(headers, row)
	var id: String = values.get("id", "")
	if id == "":
		return null

	# Recharge la carte existante si elle existe deja, pour ne pas ecraser la description
	# assignee a la main dans l'inspecteur et non geree par ce CSV.
	var out_path := "%s/%s.tres" % [OUTPUT_DIR, id]
	var card: CardResource
	if ResourceLoader.exists(out_path):
		card = ResourceLoader.load(out_path, "", ResourceLoader.CACHE_MODE_IGNORE) as CardResource
	if card == null:
		card = CardResource.new()

	card.id = StringName(id)
	card.category = StringName(values.get("categorie", ""))
	card.display_name = values.get("nom", "")
	card.grade = _parse_grade(values.get("classe", ""))

	var art_path := _find_art_path(id)
	if art_path != "":
		var loaded_texture := load(art_path)
		if loaded_texture is Texture2D:
			card.texture = loaded_texture

	return card

## Cherche l'art de la carte en .webp (format recommande) puis en .png (toujours supporte, pour
## un fichier depose avant qu'on passe au WebP). Retourne "" si aucun des deux n'existe.
func _find_art_path(id: String) -> String:
	for ext in ["webp", "png"]:
		var path := "%s/%s.%s" % [ART_DIR, id, ext]
		if FileAccess.file_exists(path):
			return path
	return ""

func _parse_grade(text: String) -> GradeLevel.Grade:
	match text.to_lower().strip_edges():
		"ce1":
			return GradeLevel.Grade.CE1
		"ce2":
			return GradeLevel.Grade.CE2
		"cm1":
			return GradeLevel.Grade.CM1
		"cm2":
			return GradeLevel.Grade.CM2
		_:
			return GradeLevel.Grade.CP
