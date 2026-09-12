## Facteur d'echelle partage par tous les sprites de profs (NPCs). Resource commune : les 5
## ProfVisual (school.tscn) chargent par defaut la MEME instance
## (res://data/prof_visual_scale.tres), donc modifier "Factor" depuis l'Inspecteur sur
## N'IMPORTE LEQUEL des 5 sprites grossit/retrecit les 5 en meme temps, en gardant leurs
## proportions relatives entre eux (chaque sprite garde sa taille nature - texture au pixel
## pres a Factor = 1.0 - seul ce facteur s'applique par-dessus, uniformement).
class_name ProfVisualScale
extends Resource

@export var factor: float = 1.0
