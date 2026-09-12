## Petit popup rouge autonome affiche quand un PNJ est interpelle alors que la limite
## d'utilisation quotidienne (controle parental) est deja atteinte (2026-09-06, retour
## utilisateur : "lorsque la limite est atteinte jaimerais que le click sur un npc ouvre une popup
## reduite comme celle dun manque de piece pour la boutique avec un message en rouge. actuellement
## cest une fenetre avec un cadre titre vide inutile") - remplace l'ancien passage par
## pack_unavailable/QuestionPanel.show_message() pour CE cas precis (qui ouvrait la fenetre
## COMPLETE de QuestionPanel avec sa zone de titre vide, pensee pour une vraie question, pas pour
## un simple message). Les autres messages pack_unavailable ("pas encore de questions pour cette
## matiere/classe...") ne sont PAS concernes et continuent de passer par QuestionPanel.show_message
## - voir QuestionGiverComponent.daily_limit_reached, signal DISTINCT de pack_unavailable pour ne
## toucher QUE ce cas precis.
##
## Meme moule que ShopPanel.InsufficientFundsOverlay (Dimmer plein ecran + petite carte centree +
## texte rouge, meme teinte que QuestionPanel.WRONG_COLOR, auto-masquage apres AUTO_HIDE_SECONDS)
## plutot que le grand cadre de QuestionPanel : ici il n'y a ni titre, ni case a remplir, juste un
## message qui se referme tout seul.
class_name DailyLimitReachedOverlay
extends Control

const AUTO_HIDE_SECONDS := 2.5

@onready var label: Label = $Card/Margin/Label

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un enfant
	## direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)

## "_source" ignore (meme convention que QuestionPanel.show_message) - un seul message fixe, pas
## besoin de savoir quel PNJ a declenche l'appel. Un second appel pendant que le message est deja
## visible relance simplement un nouveau minuteur, sans consequence (meme technique que
## ShopPanel._show_insufficient_funds).
func open(_source: Node) -> void:
	show()
	get_tree().create_timer(AUTO_HIDE_SECONDS).timeout.connect(hide)
