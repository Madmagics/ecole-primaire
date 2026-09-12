## Portail parental hors-ligne (2026-08-01) : un code aleatoire de 8 caracteres est affiche a
## l'ecran, l'action sensible (reinitialiser la progression, supprimer le compte...) n'est
## executee que si ce code est recopie a l'identique - pas de connexion internet ni de vrai
## captcha (reCAPTCHA/hCaptcha) requis, retour utilisateur explicite : "un portail parental
## simple, hors-ligne". Generique et reutilisable : ne connait aucune action precise, seulement
## deux signaux (confirmed/cancelled) - a GameMenuPanel de decider quoi faire (voir
## GameMenuPanel._request_gate()).
##
## Plus aucun raccourci clavier (2026-09-02, retour utilisateur : "on supprime tous les raccourcis
## clavier, je veux un jeu qui se joue uniquement a la souris ou au tactile") : _unhandled_input()
## (Echap pour annuler) est retire - cancel_button fait deja ca a la souris/au tactile. code_input
## (LineEdit) N'EST PAS concerne : recopier le code exige de taper du texte, pas un raccourci -
## fonctionne au clavier physique comme au clavier virtuel tactile, inchange.
class_name ParentalGateOverlay
extends Control

signal confirmed
signal cancelled

const CODE_LENGTH := 8
## Alphabet sans caracteres ambigus a l'ecran (0/O, 1/I/L) : un enfant ou un parent recopiant le
## code a la main ne doit pas avoir a deviner lequel des deux c'est.
const CODE_ALPHABET := "ABCDEFGHJKMNPQRSTUVWXYZ23456789"

@onready var code_label: Label = $Card/Margin/Content/CodeLabel
@onready var code_input: LineEdit = $Card/Margin/Content/CodeInput
@onready var error_label: Label = $Card/Margin/Content/ErrorLabel
@onready var cancel_button: Button = $Card/Margin/Content/ButtonRow/CancelButton
@onready var confirm_button: Button = $Card/Margin/Content/ButtonRow/ConfirmButton

var _expected_code: String = ""

func _ready() -> void:
	cancel_button.pressed.connect(_on_cancel_pressed)
	confirm_button.pressed.connect(_on_confirm_pressed)

## Genere un nouveau code, l'affiche et ouvre le portail. A appeler juste avant de demander une
## action sensible - un nouveau code a chaque ouverture (voir Crypto.generate_random_bytes,
## confirme via docs.godotengine.org/en/4.7) empeche de reutiliser un code memorise a l'avance.
func open() -> void:
	_expected_code = _generate_code()
	code_label.text = _expected_code
	code_input.text = ""
	error_label.hide()
	show()
	code_input.grab_focus()

func _generate_code() -> String:
	var bytes := Crypto.new().generate_random_bytes(CODE_LENGTH)
	var code := ""
	for byte_value in bytes:
		code += CODE_ALPHABET[byte_value % CODE_ALPHABET.length()]
	return code

func _on_confirm_pressed() -> void:
	if code_input.text.strip_edges().to_upper() == _expected_code:
		hide()
		confirmed.emit()
	else:
		error_label.show()

func _on_cancel_pressed() -> void:
	hide()
	cancelled.emit()
