# Matières candidates par classe (au-delà de Maths / Français)

Recherche menée le 2026-07-20 sur les programmes officiels en vigueur à la rentrée 2026-2027
(cycle 2 : CP/CE1/CE2, cycle 3 : CM1/CM2), pour préparer l'ajout de futures catégories de
questions (voir `ARCHITECTURE.md`, `SubjectType`). Sources : pages éduscol "Enseigner au cycle 2"
et "Enseigner au cycle 3" (voir liens en bas de fichier).

Rappel du principe de décision : une matière n'est un bon candidat de catégorie que si son
contenu à cette classe est (1) suffisamment **factuel/structuré** pour générer des questions à
réponse unique ou QCM (comme les questions actuelles), et (2) **substantiel** (assez de notions
distinctes pour éviter la répétition après quelques dizaines de questions).

## Décisions validées (revue classe par classe)

Revue faite avec l'utilisateur, une classe à la fois, du CP au CM2 — chaque ligne passe de
"recommandation" à "décidé" au fur et à mesure de la discussion.

| Classe | Décision | Date |
|---|---|---|
| CP | **Anglais confirmé** — vocabulaire de base uniquement (voir détail plus bas) | 2026-07-20 |
| CE1 | **Français renommé en Orthographe/Grammaire** (pas une catégorie ajoutée à côté : elle remplace "Français" pour cette classe, voir note ci-dessous) + **Anglais vocabulaire confirmé** | 2026-07-20 |
| CE2 | Décidé (2026-07-20) : Français scindé en Grammaire/Conjugaison/Orthographe, + Anglais, + Lecture | — |
| CM1 | Décidé (2026-07-20) : Grammaire/Conjugaison/Orthographe, + Anglais, + Lecture | — |
| CM2 | Décidé (2026-07-20) : Grammaire/Conjugaison/Orthographe, + Anglais, + Lecture | — |
| **Toutes classes (CP → CM2)** | **Lecture (compréhension de texte) confirmée** — nouvelle matière transversale, voir section dédiée plus bas | 2026-07-20 |

**Note sur le renommage CE1 :** vérification faite sur le contenu réel de
`csv/questions/ce1/french/generated.csv` (200 lignes) : ~90% sont déjà de la grammaire pure
(pluriels, féminin/masculin, nature du mot, conjugaison au présent) — le renommage est donc une
simple recatégorisation, pas une régénération de contenu. Un petit reliquat (~19 lignes : mois de
l'année, synonymes) est un peu à la marge de "grammaire" au sens strict mais reste du savoir
lexical français ; laissé tel quel plutôt que trié ligne par ligne pour un gain marginal.

## Tableau récapitulatif

| Classe | Matière du programme officiel | Candidate pour une catégorie ? | Pourquoi |
|---|---|---|---|
| CP | Français | Déjà en place | — |
| CP | Mathématiques | Déjà en place | — |
| CP | Histoire-géographie, Sciences et technologie | **Non, pas encore** | Nouveaux au programme CP à partir de la rentrée 2026-2027 (réforme), mais le contenu à cet âge reste oral/manipulatoire (observation, comptines) — pas encore assez de faits factuels stables pour un QCM écrit. |
| CP | **Langues vivantes → Anglais (vocabulaire de base)** | **✅ Décidé le 2026-07-20** | Pas le programme LVE officiel complet (trop tôt), mais un sous-ensemble volontairement restreint : vocabulaire de base par champs lexicaux simples — couleurs, jours de la semaine, mois, nombres, animaux, famille, etc. Format QCM mot français ↔ mot anglais (illustré si besoin), sans grammaire ni conjugaison. Assez factuel et substantiel pour ce périmètre réduit, contrairement au programme complet évalué initialement. |
| CP | EMC, EPS, Arts plastiques/musicale, Éducation à la vie affective | Non | Compétences comportementales/pratiques/artistiques, pas du savoir factuel interrogeable par QCM. |
| CE1 | Français → **Orthographe/Grammaire** (remplace Français, ne s'y ajoute pas) | **✅ Décidé le 2026-07-20** | Le programme 2025 structure déjà l'« étude de la langue » comme un bloc à part (nature des mots, accords simples sujet/verbe, homophones fréquents, conjugaison du 1ᵉʳ groupe au présent) — assez dense et stable pour une vraie catégorie. La compréhension de texte (autrefois sous "Français") part désormais dans la nouvelle matière Lecture (voir plus bas), donc plus besoin d'un "Français" générique à côté. |
| CE1 | **Langues vivantes → Anglais (vocabulaire)** | **✅ Décidé le 2026-07-20** | Continuité du CP avec un lexique un peu plus large (mêmes champs + quelques ajouts : école, corps, vêtements simples...), toujours sans grammaire/conjugaison. |
| CE1 | Questionner le monde (espace/temps, vivant/matière/objets) | Pas encore | Contenu encore assez léger et très expérimental à ce stade (comparé à CM1/CM2) ; à surveiller mais pas encore assez fourni. |
| CE2 | Français → Grammaire/Orthographe | **Oui, recommandé** | Continuité directe du CE1, accords plus complexes, conjugaison élargie (imparfait, futur). |
| CE2 | Questionner le monde, EMC (nouveau en CE2), Langues vivantes | Limite, pas encore | Un peu plus dense qu'en CE1 (repères historiques/géographiques simples) mais toujours en dessous du seuil de contenu nécessaire pour une catégorie à part entière ; à réévaluer une fois CM1/CM2 en place. |
| CM1 | Français → **Grammaire/Orthographe** | **Oui, fortement recommandé** | Accords complexes (participe passé, pluriels irréguliers), conjugaison élargie (temps composés), nature ET fonction des mots — matière très riche, se prête bien à un format QCM. |
| CM1 | **Histoire-Géographie** | **Oui, recommandé** | Devient une vraie discipline structurée dès CM1 (2026-2027) : repères chronologiques, personnages, cartes — contenu factuel abondant, bien adapté au format actuel du jeu. |
| CM1 | **Sciences et technologie** | **Oui, recommandé** | Programme structuré (corps humain, matière, énergie, vivant) avec des faits vérifiables, bon candidat. |
| CM1 | **Langues vivantes (anglais)** | Oui, avec un format adapté | Vocabulaire et structures simples exploitables en QCM (traduction, choix du bon mot), mais nécessite un format différent (prononciation non testable à l'écrit) — catégorie viable mais à concevoir à part. |
| CM1 | EMC, Arts (dont histoire des arts) | Non / à la marge | EMC reste plus discursif que factuel ; histoire des arts pourrait devenir intéressant plus tard (œuvres/artistes) mais volume trop faible pour l'instant. |
| CM2 | Français → Grammaire/Orthographe | **Oui, fortement recommandé** | Même logique que CM1, niveau de difficulté supérieur (concordance des temps, homophones grammaticaux avancés). |
| CM2 | **Histoire-Géographie** | **Oui, recommandé** | Contenu le plus dense de l'école élémentaire (grandes périodes historiques, cartes de France/Europe/monde) — excellent candidat. |
| CM2 | **Sciences et technologie** | **Oui, recommandé** | Idem CM1, notions plus poussées (énergie, univers, corps humain approfondi). |
| CM2 | **Langues vivantes (anglais)** | Oui, avec un format adapté | Vocabulaire/grammaire anglaise plus riche qu'en CM1, même réserve sur le format (écrit uniquement). |

## Lecture (compréhension de texte) — matière transversale CP → CM2

Décidée le 2026-07-20. Contrairement aux autres matières de ce document, Lecture n'est pas
propre à une classe : c'est un nouveau **mode de jeu**, disponible du CP au CM2, où la
difficulté/longueur du texte évolue avec la classe plutôt que le type de question.

**Mécanique demandée :** un nouveau PNJ dédié propose un texte à lire, puis une série de
questions portant sur ce texte (compréhension, pas grammaire pure — complémentaire
d'Orthographe/Grammaire, pas un doublon).

**Ce que ça change techniquement (pour information, pas encore implémenté) :**
- Une question de Lecture ne peut pas exister seule : elle est toujours liée à un texte. Le
  système actuel (`QuestionResource` = une question isolée, `QuestionGiverComponent` = tire
  10 questions au hasard dans un pool) ne convient pas tel quel : il faudrait une nouvelle
  ressource `ReadingPassageResource` (texte + plusieurs `QuestionResource` liées), et un
  nouveau composant PNJ qui tire **un texte entier** (pas des questions isolées) puis enchaîne
  ses questions.
- Le barème de récompense actuel (`CardRarity.get_pack_reward`) suppose un pack de 10 questions
  pile. Un texte de Lecture aura probablement moins de 10 questions (surtout au CP) : à décider
  si on garde des packs de 10 questions au total (plusieurs textes courts par visite) ou si on
  adapte le barème pour être proportionnel à n'importe quelle taille de pack.
- CSV : une question de Lecture a besoin de connaître son texte parent — nécessite soit un CSV
  à deux fichiers liés (`passages.csv` + `questions.csv` avec une colonne `passage_id`), soit un
  format où le texte est répété sur chaque ligne de question (plus simple mais redondant).

Ces points seront tranchés avec l'utilisateur avant de commencer l'implémentation (voir
questions posées dans la conversation).

## Recommandation de mise en œuvre

1. **Prochaine étape naturelle : Grammaire/Orthographe (CE1 à CM2)**, en scindant le contenu
   français actuel plutôt qu'en repartant de zéro — le programme officiel sépare déjà clairement
   lecture/écriture (reste dans "Français") et étude de la langue (nouvelle catégorie). Impact
   technique minimal : ajouter une valeur à `SubjectType.Subject` (ex. `GRAMMAR`), un dossier
   `csv/questions/<classe>/grammaire/`, aucune autre modification structurelle (l'architecture
   classe → matière mise en place ce jour gère déjà nativement une matière qui n'existe qu'à
   partir du CE1).
2. **Ensuite, à partir du CM1 : Histoire-Géographie et Sciences et technologie**, les deux
   candidats les plus solides (contenu factuel abondant, déjà structuré par le programme officiel
   en périodes/thèmes clairs).
3. **Anglais (CM1-CM2)** : viable mais mérite une réflexion de format à part (peut-être un mode
   "associer mot français ↔ mot anglais" plutôt que du texte à trous), à traiter comme un
   objectif séparé plutôt qu'un simple ajout de CSV.
4. **CP : Anglais vocabulaire de base** (décidé le 2026-07-20, voir tableau) — seule exception à
   la prudence initiale sur le CP, car le périmètre est volontairement limité au lexique simple
   (pas de grammaire/programme LVE complet), donc reste factuel et adapté à l'âge malgré l'absence
   d'un vrai programme scolaire d'anglais au CP à ce jour.

## Sources

- [Enseigner au cycle 2 — éduscol](https://eduscol.education.gouv.fr/4347/enseigner-au-cycle-2)
- [Enseigner au cycle 3 — éduscol](https://eduscol.education.gouv.fr/4356/enseigner-au-cycle-3)
- [Programmes et horaires à l'école élémentaire — education.gouv.fr](https://www.education.gouv.fr/programmes-et-horaires-l-ecole-elementaire-9011)
