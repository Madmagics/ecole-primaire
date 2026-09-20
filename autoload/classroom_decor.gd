## Decors de classe (nouveaux environnements/decors pour chaque classe) debloques par les Defis
## valides plutot que par les pieces d'Economy (2026-09-06, retour utilisateur : "je veux me
## servir des succes remportés comme monnaie pour debloquer de nouveaux environnements de classe
## (nouveau decor) achetable si les succes sont validés (5 pour le cp et 7 pour les autres) on
## creera 5 cases a acheter" - voir ui/shop/classroom_decor_item.gd pour la case de boutique et
## shop_panel.gd pour le nouvel onglet "Succes"). Autoload volontairement minimal, meme principe
## qu'Economy/ProfSkins : uniquement l'etat "quelles classes sont debloquees/actives", aucune
## logique de PNJ/decor ici (le decor visuel lui-meme, et son application a school.tscn, restent a
## construire plus tard - cet autoload ne fait que suivre l'etat "achete/pas achete" et "applique/
## pas applique").
##
## Une classe se debloque quand la TOTALITE de ses Defis (voir ChallengeTracker) est au palier
## argent (SILVER_GOAL) - pas un nombre fixe code en dur : QuestionBankScanner.get_available_
## subjects(grade) donne deja 5 matieres pour le CP et 7 pour CE1-CM2 (francais scinde en
## grammaire/conjugaison/orthographe, voir son commentaire de classe), exactement les chiffres
## cites par l'utilisateur - get_required_count() lit donc cette liste plutot que de dupliquer 5/7
## en dur.
##
## SEUIL REVU le 2026-09-18 (retour utilisateur, apres validation de la maquette de barre de
## jalons de la fenetre Succes - voir project_success_milestone_bar en memoire projet) : le
## palier de deblocage passe d'OR (GOLD_GOAL) a ARGENT (SILVER_GOAL) - la musique de classe
## (ClassroomMusic) prend la place du decor au palier BRONZE, et un nouveau palier OR accueille
## une future recompense "coupe" pas encore implementee.
##
## Selection/desactivation (2026-09-06, 2e passe, retour utilisateur : "afin de pouvoir
## selectionner le decor de classe de base ou la musique originale: selectionner une case fera
## changer le decor ou la musique, recliquer sur une case active deselectionnera celle si et
## retournera le decor ou la musique de base") : une classe debloquee n'est pas forcement ACTIVE -
## _active[grade] suit si le decor debloque de cette classe est actuellement applique (true) ou si
## la classe est revenue a son decor de base (false, etat par defaut meme juste apres deblocage -
## debloquer n'active pas automatiquement, un 2e clic est necessaire, voir
## ClassroomDecorItem._on_pressed). toggle_active() bascule entre les 2, jamais de "choix parmi
## plusieurs" ici (contrairement a ProfSkins, un seul decor par classe pour l'instant) - juste
## actif/inactif.
##
## BUG FIX exclusivite globale (2026-09-11, retour utilisateur : "actuellement on peut selectionner
## plusieurs cases. il faut pouvoir selectionner seulement une seule musique ou une seule scene, ou
## la deselectionner si on veut celui de base") : _active etait un bool INDEPENDANT par classe, donc
## rien n'empechait d'activer le decor du CP ET celui du CE1 en meme temps (plusieurs cases en
## bordure doree simultanement dans l'onglet Succes, alors qu'un seul decor de classe doit etre
## applique a la fois, toutes classes confondues). toggle_active() desactive desormais explicitement
## toute autre classe avant d'activer celle demandee - meme resultat qu'un groupe de boutons radio
## avec possibilite de tout deselectionner.
##
## MIS A JOUR le 2026-09-20 (retour utilisateur : "quand je selectionne la classe cp dans la
## boutique on ne passe pas sur la scene school1, la scene affichee reste school") : l'application
## visuelle mentionnee comme "a construire plus tard" ci-dessus est desormais cablee - voir
## get_active_scene_path() plus bas, ecoutee par school.gd (seul abonne de decor_activated,
## voir sa doc mise a jour egalement).
extends Node

const Grade = GradeLevel.Grade

## Scene affichee quand aucun decor de classe n'est actif (voir get_active_scene_path() plus bas).
const BASE_SCENE_PATH := "res://levels/school/school.tscn"

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

## Emis a chaque bascule active/inactive (voir toggle_active) - ecoute par school.gd depuis le
## 2026-09-20 (get_active_scene_path() ci-dessous + school.gd._on_classroom_decor_activated) pour
## basculer effectivement vers la scene de decor de la classe active.
signal decor_activated(grade: Grade, active: bool)

func is_unlocked(grade: Grade) -> bool:
	return bool(_unlocked.get(grade, false))

## Un decor NON debloque n'est jamais actif, quoi que _active contienne (garde-fou, ne devrait de
## toute facon jamais arriver - toggle_active() refuse deja de s'activer si non debloque).
func is_active(grade: Grade) -> bool:
	return is_unlocked(grade) and bool(_active.get(grade, false))

## Chemin de la scene a afficher compte tenu du decor de classe actuellement actif (_active
## ci-dessus, un seul actif a la fois) - BASE_SCENE_PATH si aucun decor actif, sinon
## GradeLevel.get_decor_scene_path() de la classe active. Ajoutee le 2026-09-20 (voir la note de
## mise a jour en tete de fichier) - appelee par school.gd au demarrage et a chaque
## decor_activated pour appliquer/rattraper le bon affichage.
func get_active_scene_path() -> String:
	for grade in _active.keys():
		if _active[grade]:
			return GradeLevel.get_decor_scene_path(grade)
	return BASE_SCENE_PATH

## Nombre de Defis actuellement a l'argent (SILVER_GOAL, voir ChallengeTracker) pour [grade], sur
## le total requis (voir get_required_count) - affiche en "X/Y" sur la case de boutique.
func get_validated_count(grade: Grade) -> int:
	var count := 0
	for subject in QuestionBankScanner.get_available_subjects(grade):
		if ChallengeTracker.get_count(grade, subject) >= ChallengeTracker.SILVER_GOAL:
			count += 1
	return count

## Nombre de Defis a valider (a l'argent) pour debloquer le decor de [grade] - TOUS les Defis de
## la classe, voir le commentaire de classe.
func get_required_count(grade: Grade) -> int:
	return QuestionBankScanner.get_available_subjects(grade).size()

func can_unlock(grade: Grade) -> bool:
	return get_validated_count(grade) >= get_required_count(grade)

## Tente de debloquer le decor de [grade] (echoue si deja debloque ou Defis insuffisants) - rien
## n'est jamais "depense" ici (contrairement a Economy.try_spend), ChallengeTracker ne redescend
## jamais une fois un Defi a l'argent. N'active PAS automatiquement le decor (voir le commentaire
## de classe) - reste au joueur de le selectionner ensuite via toggle_active().
func try_unlock(grade: Grade) -> bool:
	if is_unlocked(grade):
		return false
	if not can_unlock(grade):
		return false
	_unlocked[grade] = true
	return true

## Bascule le decor de [grade] entre actif et inactif (retour au decor de base) - ne fait rien si
## non debloque. Renvoie le nouvel etat. Un seul decor actif a la fois, toutes classes confondues
## (voir BUG FIX exclusivite globale dans le commentaire de classe) : activer [grade] desactive
## d'abord toute autre classe - ShopPanel._on_classroom_decor_toggle_requested rafraichit ensuite
## TOUTES les cases (_refresh_classroom_decor_items), donc la case precedemment active perd sa
## bordure doree sans qu'un signal supplementaire soit necessaire ici.
func toggle_active(grade: Grade) -> bool:
	if not is_unlocked(grade):
		return false
	var new_active: bool = not bool(_active.get(grade, false))
	if new_active:
		for other_grade in _active.keys():
			_active[other_grade] = false
	_active[grade] = new_active
	decor_activated.emit(grade, new_active)
	return new_active

## Remet chaque classe a "non debloquee, non active" (voir SaveManager.reset_current_account_
## progress).
func reset() -> void:
	for grade in _unlocked.keys():
		_unlocked[grade] = false
		_active[grade] = false
	## Meme famille de bug que ProfSkins.reset() (voir son commentaire, 2026-09-13) : le decor visuel
	## lui-meme n'est pas encore construit (voir le commentaire de classe), donc aucun symptome
	## visible a ce jour - decor_activated est tout de meme emis ici par prevention, pour qu'un futur
	## affichage de decor (equivalent de ProfVisual) n'hérite pas silencieusement du meme piege.
	for grade in _active.keys():
		decor_activated.emit(grade, false)

func serialize() -> Dictionary:
	return {"unlocked": _unlocked.duplicate(true), "active": _active.duplicate(true)}

## Cles Dictionary : GDScript garde des int (l'enum Grade) mais JSON n'accepte que des cles
## String - meme situation deja documentee dans Economy.deserialize/ProfSkins.deserialize. Format
## {"unlocked":..., "active":...} (2026-09-06, 2e passe) - remplace l'ancien format \"a plat\"
## {grade: bool} de la 1ere passe, meme mecanique que ProfSkins.serialize/deserialize.
func deserialize(data: Dictionary) -> void:
	reset()
	var unlocked_data: Dictionary = data.get("unlocked", {})
	for key in unlocked_data.keys():
		_unlocked[int(key)] = bool(unlocked_data[key])
	var active_data: Dictionary = data.get("active", {})
	for key in active_data.keys():
		_active[int(key)] = bool(active_data[key])
	## Garde-fou (2026-09-11, voir BUG FIX exclusivite globale) : une sauvegarde ecrite avant ce
	## correctif a pu enregistrer plusieurs classes actives en meme temps - ne garde que la premiere
	## rencontree (ordre de _active.keys(), stable - un Dictionary GDScript preserve l'ordre
	## d'insertion) et desactive les eventuelles autres, plutot que de propager un etat invalide.
	var kept_active := false
	for grade in _active.keys():
		if _active[grade]:
			if kept_active:
				_active[grade] = false
			else:
				kept_active = true
