## Petite fenetre de confirmation ouverte par l'icone "Quitter" tout en bas de la colonne de
## gauche (voir GameMenuPanel.quit_overlay_path/IconDock/QuitterButton) OU par la touche Echap
## quand aucun autre menu/fenetre du jeu n'est ouvert (2026-09-04, retour utilisateur : "de meme la
## touche echap quand aucun menu n est ouvert doit permettre de faire aussi apparaitre ce nouveau
## menu"). Propose deux actions ("Se deconnecter" -> SaveManager.logout(), qui ramene WelcomePanel
## via son abonnement a account_logged_out ; "Quitter le jeu" -> get_tree().quit()) plus "Annuler"
## pour refermer sans rien faire - meme moule que ParentalGateOverlay (Dimmer/Card/Margin/Content),
## mais avec son propre flou plein ecran (meme shader qu'ailleurs) puisque ce noeud N'EST PAS
## imbrique dans une fenetre deja floutee (GameMenuPanel a la sienne, mais Echap doit pouvoir ouvrir
## cette fenetre-ci MEME quand GameMenuPanel est ferme - voir game_ui.tscn, instancie comme enfant
## direct de "UI", en tout dernier pour se dessiner au-dessus de tout, y compris GameMenuPanel).
##
## blocking_panel_paths (meme principe generique que MenuToggleButton.toggled_panel_paths, voir son
## commentaire) : liste de tous les autres menus/fenetres du jeu (GameMenuPanel, BackpackMenu,
## ShopPanel, CardAlbum, SuccessPanel, QuestionPanel, SubjectSelectPanel, ReadingIntroPanel,
## CardRevealOverlay, WelcomePanel - voir game_ui.tscn) - Echap n'ouvre cette fenetre QUE si aucun
## d'entre eux n'est visible, exactement la condition demandee ("quand aucun menu n'est ouvert").
## Ne connait aucun de ces noeuds par leur classe, seulement leur "visible" (CanvasItem) - reste
## generique et reutilisable si de nouvelles fenetres s'ajoutent plus tard (il suffira d'allonger
## la liste dans game_ui.tscn, aucun code a toucher ici).
class_name QuitOverlay
extends Control

@export var blocking_panel_paths: Array[NodePath] = []

@onready var logout_button: Button = $Card/Margin/Content/LogoutButton
@onready var quit_button: Button = $Card/Margin/Content/QuitButton
@onready var cancel_button: Button = $Card/Margin/Content/CancelButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	logout_button.pressed.connect(_on_logout_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	cancel_button.pressed.connect(close)
	visibility_changed.connect(_on_visibility_changed)

func open() -> void:
	show()

func close() -> void:
	hide()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

func _on_logout_pressed() -> void:
	hide()
	SaveManager.logout()

func _on_quit_pressed() -> void:
	get_tree().quit()

## Echap ferme cette fenetre si elle est deja ouverte (meme principe que QuestionPanel, seule
## autre fenetre du jeu a avoir un raccourci clavier - voir son commentaire de classe), ou l'ouvre
## sinon, mais SEULEMENT si aucun des panneaux de blocking_panel_paths n'est actuellement visible.
func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return
	if visible:
		get_viewport().set_input_as_handled()
		close()
		return
	if _is_any_blocking_panel_open():
		return
	get_viewport().set_input_as_handled()
	open()

func _is_any_blocking_panel_open() -> bool:
	for path in blocking_panel_paths:
		var panel := get_node_or_null(path) as CanvasItem
		if panel and panel.visible:
			return true
	return false
