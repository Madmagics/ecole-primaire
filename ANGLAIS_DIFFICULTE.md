# Difficulte et progression — Anglais (CP a CM2)

Statut : **reference ecrite le 2026-09-19**, suite a l'audit de reequilibrage de difficulte demande
par l'utilisateur (voir `csv/questions/AUDITS_LOG.md`, entree #7). Comme pour les Maths
(`MATHS_DIFFICULTE.md`), l'Anglais n'avait jamais eu de document de reference formel malgre la
vague d'extension de contenu du 2026-08-04 (voir `project_english_500.md`, qui documente la
conception d'origine fondee sur le programme officiel LVE 2025). L'audit du 2026-09-18/19
(extraction programmatique de marqueurs grammaticaux sur les 2628 questions) a confirme une
progression globalement saine, et a permis de corriger 3 ecarts reels avant de rediger ce document
(voir section 3).

## 1. Scope de difficulte par classe

| Classe | Notions grammaticales | Vocabulaire/format | Plage numerique |
|---|---|---|---|
| CP | Aucune grammaire/conjugaison a proprement parler — uniquement des phrases figees (I like/I don't like, my favourite colour is, I'm N years old, I've got a pet + it's a X, it's + meteo, this is my + famille, I'm + emotion, consignes de classe, I have N/I see N [comptable]) | Nombres, couleurs, jours, mois, animaux, famille, nourriture, corps, meteo, materiel scolaire, salutations, emotions | Nombres 0-12 |
| CE1 | **can/can't** + actions (introduit), prepositions (on/under/next to) | Continuite CP + ecole, corps, vetements, traits, mots interrogatifs | Nombres jusqu'a 20 (+ 30) |
| CE2 | **there is/are** (introduit), I prefer | + transports, metiers, heure (o'clock), on [day]s we have [matiere] | Nombres par dizaines jusqu'a 100 |
| CM1 | **Comparatif** (-er than, introduit — pas encore de superlatif), **must/mustn't**, demonstratifs (that/these/those), pays + "I come from"/"he comes from" | + opposes, "my hobby is" (nom en -ing, pas du present continu — ex. "my favourite sport is swimming") | — |
| CM2 | **Preterit** (regulier -ed et irregulier, introduit), **futur proche** (going to, introduit), **comparatif complet + superlatif** (the most/-est, introduit), **adverbes de frequence** (introduit), **present continu** (-ing veritable, introduit), synonymes, modaux negatifs (shouldn't/can't/mustn't — reutilisation en synthese) | — | — |

Progression verifiee par extraction programmatique de marqueurs sur l'ensemble de chaque ligne
(question ET choix de reponse, le format etant une traduction français<->anglais) : chaque notion
apparait bien a partir de sa classe d'introduction et jamais avant, une fois les 3 ecarts de la
section 3 corriges.

## 2. Regles transversales verifiees le 2026-09-18/19

- **can/can't** : 0 occurrence avant CE1, 24 occurrences en CE1, reapparait en CM2 (8) dans la
  categorie de synthese "modaux negatifs" (shouldn't/can't/mustn't) — reutilisation normale au
  dernier niveau, pas une fuite.
- **there is/are** : exclusivement CE2 (240 occurrences), 0 ailleurs.
- **Comparatif (-er than)** : 0 avant CM1, 140 en CM1 (toutes des comparatifs simples, aucun vrai
  superlatif "the most"/"the ...est" — verifie explicitement, 0 occurrence en CM1), 105 en CM2 (+
  30 superlatifs, exclusifs a CM2) — CM1 et CM2 se distinguent donc reellement : comparatif seul
  vs comparatif + superlatif.
- **Pretérit** : 0 avant CM2 (une fois les 2 ecarts corriges, voir section 3), 67 (regulier -ed) +
  ~137 (irregulier was/were/went/etc.) en CM2 uniquement.
- **"My hobby is/sport is + -ing" (CM1, 27 occurrences)** : verifie qu'il s'agit d'un nom en -ing
  (gerondif complement, ex. "my favourite sport is swimming"), pas du present continu ("I am
  swimming") — cette derniere construction (verbe conjugue + -ing pour une action en cours) reste
  bien exclusive a CM2 (40 occurrences), pas de fuite malgre le marqueur "-ing" partage.
- **going to / adverbes de frequence** : exclusivement CM2.

## 3. Ecarts trouves et corriges le 2026-09-19

Sur decision de Steve ("reformule au present, on va essayer de coller au mieux au niveau de
classe"), 3 ecarts reperes par l'audit ont ete corriges (pas seulement documentes) :

1. **"I saw"/"j'ai vu" en CP (136 lignes) et CE1 (42 lignes)** → reformule en **"I see"/"je vois"**.
   Cause : un effet de bord du fix de l'entree #4 de ce meme journal (les phrases "j'ai N animaux"
   avaient ete reformulees en "j'ai vu N animaux" pour eviter une possession improbable, ce qui
   introduisait sans le vouloir le prétérit "saw" avant sa classe d'introduction). Remplacement
   fait sur la totalite des occurrences (question ET distracteurs d'autres questions), pas
   seulement les lignes ou l'expression etait la bonne reponse.
2. **"il est né en/au/aux [pays]"/"He was born in [pays]" en CM1 (26 lignes)** → reformule en
   **"il vient de/d'/du/des [pays]"/"He comes from [pays]"**, en reutilisant exactement les
   prepositions francaises deja en usage pour la famille "je viens de [pays]" preexistante dans le
   meme fichier. Contrairement au point 1, cet ecart existait depuis la creation du contenu
   (2026-08-04), pas un effet de bord de cette session.
3. **7 fautes d'orthographe francaise "oiseaus" au lieu de "oiseaux"** en CE2 (ids 20017, 20054,
   20075, 20077, 20096, 20148, 20179) — sans lien avec la difficulte, trouvees incidemment.

Sauvegardes : `generated.csv.bak_avant_fix_preterit_20260919` (`cp/english/`, `ce1/english/`,
`cm1/english/`) et `generated.csv.bak_avant_fix_oiseaus_20260919` (`ce2/english/`).

## 4. Pack de revision

Anglais fait partie de `REVIEW_SUBJECTS` (voir `FRANCAIS_DIFFICULTE.md` section 2) : contrairement
aux Maths, chaque classe (sauf la premiere, CP) revise aussi du vocabulaire/des notions des classes
anterieures a chaque pack, le volume augmentant avec la classe (CP : 10 questions CP uniquement ;
CE1 : 15 = 10 CE1 + 5 CP ; CE2 : 20 ; CM1 : 25 ; CM2 : 25 = 5 par classe x 5 classes).

## 5. Inventaire du contenu

5 fichiers, tranches d'id 18000-22999 (voir `csv/questions/ID_RANGES.md`) :

| Fichier | Questions |
|---|---|
| `cp/english/generated.csv` | 519 |
| `ce1/english/generated.csv` | 569 |
| `ce2/english/generated.csv` | 505 |
| `cm1/english/generated.csv` | 507 |
| `cm2/english/generated.csv` | 528 |

Total : 2628 questions. Headroom disponible sans nouvelle tranche : chaque fichier dispose encore
de marge dans sa tranche de 1000 id (voir `ID_RANGES.md` pour le detail exact par fichier).

## 6. Verifie (audit exhaustif du 2026-09-18/19)

- Extraction programmatique de 12 marqueurs grammaticaux (can/can't, there is/are, comparatif,
  superlatif, must/mustn't, demonstratifs, preterit regulier et irregulier, going to, adverbes de
  frequence, present continu, pays+speak/come from) sur l'integralite de chaque ligne des 5
  fichiers (2628 questions) : chaque notion demarre a la bonne classe et pas avant, une fois les 3
  ecarts de la section 3 corriges.
- Verification numerique : vocabulaire des nombres en toutes lettres croissant par classe (0-12
  CP → 1-20+30 CE1 → dizaines jusqu'a 100 CE2), aucune regression.
- Balayage orthographique des pluriels francais -eau/-eu (piege frequent : -s au lieu de -x) sur
  les 5 fichiers : seules les 7 occurrences "oiseaus" en CE2 trouvees et corrigees, aucune autre.
- Verification post-correction : 0 occurrence residuelle de "saw"/"vu"/"was born"/"est né"/
  "oiseaus" dans les 5 fichiers ; structure CSV intacte (nombre de lignes inchange) ; aucune fin de
  ligne CRLF introduite (remplacement en texte brut) ; diff exact contre sauvegarde = 136/42/26/7
  lignes respectivement, conforme au perimetre vise.

**Import Godot en attente** pour `cp/english`, `ce1/english`, `ce2/english` et `cm1/english`
(contenu modifie par les corrections ci-dessus).
