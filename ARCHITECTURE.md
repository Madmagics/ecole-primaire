# Architecture du projet

Principe : composition plutôt qu'héritage/scripts géants. Chaque comportement est un petit
composant réutilisable (un fichier .gd = une responsabilité), assemblé sur des scènes racines
courtes. Les contenus (questions, cartes, coffres) sont des `Resource` (.tres), pas du code.

## Dossiers

- `autoload/` — état global minimal (survit aux changements de scène) :
  `EventBus` (bus de signaux), `Economy` (pièces par matière), `CardCollection` (cartes possédées).
- `data/` — définitions de `Resource` réutilisables (le "contenu" du jeu, éditable en `.tres`
  sans toucher au code) : `question/` (QuestionResource, SubjectType), `card/` (CardResource,
  CardRarity), `loot/` (LootTableResource = un coffre, LootEntry = carte + poids).
- `entities/` — scènes du monde 3D, assemblées par composition :
  - `interactable/` : `InteractableComponent` générique (zone "Appuyer sur E"), réutilisé par
    PNJ, coffres et boutique.
  - `player/` : `player.tscn` + composants `MovementComponent` (déplacement) et
    `InteractorComponent` (détection + touche interact).
  - `npc/` : `npc.tscn` + `QuestionGiverComponent` (pose une question de son pool à
    l'interaction). Un PNJ maths et un PNJ français = la même scène, seules les ressources
    exportées changent.
  - `reward_chest/` : coffre qui tire une carte via une `LootTableResource`.
- `ui/` — fenêtres 2D réutilisables : `hud/` (compteurs de pièces), `interact_prompt/`,
  `question_panel/` (générique, pilotée par un QuestionResource), `shop/` (liste de coffres
  achetables), `collection/` (album de cartes).
- `levels/park/` — la scène du parc qui assemble PNJ, coffres et UI.
- `scripts/utils/` — utilitaires indépendants (ex. `WeightedRandom` pour le tirage des coffres).

## Ce qu'il reste à faire

- Créer les fichiers `.tres` de contenu dans `data/*/resources/` (une question = un fichier,
  une carte = un fichier, un coffre = un fichier) via l'inspecteur Godot.
- Habiller les scènes (mesh du perso/PNJ, décor du parc, style de l'UI) — actuellement squelettes
  fonctionnels sans art.
- Vérifier l'Input Map dans Project Settings (WASD + flèches pour se déplacer, E pour interagir,
  déjà pré-remplis dans `project.godot`).
- Brancher `question_started` (QuestionGiverComponent) → `QuestionPanel.display_question()` →
  `answered` → `QuestionGiverComponent.resolve_answer()` dans la scène `park.tscn`.
- Ajouter la sauvegarde (un futur autoload `SaveManager` s'insère facilement dans cette
  architecture sans rien casser).
