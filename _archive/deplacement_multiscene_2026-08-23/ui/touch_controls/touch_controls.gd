## Commandes tactiles superposees au jeu : pad de 4 fleches (bas-gauche, pilote les memes actions
## "move_left/right/up/down" que le clavier - voir MovementComponent) et 2 boutons +/- (bas-droite,
## pilotent le zoom de CameraRig via les actions "zoom_in"/"zoom_out", voir project.godot Input Map
## et camera_rig.gd). N'existe que pour les appareils tactiles (voir PlatformUtils) : reste cache
## et inerte sur desktop, ou clavier/molette suffisent deja.
##
## Boutons standards (pas de TouchScreenButton) : le reste du projet utilise deja des Button pour
## l'UI tactile (voir QuestionPanel, adapte via PlatformUtils) plutot que des TouchScreenButton -
## coherence visuelle (theme du jeu applique tel quel) et evite d'avoir a fournir des textures
## dediees en plus des icones existantes.
class_name TouchControls
extends Control

@onready var _button_up: Button = $DPad/Up
@onready var _button_down: Button = $DPad/Down
@onready var _button_left: Button = $DPad/Left
@onready var _button_right: Button = $DPad/Right
@onready var _button_zoom_in: Button = $ZoomButtons/ZoomIn
@onready var _button_zoom_out: Button = $ZoomButtons/ZoomOut

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : enfant direct du
	## CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis get_tree().root -
	## meme note que menu_toggle_button.gd/interact_prompt.gd.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	if not PlatformUtils.is_touch_platform():
		visible = false
		return
	_bind_hold_button(_button_up, "move_up")
	_bind_hold_button(_button_down, "move_down")
	_bind_hold_button(_button_left, "move_left")
	_bind_hold_button(_button_right, "move_right")
	_bind_hold_button(_button_zoom_in, "zoom_in")
	_bind_hold_button(_button_zoom_out, "zoom_out")
	## Cache le pad pendant qu'un panneau modal est ouvert (question, boutique...) : le joueur est
	## de toute facon fige (voir PlayerInputLock/MovementComponent), pas la peine de laisser les
	## fleches visibles/appuyables par-dessus une fenetre qui occupe l'ecran.
	PlayerInputLock.lock_changed.connect(_on_lock_changed)

## "button_down"/"button_up" (pas le signal "pressed", qui n'arrive qu'au relachement) : on veut
## que l'action reste "enfoncee" tant que le doigt reste sur le bouton, exactement comme une
## touche clavier maintenue - Input.action_press/release simule cet etat aupres du singleton
## Input, lu telle quelle par Input.get_vector() dans MovementComponent et Input.is_action_pressed
## dans CameraRig, sans que ces scripts aient besoin de savoir que la source est tactile.
func _bind_hold_button(button: Button, action: StringName) -> void:
	button.button_down.connect(func() -> void: Input.action_press(action))
	button.button_up.connect(func() -> void: Input.action_release(action))

func _on_lock_changed(is_locked: bool) -> void:
	visible = not is_locked
	if is_locked:
		## Un Control cache par "visible = false" arrete de recevoir les evenements tactiles : si
		## un doigt etait pose sur une fleche au moment ou le panneau s'ouvre, aucun "button_up" ne
		## sera jamais recu pour la relacher (le bouton devenu invisible ne capte plus le
		## relachement) - sans ce filet, l'action resterait "enfoncee" pour Input.get_vector/
		## is_action_pressed indefiniment. On force donc le relachement de toutes les actions
		## pilotees ici des la fermeture du pad, que le doigt ait ete leve ou non.
		_release_all_actions()

func _release_all_actions() -> void:
	for action in ["move_up", "move_down", "move_left", "move_right", "zoom_in", "zoom_out"]:
		Input.action_release(action)
