# Journal des audits CSV

Ce fichier suit, au fur et à mesure, chaque demande de "check"/audit sur les CSV de contenu
educatif (`csv/questions/<classe>/<matiere>/generated.csv` ou `histoires_generated.csv`).
Chaque demande est indexee : quand une nouvelle demande de check arrive sur un fichier, l'audit
est etendu a la matiere correspondante pour **toutes les classes concernees** (pas seulement la
classe mentionnee dans la demande), sauf si l'utilisateur precise explicitement une portee plus
etroite.

## Index

| # | Date | Demande (résumé) | Matière | Classes auditées | Résultat |
|---|------|-------------------|---------|-------------------|----------|
| 1 | 2026-09-17 | Ambiguïté "un/une X" (et variantes du/de la, au/à la, le/la) dans les questions "Comment dit-on..." | English | CP, CE1, CE2, CM1, CM2 | 209 corrections appliquées (0 ambiguïté restante) |
| 2 | 2026-09-17 | Guillemets simples ' ' peu visibles dans les questions -> remplacés par " " | Conjugaison, grammaire, orthographe, english, french (CP), lecture (histoires), logique (CM2 seulement) — aucune occurrence en math ni dans le reste de logique | CP, CE1, CE2, CM1, CM2 | 11 040 questions corrigées sur 23 fichiers |
| 3 | 2026-09-18 | Distracteurs de conjugaison trop faciles à écarter car "phonétiquement/visuellement trop différents" de la bonne réponse (ex. proposer "il tombons"/"il tombez" pour "il tombe", au lieu de variantes proches comme "il tombes"/"il tomb"/"il toombe") | Conjugaison | CE1, CE2, CM1, CM2 | 4000/4000 questions réécrites (100%) — les 3 mauvaises réponses de chaque question sont désormais des quasi-fautes d'orthographe de la bonne réponse |
| 4 | 2026-09-18 | Questions "j'ai N [objet/animal]" en anglais : chiffre (4) affiché au lieu du mot (four) dans les choix, et phrases improbables avec des animaux de ferme/sauvages ("j'ai quatre oiseaux") | English | CP, CE1 (seules classes concernées — CE2/CM1/CM2 non touchées) | 256/256 lignes corrigées (176 CP + 80 CE1) |
| 5 | 2026-09-18 | Re-vérification de la progression de difficulté par classe (notions Grammaire/Conjugaison/Orthographe vs FRANCAIS_DIFFICULTE.md, lisibilité Lecture vs LECTURE_DIFFICULTE.md) | Conjugaison, Grammaire, Orthographe, Lecture | CE1, CE2, CM1, CM2 (+ CP pour Lecture) | Conjugaison/Grammaire 100% conformes ; Orthographe CE1+CM1 corrigées (267 lignes) ; Lecture : écart de lisibilité sévère confirmé sur CE1/CM1/CM2, correction non montée en charge (voir détail) |
| 6 | 2026-09-18 | Suite de la re-vérification de la progression de difficulté par classe : Maths (avant de lancer tout chantier de correction, audit seul demandé) | Math | CP, CE1, CE2, CM1, CM2 | 100% conforme, 0 violation trouvée — seul manque : aucun document de référence écrit (comme FRANCAIS_DIFFICULTE.md/LECTURE_DIFFICULTE.md) ; corrigé en créant `MATHS_DIFFICULTE.md` |
| 7 | 2026-09-18/19 | Suite de la re-vérification de la progression de difficulté par classe : Anglais (audit d'abord, puis correction validée par Steve : "reformule au présent, on va essayer de coller au mieux au niveau de classe") | English | CP, CE1, CE2, CM1, CM2 | Progression globalement saine et conforme à `project_english_500.md` ; 3 points corrigés : 136 lignes CP + 42 lignes CE1 ("I saw"/"j'ai vu" → "I see"/"je vois"), 26 lignes CM1 ("il est né en X"/"He was born in X" → "il vient de X"/"He comes from X"), 7 lignes CE2 ("oiseaus" → "oiseaux") |
| 8 | 2026-09-19 | Suite (dernière étape) de la re-vérification de la progression de difficulté par classe : Logique (audit d'abord) + signalement utilisateur : des questions "quelle couleur ?" s'affichent en jeu comme des motifs (lignes horizontales/diagonales/verticales) au lieu de couleurs | Logique | CP, CE1, CE2, CM1, CM2 | Progression de difficulté saine et confirmée (familles d'exercices qui montent réellement en complexité, pas seulement en volume) ; bug distinct identifié (pas encore corrigé, proposition en attente de validation) : 87 questions (62 CP + 25 CE1) utilisent des emoji ronds de couleur (🔴🟣🔵🟢🟡🟠) à risque de rendu incorrect sur police système, cause probable du signalement |
| 9 | 2026-09-19 | Chantier de réécriture Lecture CE1 annoncé en #5 (écart de lisibilité sévère : Y=62,5 vs cible 80-90) — réécrire les 47 histoires CE1 en phrases courtes sans casser aucune des 940 questions liées | Lecture | CE1 uniquement | 47/47 passages réécrits ; Y moyen 62,5 → 77,0, 46/47 passages dans la bande 75-95 (1 passage à 67,2, vocabulaire muséal/dinosaures trop dense pour descendre plus bas sans sacrifier des faits testés) ; 940 questions et tous les ids/colonnes non-texte strictement inchangés ; CP/CE2/CM1/CM2 non touchés |
| 10 | 2026-09-19 | Suite du chantier de réécriture Lecture (après validation de CE1) — réécrire CE2 (`histoires_generated.csv`, Y=66,3 vs cible 70-80, écart modéré) selon la même méthode | Lecture | CE2 uniquement | 24/47 passages retouchés (23 déjà conformes, non touchés) ; Y moyen 66,3 → 68,7, 41/47 passages dans la bande 65-85 ; 6 passages restent sous la bande (musée/dinosaures, jardinage, spectacle de magie, marionnettes, volcan de sciences, jardin aux papillons) car leur vocabulaire obligatoire (mots testés par les questions) plafonne la simplification possible ; 940 questions et tous les ids/colonnes non-texte strictement inchangés ; CP/CE1/CM1/CM2 non touchés |
| 11 | 2026-09-19 | Suite du chantier de réécriture Lecture — réécrire CM1 (`histoires_generated.csv`, Y=36,3 vs cible 55-70, écart sévère) selon la même méthode | Lecture | CM1 uniquement | 35/47 passages retouchés (12 déjà conformes) ; Y moyen 36,3 → 55,0, 47/47 passages dans la bande 50-75 ; mots/phrase moyen ramené de 24,8 à 12,4 (cible 10-14) ; 940 questions et tous les ids/colonnes non-texte strictement inchangés ; CP/CE1/CE2/CM2 non touchés |
| 12 | 2026-09-19 | Suite (dernière étape) du chantier de réécriture Lecture — réécrire CM2 (`histoires_generated.csv`, Y=27,4 vs cible 40-55, écart le plus sévère du jeu) selon la même méthode | Lecture | CM2 uniquement | 47/47 passages retouchés ; Y moyen 27,4 → 42,0, 47/47 passages dans la bande 35-60 et dans la fourchette 300-380 mots ; mots/phrase moyen ramené de environ 27 à la cible 12-18 par fragmentation des phrases (vocabulaire riche CM2 conservé, pas simplifié) ; 940 questions et tous les ids/colonnes non-texte strictement inchangés ; CP/CE1/CE2/CM1 non touchés. Chantier de réécriture Lecture (CE1/CE2/CM1/CM2) désormais terminé sur les 4 classes concernées (CP déjà conforme depuis l'origine) |
| 13 | 2026-09-19 | Comparatifs incohérents en anglais signalés par Steve ("un éléphant est plus riche qu'une souris", "un rocher est plus large qu'une plume") | English | CM1, CM2 (seules classes concernées — la famille de phrases comparatives n'existe pas en CP/CE1/CE2) | 79/79 lignes corrigées pour "riche/pauvre" retiré de la famille (53 CM1 + 26 CM2) ; 11/11 lignes corrigées pour "rocher plus large qu'une plume" (7 CM1 + 4 CM2) ; bonus : 56 occurrences d'élision "que un/que une" → "qu'un/qu'une" corrigées en CM2 |
| 14 | 2026-09-19 | Suite de l'entrée #13 : deux nouveaux exemples incohérents trouvés par Steve en jouant ("un avion est plus chaud qu'un oiseau", "un fleuve est plus haut qu'un ruisseau") — extension à toute la famille "chaud/hotter" (et pas seulement avion/oiseau), plus le cas particulier fleuve/ruisseau pour "haut/higher" | English | CM1, CM2 | "chaud/hotter" retiré de toutes les paires sauf fusée/voiture (seule paire où la chaleur est un vrai trait naturel) — 53 lignes CM1 + 34 lignes CM2 corrigées (inclut le cas fleuve/ruisseau "haut" ci-dessus) |
| 15 | 2026-09-19 | Steve demande explicitement d'aller au bout de la logique et de retirer toute comparaison ambiguë/farfelue restante dans la même famille (pas seulement les cas déjà signalés) | English | CM1, CM2 | Revue complète des 8 adjectifs de base sur les 19 paires : "cleaner"/"louder"/"higher" retirés partout où ni l'un ni l'autre nom n'a de rapport plausible avec le bruit/la propreté/la hauteur (immeuble-maison, montagne-colline, livre-feuille, rocher-plume) — 31 lignes CM1 + 35 lignes CM2 corrigées ; famille comparative anglaise déclarée saine sur les 19 paires (0 combinaison farfelue restante) |
| 19 | 2026-09-20 | Steve signale en jouant que certaines questions de logique CM1/CM2 sont trop difficiles (capture d'écran : "façons de ranger 4 objets" = 24, "avec 7 amis, combien de paires" = 21) — audit de la difficulté et du type de questions demandé pour ces 2 classes | Logique | CM1, CM2 (scope explicitement restreint par Steve à ces 2 classes) | Famille « combinatoire simple » (10 questions CM2, ids 44009 + 44447-44455) confirmée hors-programme : permutations (n!) et combinaisons (n(n-1)/2) sont des notions de lycée, aucune formule n'est enseignée au primaire, énumération manuelle infaisable au-delà de 4-5 éléments — audit seul, aucune correction appliquée, en attente de décision de Steve. Famille « chiffrement de César » (91 questions CM2, 18% du fichier) signalée comme suspecte : décalage modulo-26 lettre par lettre sur des mots de 3 à 8 lettres, charge de calcul élevée pour du CM2. Reste des familles CM1 (grille 3x3, code lettre-chiffre direct, carrés parfaits, suites, déduction d'âge/course, analogies) et CM2 (grille numérique Raven, menteur/vérité, déduction 3-personnes, suites, analogies) jugées appropriées au niveau. |
| 20 | 2026-09-20 | Suite de l'entrée #19 : Steve valide les corrections (combinatoire retirée et remplacée ; César raccourci) | Logique | CM2 uniquement | Combinatoire (10 questions, ids 44009+44447-44455) remplacée par 10 suites numériques ×k+c (famille déjà validée pour CM2) ; César (91 questions) raccourci à des mots de 3-4 lettres et décalage +1 à +3 (au lieu de 3-8 lettres et +1 à +8) — 500/500 questions, 0 doublon de texte introduit, 0 erreur de calcul (vérifié programmatiquement), 0 modification hors des 101 lignes ciblées |
| 22 | 2026-09-27 | Reprise du bug de l'entrée #8 : ronds de couleur emoji (🔴🟣🔵🟢🟡🟠) affichés rayés en jeu (police d'emoji monochrome NotoEmoji) | Logique | CP, CE1 | 87/87 questions corrigées dans Supabase : 54 suites « Quelle couleur vient ensuite ? » passées en noms de couleurs écrits ; 33 intrus : ronds remplacés par des formes (■ ▲ ★) ou des fruits (🍎 🍌 🍇), énoncé « rond de couleur » adapté ; 0 emoji rond restant |
| 23 | 2026-09-27 | Audit complet de cohérence des phrases en français (grammaire, orthographe, conjugaison en phrase) : phrases illogiques, réponses fausses, distracteurs aussi corrects | Français | CP, CE1, CE2, CM1, CM2 | 2 088 questions corrigées dans Supabase (sur 9 000 relues + conjugaison CM2), par familles de gabarits avec listes blanches ; relecture indépendante (27+17+4+6 retouches) ; 0 doublon, 0 écart après application |
| 26 | 2026-09-29 | Question « La saison ___ il fait le plus chaud est l'été » (grammaire CM2) qui revient à chaque série → vérifier les notions et passer chacune à 20 questions minimum | Toutes (anglais surtout) | CP, CE1, CE2, CM1, CM2 | 54 notions sous 20 : 8 mal classées ou hors programme corrigées (75 questions modifiées), 507 questions ajoutées ; 0 notion sous 20, 0 doublon créé |
| 27 | 2026-09-29 | Suite de #26 : « I prefer apple » (pluriel manquant) et jours/mois anglais sans majuscule | English | CP, CE1, CE2, CM1, CM2 | 74 questions corrigées (22 « I prefer » CE2, 52 jours/mois CP-CE2) ; 0 reste |
| 30 | 2026-10-03 | Défauts trouvés en rédigeant les fiches de cours Logique (accords, élisions, réponses contradictoires, mauvais choix aussi corrects, questions rangées dans la mauvaise notion) — Steve : « oui corrige maintenant » | Logique | CP, CE2, CM1, CM2 (rien à corriger en CE1) | 222 questions corrigées dans Supabase ; 0 défaut restant |

## Détail

### #1 — 2026-09-17 — Ambiguïté d'article français dans les questions d'anglais

**Demande initiale** : sur CM2, retirer l'ambiguïté "un/une" dans les questions type
"Comment dit-on un/une singe" — mettre directement le bon article (ex. "un singe").

**Portée réelle auditée** : les 5 classes, `csv/questions/<classe>/english/generated.csv`.

**Motifs trouvés et corrigés** :
- `un/une X` → bon genre (ex. "un singe", "une girafe"), avec cas pluriels détectés et corrigés
  en "des X" (chaussures, chaussettes, gants, pâtes) plutôt qu'un faux singulier.
- `du/de la X` → bon genre + élision si nécessaire (ex. "de l'équitation", "de l'escalade").
- `au/à la X` → bon genre + élision si nécessaire (ex. "à l'hôpital"), y compris sur les
  tournures "j'ai mal au/à la X" (parties du corps, CM1).
- `le/la X` → bon genre (trouvé uniquement sur CM1, pièces de la maison : garage, salle de bain,
  cave, cuisine, jardin, salon, chambre).

**Résultats par classe** :

| Classe | Corrections |
|---|---|
| CP  | 12 |
| CE1 | 6 |
| CE2 | 54 |
| CM1 | 33 |
| CM2 | 104 |
| **Total** | **209** |

Vérification finale : 0 motif ambigu restant dans les 5 fichiers.

**Sauvegardes** : chaque fichier modifié a une copie `generated.csv.bak_avant_fix_articles` juste
à côté, à supprimer une fois le résultat validé en jeu.

### #2 — 2026-09-17 — Guillemets simples peu visibles dans les questions

**Demande initiale** : dans les questions, les phrases entourées par des `' '` ne sont pas très
visibles — les remplacer par des `" "`.

**Portée réelle auditée** : les 24 fichiers `generated.csv` / `histoires_generated.csv` sous
`csv/questions/**` possédant une colonne `text` (les 5 classes, toutes matières).

**Méthode** : script Python (lecture/écriture CSV via `;` comme délimiteur, cohérent avec le
parseur `FileAccess.get_csv_line` de Godot), appliqué uniquement à la colonne `text`. Chaque
apostrophe est classée caractère par caractère selon son voisinage :
- lettre des deux côtés → élision française (l'arbre, j'ai, qu'il, aujourd'hui, y compris devant
  un `___` de complétion comme "j'___") → laissée en `'` ;
- sinon (bordure de mot ou de champ) → guillemet ouvrant/fermant → converti en `"`.

Les champs devenus porteurs d'un `"` littéral sont ré-encodés selon les règles CSV standard
(champ entouré de `"..."`, guillemets internes doublés `""`) pour rester valides pour le parseur
Godot — identique à la convention déjà utilisée par endroits dans `cm1/orthographe` et les 5
`lecture/*.csv` (phrases contenant un `;`).

**Vérification** : chaque fichier modifié re-parsé et comparé ligne à ligne à `git show HEAD:<fichier>`
— même nombre de lignes/colonnes partout, aucune colonne autre que `text` touchée, aucune élision
résiduelle corrompue. Un seul cas ambigu trouvé et corrigé à la main : `csv/questions/ce2/lecture/
histoires_generated.csv` id 25187 ("qualifiés d'insaisissables'" → élision `d'` immédiatement suivie
d'un guillemet ouvrant, non séparable par la règle générale) → `d'"insaisissables"`.

**Résultats par fichier** (nombre de questions dont le texte contenait au moins une paire de
guillemets simples, désormais en `" "`) :

| Fichier | Corrections |
|---|---|
| cp/french | 802 |
| cp/english | 519 |
| ce1/conjugaison | 1000 |
| ce1/english | 569 |
| ce1/grammaire | 1000 |
| ce1/lecture (histoires) | 94 |
| ce1/orthographe | 111 |
| ce2/conjugaison | 1000 |
| ce2/english | 505 |
| ce2/grammaire | 759 |
| ce2/lecture (histoires) | 189 |
| ce2/orthographe | 280 |
| cm1/conjugaison | 1000 |
| cm1/english | 507 |
| cm1/grammaire | 161 |
| cm1/lecture (histoires) | 282 |
| cm1/orthographe | 36 |
| cm2/conjugaison | 1000 |
| cm2/english | 528 |
| cm2/grammaire | 108 |
| cm2/lecture (histoires) | 282 |
| cm2/logique | 132 |
| cm2/orthographe | 176 |
| **Total** | **11 040** |

Aucune sauvegarde `.bak` créée pour cette passe : les fichiers sont suivis par git et la
vérification s'est faite par diff contre `HEAD` (voir méthode ci-dessus) — `git diff` / `git
checkout -- <fichier>` permet de revenir en arrière si besoin.

### #3 — 2026-09-18 — Distracteurs de conjugaison trop éloignés de la bonne réponse

**Demande initiale** : sur la ligne 2288 (`ce1/conjugaison`, verbe "laver" avec "je" au présent),
les propositions étaient "je lave / je lavent / je lavez / je lavons" — Steve a fait remarquer que
des distracteurs comme "lavez"/"lavons" sont trop différents phonétiquement/visuellement de la
bonne réponse "lave" : un enfant les élimine par reconnaissance de forme (terminaison "-ons" = nous,
"-ez" = vous) sans avoir besoin de connaître la conjugaison du verbe en question. Il voulait des
propositions plus proches, du type "lave / laves / lav / laave".

**Portée réelle auditée** : exhaustive sur les 4 fichiers `<classe>/conjugaison/generated.csv`
existants (CE1, CE2, CM1, CM2 — 4000 lignes), tous les temps rencontrés : présent (CE1 entier,
une partie de CE2/CM1), imparfait (CE2, CM1), futur simple (CE2, CM1), passé composé (CM1, CM2),
plus-que-parfait (CM2), passé simple (CM2), conditionnel présent (CM2). Pas de fichier
`conjugaison` en CP (le français n'y est pas encore scindé en grammaire/conjugaison/orthographe).

**Nouvelle règle de génération des 3 mauvaises réponses** (remplace l'ancienne approche qui
empruntait la forme conjuguée réelle d'une autre personne/temps, cf. [[project_conjugaison_subject_mismatch_fix]]) :
- **Temps simples** (présent, imparfait, futur simple, conditionnel présent, passé simple — réponse
  en un seul mot conjugué, ex. "je lave", "elle fit") : les 3 distracteurs sont désormais des
  quasi-fautes d'orthographe du mot correct — une lettre ajoutée à la fin, la dernière lettre
  retirée, une voyelle interne doublée (ex. lave → laves / lav / laave).
- **Temps composés** (passé composé, plus-que-parfait — réponse en 2 mots, auxiliaire + participe,
  ex. "elle avait pris") : même principe d'ajout/retrait/doublement de lettre, appliqué à
  l'auxiliaire pour une ligne sur deux et au participe pour l'autre moitié (alternance déterministe
  par parité de l'id) — pour varier l'endroit où se niche la difficulté plutôt que toujours la même.
  Le mot non ciblé reste inchangé.
- Une variante générée qui coïncide par hasard avec la forme réelle d'une autre personne (ex.
  "laves" = vraie forme "tu" ; "elle as pris" en retirant une lettre de "a") est acceptée : elle
  reste visuellement proche de la bonne réponse, ce qui est le but, contrairement à l'ancien
  format qui empruntait des formes entières et donc très différentes.

**Résultats** : 4000/4000 lignes réécrites (colonnes `choice_2`/`choice_3`/`choice_4` uniquement —
`id`, `text` et `correct_answer` strictement inchangés, vérifié par diff colonne par colonne
contre les sauvegardes). 0 collision détectée (aucun distracteur généré identique à un autre
distracteur de la même ligne ni à la bonne réponse).

**Vérification avant écriture** : simulation complète sur les 4 fichiers (aperçu ligne par ligne
sur des échantillons aléatoires couvrant tous les temps et les 4 classes), contrôle automatique
d'unicité des 4 propositions par ligne, contrôle de non-dégénérescence (pas de distracteur réduit
à une seule lettre pour les mots courts comme "eu"/"pu"/"a").

**Sauvegardes** : `generated.csv.bak_qcmproximite_20260918` dans chaque dossier `<classe>/conjugaison/`.

**Import Godot en attente** (comme pour chaque lot précédent, cf. [[project_question_bank_ids]]) :
`tools/admin/import_questions.gd` doit être relancé (File > Run) pour CE1, CE2, CM1 et CM2 afin que
`data/question/resources/<classe>/conjugaison/conjugaison.tres` reprenne les nouveaux distracteurs.


### #4 — 2026-09-18 — "j'ai N [objet]" en anglais : chiffre au lieu du mot + phrases improbables

**Demande initiale** : sur `cp/english`, la question "Comment dit-on ""j'ai quatre oiseaux"" en
anglais ?" propose "I have 4 birds" (chiffre) au lieu de "I have four birds" (mot), alors que le
but de la question est de tester le vocabulaire des nombres — et la phrase elle-même n'a pas de
sens ("avoir quatre oiseaux" n'est pas une chose qu'un enfant dirait naturellement).

**Portée réelle auditée** : exhaustive sur les 5 fichiers `<classe>/english/generated.csv`. Les
deux familles combinatoires concernées (nombre × objet) n'existent qu'en CP ("j'ai deux/trois/
quatre/cinq/six [objet]", 170 lignes) et CE1 ("j'ai onze/douze/treize/quinze/vingt [objet]", 80
lignes) ; CE2/CM1/CM2 n'ont pas ce type de question. Une troisième famille (CP uniquement, "j'ai
N ans" / "I'm N years old", 6 lignes) a le même défaut de chiffre mais pas le problème de
plausibilité.

**Corrections appliquées** :
- Chiffre → mot anglais dans les 4 choix de chaque question (ex. "I have 4 birds" →
  "I have four birds"), y compris pour les âges ("I'm 4 years old" → "I'm four years old").
- Pour les 5 objets CP (oiseaux/vaches/cochons/canards/grenouilles) et le seul objet CE1 (oiseaux)
  qui ne sont pas des choses qu'un enfant "a" en petit nombre : reformulation "j'ai" → "j'ai vu" /
  "I have" → "I saw" (cohérent avec le tournure déjà utilisée ailleurs dans le jeu pour ce type
  d'animal, ex. CM2 "j'ai vu un hibou au zoo" → "I saw an owl at the zoo"). Appliqué à toutes les
  occurrences du couple (nombre, animal), qu'elles soient la bonne réponse d'une ligne ou un
  distracteur dans une autre ligne, pour une cohérence totale de la phrase dans tout le fichier.
  Les 12 autres objets CP (pommes, bananes, œufs, gâteaux, crayons, gommes, règles, livres,
  stylos, chats, chiens, lapins) et les 7 autres objets CE1 restent en "j'ai"/"I have", jugés
  plausibles.

**Résultats** : 176/176 lignes CP corrigées (170 "j'ai N objet" + 6 "j'ai N ans"), 80/80 lignes
CE1 corrigées. `id`, structure des 6 colonnes et nombre de lignes strictement inchangés (vérifié
par diff et par parsing CSV). Aucun chiffre résiduel de ce type, aucune double reformulation
("vu vu"/"saw saw") détectée.

**Sauvegardes** : `generated.csv.bak_avant_fix_nombres_animaux_20260918` dans `cp/english/` et
`ce1/english/`.

**Import Godot en attente** (comme pour chaque lot précédent, cf. [[project_question_bank_ids]]) :
`tools/admin/import_questions.gd` doit être relancé (File > Run) pour CP et CE1 afin que
`data/question/resources/<classe>/english/english.tres` reprenne les phrases corrigées.


### #5 — 2026-09-18 — Audit de progression de difficulté par classe (toutes matières)

**Demande initiale** : "audit de reequilibrage de difficulté et correspondance niveau requis par
classe, je veux une vraie distinction de niveau et d'évolution d'une classe à l'autre" — objectif
général, portée confirmée par Steve : toutes les matières, dans l'ordre, en commençant par
revérifier ce qui a déjà un référentiel écrit (Grammaire/Conjugaison/Orthographe, Lecture) avant
d'enchaîner sur Maths/Anglais/Logique (qui n'en ont pas).

**Conjugaison (4000 lignes, CE1-CM2)** : conformité vérifiée programmatiquement (verbes/temps
extraits par regex puis comparés au tableau de notions de `FRANCAIS_DIFFICULTE.md`) — **100%
conforme**, aucune correction nécessaire.

**Grammaire (4000 lignes, CE1-CM2)** : même méthode (catégories de nature du mot, notions "Dans
la phrase", quotas de sous-types) — **100% conforme**, aucune correction nécessaire.

**Orthographe (4000 lignes, CE1-CM2)** : 2 lacunes trouvées et corrigées.
- CE1 : la notion "comptage de lettres" (prévue au référentiel) était totalement absente (0
  question) ; 24 lignes "mois de l'année" et 111 lignes "synonymes" étaient hors périmètre CE1
  (aucune des deux n'est dans le référentiel CE1 — "synonymes" appartient au référentiel CE2).
  Les 135 lignes ont été remplacées par des questions "Combien de lettres y a-t-il dans le mot
  X ?" (vocabulaire réutilisé depuis `ce1/grammaire`, mots de 3 à 8 lettres, distracteurs =
  comptages proches).
- CM1 : la notion "doublement de consonnes" (prévue au référentiel) était totalement absente —
  le gabarit générique "Quelle est la bonne orthographe ?" (71% du fichier) teste du vocabulaire
  aléatoire sans cibler spécifiquement le doublement. 132 de ces lignes ont été remplacées par des
  mots à double consonne authentique (appeler, grammaire, poisson, accident...) avec des
  distracteurs construits spécifiquement autour de la confusion de doublement (consonne réduite à
  une seule lettre, sur-doublée, ou doublée au mauvais endroit).
- Vérifié après coup : structure CSV intacte (6 colonnes, 1000 lignes/fichier), 4 choix uniques
  par ligne, aucune ligne hors du périmètre ciblé modifiée par erreur (diff exact = 135 et 132
  lignes respectivement). Un bug d'encodage (le script de remplacement avait basculé les 2
  fichiers entiers en fins de ligne CRLF au lieu de LF, propre au projet) a été détecté et
  corrigé avant validation finale.

**Lecture (235 textes, CP-CM2)** : recalcul du score de lisibilité Kandel-Moles (formule validée
le 2026-07-20) sur le lot de 47 histoires × 5 classes (2026-07-30). Résultat : CP conforme (Y
moyen 90.9, cible 90-100), mais CE1 (Y=62.5 vs cible 80-90), CM1 (Y=36.3 vs cible 55-70) et CM2
(Y=27.4 vs cible 40-55) sont **très en dessous de leur cible de lisibilité** — les textes se
lisent nettement plus difficilement que prévu pour ces 3 classes. CE2 est modérément en dessous
(Y=66.3 vs cible 70-80). Cause identifiée par relecture d'échantillons : ce n'est pas une poignée
de phrases isolées qui tirent la moyenne vers le bas — **la quasi-totalité des phrases** de ces
histoires est structurellement trop dense (propositions relatives empilées, groupes
prépositionnels multiples, gérondifs) plutôt que reliée par des conjonctions de coordination
simples (et/puis/mais/alors) qui auraient permis une correction mécanique sûre. **Correction NON
appliquée cette session** : refaire cela correctement demande de réécrire une bonne partie des
phrases de chacune des 141-235 histoires concernées, au même niveau d'exigence que le test
original "Milo le chat" (5 versions manuscrites), pas un script de substitution — un chantier
à part entière, proposé comme prochaine étape dédiée plutôt que bâclé dans cette passe.

**Prochaine étape proposée à Steve** : suite du tour (Maths, Anglais, Logique) et/ou lancement du
chantier de réécriture Lecture (à commencer par CE1, l'écart le plus sévère avec les lecteurs les
plus jeunes).

**Sauvegardes** : `generated.csv.bak_avant_fix_niveau_20260918` dans `ce1/orthographe/` et
`cm1/orthographe/`.

**Import Godot en attente** pour `ce1/orthographe` et `cm1/orthographe` (comme pour chaque lot).

### #6 — 2026-09-18 — Progression de difficulté Maths (suite du tour, avant tout chantier de correction)

**Demande initiale** : continuer le tour de re-vérification de la progression de difficulté
(entamé à l'entrée #5) sur Maths/Anglais/Logique, mais d'abord produire un état des lieux des
travaux à effectuer, sans appliquer de correction avant validation.

**Portée réelle auditée** : les 5 fichiers `csv/questions/<classe>/math/generated.csv`
(CP à CM2, 5000 questions au total).

**Méthode** : extraction programmatique (script Python) de tous les couples multiplicatifs,
diviseurs, occurrences de fraction/décimal/pourcentage, choix vides/non-vides sur les questions
à réponse binaire, dimensions `L cm sur l cm` des problèmes de rectangle, et plages numériques
par catégorie — comparées classe par classe.

**Résultat : 0 violation trouvée.**

- CE1 : multiplication bien restreinte aux tables {0,1,2,5,10} (0/1000 hors périmètre) — l'écart
  signalé le 2026-09-07 (`feedback_math_level_scope_violation.md`, 12 lignes tables 3/4/6/7/8/9)
  n'existe plus dans le fichier actuel, corrigé entre-temps par l'extension du 2026-08-01.
- CE2 : division exclusivement exacte (0 mention de reste sur 120 questions), tables complètes
  1-10 vérifiées.
- CM1/CM2 : division avec quotient et reste bien répartie (55/110 et 47/95 questions portent sur
  le reste).
- Règle "réponse binaire = 2 choix" : 0 violation sur les 555 questions concernées (5 classes).
- Convention longueur ≥ largeur (rectangles) : 0 violation sur 140 problèmes (CM1+CM2).
- Aucune fuite de notion hors périmètre (fraction/décimal/pourcentage absents de CP/CE1/CE2,
  division absente de CP/CE1).
- Progression numérique confirmée croissante à chaque palier (ex. aire de rectangle : longueur
  4-25 en CM1 contre 7-40 en CM2).

**Seul travail identifié** : contrairement à Grammaire/Conjugaison/Orthographe
(`FRANCAIS_DIFFICULTE.md`) et Lecture (`LECTURE_DIFFICULTE.md`), les Maths n'avaient aucun
document de référence écrit malgré 5 vagues d'extension de contenu (juillet-août 2026). Steve a
validé la proposition de créer ce document ("je valide, il faut tout références sur les
difficulté pour un retour dessus éventuel plus tard") : **`MATHS_DIFFICULTE.md`** créé à la
racine du projet, consolidant le scope déjà correct (aucune ligne de CSV modifiée, aucune
sauvegarde nécessaire).

**Prochaine étape** : suite du tour vers Anglais, puis Logique (mêmes matières sans référentiel
écrit à ce jour).

### #7 — 2026-09-18 — Progression de difficulté Anglais (suite du tour, audit seul avant correction)

**Demande initiale** : continuer le tour de re-vérification de la progression de difficulté vers
l'Anglais, en produisant d'abord un état des lieux des travaux à effectuer, sans corriger avant
validation (même consigne que pour Maths, entrée #6).

**Portée réelle auditée** : les 5 fichiers `csv/questions/<classe>/english/generated.csv`
(CP à CM2, 2628 questions au total).

**Méthode** : extraction programmatique de marqueurs grammaticaux anglais (can/can't, there is/
are, comparatif -er than, superlatif the most/-est, must/mustn't, démonstratifs, prétérit régulier
-ed et irrégulier was/were/went/saw/etc., going to, adverbes de fréquence, présent continu -ing,
pays+they speak/I live in) sur l'ensemble de chaque ligne (question ET choix de réponse, le format
étant une traduction français<->anglais) — comparés classe par classe contre le scope documenté
dans `project_english_500.md`.

**Résultat global : progression saine.** Chaque notion grammaticale apparaît bien à partir de sa
classe d'introduction documentée et pas avant : can/can't démarre en CE1 (24 occurrences), there
is/are en CE2 (240), comparatif -er than en CM1 (140, confirmé comparatif seul — aucun vrai
superlatif "the most"/"the ...est" en CM1, contrairement à ce que la description mémorisée
suggérait, celui-ci n'apparaît qu'en CM2 avec 30 occurrences), must/mustn't et démonstratifs
this/that/these/those en CM1, prétérit régulier -ed, going to, adverbes de fréquence et présent
continu -ing généralisé exclusivement en CM2.

**3 points trouvés, en attente de décision (aucune correction appliquée) :**

1. **"I saw" en CP (90 questions) et CE1 (22 questions)** : le prétérit irrégulier "saw" (passé
   de "see") apparaît avant sa classe d'introduction officielle (CM2). Cause : le fix de l'entrée
   #4 de ce même journal (correction des phrases "j'ai N animaux" improbables) a reformulé ces
   questions en "I saw N [animal]"/"j'ai vu N [animal]" — un effet de bord non anticipé au moment
   de ce fix. Compromis défendable ("I saw" est une expression figée très courante, pas une leçon
   de grammaire du prétérit), mais c'est un vrai écart au séquencement programme si on l'applique
   strictement.
2. **"was born in [pays]" en CM1 (26 questions, catégorie "pays/langues")** : construction passive
   au prétérit ("il est né en Chine" → "He was born in China"), également avant la classe
   d'introduction du prétérit (CM2). Contrairement au point 1, ceci existe depuis la création du
   contenu (2026-08-04), pas un effet de bord de cette session.
3. **7 fautes d'orthographe française "oiseaus" au lieu de "oiseaux"** en CE2 (catégorie "there is/
   are", ids 20017, 20054, 20075, 20077, 20096, 20148, 20179) — trouvées incidemment lors du
   balayage, sans lien avec la difficulté ; aucune autre faute de pluriel -eau/-eu détectée ailleurs
   sur les 5 classes.

**Aucune autre fuite de notion trouvée** (numérique : progression 0-12 CP → 1-20+30 CE1 → tens
jusqu'à 100 CE2 confirmée croissante, aucune régression).

**Décision de Steve (2026-09-19)** : "reformule au présent, on va essayer de coller au mieux au
niveau de classe" — corriger les 3 points plutôt que les garder tels quels.

**Corrections appliquées le 2026-09-19 :**

1. **CP (136 lignes) + CE1 (42 lignes)** : remplacement texte intégral de "I saw" → "I see" et
   "j'ai vu" → "je vois" sur les deux fichiers (`generated.csv` de `cp/english` et `ce1/english`).
   Vérifié au préalable que "saw"/"vu" n'apparaissaient nulle part ailleurs dans ces fichiers
   (aucun faux positif possible) — remplacement fait sur la totalité des occurrences, y compris
   celles qui n'étaient visibles que dans les distracteurs d'autres questions (ex. "j'ai vu deux
   vaches" comme mauvaise réponse à "j'ai deux bananes"), pas seulement dans les 90+22 questions
   repérées initialement — cf. méthodologie "audit exhaustif, pas seulement l'occurrence
   signalée" (`feedback_exhaustive_vs_reactive_audits.md`).
2. **CM1 (26 lignes)** : "il est né en/au/aux [pays]" → "il vient de/d'/du/des [pays]" (préposition
   française correcte par pays, réutilisant exactement les prépositions déjà en usage dans la
   même banque pour la famille "je viens de [pays]" existante) ; "He was born in [pays]"
   → "He comes from [pays]" sur les 57 occurrences (question + distracteurs). Résultat cohérent
   avec la catégorie déjà existante "pays/langues" (mêmes verbes come from/vient de, juste un
   sujet différent je/il — bon exercice d'accord sujet-verbe CM1 au passage).
3. **CE2 (7 lignes)** : faute d'orthographe française "oiseaus" → "oiseaux" (ids 20017, 20054,
   20075, 20077, 20096, 20148, 20179).

**Vérifié après coup** : 0 occurrence restante de "saw"/"vu"/"was born"/"est né"/"oiseaus" dans les
5 fichiers ; structure CSV intacte (nombre de lignes inchangé sur les 4 fichiers touchés) ; aucune
fin de ligne CRLF introduite (remplacement en texte brut, sans passer par `csv.writer`) ; diff
exact contre sauvegarde = 136/42/26/7 lignes respectivement, conforme au périmètre visé.

**Sauvegardes** : `generated.csv.bak_avant_fix_preterit_20260919` dans `cp/english/`,
`ce1/english/` et `cm1/english/` ; `generated.csv.bak_avant_fix_oiseaus_20260919` dans
`ce2/english/`.

**Import Godot en attente** pour ces 4 fichiers (comme pour chaque lot).

**Prochaine étape proposée à Steve** : rédaction d'`ANGLAIS_DIFFICULTE.md` (même format que
`MATHS_DIFFICULTE.md`), puis suite du tour vers Logique, dernière matière sans référentiel écrit.

### #8 — 2026-09-19 — Progression de difficulté Logique (dernière étape du tour) + bug d'affichage "couleur"

**Demande initiale** : terminer le tour de re-vérification de la progression de difficulté avec la
Logique (dernière matière sans référentiel écrit), et vérifier en même temps un bug signalé par
Steve : dans certaines questions de logique, des questions "quelle couleur ?" s'affichent en jeu
comme des motifs (lignes horizontales, diagonales, verticales barrées) au lieu de vraies couleurs.

**Portée réelle auditée** : les 5 fichiers `csv/questions/<classe>/logique/generated.csv`
(CP à CM2, 2500 questions au total).

**1. Progression de difficulté — résultat : saine, aucune correction nécessaire.**

Méthode : inventaire complet de tous les caractères non-ASCII utilisés par classe (emoji/symboles),
recherche de marqueurs de familles avancées (grilles, syllogismes, déduction par âge, code
lettre-chiffre, menteur/vérité, chiffrement de César, combinatoire), et échantillonnage aléatoire
de CM1/CM2 pour vérifier la nature exacte des familles.

Résultat : chaque famille avancée apparaît exactement à la classe où `project_logique_500.md` la
place et jamais avant — grilles à partir de CE2 (37 CE2, 61 CM1, 75 CM2, complexité croissante :
CE2 = grille de formes simple, CM1 = rotation cyclique de symboles, CM2 = grille numérique façon
Raven), syllogismes exclusifs à CE2 (33), déduction d'âge/course exclusive à CM1 (53), code
lettre-chiffre direct (A=1, B=2...) exclusif à CM1 (44), chiffrement de César (décalage +N,
opération modulo l'alphabet — nettement plus complexe que le code direct de CM1) et
menteur/vérité exclusifs à CM2 (41), combinatoire exclusive à CM2 (4). L'inventaire des
emoji/symboles par classe confirme aussi une progression cohérente vers l'abstraction : CP/CE1
utilisent un vocabulaire visuel riche (fruits, animaux, formes, couleurs, cartes à jouer), CE2 se
limite aux légumes/fruits, CM1 seulement des formes géométriques basiques, et **CM2 n'utilise plus
aucun emoji/symbole** (100% textuel/numérique) — cohérent avec le passage à un raisonnement
purement abstrait en fin de cycle 3.

**2. Bug d'affichage "couleur" — cause probable identifiée, correction proposée, PAS encore appliquée.**

Le contenu CSV lui-même est correct : la famille "Quelle couleur vient ensuite ?" (62 questions
CP, ids ~40400s ; 25 questions CE1) utilise de vrais emoji ronds de couleur Unicode (🔴🟣🔵🟢🟡🟠),
bien formés, séquences cohérentes — vérifié ligne par ligne. Le problème est donc côté rendu, pas
côté données.

Cause probable : ces emoji ronds appartiennent à un bloc Unicode récent (2019, "Symbols and
Pictographs Extended-A"), contrairement aux symboles basiques utilisés ailleurs dans Logique
(■▲●★♥♦, bloc "Miscellaneous Symbols" de 1993, présent dans quasi toute police). La police du
projet (`Baloo2-SemiBold.ttf`) ne couvre aucun emoji ; Godot bascule alors sur une police système
de secours (`allow_system_fallback=true`, aucune police de repli explicite configurée —
`fallbacks=[]`). Ce risque avait déjà été identifié et documenté AVANT la mise à l'échelle du
contenu (`feedback_font_emoji_risk.md`, 2026-08-04 : "genuinely unverified on other export
targets"). Vérifié la propriété d'import `modulate_color_glyphs=false` du fichier `.ttf.import` :
d'après la documentation officielle Godot (`FontFile.modulate_color_glyphs`), ce réglage ne fait
que déterminer si la teinte du texte s'applique aux glyphes colorés ou seulement aux glyphes
monochromes — ce n'est PAS la cause du bug, la police de secours système reste le suspect principal
(bug de substitution de glyphe déjà documenté dans plusieurs tickets connus du moteur Godot pour
ces emoji "récents").

**Proposition (en attente de validation de Steve, rien appliqué)** : plutôt que de chercher à
fiabiliser le rendu emoji (dépend de la police système de la machine du joueur, donc jamais
garanti à 100%), remplacer les emoji ronds de couleur par le nom de la couleur en toutes lettres
("Rouge", "Bleu", "Vert", "Jaune", "Orange", "Violet") dans cette famille précise (87 questions
CP+CE1) — solution déjà anticipée dans `feedback_font_emoji_risk.md" ("redesigner le contenu pour
éviter les emoji"), purement côté CSV (aucun changement de code Godot nécessaire), et Logique gère
déjà nativement des questions 100% texte à côté de questions à emoji (voir
`project_logique_qcm_layout_fix.md`, `_is_emoji_choice()`).

**Décision de Steve (2026-09-19)** : "on laisse de côté pour le moment" — le bug est confirmé et
documenté (cause probable + proposition de correction ci-dessus), mais volontairement **non
corrigé** cette session, pour ne pas retarder le passage aux chantiers de modification. À reprendre
quand Steve le décidera, sans qu'il soit nécessaire de refaire l'investigation (déjà faite ici et
dans `LOGIQUE_DIFFICULTE.md` section 3).

**Aucune correction appliquée** sur ce point.

---

**Bilan du tour de re-vérification de difficulté (entrées #5 à #8, 2026-09-18/19)** : demandé par
Steve en début de tour ("audit de reequilibrage de difficulté... vraie distinction de niveau et
d'évolution d'une classe à l'autre", portée "Tout, dans l'ordre"). Les 7 matières du jeu ont
désormais toutes été auditées et disposent d'un référentiel écrit :
Conjugaison/Grammaire/Orthographe (`FRANCAIS_DIFFICULTE.md`, déjà existant, revérifié conforme),
Lecture (`LECTURE_DIFFICULTE.md`, déjà existant, écart de lisibilité confirmé sur CE1/CM1/CM2 mais
non corrigé — chantier à part entière, jamais entamé), Maths (`MATHS_DIFFICULTE.md`, nouveau),
Anglais (`ANGLAIS_DIFFICULTE.md`, nouveau), Logique (`LOGIQUE_DIFFICULTE.md`, nouveau). Le tour est
**terminé**. Deux points restent ouverts, tous deux explicitement mis de côté par Steve plutôt que
corrigés dans l'urgence : la réécriture Lecture (235 histoires) et le bug d'affichage couleur
Logique (87 questions) ci-dessus.

---

### #9 — 2026-09-19 — Réécriture de lisibilité Lecture CE1 (chantier annoncé en #5)

**Demande initiale** : reprendre le chantier identifié en #5 (écart de lisibilité Kandel-Moles
sévère sur CE1 : Y moyen 62,5 contre une cible de 80-90 dans `LECTURE_DIFFICULTE.md`) et réécrire
les 47 histoires de `csv/questions/ce1/lecture/histoires_generated.csv` en phrases courtes et
répétant les sujets plutôt qu'en propositions empilées, **sans casser aucune des 940 questions de
compréhension liées** (20 questions par histoire : réponse correcte, 3 distracteurs, et pour les
questions de type `[V]` le mot exact interrogé doit rester présent tel quel dans le texte).
Portée volontairement limitée à CE1 : `LECTURE_DIFFICULTE.md` non modifié (mise à jour laissée à
Steve après relecture) et aucun autre fichier/classe touché à ce stade.

**Sauvegarde** : `histoires_generated.csv.bak_avant_fix_lisibilite_20260919`, dans le même
dossier, à supprimer une fois le résultat validé en jeu.

**Méthode** : pour chacune des 47 histoires, extraction directe depuis le CSV (pas de cache) du
texte et de ses 20 questions liées (id, correct_answer, 3 distracteurs, qtype), afin de dresser
l'inventaire des faits et mots à préserver avant réécriture. Réécriture manuscrite par lots de 7-8
histoires : découpage des phrases (8 phrases denses en moyenne dans l'original → 17-27 phrases
courtes après réécriture, sujet répété plutôt que relié par "et"), simplification du vocabulaire
rare par synonyme sauf pour les mots exacts ciblés par une question `[V]` ("Que veut dire 'X' dans
le texte ?"), ajout de courtes phrases neutres (météo, humeur) pour diluer la densité syllabique
sans introduire de fait nouveau. Structure "aérée" (2-3 paragraphes séparés par un saut de ligne)
conservée. Vérification automatique après chaque lot : script comparant, pour chaque question
liée, la présence du mot-cible `[V]` et des mots-clés significatifs de `correct_answer` dans le
nouveau texte — plusieurs régressions réelles détectées et corrigées avant validation finale (ex.
id 24693 : la phrase contenant le mot-cible "redouble" avait disparu d'un brouillon ; id 24882 :
"intenses" perdu lors d'un ajout de phrase de remplissage ; id 24672 : "monitrice", exigé par deux
questions différentes, avait été remplacé par "une dame"). Quelques simplifications mineures ont
été conservées **volontairement** quand l'adverbe/complément retiré n'était pas nécessaire pour
distinguer la bonne réponse de ses distracteurs (ex. "chaleureusement" retiré à 3 endroits car le
verbe seul distingue déjà sans ambiguïté ; "multicolores" → "colorés" id 24168 ; "extrêmement" →
"très" id 24798 ; "l'alimentation" retiré id 24462, seule la question, pas la réponse, en avait
besoin).

**Écriture finale** : réécriture du fichier via `csv.writer(delimiter=';', lineterminator='\n')`
avec `newline=""` en lecture et écriture, en ne touchant que la colonne `text` des 47 lignes
`type=passage` (aucune ligne `type=question` modifiée). Le fichier vivant était en réalité en
fins de ligne CRLF avant cette passe (`\r\n` sur les 987 lignes, incohérent avec la convention
LF du reste du projet) ; conformément à la consigne explicite reçue, le fichier a été réécrit en
LF pur — cohérent avec `generated.csv` et ce journal.

**Vérification structurelle** : comparaison ligne à ligne entre la sauvegarde et le fichier final
(987 lignes des deux côtés, en-têtes identiques) — 0 écart en dehors des 47 colonnes `text`
attendues (aucun id perdu/déplacé, aucune colonne non-texte de `passage` modifiée, aucune ligne
`question` modifiée), et 0 occurrence de `\r\n` dans le fichier final.

**Résultat lisibilité (Kandel-Moles, formule validée le 2026-07-20)** :

| | Avant | Après |
|---|---|---|
| Y moyen (47 passages) | 62,5 | **77,0** |
| Passages dans la bande 75-95 | 0/47 | **46/47** |
| Nombre de mots par passage | 90-130 (préservé) | 90-130 (préservé, 0 hors bande) |

Seul passage restant hors bande : **id 24462** (visite de musée d'histoire naturelle,
squelette de dinosaure) à Y=67,2. Cause documentée : sur ce texte, la quasi-totalité du
vocabulaire porteur de sens (musée, histoire naturelle, squelette, dinosaure, suspendu, plafond,
disparu, millions d'années, fossiles, roches anciennes, + 2 mots `[V]` "impressionnée" et
"multitude") est directement exigée par au moins une question et ne peut donc pas être simplifiée
davantage sans casser un fait testé ; la marge de manœuvre restante (phrases de remplissage) a été
épuisée sans suffire à ramener le score dans la bande. Décision : accepté en l'état plutôt que de
sacrifier un fait vérifié par une question.

**Vérification manuelle croisée** (échantillon de 15 histoires réparties sur toute la plage
d'ids, du début à la fin du fichier : 24000, 24084, 24168, 24231, 24399, 24420, 24441, 24462,
24546, 24672, 24714, 24735, 24798, 24924, 24966) : pour chacune, chaque fait interrogé par une
question `[L]` (couleurs, chiffres, noms, lieux, séquence, ressenti) et chaque mot-cible `[V]`
relu à la main contre le texte réécrit — tout est resté vrai et traçable. Les seuls écarts
littéraux relevés sont soit des variantes de conjugaison déjà présentes dans le texte d'origine
avant cette passe (ex. "déguster"/"dégustent", "dénicher"/"déniché"), soit les simplifications
volontaires documentées ci-dessus — aucune perte de fait réelle constatée.

**Aucun autre fichier touché** : CP, CE2, CM1, CM2 (`lecture` comme les autres matières) restent
strictement inchangés. `LECTURE_DIFFICULTE.md` non modifié (mise à jour laissée à Steve).

**Prochaine étape proposée à Steve** : si ce résultat est validé en jeu, reprendre le même
chantier pour CE2 (Y=66,3 vs cible 70-80, écart modéré) puis CM1/CM2 (écarts les plus sévères,
Y=36,3 et Y=27,4), qui restent identifiés depuis #5 mais non traités ici.


### #10 — 2026-09-19 — Réécriture de lisibilité Lecture CE2 (suite de #9)

**Demande initiale** : après validation du résultat CE1 (#9), Steve a demandé d'enchaîner
directement sur CE2 ("enchaine avec ce2"). Même contrainte que #9 : réécrire les 47 histoires de
`csv/questions/ce2/lecture/histoires_generated.csv` sans casser aucune des 940 questions de
compréhension liées, ni leurs mots-cibles `[V]`.

**Différence de départ avec CE1** : contrairement à CE1 (8 phrases très denses par histoire,
Y=62,5 vs cible 80-90), l'état initial CE2 était moins éloigné de sa cible (Y=66,3 vs cible
70-80) et son ratio mots/phrase moyen (≈11,1) était déjà dans la bande cible CE2 (8-12
mots/phrase) — le nombre de mots par histoire était déjà bon (140-182, cible 150-200). Le levier
principal ici était donc la simplification du vocabulaire et un allègement ciblé des phrases les
plus denses, pas une fragmentation systématique comme en CE1. Sur les 47 histoires, 23 étaient
déjà suffisamment simples et n'ont pas été modifiées ; 24 ont été retouchées.

**Incident méthodologique et correction** : une première passe automatisée avait tenté de faire
remonter le score de plusieurs histoires en ajoutant des phrases courtes génériques répétitives
("Elle sourit.", "Il est ravi.", "C'est un beau moment.") sans contenu informatif nouveau —
techniquement efficace sur le score (le calcul Kandel-Moles favorise les mots courts et
peu syllabiques) mais de mauvaise qualité rédactionnelle et hors de l'esprit de la demande de
Steve ("rendre le texte clair et lisible... pour aérer les textes"). Ce travers a été repéré à la
vérification (détection automatique des tournures répétitives sur 7 histoires : 25294, 25399,
25441, 25462, 25756, 25777, 25966) et corrigé en réécrivant ces 7 histoires une seconde fois,
sans remplissage : phrases découpées sur du contenu réel, vocabulaire non protégé simplifié, et
quelques détails descriptifs concrets ajoutés (couleur de l'eau, météo, odeur du jardin...) plutôt
que des réactions émotionnelles répétées, pour rester dans la fourchette de mots sans tourner en
rond. Un écart introduit par inadvertance lors de cette correction (accord "impressionnés" ->
"impressionné" dans l'histoire 25756, cassant la correspondance exacte avec le mot interrogé par
une question `[V]`) a été repéré et corrigé avant validation finale.

**Écriture finale** : même méthode sûre qu'en #9 — `csv.writer(delimiter=';', lineterminator='\n',
quoting=csv.QUOTE_MINIMAL)`, lecture/écriture avec `newline=""`, seule la colonne `text` des
lignes `type=passage` modifiée, aucune ligne `type=question` touchée.

**Vérification structurelle** : comparaison ligne à ligne entre la sauvegarde et le fichier final
(987 lignes des deux côtés, mêmes ids dans le même ordre) — 0 écart en dehors des colonnes `text`
des 24 passages retouchés, et 0 occurrence de `\r\n` dans le fichier final (comme pour CE1, le
fichier vivant était en CRLF avant cette passe, réécrit en LF pur).

**Résultat lisibilité (Kandel-Moles)** :

| | Avant | Après |
|---|---|---|
| Y moyen (47 passages) | 66,3 | **68,7** |
| Passages dans la bande 65-85 | non mesuré individuellement avant (moyenne seule connue) | **41/47** |
| Nombre de mots par passage | 140-182 | 150-190 (dans la cible 150-200) |

6 passages restent sous la bande malgré la réécriture : 25399 (Y=59,7, volcan de sciences),
25441 (Y=60,9, jardinage), 25462 (Y=55,2, musée/dinosaures), 25756 (Y=62,2, spectacle de magie),
25777 (Y=64,0, marionnettes), 25966 (Y=58,1, jardin aux papillons). Cause commune, identique au
cas CE1 (#9, id 24462) : le vocabulaire de ces thèmes est en grande partie exigé mot pour mot par
des questions `[L]`/`[V]` liées (dinosaure, squelette, marionnettiste, chevalier, spectaculaire,
etc.) et ne peut pas être simplifié davantage sans casser un fait vérifié. Décision : accepté en
l'état plutôt que de sacrifier un fait ou de recourir à un remplissage artificiel.

**Vérification manuelle croisée** : les 7 histoires retouchées deux fois ont été revérifiées mot-
cible par mot-cible `[V]` (extraction directe du mot entre guillemets dans le texte de chaque
question, recherche exacte dans le texte réécrit) — tous présents après correction du cas
25756 ci-dessus. Échantillon complémentaire sur 10 histoires réparties sur toute la plage d'ids :
faits `[L]` et mots-cibles `[V]` tous retrouvés dans le texte réécrit.

**Aucun autre fichier touché** : CP, CE1, CM1, CM2 restent strictement inchangés.
`LECTURE_DIFFICULTE.md` non modifié (mise à jour laissée à Steve).

**Prochaine étape proposée à Steve** : si ce résultat est validé, reprendre le même chantier pour
CM1 (Y=36,3 vs cible 55-70) puis CM2 (Y=27,4 vs cible 40-55), les écarts les plus sévères des
4 classes concernées.


### #11 — 2026-09-19 — Réécriture de lisibilité Lecture CM1 (suite de #9/#10)

**Demande initiale** : après validation de CE1 (#9) et CE2 (#10), Steve a demandé d'enchaîner sur
CM1 et CM2 ensemble ("ok on enchaine avec cm1 et cm2"). Même contrainte : réécrire les 47 histoires
de `csv/questions/cm1/lecture/histoires_generated.csv` sans casser aucune des 940 questions liées
ni leurs mots-cibles `[V]`. Chantier confié à un agent dédié en parallèle de CM2 (#12), avec
instruction explicite de ne PAS reproduire le travers détecté sur CE2 (remplissage par phrases
génériques répétitives type "Elle sourit."/"Tout va bien." plutôt que du contenu réel).

**Différence de départ avec CE1/CE2** : écart de lisibilité sévère (Y=36,3 vs cible 55-70), mais
cause différente de CE2 — ici le nombre de mots par histoire était déjà bon (211-261, cible
220-280) mais les phrases étaient extrêmement denses : seulement 8-16 phrases pour ~232 mots en
moyenne, soit environ 24,8 mots par phrase (cible CM1 : 10-14 mots/phrase). Le travail a donc
consisté quasi exclusivement à fragmenter les phrases longues et composées en phrases plus courtes
sur le même contenu, en conservant un niveau de vocabulaire CM1 (plus riche que CE1, volontairement
pas nivelé vers le bas).

**Résultat** : 35/47 passages retouchés (12 déjà conformes, laissés inchangés). Mots/phrase moyen
ramené de 24,8 à 12,4. Quelques histoires à vocabulaire thématique dense (musée, sciences, fête
foraine) ont nécessité une fragmentation plus poussée (jusqu'à 26-31 phrases courtes) plutôt qu'une
simplification du vocabulaire, pour ne pas casser de mots-cibles `[V]` ni descendre sous le niveau
CM1 attendu.

**Écriture finale** : même méthode sûre que #9/#10 — `csv.writer(delimiter=';', lineterminator=
'\n', quoting=csv.QUOTE_MINIMAL)`, lecture/écriture avec `newline=""`, seule la colonne `text` des
lignes `type=passage` modifiée.

**Vérification structurelle (refaite indépendamment)** : comparaison ligne à ligne entre la
sauvegarde et le fichier final (987 lignes des deux côtés, mêmes ids dans le même ordre) — 0 écart
en dehors des colonnes `text` des 35 passages retouchés, 0 occurrence de `\r\n` dans le fichier
final (comme pour CE1/CE2, converti de CRLF à LF pur à cette occasion).

**Résultat lisibilité (Kandel-Moles, recalculé indépendamment)** :

| | Avant | Après |
|---|---|---|
| Y moyen (47 passages) | 36,3 | **55,0** |
| Passages dans la bande 50-75 | 12/47 | **47/47** |
| Mots par passage | 211-261 (déjà conforme) | 220-261, toujours dans la cible 220-280 |

**Recherche de remplissage répétitif** : recherche automatique (motifs "sourit", "est content/ravi/
heureux", "c'est bien/beau/génial", "tout va bien") refaite indépendamment sur le fichier final —
aucun passage n'atteint le seuil d'alerte (3 occurrences). Aucun remplissage générique détecté,
contrairement à l'incident survenu sur #10.

**Vérification manuelle croisée des mots-cibles `[V]`** : recherche exacte, sur les 282 questions
`[V]` du fichier, du mot cité entre guillemets dans la question, dans le texte réécrit — 280/282
présents. Les 2 seuls manquants ("économise" sur 26063, "émerveilles" sur 26084) concernent des
passages **non retouchés** par ce chantier et le mot manquant est déjà absent du texte d'origine
avant toute intervention cette session — incohérence préexistante dans les données, pas une
régression introduite ici (même type de coquille déjà rencontrée sur CE2, ex. "émerveilles" sur
25966). Échantillon complémentaire de 8 histoires réparties sur toute la plage réécrite relu
manuellement : tous les faits `[L]`/`[I]` conservés.

**Petite correction opportuniste signalée par l'agent** : incohérence préexistante sur le passage
26420 (question `[V]` demandant "délicate", texte original ne contenant que "délicat") corrigée à
l'occasion de la réécriture.

**Aucun autre fichier touché** : CP, CE1, CE2, CM2 restent strictement inchangés à ce stade (CM2
traité en parallèle, voir #12). `LECTURE_DIFFICULTE.md` non modifié (mise à jour groupée prévue
après #12).

### #12 — 2026-09-19 — Réécriture de lisibilité Lecture CM2 (suite et fin de #9/#10/#11)

**Demande initiale** : même demande que #11, traité en parallèle par un agent dédié sur
`csv/questions/cm2/lecture/histoires_generated.csv` — l'écart de lisibilité le plus sévère des 5
classes du jeu (Y=27,4 vs cible 40-55).

**Diagnostic** : comme pour CM1, le nombre de mots par histoire était déjà bon (297-355, cible
300-380) mais les phrases étaient extrêmement denses : seulement 10-24 phrases pour ~324 mots en
moyenne, soit environ 27 mots par phrase (cible CM2 : 12-18 mots/phrase, la plus large des 5
classes car c'est le niveau le plus avancé). Consigne explicite de garder un vocabulaire riche,
propre au niveau CM2 (le plus élevé du jeu) — le vrai levier était la fragmentation des phrases,
pas la simplification lexicale.

**Résultat** : 47/47 passages retouchés (le plus sévère des 4 classes traitées, aucun n'était déjà
conforme). Le vocabulaire riche CM2 a été conservé partout ; quelques adverbes intensificateurs
redondants ont été retirés sur 2 histoires à très forte densité (27840, 27861) pour alléger la
densité syllabique sans appauvrir le sens.

**Écriture finale** : même méthode sûre que les entrées précédentes.

**Vérification structurelle (refaite indépendamment)** : 987 lignes des deux côtés, mêmes ids dans
le même ordre, 0 écart en dehors des colonnes `text` des 47 passages retouchés, fichier final en
LF pur (0 `\r\n`).

**Résultat lisibilité (Kandel-Moles, recalculé indépendamment)** :

| | Avant | Après |
|---|---|---|
| Y moyen (47 passages) | 27,4 | **42,0** |
| Passages dans la bande 35-60 | non mesuré individuellement avant | **47/47** |
| Mots par passage | 297-355 (déjà conforme) | dans la cible 300-380, **47/47** |

**Recherche de remplissage répétitif** : recherche automatique refaite indépendamment sur le
fichier final — aucun passage n'atteint le seuil d'alerte (3 occurrences des motifs surveillés).
Aucun remplissage générique détecté.

**Vérification manuelle croisée des mots-cibles `[V]`** : recherche exacte sur les 282 questions
`[V]` du fichier — **282/282 présents** dans le texte réécrit (0 manquant), y compris plusieurs
incohérences préexistantes dans les données d'origine (mots-cibles sans accent, ex. "encadres" au
lieu de "encadrés") restaurées à l'identique de ce qu'attendaient les questions plutôt que
"corrigées" vers une orthographe qui aurait cassé le lien question/texte. Échantillon complémentaire
de 11 histoires réparties sur toute la plage d'ids relu manuellement : tous les faits `[L]`/`[I]`
conservés.

**Aucun autre fichier touché** : CP, CE1, CE2, CM1 restent strictement inchangés.

**Bilan du chantier de réécriture Lecture (entrées #9 à #12, 2026-09-19)** : demandé par Steve
("on va faire le chantier lecture... rendre le texte clair et lisible avec sauts de lignes
paragraphes etc... pour aérer les textes"), identifié depuis l'entrée #5. Les 4 classes
concernées par un écart de lisibilité (CE1, CE2, CM1, CM2) sont désormais toutes réécrites et
vérifiées indépendamment ; CP était déjà conforme depuis l'origine et n'a jamais eu besoin d'être
touché. Score moyen global : CE1 62,5→77,0, CE2 66,3→68,7, CM1 36,3→55,0, CM2 27,4→42,0. Quelques
passages à vocabulaire thématique obligatoire dense (musée/dinosaures notamment, récurrent sur
plusieurs classes) restent en dessous du centre de leur bande cible plutôt que de sacrifier des
faits testés par les questions — accepté en connaissance de cause à chaque fois. `LECTURE_
DIFFICULTE.md` reste à mettre à jour avec ces résultats (laissé à la charge de Steve ou d'une
prochaine session sur sa demande). Import Godot en attente sur les 4 fichiers modifiés.


### #13 — 2026-09-19 — Comparatifs anglais incohérents (CM1/CM2) : "riche/pauvre" et "rocher plus large qu'une plume"

**Demande initiale** : sur cm1/english, Steve signale deux phrases absurdes rencontrées en jeu :
"comment dit-on 'un éléphant est plus riche qu'une souris'" (la richesse ne s'applique pas à un
animal) et "un rocher est plus large qu'une plume" (comparaison de largeur qui n'a pas de sens
pour ce couple précis).

**Portée réelle auditée** : extraction exhaustive (pas seulement grep du mot signalé, cf.
[[feedback_exhaustive_vs_reactive_audits]]) de la famille de questions "Comment dit-on '[nom1]
est plus [adjectif] qu'un/qu'une [nom2]'" dans les 5 classes. Confirmé : cette famille n'existe
qu'en `cm1/english` (135 lignes) et `cm2/english` (74 lignes) ; CP/CE1/CE2 n'en ont aucune trace.
Analyse : la famille croise mécaniquement 8 adjectifs identiques (cleaner/heavier/higher/hotter/
longer/louder/richer/wider) avec chacune des 17 (CM1) / 9 (CM2) paires nom "grand/petit" de
référence (éléphant/souris, baleine/poisson, rocher/plume, etc.), sans aucun filtre de
plausibilité — même schéma de bug que les audits précédents sur les adjectifs poids/forme
([[feedback_weight_shape_adjective_mismatch]]).

**Motifs trouvés et corrigés** :
- "riche/pauvre" (richer/poorer) : la richesse est un concept économique qui ne s'applique à
  aucune des ~19 paires (animaux, véhicules, éléments géographiques, bâtiments) — retiré
  entièrement de la famille comparative-nom et remplacé, pour chaque paire, par un adjectif
  propre et plausible cohérent avec pourquoi cette paire a été choisie (ex. "bigger/plus
  grand(e)" pour la plupart des paires taille, "faster/plus rapide" pour cheval/chien,
  avion/oiseau, train/bicyclette, fusée/voiture, "stronger/plus fort" pour éléphant/souris —
  pour éviter un doublon avec la ligne "bigger" déjà existante pour cette paire —,
  "older/plus vieille" pour tortue/lapin, "deeper/plus profond" pour fleuve/ruisseau,
  "harder/plus dur" pour rocher/plume). Appliqué à toutes les occurrences de ces phrases, qu'elles
  soient la bonne réponse d'une ligne ou un distracteur ailleurs dans le fichier. Les questions de
  vocabulaire isolées ("comment dit-on 'le plus riche'" sans comparaison de noms) laissées
  inchangées — elles n'affirment rien d'incohérent en elles-mêmes.
- "rocher est plus large qu'une plume" (et tous les distracteurs "A rock is wider than a feather"
  ailleurs dans le fichier) : la largeur n'est pas la dimension naturelle de comparaison pour ce
  couple (contrairement aux autres paires taille de la famille, ex. éléphant/souris,
  fleuve/ruisseau, où "large/wide" décrit bien leur silhouette) — rocher/plume est une paire
  "lourd/léger" (cf. l'expression "léger comme une plume"), pas une paire "large/étroit".
  Remplacé par "bigger/plus grand" (déjà vrai et naturel, distinct de la ligne "heavier" déjà
  existante pour ce couple).
- Bug latent trouvé pendant la relecture exhaustive (cm2/english uniquement) : 56 occurrences de
  l'élision manquante "que un"/"que une" au lieu de "qu'un"/"qu'une" (ex. "un fleuve est plus
  large que un ruisseau" au lieu de "qu'un ruisseau") — corrigé globalement ; cm1/english n'avait
  pas ce défaut (0 occurrence).

**Résultats** : CM1 : 53 lignes corrigées pour riche/pauvre + 7 lignes pour rocher/plume-large.
CM2 : 26 lignes corrigées pour riche/pauvre + 4 lignes pour rocher/plume-large + 56 occurrences
d'élision corrigées. `id`, structure des 6 colonnes et nombre de lignes strictement inchangés
(507 CM1, 528 CM2, vérifié par parsing CSV — aucune ligne malformée, aucun id dupliqué). Plus
aucune occurrence de "is richer than"/"is poorer than" ni de "wider than a feather" dans les deux
fichiers après correction.

**Point laissé de côté (à valider avec Steve si besoin)** : dans la même famille, "cleaner"/
"louder" restent utilisés pour rocher/plume, livre/feuille, montagne/colline (ex. "un rocher est
plus bruyant qu'une plume") — bruit/propreté sont un peu moins naturels pour ces objets inertes
que pour les animaux/véhicules, mais moins clairement incohérents que "riche" ou "large" ; non
touchés dans cette passe pour rester focalisé sur les deux points signalés et éviter une réécriture
non validée à grande échelle.

**Sauvegardes** : `generated.csv.bak_avant_fix_comparatifs_incoherents_20260919` dans
`cm1/english/` et `cm2/english/`.

**Import Godot en attente** (comme pour chaque lot précédent) : `tools/admin/import_questions.gd`
à relancer pour CM1 et CM2.


### #14 — 2026-09-19 — Suite de #13 : "chaud/hotter" et "fleuve plus haut qu'un ruisseau"

**Demande initiale** : Steve, en rejouant, tombe sur deux nouvelles phrases de la même famille
comparative anglaise : "un avion est plus chaud qu'un oiseau" et "un fleuve est plus haut qu'un
ruisseau" — deux cas où l'adjectif ne correspond à aucune dimension naturelle du couple.

**Portée réelle auditée** : plutôt que corriger uniquement avion/oiseau (le cas signalé), extraction
et relecture de TOUTES les occurrences de "chaud/hotter" dans la famille comparative (17 paires
CM1, 9 paires CM2), conformément à [[feedback_exhaustive_vs_reactive_audits]] — la chaleur d'un
animal, d'un véhicule (hors fusée), d'un bâtiment ou d'un objet statique n'est pas une comparaison
qu'un locuteur ferait spontanément ; seule fusée/voiture a une justification réelle (chaleur du
moteur/de la rentrée atmosphérique) et a été laissée telle quelle.

**Corrections appliquées** :
- "chaud/hotter" retiré de 16 paires (toutes sauf fusée/voiture) et remplacé par un adjectif propre
  à chaque paire et non redondant avec ses lignes existantes (ex. "plus fort/stronger" pour
  ours-chat, immeuble-maison, voiture-vélo, géant-souris, cheval-chien, tortue-lapin, train-
  bicyclette, camion-moto, baleine-poisson ; "plus dur/harder" pour livre-feuille ; "plus
  rapide/faster" pour lion-canard ; "plus vieux-vieille/older" pour montagne-colline et rocher-
  plume ; "plus grand/bigger" pour avion-oiseau et fleuve-ruisseau). Cas particulier
  éléphant/souris : "stronger" et "bigger" étaient déjà pris pour cette paire (cf. #13) — la
  phrase a été inversée en "une souris est plus calme qu'un éléphant" / "A mouse is quieter than
  an elephant" (mot "calme"=quiet déjà établi ailleurs dans le fichier), plutôt que de forcer un
  adjectif qui aurait fait doublon.
- "un fleuve est plus haut qu'un ruisseau" : la hauteur/altitude n'est pas une dimension naturelle
  pour comparer deux cours d'eau (contrairement à une montagne/colline, où "haut" est la
  comparaison canonique) — remplacé par "plus fort/stronger" (le courant d'un fleuve est bien plus
  fort que celui d'un ruisseau, comparaison naturelle et vraie).
- Appliqué à toutes les occurrences de ces phrases, bonne réponse ou distracteur, dans les deux
  fichiers.

**Résultats** : 53 lignes CM1 + 34 lignes CM2 corrigées. `id`, structure des 6 colonnes et nombre
de lignes strictement inchangés (507 CM1, 528 CM2, vérifié par parsing CSV). Plus aucune
occurrence de "is hotter than" dans les deux fichiers sauf la ligne fusée/voiture (conservée), et
plus aucune occurrence de "river is higher than a stream".

**Point toujours laissé de côté** : "cleaner"/"louder" restent utilisés pour rocher/plume,
livre/feuille, montagne/colline, immeuble/maison (cf. note de l'entrée #13) — non corrigés dans
cette passe non plus, en l'absence de signalement direct et pour ne pas réécrire à l'aveugle une
grande partie de la famille sans validation.

**Sauvegardes** : `generated.csv.bak_avant_fix_hot_high_20260919` dans `cm1/english/` et
`cm2/english/` (en plus de la sauvegarde de l'entrée #13, toujours en place).

**Import Godot en attente** (comme pour chaque lot précédent) : `tools/admin/import_questions.gd`
à relancer pour CM1 et CM2.


### #15 — 2026-09-19 — Passe complète finale : "cleaner"/"louder"/"higher" retirés des paires où ils n'ont aucun sens

**Demande initiale** : Steve demande explicitement d'"augmenter la logique derrière les
questions" et de ne laisser aucune comparaison ambiguë ou farfelue, plutôt que de continuer à
corriger un exemple à la fois. C'est exactement le point laissé de côté dans les entrées #13 et
#14.

**Portée réelle auditée** : relecture complète des 8 adjectifs mécaniques (cleaner/heavier/
higher/longer/louder/wider, + les remplacements déjà faits pour richer et hotter) sur les 19
paires nom des 2 fichiers, en jugeant chaque combinaison avec le même critère que
[[feedback_no_unjustified_context_adjectives]] : est-ce qu'un locuteur dirait cette phrase
spontanément, sans contexte ajouté ?

**Analyse et corrections** :
- "heavier"/"longer"/"wider" : conservés partout — le poids, la longueur et la largeur sont des
  propriétés physiques universelles, jamais absurdes même pour des paires inhabituelles.
- "cleaner" (propre) : retiré pour montagne-colline et rocher-plume (une montagne ou un rocher ne
  se décrivent pas par leur propreté dans une phrase spontanée) → remplacé par "drier"/"plus
  sec(sèche)" (montagne-colline) et "thicker"/"plus épais" (rocher-plume). Conservé pour tous les
  animaux, véhicules, immeuble-maison et livre-feuille (ces objets/êtres se salissent réellement
  et se décrivent bien ainsi).
- "louder" (bruyant) : retiré pour immeuble-maison, montagne-colline, livre-feuille et rocher-
  plume — aucun de ces objets ne produit de son de façon plausible → remplacé par "thicker"/"plus
  épais" (immeuble-maison, livre-feuille), "harder"/"plus dur(e)" (montagne-colline), "stronger"/
  "plus fort" (rocher-plume). Conservé pour tous les animaux (ils émettent des sons) et véhicules
  (moteurs) ainsi que fleuve-ruisseau (rapides/courant).
- "higher" (haut) : retiré pour livre-feuille et rocher-plume (la hauteur n'est pas une dimension
  naturelle pour comparer un livre à une feuille ou un rocher à une plume, contrairement à un
  immeuble/une montagne) → remplacé par "older"/"plus vieux" (livre-feuille) et "drier"/"plus sec"
  (rocher-plume). Conservé pour tous les animaux, véhicules, immeuble-maison, montagne-colline
  (comparaison canonique) et fleuve-ruisseau avait déjà été traité en #14.
- Vérification que chaque nouveau mot introduit (thicker/harder/drier/older/stronger) ne fait pas
  doublon avec un adjectif déjà utilisé pour la même paire, pour garder 8 comparaisons distinctes
  et toutes plausibles par paire.

**Résultat final** : les 19 paires (17 CM1 + 9 CM2, dont 7 communes) ont chacune un jeu de 7 ou 8
adjectifs tous physiquement plausibles pour ce couple précis — plus aucune combinaison du type
"immeuble bruyant", "rocher propre" ou "livre plus haut qu'une feuille". Seule fusée-voiture
conserve "hotter" (justifié, cf. #14). 31 lignes CM1 + 35 lignes CM2 corrigées dans cette passe.
`id`, structure des 6 colonnes et nombre de lignes strictement inchangés (507 CM1, 528 CM2,
vérifié par parsing CSV).

**Sauvegardes** : `generated.csv.bak_avant_fix_remaining_20260919` dans `cm1/english/` et
`cm2/english/` (s'ajoutent aux sauvegardes des entrées #13 et #14, toutes encore en place).

**Import Godot en attente** (comme pour chaque lot précédent) : `tools/admin/import_questions.gd`
à relancer pour CM1 et CM2 — un seul import suffira pour cumuler les 3 passes #13/#14/#15.

### #16 — 2026-09-20 — Phrases sans COD/COI, formulations non-sens et proposition correcte absente des choix (signalé depuis une session CM2)

**Demande initiale** : Steve signale, en jouant une session CM2 (pack de révision, qui pioche
aussi dans CE1/CE2/CM1), trois problèmes distincts : (1) des phrases sans COD ni COI, (2) des
formulations qui n'ont pas de sens, (3) des propositions fausses où la bonne réponse n'est même
pas dans les 4 choix (exemple donné : "___ belle surprise !" validait "Quel" alors que "Quelle"
n'était pas proposée). Portée étendue aux 5 classes pour grammaire/conjugaison/orthographe, per
[[feedback_csv_check_workflow]] — les 3 bugs trouvés viennent en réalité de CE2/CM1 (remontés en
CM2 via le pack de révision), confirmant que le signalement "CM2" doit être audité toutes classes.

**Bug #3 (réponse correcte absente des choix) — `ce2/orthographe`** : famille homophone
quel/quelle/quels/quelles/qu'elle (31 lignes, revue exhaustivement). 2 lignes buguées : id 33823
("___ belle surprise !", "surprise" est féminin) et id 33826 ("___ heure as-tu rendez-vous ?",
"heure" est féminin) avaient toutes deux `correct_answer=Quel` (masculin, faux) alors que la
forme féminine correcte "Quelle" n'apparaissait dans aucun des 4 choix. Corrigé en changeant
`correct_answer` en "Quelle" (les 3 distracteurs Qu'elle/Quels/Quelles restent inchangés et
suffisent, comme pour les lignes soeurs déjà correctes de la même famille).

**Bug #1 (phrase sans COD/COI) — `ce2/grammaire`, famille accord sujet-verbe (notion CE2 "accord
sujet-verbe")** : audit exhaustif des 178 lignes de cette famille (gabarit "Sujet [complément de
temps] ___." testant la conjugaison au présent). 121 lignes n'avaient rien après le blanc ; sur
ces 121, 47 utilisaient un verbe transitif qui a structurellement besoin d'un COD/COI/complément
de lieu pour former une phrase complète (arroser, fermer, ouvrir, décorer, mesurer, préparer,
tester, visiter, choisir, nourrir, habiter, chercher, punir, remplir, commencer, bâtir, observer,
planter, calculer, noter) — ex. "Chaque jour, la secrétaire ___." (arrose) ne dit pas QUOI elle
arrose. Les 74 autres verbes bare (danser, chanter, réfléchir, agir, grandir, vieillir, rougir,
pâlir, réussir, obéir, voyager, nager, grimper, brouter, creuser, descendre, parler, écouter...)
sont des emplois absolus authentiquement complets en français et n'ont pas été touchés. Les 47
lignes corrigées ont reçu un complément ajouté après le blanc, cohérent avec le sujet (ex. id
31820 "Chaque jour, la secrétaire ___ les plantes.", id 31245 "En ce moment, il ___ la porte.").
Liste complète des 47 ids dans le commentaire de commit / diff. Même vérification programmatique
(stem-grouping des 4 choix) faite sur `ce1/grammaire`, `cm1/grammaire`, `cp/french` et les
fichiers `conjugaison` (format "Comment conjugue-t-on..." — jamais de phrase à trou, donc jamais
concerné) : aucune famille équivalente ailleurs, le bug est confiné à `ce2/grammaire`.

**Bug #1 bis (même famille, isolé) — `cm1/grammaire`** : id 34667 "Jade est déjà ___." (retournée)
avait le même bug que le précédent [[feedback_obligatory_complement_verbs]] (retourner exige un
complément de lieu) mais dans le nouveau lot de contenu ajouté après ce fix (ids 34xxx, lot
d'extension à 1000 questions du 2026-08-07) — raté par le fix original qui ne portait que sur
l'ancienne tranche d'ids. Corrigé : "Jade est déjà ___ à la maison."

**Bug #2 (non-sens) — `cm2/orthographe`** :
- id 12082 "Je suis sur ___ vous dites." (qu'en) n'est pas du français valide — corrigé en "Elle
  ne sort ___ cas d'urgence." (qu'en cas d'urgence), qui respecte le schéma ne...que+en des autres
  lignes correctes de la famille quand/quant/qu'en.
- id 12093 "Quand ___ demanderont, dis la vérité." (quant) — le mot "Quand" apparaissait déjà en
  clair dans le texte ET le blanc demandait "quant" juste après, ce qui donne "Quand quant
  demanderont..." (incompréhensible). Corrigé en "___ ils te demanderont, dis la vérité."
  (correct_answer="Quand", les 3 distracteurs recapitalisés Quant/Qu'en/Kan puisque le blanc est
  maintenant en début de phrase, cf. [[feedback_no_parentheses_anywhere]] note sur la
  capitalisation liée à la position du blanc).
- Famille homophone sens/sans/s'en/sang (9 lignes avec `correct_answer=sens`, revue exhaustivement) :
  5 lignes appliquaient "sens" (signification/direction) à un aliment ou un parfum là où le mot
  attendu est "goût"/"odeur" — non-sens du type "ce gâteau a un bon sens", "le vin a un bon sens".
  Corrigées en gardant le mot "sens" mais en changeant le sujet pour un contexte où il s'emploie
  réellement (sens de l'orientation, sens des responsabilités, sens ironique, sens du rythme, sens
  caché) : ids 12085, 39016, 39021, 39717, 39718. Les 4 lignes déjà correctes de la même famille
  (sens de l'humour, phrase sans sens, chemin qui change de sens, mot sans aucun sens) inchangées.

**Vérifié avant écriture** : chacun des 3 fichiers modifiés (`ce2/grammaire`, `ce2/orthographe`,
`cm2/orthographe`, `cm1/grammaire`) garde exactement 1000 lignes, aucune des nouvelles phrases
introduites ne duplique une ligne existante du même fichier (vérifié par comparaison de texte
exacte), colonnes `id`/structure inchangées ailleurs.

**Points laissés en attente, nécessitent une décision de Steve (pas corrigés dans cette passe)** :
1. `cm1/grammaire` contient 34 lignes "X vient d'être ___." avec un participe de verbe
   intransitif de mouvement/état (mourir, partir, tomber, monter, descendre, entrer, rentrer,
   revenir, passer, naître, rester) — construction passive grammaticalement admise mais peu
   naturelle à l'oral (voir [[feedback_obligatory_complement_verbs]], point déjà identifié le
   2026-09-09 et jamais tranché). Ce lot de 34 est le même core issue que le signalement "non-sens"
   actuel. Deux options de correction possibles : (a) réécrire en "vient de + infinitif" (perd le
   test d'accord du participe, change la nature de l'exercice), (b) garder la construction "vient
   d'être X" mais remplacer le verbe par un verbe transitif compatible avec le passif (puni,
   félicité, récompensé...) pour ces 34 lignes précises, en gardant sujet/structure identiques.
2. `cm2/orthographe`, famille tout/tous/toute/toutes : ~9 lignes du type "[Sujet] a/ont/avons ___
   [participe] [COD explicite]" (ex. id 39023 "Elle a ___ fini son travail.", ids 39216-39221 "X a
   ___ compris la leçon.") utilisent "tout" comme adverbe entre l'auxiliaire et le participe alors
   qu'un COD explicite suit — combinaison à la limite du naturel en français standard (on dirait
   plutôt "elle a fini tout son travail" ou "elle a tout fini"). Pas corrigé : nécessite de
   déplacer le blanc et peut changer la bonne réponse (tout -> toute devant "la leçon", féminin),
   donc changement plus lourd qu'une simple correction de texte.

**Sauvegardes** : `generated.csv.bak_avant_fix_cod_nonsens_20260920` dans `ce2/grammaire/`,
`ce2/orthographe/`, `cm1/grammaire/` et `cm2/orthographe/`.

**Import Godot en attente** pour ces 4 fichiers.

### #17 — 2026-09-20 — Suite de l'entrée #16 : les 2 points laissés en attente, tranchés par Steve

**"Vient d'être" (`cm1/grammaire`, 29 des 34 lignes concernées — 5 avaient déjà un complément et
n'étaient pas concernées)** : Steve choisit l'option "remplacer le verbe" (garder la structure
"X vient d'être ___." et l'accord du participe, changer le verbe). Les 11 verbes intransitifs de
mouvement/état (mourir/partir/tomber/monter/descendre/entrer/rentrer/revenir/passer/naître/rester)
remplacés par une rotation de 10 verbes transitifs compatibles avec le passif, universellement
applicables à un sujet humain (féliciter, récompenser, punir, choisir, inviter, nommer, consoler,
applaudir, examiner, interroger) — ex. id 34213 "Lea vient d'être ___." : morte -> félicitée.
Seuls `correct_answer`/`choice_2/3/4` changent (4 formes en genre/nombre du nouveau participe,
accordées au même sujet) ; `id` et `text` inchangés.

**"Tout" + COD explicite (`cm2/orthographe`, 9 lignes)** : Steve valide la correction. Le blanc
déplacé pour que "tout/toute" soit un déterminant directement devant le COD plutôt qu'un adverbe
entre l'auxiliaire et le participe : "Elle a ___ fini son travail." -> "Elle a fini ___ son
travail." (accord inchangé : tout, "travail" masculin) ; "Marie a ___ compris la leçon." ->
"Marie a compris ___ la leçon." (accord changé : tout -> toute, "leçon" féminin) sur 6 lignes
(Marie/Paul/Léo/Zoé/Tom/Nina) ; "Nous avons ___ terminé l'exercice." -> "... terminé ___
l'exercice." (tout, masculin, inchangé) ; "Elle a ___ rangé sa chambre." -> "... rangé ___ sa
chambre." (tout -> toute, féminin).

**Vérifié** : `cm1/grammaire` et `cm2/orthographe` toujours à 1000 lignes chacun, aucun nouveau
doublon de texte introduit (les seuls doublons présents dans les 2 fichiers sont préexistants et
non liés à cette passe : "Marie est ___ dans la cour." dans cm1/grammaire, et le gabarit
générique "Quelle est la bonne orthographe ?" dans cm2/orthographe, répété par conception).

**Sauvegardes** : réutilise les mêmes `generated.csv.bak_avant_fix_cod_nonsens_20260920` créées
pour l'entrée #16 (contiennent l'état d'avant TOUTE cette session, donc avant #16 et #17).

**Import Godot en attente** (cumulé avec l'entrée #16, un seul import suffira pour
ce2/grammaire, ce2/orthographe, cm1/grammaire, cm2/orthographe).

### #18 — 2026-09-20 — Ajout d'un COD/COI/complément aux 29 lignes "vient d'être X" (entrée #17)

**Demande** : Steve fait remarquer que la correction de l'entrée #17 (remplacement du verbe
intransitif par un verbe compatible avec le passif) n'ajoutait pas de complément — les phrases
comme "Lola vient d'être choisie." restaient courtes, sans COD/COI, alors que c'est exactement ce
que la demande initiale (entrée #16, point #1) visait à corriger.

**Correction** : les 29 lignes de `cm1/grammaire` corrigées en #17 ont chacune reçu un complément
adapté au verbe (COI introduit par pour/à/sur, complément d'agent introduit par par, ou attribut
du COD sans préposition pour "nommer"), en variant sujet par sujet pour éviter la répétition :
- féliciter/récompenser/punir -> "pour + raison" (pour son excellent dessin, pour ses efforts,
  pour son retard...)
- choisir -> "pour + rôle/évènement" (pour l'équipe de football, pour le rôle principal...)
- inviter -> "à + évènement" (à l'anniversaire de sa cousine, au mariage de son oncle...)
- nommer -> attribut direct (déléguée de la classe, capitaine de l'équipe...)
- consoler/applaudir/examiner -> "par + agent" (par sa grande soeur, par tout le public, par le
  médecin...)
- interroger -> "sur + sujet" ou "par + agent" (sur la leçon de sciences, par le professeur)

Exemple : id 34932 "Lola vient d'être ___." -> "Lola vient d'être ___ pour le spectacle de fin
d'année." (correct=choisie, inchangé).

**Vérifié** : `cm1/grammaire` toujours à 1000 lignes, aucun nouveau doublon de texte (seul
doublon présent est préexistant : "Marie est ___ dans la cour.", sans rapport avec cette passe).
Seule la colonne `text` a changé sur ces 29 lignes ; `id`/`correct_answer`/choix inchangés.

**Sauvegarde** : réutilise `generated.csv.bak_avant_fix_cod_nonsens_20260920` (état d'avant toute
la session, donc avant #16/#17/#18).

**Import Godot en attente** (cumulé avec #16 et #17).


### #19 — 2026-09-20 — Difficulté Logique CM1/CM2 : combinatoire hors-programme + César suspect

**Demande** : Steve signale en jouant (capture d'écran) que certaines questions de logique CM1 et
CM2 sont trop difficiles — exemples vus en jeu : « Combien de façons différentes peut-on ranger 4
objets différents côte à côte sur une étagère ? » (réponse 24) et « Avec 7 amis, combien de paires
différentes peut-on former ? » (réponse 21). Demande un audit de la difficulté et du type de
questions pour CM1 et CM2 uniquement (scope explicitement restreint, contrairement à la règle
générale d'audit sur toutes les classes — voir `feedback_csv_check_workflow.md`).

**Contexte** : contredit en partie la conclusion de l'entrée #8 (2026-09-19), qui avait validé la
progression de difficulté de Logique sur les 5 classes en se basant sur la cohérence *relative*
de la progression (chaque famille apparaît à la bonne classe, complexité croissante à l'intérieur
d'une famille) — mais sans juger le niveau *absolu* de chaque famille avancée par rapport au
programme réel du primaire. Ce signalement en jeu comble ce trou méthodologique.

**Méthode** : classification programmatique des 500 questions de `cm1/logique/generated.csv` et
`cm2/logique/generated.csv` par famille (mots-clés + échantillonnage manuel), puis extraction
complète de chaque famille suspecte pour lecture ligne par ligne (pas seulement le cas déjà
signalé — voir `feedback_exhaustive_vs_reactive_audits.md`).

**Résultat CM2 — famille « combinatoire simple » (10 questions, ids 44009, 44447-44455)** :
- 4 questions de permutation (« ranger N objets », N=3,4,5,6) — réponses 6, 24, 120, 720 (N!).
- 6 questions de combinaison (« paires avec N amis », N=4,5,6,7,8,9) — réponses 6, 10, 15, 21, 28,
  36 (N×(N-1)/2).
- **Confirmé hors-programme** : la factorielle et le calcul de combinaisons ne sont enseignés à
  aucun moment du primaire français (notions de lycée). Sans connaître la formule, un·e élève de
  CM2 ne peut résoudre ces questions que par énumération manuelle exhaustive, qui devient
  rapidement infaisable (36 paires à lister pour N=9, 720 arrangements pour N=6) — contrairement
  aux autres familles avancées de CM2 (César, grille de Raven, menteur/vérité, déduction), qui
  restent résolubles par raisonnement pas-à-pas même sans formule mémorisée. C'est très
  probablement la famille visée par le signalement de Steve (les deux exemples de la capture
  d'écran correspondent exactement aux ids 44447 et 44453).

**Résultat CM2 — famille « chiffrement de César » (91 questions, 18% du fichier)** : décalage de
+1 à +8 appliqué lettre par lettre (avec retour au début de l'alphabet) à des mots de 3 à 8 lettres
(majorité 5-6 lettres). Contrairement au code CM1 (A=1, B=2… consultation directe d'une seule
lettre à la fois), décoder un mot entier demande de répéter un décalage modulo 26 sur chaque
lettre en gérant le rebouclage (ex. S+7=Z), ce qui représente une charge de calcul élevée et
répétitive pour du CM2 — **suspecte mais pas confirmée hors-programme** comme la combinatoire :
le principe (décalage circulaire) reste un raisonnement accessible, contrairement à une formule
absente du programme. Signalée à Steve pour décision (réduire le nombre de lettres/le décalage
maximum, réduire le volume de la famille, ou laisser en l'état).

**Reste de CM2 jugé approprié** : grille numérique façon Raven (75 questions, pattern additif
ligne/colonne, résoluble par tâtonnement), menteur/vérité (41 questions, logique directe : qui a
dit une phrase vraie/fausse), déduction 3-personnes par élimination (14 questions), suites
numériques simples/composées/entrelacées/×k+c, analogies fonctionnelles.

**Résultat CM1 (aucune famille hors-programme confirmée)** : code lettre-chiffre direct (68
questions — lecture d'une seule lettre, ou somme de 4 à 8 lettres pour 20 d'entre elles, addition
multiple mais sans notion nouvelle), grille 3x3 à rotation cyclique de symboles (61 questions),
carrés parfaits (19 questions), suites composées à une ou deux opérations, déduction d'âge/ordre
de course par transitivité, analogies partie-tout, contraires — toutes jugées cohérentes avec le
niveau CM1, aucun signal de difficulté excessive trouvé.

**Vérifié** : comptage exhaustif par famille sur les 500+500 lignes (pas d'échantillon partiel),
lecture ligne par ligne de la totalité des 10 questions de combinatoire et d'un échantillon large
des autres familles suspectes (César, grille Raven, code lettre-chiffre) pour juger la charge de
calcul réelle, pas seulement la présence du marqueur textuel.

**Aucune correction appliquée** — audit seul, comme demandé. Décision de Steve attendue :
(a) combinatoire — retirer/remplacer les 10 questions (ids ci-dessus), et par quoi ; (b) César —
garder en l'état, réduire la difficulté (mots plus courts / décalage plus petit), ou réduire le
volume ; (c) éventuellement corriger `LOGIQUE_DIFFICULTE.md` section 1 (tableau CM2) pour retirer
la mention « combinatoire simple » de la liste des familles validées, et documenter ce nouveau
constat.

**Import Godot** : sans objet (aucune modification de CSV à ce stade).


### #20 — 2026-09-20 — Suite de l'entrée #19 : correction appliquée (combinatoire retirée, César raccourci)

**Décision de Steve** : (a) combinatoire CM2 — retirer et remplacer par 10 nouvelles questions
dans une famille déjà validée pour CM2 ; (b) César CM2 — réduire la difficulté (mots plus courts,
décalage plus petit) plutôt que le volume ou le statu quo.

**Combinatoire (10 questions, ids 44009, 44447-44455)** : remplacée par 10 suites numériques
« ×k+c » (multiplier par k puis ajouter c), même format que les suites déjà présentes dans le
fichier (`Quel nombre vient après ? a, b, c, d, …`), avec k∈{2,3}, dernier terme < 900 pour rester
lisible. Distracteurs sur le même schéma que les suites ×k+c existantes (réponse+2, réponse-1,
réponse+1). 10 textes vérifiés uniques parmi les 500 lignes du fichier.

**César (91 questions)** : mots réduits à 3-4 lettres (banque de 32 noms courants : LAC, MUR, SAC,
CHAT, LOUP, VELO, LUNE, PAIN… au lieu des mots de 5-8 lettres précédents) et décalage limité à
+1/+2/+3 (au lieu de +1 à +8). Schéma de distracteurs conservé à l'identique de la famille
d'origine (décalage+1, décalage-1 ou +2 si le -1 tombe à 0, mot inversé) pour ne pas introduire de
nouvelle logique de génération. Les 91 réponses recalculées et vérifiées programmatiquement contre
un chiffrement de César indépendant — 0 erreur.

**Vérifié** :
- 500/500 lignes conservées, ids et ordre identiques à l'original.
- Aucune modification hors des 101 lignes ciblées (diff ligne à ligne contre la sauvegarde,
  0 écart inattendu) — grille numérique/menteur-vérité/déduction/suites existantes intactes.
- 0 doublon de texte introduit parmi les 101 lignes remplacées.
- Chaque ligne modifiée garde exactement 4 choix distincts.
- 0 erreur de calcul sur les 91 questions de César (recalcul indépendant du chiffrement).

**Sauvegarde** : `generated.csv.bak_avant_fix_logique_cm2_20260920` (état complet du fichier avant
cette correction) — à supprimer seulement après validation en jeu + push GitHub, comme d'habitude.

**Import Godot en attente** (comme pour tout ajout/modification de contenu CSV).

**À faire ensuite si Steve le demande** : mettre à jour `LOGIQUE_DIFFICULTE.md` section 1 (le
tableau CM2 mentionne encore « combinatoire simple » comme famille — fait, voir section 7 mise à
jour du même fichier).

### #21 — 2026-09-27 — Erreurs de langage + réponses illogiques (4 captures en jeu) — corrigé DANS SUPABASE

**Premier audit appliqué directement dans la base** (Supabase = source de vérité depuis la phase 1 ;
les CSV sont gelés et ne sont PAS modifiés). Script : `server/correctifs_2026-09-27_langage_logique.sql`,
détail ligne à ligne : `server/correctifs_2026-09-27_detail.csv`. 267 questions corrigées, toutes classes.

Signalé par Steve (captures) : « Camille a rencontré un piano » (logique CE2), « vélo » → cycling
(anglais CE1), « un immeuble est plus fort qu'une maison » (anglais CM1/CM2), « Félix a 1 perles » (maths CP).

Équivalents cherchés et corrigés :
1. **Logique CE2 (32)** : famille « Tous les X sont des Y. Nom a rencontré un X » → « a vu un X »
   (rencontrer ne marche pas avec un objet/légume/fleur/instrument).
2. **Maths CP à CM2 (18)** : « 1 + nom au pluriel » → singulier (1 perle, 1 gâteau, 1 unité, 1 dizaine,
   1 euro, 1 mètre, 1 heure). 3 questions seraient devenues des doublons exacts d'autres questions
   (cm1 1762, cm2 1937/1938) → remplacées par une question du même type (demi-heure ; 30 et 90 km/h).
3. **Anglais CE1 (3)** : mots isolés ambigus — « vélo » (= bike) → « faire du vélo », « pêche »
   (= aussi peach, question 19360 existe !) → « faire de la pêche », « course » → « la course à pied ».
4. **Anglais CM1 (10)** : « mon sport préféré est natation » → article ajouté (la natation, le ski…).
5. **Anglais CM2 (12)** : « I did golf/fishing last weekend » → verbe correct selon le sport
   (play pour les sports de balle, go + -ing, do pour gymnastique/judo), bonnes réponses ET choix.
6. **Anglais CM1/CM2 comparatifs (192)** : famille « un X est plus ADJ qu'un Y » générée en croisant
   paires × adjectifs sans contrôle → relue en entier (audit exhaustif, pas réactif). 85 phrases
   cohérentes gardées, 107 incohérentes réécrites (propre, sec, vieux, haut pour un animal, fort pour
   un immeuble…) avec une liste blanche paire → adjectifs plausibles, y compris le sens inverse
   (« une souris est plus légère qu'un géant »). 0 doublon créé. En plus : « higher » → « taller »
   (sauf montagne), « feuille » traduite « sheet of paper » au lieu de « leaf ». Mauvais choix
   refaits en variantes proches de la même phrase (sujet inversé, autre adjectif de la même paire)
   au lieu de phrases sans rapport.

**Sécurité** : chaque ligne n'est modifiée que si son id ET son ancien énoncé correspondent ; si le
compte ≠ 267, tout est annulé. L'ancienne version de chaque ligne est gardée automatiquement dans
`contenu_historique`. `fn_publier()` relancé à la fin (seuls les paquets modifiés changent de version).

### #22 — 2026-09-27 — Ronds de couleur emoji (bug de l'entrée #8) — corrigé DANS SUPABASE

**Cause** : la police d'emoji du jeu (NotoEmoji) est monochrome, les ronds 🔴🟣🔵🟢🟡🟠 s'affichent en noir et blanc avec des motifs rayés, jamais en couleur.

**Correction (validée par Steve)** :
- 54 questions « Que/Quelle couleur vient ensuite ? » (CP + CE1) : énoncé réécrit « Quelle couleur vient ensuite ? jaune, violet, jaune… », bonne réponse et 3 mauvaises réponses remplacées par les noms de couleur (rouge, violet, bleu, vert, jaune, orange).
- 33 questions d'intrus (« Quel dessin ne va pas avec les autres ? », « Quel élément n'est pas… ? ») : 3 ronds + 1 intrus → ronds remplacés par ■ ▲ ★ (énoncé « un rond de couleur » → « une forme ») ; si l'intrus était lui-même une forme noire (● ■ ♦ ♠ ★ ♥), ronds remplacés par 🍎 🍌 🍇 (énoncé → « un fruit ») ; rond seul intrus → remplacé par ■ (ou 🍎 parmi des formes).

**Vérifié** : 0 doublon dans les choix, la bonne réponse figure toujours dans la suite affichée, 0 emoji rond restant dans les questions publiées. Anciennes versions gardées dans `contenu_historique`. `fn_publier()` relancé : cp/logique et ce1/logique passent en version 4.

### #23 — 2026-09-27 — Audit complet de cohérence du français (toutes classes) — corrigé DANS SUPABASE

**Demande de Steve** : beaucoup de questions de grammaire/conjugaison/orthographe ont des phrases sans sens logique ; audit complet, et appliquer la même correction à toutes les phrases du même type.

**Méthode** : export des 13 000 questions françaises publiées, lecture intégrale des phrases (cp/french, ce1→cm2 grammaire et orthographe, cm2 conjugaison), correction par famille de gabarit (script + listes blanches nom→adjectifs / verbe→compléments), puis relecture par un second passage indépendant.

**Corrections par classe** (nombre de questions) :
- **CP french (71)** : pluriels faux (tapis→« tapiss », ananas, ours), noms rares (miel, tigron…), contraires faux (voler/ramper), couleurs ambiguës, distracteurs synonymes aussi justes ; « la femelle du : X » → « la femelle du X / de l'âne » ; perroquet/perruche (pas la même espèce) remplacé ; « oisillon » retiré comme distracteur de pigeonneau/cygneau.
- **CE1 grammaire (104)** : « nature du mot » sur mots ambigus (porte, règle, calme, rire, bien…) → « Dans la phrase « … », quelle est la nature du mot X ? » ; masculin de belle = beau ; mots trop rares remplacés.
- **CE1 orthographe (379)** : et/est à double sujet (verbe sans complément, paires animal+humain) ; « son » avec objets absurdes (joue avec son cahier…) ; adjectifs d'animaux invraisemblables (tortues bruyantes, dauphins lents…) ; cygnette (n'existe pas) → hase ; femelle/mâle (bœuf/vache, perroquet/perruche) corrigés.
- **CE2 grammaire (179)** : phrases de conjugaison incomplètes ou absurdes, types de phrase, impératifs bizarres, élisions (l'horloge, l'actrice), sujets au genre ambigu pour les pronoms (l'architecte, Camille…).
- **CE2 orthographe (425)** : accord de l'adjectif (~360 phrases réécrites avec adjectif plausible + les 3 autres formes du même adjectif comme distracteurs) ; ses/ces (« Il range ces jouets » aussi correct → distracteurs sais/c'est/sait) ; subjonctif après « croire » ; synonymes/contraires obscurs ou faux.
- **CM1 grammaire (361)** : participe passé avec être (mourir → « de rire », naître → lieu/date, aller → lieu, compléments ajoutés, « sera » → est) ; démonstratifs ; COI.
- **CM1 orthographe (43)** : plus tôt/plutôt (distracteur aussi correct), objets implausibles, boîte, mots vieillis (naguère, tantôt).
- **CM2 grammaire (492)** : participe avec avoir (verbe choisi selon l'objet et le complément) ; **61 réponses fausses** dans les relatives (« les valises que vous avez perdue » → perdues) ; fragments sans verbe ; « C'est les » → « Ce sont les » ; compléments circonstanciels absurdes.
- **CM2 orthographe (34)** : accents (théâtre, décor, décodeur avaient une réponse fausse ; hôpital, château, sac, stylo n'ont pas de « e » accentué → mots remplacés) ; « Qu'en dis-tu de cette idée ? » fautif ; tout/tous ambigus ; « Lorsque » et « il neigea » étaient aussi corrects.

**Sécurité** : chaque ligne n'est modifiée que si son id + ancien énoncé + ancienne réponse correspondent (essai à blanc : 2 088/2 088, puis application en une transaction). Réexport après coup : 9 000 questions comparées, 0 écart. Anciennes versions dans `contenu_historique`. `fn_publier()` relancé : 9 paquets français mis à jour (les joueurs les reçoivent à la prochaine connexion).

**Laissé tel quel (acceptable)** : participes employés comme adjectifs classés « adjectif » au CE1 ; « soeur » sans œ (graphie majoritaire) ; quelques plus-que-parfaits isolés (« était né en 2015 »).


### #24 — 2026-09-27 — Logique : exemple inutile en début de question — corrigé DANS SUPABASE

**Signalé par Steve** (capture CP) : « Le petit de 🐑 est l'agneau. Le petit de 🐐 est… » → l'exemple ne sert à rien, poser directement la vraie question. Audit étendu à toutes les classes.

**Trouvé** : 325 questions de ce type (CP, CE1, CE2 — rien en CM1/CM2) : le petit de (CP 30, CE1 31), le contraire de (CP 40, CE1 51, CE2 30), cris d'animaux (CP 31), « sert à » (CE1 50), déplacement (CE2 31), habitat (CE2 30), « Le jour, on se réveille. La nuit, on… » (CP 1).

**Correction** :
- Exemple retiré : « Le petit de 🐐 est… », « Le contraire de grand est… », « Le chien 🐶 fait… », « Le savon sert à… », « La nuit, on… ». Déplacement → « Pour se déplacer, le poisson… » ; habitat → « Où vit le lapin ? » (réponses sans « vit » : « dans un terrier »).
- 194 questions devenaient des doublons exacts (seul l'exemple les différenciait) → choix de Steve : garder 1 exemplaire, remplacer les autres par de nouvelles questions du même type (même id, même notion) : sens inverse (« Quel animal fait « miaou » ? », « Le chaton est le petit de quel animal ? », « Quel objet sert à couper ? », « Le contraire de petit est… », « Quel animal vit dans une ruche ? ») et nouveaux éléments (caneton, renardeau, lapereau, louveteau, faon, ânon, aiglon… ; arrosoir, gomme, tournevis, passoire… ; dauphin, singe, limace, sauterelle… ; écurie, étable, poulailler, niche, banquise… ; allumer/éteindre, entrer/sortir, lisse/rugueux…).
- Au passage : élision « Le contraire d'ouvert / d'acheter / d'épais », canard 🐦 → 🦆, mauvais choix ambigus refaits en déplacement/habitat (ex. « dans l'eau » proposé pour le poisson rouge, « sous terre » pour le lapin, « vole » pour la sauterelle, « nage » pour le crapaud).

**Laissé tel quel (choix de Steve)** : analogies « Le doigt est à la main ce que l'orteil est… » (CE2-CM2) — l'exemple y est la question.

**Vérifié** : 325/325 lignes appliquées (id + ancien énoncé vérifiés, tout ou rien), réexport : 0 modification hors périmètre, 0 doublon créé, 0 question à exemple restante. `fn_publier()` : cp/ce1/ce2 logique mis à jour.

**Suite** : doublons « Quelle couleur vient ensuite ? … » en CP logique traités dans l'entrée #25.

### #25 — 2026-09-27 — Logique CP : doublons « Quelle couleur vient ensuite ? » — corrigé DANS SUPABASE

**Cause** : la réécriture en noms de couleur (entrée #22) a rendu identiques 8 paires de questions qui ne différaient que par la couleur des ronds.

**Correction (validée par Steve)** : 1 question de chaque paire gardée, l'autre remplacée (même id) : 4 nouvelles suites AB (violet/bleu, bleu/violet, jaune/orange, orange/jaune) et 4 suites AAB (« jaune, jaune, rouge, jaune, jaune… »). Ids 40410, 40412, 40418, 40419, 40424, 40428, 40436, 40437.

**Vérifié** : 8/8 lignes appliquées (id + ancien énoncé), CP logique : 500 questions, 0 doublon d'énoncé. `fn_publier()` : cp/logique mis à jour.

### #26 — 2026-09-29 — Notions trop petites (répétitions au tirage) — corrigé DANS SUPABASE

**Demande** : Steve voit revenir « La saison ___ il fait le plus chaud est l'été. » à chaque série de grammaire CM2. Cause : c'était la seule question de sa notion (« vocabulaire_quotidien ») ; comme le tirage met au moins une question par notion dans chaque série, elle tombait à chaque fois. Consigne : vérifier les notions et passer chacune à 20 questions minimum, en complétant celles qui sont presque vides.

**État de départ** : 54 couples classe/notion sous 20 questions (dont 5 à 1 seule question).

**1. Questions mal classées, reclassées (notion seule, texte inchangé)**
- CM2 grammaire : 37309 (« où ») → pronoms_relatifs.
- CM1 orthographe « accord_adjectif » (13 questions, en fait des adverbes) → mots_invariables (11) ; « pouvez / peuvent » (36188, 36189) → homophones. 11102 « vraiment » → mots_invariables.
- CM2 orthographe « vocabulaire_sens » (12100, 12102, 12107, 12109 : re-, -age, -ment) → formation_mots.
- CE2 grammaire « homophones » (12 questions est/sont/a/ont, sans homophone) → accord_sujet_verbe.

**2. Anglais hors programme (ANGLAIS_DIFFICULTE.md), réécrit**
- Prétérit en CE1 (7) et CE2 (8) → présent (« I think / je pense »…), notion en_verbes. 20135 « j'ai volé » (ambigu) → « je nage ».
- Présent en -ing en CM1 (14 « I am wearing… ») → vocabulaire des vêtements (« Comment dit-on "manteau" en anglais ? »), notion en_vetements ; corrige aussi « des pantalon / des pyjama ».

**3. Français fautif corrigé au passage**
- CP (18285-18289) et CE1 (19416-19430) météo : « il fait ensoleillé / pluvieux / venteux / nuageux / neigeux / brumeux » → « il y a du soleil / il pleut / il y a du vent / il y a des nuages / il neige / il y a du brouillard ».
- CE2 20203/20204 « plat de poisson / fish dish / poisson (plat) » → salade / salad.

**4. Ajouts : 507 questions (ids 110000-110506)**, format existant « Comment dit-on… / Que veut dire… », mauvais choix pris dans la même famille de mots ; phrases (âges, émotions, prépositions sur/sous/à côté de/dans, consignes, must, question words) dans la limite du programme de la classe. CP maths « formes géométriques » +13, CM2 maths « mesures » +6 (cL, mm, min, s, t, km décimal). Liste complète : `server/notions_completees_2026-09-29.csv` ; script appliqué : `server/notions_completees_2026-09-29.sql`.

**Vérifié** : 1 transaction (75 UPDATE + 507 INSERT), 0 couple classe/notion sous 20, 0 doublon d'énoncé créé (les 119 doublons restants préexistent, surtout « Quelle est la bonne orthographe ? »). `fn_publier()` : 11 paquets mis à jour.

**Signalé, non corrigé** : CE2 anglais 20337 « je préfère les pommes » → « I prefer apple » (devrait être « apples », avec « I prefer fish dish » en mauvais choix) — même famille de gabarit probablement concernée ; les jours/mois en CE1 existants sont écrits sans majuscule (« wednesday »).

### #27 — 2026-09-29 — « I prefer apple » + jours/mois sans majuscule — corrigé DANS SUPABASE

**Demande** : suite des 2 points signalés en #26, validés par Steve.

**Correction** :
- CE2 en_gouts : « I prefer apple / banana / egg / cake » → apples / bananas / eggs / cakes (préférence générale = pluriel en anglais, comme « je préfère les pommes »), et « I prefer fish dish » → « I prefer fish ». 22 questions (énoncés, réponses et mauvais choix). Cherché sur toutes les classes (I like / I don't like / I prefer / he, she likes) : les autres cas trouvés sont des couleurs (« I like orange ») ou des noms non comptables, corrects.
- Jours et mois anglais écrits sans majuscule (« wednesday », « june ») → majuscule (« Wednesday », « June ») : 52 questions (CP 45, CE1 5, CE2 2), le français reste en minuscule.

**Vérifié** : 74 UPDATE conditionnés sur l'ancien énoncé, 0 jour/mois anglais en minuscule restant, 0 « I prefer » au singulier restant. `fn_publier()` : cp/ce1/ce2 english. Script : `server/correctifs_2026-09-29_anglais.sql`.

### #28 — 2026-09-29 — Lecture : fins « rit un peu », fautes CP, accents CE1-CM2 — corrigé DANS SUPABASE

**Demande** : les histoires finissent souvent par « il/elle rit un peu » → varier les fins ; puis corriger les fautes repérées ; puis check rapide des autres classes.

**CP (45 textes)** : bloc de remplissage final supprimé (« Il/Elle rit un peu. Il fait beau. Le jour est doux. Tout va bien. Elle est bien la. C'est un beau jour. »), remplacé par une fin propre à chaque histoire. Dernières phrases gardées quand une question « à la fin » en dépend (Léa rit très fort, Oskar très content, Erik photo, Simon sourire). Puis 34 textes + 29 questions corrigés : prénom remplacé par « Il/Elle » (« fatigue Il », « aide Elle »…), à/a, phrases cassées, verbes pauvres (passe/voit/dit → traverse/regarde/raconte), texte réaligné sur les questions (pêche tôt le matin, centre équestre, sifflet de départ…), accords dans les choix (fâché, gêné/gênée, cassé, marché, pêcher).

**CE1-CM2** : pas de fin répétée ni de remplissage (sauf « Tout va bien. » dans 24420, supprimé). 48 textes + 317 questions corrigés : participes/adjectifs sans accent final repérés par règles (après être/avoir, très/bien/trop, réponse d'un seul mot, pluriel après nom), triés à la main pour écarter les faux positifs (hâte, envie, salle comble, terre meuble…) ; « à » → « a » (n'y a, Sara a déjà…) ; accents en trop (elle achève, elle gèle, il relativise) ; À en début de phrase ; boîte, mûre, cache-cache, Qu'apportent.

**Signalé, non corrigé** : les questions CM1/CM2 longues (inférence/vocabulaire) gardent encore des accents manquants isolés hors des contextes détectables par règle (ex. « le plaisir procure par »). Relecture ligne par ligne nécessaire pour les éliminer tous.

Scripts : `server/correctifs_2026-09-29_lecture_cp_fins.sql`, `..._lecture_cp_textes.sql`, `..._lecture_ce1_cm2.sql`. `fn_publier()` : cp/ce1/ce2/cm1/cm2 lecture.

### #29 — 2026-10-03 — Conjugaison : QCM refaits selon les temps connus par classe — corrigé DANS SUPABASE

**Demande** : distracteurs de conjugaison trop évidents (lettre ajoutée/supprimée/doublée : « remplir / rremplir », « nous expliquonst », « je coommande ») → les remplacer par des erreurs qui ont un intérêt, en mélangeant les temps connus par la classe ; audit de la base et correction.

**Constat** : les 4000 questions CE1-CM2 (100 %) avaient les 3 distracteurs « typo » de l'entrée #3 (lettre ajoutée à la fin, dernière lettre retirée, voyelle doublée), éliminables sans rien savoir de la conjugaison.

**Nouvelle règle (sujet toujours identique à celui demandé)** — temps connus (cumulatifs, FRANCAIS_DIFFICULTE.md) : CE1 présent ; CE2 + imparfait, futur ; CM1 + passé composé ; CM2 + plus-que-parfait, passé simple (3e personne seulement), conditionnel.
- CE2-CM2 : 2 distracteurs = le même verbe, même sujet, conjugué à un AUTRE temps connu de la classe (le 1er est le temps « voisin » le plus confondu : futur↔conditionnel, imparfait↔passé simple, passé composé↔plus-que-parfait ; le 2e tourne selon l'id) + 1 faute d'accord homophone (terminaison muette : chantait/chantais/chantaient, j'ai fini/finis, il prend/prent, vous chanterez/chanteré).
- Verbes avec être aux temps composés : la faute d'auxiliaire est prioritaire (« il est allé » → « il a allé »).
- CE1 (un seul temps connu) : fautes de terminaison homophones (il chante/chantes/chantent, nous chantont, vous chanter/chanté/chantés) + infinitif (« il chanter ») ; être/avoir : confusions classiques a/à/as, est/et/es, ont/sont/on, j'ai/je suis.
- Formes conjuguées tirées des tables Verbiste (validées sur les 4000 bonnes réponses existantes : 99 % identiques, écarts = fautes ci-dessous ou variantes admises paye/paie, protégera/protègera). Variantes admises jamais proposées comme mauvaise réponse.

**Bonnes réponses fausses corrigées (13)** : il/elle essuye → essuie (+ ils/elles essuyent, j'essuye), je nettoye → nettoie, tu rangais → rangeais, je souleverai → soulèverai, nettoyerons/nettoyerai/nettoyeront/essuyeras/essuyerai → nettoierons/nettoierai/nettoieront/essuieras/essuierai.
**Verbe remplacé (3)** : « envieillir » (archaïque) → « vieillir » (ce2, ids 32477, 32496, 32614).

**Vérifié** : 4000/4000 lignes avec 3 distracteurs distincts, aucun égal à la bonne réponse ni à une variante admise, aucun changement de sujet, 0 doublon de question. Détail ligne par ligne : `Claude outputs/audit_conj/audit_conjugaison_qcm_20261003.csv`. Anciennes versions dans contenu_historique.

Script : `server/correctifs_2026-10-03_conjugaison_qcm.sql`. `fn_publier()` : ce1/ce2/cm1/cm2 conjugaison.


### #30 — 2026-10-03 — Logique : défauts relevés pendant la rédaction des fiches de cours — corrigé DANS SUPABASE

**Origine** : en rédigeant les 25 fiches de cours Logique (CP→CM2, publiées le même jour), relecture des questions de chaque notion. Steve a validé la correction de tous les points signalés.

**Corrections (222 questions)** :
- Classer CE2/CM1 (65) : accord de l'adjectif avec le prénom (« Zoé est plus grande »), élision « qu'Enzo / qu'Inès », « Qui n'est ni le plus grand, ni le plus petit ? », « le/la plus jeune » → « le plus jeune ».
- Raisonnement CE2 (8) : « S'il a faim, Zoé… Il a faim. » → « Si elle a faim, Zoé… Elle a faim. » (idem a soif, est fatiguée) ; « S'il pleut / fait froid » (impersonnel) inchangés.
- Syllogismes CE2 (28) : « Toutes les X sont des Y » étaient rangés dans Analogies → notion Raisonnement ; « a rencontré » → « a vu » ; « Toutes les tomates sont des légumes » → aubergines (la tomate compte comme un fruit dans les questions d'intrus et dans la fiche).
- CP (90) : motifs (« Que vient ensuite ? », « Quelle couleur vient ensuite ? ») et « groupes qui grandissent » étaient rangés dans Analogies → notion Suites logiques (la fiche Suites CP les explique).
- Intrus CP (7) : l'étoile ⭐ est aussi une forme, ambiguë parmi ■ ▲ ★ → remplacée par un objet (🎈) ou, quand elle était l'intrus parmi ♥ ● ★, par un fruit (🍓).
- Classer CP (7) : deux animaux de taille trop proche dans la même question (vache/cheval, lapin/chat, lapin/poule, lion/ours) → l'un des deux remplacé par un animal nettement plus petit (ou plus grand) ; bonne réponse inchangée.
- Analogies CM2 (16) : mauvais choix qui étaient aussi de bonnes réponses (la photo est… « à regarder », « à envoyer » ; le livre « à offrir » ; la chanson « à écouter »…) → remplacés par des actions impossibles pour cet objet.
- Suite CP (1, id 40330) : 20, 15, 10, 5 → mauvais choix -1 et -3 (nombres négatifs, hors CP) → 1 et 5.

**Vérifié** : 0 défaut restant pour chaque famille (requêtes de contrôle), 3 mauvais choix distincts partout, aucune bonne réponse parmi les mauvais choix, 0 doublon de texte. Notions après correction : CP suites 234 / analogies 102 ; CE2 analogies 92 / raisonnement 111. Détail ligne par ligne : `Claude outputs/audit_logique/audit_logique_20261003.csv`. Anciennes versions dans contenu_historique.

Script : `server/correctifs_2026-10-03_logique.sql`. `fn_publier()` : cp/ce2/cm1/cm2 logique.

### #31 — 2026-10-03 — Synonymes / contraires CP : mots trop difficiles et paires ambiguës — corrigé DANS SUPABASE

- **Demande** : pendant la rédaction de la fiche de cours « Synonymes et contraires » CP, Claude signale des mots trop difficiles (« efficace », « supposer ») ; Steve demande la vérification.
- **Portée** : notion `vocabulaire_sens`, CP uniquement (seule classe où la notion est en français ; CE2 l'a en orthographe, CM1 en logique). 328 questions relues une par une.
- **Résultat** : 76 questions proposées à l'archivage (statut `archive`, pas de suppression), 328 → 252.
  - 35 contraires avec un mot hors vocabulaire CP : actuel, aride, avare/généreux, bref, terne (×2), captif, indifférent, déçu/satisfait, délicat/brutal, économe/dépensier, efficace, incomplet, épuisé, familier, gracieux, hardi, haïr, naïf, malpropre, obscur, extraordinaire, paisible, bombé, robuste, torride, rugueux, vaincu, récent, amer, lâche, semblable, raide, habile.
  - 27 synonymes avec un mot hors vocabulaire CP : se procurer, chatoyer/étinceler, cheminer, converser, dépanner, empoigner, engloutir, flâner, glousser, pouffer, exposer, supposer, apeuré, ardu, parvenir, sommeiller (×2), brailler, impeccable, gémir, fredonner, entamer, égarer, dissimuler, épuisé, sot, haïr.
  - 14 paires ambiguës ou fausses : grave→léger, frais→chaud, fin→épais, piquant→doux, muet→bavard, rire→sangloter, carré↔rond (×2, formes et non contraires), nord→sud et est→ouest (hors programme CP), écouter→entendre, fixer→observer, aider→assister, sursauter→bondir.
  - Liste des ids : 100627,100628,8326,8187,8332,8333,100612,100620,8344,100618,8346,8233,8350,8353,8354,8355,8363,100629,100613,100625,100639,8339,100633,100634,100637,8356,8338,8199,8212,8322,8321,8341,8192,8206,100626,8378,8397,100655,8386,8367,8380,100656,8374,100651,8242,8383,8388,8247,8248,8390,100658,8244,8384,100699,100650,8373,8392,8377,8382,8245,8250,100649,8364,8358,8360,100636,100630,8213,8336,8203,8195,8194,100644,100643,100647,100653
- **Décision de Steve (option 3)** : remplacer les 76 questions par des paires simples de niveau CP plutôt que les archiver (on garde 328 questions).
- **Appliqué** : 76 UPDATE sur les mêmes ids (anciennes versions dans contenu_historique), 45 contraires (fermer→ouvrir, descendre→monter, hiver→été, sous→sur, hier→demain, toujours→jamais, beaucoup→peu, question→réponse…) et 31 synonymes (voiture→auto, vélo→bicyclette, docteur→médecin, visage→figure, fâché→en colère, hurler→crier, nettoyer→laver, papa→père…) ; aucun doublon avec les 252 questions gardées, 3 mauvaises réponses distinctes par question ; fn_publier → paquet cp/french republié. Script : server/correctifs_2026-10-03_synonymes_contraires_cp.sql.
- **Fiche de cours** CP « Synonymes et contraires » (pas encore publiée) : « imaginer / supposer » remplacé par « regarder / observer ».
