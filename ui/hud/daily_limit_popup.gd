## Fenetre explicative ouverte par le badge discret DailyLimitBadge (voir son commentaire) - meme
## moule que QuitOverlay/ParentalGateOverlay (BlurBG plein ecran + Card centree), mais purement
## informative : un seul bouton "Fermer", rien a confirmer ni a saisir.
class_name DailyLimitPopup
extends Control

@onready var info_label: Label = $Card/Margin/Content/InfoLabel
@onready var close_button: Button = $Card/Margin/Content/CloseButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un enfant
	## direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Reconstruit le texte a CHAQUE ouverture (pas seulement au _ready()) : le compte du jour et/ou
## la limite peuvent avoir change depuis la derniere ouverture (nouveau questionnaire termine,
## reglage modifie par le parent...). Appelee par DailyLimitBadge._on_pressed().
func open() -> void:
	var count := SaveManager.get_daily_game_count()
	var limit := SaveManager.get_daily_game_limit()
	if count >= limit:
		info_label.text = "Tu as atteint la limite de jeu d'aujourd'hui (%d questionnaire(s) sur %d). Reviens demain, la limite repart à zéro à minuit !" % [count, limit]
	else:
		info_label.text = "Tu as fait %d questionnaire(s) sur %d autorisés aujourd'hui. Cette limite est fixée par le contrôle parental et repart à zéro à minuit." % [count, limit]
	show()

func close() -> void:
	hide()
