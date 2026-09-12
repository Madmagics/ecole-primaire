# Statut du contenu éducatif

Nombre de **questions jouables** actuellement prévues par matière et par classe (compté depuis
les CSV sous `csv/questions/`, pas les `.tres` — voir `ID_RANGES.md` pour le détail des tranches
d'id et `ARCHITECTURE.md` pour le format des fichiers). Pour "Comprehension de texte" (`lecture`),
seules les lignes `type=question` comptent, pas les lignes `type=passage` (un texte n'est pas une
question). "-" = matière pas encore introduite à cette classe.

Dernière mise à jour : **2026-08-07**.

| Classe | Math | French | Grammaire | Conjugaison | Orthographe | English | Lecture | Logique | Total |
|---|---|---|---|---|---|---|---|---|---|
| CP  | 1000 | 1000 | -    | -    | -    | 519 | 480 | 500 | 3499 |
| CE1 | 1000 | -   | 1000 | 1000 | 1000 | 569 | 960 | 500 | 6029 |
| CE2 | 1000 | -   | 1000 | 1000 | 1000 | 505 | 960 | 500 | 5965 |
| CM1 | 1000 | -   | 1000 | 1000 | 1000 | 507 | 960 | 500 | 5967 |
| CM2 | 1000 | -   | 1000 | 1000 | 1000 | 528 | 960 | 500 | 5988 |

**Total général : 27448 questions.**

## Repères pour relancer une génération

- **Maths** : les 5 classes sont à 1000 questions depuis le 2026-08-07 (CP est passé de 500 à
  1000 ce jour-là) — voir `project_cp_math_500`, `project_ce1_ce2_math_1000`,
  `project_cm2_math_1000`, `project_cm1_math_1000` en mémoire. Toutes les tranches d'id ont
  encore de la marge.
- **French (CP)** : passé à 1000 questions le 2026-08-07 (500→1000, ids 8000-8499 en plus des
  2001-2500 hérités) — voir `project_cp_french_1000` en mémoire pour le détail des familles
  ajoutées et des bugs (pré-existants et nouveaux) corrigés au passage.
- **Grammaire/Conjugaison/Orthographe (CE1-CM2)** : les 12 fichiers concernés sont passés de 500
  à 1000 questions le 2026-08-07 — voir `project_grammaire_conjugaison_orthographe_1000` en
  mémoire pour le détail des familles ajoutées et des bugs pré-existants corrigés au passage
  (CE1 était déjà à 1000 depuis une extension antérieure le même jour). Chaque fichier garde sa
  tranche d'id dédiée (28000-39999), avec encore de la marge dans chacune.
- **English (CP-CM2)** : étendu le 2026-08-04 de 40-85 à 505-569 questions selon la classe, en
  s'appuyant sur le programme officiel LVE 2025 (cycles 2 et 3) — voir `project_english_500` en
  mémoire. Mix vocabulaire (programme + cumulatif d'une classe à l'autre) et phrases/grammaire
  (I like/can, there is/are, comparatifs, prétérit/futur pour CM2, etc.), pas seulement de la
  traduction de mots isolés.
- **Lecture** : 480 (CP) à 960 (CE1-CM2) questions, réparties entre `generated.csv` (Milo le
  chat, pool fixe) et `histoires_generated.csv` (47 histoires × 5 classes, tirage aléatoire
  d'un sous-ensemble par lecture — voir `LECTURE_DIFFICULTE.md`). Sujette à la règle de gel de
  structure (`feedback_lecture_structure_freeze` en mémoire) : ajouter du contenu oui, mais sans
  retoucher le format CSV/le mécanisme de tirage.
- **Binary-choice** : toutes les matières de maths sont conformes à la règle "2 choix seulement".
  Grammaire/Conjugaison/Orthographe (toutes classes) n'ont eu aucune question binaire à 4 choix
  détectée dans le contenu généré (vérifié à chaque extension) — voir
  `feedback_binary_choice_backlog` en mémoire.
- **Logique (CP-CM2)** : lancée le 2026-08-04 avec un lot de test de 10 questions/classe, étendue
  à 500 questions/classe le 2026-08-05 (tranches 40000-44999) — voir `project_logique_500` en
  mémoire pour le détail des familles par classe (suites, intrus, analogies, déduction, grilles,
  chiffrement, combinatoire, etc., mêlant émojis/symboles et texte pur selon la classe). Pas issue
  du programme officiel (seule matière dans ce cas).

## Comment ce fichier est tenu à jour

Recalculé à la demande ("status") à partir des CSV en cours (comptage direct, pas une valeur
mise en cache) — donc toujours exact au moment où il est consulté, même si ce fichier n'a pas
été régénéré depuis. Le régénérer après tout ajout de contenu en masse pour qu'il reste utile
même sans redemander un "status".
