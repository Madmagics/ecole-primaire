## Composant du PNJ guide : affiche un texte d'aide/tuto fixe a l'interaction (voir ui/help_panel),
## aucune mecanique de jeu derriere - contrairement a QuestionGiverComponent (questions) ou au
## kiosque (achat), c'est juste de la lecture. Meme pattern _find_sibling_interactable que
## QuestionGiverComponent (voir ce fichier pour le detail du choix, pas de classe de base commune
## utile a part Node).
class_name GuideComponent
extends Node

## Emis a l'interaction : relaye tel quel a HelpPanel.open_for (voir [connection] dans la scene
## qui utilise ce PNJ).
signal help_requested(source: Node, title: String, message: String)

## Libelle affiche dans le reticule (InteractPrompt) ET comme titre du panneau d'aide.
@export var title: String = "Guide"
## Texte du mini tuto/aide affiche a l'interaction.
@export_multiline var message: String = ""

func _ready() -> void:
	var interactable := _find_sibling_interactable()
	if interactable:
		interactable.interacted.connect(_on_interacted)
		interactable.prompt_text = title

func _find_sibling_interactable() -> InteractableComponent2D:
	for child in get_parent().get_children():
		if child is InteractableComponent2D:
			return child
	return null

func _on_interacted(who: Node) -> void:
	help_requested.emit(who, title, message)
