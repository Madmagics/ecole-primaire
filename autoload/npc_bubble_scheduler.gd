## Coordonne l'affichage des bulles de dialogue des PNJ (voir ui/speech_bubble/speech_bubble.gd) :
## un seul PNJ montre sa bulle a la fois, jamais deux en meme temps (retour utilisateur 2026-09-05,
## "eviter que 2 bulles n'arrivent en meme temps [...] les bulles s'affichent a tour de role au
## hasard pendant 10 secondes puis apparaissent au professeur suivant"). Remplace l'ancien systeme
## ou chaque SpeechBubble tirait sa propre pause aleatoire independamment des autres (pouvait donc
## en afficher plusieurs a la fois par pur hasard).
## Chaque SpeechBubble s'enregistre ici a son _ready() (register) et se desinscrit a sa sortie de
## l'arbre (unregister) plutot que l'inverse (cet autoload irait chercher les PNJ dans school.tscn) :
## meme principe "le composant se fait connaitre" que ProfSkins.skin_activated ou EventBus, plutot
## qu'un chemin de scene code en dur ici.
## Boucle unique lancee au premier enregistrement (_running) : affiche un PNJ choisi au hasard
## (jamais deux fois de suite le meme si plus d'un PNJ est enregistre - voir _pick_next), attend
## TURN_DURATION secondes bulle pleinement visible, la cache completement (await, pas de fire-and-
## forget) avant de recommencer avec le PNJ suivant - garantit qu'il n'existe aucun instant ou deux
## bulles sont visibles a la fois, contrairement a un simple enchainement hide()/show() non attendu.
extends Node

const TURN_DURATION := 10.0

var _bubbles: Array[SpeechBubble] = []
var _current: SpeechBubble = null
var _running: bool = false

func register(bubble: SpeechBubble) -> void:
	_bubbles.append(bubble)
	if not _running:
		_running = true
		_run_loop()

func unregister(bubble: SpeechBubble) -> void:
	_bubbles.erase(bubble)
	if _current == bubble:
		_current = null

## Coroutine infinie demarree une seule fois (voir register) - pas de _process ici : les awaits
## imbriques (pop-in, attente du tour, pop-out) rendent une boucle a etats pilotee par delta bien
## plus compliquee a lire pour un resultat identique.
func _run_loop() -> void:
	while true:
		var next := _pick_next()
		if next == null:
			# Aucun PNJ enregistre pour l'instant (school.tscn encore en cours de chargement) -
			# on retente une seconde plus tard plutot que de boucler a vide chaque frame.
			await get_tree().create_timer(1.0).timeout
			continue
		_current = next
		await next.show_bubble()
		await get_tree().create_timer(TURN_DURATION).timeout
		if is_instance_valid(next):
			await next.hide_bubble()
		if _current == next:
			_current = null

## Exclut toujours _current en priorite (jamais deux tours de suite sur le meme PNJ) ; si ça ne
## laisse plus aucun candidat (un seul PNJ enregistre au total), retombe sur la liste complete -
## ce PNJ unique continue alors de tourner sur lui-meme, seul cas ou une repetition est acceptable.
func _pick_next() -> SpeechBubble:
	var candidates: Array[SpeechBubble] = []
	for bubble in _bubbles:
		if is_instance_valid(bubble) and bubble != _current:
			candidates.append(bubble)
	if candidates.is_empty():
		for bubble in _bubbles:
			if is_instance_valid(bubble):
				candidates.append(bubble)
	if candidates.is_empty():
		return null
	return candidates.pick_random()
