## Utilitaire partage (2026-09-18, retour utilisateur : sur smartphone/tablette, seule la fine
## barre de defilement pouvait etre attrapee au doigt - glisser depuis le reste de l'ecran ne
## faisait rien) : permet a un glissement du doigt (ou de la souris) de faire defiler un
## ScrollContainer meme quand le geste demarre sur un enfant interactif (Button, LineEdit,
## CheckBox, SpinBox...).
##
## Cause : Godot ne fait defiler un ScrollContainer QUE si l'evenement de glissement lui parvient
## reellement. Par defaut, mouse_filter=STOP sur ces controles absorbe l'evenement des qu'il les
## touche et l'empeche de jamais remonter au ScrollContainer parent - seule la barre elle-meme
## (un enfant distinct, pas concerne) restait alors utilisable au doigt (voir
## docs.godotengine.org/en/4.7/classes/class_control.html#enum-control-mousefilter et
## scene/gui/scroll_container.cpp sur github.com/godotengine/godot, qui confirment que le
## ScrollContainer n'a aucun traitement special pour ses enfants : il applique juste son
## scroll_deadzone a l'evenement de glissement s'il le recoit).
##
## Fix : MOUSE_FILTER_PASS laisse le controle traiter l'evenement normalement ET le transmet quand
## meme au parent, qui decide via son scroll_deadzone (proprite du ScrollContainer, un seuil en
## pixels) si le geste est un simple tap (le controle reagit comme avant) ou un glissement (le
## ScrollContainer defile, sans declencher le controle). Ne change rien sur PC/souris.
class_name TouchScrollFix

## Applique recursivement a tous les descendants de [param root] dont le mouse_filter vaut
## actuellement STOP (la valeur par defaut de la plupart des Controls interactifs, et aussi de
## PanelContainer - voir son constructeur dans scene/gui/panel_container.cpp). Appeler une fois
## dans le _ready() du panneau contenant le/les ScrollContainer (ou sur le noeud racine du
## panneau directement, le plus simple - les elements hors ScrollContainer ne sont pas impactes).
##
## Surveillance automatique des ajouts (2026-09-27, retour utilisateur : dans la fenetre Succes,
## seules les marges entre les blocs de classe permettaient le defilement tactile) : les blocs y
## sont des PanelContainer crees a CHAQUE ouverture (SuccessPanel.refresh), donc apres ce _ready -
## le passage recursif ci-dessus ne les voyait jamais et chacun gardait mouse_filter=STOP. Meme
## piege dans le tableau recapitulatif de QuestionPanel (row_card). Plutot que de corriger chaque
## element dynamique a la main, on ecoute SceneTree.node_added (emis pour chaque noeud qui entre
## dans l'arbre, AVANT son propre _ready - un element qui veut vraiment STOP peut donc toujours le
## redefinir dans son _ready) et on applique la meme regle a tout nouveau descendant de root.
static func allow_scroll_passthrough(root: Node) -> void:
	_apply_recursive(root)
	if not root.is_inside_tree():
		return
	var tree := root.get_tree()
	var on_node_added := func(node: Node) -> void:
		if node is Control and root.is_ancestor_of(node) \
				and (node as Control).mouse_filter == Control.MOUSE_FILTER_STOP:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_PASS
	tree.node_added.connect(on_node_added)
	## Deconnexion quand le panneau quitte l'arbre (sinon le lambda garderait une reference vers
	## un root libere).
	root.tree_exiting.connect(func() -> void:
		if tree.node_added.is_connected(on_node_added):
			tree.node_added.disconnect(on_node_added)
	, CONNECT_ONE_SHOT)

static func _apply_recursive(root: Node) -> void:
	for child in root.get_children():
		if child is Control and (child as Control).mouse_filter == Control.MOUSE_FILTER_STOP:
			(child as Control).mouse_filter = Control.MOUSE_FILTER_PASS
		_apply_recursive(child)
