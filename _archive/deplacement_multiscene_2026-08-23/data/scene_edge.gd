## Bord d'ecran (gauche/droite/aucun) utilise par EdgeTrigger2D et l'autoload SceneTransition pour
## savoir de quel cote de la scene suivante le joueur doit apparaitre en traversant un bord d'ecran
## (voir project_multi_scene_split en memoire, retour utilisateur 2026-08-10 : "sil sort par la
## droite il doit entrer par la gauche et inversement"). Classe utilitaire statique a part (meme
## principe que GradeLevel/SubjectType/CardRarity) plutot qu'un enum directement dans
## scene_transition.gd : un script autoload ne peut pas declarer un class_name identique a son nom
## d'autoload (Godot refuse ce conflit - "class X hides an autoload singleton"), donc l'enum doit
## vivre dans un script separe pour rester utilisable comme type d'export
## (@export var entry_edge: SceneEdge.Edge).
class_name SceneEdge
extends RefCounted

## NONE = entree "normale" (position deja fixee dans la scene, ex. porte de l'ecole via
## Signpost2D) : ne doit JAMAIS etre transmis par un EdgeTrigger2D, seulement valeur de repli.
enum Edge { NONE, LEFT, RIGHT }
