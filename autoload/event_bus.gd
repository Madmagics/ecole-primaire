## Bus d'evenements global : decouple les systemes entre eux (NPC, boutique, UI, coffres...).
## Regle : un composant emet/ecoute ici plutot que de connaitre directement les autres composants.
extends Node

## Emis apres qu'une reponse a une question a ete donnee (correcte ou non).
signal question_answered(subject: SubjectType.Subject, is_correct: bool)

## Emis quand une carte est obtenue (coffre ouvert, achat en boutique...).
signal card_obtained(card: CardResource)

## Emis quand le joueur entre/sort de la portee d'un objet interactif (PNJ, coffre, boutique).
signal interactable_focused(interactable: Node)
signal interactable_unfocused(interactable: Node)
