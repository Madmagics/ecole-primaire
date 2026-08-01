## Petit journal des derniers loots obtenus (achats de coffres), affiche en bas a droite.
## Chaque ligne reste visible 10 secondes, ou est evincee plus tot si plus de 10 lignes
## s'accumulent (la plus ancienne disparait alors). Purement informatif : n'affecte pas
## la collection (CardCollection), juste un retour visuel immediat sur ce qui vient d'etre gagne.
## Independant : ecoute seulement EventBus, ne connait rien d'autre.
class_name LootFeed
extends Control

const MAX_ENTRIES := 10
const ENTRY_LIFETIME_SECONDS := 5.0

@onready var entries_container: VBoxContainer = $EntriesContainer

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	EventBus.card_obtained.connect(_on_card_obtained)

func _on_card_obtained(card: CardResource) -> void:
	if card == null:
		return
	var label := Label.new()
	label.text = "+ %s (%s)" % [card.display_name, GradeLevel.get_label(card.grade)]
	label.modulate = GradeLevel.get_color(card.grade)
	## add_theme_constant_override, pas add_theme_font_size_override - outline_size est une
	## constante de theme, pas une taille de police (bug repere le 2026-07-28 via
	## section_stats.gd : avec la mauvaise categorie, aucun contour ne s'affichait).
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 4)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	entries_container.add_child(label)

	if entries_container.get_child_count() > MAX_ENTRIES:
		entries_container.get_child(0).queue_free()

	_expire_after_delay(label)

func _expire_after_delay(label: Label) -> void:
	await get_tree().create_timer(ENTRY_LIFETIME_SECONDS).timeout
	if is_instance_valid(label):
		label.queue_free()
