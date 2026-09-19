## Bouton "plein ecran" (icone plein-ecran.webp), present a 2 endroits (ecran d'intro en haut a
## droite, et HUD de jeu en haut a droite a cote du bouton menu de droite/BackpackButton) - retour
## utilisateur 2026-09-19 : basculer le plein ecran n'importe quand, sans passer par le menu
## Options > Configuration. Reutilise SaveManager.set_fullscreen() (deja toute la logique :
## DisplayServer.window_set_mode + sauvegarde disque) - ce bouton n'est qu'un raccourci visuel de
## plus vers le meme reglage. La case a cocher de SectionConfig continue de fonctionner
## normalement et reste coherente avec ce bouton via EventBus.fullscreen_changed (voir son
## commentaire), qui tient aussi ce bouton a jour si le reglage change depuis l'autre endroit
## pendant que ce bouton reste dans l'arbre de scene.
##
## Icone assombrie quand le plein ecran est actif (filtre noir transparent 50%, retour
## utilisateur) : `modulate` a 50% gris multiplie chaque pixel opaque de l'icone par 0.5,
## exactement equivalent visuellement a superposer un calque noir a 50% d'opacite (memes maths :
## src*(1-0.5) + noir*0.5 = src*0.5) - pas besoin d'un ColorRect/shader dedie pour un si petit
## effet.
##
## Masquage pendant les autres panneaux (2026-09-19, retour utilisateur : le bouton restait
## visible ET cliquable PAR-DESSUS BackpackMenu quand celui-ci s'ouvre, contrairement au menu de
## gauche/GameMenuPanel qui le recouvrait deja tout seul par simple ordre de dessin - BackpackMenu
## est instancie AVANT ce bouton dans game_ui.tscn, donc dessine derriere lui, alors que
## GameMenuPanel est instancie APRES) : meme logique de masquage que MenuToggleButton
## (toggled_panel_paths, voir ui/hud/menu_toggle_button.gd), DUPLIQUEE ici a l'identique plutot que
## partagee par heritage - aucune classe de base commune deja en place dans le projet pour ce cas
## (meme convention que HelpOverlay/_equalize_tab_widths, deja duplique depuis ShopPanel). Export
## laisse vide (valeur par defaut) sur l'ecran d'intro, qui n'a aucun panneau concurrent a
## surveiller - le bouton y reste donc toujours visible, comme avant.
class_name FullscreenButton
extends Button

const _DARKENED_MODULATE := Color(0.5, 0.5, 0.5, 1.0)

@export var toggled_panel_paths: Array[NodePath] = []

var _toggled_panels: Array[Control] = []

func _ready() -> void:
	## Reapplique le theme d'interface choisi (et reagit a un changement) : ce bouton peut etre
	## enfant direct du CanvasLayer "UI" (HUD de jeu, voir game_ui.tscn), qui coupe la propagation
	## automatique de Theme - meme raison/meme correctif que MenuToggleButton (voir son
	## commentaire de classe, ui/hud/menu_toggle_button.gd). Quand ce bouton vit plutot dans
	## WelcomePanel (un Control normal, pas un CanvasLayer), ceci est redondant mais inoffensif :
	## WelcomePanel s'applique deja le meme theme a lui-meme, et reappliquer la meme valeur ne
	## change rien.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

	for panel_path in toggled_panel_paths:
		var panel := get_node(panel_path) as Control
		if panel:
			_toggled_panels.append(panel)
			panel.visibility_changed.connect(_update_visibility)
	_update_visibility()

	pressed.connect(_on_pressed)
	EventBus.fullscreen_changed.connect(_update_modulate)
	_update_modulate(SaveManager.fullscreen)

func _update_visibility() -> void:
	for panel in _toggled_panels:
		if panel.visible:
			visible = false
			return
	visible = true

func _on_pressed() -> void:
	SaveManager.set_fullscreen(not SaveManager.fullscreen)

func _update_modulate(is_fullscreen: bool) -> void:
	modulate = _DARKENED_MODULATE if is_fullscreen else Color.WHITE
