# Tranches d'ID des questions

Registre à tenir à jour à la main : chaque fichier CSV sous `csv/questions/` reçoit une
tranche **dédiée de 1000 id** (jusqu'à 1000 questions par fichier), attribuée dans l'ordre de
création des fichiers — pas par matière/classe. Avant de créer un nouveau fichier CSV, regarder
la dernière tranche utilisée ci-dessous et prendre la suivante (+1000).

Format de tranche : `Nx000` à `Nx999` (ex. 3e fichier → 3000-3999).

## Tranches attribuées

| # | Fichier CSV | Tranche ID | Lignes actuelles |
|---|---|---|---|
| 2 | `cp/math/generated.csv` | 2000-2999 | 1000 (utilise 1001-1190 hérité + 2000-2809) |
| 3 | `ce1/math/generated.csv` | 3000-3999 | 1000 (utilise 1201-1400 hérité + 3000-3799) |
| 4 | `ce2/math/generated.csv` | 4000-4999 | 1000 (utilise 1401-1600 hérité + 4000-4799) |
| 5 | `cm1/math/generated.csv` | 5000-5999 | 1000 (utilise 1601-1800 hérité + 5000-5799) |
| 6 | `cm2/math/generated.csv` | 6000-6999 | 1000 (utilise 1801-2000 hérité + 6000-6799) |
| 8 | `cp/french/generated.csv` | 8000-8999 | 1000 (500 hérités en 2000-2500 + 500 nouvelles en 8000-8499, voir note 2026-08-07 ci-dessous) |
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

| 18 | `cp/english/generated.csv` | 18000-18999 | 519 (2026-08-04 : vocabulaire programme CP + phrases I like/I'm/consignes) |
| 19 | `ce1/english/generated.csv` | 19000-19999 | 569 (2026-08-04 : vocabulaire cumulé CP+CE1 + can/can't, prépositions, I have N) |
| 20 | `ce2/english/generated.csv` | 20000-20999 | 505 (2026-08-04 : + there is/are, I prefer, l'heure, emploi du temps) |
| 21 | `cm1/english/generated.csv` | 21000-21999 | 507 (2026-08-04 : + comparatifs/superlatifs, must/mustn't, démonstratifs, pays/langues) |
| 22 | `cm2/english/generated.csv` | 22000-22999 | 528 (2026-08-04 : + prétérit, futur proche, comparatif complet, fréquence, -ing, synonymes) |

| 40 | `cp/logique/generated.csv` | 40000-40999 | 500 (2026-08-05 : suites de formes/emoji, intrus, sons animaux, comparaisons taille, dénombrement, motifs couleur, bébés animaux) |
| 41 | `ce1/logique/generated.csv` | 41000-41999 | 500 (2026-08-05 : suites numériques/alphabet, motifs ABC, intrus catégorie/pattes, contraires, extrêmes, analogies fonction, intrus numérique) |
| 42 | `ce2/logique/generated.csv` | 42000-42999 | 500 (2026-08-05 : suites 2 étapes, double/moitié, locomotion, habitat, syllogismes, intrus alimentaire, repérage spatial 3x3, transitivité âge, si-alors, extrêmes) |
| 43 | `cm1/logique/generated.csv` | 43000-43999 | 500 (2026-08-05 : suites composées ×/±, code lettre-chiffre, grilles 2D rotation, déduction âge/course, carrés parfaits, suites appariées lettre+chiffre, analogies partie-tout, contraires) |
| 44 | `cm2/logique/generated.csv` | 44000-44999 | 500 (2026-08-05 : Fibonacci, carrés+k, chiffrement César, grilles numériques façon Raven, déduction multi-indices avec attribution, suites entrelacées, menteur/vérité, analogies fonction, suites ×k+c, combinatoire) |

| 23 | `cp/lecture/histoires_generated.csv` | 23000-23999 | 47 histoires (1 passage + 10 questions chacune) |
| 24 | `ce1/lecture/histoires_generated.csv` | 24000-24999 | 47 histoires (1 passage + 20 questions chacune) |
| 25 | `ce2/lecture/histoires_generated.csv` | 25000-25999 | 47 histoires (1 passage + 20 questions chacune) |
| 26 | `cm1/lecture/histoires_generated.csv` | 26000-26999 | 47 histoires (1 passage + 20 questions chacune) |
| 27 | `cm2/lecture/histoires_generated.csv` | 27000-27999 | 47 histoires (1 passage + 20 questions chacune) |

| 28 | `ce1/grammaire/generated.csv` (nouvelles lignes) | 28000-28999 | 914 nouvelles (+ 86 héritées de la tranche 9000-9999, voir note ci-dessous) |
| 29 | `ce1/conjugaison/generated.csv` (nouvelles lignes) | 29000-29999 | 933 nouvelles (+ 67 héritées) |
| 30 | `ce1/orthographe/generated.csv` (nouvelles lignes) | 30000-30999 | 953 nouvelles (+ 47 héritées) |
| 31 | `ce2/grammaire/generated.csv` (nouvelles lignes) | 31000-31999 | 960 nouvelles (+ 40 héritées, ids 10000-10039) |
| 32 | `ce2/conjugaison/generated.csv` (nouvelles lignes) | 32000-32999 | 950 nouvelles (+ 50 héritées, ids 10040-10089) |
| 33 | `ce2/orthographe/generated.csv` (nouvelles lignes) | 33000-33999 | 950 nouvelles (+ 50 héritées, ids 10090-10139) |

**Extension Français CP/CE1/CE2 à 500 questions chacun (2026-08-03) :** `cp/french`, `ce1/{grammaire,
conjugaison,orthographe}` et `ce2/{grammaire,conjugaison,orthographe}` — 7 fichiers — étendus à 500
questions chacun en respectant le scope de difficulté par classe défini dans
`FRANCAIS_DIFFICULTE.md`. `cp/french` : 190→500 (+310, ids 2191-2500, tranche 2000-2999 déjà
réservée) — pluriels réguliers, féminin/bébés animaux, contraires/synonymes simples, comptage
lettres/voyelles, nombres en lettres, première/dernière lettre, mois, jours, couleurs. **Rupture
avec la règle de tranche partagée pour CE1/CE2** : `ce1/grammaire+conjugaison+orthographe`
partageaient la tranche 9000-9999 (900 id restants) et `ce2/...` la tranche 10000-10999 — mais
passer les 3 fichiers de chaque classe à 500 questions chacun (1500 au total) dépasse la capacité
d'une tranche de 1000. Chaque fichier a donc reçu sa **propre tranche dédiée** (28000-30999 pour
CE1, 31000-33999 pour CE2, règle par défaut du registre) pour ses nouvelles lignes uniquement — les
id hérités (2200/2300 pour CE1, 10000-10139 pour CE2) restent inchangés à leur place d'origine, rien
n'a été renuméroté (règle 2 : jamais réutiliser/décaler une tranche). CE1 grammaire (86→500),
conjugaison (67→500), orthographe (47→500) : nature du mot/pluriels -aux/féminin adjectifs
(grammaire), verbes du 1er groupe + être/avoir déjà complets au présent (conjugaison), homophones
et/est-son/sont + femelles animaux + comptage lettres (orthographe). CE2 grammaire (40→500),
conjugaison (50→500), orthographe (50→500) : pronoms personnels/fonction sujet/accord sujet-verbe/
types de phrases (grammaire), 2e groupe + irréguliers aller-faire-dire-venir au présent + futur
simple 1er groupe + imparfait 1er groupe (conjugaison, être/avoir imparfait déjà complets non
retouchés), homophones on/ont-ces/ses-leur/leurs-quel/qu'elle-sa/ça + synonymes/antonymes + accord
adjectif épithète + pluriel -eau/-eu (orthographe). Généré par script Python (vocabulaire construit
à la main, conjugaison réguliere calculée programmatiquement avec gestion g/c devant a/o et élision
je+voyelle), vérifications avant intégration : unicité id/texte (y compris contre le contenu
hérité), aucune bonne réponse dupliquée parmi ses propres distracteurs, aucun distracteur dupliqué
(un bug de calcul de distracteurs a été détecté et corrigé sur ~120 lignes au total avant
intégration — voir [[project_francais_500]] en mémoire), accents vérifiés partout. CM1/CM2 français
non touchés (hors périmètre de cette demande).

| 34 | `cm1/grammaire/generated.csv` (nouvelles lignes) | 34000-34999 | 960 nouvelles (+ 40 héritées, ids 11000-11039) |
| 35 | `cm1/conjugaison/generated.csv` (nouvelles lignes) | 35000-35999 | 958 nouvelles (+ 42 héritées, ids 11040-11081) |
| 36 | `cm1/orthographe/generated.csv` (nouvelles lignes) | 36000-36999 | 965 nouvelles (+ 35 héritées, ids 11082-11116) |
| 37 | `cm2/grammaire/generated.csv` (nouvelles lignes) | 37000-37999 | 960 nouvelles (+ 40 héritées, ids 12000-12039) |
| 38 | `cm2/conjugaison/generated.csv` (nouvelles lignes) | 38000-38999 | 960 nouvelles (+ 40 héritées, ids 12040-12079) |
| 39 | `cm2/orthographe/generated.csv` (nouvelles lignes) | 39000-39999 | 963 nouvelles (+ 37 héritées, ids 12080-12116) |

**Extension Français CM1/CM2 à 500 questions chacun (2026-08-03) :** même traitement que
l'extension CP/CE1/CE2 (voir note ci-dessus) — les 6 fichiers `cm1/{grammaire,conjugaison,
orthographe}` et `cm2/{grammaire,conjugaison,orthographe}` (35-42 questions chacun) étendus à 500,
avec le scope de difficulté CM1/CM2 de `FRANCAIS_DIFFICULTE.md`. Même rupture avec la tranche
partagée (11000-11999 CM1, 12000-12999 CM2, 200 id utilisés sur 1000 — insuffisant pour 3×500) :
chaque fichier reçoit sa propre tranche dédiée pour ses nouvelles lignes (34000-36999 CM1,
37000-39999 CM2), contenu hérité inchangé à sa place d'origine. CM1 grammaire (40→500) : COD/COI/
attribut du sujet, déterminants possessifs vs démonstratifs, accord du participe passé avec être.
CM1 conjugaison (42→500) : présent irréguliers prendre/voir/pouvoir/vouloir/savoir, imparfait et
futur simple généralisés (radical "nous" du présent pour l'imparfait, gestion des futurs
irréguliers aller/faire/avoir/être/voir/vouloir/pouvoir/savoir/venir), passé composé avoir/être
(initiation). CM1 orthographe (35→500) : homophones avancés (la/l'a/là, peu/peux/peut, plutôt/plus
tôt), mots invariables courants, doublement de consonnes (comptage lettre par lettre sur une
banque de ~300 mots). CM2 grammaire (40→500) : compléments circonstanciels temps/lieu/manière,
subordonnée relative qui/que/où/dont, accord du participe passé avec avoir (cas invariable,
distracteurs = formes accordées à tort). CM2 conjugaison (40→500) : passé composé consolidé
(avoir + être, tous pronoms), plus-que-parfait (initiation), passé simple (3e personne seulement,
verbes fréquents, reconnaissance), conditionnel présent. CM2 orthographe (37→500) : homophones
avancés (quand/quant/qu'en, sans/s'en/sens, tout/tous), préfixes/suffixes, orthographe d'usage
(accents sur une grande banque de mots vérifiés + comparaison de graphies + comptage de lettres).
Mêmes vérifications que les extensions précédentes (unicité id/texte y compris contre le contenu
hérité, aucune bonne réponse dupliquée parmi ses distracteurs, aucun distracteur dupliqué, accents
présents). Voir [[project_francais_500_cm1_cm2]] en mémoire.

**Extension CP math + Grammaire/Conjugaison/Orthographe CE1-CM2 à 1000 questions chacun
(2026-08-07) :** `cp/math` et les 12 fichiers `{ce1,ce2,cm1,cm2}/{grammaire,conjugaison,
orthographe}` passés de 500 à 1000 questions chacun, en respectant toujours le scope de
difficulté par classe de `FRANCAIS_DIFFICULTE.md`. Aucune nouvelle tranche consommée : chaque
fichier avait déjà sa tranche dédiée avec 500 id de marge (règle 3), les nouvelles lignes
prennent la suite immédiate des id existants dans la même tranche (ex. CE2 grammaire continue à
31460 après les 460 lignes 31000-31459). `cp/french` non concerné (reste à 500, hors périmètre de
cette extension). Généré par scripts Python par fichier (familles par classe détaillées dans
[[project_grammaire_conjugaison_orthographe_1000]] en mémoire), avec la même méthode de
validation que les extensions précédentes : unicité id/texte y compris contre le contenu hérité,
aucun distracteur dupliqué, puis **échantillonnage manuel systématique** (`shuf -n N`) qui a une
nouvelle fois trouvé de vrais bugs à chaque fichier — y compris plusieurs bugs *pré-existants*
dans le contenu déjà en place avant cette extension (corrigés au passage plutôt que reconduits à
plus grande échelle) : accords d'adjectifs irréguliers faux dans ~240 lignes CE2 orthographe
(curieuxe/douxe/neufe au lieu de curieuse/douce/neuve), verbes à double conjugaison et élisions
manquantes en CE2/CM1/CM2 conjugaison, futur simple irrégulier mal formé pour les verbes comme
mourir/courir en CM1 (radical + mauvaise terminaison), auxiliaire avoir utilisé à tort pour des
verbes d'état comme rester en CM2 conjugaison, participe irrégulier mal formé pour ouvrir en CM2,
et plusieurs coquilles isolées (frappe double lettre finale, mot inventé "ommettre"/
"balladeur" au lieu d'omettre/baladeur, accord sujet-verbe singulier sur un sujet pluriel).
Détail complet par fichier dans la mémoire projet.

**Extension `cp/french` à 1000 questions (2026-08-07) :** les 500 questions existantes (ids
2001-2500, tranche 2000-2999) sont conservées à leur place — 500 nouvelles ajoutées dans la
tranche 8000-8999 déjà réservée pour ce fichier depuis l'origine (ids 8000-8499, 500 id de marge
restants), plutôt que de continuer à 2501+ qui aurait prolongé le chevauchement d'id avec
`cp/math` (constaté harmless au runtime — `id` n'est utilisé nulle part comme clé après l'import,
voir `data/question/question_resource.gd` et `tools/admin/import_questions.gd` — mais évité pour
la clarté du registre). Pas de scope `FRANCAIS_DIFFICULTE.md` pour le CP (le document ne couvre
que grammaire/conjugaison/orthographe à partir du CE1) : familles calquées sur celles déjà
présentes dans les 500 lignes existantes — pluriels réguliers, pluriel du singulier (sens
inverse), contraires, synonymes, comptage lettres/voyelles (convention du fichier confirmée :
le Y n'est pas compté comme voyelle), première/dernière lettre, nombres en lettres 21-100 et sens
inverse, couleurs. Familles déjà saturées avec le vocabulaire courant CP (féminin/masculin et
bébés des animaux, mois/jours — tous les enchaînements "juste avant/après" possibles étaient déjà
couverts) volontairement non étendues plutôt que forcées avec du vocabulaire hors-programme.
**Audit du contenu existant avant extension** (méthode systématique du projet) : 8 questions
féminin/masculin d'animaux (ours/renard/lapin/éléphant, les deux sens) avaient un distracteur
dupliquant la bonne réponse plus un faux mot en "-ee" — corrigées avec de vrais distracteurs
inter-animaux avant d'ajouter quoi que ce soit. **Bugs trouvés par échantillonnage manuel sur le
nouveau contenu** (aucun n'aurait été détecté par les seules vérifications structurelles) :
pluriels irréguliers traités comme réguliers en "+s" pour les mots en -eau/-au/-eu (bateau→
"bateaus" au lieu de bateaux), -al (journal→"journals" au lieu de journaux) et le groupe
bijou/chou/genou/hibou/joujou/pou/caillou ; pluriel de noms composés multi-mots incorrect ("pot de
fleurs"→"pot de fleurss" au lieu de pluraliser le nom tête) — ces mots composés retirés du banc
plutôt que de complexifier la règle pour un gain marginal ; "ours" (invariable singulier=pluriel)
utilisé à tort comme mot cible d'une question "quel est le singulier de" ; et un bug de code mort
dans le convertisseur nombre→lettres (`if n == 100` imbriqué dans un bloc `if n < 100`, donc
jamais atteint) qui laissait échapper le chiffre "100" tel quel au lieu d'écrire "cent". Voir
[[project_cp_french_1000]] en mémoire pour le détail.

**Corrections post-extension signalées en jeu par l'utilisateur (2026-08-07, captures d'écran) :**
deux questions incohérentes repérées en jeu ont déclenché un audit ciblé sur le lot d'extension
500→1000 (voir note ci-dessus) :

1. *`ce2/orthographe/generated.csv`, famille "accord de l'adjectif épithète" (512 lignes au
   total, ids 10124-10131 hérités + 33142-33949 nouveaux)* : les 504 nouvelles lignes avaient
   perdu leur article/nom sujet en tête de phrase lors de la génération — le texte affiché en jeu
   était juste `jardin ___ (étroit)` au lieu de `un jardin ___ (étroit)`, sans consigne ni sujet.
   Corrigé en reconstruisant l'article correct (un/une/des) à partir du genre/nombre du nom (table
   de genre construite à la main pour les 104 noms uniques de la banque), déduit et croisé avec
   l'accord déjà correct de `correct_answer`. Cette reconstruction a fait apparaître 8 doublons de
   texte exacts avec les lignes héritées d'origine (ids 33142-33149 étaient des quasi-clones de
   10124-10131, article en moins) — remplacés par 8 nouvelles paires nom/adjectif inédites plutôt
   que de dupliquer le contenu existant. Au passage, 2 fautes de pluriel irrégulier repérées dans
   le texte même des questions (pas seulement les distracteurs) : "gâteaus"/"chapeaus" au lieu de
   "gâteaux"/"chapeaux" (ids 33802, 33806).
2. *Familles homophones `sa/ça/sas/cas` (ce2/orthographe, ids 10094-33814, ~76 lignes) et
   `son/sont/sons/se` (ce2/orthographe, ids 33438-33445, 8 lignes)* : rappel entre parenthèses
   `(à lui)`/`(à elle)`/`(à lui/elle)`/`(à eux)` redondant et grammaticalement trompeur — le sujet
   de la phrase (Il/Elle/Je/un prénom comme Marie ou Paul) suffisait déjà à lever toute ambiguïté,
   et pour les phrases avec prénom le hint générique "(à lui/elle)" n'était même pas résolu au bon
   genre du prénom (Marie/Zoé/Nina/Chloé sont explicitement féminins). Rappel supprimé partout dans
   ce fichier (69 lignes avec le hint en fin de phrase + 8 lignes avec le hint au milieu de la
   phrase). **Distinction importante retenue** : le même motif `(à moi/toi/lui/elle/nous/vous/eux)`
   existe aussi dans `cm1/grammaire/generated.csv` (déterminants possessifs mon/ton/son/notre/
   votre/leur, ids 11015-34835, ~139 lignes) mais y est **nécessaire** dans 138/139 cas — la phrase
   commence directement par le blanc sans aucun autre indice de personne, donc le rappel reste la
   seule source de désambiguïsation. Un seul cas corrigé là (id 11029, rappel redondant car la
   phrase donnait déjà l'info autrement : "ils sont à toi").
3. *Vraie faute de grammaire (règle d'élision), trouvée en creusant le même sujet* : "écharpe"
   (mot féminin commençant par une voyelle) demande "son écharpe", pas "sa écharpe" — deux lignes
   la testaient à tort avec "sa" marqué correct et "son" absent des choix : id 33066 (famille
   sa/ça, remplacé par "veste" pour éviter le cas particulier) et id 34743 dans
   `cm1/grammaire/generated.csv` (famille déterminants possessifs, corrigé en remplaçant la bonne
   réponse "Ta" par "Ton"). Audit exhaustif confirmé : aucune autre occurrence du même piège
   d'élision dans tout le corpus (recherché nom par nom sur toutes les matières/classes).

Revalidé après coup sur les deux fichiers : aucun id/texte/choix dupliqué, comptes de lignes
inchangés (1000 chacun). Aucune tranche d'id ni compte de questions affecté par ces corrections
(uniquement du contenu réécrit à l'intérieur des tranches existantes).

**Faille supplémentaire trouvée par l'utilisateur (capture d'écran, "une écharpe ___ (énorme)")** :
dans la famille "accord de l'adjectif" de `ce2/orthographe/generated.csv" (512 lignes), le mot
entre parenthèses est la forme de base (citation) de l'adjectif — qui, en français, correspond
exactement au masculin singulier. Résultat : sur toute ligne où la bonne réponse attendue était
justement le masculin singulier (ou, pour les adjectifs invariables en genre/nombre comme
"énorme"/"calme"/"rapide", sur toute ligne où la forme attendue restait identique à la forme de
base), la bonne réponse était donc écrite noir sur blanc dans l'énoncé — l'élève n'avait pas besoin
de connaître la règle d'accord, juste de repérer le mot déjà affiché. **264 des 512 lignes de
cette famille étaient concernées** (204 avec un nom masculin singulier + 60 avec un adjectif
invariable sur un nom féminin singulier ou pluriel). Corrigé ligne par ligne en changeant le genre
et/ou le nombre du groupe nominal (donc la forme d'accord exigée) chaque fois que la bonne réponse
coïncidait avec la forme affichée : 227 lignes corrigées simplement en passant le nom du singulier
au pluriel (même nom, `un/une` → `des`), 37 lignes où passer au pluriel ne suffisait pas
(adjectifs invariables aussi au pluriel masculin comme curieux/doux/gris/vieux/frais/épais...) ont
eu leur nom remplacé par un nom féminin inédit pour forcer un accord réellement différent de la
forme de base. Deux collisions de texte résultantes (deux noms différents retombant sur le même
pluriel) corrigées en changeant l'un des deux noms. Revalidé : 0 fuite restante (bonne réponse ==
indice entre parenthèses), 0 doublon id/texte/choix, 0 incohérence de genre entre l'article et le
nom, 1000 lignes inchangées. Le même risque a été vérifié et écarté dans `cm1/grammaire/
generated.csv` (famille déterminants possessifs) : l'indice y est une personne ("à moi"/"à toi"...)
et non la forme de base du mot à trouver, donc structurellement non exploitable de la même façon.

**Audit de confirmation demandé par l'utilisateur ("est-ce que ça touche une autre matière du CP au
CM2 ?", 2026-08-08) :** balayage programmatique de la fuite réponse-dans-l'indice sur les **38
fichiers CSV du projet** (toutes matières, toutes classes, y compris `histoires_generated.csv`) —
**2563 lignes** au format `___ (indice)` identifiées au total. Un 3e foyer trouvé, distinct des
deux premiers et **antérieur à l'extension du 2026-08-07** (ids 11097-11106, dans la tranche
héritée d'origine) : la famille "mots invariables" de `cm1/orthographe/generated.csv`
(jamais/toujours/souvent/parfois, déjà/encore/bientôt, très/trop/assez/beaucoup/peu) répétait
littéralement le mot attendu entre parenthèses sur 10 lignes. Corrigé au cas par cas : 3 lignes où
la grammaire seule (accord `ne...jamais`/`ne...pas encore`) suffit à lever l'ambiguïté ont eu leur
parenthèse simplement supprimée ; les 7 lignes réellement ambiguës sans indice ont eu leur
parenthèse remplacée par une glose/synonyme qui ne recopie plus aucun des 4 choix (ex. "(vraiment)"
→ "(en vérité)", "(souvent)" → "(fréquemment)"). Deuxième passe de balayage complet ensuite : **0
fuite restante sur les 2563 lignes du corpus entier** (maths, français, grammaire/conjugaison/
orthographe, anglais, lecture, logique — toutes classes CP à CM2). Un balayage séparé a aussi
recherché toute autre phrase commençant directement par un nom commun minuscule suivi du blanc sans
sujet/article reconnu (le motif du bug n°1) sur les mêmes 38 fichiers : **0 occurrence restante**.
Seuls les 3 foyers listés ci-dessus (ce2/orthographe accord adjectif, ce2/orthographe + cm1/
grammaire rappels "(à qui)", cm1/orthographe mots invariables) ont jamais été touchés — aucune autre
matière/classe n'est concernée par ces trois familles de bugs.

**Correction pronom "il/elle" non résolu dans les mini-problèmes de maths (2026-08-08,
signalé par l'utilisateur) :** dans `cp/math`, `ce1/math` et `ce2/math`, les problèmes en contexte
("NOM a X objets. ___ en reçoit/donne/achète Y...") contenaient littéralement le texte non résolu
"Il/elle" (et "a-t-il/elle") au lieu du bon pronom accordé au prénom du personnage — **245 lignes**
au total (80 cp, 85 ce1, 80 ce2 ; cm1/cm2 non concernés, aucune occurrence). Résolu en fonction du
genre du prénom (36 prénoms uniques) : "Léo/Hugo/Jules/Tom/..." → "il"/"a-t-il", "Léa/Zoé/Chloé/
Nina/..." → "elle"/"a-t-elle" ; la construction impersonnelle "combien lui (en) reste-t-il" n'a pas
été touchée (le "il" y est impersonnel, comme dans "il reste 5 pommes", indépendant du genre du
personnage). **6 prénoms réellement épicènes en français (Camille, Lou, Nino, Noa, Sacha, Sam)**
n'ont aucun indice fiable ailleurs dans le projet pour trancher leur genre dans ce contexte
précis (les occurrences croisées trouvées, ex. "Il fait froid" en logique, sont des "il"
impersonnels météo sans rapport) — tranchés par défaut (Camille/Lou → elle, Nino/Noa/Sacha/Sam →
il) ; à corriger manuellement si l'utilisateur préfère un autre choix pour ces 6 prénoms
spécifiquement. Revalidé : 0 occurrence de "il/elle" restante, aucun nouveau doublon id/texte
introduit par cette correction (des doublons de texte préexistants, 31 en ce1/math et 75 en
ce2/math, ont été repérés au passage mais sont antérieurs à cette correction et hors périmètre de
cette demande — proviennent probablement d'un manque de déduplication lors de la génération
aléatoire des problèmes, à traiter séparément si besoin).

**Correction des doublons de texte ce1/math + ce2/math (2026-08-08) :** les 31 (ce1) + 75 (ce2)
doublons repérés lors de l'audit du pronom il/elle ont été traités. Cause : le lot d'origine
(1200-1400 pour ce1, 1400-1600 pour ce2) et le lot d'extension à 1000 questions (3000-3799 pour
ce1, 4000-4799 pour ce2) contenaient chacun des tables de multiplication/division sans se
vérifier l'un contre l'autre. Pour chaque doublon, la première occurrence (id le plus bas) est
restée inchangée ; la seconde a été remplacée : table de multiplication CE1 (19 lignes) → nouvelle
combinaison a×b encore libre (marge suffisante, 0-10×0-10 pas encore saturé côté CE1) ; table de
multiplication CE2 (45 lignes) → la table complète 1-10 étant déjà saturée à 100/100 combinaisons,
reformulée soit par inversion a×b→b×a quand cette forme n'existait pas encore (10 lignes), soit en
problème contextualisé équivalent ("Il y a A paquets de B objets...") pour le reste ; division CE2
(28 lignes) → même logique (nouvelle combinaison libre si possible, sinon "On partage A objets en
B groupes égaux...") ; moitié/quart (CE1 9 lignes, CE2 2 lignes) et "ajouter à N pour obtenir 100"
(CE1 2 lignes) → nouvelle valeur non utilisée ; 1 problème "tu as N euros..." (CE1) → valeurs
renouvelées. Deux bugs introduits puis corrigés au passage par échantillonnage manuel avant
intégration : distracteurs négatifs sur les petits produits/quotients proches de 0 (ex. "0 x 0"
proposait -2/-1 comme distracteurs, jamais vu en CE1/CE2) et accord singulier manquant sur "1
bonbons/1 billes/1 ballons" au lieu de "1 bonbon/1 bille/1 ballon" dans les 4 nouveaux problèmes
"paquets de 1". Revalidé : 0 doublon id/texte restant, exactitude arithmétique vérifiée
programmatiquement sur toutes les nouvelles lignes, aucun distracteur négatif ni incohérence
d'accord restants.

**Réduction du niveau des calculs CP à 0-30/0-50 (2026-08-08, signalé par l'utilisateur) :**
constat : les additions/soustractions de `cp/math/generated.csv` allaient jusqu'à 90-99 (ex.
"82 - 62", "4 + 89"), niveau CE1/CE2 plutôt que CP. **Périmètre limité aux calculs +/- uniquement**
sur demande explicite de l'utilisateur (comparaison de nombres, doubles/moitiés, nombre juste
avant/après, dizaines/unités et suites numériques restent inchangés, y compris ceux qui dépassent
30-50 — hors périmètre de cette demande). 465 lignes régénérées sur les 8 familles concernées :
addition directe (140), soustraction directe (115), addition à trous 2 termes (29+44), addition à
trous 3 termes (18), soustraction à trous (37+42), "combien faut-il ajouter à N pour obtenir X"
(40). Répartition ~70% des lignes avec toutes les valeurs ≤30, ~30% avec une valeur jusqu'à 50
(comme demandé "0 à 30 voire 0 à 50"), aucune ne dépasse 50, aucun résultat de soustraction
négatif. Vérifié programmatiquement : exactitude arithmétique sur les 465 lignes, aucun doublon
id/texte/choix, aucun distracteur négatif. Un cas limite repéré et corrigé par échantillonnage
manuel : 3 lignes "ajouter à N pour obtenir N" (même valeur des deux côtés, réponse triviale 0)
régénérées pour garantir une cible toujours strictement supérieure au nombre de départ. Ids et
nombre total de lignes du fichier inchangés (toujours 1000), seul le texte/les choix des 465
lignes concernées ont été réécrits en place.

**Audit complet maths + français, tous CSV (2026-08-28, demande utilisateur "trop d'erreurs
actuellement") :** gros audit en deux volets, aucune tranche d'id ni compte de lignes modifié nulle
part (uniquement du contenu réécrit à l'intérieur des tranches existantes).

*Volet maths (cohérence niveau/classe)* : `cp/math` — familles "double" (32 lignes) et "moitié"
(28 lignes) régénérées, la banque de valeurs dépassait le programme CP (double jusqu'à 47/94 vu en
jeu) ; nouveau plafond conforme au programme 2025 cycle 2 (double jusqu'à 15+15, moitié des pairs
<20, plus l'exception "dizaines entières" <100 pour les deux). `cm2/math` — famille "Combien font
A × B ?" (152 lignes) régénérée : elle était en moyenne *plus facile* que la même famille en CM1
(bug d'inversion de progression), nouvelle distribution avec un facteur à 3 chiffres dans 15% des
cas pour redevenir strictement plus difficile que CM1.

*Volet français (structure/grammaire)* : passe famille par famille sur grammaire/conjugaison/
orthographe des 5 classes, puis passe manuelle en profondeur sur `histoires_generated.csv` (textes
de compréhension CE1-CM2, la plus grosse source d'erreurs). Détail par fichier :
- `ce1/orthographe` : 5 lignes sans majuscule initiale corrigées.
- `ce2/orthographe` : 512 lignes accord adjectif — majuscule/point ajoutés ; 25 lignes "X-la"→
  "X-là" (accent démonstratif), dont 11 avec accord de genre faux au passage (ils sont beaux → elles
  sont belles sur des noms féminins).
- `cm1/grammaire` : 47 lignes "Regarde ___ [nom], il/elle est superbe" — accord pronom/verbe faux
  selon le genre/nombre du nom corrigé ; 1 accent démonstratif.
- `cm1/orthographe` + `cm2/orthographe` : 40 lignes toutes classes confondues avec un choix en
  double par collision de casse (plutôt/plus tôt, quand/quant/qu'en, tout/tous/toute/toutes,
  sans/s'en/sens) — distracteurs reconstruits, 3 phrases entièrement réécrites.
- `cm2/grammaire` : plus gros chantier du volet français — famille "accord du participe passé"
  (781 lignes) entièrement recurée sur demande explicite de l'utilisateur (compatibilité verbe/
  objet réaliste + accord correct antéposé/postposé, ex. "Le peintre a arrosé un tableau" →
  incohérence sémantique) ; 19 lignes accord sujet-verbe + absurdité sémantique dans la famille
  "complément circonstanciel" (ex. "Le vélo dîne à vingt heures" → "Le fermier dîne à vingt
  heures") ; 5 lignes choix en double par collision de participe (prendre → "pris" identique au
  masc. singulier et pluriel).
- `ce2/grammaire` : 26 lignes famille "type de phrase" — accord sujet-verbe + inversion sémantique
  sujet/prédicat absurde (ex. "Le boulanger mange la souris" → "Le chat mange la souris").

*Volet lecture (`histoires_generated.csv`, CP à CM2, le plus gros du travail)* : après une première
passe homophones (à/a, des/dès, ~185 corrections), un nouveau bug bien plus large a été repéré et
traité en profondeur sur demande explicite de l'utilisateur ("je le fais maintenant, en
profondeur") : de nombreux participes passés employés comme adjectifs avaient perdu leur accent
final dans les versions longues des histoires (CE1 à CM2), ex. "un atelier propose" au lieu de
"proposé", "des rideaux brodes" au lieu de "brodés". Comme le même radical peut être soit un verbe
au présent correct soit l'adjectif fautif selon le contexte, la correction s'est faite phrase par
phrase plutôt que par remplacement automatique aveugle, en plusieurs passes ciblées : participe
après nom pluriel (189 lignes), "dès l'..." avec élision manqué par la première passe (35), participe
après auxiliaire avoir/d'avoir (96, motif très fiable), une trentaine de cas isolés trouvés par
lecture manuelle de passages complets (emballes→emballés, situe→situé, cotes→côtés, tout a fait→
tout à fait, etc.), adjectif "préfère" utilisé au sens de "préféré" (35 lignes, ex. "son animal
préfère" → "son animal préféré"), homophone "ou/où" (16 lignes de relative de lieu confondues avec
la conjonction "ou"). **Deux régressions introduites puis corrigées dans la foulée** (détectées par
relecture d'échantillon après coup, pas par l'utilisateur) : l'idiome "commencer par" (ex. "Erik
commence par rouler...") avait été à tort transformé en participe passif par la passe automatique
"radical+par" (10 lignes revenues à la forme présente correcte) ; le mot "cote" avait été converti
en bloc vers "côté" alors qu'un cas isolé signifiait "côte" (pente) et non "côté" (1 ligne
corrigée dans sa paire CM1/CM2). Revalidé après coup sur les 5 fichiers `histoires_generated.csv` :
0 doublon id, 0 ligne malformée, comptes de lignes inchangés (517 CP, 987 CE1-CM2 chacun).

**Point important** : vu l'ampleur découverte en cours de route (le problème d'accents manquants
sur les participes-adjectifs dépassait largement l'estimation initiale), cette passe a couvert tout
ce qui était détectable par les motifs syntaxiques fiables utilisés (nom pluriel + participe,
auxiliaire avoir + participe, virgule + participe en apposition, lecture manuelle d'un échantillon
de passages). Un résidu de cas isolés non détectés par ces motifs peut subsister ailleurs dans les
~4700 lignes de `histoires_generated.csv` (par nature, un participe-adjectif après un nom singulier
sans virgule ni "par" ensuite est indiscernable d'un verbe au présent sans lecture intégrale de
chaque passage) — à traiter au fil de l'eau si signalé en jeu plutôt que par un nouveau balayage
automatique, le rapport signal/bruit des motifs restants étant trop faible pour être fiable sans
relecture humaine complète.

**Rappel obligatoire : relancer les deux scripts d'import Godot** après ces changements —
`tools/admin/import_questions.gd` (maths + grammaire/conjugaison/orthographe) et
`tools/admin/import_reading.gd` (lecture/`histoires_generated.csv`) — sinon le contenu en jeu reste
l'ancienne version des `.tres`.

**Régression "réponse dans l'indice" retrouvée dans `cm1/orthographe` (2026-08-30, signalée en jeu
par l'utilisateur, capture d'écran "idée de tellement")** : l'audit du 2026-08-08 (voir note
ci-dessus, "0 fuite restante sur les 2563 lignes") avait bien corrigé les 10 lignes héritées de la
famille "mots invariables", mais **75 nouvelles lignes réintroduisant exactement le même bug**
avaient été ajoutées ensuite lors du passage 500→1000 (ids 36047-36066 et 36735-36789, template
`'Il est arrivé ___' (idée de X)` où X = la bonne réponse recopiée telle quelle) — une régénération
du même gabarit sans reprendre le correctif. Corrigé en abandonnant le gabarit générique cassé
(`'Il est arrivé ___'` ne fonctionne même pas grammaticalement pour la moitié du vocabulaire
concerné, ex. "il est arrivé beaucoup" n'existe pas) au profit d'une phrase réelle et distincte par
mot, choisie pour que la bonne réponse soit la seule à s'y intégrer grammaticalement/logiquement
(reprend la méthode déjà validée le 2026-08-08 : indice entre parenthèses supprimé quand la
grammaire seule suffit, sinon remplacé par une glose qui ne recopie aucun des 4 choix). Un
distracteur trop proche synonyme de la bonne réponse a aussi été remplacé (`fréquemment` vs
`souvent`, id 36780 : `souvent` → `brièvement`, pour éviter une ambiguïté réelle entre deux mots
quasi interchangeables).

**Balayage de confirmation sur les 33 fichiers `generated.csv`** (recherche programmatique de toute
parenthèse contenant, en mot entier, la bonne réponse de sa propre ligne — donc sans faux positifs
sur les indices infinitifs légitimes du type `(chasser)` pour la réponse conjuguée `chasse`) a
trouvé **2 autres foyers**, tous deux dans la famille homophones `la/l'a/las/l'as` de
`cm1/orthographe` (+ 1 cas `s'en/sans/sens/sang` isolé dans `cm2/orthographe`) : 14 lignes
`'Range ___ [nom] ici (article la)'` (ids 36165-36174, 36704-36707) et 1 ligne `'Tu ___ déjà
rencontré (tu l'as)'` (id 11084) donnaient l'indice en toutes lettres ; corrigées en supprimant
purement la parenthèse, la grammaire (accord sujet/verbe pour 11084, article défini devant un nom
féminin pour les 14 autres) suffisant seule à désigner une réponse unique parmi les 4 homophones. Au
passage, 3 de ces 14 lignes utilisaient un nom féminin commençant par une voyelle/h muet
(histoire/idée/adresse) alors que la réponse attendue "la" (non élidée) ne peut structurellement pas
précéder un tel nom (il faudrait "l'histoire"/"l'idée"/"l'adresse", forme absente des choix) — noms
remplacés par des équivalents à consonne initiale (boite/carte/veste) pour rester cohérent avec les
4 choix existants. Idem `cm2/orthographe` id 12084 (`s'en aller` en toutes lettres) : parenthèse
supprimée, grammaire (accord "elle" + verbe pronominal) suffisante. Une incohérence mineure repérée
au passage dans `cm1/grammaire` (famille démonstratifs) : id 11023 disait `(celui-ci)` alors que la
phrase utilisait le renfort `chien-là` (éloignement) — corrigé en `(celui-là)` pour rester cohérent ;
ne changeait pas la bonne réponse ("ce"), qui était déjà correcte indépendamment de ce détail.
**0 fuite restante confirmée sur les 33 fichiers** après ce passage (nouvelle vérification
programmatique, cette fois avec correspondance en mot entier plutôt qu'en sous-chaîne pour éviter
les faux positifs de l'audit du 2026-08-08). Revalidé : aucun doublon id/texte, aucune ligne
malformée, comptes de lignes inchangés partout.

**Suppression des questions "comptage de lettres/voyelles/première-dernière lettre" (2026-08-30,
signalé par l'utilisateur)** : ces questions demandent de compter des lettres/voyelles ou de repérer
la première/dernière lettre d'un mot **affiché à l'écran** — dans un jeu 100% à l'écrit (pas de
question orale), l'élève lit littéralement la réponse sans aucune compétence linguistique testée.
998 lignes concernées sur 2 fichiers, remplacées par du contenu réellement écrit :

- `cp/french/generated.csv` — **307 lignes** (ids 2111-2125, 2146-2157, 2324-2383, 8255-8364 pour
  "combien de lettres/voyelles" ; 2412-2461, 8365-8424 pour "première/dernière lettre") remplacées
  en étendant les familles déjà présentes dans le fichier : pluriel (+95, nouveaux noms réguliers en
  -s), singulier (+55), contraire (+75), synonyme (+55), masculin d'animaux (+3, derniers couples
  courants restants : truie/cochon, paonne/paon, laie/sanglier), couleur d'objets/animaux courants
  (+24, avec parenthèse de contexte quand nécessaire type "(dans les dessins)" pour éviter toute
  ambiguïté de couleur réelle vs conventionnelle).
- `ce1/orthographe/generated.csv` — **691 lignes** (ids 2370-2377 + 30128-30961) remplacées en
  étendant les 2 familles homophones du scope CE1 (`FRANCAIS_DIFFICULTE.md` : "et/est", "son/sont")
  très fortement (150 lignes chacune pour et/est, 150+150 pour son/sont, avec accord de genre
  systématique sur les adjectifs — masculin/féminin correctement distingué selon le sujet, y compris
  pour les noms d'animaux au pluriel intrinsèquement féminins comme tortues/abeilles/coccinelles),
  synonymes (+85), et mâle/femelle d'animaux (+6, sens inverse de 6 paires déjà présentes qui
  n'avaient qu'une direction : jument/cheval, guenon/singe, chienne/chien, cane/canard, louve/loup,
  lionne/lion — cohérent avec le fait que la majorité des autres paires du fichier ont déjà les deux
  sens).

**Bugs trouvés et corrigés pendant la génération, avant intégration** : adjectifs mal accordés en
genre sur un premier jet du générateur (corrigé en construisant des paires masculin/féminin
explicites plutôt qu'un seul mot réutilisé), plusieurs collisions de vocabulaire avec des mots déjà
utilisés comme indices ailleurs dans le même fichier (ex. contraire de 'acheter' existait déjà),
2 paires contraire/synonyme sémantiquement fausses corrigées après relecture ('impoli' associé par
erreur à 'méchant' au lieu de 'poli' ; 'danser'/'valser' remplacé, "valser" étant un type de danse
précis et non un synonyme général de "danser"), 5 mots invariables en pluriel (radis, autobus,
cactus, canevas, souris — déjà terminés par un originel "s") utilisés par erreur dans les familles
pluriel/singulier basées sur l'ajout mécanique d'un "s", produisant des formes inexistantes
("radiss", "canevass") — retirés des banques de mots. **Après écriture des 691 lignes**, un
échantillonnage manuel a trouvé 13 erreurs d'élision (ex. "La abeille" au lieu de "L'abeille", y
compris un cas préexistant "la infirmière" antérieur à cette session) et 12 majuscules mal placées
en milieu de phrase (ex. "Aujourd'hui, La musicienne" au lieu de "la musicienne") — toutes corrigées.
Revalidé sur les deux fichiers : 1000 lignes chacun (inchangé), 0 doublon id/texte/choix, 0 ligne
malformée.

## Audit "réponse dans l'indice" en orthographe, toutes classes (2026-08-31)

**Retour utilisateur** (capture d'écran) : "Une voiture ___ (brillant)." avec les choix
brillants/brillantes/brillant/brillante — le mot entre parenthèses donne directement la racine de
la réponse. Demande : "je trouve encore beaucoup de questions avec un mot entre parenthese en
solution... a effacer, audit complet des fichiers concernés en orthographe check toutes les
classes concernées." Audit mené sur les 4 fichiers `orthographe/generated.csv` existants
(`ce1` n'en a pas — 0 ligne avec parenthèse) ; `cp` n'a pas de matière "orthographe" dédiée (voir
`cp/french/`, non auditée ici, hors périmètre de la demande).

- **`ce2/orthographe/generated.csv` (512 lignes)** : famille entière "Nom ___ (adjectif)." —
  toutes les lignes à parenthèse du fichier appartenaient à cette seule famille d'accord de
  l'adjectif. Analyse fine avant correction : sur ces 512 lignes, 433 étaient déjà non-ambiguës
  sans l'indice (les 3 mauvaises réponses sont automatiquement éliminées par le genre/nombre du
  nom, ex. distracteurs "gentille"/"rapide" au singulier dans une question sur "Des jardins").
  Mais 96 lignes avaient un distracteur "générique" (gentille, curieuse, grise, longue, forte,
  bleue, etc.) qui accordait AUSSI en genre/nombre avec le nom — sans l'indice, la question serait
  devenue réellement ambiguë (ex. "Une biche ___" avec les choix fraîche/frais/fraîches/gentille :
  "Une biche gentille" est grammaticalement valide aussi). Corrigé en re-genrant/renombrant ce
  distracteur pour qu'il redevienne grammaticalement éliminable (ex. "gentille" → "gentilles" si la
  question est au singulier, "salées" → "salée" si elle est au pluriel, 2 cas particuliers "gris"
  → "bleu" car "gris" ne peut pas perdre son "s" pour redevenir singulier). Parenthèse retirée sur
  les 512 lignes. **Problème additionnel découvert en supprimant la parenthèse** : la moitié des
  512 lignes partageaient un même couple déterminant+nom (ex. "Une lampe" apparaît 3 fois, "Des
  jardins" 21 fois) — sans la parenthèse pour les différencier, ça aurait produit jusqu'à 96
  doublons de texte. Corrigé en faisant tourner chaque occurrence d'un même nom sur une banque de
  15 formulations (singulier) / 24 formulations (pluriel) — "Cette lampe est ___.", "Cette lampe
  semble ___.", "Regarde, cette lampe est ___.", etc. — au lieu du gabarit unique "Nom ___". Cas
  d'élision géré ("Mon histoire" et non "Ma histoire" pour les noms à voyelle/h muet). Revalidé :
  1000 lignes (inchangé), 0 doublon id/texte/choix, 0 parenthèse restante.
- **`cm1/orthographe/generated.csv` (139 lignes à parenthèse)** : 46 lignes de la famille
  homophone la/l'a/las/l'as ("Louise ___ appelée hier soir (elle a).") avaient un indice "(elle a)"
  qui est en fait la réponse elle-même non élidée — supprimé, l'accord sujet-verbe (chaque prénom
  est un sujet à la 3e personne du singulier) suffit à éliminer las/l'as/la sans aide. Les 93 autres
  lignes (familles peut/peux/pouvez, beaucoup/trop/assez/peu, toujours/jamais/rarement/souvent,
  adverbes de temps type autrefois/désormais/jadis) portent des gloses de sens ("quantité",
  "capacité", "à partir de maintenant"...) qui ne répètent jamais le mot réponse — ce sont les
  lignes déjà retravaillées le 2026-08-XX précédent (famille "mots invariables") pour lever
  l'ambiguïté entre plusieurs adverbes réellement synonymes ; laissées telles quelles, conformes au
  principe déjà établi (glose non-révélatrice acceptable, contrairement à un indice qui redonne le
  mot). Revalidé : 1000 lignes, 0 doublon id/texte/choix.
- **`cm2/orthographe/generated.csv` (7 lignes à parenthèse)** : 3 lignes de la famille homophone
  sans/s'en/sens/sang portent des gloses de sens légitimes (non-révélatrices), laissées telles
  quelles. 4 lignes de la famille "suffixes" (ids 12103-12106) avaient l'exemple d'application
  du suffixe dans la réponse elle-même ("-esse (gentillesse)" au lieu de "-esse" simple), rendant
  la bonne réponse visuellement différente des 3 autres choix (seule à porter un exemple entre
  parenthèses) — recalées sur le gabarit déjà utilisé ailleurs dans le même fichier (le mot
  résultant dans la question : "Quel suffixe transforme l'adjectif 'gentil' en 'gentillesse' ?"),
  reformulées avec "l'adjectif"/"le verbe" pour éviter un doublon de texte avec les lignes
  39047-39050 qui utilisaient déjà exactement ce gabarit pour les 4 mêmes exemples. Revalidé :
  1000 lignes, 0 doublon id/texte/choix.

Aucune tranche d'id consommée ou modifiée (règle 2) — corrections de contenu à l'intérieur des id
existants uniquement. Périmètre non couvert par cette passe (hors demande explicite "en
orthographe") : `grammaire/` et `conjugaison/` pourraient contenir le même type de bug, à auditer
séparément si besoin.

## Même audit étendu à grammaire/conjugaison, toutes classes (2026-08-31)

**Retour utilisateur** : "oui meme audit meme corrections" — suite à l'audit orthographe
ci-dessus, extension à `grammaire/` et `conjugaison/` (ce1 à cm2). `conjugaison/` n'a aucune
ligne à parenthèse dans les 4 fichiers (rien à faire). `ce1/grammaire/` non plus. Le reste :

- **`ce2/grammaire/generated.csv` (241 lignes)** : famille unique de conjugaison au présent
  "Sujet ___ (infinitif)." (pronoms + noms de métiers/animaux). Le verbe entre parenthèses était
  redondant : les 4 choix sont toujours des formes du même verbe, l'accord sujet-verbe suffit à
  élire la bonne réponse sans l'indice. Parenthèse retirée sur les 241 lignes. Comme pour
  l'orthographe, ça créait des doublons de texte dès qu'un même sujet revenait avec un verbe
  différent (jusqu'à 12 fois pour "Nous"/"Il") — corrigé via une banque de 15 formulations
  tournantes ("Chaque jour, nous ___.", "En ce moment, nous ___.", etc.), sujet toujours en tête
  de phrase (pas de minuscule à gérer, aucun sujet propre trouvé dans cette famille). Revalidé :
  1000 lignes, 0 doublon id/texte/choix, 0 parenthèse restante.
- **`cm1/grammaire/generated.csv` (838 lignes à parenthèse)** : deux familles distinctes.
  647 lignes "Sujet est/sont ___ (infinitif)." (accord du participe passé avec être, sujets =
  prénoms ou groupes "X et Y") — même traitement : parenthèse retirée (choix déjà auto-suffisants
  pour l'accord), 18 formulations tournantes par sujet pour éviter les doublons de texte
  (max 17 répétitions pour "Les filles"), sujet toujours gardé tel quel en tête de phrase
  (prénoms propres, jamais mis en minuscule). 2 lignes particulières (11034, 11035) avaient EN
  PLUS un indice de genre en clair au milieu de la phrase ("Nous sommes ___ (garçons) au parc
  (aller).") : seul l'infinitif final a été retiré (redondant), l'indication de genre
  "(garçons)"/"(filles)" est gardée car "nous"/"vous" ne portent aucune information de genre par
  eux-mêmes — sans elle, la question deviendrait réellement ambiguë (allés/allées toutes deux
  possibles). Les 191 lignes restantes (familles possessifs "___ [nom] est là (à moi/toi/nous/
  vous/eux/lui-elle)." et démonstratifs "___ [nom] (celui-là/celle-ci/ceux-là/ceux-ci).") portent
  une glose qui désigne une PERSONNE ou un déterminant différent (pas une variante du même mot) :
  gloses non-révélatrices et nécessaires (rien d'autre dans la phrase n'indique à qui appartient
  l'objet ou lequel est désigné) — laissées telles quelles, même principe que les gloses
  conservées en orthographe. Revalidé : 1000 lignes, 0 doublon id/texte/choix.
- **`cm2/grammaire/generated.csv` (781 lignes à parenthèse)** : accord du participe passé avec
  avoir, deux sous-familles — COD après le verbe (779 lignes, "Sujet a ___ complément (infinitif).",
  participe invariable) et COD avant le verbe via une relative ("Antécédent que/qu' sujet a ___
  (infinitif).", participe accordé avec l'antécédent). Même traitement : infinitif retiré (choix
  déjà auto-suffisants), formulations tournantes par sujet+complément (14 gabarits, adverbes
  "Hier,"/"Finalement,"/"Sans attendre,"...) et par antécédent+sujet pour la relative (8 gabarits,
  "Voici .../Regarde .../C'est ...") pour éviter les doublons de texte. 2 lignes exclues de ce
  retrait (37545, 37865, famille "prendre") : cette famille n'a que 3 formes écrites distinctes
  (pris/prise/prises), le 4e choix vient forcément d'un autre verbe ("rangées") — sans l'infinitif,
  "Les photos que j'ai rangées" reste une phrase grammaticalement ET semantiquement valide,
  contrairement aux autres lignes où la forme fautive est éliminée par le seul accord de genre/
  nombre — parenthèse gardée sur ces 2 lignes seulement.
  **3 bugs de contenu trouvés en cours de route, sans rapport avec les parenthèses, corrigés** :
  (1) une "prisent" de la famille "prendre" (id 12035) n'est pas un mot français valide — remplacée
  par "prenez", cohérent avec les distracteurs "prenez" déjà utilisés ailleurs dans la même
  famille ; (2) 6 lignes de la famille "prendre" utilisaient un choix cassé "prise_x" comme 4e
  distracteur (ids 37610, 37665, 37759, 37779, 37829, 37904) — remplacé par un vrai mot d'un autre
  verbe, au bon nombre pour rester éliminable par l'accord (ex. "perdue" au singulier dans une
  question sur un antécédent pluriel) ; (3) **52 lignes de la famille relative ("Les X que/qu'...")
  avaient une bonne réponse marquée au SINGULIER alors que l'antécédent est pluriel** (ex. id 37767
  "Les photos qu'il a ___." donnait "offerte" comme correcte au lieu de "offertes") — bug
  pré-existant, sans lien avec le retrait des parenthèses, repéré en vérifiant l'accord de chaque
  ligne programmatiquement ; corrigé en promouvant la forme plurielle déjà présente parmi les 4
  choix (jamais besoin d'inventer un mot). Revalidé : 1000 lignes, 0 doublon id/texte/choix,
  0 ligne suspecte à l'accord pluriel (vérification programmatique dédiée), 2 parenthèses
  restantes (exception documentée ci-dessus).

Aucune tranche d'id consommée (règle 2). Étendue non couverte : seule `conjugaison/` a été
vérifiée pour la présence de parenthèses (aucune trouvée) — un audit d'accord programmatique
similaire à celui fait sur cm2/grammaire n'a pas été refait sur toutes les familles de
`conjugaison/`, à faire si un bug de ce type y est un jour signalé.

## Comptage de lettres restant en cm1/cm2 orthographe, remplacé (2026-08-31)

**Retour utilisateur** (capture d'écran, "Combien de 'r' dans le mot 'anniversaire' ?") : "remplace
toutes les questions de francais contenant des questions: 'combien de XXX dans le mot...' car a
l'ecrit ce nest pas coherent et cest inutilise comme question." Rappel du même bug déjà traité le
2026-08-XX précédent sur `ce1/orthographe` et `cp/french` (998 lignes) — mais `cm1/orthographe` et
`cm2/orthographe` n'avaient jamais été couverts par cette passe-là et contenaient en réalité
l'essentiel de leur contenu sous cette forme : **714/1000 lignes en cm1, 648/1000 en cm2**.
Recherche confirmée sur tout `csv/questions/` : plus aucune occurrence nulle part après cette
passe.

Question posée à l'utilisateur sur la famille de remplacement (3 options) : **choix "familles déjà
prévues au programme"** — CM1 = doublement de consonnes, CM2 = accents/orthographe d'usage
(scope déjà écrit dans `FRANCAIS_DIFFICULTE.md` pour ces 2 classes).

- **Nouvelle famille "orthographe correcte"** (mêmes ids, mêmes 714/648 lignes) : "Ce mot de N
  lettres commence par 'X', se termine par 'Y' et contient la lettre 'Z'. Quelle est la bonne
  orthographe ?" avec le mot correct + 3 fautes plausibles générées à partir du mot réel
  (doublement/dédoublement d'une consonne, permutation de 2 lettres adjacentes, et pour cm2 en
  priorité une variante d'accent). Le mot lui-même n'est jamais donné en clair dans la question
  (seule sa longueur + 1re/dernière lettre + une lettre qu'il contient, qui reste vraie pour les 4
  choix) — remplace le comptage oral par une reconnaissance visuelle de l'orthographe, exercice
  écrit par nature. Ancienne lettre testée (déjà présente dans les données d'origine) réutilisée
  comme la lettre "à surveiller" dans le nouvel énoncé plutôt que jetée, pour garder le lien avec
  le point d'orthographe d'origine (double consonne notamment).
- **Doublons de texte évités** : 478 mots uniques en cm1 pour 714 lignes, 437 pour 648 en cm2 (un
  mot testé sur 2 lettres différentes à l'origine donne 2 lignes) — la lettre mentionnée dans
  l'énoncé suffit à distinguer la plupart des répétitions ; 66 lignes cm1 et 61 cm2 où 2 mots
  différents partageaient par coïncidence longueur+1re+dernière lettre+lettre testée ont basculé
  sur une formulation alternative (même contenu, phrasé différent) pour rester uniques.
- Revalidé : 1000 lignes par fichier (inchangé), 0 doublon id/texte/choix, 0 ligne malformée, 0
  ligne "Combien de" restante sur les 2 fichiers.

Aucune tranche d'id consommée (règle 2) — contenu remplacé à l'intérieur des ids existants
uniquement.

## Audit de cohérence sémantique complet, tous fichiers français (2026-08-31 / 2026-09-01)

**Retour utilisateur** : après le signalement d'une incohérence isolée ("Mes villages sont ___.",
capture d'écran, une possession impossible pour un enfant), demande explicite d'un audit exhaustif
de la cohérence de phrase (pas seulement grammatical, sémantique aussi) sur les 13 fichiers
français restants (`cp/french` + `{ce1,ce2,cm1,cm2}/{grammaire,conjugaison,orthographe}}`),
"fait le serieusement afin de ne pas avoir a revenir dessus meme si la tache est enorme". Mené
fichier par fichier, méthode : extraction des gabarits de phrase par regex, classification
famille par famille, échantillonnage manuel systématique + vérifications programmatiques ciblées
(accord sujet-verbe, cohérence de genre, doublons). Aucune tranche d'id consommée nulle part
(règle 2) — uniquement du contenu réécrit à l'intérieur des ids existants.

- **`ce2/orthographe/generated.csv`** : la famille "Mes {nom} sont ___." (signalée par
  l'utilisateur) — 5 lignes corrigées en remplaçant "Mes" par un gabarit déjà utilisé dans le
  fichier sans possession personnelle impossible : id 33345 "Mes villages"→"Ces villages", 33229
  "Mes murs"→"On dirait que ces murs", 33301 "Mes bureaux"→"On dirait que ces bureaux", 33332 "Mes
  toits"→"Ces toits deviennent", 33868 "Mes arbres"→"Je trouve ces arbres" (chaque gabarit vérifié
  libre pour son nom pour ne pas créer de doublon de texte). Un 6e cas de la même famille repéré
  pendant l'audit complet : id 33272 "Mes jardins sont ___." (posséder plusieurs jardins
  personnels n'a pas de sens) → "Les jardins sont ___.". Deux paires synonyme/contraire à POS
  incohérent (nom vs adjectif) corrigées : id 10113 "fatigue"(nom)→"épuisé"(adj) devient
  "fatigue"→"épuisement" ; id 33083 "épuisé"(adj)→"fatigue"(nom) devient "épuisé"→"fatigué".
- **`cp/french/generated.csv`** : 3 paires synonyme/contraire imprécises ou fausses corrigées :
  id 2412 "contraire de 'gris'" (couleur, pas d'opposé logique) → mot cible changé pour "terne"
  (contraire "coloré" inchangé) ; id 2428 "contraire de 'aride'" → "mouillé" (imprécis) remplacé
  par "humide" (contraire réel) ; id 2498 "synonyme de 'chaud'" → "tiède" (signifie l'inverse
  nuancé, pas un synonyme) remplacé par "brûlant".
- **`ce1/orthographe/generated.csv`** : 21 lignes de la famille "___ très ADJ aujourd'hui."
  (ids 30039-30098) avaient un prénom féminin (Marie/Lea/Zoé) mais l'adjectif fixe de la phrase
  restait au masculin — corrigé par un accord genre/prénom explicite. 2 paires synonyme
  corrigées : id 2369 "fatigue"(nom)→"épuisé"(adj) devient "fatigue"→"épuisement" ; id 30955
  "repas"→"goûter" (imprécis, un goûter n'est qu'un des repas) → mot cible changé pour
  "collation" (réponse "goûter" inchangée, devient un synonyme correct). 1 ligne supplémentaire
  trouvée en repassant sur tout le fichier : id 30884 "synonyme de 'rapide'" avait pour réponse
  "vite" (un adverbe, alors que les 3 distracteurs — triste/lent/petit — sont des adjectifs) →
  remplacé par "vif" (adjectif, cohérent avec la famille grammaticale attendue).
- **`ce1/grammaire/generated.csv`** : 35 lignes de la famille féminin/masculin d'adjectifs
  invariables avaient un distracteur cassé se terminant en "...zzz" (artefact du générateur, ex.
  id 28705 "sociablezzz") → remplacé par un vrai mot voisin par doublement de consonne (ex.
  "ssociable"). **Bug systématique plus important trouvé en repassant sur toute la famille
  féminin/masculin** : les 16 paires d'adjectifs en "-eux" (joyeux, peureux, généreux, courageux,
  silencieux, merveilleux, délicieux, ennuyeux, chanceux, malheureux, affreux, nerveux,
  poussiéreux, orageux, venteux, hasardeux) donnaient un féminin fautif en "-ese" au lieu de
  "-euse" (ex. "joyeux"→"joyese" au lieu de "joyeuse") — la lettre "u" manquait systématiquement,
  touchant 32 lignes au total (16 questions "quel est le féminin" + 16 "quel est le masculin",
  ids 28094-28125, y compris dans le texte de la question elle-même pour les questions
  "masculin"). Corrigé par remplacement de suffixe sur les 16 racines. Revalidé : 0 doublon
  id/texte, 0 forme "-ese" résiduelle.
- **`ce1/conjugaison/generated.csv`** : aucun bug trouvé (gabarit unique "Comment conjugue-t-on
  le verbe X avec Y au présent ?", 1000 lignes, vérification programmatique de cohérence
  pronom/terminaison et de non-contradiction entre lignes du même verbe+pronom).
- **`ce2/grammaire/generated.csv`** et **`ce2/conjugaison/generated.csv`** : aucun bug trouvé
  (familles pronom de remplacement, type de phrase, sujet du verbe, conjugaison présent/imparfait/
  futur simple — vérifications programmatiques d'accord + échantillonnage manuel systématique).
- **`cm1/grammaire/generated.csv`** : aucun bug trouvé (famille fonction du mot dans la phrase,
  accord du participe passé avec être, déterminants possessifs/démonstratifs — échantillonnage
  manuel large, tout cohérent).
- **`cm1/orthographe/generated.csv`** : 9 lignes de la famille "Range ___ [nom] ici." utilisaient
  un nom qu'on ne peut pas "ranger" (une pièce entière : chambre/salle/cour/classe/cuisine/cave/
  forêt, ou un concept abstrait : chanson/réponse) — noms remplacés par des objets portables
  réels (montre, gomme, trousse, règle, balle, brosse, casquette, ceinture, corbeille). 5 lignes
  de la famille "..., près de la [nom]." (sac laissé "près de" un point de repère) utilisaient un
  nom abstrait non localisable spatialement (chanson/histoire/idée/réponse/adresse, ces deux
  derniers en plus avec une élision manquante "la adresse"/"la idée") → remplacés par des noms de
  lieux/objets concrets (table, fenêtre, porte, lampe, bibliothèque). 1 erreur de réponse
  correcte trouvée dans la famille "mot invariable" : id 36204 marquait "seul" (un adjectif
  variable) comme le mot invariable de la phrase alors que "dans" (préposition) est le seul mot
  réellement invariable parmi les 4 choix — bonne réponse corrigée.
- **`cm1/conjugaison/generated.csv`** : 12 lignes avaient "passe compose" sans accents au lieu de
  "passé composé" dans l'énoncé (ids 11070-11081), incohérent avec les 212 autres lignes du même
  gabarit correctement accentuées — corrigé, ce qui a fait apparaître 2 doublons de texte exacts
  avec des lignes déjà accentuées ailleurs dans le fichier (même verbe+pronom+temps) : id 11072
  "dire"/"nous" → changé en "dire"/"tu" ; id 11073 "faire"/"il" → changé en "faire"/"elle" (formes
  de remplacement vérifiées libres). Revalidé : 0 doublon id/texte, 0 incohérence de conjugaison
  restante (vérification programmatique sur les 4 temps).
- **`cm2/grammaire/generated.csv`** : 10 lignes de la famille "complément circonstanciel de
  manière" (sujet+verbe+adverbe générés séparément) associaient un verbe d'intention/de vie à un
  sujet inanimé ou une force de la nature, rendant la phrase absurde plutôt que simplement
  fantaisiste (ex. "La rivière agit honnêtement.", "Le vent vit dans la forêt.", "La pluie
  travaille sérieusement.", "Le train se cache derrière la maison.", "Mon frère brille dans le
  ciel.") — sujets remplacés par des personnes/animaux capables de l'action décrite (commerçant,
  renard, ouvrier, chat, étoile, etc.), formes vérifiées libres de collision. 1 accord sujet-verbe
  faux corrigé dans la même passe : id 37282 "Les oiseaux écoute attentivement." → "écoutent".
- **`cm2/conjugaison/generated.csv`** : 12 lignes "passe compose" + 10 lignes "passe simple" sans
  accents (ids 12040-12049 et 12060-12069) corrigées en "passé composé"/"passé simple", cohérent
  avec le reste du fichier. 2 bugs de contenu trouvés au passage dans la famille passé composé :
  ids 12046/12047 (verbe "tomber") donnaient "il est tombe"/"ils sont tombes" comme bonne réponse
  (accent manquant sur le participe lui-même, pas juste un distracteur) → corrigé en "tombé"/
  "tombés". La correction des accents a fait apparaître 11 doublons de texte exacts avec des
  lignes déjà correctement accentuées ailleurs (même verbe+pronom+temps) — résolus en changeant le
  pronom des 11 lignes dupliquées vers un pronom encore libre pour ce verbe (tu/elle/elles selon le
  cas, formes de passé simple/composé dérivées correctement, aucune ne change en genre pour le
  passé simple). Revalidé : 0 doublon id/texte, 0 incohérence de conjugaison sur les 4 temps
  (présent/imparfait/plus-que-parfait/conditionnel présent/passé composé/passé simple).
- **`cm2/orthographe/generated.csv`** : 2 lignes "orthographie" sans accent au lieu de
  "orthographié" dans l'énoncé (ids 12115, 12116) corrigées, ce qui a fait apparaître 2 doublons
  de texte exacts avec 2 lignes déjà correctement accentuées ailleurs — les 2 mots ciblés
  remplacés par 2 nouveaux mots inédits dans le fichier (anniversaire, restaurant). Reste du
  fichier (préfixes, suffixes, accents, homophones quand/quant/qu'en, sans/s'en/sens, tout/tous)
  vérifié sans anomalie.

Revalidé sur les 13 fichiers après cette passe : aucun doublon id/texte/choix, comptes de lignes
inchangés (1000 chacun, sauf `cp/french` déjà à 1000), aucune tranche d'id consommée. **Rappel
obligatoire** : relancer `tools/admin/import_questions.gd` dans l'éditeur Godot pour que ces
corrections apparaissent en jeu (pas encore fait, éditeur non disponible dans cette session).

## Suppression totale des indices entre parenthèses en orthographe, 4 classes (2026-09-01)

**Retour utilisateur** (capture d'écran, "Tu ___ répondre à la question (capacité)." trouvé en
CM1 orthographe malgré l'audit du 2026-08-31) : demande de repasser sur **tous** les fichiers
`orthographe/generated.csv` et de supprimer les parenthèses, sans exception cette fois (au lieu
du principe précédent "on retire seulement si ça fuite/est redondant, on garde si c'est un
désambiguïsateur nécessaire"). `ce1/orthographe` et `ce2/orthographe` avaient déjà 0 parenthèse ;
tout le travail a porté sur `cm1/orthographe` (146 lignes) et `cm2/orthographe` (57 lignes).

- **Famille "mot de N lettres... (il contient la lettre 'X')."** (53 lignes cm1, 54 lignes cm2) :
  ce n'est pas un indice qui fuite la réponse (voir famille jumelle, majoritaire dans les mêmes
  fichiers, qui écrit la même information sans parenthèse : "commence par X, se termine par Y et
  contient la lettre Z.") — juste une variante de formulation utilisée à l'origine (2026-08-31)
  pour les mots en collision de longueur/1re/dernière lettre/lettre testée avec un autre mot du
  fichier, précisément pour ne PAS dupliquer le texte de la formulation principale. Reformuler
  telle quelle en "..., se termine par Y et contient la lettre Z." (comme demandé, sans
  parenthèse) aurait donc recréé exactement les doublons que la formulation alternative évitait —
  confirmé : 56 doublons de texte immédiats après un premier essai naïf. Corrigé par une **3e
  formulation, toujours sans parenthèse mais distincte des deux autres** : "commence par 'X' et
  se termine par 'Y', avec la lettre 'Z' en plus." Revalidé : 0 doublon.
- **Famille peu/peux/peut/pouvez/pouvons/peuvent** (~40 lignes cm1, ex. l'exemple signalé) : le
  sujet grammatical de la phrase (je/tu/il/elle/nous/vous/ils) désigne déjà, à lui seul, la seule
  conjugaison possible parmi les 4 choix — la glose entre parenthèses ("capacité", "quantité",
  "autorisation"...) n'a jamais été nécessaire ici, contrairement à la famille "mots invariables"
  de `cm1/orthographe` où ce même type de glose reste indispensable (voir note du 2026-08-31, non
  concernée par cette famille-ci). Parenthèse retirée sans autre changement.
- **Familles là/l'a/las/l'as, sans/s'en/sens/sang** (cm1 + cm2) : même logique, le sujet/la
  construction de la phrase élimine déjà les 3 mauvaises formes ; parenthèse retirée seule. 2
  retraits ont fait apparaître un doublon de texte exact avec une ligne déjà sans parenthèse
  ailleurs dans `cm2/orthographe` ("Il part ___ tarder." / "Ce parfum a un bon ___.") — corrigés
  en changeant le sujet/l'objet de l'une des deux lignes ("Elle part..." / "Ce gâteau a un bon...").
- **Familles d'adverbes proches (plutôt/plus tôt/plus tard, jamais/toujours/souvent/rarement,
  vraiment/beaucoup/assez/trop/très, et une trentaine de lignes d'adverbes isolés type
  subitement/brusquement/désormais/naguère...)** : contrairement aux familles ci-dessus, retirer
  la parenthèse ici aurait dans plusieurs cas laissé une phrase réellement ambiguë entre 2 choix
  ou plus (ex. "plus tôt que prévu" et "plus tard que prévu" sont tous les deux grammaticalement
  et sémantiquement valides sans autre indice). Pour ces ~20 lignes, la parenthèse n'a pas été
  simplement supprimée mais **remplacée par une clause ajoutée dans la phrase elle-même** (pas de
  parenthèse, information intégrée naturellement) qui ne laisse plus qu'une seule réponse
  plausible — ex. id 11091 "Nous sommes arrives ___ que prévu (avant l'heure)." (avec en prime une
  faute de participe "arrives" au lieu de "arrivés") devient "Nous sommes arrivés ___ que prévu,
  avec vingt minutes d'avance." ; id 36053 "Il y a ___ d'élèves dans cette école (une grande
  quantité)." devient "Il y a ___ d'élèves dans cette école : plus de mille répartis dans quarante
  classes." **Un vrai bug de contenu trouvé au passage** dans cette famille : id 36780 "Ce chien
  aboie ___, presque chaque fois qu'il entend du bruit (un grand nombre de fois)." donnait
  "brièvement" (durée) comme bonne réponse alors que la phrase elle-même orientait vers une
  réponse de fréquence (souvent) — texte entièrement revu en "Ce chien aboie ___ à chaque fois,
  puis se calme aussitôt." pour que "brièvement" (durée du aboiement, pas fréquence) redevienne
  cohérent avec sa propre question.

Revalidé sur les 4 fichiers `orthographe/generated.csv` : **0 parenthèse restante** (recherche
programmatique du caractère `(` sur les 4 fichiers), 0 doublon id/texte/choix, 1000 lignes chacun
(inchangé). Aucune tranche d'id consommée (règle 2). Périmètre : uniquement `orthographe/` sur
demande explicite de l'utilisateur — `grammaire/` et `conjugaison/` n'ont pas été rebalayés pour
ce même motif dans cette passe (l'audit du 2026-08-31 avait déjà traité leurs parenthèses
existantes, voir section correspondante ci-dessus ; à revérifier séparément si un nouveau cas y
est un jour signalé). **Rappel obligatoire** : relancer `tools/admin/import_questions.gd` dans
l'éditeur Godot pour que ces corrections apparaissent en jeu.

## Majuscule fautive sur le 2e sujet, famille et/est/es/ai en ce1/orthographe (2026-09-01)

**Retour utilisateur** (capture d'écran) : "Le hérisson ___ La couturière bricolent." — le "La"
du deuxième sujet ne devrait pas être en majuscule (règle de base : une majuscule seulement en
début de phrase). Bug isolé à `ce1/orthographe/generated.csv`, famille "Sujet1 ___ Sujet2
VERBE(pluriel)." qui teste l'homophone et/est/es/ai : quand le 2e sujet est un nom commun avec
article (le/la/l') plutôt qu'un prénom propre, le générateur d'origine avait gardé l'article en
majuscule. **43 lignes concernées** (ids 30271-30447 dans cette même famille), confirmé par
recherche programmatique du motif " ___ Le "/" ___ La "/" ___ L'" sur les 38 fichiers CSV du
projet — bug **isolé à ce seul fichier**, aucune autre matière/classe touchée par ce même motif
(les familles équivalentes de `ce2/orthographe`, `ce2/grammaire`, etc. n'utilisent que des
prénoms propres en 2e position, jamais un nom commun avec article). Corrigé en minusculant l'
article du 2e sujet uniquement (Le→le, La→la, L'→l'), le 1er sujet en tête de phrase — qu'il
s'agisse d'un prénom ou d'un nom commun avec article ("Le renard...", "L'abeille...") — restant
inchangé puisqu'il est correctement en début de phrase. Revalidé : 1000 lignes (inchangé), 0
doublon id/texte/choix. Aucune tranche d'id consommée.

## Simplification de la famille "reconnaissance d'orthographe", cm1/cm2 (2026-09-01)

**Retour utilisateur** (capture d'écran, "Ce mot de 11 lettres commence par 'i', se termine par
't' et contient la lettre 'l'. Quelle est la bonne orthographe ?") : demande de retirer la
description du mot dans l'énoncé de toute la famille et de ne garder que "Quelle est la bonne
orthographe ?" — **consigne posée pour l'avenir** : ce format simplifié (question neutre + 4
graphies parmi lesquelles une seule est correcte) devient désormais le remplacement standard pour
toute question d'orthographe jugée non adaptée.

Famille concernée : celle créée le 2026-08-31 en remplacement des questions "Combien de lettres"
(voir section correspondante plus haut), présente uniquement dans `cm1/orthographe` (714 lignes)
et `cm2/orthographe` (648 lignes) — confirmé absente des 36 autres fichiers CSV. Elle avait pris
**5 formulations différentes** au fil des sessions successives (la principale "commence par X, se
termine par Y et contient la lettre Z.", plus 4 variantes alternatives créées pour éviter des
collisions de texte entre mots partageant longueur/1re/dernière lettre/lettre testée : "commence
par X et se termine par Y, avec la lettre Z en plus.", "qui commence par X, finit par Y et
comporte un Z.", "Voici un mot de N lettres qui commence par X, finit par Y et comporte un Z.",
"il commence par X, se termine par Y, et on y trouve la lettre Z.") — les 5 réduites à la même
question neutre "Quelle est la bonne orthographe ?", sans distinction de longueur/lettres.

**Effet de bord attendu et accepté** : plusieurs centaines de lignes partagent désormais le même
texte de question (le test repose entièrement sur les 4 graphies proposées en réponse, plus sur
l'énoncé) — differemment des autres familles du projet où un texte dupliqué signale un vrai
doublon de contenu, ici les 4 choix restent le contenu réel de la question. **Mais 18 lignes de
`cm1/orthographe` se sont révélées être de véritables doublons complets** (même mot ET mêmes 4
graphies, testé deux fois sous deux anciennes formulations différentes désormais fondues en un
texte identique) — remplacées par 18 mots inédits dans le fichier (cahier, atelier, aventure,
peinture, ceinture, toiture, limonade, biscuit, chapeau, pantalon, chaussure, campagne, fenêtre,
toboggan, dragon, sorcière, monstre, cascade), avec 3 fautes plausibles générées selon le même
principe que le reste de la famille (doublement de la 1re lettre, doublement d'une consonne
centrale, permutation des 2 dernières lettres). `cm2/orthographe` n'avait aucun doublon complet de
ce type. Revalidé sur les 2 fichiers : 1000 lignes chacun (inchangé), 0 doublon id, 0 doublon
(texte + jeu de 4 choix) exact, 0 trace des anciennes formulations descriptives. Aucune tranche
d'id consommée (règle 2).

## Adjectifs incohérents sur des objets inanimés, ce2/orthographe (2026-09-01)

**Retour utilisateur** (capture d'écran, "Regarde, cette robe est ___." avec bonne réponse
"paresseuse") : "je trouve encore du contenu qui n'a qucun sens, audit des csv d'orthographe,
modifie les mots pour que les phrases proposées soient coherente dans le sens pas simplement au
niveau de l'orthographe ou de la grammaire." Une robe ne peut pas être "paresseuse" — l'adjectif
est grammaticalement correct (accord au féminin singulier) mais sémantiquement absurde appliqué à
un vêtement.

**Ampleur** : famille d'accord d'adjectif via copule (sembler/paraître/avoir l'air/devenir/être,
204 lignes) confirmée présente uniquement dans `ce2/orthographe` (absente des 3 autres fichiers
orthographe et de `cp/french`, vérifié par recherche). Sur les 204, **28 lignes** avaient une
bonne réponse sémantiquement incompatible avec le nom testé : traits de personnalité/émotion sur
un objet (jupe **maligne**, chaise **gentille**, nuages **gentils**, route **heureuse**, gants
**timides**, étoiles **paresseuses**), goût sur un non-comestible (ballons **amers**, oiseaux
**sucrés**, nuages **salés**), forme/texture impossible (oiseaux **plats**, chatte **plate**, chats
**pointus**, soupe **pointue**, histoire **pointue**), courtoisie sur un objet (rivière/fleur/toits/
pantalons **polis** — sens "poli"=courtois, pas "poli"=lisse, incohérent ici), style/époque sur la
nature (nuages/rivières **modernes**), mutisme anthropomorphisant des arbres (**muets**), ou
émotion/texture alimentaire sur du bâti (maisons/étoiles **tendres**, jardins/manteaux **actifs**,
livres/soupes **calmes**).

**Fix** : seule la colonne "bonne réponse" (colonne 3) remplacée par un adjectif physiquement
plausible pour le nom concerné, même position dans la ligne, distracteurs (colonnes 4-6, déjà des
mots génériques sans lien sémantique par construction de cette famille) laissés inchangés — ex.
`33856;Regarde, cette robe est ___.;paresseuse;paresseux;paresseuses;gentilles` →
`...;déchirée;paresseux;paresseuses;gentilles`. Vérifié pour chaque ligne que le nouveau mot ne
collisionne pas avec un distracteur déjà présent (0 collision).

**Deuxième passe, seuil resserré (même jour)** : l'utilisateur a rejeté ma première coupure
("cette gomme est silencieuse" jugé "pas français" faute de tout contexte le justifiant), obligeant
à revoir à la hausse l'exigence : une phrase ne reste que si un locuteur français la dirait
spontanément, sans contexte supplémentaire ni interprétation en seconde lecture. **12 lignes de
plus corrigées** sur cette base : gomme **silencieuse**/**muette** (×2, remplacé par "rose"),
image **silencieuse** (→ floue), cantine **plate** (→ bruyante), récréation **brillante**/
**curieuse** (→ animée / calme), jupe **forte** (→ longue), manteaux **durs** (→ chauds), robe/
valise/tarte **curieuse** (→ usée / abîmée / brûlée), sacs **vifs** (→ neufs), voitures **plates**
(→ rapides). Cas confirmés comme passant le nouveau seuil et volontairement laissés : "cette cour
est silencieuse" (description standard d'une cour d'école calme), "cette étoile est carrée"
(forme décorative, cohérent avec "cartables ronds" déjà accepté).

**Troisième passe (même jour)** : "ces gâteaux sont gourmands" rejeté à son tour — "gourmand"
qualifie une personne (ou un animal) qui aime manger, pas la nourriture elle-même ; on dirait
"appétissants" pour décrire des gâteaux. Corrigé (id 33943). Leçon retenue : une expression figée
ou courante ne suffit pas à justifier un mot si ce mot reste, par nature, un trait réservé aux
êtres vivants — même écart que "paresseuse/gentille" corrigés à la première passe, juste plus
discret. Total : **41 lignes corrigées** sur les 204 de la famille. Revalidé : 1000 lignes
(inchangé), 0 doublon id, 0 doublon texte, 0 collision bonne-réponse/distracteur.

**Quatrième passe (même jour)** : capture d'écran "Ces manteaux sont ___." avec 4 choix tous des
variantes de "salé" — recherche exhaustive dans le CSV actuel : aucune ligne ne correspond à cette
structure (4 choix identiques en racine). La ligne la plus proche, id 33456 ("Ces manteaux sont
___.;neufs;salé;salée;salées"), avait une bonne réponse déjà correcte ("neufs") mais des
distracteurs orphelins d'une ancienne version ("salé" et ses variantes, sans lien avec "neufs") —
nettoyée en `neufs;neuf;neuve;neuves` par cohérence. **Cette incohérence structurelle ne
correspond pas exactement à la capture d'écran** (qui montre 4 variantes de "salé", aucune
"neufs") : les `.tres` en jeu n'ont vraisemblablement pas été régénérés depuis plusieurs
corrections de cette session — voir rappel `tools/admin/import_questions.gd` en fin de session.
Recherche élargie par mots-clés (salé/sucré/amer/gourmand/paresseux/gentil/timide/malin/poli/
muet/tendre/moderne/actif) sur la bonne réponse de tous les fichiers orthographe + cp/french :
tous les autres résultats sont des usages valides (vocabulaire synonyme/contraire, adjectifs sur
des animaux, "toits pointus"/"étoile pointue"/"rue active"/"villages modernes" — descriptions
naturelles) — aucun autre nonsens trouvé.

## Trou "___" manquant dans 62 lignes, cm1/grammaire (2026-09-01)

**Retour utilisateur** (capture d'écran, "Les garçons sont tombés de leur vélo." affiché comme
énoncé complet avec 4 choix tombées/tombé/tombée/tombés à cliquer, sans aucun trou visible dans la
phrase) : "trouvé des questions ou il n y a pas de trou dans la phrase, audit les fichiers et
corrige." Cause identifiée : bug auto-introduit plus tôt dans cette session lors de la correction
"Faux verbes copules devant un participe passé" (voir section correspondante) — le 3e lot de cette
correction (familles "restait/restaient", "demeure/demeurent" et le cas isolé "paraissaient", 61+1
lignes, ids 34202-34957 et 34660) a été réécrit en phrase complète avec la bonne réponse déjà
insérée dans le texte, en oubliant de remettre le "___" à la place du participe testé. Les deux
lots précédents de la même correction ("sembler" 56 lignes, "paraître" 52 lignes) avaient
correctement gardé le "___" et n'étaient pas concernés.

**Fix** : les 62 lignes retrouvées via recherche par id parmi celles touchées par la correction
précédente, réponse correcte (colonne 3) repérée littéralement dans le texte et remplacée par
"___" (occurrence unique vérifiée avant remplacement dans chaque cas, aucun cas ambigu). Exemple :
"Les garçons sont tombés de leur vélo." → "Les garçons sont ___ de leur vélo." Choix de réponse
inchangés. Revalidé : 1000 lignes (inchangé), 0 doublon id, 0 doublon texte, 0 trou manquant parmi
les lignes concernées.

**Audit élargi** : recherche projet entier de toute autre phrase déclarative (se terminant par un
point, pas une question) sans "___" mais dont les 4 choix partagent un préfixe commun significatif
(signature d'un trou oublié) — 0 résultat en dehors des 62 ci-dessus, confirmé après correction.
Les nombreuses familles "Comment conjugue-t-on...", "Quel est le pluriel de...", "Comment dit-on
..." etc. n'ont jamais de "___" par conception (la réponse n'est pas insérée dans une phrase à
trou mais donnée en toutes lettres dans les choix) — non concernées, écartées du diagnostic.

## Audit complet des parenthèses, tous fichiers CSV (2026-09-01)

**Retour utilisateur** (capture d'écran, "Regarde ___ maison, elle est superbe (celle-ci).") :
"encore un indice entre parenthese... fait un audit general des que tu trouves un ou plusieurs
mot entre parenthese tu supprime les parentheses et leur contenu (dans tous les fichiers csv)
classes et matieres." Contrairement au précédent audit (orthographe uniquement, suppression
inconditionnelle des indices), certaines parenthèses trouvées ici portaient une information
indispensable à la résolution de la question (règle de code, propriétaire d'un possessif, genre
d'un groupe, verbe à conjuguer) — les supprimer purement et simplement aurait rendu la question
ambiguë ou impossible à résoudre. Dans ces cas, l'information a été repliée dans la phrase (même
principe que l'audit orthographe précédent) plutôt que juste supprimée.

**Ampleur** : 397 lignes avec parenthèses trouvées dans 8 fichiers sur les 38 du projet
(confirmé absentes des 30 autres). Détail par fichier et traitement appliqué :

- `cm1/logique` (52) et `cm2/logique` (97) : règles de décodage indispensables ("Avec ce code
  (A=1, B=2, C=3…)", "Avec un décalage de +N (A devient X, B devient Y…)") — repliées dans la
  phrase sans parenthèses ("Avec le code où A=1, B=2, C=3, etc., ..."). Un cas différent, "(chaque
  paire = 2 amis)", était réellement redondant (le mot "paire" suffit) — supprimé sans reformuler.
  Un dernier cas, "le/la plus âgé(e)", était une notation d'écriture inclusive sans lien avec la
  réponse (les choix sont des prénoms) — simplifié en "le plus âgé" (masculin par défaut, usage
  standard en français pour ce type de comparatif).
- `cm1/grammaire` (193) : trois familles distinctes. (a) "(à moi/toi/nous/vous/eux/lui-elle)"
  (138 lignes, exercice de déterminant possessif) — le propriétaire n'était pas déductible du
  reste de la phrase, remplacé par une proposition introductive naturelle ("C'est à moi : ___
  chien aboie fort."). (b) "(celui-ci/celle-là/ceux-ci/...)" (53 lignes, exercice de déterminant
  démonstratif) — dans 50 cas le genre/nombre du nom suffisait déjà à déterminer la seule réponse
  grammaticalement valide parmi les 4 choix (parenthèse purement redondante, supprimée) ; dans 3
  cas les choix incluaient un possessif concurrent (Ses/Leurs) rendant la phrase réellement
  ambiguë sans la précision, résolu en accolant "-ci"/"-là" directement au nom ("___ fleurs-là
  sont magnifiques.", cohérent avec un usage déjà présent ailleurs dans le même fichier).
  **Effet de bord** : la suppression du duo -ci/-là a fait apparaître 8 doublons exacts (même
  texte, mêmes 4 choix) dans la famille "Regarde ___ NOM, il/elle est superbe" — un même nom
  testé deux fois (une version -ci, une version -là) donnait déjà la même réponse dans les deux
  cas, la distinction n'ayant jamais été pertinente pour la bonne réponse ; résolu en substituant
  un nom inédit du même genre/classe d'élision dans un exemplaire de chaque paire (garçon→ballon,
  animal→escargot, orage→oiseau, maison→rivière, hôtel→immeuble, étoile→forêt, bateau→tableau,
  avions→montagnes). (c) "(garçons)"/"(filles)" (2 lignes, accord de participe passé lié au genre
  d'un groupe implicite) — repliées en apposition naturelle ("Nous, les garçons, sommes ___ au
  parc.").
- `cm2/grammaire` (2) : "(prendre)" donnait l'infinitif du verbe à conjuguer, indispensable (les
  choix incluaient un distracteur d'un autre verbe, "ouvert") — reformulé en "Complète avec le
  participe passé du verbe 'prendre' : Ma tante a ___ des photos."
- `cm1/english` (7) : "(taille)" sur 'grand'/'petit' s'est révélé indispensable après coup — sa
  suppression a créé une collision avec deux questions préexistantes testant le même mot dans un
  autre sens ("grand"=big vs tall), détecté par la revalidation systématique et corrigé en
  repliant le contexte dans la phrase ("Quand on parle de la taille d'une personne, comment dit-on
  'grand' en anglais ?"). Les 5 autres lignes, "(e)"/"(ne)" sur des adjectifs de nationalité,
  n'étaient qu'une notation d'accord féminin sans lien avec la traduction anglaise (genre neutre
  en anglais) — supprimées sans reformulation.
- `cm2/english` (36) : "(hier)" était redondant (le passé composé français indique déjà le temps
  à traduire, et aucun distracteur ne joue sur le temps du verbe) — supprimé. Les "(e)" internes
  aux phrases citées ("je suis arrivé(e)") supprimés de la même façon que cm1/english.
- `cp/french` (9) : contextes de couleur ("(par beau temps)", "(dans les dessins)", "(à la
  plage)", "(le fruit)", "(la chair)", "dessiné") — repliés en modificateurs naturels sans
  parenthèses ("De quelle couleur est le ciel par beau temps ?"), sauf "citron pressé (le jus)"
  où la précision était redondante ("pressé" l'indique déjà) — supprimée sans reformulation.
- `ce2/english` (1) : "poisson (plat)" précisait que la réponse attendue est "fish dish" (plat) et
  non "fish" (l'animal) — indispensable, la question elle-même reformulée en "Comment dit-on 'plat
  de poisson' en anglais ?" plutôt que de garder une parenthèse.

Aucune tranche d'id consommée (règle 2), aucun choix de réponse modifié sauf dans les 8 doublons
cm1/grammaire ci-dessus (nouveau nom + distracteurs regénérés en cohérence). Revalidé sur les 8
fichiers touchés + re-scan des 38 fichiers du projet : 0 parenthèse restante nulle part, tous les
row counts inchangés, 0 doublon id, 0 doublon texte dans les fichiers modifiés (hors les
duplications de texte déjà connues et acceptées : famille "Quelle est la bonne orthographe ?" en
cm1/cm2 orthographe, voir [[feedback_orthographe_replacement_template]]).

## Faux verbes copules devant un participe passé, cm1/grammaire (2026-09-01)

**Retour utilisateur** (capture d'écran, "Nina semble ___." avec choix descendues/descendus/
descendu/descendue, question "est ce un meurtre? ou certaines questions ne veulent rien dire?") :
la famille d'accord du participe passé (verbes du groupe être — né/mort/parti/allé/venu/arrivé/
entré/sorti/monté/descendu/tombé/resté/retourné/passé/revenu/devenu/rentré) utilisait par endroits
un verbe d'encadrement qui n'est pas "être", ce qui rend la phrase bancale ou involontairement
glauque quand le participe testé est "mort"/"tombé"/"descendu" sans aucun contexte ("Nina semble
descendue.", "Timéo et Malo paraissent morts.", "Romain restait mort."). Consigne : remplacer ce
verbe par "être" (au temps qui convient) et ajouter un complément court et naturel à chaque phrase.

**Ampleur du bug** : confiné à `cm1/grammaire/generated.csv` (confirmé absent des 37 autres
fichiers, y compris `cm1/conjugaison`, après recherche des mêmes motifs). Quatre verbes
d'encadrement fautifs identifiés, cumulant **170 lignes** sur les 1000 du fichier :
"sembler" (56 lignes, ids 34182-34719), "paraître" y compris une occurrence à l'imparfait
"paraissaient" (53 lignes, ids 34189-34891), "rester" conjugué comme s'il pouvait servir
d'auxiliaire ("restait"/"restaient", 42 lignes, ids 34202-34957 — dont 2 cas où le participe
testé était "resté" lui-même, donnant l'absurdité "Paul restait resté.") et "demeurer"
("demeure"/"demeurent", 18 lignes, ids 34292-34940). Deux exceptions volontairement gardées :
la famille adjective "Cette maison semble/paraît/a l'air/devient verte." en `ce2/orthographe`
(79+79+43+4 lignes) n'est pas concernée — "sembler/paraître + adjectif" est parfaitement naturel,
seul "sembler/paraître/rester/demeurer + participe d'un autre verbe que lui-même" posait problème.

**Fix appliqué** : verbe d'encadrement remplacé par "être" au temps correspondant (présent pour
"demeure/demeurent" → "est/sont" ; imparfait pour "semblait/paraissait/restait/restaient" → était/
étaient — ici tous au présent sauf les 42 "restait/restaient" et 1 "paraissaient" passés à
l'imparfait), plus un complément court ajouté à chaque phrase pour la rendre naturelle et non
ambiguë (lieu, manière, ou contexte — ex. "Nina est descendue de l'arbre.", "Paul est arrivé à
l'école en retard."). Cas particulier du verbe "mourir" (5 occurrences : Hugo, Malo, Timéo et
Malo, Timéo, Lisa, Romain, Yasmine) : complément idiomatique "de rire"/"de faim"/"de fatigue"
choisi systématiquement plutôt qu'un complément neutre, pour éviter toute lecture macabre dans un
jeu destiné à des enfants (ex. "Hugo est mort de rire.", pas "Hugo est mort à la maison."). Aucune
tranche d'id consommée (règle 2), choix de réponse (colonnes 3-6) inchangés dans les 170 lignes —
seul le texte de la question a changé. Revalidé : 1000 lignes (inchangé), 0 doublon id, 0 doublon
texte, 0 trace résiduelle d'un verbe d'encadrement autre que "être" devant un participe seul.

## Audit "choix multiples dans l'énoncé", toutes classes et matières (2026-09-01)

**Retour utilisateur** (capture d'écran, "Quel mot est correctement orthographié : 1) 'raquette'
2) 'raquete' 3) 'raquettte' ?") : les propositions de réponse ne doivent jamais être répétées
dans le texte de la question puisqu'elles sont déjà affichées dans les boutons de choix cliquables
— demande explicite d'un audit complet sur les 38 fichiers CSV du projet (toutes classes CP-CM2,
toutes matières), pas seulement l'orthographe.

**Bug confirmé et corrigé** : famille "Quel mot est correctement orthographié : 1) 'X' 2) 'Y'
3) 'Z' ?" — 73 lignes, uniquement dans `cm2/orthographe/generated.csv` (confirmé absente des 37
autres fichiers via `grep` sur le motif littéral "1)"). Le texte listait 3 des 4 graphies déjà
présentes dans les colonnes de choix (incohérence en plus du doublon : la 4e graphie, un vrai
distracteur, n'apparaissait même pas dans l'énoncé). Remplacée partout par la question neutre
"Quelle est la bonne orthographe ?", conformément au format standard déjà établi le même jour pour
la famille "reconnaissance d'orthographe" (voir section précédente et
[[feedback_orthographe_replacement_template]]). Un cas particulier (id 39738, mot "aujourd'hui"
dont l'apostrophe cassait la regex générique à cause du guillemet simple) traité séparément à la
main. Revalidé : 1000 lignes (inchangé), 0 doublon id, 0 doublon (texte + jeu de 4 choix) exact,
0 occurrence restante du motif "1)".

**Recherche élargie** (au-delà du seul motif "1)") : recherche d'autres styles d'énumération
("2)", "a)", "A)", "1.", listes de mots entre guillemets consécutifs) sur les 38 fichiers — aucune
autre occurrence trouvée. Une vérification programmatique complémentaire (chaque ligne où ≥3 des 4
choix apparaissent littéralement dans le texte de la question) a remonté 369 autres lignes, mais
toutes se sont révélées être de faux positifs correspondant à des formats légitimes où
l'énumération fait partie intégrante et nécessaire de l'énoncé (pas une redite des boutons) :
questions de logique type "Parmi 12, 7, 34, 9 : quel est le plus grand nombre ?" (ce1/ce2/cm1/cm2
`logique`), déductions/comparaisons nommant les personnages ("Emma est plus âgée que Noah. Léa est
plus jeune que Noah. Qui est le plus âgé ?"), grilles numériques à compléter, et questions
"Quel est le singulier de 'grenouilles' ?" (le mot cible contient par construction des
sous-chaînes qui recoupent les distracteurs). Dans tous ces cas, l'énoncé ne fonctionnerait pas
sans cette information — contrairement au cas corrigé où elle était purement redondante avec les
boutons. Audit "classes et matières" considéré clos : le bug signalé n'existait que dans le seul
endroit trouvé et corrigé ci-dessus.

**Prochaine tranche libre : 45000-45999** (45e fichier).

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

## Audit cohérence sémantique + suppression parenthèses/choix intégrés, grammaire/orthographe
toutes classes (2026-09-02/03)

Série de retours utilisateur (captures d'écran successives) sur des questions grammaticalement
correctes mais sémantiquement absurdes ou mal formées, traités au fil de l'eau puis élargis en
audit complet sur demande explicite finale ("gros audit, modifie tout ce qui est nécessaire").
Aucune tranche d'id consommée, aucun compte de lignes modifié nulle part.

1. **Choix multiples recopiés dans l'énoncé** (`cm2/orthographe/generated.csv`, 73 lignes +
   1 cas apostrophe) : questions du type "Quel mot est correctement orthographié : 1) 'raquette'
   2) 'raquete' 3) 'raquettte' ?" recopiaient les 4 choix (déjà cliquables) dans le texte de la
   question. Uniformisé sur "Quelle est la bonne orthographe ?".
2. **Faux copule devant un participe** (`cm1/grammaire/generated.csv`, 170 lignes) :
   sembler/paraître/rester/demeurer utilisés à tort comme auxiliaire devant un participe passé
   (DR MRS VANDERTRAMP) au lieu du verbe être — lisait comme une phrase cassée ou involontairement
   sinistre ("Nina semble descendue."). Corrigé en être + complément naturel court ; "mourir" reçoit
   un complément idiomatique (de rire/faim/fatigue) pour éviter la lecture littérale. Voir
   [[feedback_fake_copula_participle]].
3. **Indices entre parenthèses, partout** (règle élargie à "supprime toute parenthèse dès que tu en
   croises une") : `cm1/grammaire` (193 lignes, rappels de personne "(à moi/toi/...)" et
   démonstratifs "(celui-ci/celle-là)"), `cm2/grammaire` (2 lignes, infinitif "(prendre)"),
   `cm1/logique` + `cm2/logique` (111+26 lignes, règles de chiffrement/comparaison), `cm1/english` +
   `cm2/english` (5+36 lignes, marqueurs de genre/temps), `cp/french` (9 lignes, contexte couleur),
   `ce2/english` (1 ligne). Redondant → supprimé ; porteur d'info → replié dans la phrase. Voir
   [[feedback_no_parentheses_anywhere]].
4. **Aucun "___" dans la phrase** (bug auto-introduit deux fois pendant la correction du point 2,
   capturé une fois par l'utilisateur et une fois en interne) : phrases réécrites avec la réponse
   déjà insérée en toutes lettres, blanc oublié. Corrigé en relocalisant le mot-réponse par regex et
   en le remplaçant par "___". Balayage de confirmation final (heuristique : phrase déclarative sans
   "___" dont les 4 choix partagent un préfixe long) : **0 occurrence restante sur tout le projet**.
5. **Adjectif/nom sémantiquement incohérent** (`ce2/orthographe/generated.csv`, famille "Nom ___
   (adjectif)"/"Regarde, Nom est/semble/paraît ___", 41 lignes sur 4 passes) : traits exclusivement
   humains/animaux (personnalité, appétit, émotion) réutilisés sur des objets inanimés ("cette robe
   est paresseuse", "cette gomme semble silencieuse", "ces gâteaux sont gourmands"). Remplacés par
   des catégories sans besoin de justification (couleur, taille, propreté, âge/état, texture). Voir
   [[feedback_no_unjustified_context_adjectives]].
6. **Sujet (animal) incompatible avec un verbe humain-only, à mono-sujet** (`ce2/grammaire/
   generated.csv`, famille conjugaison au présent "Sujet ___.", 6 lignes) : écureuils/tortues/
   dauphins/girafes affublés de verbes nécessitant mains/outils/langage (dessiner, préparer, placer,
   pâlir, rougir) — corrigés en verbes plausibles pour l'animal en question (grimpent, creusent,
   nagent, broutent...), les 4 colonnes de choix régénérées comme variantes de conjugaison du
   nouveau verbe (pas seulement la bonne réponse) pour rester cohérentes avec le style de distracteur
   de cette famille. Ids : 31835, 31836, 31882, 31915, 31873, 31931.
7. **Sujet (animal) incompatible avec un verbe humain-only, à double-sujet partagé** (`ce1/
   orthographe/generated.csv`, famille homophone et/est/es/ai "Sujet1 ___ Sujet2 verbe(pluriel).",
   2 lignes sur ~185 de la famille) : "Océane ___ le dauphin peignent." et "Le dauphin ___ la
   couturière bricolent." — un dauphin ne peut pas peindre/bricoler. Corrigé : le premier en
   changeant le verbe pour "nagent" (les deux sujets peuvent nager), le second en remplaçant le sujet
   "dauphin" par "pêcheur" (les deux sujets peuvent bricoler). Ids : 30363, 30443. Cette structure à
   double-sujet est confirmée unique à ce fichier (0 occurrence ailleurs dans le projet) ; c'est
   l'endroit structurellement le plus à risque pour ce bug puisque le même verbe doit convenir aux
   deux sujets simultanément — c'est l'exact scénario qui avait produit "Romy et l'infirmière
   volent." (id 30274, déjà corrigé lors d'une passe précédente de cette même famille).
8. **"Phrases trop simples"** (volet explicitement demandé en plus de l'incohérence) : audit des
   phrases déclaratives courtes (≤4 mots) dans les 13 fichiers grammaire/conjugaison/orthographe —
   la grande majorité sont des exercices d'accord sujet-verbe délibérément courts par construction
   ("Les enfants ___.") et n'ont pas été rallongés (rallonger casserait le format de l'exercice sans
   ajouter de valeur pédagogique, cohérent avec la préférence "jeu léger" — voir
   [[feedback_lightweight_game]]) ; seul le sous-cas où le sujet lui-même rend le verbe implausible
   (points 6-7 ci-dessus) a été jugé être le vrai problème visé par le retour utilisateur.

**Balayages de confirmation finaux (tous les fichiers grammaire/conjugaison/orthographe + cp/french
+ english + logique)** : 0 parenthèse restante, 0 ligne sans "___", 0 choix "1)/2)/3)" recopié dans
l'énoncé, 0 faux-copule devant participe, 0 autre incohérence sujet-verbe animal détectée (recherche
élargie sur ~35 verbes à capacité humaine uniquement croisés avec ~35 noms d'animaux). Chaque fichier
touché revalidé individuellement : compte de lignes inchangé, 0 doublon id, 0 doublon texte.

**Rappel obligatoire** : relancer `tools/admin/import_questions.gd` dans l'éditeur Godot pour
propager tous les changements CSV de cette session vers les `.tres` — un cas de `.tres`
manifestement obsolète a été repéré en cours d'audit (`ce2/orthographe` id 33456, contenu vu en jeu
introuvable dans le CSV actuel), suggérant que l'import n'a pas été relancé récemment.

## Audit majuscules des choix de réponse selon la position du trou (2026-09-03)

**Retour utilisateur** : quand le trou "___" est en tout début de phrase, les choix de réponse
doivent porter la majuscule (l'absence de majuscule est une faute) ; inversement, quand le trou est
au milieu d'une phrase, les choix ne doivent pas porter de majuscule (sauf si la majuscule
correspond à une vraie règle, ex. nom propre). Balayage programmatique sur les 13 fichiers
grammaire/conjugaison/orthographe + `cp/french` : position du trou déterminée par le premier mot de
l'énoncé (`___` en position 0 = début de phrase, sinon milieu — confirmé qu'aucune ligne du corpus
n'a de trou démarrant une seconde phrase interne, donc pas de faux négatif possible avec cette
méthode).

- **Trou en début de phrase, choix sans majuscule (9 lignes)** : `cm1/orthographe` (8 lignes,
  familles "plutôt/plus tôt/plus tard/plutard" ids 36045/36196 et "sitôt" id 36785 — dans ce
  dernier cas les 4 choix étaient entièrement en minuscule) et `cm2/orthographe` (1 ligne, id 12088,
  distracteur-anagramme "xuoT" de "Tout" retourné lettre à lettre). Toutes recapitalisées.
- **Trou au milieu de phrase, choix à tort capitalisés (800 lignes, 2 fichiers)** :
  - `cm1/grammaire/generated.csv` (740 choix sur 185 lignes) : famille déterminants possessifs
    "C'est à moi/toi/lui/nous/vous/eux : ___ chien aboie fort." — mon/ton/son/notre/votre/leur/ce/
    cette/etc. étaient restés capitalisés. **Cause identifiée** : régression auto-introduite lors de
    l'audit "parenthèses" du 2026-09-01/02 (voir [[feedback_no_parentheses_anywhere]]) — ces 138
    lignes étaient à l'origine `___ chien aboie fort. (à moi)` (trou en tête, majuscule correcte),
    repliées en `C'est à moi : ___ chien aboie fort.` (trou déplacé au milieu) sans repasser les 4
    choix en minuscule à cette occasion.
  - `ce2/orthographe/generated.csv` (60 choix sur 15 lignes) : famille homophone on/ont, ids
    33752-33766 ("Les enfants ___ faim.") — Ont/On/En/Ons capitalisés à tort en milieu de phrase.
- Tous les mots concernés vérifiés un par un avant correction : uniquement des mots grammaticaux
  courants (déterminants possessifs/démonstratifs, formes de avoir/on), aucun nom propre parmi eux
  — donc aucune exception légitime à la règle dans ce lot.

**Leçon retenue** : chaque fois qu'une correction déplace la position du trou dans une phrase
(notamment en repliant un indice entre parenthèses en clause de tête, voir
[[feedback_no_parentheses_anywhere]]), vérifier/mettre à jour la casse des 4 choix en même temps —
ajouté comme point de contrôle permanent, voir mémoire dédiée.

Balayage de confirmation final sur les 13 fichiers : **0 trou en début de phrase avec un choix en
minuscule, 0 trou au milieu de phrase avec un choix capitalisé restant**. Fichiers revalidés
individuellement : comptes de lignes inchangés (1000 partout), 0 doublon id/texte.

## Audit de classification grammaire/conjugaison/orthographe, CE1-CM2 (2026-09-03)

**Retour utilisateur** : vérifier qu'aucune question n'est classée dans le mauvais fichier parmi
les 3 matières `grammaire/conjugaison/orthographe`, et transférer si besoin. Audit programmatique
sur les 12 fichiers (`{ce1,ce2,cm1,cm2}/{grammaire,conjugaison,orthographe}`, 12 000 lignes) : regroupement
par famille (jeu de choix + gabarit de phrase) pour couvrir la totalité du contenu (pas seulement un
échantillon), puis recherche ciblée de signaux d'appartenance croisée dans les deux sens :

- Signal conjugaison ("comment conjugue-t-on", paradigme je/tu/il/nous/vous/ils d'un même verbe)
  recherché dans les fichiers `grammaire` et `orthographe` : **0 occurrence**.
- Signal orthographe ("bonne orthographe", "quel accent", "préfixe/suffixe", "mot invariable",
  jeux de choix homophones classiques et/est, on/ont, ces/ses, sa/ça, la/l'a, sans/s'en, quand/
  quant) recherché dans les fichiers `grammaire` et `conjugaison` : **0 occurrence réelle** (12 faux
  positifs initiaux dans `cm1/grammaire`, tous de la famille légitime "leur/leurs" déterminant
  possessif — pas l'homophone d'orthographe).
- Signal grammaire ("nature du mot", "quel pronom", "fonction de", "phrase de quel type",
  "complément circonstanciel", "subordonnée relative", "COD/COI/attribut du sujet") recherché dans
  les fichiers `conjugaison` et `orthographe` : **0 occurrence réelle** (2 faux positifs, substrings
  fortuits "coi" dans "coiffer" et "cod" dans "décodeur").
- Échantillonnage manuel aléatoire (15 lignes/fichier) sur les 3 fichiers `grammaire` les plus
  volumineux en familles distinctes (`ce2`, `cm1`, `cm2`) : conforme au scope de
  `FRANCAIS_DIFFICULTE.md` sur tout l'échantillon.

**Conclusion : aucune ligne mal classée entre grammaire/conjugaison/orthographe sur les 12 fichiers
— aucun transfert nécessaire.** Deux familles a priori surprenantes ont été vérifiées comme
correctement placées par convention pédagogique du cycle 2/3 (et non comme des erreurs) : l'accord
du participe passé (être en `grammaire` CM1, avoir en `grammaire` CM2) est un point de grammaire
(règle d'accord), pas de conjugaison (formation du temps) ; l'identification des mots invariables et
la reconnaissance de la bonne graphie sont classées en `orthographe`, jamais en `grammaire`.

**Observation annexe (hors périmètre strict de la demande, à trancher séparément si besoin)** :
plusieurs familles à caractère lexical plutôt qu'orthographique vivent dans des fichiers
`orthographe`, faute de matière "vocabulaire" dédiée dans le projet — ajouts historiques déjà
documentés et validés (voir notes `project_francais_500`/`ID_RANGES.md` plus haut), pas une
confusion accidentelle entre les 3 matières demandées : `ce1/orthographe` (111 synonymes, 52
mâle/femelle d'animaux, 24 "quel mois vient juste après/avant" — ce dernier point relève plutôt de
la logique/culture générale que du lexique), `ce2/orthographe` (81 synonymes + 105 contraires,
mais alignés avec le scope explicite de `FRANCAIS_DIFFICULTE.md` pour cette classe). Laissé en
l'état sans action, à signaler si l'utilisateur veut un traitement séparé.

## Repasse générale complète : maths, français, anglais (2026-09-07)

Suite à la demande "refait une repasse complete de tous les fichiers csv crées" (revalidation de
tous les fixes précédents + niveau maths par classe + cohérence français + zéro parenthèse +
sujet-verbe-complément minimum + zéro doublon anglais inter-années). Périmètre : tous les CSV
`{ce1,ce2,cm1,cm2}/math`, `{ce1,ce2,cm1,cm2}/{grammaire,conjugaison,orthographe}`, et
`{cp,ce1,ce2,cm1,cm2}/english`.

### 1. Maths — niveau par classe

- `ce1/math/generated.csv` : 12 lignes de multiplication hors scope (tables 3/4/6/7/8/9, alors que
  CE1 est limité aux tables 2/5/10 depuis une session antérieure) — ids 1262, 1266, 1267, 1268,
  1271, 1278, 1280, 1286, 1290, 1292, 1294, 1300, recalculées sur les tables 2/5/10 uniquement.
  Contenu résiduel d'avant l'instauration de cette règle.
- `ce1/math/generated.csv` (17 lignes) et `ce2/math/generated.csv` (22 lignes) : convention
  "longueur ≥ largeur" d'un rectangle violée (largeur > longueur dans l'énoncé) — corrigé par
  permutation des deux valeurs (symétrique pour périmètre/aire, aucune réponse changée).
- Reste du scope (CE1/CE2 addition-soustraction jusqu'à 999/9999, etc.) : conforme au programme
  cycle 2, aucune anomalie.

### 2. Français — cohérence de langage + sujet-verbe-complément minimum

- `ce2/orthographe/generated.csv` : 12 lignes où l'adjectif "court/courte" (dimension de longueur)
  était appliqué à des noms sans dimension de longueur saillante (valise, maison, chatte, chaise,
  sacs, oursons, soupe, vélos, lapins, arbres, chapeaux, fenêtre) — remplacé par un adjectif
  pertinent pour chaque nom (lourde, neufs, petite, cassée, noire, colorés, chaude, blancs, hauts).
  Glissé à travers deux audits précédents de la même famille de règle
  (voir [[feedback_no_unjustified_context_adjectives]]).
- `ce2/orthographe/generated.csv` id 33452 : "Une soupe ___." avec réponse "étroite" (incohérent,
  une soupe n'a pas de largeur) → "salée".
- Règle sujet-verbe-complément minimum (nouvelle, remplace le jugement d'une session antérieure
  selon lequel les phrases courtes type "Sujet ___." étaient acceptables comme exercices de
  conjugaison isolés) : toute phrase réduite à "Sujet Verbe/Participe/Adjectif." sans complément a
  été étoffée avec un complément cohérent.
  - `ce2/grammaire/generated.csv` : 66 lignes ("Les enfants ___ dans la cour de récréation.", "Le
    chat ___ le papillon.", etc.).
  - `cm1/grammaire/generated.csv` : 85 lignes (participe passé + être, complément de lieu/temps
    via dictionnaire lemme→complément : venu→chez nous, sorti→dans la cour, etc.).
  - `ce2/orthographe/generated.csv` : 118 lignes ("Une/Des X ___." → "Cette X est ___."/"Ces X sont
    ___." pour rester dans le gabarit rotatif déjà établi du fichier).
  - Dans ces 3 lots, quelques doublons auto-introduits (nouveau complément identique à une ligne
    préexistante) détectés par validation post-édition et corrigés par un choix de complément
    différent (ex. ce2/grammaire ids 31063/31064 ; deux accords sujet-pluriel/complément-singulier
    incohérents auto-introduits dans cm1/grammaire ids 34157/34927, corrigés en relecture manuelle).
- Reconfirmation des animaux à verbe implausible (6 lignes ce2/grammaire, 2 lignes ce1/orthographe)
  et des bugs de casse des choix (cm1/orthographe ids 36045/36196/36785, cm2/orthographe id 12088)
  déjà traités lors des audits précédents — revalidés sans régression.

### 3. Anglais — suppression des doublons inter-années (949 lignes)

Détection : 949 lignes en doublon exact (texte + bonne réponse) présentes dans plusieurs fichiers
`{cp,ce1,ce2,cm1,cm2}/english/generated.csv` — contenu généré à plat lors d'une session antérieure
sans vérification croisée entre classes. Choix utilisateur explicite (question posée) : **remplacer
le contenu dupliqué par du contenu neuf et plus avancé plutôt que de réduire la taille des
fichiers** — la classe la plus basse où le doublon apparaît garde le contenu original, les classes
supérieures reçoivent du contenu de remplacement.

- `ce1/english/generated.csv` : 184 lignes remplacées (nouveau vocabulaire, format "Comment
  dit-on/Que veut dire" inchangé).
- `ce2/english/generated.csv` : 211 lignes remplacées (61 nouveau vocabulaire + 150 phrases
  combinatoires "il y a [nombre] [animal] [position]" avec nombres/positions inédits).
  **Bugs trouvés et corrigés** (présents dans le contenu original ET auto-répliqués par le
  générateur) : "ourss" → "ours" (invariable), "chevals" → "chevaux" (pluriel irrégulier),
  "à " manquant devant "gauche,"/"droite," — confinés à ce seul fichier.
- `cm1/english/generated.csv` : 275 lignes remplacées (comparatifs, pays, ordinaux, consignes de
  classe, vêtements, corps, sports, instruments, pièces de la maison, famille — contenu
  combinatoire neuf). **Bugs de grammaire française auto-introduits, trouvés et corrigés** :
  élision "que un/une" → "qu'un/qu'une" (120 lignes), accord féminin des adjectifs comparatifs
  avec un premier sujet féminin (20 lignes, ex. "une voiture est plus lourde"), élision "à l'"
  devant oeil/oreille (2 lignes), prépositions de pays fautives (en la/le/les, de le/les — 26
  lignes, dictionnaire de préposition correcte par pays).
- `cm2/english/generated.csv` : 279 lignes remplacées (verbes au passé, adverbes de fréquence,
  comparatifs avec accord/élision natifs dès la génération, vêtements/lieux/animaux/nourriture/
  métiers/instruments/sports/famille au passé — contenu combinatoire neuf).
- **Doublons inter-années auto-introduits en cours de correction** (31 groupes) : la réutilisation
  des mêmes banques de vocabulaire/gabarits combinatoires entre plusieurs fichiers sans vérification
  croisée finale a recréé de nouveaux doublons. Corrigés par reformulation de l'occurrence la plus
  avancée (ex. ordinaux `cm1` reformulés en "le/la Xème" au lieu de la forme brute, doublons avec
  `ce1`/`ce2`), remplacement du verbe au passé par un verbe neuf pour les 9 lignes en doublon entre
  `ce2` et `cm2` (commencé/fini/répondu/attendu/entendu/voulu/cru/suivi/reçu), et remplacement du
  couple sujet "avion/oiseau" par "fusée/voiture" (avec accord féminin correct) + reformulation en
  question inversée pour les 15 lignes de la famille comparatif/superlatif en doublon entre `cm1`
  et `cm2`.
- **Validation finale (les 5 fichiers)** : cp=519, ce1=569, ce2=505, cm1=507, cm2=528 lignes
  (comptes inchangés) ; 0 doublon id ; 0 doublon (texte+choix) intra-fichier ; **0 doublon
  (texte+réponse) inter-classes** ; 0 parenthèse résiduelle.

**Import Godot requis** : de nombreux fichiers CSV ont été modifiés dans cette repasse
(math CE1/CE2 ; grammaire/orthographe CE1/CE2/CM1/CM2 ; english CE1/CE2/CM1/CM2) — relancer
`tools/admin/import_questions.gd` pour régénérer les `.tres` correspondants.

### 4. Complément — mismatch adjectif poids/forme repéré en jeu (2026-09-09)

L'utilisateur a signalé en jeu la question "Ma rivière est ___." avec la bonne réponse "lourde" —
une rivière n'a pas de dimension de poids, même famille de bug que le "court/courte" déjà traité
au point 2 ci-dessus (glissé une nouvelle fois car l'audit précédent ne cherchait que cet
adjectif précis, pas toute la catégorie sémantique poids/forme/épaisseur). Recherche ciblée sur
`ce2/orthographe/generated.csv` pour les adjectifs lourd/léger/carré/épais appliqués à un nom sans
cette dimension physique : 9 lignes trouvées et corrigées (id → nouvel adjectif) : 33302 (rivière
lourde→froide), 33211 (jardins légers→fleuris), 33345 (villages légers→calmes), 33497 (rivière
légère→agitée), 33862 (renards carrés→rapides), 33901 (étoile carrée→scintillante), 33472 (lune
épaisse→ronde), 33846 (voitures épaisses→rapides), 33909 (colline épaisse→haute). Les 4 colonnes
de choix régénérées pour chaque ligne selon l'accord habituel de la famille. Cas limites/idiomes
laissés en l'état après vérification (légitimes en français courant) : "cette histoire est
lourde" (sens figuré, récit pesant), "cette chanson semble profonde" (sens figuré). Revalidé :
1000 lignes, 0 doublon id, 0 doublon texte+choix.

### 5. Autres signalements en jeu (2026-09-09)

- **Ambiguïté ces/ses** : id 10097 "___ enfants jouent dans le parc." acceptait "Ces" comme seule
  bonne réponse alors que "Ses enfants jouent dans le parc." est tout aussi valide (aucun "-là"
  démonstratif, aucun verbe/contexte à connotation possessive comme "ranger" pour trancher).
  Corrigé en ajoutant "-là" : "___ enfants-là jouent dans le parc." (démonstratif sans ambiguïté).
  Vérification étendue à toute la famille ces/ses du fichier : un second cas limite repéré, id
  10096 "Elle adore ___ livres." (réponse "ses", pas de "-là" mais lecture par défaut discutable) —
  reformulé en "Elle range ___ livres." pour aligner sur le gabarit "Il range ___ X." déjà utilisé
  à grande échelle dans le fichier pour la lecture possessive sans ambiguïté.
- **Mismatch nom+adjectif supplémentaire (famille "rapide/solide" générique)** : signalement
  utilisateur sur id 33890 "Ces cartables sont ___." avec réponse "rapides" (un cartable n'a pas de
  vitesse). Cause : un jeu de 3 distracteurs fixes ("rapide;gentille;solide") réutilisé mécaniquement
  à travers le fichier, avec l'adjectif correct parfois interverti sans revérifier la pertinence pour
  chaque nom. Audit complet des lignes utilisant ce jeu de distracteurs : 3 autres bonnes réponses
  factuellement/sémantiquement fausses trouvées et corrigées — 33498 "Ces tortues sont ___."
  rapides→lentes (les tortues sont lentes, pas rapides), 33890 rapides→lourds (cartable lourd,
  expression courante), 33916 "Ces rues sont ___." rapides→animées. Puis extension à l'adjectif
  "solide" du même jeu de distracteurs : 5 lignes où "solide(s)" ne correspondait à rien de naturel
  pour le nom — 33540 écharpes→chaudes, 33542 tableaux→anciens, 33544 ballons→colorés, 33547
  légumes→verts, 33570 dessins→colorés. Choix laissés en l'état après vérification individuelle
  (défendables) : chaises/ponts/pantalons "solides" (objets robustes, usage courant), chiens/chats
  "gentils" (personnification classique). Revalidé : 1000 lignes, 0 doublon id, 0 doublon
  texte+choix.
- **Ambiguïté "mot invariable" (cm1/orthographe)** : signalement utilisateur sur id 36796 "Elle
  parle doucement à son chat." — "à" est également un mot invariable (préposition), au même titre
  que "doucement" (adverbe), donc la question "quel est le mot invariable ?" acceptait une seule
  bonne réponse alors que 2 choix l'étaient réellement. Audit complet des 28 lignes de cette
  famille (ids 36067-36072, 36198-36204, 36790-36804) : 13 lignes avaient le même défaut (un
  distracteur était en fait une préposition tout aussi invariable que la bonne réponse — en/à/de/
  dans/sous/vers/malgré — ou, pour 2 lignes, un second adverbe : "ici" concurrençant "toujours"
  id 36070, "aujourd'hui" concurrençant "très" id 36198). Corrigé en reformulant la question :
  "quel est l'adverbe invariable ?" pour les 25 lignes où la bonne réponse est un adverbe (résout
  toutes les ambiguïtés adverbe/préposition d'un coup, sans toucher au texte des phrases sauf pour
  les 2 lignes à double-adverbe où la phrase a aussi été récrite pour retirer le second adverbe :
  36070 "...toujours ici." → "...toujours dans son panier.", 36198 "...très beau aujourd'hui."
  → "...très beau ce matin.") ; "quelle est la préposition invariable ?" pour les 3 lignes où la
  bonne réponse est une préposition (36200/36201/36204, non ambiguës mais reformulées par
  cohérence). Les contractions au/jusqu'au (variables en nombre : au→aux) n'ont pas été traitées
  comme concurrentes. Revalidé : 1000 lignes, 0 doublon id, 0 doublon texte+choix.
- **Audit exhaustif nom+adjectif, ce2/orthographe** : après le signalement "cette tarte a l'air
  fatiguée" (id 33937, tarte→dorée), constat que tous les audits précédents de cette session (court/
  courte, lourd/léger/carré/épais, rapide/solide) ne cherchaient qu'un adjectif déjà repéré à chaque
  fois, sans jamais couvrir la totalité de la matrice nom×adjectif de la famille rotative "Cette/
  Ces/Ma/Mes X est/sont/semble/... ___.". Extraction programmatique de la totalité de cette famille
  (409 lignes, singulier + pluriel) et relecture individuelle de chaque paire nom+adjectif. 19
  nouvelles lignes corrigées. Motif le plus net : l'adjectif "calme" appliqué à un objet inanimé
  sans registre d'ambiance possible (manteaux/lampes/portes/glaces, ids 33599/33348/33291/33907,
  remplacés par chauds/brillantes/brillantes/sucrées) — à distinguer d'un lieu (rue/place restent
  légitimement "calme", vérifié et laissé tel quel). Autres cas : "nuages piquants"→menaçants
  (33573), "chemise/robe fortes"→chaude/légère (33339/33377), "biche/récréation vertes"→calme/
  animée (33898/33877), "chapeaux profonds"→colorés (33927), "cartables ronds"→neufs (33900),
  "nuages chauds"→blancs (33494), "chattes larges"→douces (33276), "cheminée/fenêtre/règle
  douces"→ancienne/ronde/neuve (33304/33308/33892, "douce" ne convient pas à un objet rigide),
  "rue/place douces"→calme (33880/33517), "histoires sales"→amusantes (33187, idiome trop mature
  pour le niveau). Revalidé : 1000 lignes, 0 doublon id, 0 doublon texte+choix.
- **Participes "devenir/aller/retourner" sans complément (cm1/grammaire)** : signalement
  utilisateur sur id 34670 "Antoine est bien ___." (devenu — "devenu quoi ?"). Ces 3 verbes exigent
  toujours un complément (attribut du sujet pour devenir, complément de lieu pour aller/retourner),
  contrairement à venir/entrer/sortir/partir/arriver/tomber/mourir/naître/rester qui sont complets
  seuls. Le fix "sujet+verbe+complément minimum" d'une session précédente (point 6/[[feedback_subject_verb_complement_minimum]])
  ne couvrait que le gabarit strict "Sujet est/sont ___." sans adverbe intercalé — toutes les
  variantes avec un adverbe (bien/déjà/encore/enfin/toujours/maintenant) ou la tournure "vient
  d'être ___." lui échappaient. Audit exhaustif programmatique de cm1/grammaire (et confirmation
  qu'aucun autre fichier n'a cette famille) : 33 lignes trouvées et corrigées en insérant le
  complément juste après le trou (position du trou inchangée, donc accord/choix intacts) — devenir
  → "un grand champion"/"une grande championne"/"de grands champions"/"de grandes championnes"
  selon le genre/nombre ; aller/retourner → un lieu adapté (au marché, à l'école, à la maison, en
  classe, chez le médecin, etc.). Revalidé : 1000 lignes, 0 doublon id, 0 doublon texte+choix.
  **Point signalé à l'utilisateur, non corrigé unilatéralement** : ce fichier contient aussi 32
  lignes au gabarit "Sujet vient d'être ___." appliqué à des verbes d'état/mouvement à auxiliaire
  être (mort/parti/tombé/monté/descendu/rentré/entré/né/resté, en plus des 5 devenir/aller/
  retourner déjà corrigées ci-dessus) — tournure grammaticalement discutable pour ces verbes
  intransitifs (le passif "vient d'être puni/opéré" est correct pour un verbe transitif, mais
  "il vient d'être mort/parti/tombé" sonne artificiel ; la forme naturelle serait "il vient de
  mourir/partir/tomber", ce qui casserait l'exercice d'accord du participe). Laissé en l'état
  faute d'un choix de refonte tranché par l'utilisateur — voir mémoire dédiée.
- **Adjectif à double sens "tendre" appliqué à des animaux (ce1/orthographe)** : signalement
  utilisateur sur id 30662 "Les pingouins ___ vraiment tendres aujourd'hui." — "tendre" a un sens
  affectueux (tendre = doux, câlin) mais aussi un sens culinaire fort (viande tendre), ce qui rend
  la phrase ambiguë/malaisante appliquée à un animal (lecture involontaire : "on les mange ?").
  Recherche de toutes les occurrences de "tendre(s)" comme bonne réponse dans la famille rotative
  "Les [animal] ___ (vraiment) [adjectif] (aujourd'hui)." (164 lignes, homophone son/sont) :
  5 lignes trouvées et corrigées en remplaçant "tendres" par "adorables" (poussins 30648,
  coccinelles 30653, pingouins 30662, tortues 30705, abeilles 30719) — aucun autre adjectif de
  cette famille ne pose ce problème de double sens (vérifié un par un : ravis/joyeux/calmes/fiers/
  polis/souriants/malicieux/etc. sont tous des personnifications sans ambiguïté). Vérifié qu'aucune
  autre occurrence de "tendre" dans le projet n'est utilisée comme bonne réponse pour un animal
  (les autres occurrences sont des distracteurs ou des questions de vocabulaire/nature du mot,
  sans risque). Revalidé : 1000 lignes, 0 doublon id, 0 doublon texte+choix.
- **Élision manquante "je" devant voyelle (ce2/grammaire)** : signalement utilisateur sur id 31410
  "Maintenant, je ___." avec bonne réponse "agis" — "je" doit s'élider en "j'" devant un verbe
  commençant par une voyelle ("j'agis", jamais "je agis"). Recherche programmatique de tout mot
  élidable (je/me/te/se/le/la/de/ne/que/ce) placé juste avant un trou dont la bonne réponse
  commence par une voyelle ou un h, sur l'ensemble des fichiers du projet : 1 seconde occurrence
  trouvée, id 31811 "Parfois, je ___." (achète). Les deux corrigées en "j'___" (aucune autre
  combinaison élidable+trou n'est concernée ailleurs dans le projet). Revalidé : 1000 lignes,
  0 doublon id, 0 doublon texte+choix.
