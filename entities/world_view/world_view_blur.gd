## A poser sur le SubViewportContainer qui affiche le monde 3D (voir levels/park/park.tscn) :
## floute automatiquement ce rendu pendant qu'un panneau modal est ouvert (question, dialogue,
## boutique, album de cartes, menu...), et le rend net des que tout est ferme.
##
## Volontairement generique : ecoute uniquement PlayerInputLock.lock_changed (deja le signal
## unique "un panneau modal est ouvert/ferme" pour tout le jeu, voir autoload/player_input_lock.gd)
## plutot que d'ecouter chaque panneau individuellement. Ainsi tout futur panneau (book de cartes,
## etc.) est flou par le simple fait d'utiliser PlayerInputLock comme les autres - aucun code a
## ajouter ici pour un nouveau panneau.
##
## Le flou lui-meme est un shader canvas_item (world_blur.gdshader) qui lit uniquement TEXTURE
## (la texture du SubViewport, cf. tutoriel officiel "Using a SubViewport as a texture"), donc
## fonctionne sur le renderer Compatibility de ce projet - voir le commentaire en tete du shader
## pour le detail (DOF/SSAO integres et hint_screen_texture ont ete ecartes, l'un non supporte
## en Compatibility, l'autre avec des bugs connus dans ce renderer).
extends SubViewportContainer

## Force du flou une fois le panneau ouvert (en "texels" de decalage d'echantillonnage, voir le
## shader). Reglable ici sans toucher au code - c'est le "reglable par composition" demande.
@export var blur_strength: float = 4.0
## Duree de la transition net <-> flou, en secondes.
@export var transition_time: float = 0.3

var _tween: Tween

func _ready() -> void:
	if material:
		material.set_shader_parameter("blur_amount", 0.0)
	PlayerInputLock.lock_changed.connect(_on_lock_changed)

func _on_lock_changed(is_locked: bool) -> void:
	var target_amount := blur_strength if is_locked else 0.0
	_animate_to(target_amount)

func _animate_to(amount: float) -> void:
	if material == null:
		return
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(
		func(v: float) -> void: material.set_shader_parameter("blur_amount", v),
		material.get_shader_parameter("blur_amount"),
		amount,
		transition_time
	)
