-- Fiches Maths CP (2026-09-30) : les 10 fiches d'un coup (addition a formes geometriques).
-- Relancer ce script remplace le contenu des fiches.
begin;

-- Fiche L'addition (CP) - contenu_cours id 1. Relancer ce script remplace le contenu de la fiche.
update contenu_cours set contenu = $fiche$
[titre]Additionner, c'est quoi ?[/titre]
Additionner, c'est [b]mettre ensemble[/b] pour savoir combien on a [b]en tout[/b].
Léo a 3 billes. Sa sœur lui en donne 2. Combien Léo a-t-il de billes maintenant ?
[billes groupes=3,2 couleurs=bleu,rouge total=oui]
On compte tout : 1, 2, 3… 4, 5.
[cadre]Léo a [b]5 billes[/b] en tout.[/cadre]
[page]
[titre]Les signes + et =[/titre]
Pour écrire une addition, on utilise deux signes :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]+[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « plus » : on ajoute[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]=[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « égale » : voici le résultat[/center][/cell][/table]
[center][font_size=34][b]3 + 2 = 5[/b][/font_size][/center]
[center]« trois plus deux égale cinq »[/center]
[cadre]Le résultat d'une addition s'appelle [b]la somme[/b].[/cadre]
[page]
[titre]Compter en avançant[/titre]
Pour calculer [b]4 + 3[/b], je pars de 4 et j'avance de 3 pas.
[file de=0 a=10 bonds=4:7]
4 → 5, 6, 7
[cadre][b]4 + 3 = 7[/b]
Je peux m'aider de mes doigts ou d'une file de nombres.[/cadre]
[page]
[titre]Ajouter zéro[/titre]
Zéro, c'est « rien ». Si j'ajoute zéro, le nombre ne change pas.
J'ai 6 billes, on m'en donne 0 : j'ai toujours 6 billes.
[billes groupes=6,0 couleurs=bleu,rouge total=oui]
[cadre][b]6 + 0 = 6[/b][/cadre]
[page]
[titre]L'ordre ne change rien[/titre]
[billes groupes=2,7 couleurs=rouge,bleu total=oui]
[billes groupes=7,2 couleurs=bleu,rouge total=oui]
[center][b]2 + 7 = 9[/b]      et      [b]7 + 2 = 9[/b][/center]
[cadre=astuce]Je pars toujours du [b]plus grand nombre[/b], c'est plus rapide.
Pour 2 + 7, je pars de 7 et j'avance de 2 : 8, 9.[/cadre]
[page]
[titre]Les paires qui font 10[/titre]
Il faut connaître par cœur les nombres qui font 10 ensemble.
[cases n=10 bleu=3]
3 cases bleues et 7 cases jaunes : [b]3 + 7 = 10[/b]
[table=5][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]1 + 9[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]2 + 8[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]3 + 7[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]4 + 6[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]5 + 5[/b][/cell][/table]
[cadre]Et dans l'autre sens aussi : 9 + 1, 8 + 2, 7 + 3, 6 + 4.[/cadre]
[page]
[titre]La dizaine et les unités[/titre]
Quand on a 10 objets, on fait [b]un paquet de 10[/b] : c'est [b]une dizaine[/b].
Les objets qui restent tout seuls s'appellent [b]les unités[/b].
[cubes d=1 u=5]
[table=2][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]dizaines[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]unités[/b][/color][/cell][cell border=#classe padding=18,4,18,4][center][font_size=34][b]1[/b][/font_size][/center][/cell][cell border=#unites padding=18,4,18,4][center][font_size=34][b]5[/b][/font_size][/center][/cell][/table]
[cadre]Dans [b]15[/b] : le [b]1[/b] est le chiffre des [b]dizaines[/b], le [b]5[/b] est le chiffre des [b]unités[/b].
[b]15 = 10 + 5[/b][/cadre]
[page]
[titre]Ajouter 10[/titre]
Ajouter 10, c'est ajouter [b]un paquet de 10[/b] de plus.
[cubes d=1 u=8 vers=2:8]
[center][font_size=30][b]18 + 10 = 28[/b][/font_size][/center]
[cadre]Le chiffre des [b]dizaines augmente de 1[/b] : le 1 devient 2.
Le chiffre des [b]unités ne bouge pas[/b] : le 8 reste 8.[/cadre]
[page]
[titre]Additionner deux grands nombres[/titre]
Pour [b]13 + 11[/b], je range les nombres dans le tableau :
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
Les dizaines ensemble : 10 + 10 = [b]20[/b]. Les unités ensemble : 3 + 1 = [b]4[/b].
[cadre]Je rassemble : 20 + 4 = [b]24[/b]. Donc [b]13 + 11 = 24[/b].[/cadre]
[page]
[titre]Passer la dizaine[/titre]
Pour [b]8 + 5[/b], je complète d'abord jusqu'à 10.
[file de=0 a=15 bonds=8:10,10:13]
8 + [b]2[/b] = 10, puis il reste 3 à ajouter : 10 + [b]3[/b] = [b]13[/b].
[cadre=astuce]Pareil avec [b]19 + 7[/b] : 19 + 1 = 20, puis 20 + 6 = [b]26[/b].
Pour faire 7, j'ai coupé en 1 et 6.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Additionner, c'est mettre ensemble. Le résultat s'appelle [b]la somme[/b].
• Je pars du [b]plus grand nombre[/b] et j'avance.
• [b]+ 0[/b] ne change rien.
• Les paires qui font 10 : 1 + 9, 2 + 8, 3 + 7, 4 + 6, 5 + 5.
• Dans [b]15[/b] : 1 dizaine et 5 unités.
• [b]+ 10[/b] : le chiffre des dizaines augmente de 1.
• Pour dépasser 10 : je complète d'abord jusqu'à 10.[/cadre]
$fiche$, statut = 'publie', modifie_le = now() where id = 1 returning id, titre, statut;

-- Fiche La soustraction (CP) - notion 'soustraction'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'La soustraction', $fiche$
[titre]Soustraire, c'est quoi ?[/titre]
Soustraire, c'est [b]enlever[/b] pour savoir combien il [b]reste[/b].
Léo a 5 billes. Il en perd 2. Combien de billes reste-t-il à Léo ?
[billes groupes=5 couleurs=bleu barrees=2 total=oui]
J'enlève les 2 billes perdues, puis je compte celles qui restent : 1, 2, 3.
[cadre]Il reste [b]3 billes[/b] à Léo.[/cadre]
[page]
[titre]Les signes - et =[/titre]
Pour écrire une soustraction, on utilise deux signes :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]-[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « moins » : on enlève[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]=[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « égale » : voici le résultat[/center][/cell][/table]
[center][font_size=34][b]5 - 2 = 3[/b][/font_size][/center]
[center]« cinq moins deux égale trois »[/center]
[cadre]Le résultat d'une soustraction s'appelle [b]la différence[/b].[/cadre]
[page]
[titre]Compter en reculant[/titre]
Pour calculer [b]7 - 3[/b], je pars de 7 et je recule de 3 pas.
[file de=0 a=10 bonds=7:4]
7 → 6, 5, 4
[cadre][b]7 - 3 = 4[/b]
Avec mes doigts : j'en lève 7, puis j'en baisse 3. Il en reste 4 levés.[/cadre]
[page]
[titre]Enlever zéro, enlever tout[/titre]
J'ai 6 billes et je n'en enlève aucune : j'ai toujours 6 billes.
J'ai 6 billes et je les enlève toutes : il ne reste rien.
[billes groupes=6 couleurs=bleu barrees=6 total=oui]
[cadre]• Enlever 0 ne change rien : [b]6 - 0 = 6[/b]
• Si j'enlève tout, il reste [b]zéro[/b] : [b]6 - 6 = 0[/b][/cadre]
[page]
[titre]Le plus grand nombre d'abord[/titre]
Dans une soustraction, on écrit toujours [b]le plus grand nombre en premier[/b].
[center][font_size=34][b]8 - 3 = 5[/b][/font_size][/center]
On ne peut pas calculer 3 - 8 : on ne peut pas enlever 8 billes quand on n'en a que 3 !
[cadre=astuce]Dans l'addition, l'ordre ne change rien.
Dans la soustraction, [b]l'ordre compte[/b] : le grand nombre, puis le petit.[/cadre]
[page]
[titre]Enlever à partir de 10[/titre]
Les paires qui font 10 m'aident aussi pour enlever.
[cases n=10 bleu=10 barrees=3]
10 cases, j'en barre 3 : il en reste 7. [b]10 - 3 = 7[/b], car 7 + 3 = 10.
[table=5][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 - 1 = 9[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 - 2 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 - 3 = 7[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 - 4 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 - 5 = 5[/b][/cell][/table]
[cadre]Et aussi : 10 - 9 = 1, 10 - 8 = 2, 10 - 7 = 3, 10 - 6 = 4.[/cadre]
[page]
[titre]Chercher l'écart[/titre]
Quand les deux nombres sont [b]proches[/b], c'est plus rapide d'avancer.
Pour [b]19 - 17[/b], je pars de 17 et j'avance jusqu'à 19.
[file de=14 a=20 bonds=17:19]
17 → 18, 19 : j'ai fait 2 pas.
[cadre][b]19 - 17 = 2[/b] : entre 17 et 19, il y a un écart de 2.[/cadre]
[page]
[titre]Vérifier avec une addition[/titre]
La soustraction et l'addition vont ensemble.
Si j'enlève 4 billes à 9 billes, il en reste 5 : [b]9 - 4 = 5[/b].
Si je remets les 4 billes, je retrouve mes 9 billes :
[billes groupes=5,4 couleurs=bleu,rouge total=oui]
[cadre=astuce]Pour vérifier, j'ajoute ce que j'ai enlevé : je dois retrouver le nombre du départ.
[b]9 - 4 = 5[/b], car [b]5 + 4 = 9[/b].[/cadre]
[page]
[titre]Enlever 10[/titre]
Rappel : dans [b]28[/b], il y a 2 dizaines et 8 unités.
Enlever 10, c'est enlever [b]un paquet de 10[/b].
[cubes d=2 u=8 vers=1:8]
[center][font_size=30][b]28 - 10 = 18[/b][/font_size][/center]
[cadre]Le chiffre des [b]dizaines diminue de 1[/b] : le 2 devient 1.
Le chiffre des [b]unités ne bouge pas[/b] : le 8 reste 8.[/cadre]
[page]
[titre]Passer la dizaine en reculant[/titre]
Pour [b]13 - 5[/b], je recule d'abord jusqu'à 10.
[file de=5 a=15 bonds=13:10,10:8]
13 - [b]3[/b] = 10, puis il reste 2 à enlever : 10 - [b]2[/b] = [b]8[/b].
[cadre=astuce]Pareil avec [b]32 - 6[/b] : 32 - 2 = 30, puis 30 - 4 = [b]26[/b].
Pour faire 6, j'ai coupé en 2 et 4.[/cadre]
[page]
[titre]Soustraire deux grands nombres[/titre]
Pour [b]47 - 21[/b], je range les nombres dans le tableau :
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
Les dizaines : 40 - 20 = [b]20[/b]. Les unités : 7 - 1 = [b]6[/b]. Donc [b]47 - 21 = 26[/b].
[cadre=astuce]Pour [b]32 - 14[/b], il n'y a pas assez d'unités (2 - 4, impossible).
J'enlève en deux fois : d'abord la dizaine, 32 - 10 = 22, puis 22 - 4 = [b]18[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Soustraire, c'est enlever. Le résultat s'appelle [b]la différence[/b].
• Le [b]plus grand nombre[/b] s'écrit en premier. Je pars de lui et je recule.
• Nombres proches : j'avance du petit jusqu'au grand.
• Enlever 0 ne change rien. Si j'enlève tout, il reste [b]0[/b].
• [b]10 - 3 = 7[/b], car 7 + 3 = 10.
• Enlever 10 : le chiffre des [b]dizaines diminue de 1[/b].
• Pour passer 10 : je recule d'abord jusqu'à 10.
• Je vérifie avec une addition.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'soustraction'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Compléments et nombres manquants (CP) - notion 'complements'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Compléments et nombres manquants', $fiche$
[titre]Le nombre qui manque[/titre]
Parfois, dans un calcul, un nombre est [b]caché[/b]. On écrit un trou : [b]___[/b]
[center][font_size=34][b]3 + ___ = 5[/b][/font_size][/center]
J'ai 3 cases bleues. Combien faut-il de cases en plus pour en avoir 5 ?
[cases n=5 bleu=3]
[cadre]Il manque [b]2[/b] cases jaunes. Donc [b]3 + 2 = 5[/b].[/cadre]
[page]
[titre]Compléter en avançant[/titre]
Combien faut-il ajouter à [b]8[/b] pour obtenir [b]11[/b] ?
Je pars de 8 et j'avance jusqu'à 11 en comptant mes pas.
[file de=5 a=13 bonds=8:11]
8 → 9, 10, 11 : j'ai fait 3 pas.
[cadre]Il faut ajouter [b]3[/b] : [b]8 + 3 = 11[/b].[/cadre]
[page]
[titre]Les compléments à 10[/titre]
Pour aller jusqu'à 10, les paires qui font 10 donnent la réponse tout de suite.
[cases n=10 bleu=6]
6 cases bleues : il manque 4 cases pour aller jusqu'à 10. [b]6 + 4 = 10[/b]
[table=5][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]1 + 9[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]2 + 8[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]3 + 7[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]4 + 6[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]5 + 5[/b][/cell][/table]
[cadre]Si je connais ces paires par cœur, je trouve le nombre qui manque sans compter.[/cadre]
[page]
[titre]Aller jusqu'à la dizaine suivante[/titre]
Combien faut-il ajouter à [b]27[/b] pour obtenir [b]30[/b] ?
[file de=24 a=32 bonds=27:30]
Je regarde les unités : 7 + [b]3[/b] = 10. Donc 27 + [b]3[/b] = 30.
[cadre=astuce]Les paires qui font 10 marchent aussi avec les grands nombres :
34 + [b]6[/b] = 40, car 4 + 6 = 10.[/cadre]
[page]
[titre]Les mêmes dizaines[/titre]
Pour [b]44 + ___ = 48[/b], je regarde les deux nombres.
[cubes d=4 u=4 vers=4:8]
Les dizaines ne changent pas : 4 et 4. Seules les unités changent : de 4 à 8.
[cadre]Il manque [b]4[/b] unités : [b]44 + 4 = 48[/b].
Pareil pour 20 + ___ = 24 : il manque [b]4[/b].[/cadre]
[page]
[titre]Faire un grand bond[/titre]
Pour [b]9 + ___ = 30[/b], j'avance en deux fois.
[file de=8 a=30 bonds=9:10,10:30]
D'abord de 9 à 10 : [b]+1[/b]. Puis de 10 à 30 : [b]+20[/b].
[cadre]En tout, j'ai ajouté 1 + 20 = [b]21[/b]. Donc [b]9 + 21 = 30[/b].[/cadre]
[page]
[titre]Le trou au début[/titre]
Le nombre qui manque peut être [b]au début[/b] :
[center][font_size=34][b]___ + 3 = 8[/b][/font_size][/center]
Dans une addition, l'ordre ne change rien. C'est donc pareil que [b]3 + ___ = 8[/b].
[file de=0 a=10 bonds=3:8]
[cadre]De 3 à 8, il y a 5 pas. Il manque [b]5[/b] : [b]5 + 3 = 8[/b].[/cadre]
[page]
[titre]Trouver avec une soustraction[/titre]
Pour [b]23 + ___ = 45[/b], je calcule [b]45 - 23[/b] avec le tableau :
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
Les dizaines : 4 - 2 = 2. Les unités : 5 - 3 = 2. Il manque [b]22[/b].
[cadre=astuce]Je vérifie : [b]23 + 22 = 45[/b]. C'est juste ![/cadre]
[page]
[titre]Combien ai-je enlevé ?[/titre]
Pour [b]15 - ___ = 5[/b] : j'avais 15 billes, il m'en reste 5.
[billes groupes=15 couleurs=bleu barrees=10 total=oui]
Pour passer de 15 billes à 5 billes, j'en ai barré 10.
[cadre]J'ai enlevé [b]10[/b] : [b]15 - 10 = 5[/b].
Je peux aussi avancer de 5 jusqu'à 15 : l'écart est de 10.[/cadre]
[page]
[titre]Le nombre du départ[/titre]
Pour [b]___ - 4 = 16[/b] : j'ai enlevé 4, et il me reste 16. Combien avais-je au départ ?
Je remets ce que j'ai enlevé : je pars de 16 et j'avance de 4.
[file de=13 a=22 bonds=16:20]
[cadre]Au départ, j'avais [b]20[/b] : [b]16 + 4 = 20[/b], donc [b]20 - 4 = 16[/b].[/cadre]
[page]
[titre]Avec trois nombres[/titre]
Pour [b]___ + 10 + 4 = 34[/b], je commence par les nombres que je connais.
[center][b]10 + 4 = 14[/b][/center]
Il reste à trouver [b]___ + 14 = 34[/b].
[cubes d=1 u=4 vers=3:4]
Les unités ne changent pas. Il manque 2 dizaines : [b]20[/b].
[cadre]Je vérifie : [b]20 + 10 + 4 = 34[/b]. C'est juste ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Pour trouver le nombre qui manque, j'avance du petit nombre jusqu'au grand et je compte mes pas.
• Les paires qui font 10 : 1 + 9, 2 + 8, 3 + 7, 4 + 6, 5 + 5.
• Pour un grand bond, j'avance d'abord jusqu'à la dizaine.
• Dans une addition, le trou peut être au début : l'ordre ne change rien.
• Pour ___ - 4 = 16, je remets ce que j'ai enlevé : 16 + 4 = 20.
• Avec trois nombres, j'additionne d'abord ceux que je connais.
• Je vérifie toujours : je mets mon nombre dans le trou et je calcule.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'complements'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La numération (CP) - notion 'numeration'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'La numération', $fiche$
[titre]Les chiffres et les nombres[/titre]
Pour écrire tous les nombres, on utilise seulement [b]10 chiffres[/b] :
[table=10][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]1[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]2[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]3[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]5[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]6[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]7[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]9[/b][/cell][/table]
De 0 à 9, un seul chiffre suffit : 3, 7, 9.
À partir de 10, il faut [b]2 chiffres[/b] pour écrire le nombre : 10, 15, 47, 92.
[cadre]Un [b]chiffre[/b], c'est comme une lettre. Un [b]nombre[/b], c'est comme un mot.[/cadre]
[page]
[titre]La dizaine[/titre]
Quand j'ai [b]10 unités[/b], je les attache ensemble : ça fait [b]1 dizaine[/b].
[cubes d=0 u=10 vers=1:0 fleche==]
[center][font_size=30][b]10 unités = 1 dizaine[/b][/font_size][/center]
[cadre]Une [b]unité[/b], c'est un objet tout seul. Une [b]dizaine[/b], c'est un paquet de 10.[/cadre]
[page]
[titre]Lire un nombre[/titre]
Dans [b]34[/b], il y a [b]3 dizaines[/b] et [b]4 unités[/b].
[cubes d=3 u=4]
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
[cadre][b]34 = 30 + 4[/b] : trois paquets de 10 carrés, et encore 4 carrés tout seuls.[/cadre]
[page]
[titre]Le chiffre des dizaines, le chiffre des unités[/titre]
Dans un nombre à 2 chiffres, chaque chiffre a sa place :
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
Dans [b]92[/b] : le [b]9[/b] est le chiffre des [b]dizaines[/b], le [b]2[/b] est le chiffre des [b]unités[/b].
[cadre=astuce]Le chiffre de [b]gauche[/b] compte les dizaines. Le chiffre de [b]droite[/b] compte les unités.
Dans [b]7[/b], il y a 0 dizaine et 7 unités.[/cadre]
[page]
[titre]Des dizaines et des unités au nombre[/titre]
Combien font [b]5 dizaines et 9 unités[/b] ?
[cubes d=5 u=9]
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]J'écris les dizaines, puis les unités : [b]59[/b].
5 dizaines = 50, et 50 + 9 = [b]59[/b].[/cadre]
[page]
[titre]Le zéro dans un nombre[/titre]
Dans [b]40[/b], il y a 4 dizaines et [b]aucune unité[/b].
[cubes d=4 u=0]
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
[cadre]Le [b]0[/b] garde la place des unités. Sans lui, on lirait 4 au lieu de 40 ![/cadre]
[page]
[titre]Compter de 10 en 10[/titre]
Les dizaines ont chacune leur nom :
[table=3][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10[/b] dix[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]20[/b] vingt[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]30[/b] trente[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]40[/b] quarante[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]50[/b] cinquante[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]60[/b] soixante[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]70[/b] soixante-dix[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]80[/b] quatre-vingts[/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]90[/b] quatre-vingt-dix[/cell][/table]
[cadre]À chaque fois, j'ajoute [b]une dizaine[/b] : le chiffre des dizaines augmente de 1.[/cadre]
[page]
[titre]Le nombre juste après[/titre]
Le nombre [b]juste après[/b], c'est le nombre suivant quand je compte : j'ajoute 1.
[file de=20 a=30 bonds=25:26]
[cadre]Juste après [b]25[/b], il y a [b]26[/b] : 25 + 1 = 26.[/cadre]
[cadre=astuce]Attention au passage de la dizaine : juste après [b]39[/b], il y a [b]40[/b].[/cadre]
[page]
[titre]Le nombre juste avant[/titre]
Le nombre [b]juste avant[/b], c'est le nombre d'avant quand je compte : j'enlève 1.
[file de=30 a=40 bonds=37:36]
[cadre]Juste avant [b]37[/b], il y a [b]36[/b] : 37 - 1 = 36.[/cadre]
[cadre=astuce]Attention au passage de la dizaine : juste avant [b]50[/b], il y a [b]49[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• On écrit tous les nombres avec 10 chiffres : de 0 à 9.
• [b]10 unités = 1 dizaine[/b].
• Dans [b]34[/b] : 3 dizaines et 4 unités. 34 = 30 + 4.
• Le chiffre de gauche : les dizaines. Le chiffre de droite : les unités.
• Le [b]0[/b] garde la place quand il n'y a pas d'unité : 40.
• Juste après : [b]+ 1[/b]. Juste avant : [b]- 1[/b].
• Attention : après 39 vient 40, avant 50 vient 49.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'numeration'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Comparer des nombres (CP) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Comparer des nombres', $fiche$
[titre]Plus grand, plus petit[/titre]
Comparer, c'est chercher quel nombre est le [b]plus grand[/b] ou le [b]plus petit[/b].
Tom a 3 billes. Lina a 7 billes.
[billes groupes=3 couleurs=bleu]
[billes groupes=7 couleurs=rouge]
[cadre]7 billes, c'est plus que 3 billes : [b]7 est plus grand que 3[/b].
3 est [b]plus petit[/b] que 7.[/cadre]
[page]
[titre]Sur la file des nombres[/titre]
Sur la file des nombres, plus on va vers la [b]droite[/b], plus les nombres sont [b]grands[/b].
[file de=0 a=10 points=4,9]
[b]9[/b] est plus loin à droite que [b]4[/b].
[cadre][b]9 est plus grand que 4[/b]. Quand je compte, 9 vient après 4.[/cadre]
[page]
[titre]1 chiffre ou 2 chiffres ?[/titre]
Compare [b]9[/b] et [b]12[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b][/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
9 n'a pas de dizaine. 12 a une dizaine.
[cadre]Un nombre à [b]2 chiffres[/b] est toujours plus grand qu'un nombre à [b]1 chiffre[/b].
[b]12 est plus grand que 9[/b].[/cadre]
[page]
[titre]Je regarde d'abord les dizaines[/titre]
Compare [b]69[/b] et [b]76[/b].
[cubes d=6 u=9]
[cubes d=7 u=6]
[cadre]69 a 6 dizaines, 76 a 7 dizaines. 7 dizaines, c'est plus que 6 dizaines.
[b]76 est plus grand que 69[/b], même si 9 unités, c'est plus que 6 unités.[/cadre]
[page]
[titre]Mêmes dizaines : je regarde les unités[/titre]
Compare [b]23[/b] et [b]28[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
Les dizaines sont les mêmes : 2 et 2. Je regarde alors les unités : 3 et 8.
[cadre]8 unités, c'est plus que 3 unités. [b]28 est plus grand que 23[/b].[/cadre]
[page]
[titre]Attention aux chiffres échangés[/titre]
[b]46[/b] et [b]64[/b] ont les mêmes chiffres, mais pas à la même place !
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
46 : 4 dizaines. 64 : 6 dizaines.
[cadre][b]64 est plus grand que 46[/b]. Ce qui compte, c'est la place du chiffre.[/cadre]
[page]
[titre]Les signes < et >[/titre]
Pour écrire une comparaison, on utilise deux signes :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]>[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « est plus grand que »[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][font_size=34][b]<[/b][/font_size][/center][/cell][cell border=#classe padding=14,15,14,6][center]se lit « est plus petit que »[/center][/cell][/table]
[center][font_size=34][b]7 > 3        3 < 7[/b][/font_size][/center]
[cadre=astuce]La pointe du signe montre toujours le [b]plus petit[/b] nombre.
Le côté ouvert est tourné vers le [b]plus grand[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Sur la file des nombres, plus c'est à droite, plus c'est grand.
• Un nombre à 2 chiffres est plus grand qu'un nombre à 1 chiffre.
• Je compare d'abord les [b]dizaines[/b] : le plus de dizaines gagne.
• Si les dizaines sont les mêmes, je compare les [b]unités[/b].
• 46 et 64 : mêmes chiffres, mais 64 est plus grand.
• [b]>[/b] : est plus grand que. [b]<[/b] : est plus petit que.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Les suites de nombres (CP) - notion 'suites_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Les suites de nombres', $fiche$
[titre]Une suite, c'est quoi ?[/titre]
Une suite, ce sont des nombres rangés en suivant [b]une règle[/b].
[center][font_size=30][b]1, 2, 3, 4, 5[/b][/font_size][/center]
[file de=0 a=6 bonds=1:2,2:3,3:4,4:5]
[cadre]Ici, la règle est : [b]+1[/b]. À chaque fois, on ajoute 1.[/cadre]
[page]
[titre]Trouver la règle[/titre]
Pour trouver la règle, je regarde [b]deux nombres qui se suivent[/b].
[center][font_size=30][b]4, 6, 8, 10[/b][/font_size][/center]
[file de=3 a=11 bonds=4:6,6:8,8:10]
De 4 à 6, j'avance de 2. De 6 à 8, encore 2.
[cadre]La règle est : [b]+2[/b]. On compte de 2 en 2.[/cadre]
[page]
[titre]Trouver le nombre qui manque[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]10[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]12[/b][/cell][/table]
1. Je trouve la règle avec deux nombres côte à côte : de 8 à 10, [b]+2[/b].
2. J'applique la règle après le nombre qui est juste avant le trou : 4 + 2 = [b]6[/b].
[cadre]Il manque [b]6[/b] : 4, 6, 8, 10, 12.
Je vérifie : 6 + 2 = 8. C'est juste ![/cadre]
[page]
[titre]Compter de 2 en 2[/titre]
En partant de 0 :
[table=7][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]2[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]6[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]10[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]12[/b][/cell][/table]
En partant de 1 :
[table=7][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]1[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]3[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]5[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]7[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]9[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]11[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]13[/b][/cell][/table]
[cadre=astuce]Le chiffre des unités revient toujours de la même façon :
0, 2, 4, 6, 8 ou bien 1, 3, 5, 7, 9.[/cadre]
[page]
[titre]Compter de 5 en 5[/titre]
[table=7][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]5[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]10[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]15[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]20[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]25[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]30[/b][/cell][/table]
En partant de 7 :
[table=5][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]7[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]12[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]17[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]22[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]27[/b][/cell][/table]
[cadre=astuce]De 5 en 5, les unités font toujours le même va-et-vient :
0, 5, 0, 5… ou bien 7, 2, 7, 2…[/cadre]
[page]
[titre]Compter de 10 en 10[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]3[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]13[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]23[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]33[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]43[/b][/cell][/table]
[cubes d=1 u=3 vers=2:3]
[cadre]De 10 en 10, [b]seul le chiffre des dizaines change[/b] : il augmente de 1.
Le chiffre des unités ne bouge pas : 3, 13, 23, 33, 43.[/cadre]
[page]
[titre]Le trou au début[/titre]
[table=5][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]7[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]9[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]11[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]13[/b][/cell][/table]
La règle est [b]+2[/b]. Pour trouver le premier nombre, je fais le chemin à l'envers : je [b]recule[/b] de 2.
[file de=3 a=10 bonds=7:5]
[cadre]7 - 2 = [b]5[/b]. La suite est : 5, 7, 9, 11, 13.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une suite suit toujours la même règle.
• Pour trouver la règle, je regarde l'écart entre deux nombres qui se suivent.
• Pour le trou, j'applique la règle après le nombre d'avant.
• Si le trou est au début, je recule.
• De 2 en 2 : 0, 2, 4, 6, 8… De 5 en 5 : 0, 5, 10, 15…
• De 10 en 10 : seul le chiffre des dizaines change.
• Je vérifie toujours avec la règle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Pair et impair (CP) - notion 'pair_impair'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Pair et impair', $fiche$
[titre]Un nombre pair[/titre]
Je range mes billes [b]par 2[/b], comme des copains qui se donnent la main.
J'ai 6 billes :
[paires n=6]
[cadre]Chaque bille a un copain : il n'en reste aucune toute seule.
[b]6 est un nombre pair[/b].[/cadre]
[page]
[titre]Un nombre impair[/titre]
J'ai 7 billes. Je les range par 2 :
[paires n=7]
[cadre]Une bille reste [b]toute seule[/b], sans copain.
[b]7 est un nombre impair[/b].[/cadre]
[page]
[titre]Les nombres pairs et impairs[/titre]
[table=6][cell bg=#classe border=#classe padding=12,6,12,6][b]pairs[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]2[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]6[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#unites border=#unites padding=12,6,12,6][b]impairs[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]1[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]3[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]5[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]7[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]9[/b][/cell][/table]
Sur la file des nombres, pair et impair [b]se suivent chacun leur tour[/b] :
[file de=0 a=10 points=0,2,4,6,8,10]
[cadre]0 est pair. 1 est impair, 2 est pair, 3 est impair…[/cadre]
[page]
[titre]Et les grands nombres ?[/titre]
Pour savoir si un grand nombre est pair, je regarde [b]seulement le chiffre des unités[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
Dans 74, les unités, c'est 4 : pair. Dans 59, les unités, c'est 9 : impair.
[cadre][b]74 est pair[/b], car 4 est pair.
[b]59 est impair[/b], car 9 est impair.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Pair[/b] : je range par 2, il ne reste aucune bille seule.
• [b]Impair[/b] : il reste une bille toute seule.
• Les chiffres pairs : 0, 2, 4, 6, 8.
• Les chiffres impairs : 1, 3, 5, 7, 9.
• Pour un grand nombre, je regarde le [b]chiffre des unités[/b] : 74 est pair, 59 est impair.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pair_impair'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Doubles et moitiés (CP) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Doubles et moitiés', $fiche$
[titre]Le double[/titre]
Le [b]double[/b] d'un nombre, c'est ce nombre [b]deux fois[/b].
Le double de 4, c'est 4 + 4 :
[billes groupes=4,4 couleurs=bleu,bleu total=oui]
[cadre]Le double de 4, c'est [b]8[/b].[/cadre]
[page]
[titre]Les doubles à connaître[/titre]
Il faut connaître ces doubles par cœur :
[table=5][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]1 + 1 = 2[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]2 + 2 = 4[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]3 + 3 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]4 + 4 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]5 + 5 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]6 + 6 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]7 + 7 = 14[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]8 + 8 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]9 + 9 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 + 10 = 20[/b][/cell][/table]
[cadre=astuce]Les doubles sont toujours des nombres [b]pairs[/b].[/cadre]
[page]
[titre]Le double d'une dizaine[/titre]
Le double de [b]40[/b] : 4 dizaines et encore 4 dizaines.
[cubes d=4 u=0 vers=8:0 fleche=double]
[cadre]4 dizaines + 4 dizaines = 8 dizaines.
Le double de 40, c'est [b]80[/b], comme le double de 4, c'est 8.[/cadre]
[page]
[titre]Le double d'un grand nombre[/titre]
Pour le double de [b]13[/b], je fais le double des dizaines et le double des unités.
[cubes d=1 u=3 vers=2:6 fleche=double]
Double de 10 = [b]20[/b]. Double de 3 = [b]6[/b].
[cadre]20 + 6 = [b]26[/b]. Le double de 13, c'est 26.[/cadre]
[page]
[titre]La moitié[/titre]
Prendre la [b]moitié[/b], c'est partager en [b]2 parts égales[/b].
J'ai 8 billes. Je les partage avec mon copain, pareil pour chacun :
[billes groupes=4,4 couleurs=bleu,rouge]
[cadre]Chacun a 4 billes. La moitié de 8, c'est [b]4[/b].[/cadre]
[page]
[titre]Double et moitié vont ensemble[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 4, c'est 8.[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 8, c'est 4.[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 7, c'est 14.[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 14, c'est 7.[/b][/cell][/table]
[cadre=astuce]Pour trouver une moitié, je cherche quel nombre a ce [b]double[/b].
La moitié de 10 ? Le double de 5 fait 10, donc c'est [b]5[/b].[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]26[/b], je partage les dizaines et je partage les unités.
[cubes d=2 u=6 vers=1:3 fleche=moitié]
Moitié de 20 = [b]10[/b]. Moitié de 6 = [b]3[/b]. Donc la moitié de 26, c'est [b]13[/b].
[cadre=astuce]Pour la moitié de [b]34[/b], je coupe 34 en 20 et 14 :
moitié de 20 = 10, moitié de 14 = 7, et 10 + 7 = [b]17[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]double[/b] : le nombre deux fois. Double de 4 = 4 + 4 = 8.
• La [b]moitié[/b] : partager en 2 parts égales. Moitié de 8 = 4.
• Double et moitié vont ensemble : double de 7 = 14, moitié de 14 = 7.
• Pour un grand nombre, je m'occupe des dizaines puis des unités.
• Double de 13 = 20 + 6 = 26. Moitié de 26 = 10 + 3 = 13.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Petits problèmes (CP) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Petits problèmes', $fiche$
[titre]Lire un problème[/titre]
Un problème, c'est une petite histoire avec des nombres et [b]une question[/b].
[cadre]Mia a 5 crayons. Elle en reçoit 7 de plus.
[b]Combien Mia a-t-elle de crayons maintenant ?[/b][/cadre]
1. Je lis l'histoire [b]deux fois[/b].
2. Je trouve [b]la question[/b] : elle finit par « ? ».
3. Je cherche [b]les nombres[/b] : 5 et 7.
4. Je choisis [b]+ ou -[/b] : « elle en reçoit », elle en a plus. J'ajoute.
5. Je [b]calcule[/b] : 5 + 7 = 12.
6. Je [b]réponds par une phrase[/b] : Mia a 12 crayons.
[page]
[titre]Plus ou moins ?[/titre]
Des mots de l'histoire me disent s'il faut ajouter ou enlever :
[table=2][cell bg=#classe border=#classe padding=14,6,14,6][b]+  J'ajoute[/b][/cell][cell bg=#unites border=#unites padding=14,6,14,6][b]-  J'enlève[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6]reçoit, gagne, achète, trouve, [b]de plus[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]donne, perd, mange, casse, [b]il reste[/b][/cell][/table]
[cadre=astuce]Je me demande : à la fin, est-ce qu'il y en a [b]plus[/b] ou [b]moins[/b] qu'au début ?[/cadre]
[page]
[titre]Un problème avec +[/titre]
Alice a 5 ballons. Elle en reçoit 7 de plus. Combien Alice a-t-elle de ballons maintenant ?
« Elle en [b]reçoit[/b] » : elle en a plus qu'avant. J'ajoute.
[billes groupes=5,7 couleurs=bleu,rouge total=oui]
[center][font_size=30][b]5 + 7 = 12[/b][/font_size][/center]
[cadre]Je réponds par une phrase : [b]Alice a 12 ballons.[/b][/cadre]
[page]
[titre]Un problème avec -[/titre]
Iris a 11 billes. Elle en donne 3. Combien lui reste-t-il de billes ?
« Elle en [b]donne[/b] » : il lui en reste moins. J'enlève.
[billes groupes=11 couleurs=bleu barrees=3 total=oui]
[center][font_size=30][b]11 - 3 = 8[/b][/font_size][/center]
[cadre]Je réponds par une phrase : [b]Il reste 8 billes à Iris.[/b][/cadre]
[page]
[titre]Avec de plus grands nombres[/titre]
Chloé a 16 cartes. Elle en donne 12. Combien lui reste-t-il de cartes ?
Elle donne : c'est une soustraction, [b]16 - 12[/b].
Les deux nombres sont proches : j'avance de 12 jusqu'à 16.
[file de=10 a=18 bonds=12:16]
[cadre][b]16 - 12 = 4[/b]. Il reste 4 cartes à Chloé.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
Avant de répondre, je vérifie :
[cadre]• Si on [b]reçoit[/b], la réponse est [b]plus grande[/b] que le nombre du début.
• Si on [b]donne[/b], la réponse est [b]plus petite[/b] que le nombre du début.[/cadre]
Iris avait 11 billes et elle en donne 3. Si je trouve 14, c'est faux : elle ne peut pas en avoir plus qu'avant !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis l'histoire deux fois et je trouve la question.
• Je cherche les nombres.
• [b]Reçoit, gagne, de plus[/b] : j'ajoute avec +.
• [b]Donne, perd, il reste[/b] : j'enlève avec -.
• Je calcule, puis je réponds par une phrase.
• Je vérifie que ma réponse a du sens.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Les formes géométriques (CP) - notion 'formes_geometriques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Les formes géométriques', $fiche$
[titre]Les formes[/titre]
Autour de nous, on trouve des formes : une fenêtre, un panneau, une roue…
[formes liste=carre,rectangle,triangle,rond]
[cadre]Chaque forme a un [b]nom[/b]. Pour les reconnaître, je compte leurs [b]côtés[/b].[/cadre]
[page]
[titre]Côtés et sommets[/titre]
[formes liste=triangle cotes=oui]
Un [b]côté[/b], c'est un trait bien droit. Un [b]sommet[/b], c'est un coin (les points orange).
[cadre]Le triangle a [b]3 côtés[/b] et 3 sommets.[/cadre]
[cadre=astuce]Pour compter les côtés, je pose le doigt sur un sommet et je fais le tour en comptant chaque trait.[/cadre]
[page]
[titre]Le carré et le rectangle[/titre]
[formes liste=carre,rectangle cotes=oui]
Les deux ont [b]4 côtés[/b] et 4 coins bien droits.
[cadre]• Le [b]carré[/b] : ses 4 côtés ont [b]la même longueur[/b].
• Le [b]rectangle[/b] : 2 côtés longs et 2 côtés courts.[/cadre]
[page]
[titre]Le losange[/titre]
[formes liste=losange,carre cotes=oui]
Le losange a [b]4 côtés de la même longueur[/b], comme le carré.
[cadre]Mais ses coins ne sont pas droits : il a l'air penché, comme un cerf-volant.[/cadre]
[page]
[titre]Le rond[/titre]
[formes liste=rond cotes=oui]
Le rond n'a [b]aucun trait droit[/b] : son bord est tout arrondi.
[cadre]Le rond a [b]0 côté[/b] et aucun sommet. On l'appelle aussi un [b]cercle[/b].[/cadre]
[page]
[titre]Plus de côtés[/titre]
[formes liste=pentagone,hexagone cotes=oui]
[cadre]• Le [b]pentagone[/b] a [b]5 côtés[/b].
• L'[b]hexagone[/b] a [b]6 côtés[/b].[/cadre]
Je compte toujours en faisant le tour avec le doigt, pour ne pas oublier de côté.
[page]
[titre]Je retiens[/titre]
[formes liste=triangle,carre,rectangle cotes=oui]
[formes liste=losange,pentagone,rond cotes=oui]
[cadre]Pour trouver le nombre de côtés, je fais le tour de la forme en comptant les traits droits.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'formes_geometriques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

commit;
select fn_publier();
