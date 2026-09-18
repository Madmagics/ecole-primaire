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
