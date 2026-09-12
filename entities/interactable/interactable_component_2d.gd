## Detecteur de clic 2D : sous CLASSE2.0 (ecran unique, plus de joueur - voir
## project_classe2_single_screen_pivot en memoire), chaque PNJ/kiosque est directement cliquable
## (souris OU tactile) au lieu d'etre detecte par proximite (Area2D + joueur qui marche dessus,
## ancien comportement). A placer comme noeud Area2D (avec une CollisionShape2D enfant) sur la
## scene qui l'utilise - la forme EST la zone de clic, pas une zone de declenchement physique.
## `monitoring`/`monitorable` desactives ci-dessous : plus besoin de detecter des chevauchements
## corps/zone (aucun joueur a detecter), seul `input_pickable` (true par defaut, voir
## docs.godotengine.org/en/stable/classes/class_collisionobject2d.html) sert desormais, et ne
## depend que d'un `collision_layer` avec au moins un bit actif (deja la valeur par defaut).
class_name InteractableComponent2D
extends Area2D

## Emis au clic/tap. "who" toujours null ici (plus de joueur a identifier) - conserve pour garder
## la meme signature qu'avant CLASSE2.0 : aucun ecouteur actuel (QuestionGiverComponent,
## ShopPanel.open) ne lit ce parametre.
signal interacted(who: Node)

## Libelle court de cet interactable ("Boutique", "Maître du CP"...) - non affiche pour l'instant
## (l'ancien reticule central InteractPrompt est archive avec le reste du deplacement), garde
## pour une future infobulle au survol.
@export var prompt_text: String = "Interagir"

func _ready() -> void:
	## Cette Area2D ne sert plus qu'a capter le clic/tap sur sa forme - desactive le
	## chevauchement corps/zone (le mecanisme "trigger" historique), inutile sans joueur.
	monitoring = false
	monitorable = false
	input_event.connect(_on_input_event)

## Signature imposee par CollisionObject2D.input_event (voir docs officielles) : viewport et
## shape_idx ne servent a rien ici (un seul Area2D = un seul interactable, pas besoin de
## distinguer quelle CollisionShape2D a ete touchee).
## Ecoute uniquement InputEventMouseButton, pas InputEventScreenTouch directement : un CollisionObject2D
## ne recoit pas les evenements tactiles bruts de facon fiable via input_event (rapporte sur
## forum.godotengine.org), mais un tap genere AUSSI un InputEventMouseButton emule tant que le
## reglage projet "Input Devices > Pointing > Emulate Mouse From Touch" reste actif (valeur par
## defaut du moteur, non modifiee dans ce projet) - donc souris ET tactile passent deja par cette
## seule branche, aucune duplication a filtrer ici.
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	## Sur relachement (pas l'appui) : meme convention qu'un Button natif (BaseButton.
	## action_mode par defaut = ACTION_MODE_BUTTON_RELEASE), permet d'annuler un clic en
	## glissant hors de la zone avant de relacher.
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		interacted.emit(null)
