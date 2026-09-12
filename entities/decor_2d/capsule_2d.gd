## Silhouette de capsule dessinee en procedural (rectangle + 2 cercles), sans image : meme esprit
## que les CapsuleMesh utilisees comme placeholders en 3D avant l'arrivee de vrais modeles (voir
## npc.tscn/player.tscn historiques), le temps que le jeu 2D recoive de vrais sprites/animations.
## Convention radius/height alignee sur CapsuleShape2D (voir la CollisionShape2D soeur dans les
## scenes qui utilisent ce script) : orientee verticale, centree sur son origine locale.
##
## set_locked()/etat grise retires (2026-08-29, retour utilisateur : suppression du deblocage de
## classe payant, un PNJ n'est plus jamais verrouille - voir
## QuestionGiverComponent._on_interacted) : ce noeud ne fait plus que dessiner sa silhouette
## coloree. CapsuleVisual reste par ailleurs invisible dans school.tscn (remplace par ProfVisual,
## voir prof_visual.gd).
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

func _draw() -> void:
	var rect_half_height: float = maxf(0.0, height * 0.5 - radius)
	draw_rect(Rect2(-radius, -rect_half_height, radius * 2.0, rect_half_height * 2.0), color)
	draw_circle(Vector2(0.0, -rect_half_height), radius, color)
	draw_circle(Vector2(0.0, rect_half_height), radius, color)
