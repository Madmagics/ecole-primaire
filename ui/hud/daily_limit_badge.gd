## Badge discret (bas gauche de l'ecran) indiquant la progression du jour vis-a-vis de la limite
## de controle parental (2026-09-06, retour utilisateur : "on peut ajouter un badge discret en bas
## a gauche de l'ecran avec explication en popup si click ou activation touch") - suite directe de
## l'application reelle de la limite quotidienne (compteur + remise a zero a minuit + blocage),
## voir feedback_parental_control_checkbox.md en memoire projet.
##
## Visible SEULEMENT si le compte connecte a une limite reellement definie
## (SaveManager.get_daily_game_limit() > 0) - rien a signaler sinon, y compris si personne n'est
## connecte (get_daily_game_limit() renvoie deja 0 dans ce cas, profil vide - pas besoin de
## verifier current_account_id separement ici) - ET si aucune fenetre du jeu n'est ouverte par-
## dessus la classe (2026-09-06, retour utilisateur : "le badge ne doit apparaitre que dans la
## grande fenetre de classe comme actuellement, je ne la veux pas dans les autres fenetres" - le
## badge restait affiche par-dessus GameMenuPanel/ShopPanel/etc., signale explicitement comme un
## defaut dans le commentaire de la version precedente). Voir hidden_when_visible_paths ci-dessous,
## meme principe que MenuToggleButton.toggled_panel_paths (ui/hud/menu_toggle_button.gd) : liste
## generique de Control a surveiller, assignee depuis game_ui.tscn plutot que codee en dur ici.
## Se rafraichit a la connexion/deconnexion d'un compte, a chaque questionnaire termine
## (EventBus.pack_completed, meme signal que SaveManager/StatsTracker pour ce compteur), et a
## chaque changement de visibilite d'une des fenetres surveillees.
##
## Le popup explicatif (ui/hud/daily_limit_popup.tscn, meme moule BlurBG+Card que QuitOverlay/
## ParentalGateOverlay) est un noeud EXTERNE (voir popup_path, meme mecanisme de NodePath que
## GameMenuPanel.quit_overlay_path) plutot qu'imbrique ici : ce bouton n'occupe qu'un petit
## rectangle en bas a gauche de l'ecran (anchors BOTTOM_LEFT) - un enfant a lui ne pourrait jamais
## couvrir tout l'ecran (les ancres d'un enfant se calculent par rapport au rectangle du PARENT,
## pas du viewport).
class_name DailyLimitBadge
extends Button

@export var popup_path: NodePath

## Fenetres du jeu dont la visibilite masque ce badge (voir commentaire de classe) - assignee
## depuis game_ui.tscn, jamais codee en dur ici (badge reutilisable, comme MenuToggleButton).
@export var hidden_when_visible_paths: Array[NodePath] = []

var _hidden_when_visible: Array[CanvasItem] = []

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce bouton est un enfant
	## direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	pressed.connect(_on_pressed)
	SaveManager.account_logged_in.connect(func(_profile: Dictionary) -> void: _refresh())
	SaveManager.account_logged_out.connect(_refresh)
	EventBus.pack_completed.connect(_on_pack_completed)
	for path in hidden_when_visible_paths:
		var panel := get_node_or_null(path) as CanvasItem
		if panel:
			_hidden_when_visible.append(panel)
			panel.visibility_changed.connect(_refresh)
	_refresh()

func _on_pack_completed(_subject: SubjectType.Subject, _rarity: CardRarity.Rarity, _correct_count: int, _total_count: int, _reward: int) -> void:
	_refresh()

func _any_other_window_visible() -> bool:
	for panel in _hidden_when_visible:
		if panel.visible:
			return true
	return false

func _refresh() -> void:
	var limit := SaveManager.get_daily_game_limit()
	visible = limit > 0 and not _any_other_window_visible()
	if visible:
		text = "%d/%d" % [SaveManager.get_daily_game_count(), limit]

func _on_pressed() -> void:
	var popup := get_node_or_null(popup_path)
	if popup and popup.has_method("open"):
		popup.open()
