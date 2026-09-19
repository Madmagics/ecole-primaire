# Difficulte et progression — Mathematiques (CP a CM2)

Statut : **reference ecrite le 2026-09-18**, suite a l'audit de reequilibrage de difficulte demande
par l'utilisateur (voir `csv/questions/AUDITS_LOG.md`). Contrairement a Grammaire/Conjugaison/
Orthographe (`FRANCAIS_DIFFICULTE.md`) et Lecture (`LECTURE_DIFFICULTE.md`), les Maths n'avaient
jamais eu de document de reference formel malgre 5 vagues d'extension de contenu (2026-07-31 a
2026-08-01, voir `project_cp_math_500.md`, `project_ce1_ce2_math_1000.md`, `project_cm1_math_1000.md`,
`project_cm2_math_1000.md`). L'audit exhaustif du 2026-09-18 (script Python, verification
programmatique ligne par ligne sur les 5000 questions) n'a trouve **aucune violation reelle** : le
contenu actuel est deja bien calibre et progresse reellement d'une classe a l'autre. Ce document
consolide ce scope deja correct, pour qu'il serve de reference verifiable lors de futures
extensions (comme `FRANCAIS_DIFFICULTE.md` le fait pour le francais).

## 1. Scope de difficulte par classe

| Classe | Operations | Notions/types principaux | Plage numerique (ordres de grandeur verifies) |
|---|---|---|---|
| CP | Addition, soustraction (pas de multiplication/division) | calcul a trous, comparaison (2 choix), pair/impair (2 choix), dizaines/unites, moities/doubles, nombre avant/apres, suites par bonds de 2/5/10, formes geometriques (cotes), problemes simples en contexte | Addition/soustraction : 0-65. Comparaisons : nombres < 100. |
| CE1 | Addition, soustraction, multiplication **restreinte aux tables 0/1/2/5/10** (facteurs 0-11), pas de division a proprement parler (complement a un multiple de 10 seulement) | calcul a trous, comparaison (2 choix), pair/impair (2 choix), moitie/tiers/quart, conversions simples, suites par bonds de 10/50/100, complement a un multiple de 10 | Addition/soustraction : 11-598. Multiplication : un facteur dans {0,1,2,5,10}, l'autre 0-11. |
| CE2 | Addition, soustraction, multiplication **table complete 1-10** (100 combinaisons), division **exacte, sans reste** (diviseurs 1-10) | calcul a trous, comparaison (2 choix), pair/impair (2 choix), moitie/tiers/quart, conversions, suites par bonds de 100/1000, perimetre de rectangle, problemes en contexte (argent) | Addition/soustraction : 103-8992. Division : dividendes 1-120, diviseurs 1-10, toujours exacte. |
| CM1 | Addition/soustraction **decimales** (en plus des entieres), multiplication a 2 chiffres, division **avec quotient et reste**, fractions (comparaison, meme denominateur, fraction d'un nombre) | comparaison fraction (2 choix), comparaison decimal (2 choix), aire de rectangle, perimetre de rectangle, proportionnalite, conversions (+ mm, cl), valeur de position (nombres a 6 chiffres) | Division avec reste introduite. Fractions : denominateurs 2-9. Aire rectangle : longueur 4-25, largeur 2-20 (toujours longueur >= largeur). |
| CM2 | Addition/soustraction decimales, multiplication a 2 chiffres + revision table complete 1-10, division avec quotient et reste, fractions (vers decimal), **pourcentages** (10/25/50/75 %) | aire de rectangle, **volume de pave droit** (nouveau), perimetre, proportionnalite (prix unitaire), vitesse/distance, conversions (+ g/kg, cl/l, m/cm), valeur de position (nombres a 9 chiffres) | Pourcentages : {10, 25, 50, 75} uniquement. Aire rectangle : longueur 7-40, largeur 3-30 (superieur a CM1, toujours longueur >= largeur). |

Progression verifiee de deux facons : l'apparition de notions strictement nouvelles a chaque
palier (multiplication en CE1, division et table complete en CE2, decimales/fractions/quotient-
reste en CM1, pourcentages/volume en CM2 — aucune de ces notions n'apparait avant sa classe
d'introduction), et l'elargissement des plages numeriques a operation egale (ex. aire de
rectangle : longueur 4-25 en CM1 contre 7-40 en CM2).

## 2. Regles transversales verifiees le 2026-09-18

- **CE1 — multiplication restreinte** : sur les 1000 questions, aucune ne teste une table hors
  {0, 1, 2, 5, 10} (verifie par extraction programmatique de tous les couples `a x b` du texte —
  0 violation). Une alerte anterieure (`feedback_math_level_scope_violation.md`, 2026-09-07)
  avait signale 12 lignes de tables 3/4/6/7/8/9 heritees d'avant la regle : elles n'existent plus
  dans le fichier actuel, corrigees entre-temps par l'extension du 2026-08-01.
- **CE2 — division exacte uniquement** : les 120 questions de division utilisent la notation
  `a : b` avec diviseurs 1-10 et sont toutes des divisions exactes (aucune mention de reste) —
  coherent avec l'introduction de la notion de division sans complexifier avec le reste, reserve
  a CM1/CM2.
- **CM1/CM2 — division avec reste** : sur 110 (CM1) et 95 (CM2) questions de division, environ la
  moitie (55 et 47) portent explicitement sur le reste ("quel est le reste ?"), l'autre moitie sur
  le quotient — bonne repartition entre les deux notions au meme niveau.
- **Regle "reponse binaire = 2 choix"** (comparaison de nombres, fractions, decimaux, pair/impair)
  : verifie sur toutes les questions au phrasing binaire des 5 classes (cp: 165, ce1: 125, ce2:
  110, cm1: 155, cm2: 0 — cm2 n'a pas ce type de question) — **0 violation**, `choice_3`/`choice_4`
  bien vides partout. Voir aussi `feedback_binary_choice_backlog.md` (ferme pour les maths depuis
  2026-08-01).
- **Convention longueur >= largeur** (problemes de perimetre/aire de rectangle) : verifie sur les
  75 (CM1) et 65 (CM2) problemes au phrasing "`L cm sur l cm`" — **0 violation**.
- **Pas de fuite de perimetre/notion hors classe** : aucune mention de fraction, decimal ou
  pourcentage dans CP/CE1/CE2 (0 occurrence sur les 3000 questions) — ces notions restent
  cantonnees a CM1 (fractions/decimales) et CM2 (+ pourcentages), conforme au programme officiel.
- **Pas de division en CP/CE1** : 0 question de division dans ces deux classes (CE1 n'a que le
  "complement a un multiple de 10", pas une vraie division).

## 3. Pack de revision

Contrairement a Grammaire/Conjugaison/Orthographe/Anglais (voir `FRANCAIS_DIFFICULTE.md` section
2), les Maths **n'ont pas** de mecanisme de pack de revision multi-classes dans
`QuestionGiverComponent._build_review_pack` (`REVIEW_SUBJECTS` exclut explicitement Maths et
Lecture). Decision deja actee : les maths sont un acquis cumulatif par construction (un exercice
de CM2 suppose deja les tables et les 4 operations, contrairement a une conjugaison ou une regle
d'orthographe qui peut etre oubliee sans etre reutilisee). Chaque pack de Maths ne pioche donc que
dans la classe en cours (`PACK_SIZE` = 10).

## 4. Inventaire du contenu

5 fichiers, 1000 questions chacune (5000 au total), voir `csv/questions/ID_RANGES.md` pour le
detail des tranches d'id :

| Fichier | Questions | Ids (herites + nouveaux) |
|---|---|---|
| `cp/math/generated.csv` | 500 (pas 1000, jamais etendu au-dela) | 1001-1190 herites + 2000-2309 |
| `ce1/math/generated.csv` | 1000 | 1201-1400 herites + 3000-3799 |
| `ce2/math/generated.csv` | 1000 | 1401-1600 herites + 4000-4799 |
| `cm1/math/generated.csv` | 1000 | 1601-1800 herites + 5000-5799 |
| `cm2/math/generated.csv` | 1000 | 1801-2000 herites + 6000-6799 |

Note : CP compte 500 questions (pas 1000 comme les 4 autres classes) — cible fixee volontairement
plus bas des le depart (`project_cp_math_500.md`), jamais revue a la hausse depuis. Headroom
disponible sans nouvelle tranche : CP jusqu'a 2999 (690 id libres), CE1-CM2 jusqu'a x999 (200 id
libres chacun).

## 5. Verifie (audit exhaustif du 2026-09-18)

- Extraction programmatique et comptage de tous les couples multiplicatifs (`a x b`) sur les 1000
  questions CE1 : 0 table hors {0,1,2,5,10}.
- Recherche de "fraction"/"decimal"/"%" sur les 3000 questions CP+CE1+CE2 : 0 occurrence.
- Recherche de "division"/"partage"/notation `a : b` sur CP+CE1 : 0 occurrence.
- Comptage des choix non-vides (`choice_3`/`choice_4`) sur toutes les questions a phrasing binaire
  identifie (comparaison, pair/impair) des 5 classes : 0 violation.
- Extraction des dimensions `L cm sur l cm` sur les 140 problemes de rectangle (CM1+CM2) : 0 cas
  largeur > longueur.
- Verification des diviseurs et de la presence du mot "reste" sur les questions de division CE2
  (120) et CM1/CM2 (110+95) : CE2 exclusivement exacte, CM1/CM2 repartition quotient/reste
  equilibree.
- Comparaison des plages numeriques d'une meme categorie entre classes adjacentes (aire de
  rectangle CM1 vs CM2, addition/soustraction simple CE1 vs CE2) : progression confirmee dans le
  sens croissant a chaque fois, aucune classe superieure n'a une plage plus etroite qu'une classe
  inferieure sur une meme notion.

Conclusion : aucune correction de contenu necessaire pour les Maths. Le seul "travail a effectuer"
identifie par l'audit etait l'absence de ce document — desormais comble.
