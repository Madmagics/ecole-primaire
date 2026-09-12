## Sprite d'un prof (NPC), affiche a sa taille nature (texture au pixel pres) multipliee par le
## facteur commun ProfVisualScale.factor (voir data/prof_visual_scale.gd). Un seul chiffre a
## modifier pour faire varier la taille des 5 profs a la fois, en gardant leurs proportions
## relatives entre eux (chacun garde sa taille nature propre, seul le facteur commun s'ajoute
## par-dessus).
## Anime aussi un leger mouvement idle ("respiration") pour rendre le sprite statique plus vivant,
## ancre sur les pieds : le point bas du sprite (au repos) reste fixe, seul le haut du corps s'etire
## tres legerement vers le haut puis revient. Uniquement vertical, PAS de balancement lateral/
## rotation (retire le 2026-09-02, retour utilisateur : ca faisait "ballon gonfle a l'helium qui se
## balance" plutot qu'une respiration - voir l'ancienne version dans l'historique git si besoin de
## la reintroduire). Aucune deformation du dessin lui-meme, uniquement scale.y + position.y du noeud
## (meme famille de technique que wind_sway.gd pour les arbres : transform rigide). Comme
## l'animation porte sur ce noeud et non sur la texture, elle continue de s'appliquer telle quelle
## quel que soit le skin affiche (prof1.0, prof1.1, prof1.2, ... skins achetables futurs).
## Respiration par a-coups, pas un sinus continu (2026-09-02, suite - retour utilisateur) : une
## pause immobile de duree ALEATOIRE (voir PAUSE_MIN/PAUSE_MAX) puis UNE extension (montee-descente,
## voir STRETCH_DURATION), puis une nouvelle pause d'une duree aleatoire differente, etc. - voir
## _process pour la machine a etats (_is_stretching). Une simple sinusoide continue dephasee par PNJ
## (ancienne version, _time_offset) restait parfaitement synchronisee EN RELATIF d'un PNJ a l'autre
## pour toujours ; en retirant une nouvelle duree aleatoire a chaque pause, les PNJ derivent les uns
## par rapport aux autres au fil du temps et ne finissent jamais tous par respirer a l'unisson.
## @tool : le resultat de _apply_scale() s'applique aussi dans l'editeur (pas seulement en jeu),
## pour le voir sans lancer de partie - recharger la scene apres avoir change le facteur pour
## rafraichir les 5 a la fois. L'animation idle, elle, ne tourne qu'en jeu (pas dans l'editeur).
##
## Skin achetable applique au demarrage (2026-08-29, retour utilisateur : 5 nouveaux onglets
## boutique, 10 skins de prof par classe, achat + equipement en jeu) : la classe de ce PNJ n'est
## pas dupliquee ici (voir _find_sibling_question_giver, meme principe que
## QuestionGiverComponent._find_sibling_interactable) - le skin actif (ProfSkins.get_active_skin)
## est applique au _ready() puis a chaque ProfSkins.skin_activated concernant cette classe, sans
## recharger la scene. Rien de tout ca ne tourne dans l'editeur (voir Engine.is_editor_hint(),
## ProfSkins n'existe pas hors jeu) : le texture= pose en dur sur chaque instance dans school.tscn
## (prof1.0, prof2.0, ...) reste l'apercu editeur et le repli hors jeu - il correspond deja au
## skin par defaut (index 0, toujours debloque, voir ProfSkins.reset()), donc au tout premier
## lancement d'un compte le resultat est identique.
## class_name ajoute le 2026-09-05 (bulle de dialogue BD, voir ui/speech_bubble/speech_bubble.gd) :
## permet a SpeechBubble de retrouver son ProfVisual frere via "child is ProfVisual", meme idiome
## que QuestionGiverComponent._find_sibling_interactable / ProfVisual._find_sibling_question_giver
## ci-dessous.
@tool
class_name ProfVisual
extends Sprite2D

@export var scale_settings: ProfVisualScale = preload("res://data/prof_visual_scale.tres")

@export_group("Idle vivant")
@export_range(0.0, 0.1, 0.001) var stretch_amplitude: float = 0.025 ## etirement vertical max (0.025 = 2.5%), toujours vers le haut, jamais en dessous du repos
## Duree d'UNE extension complete (montee + redescente, pas juste la montee), tiree au sort dans
## [stretch_min, stretch_max] a chaque debut d'extension (voir _process) - meme principe que
## pause_min/pause_max ci-dessous, pour varier aussi le rythme de la respiration elle-meme d'un
## cycle a l'autre, pas seulement le temps entre deux respirations.
@export var stretch_min: float = 4.0
@export var stretch_max: float = 5.0
## Duree de la pause immobile entre deux extensions, tiree au sort dans [pause_min, pause_max] a
## chaque fois qu'une extension se termine (voir _process) - une valeur differente a chaque cycle,
## pas juste un dephasage initial fixe, pour que les PNJ derivent les uns des autres dans le temps.
@export var pause_min: float = 2.0
@export var pause_max: float = 4.0

var _rest_scale: Vector2       # scale au repos (avant etirement idle), en general scale_settings.factor
var _half_height_rest: float   # moitie de la hauteur du sprite au repos (centered=true : pivot par defaut au centre)
var _feet_anchor: Vector2      # position du point "pieds" au repos, dans l'espace du parent - ne bouge plus ensuite
var _rest_position: Vector2    # position au repos (avant tout decalage idle) - fixe des _ready()
var _grade: GradeLevel.Grade   # classe de ce PNJ, lue sur le QuestionGiverComponent frere (voir _find_sibling_question_giver)

## Machine a etats a 2 phases : en pause (immobile, _pause_time_left decompte vers 0) ou en train
## de s'etirer (_stretch_elapsed monte vers _current_stretch_duration, tiree au sort au debut de
## CHAQUE extension - voir stretch_min/stretch_max). Demarre en pause avec une duree aleatoire (voir
## _ready) : chaque PNJ attend donc un temps different avant sa toute premiere extension, sans avoir
## besoin d'un _time_offset separe comme avant.
var _is_stretching: bool = false
var _pause_time_left: float = 0.0
var _stretch_elapsed: float = 0.0
var _current_stretch_duration: float = 0.0

func _ready() -> void:
	_apply_scale()
	_rest_scale = scale
	_rest_position = position
	_recompute_feet_anchor()
	_pause_time_left = randf_range(pause_min, pause_max)
	set_process(not Engine.is_editor_hint())
	if not Engine.is_editor_hint():
		var question_giver := _find_sibling_question_giver()
		if question_giver:
			_grade = question_giver.grade
			_apply_active_skin()
			ProfSkins.skin_activated.connect(_on_skin_activated)

func _apply_scale() -> void:
	if scale_settings:
		scale = Vector2.ONE * scale_settings.factor

## Applique le skin actuellement porte pour _grade (voir ProfSkins.get_active_skin/
## ProfSkinCatalog) et recalcule l'ancrage "pieds" de l'animation idle, au cas ou le nouveau skin
## n'aurait pas exactement la meme hauteur native que le precedent (toutes les variantes
## prof<N>.<index>.webp partagent en principe le meme cadrage, mais un decalage silencieux serait
## sinon invisible tant qu'aucun skin de taille differente n'est ajoute).
func _apply_active_skin() -> void:
	texture = ProfSkinCatalog.get_texture(_grade, ProfSkins.get_active_skin(_grade))
	_recompute_feet_anchor()

func _recompute_feet_anchor() -> void:
	_half_height_rest = (texture.get_height() * _rest_scale.y * 0.5) if texture else 0.0
	_feet_anchor = _rest_position + Vector2(0.0, _half_height_rest)

## Filtre sur "changed_grade" : ce signal est diffuse a tous les ProfVisual a la fois (5 au
## total), meme principe que l'ancien QuestionGiverComponent._on_grade_unlocked.
func _on_skin_activated(changed_grade: GradeLevel.Grade, _skin_index: int) -> void:
	if changed_grade == _grade:
		_apply_active_skin()

## Cherche le QuestionGiverComponent frere qui porte le numero de classe de ce PNJ - meme
## technique de recherche que QuestionGiverComponent._find_sibling_interactable (l'ancien
## _find_sibling_locked_visual, retire, faisait de meme pour la capsule de grisage).
func _find_sibling_question_giver() -> QuestionGiverComponent:
	for child in get_parent().get_children():
		if child is QuestionGiverComponent:
			return child
	return null

func _process(delta: float) -> void:
	var stretch := 0.0
	if _is_stretching:
		_stretch_elapsed += delta
		if _stretch_elapsed >= _current_stretch_duration:
			# Extension terminee : nouvelle pause de duree aleatoire avant la prochaine (voir
			# commentaire de tete de fichier - c'est ce tirage repete, pas juste un dephasage
			# initial, qui empeche les PNJ de finir par respirer a l'unisson).
			_is_stretching = false
			_pause_time_left = randf_range(pause_min, pause_max)
		else:
			# Demi-sinusoide sur [0, _current_stretch_duration] : 0 au debut/a la fin, amplitude
			# max au milieu - monte puis redescend en douceur, jamais de saut brusque.
			var t01 := _stretch_elapsed / _current_stretch_duration
			stretch = stretch_amplitude * sin(t01 * PI)
	else:
		_pause_time_left -= delta
		if _pause_time_left <= 0.0:
			_is_stretching = true
			_stretch_elapsed = 0.0
			_current_stretch_duration = randf_range(stretch_min, stretch_max)
	scale.y = _rest_scale.y * (1.0 + stretch)
	var half_height_now: float = _half_height_rest * (1.0 + stretch)
	# purement vertical : la base (pieds) ne bouge pas, seul le haut du sprite monte/descend -
	# pas de rotation/balancement lateral (voir commentaire de tete de fichier, 2026-09-02).
	position = _feet_anchor - Vector2(0.0, half_height_now)
