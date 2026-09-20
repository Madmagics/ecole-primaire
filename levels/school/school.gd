## Verification de cablage lancee au demarrage de la scene principale : controle que chaque PNJ
## est bien branche sur les panneaux UI (paquets de questions, lecture, choix de matiere). Sert
## de filet de securite pour tout ce qui reste cable via des [connection] dans school.tscn (les
## connexions posees dans l'editeur peuvent etre perdues en reconstruisant la scene, ou ecrasees
## par un enregistrement depuis l'editeur pendant qu'un fichier a ete modifie hors-editeur - voir
## memoire projet, deja arrive plusieurs fois). N'importe quel trou est signale par push_error
## (visible dans le panneau Sortie a chaque lancement, jamais silencieux) - ce script ne modifie
## rien, il se contente de constater.
extends Node2D

@onready var _question_panel: Node = $UI/QuestionPanel
@onready var _reading_intro_panel: Node = $UI/ReadingIntroPanel
@onready var _subject_select_panel: Node = $UI/SubjectSelectPanel
## Ajoute le 2026-09-06 avec daily_limit_reached (voir plus bas) - meme raison d'etre que les 3
## autres.
@onready var _daily_limit_reached_overlay: Node = $UI/DailyLimitReachedOverlay

func _ready() -> void:
	_check_npc_wiring()

func _check_npc_wiring() -> void:
	var npcs_root := get_node_or_null("NPCs")
	if npcs_root == null:
		push_error("School: noeud 'NPCs' introuvable, verification du cablage impossible.")
		return
	for npc in npcs_root.get_children():
		var giver: Node = npc.get_node_or_null("QuestionGiverComponent")
		if giver == null:
			push_error("School: %s n'a pas de QuestionGiverComponent." % npc.name)
			continue
		_require(giver.pack_started, _question_panel.display_pack, npc.name, "pack_started -> QuestionPanel.display_pack (voir [connection] dans school.tscn)")
		_require(giver.pack_unavailable, _question_panel.show_message, npc.name, "pack_unavailable -> QuestionPanel.show_message (voir [connection] dans school.tscn)")
		_require(giver.reading_pack_started, _reading_intro_panel.open_for, npc.name, "reading_pack_started -> ReadingIntroPanel.open_for (voir [connection] dans school.tscn)")
		_require(giver.subject_selection_requested, _subject_select_panel.open_for, npc.name, "subject_selection_requested -> SubjectSelectPanel.open_for (voir [connection] dans school.tscn)")
		## Ajoutee le 2026-09-06 en tant que [connection] dans school.tscn (sens inverse : QuestionPanel
		## -> giver.resolve_pack, contrairement aux 4 ci-dessus qui vont de giver vers l'UI) : cette
		## connexion manquait depuis toujours, decouverte via le badge de limite quotidienne
		## (DailyLimitBadge, voir feedback_parental_control_checkbox.md en memoire projet) qui restait
		## bloque a 0 apres un questionnaire termine. Sans elle, resolve_pack() n'etait JAMAIS appelee :
		## EventBus.pack_completed n'etait jamais emis, donc ni les pieces (Economy.add_coins), ni les
		## statistiques (StatsTracker), ni le compteur quotidien (SaveManager) n'etaient mis a jour -
		## uniquement le texte "tu gagnes X" affiche par QuestionPanel lui-meme restait correct, ce qui
		## rendait le bug invisible a l'oeil sans verifier le solde reel.
		## RECABLEE PAR CODE le 2026-09-13 (au lieu d'un [connection] dans les 6 school*.tscn) : le
		## correctif du 09-06 avait bien restaure la connexion dans school.tscn, mais elle a disparu
		## une seconde fois d'ici le 09-13 (push_error "connexion manquante" de nouveau constate en jeu,
		## sur les 5 PNJ, alors que le texte du fichier .tscn local semblait pourtant correct - tres
		## probablement un enregistrement de scene depuis l'editeur qui a ecrase le fichier avec une
		## version anterieure, exactement le risque documente en tete de ce script). Meme parade que
		## EventBus.subject_selected (voir question_giver_component.gd._ready()) : une connexion posee
		## par CODE ici, verifiee/reetablie a chaque lancement de School, ne peut plus se perdre au
		## rechargement/enregistrement d'une scene - contrairement a un [connection] dans le .tscn.
		## is_connected() en garde-fou : ne re-connecte pas si school.tscn a deja la connexion (aucun
		## doublon), ne fait rien de plus qu'avant si elle y est encore.
		if not _question_panel.pack_completed.is_connected(giver.resolve_pack):
			_question_panel.pack_completed.connect(giver.resolve_pack)
		_require(_question_panel.pack_completed, giver.resolve_pack, npc.name, "pack_completed -> resolve_pack (cable par code ci-dessus depuis le 2026-09-13, ne devrait plus jamais manquer)")
		## Ajoutee le 2026-09-06, 2e passe (retour utilisateur : popup reduite au lieu de la
		## fenetre complete de QuestionPanel quand la limite quotidienne est atteinte) - voir
		## QuestionGiverComponent.daily_limit_reached et ui/hud/daily_limit_reached_overlay.gd.
		_require(giver.daily_limit_reached, _daily_limit_reached_overlay.open, npc.name, "daily_limit_reached -> DailyLimitReachedOverlay.open (voir [connection] dans school.tscn)")
		## Celui-ci est cable par code (voir question_giver_component.gd._ready), pas par une
		## [connection] de scene - le verifier ici aussi, au cas ou quelqu'un retire un jour
		## cet appel par erreur en modifiant le script.
		_require(EventBus.subject_selected, giver.start_pack_for_subject, npc.name, "EventBus.subject_selected -> start_pack_for_subject (cable par code, voir question_giver_component.gd)")

func _require(source_signal: Signal, target: Callable, npc_name: String, label: String) -> void:
	if not source_signal.is_connected(target):
		push_error("School: connexion manquante pour %s : %s" % [npc_name, label])
