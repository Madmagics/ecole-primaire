## Bouton d'interaction centre a l'ecran, pilote par InteractorComponent.gd du joueur (signal
## "interactable_changed" -> show_for()). N'apparait QUE quand un interactable est reellement en
## portee - pas de badge affiche en permanence quand rien n'est a portee.
##
## Pilule a largeur variable (retour utilisateur 2026-08-02, apres un essai intermediaire en case
## carree 120x120 finalement ecarte) : un badge "E" (KeyBadge) a gauche, le titre court de
## l'interactable a droite (InteractableComponent.prompt_text - "Boutique", "Maître du CP"...),
## tous deux a l'interieur d'UN SEUL bouton cliquable (pas de zone separee non cliquable). Style
## natif du theme (Button/styles/*), pas de fond/transparence dedies.
##
## PromptButton est un VRAI bouton cliquable (pas juste un affichage) : appuyer dessus declenche
## la meme interaction que la touche E (voir _on_prompt_pressed), exactement comme
## InteractorComponent.trigger_interact - ca comble l'absence de commande tactile pour "interact"
## (TouchControls, ajoute plus tot, ne couvrait que deplacement/zoom).
class_name InteractPrompt
extends Control

## Bouton natif (pas de Container) : ne s'auto-redimensionne pas a son contenu comme un vrai texte
## de bouton le ferait (voir _resize_prompt_button) puisque son contenu visuel (badge + titre)
## passe par des enfants manuels, pas par la propriete "text". Ces deux constantes reprennent les
## valeurs de Button/styles/normal (content_margin) des 4 fichiers theme (ui/theme/*.tres,
## identiques sur ce point) : si ces marges changent un jour dans le theme, les mettre a jour ici
## aussi pour que le bouton reste visuellement cohesif avec les autres boutons du jeu.
const _BUTTON_PADDING := Vector2(14.0, 8.0)
## Plancher de taille pour KeyBadge (voir custom_minimum_size dans la scene) : doit rester
## superieur au besoin intrinseque du badge (Label "E" + content_margin 12/8/12/8 de
## PanelContainer/styles/panel, meme style que les badges de touches du menu - ConfigBadge et
## consorts, ui/game_menu/game_menu_panel.tscn) sur SES DEUX AXES a la fois. Sinon Godot prend le
## plus grand des deux (custom_minimum_size vs besoin reel) INDEPENDAMMENT par axe : comme la
## marge verticale (8+8=16) est plus courte que l'horizontale (12+12=24), le besoin reel en
## hauteur (marges + hauteur de ligne du texte) depassait 40 sans depasser 40 en largeur - le badge
## rendait donc plus haut que large, pas carre (retour utilisateur 2026-08-02). 48 laisse assez de
## marge pour rester la valeur dominante sur les deux axes avec la police du theme actuelle.
const _KEY_BADGE_SIZE := 48.0
const _CONTENT_SEPARATION := 6.0

@onready var _prompt_button: Button = $Center/PromptButton
@onready var _key_badge: Control = $Center/PromptButton/Content/KeyBadge
@onready var _prompt_label: Label = $Center/PromptButton/Content/PromptLabel

## Node (pas InteractableComponent) : recoit indifferemment un interactable 3D ou 2D depuis le
## passage du jeu en 2D (voir InteractorComponent.gd) - les deux exposent prompt_text/
## trigger_interact mais n'ont pas de classe de base commune utile a part Node.
var _current_interactable: Node

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : enfant direct du
	## CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis get_tree().root -
	## meme note que menu_toggle_button.gd/touch_controls.gd.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	_prompt_button.pressed.connect(_on_prompt_pressed)
	_prompt_button.visible = false
	## Cache le bouton pendant qu'un panneau modal est ouvert - le joueur est de toute facon fige
	## (voir PlayerInputLock/MovementComponent), pas la peine de laisser un bouton "Boutique"
	## appuyable par-dessus la boutique deja ouverte. Meme principe que
	## TouchControls._on_lock_changed.
	PlayerInputLock.lock_changed.connect(_on_lock_changed)

## Appele par InteractorComponent a chaque changement d'interactable en portee (voir
## interactable_changed dans park.tscn) - interactable == null quand plus rien n'est a portee.
func show_for(interactable: Node) -> void:
	_current_interactable = interactable
	if interactable == null:
		_prompt_button.visible = false
		return
	_prompt_label.text = interactable.prompt_text
	_prompt_button.visible = true
	_resize_prompt_button()

## Button n'est pas un Container : il ne recalcule pas sa taille d'apres ses enfants (contrairement
## a un vrai texte de bouton natif). On mesure donc a la main - get_minimum_size() sur KeyBadge et
## PromptLabel (sans autowrap, pas de largeur imposee) refletant deja leur contenu courant de facon
## synchrone, pas besoin d'attendre une frame comme _fit_question_card (QuestionPanel) qui mesurait
## lui une hauteur APRES repli sur une largeur contrainte, cas different. On mesure KeyBadge au lieu
## de reprendre directement la constante _KEY_BADGE_SIZE : c'est la taille REELLEMENT rendue (max
## entre le plancher et le besoin intrinseque, voir le commentaire sur cette constante) qui doit
## entrer dans ce calcul, pas le plancher suppose - sinon le bouton peut se retrouver legerement
## trop court si jamais le badge finit par depasser son plancher sur un theme/une police future.
func _resize_prompt_button() -> void:
	var badge_size: Vector2 = _key_badge.get_minimum_size()
	var label_size: Vector2 = _prompt_label.get_minimum_size()
	var content_width := badge_size.x + _CONTENT_SEPARATION + label_size.x
	var content_height := maxf(badge_size.y, label_size.y)
	_prompt_button.custom_minimum_size = Vector2(content_width, content_height) + _BUTTON_PADDING * 2.0

func _on_prompt_pressed() -> void:
	if _current_interactable:
		## "who" n'est lu par aucun des ecouteurs actuels de InteractableComponent.interacted
		## (QuestionGiverComponent, ShopPanel.open, RewardChest - tous nomment leur parametre
		## "_who" et l'ignorent), donc null convient ici comme depuis InteractorComponent, qui
		## passe systematiquement le joueur sans que cette valeur soit jamais utilisee.
		_current_interactable.trigger_interact(null)

func _on_lock_changed(is_locked: bool) -> void:
	visible = not is_locked
