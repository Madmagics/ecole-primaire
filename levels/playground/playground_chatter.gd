## Conversations des enfants de la cour (2026-11-25). Les deux enfants de chaque classe se
## repondent a tour de role (repliques de PlaygroundDialogues) : chaque bulle reste affichee 6 a
## 10 secondes (rythme divise par 2 le 2026-11-25, retour utilisateur : "ca revient trop vite"), se referme, puis l'autre enfant repond. Entre deux conversations d'un meme binome,
## une pause de quelques secondes ; au plus MAX_SIMULTANEOUS binomes parlent en meme temps pour
## que l'ecran ne se remplisse pas de bulles. Cree et demarre par playground.gd.
##
## Attentes faites avec des Timer enfants (pas get_tree().create_timer) : quand la cour est
## liberee, les Timer le sont avec elle et les conversations en cours s'arretent proprement.
class_name PlaygroundChatter
extends Node

const LINE_MIN_SECONDS := 6.0
const LINE_MAX_SECONDS := 10.0
const BETWEEN_LINES_SECONDS := 0.6
const GAP_MIN_SECONDS := 12.0
const GAP_MAX_SECONDS := 28.0
const FIRST_DELAY_MAX_SECONDS := 16.0
const MAX_SIMULTANEOUS := 2

var _active_conversations: int = 0

## [pairs] : classe -> {1: PlaygroundChild, 2: PlaygroundChild}.
func start(pairs: Dictionary) -> void:
	for grade in pairs:
		var pair: Dictionary = pairs[grade]
		var first := pair.get(1) as PlaygroundChild
		var second := pair.get(2) as PlaygroundChild
		if first and second and first.bubble and second.bubble:
			_run_pair(PlaygroundDialogues.CONVERSATIONS.get(grade, []), first, second)

func _run_pair(conversations: Array, first: PlaygroundChild, second: PlaygroundChild) -> void:
	if conversations.is_empty():
		return
	await _wait(randf_range(1.0, FIRST_DELAY_MAX_SECONDS))
	## Paquet melange : toutes les conversations passent une fois avant qu'une ne se repete, et la
	## derniere d'un paquet n'ouvre jamais le suivant.
	var deck: Array[int] = []
	var last_index := -1
	while true:
		while _active_conversations >= MAX_SIMULTANEOUS:
			await _wait(1.0)
		if deck.is_empty():
			for i in conversations.size():
				deck.append(i)
			deck.shuffle()
			if deck.size() > 1 and deck[0] == last_index:
				deck.append(deck.pop_front())
		var index: int = deck.pop_front()
		last_index = index
		_active_conversations += 1
		for line in conversations[index]:
			var speaker := first if int(line[0]) == 1 else second
			await speaker.bubble.say(PlaygroundDialogues.one_sentence_per_line(String(line[1])))
			await _wait(randf_range(LINE_MIN_SECONDS, LINE_MAX_SECONDS))
			await speaker.bubble.hide_bubble()
			await _wait(BETWEEN_LINES_SECONDS)
		_active_conversations -= 1
		await _wait(randf_range(GAP_MIN_SECONDS, GAP_MAX_SECONDS))

func _wait(seconds: float) -> void:
	var timer := Timer.new()
	timer.one_shot = true
	timer.wait_time = seconds
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
