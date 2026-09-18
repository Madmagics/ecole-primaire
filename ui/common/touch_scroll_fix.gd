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
## actuellement STOP (la valeur par defaut de la plupart des Controls interactifs). Appeler une
## fois dans le _ready() du panneau contenant le/les ScrollContainer (ou sur le noeud racine du
## panneau directement, le plus simple - les elements hors ScrollContainer ne sont pas impactes).
## Pour un element cree dynamiquement APRES ce _ready() (ex: case de boutique instanciee a l'achat),
## fixer plutot son mouse_filter directement dans son propre _ready() (voir ui/shop/crate_item.gd).
static func allow_scroll_passthrough(root: Node) -> void:
	for child in root.get_children():
		if child is Control and (child as Control).mouse_filter == Control.MOUSE_FILTER_STOP:
			(child as Control).mouse_filter = Control.MOUSE_FILTER_PASS
		allow_scroll_passthrough(child)
