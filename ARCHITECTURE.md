# Architecture du projet

Principe : composition plutôt qu'héritage/scripts géants. Chaque comportement est un petit
composant réutilisable (un fichier .gd = une responsabilité), assemblé sur des scènes racines
courtes. Les contenus (questions, cartes, coffres) sont des `Resource` (.tres), pas du code.

## Dossiers

- `autoload/` — état global minimal :
  `EventBus` (bus de signaux), `Economy` (pièces par **rareté** — commune, peu commune, rare,
  épique, légendaire ; les pièces d'une rareté achètent les coffres de cette même rareté),
  `CardCollection` (cartes possédées), `PlayerInputLock` (compteur de fenêtres modales ouvertes ;
  `MovementComponent`/`InteractorComponent` s'y réfèrent pour figer le joueur pendant qu'une
  fenêtre — question, boutique, choix de classe, menu de jeu — est ouverte), `StatsTracker`
  (progression : packs réussis, précision, répartition par matière — écoute
  `EventBus.pack_completed`, ne connaît aucun PNJ directement), `GradeUnlock` (progression des
  classes accessibles aux PNJ — seul CP est débloqué au démarrage ; CE1→CM2 se débloquent un par
  un contre 500 pièces de la monnaie de la classe la plus avancée déjà débloquée, achat fait
  depuis `ShopPanel`/`GradeUnlockItem` ; émet `grade_unlocked`, écouté par chaque
  `QuestionGiverComponent` pour se griser/dégriser et bloquer/débloquer son interaction sans
  recharger la scène — voir 2026-07-21 dans `csv/questions/ID_RANGES.md` pour le contexte),
  `SaveManager` (survit lui à un **redémarrage** du jeu, contrairement aux autres autoloads
  ci-dessus qui ne survivent que d'une scène à l'autre au sein d'une même session : sérialise
  `Economy`/`CardCollection`/`StatsTracker`/`GradeUnlock` + les réglages volume/plein écran/touches
  dans un seul fichier `user://savegame.json` — voir section "Menu de jeu" plus bas). Ordre
  d'`[autoload]` dans `project.godot` important : `StatsTracker`/`GradeUnlock` doivent être
  chargés avant `SaveManager` (qui les appelle dans `load_game()`).
- `csv/` — TOUS les fichiers CSV du projet (source du contenu en masse), à la racine pour rester
  faciles à retrouver : `cards.csv`, `questions/math/`, `questions/french/`... (voir section
  "Outils admin" plus bas). Les `.tres` générés à partir de ces CSV vivent dans `data/`.
- `data/` — définitions de `Resource` réutilisables (le "contenu" du jeu, éditable en `.tres`
  sans toucher au code) : `question/` (QuestionResource, SubjectType), `card/` (CardResource,
  CardRarity), `loot/` (LootTableResource = un coffre, LootEntry = carte + poids).
- `entities/` — scènes du monde 3D, assemblées par composition :
  - `interactable/` : `InteractableComponent` générique (zone "Appuyer sur E"), réutilisé par
    PNJ, coffres et boutique.
  - `player/` : `player.tscn` + composants `MovementComponent` (déplacement), `InteractorComponent`
    (détection + touche interact), `CameraRig` (cadrage suivi + cadrage activation) et
    `InteractionFacing` (joueur/interactable face à face pendant l'activation) — voir "Caméra et
    déplacement" plus bas pour les trois derniers.
  - `world_view/` : `world_view_blur.gd` + `world_blur.gdshader` — flou du monde 3D pendant un
    panneau modal, posés sur le `SubViewportContainer` de `levels/park/park.tscn` (voir "Flou du
    monde pendant un panneau modal" plus bas). Pas de scène propre : ce sont des composants
    attachés directement aux nœuds de `park.tscn`.
  - `npc/` : `npc.tscn` + `QuestionGiverComponent`. Chaque PNJ représente le "maître/maîtresse"
    d'une **classe fixe** (`grade`, CP à CM2) — comme à l'école primaire réelle, où un seul
    enseignant couvre toutes les matières d'une classe (contrairement à un PNJ par matière, plus
    "collège/lycée" ; bascule faite le 2026-07-20, voir `MATIERES_CANDIDATES.md`). À
    l'interaction, demande d'abord la **matière** parmi celles disponibles pour cette classe
    (via `SubjectSelectPanel`), puis compose un pack : toujours **`PACK_SIZE` (10) questions au
    total** (retour utilisateur 2026-08-01, "questionnaires à rallonge" — avant cette date, un
    pack de révision pouvait monter à 10-25 questions), soit **10 questions au hasard** dans la
    classe du PNJ (Maths, Comprehension de texte — celle-ci via un flux dédié, voir plus bas),
    soit un **pack de révision** réparti entre la classe du PNJ et les classes antérieures pour
    Grammaire/Conjugaison/Orthographe/Anglais (`REVIEW_SUBJECTS`, `_build_review_pack` +
    `_compute_review_quotas`/`_distribute_quota` pour la mise à l'échelle sur 10 — voir
    `FRANCAIS_DIFFICULTE.md` pour le barème complet, ajouté le 2026-07-21 suite à un contenu
    insuffisamment différencié par classe).
    `question_pool` est vide par défaut dans `park.tscn` : au démarrage, si vide,
    `QuestionGiverComponent` scanne automatiquement `data/question/resources/<classe>/` (donc
    toutes les matières de sa classe, voir `GradeLevel.get_folder_name()`) — pas besoin de
    re-câbler la scène à la main à chaque ajout de contenu en masse. Ne remplir `question_pool`
    à la main dans l'inspecteur que pour limiter un PNJ à un sous-ensemble spécifique de
    questions. Un PNJ de CP et un PNJ de CM2 = la même scène, seules les ressources exportées
    (`grade`, `question_pool`) changent ; les matières proposées par un PNJ sont déduites du
    contenu réellement chargé (`get_available_subjects()`), pas d'une liste figée — une nouvelle
    matière apparaît automatiquement dès qu'un CSV est importé pour cette classe. La classe du
    PNJ détermine la rareté des pièces gagnées (`GradeLevel.get_rarity()` : CP=commune,
    CE1=peu commune, CE2=rare, CM1=épique, CM2=légendaire) — impossible de "se déclarer" plus
    jeune pour farmer des pièces avec des questions faciles, le gain reste plafonné à la classe
    du PNJ interrogé. Dans cette rareté, la récompense dépend ensuite du score sur le pack, voir
    `CardRarity.get_pack_reward()`, en pourcentage de réussite mis à l'échelle sur la taille
    réelle du pack (100% → 10 pièces sur un pack de 10 questions) : 100% → barème plein, 90% →
    5/10, 80% → 4/10, 70% → 3/10, 60% → 2/10, 50% → 1/10, en dessous de 50% → 0 (même barème pour
    toutes les classes/raretés actuellement). Généralisé le 2026-07-21 depuis un barème fixé sur
    10 questions car un pack de révision (voir ci-dessus) pouvait alors faire 10 à 25 questions ;
    depuis le passage de tous les packs à 10 questions fixes (2026-08-01), la mise à l'échelle
    retombe systématiquement sur le barème d'origine, mais la formule générale reste en place
    (pas de raison de la refixer en dur). `EventBus.pack_completed` transporte le `total_count`
    du pack pour permettre ce calcul et les stats.
  - **Verrouillage par classe** (2026-07-21, voir `GradeUnlock` ci-dessus) : au `_ready()` et à
    chaque `GradeUnlock.grade_unlocked`, chaque PNJ grise son propre `MeshInstance3D`
    (`material_override` gris tant que `GradeUnlock.is_unlocked(grade)` est faux) et bloque son
    interaction (`_on_interacted` renvoie `pack_unavailable` avec un message d'invite à l'achat
    au lieu d'ouvrir `SubjectSelectPanel`). Générique par construction (recherche le sibling
    `MeshInstance3D`/écoute le signal global) : s'applique automatiquement à tout PNJ existant ou
    futur, pas besoin de câblage par instance dans `park.tscn`.
  - `reward_chest/` : coffre qui tire une carte via une `LootTableResource` (non utilisé dans
    `park.tscn` actuellement — la boutique est le seul moyen d'obtenir des cartes ; ce composant
    reste disponible pour un futur cadeau/événement ponctuel).
  - `shop_kiosk/` : point d'accès à la boutique dans le monde (pas de script propre, juste un
    `InteractableComponent` dont le signal `interacted` est branché sur `ShopPanel.open()`).
- `ui/` — fenêtres 2D réutilisables : `hud/` (compteurs de pièces), `interact_prompt/`,
  `subject_select/` (choix de la matière avant un pack, parmi celles disponibles pour la classe
  du PNJ interrogé), `question_panel/` (générique, pilotée par un tableau de QuestionResource),
  `shop/` (liste de coffres achetables, prix uniforme de 50 pièces pour les 5 coffres depuis le
  2026-07-21, + une ligne `GradeUnlockItem` en tête de liste pour acheter la classe suivante à
  500 pièces via `GradeUnlock`, masquée une fois CM2 débloqué), `collection/` (livre de cartes plein écran, une page =
  une catégorie), `loot_feed/` (journal des derniers loots, bas-droite), `game_menu/` (menu de
  jeu, voir section dédiée plus bas).
- `levels/park/` — la scène du parc qui assemble PNJ, coffres et UI.
- `scripts/utils/` — utilitaires indépendants (ex. `WeightedRandom` pour le tirage des coffres,
  `CsvResourceImporter` pour les outils admin CSV → Resource).
- `tools/admin/` — scripts `@tool` (EditorScript) à lancer manuellement depuis l'éditeur pour
  importer/mettre à jour du contenu en masse depuis un CSV, sans dupliquer les fichiers à la main.

## Caméra et déplacement (2026-07-21)

Décision explicite (public visé : 5-10 ans) : contrôles **"world-relative"** (les touches
gauche/droite/haut/bas correspondent toujours à gauche/droite/haut/bas à l'écran, quelle que soit
l'orientation du personnage) + caméra **fixe en plongée qui ne pivote jamais avec les touches**.
Pas de caméra orbitale/3e personne classique (souris ou stick pour tourner autour du perso) : ça
ajouterait un deuxième axe de contrôle à coordonner avec le déplacement, ce qui est bien plus dur
à cet âge (surtout en dessous de 7-8 ans) qu'un jeu vu du dessus/en angle où "gauche" veut
toujours dire la même chose. C'est le même principe que des jeux comme Animal Crossing ou
Pokémon (vue fixe, pas de caméra libre) plutôt qu'un jeu de plateforme 3D à la manette.

- **`MovementComponent`** (`entities/player/components/movement_component.gd`) : la logique de
  déplacement elle-même n'a pas changé (world-relative, voir plus haut) — seul ajout : le
  personnage tourne maintenant visuellement pour faire face à sa direction de déplacement
  (`_update_facing`, `lerp_angle` vers `atan2(-direction.x, -direction.z)`, convention Godot
  "avant = -Z locale"). Purement cosmétique : ça ne touche pas à `body.velocity.x/z` qui restent
  en axes du monde. Corrige l'effet "crabe" (le perso glissait sans jamais se tourner) sans
  complexifier les touches. Si un futur modèle importé est orienté vers +Z plutôt que -Z, corriger
  via une rotation locale fixe sur le `MeshInstance3D`, pas en touchant `_update_facing`.
- **`CameraRig`** (`entities/player/components/camera_rig.gd`, composant du joueur) : deux
  cadrages, jamais de rotation en réponse aux touches de déplacement.
  - **Cadrage "suivi"** (par défaut) : plongée fixe (**`pitch_degrees`**, 40° par défaut) —
    compromis entre vue d'ensemble (utile pour repérer les PNJ/le kiosque) et lisibilité des
    futurs modèles 3D (un angle proche de 90°/vue du dessus aplatit tout en silhouettes, peu
    flatteur pour du décor/perso stylisés). Seule la position suit le joueur en douceur
    (`follow_speed`, lerp) ; l'orientation reste constante.
  - **Cadrage "activation"** (depuis 2026-07-23) : dès qu'un panneau modal s'ouvre
    (`PlayerInputLock.lock_changed(true)` — question, boutique... c'est-à-dire une interaction
    réellement **activée** avec E, pas juste une proximité) et qu'un `InteractableComponent` est
    à l'origine du verrouillage (suivi via `EventBus.interactable_focused/unfocused`, déjà
    utilisé par `InteractorComponent`), la caméra se repositionne **face à l'interactable, à
    hauteur d'yeux (`focus_eye_height`, pas de plongée)** et **zoomée** pour montrer joueur et
    interactable ensemble. Géométrie : la caméra se place sur l'axe interactable→joueur (le
    joueur approche forcément l'interactable pour l'activer, cet axe donne donc une direction
    "de face" correcte sans qu'aucun interactable n'ait besoin de définir sa propre orientation
    avant), à une distance `focus_min_distance`/`focus_back_margin` au-delà du joueur, visant un
    point pondéré (`focus_look_weight`) entre les deux. Revient au cadrage suivi à la fermeture
    du panneau. Ce changement de rotation ne contredit pas la règle "la caméra ne pivote jamais
    avec les touches" : ce n'est pas un déplacement qui la déclenche mais un état de jeu
    explicite (E), pendant lequel `MovementComponent` fige justement le joueur.
  - Implémentation : calcule chaque frame une position ("oeil") et un point visé ("look_at")
    désirés selon le mode actif, puis fait glisser la caméra réelle vers ces valeurs (lerp de
    position + `look_at()` recalculé sur la position lissée, pas de slerp de quaternion à gérer
    à la main). L'ancien `SpringArm3D` (bras à inclinaison fixe) a été abandonné : son
    pivot+ressort ne peut pas exprimer une orientation arbitraire "face à l'interactable". Son
    évitement de collision automatique est donc perdu — à réintroduire (ex. raycast œil→cible)
    si le décor futur ajoute des obstacles hauts près de la caméra.
  - Tous les réglages (`pitch_degrees`, `heading_degrees`, `distance`, `pivot_height`,
    `follow_speed`, `focus_eye_height`, `focus_min_distance`, `focus_back_margin`,
    `focus_look_weight`, `focus_transition_speed`) sont des `@export` ajustables dans
    l'inspecteur sans toucher au code.
- **`InteractionFacing`** (`entities/player/components/interaction_facing.gd`, composant du
  joueur, indépendant de `CameraRig` — les deux réagissent séparément aux mêmes signaux globaux)
  : pendant le cadrage "activation" ci-dessus, fait tourner le joueur **et** le propriétaire de
  l'interactable (le parent du `InteractableComponent` — PNJ, kiosque... pas le
  `InteractableComponent` lui-même, qui n'est qu'une zone de détection Area3D sans maillage) l'un
  vers l'autre, "face à face", le long de l'axe horizontal qui les sépare (`turn_speed`,
  `lerp_angle`, même formule `atan2` que `MovementComponent._update_facing`). Générique par
  construction : marche pour tout interactable dont le parent est un `Node3D` ; un objet
  statique/symétrique (ex. le kiosque actuel, une simple boîte) tourne "pour rien" — aucun effet
  visible, pas besoin de le traiter à part.
  - Capture l'orientation des deux au moment où le panneau s'ouvre
    (`PlayerInputLock.lock_changed(true)`), et les y ramène en douceur sur `return_duration`
    secondes à la fermeture — en même temps que `CameraRig` dézoome, puisque déclenché par le
    même signal. Ne déclenche rien si le verrouillage vient d'un panneau ouvert au bouton (menu,
    album) sans interactable associé.
  - Pendant le retour, laisse la main à `MovementComponent` dès que le joueur fournit une
    entrée de déplacement réelle (`Input.get_vector` non nul), pour que les deux composants ne se
    disputent pas `rotation.y` la même frame si le joueur repart marcher immédiatement après
    avoir fermé le panneau.

### Flou du monde pendant un panneau modal (2026-07-23)

Demande : flouter la vue 3D pendant qu'un panneau (boutique, futur "book de cartes", etc.) est
ouvert, en gardant l'UI nette — sans coder ce comportement par type de panneau.

Le projet tourne en **renderer Compatibility** (`renderer/rendering_method="gl_compatibility"`
dans `project.godot`). Deux pistes ont été écartées après vérification (recherche web,
docs.godotengine.org) :
- **Depth of Field / SSAO / SSR intégrés (Environment)** : réservés au renderer Forward+, pas
  disponibles en Compatibility.
- **Shader `canvas_item` avec `hint_screen_texture`/`SCREEN_TEXTURE`** : techniquement possible en
  Godot 4, mais bugs connus spécifiques au renderer Compatibility (filtrage, écran noir au
  redimensionnement — issues godotengine/godot#97728, #106787).

Solution retenue, indépendante du renderer : tout le contenu 3D de `levels/park/park.tscn` est
rendu dans un **`SubViewport`**, affiché via un **`SubViewportContainer`** (`WorldViewport`,
`stretch = true` pour suivre la taille de la fenêtre) qui porte un `ShaderMaterial`
(`entities/world_view/world_blur.gdshader`). Le shader ne lit que `TEXTURE` (la texture propre à
ce nœud, cf. tutoriel officiel "Using a SubViewport as a texture") — jamais de lecture
écran-relative, donc aucun des bugs Compatibility ci-dessus. `UI` (le `CanvasLayer` existant)
reste un frère de `WorldViewport`, déclaré après lui dans `park.tscn` : elle se dessine par-dessus
et n'est jamais affectée par le flou.

`entities/world_view/world_view_blur.gd` (posé sur `WorldViewport`) écoute uniquement
`PlayerInputLock.lock_changed` — le même signal générique déjà utilisé pour verrouiller les
contrôles à l'ouverture de n'importe quel panneau modal — et anime le paramètre `blur_amount` du
shader (`create_tween().tween_method`) entre 0 (net) et `blur_strength` (flou, `@export`,
"réglable par composition" comme demandé) sur `transition_time` secondes. Générique par
construction : tout futur panneau (book de cartes...) est flouté par le simple fait de passer par
`PlayerInputLock` comme les autres, sans code supplémentaire ici.

## Outils admin (import CSV)

Tous les CSV du projet (cartes, questions...) vivent sous **`csv/` à la racine du projet**, pas
dispersés dans `data/` — plus simple à retrouver au fur et à mesure que le contenu grossit :

```
csv/
  cards.csv
  questions/
    math/    (un ou plusieurs fichiers .csv)
    french/  (un ou plusieurs fichiers .csv)
```

Pour ajouter beaucoup de cartes sans créer chaque `.tres` à la main dans l'éditeur :

1. Ajouter/modifier des lignes dans `csv/cards.csv` (colonnes : `id;categorie;nom;rarete`,
   séparateur `;`). `id` = numéro unique et permanent (ne jamais réutiliser/décaler un id une fois
   assigné, les cartes seront un jour échangées entre joueurs). Convention : blocs de 5 id
   consécutifs par espèce/design (un par rareté), ex : 1-5 = Chat de gouttière, 6-10 = Chat
   siamois... `rarete` accepte `commune`/`peu commune`/`rare`/`epique`/`legendaire` (ou leurs
   équivalents anglais).
2. (Optionnel, pour plus tard) Déposer l'illustration de chaque carte dans `data/card/art/`,
   nommée `<id>.png` (ex: `1.png` pour la carte id `1`) — l'import l'assigne automatiquement au
   champ `Texture` de la carte correspondante. Format retenu : ratio 2:3, source PNG 1024×1536 px
   (proche d'une puissance de 2, bonne qualité mipmaps/compression mobile ; un seul fichier par
   carte suffit, Godot adapte à l'export PC/mobile).
3. Ouvrir `tools/admin/import_cards.gd` dans l'éditeur Godot.
4. **File > Run** (ou `Ctrl+Shift+X`) pour lancer le script.
5. Les fichiers `.tres` correspondants sont créés/mis à jour dans `data/card/resources/` (le nom
   de fichier = la colonne `id`). La description assignée à la main sur une carte existante n'est
   pas écrasée par le script (seuls les champs gérés par le CSV/art sont mis à jour).

`CsvResourceImporter` (dans `scripts/utils/`) est générique : le même principe peut servir de base
à un futur importeur pour d'autres types de contenu (objets...) — il suffit d'écrire un nouveau
petit script dans `tools/admin/` qui définit le mapping colonnes → Resource, sans dupliquer la
lecture/écriture du CSV.

### Questions (import_questions.gd)

Un CSV ne peut pas avoir plusieurs "sheets" (concept propre à Excel/.xlsx) : l'architecture est
donc **un dossier par classe** (`cp`/`ce1`/`ce2`/`cm1`/`cm2`), **puis un sous-dossier par
matière**, pouvant chacun contenir **autant de fichiers CSV que voulu** — classe et matière sont
déduites du chemin du dossier, pas de colonnes. Classe en premier (et non matière en premier,
comme au tout début du projet) car de nouvelles matières apparaîtront à partir de certaines
classes seulement (ex. anglais dès le CE1) sans exister à toutes les classes ; un dossier
`<classe>/<matière>/` absent est simplement ignoré à l'import plutôt que de forcer un dossier
vide pour chaque classe où la matière n'existe pas encore. Si le contenu est préparé dans Excel,
exporter chaque onglet en CSV séparé et le déposer dans le bon dossier :

```
csv/questions/
  cp/
    math/    (un ou plusieurs .csv)
    french/  ...
  ce1/
    math/ french/ (+ futures matières)
  ce2/ cm1/ cm2/
    ...
```

Chaque classe (`cp` à `cm2`) n'a qu'**un seul fichier CSV**, `generated.csv` (banque générée
alignée sur le programme Éducation nationale — réforme 2025 pour CP à CM1, programme cycle 3
classique inchangé pour CM2 cette année ; réponses numériques sans unité). **Les accents sont
obligatoires** dans tout le texte français (titre, questions, choix, passages de lecture) —
convention inverse de celle d'origine (2026-07-19, "texte sans accents pour rester simple à taper
au clavier") qui n'avait plus de sens une fois le jeu passé en QCM (boutons, pas de saisie
clavier) : elle empêchait certaines questions d'orthographe/grammaire d'avoir une bonne réponse
distincte (ex. "où" vs "ou" rendus identiques). Revue et corrigée intégralement le 2026-07-21
(accents, élisions, auxiliaires être/avoir, accords de participe, cohérence des distracteurs) —
voir `ID_RANGES.md` pour la note correspondante. Toute nouvelle question doit être tapée avec les
accents corrects dès l'écriture du CSV, avec 200 questions par classe sauf
`math/cp` et `french/cp` qui n'en ont que 190 (les `base.csv` d'origine, 10 questions chacun, ont
été retirés le 2026-07-19 pour harmoniser la structure — un seul fichier par classe partout).
Tranches d'id : voir `csv/questions/ID_RANGES.md`, à consulter/mettre à jour avant de créer un
nouveau fichier CSV.

**Matières au-delà de Maths/Français :** `SubjectType.Subject` n'est plus limité à `MATH`/
`FRENCH` — voir `MATIERES_CANDIDATES.md` (racine du projet) pour la revue classe par classe des
matières candidates et les décisions prises. Le français de CE1 à CM2 a été scindé le
2026-07-20 en trois matières distinctes (le contenu existant était déjà quasi entièrement de ce
type, reclassé automatiquement par motif sur le texte de la question, pas régénéré) :
`GRAMMAR` ("Grammaire" : accords, nature des mots), `CONJUGATION` ("Conjugaison"),
`SPELLING` ("Orthographe" : le reste — contraire/synonyme/homophones/divers). `ENGLISH`
("Anglais") et `READING` ("Comprehension de texte" — le dossier reste `lecture`, seul le
libellé affiché change) sont branchés. Ajouter une matière = un nouveau cas dans `SubjectType`
(valeur figée, jamais réutilisée, voir commentaire dans le fichier) + une entrée dans
`SUBJECT_FOLDERS` de `import_questions.gd` (sauf `READING`, qui a son propre outil d'import
dédié — `tools/admin/import_reading.gd` — une question de "Comprehension de texte" étant
toujours liée à un texte, voir `PassageResource`/`QuestionResource.passage` et
`LECTURE_DIFFICULTE.md`) + un dossier `csv/questions/<classe>/<matière>/`, sans toucher au
reste (l'arborescence classe → matière gère nativement une matière absente à certaines
classes).

**"Comprehension de texte" (READING) — mécanique dédiée (2026-07-21, voir
`LECTURE_DIFFICULTE.md`) :** contrairement aux autres matières (échantillon plat de
`QuestionResource`), une question de lecture est toujours liée à un `PassageResource` (texte
complet, référencé directement via `QuestionResource.passage`). `QuestionGiverComponent.
_start_reading_pack` tire un passage au hasard dans la classe du PNJ, réunit toutes ses
questions liées puis n'en tire que `PACK_SIZE` (10) au hasard **(2026-07-31)** : la banque par
texte peut dépasser 10 (CE1 à CM2 : 20 en banque depuis le batch de 47 histoires du 2026-07-30),
pour qu'une relecture du même texte ne repose pas systématiquement les mêmes questions dans le
même ordre — tirage purement aléatoire, sans recalcul des quotas L/V/I sur les 10 tirées (décision
explicite de l'utilisateur). Au CP la banque ne compte que 10 questions par texte (= `PACK_SIZE`),
donc pas de variation possible. Émet `reading_pack_started` (pas `pack_started`) : `ReadingIntroPanel`
(`ui/reading_intro/`) affiche d'abord le texte, puis relaie vers `QuestionPanel` au clic sur
"Commencer" — sans aucun moyen de revenir au texte ensuite. Exclu de `REVIEW_SUBJECTS` (pas de
pack de révision multi-classes pour cette matière, contrairement à Grammaire/Conjugaison/
Orthographe/Anglais).

1. Ajouter/modifier des lignes dans un fichier sous `csv/questions/<classe>/<matière>/`
   (colonnes : `id;text;correct_answer;choice_2;choice_3;choice_4`, séparateur `;`). `id` sert de
   nom de fichier (contrairement aux cartes, les questions ne sont pas échangées entre joueurs,
   pas besoin de stabilité long terme, mais éviter quand même de réutiliser un id). **Tranche
   d'id à utiliser : voir `csv/questions/ID_RANGES.md`** — chaque fichier CSV reçoit un bloc dédié
   de 1000 id (1000-1999, 2000-2999...) attribué dans l'ordre de création des fichiers ; toujours
   mettre ce registre à jour en créant un nouveau fichier CSV. `choice_2/3/4`
   sont optionnelles : mauvaises réponses pour le mode QCM par boutons (voir plus bas) — laisser
   vide si non utilisées (la question reste alors en saisie clavier).
2. Ouvrir `tools/admin/import_questions.gd` dans l'éditeur Godot puis **File > Run**.
3. Les fichiers `.tres` sont créés/mis à jour dans `data/question/resources/<classe>/<matière>/`
   (même arborescence que `csv/questions/`, pour rester lisible dans le dock) : contrairement aux
   cartes, aucun champ de `QuestionResource` n'est réservé à l'édition manuelle — tout vient du
   CSV. Chaque PNJ (`QuestionGiverComponent`) scanne **récursivement** le sous-dossier de sa
   propre classe (`data/question/resources/<classe>/`, voir `_scan_dir`) : il ne connaît pas les
   noms des sous-dossiers matière, seulement le champ `subject` de chaque ressource chargée
   (utilisé pour proposer les matières disponibles, voir `get_available_subjects()`), donc
   l'arborescence peut encore évoluer plus tard sans casser le chargement en jeu.

**Un `.tres` par CSV, pas par question (évolution 2026-08-01) :** jusqu'à début août 2026, chaque
ligne de CSV produisait son propre fichier `.tres` (nommé par `id`) — simple, mais devenu coûteux
une fois les banques de maths passées à 500-1000 questions par classe : au total 10 144 fichiers
`.tres` sous `data/question/resources/`, chacun ouvert individuellement par `_scan_dir` au
démarrage (chaque PNJ charge **tout** le dossier de sa classe dans `_ready()`, toutes matières
confondues — jusqu'à ~2263 ouvertures de fichier pour le PNJ CE1 à lui seul). Sur un système de
fichiers lent (antivirus, disque réseau...), ça peut se traduire par un temps de chargement
perceptible à l'entrée du parc — voir discussion utilisateur du 2026-08-01. Corrigé en regroupant
toutes les questions d'**un même fichier CSV** dans **un seul** `QuestionBankResource`
(`data/question/question_bank_resource.gd`, `@export var questions: Array[QuestionResource]`),
nommé d'après la **matière** quand un seul CSV existe dans son dossier (`math.tres`,
`french.tres`... — cas de 28 des 33 dossiers) ou d'après le CSV source quand plusieurs CSV
cohabitent dans le même dossier (`lecture/` : `generated.tres` + `histoires_generated.tres` —
nommer les deux `lecture.tres` aurait été ambigu ; règle choisie après retour utilisateur
2026-08-01, un nom de fichier identique dans presque tous les dossiers rendait la recherche
rapide/les onglets Godot peu lisibles) : `import_questions.gd` et
`import_reading.gd` construisent le tableau en mémoire en lisant tout le CSV, puis un seul
`ResourceSaver.save()` écrit tout le fichier — ~30 fichiers `.tres` au total pour les 10 144
questions actuelles, au lieu d'un par question. `_scan_dir` charge chaque `.tres` rencontré comme
`QuestionBankResource` et étale son tableau `questions` dans le résultat : la mémoire obtenue
(nombre de `QuestionResource` en RAM) est identique à avant, seul le nombre d'ouvertures de
fichier baisse. Pour "Comprehension de texte", le `PassageResource` de chaque question
(`QuestionResource.passage`) est maintenant une sous-ressource du même fichier que ses questions
— `take_over_path()` (qui ne servait qu'à lier des ressources vivant dans des fichiers séparés,
voir l'incident documenté dans l'historique de `import_reading.gd`) n'est plus nécessaire, Godot
dédupliquant nativement les sous-ressources partagées au sein d'un même fichier. Corollaire :
`QuestionGiverComponent._load_passages_for_grade` ne fait plus un second scan disque du dossier
`lecture/` — elle dérive directement la liste des passages à partir de `question_pool`, déjà
chargé en mémoire, ce qui évite au passage tout risque qu'un second `load()` indépendant renvoie
une instance différente du même passage (voir commentaire de la fonction).

**Migration ponctuelle (à faire une fois après avoir relancé les deux imports) :** les anciens
fichiers `.tres` un-par-question (nommés par `id`, ex. `2000.tres`) restent sur le disque à côté
des nouveaux `<nom_csv>.tres` — noms différents, pas d'écrasement automatique. Une fois le nouvel
import vérifié en jeu (les PNJ posent bien des questions), supprimer les anciens fichiers
orphelins pour ne pas garder ~10 000 fichiers inutiles sous `data/question/resources/`.

La réponse saisie par le joueur est comparée à `correct_answer` sans tenir compte des espaces ni
de la casse (clavier tactile, public jeune).

### Mode de réponse (QCM par boutons dès qu'il y a des choix)

`QuestionPanel` affiche des boutons (bonne réponse + mauvaises réponses, mélangées) dès qu'une
question a des `choices`, sur **toutes les plateformes** (desktop clavier inclus) — pas seulement
sur tactile. Raison : pour un texte à trous (ex. conjugaison, homophones), le joueur n'a sinon
aucun moyen de deviner au clavier la forme exacte attendue (accord, orthographe précise...) sans
voir les options, contrairement à la version tactile qui les affichait déjà. Seule une question
sans `choices` (colonnes `choice_2/3/4` vides dans le CSV) reste en saisie clavier (`AnswerInput`),
sur toutes les plateformes également.

**Nombre de boutons = nombre de cellules non vides, pas un compte fixe de 4** (règle validée
2026-07-31) : `_populate_choice_buttons` (`ui/question_panel/question_panel.gd`) construit ses
boutons à partir de `correct_answer` + `choices` (déjà filtré des cellules vides par les
importeurs, voir plus haut), quelle que soit la taille du tableau — 1 bonne réponse + 1 mauvaise
(`choice_2` seule remplie) donne 2 boutons, pas 4 avec des cases vides ou des distracteurs
inventés pour combler. **Convention à suivre pour toute question dont il n'existe naturellement
que 2 (ou 3) réponses plausibles** (vrai/faux, pair/impair, plus grand/plus petit, singulier/
pluriel...) : ne remplir que `choice_2` (ou `choice_2`+`choice_3`) et laisser `choice_3`/`choice_4`
vides plutôt que d'inventer un distracteur faible ou dupliqué juste pour atteindre 4 options.
Pas de changement de code nécessaire pour ça : le mécanisme (import + affichage) le supportait
déjà nativement, seule l'absence de contenu l'utilisant manquait.

**Règle accents (renforcée 2026-07-31)** : le batch de 47 histoires généré le 2026-07-30 s'est
retrouvé intégralement sans accents (bug de génération, non détecté avant relecture par
l'utilisateur) malgré la règle déjà énoncée plus haut (2026-07-21, "les accents sont
obligatoires"). Corrigé par une restauration automatisée (dictionnaire FR + règles contextuelles
vérifiées manuellement sur homophones a/à, ou/où, la/là, des/dès, sur/sûr, cote/côté/côte) —
détail dans la mémoire `feedback_missing_accents_2026_07_31`. **Pour tout contenu français généré
par script ou en plusieurs temps (histoires, questions, cartes...), vérifier explicitement la
présence d'accents avant de considérer une génération de contenu terminée** — un simple
`grep -c '[àâäéèêëïîôöùûüçœæ]'` sur le fichier produit, comparé à sa taille en mots, permet de
détecter un taux anormalement bas (repère : le contenu français correctement accentué de ce
projet tourne autour de 6-15% de caractères accentués rapportés au nombre de mots).

`PlatformUtils.is_touch_platform()` (dans `scripts/utils/`) existe toujours (détecte tactile via
export Android/iOS ou `DisplayServer.is_touchscreen_available()`, ignoré sur desktop où ce signal
est peu fiable — bug connu [godotengine/godot#84235](https://github.com/godotengine/godot/issues/84235))
mais n'est plus utilisé par `QuestionPanel` pour choisir le mode de réponse ; il reste disponible
si un futur écran a besoin de distinguer tactile/desktop pour autre chose (ex. taille des boutons).

### Coffres de la boutique (build_loot_tables.gd)

Les 5 coffres de la boutique (un par rareté) ne sont pas édités à la main : ils sont générés à
partir des `CardResource` déjà présentes dans `data/card/resources/`.

1. Ouvrir `tools/admin/build_loot_tables.gd` dans l'éditeur Godot.
2. **File > Run** (ou `Ctrl+Shift+X`).
3. Le script regroupe toutes les cartes par rareté et (re)génère les 5 fichiers dans
   `data/loot/resources/` : `crate_commun.tres`, `crate_peu_commun.tres`, `crate_rare.tres`,
   `crate_epique.tres`, `crate_legendaire.tres`. Chaque coffre ne contient que les cartes de sa
   propre rareté, à poids égal.
4. `crate_price` n'est défini par défaut qu'à la toute première création d'un coffre (voir
   `DEFAULT_PRICES` dans le script) — libre à toi de l'ajuster ensuite dans l'inspecteur, il ne
   sera plus jamais écrasé par le script.

Code couleur des raretés (carte, album, prix des coffres), défini dans `CardRarity.get_color()` :
commune = blanc, peu commune = vert, rare = bleu, épique = violet, légendaire = orange.

## Décor saisonnier (`entities/decor/`, 2026-07-29)

Objectif : 4 versions du décor (une par saison), sans dupliquer `park.tscn` ni coder le
changement au cas par cas pour chaque objet.

- **`data/decor/season.gd`** (`Season`, classe utilitaire statique, même principe que
  `GradeLevel`/`CardRarity`) : `Season.current()` déduit la saison (`Season.Kind` :
  `PRINTEMPS`/`ETE`/`AUTOMNE`/`HIVER`) du mois de l'horloge système
  (`Time.get_date_dict_from_system()`) — découpage météorologique par mois calendaire (déc-janv-fév
  = hiver, etc.), pas astronomique (dates de solstice variables) : plus simple et suffisant pour de
  l'habillage de décor. `Season.get_folder_name()` donne le nom de sous-dossier correspondant.
- **`entities/decor/seasonal_skin.gd`** (`SeasonalSkin`) : posé sur la racine de chaque scène de
  décor "de base" (`tree.tscn`, `flower_bed.tscn`). À `_ready()`, déduit son propre nom depuis
  `scene_file_path` (ex. `tree` pour `tree.tscn` — rien à saisir à la main) puis cherche
  `entities/decor/seasons/<saison>/<nom>.tscn`. Si ce fichier existe (`ResourceLoader.exists`), il
  remplace tout le contenu de la scène de base par cette variante ; sinon il ne fait rien (le décor
  de base reste affiché, coût nul en dehors de la vérification d'existence).
- **`entities/decor/seasons/<printemps|ete|automne|hiver>/`** : un `README.md` par dossier
  explique la convention. Vide pour l'instant côté art — y déposer un `.tscn` du même nom qu'un
  décor de base (ex. `hiver/tree.tscn` = arbre enneigé) suffit à l'activer, sans toucher à
  `park.tscn` ni à aucune instance déjà placée dans une scène.
- Étendre la couverture à un autre décor (portail, grande roue...) : (1) si ce n'est pas déjà une
  scène séparée sous `entities/decor/`, l'extraire en `.tscn` ; (2) poser `seasonal_skin.gd` sur sa
  racine ; (3) déposer les variantes saisonnières au même nom. Aucune modification du script
  générique n'est nécessaire.
- **Limite connue** : la substitution n'a lieu qu'à l'exécution (`_ready`), pas prévisualisable
  dans l'éditeur — un script `@tool` avec préversualisation est possible mais ajoute de la
  complexité (gestion de l'ownership des nœuds générés), à faire seulement si le besoin se
  confirme à l'usage.

## Menu de jeu (`ui/game_menu/`)

Panneau modal accessible via le bouton "M" du HUD (`park.tscn`, `UI/OpenMenuButton`), même
convention que les autres fenêtres modales (`Control` racine, `Panel` visuel, `CloseButton`,
fermeture par Échap, verrouille `PlayerInputLock` tant qu'il est ouvert). `GameMenuPanel`
(`game_menu_panel.gd/.tscn`) est une simple coquille de navigation entre 5 sections :

- **Configuration** (`section_config.gd/.tscn`) — volume général (`AudioServer`, bus "Master") et
  plein écran (`DisplayServer`), via `SaveManager`.
- **Sauvegarde** (`section_save.gd/.tscn`) — Sauvegarder/Charger manuels (en plus de l'auto-save
  faite par `SaveManager` à chaque changement de réglage/touche) et réinitialisation complète de
  la progression (confirmation en 2 clics, pas de popup séparée).
- **Commandes** (`section_controls.gd/.tscn`) — réassignation clavier ; une ligne par action de
  `SaveManager.REBINDABLE_ACTIONS`, construite dynamiquement (même principe que
  `SubjectSelectPanel` pour ses boutons de matière) — ajouter une action reassignable = l'ajouter
  à cette constante, aucune scène à retoucher.
- **Collection** — ne réimplémente rien : le bouton émet le signal `collection_requested`,
  branché dans `park.tscn` sur `UI/CardAlbum.open()`, pour réutiliser l'album existant plutôt que
  dupliquer son affichage.
- **Statistiques** (`section_stats.gd/.tscn`) — lecture seule : packs réussis, précision,
  répartition par matière (`StatsTracker`), soldes de pièces (`Economy`), % de collection
  (`CardCollection` vs nombre total de `.tres` dans `data/card/resources/`).

Évolutif par construction : ajouter une 6e section = un nouveau `Section*.gd/.tscn` (même
interface `refresh()` + `show()/hide()`), un bouton dans `NavContainer`, une entrée dans
`_hide_all_sections()`/un nouveau `_show_xxx()` de `game_menu_panel.gd` — le reste (ouverture,
fermeture, verrouillage input) ne bouge pas.

## Ce qu'il reste à faire

- Étoffer `csv/cards.csv` jusqu'à ~500 cartes (100 blocs de 5 raretés), puis relancer l'import.
- Habiller les scènes (mesh du perso/PNJ/kiosque, décor du parc, style de l'UI, art des cartes
  dans `data/card/art/`) — actuellement squelettes fonctionnels sans art.
