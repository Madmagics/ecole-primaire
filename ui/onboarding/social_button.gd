## Icone de reseau social de l'ecran d'accueil (2026-11-07, demande Steve : icone Facebook entre
## "Quitter" et l'aide) - ouvre [url] dans le navigateur par defaut via OS.shell_open (sur la
## version Web : nouvel onglet du navigateur, le clic fournit l'action utilisateur requise par les
## bloqueurs de fenetres). Vit uniquement dans WelcomePanel, comme HelpButton.
class_name SocialButton
extends Button

@export var url: String = ""

func _ready() -> void:
	pressed.connect(_on_pressed)
	pivot_offset = size / 2.0
	resized.connect(func() -> void: pivot_offset = size / 2.0)
	mouse_entered.connect(func() -> void: scale = Vector2(1.08, 1.08))
	mouse_exited.connect(func() -> void: scale = Vector2.ONE)

func _on_pressed() -> void:
	if url != "":
		OS.shell_open(url)
