## Musiques de classe (nouvelles pistes musicales) debloquees par les Defis valides au palier
## ARGENT (SILVER_GOAL, voir ChallengeTracker) - 2026-09-06, retour utilisateur : "ajoute 5 cases
## en 2eme ligne de l onglet succes. lorsque les defis sont aux niveaux argent on debloquera de
## nouvelles musiques que je provisionnerai plus tard". Meme mecanique que ClassroomDecor (voir
## son commentaire de classe pour le detail), seuil different : ici SILVER_GOAL (20) plutot que
## GOLD_GOAL (50) - un palier moins exigeant, cohérent avec "musiques" arrivant avant "décors"
## dans la progression du joueur. Autoload separe plutot qu'un parametre sur ClassroomDecor : 2
## recompenses differentes (musique vs decor), meme duplication assumee que CrateItem/ProfSkinItem
## (voir feedback_lightweight_game.md - scripts courts et independants plutot qu'une base commune
## prematuree).
##
## Une classe debloque ses musiques quand LA TOTALITE de ses Defis est au palier argent ou plus -
## meme lecture dynamique de QuestionBankScanner.get_available_subjects(grade) que ClassroomDecor,
## pas de nombre code en dur.
##
## Selection/desactivation (2026-09-06, 2e passe, retour utilisateur : "afin de pouvoir
## selectionner le decor de classe de base ou la musique originale: selectionner une case fera
## changer le decor ou la musique, recliquer sur une case active deselectionnera celle si et
## retournera le decor ou la musique de base") : une classe debloquee n'est pas forcement ACTIVE -
## _active[grade] suit si la musique debloquee de cette classe est actuellement appliquee (true) ou
## si la classe est revenue a sa musique de base (false, etat par defaut meme juste apres
## deblocage - debloquer n'active pas automatiquement, un 2e clic est necessaire, voir
## ClassroomMusicItem._on_pressed). toggle_active() bascule entre les 2, jamais de "choix parmi
## plusieurs" ici (contrairement a ProfSkins, une seule musique par classe pour l'instant) - juste
## actif/inactif.
##
## BUG FIX exclusivite globale (2026-09-11, retour utilisateur : "actuellement on peut selectionner
## plusieurs cases. il faut pouvoir selectionner seulement une seule musique ou une seule scene, ou
## la deselectionner si on veut celui de base") : meme correctif que ClassroomDecor (voir son
## commentaire de classe pour le detail) - _active etait un bool INDEPENDANT par classe, rien
## n'empechait donc d'activer la musique du CP ET celle du CE1 en meme temps. toggle_active()
## desactive desormais explicitement toute autre classe avant d'activer celle demandee.
extends Node

const Grade = GradeLevel.Grade

var _unlocked: Dictionary = {
	Grade.CP: false,
	Grade.CE1: false,
	Grade.CE2: false,
	Grade.CM1: false,
	Grade.CM2: false,
}
var _active: Dictionary = {
	Grade.CP: false,
	Grade.CE1: false,
	Grade.CE2: false,
	Grade.CM1: false,
	Grade.CM2: false,
}

## Emis a chaque bascule active/inactive (voir toggle_active) - pas encore ecoute nulle part (la
## musique reste a fournir, voir le commentaire de classe), mais meme point d'accroche futur que
## ProfSkins.skin_activated.
signal music_activated(grade: Grade, active: bool)

func is_unlocked(grade: Grade) -> bool:
	return bool(_unlocked.get(grade, false))

## Une musique NON debloquee n'est jamais active, quoi que _active contienne (garde-fou, ne
## devrait de toute facon jamais arriver - toggle_active() refuse deja de s'activer si non
## debloque).
func is_active(grade: Grade) -> bool:
	return is_unlocked(grade) and bool(_active.get(grade, false))

## Nombre de Defis actuellement a l'argent (SILVER_GOAL, voir ChallengeTracker) pour [grade], sur
## le total requis (voir get_required_count) - affiche en "X/Y" sur la case de boutique.
func get_validated_count(grade: Grade) -> int:
	var count := 0
	for subject in QuestionBankScanner.get_available_subjects(grade):
		if ChallengeTracker.get_count(grade, subject) >= ChallengeTracker.SILVER_GOAL:
			count += 1
	return count

## Nombre de Defis a valider (a l'argent) pour debloquer les musiques de [grade] - TOUS les Defis
## de la classe, voir le commentaire de classe.
func get_required_count(grade: Grade) -> int:
	return QuestionBankScanner.get_available_subjects(grade).size()

func can_unlock(grade: Grade) -> bool:
	return get_validated_count(grade) >= get_required_count(grade)

## Tente de debloquer les musiques de [grade] (echoue si deja debloque ou Defis insuffisants) -
## rien n'est jamais "depense" ici (contrairement a Economy.try_spend), ChallengeTracker ne
## redescend jamais une fois un Defi a l'argent. N'active PAS automatiquement la musique (voir le
## commentaire de classe) - reste au joueur de la selectionner ensuite via toggle_active().
func try_unlock(grade: Grade) -> bool:
	if is_unlocked(grade):
		return false
	if not can_unlock(grade):
		return false
	_unlocked[grade] = true
	return true

## Bascule la musique de [grade] entre active et inactive (retour a la musique de base) - ne fait
## rien si non debloquee. Renvoie le nouvel etat. Une seule musique active a la fois, toutes classes
## confondues (voir BUG FIX exclusivite globale dans le commentaire de classe) : activer [grade]
## desactive d'abord toute autre classe - ShopPanel._on_classroom_music_toggle_requested rafraichit
## ensuite TOUTES les cases (_refresh_classroom_music_items), donc la case precedemment active perd
## sa bordure doree sans qu'un signal supplementaire soit necessaire ici.
func toggle_active(grade: Grade) -> bool:
	if not is_unlocked(grade):
		return false
	var new_active: bool = not bool(_active.get(grade, false))
	if new_active:
		for other_grade in _active.keys():
			_active[other_grade] = false
	_active[grade] = new_active
	music_activated.emit(grade, new_active)
	return new_active

## Remet chaque classe a "non debloquee, non active" (voir SaveManager.reset_current_account_
## progress).
func reset() -> void:
	for grade in _unlocked.keys():
		_unlocked[grade] = false
		_active[grade] = false
	## Meme famille de bug que ProfSkins.reset() (voir son commentaire, 2026-09-13) - meme raison que
	## ClassroomDecor.reset() ci-dessus (voir son commentaire) : musique_activated emis par
	## prevention, la musique de classe n'etant pas non plus encore appliquee visuellement/sonorement.
	for grade in _active.keys():
		music_activated.emit(grade, false)

func serialize() -> Dictionary:
	return {"unlocked": _unlocked.duplicate(true), "active": _active.duplicate(true)}

## Cles Dictionary : GDScript garde des int (l'enum Grade) mais JSON n'accepte que des cles
## String - meme situation deja documentee dans Economy.deserialize/ProfSkins.deserialize. Format
## {"unlocked":..., "active":...} (2026-09-06, 2e passe) - remplace l'ancien format "a plat"
## {grade: bool} de la 1ere passe, meme mecanique que ClassroomDecor.serialize/deserialize.
func deserialize(data: Dictionary) -> void:
	reset()
	var unlocked_data: Dictionary = data.get("unlocked", {})
	for key in unlocked_data.keys():
		_unlocked[int(key)] = bool(unlocked_data[key])
	var active_data: Dictionary = data.get("active", {})
	for key in active_data.keys():
		_active[int(key)] = bool(active_data[key])
	## Garde-fou (2026-09-11, voir BUG FIX exclusivite globale) : meme raison que
	## ClassroomDecor.deserialize - une sauvegarde ecrite avant ce correctif a pu enregistrer
	## plusieurs classes actives en meme temps, ne garde que la premiere rencontree.
	var kept_active := false
	for grade in _active.keys():
		if _active[grade]:
			if kept_active:
				_active[grade] = false
			else:
				kept_active = true
