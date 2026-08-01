# Algorithme de difficulté — matière "Comprehension de texte" (CP à CM2)

Statut : **algorithme validé par l'utilisateur le 2026-07-20** (texte + questions), à appliquer
telle quelle à toute future histoire générée pour cette matière. **Branché côté Godot le
2026-07-21** : `PassageResource`, `tools/admin/import_reading.gd`, cas particulier `READING`
dans `QuestionGiverComponent`, et `ReadingIntroPanel` (texte affiché en premier, puis questions
sans retour possible) — voir "Prochaines étapes" en bas de fichier pour le détail de ce qui a été
fait et ce qui reste (génération de contenu à l'échelle). Le libellé affiché au joueur est
"Comprehension de texte" (`SubjectType.get_label`), "Lecture" ne reste que le nom du dossier
(`csv/questions/<classe>/lecture/`, `data/question/resources/<classe>/lecture/`).

## Méthode

Trois critères combinés, tous mesurables objectivement sur un texte (pas d'appréciation
subjective) :

1. **Longueur du texte**, calibrée sur la fluence de lecture officielle (MCLM — mots
   correctement lus par minute, repères éducation nationale) : un texte trop long pour la
   vitesse de lecture réelle d'une classe décourage plutôt qu'il n'évalue la compréhension.
   Cible : lisible en 1 à 3 minutes selon la classe.
2. **Longueur de phrase** (mots par phrase) : proxy direct de la complexité syntaxique
   (subordonnées, énumérations...).
3. **Score de lisibilité Kandel-Moles** — adaptation française (1958) de la formule de Flesch,
   référence en didactique du français : `Y = 207 − 1.015×LP − 0.736×LM`, où `LP` = mots par
   phrase et `LM` = syllabes pour 100 mots. `Y` va de 0 (très complexe) à 100 (très facile).

Le nombre de syllabes est estimé par un comptage de groupes de voyelles consécutives
(heuristique standard, imparfaite sur les liaisons/e muets mais cohérente pour comparer 5
versions d'un même texte entre elles).

## Repères utilisés (sources)

- MCLM officiels (ordre de grandeur, les sources varient légèrement selon la période de l'année
  évaluée) : CP ≈ 50 mots/min, CE1 ≈ 70-90, CE2 ≈ 90-120, CM1 ≈ 110-115, CM2 ≈ 120+.
- Formule Kandel-Moles (1958), adaptation française de Flesch — référence standard en
  pédagogie/édition jeunesse pour juger la lisibilité d'un texte français.
- Programme officiel : progression cycle 2 (décodage/fluence prioritaires au CP, montée en
  charge de la compréhension au CE1-CE2) et cycle 3 (syntaxe plus complexe, vocabulaire en
  contexte, inférence).

## Cibles retenues par classe

| Classe | Mots (cible) | Mots/phrase (cible) | Score Y (cible) | Tonalité |
|---|---|---|---|---|
| CP | 50-70 | 4-6 | 90-100 | Phrases simples SVO, present, vocabulaire tres courant |
| CE1 | 90-130 | 6-9 | 80-90 | Quelques phrases plus longues, toujours du concret |
| CE2 | 150-200 | 8-12 | 70-80 | Debut de subordonnees, vocabulaire un peu plus varie |
| CM1 | 220-280 | 10-14 | 55-70 | Phrases composees, vocabulaire en contexte, inference legere |
| CM2 | 300-380 | 12-18 | 40-55 | Phrases complexes, inference, vocabulaire plus riche |

## Résultat du test (histoire "Milo le chat", 5 versions)

Même trame narrative (un chat s'echappe, se perd en poursuivant un papillon, est retrouve par
sa maitresse) réécrite à 5 niveaux, pour comparer la progression à contenu égal.

| Classe | Mots | Mots/phrase | Syllabes/100 mots | Score Y | Cible Y | Dans la cible ? |
|---|---|---|---|---|---|---|
| CP | 63 | 4.8 | 144.4 | **95.8** | 90-100 | Oui |
| CE1 | 111 | 8.5 | 155.9 | **83.6** | 80-90 | Oui |
| CE2 | 194 | 12.1 | 161.3 | **75.9** | 70-80 | Oui |
| CM1 | 264 | 18.9 | 173.1 | **60.5** | 55-70 | Oui |
| CM2 | 398 | 26.5 | 173.1 | **52.7** | 40-55 | Oui |

Les 5 versions tombent dans leur bande cible dès le premier jet. Écart jugé "vraiment excellent"
par l'utilisateur (2026-07-20) — algorithme texte validé tel quel, y compris la bascule CM1/CM2
où la difficulté vient plus de la syntaxe (phrases composées) que du vocabulaire (syllabes/100
mots identiques entre les deux, 173.1) : cohérent avec le programme officiel, qui insiste plus
sur la syntaxe que sur la rareté lexicale à ce stade du cycle 3.

## Progression des questions (pas seulement le texte)

Constat initial (avant révision) : le texte se complexifiait bien d'une classe à l'autre, mais
les *questions*, elles, restaient presque toutes littérales (réponse directement recopiable dans
le texte) à tous les niveaux — la difficulté ne progressait donc que d'un côté. Corrigé le
2026-07-20 en ajoutant une deuxième dimension à l'algorithme : le **type** de question, avec un
quota qui évolue par classe.

Trois types :
- **L (Littérale)** : la réponse est explicitement dans le texte, une seule phrase à relire.
- **V (Vocabulaire en contexte)** : sens d'un mot ou d'une expression du texte à déduire du
  contexte (ex. "que veut dire 'insaisissable' ?").
- **I (Inférence)** : réponse non explicite, nécessite de relier plusieurs informations ou de
  déduire une cause/conséquence/émotion non nommée par le texte.

Quotas retenus (repose sur le programme officiel : décodage/fluence prioritaires au CP,
compréhension qui monte en charge au CE1-CE2, inférence/vocabulaire en contexte davantage
travaillés en cycle 3) :

| Classe | Questions | Littérales (L) | Vocabulaire (V) | Inférence (I) | % non-littéral |
|---|---|---|---|---|---|
| CP | 5 | 5 | 0 | 0 | 0 % |
| CE1 | 10 | 8 | 1 | 1 | 20 % |
| CE2 | 10 | 6 | 2 | 2 | 40 % |
| CM1 | 10 | 4 | 3 | 3 | 60 % |
| CM2 | 10 | 3 | 3 | 4 | 70 % |

Les 5 jeux de questions de test ("Milo le chat") ont été réécrits pour respecter exactement ces
quotas (vérifié par script, voir historique). La colonne `qtype` du CSV (voir format ci-dessous)
trace le type de chaque question, pour pouvoir auditer automatiquement le respect du quota sur
les futurs contenus générés en masse.

## Format CSV (validé)

Une question de lecture est toujours liée à un texte, ce qui ne rentre pas dans le format plat
`id;text;correct_answer;choice_2;choice_3;choice_4` du reste du projet. Format retenu pour ce
test, toujours **un seul fichier par classe** (`csv/questions/<classe>/lecture/generated.csv`,
même convention que les autres matières) :

```
id;type;text;correct_answer;choice_2;choice_3;choice_4;passage_id;qtype
13000;passage;<texte complet>;;;;;;
13001;question;<question 1>;<reponse>;<distracteur>;<distracteur>;<distracteur>;13000;L
...
```

- Une ligne `type=passage` par texte (id = id du passage, `text` = le texte complet, le reste
  vide).
- Une ligne `type=question` par question, `passage_id` pointant vers l'id de son passage,
  `qtype` = L/V/I (voir "Progression des questions" ci-dessus ; vide/non utilisé pour les lignes
  passage). `qtype` n'est pas consommé par le jeu (pas de champ équivalent prévu sur
  `QuestionResource`) : c'est une métadonnée d'auteur/QA, pour vérifier par script que chaque
  nouvelle histoire respecte bien le quota de sa classe avant import.
- Permet plusieurs passages par classe dans le même fichier à terme (plusieurs histoires par
  niveau), sans fichier séparé à lier manuellement.

Tranches d'id réservées dans `csv/questions/ID_RANGES.md` : 13000-13999 (cp), 14000-14999 (ce1),
15000-15999 (ce2), 16000-16999 (cm1), 17000-17999 (cm2).

## Prochaines étapes

Fait le 2026-07-21 :

1. `PassageResource` (nouveau type, `grade`/`text`) + `QuestionResource.passage` (référence
   directe vers le `PassageResource`, plutôt qu'un id manuel à faire correspondre — Godot
   dédoublonne déjà les `Resource` chargées plusieurs fois depuis le même chemin `.tres`).
2. `tools/admin/import_reading.gd` : lit le format CSV ci-dessus (garde en mémoire le dernier
   passage rencontré pour lier les questions qui suivent), écrit les `.tres` passage et
   questions dans `data/question/resources/<classe>/lecture/`. Les 5 CSV de test existants ont
   été importés à la main (pas d'accès à l'éditeur Godot dans cette session) en suivant
   exactement la même logique.
3. `QuestionGiverComponent` : cas particulier pour `READING` dans `start_pack_for_subject`
   (`_start_reading_pack`) — tire UN passage au hasard parmi ceux de la classe du PNJ, réunit
   toutes ses questions liées (pas un échantillon plat comme les autres matières), puis n'en
   garde que `PACK_SIZE` (10) tirées au hasard parmi elles **(2026-07-31)** : la banque par texte
   peut donc dépasser 10 questions (CE1 à CM2 : 20 en banque, voir "Progression des questions"
   plus haut — quotas devenus 16L/2V/2I, 12L/4V/4I, 8L/6V/6I, 6L/6V/8I sur 20 questions depuis le
   batch de 47 histoires du 2026-07-30, voir `ID_RANGES.md`) afin qu'une relecture du même texte
   ne repose pas systématiquement les mêmes questions dans le même ordre. Le tirage est
   complètement aléatoire (pas de recalcul des quotas L/V/I sur les 10 tirées, décision explicite
   de l'utilisateur). Au CP la banque ne compte que 10 questions par texte (= `PACK_SIZE`) : le
   tirage y reste donc intégral, sans variation. Exclu de `REVIEW_SUBJECTS` (pas de pack de
   révision multi-classes pour cette matière).
4. `ReadingIntroPanel` (`ui/reading_intro/`) : affiche le texte du passage (zone de texte avec
   défilement si besoin, pensée pour tenir sur un seul écran pour la plupart des classes), puis
   relaie vers `QuestionPanel` au clic sur "Commencer les questions" — **aucun moyen de revenir
   au texte** une fois les questions lancées (demande explicite de l'utilisateur : le panneau
   oublie son contenu dès qu'il se ferme, qu'il s'agisse d'un abandon ou d'un vrai démarrage).
5. Menu matière (`SubjectSelectPanel`) : rien à faire, déjà 100% générique — "Comprehension de
   texte" apparaît automatiquement dès que `get_available_subjects()` trouve des questions
   `READING` dans le pool de la classe.

Reste à faire : génération de contenu à l'échelle (plusieurs histoires par classe, actuellement
1 seule par classe = le jeu de test "Milo le chat").
