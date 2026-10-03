-- Toutes les fiches de cours Logique CP -> CM2 (2026-10-03), une seule transaction.
begin;
-- Fiche Les suites logiques (CP) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Les suites logiques', $fiche$
[titre]Un motif qui se répète[/titre]
Dans une suite, un même [b]morceau[/b] revient toujours dans le même ordre : c'est le [b]motif[/b].
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=30][b]?[/b][/font_size][/center][/cell][/table]
[cadre]Le motif, c'est [b]■ ▲[/b]. Après ■ vient toujours ▲.
La réponse est [b]▲[/b].[/cadre]
[page]
[titre]Un motif de 3[/titre]
[table=6][cell bg=#42A5F5 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#F2A541 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#AB47BC border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#42A5F5 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#F2A541 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=18,8,18,8][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]bleu[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]orange[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]violet[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]bleu[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]orange[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]?[/font_size][/center][/cell][/table]
Je lis à voix haute : « bleu, orange, violet… bleu, orange… »
[cadre]Le motif a [b]3 couleurs[/b] : bleu, orange, violet.
Après orange vient [b]violet[/b].[/cadre]
[cadre=astuce]Je cherche où le motif [b]recommence[/b] : ici, quand le bleu revient.[/cadre]
[page]
[titre]Des groupes qui grandissent[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐🍐🍐[/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=26][b]?[/b][/font_size][/center][/cell][/table]
Je compte chaque groupe : [b]1[/b], puis [b]2[/b], puis [b]3[/b].
[cadre]À chaque groupe, on ajoute [b]1[/b] poire.
Le prochain groupe a [b]4[/b] poires.[/cadre]
[page]
[titre]Des nombres qui montent[/titre]
[center][font_size=30][b]2, 3, 4, 5, …[/b][/font_size][/center]
[file de=1 a=7 bonds=2:3,3:4,4:5,5:6]
[cadre]À chaque fois, j'avance de [b]1[/b] : c'est la règle [b]+1[/b].
Après 5 vient [b]6[/b].[/cadre]
[page]
[titre]Des nombres qui descendent[/titre]
[center][font_size=30][b]40, 38, 36, 34, …[/b][/font_size][/center]
[file de=31 a=41 bonds=40:38,38:36,36:34,34:32]
Les nombres sont de plus en plus [b]petits[/b] : je recule.
[cadre]De 40 à 38, je recule de [b]2[/b]. La règle est [b]-2[/b].
Après 34 vient [b]32[/b].[/cadre]
[page]
[titre]Reculer de 5 en 5[/titre]
[center][font_size=30][b]20, 15, 10, 5, …[/b][/font_size][/center]
[file de=0 a=20 pas=5 bonds=20:15,15:10,10:5,5:0]
[cadre]La règle est [b]-5[/b]. Après 5 vient [b]0[/b].[/cadre]
[cadre=astuce]Je regarde d'abord si les nombres [b]montent[/b] ou [b]descendent[/b].
S'ils montent, la réponse est plus grande. S'ils descendent, elle est plus petite.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une suite suit toujours [b]une règle[/b].
• Avec des formes ou des couleurs, je cherche le [b]motif[/b] qui se répète.
• Avec des groupes, je [b]compte[/b] chaque groupe.
• Avec des nombres, je regarde de combien on avance ou on recule : [b]+1[/b], [b]+2[/b], [b]-2[/b], [b]-5[/b]…
• Je vérifie ma réponse avec la règle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Ce qui va ensemble (CP) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Ce qui va ensemble', $fiche$
[titre]Les contraires[/titre]
Le contraire, c'est le mot qui veut dire [b]tout l'inverse[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]grand[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]petit[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]haut[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]bas[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]chaud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]froid[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]plein[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]vide[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]content[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]triste[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]assis[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]debout[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]ouvert[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]fermé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]rapide[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]lent[/font_size][/center][/cell][/table]
[cadre]Le contraire de [b]grand[/b], c'est [b]petit[/b]. Et le contraire de petit, c'est grand ![/cadre]
[page]
[titre]Trouver le contraire[/titre]
Pour trouver le contraire, je me fais un [b]petit film dans la tête[/b].
[cadre]Une boîte [b]pleine[/b] de bonbons… je mange tout… elle est [b]vide[/b] !
Le contraire de plein, c'est [b]vide[/b].[/cadre]
[cadre=astuce]Attention aux mots qui n'ont rien à voir : le contraire de [b]propre[/b] n'est pas « lourd », c'est [b]sale[/b].[/cadre]
[page]
[titre]Les petits des animaux[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐱 le chat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le chaton[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐶 le chien[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le chiot[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐮 la vache[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le veau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐔 la poule[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le poussin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐴 le cheval[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le poulain[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐑 le mouton[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'agneau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐷 le cochon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le porcelet[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐐 la chèvre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le chevreau[/font_size][/center][/cell][/table]
[cadre=astuce]Souvent, on entend le nom de l'animal : [b]lion[/b] → [b]lion[/b]ceau, [b]ours[/b] → [b]ours[/b]on, [b]lap[/b]in → [b]lap[/b]ereau.[/cadre]
[page]
[titre]Les cris des animaux[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐶[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]ouaf[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐱[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]miaou[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐮[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]meuh[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐔[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]cocorico[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐑[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]bêê[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🦆[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]coincoin[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐸[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]coa coa[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐺[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]aouuuu[/font_size][/center][/cell][/table]
[cadre]Je fais le cri dans ma tête et j'imagine l'animal qui le fait.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]contraire[/b], c'est le mot qui veut dire l'inverse : jour → nuit.
• Chaque animal a son [b]petit[/b] : le chat → le chaton.
• Chaque animal a son [b]cri[/b] : la vache fait « meuh ».
• Je cherche toujours ce qui [b]va ensemble[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Trouver l'intrus (CP) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Trouver l''intrus', $fiche$
[titre]L'intrus, c'est quoi ?[/titre]
L'intrus, c'est celui qui [b]n'est pas de la même famille[/b] que les autres.
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐶[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐰[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🍎[/color][/font_size][/center][/cell][/table]
[cadre]🐱 🐶 🐰 sont des [b]animaux[/b]. 🍎 est un [b]fruit[/b].
L'intrus, c'est 🍎.[/cadre]
[page]
[titre]Les formes et les dessins[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]★[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🐟[/color][/font_size][/center][/cell][/table]
[cadre]■ ▲ ★ sont des [b]formes[/b] : un carré, un triangle, une étoile.
🐟 est un [b]animal[/b] : c'est l'intrus.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je [b]nomme[/b] chaque dessin dans ma tête.
2. Je cherche ce que [b]presque tous[/b] ont en commun : des animaux ? des formes ? des fruits ?
3. Celui qui n'est pas dans la famille, c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Il y a toujours [b]un seul[/b] intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Les familles : les [b]animaux[/b], les [b]fruits[/b], les [b]formes[/b], les [b]objets[/b].
• L'intrus est celui qui n'est [b]pas de la même famille[/b].
• Je nomme chaque dessin avant de choisir.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Comparer : le plus, le moins (CP) - logique, notion 'comparer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Comparer : le plus, le moins', $fiche$
[titre]Je compte chacun[/titre]
[center]Léo a 🍋🍋🍋, Nina a 🍋🍋🍋🍋🍋.[/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Prénom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Citrons[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Nina[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]5[/font_size][/center][/cell][/table]
[cadre]Nina a [b]5[/b] citrons, Léo en a [b]3[/b].
5 est plus grand que 3 : c'est [b]Nina qui en a le plus[/b].[/cadre]
[page]
[titre]Le plus ou le moins ?[/titre]
Je lis bien la question : elle demande [b]le plus[/b] ou [b]le moins[/b] ?
[cadre][b]Le plus[/b] : celui qui en a [b]beaucoup[/b], le plus grand nombre.
[b]Le moins[/b] : celui qui en a [b]peu[/b], le plus petit nombre.[/cadre]
[cadre=astuce]Léo a 3 citrons, Nina en a 5.
Qui a [b]le moins[/b] de citrons ? C'est [b]Léo[/b] ![/cadre]
[page]
[titre]Mettre en face[/titre]
Je peux aussi mettre les objets [b]face à face[/b], un par un.
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24] [/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]Nina[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][/table]
[cadre]Chez Léo, il reste des cases vides : il en a [b]moins[/b].
Nina a des citrons en plus : elle en a [b]plus[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je [b]compte[/b] les objets de chaque enfant.
• [b]Le plus[/b] = le plus grand nombre. [b]Le moins[/b] = le plus petit nombre.
• S'ils en ont autant, c'est [b]pareil[/b].
• Je relis la question avant de répondre : le plus ou le moins ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Classer : le plus grand, le plus petit (CP) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Classer : le plus grand, le plus petit', $fiche$
[titre]Du plus petit au plus grand[/titre]
Je range les animaux selon leur taille [b]dans la vraie vie[/b].
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐝[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐶[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐴[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐘[/font_size][/center][/cell][/table]
[center][b]le plus petit  ———————→  le plus grand[/b][/center]
[cadre]L'abeille 🐝 est [b]la plus petite[/b]. L'éléphant 🐘 est [b]le plus grand[/b].[/cadre]
[page]
[titre]Attention aux dessins ![/titre]
Sur l'écran, tous les dessins ont [b]la même taille[/b].
[table=2][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐘[/font_size][/center][/cell][/table]
[cadre]Je ne regarde pas la taille du dessin.
J'imagine [b]le vrai animal[/b] : une souris tient dans la main, un éléphant est plus haut qu'une maison ![/cadre]
[page]
[titre]Trouver le plus grand[/titre]
[center]Quel est l'animal le plus grand ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐔[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🐻[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐸[/font_size][/center][/cell][/table]
[cadre]1. J'imagine chaque animal pour de vrai.
2. Je les compare deux par deux : l'ours est plus grand que la poule.
3. Le plus grand, c'est [b]l'ours [/b]🐻.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je pense à la taille des animaux [b]dans la vraie vie[/b].
• Le [b]plus petit[/b] est au début du rang, le [b]plus grand[/b] à la fin.
• Je relis la question : le plus grand ou le plus petit ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les suites logiques (CE1) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'logique', 'Les suites logiques', $fiche$
[titre]Trouver la longueur du motif[/titre]
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐝[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐘[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🦊[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐝[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐘[/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=30][b]?[/b][/font_size][/center][/cell][/table]
Je cherche quand le [b]premier dessin revient[/b] : 🐝 revient en 4e position.
[cadre]Le motif a donc [b]3 dessins[/b] : 🐝 🐘 🦊.
Après 🐘 vient 🦊.[/cadre]
[page]
[titre]Couper la suite en morceaux[/titre]
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]♦[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]★[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]♦[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]★[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=30][b]?[/b][/font_size][/center][/cell][/table]
[cadre]Je coupe : [b]♦ ★ ●[/b]  |  [b]♦ ★ ?[/b]
Les deux morceaux sont pareils : il manque [b]●[/b].[/cadre]
[cadre=astuce]Je vérifie que chaque morceau est [b]exactement le même[/b], dans le même ordre.[/cadre]
[page]
[titre]Les suites de lettres[/titre]
[table=26][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]A[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]B[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]C[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]D[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]E[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]F[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]G[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]H[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]I[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]J[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]K[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]L[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]M[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]N[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]O[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]P[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Q[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]R[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]S[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]T[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]U[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]V[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]W[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]X[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Y[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Z[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]1[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]2[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]3[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]4[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]5[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]6[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]7[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]8[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]9[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]10[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]11[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]12[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]13[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]14[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]15[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]16[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]17[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]18[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]19[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]20[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]21[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]22[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]23[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]24[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]25[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]26[/font_size][/b][/center][/cell][/table]
[center][font_size=28][b]A, C, E, G, …[/b][/font_size][/center]
[cadre]De A à C, je [b]saute une lettre[/b] (B). De C à E, je saute D.
Après G, je saute H : la réponse est [b]I[/b].[/cadre]
[page]
[titre]Trouver l'écart[/titre]
Avec des nombres, je cherche [b]l'écart[/b] entre deux nombres qui se suivent.
[center][font_size=30][b]89, 85, 81, 77, …[/b][/font_size][/center]
[cadre]De 89 à 85, je recule de [b]4[/b]. De 85 à 81 : encore 4.
La règle est [b]-4[/b] : 77 - 4 = [b]73[/b].[/cadre]
[cadre=astuce]Je vérifie l'écart sur [b]deux paires[/b] de nombres, pas une seule.[/cadre]
[page]
[titre]Des grands bonds[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]149[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]169[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]189[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]209[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+20[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+20[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+20[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+20[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]De 149 à 169, j'avance de [b]20[/b]. Seules les [b]dizaines[/b] changent : 4, 6, 8, puis 0 (et la centaine passe à 2).
209 + 20 = [b]229[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Formes et dessins : je trouve la [b]longueur du motif[/b] (quand le 1er revient).
• Lettres : je regarde combien de lettres on [b]saute[/b] dans l'alphabet.
• Nombres : je calcule [b]l'écart[/b] (+4, -4, +20…) et je le vérifie deux fois.
• Les nombres montent ? Ma réponse est plus grande. Ils descendent ? Elle est plus petite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Ce qui va ensemble (CE1) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'logique', 'Ce qui va ensemble', $fiche$
[titre]Les contraires[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]devant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]derrière[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]acheter[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]vendre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]ouvert[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]fermé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]étroit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]large[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]épais[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]mince[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]mouillé[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]sec[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]vieux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]jeune[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]sombre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]clair[/font_size][/center][/cell][/table]
[cadre]Le contraire veut dire [b]l'inverse[/b]. Je peux tester avec une phrase :
« La porte est [b]ouverte[/b]… non, elle est [b]fermée[/b]. »[/cadre]
[page]
[titre]À quoi ça sert ?[/titre]
Chaque objet a une [b]utilité[/b] : il sert à faire quelque chose.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la gomme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]effacer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la règle[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]mesurer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la balance[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]peser[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le marteau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]clouer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la loupe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]voir en plus gros[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le sécateur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]tailler les branches[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le thermomètre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]mesurer la température[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la passoire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]égoutter les pâtes[/font_size][/center][/cell][/table]
[page]
[titre]Trouver l'objet[/titre]
La question peut être posée [b]dans les deux sens[/b] :
[cadre]« La gomme sert à… » → [b]effacer[/b].
« Quel objet sert à effacer ? » → [b]la gomme[/b].[/cadre]
[cadre=astuce]Je m'imagine en train de faire l'action : pour [b]peser[/b] des pommes, je les pose sur… [b]la balance[/b] ![/cadre]
[page]
[titre]Les petits des animaux[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'aigle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'aiglon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'âne[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'ânon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le canard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le caneton[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le cerf[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le faon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le loup[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le louveteau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la baleine[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le baleineau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'oie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'oison[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le lapin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le lapereau[/font_size][/center][/cell][/table]
[cadre]Le faon (petit du cerf) est un piège : on n'entend pas « cerf » dedans ![/cadre]
[page]
[titre]Dans l'autre sens[/titre]
[cadre]« Le petit de la vache est… » → [b]le veau[/b].
« Le veau est le petit de quel animal ? » → [b]la vache[/b].[/cadre]
[cadre=astuce]Je relis la question : on me demande [b]le petit[/b] ou [b]le parent[/b] ?[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]contraire[/b] dit l'inverse : acheter → vendre.
• Chaque objet [b]sert à[/b] quelque chose : le peigne sert à se coiffer.
• Chaque animal a son [b]petit[/b] : le loup → le louveteau.
• La question peut être posée dans les [b]deux sens[/b] : je relis bien.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Trouver l'intrus (CE1) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'logique', 'Trouver l''intrus', $fiche$
[titre]Bien lire la question[/titre]
Au CE1, la question dit [b]quelle famille[/b] chercher.
[cadre]« Quel nombre [b]n'est pas[/b] un multiple de 10 ? »
Je cherche le seul nombre qui [b]n'est pas[/b] dans la famille des multiples de 10.[/cadre]
[cadre=astuce]Le mot [b]« pas »[/b] est très important : je cherche celui qui ne va pas.[/cadre]
[page]
[titre]Les multiples de 10 et de 5[/titre]
Un multiple de 10 se termine par [b]0[/b]. Un multiple de 5 se termine par [b]0 ou 5[/b].
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]140[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]190[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=26][b][color=white]116[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]170[/b][/font_size][/center][/cell][/table]
[cadre]140, 190 et 170 se terminent par 0. 116 se termine par 6 : c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Je regarde seulement le [b]dernier chiffre[/b] (le chiffre des unités).[/cadre]
[page]
[titre]Pair ou impair ?[/titre]
Pairs : se terminent par [b]0, 2, 4, 6, 8[/b]. Impairs : par [b]1, 3, 5, 7, 9[/b].
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]65[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=26][b][color=white]92[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]41[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]23[/b][/font_size][/center][/cell][/table]
[cadre]« Quel nombre n'est pas impair ? » 65, 41, 23 sont impairs.
92 se termine par 2 : il est pair, c'est [b]l'intrus[/b].[/cadre]
[page]
[titre]Le nombre de pattes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐭 🐰 🐶 🐸 🐷[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]4 pattes[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐔 🦆 🐦[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]2 pattes (les oiseaux)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐝 🦋 🐞[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]6 pattes (les insectes)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐟 🐍[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]pas de pattes[/font_size][/center][/cell][/table]
[cadre]« Lequel n'a pas 4 pattes ? 🐔 🐭 🐰 🐸 » → la poule 🐔 n'a que 2 pattes.[/cadre]
[page]
[titre]Animal, objet ou fruit ?[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🔑[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=32][color=white]🍊[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🎁[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🎈[/font_size][/center][/cell][/table]
[cadre]« Quel élément n'est pas un objet ? » La clé, le cadeau et le ballon sont des objets.
L'orange 🍊 est un fruit : c'est l'intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis la famille demandée et le mot [b]« pas »[/b].
• Multiple de 10 : finit par [b]0[/b]. Multiple de 5 : finit par [b]0 ou 5[/b].
• Pair : finit par 0, 2, 4, 6, 8. Impair : par 1, 3, 5, 7, 9.
• Oiseaux : 2 pattes. Insectes : 6 pattes.
• Je vérifie chaque élément un par un.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les suites logiques (CE2) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Les suites logiques', $fiche$
[titre]J'écris les écarts[/titre]
Je note [b]sous la suite[/b] l'écart entre chaque nombre.
[table=11][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]12[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]16[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]18[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]22[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]24[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les écarts ne sont pas toujours les mêmes : [b]+4, +2, +4, +2[/b]…
Ils [b]alternent[/b] ! Le prochain est +4 : 24 + 4 = [b]28[/b].[/cadre]
[page]
[titre]Deux règles qui alternent[/titre]
[table=11][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]14[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]24[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]20[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]30[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]26[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+10[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]-4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+10[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]-4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+10[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]On ajoute 10, puis on enlève 4, puis on ajoute 10… : 26 + 10 = [b]36[/b].[/cadre]
[cadre=astuce]Quand une suite monte puis descend, c'est souvent [b]deux règles qui alternent[/b].[/cadre]
[page]
[titre]Doubler à chaque fois[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]18[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]36[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]72[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]144[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les écarts grandissent très vite : 18, 36, 72… Chaque nombre est le [b]double[/b] du précédent.
144 x 2 = [b]288[/b].[/cadre]
[cadre=astuce]Dans l'autre sens (32, 16, 8, 4…), on prend la [b]moitié[/b] : la réponse est 2.[/cadre]
[page]
[titre]Sauter des lettres[/titre]
[table=26][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]A[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]B[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]C[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]D[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]E[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]F[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]G[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]H[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]I[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]J[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]K[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]L[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]M[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]N[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]O[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]P[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Q[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]R[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]S[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]T[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]U[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]V[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]W[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]X[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Y[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=18]Z[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]1[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]2[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]3[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]4[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]5[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]6[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]7[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]8[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]9[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]10[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]11[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]12[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]13[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]14[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]15[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]16[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]17[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]18[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]19[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]20[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]21[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]22[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]23[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]24[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]25[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=18]26[/font_size][/b][/center][/cell][/table]
[center][font_size=28][b]A, D, G, J, …[/b][/font_size][/center]
[cadre]Avec les nombres sous les lettres : A = 1, D = 4, G = 7, J = 10 : la règle est [b]+3[/b].
10 + 3 = 13, et la lettre n°13 est [b]M[/b].[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Les nombres montent ? descendent ? montent [b]et[/b] descendent ?
2. J'écris tous les [b]écarts[/b] sous la suite.
3. Les écarts sont pareils → c'est la règle. Ils alternent → [b]deux règles[/b]. Ils grandissent très vite → peut-être [b]x 2[/b].
4. Je calcule la réponse et je vérifie.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• J'écris toujours les [b]écarts[/b] sous la suite.
• Des écarts qui reviennent (+10, -4, +10, -4) : [b]deux règles qui alternent[/b].
• Des nombres qui doublent : la règle est [b]x 2[/b] (ou la moitié s'ils diminuent).
• Lettres : je compte les lettres sautées, ou j'utilise A = 1, B = 2, C = 3…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les analogies (CE2) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Les analogies', $fiche$
[titre]Le même lien[/titre]
Une analogie, c'est retrouver [b]le même lien[/b] entre deux paires de mots.
[center][font_size=24][b]Le jour est à la nuit ce que le chaud est… au froid.[/b][/font_size][/center]
[cadre]Jour et nuit sont des [b]contraires[/b]. Il faut donc le contraire de chaud : [b]froid[/b].[/cadre]
[page]
[titre]Où vivent les animaux ?[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'abeille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une ruche[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la fourmi[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une fourmilière[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le castor[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une hutte[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le lapin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un terrier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'ours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une tanière[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le cheval[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une écurie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le mouton[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une bergerie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le manchot[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la banquise[/font_size][/center][/cell][/table]
[cadre=astuce]Le nom de la maison ressemble souvent au nom de l'animal : la [b]poule[/b] → le [b]poul[/b]ailler, le [b]pigeon[/b] → le [b]pigeon[/b]nier, la [b]guêpe[/b] → le [b]guêp[/b]ier.[/cadre]
[page]
[titre]Comment se déplacent-ils ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]l'aigle, la mouche, la chauve-souris[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]vole[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le dauphin, le requin, la truite[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]nage[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le serpent, la chenille, le ver de terre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]rampe[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]l'escargot, la limace[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]glisse[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la grenouille, la puce, la sauterelle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]saute[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le kangourou, le lièvre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]bondit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le singe, le koala, la chèvre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]grimpe[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le cheval, le zèbre, le poney[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]galope[/font_size][/center][/cell][/table]
[page]
[titre]D'autres contraires[/titre]
Les [b]verbes[/b] (entrer, allumer…) ont aussi des contraires, comme les mots qui décrivent (calme, ancien…).
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]entrer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]sortir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]allumer[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]éteindre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]attacher[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]détacher[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]accepter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]refuser[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]avancer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]reculer[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]calme[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]agité[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]ancien[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]moderne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]épais[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]mince[/font_size][/center][/cell][/table]
[cadre=astuce]Parfois, il suffit d'ajouter [b]dé-[/b] : attacher → [b]dé[/b]tacher. Mais pas toujours : allumer → éteindre.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une analogie : je trouve le [b]lien[/b] entre les deux premiers mots, puis je l'applique.
• Les liens possibles : [b]contraire[/b], [b]où il vit[/b], [b]comment il se déplace[/b]…
• La maison d'un animal ressemble souvent à son nom : la ruche, le poulailler.
• Je vérifie en faisant une phrase : « Le singe [b]grimpe[/b] aux arbres. »[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Trouver l'intrus (CE2) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Trouver l''intrus', $fiche$
[titre]Fruit ou légume ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Famille[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🍎 🍐 🍊 🍋 🍌 🍇 🍓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des fruits[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]🍒 🍑 🍉 🍍 🥝 🥭 🍅[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des fruits[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🥕 🥔 🧅 🥦 🥬[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des légumes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]🥒 🍆 🌽[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des légumes[/font_size][/center][/cell][/table]
[cadre=astuce]La [b]tomate[/b] 🍅 est un fruit : elle pousse à partir de la fleur et elle a des pépins.[/cadre]
[page]
[titre]Trouver l'intrus[/titre]
[center]Lequel de ces aliments n'est pas un fruit ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍇[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🥦[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍑[/font_size][/center][/cell][/table]
[cadre]1. Je nomme chaque aliment : poire, raisin, brocoli, pêche.
2. Je classe : poire → fruit, raisin → fruit, brocoli → [b]légume[/b], pêche → fruit.
3. L'intrus est le [b]brocoli [/b]🥦.[/cadre]
[page]
[titre]Attention à la question ![/titre]
[center]Lequel de ces aliments n'est pas un [b]légume[/b] ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🌽[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🥬[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🧅[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🍇[/color][/font_size][/center][/cell][/table]
[cadre]Cette fois, la famille, ce sont les [b]légumes[/b]. Le maïs, la salade et l'oignon en sont.
Le raisin 🍇 est un fruit : c'est lui l'intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis bien la famille demandée : [b]fruit[/b] ou [b]légume[/b] ?
• Je nomme chaque aliment avant de choisir.
• La tomate 🍅 est un fruit.
• Il n'y a qu'[b]un seul[/b] intrus : les trois autres sont de la même famille.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Classer et ranger (CE2) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Classer et ranger', $fiche$
[titre]Je fais une échelle[/titre]
[center]Tom est plus grand que Léo. Léo est plus grand que Nolan.[/center]
[table=1][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]↑ le plus grand[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Tom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Nolan[/font_size][/center][/cell][/table]
[center][b]↓ le plus petit[/b][/center]
[cadre]Je place les enfants du plus grand (en haut) au plus petit (en bas).
Le plus grand est [b]Tom[/b], le plus petit est [b]Nolan[/b].[/cadre]
[page]
[titre]Le prénom qui revient[/titre]
[cadre]« Tom est plus grand que [b]Léo[/b]. [b]Léo[/b] est plus grand que Nolan. »
Léo est dans les deux phrases : il est plus petit que Tom mais plus grand que Nolan.
Léo est donc [b]au milieu[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]deux fois[/b] est toujours celui du milieu.[/cadre]
[page]
[titre]Ni le plus grand, ni le plus petit[/titre]
« Qui n'est ni le plus grand, ni le plus petit ? »
[cadre]On cherche celui qui est [b]au milieu[/b] de l'échelle.
Avec Tom, Léo et Nolan, c'est [b]Léo[/b].[/cadre]
[cadre=astuce]Ce n'est jamais « impossible à savoir » : les deux phrases suffisent toujours à ranger les trois enfants.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je dessine une [b]échelle[/b] : le plus grand en haut, le plus petit en bas.
• Le prénom qui revient dans [b]les deux phrases[/b] est au milieu.
• « Ni le plus grand, ni le plus petit » = celui [b]du milieu[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Raisonner et déduire (CE2) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Raisonner et déduire', $fiche$
[titre]Si… alors…[/titre]
[cadre][b]Si[/b] le feu est vert, Nina avance.
Le feu [b]est[/b] vert.
[b]Donc[/b] Nina… [b]avance ![/b][/cadre]
La 1re phrase donne une [b]règle[/b]. La 2e dit que la condition est vraie.
Alors je peux en être sûr : la règle s'applique.
[page]
[titre]Recopier la règle[/titre]
[cadre]« S'il fait froid, Alice [b]met un manteau[/b]. Il fait froid. Donc Alice… »
La réponse est déjà écrite dans la règle : Alice [b]met un manteau[/b].[/cadre]
[cadre=astuce]Les autres réponses (« boit de l'eau fraîche », « ne fait rien ») sont peut-être possibles dans la vie, mais [b]la règle[/b] dit ce qui se passe.[/cadre]
[page]
[titre]Tous les… sont des…[/titre]
[cadre]« [b]Tous[/b] les chats sont des animaux. Félix est un chat. Donc Félix est… [b]un animal[/b]. »[/cadre]
[table=1][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]les animaux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐱 les chats : Félix[/font_size][/center][/cell][/table]
[center]La famille des chats est [b]rangée dans[/b] la famille des animaux.[/center]
[page]
[titre]Je retiens[/titre]
[cadre]• « [b]Si[/b] … alors … » : quand la condition est vraie, la suite arrive toujours.
• La réponse se trouve [b]dans la règle[/b] : je la recopie.
• « [b]Tous[/b] les X sont des Y » : un X est forcément un Y.
• Je réponds avec ce que dit le texte, pas avec ce que j'imagine.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Se repérer dans l'espace (CE2) - logique, notion 'reperage_espace'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Se repérer dans l''espace', $fiche$
[titre]Les 9 cases de la grille[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut à droite[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au milieu à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au milieu à droite[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas à droite[/b][/font_size][/center][/cell][/table]
[cadre]Je dis d'abord la [b]ligne[/b] (en haut, au milieu, en bas), puis la [b]colonne[/b] (à gauche, au centre, à droite).
La case du milieu s'appelle simplement [b]au centre[/b].[/cadre]
[page]
[titre]Déplacer vers le bas[/titre]
[center]Un objet est [b]en haut à droite[/b]. On le déplace de [b]2 cases vers le bas[/b].[/center]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]↓[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=26][b][color=white]●[/color][/b][/font_size][/center][/cell][/table]
[cadre]Il descend dans [b]la même colonne[/b] : en haut → au milieu → en bas.
Il arrive [b]en bas à droite[/b].[/cadre]
[page]
[titre]Déplacer vers la gauche[/titre]
[center]Un objet est [b]au milieu à droite[/b]. On le déplace de [b]1 case vers la gauche[/b].[/center]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=26][b][color=white]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]● ←[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][/table]
[cadre]Il reste sur [b]la même ligne[/b] et recule d'une case : il arrive [b]au centre[/b].[/cadre]
[cadre=astuce]La [b]gauche[/b], c'est le côté où l'on commence à lire une ligne.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je pose mon doigt sur la case de départ.
2. Je compte les cases [b]une par une[/b] dans la bonne direction.
3. Haut ou bas : je change de [b]ligne[/b]. Gauche ou droite : je change de [b]colonne[/b].
4. Je dis la nouvelle position : la ligne, puis la colonne.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une position = une [b]ligne[/b] + une [b]colonne[/b] : « en bas à gauche ».
• La case du milieu, c'est [b]au centre[/b].
• Vers le haut ou le bas : je reste dans la même colonne.
• Vers la gauche ou la droite : je reste sur la même ligne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'reperage_espace'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les suites logiques (CM1) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les suites logiques', $fiche$
[titre]Une multiplication, puis une addition[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]5[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]15[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]17[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]51[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 3[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 3[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]L'écart change sans arrêt (+10, +2, +34) : ce n'est pas une addition simple.
Je teste : 5 [b]x 3[/b] = 15, 15 [b]+ 2[/b] = 17, 17 [b]x 3[/b] = 51. Ensuite : 51 + 2 = [b]53[/b].[/cadre]
[page]
[titre]Monter, descendre[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]19[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]25[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]17[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]23[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]- 8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]- 8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]La suite monte, puis descend : [b]+6 puis -8[/b], et ainsi de suite.
23 - 8 = [b]15[/b].[/cadre]
[cadre=astuce]Je vérifie ma règle sur [b]tous[/b] les nombres de la suite, pas seulement les deux premiers.[/cadre]
[page]
[titre]Une lettre et un nombre[/titre]
[center][font_size=28][b]E5, G7, I9, K11, …[/b][/font_size][/center]
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]E[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]G[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]I[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]K[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]5[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]7[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]9[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]11[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[cadre]Je sépare la suite en [b]deux suites[/b] : les lettres E, G, I, K (je saute une lettre) → [b]M[/b] ; les nombres +2 → [b]13[/b].
La réponse est [b]M13[/b].[/cadre]
[page]
[titre]Les nombres carrés[/titre]
Le [b]carré[/b] d'un nombre, c'est ce nombre multiplié [b]par lui-même[/b].
[grille lignes=3 colonnes=3]
[cadre]Le carré de 3 = 3 x 3 = [b]9[/b] : un carré de 3 cases sur 3 cases.
Les carrés : 1, 4, 9, 16, 25, 36, 49, 64, [b]81[/b] (9 x 9), 100.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. J'écris les écarts. Ils sont pareils ? C'est une addition ou une soustraction.
2. Ils alternent ? [b]Deux règles[/b] (+6 puis -8).
3. Ils grandissent vite ? Je teste une [b]multiplication[/b] (x 2, x 3…).
4. Lettres et nombres mélangés ? Je fais [b]deux suites séparées[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une suite peut avoir [b]deux opérations[/b] qui alternent : x 3 puis + 2.
• Pour « E5, G7… », je traite les [b]lettres[/b] et les [b]nombres[/b] séparément.
• Le carré d'un nombre : ce nombre [b]x lui-même[/b] (9 x 9 = 81).
• Je vérifie ma règle sur toute la suite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les analogies : la partie et le tout (CM1) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les analogies : la partie et le tout', $fiche$
[titre]Lire une analogie[/titre]
[center][font_size=24][b]Le pétale est à la fleur ce que la feuille est… à l'arbre.[/b][/font_size][/center]
[cadre]Je trouve le lien entre les deux premiers mots : le pétale est [b]une partie[/b] de la fleur.
Je cherche de quoi la feuille est une partie : [b]de l'arbre[/b].[/cadre]
[page]
[titre]Des parties et leur tout[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]La partie[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le tout[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]La partie[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le tout[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la page[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le livre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la touche[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le piano[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le wagon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le train[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le maillon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la chaîne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la perle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le collier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la note[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la mélodie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le pixel[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'écran[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la voile[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le rayon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la roue[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'orteil[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le pied[/font_size][/center][/cell][/table]
[page]
[titre]Faire une phrase pour vérifier[/titre]
[cadre]« La touche est au piano ce que la voile est… »
Je dis : « La touche est [b]une partie du[/b] piano. La voile est [b]une partie du[/b]… [b]bateau[/b]. »
La phrase marche : la réponse est [b]au bateau[/b].[/cadre]
[cadre=astuce]Piège : une réponse peut reprendre un mot du début (« à la fleur »). Elle est fausse : il faut le tout du [b]troisième[/b] mot.[/cadre]
[page]
[titre]au, à la, à l'[/titre]
La réponse commence par [b]à[/b] + le nom :
[cadre]à + le bateau → [b]au[/b] bateau
à + la chaîne → [b]à la[/b] chaîne
à + l'écran → [b]à l'[/b]écran[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• « A est à B ce que C est à … » : je trouve le [b]lien entre A et B[/b], puis je l'applique à C.
• Ici, le lien est souvent : A est [b]une partie[/b] de B.
• Je vérifie avec une phrase : « La page est une partie du livre. »
• au = à + le.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Classer et ranger (CM1) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Classer et ranger', $fiche$
[titre]Plus âgé, plus jeune[/titre]
[cadre]Plus [b]âgé[/b] = plus vieux, né [b]avant[/b].
Plus [b]jeune[/b] = moins vieux, né [b]après[/b].[/cadre]
Ce sont des [b]contraires[/b] : si Emma est plus âgée que Sarah, alors Sarah est plus jeune qu'Emma.
[page]
[titre]Tout dire dans le même sens[/titre]
[center]Camille est plus âgée que Sarah. Emma est plus jeune que Sarah.[/center]
[cadre]Les deux phrases ne vont pas dans le même sens. Je retourne la 2e :
« Emma est plus jeune que Sarah » = « Sarah est [b]plus âgée[/b] qu'Emma ».
Donc : [b]Camille[/b] > Sarah > Emma.[/cadre]
[page]
[titre]Je range sur une frise[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la plus âgée[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]au milieu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la plus jeune[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Camille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Sarah[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Emma[/font_size][/center][/cell][/table]
[cadre]Qui est le plus âgé ? [b]Camille[/b]. Qui est le plus jeune ? [b]Emma[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]dans les deux phrases[/b] est toujours au milieu.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus âgé et plus jeune sont des [b]contraires[/b].
• Je retourne une phrase pour que les deux disent [b]la même chose[/b] (plus âgé que…).
• Je range les prénoms sur une frise, du plus âgé au plus jeune.
• Le prénom qui revient deux fois est [b]au milieu[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Raisonner et déduire (CM1) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Raisonner et déduire', $fiche$
[titre]Avant, après[/titre]
[cadre]Dans une course, arriver [b]avant[/b] quelqu'un, c'est arriver [b]plus tôt[/b] : on est devant lui au classement.[/cadre]
[center]Inès arrive avant Hugo. Hugo arrive avant Lucas.[/center]
Inès est devant Hugo, et Hugo est devant Lucas.
[page]
[titre]Je fais le podium[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]1er[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]2e[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]3e (dernier)[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Inès[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Hugo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Lucas[/font_size][/center][/cell][/table]
[cadre]Qui arrive en premier ? [b]Inès[/b]. En 2e position ? [b]Hugo[/b]. En dernier ? [b]Lucas[/b].[/cadre]
[page]
[titre]Si l'ordre est mélangé[/titre]
[center]Hugo arrive avant Lucas. Inès arrive avant Hugo.[/center]
[cadre]Les phrases ne sont pas dans l'ordre, mais je fais pareil :
je place d'abord Hugo devant Lucas, puis Inès devant Hugo : [b]Inès, Hugo, Lucas[/b].[/cadre]
[cadre=astuce]Je commence toujours par le prénom qui apparaît [b]deux fois[/b] : il est 2e.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Arriver [b]avant[/b] = être devant au classement.
• J'écris le classement : 1er, 2e, 3e.
• Le prénom cité dans [b]les deux phrases[/b] est en 2e position.
• Je relis la question : premier, 2e ou dernier ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les codes secrets (CM1) - logique, notion 'codes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les codes secrets', $fiche$
[titre]Le code A = 1, B = 2…[/titre]
Chaque lettre a un numéro : [b]sa place dans l'alphabet[/b].
[table=13][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]A[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]B[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]C[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]D[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]E[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]F[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]G[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]H[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]I[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]J[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]K[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]L[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]M[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]1[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]2[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]3[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]4[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]5[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]6[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]7[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]8[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]9[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]10[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]11[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]12[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]13[/font_size][/b][/center][/cell][/table]
[table=13][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]N[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]O[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]P[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Q[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]R[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]S[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]T[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]U[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]V[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]W[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]X[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Y[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Z[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]14[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]15[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]16[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]17[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]18[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]19[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]20[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]21[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]22[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]23[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]24[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]25[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]26[/font_size][/b][/center][/cell][/table]
[page]
[titre]Des repères pour aller vite[/titre]
[cadre]Je retiens quelques lettres : [b]E = 5[/b], [b]J = 10[/b], [b]O = 15[/b], [b]T = 20[/b], [b]Y = 25[/b].
Puis je compte à partir du repère le plus proche.[/cadre]
[cadre=astuce]U = ? → T = 20, donc U = [b]21[/b].
22 = ? → 20 = T, 21 = U, 22 = [b]V[/b].[/cadre]
[page]
[titre]La somme d'un mot[/titre]
[center][font_size=24][b]PAIN[/b][/font_size][/center]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]P[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]A[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]I[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]N[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]16[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]9[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]14[/font_size][/center][/cell][/table]
[cadre]16 + 1 + 9 + 14 = [b]40[/b]. La somme des lettres de PAIN est [b]40[/b].[/cadre]
[cadre=astuce]J'additionne en regroupant : 16 + 14 = 30, puis 30 + 1 + 9 = 40.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Dans ce code, chaque lettre vaut [b]sa place dans l'alphabet[/b] : A = 1, Z = 26.
• Repères : E = 5, J = 10, O = 15, T = 20, Y = 25.
• Somme d'un mot : je remplace chaque lettre par son nombre, puis j'additionne.
• Je vérifie mon addition une deuxième fois.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'codes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les grilles à compléter (CM1) - logique, notion 'grilles'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les grilles à compléter', $fiche$
[titre]La règle de la grille[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Chaque symbole apparaît [b]une seule fois[/b] dans chaque ligne et [b]une seule fois[/b] dans chaque colonne.[/cadre]
[page]
[titre]Ce qui manque dans la ligne[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Dans la 3e ligne, il y a déjà ▲ et ●. Il manque [b]■[/b].[/cadre]
[page]
[titre]Je vérifie avec la colonne[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=30][b][color=white]■[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Dans la 1re colonne : ▲, ●, et ma réponse ■. Les trois sont différents : [b]c'est juste ![/b][/cadre]
[cadre=astuce]On voit aussi que chaque ligne est la ligne d'avant [b]décalée d'une case[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Chaque symbole : [b]une fois[/b] par ligne et [b]une fois[/b] par colonne.
• Je regarde la ligne de la case vide : quel symbole manque ?
• Je vérifie avec la colonne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'grilles'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les suites logiques (CM2) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les suites logiques', $fiche$
[titre]La somme des deux précédents[/titre]
[table=11][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]2[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]6[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]8[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]14[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]22[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites][/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les écarts ne suivent pas de règle simple. Je regarde autrement :
2 + 6 = [b]8[/b], 6 + 8 = [b]14[/b], 8 + 14 = [b]22[/b]. Chaque nombre est la [b]somme des deux d'avant[/b].
14 + 22 = [b]36[/b].[/cadre]
[page]
[titre]Multiplier puis ajouter[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]4[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]13[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]31[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]67[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=24][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les nombres font un peu plus que [b]doubler[/b]. Je teste x 2 : 4 x 2 = 8, et il reste [b]5[/b] pour arriver à 13.
Je vérifie : 13 x 2 + 5 = 31 ✓, 31 x 2 + 5 = 67 ✓. Donc 67 x 2 + 5 = [b]139[/b].[/cadre]
[page]
[titre]Une règle cachée : x 3 + 3[/titre]
[center][font_size=28][b]1, 6, 21, 66, …[/b][/font_size][/center]
[cadre]Ça grandit d'environ [b]3 fois[/b] : je teste x 3.
1 x 3 = 3 → il manque 3 pour faire 6. 6 x 3 = 18 → il manque 3 pour 21. La règle : [b]x 3 + 3[/b].
66 x 3 + 3 = [b]201[/b].[/cadre]
[cadre=astuce]Je divise un nombre par le précédent (66 ÷ 21 ≈ 3) pour deviner le « x ».[/cadre]
[page]
[titre]Deux suites mélangées[/titre]
[center][font_size=28][b]4, 22, 6, 21, 8, …[/b][/font_size][/center]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]1re, 3e, 5e place[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]4[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]6[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]8[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]2e, 4e, 6e place[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]22[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]21[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[cadre]Un nombre sur deux forme une suite : 4, 6, 8 (+2) et 22, 21 (-1).
La 6e place continue la 2e suite : 21 - 1 = [b]20[/b].[/cadre]
[page]
[titre]Ma méthode, dans l'ordre[/titre]
[cadre]1. J'écris les écarts : sont-ils pareils ou alternés ?
2. Les nombres sautent (petit, grand, petit…) ? → [b]deux suites mélangées[/b].
3. Chaque nombre = les deux précédents additionnés ?
4. Ça grandit très vite ? → je teste [b]x 2[/b] ou [b]x 3[/b], puis je regarde ce qu'il faut ajouter.
5. Je vérifie la règle sur [b]tous[/b] les nombres.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Somme des deux précédents : 2, 6, 8, 14, 22, 36…
• Règle « [b]x k + c[/b] » : je devine le x en comparant deux nombres, puis je trouve ce qu'il faut ajouter.
• Deux suites mélangées : je regarde [b]un nombre sur deux[/b].
• Une règle n'est bonne que si elle marche pour [b]toute[/b] la suite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les analogies : à quoi ça sert ? (CM2) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les analogies : à quoi ça sert ?', $fiche$
[titre]Le lien : ce qu'on en fait[/titre]
[center][font_size=24][b]Le stylo est à écrire ce que le livre est… à lire.[/b][/font_size][/center]
[cadre]Le lien entre « stylo » et « écrire » : le stylo [b]sert à[/b] écrire.
Je cherche à quoi sert le livre : [b]à lire[/b].[/cadre]
[page]
[titre]Des objets et leur action[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le nom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]L'action[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le nom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]L'action[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le vélo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pédaler[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la voiture[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]conduire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la porte[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ouvrir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la valise[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]porter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le feu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]éteindre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la graine[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]planter[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le puzzle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]assembler[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le linge[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]laver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la musique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]écouter[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le film[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]regarder[/font_size][/center][/cell][/table]
[page]
[titre]Choisir la meilleure action[/titre]
Un objet peut servir à plusieurs choses. Je choisis l'action [b]la plus naturelle[/b], celle qu'on dit en premier.
[cadre]« La voiture est à conduire ce que le stylo est… »
à écrire ✓   à chanter ✗   à porter ✗   à prendre ✗[/cadre]
[cadre=astuce]Je fais une phrase : « On [b]conduit[/b] une voiture, on [b]écrit[/b] avec un stylo. »[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je trouve le [b]lien[/b] entre le 1er et le 2e mot : ici, ce à quoi sert l'objet.
• J'applique le même lien au 3e mot.
• Je choisis l'action la plus [b]naturelle[/b] et je vérifie avec une phrase.
• Au CM1, le lien était « une partie de » ; au CM2, c'est souvent « [b]sert à[/b] ».[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Raisonner et déduire (CM2) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Raisonner et déduire', $fiche$
[titre]Vérité ou mensonge ?[/titre]
Sur une île, [b]Léa dit toujours la vérité[/b] et [b]Kim ment toujours[/b].
[cadre]Quelqu'un dit : « La porte est ouverte. » Mais la porte est [b]fermée[/b].
La phrase est [b]fausse[/b] : seul un menteur peut la dire. C'est [b]Kim[/b].[/cadre]
[cadre=astuce]Phrase [b]vraie[/b] → celui qui dit la vérité. Phrase [b]fausse[/b] → le menteur.[/cadre]
[page]
[titre]Le tableau de déduction[/titre]
[center]Manon, Léo et Emma aiment chacun une couleur différente : bleu, rouge, vert.
Manon aime le bleu. Léo n'aime pas le vert.[/center]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]bleu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]rouge[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]vert[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Manon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Emma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[page]
[titre]Je complète le tableau[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]bleu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]rouge[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]vert[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Manon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Emma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][/table]
[cadre]1. Manon a le bleu : personne d'autre ne l'a.
2. Léo n'a ni le bleu ni le vert : il a forcément [b]le rouge[/b].
3. Il ne reste que le vert : c'est [b]Emma[/b] qui aime le vert.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Vérité/mensonge : je regarde si la phrase est [b]vraie ou fausse[/b] dans la réalité.
• Pour répartir des choses, je fais un [b]tableau[/b] avec ✓ et ✗.
• Un ✓ dans une case → des ✗ dans le reste de sa ligne et de sa colonne.
• Quand il ne reste qu'une case possible, c'est la réponse.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les codes secrets (CM2) - logique, notion 'codes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les codes secrets', $fiche$
[titre]Le code par décalage[/titre]
Avec un [b]décalage de +3[/b], chaque lettre est remplacée par celle qui est [b]3 places plus loin[/b].
[table=13][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]A[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]B[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]C[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]D[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]E[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]F[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]G[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]H[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]I[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]J[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]K[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]L[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]M[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]D[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]E[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]F[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]G[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]H[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]I[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]J[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]K[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]L[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]M[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]N[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]O[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]P[/font_size][/b][/center][/cell][/table]
[table=13][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]N[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]O[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]P[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Q[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]R[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]S[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]T[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]U[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]V[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]W[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]X[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Y[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size=20]Z[/font_size][/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]Q[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]R[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]S[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]T[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]U[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]V[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]W[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]X[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]Y[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]Z[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]A[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]B[/font_size][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size=20]C[/font_size][/b][/center][/cell][/table]
[center]A devient D, B devient E, C devient F…[/center]
[page]
[titre]Coder un mot[/titre]
[center][font_size=24][b]LAC avec +3[/b][/font_size][/center]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]L[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]A[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]C[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]↓ +3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]↓ +3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]↓ +3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]O[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]D[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]F[/font_size][/center][/cell][/table]
[cadre]Je code [b]chaque lettre[/b], l'une après l'autre : L → M, N, [b]O[/b]. LAC devient [b]ODF[/b].[/cadre]
[page]
[titre]Éviter les pièges[/titre]
[cadre]• Je garde [b]l'ordre des lettres[/b] : FDO est le bon code à l'envers, donc faux !
• J'avance du [b]bon nombre[/b] de places : +2 et +3 donnent des codes différents.
• Après Z, on recommence à A : avec +3, X → A, Y → B, Z → C.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Décalage de +k : chaque lettre avance de [b]k places[/b] dans l'alphabet.
• Je code les lettres [b]une par une[/b], dans l'ordre.
• Pour décoder, je [b]recule[/b] du même nombre de places.
• Après Z, je repars à A.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'codes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les grilles à compléter (CM2) - logique, notion 'grilles'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les grilles à compléter', $fiche$
[titre]Regarder les lignes[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]3[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]11[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]4[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]12[/b][/font_size][/center][/cell][/table]
[cadre]1re ligne : 2, 6, 10 → [b]+4[/b] à chaque case. 3e ligne : 4, 8, 12 → [b]+4[/b] aussi.
La 2e ligne suit la même règle : 3 + 4 = [b]7[/b], et 7 + 4 = 11 ✓.[/cadre]
[page]
[titre]Vérifier avec les colonnes[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]3[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=30][b][color=white]7[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]11[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]4[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]12[/b][/font_size][/center][/cell][/table]
[cadre]Colonne du milieu : 6, [b]7[/b], 8 → +1 à chaque case. ✓
Les lignes et les colonnes sont d'accord : la réponse est [b]7[/b].[/cadre]
[page]
[titre]Un autre exemple[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]5[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]9[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]13[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]16[/b][/font_size][/center][/cell][/table]
[cadre]Lignes : [b]+3[/b] (2, 5, 8). Colonnes : [b]+4[/b] (2, 6, 10).
Ligne : 9 + 3 = 12. Colonne : 8 + 4 = 12. La réponse est [b]12[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je cherche la règle d'une [b]ligne complète[/b] (+3, +4…).
• Je l'applique à la ligne de la case vide.
• Je vérifie avec la [b]colonne[/b] : les deux calculs doivent donner le même nombre.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'grilles'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
