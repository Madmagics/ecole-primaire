## Menu de jeu principal : coquille de navigation entre 6 entrees (Configuration, Sauvegarde,
## Commandes, Collection, Inventaire, Statistiques). Meme convention que les autres panneaux modaux du jeu
## (CardAlbum, ShopPanel, QuestionPanel) : Control racine, Panel visuel, CloseButton, verrouille
## les deplacements du joueur via PlayerInputLock tant qu'il est ouvert, se ferme avec la croix
## ou Echap. Evolutif par construction : ajouter une 6e section = ajouter un bouton de nav + un
## enfant Section*, sans toucher au reste (voir ARCHITECTURE.md).
##
## La Collection n'est pas reimplementee ici : un signal delegue a l'ecran CardAlbum existant
## (deja complet - pagination, quantites...) pour eviter toute duplication. L'Inventaire (2026-08-01)
## suit exactement le meme principe : un signal delegue vers InventoryPanel, fenetre dediee plutot
## qu'une section generique, pas encore de raccourci clavier propre (a la difference de Collection)
## - juste un point d'entree depuis ce menu pour l'instant.
class_name GameMenuPanel
extends Control

## Emis quand le joueur clique sur "Collection" : a connecter vers CardAlbum.open() depuis la
## scene (park.tscn), pas d'appel direct ici pour ne pas coupler ce panneau a CardAlbum.
signal collection_requested

## Emis quand le joueur clique sur "Inventaire" : a connecter vers InventoryPanel.open() depuis
## la scene (park.tscn), meme raison que collection_requested.
signal inventory_requested

@onready var close_button: Button = $Panel/CloseButton
@onready var config_button: Button = $Panel/NavContainer/ConfigRow/ConfigButton
@onready var save_button: Button = $Panel/NavContainer/SaveRow/SaveButton
@onready var controls_button: Button = $Panel/NavContainer/ControlsRow/ControlsButton
@onready var collection_button: Button = $Panel/NavContainer/CollectionRow/CollectionButton
@onready var inventory_button: Button = $Panel/NavContainer/InventoryRow/InventoryButton
@onready var stats_button: Button = $Panel/NavContainer/StatsRow/StatsButton

@onready var section_config: SectionConfig = $Panel/ContentArea/SectionConfig
@onready var section_save: SectionSave = $Panel/ContentArea/SectionSave
@onready var section_controls: SectionControls = $Panel/ContentArea/SectionControls
@onready var section_stats: SectionStats = $Panel/ContentArea/SectionStats

## Libelle (touche affichee) a cote de chaque bouton de nav - voir _refresh_badges().
@onready var _badge_labels: Dictionary = {
	"open_config": $Panel/NavContainer/ConfigRow/ConfigBadge/ConfigBadgeLabel,
	"open_save": $Panel/NavContainer/SaveRow/SaveBadge/SaveBadgeLabel,
	"open_controls": $Panel/NavContainer/ControlsRow/ControlsBadge/ControlsBadgeLabel,
	"open_album": $Panel/NavContainer/CollectionRow/CollectionBadge/CollectionBadgeLabel,
	"open_stats": $Panel/NavContainer/StatsRow/StatsBadge/StatsBadgeLabel,
}

## Section actuellement affichee ("config"/"save"/"controls"/"stats"/"" si fermee) : permet aux
## raccourcis clavier (voir _unhandled_input) de fermer le menu si la touche pressee correspond
## a la section deja ouverte, ou de basculer dessus sinon - meme convention que CardAlbum pour
## "open_album" (bascule ouvert/ferme sur une seule touche).
var _current_section: StringName = &""

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)
	config_button.pressed.connect(_show_config)
	save_button.pressed.connect(_show_save)
	controls_button.pressed.connect(_show_controls)
	## Ferme ce menu avant d'ouvrir la Collection (CardAlbum) : sinon les deux panneaux restaient
	## visibles en meme temps, celui-ci recouvrant l'autre (voir retour utilisateur 2026-07-28) -
	## la Collection remplace le menu au lieu de s'empiler dessus, il faut rouvrir le menu (M) pour
	## y revenir.
	collection_button.pressed.connect(func() -> void:
		close()
		collection_requested.emit()
	)
	inventory_button.pressed.connect(func() -> void:
		close()
		inventory_requested.emit()
	)
	stats_button.pressed.connect(_show_stats)
	visibility_changed.connect(_on_visibility_changed)

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("open_menu"):
		toggle()
		get_viewport().set_input_as_handled()
		return
	## "open_album" ouvre CardAlbum directement (voir CardAlbum._unhandled_input) : ce menu n'a
	## pas de section "Collection" propre a fermer/ouvrir, seulement les 4 autres.
	for pair in [
		["open_config", &"config", _show_config],
		["open_save", &"save", _show_save],
		["open_controls", &"controls", _show_controls],
		["open_stats", &"stats", _show_stats],
	]:
		var action: String = pair[0]
		var section_id: StringName = pair[1]
		var show_callable: Callable = pair[2]
		if event.is_action_pressed(action):
			if visible and _current_section == section_id:
				close()
			else:
				if not visible:
					show()
				show_callable.call()
			get_viewport().set_input_as_handled()
			return

func open() -> void:
	show()
	_show_config()

func close() -> void:
	hide()
	_current_section = &""

## Bascule le menu ouvert/ferme sur une seule touche/un seul clic (le bouton "M" du HUD comme la
## touche "open_menu" appellent cette meme methode, pour un comportement identique).
func toggle() -> void:
	if visible:
		close()
	else:
		open()

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
		_refresh_badges()
	else:
		PlayerInputLock.unlock()

func _refresh_badges() -> void:
	for action in _badge_labels.keys():
		_badge_labels[action].text = SaveManager.get_binding_label(action)

func _hide_all_sections() -> void:
	section_config.hide()
	section_save.hide()
	section_controls.hide()
	section_stats.hide()

func _show_config() -> void:
	_hide_all_sections()
	section_config.refresh()
	section_config.show()
	_current_section = &"config"

func _show_save() -> void:
	_hide_all_sections()
	section_save.refresh()
	section_save.show()
	_current_section = &"save"

func _show_controls() -> void:
	_hide_all_sections()
	section_controls.refresh()
	section_controls.show()
	_current_section = &"controls"

func _show_stats() -> void:
	_hide_all_sections()
	section_stats.refresh()
	section_stats.show()
	_current_section = &"stats"
