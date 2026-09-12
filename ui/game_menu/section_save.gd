## Section "Sauvegarde" du menu de jeu : sauvegarder/charger manuellement, ou reinitialiser la
## progression du compte connecte. Reinitialiser est destructif (pieces, cartes, stats perdues,
## le profil - nom/prenom/classe/date de naissance/pays - est conserve) donc protege par le
## portail parental (code a 8 caracteres, voir ParentalGateOverlay) - cette section se contente
## d'emettre reset_requested, c'est GameMenuPanel qui orchestre l'ouverture du portail et
## n'appelle SaveManager.reset_current_account_progress() qu'apres confirmation (voir
## GameMenuPanel._request_gate()). Remplace l'ancienne confirmation en 2 clics (2026-08-01,
## retour utilisateur : le compte peut maintenant etre partage/supprime, une simple double-clic
## n'etait plus jugee suffisante).
##
## SaveButton/LoadButton/ResetButton en size_flags_horizontal = SIZE_SHRINK_BEGIN (0) depuis
## 2026-08-26 (retour utilisateur : "reduit de moitie la longueur des pushbutton, ils prennent
## actuellement toute la largeur de la fenetre") - voir SectionProfile.gd pour le detail du
## mecanisme (FILL par defaut = pleine largeur sur l'axe transversal d'un VBoxContainer).
class_name SectionSave
extends Control

signal reset_requested

@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var load_button: Button = $VBoxContainer/LoadButton
@onready var reset_button: Button = $VBoxContainer/ResetButton
@onready var status_label: Label = $VBoxContainer/StatusLabel

func _ready() -> void:
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	reset_button.pressed.connect(func() -> void: reset_requested.emit())

func refresh() -> void:
	status_label.text = ""
	load_button.disabled = not SaveManager.has_save()

func _on_save_pressed() -> void:
	SaveManager.save_current_account()
	status_label.text = "Partie sauvegardée."
	load_button.disabled = false

func _on_load_pressed() -> void:
	SaveManager.reload_current_account()
	status_label.text = "Partie chargée."

## Appele par GameMenuPanel une fois le portail parental valide (voir reset_requested) : cette
## section n'appelle jamais SaveManager.reset_current_account_progress() elle-meme.
func notify_reset_done() -> void:
	status_label.text = "Progression réinitialisée."
