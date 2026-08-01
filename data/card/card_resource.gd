## Une carte pet-shop a collectionner, editable dans l'inspecteur (fichier .tres).
## Un fichier .tres par carte : ajouter une carte au jeu = un nouveau fichier, pas de code.
class_name CardResource
extends Resource

## Alias local : GDScript ne peut pas exporter directement un enum d'une autre classe
## via un chemin pointe (GradeLevel.Grade) ; on "importe" l'enum dans une const locale.
const Grade = GradeLevel.Grade

@export var id: StringName = &""
## Categorie de l'animal (chien, chat, robot, extraterrestre...) : determine le design/art
## de la carte, en plus de la classe.
@export var category: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var texture: Texture2D
## Classe scolaire associee a cette carte (CP a CM2) : remplace l'ancien champ "rarity"
## depuis le 2026-07-26 - la rarete des cartes a disparu au profit d'une correspondance directe
## avec la classe (et, a terme, l'age - voir data/question/grade_level.gd et le futur plan
## d'i18n classe->age). La couleur du cadre reste pilotee via GradeLevel.get_color(grade).
@export var grade: Grade = Grade.CP
