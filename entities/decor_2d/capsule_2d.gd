## Silhouette de capsule dessinee en procedural (rectangle + 2 cercles), sans image : meme esprit
## que les CapsuleMesh utilisees comme placeholders en 3D avant l'arrivee de vrais modeles (voir
## npc.tscn/player.tscn historiques), le temps que le jeu 2D recoive de vrais sprites/animations.
## Convention radius/height alignee sur CapsuleShape2D (voir la CollisionShape2D soeur dans les
## scenes qui utilisent ce script) : orientee verticale, centree sur son origine locale.
@tool
class_name Capsule2D
extends Node2D

@export var color: Color = Color(0.2, 0.6, 1.0):
	set(value):
		color = value
		queue_redraw()
@export var radius: float = 20.0:
	set(value):
		radius = value
		queue_redraw()
## Hauteur TOTALE de la capsule (demi-cercles inclus), comme CapsuleShape2D.height.
@export var height: float = 60.0:
	set(value):
		height = value
		queue_redraw()

const _LOCKED_COLOR := Color(0.3, 0.3, 0.3)
var _locked: bool = false

func _draw() -> void:
	var draw_color := _LOCKED_COLOR if _locked else color
	var rect_half_height: float = maxf(0.0, height * 0.5 - radius)
	draw_rect(Rect2(-radius, -rect_half_height, radius * 2.0, rect_half_height * 2.0), draw_color)
	draw_circle(Vector2(0.0, -rect_half_height), radius, draw_color)
	draw_circle(Vector2(0.0, rect_half_height), radius, draw_color)

## Appele par QuestionGiverComponent._refresh_lock_visual() (voir
## entities/npc/components/question_giver_component.gd) tant que la classe de ce PNJ n'est pas
## debloquee - twin 2D du grisage par material_override utilise sur les PNJ 3D historiques.
func set_locked(locked: bool) -> void:
	_locked = locked
	queue_redraw()
