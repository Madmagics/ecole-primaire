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
