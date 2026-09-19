# Difficulte et progression — Logique (CP a CM2)

Statut : **reference ecrite le 2026-09-19**, derniere etape du tour de reequilibrage de difficulte
demande par l'utilisateur (voir `csv/questions/AUDITS_LOG.md`, entree #8). Contrairement aux autres
matieres, Logique n'est pas issue du programme scolaire officiel (voir `project_logique_test_batch.md`)
— c'est une matiere de tests psychotechniques/logique pure, concue directement avec une progression
de difficulte par familles d'exercices (voir `project_logique_500.md` pour la conception d'origine
et l'historique des bugs corriges lors de la creation du contenu, 2026-08-05). L'audit du
2026-09-19 confirme que cette progression est saine et n'a necessite aucune correction.

## 1. Scope de difficulte par classe

| Classe | Familles d'exercices | Support visuel |
|---|---|---|
| CP | Suites de formes/emoji, intrus emoji, cris d'animaux, comparaison de taille, denombrement/comparaison de groupes, suites +1, contraires, motifs de couleur, bebes animaux | Riche : fruits, animaux, formes, couleurs, cartes a jouer |
| CE1 | Suites numeriques a une etape, suites alphabet, completion de motif ABC, intrus (categorie/nombre de pattes), contraires, bebes animaux, choix des extremes, analogies de fonction, intrus numerique | Riche (continuite CP) |
| CE2 | Suites a deux etapes, double/moitie, locomotion, habitat, **syllogismes** (appartenance a une categorie, introduits), intrus (alimentation), suites alphabet, **grille spatiale 3x3** (introduite, formes simples), deduction transitive d'age, **conditionnel si...alors** (introduit), contraires, extremes | Limite : fruits/legumes uniquement |
| CM1 | Suites composees (melange x/±), **code lettre-chiffre** (A=1, B=2..., introduit, direct dans les deux sens + somme de mot), **grille 3x3 a rotation cyclique** (symboles, plus complexe que CE2), **deduction a 2 indices** (age/course), carres parfaits, suites appariees lettre+chiffre, analogies partie-tout, contraires | Minimal : formes geometriques basiques uniquement (■▲●★♥♦) |
| CM2 | Suites Fibonacci simplifiees, carres+k, **chiffrement de Cesar** (decalage modulo l'alphabet, plus complexe que le code direct de CM1), grilles numeriques façon Raven (calcul, plus complexe que la rotation de CM1), **deduction a 3 personnes/3 indices** (indices positifs et negatifs), suites entrelacees, **menteur/verite** (introduit), analogies de fonction, suites x k + c, **combinatoire simple** (introduite) | **Aucun** : 100% textuel/numerique |

Progression verifiee par echantillonnage et recherche de marqueurs : chaque famille avancee
apparait exactement a sa classe d'introduction et jamais avant (grilles a partir de CE2,
syllogismes/conditionnel exclusifs a CE2, deduction d'age et code lettre-chiffre exclusifs a CM1,
Cesar/menteur-verite/combinatoire exclusifs a CM2). La complexite a l'interieur d'une meme famille
augmente aussi d'une classe a l'autre plutot que de rester identique (ex. grille : formes simples
CE2 -> rotation cyclique de symboles CM1 -> calcul numerique CM2 ; code : correspondance directe
CM1 -> chiffrement par decalage CM2).

## 2. Progression du support visuel (constat supplementaire)

Fait notable confirme par un inventaire complet des caracteres non-ASCII utilises par classe :
l'usage d'emoji/symboles diminue progressivement classe apres classe, jusqu'a disparaitre
totalement en CM2 (100% texte/nombres). Ce n'etait pas un objectif explicite de la conception
d'origine, mais c'est une consequence coherente du passage progressif du concret (CP/CE1,
vocabulaire visuel riche) vers l'abstrait (CM2, raisonnement logique pur) — et un signal positif
supplementaire de bonne progression de difficulte, au-dela des familles d'exercices elles-memes.

## 3. Bug d'affichage trouve (independant de la difficulte) — non corrige, proposition en attente

Signalement de Steve (2026-09-19) : certaines questions "quelle couleur ?" s'affichent en jeu
comme des motifs (lignes horizontales/diagonales/verticales) plutot que des couleurs. Contenu CSV
verifie correct (vrais emoji ronds Unicode 🔴🟣🔵🟢🟡🟠, bien formes) — cause probable cote rendu :
ces emoji appartiennent a un bloc Unicode recent (2019) non couvert par la police du jeu
(`Baloo2-SemiBold.ttf`), Godot bascule sur une police systeme de secours non garantie
(`feedback_font_emoji_risk.md`, risque identifie et documente avant la mise a l'echelle du
contenu, 2026-08-04). Concerne 87 questions (62 CP + 25 CE1, famille "Quelle couleur vient
ensuite ?"). Proposition en attente de validation : remplacer les emoji par le nom de la couleur
en toutes lettres (Rouge/Bleu/Vert/Jaune/Orange/Violet) — voir `AUDITS_LOG.md` entree #8 pour le
detail complet. Les autres familles a emoji (CP/CE1 : fruits/animaux/formes/cartes ; CE2 :
legumes ; CM1 : formes basiques) utilisent des blocs Unicode plus anciens et largement supportes,
donc a priori moins exposees au meme risque, mais n'ont pas ete testees en jeu.

## 4. Pack de revision

Comme les Maths (voir `MATHS_DIFFICULTE.md` section 4), Logique n'est **pas** dans
`REVIEW_SUBJECTS` : chaque pack pioche uniquement dans la classe en cours. Coherent avec la nature
de la matiere (raisonnement plutot que memorisation cumulative, pas de notion "revue" au sens
scolaire).

## 5. Inventaire du contenu

5 fichiers, 500 questions chacun (2500 au total), tranches d'id 40000-44999 (voir
`csv/questions/ID_RANGES.md`), chaque fichier n'utilisant que sa demi-tranche X000-X499 sur les
1000 id disponibles :

| Fichier | Questions | Ids utilises |
|---|---|---|
| `cp/logique/generated.csv` | 500 | 40000-40499 |
| `ce1/logique/generated.csv` | 500 | 41000-41499 |
| `ce2/logique/generated.csv` | 500 | 42000-42499 |
| `cm1/logique/generated.csv` | 500 | 43000-43499 |
| `cm2/logique/generated.csv` | 500 | 44000-44499 |

Headroom disponible sans nouvelle tranche : 500 id libres par fichier (X500-X999).

## 6. Verifie (audit du 2026-09-19)

- Inventaire complet des caracteres non-ASCII (emoji/symboles) sur les 2500 questions, classe par
  classe : confirme une reduction progressive et coherente du support visuel jusqu'a 0 en CM2.
- Recherche de marqueurs de familles avancees (grilles, syllogismes, deduction d'age, code
  lettre-chiffre, Cesar, menteur/verite, combinatoire) : chaque famille demarre a la bonne classe,
  0 occurrence avant.
- Echantillonnage aleatoire de CM1 et CM2 (25 lignes) pour verifier la nature exacte des familles
  la ou les marqueurs textuels etaient ambigus : confirme la complexite croissante a l'interieur
  d'une meme famille (grille, code) d'une classe a l'autre.
- Verification ligne par ligne de la famille "couleur" (87 questions) : emoji corrects et
  coherents, structure CSV intacte — probleme isole au rendu, pas aux donnees.
- Comptage des lignes par fichier : 500/500/500/500/500, conforme a `ID_RANGES.md`.

Conclusion : aucune correction de contenu necessaire pour la progression de difficulte de Logique.
Le seul point ouvert est le bug d'affichage de la section 3, distinct de la difficulte, en attente
de decision.
