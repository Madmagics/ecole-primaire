## Skins de "prof" possedes/actifs par classe (voir ProfSkinCatalog pour le catalogue de textures,
## et ui/shop/prof_skin_item.gd pour l'achat/l'equipement en boutique - 5 nouveaux onglets, un par
## classe, 10 skins par onglet sur 2 lignes de 5, retour utilisateur 2026-08-29). Autoload
## volontairement minimal, meme principe qu'Economy/CardCollection/StatsTracker : pas de logique
## de prix ici au-dela de SKIN_PRICE (voir Economy pour le portefeuille reel), juste l'etat "quels
## index sont debloques" et "lequel est actif" pour chacune des 5 classes.
extends Node

const Grade = GradeLevel.Grade

## Prix d'un skin, en monnaie de la classe concernee (voir GradeLevel.get_rarity) - identique pour
## les 5 classes et les 10 skins, pas de bareme progressif pour l'instant (facile a differencier
## plus tard si besoin, une seule constante a eclater en dictionnaire). Baisse de 150 a 50
## le 2026-08-29 (meme jour, retour utilisateur).
const SKIN_PRICE := 50

## grade -> Array[int] des index de skin debloques pour cette classe. L'index 0 (skin deja porte
## par chaque PNJ avant l'introduction de ce systeme, voir school.tscn) est TOUJOURS debloque de
## depart, voir reset().
var _unlocked: Dictionary = {
	Grade.CP: [0],
	Grade.CE1: [0],
	Grade.CE2: [0],
	Grade.CM1: [0],
	Grade.CM2: [0],
}
## grade -> index du skin actuellement porte par le PNJ de cette classe.
var _active: Dictionary = {
	Grade.CP: 0,
	Grade.CE1: 0,
	Grade.CE2: 0,
	Grade.CM1: 0,
	Grade.CM2: 0,
}

## Emis a chaque changement de skin actif (achat+equipement automatique via try_unlock, ou
## reequipement gratuit d'un skin deja possede via set_active) : ProfVisual ecoute ce signal pour
## rafraichir son sprite sans recharger la scene.
signal skin_activated(grade: Grade, skin_index: int)

func is_unlocked(grade: Grade, skin_index: int) -> bool:
	return (_unlocked.get(grade, []) as Array).has(skin_index)

func get_active_skin(grade: Grade) -> int:
	return int(_active.get(grade, 0))

## Tente d'acheter [skin_index] pour [grade] (echoue si deja possede ou solde insuffisant), et
## l'equipe immediatement en cas de succes - une case de boutique achete ET equipe en un clic
## (plus la popup de confirmation habituelle), pas une etape supplementaire.
func try_unlock(grade: Grade, skin_index: int) -> bool:
	if is_unlocked(grade, skin_index):
		return false
	if not Economy.try_spend(GradeLevel.get_rarity(grade), SKIN_PRICE):
		return false
	(_unlocked[grade] as Array).append(skin_index)
	set_active(grade, skin_index)
	return true

## Reequipe un skin deja possede - gratuit, pas de confirmation cote UI (voir
## ProfSkinItem._on_pressed) : ne fait rien si [skin_index] n'est pas debloque.
func set_active(grade: Grade, skin_index: int) -> void:
	if not is_unlocked(grade, skin_index):
		return
	_active[grade] = skin_index
	skin_activated.emit(grade, skin_index)

## Remet chaque classe a son seul skin de depart (voir SaveManager.reset_progress).
func reset() -> void:
	for grade in _unlocked.keys():
		_unlocked[grade] = [0]
		_active[grade] = 0

func serialize() -> Dictionary:
	return {"unlocked": _unlocked.duplicate(true), "active": _active.duplicate(true)}

## Cles Dictionary : GDScript garde des int (l'enum Grade) mais JSON n'accepte que des cles
## String - JSON.stringify les convertit automatiquement en "0", "4"... meme situation deja
## documentee dans Economy.deserialize, se reconvertit sans ambiguite avec int().
func deserialize(data: Dictionary) -> void:
	reset()
	var unlocked_data: Dictionary = data.get("unlocked", {})
	for key in unlocked_data.keys():
		var grade: int = int(key)
		var indices: Array = unlocked_data[key]
		var current: Array = _unlocked.get(grade, [0])
		for idx in indices:
			if not current.has(int(idx)):
				current.append(int(idx))
		_unlocked[grade] = current
	var active_data: Dictionary = data.get("active", {})
	for key in active_data.keys():
		_active[int(key)] = int(active_data[key])
	## BUG FIX (2026-09-11, retour utilisateur : "a chaque debut de jeu, la tenue des profs choisis
	## n'est pas conservee, on revient systematiquement aux tenues de base pour tous les profs") :
	## contrairement a set_active(), cette fonction ne prevenait jamais ProfVisual du changement.
	## Elle est appelee par SaveManager.login()/_apply_account_to_runtime(), qui tourne APRES que
	## les ProfVisual de school.tscn aient deja fait leur premier _apply_active_skin() a leur
	## _ready() (WelcomePanel vit dans la MEME scene que les PNJ, voir son commentaire de classe :
	## il ne fait qu'un hide() au login, aucun rechargement de scene) - a ce moment-la, _active
	## valait encore {CP:0, ..., CM2:0} (etat par defaut avant tout chargement), donc chaque
	## ProfVisual affichait deja le skin de base. deserialize() mettait ensuite _active a jour EN
	## MEMOIRE correctement (la sauvegarde elle-meme n'a jamais ete perdue), mais sans emettre
	## skin_activated, aucun sprite ne se rafraichissait pour refleter l'etat charge - d'ou
	## l'impression que le skin choisi "ne se souvenait pas" a chaque lancement, alors qu'il etait
	## bien present sur le disque. Boucle sur _active.keys() (les 5 classes) plutot que
	## active_data.keys() : couvre aussi une classe absente de la sauvegarde (remise a 0 par
	## reset() ci-dessus) si jamais un ProfVisual affichait deja autre chose.
	for grade in _active.keys():
		skin_activated.emit(grade, _active[grade])
