## Affiche les soldes de pieces (math / francais) et se met a jour via le signal d'Economy.
## Ne connait rien d'autre que l'autoload Economy : reutilisable sur n'importe quel ecran.
class_name CoinHUD
extends Control

@onready var math_label: Label = $HBoxContainer/MathLabel
@onready var french_label: Label = $HBoxContainer/FrenchLabel

func _ready() -> void:
	## Couleur de piece par matiere, pour que ce soit lisible d'un coup d'oeil (public jeune).
	math_label.modulate = SubjectType.get_color(SubjectType.Subject.MATH)
	french_label.modulate = SubjectType.get_color(SubjectType.Subject.FRENCH)
	Economy.balance_changed.connect(_on_balance_changed)
	_refresh()

func _refresh() -> void:
	## Prefixe court + espacement pour eviter que les deux nombres se lisent comme un seul (ex: "1" "0" -> "10").
	math_label.text = "MA=%d" % Economy.get_balance(SubjectType.Subject.MATH)
	french_label.text = "FR=%d" % Economy.get_balance(SubjectType.Subject.FRENCH)

func _on_balance_changed(_subject: SubjectType.Subject, _amount: int) -> void:
	_refresh()
