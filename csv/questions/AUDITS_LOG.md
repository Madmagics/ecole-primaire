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
