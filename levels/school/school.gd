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

## Chemin de la scene actuellement appliquee pour Background/Decor (voir _swap_decor_from()) -
## initialise a scene_file_path (soi-meme = school.tscn = decor de base) : ce script tourne SUR
## school.tscn, seule scene jamais executee comme main_scene (voir ClassroomDecor.BASE_SCENE_PATH).
var _current_decor_scene_path: String = ""

func _ready() -> void:
	_current_decor_scene_path = scene_file_path
	_check_npc_wiring()
	## Ajoute le 2026-09-20 (retour utilisateur : "quand je selectionne la classe cp dans la
	## boutique on ne passe pas sur la scene school1, la scene affichee reste school", puis
	## precision : "school doit rester la reference avec tous les items/menu/npc etc, chaque school
	## variant n'influe que sur les decors et le fond") : ClassroomDecor.decor_activated n'etait
	## ecoute nulle part (voir sa doc). PREMIER ESSAI avec get_tree().change_scene_to_file() -
	## REVERTE dans l'heure (voir le commentaire de classe de classroom_decor.gd) : ce jeu n'a plus
	## de scene "de niveau" separee de l'UI/session, un changement de scene ejectait le joueur du
	## jeu et cassait la deconnexion serveur propre. _swap_decor_from() ci-dessous n'echange QUE les
	## noeuds Background/Decor, jamais la scene entiere : NPCs/UI/camera restent exactement ceux de
	## CETTE instance de School, jamais recrees ni interrompus.
	ClassroomDecor.decor_activated.connect(_on_classroom_decor_activated)
	_apply_active_classroom_decor()

## Reagit a toute bascule (voir ClassroomDecor.decor_activated) - _grade non utilise (on relit
## l'etat complet via get_active_scene_path(), plus simple que de raisonner sur le delta).
func _on_classroom_decor_activated(_grade: GradeLevel.Grade, _active: bool) -> void:
	_apply_active_classroom_decor()

## Applique le Background/Decor correspondant au decor de classe actuellement actif, seulement si
## different de ce qui est deja affiche (_current_decor_scene_path) - evite un echange inutile
## (cas normal : aucun decor actif, deja sur la scene de base).
func _apply_active_classroom_decor() -> void:
	var target_path := ClassroomDecor.get_active_scene_path()
	if target_path == _current_decor_scene_path:
		return
	_swap_decor_from(target_path)
	_current_decor_scene_path = target_path

## Charge [donor_path] (school.tscn ou school1-5.tscn - jamais joue directement, voir
## GradeLevel.get_decor_scene_path()), lui prend UNIQUEMENT ses noeuds "Background"/"Decor" et
## jette le reste (NPCs/UI/camera dupliques, jamais utilises). Ne touche jamais a NPCs/UI/camera de
## CETTE scene : ils restent ceux de school.tscn, la reference unique demandee par Steve
## (2026-09-20).
##
## CORRIGE le 2026-09-20 (retour utilisateur : "les decors sprite2d disparaissent partiellement de
## meme que les npc profs, certains restent present") - 2 bugs dans la 1ere version :
## 1. Position dans l'arbre : l'ancien code reinserait Background PUIS reutilisait un index de
##    Decor capture AVANT cette reinsertion - or reinserer Background decale tous les index
##    suivants, donc Decor atterrissait apres NPCs au lieu d'avant. A z_index egal, l'ordre de
##    dessin suit l'ordre dans l'arbre (confirme par project_classe2_single_screen_pivot.md en
##    memoire projet) : Decor dessine APRES les PNJ passait donc devant eux, masquant
##    partiellement les profs (et certains decors selon leur z_index). Corrige en capturant une
##    ANCRE (le noeud qui suivait immediatement chaque noeud remplace, ex. NPCs pour Decor) avant
##    toute modification, puis en reinserant juste avant la position COURANTE (relue en direct) de
##    cette ancre - insensible aux decalages d'index provoques par les etapes precedentes.
## 2. Owner : remove_child() ne nettoie PAS owner tout seul ici (verifie dans le code source de
##    Godot 4.7, node.cpp - contrairement a ce que la doc laissait penser, ce nettoyage automatique
##    ne s'applique qu'aux noeuds qui QUITTENT REELLEMENT l'arbre de scene active ; donor_root
##    n'y a jamais ete ajoute) : Background/Decor gardaient donc l'ancien donor_root comme owner,
##    d'ou l'avertissement Godot "will make owner 'School' inconsistent" a chaque bascule (visible
##    dans le panneau Sortie). Owner n'affecte pas le rendu (ce n'est pas la cause du bug 1
##    ci-dessus), mais reste incorrect a laisser trainer - nettoye desormais explicitement via
##    _clear_owner_recursive().
func _swap_decor_from(donor_path: String) -> void:
	var donor_packed: PackedScene = load(donor_path)
	if donor_packed == null:
		push_error("School: impossible de charger %s (changement de decor de classe annule)." % donor_path)
		return
	var donor_root := donor_packed.instantiate()
	var donor_background := donor_root.get_node_or_null("Background")
	var donor_decor := donor_root.get_node_or_null("Decor")
	if donor_background == null or donor_decor == null:
		push_error("School: %s n'a pas de noeud Background/Decor, changement de decor annule." % donor_path)
		donor_root.queue_free()
		return

	var old_background := get_node_or_null("Background")
	var old_decor := get_node_or_null("Decor")
	## Ancres capturees AVANT toute modification (voir le commentaire de fonction, point 1) - le
	## noeud qui suit immediatement chaque noeud remplace, pour reinserer par relation ("juste
	## avant X") plutot que par un index numerique qui se decale a chaque ajout/retrait.
	var background_anchor := _next_sibling_of(old_background)
	var decor_anchor := _next_sibling_of(old_decor)

	if old_background:
		remove_child(old_background)
		old_background.queue_free()
	if old_decor:
		remove_child(old_decor)
		old_decor.queue_free()

	donor_root.remove_child(donor_background)
	_clear_owner_recursive(donor_background)
	add_child(donor_background)
	if is_instance_valid(background_anchor):
		move_child(donor_background, background_anchor.get_index())
	else:
		move_child(donor_background, 0)

	donor_root.remove_child(donor_decor)
	_clear_owner_recursive(donor_decor)
	add_child(donor_decor)
	if is_instance_valid(decor_anchor):
		move_child(donor_decor, decor_anchor.get_index())
	else:
		move_child(donor_decor, get_child_count() - 1)

	## Position des PNJ (2026-09-20, retour utilisateur : "le placement des npj peut il etre
	## modifie sur les scenes school1+") : contrairement a Background/Decor ci-dessus, les noeuds
	## NPCs de CETTE scene ne sont JAMAIS remplaces (Steve garde school.tscn comme reference unique
	## pour le cablage/menu/PNJ, voir le commentaire de classe) - seule leur POSITION est reprise du
	## noeud NPCs du donneur, par nom (NPC_CP/NPC_CE1/...), pour permettre de repositionner les PNJ
	## par classe (ex. autour d'une cour de recre pour CP) sans dupliquer script/signaux/visuel.
	## Fonctionne aussi bien pour appliquer une position specifique a une classe que pour revenir a
	## la position de base (le "donneur" est alors school.tscn lui-meme, charge en frais - ses
	## propres positions de NPC_* SONT les positions de base).
	var donor_npcs := donor_root.get_node_or_null("NPCs")
	var live_npcs := get_node_or_null("NPCs")
	if donor_npcs and live_npcs:
		for live_npc in live_npcs.get_children():
			var live_npc_2d := live_npc as Node2D
			var donor_npc_2d := donor_npcs.get_node_or_null(NodePath(live_npc.name)) as Node2D
			if live_npc_2d and donor_npc_2d:
				live_npc_2d.position = donor_npc_2d.position

	donor_root.queue_free()

## Renvoie le noeud juste apres [node] parmi ses freres actuels, ou null si [node] est nul, deja
## dernier, ou introuvable - aide de _swap_decor_from() ci-dessus.
func _next_sibling_of(node: Node) -> Node:
	if node == null:
		return null
	var parent := node.get_parent()
	if parent == null:
		return null
	var next_index := node.get_index() + 1
	if next_index >= parent.get_child_count():
		return null
	return parent.get_child(next_index)

## Nettoie recursivement owner (node + tous ses descendants) - necessaire avant de rattacher un
## sous-arbre issu d'une scene instanciee separement (voir le commentaire de fonction, point 2) :
## sans ca, owner continue de pointer vers l'ancien donor_root (jamais ajoute a l'arbre reel, donc
## jamais nettoye automatiquement), ce que Godot signale par un avertissement "owner inconsistent".
func _clear_owner_recursive(node: Node) -> void:
	node.owner = null
	for child in node.get_children():
		_clear_owner_recursive(child)

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
