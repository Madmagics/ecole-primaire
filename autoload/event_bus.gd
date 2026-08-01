## Bus d'evenements global : decouple les systemes entre eux (NPC, boutique, UI, coffres...).
## Regle : un composant emet/ecoute ici plutot que de connaitre directement les autres composants.
extends Node

## Emis quand un PNJ a termine de corriger un pack de questions. total_count = taille reelle du
## pack (10 pour Math/Lecture, mais variable - 10/15/20/25 - pour Grammaire/Conjugaison/
## Orthographe/Anglais depuis la mecanique de pack de revision, voir QuestionGiverComponent et
## FRANCAIS_DIFFICULTE.md).
signal pack_completed(subject: SubjectType.Subject, rarity: CardRarity.Rarity, correct_count: int, total_count: int, reward: int)

## Emis quand une carte est obtenue (coffre ouvert, achat en boutique...).
signal card_obtained(card: CardResource)

## Emis quand le joueur entre/sort de la portee d'un objet interactif (PNJ, coffre, boutique).
signal interactable_focused(interactable: Node)
signal interactable_unfocused(interactable: Node)

## Emis par SaveManager.set_ui_theme() quand le theme d'interface change. Ecoute par chaque
## panneau racine sous UI/ (CanvasLayer) : un CanvasLayer n'est pas un Control/Window, il coupe
## la propagation automatique de Theme (voir doc officielle Window.theme, Godot 4.7 : le theme
## se propage "a ce noeud et a tous ses enfants Control et Window") - impossible donc de
## reskinner tout d'un coup via get_tree().root.theme comme on le ferait sans CanvasLayer. Chaque
## panneau s'applique donc son propre theme (theme = ...) a la reception de ce signal.
signal ui_theme_changed(theme: Theme)
