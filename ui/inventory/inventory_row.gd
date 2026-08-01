## Ligne reutilisable affichant le solde d'une rarete de piece dans InventoryPanel.
## Instanciee en boucle par InventoryPanel.gd, une par rarete affichee.
class_name InventoryRow
extends PanelContainer

@onready var coin_icon: TextureRect = $HBoxContainer/CoinIcon
@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var amount_label: Label = $HBoxContainer/AmountLabel

func display(rarity: CardRarity.Rarity, amount: int) -> void:
	coin_icon.modulate = CardRarity.get_color(rarity)
	name_label.text = CardRarity.get_label(rarity)
	amount_label.text = str(amount)
