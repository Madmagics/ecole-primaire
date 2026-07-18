## Vignette reutilisable pour afficher une carte (possedee ou verrouillee) dans l'album.
## Instanciee en boucle par CardAlbum.gd.
class_name CardSlot
extends PanelContainer

@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var name_label: Label = $VBoxContainer/NameLabel

func display(card: CardResource, owned: bool) -> void:
	name_label.text = card.display_name if owned else "???"
	texture_rect.texture = card.texture if owned else null
	self_modulate = CardRarity.get_color(card.rarity) if owned else Color.GRAY
