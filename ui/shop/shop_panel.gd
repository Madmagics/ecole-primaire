## Boutique : onglets horizontaux, "Cartes" (coffres par rarete) et "Classe" (deblocage des 5
## classes). Instancie un CrateItem.tscn par lot dans l'onglet Cartes, et un GradeUnlockItem.tscn
## par classe (CP a CM2) dans l'onglet Classe - meme base visuelle carree dans les deux onglets
## (voir CrateItem/GradeUnlockItem, retour utilisateur 2026-08-01 : "place les items a acheter
## sur la meme base que le premier onglet"). Les 5 classes restent TOUJOURS presentes dans
## l'onglet (memes retour : "les 5 classes doivent etre presentes"), sinon l'onglet finit vide
## une fois toute la progression achetee - chaque GradeUnlockItem se grise et affiche un "-" a la
## place du prix des qu'il est achete (voir GradeUnlockItem.refresh() pour le detail des etats).
## Ajouter un coffre au jeu = ajouter une LootTableResource a available_crates, sans code. Chaque
## case (coffre ou classe) est reactive au clic (pas de bouton "Acheter" dedie) : cliquer dessus
## ouvre une popup de confirmation (Oui/Annuler) avant tout achat reel.
class_name ShopPanel
extends Control

const CrateItemScene := preload("res://ui/shop/crate_item.tscn")
const GradeUnlockItemScene := preload("res://ui/shop/grade_unlock_item.tscn")

## Ordre d'affichage des raretes dans l'onglet Cartes : les valeurs de l'enum CardRarity.Rarity
## ne sont pas dans l'ordre "logique" (UNCOMMON=4 vient apres LEGENDARY=3, voir card_rarity.gd,
## commentaire au dessus de l'enum), donc un tri numerique naif melangerait l'affichage - liste
## explicite du moins au plus rare.
const RARITY_DISPLAY_ORDER: Array[CardRarity.Rarity] = [
	CardRarity.Rarity.COMMON,
	CardRarity.Rarity.UNCOMMON,
	CardRarity.Rarity.RARE,
	CardRarity.Rarity.EPIC,
	CardRarity.Rarity.LEGENDARY,
]

@export var available_crates: Array[LootTableResource] = []

@onready var item_grid: GridContainer = $Panel/Margin/Content/Tabs/Cartes/TabMargin/ItemGrid
@onready var class_item_grid: GridContainer = $Panel/Margin/Content/Tabs/Classe/TabMargin/ItemGrid
@onready var close_button: Button = $Panel/Margin/Content/HeaderRow/CloseButton
@onready var confirm_overlay: Control = $ConfirmOverlay
@onready var confirm_label: Label = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmLabel
@onready var cancel_button: Button = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmButtonRow/CancelButton
@onready var confirm_button: Button = $ConfirmOverlay/ConfirmCard/ConfirmMargin/ConfirmContent/ConfirmButtonRow/ConfirmButton

## Les 5 cases d'achat de classe (voir GradeUnlock), dans l'onglet Classe : une instance par
## GradeLevel.Grade (voir GradeUnlock.GRADE_ORDER), toujours toutes presentes - a la difference
## des coffres (available_crates), la liste des classes est fixe et connue d'avance.
var _grade_unlock_items: Array[GradeUnlockItem] = []

## Achat en attente de validation par la popup de confirmation (voir _ask_confirm) : n'est
## execute que si le joueur clique "Oui" ou valide avec Entree, jamais directement au clic sur
## une case.
var _pending_purchase: Callable

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un
	## enfant direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)

	confirm_overlay.hide()
	cancel_button.pressed.connect(_close_confirm)
	confirm_button.pressed.connect(_on_confirm_accepted)

	for grade in GradeUnlock.GRADE_ORDER:
		var grade_item := GradeUnlockItemScene.instantiate() as GradeUnlockItem
		grade_item.grade = grade
		grade_item.purchase_requested.connect(_on_grade_unlock_purchase_requested)
		class_item_grid.add_child(grade_item)
		_grade_unlock_items.append(grade_item)

	## Pas d'intitule de rarete affiche au-dessus de chaque groupe (retour utilisateur 2026-08-01 :
	## faisait repetition avec le nom du lot et la couleur de la piece) - RARITY_DISPLAY_ORDER ne
	## sert plus qu'a trier les lots du moins au plus rare, sans en-tete visuel. Les coffres sont
	## des cases carrees dans ItemGrid plutot que des lignes pleine largeur.
	for rarity in RARITY_DISPLAY_ORDER:
		var crates_of_rarity: Array = available_crates.filter(
			func(c: LootTableResource) -> bool: return c.rarity == rarity
		)
		for crate in crates_of_rarity:
			var item := CrateItemScene.instantiate() as CrateItem
			item.loot_table = crate
			item.purchase_requested.connect(_on_purchase_requested)
			item_grid.add_child(item)

	## Fige le joueur (deplacement + interaction) tant que la boutique est visible.
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
		## Le solde (et donc l'affordabilite du deblocage suivant) a pu changer depuis la
		## derniere ouverture (packs de questions reussis entre-temps) : recalcule a chaque
		## ouverture plutot qu'une seule fois a _ready().
		_refresh_grade_items()
	else:
		PlayerInputLock.unlock()
		_close_confirm()

func _on_grade_unlock_purchase_requested() -> void:
	if not GradeUnlock.has_next_grade():
		return
	var next_grade: GradeLevel.Grade = GradeUnlock.get_next_grade()
	var question := "Débloquer %s pour %d ?" % [GradeLevel.get_label(next_grade), GradeUnlock.UNLOCK_PRICE]
	_ask_confirm(question, _do_grade_unlock)

func _do_grade_unlock() -> void:
	GradeUnlock.try_unlock_next()
	_refresh_grade_items()

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if confirm_overlay.visible:
		if event.is_action_pressed("ui_cancel"):
			_close_confirm()
			get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()

## Appele par le kiosque (InteractableComponent.interacted, qui envoie "who") pour ouvrir la boutique.
func open(_who: Node = null) -> void:
	show()

## Appele aussi par le kiosque (InteractableComponent.unfocused) quand le joueur s'eloigne,
## par la croix de fermeture, et par la touche Echap (ui_cancel).
func close() -> void:
	hide()

func _on_purchase_requested(loot_table: LootTableResource) -> void:
	if loot_table == null:
		return
	var question := "Acheter « %s » pour %d ?" % [loot_table.crate_name, loot_table.crate_price]
	_ask_confirm(question, _do_purchase_crate.bind(loot_table))

func _do_purchase_crate(loot_table: LootTableResource) -> void:
	if Economy.try_spend(loot_table.rarity, loot_table.crate_price):
		var card := loot_table.draw_card()
		if card:
			CardCollection.add_card(card)
			EventBus.card_obtained.emit(card)
		## Un coffre commun/peu commun peut avoir depense la meme monnaie que celle requise
		## pour le deblocage suivant (voir GradeUnlock.get_unlock_currency) : rafraichit toutes
		## les cases de classe (celle qui est active se grise si le solde passe sous le seuil).
		_refresh_grade_items()

## Affiche la popup de confirmation d'achat au dessus de tout le panneau (coffre ou deblocage
## de classe, voir _on_purchase_requested / _on_grade_unlock_purchase_requested). Le bouton
## "Oui" recoit le focus par defaut : Entree/ui_accept le declenche donc directement. Echap
## (ui_cancel, voir _unhandled_input) annule sans rien acheter.
func _ask_confirm(text: String, on_confirm: Callable) -> void:
	confirm_label.text = text
	_pending_purchase = on_confirm
	confirm_overlay.show()
	confirm_button.grab_focus()

func _on_confirm_accepted() -> void:
	var callback := _pending_purchase
	_close_confirm()
	if callback.is_valid():
		callback.call()

func _close_confirm() -> void:
	confirm_overlay.hide()
	_pending_purchase = Callable()

## Rafraichit les 5 cases de classe d'un coup (voir GradeUnlockItem.refresh()) : plus simple
## qu'identifier laquelle a besoin d'etre mise a jour, et l'operation est peu couteuse (5 petits
## StyleBoxFlat a reconstruire, jamais dans une boucle de _process).
func _refresh_grade_items() -> void:
	for grade_item in _grade_unlock_items:
		grade_item.refresh()
