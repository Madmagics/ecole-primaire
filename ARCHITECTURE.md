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
  fenêtre — question, boutique, menu de jeu — est ouverte), `ChallengeTracker`
  (2026-09-05, remplace `StatsTracker`/`SectionStats` retirés ce jour-là, retour utilisateur : "on
  va supprimer l'icone et la fenetre de statistique qui est au final inutile" — progression des
  "Défis" classe+matière, un défi = un pack terminé sans faute, voir son commentaire de classe et
  `ui/success/success_panel.gd` pour l'écran qui l'affiche), `ProfSkins` (2026-08-29 : skins
  de "prof" achetables/équipables par classe - 10 skins/classe, voir `data/ProfSkinCatalog` pour
  le catalogue de textures ; `try_unlock()` achète ET équipe en un clic, `set_active()` rééquipe
  gratuitement un skin déjà possédé ; émet `skin_activated`, écouté par chaque `ProfVisual` pour
  changer son sprite sans recharger la scène),
  `SaveManager` (survit lui à un **redémarrage** du jeu, contrairement aux autres autoloads
  ci-dessus qui ne survivent que d'une scène à l'autre au sein d'une même session). Depuis
  2026-08-01, `SaveManager` gère **plusieurs comptes locaux** (le jeu peut être partagé par
  plusieurs enfants sur le même appareil) plutôt qu'un profil unique : chaque compte a son propre
  pseudo/mot de passe (haché+salé, jamais en clair), son propre profil (nom/prénom/classe/date de
  naissance/pays) et sa propre progression (`Economy`/`CardCollection`/`ChallengeTracker` sérialisés
  par compte). Les réglages (volume, plein écran, thème, touches) restent
  partagés au niveau de l'appareil, pas par compte. Tout vit dans un seul fichier
  `user://savegame.json` — voir section "Menu de jeu" plus bas pour `SectionSave`. Personne n'est
  connecté au démarrage : `ui/onboarding/WelcomePanel` (instancié dans `UI` de `park.tscn`,
  dernier enfant pour s'afficher au-dessus de tout) demande systématiquement pseudo + mot de passe
  ou la création d'un compte — pas de liste des comptes existants affichée. La classe choisie à la
  création n'est qu'une donnée de profil déclarative (2026-08-29, retrait de `GradeUnlock` : plus
  de déblocage payant, toutes les classes sont accessibles dès le départ, un enfant qui commence
  au CE2 peut réviser le CP/CE1 ou tester le CM1/CM2). Ordre d'`[autoload]` dans `project.godot`
  important : `Economy`/`CardCollection`/`ChallengeTracker` doivent être chargés avant `SaveManager`
  (qui les appelle depuis `create_account()`/`login()`/`save_current_account()`).
- `csv/` — TOUS les fichiers CSV du projet (source du contenu en masse), à la racine pour rester
  faciles à retrouver : `cards.csv`, `questions/math/`, `questions/french/`... (voir section
  "Outils admin" plus bas). Les `.tres` générés à partir de ces CSV vivent dans `data/`.
- `data/` — définitions de `Resource` réutilisables (le "contenu" du jeu, éditable en `.tres`
  sans toucher au code) : `question/` (QuestionResource, SubjectType), `card/` (CardResource,
  CardRarity), `loot/` (LootTableResource = un coffre, LootEntry = carte + poids).
- `entities/` — scènes du monde 3D, assemblées par composition :
  - `interactable/` : `InteractableComponent` générique (zone de détection + titre court affiché
    dans le réticule central, voir `ui/interact_prompt/`), réutilisé par PNJ, coffres et boutique.
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
  - **Verrouillage par classe retiré** (2026-07-21, introduit ; retiré le 2026-08-29, retour
    utilisateur : plus de déblocage de classe payant, toutes les classes sont accessibles dès le
    départ) : `GradeUnlock` (l'autoload), le grisage de `_refresh_lock_visual` et le blocage
    d'interaction dans `_on_interacted` ont été supprimés de `QuestionGiverComponent` - chaque
    PNJ répond désormais toujours à l'interaction, quelle que soit la classe choisie au départ.
  - `reward_chest/` : coffre qui tire une carte via une `LootTableResource` (non utilisé dans
    `park.tscn` actuellement — la boutique est le seul moyen d'obtenir des cartes ; ce composant
    reste disponible pour un futur cadeau/événement ponctuel).
  - `shop_kiosk/` : point d'accès à la boutique dans le monde (pas de script propre, juste un
    `InteractableComponent` dont le signal `interacted` est branché sur `ShopPanel.open()`).
- `ui/` — fenêtres 2D réutilisables : `hud/` (compteurs de pièces), `interact_prompt/`,
  `subject_select/` (choix de la matière avant un pack, parmi celles disponibles pour la classe
  du PNJ interrogé), `question_panel/` (générique, pilotée par un tableau de QuestionResource),
  `shop/` (liste de coffres achetables, prix uniforme de 50 pièces pour les 5 coffres depuis le
  2026-07-21 ; l'onglet "Classe"/`GradeUnlockItem` qui vendait le déblocage des classes suivantes
  a été retiré le 2026-08-29, voir plus haut ; remplacé le même jour par 5 nouveaux onglets - un
  par classe CP à CM2 - de 10 `ProfSkinItem` chacun (2 lignes de 5, voir `ProfSkins`) : grisé si
  pas acheté, cadre coloré par la classe si possédé, bordure dorée en plus si actuellement porté ;
  désormais aussi la fenêtre de la
  section "Récompenses" du dock de droite depuis le 2026-08-29, avec une bande `RewardsBand` en
  tête montrant le solde par classe — voir "Menu de jeu" plus bas), `collection/` (livre de cartes plein écran, une page =
  une catégorie), `card_reveal/` (animation d'obtention de carte a l'achat, 2026-09-02 - remplace l'ancien
  `loot_feed/`, journal texte retire), `game_menu/` (menu de
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

1. Ajouter/modifier des lignes dans `csv/cards.csv` (colonnes : `id;categorie;nom;classe`,
   séparateur `;`). `id` = numéro unique et permanent (ne jamais réutiliser/décaler un id une fois
   assigné, les cartes seront un jour échangées entre joueurs). Convention : blocs de 5 id
   consécutifs par espèce/design (un par variante, une variante = une classe CP→CM2), ex : 1-5 =
   Chat (Sauvage/Siamois/Forestier/Céleste/Cosmique), 6-10 = Chien... `classe` accepte
   `CP`/`CE1`/`CE2`/`CM1`/`CM2` (insensible à la casse/accents) — remplace l'ancienne colonne
   `rarete` (retirée le 2026-07-26, voir `GradeLevel`/`CardResource.grade`) : chaque carte a
   désormais une classe scolaire directe, plus de palier de rareté séparé.
2. Déposer l'illustration de chaque carte dans `assets/classe2.0/pets/` (déplacé le 2026-08-30,
   était `data/card/art/` avant — 125/125 cartes ont leur art depuis ce jour, plus un dossier
   partiellement vide), nommée `<id>.webp` (ex: `1.webp` pour la carte id `1`, `.png` accepté en
   repli si déposé avant conversion) — l'import l'assigne automatiquement au champ `Texture` de la
   carte correspondante. Format retenu : WebP q90, 512×612 (~59Ko, voir `project_card_art_spec` en
   mémoire projet pour l'historique du choix face au PNG ~1.8Mo).
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
libellé affiché change) sont branchés. `LOGIC` ("Logique", 2026-08-04) : tests
psychotechniques pour enfants (suites, intrus, analogies, deduction) — seule matiere du jeu
qui n'est pas issue du programme scolaire officiel, voir `MATIERES_CANDIDATES.md`. Lancee avec
un lot de test de 10 questions par classe (dossier `logique/`) avant extension. Ajouter une matière = un nouveau cas dans `SubjectType`
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

Code couleur des raretés (carte, album, prix des coffres) — **obsolète, voir plus bas** : défini à
l'origine dans `CardRarity.get_color()` (commune = blanc, peu commune = vert, rare = bleu, épique =
violet, légendaire = orange), retiré le 2026-08-30 au profit d'une palette par CLASSE dans
`GradeLevel.get_color()`.

**`crate_name` affiché au joueur en nom de classe, pas de rareté (2026-08-29, section
"Récompenses")** : `build_loot_tables.gd` génère désormais `crate_name = GradeLevel.get_label(
GradeLevel.get_grade_for_rarity(rarity))` ("CP"/"CE1"/"CE2"/"CM1"/"CM2"), plus "Commune"/"Peu
commune"/etc (`CardRarity.get_label()` supprimé, plus aucun appelant) — visible dans la popup de
confirmation d'achat de `ShopPanel` ("Acheter « CP » pour 20 ?"). Les 5 `.tres` déjà générés dans
`data/loot/resources/` ont été mis à jour à la main pour rester synchronisés sans relancer le
script. `Economy` reste indexé par `Rarity` en interne (aucune migration de sauvegarde) — seule la
couche d'affichage change.

**Nouveau code couleur unifié par classe, plus par rareté (2026-08-30, retour utilisateur : "on va
instaurer un nouveau code couleur valable pour tout le jeu : cp=bleu, ce1=vert, ce2=jaune,
cm1=violet, cm2=rouge")** : `GradeLevel.get_color(grade)` a désormais sa propre palette fixe,
indépendante de `CardRarity` — `CardRarity.get_color()` n'avait plus qu'un seul appelant
(`GradeLevel.get_color()` lui-même) et a été retiré. Tout ce qui affichait une couleur de
classe/rareté (`CardSlot`, `LootFeed`, `CoinHUD`, `CrateItem`, `ProfSkinItem`) suit désormais
automatiquement la nouvelle palette. `CrateItem` convertit sa `Rarity` en `Grade` via
`GradeLevel.get_grade_for_rarity()` avant d'appeler `get_color()` (il n'appelait plus `CardRarity`
directement).

**Icônes de pièces : deux jeux d'images déjà colorées par classe, plus de teinte au runtime**
(même retour utilisateur : "je les ai faites en webp avec leur couleur... les pieces a utiliser
pour les achat sont les icones pieces... les icones pour le total de piece du joueur sappellent
tasdepiece") : `assets/classe2.0/icones/piece-<CLASSE>.webp` (une pièce, prix à payer — `CrateItem`/
`ProfSkinItem`, voir `GradeLevel.get_coin_icon_path()`) et `tasdepiece-<CLASSE>.webp` (pile de
pièces, solde total du joueur — `CoinHUD`/`RewardsBand`, voir `GradeLevel.get_coin_pile_icon_path()`).
Remplacent l'ancienne icône unique `piece.webp` (`CoinHUD`) et la base grise `concept_piece.svg`
(`CrateItem`/`ProfSkinItem`, tous deux teintés par `modulate` au runtime) — les nouveaux fichiers
sont finis en couleur, `modulate` n'est plus appliqué dessus (re-teindrait une image déjà colorée).
`concept_piece.svg` supprimé (plus aucune référence).

**Correctif du même jour (plus tard)** : une refonte de `ProfSkinItem` faite en dehors de cette
session (cadre transparent, `PriceBadge`, voir doc-comment de `prof_skin_item.gd`) avait
réintroduit `concept_piece.svg` + `modulate` sur `CoinIcon` après sa suppression ci-dessus, cassant
le chargement de `prof_skin_item.tscn` au lancement. Refait dans la structure actuelle du fichier :
`CoinIcon` charge `GradeLevel.get_coin_icon_path(grade)` en `_ready()`, sans `modulate`. Zéro
référence restante à `concept_piece.svg`/`assets/icons/` dans le projet (vérifié par recherche
globale).

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

Panneau modal accessible via le bouton "M" du HUD (`game_ui.tscn`, `UI/OpenMenuButton`), même
convention que les autres fenêtres modales (`Control` racine, `Panel` visuel, fermeture par Échap
ou par le `CloseButton` partagé en haut de la colonne d'icônes — voir plus bas, 2026-08-29 — verrouille
`PlayerInputLock` tant qu'il est ouvert). `GameMenuPanel`
(`game_menu_panel.gd/.tscn`) est une simple coquille de navigation entre 5 entrées, dont les
boutons vivent dans `IconDock` (2026-08-25) : boutons icône seule sans cadre (`flat`,
`expand_icon`, taille native ×0,6 - voir l'historique de tuning ci-dessous). `IconDock` et `Panel`
sont deux enfants directs de `GameMenuPanel`, disposés avec une marge fixe de 20px de part et
d'autre de `IconDock` (réduite de 50% depuis les 40px initiaux) : bord gauche → marge 20px →
`IconDock` (93px, était 148px avant le 2026-08-26) → marge 20px → `Panel` (`offset_left` = 133,
était 188) → marge 40px (inchangée, pas une marge "autour des icônes") → bord droit. `IconDock` est
lui-même un `Panel` (type de base, même thème que la fenêtre) depuis le 2026-08-25 (retour
utilisateur : "un cadre autour du bloc des icônes... même thème que la fenêtre de la rubrique du
menu") : même StyleBox que le `Panel` de la fenêtre, même hauteur (`offset_top`/`offset_bottom` =
40/-40, identiques), largeur ajustée à 93px pour loger une marge interne de 5px de chaque côté de
la colonne d'icônes (`IconList`).

**Historique du tuning de largeur (2026-08-26, deux retours utilisateur le même jour)** : d'abord
retrécie de 25% ("on va reduire la largeur des colonnes de 25%" — `IconDock` 148→111px, marge
`IconList` 20→15px, icônes à native ×0,45), puis l'utilisateur est revenu sur la taille des icônes
("taille d icone retour a la taille precedente") tout en gardant la colonne étroite via la marge
intérieure seule, réduite à 5px ("on reduit la marge interieur a 5 px") : les icônes retrouvent
leur taille native ×0,6 d'origine, seule la marge autour d'elles a changé. `IconDock` se stabilise
donc à 93px de large (icône la plus large du dock partagé, `SuccesButton` côté `BackpackMenu` à
83px, + 5px de marge de chaque côté). Chaque bouton garde `size_flags_horizontal = SIZE_SHRINK_
CENTER` pour rester centré dans `IconList` quelle que soit sa propre largeur. S'applique aux deux
colonnes puisqu'elles partagent `icon_dock.tscn` (voir "scène partagée" ci-dessous).

**`IconDock` est depuis le 2026-08-26 une scène partagée** (`ui/game_menu/icon_dock.tscn` — un
simple `Panel` + `IconList` `VBoxContainer`, sans bouton ni script) instanciée ici ET dans le
nouveau dock "Sac à dos" en haut à droite de l'écran (voir plus bas, `ui/hud/backpack_menu.tscn`) :
retour utilisateur "je la veux commune si bien que si on modifie une l'autre sera modifiée aussi"
— modifier le cadre/les marges/la hauteur dans `icon_dock.tscn` met à jour les deux colonnes à la
fois. Chaque instance ajoute ses propres boutons comme enfants éditables de son `IconList` (voir
`[editable path="IconDock"]` en bas des deux `.tscn`) ; seule la position diffère par instance
(ancrée à gauche ici, miroir à droite dans `BackpackMenu`, mêmes dimensions).
Le fond flouté (shader `icon_dock_blur.gdshader` — lit `hint_screen_texture` via `textureLod` à un
mipmap non nul, technique documentée par Godot pour un flou sans noyau manuel) + teinte noire
plate 40% (montée depuis 10% initial) couvre tout l'écran (`BlurBG`, premier enfant de
`GameMenuPanel`, dessiné sous `Panel`/`IconDock`) — visible uniquement dans les marges entre les
deux cadres opaques désormais. Le badge de raccourci clavier n'est plus sur l'icône mais à côté du
titre de la section active (`Panel/TitleRow/ShortcutBadge`, mis à jour par `_update_header()`),
masqué pour les sections sans raccourci propre. Une ligne (`TitleSeparator`, `HSeparator`) sépare
`TitleRow` du reste de la fenêtre (retour utilisateur : "une ligne de separation entre le titre et
le reste de la fenetre, le trait est de meme design que le trait de contour de la fenetre") — son
style (`HSeparator/styles/separator`, `StyleBoxLine`) est défini dans les 4 fichiers de thème avec
la même couleur et épaisseur (4px) que `border_color`/`border_width` du `Panel/styles/panel` de
chaque thème, pour reprendre exactement le style du contour de la fenêtre quel que soit le thème
actif. `ContentArea` (parent commun des 6 sections) a par ailleurs vu son `offset_left` réduit de
260px à 40px le même jour (retour utilisateur : "toutes les fenetres de menus doivent voir leurs
contenus colles a gauche avec une marge equivalente a la marge entre la fenetre et le bord de
l'ecran") — les 260px dataient de l'ancienne navigation verticale qui vivait autrefois à l'intérieur
de `Panel`, avant qu'`IconDock` ne devienne un cadre entièrement externe (voir plus haut).

Retouché à nouveau le même jour (retour utilisateur : le trait "trop haut", "reduit la case
raccourci en hauteur, met le raccourci en majuscule..., passe le cadre... en forme carree") :
`TitleSeparator` descend (`offset_top`/`bottom` 48/52 → 55/59, `ContentArea` suit à 64 au lieu de
60) pour dégager une vraie marge sous le titre. `ShortcutBadge` abandonne le type `TitleLabel`
(24px, pensé pour un titre) au profit d'un type dédié (`ShortcutBadge`, base `PanelContainer`,
ajouté aux 4 thèmes — petit cadre carré 28×28 avec bordure/fond repris du `Panel` de chaque thème,
bordure 2px, coins 6px) ; son `Label` passe à un `font_size` direct de 16px et le texte est mis en
majuscule (`_update_header()`, `.to_upper()` — une majuscule n'a pas de jambage sous la ligne de
base, contrairement à certaines minuscules, ce qui aurait forcé le cadre à s'agrandir). `CloseButton`
reprend la même taille (28×28) le lendemain (2026-08-26) : ses offsets seuls ne suffisaient pas (la
taille minimale calculée par un `Button` de base — texte 20px + marges 14px/8px — l'emportait sur
des offsets plus petits), d'où un type dédié `CloseButton` (base `Button`, ajouté aux 4 thèmes,
mêmes couleurs normal/hover/pressed que le `Button` de base mais marges 5px/3px, bordure 2px,
police 16px) qui fait réellement descendre la taille minimale sous 28×28 :

Les 5 sections (`Section*.gd/.tscn`) partagent la même mise en page, égalisée le 2026-08-25 (retour
utilisateur : "reprendre la mise en page des rubriques du menu option et les égaliser... réduit la
marge de droite réduit la police de 1 taille") : `VBoxContainer` avec marges 20px (gauche/haut/bas)
et 10px à droite (réduite depuis 20px), séparation 16 uniforme (Informations personnelles était à
14, alignée sur les autres). Police réduite d'un cran (20→18 par défaut, 24→22 pour `TitleLabel`)
via un thème minimal dédié (`ui/theme/menu_options_font.tres`, seulement `default_font_size` et
`TitleLabel/font_sizes` — aucune couleur) assigné une seule fois sur `Panel/ContentArea` : les
thèmes Godot se fusionnent le long de l'arbre (le thème le plus proche est prioritaire par item),
donc ce thème réduit uniquement les tailles de police, les couleurs continuant de venir du thème
de palette actif (`SaveManager.ui_theme`) assigné plus haut sur `GameMenuPanel`.

- **Configuration** (`section_config.gd/.tscn`) — volume général (`AudioServer`, bus "Master") et
  plein écran (`DisplayServer`), via `SaveManager`.
- **Sauvegarde** (`section_save.gd/.tscn`) — Sauvegarder/Charger manuels (en plus de l'auto-save
  faite par `SaveManager` à chaque achat/déblocage/pack réussi, voir plus bas) et réinitialisation
  complète de la progression du compte. Le bouton se contente d'émettre `reset_requested` ; c'est
  `GameMenuPanel` qui ouvre le portail parental (`ParentalGateOverlay`, code à 8 caractères à
  recopier) et n'appelle `SaveManager.reset_current_account_progress()` que si le code est validé
  (voir `_request_gate`/`_on_gate_confirmed`) — aucune action destructive ne s'exécute plus
  directement au clic.
- **Commandes** (`section_controls.gd/.tscn`) — réassignation clavier ; une ligne par action de
  `SaveManager.REBINDABLE_ACTIONS`, construite dynamiquement (même principe que
  `SubjectSelectPanel` pour ses boutons de matière) — ajouter une action reassignable = l'ajouter
  à cette constante, aucune scène à retoucher.
- **Informations personnelles** (`section_profile.gd/.tscn`, 2026-08-01) — édition du profil du
  compte connecté (nom, prénom, classe, date de naissance, pays ; voir `SaveManager.
  get_current_profile()`/`update_current_profile()`). "Classe" est une donnée déclarative — depuis
  le retrait de `GradeUnlock` (2026-08-29), elle ne débloque plus rien. Contient aussi le
  bouton "Supprimer le compte", qui émet `delete_account_requested` : passe par le même portail
  parental que la réinitialisation avant d'appeler `SaveManager.delete_current_account()`, puis
  ferme ce menu (`WelcomePanel` se raffiche tout seul via `SaveManager.account_logged_out`). Pas de
  raccourci clavier dédié (ouverture au clic uniquement, voir commentaire en tête de
  `game_menu_panel.gd`).
- **Statistiques** retirée le 2026-09-05 (retour utilisateur : "on va supprimer l'icone et la
  fenetre de statistique qui est au final inutile") — `section_stats.gd/.tscn` et l'autoload
  `StatsTracker` supprimés du disque ; le seul morceau utile (suivi de progression) est repris par
  `ChallengeTracker`, voir plus haut, et affiché dans la fenêtre "Succès" (voir plus bas, "Défis").

**Collection, Sac de pièces et Succès ne font plus partie de ce menu** — ils vivent derrière un
dock d'icônes permanent en haut à droite de l'écran, symétrique de `OpenMenuButton` en haut à
gauche. Architecture en deux temps :

- 2026-08-25 (retour utilisateur : "séparer les icônes... les placer en haut à droite de l'écran
  de manière permanente comme le menu") : Collection/Sac de pièces/Inventaire deviennent 3 icônes
  permanentes indépendantes dans `game_ui.tscn`, chacune ouvrant directement sa fenêtre.
- 2026-08-26 (retour utilisateur : "un nouveau modèle de groupes d'icônes... exactement pareil que
  du côté gauche : une icône principale, le sac à dos, qui ouvre un menu colonne") : ces 3 icônes
  sont remplacées par **une seule icône permanente**, `UI/BackpackButton` (`game_ui.tscn`, même
  style `flat`/`expand_icon` et même script générique `menu_toggle_button.gd` que les autres icônes
  persistantes), qui bascule (`toggle()`) l'affichage d'une colonne d'icônes, `UI/BackpackMenu`
  (`ui/hud/backpack_menu.gd/.tscn`) — instance miroir de `IconDock` (voir plus haut), ancrée à
  droite au lieu de gauche, mêmes dimensions. `BackpackButton` n'ouvre plus de fenêtre propre : le
  `BackpackPanel` d'origine ("Bientôt disponible !") est retiré, son rôle de hub est repris par
  cette colonne (retour utilisateur : "on y ajoutera du contenu plus tard directement en relation
  avec les gains du jeu" — le contenu futur s'ajoutera comme nouvelles icônes de la colonne).

`BackpackMenu` contient 3 boutons, chacun ouvrant un panneau existant SANS fermer la colonne
(2026-08-26, retour utilisateur : "je veux aussi que les fenetre et la colonne de droite
apparaissent en meme temps comme pour la colonne de gauche avec ses menus et fenetres" — la colonne
et son panneau restent visibles ensemble, exactement comme `IconDock` reste visible à côté du
`Panel` de contenu dans `GameMenuPanel` ; un comportement de menu déroulant qui refermait la
colonne après sélection a été essayé puis abandonné le même jour, voir `BackpackMenu._open_panel()`).
Un seul panneau de la colonne reste visible à la fois (même jour, retour utilisateur suivant avec
captures d'écran comparant le menu de gauche et le menu de droite : "un click sur une autre icone
fait disparaitre la premiere fenetre et apparaitre lautre") : `_open_panel()` ferme les 2 autres
panneaux de la colonne avant d'ouvrir le nouveau. `BackpackMenu.close()` ferme aussi les 3 panneaux
externes en plus de la colonne elle-même (2026-08-29, retour utilisateur : "laction ECHAP doit
fermer le menu ET la fenetre... a droite la fenetre reste ouverte") — contrairement à
`GameMenuPanel`, `BackpackMenu` et ses 3 panneaux sont des nœuds séparés de `UI`, chacun avec son
propre gestionnaire d'Échap ; le premier à consommer l'événement empêchait l'autre de se fermer,
d'où le fix explicite dans `close()` plutôt que de compter sur l'ordre de parcours de l'arbre.
`BackpackMenu` (racine plein écran, ajoutée après `CardAlbum`/`SuccessPanel`/`ShopPanel` dans
`game_ui.tscn` — dans cet ordre précisément, voir plus bas) est aussi passée à `mouse_filter = 2`
(2026-08-29, retour utilisateur : "les croix de fermeture sur les fenetre du menu de droite... ne
fonctionne plus au click") — sa zone vide bloquait au clic les croix de fermeture des panneaux
voisins dessinés en dessous d'elle, même correctif que `BlurBG` dans `GameMenuPanel`.

**Page de base à l'ouverture + flou plein écran (2026-08-29, retour utilisateur : "tout comme le
menu de gauche ouvre une colonne d icones et la page configuration avec du floutage en arriere
plan, je veux que le menu de droite ouvre la boutique comme page de base, que le fond en arriere
plan soit floute de la meme maniere que l autre menu")** : `BackpackMenu.open()` appelle désormais
`_open_panel(wallet_panel_path)` juste après `show()`, donc `ShopPanel` s'affiche automatiquement
à l'ouverture de la colonne — même principe que `GameMenuPanel.open()` qui affiche toujours
Configuration via `_show_config()`. Pour le flou, `BlurBG` de `GameMenuPanel` est un enfant DIRECT
du panneau (se dessine sous son propre `Panel`/`IconDock` sans rien connaître d'autre) ; côté
droit, `ShopPanel`/`CardAlbum`/`SuccessPanel` sont des nœuds SÉPARÉS de `BackpackMenu` dans
`game_ui.tscn`, donc un `BlurBG` enfant de `BackpackMenu` se serait dessiné PAR-DESSUS eux (puisque
`BackpackMenu` est placé après eux dans l'arbre, voir juste au-dessus). Un nouveau nœud
`BackpackBlurBG` (`ColorRect`, même shader `icon_dock_blur.gdshader`/même teinte 40% que `BlurBG`)
est ajouté directement dans `game_ui.tscn`, placé AVANT `CardAlbum`/`SuccessPanel`/`ShopPanel` pour
se dessiner en dessous des trois, et piloté à distance par `BackpackMenu` via un nouveau NodePath
export (`blur_bg_path`, même mécanisme que `wallet_panel_path`/`collection_panel_path`/
`success_panel_path`) — sa visibilité suit celle de la colonne dans `_on_visibility_changed()`.

**Croix de fermeture unique en haut de chaque colonne (2026-08-29, retour utilisateur suivant le
même jour)** : "dorenavant la fermeture de l ensemble colonne d icone et fermeture fenetre
soperera par la touche ECHAP ou une croix située en haut de la colonne au lieu de la croix dans
chaque fenetre qui sera a enlever." `GameMenuPanel`, `ShopPanel`, `CardAlbum` et `SuccessPanel`
perdent chacune leur `CloseButton` propre (et `HeaderSpacer` qui ne servait qu'à le pousser à
droite). Un `CloseButton` unique est ajouté directement dans `icon_dock.tscn` (la scène de base
déjà partagée entre `GameMenuPanel` à gauche et `BackpackMenu` à droite, voir plus haut) — visible
en haut de la colonne des deux côtés sans dupliquer le nœud. Placé d'abord comme premier enfant
d'`IconList` (`alignment = 1`, centré), corrigé le jour même suite au retour utilisateur "colle la
croix en haut de la colonne des 2 cotés" : il suivait alors le centrage du bloc d'icônes au lieu de
rester fixe en haut du panneau. `CloseButton` est donc sorti d'`IconList` pour devenir un enfant
séparé d'`IconDock`, ancré en haut et centré horizontalement (`anchor_left = anchor_right = 0.5`,
`offset_top = 8`), collé au bord supérieur du `Panel` indépendamment du centrage d'`IconList` en
dessous (`IconList.offset_top` passe de 14 à 44 pour lui laisser la place). `IconDock` lui-même n'a
pas de script : chaque script
côté (`game_menu_panel.gd`, `backpack_menu.gd`) connecte ce bouton partagé à son propre `close()`
— comportement identique à Échap, juste un second chemin pour y accéder. `QuestionPanel`/
`SubjectSelectPanel` (questions via NPC) gardent leur propre croix, non concernés. **Marge
au-dessus de la croix alignée sur 10px** (retour utilisateur suivant, même jour : "appplique la
meme marge au dessus des croix de fermeture des menu colonne que sur les cotes 10px?") :
`CloseButton.offset_top` passe de 8 à 10, reprenant la valeur de la marge colonne↔fenêtre déjà
établie ailleurs (10px, voir "Marges resserrées" plus bas) ; `offset_bottom` suit (36→38).
`IconList.offset_top` passe de 44 à 46 (+2) pour garder le même écart de 8px sous la croix, sans
changer l'espacement interne :

- **Récompenses** (2026-08-29, retour utilisateur : "licone sac de piece devient la section
  'Récompenses' : dans la fenetre correpondante on aura la fenetre boutique actuelle" — remplace
  "Sac de pièces") → `UI/ShopPanel.open()` (`ui/shop/shop_panel.gd/.tscn`, voir la section
  "Boutique" plus bas pour son fonctionnement complet). L'ancien `InventoryPanel`
  (`inventory_panel.gd/.tscn`/`InventoryRow`) qui listait le solde par rareté est retiré du projet
  (fichiers supprimés) : son rôle est repris par `RewardsBand` à l'intérieur de `ShopPanel`, qui
  liste désormais le solde par CLASSE (CP à CM2, plus de vocabulaire de rareté côté joueur — voir
  `GradeLevel.get_label`/`get_grade_for_rarity`). Raccourci clavier indépendant ("I",
  `open_inventory`, nom d'action inchangé, géré par `ShopPanel._unhandled_input`) : bascule
  désormais `ShopPanel` au lieu de l'ancien `InventoryPanel`. `ShopPanel` était aussi ouvrable par
  le kiosque de la scène (`ShopKiosk`, `entities/shop_kiosk_2d/`, instancié dans
  `levels/school/school.tscn`) — **retiré le même jour** (retour utilisateur : "on retire le module
  boutique pose dans le jeu en 2d, il n a plus a apparaitre la car il se trouve dans le menu") :
  nœud `ShopKiosk` supprimé de `school.tscn`, scène `shop_kiosk_2d.tscn` supprimée (plus aucune
  référence dans le projet actif). `ShopPanel.open()` perd son paramètre `who` (n'avait plus
  d'appelant lui en passant un). L'icône "Récompenses" est désormais le seul chemin d'ouverture,
  avec le raccourci "I".
- **Livre** → `UI/CardAlbum.open()` — album de cartes existant, pagination/quantités, raccourci
  clavier propre ("L", `open_album`, géré par `CardAlbum._unhandled_input`).
- **Succès** → `UI/SuccessPanel.open()` (`ui/success/success_panel.gd/.tscn`, 2026-08-26) —
  affiche désormais les "Défis" (2026-09-05, retour utilisateur, nom d'écran conservé : "on garde
  le nom succes et applique le reste de ma demande") : un cadre par classe (CP à CM2, couleur
  `GradeLevel.get_color()`), chacun listant une ligne par matière réellement disponible pour cette
  classe (`QuestionBankScanner.get_available_subjects()`) — libellé + barre de progression + total
  "X / 70". Un défi = une classe + une matière ; il avance d'une réussite par pack terminé SANS
  FAUTE (`ChallengeTracker.register_success()`, appelé depuis `QuestionPanel._show_result()`), une
  seule barre recolorée bronze (0-4) → argent (5-19) → or (20-69, 70 = défi terminé) plutôt que 3
  barres séparées. `QuestionPanel` affiche aussi une ligne dédiée + un popup + `Sfx.CHALLENGE_
  SUCCESS` dans son récapitulatif quand un pack sans faute fait avancer un défi. Remplace
  `SectionDefis`, qui vivait jusque-là dans le menu de gauche sous le nom "Défis" (retour
  utilisateur du 2026-08-26 : "on va y transférer l'icône actuelle défis qu'on va renommer en
  succès") — seul le nom affiché avait changé depuis, la page restait vide jusqu'à aujourd'hui.
  Même moule que les autres panneaux modaux (`BackpackPanel` avant sa retraite, `CardAlbum`). Pas
  de raccourci clavier.

**Ordre des nœuds dans `game_ui.tscn` (important, 2026-08-29)** : `ShopPanel` DOIT rester placé
avant `BackpackMenu` dans l'arbre (donc dessiné en dessous d'`IconDock`) — sinon sa racine plein
écran (`mouse_filter` par défaut STOP, volontaire : bloque les clics vers le monde du jeu pendant
qu'il est ouvert, comme les autres panneaux modaux) intercepterait les clics destinés aux boutons
Livre/Succès du dock quand "Récompenses" est ouvert, même bug que celui corrigé sur `BackpackMenu`
lui-même juste au-dessus (voir aussi le commentaire de classe de `shop_panel.gd`).

**`InventoryPanel` (retiré depuis, voir plus haut) et `SuccessPanel` au même format que
`GameMenuPanel`/`CardAlbum` (2026-08-26, retour utilisateur : "les fenetres qui popent suite a l
activation des menus de la colonne de droite doivent avoir le meme format que les fenetres qui
souvrent par le menu de gauche")** :
leur `Panel` racine était un `PanelContainer` avec anchors en pourcentage (0.1/0.08/0.9/0.92) — ce
type est stylé dans les 4 thèmes via `PanelContainer/styles/panel` (fond blanc, bordure 3px),
pensé pour des lignes de liste (coffre, item), pas pour une fenêtre entière. Passé à `Panel` (fond
crème, bordure 4px, coins arrondis 20 — `Panel/styles/panel`) avec `anchors_preset=15`, exactement
le format déjà utilisé par `GameMenuPanel` et `CardAlbum`. `Margin` (leur `MarginContainer` interne)
passe de `layout_mode=2` (arrangée automatiquement par `PanelContainer`, un vrai `Container`) à
`layout_mode=1` + `anchors_preset=15` (`Panel` ne gère pas la disposition de ses enfants — il faut
l'ancrer explicitement pour qu'elle remplisse tout le `Panel`, même résultat visuel qu'avant).

**Fenêtres collées au dock, un seul panneau à la fois (2026-08-26, même jour, retour utilisateur
suivant avec captures d'écran comparant "Configuration" à gauche et "Inventaire" à droite)** :
`InventoryPanel` (retiré depuis), `SuccessPanel` et `CardAlbum` avaient encore des marges symétriques de 40px sur
les 4 côtés, ignorant la présence d'`IconDock` — d'où un grand vide visible entre la fenêtre et la
colonne d'icônes côté droit. Les 3 fenêtres passent à border directement la colonne, comme `Panel`
borde `IconDock` à gauche dans `GameMenuPanel`. `BackpackMenu._open_panel()` ferme les 2 autres
panneaux de la colonne avant d'ouvrir le nouveau (voir plus haut) — un seul panneau visible à la
fois, même principe que gauche. `CardAlbum` garde son contenu inchangé (5 cartes/page, même taille) :
seul son `ScrollContainer` (centré, largeur fixe) s'ajuste pour continuer à loger la grille de
cartes dans le `Panel` (valeurs exactes : voir l'entrée suivante, revues le 2026-08-29).

**Marges resserrées, cohérence gauche/droite (2026-08-29)** : un comparatif des marges demandé par
l'utilisateur a révélé que la colonne gauche gardait 20px entre `IconDock` et sa fenêtre alors que
la droite était collée (0px, retour utilisateur : "actuellement entre la colonne de droite et les
fenetres correspondantes il n y a pas de marge"). Décision : "on va passer a 10px de chaque cote
entre la colonne et la fenetre, on va aussi reduire toutes les marges exterieures entre fenetre et
bord de l ecran en haut en bas a droite et a gauche" — appliqué uniquement aux fenêtres ouvertes
depuis une colonne d'icônes qui avaient déjà ce format à cette date (`GameMenuPanel`,
`InventoryPanel` alors, `SuccessPanel`, `CardAlbum`), pas aux fenêtres NPC/Boutique qui gardaient
leur propre design — `ShopPanel` n'a rejoint la colonne de droite (section "Récompenses") que le
lendemain, 2026-08-29, en conservant d'abord son format `PanelContainer`/ancres en pourcentage
existant (retour utilisateur : "on aura la fenetre boutique actuelle" — la fenêtre boutique reste
inchangée visuellement), avant d'adopter la MÊME taille en pixels fixes que les 3 autres fenêtres
de cette colonne quelques échanges plus tard le même jour (retour utilisateur suivant : "ajuste la
taille de la fenetre pour etre de la meme taille que les autres fenetres" — `PanelContainer` et son
style restent inchangés à ce stade, seule la taille/position suit désormais la même formule
qu'`InventoryPanel`/`SuccessPanel`/`CardAlbum`, voir CHARTE_GRAPHIQUE.md). **Correction le même jour,
retour utilisateur suivant** ("applique la configuration des fenetres de gauche a celle de la
boutique, positionnement du titre, barre de separation couleur de fond theme etc") : `Panel` passe à
son tour de `PanelContainer` à `Panel` (même correction de style qu'`InventoryPanel`/`SuccessPanel`
le 2026-08-26 ci-dessus), `Margin` de `layout_mode=2` à `layout_mode=1` + `anchors_preset=15`, et
`HeaderRow` gagne `alignment=1` pour centrer le titre (il était aligné à gauche). `SuccessPanel`
reçoit la même correction de centrage + un `TitleSeparator` qui lui manquait ; `CardAlbum` était déjà
conforme (voir CHARTE_GRAPHIQUE.md pour le détail des trois fenêtres). **Correction suivante, même
jour** (retour utilisateur avec captures d'écran : "a droite on a une ligne flottante plus bas mais
pas comme sauvegarde et les autres fenetres du menu de gauche") : `alignment=1` centrait bien le
titre mais laissait `TitleSeparator` dans le flux du `VBoxContainer` `Content`, donc sa position
dépendait de la hauteur réelle du `Label` au lieu d'un offset fixe — dérive visible face à
`GameMenuPanel`. `TitleRow`/`TitleSeparator` sortent du flux `Margin`/`Content` pour devenir des
enfants directs de `Panel` dans `ShopPanel` et `SuccessPanel`, avec exactement les offsets de
`game_menu_panel.tscn` (titre `offset_top=10/bottom=40`, séparateur `offset_top=55/bottom=59`) ;
`Margin` démarre à `offset_top=80` (voir CHARTE_GRAPHIQUE.md pour le détail). Marge écran 40→20px sur `IconDock` (haut/
bas, il n'avait déjà que 20px en horizontal) et sur les 4 fenêtres (tous les côtés). Marge colonne↔
fenêtre uniformisée à 10px des deux côtés (était 20px à gauche, 0px à droite) : `GameMenuPanel.
Panel.offset_left = 123` (20 marge écran + 93 `IconDock` + 10 marge, était 133) ; côté droit,
`offset_right = -123` sur les 3 fenêtres (était -113), même formule en miroir. `CardAlbum.Panel`
passe de 999 à 1009px de large (la baisse de marge écran l'emporte sur la hausse de marge colonne) ;
son `ScrollContainer` s'élargit de 990 à 1000px en conséquence (mêmes ~4,5px de marge par côté
autour de la grille de cartes).

`OpenMenuButton` et `BackpackButton` surveillent tous les deux les mêmes panneaux (`GameMenuPanel`,
`CardAlbum`, `ShopPanel`, `SuccessPanel`, `BackpackMenu`, `WelcomePanel`) via
`toggled_panel_paths` : n'importe lequel d'entre eux ouvert masque les deux icônes persistantes, pour
éviter tout chevauchement visuel.

Le solde de pièces n'est plus affiché en permanence à l'écran (`CoinHUD`, retiré de `game_ui.tscn`
le 2026-08-25 — retour utilisateur) : consultable uniquement via "Récompenses" ci-dessus. Le
composant `CoinHUD` (`ui/hud/coin_hud.gd/.tscn`) a trouvé un premier vrai usage le 2026-08-29,
instancié comme `RewardsBand` dans `ShopPanel` (voir section "Boutique" plus bas) — affiche
désormais le solde par CLASSE (CP à CM2), plus par rareté (voir `GradeLevel.get_label`).

`ParentalGateOverlay` (`parental_gate_overlay.gd/.tscn`, 2026-08-01) est un portail réutilisable :
génère un code de 8 caractères (`Crypto.generate_random_bytes`, alphabet sans caractères ambigus
0/O/1/I/L) à chaque ouverture, émet `confirmed` seulement si le joueur le recopie correctement,
`cancelled` sinon/à l'Échap. `GameMenuPanel` le partage entre réinitialisation et suppression de
compte via `_pending_gated_action` (même convention que `ShopPanel._pending_purchase`).

Évolutif par construction : ajouter une 6e section = un nouveau `Section*.gd/.tscn` (même
interface `refresh()` + `show()/hide()`), un bouton dans `IconDock/IconList`, une entrée dans
`_hide_all_sections()`/un nouveau `_show_xxx()` de `game_menu_panel.gd` — le reste (ouverture,
fermeture, verrouillage input) ne bouge pas.

**Icône de titre clonée du bouton de menu (2026-09-02)** : `GameMenuPanel`, `ShopPanel`,
`SuccessPanel` et `CardAlbum` ont chacune une `TitleIcon` (`TextureRect`) avant `TitleLabel` dans
leur `TitleRow` (voir CHARTE_GRAPHIQUE.md pour le détail complet et la citation du retour
utilisateur). Aucune texture n'est fixée en dur : `title_icon.texture` est lu directement depuis le
bouton `IconDock` correspondant, jamais dupliqué en fichier séparé.
- `GameMenuPanel` lit son PROPRE bouton (`config_button`/`save_button`/...) via
  `_icon_button_for(id)`, rappelé à chaque `_update_header()` puisqu'une seule fenêtre sert 5
  sections différentes.
- `ShopPanel`/`SuccessPanel`/`CardAlbum` (fenêtres externes à `BackpackMenu`, voir plus bas) ont
  chacune un export `title_icon_source_path: NodePath`, assigné dans `game_ui.tscn` vers le bouton
  `IconDock` du dock DROIT (`../BackpackMenu/IconDock/IconList/<Bouton>`) — même mécanisme de
  référence par `NodePath` déjà utilisé par `CardRevealOverlay.book_icon_path` pour cibler
  `LivreButton`. Lu une seule fois en `_ready()` (l'icône d'un bouton ne change jamais au runtime).

**Jeu 100% souris/tactile, plus de raccourcis clavier (2026-09-02)** : voir CHARTE_GRAPHIQUE.md
pour le détail complet et la citation du retour utilisateur. Résumé structurel :
- `project.godot` n'a plus de section `[input]` personnalisée (les 7 actions liées aux menus sont
  supprimées) — seules les actions UI natives de Godot (`ui_cancel`, `ui_accept`, etc.) existent
  encore par défaut, mais plus aucun script du projet ne les écoute.
- `GameMenuPanel` passe de 5 à 4 sections (Configuration/Sauvegarde/Informations personnelles/
  Statistiques) : la section "Commandes" (`SectionControls`, réassignation des touches) est
  supprimée avec son bouton d'`IconDock` et l'icône `control.webp`, devenue orpheline.
  `SaveManager` perd en miroir tout son système de réassignation (`REBINDABLE_ACTIONS`,
  `custom_bindings`, `rebind_action()`, `get_binding_label()`, etc.) — la clé `custom_bindings` de
  `savegame.json` n'est plus écrite, et simplement ignorée si une sauvegarde plus ancienne
  l'a encore.
- `ReadingIntroPanel` (seul panneau qui n'avait aucune fermeture à la souris/au tactile avant
  cette tâche, uniquement Echap) gagne une croix de fermeture (`HeaderRow`/`CloseButton`, même
  composant que `SubjectSelectPanel`/`QuestionPanel`) pour ne rien perdre en fonctionnalité.
- Le tactile fonctionne déjà nativement sans code de détection de plateforme : le réglage moteur
  `Emulate Mouse From Touch` (actif par défaut, jamais modifié dans ce projet) traduit chaque tap
  en `InputEventMouseButton` équivalent — toute l'UI (`Button`/`Control` standards) répond donc
  déjà aux deux en même temps.

**Floutage uniformisé sur les fenêtres PNJ (2026-09-04)** : voir CHARTE_GRAPHIQUE.md pour le détail
complet et la citation du retour utilisateur. `QuestionPanel`, `SubjectSelectPanel` et
`ReadingIntroPanel` (jusque-là sans flou, contrairement à `GameMenuPanel`/`BackpackMenu`) reçoivent
chacune un export `blur_bg_path: NodePath`, même mécanisme que `BackpackMenu.blur_bg_path` :
bascule dans le `_on_visibility_changed()` déjà existant de chaque panneau (en même temps que
`PlayerInputLock`). Les trois pointent vers un même nouveau nœud `NpcBlurBG` (`ColorRect`,
`game_ui.tscn`, tout premier enfant du `CanvasLayer UI` pour se dessiner sous les trois),
réutilisant le `SubResource("ShaderMaterial_backpack_blur")` déjà déclaré pour `BackpackBlurBG` —
un seul matériau de flou partagé par les deux ColorRect plutôt qu'un doublon.

**Menus masqués + Échap pendant une session de questions (2026-09-04)** : voir CHARTE_GRAPHIQUE.md
pour le détail complet et la citation du retour utilisateur. `QuestionPanel` gagne deux exports
`open_menu_button_path`/`backpack_button_path` (`NodePath` vers `OpenMenuButton`/`BackpackButton`
dans `game_ui.tscn`), basculés dans `_on_visibility_changed()` (`visible = not visible` du
panneau) — les 2 boutons d'ouverture de menu sont masqués tant qu'une session de questions est
affichée. `QuestionPanel` gagne aussi un `_unhandled_input()` (seule exception au retrait général
des raccourcis clavier du 2026-09-02) : Échap appelle `_abort_pack()`, la même fonction que
`close_button` — comportement strictement identique aux deux, y compris après l'affichage du
récapitulatif (la récompense est déjà versée à ce stade, voir doc-comment de `_abort_pack()`).
Ignoré si le panneau n'est pas visible, pour ne jamais intercepter un Échap destiné à une autre
fenêtre.

**Correctif (2026-09-04, même jour)** : le masquage des 2 boutons n'était câblé que sur
`QuestionPanel`. `SubjectSelectPanel` et `ReadingIntroPanel` (les 2 fenêtres qui précèdent la
question dans le flux PNJ) reçoivent désormais les mêmes exports
`open_menu_button_path`/`backpack_button_path`, avec le même toggle dans leur
`_on_visibility_changed()` — les 2 icônes de menu sont donc masquées dès la première fenêtre du
flux PNJ (choix de matière ou texte de lecture), pas seulement pendant les questions elles-mêmes.

**Thème d'interface et musique de fond passent PAR COMPTE (2026-09-06)** : retour utilisateur
"pour l ecran dintro je veux que le theme de couleur soit fixe et ne varie pas de 'fete foraine',
des le log in dans un compte, le theme du compte prend effet, on laissera aussi la musique de base
pour l intro et on passera a la musique debloquee et choisie par le compte sil y en a une".
`SaveManager.ui_theme` n'est plus un réglage d'appareil partagé (`device_settings["ui_theme"]`,
retiré de `_save_to_disk()`/`_read_from_path()`, ancienne clé désormais ignorée comme
`custom_bindings`/`master_volume`) : c'est désormais un réglage PAR COMPTE, exactement comme
`music_volume`/`sfx_volume` depuis le 2026-09-05 — stocké dans `profile["ui_theme"]`,
`_apply_theme_from_profile()`/`_reset_theme_to_default()` (nouvelles, même forme que leurs
équivalents volume) appelées aux mêmes points (`login()`/`create_account()` pour appliquer,
`logout()`/`delete_current_account()` pour revenir à `DEFAULT_UI_THEME` = "fete_foraine").
`set_ui_theme()` (appelée par `SectionConfig`, qui ne vit que dans le menu de jeu donc jamais sur
l'écran d'accueil) persiste maintenant dans le profil du compte connecté au lieu du disque
directement. Résultat : `WelcomePanel` affiche toujours "Fête foraine" (valeur de départ de la
variable, plus jamais relue du disque), le thème choisi par le compte ne s'applique qu'après
connexion, et revient à "Fête foraine" à la déconnexion.

Côté musique, `SoundManager` gagne `_resolve_music_path()`/`_refresh_music()` : la musique de base
(`lofi.ogg`) reste toujours celle de l'écran d'accueil, remplacée par la musique de la première
classe à la fois débloquée ET activée du compte connecté (`ClassroomMusic.is_active`, voir plus
bas) SI son fichier existe (`_CLASSROOM_MUSIC_PATHS`, convention `classe-<CLASSE>.ogg` — aucun
fichier fourni pour l'instant, fallback silencieux vers la musique de base tant que c'est le cas,
même principe que les `Sfx` non fournis). Un seul `AudioStreamPlayer` réutilisé (swap de `stream`)
plutôt que recréé à chaque changement, mis à jour via `SaveManager.account_logged_in`/
`account_logged_out` et `ClassroomMusic.music_activated`.

## Ce qu'il reste à faire

- `csv/cards.csv` compte 125 cartes (25 espèces × 5 classes), toutes avec leur art dans
  `assets/classe2.0/pets/` depuis le 2026-08-30 (voir "Outils admin" plus haut) — section obsolète
  sur ce point, conservée pour le reste de la liste.
- Habiller les scènes (style de l'UI restant) — le reste de cette entrée (mesh 3D du perso/PNJ,
  décor du parc, kiosque) date d'avant le pivot 2D (2026-08-08) et le retrait du kiosque
  (2026-08-29), n'a plus lieu d'être.
