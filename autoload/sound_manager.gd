## Gestionnaire audio global : bruitages (SFX) de l'interface ET musique de fond.
##
## === Bruitages (Sfx) ===
## Un seul AudioStreamPlayer non positionnel portant un AudioStreamPolyphonic (voir doc officielle
## docs.godotengine.org/en/4.7/classes/class_audiostreampolyphonic.html) plutot qu'un pool de
## plusieurs AudioStreamPlayer : AudioStreamPlaybackPolyphonic.play_stream() lance chaque son sur
## une voie interne separee (jusqu'a POLYPHONY simultanees) SANS jamais couper les sons deja en
## cours - contrairement a changer AudioStreamPlayer.stream directement, qui "stops all currently
## playing sounds" (meme doc). Necessaire ici : un clic de bouton peut survenir pendant qu'un son
## "bonne reponse" est encore en train de jouer, les deux doivent s'entendre.
##
## Sequence d'amorcage obligatoire (confirmee via forum.godotengine.org, la doc officielle ne
## donne pas d'exemple complet) : stream = AudioStreamPolyphonic AVANT d'appeler play() une
## premiere fois (sans quoi get_stream_playback() renvoie null), get_stream_playback() ensuite
## seulement. Ce play() initial ne joue aucun son (l'AudioStreamPolyphonic lui-meme est silencieux
## tant qu'aucun play_stream() n'est appele dessus) - il active seulement le moteur de lecture.
##
## Clic generique (Sfx.CLICK) branche automatiquement sur TOUS les Button du jeu, sans toucher
## chaque panneau UI un par un : _on_node_added ecoute SceneTree.node_added (emis individuellement
## pour CHAQUE noeud d'une sous-scene instanciee au runtime, pas seulement sa racine - confirme
## dans le code source de Node::_propagate_enter_tree, godotengine/godot) et connecte le "pressed"
## de tout Button (CrateItem, ProfSkinItem, MenuToggleButton, boutons standards... tous verifies
## "extends Button" dans ce projet) a Sfx.CLICK des son entree dans l'arbre. Une case deja
## instanciee puis simplement masquee/reaffichee (hide()/show()) ne re-declenche jamais
## node_added (elle ne quitte pas l'arbre) - is_connected() ci-dessous protege seulement contre
## un meme noeud notifie deux fois par erreur, pas un mecanisme de re-connexion.
##
## === Musique de fond ===
## 2026-09-04 : un seul morceau (assets/audio/music/lofi.ogg, Ogg Vorbis ~41 kb/s stereo, choisi
## par l'utilisateur apres plusieurs essais de compression - voir project_sound_and_music.md) joue
## en boucle en permanence des le lancement, sans gestion par scene : le jeu est un ecran unique
## (voir CLASSE2.0, project_classe2_single_screen_pivot en memoire), pas besoin de changer de
## musique en changeant d'ecran ni de gerer une transition. Boucle via AudioStreamOggVorbis.loop
## (propriete du stream lui-meme, positionnable en code - voir doc officielle
## class_audiostreamoggvorbis.html) plutot qu'un signal "finished" reconnecte a la main : plus
## simple, et sans micro-coupure au point de bouclage.
##
## Musique de classe par compte (2026-09-06, retour utilisateur : "on laissera aussi la musique de
## base pour l intro et on passera a la musique debloquee et choisie par le compte sil y en a
## une") : l'ecran d'accueil (personne connecte) garde TOUJOURS lofi.ogg - _resolve_music_path()
## ci-dessous ne consulte ClassroomMusic que si SaveManager.current_account_id n'est pas vide.
## Une fois connecte, la musique de la premiere classe a la fois debloquee ET activee (voir
## ClassroomMusic.is_active) remplace la musique de base, SI son fichier existe reellement -
## _CLASSROOM_MUSIC_PATHS ci-dessous n'a aucun fichier fourni pour l'instant ("que je
## provisionnerai plus tard", voir classroom_music.gd) : fallback silencieux vers lofi.ogg tant que
## c'est le cas, meme principe que les Sfx non fournis (voir play()). Reagit a account_logged_in/
## account_logged_out (SaveManager) et music_activated (ClassroomMusic) via _refresh_music().
extends Node

enum Sfx {
	CLICK,
	CORRECT,
	WRONG,
	CARD_REVEAL,
	PACK_REWARD,
	PURCHASE,
	## Pack termine SANS FAUTE (voir ChallengeTracker.register_success, appele depuis
	## QuestionPanel._show_result()) - distinct de PACK_REWARD ci-dessus (qui joue des 50%
	## de bonnes reponses) : signale un evenement different, la progression d'un Defi.
	CHALLENGE_SUCCESS,
}

## Sons simultanes maximum (voir AudioStreamPolyphonic.polyphony) - tres large marge par rapport
## au besoin reel de ce jeu (jamais plus de 2-3 sons attendus en meme temps).
const _POLYPHONY := 16

const _STREAM_PATHS: Dictionary[Sfx, String] = {
	Sfx.CLICK: "res://assets/audio/sfx/click.wav",
	Sfx.CORRECT: "res://assets/audio/sfx/correct.wav",
	Sfx.WRONG: "res://assets/audio/sfx/wrong.wav",
	Sfx.CARD_REVEAL: "res://assets/audio/sfx/card_reveal.wav",
	Sfx.PACK_REWARD: "res://assets/audio/sfx/pack_reward.wav",
	Sfx.PURCHASE: "res://assets/audio/sfx/purchase.wav",
	## Fichier pas encore fourni (2026-09-05) : play() ci-dessous ne fait rien silencieusement
	## tant qu'il est absent (meme comportement que les autres Sfx avant l'ajout de leur son
	## definitif, voir commentaire de play()) - a deposer ici quand le son sera choisi.
	Sfx.CHALLENGE_SUCCESS: "res://assets/audio/sfx/challenge_success.wav",
}

const _MUSIC_PATH := "res://assets/audio/music/lofi.ogg"
## En retrait par rapport aux bruitages (0 dB) pour rester un fond discret, pas un concurrent des
## sons d'interaction - valeur de depart a l'oreille, facile a retoucher ici seul.
const _MUSIC_VOLUME_DB := -10.0

## Un fichier par classe (voir commentaire de classe, "Musique de classe par compte") - convention
## de nommage identique a GradeLevel.get_coin_icon_path() (get_label(grade) directement, ex.
## "classe-CP.ogg"). Aucun fichier n'existe encore sur le disque : _refresh_music() verifie
## ResourceLoader.exists() avant d'utiliser une de ces entrees.
const _CLASSROOM_MUSIC_PATHS: Dictionary[GradeLevel.Grade, String] = {
	GradeLevel.Grade.CP: "res://assets/audio/music/classe-CP.ogg",
	GradeLevel.Grade.CE1: "res://assets/audio/music/classe-CE1.ogg",
	GradeLevel.Grade.CE2: "res://assets/audio/music/classe-CE2.ogg",
	GradeLevel.Grade.CM1: "res://assets/audio/music/classe-CM1.ogg",
	GradeLevel.Grade.CM2: "res://assets/audio/music/classe-CM2.ogg",
}

var _streams: Dictionary[Sfx, AudioStream] = {}
var _playback: AudioStreamPlaybackPolyphonic

## Cree une seule fois dans _start_music(), reutilise par _refresh_music() a chaque changement de
## piste (swap du stream plutot que recreer un AudioStreamPlayer a chaque fois).
var _music_player: AudioStreamPlayer
## Chemin de la piste actuellement chargee sur _music_player - permet a _refresh_music() de ne
## rien faire (pas de redemarrage audible depuis le debut du morceau) si la piste resolue est deja
## celle en cours de lecture.
var _current_music_path: String = ""

func _ready() -> void:
	for sfx_id: Sfx in _STREAM_PATHS:
		var path: String = _STREAM_PATHS[sfx_id]
		if ResourceLoader.exists(path):
			_streams[sfx_id] = load(path)

	var player := AudioStreamPlayer.new()
	var polyphonic_stream := AudioStreamPolyphonic.new()
	polyphonic_stream.polyphony = _POLYPHONY
	player.stream = polyphonic_stream
	## Bus "Bruitages" (voir default_bus_layout.tres) : volume reglable independamment de la
	## musique depuis SectionConfig (voir SaveManager.sfx_volume).
	player.bus = "Bruitages"
	add_child(player)
	player.play()
	_playback = player.get_stream_playback() as AudioStreamPlaybackPolyphonic

	get_tree().node_added.connect(_on_node_added)

	_start_music()
	## Reagit a une connexion/deconnexion de compte et a l'activation/desactivation d'une musique
	## de classe (voir commentaire de classe, "Musique de classe par compte") - les 3 branches
	## d'entree de _refresh_music().
	SaveManager.account_logged_in.connect(func(_profile: Dictionary) -> void: _refresh_music())
	SaveManager.account_logged_out.connect(_refresh_music)
	ClassroomMusic.music_activated.connect(func(_grade: GradeLevel.Grade, _active: bool) -> void: _refresh_music())

## Joue le bruitage [sfx_id]. Ne fait rien silencieusement si le fichier correspondant est
## absent (voir _STREAM_PATHS) - permet d'appeler play() partout dans le code sans jamais
## planter, meme avant que tous les sons definitifs soient integres.
func play(sfx_id: Sfx) -> void:
	var stream: AudioStream = _streams.get(sfx_id)
	if stream == null or _playback == null:
		return
	_playback.play_stream(stream)

func _on_node_added(node: Node) -> void:
	if node is Button and not node.pressed.is_connected(_on_button_pressed):
		node.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	play(Sfx.CLICK)

## Cree le lecteur de musique de fond (reutilise ensuite par _refresh_music() a chaque changement
## de piste) et lance la piste initiale - l'ecran d'accueil n'a personne de connecte a cet instant
## (voir SaveManager, current_account_id vide au demarrage), _resolve_music_path() renvoie donc
## toujours lofi.ogg ici.
func _start_music() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.volume_db = _MUSIC_VOLUME_DB
	## Bus "Musique" (voir default_bus_layout.tres) : volume reglable independamment des
	## bruitages depuis SectionConfig (voir SaveManager.music_volume).
	_music_player.bus = "Musique"
	add_child(_music_player)
	_refresh_music()

## Determine quelle piste doit jouer maintenant (voir commentaire de classe, "Musique de classe par
## compte") : la musique de base tant que personne n'est connecte, sinon la musique de la premiere
## classe a la fois debloquee ET activee pour le compte connecte (ClassroomMusic.is_active) DONT le
## fichier existe reellement - plusieurs classes peuvent en theorie etre actives a la fois sur un
## meme compte (ClassroomMusic n'impose aucune exclusivite entre classes), la premiere trouvee dans
## l'ordre CP->CM2 (ordre d'insertion de _CLASSROOM_MUSIC_PATHS, preserve par Dictionary - voir doc
## officielle class_dictionary.html) est utilisee : choix arbitraire mais stable, en l'absence d'un
## concept de "classe actuellement affichee" dans cette scene a ecran unique (voir
## project_classe2_single_screen_pivot en memoire).
func _resolve_music_path() -> String:
	if not SaveManager.current_account_id.is_empty():
		for grade: GradeLevel.Grade in _CLASSROOM_MUSIC_PATHS:
			var path: String = _CLASSROOM_MUSIC_PATHS[grade]
			if ClassroomMusic.is_active(grade) and ResourceLoader.exists(path):
				return path
	return _MUSIC_PATH

## Recharge _music_player si la piste resolue par _resolve_music_path() a change - ne fait rien
## silencieusement si le fichier resolu est absent (meme raisonnement que play() ci-dessus pour les
## Sfx) ou si c'est deja la piste en cours (evite un redemarrage audible depuis le debut du
## morceau a chaque signal recu, meme si la piste effective n'a pas change).
func _refresh_music() -> void:
	var path := _resolve_music_path()
	if path == _current_music_path or not ResourceLoader.exists(path):
		return
	var stream := load(path) as AudioStreamOggVorbis
	stream.loop = true
	_music_player.stream = stream
	_music_player.play()
	_current_music_path = path
