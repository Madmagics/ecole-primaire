## Une carte pet-shop a collectionner, editable dans l'inspecteur (fichier .tres).
## Un fichier .tres par carte : ajouter une carte au jeu = un nouveau fichier, pas de code.
class_name CardResource
extends Resource

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (CardRarity.Rarity) ; on "importe" l'enum dans une const locale.
const Rarity = CardRarity.Rarity

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var texture: Texture2D
@export var rarity: Rarity = Rarity.COMMON
