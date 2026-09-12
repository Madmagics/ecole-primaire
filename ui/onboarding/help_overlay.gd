## Fenetre "Aide" de l'ecran d'accueil (2026-09-06, retour utilisateur : "cliquer sur l icone
## ouvrira une fenetre ou on mettra du contenu explicatif, un systeme d onglet comme dans la
## boutique ; tu peux reprendre le meme design general de la boutique avec ses ouglet. 1er onglet
## : Intro, 2e: contenu du jeu, 3e mises a jour, on remplira ensuite ces onglets") - meme chrome de
## fenetre (Panel/TitleRow+TitleLabel+CloseButton/TitleSeparator/Margin/Content/Tabs) que
## ShopPanel/WelcomePanel (voir shop_panel.gd/.tscn et welcome_panel.tscn, les 2 references
## reprises ici), mais geometrie de Panel calquee sur celle du formulaire login/creation de
## WelcomePanel (anchors en pourcentage 0.2/0.06/0.8/0.94, PAS l'offset asymetrique de ShopPanel
## qui reserve la colonne d'icones a droite - inexistante sur l'ecran d'accueil).
##
## 3 onglets vides pour l'instant (Intro / Contenu du jeu / Mises a jour, chacun un simple Label
## "Contenu a venir." le temps d'etre rempli) - voir memoire projet pour le suivi de ce backlog.
class_name HelpOverlay
extends Control

@onready var tabs: TabContainer = $Panel/Margin/Content/Tabs
@onready var close_button: Button = $Panel/TitleRow/CloseButton

func _ready() -> void:
	## Enfant direct du CanvasLayer "UI" de WelcomePanel (voir son .tscn) : la propagation
	## automatique de Theme depuis get_tree().root ne suffit pas, meme raison que ShopPanel/
	## GameMenuPanel/etc.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)
	## Titres affiches fixes ici plutot que via le nom des noeuds (ContenuJeu/MisesAJour dans le
	## .tscn, SANS espace) : un nom de noeud avec espace/accent fonctionne (voir l'onglet "Succès"
	## de ShopPanel), mais "Contenu du jeu"/"Mises à jour" combinent espace ET accent - autant
	## fixer le texte explicitement ici plutot que de parier sur la tolerance de l'editeur.
	tabs.set_tab_title(0, "Intro")
	tabs.set_tab_title(1, "Contenu du jeu")
	tabs.set_tab_title(2, "Mises à jour")
	_equalize_tab_widths()

func open() -> void:
	show()

func close() -> void:
	hide()

## Identique a ShopPanel._equalize_tab_widths() (voir son commentaire pour l'historique complet) :
## force chaque onglet a la largeur du plus large tout en gardant son titre centre. Duplique
## plutot que partage - pas de classe utilitaire commune deja en place pour cette logique.
func _equalize_tab_widths() -> void:
	await get_tree().process_frame
	var tab_bar := tabs.get_tab_bar()
	var font: Font = tab_bar.get_theme_font("font")
	var font_size: int = tab_bar.get_theme_font_size("font_size")
	var space_width: float = font.get_string_size(" ", HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var titles: Array[String] = []
	var widths: Array[float] = []
	for i in tab_bar.tab_count:
		titles.append(tab_bar.get_tab_title(i))
		widths.append(tab_bar.get_tab_rect(i).size.x)
	var max_width: float = widths.max()
	for i in tab_bar.tab_count:
		var gap := max_width - widths[i]
		if gap <= 0.0 or space_width <= 0.0:
			continue
		var side_spaces: int = maxi(0, roundi(gap / 2.0 / space_width))
		if side_spaces == 0:
			continue
		var padding: String = " ".repeat(side_spaces)
		tab_bar.set_tab_title(i, padding + titles[i] + padding)
