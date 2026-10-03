## Reglage d'UN sprite qui defile dans un CloudScroller (ex: un vaisseau de school5) : sa
## texture, son sens de passage et l'angle de sa trajectoire.
class_name ScrollingSpriteEntry
extends Resource

enum Direction { LEFT_TO_RIGHT, RIGHT_TO_LEFT }

@export var texture: Texture2D
@export var direction: Direction = Direction.LEFT_TO_RIGHT
## Angle de la trajectoire en degres par rapport a l'horizontale. Positif = descend,
## negatif = monte, 0 = vol horizontal (quel que soit le sens de passage).
@export_range(-60.0, 60.0, 1.0) var angle_deg: float = 0.0
