## Cache ce bouton tant qu'au moins un des panneaux qu'il ouvre est visible, pour ne pas le
## laisser superpose par-dessus (ex: le bouton "M" au-dessus du menu de jeu). Generique et
## reutilisable : ne connait que les Control qu'on lui donne, pas GameMenuPanel specifiquement.
##
## Array plutot qu'un seul NodePath (2026-07-25) : CardAlbum (le livre de collection) a son
## propre raccourci "L" independant du menu (voir CHARTE_GRAPHIQUE.md, "Raccourcis clavier des
## sections du menu") et peut donc s'ouvrir sans passer par GameMenuPanel. Avec un seul panneau
## surveille, le bouton "M" restait affiche par-dessus le livre quand il s'ouvrait directement -
## bug corrige en surveillant les deux panneaux ici plutot qu'un seul.
extends Button

## NodePath plutot qu'un export direct de type Control : assigner un NodePath litteral a un
## export de type Node/Control dans un .tscn ecrit a la main ne se resout pas forcement en
## reference reelle (echec silencieux, le bouton restait affiche en permanence). get_node() ici
## garantit une resolution correcte.
@export var toggled_panel_paths: Array[NodePath] = []

var _toggled_panels: Array[Control] = []

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce bouton est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	for panel_path in toggled_panel_paths:
		var panel := get_node(panel_path) as Control
		if panel:
			_toggled_panels.append(panel)
			panel.visibility_changed.connect(_update_visibility)
	_update_visibility()

func _update_visibility() -> void:
	for panel in _toggled_panels:
		if panel.visible:
			visible = false
			return
	visible = true
