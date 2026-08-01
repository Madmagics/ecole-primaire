# Charte graphique — direction "Fête foraine"

Première passe de style visuel sur l'UI (2026-07-23), en remplacement du thème par défaut de
l'éditeur (voir "Ce qu'il reste à faire" dans `ARCHITECTURE.md`, qui notait l'UI comme
"squelette fonctionnel sans art"). Direction choisie parmi plusieurs propositions : contours
épais façon BD/cartoon, couleurs chaudes et vives mais pas criardes, pensée pour un public de
5 à 10 ans (gros contrastes, formes simples — cohérent avec la doc "Caméra et déplacement" de
`ARCHITECTURE.md` qui vise déjà ce public).

## Palette

- **Encre (contours, texte sur fond clair)** : `#7A4A2B`
- **Fond des panneaux principaux** : crème `#FFF0D6`
- **Fond des lignes de liste** (coffre, item) : blanc `#FFFFFF`
- **Boutons** : jaune `#FFDD57` (normal), `#FFE685` (survol), `#F2C93E` (pressé)
- **États désactivés** : gris chaud `#E0DCD3` (fond), `#A69C8C` (contour/texte)

Ces couleurs sont **indépendantes** du code couleur des classes (`GradeLevel.get_color()` :
CP=blanc, CE1=vert, CE2=bleu, CM1=violet, CM2=orange — mêmes valeurs que l'ancien
`CardRarity.get_color()`, réutilisées via délégation depuis le 2026-07-26, voir la section
"Design des cartes" plus bas) — les deux systèmes cohabitent sans se marcher dessus (voir règle
ci-dessous).

## Où c'est appliqué

Un unique `Theme` global : `ui/theme/game_theme.tres`, référencé dans `project.godot` via
`[gui]/theme/custom`. Il cascade automatiquement à tous les `Control` du jeu sans avoir à
toucher chaque scène : styles `Panel` (fond crème, contour 4px, coins arrondis 20), `PanelContainer`
(lignes de liste : fond blanc, contour 3px, coins 14), et `Button` (4 états — normal/survol/
pressé/désactivé — avec un contour bas plus épais en état normal/survol qui s'aplatit en
pressé, pour un effet "bouton 3D" cartoon sans dégradé ni ombre, non supporté nativement en
StyleBoxFlat). Taille de police globale relevée à 20 (`default_font_size`) pour la lisibilité
à cet âge.

**Police (2026-07-26)** : `default_font` pointe sur **Baloo 2 SemiBold** (600), `ui/theme/fonts/
Baloo2-SemiBold.ttf` (Google Fonts, licence OFL) - choisie ronde/enfantine/lisible parmi 5
candidates comparées (Baloo 2, Fredoka, Quicksand, Comfortaa, Varela Round), en SemiBold plutôt
que Bold (moins lourd visuellement). Réglée dans les 4 fichiers de thème (`game_theme.tres`,
`theme_bonbon.tres`, `theme_sombre.tres`, `theme_tropical.tres`) pour s'appliquer quel que soit
le thème choisi par le joueur - un seul fichier de police, quatre `ext_resource` distincts (un
par thème, Godot ne partage pas les ext_resource entre fichiers `.tres` séparés).

## Règle importante : ne jamais fixer `Label/colors/font_color` dans le thème global

De nombreux Labels du projet utilisent `modulate` pour encoder une information (rareté ou
résultat), pas une couleur de thème fixe : `CoinHUD`, `CrateItem.price_label`,
`GradeUnlockItem.price_label`, `LootFeed`, `SectionStats` (labels de rareté générés en boucle),
`QuestionPanel` (réponse correcte/incorrecte). `modulate` **multiplie**
la couleur de base du Label : si le thème fixait une `font_color` foncée par défaut, la
multiplication écraserait ces couleurs de rareté/résultat. Le thème global ne touche donc
jamais `Label/colors/font_color` — seuls les Labels qui n'ont pas ce besoin reçoivent la
variante de type `TitleLabel` (texte encre foncée, taille 24), posée **au cas par cas** sur
chaque scène concernée (titres de panneaux, noms d'objets, texte de progression...), jamais
globalement.

## Themes multiples (2026-07-23)

Le thème n'est plus figé : 4 variantes existent maintenant sous `ui/theme/` (`game_theme.tres` =
Fête foraine, `theme_bonbon.tres`, `theme_tropical.tres`, `theme_sombre.tres` — ce dernier pensé
pour jouer dans une pièce peu éclairée, fond sombre + bordures dorées, jamais de texte foncé sur
fond foncé). Le joueur choisit sa vignette dans Configuration (menu, touche `C`) ; le choix est
appliqué immédiatement via `get_tree().root.theme` (propage automatiquement à tous les `Control`,
voir `SaveManager._apply_ui_theme()`) et persiste dans `savegame.json`. Ajouter un 5e thème = un
nouveau `.tres` sous `ui/theme/` + une entrée dans `SaveManager.THEMES` et `THEME_PREVIEWS` — la
vignette apparaît toute seule dans Configuration, aucune scène à retoucher.

Chaque variante définit sa propre couleur `TitleLabel` (texte foncé sur fond clair pour les 3
premières, texte clair sur fond sombre pour "Sombre") — c'est le seul endroit où la couleur de
texte doit changer d'un thème à l'autre, la règle sur `modulate` (voir plus haut) reste valable
pour les 4.

## Raccourcis clavier des sections du menu (2026-07-23)

Chaque section du menu (sauf Collection, qui reste gérée par `CardAlbum`) a sa propre touche
directe, rebindable comme les autres actions (`SaveManager.REBINDABLE_ACTIONS`) : `C`
Configuration, `V` Sauvegarde, `K` Commandes, `P` Statistiques, `L` Collection. `M` ouvre/ferme le
menu dans son ensemble (touche `open_menu`, même comportement que le clic sur le bouton "M" du
HUD - les deux appellent `GameMenuPanel.toggle()`). Une vignette carrée à droite de chaque ligne
de nav (`ui/game_menu/game_menu_panel.tscn`) affiche la touche actuelle, mise à jour à chaque
ouverture du menu. Presser la touche d'une section déjà affichée ferme le menu (même principe que
`L`/`CardAlbum`) ; la presser depuis une autre section bascule directement dessus.

Le bouton "M" du HUD se cache automatiquement tant que le menu **ou** le livre de collection est
ouvert (`ui/hud/menu_toggle_button.gd`, générique - ne connaît que les `Control` qu'on lui associe
via une liste de NodePath, pas directement GameMenuPanel/CardAlbum). CardAlbum est surveillé en
plus de GameMenuPanel depuis le 2026-07-25 : il a son propre raccourci "L" (voir plus bas) et peut
s'ouvrir sans passer par le menu, donc le bouton doit aussi réagir à sa visibilité pour ne pas
rester affiché par-dessus le livre.

**Piège AZERTY (2026-07-23) :** `physical_keycode` est positionnel, toujours référencé sur une
disposition QWERTY. Sur un clavier AZERTY, M et point-virgule sont permutés par rapport à QWERTY
(la touche physique "M" imprimée est à la position que Godot appelle "Semicolon"). La touche par
défaut de `open_menu` est donc réglée sur le code physique du point-virgule (QWERTY) pour que la
touche réellement imprimée "M" fonctionne sur AZERTY. Pour l'affichage des touches (badges du
menu, `SaveManager.get_binding_label()`), ne jamais faire `OS.get_keycode_string(physical_keycode)`
directement - toujours passer par `DisplayServer.keyboard_get_label_from_physical()` d'abord, qui
convertit vers le caractère réellement imprimé sur la disposition active du joueur.

**Collisions de touches (2026-07-23) :** `SaveManager.rebind_action()` refuse maintenant qu'une
touche soit partagée par deux actions - si l'action B revendique une touche déjà prise par A, B
retrouve son binding par défaut (`_default_bindings`, capturé depuis project.godot au tout
premier démarrage). `_resolve_binding_collisions()` fait le même ménage au chargement d'une
sauvegarde plus ancienne qui aurait fixé une collision avant cette garde (c'est ce qui était
arrivé à Commandes/Statistiques, toutes deux figées sur la même touche dans le fichier de
sauvegarde).

**Le nettoyage n'était pas persisté (2026-07-23, suite) :** `_resolve_binding_collisions()`
corrigeait la collision seulement en mémoire à chaque chargement, sans jamais réécrire
`savegame.json` - le fichier restait corrompu et la collision "revenait" à chaque partie tant que
le fichier n'était pas réécrit. Ajout de `_enforce_no_runtime_collisions()` (appelée à la fin de
`_apply_settings()`, donc après application de tous les bindings) : vérifie l'état réellement
appliqué à `InputMap` - pas seulement le dictionnaire `custom_bindings` du JSON - corrige toute
collision restante et **sauvegarde immédiatement** (`save_game()`) dès qu'un changement a eu
lieu, pour assainir le fichier une bonne fois pour toutes. Si le souci persiste malgré tout après
un redémarrage complet du jeu (pas juste une fermeture du menu), le plus sûr est de supprimer
directement `savegame.json` (sous Windows : `%APPDATA%\Godot\app_userdata\Projet petshop\
savegame.json`) - le jeu repart alors sur les valeurs par défaut de `project.godot`, garanties
sans collision.

## Design des cartes (album/book, 2026-07-25)

`ui/collection/card_slot.gd`/`.tscn` construisent la vignette de carte entièrement via
`StyleBoxFlat` généré en code (pas de PNG pré-assemblé) : cadre épais coloré directement avec
`GradeLevel.get_color()`, fond intérieur crème `#FFF0D6`, ombre plate décalée en gris foncé
`#5F5E5A` (assombrie depuis `#888780` le 2026-07-26)
(pas de flou/dégradé, cohérent avec le reste de l'UI qui n'utilise que des aplats), pastille de
nom en bas reprenant la même couleur de classe. Le contour du personnage (dessiné plus tard dans
l'art réel du pet) reste en encre `#7A4A2B`.

**2026-07-26 : cartes agrandies x1.5, une page = 1 rangée de 5 cartes.** Depuis que le système de
classe a remplacé la rareté, une catégorie a toujours exactement 5 variantes (une par classe) - la
2e rangée de l'ancien layout (2 rangées de 5) restait donc systématiquement vide. `CardAlbum`
passe à `ROWS_PER_PAGE = 1`, et `CardSlot.CARD_SIZE` passe de 126×190 à 189×285 (toutes les
constantes de style - `FRAME`, `OUTER_RADIUS`, `INNER_RADIUS`, `NAME_HEIGHT`, `SHADOW_OFFSET`,
tailles de police du nom/du "?"/du badge "+N" - suivent le même facteur ×1.5, design identique
juste à plus grande échelle). Le `ScrollContainer` de `card_album.tscn` est redimensionné en
conséquence pour n'afficher qu'une seule rangée sans scroll.

**2026-07-26 : fond "parchemin" du CardAlbum, titre "Grimoire des animaux extraordinaires".**
`Panel/AtlasBackground` (`atlas_background.gd`) dessine à la main (aplats + traits `_draw()`, pas
de texture/dégradé) un papier ancien : quelques taches d'ancienneté, un double liséré avec petits
repères, et des fleurons d'angle. Le titre n'est plus dans un encadré : `TitleBlock` (VBox) empile
le titre, un simple soulignement double (`title_underline.gd`) et un `CategoryLabel` affichant la
catégorie de la page en cours. Le double liséré étant très proche du bord du panneau (~17px), la
grille de cartes, le bouton de fermeture et la barre de navigation ont tous été reculés pour ne
jamais le chevaucher — à ajuster ensemble si la taille du panneau ou des cartes change encore.
Palette pilotée par le thème actif (pas de couleurs figées) : `CardAlbum._apply_theme_colors()`
lit le `Panel/styles/panel` du `Theme` en cours (`bg_color` → papier, `border_color` → encre) et
le `Button/styles/normal` (`bg_color` → accent de `CategoryLabel`), donc le grimoire change
d'ambiance avec les 4 thèmes (`game_theme`/`theme_bonbon`/`theme_sombre`/`theme_tropical`) au lieu
de rester toujours beige.

**2026-07-26 : la rareté a disparu du système de cartes.** `CardResource` n'a plus de champ
`rarity` — remplacé par `grade` (`GradeLevel.Grade`, CP à CM2), lu depuis la colonne `classe` de
`csv/cards.csv` (une variante = une classe, 5 variantes par espèce = les 5 classes). Raison :
Steve veut pouvoir localiser le jeu à terme, et "CM2"/"légendaire" n'ont pas le même sens
first-class à l'international — la classe pourra être ré-affichée en âge (6-10 ans) plus tard
sans toucher aux couleurs (voir plan i18n classe→âge). `CardRarity` reste utilisé tel quel pour
tout le système économique (coffres, boutique, pièces de récompense) — seul l'usage sur les
cartes elles-mêmes a changé ; `GradeLevel.get_color()` délègue en interne à
`CardRarity.get_color()` pour ne pas dupliquer la palette.

Tant qu'aucune image n'existe pour une carte (`data/card/art/<id>.png`, voir
`tools/admin/import_cards.gd`), `PetPlaceholderIcon` (nouveau script, `ui/collection/`) dessine
une silhouette générique de patte via `_draw()` - remplacée automatiquement par la vraie texture
dès qu'elle est importée, aucun changement de code nécessaire à ce moment-là.

Carte non découverte (`quantity == 0` dans `CardSlot.display()`) : même cadre, mais en gris
neutre plutôt que la vraie couleur de classe (pour ne pas la révéler avant obtention), icône et
nom remplacés par `"?"`. Contrairement aux autres Labels du projet (voir règle `modulate`
ci-dessus), `CardSlot.name_label` reçoit sa couleur via `add_theme_color_override` posé
**par instance** dans `display()` - ce n'est pas le thème global qui fixe cette couleur, donc pas
de conflit avec la règle.

## CheckBox stylé + corrigé (2026-07-28)

La case "Plein écran" (seule `CheckBox` du projet, `SectionConfig`) n'avait aucun style dans le
thème global : elle utilisait le thème par défaut de l'éditeur, dont les marges de contenu
(`content_margin`) diffèrent entre l'état normal et l'état survolé - au survol, le texte se
décalait et chevauchait la case à cocher (voir le comportement documenté des `Button`/`BaseButton`
dans le tracker Godot, issue godotengine/godot#85095 : c'est en principe la stylebox "normal" qui
fixe la marge de tous les états pour éviter ce genre de saut, mais l'implémentation par défaut de
`CheckBox` n'harmonise pas forcément ses propres styleboxes). Chaque thème définit maintenant ses
propres styles `CheckBox` (`styles/normal|hover|pressed|hover_pressed|disabled`) avec
**exactement la même** `content_margin` sur les 4 côtés pour tous les états - fond transparent au
repos, léger fond teinté + bordure (couleurs du survol/pressé des `Button` du même thème, en
transparence réduite) au survol/pressé, pour un retour visuel cohérent avec les boutons sans
jamais déplacer le texte. Couleur de police : ink foncée des 3 thèmes clairs, texte clair
(`#F2E9DA`) pour "Sombre" (la case n'a pas de fond opaque au repos, contrairement aux `Button`).

## Code couleur des matieres (2026-07-28, revu le meme jour)

Chaque matiere a deja une couleur (`SubjectType.get_color()`, utilisee pour la couleur des pieces
gagnees au HUD) - reutilisee telle quelle comme code couleur des cases de matiere dans
`SubjectSelectPanel` (menu de choix de matiere d'un PNJ), au lieu d'inventer un second systeme de
couleurs.

Deux essais avant la version retenue : teinter directement la bordure du bouton (abandonne - se
confondait avec le fond du bouton selon le theme, ex. matiere bleue sur bouton dore du theme
Sombre, contraste WCAG 1.28), puis une pastille separee a gauche du texte (fonctionnelle mais pas
au gout du joueur). Version retenue (`SubjectSelectPanel._build_subject_frame`) : chaque bouton de
matiere est pose dans une carte (`PanelContainer`) dont le fond plein est la couleur de la
matiere, avec le bouton legerement inset (`content_margin`, ~7px) pour laisser apparaitre un
anneau colore tout autour - le bouton lui-meme garde son style natif du theme. L'anneau touche le
fond du PANNEAU (toujours peu sature dans les 4 themes) plutot que le fond du bouton (tres
sature), ce qui donne un contraste bien plus fiable qu'une bordure de bouton recoloree, tout en
gardant l'effet "case coloree" voulu.

Palette (revue le 2026-07-28) : MATH bleu (`4C9AFF`), les 3 "sous-matieres" francaises
(GRAMMAR/CONJUGATION/SPELLING, issues du meme contenu francais d'origine) en couleurs chaudes -
rouge (`E64545`), orange (`FF9800`), jaune dore (`E0A100`) - READING en marron (`8B5E34`), ENGLISH
en vert (`66BB6A`). FRENCH (id historique, plus utilise pour de nouvelles questions depuis la
scission en 3) garde son ancienne couleur rouge, non affichee dans les menus actuels.

**Bouton sans bordure propre (2026-07-28, suite) :** le bouton natif du theme (bordure epaisse
"effet 3D", voir plus haut) combine a la carte coloree autour faisait doublon - deux bordures
empilees, visuellement charge. Nouvelle variante de theme `SubjectButton` (voir les 4 `.tres`,
meme mecanisme que `TitleLabel` : `base_type = &"Button"`, appliquee via
`button.theme_type_variation = &"SubjectButton"` dans `SubjectSelectPanel._build_subject_frame`)
qui reprend exactement les couleurs de fond du `Button` global de chaque theme (repos/survol/
pressé/désactivé) mais SANS aucune bordure - la carte coloree suffit a delimiter le bouton. Au
survol, seule la couleur change (vers la teinte "douce" deja utilisee comme hover du theme), sans
effet de bordure a gerer. Cette variante ne touche pas le `Button` global (menu, boutique, etc. la
gardent inchangee) : elle ne s'applique qu'aux boutons de matiere.

**Fond eclairci (2026-07-28, suite) :** le fond au repos du bouton (couleur vive du theme, ex.
jaune `FFDD57`) faisait trop charge a cote de la carte coloree. Remplace par la couleur de fond du
PANNEAU (`Panel/styles/panel`, ex. creme `FFF0D6`) - plus clair, laisse la carte coloree porter
l'information de couleur. Le survol garde la teinte deja utilisee (inchangee). Cas particulier
"Sombre" : son fond de panneau est sombre (pas plus clair), donc le bouton au repos y devient
quasi invisible sur le panneau tout en restant bien delimite par sa carte coloree (effet "halo") -
la couleur de police du bouton bascule alors sur la teinte claire de `TitleLabel` au repos/focus
(au lieu de l'encre foncee, illisible sur un fond sombre), et revient a l'encre foncee au survol/
pressé puisque ces etats gardent leur fond dore clair.

**Epaisseur de l'anneau (2026-07-28, suite) :** `_FRAME_THICKNESS` ramene de 7 a 4px, aligne sur
`border_width_*` de `StyleBoxFlat_panel` - meme epaisseur que le cadre du panneau principal et les
autres cadres du menu (7px faisait plus epais que le reste de l'UI).

## Panneau de choix de matiere : taille fixe + recentrage (2026-07-28)

Le panneau (`SubjectSelectPanel`) a une taille MINIMALE fixe (`custom_minimum_size = 560x420` sur
le `PanelContainer` racine) au lieu de s'ajuster strictement au contenu : les classes avec peu de
matieres (CP notamment) se retrouvaient avec un panneau plus etroit, ce qui coupait le titre sur
2 lignes - un cadre de taille coherente d'un PNJ a l'autre est plus lisible. Le panneau peut
encore grandir au-dela de cette taille minimale si une classe propose un jour beaucoup plus de
matieres (evite de retomber dans le bug de debord d'origine). Les cases de matieres sont
enveloppees dans un `CenterContainer` (`Panel/Margin/Content/Center`) : avec une seule colonne
(peu de matieres), le bloc de boutons est centre horizontalement (et verticalement) dans le
panneau au lieu de rester colle a gauche.

## Ordre des matieres dans le menu (2026-07-28)

L'ordre d'affichage (`QuestionGiverComponent.get_available_subjects`) est trie sur la valeur de
l'enum `SubjectType.Subject` plutot que laisse dans l'ordre de scan du dossier de questions (qui
dependait du systeme de fichiers et rendait l'ordre incoherent d'un PNJ/d'une machine a l'autre) -
l'enum est deja range dans un ordre pedagogique voulu (maths, puis les 3 competences francaises
regroupees, anglais et lecture en dernier).

## Texte blanc illisible dans Statistiques (2026-07-28)

Deux bugs distincts derriere le meme symptome ("texte blanc" signale par l'utilisateur) :

1. `SectionStats._refresh_by_subject()` creait ses labels ("Mathematiques : X pack(s)"...) sans
   `theme_type_variation = &"TitleLabel"` - ils gardaient donc la couleur par defaut du moteur
   pour `Label.font_color` (blanc, voir doc Godot), le theme global ne la fixant jamais expres
   (regle deja documentee plus haut). Corrige en ajoutant la variante `TitleLabel`, comme les
   autres labels de la section.
2. Le contour noir cense rendre lisible le texte des labels a couleur de rarete (`_refresh_coins`,
   `CoinHUD`, `LootFeed` - "commune" = blanc, voir `CardRarity.get_color`) ne s'affichait en
   realite JAMAIS : le code appelait `add_theme_font_size_override("outline_size", ...)`, alors
   qu'`outline_size` est une **constante** de theme (categorie `theme_override_constants`), pas
   une taille de police - avec la mauvaise categorie, Godot ignore silencieusement l'override
   (aucune erreur, aucun contour). Corrige dans les 3 fichiers (`section_stats.gd`, `coin_hud.gd`,
   `loot_feed.gd`) en `add_theme_constant_override("outline_size", ...)` - meme categorie que
   `card_slot.tscn`, qui utilisait deja la bonne syntaxe (`theme_override_constants/outline_size`)
   et n'a jamais eu ce probleme.

## QuestionPanel : cadre adaptatif + refonte (2026-07-28)

Refonte complete de `ui/question_panel/question_panel.tscn` : l'ancien `Panel` a taille fixe
(500x360, positions d'enfants en pixels codes en dur) causait trois problemes rapportes -
questions longues tronquees (le `QuestionLabel` avait une hauteur figee, le texte au-dela etait
simplement invisible), texte colle aux boutons de choix (10px d'ecart fixe), et boutons de choix
qui debordaient du cadre sur certains ecrans (largeur codee en dur sans rapport avec la taille
reelle du panneau). Remplace par la meme approche que les autres panneaux modaux
(`PanelContainer` + conteneurs) mais avec deux differences deliberees :

- **Cadre en pourcentage d'ecran**, pas en pixels fixes : `anchor_left/top/right/bottom` a
  `0.1/0.08/0.9/0.92` (80% de large, 84% de haut) - le panneau occupe une place plus importante et
  s'adapte a la taille reelle de la fenetre/de l'ecran, plutot qu'une boite figee en pixels.
- **Question dans un `ScrollContainer`** (`horizontal_scroll_mode = 0`, comme
  `section_controls.tscn`) plutot qu'un simple Label : force le texte a rester dans la largeur du
  cadre (donc a s'enrouler), et permet de faire defiler verticalement dans le cas (rare vu la
  taille du cadre) ou une question serait quand meme plus haute que l'espace disponible - aucune
  troncature possible, contrairement a un Label a hauteur fixe.

Meme panneau (meme taille) utilise pour les questions ET le tableau recapitulatif de fin de pack :
`_set_panel_half_size()` (deux tailles differentes, question vs resultat) est supprime, le cadre
etant deja assez grand pour les deux usages sans le distinguo.

Habillage visuel (contre le cote "austere" signale) : la question est posee dans une carte
(`QuestionCard`, `PanelContainer` sans style specifique - herite simplement du style
`PanelContainer` global du theme, meme "carte blanche" que les lignes de liste ailleurs dans
l'UI), et le compteur "Question X/Y" est dans une pastille (`ProgressBadge`, meme mecanisme,
aucune StyleBox a creer) - reutilise le vocabulaire visuel deja etabli plutot que d'introduire de
nouvelles couleurs/styles.

**Texte blanc dans le tableau recapitulatif :** la colonne "Question" n'avait jamais de
`theme_type_variation` ni de `modulate` (contrairement a "Ta reponse"/"Correction", colorees en
vert/rouge sur les lignes de donnees) - elle restait donc blanche par defaut, illisible. Corrige
en lui donnant `TitleLabel`. Pour la ligne d'en-tete (labels "Ta reponse"/"Correction" eux-memes,
pas les valeurs), meme correction, mais seulement dans le cas `is_correct == null` : ces deux
labels reçoivent un `modulate` vert/rouge sur les lignes de donnees, `TitleLabel` y fausserait la
couleur par multiplication (regle modulate documentee plus haut) - sans danger uniquement sur la
ligne d'en-tete, qui n'a pas de modulate.

**Tableau recapitulatif retravaille, 1ere passe (2026-08-01) :** le `GridContainer` a 3 colonnes
egales rendait le tableau illisible - colonnes "Ta reponse"/"Correction" bien plus larges que
necessaire (un nombre ou un mot court), colonne "Question" trop etroite du coup (saut de ligne sur
quelques mots), et aucune separation visuelle entre les lignes. Remplace par un `VBoxContainer`
(`ResultRows`) de lignes en carte (`PanelContainer`) avec des `size_flags_stretch_ratio` differents
par colonne (question = 3, reponse/correction = 1 chacune). Ce format 3-colonnes s'est revele
encore trop serre a l'usage (texte "ecrase") - voir passe suivante.

**Regression carte question/score vide (2026-08-01) :** en retirant le `custom_minimum_size` fixe
de `QuestionScroll` (passe precedente, pour que la carte "Score" ne force plus une hauteur de
70px), la carte s'est mise a collapser a une hauteur quasi nulle - un `ScrollContainer` en mode
scroll vertical n'inclut pas la taille de son contenu dans son propre `custom_minimum_size` (c'est
le mecanisme meme qui permet le defilement), donc sans valeur explicite il retombe a ~0. Le bug
touchait les deux usages partages par ce noeud : la ligne "Score" ET l'affichage des questions
elles-memes. Corrige par un ajustement dynamique (`_fit_question_card`) : apres chaque
`question_label.text = ...`, on attend une frame (`await get_tree().process_frame`, le temps que
le moteur calcule le retour a la ligne sur la largeur deja fixee par le ScrollContainer), on lit la
hauteur reelle du Label, puis on la clamp entre `QUESTION_CARD_MIN_HEIGHT` (40, une ligne) et
`QUESTION_CARD_MAX_HEIGHT` (170, ~5 lignes) et on l'applique a
`question_scroll.custom_minimum_size.y`. Au-dela de 170px, le `ScrollContainer` reprend son role de
filet de securite (defilement) plutot que de faire grossir la carte indefiniment.

**Tableau recapitulatif, 2eme passe - lignes verticales (2026-08-01) :** le format 3-colonnes
restait illisible ("texte ecrase" - retour utilisateur). Remplace par 3 lignes empilees par carte
de reponse (`_add_result_row`) : ligne 1 = question en pleine largeur, ligne 2 = "Ta reponse : ..."
(verte si juste, rouge si fausse), ligne 3 = "Correction : ..." (verte, seulement si la reponse
etait fausse - omise sinon, pour ne pas laisser une ligne vide). Les lignes 2 et 3 sont decalees de
20% vers la droite par rapport a la question via `_build_indented_line` (un `Control` spacer de
`size_flags_stretch_ratio = 0.2` suivi du label a `0.8`), pour bien les distinguer d'un coup d'oeil.
La ligne d'en-tete ("Question"/"Ta reponse"/"Correction") disparait : chaque ligne porte desormais
son propre intitule ("Ta reponse : ...", "Correction : ..."), redondant avec un en-tete separe dans
ce nouveau format.

**Fond du cadre de lecture aligne sur les cartes resultat (2026-08-01) :** l'utilisateur a valide
la couleur de fond des cartes du tableau recapitulatif (le style `PanelContainer` global,
`StyleBoxFlat_row` - blanc pur en Bonbon/Tropicale, gris fonce en Sombre) et voulait la meme sur
les cadres questions et sur le texte de lecture. Verification faite : `QuestionPanel` (le cadre
global des questions) et `QuestionCard` sont deja des `PanelContainer` sans variation - ils
utilisent deja `StyleBoxFlat_row`, rien a changer la. En revanche `ReadingIntroPanel` (le texte a
lire avant les questions de comprehension) utilise un node `Panel` (pas `PanelContainer`), donc le
style `Panel/styles/panel` = `StyleBoxFlat_panel` - une teinte legerement differente (ex. Bonbon :
fond rose tres clair `Color(1, 0.952941, 0.972549)` contre le blanc pur `Color(1, 1, 1)` des
cartes). Plutot que de changer le node en `PanelContainer` (aurait casse le positionnement absolu
de ses enfants, qui suppose un `Panel` simple, pas un conteneur qui repositionne ses enfants) ou de
modifier `Panel/styles/panel` globalement (utilise aussi par Collection, Menu, Boutique - hors
perimetre de la demande), ajout d'une variante de theme `ReadingPanel` (`base_type = Panel`) dans
les 4 fichiers theme, qui reutilise directement la meme ressource `StyleBoxFlat_row` (pas une
copie : si la couleur des cartes change plus tard, celle du cadre de lecture suit automatiquement).
Appliquee via `theme_type_variation = &"ReadingPanel"` sur le node `Panel` de
`reading_intro_panel.tscn`.

**Fusion des cases Score et Résultat (2026-08-01) :** les deux cases separees ("Résultat" dans la
pastille d'en-tete `ProgressBadge`, et "Score : X/Y -> +N pièce(s) Rareté" dans `QuestionCard` en
dessous) fusionnees en une seule, affichee dans la pastille d'en-tete : "Résultat : X/Y, tu gagnes
N pièce(s) Rareté". `QuestionCard` (devenu inutile en mode resultat) est masque
(`question_card.visible = false`), liberant tout son espace pour le tableau recapitulatif en
dessous. Accord singulier/pluriel correct sur "pièce(s)" (l'ancien texte affichait litteralement
"pièce(s)", jamais accorde) : `0` ou `1` -> "pièce", `> 1` -> "pièces".

Positionnement : la pastille prend la place de l'ancienne case "Résultat" et garde le meme
mecanisme de hauteur (`PanelContainer` a `size_flags_horizontal = 0`, se redimensionne a son
contenu, une seule ligne) - elle s'elargit simplement pour le texte plus long, sans rien changer a
sa hauteur. `HeaderSpacer` (un `Control` a `size_flags_horizontal = 3`, entre la pastille et la
croix) reste actif dans les deux modes, sans bascule de visibilite : la pastille reste collee a
gauche et la croix epinglee en haut a droite du cadre quelle que soit la largeur du texte de la
pastille (retour utilisateur 2026-08-01, apres deux essais intermediaires - un ecart fixe collant
la croix a la pastille, puis un spacer inverse qui poussait les deux vers la droite - ni l'un ni
l'autre ne convenaient : la croix doit rester epinglee au coin en toutes circonstances).

**Cartes du tableau recapitulatif comprimees a gauche (2026-08-01) :** apres la refonte en lignes
verticales, chaque carte de reponse (bordure + contenu) restait comprimee a sa largeur minimale de
contenu au lieu d'occuper toute la largeur du tableau - la question repliait un seul mot par ligne,
et le cadre visible autour de la carte etait lui-meme etroit, pas seulement le texte. Cause :
plusieurs conteneurs de cette chaine, crees par script (`_add_result_row`/`_build_indented_line`),
n'avaient que le flag `FILL` par defaut (`size_flags_horizontal = 1`) sans `EXPAND` - suffisant en
temps normal pour un enfant unique de `MarginContainer`/`PanelContainer` (qui forcent le
remplissage quel que soit le flag), mais pas assez robuste ici avec une chaine aussi profonde de
conteneurs imbriques crees dynamiquement. Corrige en fixant explicitement
`size_flags_horizontal = Control.SIZE_EXPAND_FILL` sur chaque conteneur intermediaire (`lines`,
`row_margin`, `row_card`, et la ligne HBoxContainer de `_build_indented_line`) plutot que de
compter sur le comportement implicite - plus robuste et plus lisible pour du code qui construit son
arbre de noeuds dynamiquement.

**ReadingIntroPanel refondu avec le cadre adaptatif (2026-08-01) :** ce panneau utilisait encore
l'ancienne architecture - un `Panel` a taille fixe (600x440, offsets absolus, `layout_mode = 0` sur
tous ses enfants) qui ne s'adaptait ni a la largeur de l'ecran ni a la longueur du texte du
passage. Reconstruit sur le meme modele que `QuestionPanel` : `Panel` devient un `PanelContainer` a
ancres en pourcentage (0.1/0.08/0.9/0.92, identique a `QuestionPanel`) → `MarginContainer` (memes
marges, 28/20/28/28) → `VBoxContainer` `Content` (separation 18) → titre, puis `ScrollContainer`
(`horizontal_scroll_mode = 0`, meme technique d'auto-retour a la ligne contraint par la largeur).
Le `Panel` etant maintenant un `PanelContainer`, il reutilise directement le style
`PanelContainer/styles/panel` (`StyleBoxFlat_row`) sans variation de theme dediee - la variante
`ReadingPanel` ajoutee la fois precedente (specifiquement pour contourner l'ancien `Panel` a
positionnement absolu) devient inutile et est retiree des 4 fichiers theme.

Titre remplace : "À lire attentivement..." -> "Découvre cette histoire puis réponds aux
questions." (`autowrap_mode` ajoute par securite si le texte plus long devait se replier sur un
tres petit ecran).

Bouton "Commencer les questions" deplace a l'interieur du `ScrollContainer`, juste apres le Label
du texte (tous deux enfants d'un `VBoxContainer` `TextContent`, seul enfant autorise du
`ScrollContainer`) : pour un texte court, il apparait directement sous le texte sans qu'il y ait
besoin de scroller ; pour un texte qui deborde du cadre, il ne devient visible/cliquable qu'une
fois arrive au bout du defilement (retour utilisateur 2026-08-01 - empeche de lancer les questions
sans avoir fait defiler tout le passage).

**Retrait du scroll sur la carte question et les boutons de reponse (2026-08-01) :** la carte
question utilisait un `ScrollContainer` (`QuestionScroll`) redimensionne a la main
(`_fit_question_card`, ajoutee le 2026-08-01 plus tot dans la journee) : mesurer la hauteur du
`Label` une frame apres avoir change son texte, puis appliquer un `clampf` sur
`custom_minimum_size.y` du `ScrollContainer`. En pratique ce filet s'est revele fragile - retour
utilisateur avec une question sur 2 lignes affichee a moitie tronquee avec une barre de defilement
visible (le calcul en une frame ne recuperait pas toujours la hauteur finale une fois le texte
reellement replie a la largeur du cadre). Plutot que de fiabiliser ce hack, le `ScrollContainer`
est retire entierement : `QuestionLabel` passe directement enfant de `QuestionCardMargin`
(`MarginContainer`), sans intermediaire. Un `Label` avec `autowrap_mode` actif, place dans une
chaine de conteneurs qui lui impose deja sa largeur (comme c'est le cas ici), calcule nativement sa
hauteur minimale d'apres le nombre de lignes repliees - le moteur fait le travail que le script
tentait de reproduire a la main, sans latence d'une frame ni risque de decalage. Meme traitement
sur les boutons de reponse QCM (`_populate_choice_buttons`) : chaque `Button` recoit
`autowrap_mode = TextServer.AUTOWRAP_WORD`, qui fait grandir sa hauteur minimale si le texte de la
reponse passe sur 2 lignes, au lieu de deborder du bouton - `Button` supporte nativement
`autowrap_mode` depuis la 4.x (verifie sur `docs.godotengine.org/en/4.7/classes/class_button.html`
avant d'ecrire ce correctif), pas besoin non plus d'un conteneur de defilement ici. Aucun des deux
n'a de scroll desormais (demande explicite de l'utilisateur), seulement une adaptation automatique
de la hauteur.

**Coche/croix a cote de la reponse donnee (2026-08-01) :** ajout d'un badge rond (`ResultIcon`,
nouveau script `ui/question_panel/result_icon.gd`) sur la ligne "Ta réponse" du tableau
recapitulatif - coche verte si juste, croix rouge si fausse, en plus de la couleur deja appliquee
au texte. Dessine a la main (`draw_circle`/`draw_line`, verifie sur
`docs.godotengine.org/en/4.7/classes/class_canvasitem.html`) plutot qu'avec un glyphe Unicode
(✓/✕), pour ne pas dependre du support de ces caracteres par la police du theme (Baloo2). Taille
volontairement modeste (22px, `ResultIcon.SIZE`) pour rester decente a cote du texte sans le
dominer. Place dans la marge de 20% deja existante devant la reponse
(`_build_indented_line` : la marge, avant un simple `Control` vide, devient un `HBoxContainer`
aligne a droite - `BoxContainer.ALIGNMENT_END`, verifie sur
`docs.godotengine.org/en/4.7/classes/class_boxcontainer.html` - avec l'icone collee contre le
texte) ; ligne "Correction" non concernee (elle n'existe deja que quand la reponse est fausse, pas
besoin de son propre badge).

**Largeur des cases QCM fixee sur la reponse la plus longue (2026-08-01) :** les boutons de
reponse (`_populate_choice_buttons`) s'etiraient par defaut sur toute la largeur du cadre
(`Control.SIZE_FILL`, comportement par defaut d'un `VBoxContainer`), meme pour une reponse tres
courte - retour utilisateur "cases trop larges". Chaque bouton passe desormais en
`Control.SIZE_SHRINK_CENTER` (reduit a son contenu et centre horizontalement) ; sa largeur
naturelle sur une seule ligne est mesuree (`get_minimum_size().x`, avant d'activer l'autowrap - une
fois l'autowrap actif, cette mesure ne refleterait plus que le mot le plus long, pas la reponse
entiere) puis la plus grande valeur parmi les 4 choix est appliquee a tous via
`custom_minimum_size.x` : toutes les cases d'une meme question ont donc la meme largeur, fixee par
la reponse la plus longue, plutot que de remplir le cadre par defaut.

Plancher ajoute dans la foulee (meme jour) : une reponse la plus longue trop courte (ex. un seul
chiffre) donnait des cases trop etroites une fois reduites a leur contenu - retour utilisateur.
`MIN_CHOICE_WIDTH_RATIO` (0.3) impose une largeur minimale de 30% de la largeur du cadre, quelle
que soit la longueur de la reponse la plus longue. Premiere version basee sur
`choices_container.size.x` sans effet visible : ce noeud bascule `visible = false/true` a chaque
question (voir `_display_current_question`), et son `size` n'est pas garanti a jour au moment ou
`_populate_choice_buttons` s'execute (le retri d'un conteneur suite a un changement de visibilite
peut n'avoir lieu qu'a la frame suivante). Corrige en utilisant `panel.size.x` (le cadre entier de
la question, toujours visible et dimensionne par ses ancres des le demarrage - fiable a tout
instant) - c'est aussi la lecture correcte de "largeur du cadre" (le panneau entier, pas la
sous-zone des choix).

## Icônes d'objets — premier style validé (2026-08-01)

Suite à la discussion sur l'UI façon "boutique fête foraine" (références visuelles avec étal en
bois/onglets en banderole), deux niveaux de fidélité identifiés : un rendu illustré/peint complet
(texture bois, icônes peintes, logo en relief) qui suppose soit un outil externe (Figma/
Illustrator/Photoshop), soit un pack d'assets acheté, aucun des deux non disponibles ici ; et une
réinterprétation vectorisée plate, réalisable entièrement à la main (SVG écrit directement en
code, sans outil graphique). Steve a validé cette seconde option pour une première série d'icônes
(`assets/icons/concept_coffre.svg`, `concept_piece.svg`).

**Règles du style d'icône** (a suivre pour toute icône future de cette famille) :
- Aplats de couleur uniquement, jamais de dégradé/ombre (cohérent avec la règle déjà en place sur
  les `StyleBoxFlat` du thème).
- Contour encre fixe `#4A2E1A` (pas une des 4 couleurs d'encre par thème) : l'icône doit rester
  lisible sur les 4 thèmes, y compris "Sombre" dont le fond des lignes (`PanelContainer/styles/
  panel`) est sombre - une encre par thème disparaîtrait dessus. Testé visuellement sur fond blanc
  ET sur le gris `#3A3E45` (couleur exacte de `StyleBoxFlat_row` du thème Sombre) avant validation.
  Par construction l'icône porte son propre fond coloré (elle ne compte jamais sur le fond de la
  ligne pour être visible).
- Couleur d'or de la pièce reprise telle quelle du bouton du thème par défaut (`#FFDD57`), pour
  rester cohérente avec le reste de l'UI plutôt que d'inventer une nouvelle teinte. **Révisé le
  2026-08-01 (voir plus bas)** : la pièce est en fait recolorée dynamiquement par rareté/classe,
  sa base est donc passée au gris neutre plutôt qu'à l'or fixe.

**Intégration (2026-08-01)** : `CrateItem` affiche l'icône du coffre (`TextureRect` 32×32,
`expand_mode = EXPAND_IGNORE_SIZE`, `stretch_mode = STRETCH_KEEP_ASPECT_CENTERED` - verifie sur
`docs.godotengine.org/en/4.7/classes/class_texturerect.html`, necessaire car sans
`EXPAND_IGNORE_SIZE` le `TextureRect` imposerait la taille native du SVG importe comme minimum,
pas la taille voulue de 32px) a gauche du nom, et l'icone piece (18×18, meme reglages) juste avant
le prix (`PriceRow`, nouveau `HBoxContainer` autour de l'ancien `PriceLabel`). `GradeUnlockItem`
recoit uniquement l'icone piece (pas de coffre : ce n'est pas un coffre a ouvrir) - meme
`PriceRow`. Les deux `.svg` sont references par chemin (`res://assets/icons/...`), pas encore par
uid : le projet n'a jamais ete rouvert dans l'editeur Godot depuis leur ajout, l'import (et
l'attribution d'un uid) se fera automatiquement a la prochaine ouverture - a verifier a ce
moment-la que le rendu/l'echelle du SVG importe correspond bien a l'attendu (parametre `svg/scale`
de l'import, ajustable si besoin).

## Boutique v2 : onglets façon carte, suppression des répétitions, pièce colorée (2026-08-01)

Retour utilisateur sur la première version des onglets (v1, section précédente) : le contenu de
l'onglet s'affichait comme un bloc gris plat sans lien visuel avec le cadre crème arrondi du
panneau (le `TabContainer` n'avait aucun style de thème, donc Godot appliquait son style par
défaut - un panneau gris ordinaire), et l'onglet lui-même était un simple rectangle plat, trop
discret. Corrigé en ajoutant, dans les 4 fichiers thème, un jeu de styles dédiés :

- `TabContainer/styles/panel` (nouveau `StyleBoxFlat_tab_panel`) : reprend le fond/bordure de
  `StyleBoxFlat_row` (blanc en Fête foraine/Bonbon/Tropicale, gris foncé en Sombre) mais **sans
  bordure haute** (`border_width_top = 0`) et **arrondi seulement en bas**
  (`corner_radius_top_* = 0`, `corner_radius_bottom_* = 14`) - le contenu de l'onglet se fond
  ainsi directement dans l'onglet actif au-dessus, sans double-bordure à la jonction.
- `TabContainer/styles/tab_selected` / `tab_unselected` / `tab_hovered` (nouveaux
  `StyleBoxFlat_tab_*`) : cases nettement plus grosses que les boutons normaux
  (`content_margin` 20/10 contre 14/8), **arrondies seulement en haut**
  (`corner_radius_top_* = 14`, `corner_radius_bottom_* = 0`, symétrique du panel ci-dessus) et
  sans bordure basse, pour la même raison de jonction propre. L'onglet sélectionné reprend la
  couleur "bouton normal" du thème (vive, ex. `#FFDD57` en Fête foraine) pour bien ressortir ;
  l'onglet non sélectionné reprend la couleur de fond du panneau principal (`StyleBoxFlat_panel`,
  ex. crème `#FFF0D6`) pour se fondre dans le cadre plutôt que d'attirer l'œil - inspiré du design
  des cartes (`CardSlot`) : bordure encre épaisse, coins arrondis, aplats sans dégradé.
  `tab_disabled` réutilise directement `StyleBoxFlat_btn_disabled` (déjà thémé, pas de nouvelle
  ressource nécessaire).
- **Cas particulier Sombre** : ses lignes/panneaux ont un fond sombre alors que ses boutons
  restent dorés (texte encre foncée dessus) - même bascule de couleur de police déjà documentée
  pour `SubjectButton` (voir plus haut) : `font_selected_color`/`font_hovered_color` = couleur de
  police des `Button` (encre foncée, l'onglet actif étant doré) mais `font_unselected_color` =
  couleur de `TitleLabel` (crème claire, l'onglet inactif étant sombre comme le panneau).
  Vérifié sur `docs.godotengine.org/en/4.7/classes/class_tabcontainer.html` avant d'écrire ces
  propriétés (`font_selected_color`, `font_unselected_color`, `font_hovered_color`,
  `font_disabled_color`, `styles/panel`, `styles/tab_selected`, `styles/tab_unselected`,
  `styles/tab_hovered`, `styles/tab_disabled` - toutes confirmées existantes en 4.7).

**Suppression des répétitions** (retour utilisateur : "ça fait répétition") :
- Les intitulés de rareté au-dessus de chaque groupe ("Commune", "Peu commune"...) sont retirés de
  `ShopPanel._ready()` - `RARITY_DISPLAY_ORDER` ne sert plus qu'à trier les lots, sans en-tête
  visuel. L'information de rareté reste portée par le nom du lot et par la couleur de la pièce
  (voir ci-dessous).
- Le mot "Coffre" est retiré de `crate_name` dans les 5 `LootTableResource` (`data/loot/
  resources/crate_*.tres`) : les lots s'appellent maintenant juste "Commune", "Peu commune",
  "Rare", "Épique", "Légendaire" - l'icône du coffre (`ItemIcon`) porte déjà cette information
  visuellement, le mot était redondant.

**Pièce colorée par rareté/classe, prix en couleur normale de l'UI** : jusqu'ici c'est le texte du
prix qui portait la couleur de rareté (`price_label.modulate`) et la pièce restait dorée fixe.
Inversé sur demande : `PriceLabel` reçoit la variante `TitleLabel` (couleur encre normale du
thème, comme tous les autres textes) et c'est `CoinIcon.modulate` qui reçoit
`CardRarity.get_color(...)` (rareté du coffre pour `CrateItem`, devise de déblocage pour
`GradeUnlockItem`). Pour que cette teinte rende bien sur toutes les raretés (et pas seulement sur
une base dorée, qui aurait donné des couleurs sales une fois multipliée par du bleu/violet),
`assets/icons/concept_piece.svg` repasse en gris neutre (`#D8D8D8`/`#B5B5B5`, contour encre
inchangé) - une base neutre se teinte proprement par multiplication quelle que soit la couleur
cible, technique standard pour les icônes "à teinter" en jeu vidéo.

## Boutique v3 : cases carrées façon carte, cadre de l'onglet fermé (2026-08-01)

Retour utilisateur sur la v2 : le cadre sous l'onglet ne se refermait pas visiblement autour de
la zone d'items, et les lots restaient des lignes pleine largeur alors qu'il avait été demandé
des cases carrées avec le prix dans une bulle en bas, "comme les cartes avec les animaux" (voir
`ui/collection/card_slot.gd`) mais plus petit.

**Fermeture du cadre** : `StyleBoxFlat_tab_panel` (v2) perd son `content_margin` - on ne peut pas
garantir que `TabContainer` l'utilise pour repousser ses enfants (contrairement à
`PanelContainer`, qui le fait explicitement), donc s'y fier pour l'espacement était fragile.
Remplacé par un `MarginContainer` explicite (`TabMargin`, 14px sur les 4 côtés) inséré entre le
`ScrollContainer` de l'onglet et `ListContainer` - même leçon que `ResultRowsMargin` dans
`QuestionPanel` (2026-08-01, plus haut) : un espacement fixé par un noeud dédié plutôt que par une
propriété de StyleBox dont l'effet sur la mise en page n'est pas garanti.

**Cases carrées** : `CrateItem` (`ui/shop/crate_item.tscn`/`.gd`) reconstruit selon la même
technique que `CardSlot` - un cadre (`Panel`) colore par `CardRarity.get_color(rarity)`, une
marge de 6px, un fond crème (`Panel` interne, même couleur que `CardSlot.CREAM_COLOR`), l'icône
du coffre en haut (zone extensible) et une "bulle" de prix (`PriceBubble`, `Panel` arrondi) callée
en bas - exactement le rôle de `NamePlate` sur les cartes, à l'échelle d'une case de 112×112 au
lieu de 189×285. Contrairement à `CardSlot`, pas de nom affiché (l'icône suffit, le nom du lot
sert uniquement au texte de la popup de confirmation).

C'est la bulle elle-même qui porte désormais la couleur de rareté (comme `NamePlate` porte la
couleur de classe) - la pièce à l'intérieur repasse donc en gris neutre non teinté (elle
teindrait la bulle vers une couleur presque identique, illisible) : seul le prix change de
couleur de texte pour rester lisible sur la bulle (règle reprise telle quelle de `CardSlot` :
blanc sur la rareté Légendaire/orange, encre sur les 4 autres).

`ShopPanel` range désormais les coffres dans une `GridContainer` (`ItemGrid`, 5 colonnes, avec
retour à la ligne automatique si une 6e rareté est ajoutée un jour) plutôt qu'une simple liste
verticale - la ligne "Débloquer la classe suivante" (`GradeUnlockItem`) reste à part, au-dessus de
la grille, pleine largeur : c'est une action unique, pas un item de collection répété, elle garde
donc son propre traitement visuel (voir `list_container.move_child(_grade_unlock_item, 0)` dans
`shop_panel.gd`, nécessaire car `ItemGrid` est déjà présent dans la scène avant l'ajout au
runtime).

Chaque `Panel` decoratif de `CrateItem` (`Frame`, `InnerPanel`, `PriceBubble`) reçoit
`mouse_filter = MOUSE_FILTER_IGNORE` explicitement - vérifié sur
`docs.godotengine.org/en/4.7/classes/class_panel.html` que `Panel` n'a pas d'override par défaut
(contrairement à `Label`/`Container`, voir plus haut la note sur `_populate_choice_buttons`) et
bloquerait donc les clics vers le `Button` racine sans ce reglage explicite.

## Boutique v4 : contour des cases + fermeture définitive du cadre d'onglet (2026-08-01)

Deux derniers ajustements après retour utilisateur sur la v3 :

- **Cases "en superposition"** : `Frame` (cadre coloré) et `PriceBubble` (bulle de prix) de
  `CrateItem` partagent la même couleur de rareté sans aucun contour propre - à la jonction où la
  bulle "flotte" dans le bas du cadre, les deux aplats identiques se fondaient l'un dans l'autre
  sans limite visible. Ajout d'un contour encre de 2px sur les deux (`_apply_flat_style` reprend
  le paramètre `border_color`/`border_width` optionnel de `CardSlot._apply_flat_style`, qui
  n'était pas encore repris dans la version simplifiée de `CrateItem`).
- **Ligne de cadre manquante sous l'onglet** : `StyleBoxFlat_tab_panel` avait `border_width_top`
  volontairement absent (0), pour ne pas doubler la bordure avec le bas de l'onglet actif à leur
  jonction. En pratique la jonction ne se refermait que là où un onglet est present - ailleurs
  (à droite de l'onglet, avant que d'autres onglets n'existent) aucune ligne ne fermait le haut du
  cadre de contenu, donnant l'impression que l'onglet "flotte" au lieu de reposer sur un cadre.
  `border_width_top` remis à 3 (comme les 3 autres côtés) : la portion sous l'onglet actif est de
  toute façon recouverte par celui-ci (qui se dessine par-dessus), donc pas de doublon visible -
  seule la portion NON couverte par un onglet affiche desormais la ligne de fermeture, exactement
  le comportement attendu d'onglets classiques "posés" sur un cadre.

## Boutique v5 : onglet Classe + prix des coffres à 20 (2026-08-01)

Prix des 5 coffres passé de 50 à 20 pièces (`crate_price` dans les `LootTableResource`).

Nouvel onglet "Classe" dans `ShopPanel` (à côté de "Cartes"), pour l'achat de la classe suivante
(voir `GradeUnlock`). `GradeUnlockItem` était jusqu'ici une ligne pleine largeur ; il devient une
case carrée 112×112 identique dans sa structure à `CrateItem` (cadre coloré + fond crème +
pastille de prix), pour que les deux onglets partagent la même base visuelle - retour utilisateur
2026-08-01 : "place les items à acheter sur la même base que le premier onglet". Différence : pas
d'icône dédiée pour l'instant (aucun asset "classe" créé), le nom court de la classe (CP/CE1/...)
sert de contenu central à la place, dans la couleur encre fixe du cadre. Le cadre et la pastille de
`GradeUnlockItem` suivent la couleur de la monnaie de déblocage courante
(`GradeUnlock.get_unlock_currency()`), recalculée à chaque `refresh()` puisque cette monnaie change
d'un déblocage à l'autre (contrairement à la rareté fixe d'un `CrateItem`).

Simplification de côté : la couche `ListContainer` qui empilait la ligne de déblocage au-dessus de
la grille de coffres dans l'onglet Cartes n'a plus de raison d'être (le déblocage a son propre
onglet) - `ItemGrid` est redevenu l'enfant direct de `TabMargin` dans les deux onglets.

## Boutique v6 : coins hauts arrondis + onglet Classe à 5 cases fixes (2026-08-01)

Cadre de la zone d'items (`TabContainer/styles/panel`, `StyleBoxFlat_tab_panel`) : coins hauts
arrondis (14, comme les coins bas déjà en place) dans les 4 thèmes. Sans risque de doublon visuel
avec les onglets : le rectangle du panel commence sous la bande d'onglets, ses coins hauts ne sont
visibles qu'à l'endroit où aucun onglet ne les recouvre (à droite du dernier onglet, ou à gauche
si un onglet ne commence pas exactement à x=0).

Changement de plan pour `GradeUnlockItem` (onglet Classe) : au lieu d'une case unique représentant
"la prochaine classe à débloquer" qui finissait par disparaître une fois tout débloqué (onglet
vide), les 5 classes (CP à CM2) sont maintenant toujours présentes - une instance par
`GradeLevel.Grade`, même principe data-driven que `CrateItem`. Trois états possibles par case
(voir `GradeUnlockItem.refresh()`) : déjà achetée → grisée, désactivée, le prix est remplacé par
un simple "-" ; classe suivante à débloquer → case active et colorée par la monnaie à dépenser,
comme avant ; verrouillée mais pas encore accessible (plus loin dans la file) → grisée comme la
première mais garde son prix visible (pas de "-", elle n'est pas achetée). Décision motivée par
l'intention d'ajouter d'autres objets à débloquer dans cet onglet plus tard - il reste tel quel
dans sa structure (un onglet dédié, pas fondu ailleurs).

## Fenêtre Inventaire (2026-08-01)

Nouvelle entrée "Inventaire" dans `GameMenuPanel`, sur le même principe que Collection : un signal
(`inventory_requested`) délègue vers une fenêtre dédiée (`ui/inventory/inventory_panel.tscn`)
plutôt qu'une section générique du menu, pour ne pas se marcher dessus si Boutique/Album sont
ouverts. Pas de raccourci clavier propre pour l'instant (contrairement à Collection/"L"),
seulement le point d'entrée depuis le menu.

Cadre identique à `ShopPanel`/`QuestionPanel` (ancres 0.1/0.08/0.9/0.92, en-tête titre + croix
toujours en haut à droite). Le contenu est une simple liste (`InventoryRow` par rareté, réutilise
le style `PanelContainer` global du thème, pas de StyleBox dédié) : icône de la pièce (même SVG
neutre que la boutique, teintée par `CardRarity.get_color()`), libellé de la rareté en couleur
normale de l'UI, montant à droite - reprend le même langage visuel que la boutique et l'inventaire
en pièces (`CoinHUD`) sans dupliquer leur code.

## Reste à faire

- Reste de la série d'icônes (une par rareté de coffre au minimum) à faire une fois ce premier
  jet definitivement approuvé en jeu.
- `InteractablePrompt`/HUD monde (texte flottant sur la scène 3D) pas encore repris — contexte
  différent (superposé au décor 3D, pas dans un panneau), à traiter à part.
- Art des cartes (`data/card/art/`) : toujours en attente, voir `project_card_art_spec.md`.
- Une fois plusieurs écrans testés en jeu, ajuster au besoin épaisseur des contours/rayon des
  coins dans `ui/theme/game_theme.tres` (un seul fichier à modifier, pas de re-câblage scène par
  scène).
