## Petit badge rond dessine a la main (cercle plein + coche ou croix), affiche dans le tableau
## recapitulatif de QuestionPanel a cote de la reponse donnee par le joueur (voir
## question_panel.gd, _add_result_row/_build_indented_line). Dessin vectoriel (draw_circle/
## draw_line, verifie sur docs.godotengine.org/en/4.7/classes/class_canvasitem.html) plutot qu'un
## glyphe Unicode (✓/✕) pour ne pas dependre du support de ces caracteres par la police du theme -
## retour utilisateur 2026-08-01.
class_name ResultIcon
extends Control

const SIZE := 22.0
const MARK_COLOR := Color(1, 1, 1, 1)
const MARK_WIDTH := 2.4

## true -> coche verte, false -> croix rouge. Les couleurs sont passees par l'appelant
## (question_panel.gd reutilise ses propres CORRECT_COLOR/WRONG_COLOR) plutot que dupliquees ici.
var is_correct: bool = true
var badge_color: Color = Color.WHITE

func _ready() -> void:
	## Cree dynamiquement (pas dans le _ready() du panneau parent) : se corrige donc soi-meme
	## pour rester attrapable au doigt en glissement depuis le ResultScroll parent
	## (QuestionPanel, tableau recapitulatif) - voir ui/common/touch_scroll_fix.gd (retour
	## utilisateur 2026-09-18, meme bug signale a nouveau le 2026-09-19 pour cette fenetre).
	mouse_filter = Control.MOUSE_FILTER_PASS
	custom_minimum_size = Vector2(SIZE, SIZE)

func _draw() -> void:
	var center := size / 2.0
	var radius := size.x / 2.0
	draw_circle(center, radius, badge_color)
	if is_correct:
		## Coche : deux segments courts formant un "check" (angle bas puis remontee).
		var p1 := center + Vector2(-radius * 0.45, 0.0)
		var p2 := center + Vector2(-radius * 0.1, radius * 0.35)
		var p3 := center + Vector2(radius * 0.5, -radius * 0.35)
		draw_line(p1, p2, MARK_COLOR, MARK_WIDTH, true)
		draw_line(p2, p3, MARK_COLOR, MARK_WIDTH, true)
	else:
		var offset := radius * 0.4
		draw_line(center + Vector2(-offset, -offset), center + Vector2(offset, offset), MARK_COLOR, MARK_WIDTH, true)
		draw_line(center + Vector2(-offset, offset), center + Vector2(offset, -offset), MARK_COLOR, MARK_WIDTH, true)
