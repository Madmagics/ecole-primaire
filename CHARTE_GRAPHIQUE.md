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

## Menu : Informations personnelles, portail parental, raccourci Inventaire (2026-08-01)

Nouvelle entrée "Informations personnelles" dans le menu (entre Commandes et Collection) :
modifie le profil (nom/prénom/classe/date de naissance/pays) du compte connecté, plus un bouton
"Supprimer le compte". Pas de raccourci clavier dédié (ouverture au clic uniquement).

`SectionSave` ("Réinitialiser la progression") et la nouvelle "Supprimer le compte" partagent le
même **portail parental hors-ligne** (`ParentalGateOverlay`) : un code aléatoire de 8 caractères
(`Crypto.generate_random_bytes`) s'affiche, l'action n'est exécutée que s'il est recopié à
l'identique - pas de connexion internet, pas de vrai reCAPTCHA (retour utilisateur explicite).
Remplace l'ancienne confirmation en 2 clics de "Tout réinitialiser". Les deux sections se
contentent d'émettre un signal (`reset_requested`/`delete_account_requested`) ; c'est
`GameMenuPanel` qui ouvre le portail et n'exécute l'action qu'après confirmation - même
convention que `ShopPanel._ask_confirm`/`_pending_purchase`.

L'onglet Inventaire gagne son propre raccourci clavier ("I", action `open_inventory`), affiché
en badge à côté du bouton comme les autres entrées du menu (même mécanisme que "L" pour la
Collection : la bascule ouvert/fermé vit dans `InventoryPanel._unhandled_input`, pas dans le menu).

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

## Bouton d'interaction centré (2026-08-02, revu le même jour)

`ui/interact_prompt/` refondu (retour utilisateur, maquettes discutées en amont) : l'ancien label
"Appuyer sur E" en haut à gauche est remplacé par un bouton pilule centré à l'écran, avec son
titre court (`InteractableComponent.prompt_text` — "Boutique", "Maître du CP"...). Le bouton est
cliquable (déclenche `trigger_interact` directement), ce qui comble au passage l'absence de
commande tactile pour "interact" (les boutons tactiles ajoutés précédemment, `ui/touch_controls/`,
ne couvraient que déplacement/zoom). `prompt_text` change donc de nature : ce n'est plus une
phrase complète ("Appuyer sur E pour ouvrir la boutique") mais un titre court, pour tenir dans le
bouton. Titres des PNJ (`QuestionGiverComponent._GRADE_TEACHER_TITLES`) posés au hasard par classe
(Maître/Maîtresse en alternance) uniquement pour avoir un texte plausible à l'écran — à corriger
une fois les personnages 3D des PNJ en place.

**Premier essai corrigé la même journée** : la toute première version affichait un badge "E" en
permanence au milieu de l'écran (visible même sans rien à portée), avec le bouton qui apparaissait
séparément en dessous une fois un interactable détecté. Retour utilisateur : le badge permanent
gênait la vue de loin - il a été retiré, le bouton seul (invisible tant que rien n'est en portée)
suffit.

**Deuxième passe le même jour : case carrée, écartée** : essai intermédiaire en case carrée fixe
120×120 (E en grand + bulle de titre en bas, fond `QuestionCard`, 20% de transparence), même
technique que `CrateItem`. Revu à l'usage (retour utilisateur, capture à l'appui) : ce n'était pas
le bon format - la pilule d'origine (badge + titre côte à côte, style natif du thème, sans
transparence) était la bonne direction depuis le début.

**Troisième passe : retour à la pilule, texte dynamique confirmé** : `InteractPrompt` revient à la
structure "Premier essai corrigé" ci-dessus - un seul bouton cliquable à largeur variable, `KeyBadge`
(badge "E", 40×40, même style `PanelContainer`/`TitleLabel` que les badges de touches du menu) à
gauche et `PromptLabel` à droite, tous deux enfants d'un `HBoxContainer` centré dans le bouton.
Bouton pas un `Container` : sa taille suit le contenu via une mesure manuelle
(`InteractPrompt._resize_prompt_button`, largeur du `Label` + largeur du badge + séparation +
marges du thème) recalculée à chaque `show_for()`. Le titre affiché est bien
`InteractableComponent.prompt_text` ("Boutique", "Maître du CP"...), jamais un texte fixe
"Ouvrir".

**Badge pas carré, corrigé (2026-08-02, même jour)** : `KeyBadge` rendait plus haut que large
(retour utilisateur, capture à l'appui) - son `custom_minimum_size` (40×40) ne suffisait plus une
fois le contenu réel (Label "E" + marges asymétriques 12/8/12/8 du style `PanelContainer` global)
pris en compte : Godot retient le plus grand des deux **par axe**, et la marge verticale, plus
courte, laissait le besoin réel dépasser 40 en hauteur sans dépasser 40 en largeur. Plancher relevé
à 48×48 (confortablement au-dessus du besoin réel sur les deux axes avec la police actuelle) pour
que ce plancher reste la valeur dominante et que le badge rende bien carré. `_resize_prompt_button`
mesure aussi désormais la taille réelle de `KeyBadge` (`get_minimum_size()`) plutôt que de
recopier la constante, pour ne plus jamais dépendre de cette hypothèse.

## Boutique v7 : sélecteur de quantité sur les coffres (2026-08-04)

Chaque `CrateItem` (onglet Cartes) gagne une ligne `QuantityRow` sous la bulle de prix : un bouton
"-", un chiffre, un bouton "+". Le prix affiché dans la bulle devient prix de base × quantité
sélectionnée, recalculé à chaque clic sur "+"/"-". Le "+" est plafonné au nombre de coffres que le
solde actuel de la rareté permet d'acheter (`Economy.get_balance() / crate_price`, voir
`CrateItem._get_max_affordable`) - impossible de sélectionner plus que ce que le joueur possède.

Le clic sur la case elle-même reste le seul déclencheur d'achat (retour utilisateur explicite : "on
garde la validation de l'achat sur la case existante, et on garde la popup de validation finale") -
les boutons +/- ne font qu'ajuster `_quantity`, sans jamais émettre `purchase_requested`. Ça marche
sans changement particulier car `MinusButton`/`PlusButton` sont des `Button` indépendants (donc
`mouse_filter = STOP` par défaut) placés au-dessus de la case, qui est elle-même un `Button` : leur
clic ne se propage jamais jusqu'au `pressed` de la case parente.

La case revient à une quantité de 1 après un achat réussi ; les autres coffres de la même rareté
voient seulement leur plafond +/- recalculé (un achat peut faire passer leur "+" en dessous de leur
quantité déjà sélectionnée, auquel cas elle est réduite automatiquement).

Case relevée de 112×112 à 112×140 pour loger la nouvelle ligne sans écraser l'icône.

## Boutique v8 : boutons +/- carrés, case coffre carrée, audit texte blanc (2026-08-04)

**Boutons +/- carrés et plus bas** : le style `Button` global du thème actif (marges 14/8px +
bordure basse épaissie à 6px, effet cartoon) donnait des boutons nettement plus hauts que larges
une fois appliqué à un seul caractère - même cause que "Badge pas carré" (2026-08-02, plus haut)
pour `KeyBadge`. `CrateItem._style_quantity_button` leur applique désormais un style dédié, plus
fin et symétrique (marge 2px, bordure 2px sur les 4 côtés), sur les 4 états
(normal/survol/pressé/désactivé) pour que la taille ne bouge jamais - combiné à un plancher carré
de 28×28 dans le `.tscn` (au lieu de 22×22), qui domine désormais ce contenu réduit sur les deux
axes et garantit un carré, au lieu de tenter de forcer un carré plus grand que le contenu comme
pour KeyBadge.

**Case coffre élargie en carré** : `CrateItem` passe de 112×140 (v7, plus haut) à 140×140 - la
largeur suit désormais la hauteur ajoutée par la ligne de quantité, au lieu de rester plus étroite
que haute.

**Audit texte blanc illisible** : en cherchant l'origine du blanc sur `QuantityLabel` (fond crème,
texte illisible), constat que tout `Label` "nu" (sans `theme_type_variation` ni
`add_theme_color_override` propre) hérite du gris clair/blanc par défaut du moteur Godot, pensé
pour un fond sombre - jamais recouvert dans les 4 thèmes du projet, qui ne définissaient une
couleur de texte que pour le type `TitleLabel`, pas pour `Label` de base. Repéré aussi sur
`InfoLabel`/`ErrorLabel` (`ParentalGateOverlay`) et les labels d'erreur de `WelcomePanel`. Corrigé
à la source : chaque `ui/theme/*.tres` définit maintenant `Label/colors/font_color` avec la même
teinte que son `TitleLabel` (encre foncée pour les thèmes clairs, crème claire pour `theme_sombre`,
dont les panneaux sont sombres) - un `Label` sans style dédié devient lisible partout, sans toucher
aux nœuds qui fixent déjà leur propre couleur (`CrateItem`/`GradeUnlockItem`/`CardSlot`, qui
recolorent selon la rareté : un override explicite gagne toujours sur cette valeur de thème).

Exception : `QuantityLabel` reçoit en plus sa propre couleur fixée en dur (encre, voir
`crate_item.gd`) car son fond crème reste toujours le même quel que soit le thème choisi
(convention déjà en place pour `PriceLabel`/`GradeLabel`) - le correctif de thème seul ne
suffirait pas avec `theme_sombre`, dont le `Label` de base passe au crème clair (illisible sur un
fond crème qui, lui, ne change jamais).

## Boutique v9 : appui maintenu = répétition automatique sur +/- (2026-08-04)

Un appui bref sur "+"/"-" reste un pas unique. Un appui maintenu déclenche après 1 seconde (3
secondes au départ, ramené à 1 seconde le même jour, retour utilisateur) une répétition automatique
à 5 unités/seconde jusqu'au relâchement. Implémenté via
`button_down`/`button_up` plutôt que le signal `pressed` (qui ne s'émet qu'au relâchement et aurait
ajouté un pas en trop à la fin d'un appui long) : `button_down` déclenche le premier pas et démarre
un `Timer` de délai (3s, one-shot) ; à son échéance, un second `Timer` (0.2s, répétitif) enchaîne
les pas jusqu'à `button_up`. Les deux `Timer` sont créés en code (`CrateItem._setup_auto_repeat`,
partagé entre les deux boutons) plutôt que dans la scène. Si la case se désactive pendant l'appui
(quantité qui atteint sa borne, voir `refresh_availability`), Godot émet `button_up` automatiquement
(comportement documenté de `BaseButton.disabled`) : la répétition s'arrête donc sans code dédié.

## Régression couleurs de rareté après le correctif texte blanc (2026-08-04)

Le correctif `Label/colors/font_color` (juste au-dessus) a cassé l'affichage des soldes de pièces
en haut de l'écran (`CoinHUD`), le tableau des soldes dans Statistiques (`section_stats.gd`), le
journal des loots obtenus (`LootFeed`) et la coloration vert/rouge des réponses dans le
récapitulatif de fin de pack (`question_panel.gd`) - retour utilisateur : "toutes les couleurs des
raretés ont disparu au profit du filtre appliqué par le thème choisi", trop foncé, sauf en
`theme_sombre` où l'affichage restait normal.

Cause : ces quatre endroits coloraient un `Label` via `modulate` plutôt que
`add_theme_color_override("font_color", ...)`. `modulate` multiplie TOUTE la couleur déjà
affichée par le nœud - avant le correctif, aucun thème ne définissait de `font_color` de base
pour `Label`, donc le moteur utilisait son blanc quasi pur par défaut, et blanc × couleur = couleur
: `modulate` "fonctionnait" par coïncidence. Dès qu'un thème a défini `Label/colors/font_color`
(l'encre foncée du thème), `modulate` a multiplié chaque couleur de rareté/classe/résultat par
cette encre, l'assombrissant fortement - sauf sur `theme_sombre`, dont le `Label` de base est
défini en crème quasi blanc, donc peu perturbateur en multiplication (d'où "les couleurs restent
normales en mode sombre").

Corrigé en remplaçant `modulate` par `add_theme_color_override("font_color", ...)` dans les 4
fichiers concernés (`coin_hud.gd`, `section_stats.gd`, `loot_feed.gd`, `question_panel.gd`) - la
bonne pratique pour recolorer le texte d'un `Label`, indépendante de tout `font_color` de thème,
déjà utilisée par ailleurs dans `CrateItem`/`GradeUnlockItem`/`CardSlot`. `InventoryRow.coin_icon`
utilise aussi `modulate`, mais sur un `TextureRect` (pas un `Label`) : non affecté, laissé tel quel.

## Menu : bande d'icônes sur le bord gauche (2026-08-25)

Les icônes fraîchement intégrées dans `GameMenuPanel` (`assets/classe2.0/icones/`, ~110-140px
natif) rendaient beaucoup trop grandes dans l'ancien `NavContainer` (boutons pleine largeur
icône+texte) - `Button.icon` sans `expand_icon` se dessine à la taille native de la texture.

Refonte complète de la navigation en bande d'icônes (`IconDock`, retour utilisateur) : une bande
verticale sur 10% de la largeur de l'écran, le long du bord gauche, avec un fond en dégradé noir
80% d'opacité (au bord) vers noir 20% (vers l'intérieur) - un `TextureRect` affichant un
`GradientTexture2D` (dégradé horizontal, ses valeurs par défaut `fill_from`/`fill_to` correspondent
déjà exactement à ce sens). `IconDock` est un enfant direct de `GameMenuPanel` (pas de `Panel`, qui
est inset de 40px) pour coller au vrai bord de l'écran, ancré en pourcentage (`anchor_right = 0.1`)
plutôt qu'en pixels fixes pour rester à 10% quelle que soit la résolution ; dessiné après `Panel`
dans l'arbre pour rester visible au-dessus de son fond arrondi là où les deux se chevauchent.

Les 8 boutons de section deviennent icône seule (`expand_icon = true`, `text = ""`,
`icon_alignment`/`vertical_icon_alignment` centrés) dans un carré de 76×76 - `expand_icon` fait
tenir n'importe quelle icône dans ce carré en conservant son ratio, quelle que soit sa résolution
native. Le badge de raccourci clavier (ex. "C" pour Configuration), auparavant à côté du bouton
dans sa propre rangée, devient une pastille en incrustation dans le coin inférieur droit de
l'icône (`ConfigBadge` etc., ancré au coin du bouton plutôt qu'en frère dans une `HBoxContainer` -
il n'y a plus de rangée du tout, `IconList` est directement une colonne de boutons carrés). Le nom
de chaque section passe en `tooltip_text` plutôt qu'en texte visible.

## Icônes du menu réduites de 30% + bouton menu principal à gauche (2026-08-25)

Icônes de `IconDock` (voir plus haut) réduites de 30% (retour utilisateur) : cases 76×76 → 53×53,
badges de raccourci 26×26 → 18×18 (réduits dans la même proportion pour rester lisibles sans
déborder du coin de l'icône, plus petite elle aussi).

`OpenMenuButton` (le bouton "M" toujours visible du HUD, `game_ui.tscn`) déplacé du coin haut-droit
vers le bord gauche de l'écran (retour utilisateur), pour rester cohérent avec `IconDock` qui vit
désormais lui aussi sur ce bord.

**Correction en urgence** : j'avais d'abord documenté ces deux changements avec des commentaires
`##` directement dans `game_menu_panel.tscn`/`game_ui.tscn`, par réflexe GDScript - or ce format
(`.tscn`, comme `.tres`) ne supporte aucun commentaire, exactement la cause de la régression du
2026-08-04 sur les thèmes (`Label/colors/font_color`). Repéré avant tout rechargement en constatant
qu'aucun `.tscn` du projet n'en contient nulle part ailleurs, et retirés immédiatement.

## Sac de pièces remplace Inventaire, CoinHUD retiré (2026-08-25)

Clarification après la question posée à l'utilisateur (l'ancien bouton "Inventaire" ouvrait déjà
exactement une liste de soldes de pièces par rareté - listant les pièces, pas des objets) :

- Le bouton qui ouvrait la fenêtre de solde de pièces (icône `inventaire.webp`) est rebaptisé
  "Sac de pièces" (icône `sac-de-pieces.webp`, nouveau noeud `WalletButton`) - comportement et
  fenêtre strictement inchangés (`InventoryPanel`, jamais renommée côté script pour limiter la
  portée du changement : `class_name`, signal `inventory_requested`, action `open_inventory`
  restent tels quels). Le libellé du raccourci clavier dans "Commandes" passe de "Ouvrir
  l'inventaire" à "Ouvrir le sac de pièces", pour rester exact.
- "Inventaire" redevient un bouton distinct (icône `inventaire.webp`, sac à dos), page vide en
  réserve pour un futur système de vrais objets - même statut que "Défis" (`SectionInventory`,
  même moule que `SectionDefis`), pas de raccourci clavier. La bande d'icônes passe donc de 8 à 9
  entrées.
- `CoinHUD` (soldes de pièces affichés en permanence en haut de l'écran) est retiré de
  `game_ui.tscn` - le solde n'est plus consultable qu'via "Sac de pièces". Le composant
  (`ui/hud/coin_hud.gd/.tscn`) reste dans le projet, réutilisable, mais n'est plus instancié
  nulle part pour l'instant.

## Titre dynamique, icônes sans cadre -40%, bande floutée mono (2026-08-25)

**Titre de section** : `Panel/TitleLabel` affichait toujours "Menu" en dur, quelle que soit la
section ouverte - aucune indication de "où on est" une fois dans Configuration/Sauvegarde/etc.
(certaines sections comme `SectionConfig` n'ont même pas leur propre titre interne). Corrigé :
chaque `_show_xxx()` de `game_menu_panel.gd` met maintenant `title_label.text` à jour via une
nouvelle constante `SECTION_TITLES` (dict section → libellé). Collection et Sac de pièces n'ont pas
d'entrée : ces deux boutons ferment ce menu et ouvrent une fenêtre à part, ils ne deviennent jamais
`_current_section`.

**Icônes sans cadre, taille native -40%** : retour utilisateur - le cadre visuel du `Button` (style
"cartoon" du thème actif : marges + bordure épaisse) est retiré (`flat = true` sur les 9 boutons de
`IconDock`), ne laissant que l'icône. Abandon du plancher carré uniforme (76 puis 53px, itérations
précédentes) au profit de la dimension **native** de chaque icône (ex. 121×121 pour
`reglages.webp`, 139×129 pour `defis.webp`) réduite de 40% (×0.6) - chaque bouton garde donc le
ratio d'aspect propre à son icône plutôt qu'un carré artificiel. Badges de raccourci agrandis en
conséquence (18×18 → 22×22, les icônes étant maintenant globalement plus grandes qu'à l'itération
précédente).

**Bande "mono" + flou d'arrière-plan** : le fond en dégradé noir 80%→20% (`GradientTexture2D`,
version précédente) est remplacé par un fond plat ("mono") à 10% d'opacité, ET l'image derrière la
bande (le jeu, visible à travers - `IconDock` n'a pas de fond opaque propre, contrairement à
`Panel`) devient floutée. Implémenté via un shader (`icon_dock_blur.gdshader`, `ColorRect BlurBG`
+ `ShaderMaterial`) : lecture de `hint_screen_texture` à un niveau de mipmap non-nul via
`textureLod` (technique documentée officiellement pour obtenir un flou sans écrire de noyau de
convolution manuel, voir docs.godotengine.org/en/4.7/tutorials/shaders/screen-reading_shaders.html)
puis mélange avec la teinte noire plate. `blur_amount` (mipmap lu) et `tint_color` sont exposés en
`shader_parameter/` réglables depuis l'inspecteur sans retoucher le shader - valeurs de départ
`2.0`/`Color(0,0,0,0.1)`, interprétation raisonnable de "flou 20%"/"mono 10%" à ajuster à l'oeil en
jeu (aucun rendu visuel possible de mon côté pour caler la valeur exacte).

## Raccourci à côté du titre, écart réduit entre icônes (2026-08-25)

**Raccourci déplacé** : la pastille de touche clavier ("C", "V", "K", "T"...), jusque-là en coin de
chaque icône, est retirée de `IconDock` (6 badges + labels supprimés) et remplacée par une seule
pastille (`ShortcutBadge`) à côté du titre en tête de panneau (`Panel/TitleRow`, nouveau
`HBoxContainer` qui remplace le `TitleLabel` seul). Elle montre la touche de la section
**actuellement affichée** (`_update_header()`, appelé par chaque `_show_xxx()`) et se masque quand
la section n'a pas de raccourci propre (Informations personnelles/Inventaire/Défis). Collection et
Sac de pièces ont bien un raccourci ("L"/"I") mais ferment ce menu au clic pour ouvrir une fenêtre
à part : ils ne deviennent jamais `_current_section`, donc n'ont plus d'affichage de leur touche
dans ce panneau.

**Écart entre icônes réduit** : les icônes dépassaient de l'écran (retour utilisateur) - séparation
de `IconList` réduite de 14 à 6px, marges haut/bas de 32 à 14px. Tailles d'icônes elles-mêmes
inchangées (natif -40%, voir plus haut).

## Collection/Sac de pièces/Inventaire sortent du menu, dock permanent en haut à droite (2026-08-25)

**Retour utilisateur** : "on va separer les icones et placer... le sac a dos inventaire, le sac de
piece et le livre... en haut a droite de l'ecran de maniere permanente comme le menu... ces
fenetres n'ouvriront pas le menu principal, les autres icones resteront enfant du menu principal."

Les 3 icônes qui fermaient jusque-là `GameMenuPanel` pour ouvrir une fenêtre à part (Collection →
`CardAlbum`, Sac de pièces → `InventoryPanel`, Inventaire → l'ancienne section interne
`SectionInventory`) quittent `IconDock` (bande gauche du menu) pour devenir 3 boutons permanents
dans `game_ui.tscn`, alignés en haut à droite de l'écran — même traitement que le bouton "M"
(`OpenMenuButton`) en haut à gauche : `flat`, `expand_icon`, pas de cadre, mêmes tailles qu'avant
(70×76/70×76/73×82), et même script générique `menu_toggle_button.gd` (se masquent tant qu'un des
panneaux modaux surveillés est déjà visible, `OpenMenuButton` inclus dans leur liste et
réciproquement).

Ces boutons appellent directement `open()` sur leur fenêtre cible (connexion `pressed` dans le
`.tscn`) au lieu de traverser un signal intermédiaire de `GameMenuPanel` : les signaux
`collection_requested`/`inventory_requested` et les handlers qui fermaient le menu avant d'émettre
sont supprimés (plus nécessaire, ces fenêtres sont maintenant indépendantes du menu — même
comportement que les raccourcis clavier "L"/"I" qui n'ont jamais fermé le menu non plus).

L'ex-section "Inventaire" (page vide en réserve pour un futur inventaire d'objets) devient sa
propre fenêtre modale, `BackpackPanel` (`ui/inventory/backpack_panel.gd/.tscn`), même moule que
`CardAlbum`/`InventoryPanel` (cadre en % d'écran, croix de fermeture, `PlayerInputLock`, Échap) —
`section_inventory.gd/.tscn` supprimés. `GameMenuPanel` ne garde plus que 6 sections (retire
Collection/Sac de pièces/Inventaire de `SECTION_TITLES`).

## Flou plein écran + disposition marge/icône/marge/fenêtre du menu (2026-08-25)

**Retour utilisateur** : "applique la flou sur toute la fenetre quand le menu est actif, decale le
bord gauche de toutes les fenetre linkées au menu je veux limite ecran gauche / marge / icone /
marge / fenetre / marge/ limite bord droit de l ecran, la marge doit etre la meme qu actuellement
autour des fenetres." Portée confirmée à `GameMenuPanel` uniquement (question posée : `CardAlbum`
et `InventoryPanel` restent inchangés).

**Flou étendu à tout l'écran** : le `ColorRect`+`ShaderMaterial` flouté (`icon_dock_blur.gdshader`)
qui ne couvrait jusque-là que la bande `IconDock` devient `BlurBG`, premier enfant direct de
`GameMenuPanel` couvrant tout l'écran (dessiné sous `Panel` et `IconDock` — premier dans l'arbre).
L'ancien `BlurBG` local à `IconDock` est supprimé (redondant, la version plein écran couvre déjà
cette zone). Le shader lui-même est inchangé, seul son support (taille/position du `ColorRect`) a
changé.

**Disposition marge/icône/marge/fenêtre/marge** : jusque-là `IconDock` était collé au bord gauche
de l'écran (`anchor_right = 0.1`) et chevauchait en partie `Panel` (qui commençait à x=40) — les
deux étaient des enfants indépendants sans marge concertée entre eux. Remplacé par une séquence
explicite en pixels fixes, avec la même marge (40px) que celle déjà utilisée autour de `Panel` :
bord gauche → marge 40px → `IconDock` (108px, largeur reprise de l'ancienne bande à 10% d'écran) →
marge 40px → `Panel` (commence maintenant à x=188 au lieu de x=40, marge droite -40 inchangée) →
marge 40px (inchangée) → bord droit.

## Dock haut-droite vertical, marges du menu réduites de 50%, teinte 40% (2026-08-25)

**Retour utilisateur** : "place les icones de droites verticales et non horizontale. en ce qui
concerne le menu principal reduit la marge de chaque cote des icones de 50% et en plus du flou de
fond applique un noir transparent de 40%."

**Dock haut-droite vertical** : `CollectionButton`/`WalletButton`/`InventoryButton`
(`game_ui.tscn`) passent d'une rangée horizontale à une colonne verticale, alignés sur le même
bord droit (marge 20px constante), empilés de haut en bas dans le même ordre qu'avant (Collection,
Sac de pièces, Inventaire), séparés par le même écart de 14px.

**Marges du menu réduites de 50%** : les deux marges encadrant `IconDock` dans `GameMenuPanel`
(bord écran → icône, et icône → fenêtre) passent de 40px à 20px chacune. La marge droite de
`Panel` (fenêtre → bord écran) n'est pas concernée (pas une marge "autour des icônes") et reste à
40px.

**Teinte noire 40%** : `shader_parameter/tint_color` du fond flouté plein écran passe de
`Color(0,0,0,0.1)` à `Color(0,0,0,0.4)` — le flou (mipmap) est inchangé, seule l'opacité de la
teinte plate appliquée par-dessus augmente.

## Cadre autour du bloc d'icônes du menu, même thème que la fenêtre (2026-08-25)

**Retour utilisateur** : "on va faire un cadre autour du bloc des icones du menu principale,
utilise la hauteur de la fenetre des menus et adapte la largeur de la colonne avec marges, on
utilisera meme theme que la fenetre de la rubrique du menu."

`IconDock` passe de `Control` (transparent, pas de fond propre) à `Panel` (type de base, sans
`theme_type_variation`) — exactement le même type de nœud que le `Panel` de la fenêtre, donc même
`StyleBox` puisque les deux héritent du même `theme` assigné sur `GameMenuPanel`. Deux
conséquences directes de la demande :

- **Hauteur** : `offset_top`/`offset_bottom` passent de `0`/pleine hauteur à `40`/`-40`, identiques
  à ceux du `Panel` de la fenêtre — les deux cadres ont maintenant exactement la même hauteur.
- **Largeur avec marges** : la colonne d'icônes (`IconList`) collait auparavant aux bords
  d'`IconDock` (108px de large, tout occupé). `IconDock` est élargi à 148px et `IconList` reçoit
  une marge interne de 20px de chaque côté (`offset_left = 20`/`offset_right = -20`) pour que les
  icônes ne touchent plus le bord du nouveau cadre. `Panel` (fenêtre) recule d'autant à droite
  (commence maintenant à x=188 au lieu de x=148) pour garder la marge de 20px entre les deux
  cadres inchangée.

Le fond flouté + teinte 40% (voir plus haut) reste en place derrière tout l'écran : il n'est plus
visible que dans les marges entre les deux cadres opaques (bord écran↔icônes et icônes↔fenêtre),
qui sont maintenant du même style visuel que le contenu du menu.

## Mise en page des rubriques du menu égalisée, marge de droite et police réduites (2026-08-25)

**Retour utilisateur** : "on va reprendre la mise en page des rubriques du menu option et les
egaliser, relis la mise en page actuelle, reduit la marge de droite reduit la police de 1 taille
pour tous les menus d options."

**État avant modification** : les 6 rubriques (`section_config`, `section_save`,
`section_controls`, `section_stats`, `section_profile`, `section_defis`) utilisaient déjà la même
structure de base (`VBoxContainer`, marges 20px de chaque côté), à une exception près :
`section_profile` avait une séparation de 14px au lieu de 16px pour les 5 autres — égalisée à 16px.

**Marge de droite réduite** : la marge droite du `VBoxContainer` de chacune des 6 rubriques passe
de 20px à 10px, en laissant les marges gauche/haut/bas inchangées (20px) — donne plus de largeur
utile au contenu (notamment les lignes de `section_controls`/`section_profile`).

**Police réduite d'un cran** : plutôt que de dupliquer la réduction dans les 6 scènes, un thème
minimal dédié (`ui/theme/menu_options_font.tres` — seulement `default_font_size = 18` et
`TitleLabel/font_sizes/font_size = 22`, sans aucune couleur) est assigné une seule fois sur
`Panel/ContentArea` (le parent commun des 6 rubriques) dans `game_menu_panel.tscn`. Les thèmes
Godot se fusionnent le long de l'arbre de nœuds : ce thème local ne fait que réduire les tailles de
police (20→18 par défaut, 24→22 pour les titres), les couleurs de la palette active
(`SaveManager.ui_theme` : Fête foraine/Bonbon/Tropical/Sombre) continuent de s'appliquer
normalement puisqu'elles ne sont pas redéfinies dans ce thème local. Un seul hardcode
(`section_config.gd`, vignette de thème, police 16px volontairement compacte) n'est pas concerné
par cette réduction — déjà plus petit que la base et contraint par la taille de la vignette.

## Référence aux pièces retirée de la fenêtre Statistiques (2026-08-25)

**Retour utilisateur** : "dans fenetre statistique, supprime la reference aux pieces."

Le résumé du solde de pièces par rareté (`CoinsContainer`/`_refresh_coins()` dans
`section_stats.gd/.tscn`, dépendance à `Economy`/`CardRarity`) est retiré — c'était un doublon
avec "Sac de pièces" (voir plus haut), déjà l'endroit dédié pour consulter ce solde. La section
Statistiques ne montre plus que packs réussis, précision, répartition par matière et % de
collection.

## Contenu collé à gauche + ligne de séparation sous le titre (2026-08-25)

**Retour utilisateur** : "ok toutes les fenetres de menus doivent voir leurs contenus colles a
gauche avec une marge equivalente a la marge entre la fenetre et le bord de l ecran", puis en
cours de tâche : "je veux aussi une ligne de separation en tre le titre et le reste de la fenetre,
le trait est de meme design que le trait de contour de la fenetre."

**Contenu collé à gauche** : `Panel/ContentArea` (parent commun des 6 rubriques) avait un
`offset_left` de 260px, hérité de l'ancienne navigation verticale qui vivait autrefois à
l'intérieur de `Panel`, avant qu'`IconDock` ne devienne un cadre entièrement externe (voir plus
haut). Ce vide n'avait plus lieu d'être ; réduit à 40px — la même marge que celle entre `Panel` et
le bord de l'écran (`offset_top`/`offset_bottom`) — pour que la marge intérieure du contenu soit
cohérente avec la marge extérieure de la fenêtre.

**Ligne de séparation sous le titre** : `TitleSeparator` (`HSeparator`), placé entre `TitleRow` et
`ContentArea`. Plutôt que de coder une couleur en dur, son style (`HSeparator/styles/separator`,
`StyleBoxLine`) est déclaré dans les 4 fichiers de thème avec la même couleur et épaisseur (4px)
que `border_color`/`border_width` du `Panel/styles/panel` de chaque thème respectif — le trait
reprend donc exactement le style du contour de la fenêtre, quel que soit le thème actif
(Fête foraine/Bonbon/Tropical/Sombre), sans logique supplémentaire côté script.

## Marge sous le titre + pastille de raccourci carrée (2026-08-26)

**Retour utilisateur** : "le menu actuel voit sa barre de separation titre contenu trop haute,
applique une marge basse en dessous du titre, ensuite reduit la case raccourci en hauteur, met le
raccourci en majuscule pour ne pas avoir de case basse et passe le cadre de la lettre raccourci en
forme carrée."

**Marge sous le titre** : `TitleSeparator` (la ligne ajoutée sous le titre le 2026-08-25) était
trop proche du texte — descendue de `offset_top`/`bottom` 48/52 à 55/59, ce qui porte la marge
sous le titre de 8 à 15px. `ContentArea` suit (60 → 64) pour garder un petit écart après le trait.

**Pastille de raccourci réduite et carrée** : `ShortcutBadge` utilisait le type `TitleLabel`
(24px), pensé pour un vrai titre, pas une petite pastille — d'où un cadre en forme de pilule plus
haute que large (le texte à 24px forçait `PanelContainer` à s'agrandir bien au-delà des 32×32
demandés). Remplacé par un type dédié, `ShortcutBadge` (base `PanelContainer`, ajouté aux 4
fichiers de thème avec le même fond/bordure que le `Panel` de chaque thème, bordure 2px, coins
6px, marges internes 4px) et un `custom_minimum_size` de 28×28. Le `Label` à l'intérieur passe à
un `font_size` direct de 16px (au lieu de 24 via `TitleLabel`) et son texte est mis en majuscule
(`_update_header()`, `.to_upper()`) : une majuscule n'a jamais de jambage sous la ligne de base
(contrairement à g/j/p/q/y en minuscule), ce qui aurait forcé la police à réserver de la place en
plus et empêché le cadre de tenir dans un vrai petit carré.

**CloseButton aligné sur la même taille** (retour utilisateur : "la pastille raccourci est
parfaite applique la meme taille pour le X de fermeture") : offsets passés à 28×28 (`offset_left`
-60→-48, `offset_top` 8→12, le coin ancré `offset_right`/`offset_bottom` -20/40 ne change pas) —
**insuffisant à lui seul** (retour utilisateur suivant : "toujours aussi grande, aucun
changement") : un `Button` calcule sa propre taille minimale à partir de son texte et des marges
de son `StyleBox` (14px/8px sur le `Button` de base, pensé pour un vrai bouton texte, police 20px)
— cette taille minimale (~40px) l'emportait sur les offsets 28×28 tant qu'elle restait plus
grande. Corrigé par un `theme_type_variation` dédié (`CloseButton`, base `Button`, ajouté aux 4
thèmes) reprenant les mêmes couleurs normal/hover/pressed que le `Button` de chaque thème mais
avec des marges réduites (5px/3px au lieu de 14px/8px), une bordure 2px (au lieu de 3-6) et une
police dédiée de 16px (`CloseButton/font_sizes/font_size`) — la taille minimale réelle passe sous
28×28, les offsets du nœud font désormais foi. Seule la taille/les proportions changent, pas la
nature du bouton : `CloseButton` reste un vrai `Button` cliquable avec l'accent coloré du thème,
contrairement à `ShortcutBadge` qui n'est qu'une pastille d'affichage.

## Style de croix de fermeture étendu à toutes les fenêtres (2026-08-26)

**Retour utilisateur** : "applique ce style de croix de fermeture sur toutes les fenetres y
compris grimoire inventaire et sac de pieces."

Le `theme_type_variation` `CloseButton` (créé pour `GameMenuPanel`, voir plus haut — petit cadre
carré 28×28, marges 5px/3px, bordure 2px, police 16px, mêmes couleurs que le `Button` normal du
thème actif) est appliqué à toutes les autres croix de fermeture du jeu : `CardAlbum` (le
grimoire, seule autre fenêtre en positionnement par offsets comme `GameMenuPanel` — offsets
resserrés en gardant le même coin ancré), `BackpackPanel` (Inventaire), `InventoryPanel` (Sac de
pièces), `ShopPanel`, `QuestionPanel`, `SubjectSelectPanel` (ces 5 dernières ont leur `CloseButton`
dans un `HBoxContainer` d'en-tête : `theme_type_variation` + `custom_minimum_size = Vector2(28,
28)` suffisent, le conteneur dimensionne lui-même le bouton). Toutes les croix de fermeture du jeu
ont désormais la même taille et le même style, indépendamment du thème actif.

## Cases actives réduites à la taille du contenu (2026-08-26)

**Retour utilisateur** : "reduisons toute les tailles de cases actives, exemple dans info perso
elles font toute la largeur de la page, cest trop, on va faire taille de police plus marge
raisonnable avant apres texte pour delimiter la taille de la case."

Les champs interactifs (`LineEdit`, `OptionButton`, `SpinBox`) des formulaires `SectionProfile`
(Informations personnelles) et `WelcomePanel` (connexion/création de compte) s'étiraient sur
toute la largeur disponible via `size_flags_horizontal = 3` (EXPAND). Ce flag est retiré partout :
pour `OptionButton`/`SpinBox`, qui affichent un contenu réel (libellé de classe, valeur
numérique), la taille minimale naturelle du contrôle (police + marges internes du style actif)
suffit une fois l'EXPAND enlevé. Pour `LineEdit`, vide de tout contenu au repos, la taille
minimale naturelle serait trop petite pour rester utilisable : un `custom_minimum_size =
Vector2(220, 0)` est fixé à la place. Appliqué à `NomInput`/`PrenomInput` (`SectionProfile`) et
`LoginInput`/`PasswordInput`/`NomInput`/`PrenomInput`/`NewLoginInput`/`NewPasswordInput`/
`ConfirmPasswordInput` (`WelcomePanel`), ainsi qu'à `ClasseOption`/`PaysOption`/`DaySpin`/
`MonthSpin`/`YearSpin` dans les deux fichiers. Exclus du périmètre : `AnswerInput` du
`QuestionPanel` (champ de réponse libre, doit rester large) et `AvatarOptions` (conteneur de
boutons-image à taille fixe, pas une case de saisie).

## Boutons pleine largeur réduits à leur taille naturelle (2026-08-26)

**Retour utilisateur** : "reduit de moitie la longueur des pushbutton, ils prennent actuellement
toute la largeur de la fenetre."

Les boutons d'action seuls sur leur ligne dans un `VBoxContainer` (`Enregistrer`/`Supprimer le
compte` dans `SectionProfile` ; `Sauvegarder`/`Charger`/`Réinitialiser la progression` dans
`SectionSave` ; `Se connecter`/`Pas encore de compte ? Créer un compte`/`Créer le compte`/`Déjà un
compte ? Se connecter` dans `WelcomePanel`) s'étiraient sur toute la largeur du conteneur. Cause :
dans un `VBoxContainer`, l'axe transversal (horizontal) applique le flag `FILL` par défaut même
sans le flag `EXPAND` — contrairement à un `HBoxContainer` où `FILL` seul dimensionne au minimum
naturel (voir l'entrée "Cases actives" ci-dessus pour ce second cas). `size_flags_horizontal =
0` (`SIZE_SHRINK_BEGIN`) est ajouté explicitement à ces boutons : ils reprennent leur taille
naturelle (texte + marges du style de bouton actif) et s'alignent à gauche, cohérent avec la
règle "contenu collé à gauche" déjà appliquée aux rubriques du menu. Exclus du périmètre : les
paires bouton Annuler/Confirmer côte à côte dans `ShopPanel` (confirmation d'achat) et
`ParentalGateOverlay` (portail parental), où le partage 50/50 de la ligne est un choix de mise en
page délibéré, pas la largeur totale de la fenêtre qui a motivé la remarque.

## Trois retouches sur Informations personnelles (2026-08-26)

**Retour utilisateur** : "drapeau a reduire taille -30%" ; "saut de ligne ou marge entre trait de
separation et nom avec case qui touche la separation actuellement" ; "un saut de ligne inutile
entre enregistrer et supprimer le compte."

- **Drapeau** : `PaysOption` affichait le drapeau `flag_fr.svg` (120×80 natif) à taille pleine
  faute de limite. `theme_override_constants/icon_max_width = 84` (120 × 0.7) plafonne la largeur
  de l'icône native de `Button`/`OptionButton` ; la hauteur suit le ratio automatiquement. Appliqué
  à `SectionProfile` (menu) et `WelcomePanel` (écran de connexion, même drapeau).
- **Marge sous la séparation** : `ContentArea/offset_top` remonté de 64 à 80 dans
  `game_menu_panel.tscn` — le trait `TitleSeparator` et le premier champ de chaque section
  (`Nom`, `Volume général`, etc.) étaient trop rapprochés. +16px redonne de l'air aux 6 sections
  d'un coup, `ContentArea` étant leur parent commun.
- **Espace vide entre les deux boutons** : `StatusLabel` (message "Profil enregistré.") est un
  `Label` toujours présent entre `SaveButton` et `DeleteAccountButton`. Même vide, un `Label`
  garde une hauteur minimale d'une ligne de police, ce qui creusait un blanc visible entre les deux
  boutons (avec les séparations de 16px du `VBoxContainer` de part et d'autre). `StatusLabel` est
  désormais caché par défaut (`visible = false`) et dans `refresh()`, et n'est réaffiché que
  lorsque `_on_save_pressed()` lui donne effectivement un texte.

## Dock "Sac à dos" à droite, colonne d'icônes partagée avec la gauche (2026-08-26)

**Retour utilisateur** : "on va partir sur un nouveau modele de groupes d icones situé a droite de
l ecran; on va faire exactement parei que du cote gauche: cest a dire une icone principale : le sac
a dos: qui ouvre un menu colonne avec le sac de piece et le livre on y ajoutera du contenu plus
tard directement en relation avec les gains du jeu, on va y transferer licone actuelle defis qu on
va renommer en 'succes', on y mettra des succes plus tard correspondant a des evenements clés
offrant des recompenses, pour le design, on va utiliser la colonne et les dimensions de la colonne
de gauche. je la veux commune si bien que si on modifie une lautre sera modifiee aussi."

Les 3 icônes permanentes du haut-droite (Collection/Sac de pièces/Inventaire, ajoutées le
2026-08-25) sont remplacées par le même modèle que le menu de gauche : une icône principale
(`BackpackButton`, même icône "sac à dos") qui bascule l'affichage d'une colonne d'icônes
(`BackpackMenu`) au lieu d'ouvrir directement une fenêtre. La colonne contient "Sac de pièces"
(→ `InventoryPanel`) et "Livre" (→ `CardAlbum`) ; chaque clic ouvre la fenêtre visée puis referme
la colonne (comportement de menu déroulant). `BackpackPanel` (l'ancien écran "Bientôt disponible
!" du sac à dos) est retiré : le bouton n'ouvre plus d'écran propre, son rôle de hub est repris par
la colonne — le contenu "en relation avec les gains du jeu" annoncé par l'utilisateur s'ajoutera
plus tard comme nouvelles icônes ici, pas dans un écran séparé.

"Défis" quitte le menu principal (`GameMenuPanel`) et rejoint cette colonne, renommé "Succès" :
`SectionDefis` (page vide intégrée au menu) est remplacé par `SuccessPanel`, un panneau modal
autonome sur le même moule que les autres fenêtres du jeu, ouvert depuis la nouvelle colonne. Le
menu principal passe donc de 6 à 5 rubriques.

**Colonne commune** : "je la veux commune si bien que si on modifie une l'autre sera modifiée
aussi" — le cadre + la colonne d'icônes (`Panel`/`IconList`, marges, séparation, hauteur) qui
vivaient jusque-là codés en dur dans `GameMenuPanel` sont extraits dans une scène séparée
(`ui/game_menu/icon_dock.tscn`), instanciée à la fois à gauche (5 icônes : Config/Save/Controls/
Informations/Stats) et dans la nouvelle colonne à droite (3 icônes : Sac de pièces/Livre/Succès,
en miroir). Modifier le cadre ou les dimensions dans ce fichier partagé met à jour les deux
colonnes en même temps, sans dupliquer le style. Chaque instance ajoute ses propres boutons comme
enfants "éditables" de la scène instanciée (mécanisme standard de Godot pour composer une scène de
base commune avec un contenu différent par instance).

## Colonnes -25%, fenêtres du dock droit au format du menu de gauche (2026-08-26)

**Retour utilisateur** : "on va reduire la largeur des colonnes de 25%, les fenetres qui popent
suite a lactivation des menus de la colonne de droite doivent avoir le meme format que les
fenetres qui souvrent par le menu de gauche."

- **Colonnes -25%** : `icon_dock.tscn` (partagé gauche/droite) passe de 148 à 111px de large
  (marge interne de `IconList` 20→15px de chaque côté). Les icônes suivent la même réduction :
  la convention "taille native × 0,6" du 2026-08-25 devient "native × 0,45" (0,6 × 0,75), pour
  rester proportionnelle à la nouvelle largeur de colonne plutôt que de laisser les icônes
  déborder ou flotter dans un cadre devenu trop étroit. `GameMenuPanel.Panel.offset_left` (151,
  était 188) et `BackpackMenu`'s `IconDock.offset_left` (-131, était -168) suivent pour garder
  la formule marge/icône/marge intacte de chaque côté.
- **Fenêtres du dock droit au même format** : en comparant les styles de thème, `InventoryPanel`
  et `SuccessPanel` utilisaient `PanelContainer` comme fenêtre racine - dans les 4 thèmes, ce type
  est stylé en `PanelContainer/styles/panel` (fond blanc, bordure 3px), pensé à l'origine pour les
  lignes de liste (coffre, item), pas pour une fenêtre entière. `GameMenuPanel` et `CardAlbum`
  utilisent `Panel` (fond crème, bordure 4px, coins arrondis 20 - `Panel/styles/panel`) avec des
  marges fixes de 40px sur les 4 côtés. `InventoryPanel` et `SuccessPanel` adoptent maintenant ce
  même type `Panel` + mêmes marges fixes (au lieu des anchors en pourcentage 0.1/0.08/0.9/0.92
  utilisées jusque-là) : les 3 fenêtres ouvertes depuis la colonne de droite (Sac de pièces, Livre,
  Succès) partagent désormais exactement le même habillage que la fenêtre du menu de gauche.
  `CardAlbum` n'a pas eu besoin de changer, déjà dans ce format.

## Retour sur la taille des icônes, marge à 5px, colonne droite persistante (2026-08-26)

**Retour utilisateur** : "modifie comme suit: taille d icone retour a la taille precedente on
reduit la marge interieur a 5 px; les icones doivent etre centrées, je veux aussi que les fenetre
et la colonne de droite apparaissent en meme temps comme pour la colonne de gauche avec ses menus
et fenetres."

Trois ajustements sur la retouche précédente ("Colonnes -25%") :

- **Taille d'icône** : retour à la convention native × 0,6 d'origine (× 0,45 abandonné) pour les 8
  boutons des deux colonnes.
- **Marge intérieure** : `IconList` passe à 5px de chaque côté (au lieu de 15px) - c'est
  maintenant la marge, pas la taille des icônes, qui détermine la largeur resserrée de la colonne.
  `IconDock` (partagé) se stabilise à 93px de large (icône la plus large, `SuccesButton` à 83px,
  + 5px de marge de chaque côté). Les boutons gardent `size_flags_horizontal = SHRINK_CENTER`
  (déjà en place) : chacun reste centré dans la colonne quelle que soit sa propre largeur.
- **Colonne et fenêtre visibles ensemble** : `BackpackMenu` ne referme plus la colonne après avoir
  ouvert un panneau (Sac de pièces/Livre/Succès) - jusque-là un comportement de menu déroulant
  (`_open_panel()` appelait `close()` juste après `panel.open()`). La colonne reste maintenant
  affichée en même temps que la fenêtre ouverte, exactement comme `IconDock` reste visible à côté
  du `Panel` de contenu dans `GameMenuPanel` côté gauche.

**Point de vigilance signalé ici, résolu le jour même** : voir l'entrée suivante.

## Fenêtres de la colonne droite collées au dock, un seul panneau à la fois (2026-08-26)

**Retour utilisateur** (avec deux captures d'écran comparant "Configuration" à gauche et
"Inventaire" à droite) : "compare ces 2 photos de menu gauche et droite, je veux que le menu de
droite fasse la meme chose : le click sur l icone fait apparaitre la fenetre correspondant a l
icone a cote de la colonne menu, un click sur une autre icone fait disparaitre la premiere fenetre
et apparaitre lautre. en ce qui concerne le livre de cartes, on va garder le contenu mais on va
passer sur un contour de fenetre identique aux autres fenetre des menus."

Ce retour tranche directement le point de vigilance laissé ouvert par la retouche précédente.

- **Fenêtre collée à la colonne** : `InventoryPanel`, `SuccessPanel` et `CardAlbum` avaient des
  marges symétriques de 40px, ignorant la présence d'`IconDock` — d'où le grand vide visible dans
  la capture d'écran entre la fenêtre "Inventaire" et la colonne d'icônes. Les 3 fenêtres passent à
  `offset_right = -113` (au lieu de -40) : 113 = largeur d'`IconDock` (93px) + marge écran (20px),
  la fenêtre borde directement la colonne, exactement comme `Panel` borde `IconDock` à gauche.
- **Un seul panneau à la fois** : `BackpackMenu._open_panel()` ferme désormais les 2 autres
  panneaux de la colonne avant d'ouvrir le nouveau — cliquer sur "Livre" pendant que "Sac de
  pièces" est ouvert referme ce dernier, comme demandé.
- **`CardAlbum` recadré, contenu conservé** : "on va garder le contenu" — toujours 5 cartes par
  page, même taille de carte, aucune section retirée. Seul `ScrollContainer` (largeur fixe, centré
  sur `Panel`) rétrécit de 1040 à 990px pour continuer à loger les 5 cartes (967,5px de large avec
  leur espacement) dans le `Panel` désormais plus étroit (999px disponibles, ~4,5px de marge de
  chaque côté — volontairement serré). Le titre, la pagination et les boutons Précédent/Suivant
  n'ont pas eu besoin de changer : ancrés en pourcentage/côté-relatif au `Panel`, ils suivent
  automatiquement son nouveau format.

## Marges resserrées, cohérence gauche/droite (2026-08-29)

**Retour utilisateur** (demande d'un comparatif des marges verticales entre fenêtres et colonnes
d'icônes gauche/droite) : "actuellement entre la colonne de droite et les fenetres correspondantes
il n y a pas de marge." Comparatif fait à sa demande : la colonne gauche gardait 20px entre
`IconDock` et sa fenêtre, la colonne droite était collée (0px) — écart introduit par la retouche du
2026-08-26 (`offset_right = -113`, calculé sans marge supplémentaire pour que la grille de cartes de
`CardAlbum` tienne dans le `Panel`).

Décision : "on va passer a 10px de chaque cote entre la colonne et la fenetre, on va aussi reduire
toutes les marges exterieures entre fenetre et bord de l ecran en haut en bas a droite et a gauche,
applique cette mod a toutes les fentres et tous les menus du jeu." Portée précisée ensuite : "toutes
les fenetres accessibles via les icone dans les menus en colonne doivent avoir la meme logique et le
meme theme grphique, les questions accessibles via npc gardent leur propre design" — donc uniquement
`GameMenuPanel`, `BackpackMenu`/`IconDock` (partagé), `InventoryPanel`, `SuccessPanel` et
`CardAlbum` ; `ShopPanel`/`QuestionPanel`/`SubjectSelectPanel`/`WelcomePanel`/`ReadingIntroPanel`
(ancrés en pourcentage, sans colonne d'icônes, pas ouverts depuis une colonne) restent inchangés.

- **Marge écran (haut/bas/gauche/droite) 40 → 20px**, uniforme sur `IconDock` ET sur les 4
  fenêtres : `IconDock` n'avait déjà que 20px en horizontal, il passe aussi à 20px en haut/bas
  (`offset_top`/`offset_bottom` : 40/-40 → 20/-20). Réponse retenue quand demandé explicitement :
  "20px (aligné sur la marge écran de la colonne d'icônes elle-même)."
- **Marge colonne ↔ fenêtre 20 → 10px** (au lieu des deux valeurs incohérentes 20/0 relevées par le
  comparatif) : `GameMenuPanel.Panel.offset_left` = 20 (marge écran) + 93 (largeur `IconDock`) + 10
  (nouvelle marge) = 123, était 133. Côté droit, `InventoryPanel`/`SuccessPanel`/`CardAlbum`
  passent à `offset_right = -123` (était -113), même formule en miroir.
- **`CardAlbum` regagne de la place** malgré la marge colonne qui augmente (0→10px), parce que la
  marge écran baisse davantage (40→20px) : le `Panel` passe de 999 à 1009px de large. Son
  `ScrollContainer` s'élargit en conséquence de 990 à 1000px (`offset` ±495 → ±500) pour garder la
  même marge visuelle (~4,5px de chaque côté) autour de la grille de 5 cartes.

## Échap ferme la colonne ET la fenêtre, colonne de droite (2026-08-29)

**Retour utilisateur** : "il reste une difference a appliquer sur les icones et fenetre lie a la
colonne de droite, laction ECHAP doit fermer le menu ET la fenetre, actuellement ca fonctionne bien
avec la colonne de gauche mais a droite la fenetre reste ouverte."

Cause : `GameMenuPanel` (gauche) est un seul nœud racine contenant à la fois `IconDock` et `Panel` —
un seul `close()` ferme les deux d'un coup. À droite, `BackpackMenu` et ses 3 panneaux
(`InventoryPanel`/`CardAlbum`/`SuccessPanel`) sont des nœuds séparés dans `UI`, chacun avec son
propre gestionnaire d'Échap (`_unhandled_input` sur `ui_cancel`) — le premier nœud traité dans
l'ordre de l'arbre consomme l'événement, empêchant l'autre de le recevoir. `BackpackMenu` se
fermait donc bien, mais le panneau resté ouvert ne voyait jamais l'Échap.

Fix : `BackpackMenu.close()` ferme désormais explicitement les 3 panneaux externes (même liste que
`_open_panel()`) en plus de se fermer elle-même — qu'importe qui consomme l'événement en premier,
fermer la colonne ferme toujours tout avec elle. S'applique aussi au clic sur `BackpackButton`, pas
seulement à Échap.

## Croix de fermeture bloquées, colonne de droite (2026-08-29)

**Retour utilisateur** : "check les croix de fermeture sur les fenetre du menu de droite, elles ne
fonctionne plus au click."

Cause : `BackpackMenu` est un `Control` plein écran, ajouté après `CardAlbum`/`InventoryPanel`/
`SuccessPanel` dans `game_ui.tscn` (donc dessiné par-dessus). Par défaut (`mouse_filter` = STOP), sa
zone vide en dehors d'`IconDock` capturait tous les clics de l'écran, y compris ceux destinés aux
croix de fermeture des 3 panneaux voisins situés en dessous. Fix : `mouse_filter = 2` (IGNORE) sur
le nœud racine de `BackpackMenu` — même correctif déjà appliqué à `BlurBG` dans
`game_menu_panel.tscn` pour la même raison (zone plein écran vide au-dessus d'éléments cliquables).
`IconDock` et ses boutons, restés à leur `mouse_filter` par défaut, continuent de capter leurs
propres clics normalement.

## Section "Récompenses" : fusion avec la Boutique, fin du système de rareté (2026-08-29)

**Retour utilisateur** : "modification majeure : licone sac de piece devient la section
'Récompenses' : dans la fenetre correpondante on aura la fenetre boutique actuelle, on y ajoute
une bande en haut avec les pieces gagnées ; leur nom change aussi, on enleve le systeme commun peu
commun etc et on remplace juste par le nom des classes CP, CE1 etc on va aussi utiliser l icone de
piece qu on va colorer selon la charte de couleur utilisee actuellement, lets go."

- **"Sac de pièces" → "Récompenses"** : le bouton de `BackpackMenu` (nom de nœud/variable
  inchangé, même convention que l'ancien renommage d'`InventoryPanel`) ouvre désormais `ShopPanel`
  au lieu de l'ancien `InventoryPanel`, retiré (`ui/inventory/` supprimé : `inventory_panel.gd/
  .tscn`, `inventory_row.gd/.tscn`, doublon une fois son rôle repris par `ShopPanel`). `ShopPanel`
  reste aussi ouvrable par le kiosque de la scène — les deux chemins ouvrent le même nœud, pas une
  copie. Le raccourci clavier "I" (`open_inventory`, nom d'action inchangé) bascule maintenant
  `ShopPanel` ouvert/fermé, comme il le faisait pour `InventoryPanel`.
- **Bande "pièces gagnées"** : `RewardsBand`, une instance de `CoinHUD` (`ui/hud/coin_hud.gd/
  .tscn` — codée depuis longtemps mais jamais instanciée nulle part avant ce jour), ajoutée entre
  l'en-tête et les onglets de `ShopPanel`. Se met à jour toute seule via `Economy.balance_changed`.
- **Fin du "Commune/Peu commune/Rare/Épique/Légendaire" côté joueur** : `CardRarity.get_label()`
  supprimé (plus aucun appelant) — remplacé partout par `GradeLevel.get_label()` (CP/CE1/CE2/CM1/
  CM2). `Economy` reste indexé par `CardRarity.Rarity` en interne (aucune migration de sauvegarde
  nécessaire, simple changement de couche d'affichage) ; `GradeLevel.get_grade_for_rarity()`
  (nouvelle réciproque de `get_rarity()`) fait la conversion partout où seule la `Rarity` est
  connue. Textes mis à jour : `CoinHUD`, le nom des 5 coffres (`crate_commun.tres` etc., "Commune"
  → "CP", ...), le message de classe verrouillée (`QuestionGiverComponent`), le message de
  résultat de pack (`QuestionPanel`), le libellé du raccourci "I" dans la section Commandes
  (`SectionControls`), et le générateur `tools/admin/build_loot_tables.gd` (qui corrige au passage
  un préfixe "Coffre " obsolète, déjà retiré à la main des `.tres` existants).
- **Icône pièce colorée par classe** : `CoinHUD` teinte l'icône `piece.webp` via `modulate` avec
  `GradeLevel.get_color(grade)` (même palette que les cartes/l'album : CP=blanc, CE1=vert,
  CE2=bleu, CM1=violet, CM2=orange) au lieu d'une texture neutre non colorée — une seule icône
  partagée, comme avant, mais teintée cette fois.

## Retouches sur la section "Récompenses" : taille des icônes, format de fenêtre, prix colorés (2026-08-29)

**Retour utilisateur** (avec capture d'écran) : "reduit la taille des icones de 60%, ajuste la
taille de la fenetre pour etre de la meme taille que les autres fenetres. En plus modifie les
icones dans les prix des items et pose la couleur correspondant aux pieces listees dans la fenetre."

- **Icônes de `RewardsBand` trop grandes — bug, pas un simple réglage** : `piece.webp` fait
  120×120px nativement. Le `TextureRect` créé en code dans `CoinHUD` fixait bien
  `custom_minimum_size = Vector2(20, 20)` mais oubliait `expand_mode` — resté à sa valeur par
  défaut (`EXPAND_KEEP_SIZE`), qui fait remonter la taille NATIVE de la texture comme taille
  minimale réelle (Godot prend le maximum des deux). L'icône s'affichait donc à 120px, jamais à
  20px. Fix : `expand_mode = EXPAND_IGNORE_SIZE` + nouvelle taille cible `ICON_SIZE = 48` (120 ×
  0,4 — soit une réduction de 60% par rapport à ce qui s'affichait réellement à l'écran, plus
  grande que les 20px visés à l'origine mais cohérente avec la réduction demandée). `RewardsBand`
  passe de 44 à 56px de haut dans `shop_panel.tscn` pour garder un peu de marge autour.
- **Fenêtre de `ShopPanel` alignée sur les 3 autres fenêtres de la colonne droite** : passée
  d'ancres en pourcentage (0.1/0.08/0.9/0.92, ~80% de l'écran) à la même formule en pixels fixes
  que `InventoryPanel`/`SuccessPanel`/`CardAlbum` (`offset_left=20, offset_top=20,
  offset_right=-123, offset_bottom=-20` — borde `IconDock`). Le `PanelContainer` racine et son
  style restent inchangés : seule la taille/position visée par ce retour, pas l'habillage (qui
  avait été explicitement conservé la veille - "on aura la fenetre boutique actuelle").
- **Icônes de prix (`CoinIcon`, `CrateItem`/`GradeUnlockItem`) enfin colorées** : `concept_piece.
  svg` est une base grise neutre conçue dès sa création (2026-08-01) pour être teintée par
  `modulate` selon la rareté/classe — son propre commentaire l'annonçait déjà — mais ce `modulate`
  n'était en réalité jamais appliqué dans le code (bug latent, invisible tant que personne n'avait
  comparé à la bande de pièces). Corrigé : `coin_icon.modulate = color`, même couleur que le cadre/
  la pastille de prix déjà colorés, donc même couleur que la pièce correspondante dans `RewardsBand`.

## En-tête de la Boutique aligné sur le menu de gauche, icônes de coffre remplacées (2026-08-29)

**Retour utilisateur** : "dans la boutique, applique la meme mise en page de fenetre que les menu
gauche, le titre en haut avec une barre de separation, pas besoin de l icone coffre, par contre
remplace les coffres d achat d animaux par l icone boutique de meme taille beaucoup plus design."

- **En-tête simplifié** : `TitleIcon` (`boutique.webp`, une icône dans le titre) retiré de
  `HeaderRow` — `GameMenuPanel`, la référence citée, n'a jamais eu d'icône dans son propre
  `TitleRow`, juste le texte du titre.
- **Barre de séparation sous le titre** : `TitleSeparator` (`HSeparator`) ajouté juste après
  `HeaderRow`, même convention que `TitleSeparator` dans `game_menu_panel.tscn` (déjà stylée dans
  les 4 thèmes). Remplace l'ancien `RewardsSeparator`, qui se trouvait plus bas (entre
  `RewardsBand` et les onglets) — mauvais emplacement par rapport à cette demande : un seul trait,
  sous le titre, pas un deuxième plus bas.
- **Icônes des coffres remplacées** : `ItemIcon` (case de coffre dans l'onglet "Cartes") passe de
  `concept_coffre.svg` (placeholder "concept" du 2026-08-01, supprimé du projet, plus aucune
  référence) à `boutique.webp` (icône finie, "beaucoup plus design"). Aucun ajustement de taille
  nécessaire — `expand_mode`/`stretch_mode` remplissaient déjà l'espace disponible indépendamment
  de la résolution native de la texture. Pas de teinte appliquée dessus (contrairement à
  `CoinIcon`) : c'est une icône finie en couleurs, pas une base grise à teinter.

## Croix de fermeture unique en haut de chaque colonne (2026-08-29)

**Retour utilisateur** : "on va operer une modification sur toutes les fenetres accessibles via
menu droite et gauche. dorenavant la fermeture de l ensemble colonne d icone et fermeture fenetre
soperera par la touche ECHAP ou une croix située en haut de la colonne au lieu de la croix dans
chaque fenetre qui sera a enlever."

- **Croix retirées** : `GameMenuPanel`, `ShopPanel`, `CardAlbum` et `SuccessPanel` perdent chacune
  leur `CloseButton` propre (coin supérieur droit de la fenêtre). `HeaderSpacer` (qui ne servait
  qu'à pousser cette croix à droite dans `ShopPanel`/`SuccessPanel`) est retiré avec elle, devenu
  inutile.
- **Une seule croix par colonne, partagée entre les deux côtés** : un nouveau `CloseButton` est
  ajouté directement dans `icon_dock.tscn` (la scène de base déjà partagée entre `GameMenuPanel` à
  gauche et `BackpackMenu` à droite) — visible en haut de la colonne des deux côtés à la fois sans
  dupliquer le nœud, exactement comme le cadre/les marges d'`IconDock` l'étaient déjà.
- **Comportement inchangé, juste un nouvel accès** : le nœud visuel est partagé, pas le
  comportement — `IconDock` lui-même n'a pas de script. Chaque script côté (`game_menu_panel.gd`,
  `backpack_menu.gd`) connecte ce bouton à son propre `close()`, qui fermait déjà colonne + fenêtre
  ensemble (voir les entrées précédentes sur la fermeture par Échap). Cette croix est donc un
  second chemin vers exactement ce que faisait déjà Échap, pas un nouveau comportement.
- **Croix collée au bord supérieur, pas au bloc d'icônes centré** (retour utilisateur suivant, même
  jour : "colle la croix en haut de la colonne des 2 cotés") : placée d'abord comme premier enfant
  d'`IconList` (`alignment = 1`, centré) — elle suivait alors le centrage du bloc d'icônes au lieu
  de rester fixe en haut du panneau, si le bloc ne remplissait pas toute la hauteur disponible.
  Sortie d'`IconList`, devient un enfant séparé d'`IconDock`, ancré en haut et centré horizontalement
  (`anchor_left = anchor_right = 0.5`, `offset_top = 8`). `IconList.offset_top` passe de 14 à 44
  pour libérer la place sous la croix — la liste d'icônes reste centrée, mais dans l'espace restant
  en dessous d'elle, plus dans tout le panneau.
- **Hors périmètre** : `QuestionPanel`/`SubjectSelectPanel` (questions via NPC) gardent leur propre
  croix — non concernés, ils ne vivent pas derrière une colonne d'icônes.

## Chrome de fenêtre uniformisé : Boutique, Succès, Livre des animaux (2026-08-29)

**Retour utilisateur** : "applique la configuration des fenetres de gauche a celle de la boutique,
positionnement du titre, barre de separation couleur de fond theme etc, pareil pour defis et
pareil pour livre des animaux, on refondra le design du livre plus tard pour l instant je veux
uniformiser toutes les fenetres."

- **Boutique (`ShopPanel`)** : son `Panel` racine était resté un `PanelContainer` (fond blanc, coins
  arrondis 14 — style pensé pour une ligne de liste, pas une fenêtre) même après son alignement en
  taille/position sur les autres fenêtres du 2026-08-29 plus tôt le même jour. Passe à `Panel` (fond
  crème, bordure 4px, coins arrondis 20), même style que `GameMenuPanel`/`CardAlbum`/`SuccessPanel`.
  `Margin` passe de `layout_mode = 2` (arrangé automatiquement par le `PanelContainer`) à
  `layout_mode = 1` + `anchors_preset = 15` explicite (`Panel` ne gère pas la disposition de ses
  enfants). `HeaderRow` gagne `alignment = 1` : le titre "Boutique" était aligné à gauche, il est
  maintenant centré comme `TitleRow` dans `game_menu_panel.tscn`.
- **Succès (`SuccessPanel`)** : avait déjà le bon type `Panel`, mais son titre restait aligné à
  gauche (pas d'`alignment` sur `HeaderRow`) et n'avait jamais eu de barre de séparation sous le
  titre — page vide en réserve, l'absence passait inaperçue. `HeaderRow` gagne `alignment = 1`,
  un `TitleSeparator` (`HSeparator`) est ajouté juste après, même convention que `GameMenuPanel`/
  `ShopPanel`.
- **Livre des animaux (`CardAlbum`)** : déjà conforme (type `Panel`, titre déjà centré via
  `horizontal_alignment = 1` sur `TitleLabel`) — aucun changement de chrome. Son trait décoratif
  double sous le titre (`TitleUnderline`) reste en place à la place d'un `HSeparator` standard :
  design spécifique au livre demandé par Steve le 2026-07-25, explicitement laissé de côté par ce
  même retour ("on refondra le design du livre plus tard") plutôt que traité comme une incohérence
  à corriger maintenant.

## Géométrie du titre/séparateur calquée pixel pour pixel sur le menu de gauche (2026-08-29)

**Retour utilisateur, avec captures d'écran comparant les en-têtes "Boutique" et "Sauvegarde"** :
"ca fait plusieurs fois que je demande la meme config d ui entre les fenetre ouvertes depuis icone
de gauche et droite, a gauche lentete est OK avec sauvegarde, le raccourci et la barre de
separation; a droite on a une ligne flottante plus bas mais pas comme sauvegarde et les autres
fenetres du menu de gauche, peux tu appliquer le meme design?"

- **Cause du décalage** : le correctif précédent (entrée ci-dessus) centrait bien le titre, mais
  laissait `TitleSeparator` dans le flux du `VBoxContainer` `Content` (`separation = 18`) — sa
  position dépendait donc de la hauteur réelle du `Label` (police, interligne), pas d'un offset
  fixe. Résultat : la ligne apparaissait plus bas que dans `GameMenuPanel`, où `TitleRow` et
  `TitleSeparator` sont positionnés en pixels fixes, indépendamment de tout conteneur.
- **Correctif** : dans `ShopPanel` et `SuccessPanel`, `TitleRow` (renommé depuis `HeaderRow`) et
  `TitleSeparator` sortent entièrement du flux `Margin`/`Content` pour devenir des enfants directs
  de `Panel`, avec exactement les mêmes offsets que `game_menu_panel.tscn` : titre
  `offset_top = 10, offset_bottom = 40` ; séparateur `offset_top = 55, offset_bottom = 59`. `Margin`
  (le corps de la fenêtre : `RewardsBand`/`Tabs` pour la Boutique, `PlaceholderLabel` pour Succès)
  démarre désormais à `offset_top = 80`, même valeur que `ContentArea` dans `GameMenuPanel`.
- **Résultat** : géométrie d'en-tête identique en pixels des deux côtés, plus une approximation
  visuelle par séparation de conteneur — élimine la dérive pour de bon.

## Kiosque Boutique retiré de la scène 2D (2026-08-29)

**Retour utilisateur** : "on retire le module boutique posé dans le jeu en 2d, il n a plus a
apparaitre la car il se trouve dans le menu."

- Le nœud `ShopKiosk` (capsule jaune interactive, `entities/shop_kiosk_2d/shop_kiosk_2d.tscn`)
  posé dans `levels/school/school.tscn` est supprimé, avec son `ext_resource`. La scène
  `shop_kiosk_2d.tscn` elle-même est supprimée (plus aucune référence dans le projet actif).
- La Boutique (`ShopPanel`, section "Récompenses") reste accessible uniquement via l'icône de la
  colonne de droite et le raccourci clavier "I" — plus de point d'entrée dans le monde du jeu.
- `ShopPanel.open()` perd son paramètre `who` optionnel, qui n'existait que pour recevoir
  l'`InteractableComponent.interacted` du kiosque.

## Boutique en page de base + flou plein écran, colonne de droite (2026-08-29)

**Retour utilisateur** : "tout comme le menu de gauche ouvre une colonne d icones et la page
configuration avec du floutage en arriere plan, je veux que le menu de droite ouvre la boutique
comme page de base, que le fond en arriere plan soit flouté de la meme maniere que l autre menu."

- **Page de base** : `BackpackMenu.open()` ouvre désormais automatiquement `ShopPanel` (Boutique)
  en plus d'afficher la colonne d'icônes, qu'une icône ait été cliquée ou non — même principe que
  `GameMenuPanel.open()` qui affiche toujours "Configuration" en premier. Rouvrir la colonne après
  fermeture revient toujours à la Boutique (pas de mémoire du dernier onglet consulté).
- **Flou plein écran** : la colonne de gauche a déjà ce flou (`BlurBG`, voir "Flou plein écran"
  ci-dessus) car il vit comme enfant direct de `GameMenuPanel`, dessiné sous son propre `Panel`.
  `ShopPanel`/`CardAlbum`/`SuccessPanel` ne sont pas des enfants de `BackpackMenu` mais des nœuds
  séparés dans `game_ui.tscn` : un flou enfant de `BackpackMenu` se serait dessiné PAR-DESSUS eux
  (mauvais). Un nouveau nœud `BackpackBlurBG` (même shader `icon_dock_blur.gdshader`, même teinte
  noire 40%) est ajouté à `game_ui.tscn`, placé AVANT ces trois fenêtres dans l'arbre pour se
  dessiner en dessous, et piloté à distance par `BackpackMenu` via un nouveau NodePath
  (`blur_bg_path`) — sa visibilité suit celle de la colonne.

## Marge au-dessus de la croix de fermeture alignée sur 10px (2026-08-29)

**Retour utilisateur** : "appplique la meme marge au dessus des croix de fermeture des menu colonne
que sur les cotes 10px?"

- `CloseButton` (dans `icon_dock.tscn`, partagé entre les deux colonnes) passe d'`offset_top = 8`
  à `offset_top = 10` — reprend la même valeur que la marge colonne↔fenêtre déjà utilisée ailleurs
  dans l'interface (10px de chaque côté entre une colonne d'icônes et sa fenêtre). `offset_bottom`
  suit (36→38, hauteur 28px inchangée).
- `IconList.offset_top` passe de 44 à 46 (+2px) pour conserver le même écart de 8px entre le bas
  de la croix et le haut de la liste d'icônes — seule la marge du haut change, pas l'espacement
  interne sous la croix.

## Nouveau code couleur par classe + icônes de pièces finies en couleur (2026-08-30)

**Retour utilisateur** : "dans la boutique, remplace les icone de pieces, je les ai faites en webp
avec leur couleur, on va instaurer un nouveau code couleur valable pour tout le jeu : cp=bleu,
ce1=vert, ce2=jaune, cm1=violet, cm2=rouge, du coup les icones pour le total de piece du joueur
sappellent tasdepiece, les pieces a utiliser pour les achat sont les icones pieces et doivent
apparaitre a cote du nombre de piece dans les item a achter de la boutique en fonction de la
classe correpondante."

- **Palette officielle, valable dans tout le jeu** : CP = bleu (`#42A5F5`), CE1 = vert (`#66BB6A`),
  CE2 = jaune (`#FDD835`), CM1 = violet (`#AB47BC`), CM2 = rouge (`#E53935`) — `GradeLevel.get_color()`.
  Remplace l'ancienne palette héritée du système de rareté des cartes (`CardRarity.get_color()`,
  commune=blanc/peu commune=vert/rare=bleu/épique=violet/légendaire=orange, retiré car plus aucun
  appelant). S'applique partout où une couleur de classe était déjà utilisée : cadre de carte dans
  l'album, texte de `LootFeed`, solde de `CoinHUD`, cadre/bulle de prix de `CrateItem`, cadre de
  `ProfSkinItem`.
- **Icônes de pièces, deux jeux distincts, finis en couleur** : `piece-<CLASSE>.webp` (une pièce
  seule) à côté du prix des items à acheter (`CrateItem`, `ProfSkinItem`) ; `tasdepiece-<CLASSE>.webp`
  (pile de pièces) pour le solde total du joueur (`CoinHUD`/bande "Récompenses"). Remplacent
  l'ancienne icône unique `piece.webp` teintée par `modulate` (`CoinHUD`) et la base grise
  `concept_piece.svg` jamais correctement teintée puis teintée via `modulate` (`CrateItem`/
  `ProfSkinItem`) — les nouveaux fichiers étant déjà en couleur, plus aucun `modulate` n'est
  appliqué dessus (ça re-teindrait une image déjà colorée). `concept_piece.svg` supprimé.
- **Contraste texte inchangé** : la règle "texte blanc sur fond CM2, encre ailleurs" (`CardSlot`,
  `ProfSkinItem`) et son équivalent côté rareté dans `CrateItem` (désormais aussi indexé sur
  `grade == CM2`, plus `rarity == LEGENDARY`) restent valables — le rouge CM2 comme l'ancien orange
  légendaire nécessitent un texte clair.

**Correctif du même jour (2026-08-30, plus tard)** : `ProfSkinItem` a été refondu entre-temps (voir
l'entrée "Cadre simplifié" dans son propre historique de doc-comment, `prof_skin_item.gd`) — la
nouvelle version (`PriceBadge`, cadre transparent) réintroduisait par erreur `concept_piece.svg` +
`modulate = GradeLevel.get_color(grade)` sur `CoinIcon`, alors que ce fichier avait déjà été
supprimé dans le cadre du point ci-dessus. Résultat : erreur de chargement de scène au lancement
(`_load: Resource file not found: res://assets/icons/concept_piece.svg`), signalée par Steve via
capture d'écran de la console Godot. Corrigé : `prof_skin_item.tscn` n'a plus l'`ext_resource` du
`.svg` ni de `texture=` sur `CoinIcon` ; `prof_skin_item.gd` assigne `coin_icon.texture =
load(GradeLevel.get_coin_icon_path(grade))` en `_ready()`, sans `modulate`, cohérent avec
`CrateItem`/`CoinHUD` ci-dessus.

## Écran de résultat : icône pièce au lieu du texte, doublon icône/nom retiré en Logique (2026-08-31)

**Retour utilisateur** : "dans les questions de logique quand la question le petit du cheval est..
le petit du chien est.. laisse uniquement l icone, enleve le nom de l animal en lettre, sinon ca
fait doublon, ensuite lors des resultats, a la place de tu gagnes 5 pieces CP, remplace 'piece CP'
par l icone de piece de la bonne couleur, applique ceci pour toutes les classes toutes les
matieres."

- **Logique CP, famille "petit de l'animal"** : `csv/questions/cp/logique/generated.csv`, 30 lignes
  qui affichaient déjà l'emoji ET le nom de l'animal en toutes lettres (ex. "Le petit du 🐷 est le
  porcelet"). Le nom textuel est retiré, seul l'emoji reste ("Le petit de 🐷 est le porcelet").
  `ce1/logique` a la même famille mais sans aucun emoji (texte seul) — pas de doublon là, donc pas
  touché.
- **Pastille de résultat (`QuestionPanel`)** : "tu gagnes N pièce(s) {Classe}" devenait redondant
  avec le reste de l'UI (boutique, `RewardsBand`) qui affiche déjà l'icône `piece-<CLASSE>.webp`
  plutôt que le nom de la classe en toutes lettres. Le texte s'arrête maintenant à "tu gagnes N",
  suivi de l'icône pièce colorée de la classe (même fichier que `CrateItem`/`ProfSkinItem`, voir
  `GradeLevel.get_coin_icon_path()`). `ProgressBadge` (la pastille d'en-tête, jusque-là un
  `PanelContainer` à enfant unique `ProgressLabel`) gagne un `HBoxContainer` intermédiaire
  (`ProgressBadgeRow`) pour loger le label et une icône `TextureRect` côte à côte ; l'icône est
  créée en code dans `_ready()` (même pattern que `CoinHUD`, jamais posée dans la `.tscn`), et
  reste masquée tant que la pastille sert à autre chose (compteur "Question X/Y", message
  temporaire) — elle n'apparaît qu'à l'affichage du résultat. Un seul script/scène partagé par
  toutes les matières et classes (`QuestionPanel`), donc le changement s'applique partout sans
  logique conditionnelle par classe.

## Idle des profs : retrait du balancement latéral (2026-09-02)

`entities/npc/components/prof_visual.gd` (animation idle "vivante" des sprites de prof, voir
[[project_classe2_single_screen_pivot]]) avait un étirement vertical ET un léger balancement/
rotation latéral pivotant depuis les pieds. Retour utilisateur : l'ensemble donnait un effet
"ballon gonflé à l'hélium qui se balance" plutôt qu'une respiration. Le balancement (rotation) est
retiré entièrement - il ne reste que l'étirement vertical, toujours ancré sur les pieds (le bas du
sprite ne bouge jamais, seul le haut monte très légèrement puis redescend).

**Respiration par à-coups plutôt qu'un sinus continu (2026-09-02, suite)** : retour utilisateur -
une simple sinusoïde continue déphasée par PNJ reste synchronisée EN RELATIF pour toujours (les
PNJ gardent le même écart entre eux indéfiniment), ce n'est pas suffisant pour ne jamais donner
l'impression que plusieurs respirent ensemble. Remplacé par une machine à 2 états
(`_is_stretching`) : une pause immobile de durée aléatoire (`pause_min`/`pause_max`, 2 à 4s par
défaut), puis UNE extension (demi-sinusoïde), puis une NOUVELLE pause d'une durée aléatoire
différente, etc. C'est ce tirage aléatoire répété à chaque cycle (pas juste un décalage initial)
qui fait dériver les PNJ les uns par rapport aux autres dans le temps.

**Durée de l'extension aussi tirée au sort (2026-09-02, suite)** : retour utilisateur - l'aller-retour
de l'extension (montée + redescente) doit durer 4 à 5 secondes, pas une valeur fixe. `stretch_duration`
remplacé par `stretch_min`/`stretch_max` (4.0/5.0), tirés au sort dans `_current_stretch_duration` à
chaque début d'extension - même principe que `pause_min`/`pause_max`, la respiration elle-même varie
donc aussi d'un cycle à l'autre, pas seulement le temps entre deux respirations.

## Icône de titre clonée du menu, dans les 4 fenêtres (2026-09-02)

**Retour utilisateur** : "je veux que l icone de chaque fenetre apparaisse aussi a gauche du titre
de la fenetre dans la fenetre, cela donnera une correspondance entre la fenetre exploree et l icone
de menu, il faut que l icone dans la fentre a cote du titre soit un clone de celle du menu, en
changeant un on change l autre, des modifications du graphisme vont internvenir apres."

Une `TitleIcon` (`TextureRect`, 28×28 comme `ShortcutBadge`, `expand_mode`/`stretch_mode` repris de
`CoinIcon`) apparaît désormais avant `TitleLabel` dans le `TitleRow` (centré, comme le reste) de
`GameMenuPanel`, `ShopPanel`, `SuccessPanel` et `CardAlbum` (nouveau `TitleRow` intercalé dans
`TitleBlock`, avant `TitleUnderline`/`CategoryLabel` — design "livre" par ailleurs inchangé, voir
"Reste à faire"). Aucune n'a de texture fixée en dur dans son `.tscn` : c'est un "clone" au sens
demandé — pas un fichier dupliqué, mais une lecture directe de la `Texture2D` déjà chargée par le
bouton de la colonne `IconDock` correspondant, assignée en code. Modifier l'icône d'un bouton (ou
remplacer son fichier source sur disque) met donc à jour le titre automatiquement.

- `GameMenuPanel` (5 sections dans UNE seule fenêtre) : `title_icon.texture` est réassigné à
  `_update_header()` depuis le bouton de la section active (`_icon_button_for(id)`), puisque
  l'icône affichée doit changer à chaque bascule de section.
- `ShopPanel`/`SuccessPanel`/`CardAlbum` (3 fenêtres séparées ouvertes par `BackpackMenu`) :
  chacune a un nouvel export `title_icon_source_path` (`NodePath`), assigné dans `game_ui.tscn`
  vers le bouton `IconDock` correspondant (`SacDePiecesButton`/`SuccesButton`/`LivreButton`) —
  même mécanisme de référence que `CardRevealOverlay.book_icon_path`, déjà utilisé dans ce projet
  pour cibler `LivreButton`. `title_icon.texture` est lu une seule fois en `_ready()`.

## ProfSkinItem : portrait réduit, cadre de prix thémé, bordure superflue retirée (2026-09-02)

**Retour utilisateur** (capture d'écran des 10 skins de la boutique) : "les images de prof sont
toujours trop grande (au moins 50%) et ne sont pas adaptées a la case d achat. ensuite il manque un
cadre autour du prix+icone avec fond unis selon le theme pour lisibilité. ensuite le cadre superflu
autour de la case d achat est toujours present, enleve le."

- **Portrait réduit** : `SkinIcon` gagne une marge de 20px sur les 4 côtés (zone visible 100×100 →
  60×60) — le mode `STRETCH_KEEP_ASPECT_CENTERED` (déjà en place depuis le 2026-08-30) continue de
  s'appliquer sur cette zone réduite, laissant le fond crème d'`InnerPanel` visible tout autour.
- **Cadre de prix thémé** : `CoinIcon`/`PriceLabel` passent d'enfants directs de `Frame` à enfants
  d'un nouveau `PriceBadge` (`PanelContainer`, `theme_type_variation = "ShortcutBadge"` — la même
  pastille cadre/fond par thème déjà utilisée pour la touche de raccourci dans `GameMenuPanel`,
  réutilisée telle quelle plutôt que dupliquée) — même position (ancré bas-droite), désormais avec
  un fond uni + bordure fine aux couleurs du thème actif derrière la pièce colorée.
- **Bordure de case retirée sauf skin actif** : `Frame` ne dessine plus de bordure du tout tant que
  le skin affiché n'est pas celui actuellement porté (l'ancienne bordure encre fine, permanente et
  identique sur toutes les cases, n'apportait aucune information) — seule la bordure dorée
  "surbrillance" (skin actif) subsiste, puisqu'elle signale réellement quelque chose.

## Jeu 100% souris/tactile, suppression de tous les raccourcis clavier (2026-09-02)

**Retour utilisateur** : "changement de plans, on supprime tous les raccourcis clavier, je veux un
jeu qui se joue uniquement a la souris ou au tactile, est ce possible de detecter automatiquement
la plateforme et dactiver ou de rendre utilisable tactile et souris en meme temps ?"

**Réponse à la question technique** : oui, et rien à activer — c'est déjà le cas. Le réglage moteur
`Emulate Mouse From Touch` (Project Settings > Input Devices > Pointing) est **actif par défaut** et
n'a jamais été modifié dans ce projet : chaque tap tactile génère automatiquement un
`InputEventMouseButton` équivalent, donc toute l'UI de ce jeu (entièrement construite en `Button`/
`Control` standards) répond déjà à la souris ET au tactile simultanément, sans détection de
plateforme ni code séparé. Cette dépendance était déjà documentée et exploitée avant même cette
tâche, voir `card_reveal_overlay.gd` (`_on_card_gui_input`, "N'ecoute QUE InputEventMouseButton...

## Prénoms à la place des variantes, badge de classe sur les cartes (2026-09-03)

**Retour utilisateur** : les cartes affichaient un descriptif de variante ("Sauvage", "Siamois"...)
comme nom, pas un vrai prénom d'animal. 125 prénoms générés (`csv/prenoms_cartes.csv`, cohérents
avec l'espèce/la variante, ex. chat Sauvage → Grisou, requin Abyssal → Léviathan), puis la colonne
`nom` de `cards.csv` remplacée par ces prénoms (les 125 `.tres` de `data/card/resources/`
régénérés à la main en conséquence, `display_name` mis à jour). `NameLabel` affiche donc
automatiquement le prénom, aucun changement de code nécessaire côté pastille de nom.

En échange, la classe (CP-CM2) n'était plus lisible nulle part sur la carte (seule la couleur du
cadre la codait, implicitement). Ajout d'un `GradeBadge` en coin haut-gauche de `InnerPanel`,
par-dessus le portrait mais volontairement petit (34×42) pour ne pas le recouvrir. Première version :
un badge dessiné en code (`Panel` + `Label`, fond `frame_color` + texte "CP"/"CM2"...) - corrigée
dans la foulée, Steve voulait en fait les icônes médaille déjà existantes
(`assets/classe2.0/icones/badge-<CLASSE>.webp`, coin `C:\Users\Madmagics\Documents\#gimp\classe2.0\
icones` côté disque) : `GradeBadge` est maintenant un simple `TextureRect`, texture assignée via le
nouveau `GradeLevel.get_badge_icon_path()` (même convention que `get_coin_icon_path()`/
`get_coin_pile_icon_path()` - fichier déjà fini en couleur par classe, pas de `modulate`). Même règle
de découverte que le reste de la carte (cadre, nom, icône) : caché tant que `owned == false`, pour
ne pas révéler la classe avant l'obtention de la carte.
'Emulate Mouse From Touch'... fait qu'un tap genere DEJA un InputEventMouseButton emule").

**Ce qui a été retiré** — chaque raccourci clavier de ce projet avait déjà un équivalent souris/
tactile (bouton, icône de colonne), les deux faisaient donc doublon :

- Les 7 actions personnalisées de `project.godot` (`open_album`/`open_config`/`open_save`/
  `open_controls`/`open_stats`/`open_menu`/`open_inventory`, touches L/C/V/K/P/M/I) sont
  entièrement supprimées.
- Toutes les branches `is_action_pressed("ui_cancel")` (Echap pour fermer une fenêtre) sont
  retirées de `GameMenuPanel`, `ShopPanel`, `SuccessPanel`, `SubjectSelectPanel`, `CardAlbum`,
  `BackpackMenu`, `ParentalGateOverlay`, `QuestionPanel`, `CardRevealOverlay` (`ui_accept` aussi
  pour cette dernière) — chacune avait déjà une croix de fermeture cliquable.
- `CardAlbum` perd aussi la navigation aux flèches gauche/droite (`ui_left`/`ui_right`) —
  `PrevButton`/`NextButton` suffisaient déjà.
- **Section "Commandes" du menu entièrement supprimée** (`SectionControls`, bouton dédié dans
  `IconDock`, icône `control.webp`) : elle ne servait qu'à réassigner ces touches, elle n'a donc
  plus aucune utilité. Le menu de gauche passe de 5 à 4 rubriques (Configuration/Sauvegarde/
  Informations personnelles/Statistiques).
- `SaveManager` perd tout son système de réassignation clavier (`REBINDABLE_ACTIONS`,
  `custom_bindings`, `rebind_action()`, `get_binding_label()`, etc.) — la clé `custom_bindings` de
  `savegame.json` est désormais ignorée sans casser une sauvegarde plus ancienne qui la contiendrait
  encore.
- `ShortcutBadge` (pastille affichant la touche de la section active à côté du titre de
  `GameMenuPanel`) est retirée de `game_menu_panel.tscn` — plus rien à afficher sans raccourcis. Le
  `theme_type_variation` "ShortcutBadge" lui-même **reste** dans les 4 thèmes : toujours utilisé par
  `ProfSkinItem.PriceBadge` (voir l'entrée juste au-dessus).

**Seule exception ajoutée** : `ReadingIntroPanel` n'avait *aucun* moyen souris/tactile d'abandonner
avant de cliquer "Commencer" (seul Echap le permettait) — une croix de fermeture (`HeaderRow` +
`CloseButton`, même composant que `SubjectSelectPanel`/`QuestionPanel`) lui est ajoutée pour ne pas
perdre cette possibilité en retirant le raccourci.

**Ce qui n'a volontairement PAS été touché** : la saisie de texte au clavier (réponse libre dans
`QuestionPanel`, code du portail parental dans `ParentalGateOverlay`) reste inchangée — ce n'est
pas un "raccourci" mais une vraie saisie, qui fonctionne au clavier physique comme au clavier
virtuel tactile. Le focus-navigation natif de Godot (Entrée active un bouton qui a le focus, ex.
`confirm_button.grab_focus()` dans `ShopPanel`) n'a pas non plus été désactivé : une commodité
clavier native de l'engine, pas un raccourci codé par ce projet, qui ne gêne en rien le jeu 100%
souris/tactile.

## Cases de skins de prof : marge du portrait réduite (2026-09-03)

**Retour utilisateur** : "dans les cases passe la marge interieur de 20 a 10px et donc la taille
des images a 80px."

`SkinIcon` (portrait de `ProfSkinItem`) passe de 60×60 à 80×80px visible dans l'`InnerPanel` de
100×100 (marge de 20px ramenée à 10px sur les 4 côtés) — moins de fond crème visible autour du
portrait qu'avec le réglage du 2026-09-02.

## Floutage uniformisé sur les fenêtres questions/menus des PNJ (2026-09-04)

**Retour utilisateur** : "on va uniformiser le floutage arriere pour toutes les fenetres quand
celles ci sont actives. actuellement seuls les menus et fenetres de menus floute larriere plan,
je veux appliquer la meme chose aux questions et menus proposés par les npc."

Jusqu'ici, seules les fenêtres du menu de gauche (`GameMenuPanel`) et du dock droit
(`BackpackMenu` et ses 3 panneaux, via `BackpackBlurBG`) floutaient l'arrière-plan à l'ouverture.
`QuestionPanel`, `SubjectSelectPanel` et `ReadingIntroPanel` (le flux déclenché par un PNJ :
choix de matière, texte de lecture, questions) n'avaient aucun flou. Un nouveau `ColorRect`
`NpcBlurBG` est ajouté dans `game_ui.tscn`, tout premier enfant du `CanvasLayer` (donc sous les
trois panneaux), réutilisant le même `ShaderMaterial`/shader (`icon_dock_blur.gdshader`,
`blur_amount = 2.0`, `tint_color = Color(0, 0, 0, 0.4)`) que `BackpackBlurBG` — même rendu visuel
que le flou déjà en place. Chacun des trois panneaux reçoit un nouvel export `blur_bg_path`
(même pattern que `BackpackMenu.blur_bg_path`) branché sur `NpcBlurBG`, et bascule sa visibilité
dans son `_on_visibility_changed()` existant, en même temps que le verrouillage du joueur
(`PlayerInputLock`). Résultat : toute fenêtre active du jeu (menu, dock, ou fenêtre PNJ) floute
désormais l'arrière-plan de la même façon.

## Menus masqués + Échap pendant une session de questions (2026-09-04)

**Retour utilisateur** : "lorsque les questions sont ouvertes, il faut desactiver les 2 menus
(les masquer), la touche echap ou la croix permettent de quitter une session de questions en
cours, attention echap apres l apparition des resultats n invalidera pas la session mais quittera
simplement l ecran de correction."

`QuestionPanel` masque désormais `OpenMenuButton` (menu gauche) et `BackpackButton` (dock droit)
tant qu'il est visible — impossible d'ouvrir un des deux menus pendant une session de questions ;
ils réapparaissent à la fermeture du panneau (question interrompue, résultat fermé, ou joueur qui
s'éloigne du PNJ). La touche Échap devient une alternative à la croix pour quitter — seule fenêtre
du jeu à retrouver un raccourci clavier depuis la suppression générale du 2026-09-02, sur demande
explicite cette fois. Aucune distinction de code n'était nécessaire pour la nuance "Échap après
les résultats ne doit pas invalider la session" : la croix avait déjà ce comportement (la
récompense est versée dès l'affichage du récapitulatif, avant même que le joueur ferme la
fenêtre) — Échap appelle exactement la même fonction.

**Correctif (2026-09-04, même jour)** : "les icones de menu droit et gauche sont touours la quand
jouvre un menu npc." Le masquage n'avait été câblé que sur `QuestionPanel`, pas sur les deux
fenêtres qui précèdent la question elle-même dans le flux PNJ (`SubjectSelectPanel` — choix de
matière — et `ReadingIntroPanel` — texte de lecture) : les 2 icônes restaient donc visibles/
cliquables tant que le joueur n'était pas encore arrivé à l'écran de questions. Même export
`open_menu_button_path`/`backpack_button_path` ajouté à ces deux panneaux, avec le même
comportement dans leur `_on_visibility_changed()`.

## Bulle de dialogue BD au-dessus des PNJ (2026-09-05)

Nouvelle demande utilisateur : signaler à l'enfant que le PNJ a quelque chose à proposer, sans
repasser par un texte permanent style "Appuyer sur E". Quatre maquettes de bulle BD proposées
(queue triangle classique, queue "petits ronds" décroissants, bulle-pensée façon nuage, bulle
rectangulaire à coin coupé) — l'utilisateur valide l'option **petits ronds** : trois cercles crème/
encre décroissants entre la bulle et la tête du PNJ, plutôt qu'une pointe triangulaire classique.

Appliquée aux 5 PNJ d'un coup en l'ajoutant à la scène partagée `entities/npc_2d/npc_2d.tscn`
(`ui/speech_bubble/speech_bubble.tscn`, enfant direct de `NPC2D`) plutôt qu'aux 5 instances dans
`school.tscn` — même esprit que `QuestionGiverComponent`/`InteractableComponent` déjà dans la
scène de base. Reprend la palette `CardSlot` (`CREAM_COLOR` #FFF0D6, `INK_COLOR` #7A4A2B) et un
contour épais (3px sur la bulle, 1-2px sur les petits ronds) pour rester dans le style BD/cartoon
de la charte. Ancrage au-dessus de la tête : `SpeechBubble` retrouve son `ProfVisual` frère (même
technique "recherche par type" que `_find_sibling_interactable`/`_find_sibling_question_giver`) et
se positionne chaque frame à `ProfVisual.position - (0, demi-hauteur du sprite + marge)`, ce qui
suit aussi la respiration idle (`prof_visual.gd`) sans code supplémentaire. `ProfVisual` gagne au
passage un `class_name` (absent jusqu'ici) pour permettre ce `is ProfVisual`.

Cycle demandé : pause aléatoire 7 à 10 secondes (bulle cachée), puis affichage 5 secondes avec un
texte tiré au hasard, pop-in/pop-out animés (échelle + fondu) et un léger mouvement vertical
pendant l'affichage. Les durées sont re-tirées à chaque cycle (même principe que la respiration
par à-coups des PNJ) pour que les 5 bulles ne s'affichent jamais toutes ensemble.

**Pool de textes** : `csv/dialogue/npc_bubbles.csv` (20 lignes, `id;texte`), partagé par les 5 PNJ
via `data/dialogue/npc_bubble_pool.gd` (`NpcBubblePool`, membres `static`, un seul chargement du
csv au lieu de 5) — même lecteur `FileAccess.get_csv_line(";")` que `tools/admin/import_questions.gd`.

**Correctif largeur (2026-09-05, même jour)** : en jeu, le texte passait un mot par ligne (bulle
haute et étroite) — le `Label` sans largeur minimale se réduisait à quasi 0 (même mécanisme que le
badge non carré de `interact_prompt.gd`, voir plus haut). Ajout de `bubble_text_width` (200px,
réglable) forcé sur `custom_minimum_size.x` du `Label` en `_ready()`.

**Réglage des durées (2026-09-05, même jour, retour utilisateur)** : "on espace le temps
d'apparition des bulles de 20 secondes, apparition et disparition 200% plus lente." Pause entre
deux bulles portée de 7-10s à 27-30s (`cycle_pause_min`/`cycle_pause_max`, +20s). Animations
pop-in/pop-out multipliées par 3 (200% plus lent = durée x3) : fondu 0.18s→0.54s et 0.15s→0.45s,
échelle 0.22s→0.66s et 0.15s→0.45s.

**Textes par classe + matières, police réduite, ronds décalés (2026-09-05, même jour, retour
utilisateur)** : "modifie les dialogues pour specifier plus explicitement le niveau cp/ce1 etc de
chaque prof ainsi que les matieres proposées [...] diminue d'une taille la police [...] petit
decalage au niveau du placement des mini bulles, la petite fixe la moyenne decalee de 5px et la
3eme de 2px de plus." `csv/dialogue/npc_bubbles.csv` gagne une colonne `classe` (`id;classe;texte`,
libellés identiques à `GradeLevel.get_label`) ; les 20 textes sont réécrits par classe (4 par
classe) pour citer explicitement "le maître du CP"/"la maîtresse du CE1"/etc. et 1-2 matières
réellement proposées par ce PNJ (déduites de `QuestionGiverComponent.get_available_subjects` :
CP = mathématiques/français/anglais/lecture/logique ; CE1 à CM2 = mathématiques/grammaire/
conjugaison/orthographe/anglais/lecture/logique). `NpcBubblePool` groupe désormais les lignes par
classe (`_lines_by_grade`) au lieu d'un pool unique commun aux 5 PNJ ; `SpeechBubble` retrouve la
classe de son PNJ via son `QuestionGiverComponent` frère (même "recherche par type" que pour
`ProfVisual`) et interroge `NpcBubblePool.get_random_line(grade)`.

Police du `Label` de la bulle passée de 20 (taille par défaut du thème) à 16. Les 3 petits ronds de
la queue gagnent un décalage horizontal progressif plutôt qu'une colonne bien verticale : DotNear
fixe (0px), DotMid +5px, DotFar +7px (5+2) - légère diagonale montante façon vraie file de bulles
BD.

**Pause 15-30s (2026-09-05, même jour, retour utilisateur)** : "la pause entre les bulles doit
varier entre 15 et 30 secondes aleatoirement et durer 5 secondes" - `cycle_pause_min`/
`cycle_pause_max` repassés de 27-30s à 15-30s ; `show_duration` (5s) inchangé, déjà à cette valeur.

**100 textes, 20 par PNJ (2026-09-05, même jour, retour utilisateur)** : "dans le csv je veux
scinder les dialogues par npc, on va en faire 20 par npc [...] mettre en avant le fait de gagner
des pieces, des parties de dialogues reparties entre les npc doivent aussi proposer des
explications sur l'achat des tenues et des coffres de cartes." `csv/dialogue/npc_bubbles.csv`
passe de 20 à 100 lignes (20 par classe, `NpcBubblePool` groupait déjà par classe - voir plus haut
- aucun changement de code nécessaire). Chaque bloc de 20 : ~15 lignes matière par matière (toutes
celles réellement disponibles pour cette classe) insistant sur le gain de pièces à chaque bonne
réponse, puis 5 lignes reprises sur les 5 classes expliquant qu'on peut dépenser ses pièces à la
boutique pour des tenues de prof et des coffres de cartes - texte identique aux libellés utilisés
dans `ui/shop/` ("tenue", `prof_skin_item.gd` ; "coffre", `crate_item.gd`/onglet "Cartes").

**Correction du genre des profs (2026-09-05, même jour, retour utilisateur)** : "cp/ce2 et cm2 sont
des maitresses et ce1/cm1 sont des maitres" - inverse le genre fixé jusqu'ici (CP/CE2/CM2 maître,
CE1/CM1 maîtresse). Corrigé aux deux endroits où ce genre est écrit en dur : les 100 lignes de
`csv/dialogue/npc_bubbles.csv` (relu et réaccordé ligne par ligne, pas un simple remplacement de
mot - "le"/"la" et majuscules de début de phrase suivent), et `_GRADE_TEACHER_TITLES` dans
`question_giver_component.gd` (titre affiché sur le bouton d'interaction central) qui utilisait le
même genre par classe et serait sinon resté en contradiction avec les bulles.

**Une seule bulle à la fois, rotation par tour de 10s (2026-09-05, même jour, retour utilisateur)** :
"je veux eviter que 2 bulles n'arrivent en meme temps, retravaille le systeme pour que les bulles
s affichent a tour de role au hasard pendant 10 secondes puis apparaissent au professeur suivant."
Avant cette date, chaque `SpeechBubble` tirait sa propre pause aléatoire indépendamment des 4
autres PNJ : deux bulles pouvaient donc apparaître en même temps par pur hasard. Remplacé par un
nouvel autoload `NpcBubbleScheduler` (`autoload/npc_bubble_scheduler.gd`) qui centralise le tour de
rôle : chaque `SpeechBubble` s'enregistre à son `_ready()` (même principe "le composant se fait
connaître" que le reste du projet, pas un chemin de scène codé en dur dans l'autoload) ; une seule
coroutine (`_run_loop`, démarrée au premier enregistrement) choisit un PNJ au hasard parmi les
enregistrés - jamais deux fois de suite le même s'il y en a plusieurs -, attend la fin complète de
son `show_bubble()` (pop-in), laisse la bulle visible 10 secondes (`TURN_DURATION`), attend la fin
complète de son `hide_bubble()` (pop-out) avant de passer au suivant : à aucun instant deux bulles
ne peuvent être visibles en même temps, contrairement à un enchaînement `hide()`/`show()` non
attendu. `speech_bubble.gd` perd sa machine à états interne (`cycle_pause_min/max`, `show_duration`,
`_time_until_next_show`) : il n'expose plus que `show_bubble()`/`hide_bubble()`, pilotées par le
scheduler ; `_process` ne garde que le suivi de la tête du PNJ et le mouvement idle pendant
l'affichage.

## Livre des animaux : retour au chrome standard, cartes réduites, flèches agrandies (2026-09-03)

**Retour utilisateur** : "on va modifier le style du livre, on reprend le design des autres
fenetres en ce qui concerne les bordures et les coins arrondis de meme que le titre et la ligne de
separation. diminue la taille des cartes de 5% et recentre la ligne de carte. de plus enleve le
cadre autour des icones fleches et augmente leur taille de 200%" — referme le point "à refondre
plus tard" laissé ouvert par l'entrée d'uniformisation du 2026-08-29.

- **Chrome standard** : `AtlasBackground` (fond parchemin dessiné à la main, taches d'ancienneté,
  double liséré, fleurons d'angle) retiré de `card_album.tscn`. Il repeignait tout le `Panel` en
  opaque par-dessus le style du `Theme` (fond crème + bordure 4px + coins arrondis 20px, partagé
  avec `ShopPanel`/`SuccessPanel`) — en le retirant, ce style standard redevient visible sans code
  supplémentaire. `TitleUnderline` (soulignement double dessiné à la main) remplacé par un simple
  `HSeparator` (même node que `ShopPanel.TitleSeparator`, style déjà fourni par le `Theme`).
  `atlas_background.gd`/`title_underline.gd` supprimés (plus aucun appelant). `TitleBlock` remonté
  (offset_top 28→10, offset_bottom 100→80) : la bordure standard de 4px n'a plus besoin de la
  marge de sécurité qu'exigeait le double liséré du parchemin (~17-20px).
- **Cartes réduites de 5%** : toutes les constantes de `CardSlot` (taille, cadre, rayons, hauteur
  de pastille, ombre) et les offsets correspondants de `card_slot.tscn` multipliés par 0,95 — même
  principe que le passage ×1,5 du 2026-07-26, le design ne change pas, seule l'échelle change. La
  ligne de cartes reste centrée automatiquement (`CenterContainer`, déjà en place).
- **Flèches Précédent/Suivant** : `flat = true` (retire le fond/la bordure de bouton du `Theme`, ne
  laisse que l'icône) et taille +200% (40×30 → 120×90) — voir `card_album.gd` pour le détail des
  repositionnements de `OptionsBar`/`ScrollContainer` que ça entraîne pour ne rien chevaucher.

## Livre des animaux : séparateur pleine largeur + livre vide à la première ouverture (2026-09-05)

**Retour utilisateur** (avec capture d'écran) : "2 corrections, la ligne de separation nest pas la
meme que les autres fenetres, check difference il faut que ca touche le cadre de la fenetre. 2e:
quand on ouvre le livre pour la premiere fois dans le jeu, il ny a aucune carte affichee, corrige
pour afficher les cartes des la premiere ouverture".

- **Séparateur pleine largeur** : le passage du 2026-09-03 ci-dessus avait bien remplacé
  `TitleUnderline` par un `HSeparator` standard, mais celui-ci était resté un enfant de
  `TitleBlock` (un `VBoxContainer` avec 20px de marge gauche/droite hérités du fond parchemin) —
  il n'atteignait donc jamais les bords du `Panel`, contrairement à `ShopPanel.TitleSeparator`
  (enfant direct de `Panel`, sans marge gauche/droite). Fix : `TitleBlock` supprimé, `TitleRow`/
  `TitleSeparator`/`CategoryLabel` deviennent des enfants directs de `Panel` avec des offsets fixes
  identiques à `ShopPanel` (`TitleSeparator` : `anchors_preset=10`, `offset_top=55`/`bottom=59`,
  aucun offset gauche/droite → pleine largeur). `card_album.gd` mis à jour en conséquence
  (`title_icon`/`category_label`).
- **Livre vide à la première ouverture** : bug distinct du bug homonyme du 2026-07-26 déjà corrigé
  (celui-ci portait sur `visible=false` au démarrage). Ici, `_load_pages()` n'était appelé qu'une
  fois dans `_ready()` (au chargement de la scène, avant que le joueur ait obtenu la moindre carte)
  et par `_on_card_added()` — mais seulement `if visible`, donc jamais pendant que le livre est
  fermé (le cas normal : le joueur obtient des cartes en jouant, livre fermé). `open()` ne rappelait
  que `_refresh()` : il réaffichait donc `_pages` tel que figé à `_ready()`, potentiellement vide ou
  périmé, sans jamais le recalculer avec la collection actuelle. Ce bug ne se voyait pas avant le
  passage aux filtres du 2026-09-03 (`FilterMode.OWNED_ONLY` par défaut) : avec l'ancien
  affichage "toutes les cartes", les pages ne dépendaient jamais de la collection, seul l'état
  possédé/non-possédé de chaque case (lu à chaque `_refresh()`) changeait. Fix : `open()` appelle
  désormais `_load_pages()` avant `_refresh()`, comme `_reload_and_refresh()`.

## Livre des animaux : zoom sur une carte (2026-09-05)

**Retour utilisateur** : "lorsque on clique sur une carte, je veux quelle apparaisse avec une
taille de 200% au centre de l'ecran avec le fond flouté, un 2eme click sur la carte ou ECHAP
permet de revenir au livre. Le but est de pouvoir voir la carte et l'observer en grand."

- Un clic sur n'importe quelle case de la grille instancie une deuxième `CardSlot` (même carte,
  même quantité) centrée sur l'écran et mise à l'échelle ×2 (`ZOOM_SCALE`).
- Fermeture par un second clic sur la carte agrandie, ou par **Échap** — troisième exception au
  principe "souris/tactile uniquement" du 2026-09-02, avec `QuestionPanel._abort_pack` et
  `QuitOverlay`, demandée explicitement ici par Steve.
- **Flou EXTERNE, partagé avec la colonne `BackpackMenu`** (retour utilisateur suivant : "cest le
  livre qui reapparait en fond et est floute, le menu de droite doit apparaitre aussi et doit etre
  floute au meme titre que le livre") : la première version utilisait un `ZoomBlurBG` local à
  `card_album.tscn`, incapable de flouter `BackpackMenu` (colonne de droite, nœud séparé placé
  après `CardAlbum` dans `game_ui.tscn`, donc dessiné par-dessus lui). Fix : le flou déménage dans
  `game_ui.tscn` (`CardZoomBlurBG`, `ColorRect` placé après `BackpackMenu`, même shader
  `icon_dock_blur.gdshader` et même `SubResource` que `NpcBlurBG`/`BackpackBlurBG`) — en capturant
  l'écran juste derrière lui, il floute d'un coup le livre ET la colonne, déjà tous deux dessinés à
  ce stade. La `CardSlot` zoomée est ajoutée comme enfant de ce même `ColorRect` (pas de
  `CardAlbum`) pour rester elle aussi au-dessus. `zoom_blur_bg_path` (NodePath, assigné dans
  `game_ui.tscn`) remplace l'ancien nœud local. Bloque au passage les clics vers `BackpackMenu`
  pendant le zoom (un trou qui existait déjà avec l'ancien `ZoomBlurBG` local).

## Infobulles thémées (2026-09-06)

**Retour utilisateur** : "concernant les infobulles au survol des elements clickables, actuellement
le survol montre une ecriture foncée sur fond semi transparent sans bordure, propose moi quelque
chose ici de plus visible sadaptant aux themes proposés."

Les infobulles (`tooltip_text`, déjà posées sur une dizaine de boutons — icônes du menu,
pagination du livre, etc.) utilisaient jusqu'ici le thème moteur par défaut de Godot (non
recouvert par aucun des 4 thèmes du jeu) : fond gris foncé semi-transparent, texte sombre, aucune
bordure — peu lisible et hors charte. Chacun des 4 fichiers de thème (`game_theme.tres`,
`theme_bonbon.tres`, `theme_sombre.tres`, `theme_tropical.tres`) reçoit désormais un style
`TooltipPanel`/`TooltipLabel` dédié, construit sur le même langage visuel que les boutons du
thème : fond opaque à la couleur "normale" du bouton de ce thème (jaune pour Fête foraine, rose
pour Bonbon, doré pour Sombre, vert d'eau pour Tropical), bordure encre de 3px, coins arrondis à
10 (cohérent avec les cases/boutons), texte dans la même couleur d'encre que le texte des boutons
de ce thème (déjà validée comme lisible sur ce fond). Chaque thème garde donc sa propre identité
sur l'infobulle, comme partout ailleurs dans l'UI.

## Écran d'intro : thème fixe "Fête foraine" + musique de base (2026-09-06)

**Retour utilisateur** : "pour l ecran dintro je veux que le theme de couleur soit fixe et ne varie
pas de 'fete foraine', des le log in dans un compte, le theme du compte prend effet, on laissera
aussi la musique de base pour l intro et on passera a la musique debloquee et choisie par le
compte sil y en a une."

Le thème d'interface (les 4 variantes, voir "Themes multiples" plus haut) était jusqu'ici un
réglage d'appareil partagé par tous les comptes : l'écran d'accueil (`WelcomePanel`) pouvait donc
hériter du thème choisi par le dernier compte utilisé, au lieu de rester toujours sur "Fête
foraine". C'est désormais un réglage propre à chaque compte (voir ARCHITECTURE.md pour le détail
technique) : l'écran d'accueil affiche systématiquement "Fête foraine", et le thème choisi par le
compte connecté ne prend effet qu'après connexion — retour à "Fête foraine" à la déconnexion. Même
principe côté musique : l'écran d'accueil garde toujours la musique de base (`lofi.ogg`), la
musique de classe débloquée et activée par le compte (onglet Succès de la boutique, voir
ARCHITECTURE.md) prend le relais une fois connecté, si elle a été fournie.

## Reste à faire

- Reste de la série d'icônes (une par rareté de coffre au minimum) à faire une fois ce premier
  jet definitivement approuvé en jeu.
- Art des cartes (`data/card/art/`) : toujours en attente, voir `project_card_art_spec.md`.
- Une fois plusieurs écrans testés en jeu, ajuster au besoin épaisseur des contours/rayon des
  coins dans `ui/theme/game_theme.tres` (un seul fichier à modifier, pas de re-câblage scène par
  scène).
