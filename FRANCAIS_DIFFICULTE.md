# Difficulte et revision — Grammaire, Conjugaison, Orthographe, Anglais

Statut : **scope et mecanisme valides par l'utilisateur le 2026-07-21**, contenu regenere pour
CE2/CM1/CM2 (CE1 deja conforme, non touche). Fait suite a un signalement : les questions de
Grammaire/Conjugaison/Orthographe etaient quasi identiques d'une classe a l'autre (meme banque de
verbes/adjectifs recyclee sans jamais monter en difficulte), car ce contenu venait d'un pool
"francais" genere a plat puis simplement reparti par type de notion (voir
`csv/questions/ID_RANGES.md`, note "Recategorisation du 2026-07-20") - jamais recalibre par classe.

## 1. Scope de difficulte par classe

CE1 n'a pas ete modifie (contenu deja adapte a son niveau). Seuls CE2/CM1/CM2 ont ete regeneres.

**Conjugaison**
| Classe | Notions |
|---|---|
| CE1 | Present, verbes du 1er groupe + etre/avoir |
| CE2 | Present (2e groupe + irreguliers usuels aller/faire/dire/venir), futur simple (1er groupe), imparfait (1er groupe + etre/avoir) |
| CM1 | Present (irreguliers prendre/voir/pouvoir/vouloir/savoir), imparfait generalise, futur simple generalise, passe compose (avoir/etre, initiation) |
| CM2 | Passe compose consolide, plus-que-parfait (initiation), passe simple (3e personne, verbes frequents, reconnaissance), conditionnel present |

**Grammaire**
| Classe | Notions |
|---|---|
| CE1 | Nature du mot (nom/verbe/adjectif/adverbe), pluriels en -aux, feminin des adjectifs |
| CE2 | Pronoms personnels, fonction sujet du verbe, accord sujet-verbe, types de phrases |
| CM1 | Fonctions COD/COI/attribut du sujet, determinants possessifs vs demonstratifs, accord du participe passe avec etre (simple) |
| CM2 | Complements circonstanciels (temps/lieu/maniere), subordonnee relative (qui/que/ou/dont), accord du participe passe avec avoir (initiation, cas invariable) |

**Orthographe**
| Classe | Notions |
|---|---|
| CE1 | Homophones simples (et/est, son/sont), femelles des animaux, comptage de lettres |
| CE2 | Homophones (on/ont, ces/ses, leur/leurs, quel/qu'elle, sa/ca — deplaces ici depuis CM1/CM2, deja au programme du cycle 2), synonymes/antonymes, accord de l'adjectif epithete, pluriel en -eau/-eu (-x) |
| CM1 | Homophones avances (la/l'a/la, peu/peux/peut, plutot/plus tot), mots invariables courants, doublement de consonnes |
| CM2 | Homophones avances (quand/quant/qu'en, sans/s'en/sens, tout/tous), prefixes/suffixes, orthographe d'usage (accents) |

Correction du 2026-07-21 : le premier jet placait les homophones grammaticaux (leur/leurs,
quel/qu'elle, sa/ca) en CM1/CM2 - l'utilisateur a signale que ces notions sont deja etudiees en
CE1/CE2 au programme officiel. Deplacees en CE2, remplacees en CM1/CM2 par des homophones
effectivement plus avances.

## 2. Mecanisme de pack de revision

Constat complementaire : meme avec un contenu bien calibre par classe, un pack de 10 questions
tirees uniquement dans la classe en cours ne fait jamais reviser les annees precedentes - risque
d'oubli. Ajoute un systeme de pack de revision pour Grammaire/Conjugaison/Orthographe/Anglais
(pas Maths : acquis cumulatifs par construction, un exercice de CM2 suppose deja les tables et les
4 operations ; pas Lecture : mecanique dediee au passage).

Implemente dans `QuestionGiverComponent._build_review_pack` : pour une matiere qui existe sur N
classes (ex. Anglais CP->CM2, N=5 ; Grammaire/Conjugaison/Orthographe CE1->CM2, N=4), la classe
d'index idx (0 = premiere classe ou la matiere existe, deduit du disque via
`_get_subject_grade_scope`) donne le pack suivant :

- **Premiere classe (idx=0)** : 10 questions de sa propre classe uniquement.
- **Derniere classe (idx=N-1)** : 5 questions de CHAQUE classe du parcours, y compris la
  sienne (revision egalitaire de toutes les annees avant l'entree au college).
- **Classes intermediaires** : 10 questions de sa propre classe + 5 questions de CHAQUE classe
  anterieure (pas seulement la precedente).

| Classe | Grammaire/Conjugaison/Orthographe (N=4, debut CE1) | Anglais (N=5, debut CP) |
|---|---|---|
| CP | - | 10 (CP) |
| CE1 | 10 (CE1) | 15 (10 CE1 + 5 CP) |
| CE2 | 15 (10 CE2 + 5 CE1) | 20 (10 CE2 + 5 CE1 + 5 CP) |
| CM1 | 20 (10 CM1 + 5 CE2 + 5 CE1) | 25 (10 CM1 + 5 CE2 + 5 CE1 + 5 CP) |
| CM2 | 20 (5 CE1 + 5 CE2 + 5 CM1 + 5 CM2) | 25 (5 CP + 5 CE1 + 5 CE2 + 5 CM1 + 5 CM2) |

Le pack pioche directement dans les `.tres` des classes anterieures a chaque lancement (pas de
duplication de contenu entre CSV) via `_load_subject_for_grade`. Aucune notion de "meme question
deja vue" n'est trackee : le tirage est aleatoire a chaque fois, comme pour le reste du jeu.

Consequence technique : la taille d'un pack n'est plus toujours 10. `CardRarity.get_pack_reward`
a ete generalise en pourcentage de reussite puis mis a l'echelle sur la taille reelle du pack
(voir le commentaire dans `card_rarity.gd`), et `EventBus.pack_completed` transporte desormais le
`total_count` du pack (utilise par `stats_tracker.gd` a la place de l'ancienne constante
`QuestionGiverComponent.PACK_SIZE`, qui ne vaut plus que pour Maths/Lecture).

## 3. Contenu regenere

`csv/questions/{ce2,cm1,cm2}/{grammaire,conjugaison,orthographe}/generated.csv` et les `.tres`
correspondants ont ete entierement recrees (anciens fichiers supprimes) le 2026-07-21, toujours
dans les tranches d'id deja reservees (voir `ID_RANGES.md`) :

| Classe/matiere | Questions | Ids |
|---|---|---|
| ce2/grammaire | 40 | 10000-10039 |
| ce2/conjugaison | 50 | 10040-10089 |
| ce2/orthographe | 50 | 10090-10139 |
| cm1/grammaire | 40 | 11000-11039 |
| cm1/conjugaison | 42 | 11040-11081 |
| cm1/orthographe | 35 | 11082-11116 |
| cm2/grammaire | 40 | 12000-12039 |
| cm2/conjugaison | 40 | 12040-12079 |
| cm2/orthographe | 37 | 12080-12116 |

CE1 (grammaire=86, conjugaison=67, orthographe=47, ids 9000-9199ish) n'a pas ete touche.

## 4. Verifie

- Aucune question dupliquee (texte) au sein d'une meme classe/matiere.
- Aucune bonne reponse presente parmi ses propres distracteurs, aucun distracteur duplique
  (script de validation automatique avant ecriture des `.tres`).
- Echantillon relu manuellement (conjugaisons irregulieres, accords, homophones) pour verifier
  la correction grammaticale des formes generees.
