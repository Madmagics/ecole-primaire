## Socle commun des mini-jeux de la cour de recre (2026-11-25). Chaque jeu est une scene plein
## ecran dont la racine herite de MiniGame : la cour (levels/playground/playground.gd) l'instancie,
## lui donne la classe de l'enfant qui l'a propose (grade), puis la libere quand le jeu emet closed.
##
## Controles : souris ET tactile avec le MEME code. Le reglage par defaut du projet
## input_devices/pointing/emulate_mouse_from_touch (true, doc officielle) transforme un tap ou un
## glissement de doigt en evenements souris - un jeu n'ecoute donc QUE InputEventMouseButton /
## InputEventMouseMotion, jamais InputEventScreenTouch en plus (sinon double declenchement), meme
## regle que interactable_component_2d.gd. Aucun raccourci clavier (jeu 100% souris/tactile).
class_name MiniGame
extends Control

signal closed

var grade: GradeLevel.Grade = GradeLevel.Grade.CP

## Cartes de la classe [grade] (CardResource), triees par id - pour les jeux qui montrent les
## animaux de la collection (Memory, Simon, Taquin, 2048...).
static func get_grade_cards(for_grade: GradeLevel.Grade) -> Array[CardResource]:
	var cards: Array[CardResource] = []
	for card_id in PlaygroundChildPopup.get_card_ids(for_grade):
		var card := load("%s/%s.tres" % [PlaygroundChildPopup.CARDS_DIR, card_id]) as CardResource
		if card and card.texture:
			cards.append(card)
	cards.sort_custom(func(a: CardResource, b: CardResource) -> bool: return int(String(a.id)) < int(String(b.id)))
	return cards

static func get_grade_textures(for_grade: GradeLevel.Grade) -> Array[Texture2D]:
	var textures: Array[Texture2D] = []
	for card in get_grade_cards(for_grade):
		textures.append(card.texture)
	return textures

## Plus grand rectangle aux proportions de [content_size] centre dans [area].
static func fit_rect(content_size: Vector2, area: Rect2) -> Rect2:
	if content_size.x <= 0.0 or content_size.y <= 0.0:
		return area
	var ratio := minf(area.size.x / content_size.x, area.size.y / content_size.y)
	var fitted := content_size * ratio
	return Rect2(area.position + (area.size - fitted) * 0.5, fitted)
