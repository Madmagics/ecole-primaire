## Tirage des questions et des textes de lecture (2026-09-28, retour d'utilisateurs : "on a
## regulierement les memes questions et les memes textes de comprehension"). Remplace le tirage
## au hasard pur et le "pack de revision" multi-classes de QuestionGiverComponent :
## - chaque serie contient AU MOINS UNE QUESTION PAR NOTION de la classe+matiere. S'il y a plus de
##   notions que de places, les notions tournent : chaque serie prend des notions pas encore vues
##   dans le cycle en cours, puis le cycle recommence une fois toutes les notions passees ;
## - une question deja tombee ne revient pas tant que TOUTES les questions de la classe+matiere ne
##   sont pas passees (2026-11-08 ; les places restantes de la serie sont completees au hasard
##   parmi les questions pas encore vues) ;
## - lecture : un texte ne revient pas tant que tous les textes de la classe ne sont pas passes
##   (ordre aleatoire), et le dernier texte lu n'ouvre jamais le cycle suivant.
##
## Fonctions statiques sans etat propre : l'historique ("state", un Dictionary) est fourni et
## modifie par l'appelant, qui le range dans la sauvegarde du compte (SaveManager.get_draw_state /
## set_draw_state). Les nombres relus depuis le JSON de sauvegarde arrivent en float : tout ID est
## donc repasse en int ici avant de servir de cle.
class_name QuestionDraw
extends RefCounted

## Tire [count] questions de [pool] (ou moins si le pool est plus petit), selon les regles
## ci-dessus. Met a jour [state] (cles "questions" et "notions").
## 2026-11-08 (retour de Steve : en Histoire-Geo CM1/CM2 des questions revenaient d'une serie a
## l'autre) : TOUTES les questions du pool passent avant qu'une seule revienne. La regle "une
## question par notion" ne s'applique plus qu'aux notions qui ont encore des questions pas vues
## (avant, une notion epuisee etait remise a zero seule, ce qui refaisait tomber ses questions
## alors que d'autres n'etaient jamais sorties). L'historique ne repart a zero qu'une fois tout
## le pool vu, et jamais avec une question de la serie en cours.
static func draw_questions(pool: Array[QuestionResource], count: int, state: Dictionary) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	if pool.is_empty() or count <= 0:
		return result
	var target := mini(count, pool.size())
	var seen := _to_int_set(state.get("questions", []))
	var notions_seen: Dictionary = {}
	var all_notions := _group_by_notion(pool)
	for code: Variant in state.get("notions", []):
		if all_notions.has(str(code)):
			notions_seen[str(code)] = true
	var picked: Dictionary = {}

	# 1) Une question par notion, parmi les notions qui ont encore des questions pas vues.
	var by_notion := _group_by_notion(_unseen(pool, seen, picked))
	var notion_codes: Array[String] = []
	notion_codes.assign(by_notion.keys())
	for code in _pick_notions(notion_codes, mini(target, notion_codes.size()), notions_seen):
		var questions: Array[QuestionResource] = by_notion[code]
		_take(questions.pick_random(), result, picked, seen)

	# 2) Complement au hasard parmi les questions pas encore vues.
	_fill(_unseen(pool, seen, picked), target, result, picked, seen)

	# 3) Tout le pool a ete vu : nouveau cycle (on n'efface que les IDs de CE pool, utile en
	#    lecture ou un meme historique couvre plusieurs textes), sans reprendre cette serie.
	if result.size() < target:
		for question in pool:
			if not picked.has(question.id):
				seen.erase(question.id)
		_fill(_unseen(pool, seen, picked), target, result, picked, seen)

	state["questions"] = seen.keys()
	state["notions"] = notions_seen.keys()
	result.shuffle()
	return result

## Questions de [pool] ni vues dans le cycle en cours ni deja prises dans cette serie.
static func _unseen(pool: Array[QuestionResource], seen: Dictionary, picked: Dictionary) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	for question in pool:
		if not seen.has(question.id) and not picked.has(question.id):
			result.append(question)
	return result

## Ajoute au hasard des questions de [candidates] a [result] jusqu'a [target].
static func _fill(candidates: Array[QuestionResource], target: int, result: Array[QuestionResource], picked: Dictionary, seen: Dictionary) -> void:
	candidates.shuffle()
	for question in candidates.slice(0, target - result.size()):
		_take(question, result, picked, seen)

static func _take(question: QuestionResource, result: Array[QuestionResource], picked: Dictionary, seen: Dictionary) -> void:
	result.append(question)
	picked[question.id] = true
	seen[question.id] = true

## Tirage reparti entre plusieurs groupes de questions (2026-11-07, Histoire-Geo CP-CE2 : 5 questions
## d'histoire + 5 de geographie par serie). [groups] et [counts] ont la meme taille ; chaque groupe
## est tire avec draw_questions (memes regles : une question par notion, pas de repetition) en
## partageant le meme historique [state]. Si un groupe a moins de questions que prevu, les places
## manquantes sont prises dans les autres groupes.
static func draw_by_groups(groups: Array, counts: Array[int], state: Dictionary) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	var notions: Dictionary = {}
	var missing := 0
	for i: int in groups.size():
		var pool: Array[QuestionResource] = []
		pool.assign(groups[i])
		var sub := {"questions": state.get("questions", []), "notions": state.get("notions", [])}
		var drawn := draw_questions(pool, counts[i], sub)
		missing += counts[i] - drawn.size()
		result.append_array(drawn)
		state["questions"] = sub["questions"]
		for code: Variant in sub["notions"]:
			notions[str(code)] = true
	if missing > 0:
		var rest: Array[QuestionResource] = []
		var taken: Dictionary = {}
		for question in result:
			taken[question.id] = true
		for group: Variant in groups:
			for question: QuestionResource in group:
				if not taken.has(question.id):
					rest.append(question)
		rest.shuffle()
		result.append_array(rest.slice(0, missing))
	state["notions"] = notions.keys()
	result.shuffle()
	return result

## Tire un texte de lecture pas encore lu dans le cycle en cours. Met a jour [state] (cles
## "textes" et "dernier_texte"). Renvoie null si [passages] est vide.
static func draw_passage(passages: Array[PassageResource], state: Dictionary) -> PassageResource:
	if passages.is_empty():
		return null
	var seen := _to_int_set(state.get("textes", []))
	var last_id := int(state.get("dernier_texte", 0))
	var candidates: Array[PassageResource] = []
	for passage in passages:
		if not seen.has(passage.id):
			candidates.append(passage)
	if candidates.is_empty():
		# Tous les textes ont ete lus : nouveau cycle, sans reprendre tout de suite le dernier.
		seen.clear()
		for passage in passages:
			if passage.id != last_id or passages.size() == 1:
				candidates.append(passage)
	var chosen: PassageResource = candidates.pick_random()
	seen[chosen.id] = true
	state["textes"] = seen.keys()
	state["dernier_texte"] = chosen.id
	return chosen

## Choisit [n] notions en priorite parmi celles pas encore vues dans le cycle ([notions_seen],
## modifie). Quand le cycle est epuise, il repart a zero et complete avec d'autres notions.
static func _pick_notions(all_codes: Array[String], n: int, notions_seen: Dictionary) -> Array[String]:
	var remaining: Array[String] = []
	for code in all_codes:
		if not notions_seen.has(code):
			remaining.append(code)
	remaining.shuffle()
	var chosen: Array[String] = []
	chosen.assign(remaining.slice(0, n))
	for code in chosen:
		notions_seen[code] = true
	if chosen.size() < n:
		notions_seen.clear()
		var others: Array[String] = []
		for code in all_codes:
			if not chosen.has(code):
				others.append(code)
		others.shuffle()
		for code in others.slice(0, n - chosen.size()):
			chosen.append(code)
			notions_seen[code] = true
	else:
		for code in all_codes:
			if not notions_seen.has(code):
				return chosen
		notions_seen.clear()
	return chosen

static func _group_by_notion(pool: Array[QuestionResource]) -> Dictionary:
	var groups: Dictionary = {}
	for question in pool:
		if not groups.has(question.notion):
			var list: Array[QuestionResource] = []
			groups[question.notion] = list
		groups[question.notion].append(question)
	return groups

static func _to_int_set(values: Variant) -> Dictionary:
	var result: Dictionary = {}
	if values is Array:
		for value: Variant in values:
			result[int(value)] = true
	return result
