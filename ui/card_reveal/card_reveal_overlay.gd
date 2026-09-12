## Animation d'obtention de carte a l'achat d'un coffre (2026-09-02, retour utilisateur :
## "jaimerais ajouter une animation pour l achat des cartes... la carte gagnee apparait en grand
## a lecran dans une explosion de paillettes puis se deplace en retrecissant rapidement vers le
## livre comme si elle etait aspiree par celui ci, si plusieurs cartes sont achetees en meme
## temps, chacune apparait des que la precedente file vers le livre") : remplace LootFeed (voir
## plus bas) au meme point d'ecoute, EventBus.card_obtained (voir shop_panel.gd -
## _do_purchase_crate emet ce signal une fois par carte tiree, dans l'ordre - CardCollection.
## add_card() est deja appele AVANT l'emit, donc CardCollection.get_quantity() reflete deja le
## nouveau total au moment ou _on_card_obtained() ci-dessous s'execute).
##
## Reutilise CardSlot (ui/collection/card_slot.tscn, deja instancie par CardAlbum) pour le rendu
## de la carte plutot que de redessiner un cadre a part - meme cadre colore par classe (voir
## CardSlot.display()), memes proportions que dans le livre, juste affiche ici en dehors de
## l'album le temps de l'animation.
##
## File d'attente avec chevauchement ("chacune apparait des que la precedente file vers le
## livre") : _process_queue() attend _reveal_card() carte par carte, mais _reveal_card() ne
## termine (ne "resume" l'await) qu'une fois le tween de vol vers le livre LANCE - pas termine.
## La carte suivante peut donc commencer a apparaitre pendant que la precedente est encore en
## train de retrecir/voler vers le livre, sans attendre son arrivee.
##
## Declenchement du vol par le joueur (2026-09-02, 3e passe, retour utilisateur : "on modifie la
## sequence, quand la carte apparait a l ecran, il faut clicker dessus (tactile ou souris) ou
## faire ENTER ou ECHAP pour trigger le deplacement vers le livre") : remplace l'ancienne pause
## fixe (HOLD_SECONDS, retiree) - une fois le pop termine, _reveal_card() attend le signal
## reveal_advance_requested, emis soit par _on_card_gui_input() (clic/tap SUR la carte - voir
## plus bas pourquoi tous ses enfants passent en MOUSE_FILTER_IGNORE), soit par
## _unhandled_input() (ui_accept/ui_cancel, memes actions qu'Entree/Echap ailleurs dans ce
## projet - voir ShopPanel._ask_confirm et _unhandled_input). _waiting_for_advance restreint ce
## dernier a la fenetre ou une carte attend reellement, pour ne jamais voler un Echap destine a
## fermer un panneau en temps normal. Un seul "en attente" a la fois par construction (voir
## chevauchement ci-dessus : la carte suivante n'apparait qu'apres le LANCEMENT du vol de la
## precedente, jamais avant), donc reveal_advance_requested n'a pas besoin de preciser QUELLE
## carte il concerne.
##
## Masque plein ecran bloquant (2026-09-02, 4e passe, retour utilisateur : "lorsque une carte
## est affichee a l ecran je veux qun masque empeche un click ailleurs, le joueur ne peut pas
## interagir avec autre chose que la carte, pas d action possible sur autre chose tant que la
## carte saffiche") : InputMask (voir le .tscn, ColorRect plein ecran MOUSE_FILTER_STOP, meme
## teinte que ConfirmOverlay/Dimmer dans shop_panel.tscn - Color(0,0,0,0.55), meme convention de
## "modal" visuelle que le reste du projet) - visible tant que _active_card_count > 0 (voir
## _update_input_mask, incremente/decremente autour de chaque CardSlot instanciee dans
## _reveal_card). Reste actif pendant TOUT l'affichage d'une carte - pop, attente ET vol -
## puisque "tant que la carte s'affiche" ne se limite pas a l'attente d'un declenchement. Ajoute
## en PREMIER enfant dans le .tscn : les CardSlot instanciees dynamiquement s'empilent toujours
## APRES (add_child ajoute a la fin), donc restent cliquables PAR-DESSUS le masque sans reglage
## supplementaire (le masque ne bloque que ce qu'il y a EN DESSOUS de lui dans l'ordre de
## dessin, jamais les cartes elles-memes).
##
## Tous les enfants de la CardSlot instanciee passent en MOUSE_FILTER_IGNORE (voir
## _force_mouse_filter_ignore) alors que la racine CardSlot reste au defaut MOUSE_FILTER_STOP
## (verifie dans la doc officielle Control.mouse_filter : STOP est deja la valeur par defaut de
## tout Control, y compris les Panel internes de CardSlot type CardFrame/InnerPanel - sans ce
## passage en IGNORE, un clic sur l'un de ces panneaux internes serait consomme LA, jamais
## remonte jusqu'au gui_input de la racine, puisque STOP bloque toute propagation vers le
## parent).
##
## Particules "paillettes" : CPUParticles2D sans texture (rend en petits carres plats, voir doc
## officielle CPUParticles2D - "particles will be squares" quand texture est null) plutot qu'une
## texture generee - un carre plat colle mieux a l'esprit "cartoon, pas de dégradé/flou" deja en
## place dans tout le reste de l'UI (voir CHARTE_GRAPHIQUE.md) qu'un rond avec un flou de bord.
## Couleur reprise de ProfSkinItem.ACTIVE_BORDER_COLOR (meme jaune/or "recompense") pour rester
## dans le meme systeme de couleurs que le reste de la boutique plutot que d'inventer une
## nouvelle teinte.
##
## Cible du vol = LivreButton (voir book_icon_path, assigne dans game_ui.tscn vers
## ../BackpackMenu/IconDock/IconList/LivreButton) : ce bouton n'est visible/positionne que
## lorsque la colonne BackpackMenu est ouverte, ce qui est garanti au moment d'un achat puisque
## ShopPanel n'est plus atteignable que par cette colonne depuis le retrait du kiosque (voir
## shop_panel.gd, "Kiosque en jeu retire") - si jamais introuvable (chemin invalide), repli sur
## le centre de l'ecran (la carte retrecit sur place plutot que de planter).
##
## LootFeed retire (ce meme retour utilisateur : "on supprimera en parallele le log de carte
## gagnee qui napparaissait plus au bon endroit") : ui/loot_feed/ supprime du disque, plus
## seulement desactive - son unique role (petit texte "+ Nom (Classe)" en bas a droite) est
## remplace par cette animation, qui rend la meme information (quelle carte, quelle classe, via
## le cadre CardSlot lui-meme) de facon beaucoup plus visible.
##
## Declenchement clavier retire (2026-09-02, plus tard le meme jour, retour utilisateur : "on
## supprime tous les raccourcis clavier, je veux un jeu qui se joue uniquement a la souris ou au
## tactile") : _unhandled_input() (ui_accept/ui_cancel, voir la 3e passe ci-dessus) est retire -
## le clic/tap sur la carte (_on_card_gui_input) reste le seul declencheur, ce qui suffisait deja
## a lui seul. _waiting_for_advance disparait avec lui (n'etait lu que par _unhandled_input, la
## logique d'attente elle-meme repose entierement sur "await reveal_advance_requested").
class_name CardRevealOverlay
extends Control

const CardSlotScene := preload("res://ui/collection/card_slot.tscn")

## Chemin vers LivreButton (voir commentaire de classe) - assigne dans game_ui.tscn.
@export var book_icon_path: NodePath

const POP_DURATION := 0.35
const FLY_DURATION := 0.45

## Grossissement au pop (2026-09-02, retour utilisateur : "augmente la taille des cartes de 50%
## quand elles pop et augmente l expansion des paillettes et leur nombre en proportion") : une
## seule constante pilote a la fois la taille finale de la carte (scale cible du pop_tween) ET le
## nombre/la portee des paillettes (voir _spawn_sparkles) pour que les deux restent proportionnels
## entre eux, comme demande, plutot que deux reglages independants a resynchroniser a la main a
## chaque futur ajustement.
const REVEAL_SCALE := 1.5

## Base a REVEAL_SCALE=1.0 (valeurs d'origine) - voir _spawn_sparkles pour la mise a l'echelle.
const PARTICLE_AMOUNT := 28
const PARTICLE_LIFETIME := 0.6
## Reprise de ProfSkinItem.ACTIVE_BORDER_COLOR (voir commentaire de classe).
const SPARKLE_COLOR := Color(1, 0.85, 0.2)

## Voir le commentaire de classe ("Declenchement du vol par le joueur").
signal reveal_advance_requested

var _queue: Array[CardResource] = []
var _processing := false

## Voir InputMask dans le .tscn et le commentaire de classe ("Masque plein ecran bloquant").
@onready var input_mask: ColorRect = $InputMask
## Nombre de CardSlot actuellement affichees (pop, attente ou vol en cours) - voir
## _update_input_mask.
var _active_card_count: int = 0

func _ready() -> void:
	EventBus.card_obtained.connect(_on_card_obtained)

## Clic souris OU tap tactile SUR la carte actuellement affichee (voir gui_input connecte dans
## _reveal_card, et le commentaire de classe sur MOUSE_FILTER_IGNORE des enfants) - meme effet
## que ui_accept/ui_cancel ci-dessus. N'ecoute QUE InputEventMouseButton, pas
## InputEventScreenTouch en plus : meme raisonnement deja documente dans
## interactable_component_2d.gd (_on_input_event) pour cette meme question - "Emulate Mouse From
## Touch" (reglage par defaut du moteur, non modifie dans ce projet) fait qu'un tap genere DEJA
## un InputEventMouseButton emule ; ecouter les deux ferait declencher reveal_advance_requested
## deux fois pour un seul tap.
func _on_card_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		reveal_advance_requested.emit()

## Force tous les descendants Control de [node] en MOUSE_FILTER_IGNORE (voir le commentaire de
## classe pour pourquoi) - la racine, elle, garde son MOUSE_FILTER_STOP par defaut.
func _force_mouse_filter_ignore(node: Node) -> void:
	for child in node.get_children():
		if child is Control:
			(child as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
		_force_mouse_filter_ignore(child)

## InputMask visible tant qu'au moins une carte est affichee (_active_card_count > 0) - voir le
## commentaire de classe.
func _update_input_mask() -> void:
	input_mask.visible = _active_card_count > 0

func _on_card_obtained(card: CardResource) -> void:
	if card == null:
		return
	_queue.append(card)
	if not _processing:
		_process_queue()

## Vide _queue une carte a la fois : voir le commentaire de classe pour la regle de
## chevauchement (_reveal_card ne resout son await qu'apres avoir LANCE le vol vers le livre,
## pas apres son arrivee).
func _process_queue() -> void:
	_processing = true
	while not _queue.is_empty():
		var card: CardResource = _queue.pop_front()
		await _reveal_card(card)
	_processing = false

## Fait apparaitre [card] en grand au centre de l'ecran (avec une explosion de paillettes),
## attend que le joueur declenche la suite (clic/tap dessus, ENTER ou ECHAP - voir le
## commentaire de classe), puis lance son vol-retrecissement vers le livre. Resout (return)
## juste apres avoir LANCE ce dernier tween - voir _process_queue().
func _reveal_card(card: CardResource) -> void:
	var quantity: int = CardCollection.get_quantity(card.id)
	var card_node := CardSlotScene.instantiate() as CardSlot
	add_child(card_node)
	_active_card_count += 1
	_update_input_mask()
	card_node.display(card, quantity)
	## Racine cliquable (MOUSE_FILTER_STOP, deja la valeur par defaut), enfants transparents au
	## clic (voir _force_mouse_filter_ignore et le commentaire de classe).
	_force_mouse_filter_ignore(card_node)

	## Taille visuelle reelle de la carte (voir CardSlot.CARD_SIZE/SHADOW_OFFSET) : ne depend pas
	## de card_node.size (une CardSlot hors conteneur garde sa taille par defaut a Vector2.ZERO,
	## seuls ses enfants se positionnent eux-memes avec des offsets fixes - voir card_slot.tscn).
	var card_rect_size: Vector2 = CardSlot.CARD_SIZE + Vector2(CardSlot.SHADOW_OFFSET, CardSlot.SHADOW_OFFSET)
	## Pivot au centre (voir doc Control.pivot_offset) : le scale ci-dessous (0 -> 1 puis 1 -> 0)
	## reste ainsi centre sur la carte au lieu de partir de son coin haut-gauche.
	card_node.pivot_offset = card_rect_size / 2.0

	var start_center: Vector2 = size / 2.0
	card_node.position = start_center - card_rect_size / 2.0
	card_node.scale = Vector2.ZERO

	_spawn_sparkles(start_center)
	## Synchronise avec l'explosion de paillettes ci-dessus, pas avec la fin du pop_tween.
	SoundManager.play(SoundManager.Sfx.CARD_REVEAL)

	## "Apparait en grand" : montee en echelle avec un leger rebond (TRANS_BACK, depasse 1.0 puis
	## revient) plutot qu'une simple montee lineaire, pour l'effet "pop" d'une recompense.
	var pop_tween := create_tween()
	pop_tween.tween_property(card_node, "scale", Vector2.ONE * REVEAL_SCALE, POP_DURATION) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await pop_tween.finished

	card_node.gui_input.connect(_on_card_gui_input)
	await reveal_advance_requested
	card_node.gui_input.disconnect(_on_card_gui_input)

	var end_center := start_center
	var book_button := get_node_or_null(book_icon_path) as Control
	if book_button:
		end_center = book_button.global_position - global_position + book_button.size / 2.0

	## "Se deplace en retrecissant rapidement... comme si elle etait aspiree" : position et scale
	## en parallele (set_parallel), acceleres (EASE_IN) plutot que lineaires, pour un mouvement
	## qui prend de la vitesse comme une aspiration. chain() avant le queue_free : attend la FIN
	## du groupe parallele (voir doc officielle Tween.chain - "cree un point sequentiel apres un
	## bloc parallele"), pas juste le premier des deux tweeners.
	var fly_tween := create_tween()
	fly_tween.set_parallel(true)
	fly_tween.tween_property(card_node, "position", end_center - card_rect_size / 2.0, FLY_DURATION) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	fly_tween.tween_property(card_node, "scale", Vector2.ZERO, FLY_DURATION) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	fly_tween.chain().tween_callback(func() -> void:
		_active_card_count -= 1
		_update_input_mask()
		card_node.queue_free()
	)
	## Pas de "await fly_tween.finished" ici : _reveal_card doit resoudre des que ce vol est
	## LANCE, pas termine (voir commentaire de classe et _process_queue).

## "Explosion de paillettes" centree sur [center] (espace local de ce Control). CPUParticles2D
## sans texture (carres plats, voir commentaire de classe) ; restart() plutot que de jouer avec
## "emitting" directement (methode recommandee par la doc officielle pour declencher une salve
## one_shot proprement). Auto-detruite un peu apres la fin du burst (PARTICLE_LIFETIME + marge).
## Nombre et portee (vitesse initiale, donc distance parcourue) mis a l'echelle par REVEAL_SCALE
## (voir sa doc plus haut) - "augmente l'expansion des paillettes et leur nombre en proportion" -
## seule la taille de chaque paillette (scale_amount_min/max) reste fixe, pas demandee.
func _spawn_sparkles(center: Vector2) -> void:
	var particles := CPUParticles2D.new()
	add_child(particles)
	particles.position = center
	particles.one_shot = true
	particles.explosiveness = 1.0
	particles.amount = roundi(PARTICLE_AMOUNT * REVEAL_SCALE)
	particles.lifetime = PARTICLE_LIFETIME
	particles.lifetime_randomness = 0.4
	particles.direction = Vector2.RIGHT
	particles.spread = 180.0
	particles.gravity = Vector2.ZERO
	particles.initial_velocity_min = 120.0 * REVEAL_SCALE
	particles.initial_velocity_max = 320.0 * REVEAL_SCALE
	particles.scale_amount_min = 3.0
	particles.scale_amount_max = 6.0
	particles.color = SPARKLE_COLOR
	particles.restart()
	get_tree().create_timer(PARTICLE_LIFETIME + 0.2).timeout.connect(particles.queue_free)
