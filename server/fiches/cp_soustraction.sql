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
select fn_publier();
