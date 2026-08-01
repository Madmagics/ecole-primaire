## A poser sur le noeud racine de CHAQUE scene de decor "de base" (voir tree.tscn,
## flower_bed.tscn) pour la rendre habillable par saison. Au demarrage, cherche si un fichier du
## meme nom existe dans le sous-dossier de la saison courante
## (entities/decor/seasons/<saison>/<nom>.tscn - <nom> deduit automatiquement du fichier de LA
## SCENE ELLE-MEME via scene_file_path, rien a saisir a la main) ; si oui, jette le contenu de
## base et le remplace par cette variante. Sinon ne fait rien (contenu de base conserve, cout nul
## en dehors d'un ResourceLoader.exists()).
##
## Exemple : entities/decor/tree.tscn porte ce script. Un(e) artiste depose
## entities/decor/seasons/hiver/tree.tscn (arbre enneige, meme structure interne ou non - libre)
## -> des qu'on est en hiver, CHAQUE instance de Tree affiche automatiquement la version
## enneigee, sans toucher a park.tscn ni a aucune instance deja placee.
##
## Limite connue : substitution uniquement a l'execution (_ready), pas previsualisable dans
## l'editeur (le decor de base reste affiche tant qu'on ne lance pas le jeu). Un script @tool
## avec previsualisation resterait possible (voir gestion de l'ownership des noeuds generes)
## mais ajoute de la complexite - a faire seulement si le besoin se confirme a l'usage.
class_name SeasonalSkin
extends Node3D

const SEASONS_DIR := "res://entities/decor/seasons/"

func _ready() -> void:
	## Garde-fou : une variante saisonniere ne doit jamais porter ce script sur sa propre racine
	## (elle EST deja le skin final) - evite une auto-instanciation en boucle si ca arrivait
	## quand meme par erreur de copier-coller.
	if scene_file_path.begins_with(SEASONS_DIR):
		return
	var seasonal_scene := _find_seasonal_variant()
	if seasonal_scene == null:
		return
	for child in get_children():
		child.free()
	add_child(seasonal_scene.instantiate())

## Cherche une variante saisonniere portant le meme nom de fichier que cette scene (ex: "tree"
## pour tree.tscn). Renvoie null si aucune variante n'existe pour la saison courante.
func _find_seasonal_variant() -> PackedScene:
	if scene_file_path.is_empty():
		return null
	var decor_name := scene_file_path.get_file().get_basename()
	var season_folder := Season.get_folder_name(Season.current())
	var seasonal_path := "%s%s/%s.tscn" % [SEASONS_DIR, season_folder, decor_name]
	if not ResourceLoader.exists(seasonal_path, "PackedScene"):
		return null
	return load(seasonal_path)
