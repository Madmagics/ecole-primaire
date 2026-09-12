## Bus d'evenements global : decouple les systemes entre eux (NPC, boutique, UI, coffres...).
## Regle : un composant emet/ecoute ici plutot que de connaitre directement les autres composants.
extends Node

## Emis quand un PNJ a termine de corriger un pack de questions. total_count = taille reelle du
## pack (10 pour Math/Lecture, mais variable - 10/15/20/25 - pour Grammaire/Conjugaison/
## Orthographe/Anglais depuis la mecanique de pack de revision, voir QuestionGiverComponent et
## FRANCAIS_DIFFICULTE.md).
## @warning_ignore("unused_signal") : faux positif connu depuis Godot 4.3 pour un signal declare
## dans un singleton "bus d'evenements" mais toujours emis depuis D'AUTRES scripts (ici via
## EventBus.xxx.emit(), jamais emit_signal() localement) - confirme sur docs.godotengine.org/
## le tracker officiel (godotengine/godot#95403), pas une regression a corriger dans le code lui-
## meme. Applique aux 4 signaux de ce fichier.
@warning_ignore("unused_signal")
signal pack_completed(subject: SubjectType.Subject, rarity: CardRarity.Rarity, correct_count: int, total_count: int, reward: int)

## Emis quand une carte est obtenue (coffre ouvert, achat en boutique...).
@warning_ignore("unused_signal")
signal card_obtained(card: CardResource)

## Emis par SubjectSelectPanel une fois la matiere choisie. Passe par EventBus (plutot qu'un
## signal local + connexions par-PNJ dans chaque scene, comme avant) expres : ce signal doit
## etre diffuse a TOUS les PNJ a la fois (chaque QuestionGiverComponent.start_pack_for_subject
## s'auto-filtre sur "source"), et une connexion posee dans un fichier .tscn s'est retrouvee
## perdue plusieurs fois (reconstruction de scene depuis un autre niveau qui ne l'avait pas,
## ou ecrasee par un enregistrement depuis l'editeur pendant que la scene etait ouverte avec
## un fichier modifie hors-editeur). Chaque QuestionGiverComponent s'auto-connecte a ce signal
## dans son _ready() (voir question_giver_component.gd) : ca ne peut plus se perdre au
## rechargement/enregistrement d'une scene, contrairement a une connexion posee dans le .tscn.
@warning_ignore("unused_signal")
signal subject_selected(source: Node, subject: SubjectType.Subject)


## Emis par SaveManager.set_ui_theme() quand le theme d'interface change. Ecoute par chaque
## panneau racine sous UI/ (CanvasLayer) : un CanvasLayer n'est pas un Control/Window, il coupe
## la propagation automatique de Theme (voir doc officielle Window.theme, Godot 4.7 : le theme
## se propage "a ce noeud et a tous ses enfants Control et Window") - impossible donc de
## reskinner tout d'un coup via get_tree().root.theme comme on le ferait sans CanvasLayer. Chaque
## panneau s'applique donc son propre theme (theme = ...) a la reception de ce signal.
@warning_ignore("unused_signal")
signal ui_theme_changed(theme: Theme)
