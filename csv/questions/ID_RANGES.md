# Tranches d'ID des questions

Registre à tenir à jour à la main : chaque fichier CSV sous `csv/questions/` reçoit une
tranche **dédiée de 1000 id** (jusqu'à 1000 questions par fichier), attribuée dans l'ordre de
création des fichiers — pas par matière/classe. Avant de créer un nouveau fichier CSV, regarder
la dernière tranche utilisée ci-dessous et prendre la suivante (+1000).

Format de tranche : `Nx000` à `Nx999` (ex. 3e fichier → 3000-3999).

## Tranches attribuées

| # | Fichier CSV | Tranche ID | Lignes actuelles |
|---|---|---|---|
| 2 | `cp/math/generated.csv` | 2000-2999 | 500 (utilise 1001-1190 hérité + 2000-2309) |
| 3 | `ce1/math/generated.csv` | 3000-3999 | 1000 (utilise 1201-1400 hérité + 3000-3799) |
| 4 | `ce2/math/generated.csv` | 4000-4999 | 1000 (utilise 1401-1600 hérité + 4000-4799) |
| 5 | `cm1/math/generated.csv` | 5000-5999 | 1000 (utilise 1601-1800 hérité + 5000-5799) |
| 6 | `cm2/math/generated.csv` | 6000-6999 | 1000 (utilise 1801-2000 hérité + 6000-6799) |
| 8 | `cp/french/generated.csv` | 8000-8999 | 190 |
| 9 | `ce1/grammaire/` + `ce1/conjugaison/` + `ce1/orthographe/` (ex `ce1/french/`) | 9000-9999 (partagée par les 3, voir note) | 86 + 67 + 47 = 200 |
| 10 | `ce2/grammaire/` + `ce2/conjugaison/` + `ce2/orthographe/` (ex `ce2/french/`) | 10000-10999 (partagée) | 83 + 40 + 77 = 200 |
| 11 | `cm1/grammaire/` + `cm1/conjugaison/` + `cm1/orthographe/` (ex `cm1/french/`) | 11000-11999 (partagée) | 57 + 42 + 101 = 200 |
| 12 | `cm2/grammaire/` + `cm2/conjugaison/` + `cm2/orthographe/` (ex `cm2/french/`) | 12000-12999 (partagée) | 57 + 37 + 106 = 200 |

**Tranches retirées (fichier supprimé, blocs non réutilisés — voir règle 2 ci-dessous) :**
1 (1000-1999, `math/cp/base.csv`), 7 (7000-7999, `french/cp/base.csv`) — supprimés le
2026-07-19 pour n'avoir qu'un seul CSV par classe (voir "État" plus bas).

**Recatégorisation du 2026-07-20 (grammaire) puis re-split (grammaire/conjugaison/orthographe) :**
`ce1/french/generated.csv` (tranche 9000-9999) est d'abord devenu `ce1/grammaire/generated.csv`
dans son intégralité, puis a été re-scindé en 3 fichiers le jour même (le français devait de
toute façon se découper en Grammaire/Conjugaison/Orthographe pour CE1 et les classes suivantes,
voir `MATIERES_CANDIDATES.md`) : `ce1/grammaire/` (accords, nature des mots), `ce1/conjugaison/`
(conjugue-t-on), `ce1/orthographe/` (reste : contraire/synonyme/homophones/divers). Même
traitement appliqué à `ce2/french/`, `cm1/french/` et `cm2/french/`. **Exception au principe
"un fichier = une tranche dédiée"** : ces 3×4 nouveaux fichiers se partagent la tranche d'id de
leur ancien fichier `french` d'origine plutôt que d'en recevoir chacun une neuve — un id garde
la valeur qu'il avait dans le fichier `french` d'origine, seul son dossier (donc sa matière)
change. Pas de nouvelle tranche consommée par cette opération.

*Incident du 2026-07-20 :* un bug de script a supprimé par erreur les 86 lignes/`.tres`
`ce1/grammaire` lors du premier passage de split (le dossier de destination "grammaire"
coïncidait avec le dossier source, écrasé par le nettoyage de fin de script). Récupéré à
l'identique en relançant `generate_questions.py` (seed fixe = sortie déterministe, vérifié
byte-à-byte contre les 114 lignes `conjugaison`/`orthographe` restantes avant de faire confiance
au reste). Aucune perte finale, mais leçon retenue : ne plus jamais faire coïncider un dossier
source et un dossier de destination dans un même script de réorganisation sans un garde-fou
explicite (`if src_dir == dest_dir: skip cleanup`).

**Réorganisation du 2026-07-20 :** l'arborescence est passée de `<matière>/<classe>/` à
`<classe>/<matière>/` (ex. `math/cp/generated.csv` → `cp/math/generated.csv`), pour permettre
de nouvelles matières qui n'existent qu'à partir de certaines classes (ex. anglais dès le CE1)
sans dossier vide dans les classes plus basses. Les tranches d'id ne changent pas (règle 2) :
seul le chemin affiché ci-dessus est mis à jour. `tools/admin/import_questions.gd` a été adapté
en conséquence.

| 13 | `cp/lecture/generated.csv` | 13000-13999 | 11 (1 passage + 10 questions, Milo le chat) |
| 14 | `ce1/lecture/generated.csv` | 14000-14999 | 21 (1 passage + 20 questions, Milo le chat) |
| 15 | `ce2/lecture/generated.csv` | 15000-15999 | 21 (1 passage + 20 questions, Milo le chat) |
| 16 | `cm1/lecture/generated.csv` | 16000-16999 | 21 (1 passage + 20 questions, Milo le chat) |
| 17 | `cm2/lecture/generated.csv` | 17000-17999 | 21 (1 passage + 20 questions, Milo le chat) |

| 18 | `cp/english/generated.csv` | 18000-18999 | 40 |
| 19 | `ce1/english/generated.csv` | 19000-19999 | 55 |
| 20 | `ce2/english/generated.csv` | 20000-20999 | 65 |
| 21 | `cm1/english/generated.csv` | 21000-21999 | 75 |
| 22 | `cm2/english/generated.csv` | 22000-22999 | 85 |

| 23 | `cp/lecture/histoires_generated.csv` | 23000-23999 | 47 histoires (1 passage + 10 questions chacune) |
| 24 | `ce1/lecture/histoires_generated.csv` | 24000-24999 | 47 histoires (1 passage + 20 questions chacune) |
| 25 | `ce2/lecture/histoires_generated.csv` | 25000-25999 | 47 histoires (1 passage + 20 questions chacune) |
| 26 | `cm1/lecture/histoires_generated.csv` | 26000-26999 | 47 histoires (1 passage + 20 questions chacune) |
| 27 | `cm2/lecture/histoires_generated.csv` | 27000-27999 | 47 histoires (1 passage + 20 questions chacune) |

**Prochaine tranche libre : 28000-28999** (28e fichier).

**Banque de 47 histoires par classe (2026-07-30) :** extension majeure de la matière
"Comprehension de texte" — 47 nouveaux themes (vacances, sorties scolaires, mer, montagne,
famille, fete foraine, etc.) declines chacun en 5 versions (CP a CM2, meme trame narrative,
difficulte croissante selon l'algorithme Kandel-Moles, prenoms europeens varies). Fichier
distinct de `generated.csv` (qui reste dedie a l'histoire "Milo le chat", desormais enrichie a
10 questions en CP et 20 en CE1-CM2, voir plus bas) : un fichier = une tranche dediee (regle 2),
d'ou les tranches 23000-27999 ci-dessus plutot qu'un ajout dans les tranches 13000-17999 deja
attribuees a `generated.csv`. Quotas qtype par classe : CP 10 questions 100% L ; CE1 20 questions
16L/2V/2I ; CE2 20 questions 12L/4V/4I ; CM1 20 questions 8L/6V/6I ; CM2 20 questions 6L/6V/8I.
Au tirage en jeu, une histoire piochee dans le pool selectionne un sous-ensemble de questions
parmi celles disponibles (voir `LECTURE_DIFFICULTE.md`). Non encore importe en `.tres` (a faire
via `tools/admin/import_reading.gd` dans l'editeur Godot, non disponible dans cette session).
Resultats de validation lisibilite (bande stricte Kandel-Moles par classe, voir tableau
`TARGETS` dans `check_reading.py`) : CP 32/47, CE1 2/47, CE2 14/47, CM1 7/47, CM2 6/47 histoires
dans la bande stricte visee. Toutes les histoires sont neanmoins structurellement valides (bon
nombre de questions, quota qtype exact, pas de doublon d'id) - seul le score de lisibilite
Kandel-Moles s'ecarte de la cible sur une partie du contenu, notamment aux classes intermediaires
ou le style d'ecriture a derive vers des phrases plus longues/complexes au fil de la redaction.
Ecart signale explicitement plutot que corrige retroactivement (consigne utilisateur : "on
continue tel quel"). Le mot-compte reste lui globalement dans la fourchette attendue (quelques
histoires CE2 legerement sous la borne basse de mots).

**Lecture (2026-07-20) :** format de fichier différent des autres matières (colonnes
`id;type;text;correct_answer;choice_2;choice_3;choice_4;passage_id;qtype`, une question est
toujours liée à un texte, `qtype`=L/V/I trace le type pédagogique de la question) — voir
`LECTURE_DIFFICULTE.md` à la racine du projet pour le détail. Algorithme de difficulté (texte
+ répartition des types de question par classe) validé par l'utilisateur. Contenu actuel = un
seul texte par classe (histoire "Milo le chat"), pas encore importé dans Godot (pas de
`PassageResource`/PNJ dédié) — la génération à l'échelle suivra une fois le système branché.

**Regeneration Grammaire/Conjugaison/Orthographe CE2-CM1-CM2 (2026-07-21) :** contenu signale par
l'utilisateur comme quasi identique d'une classe a l'autre (meme banque de verbes/mots recyclee
sans jamais differencier la difficulte). Entierement regenere selon un nouveau scope de difficulte
par classe + un mecanisme de "pack de revision" qui pioche aussi dans les classes anterieures a
chaque pack - voir `FRANCAIS_DIFFICULTE.md` a la racine du projet pour le detail complet. CE1 non
touche (deja conforme). Tranches d'id inchangees (9000/10000/11000/12000, regle 2 - un fichier
garde sa tranche), seul le contenu a l'interieur a change.

**Correction accents/orthographe/grammaire, tous CSV (2026-07-21) :** l'utilisateur a signalé
l'absence totale d'accents dans tout le contenu (hérité de la convention "sans accents pour
rester simple à taper au clavier", devenue caduque une fois le jeu en QCM). Passe complète sur
les 28 `generated.csv` (toutes classes/matières, y compris `lecture/`) : accents restaurés
(dictionnaire construit à partir de `pyspellchecker` fr + résolution manuelle des cas ambigus),
élisions corrigées (`je`/`que`/`de` + voyelle), confusions homophones corrigées (`a`/`à`, `ou`/
`où`, `la`/`là`), auxiliaires être/avoir et accords de participe passé corrigés dans les exercices
de conjugaison, et cohérence des distracteurs améliorée dans les questions de synonymes/contraires
(catégorie grammaticale homogène plutôt que mots sans rapport). Tous les `.tres` correspondants
régénérés directement depuis les CSV corrigés (éditeur Godot non disponible dans cette session).
Aucune tranche d'id modifiée. Voir `ARCHITECTURE.md` pour la nouvelle convention (accents
obligatoires partout, plus jamais de contenu français sans accent).

**Anglais (2026-07-20) :** vocabulaire fr<->en par champ lexical, introduit dès le CP et étendu
à toutes les classes (voir `MATIERES_CANDIDATES.md`). Format standard (une ligne = une question),
importable directement par `tools/admin/import_questions.gd` (dossier `english/`, voir
`SUBJECT_FOLDERS`). 320 questions générées et `.tres` déjà écrits directement (cp 40, ce1 55,
ce2 65, cm1 75, cm2 85).

**Extension Maths CP à 500 questions (2026-07-31) :** les 190 questions d'origine (ids
1001-1190, ancienne numérotation héritée de `math/cp/base.csv`, jamais renumérotée — voir "État
au 2026-07-19" plus bas) sont conservées telles quelles ; 310 nouvelles questions ajoutées à la
suite dans le même fichier, avec les ids 2000-2309 puisés dans la tranche 2000-2999 déjà réservée
pour ce fichier (règle 3 : une tranche reste disponible pour agrandir un fichier existant sans
tranche neuve). Répartition par type : calcul à trous addition 2-3 termes (70, ex. "10 + 10 + 10
+ ___ = 50"), calcul à trous soustraction (39), comparaison plus grand/plus petit sur des nombres
< 100 (40, 2 choix seulement — voir règle QCM binaire dans `ARCHITECTURE.md`), nombre juste avant/
juste après (35), suites numériques à trous par bonds de 2/5/10 (34), problèmes simples en
contexte (35, prénoms européens variés), pair ou impair (20, 2 choix), dizaines et unités
complémentaire (20), formes géométriques - nombre de côtés (7, une question par forme :
triangle/carré/rectangle/rond/losange/pentagone/cercle), doubles/moitiés complémentaire (10).
Généré par script Python (seed fixe, non conservé dans le projet) avec vérifications automatiques
avant intégration : unicité des ids et des textes, exactitude arithmétique de chaque calcul à
trous, respect strict de la règle "2 choix seulement" pour les questions binaires (aucune cellule
`choice_3`/`choice_4` remplie), densité d'accents cohérente avec le reste du contenu mathématique
(~1%, attendu vu la faible part de texte français dans ce type de contenu — voir
`feedback_missing_accents_2026_07_31`). **À cette occasion**, les 25 questions "plus grand/plus
petit" déjà existantes (ids 1146-1170) ont aussi été corrigées au format 2 choix (elles avaient 2
distracteurs inventés en trop, en contradiction avec la règle validée le 2026-07-31) — voir
[[feedback_binary_choice_backlog]] pour le reste du travail de conversion encore en attente sur
les autres classes/matières.

**Extension Maths CE1/CE2 à 1000 questions chacun (2026-08-01) :** même principe que l'extension
CP (voir note ci-dessus) — les 200 questions d'origine de chaque fichier (ids 1201-1400 pour CE1,
1401-1600 pour CE2) sont conservées telles quelles, 800 nouvelles questions ajoutées à chacune
dans les tranches déjà réservées : 3000-3799 pour CE1, 4000-4799 pour CE2 (chaque tranche garde
200 id de marge pour une extension future). Difficulté adaptée par classe (nombres à 3 chiffres
pour CE1, 4 chiffres pour CE2). Tables de multiplication ajoutées comme demandé, également
adaptées par classe : CE1 se limite aux tables de 2, 5 et 10 (introduction, programme officiel
CE1) avec deux formulations différentes pour varier le texte des questions ; CE2 couvre la table
complète 1 à 10 (100 combinaisons uniques a×b, programme officiel CE2 — "jusqu'à 10x10"). Autres
types ajoutés aux deux classes (mêmes catégories, valeurs adaptées à l'échelle de chaque classe) :
calcul à trous addition/soustraction, moitié/tiers/quart, comparaison plus grand/plus petit (2
choix), problèmes en contexte (argent, achète+donne combinés), complément à un multiple de 10
(CE1) ou suites numériques par bonds de 100/1000 (CE1 par bonds de 10/50/100), périmètre de
rectangle, pair ou impair (2 choix). CE2 ajoute en plus une division simple (résultat entier,
diviseurs 2 à 10). Généré et vérifié avec la même méthode que l'extension CP (script Python seed
fixe non conservé, vérifications d'unicité d'id/texte, exactitude arithmétique programmatique,
respect strict de la règle 2-choix, densité d'accents coherente ~1.5-2% pour du contenu
majoritairement numérique). **À cette occasion**, les questions "plus grand/plus petit"
préexistantes ont aussi été corrigées au format 2 choix : 25 lignes CE1 (ids 1336-1360), 10 lignes
CE2 (ids 1591-1600) — voir [[feedback_binary_choice_backlog]], qui reste à traiter pour CM1/CM2
math et les autres matières.

**Extension Maths CM2 à 1000 questions (2026-08-01) :** même principe que CP/CE1/CE2 (voir notes
ci-dessus) — les 200 questions d'origine (ids 1801-2000) conservées telles quelles, 800 nouvelles
ajoutées avec les ids 6000-6799 (tranche 6000-6999 déjà réservée, 200 id de marge restants).
Contrairement à CP/CE1/CE2, le fichier CM2 d'origine ne contenait déjà aucune question binaire
("plus grand/petit", "pair/impair") à corriger — rien à faire de ce côté. Catégories étendues à
partir des types déjà présents dans le fichier (addition/soustraction décimale, multiplication à
2 chiffres, division avec quotient et reste, pourcentages 10/25/50/75%, fractions de même
dénominateur, conversion fraction→décimale, proportionnalité, vitesse/distance, aire de
rectangle, volume de pavé droit, conversion d'unités élargie à g/kg et cl/l en plus de km/m,
valeur de position dans un grand nombre à 9 chiffres) + une catégorie de révision "table de
multiplication complète 1 à 10" (60 questions, dans la continuité du thème tables ajouté à CE1/
CE2, même si le programme CM2 suppose les tables déjà acquises). Vérifications identiques aux
extensions précédentes : unicité id/texte (y compris contre les 200 lignes héritées), exactitude
arithmétique de chaque catégorie validée programmatiquement (addition/soustraction décimale en
centimes pour éviter les erreurs d'arrondi flottant, quotient/reste, pourcentage, fraction,
proportionnalité, vitesse, aire, volume, conversions, valeur de position), densité d'accents
cohérente (~0.9%, contenu très numérique). Voir `project_cm2_math_1000` en mémoire.

**Extension Maths CM1 à 1000 questions (2026-08-01) :** dernière des 5 classes à passer par cette
extension (CP, CE1, CE2, CM2 déjà faits — voir notes ci-dessus), même principe. Les 200 questions
d'origine (ids 1601-1800) conservées telles quelles, 800 nouvelles ajoutées avec les ids
5000-5799 (tranche 5000-5999 déjà réservée, 200 id de marge restants). Catégories étendues à
partir des types déjà présents (multiplication à 2 chiffres, division avec quotient et reste,
comparaison de fractions, fractions de même dénominateur, fraction d'un nombre, comparaison de
décimaux, addition décimale, conversion d'unités élargie à mm/cl en plus de cm/g/min, aire de
rectangle, proportionnalité, valeur de position dans un nombre à 6 chiffres) + deux ajouts :
soustraction décimale (miroir de l'addition déjà présente) et périmètre de rectangle (présent en
CE1/CE2 mais absent de CM1 jusqu'ici). **À cette occasion**, deux types de questions binaires
préexistants ont été corrigés au format 2 choix : "quelle fraction est la plus grande" (20 lignes,
ids 1661-1680) et "quel nombre est le plus grand" sur des décimaux (15 lignes, ids 1711-1725) —
35 lignes au total, voir [[feedback_binary_choice_backlog]], qui est maintenant soldé pour les 5
classes de maths (plus aucune question binaire à 4 choix connue dans cp/ce1/ce2/cm1/cm2/math).
Mêmes vérifications que les extensions précédentes (unicité id/texte y compris contre les 200
lignes héritées, exactitude arithmétique programmatique sur toutes les catégories, densité
d'accents cohérente ~0.6%, contenu très numérique).

## État au 2026-07-19

Chaque classe n'a maintenant plus qu'**un seul fichier CSV** (`generated.csv`) : les
`base.csv` de `math/cp` et `french/cp` (10 questions chacun, id 1-20) ont été supprimés pour
harmoniser la structure — toutes les classes suivent maintenant le même schéma "un fichier par
classe". Consequence : `math/cp` et `french/cp` n'ont que 190 questions contre 200 pour les
8 autres classes (écart mineur, à combler plus tard si besoin en ajoutant 10 lignes à ces deux
`generated.csv`, en piochant dans la tranche 2000-2999 / 8000-8999 déjà attribuée).

La numérotation cible ci-dessus n'est pas encore appliquée dans les CSV, qui utilisent encore
l'ancien découpage par matière/classe (blocs 1001-1190, 1201-1400... voir historique Git). Les
`.tres` correspondants dans `data/question/resources/` ont été purgés : une fois les CSV
renumérotés selon la table ci-dessus, relancer `tools/admin/import_questions.gd` (File > Run dans
l'éditeur Godot) pour régénérer les ressources avec les nouveaux id. Aucun autre câblage à
toucher : `QuestionGiverComponent` scanne tout `data/question/resources/` automatiquement (voir
`ARCHITECTURE.md`).

## Règle pour la suite

1. Nouveau fichier CSV = nouvelle ligne dans la table ci-dessus, tranche = dernière tranche + 1000.
2. Ne jamais réutiliser/décaler une tranche déjà attribuée à un fichier existant, même si le
   fichier est renommé ou déplacé (même logique que les id de `cards.csv` : stabilité une fois
   assignée).
3. Un fichier peut contenir moins de 1000 lignes (ex. `base.csv`, 10 lignes) : la tranche reste
   quand même réservée en entier pour cette page, pour permettre d'y ajouter jusqu'à 1000 lignes
   plus tard sans recréer de fichier.
