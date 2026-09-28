## Tirage des questions et des textes de lecture (2026-09-28, retour d'utilisateurs : "on a
## regulierement les memes questions et les memes textes de comprehension"). Remplace le tirage
## au hasard pur et le "pack de revision" multi-classes de QuestionGiverComponent :
## - chaque serie contient AU MOINS UNE QUESTION PAR NOTION de la classe+matiere. S'il y a plus de
##   notions que de places, les notions tournent : chaque serie prend des notions pas encore vues
##   dans le cycle en cours, puis le cycle recommence une fois toutes les notions passees ;
## - une question deja tombee ne revient pas tant que les autres questions de SA notion ne sont
##   pas toutes passees (les places restantes de la serie sont completees au hasard parmi les
##   questions pas encore vues) ;
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
static func draw_questions(pool: Array[QuestionResource], count: int, state: Dictionary) -> Array[QuestionResource]:
	var result: Array[QuestionResource] = []
	if pool.is_empty() or count <= 0:
		return result
	var by_notion := _group_by_notion(pool)
	var seen := _to_int_set(state.get("questions", []))
	var notions_seen: Dictionary = {}
	for code: Variant in state.get("notions", []):
		if by_notion.has(str(code)):
			notions_seen[str(code)] = true
	var picked: Dictionary = {}

	# 1) Une question par notion retenue pour cette serie.
	var notion_codes: Array[String] = []
	notion_codes.assign(by_notion.keys())
	for code in _pick_notions(notion_codes, mini(count, notion_codes.size()), notions_seen):
		var question := _pick_in_notion(by_notion[code], seen, picked)
		result.append(question)
		picked[question.id] = true
		seen[question.id] = true

	# 2) Complement au hasard parmi les questions pas encore vues.
	var target := mini(count, pool.size())
	while result.size() < target:
		var candidates: Array[QuestionResource] = []
		for question in pool:
			if not seen.has(question.id) and not picked.has(question.id):
				candidates.append(question)
		if candidates.is_empty():
			# Tout ce pool a deja ete vu : nouveau cycle (on n'efface que les IDs de CE pool,
			# utile en lecture ou un meme historique couvre plusieurs textes).
			for question in pool:
				if not picked.has(question.id):
					seen.erase(question.id)
			continue
		candidates.shuffle()
		for question in candidates.slice(0, target - result.size()):
			result.append(question)
			picked[question.id] = true
			seen[question.id] = true

	state["questions"] = seen.keys()
	state["notions"] = notions_seen.keys()
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
	elif notions_seen.size() >= all_codes.size():
		notions_seen.clear()
	return chosen

## Une question pas encore vue de cette notion ; si toutes l'ont ete, la notion repart a zero.
static func _pick_in_notion(questions: Array[QuestionResource], seen: Dictionary, picked: Dictionary) -> QuestionResource:
	var candidates: Array[QuestionResource] = []
	for question in questions:
		if not seen.has(question.id) and not picked.has(question.id):
			candidates.append(question)
	if candidates.is_empty():
		for question in questions:
			seen.erase(question.id)
			if not picked.has(question.id):
				candidates.append(question)
	return candidates.pick_random()

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
