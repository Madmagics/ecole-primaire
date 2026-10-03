-- Fiche La multiplication (CM1) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La multiplication', $fiche$
[titre]Multiplier par 10, 100, 1000[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 10 = 730[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]un 0[/b] à droite[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 100 = 7300[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]deux 0[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 1000 = 73000[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]trois 0[/b][/center][/cell][/table]
[cadre]Fois 10, chaque chiffre prend une valeur [b]10 fois plus grande[/b] : les 3 unités deviennent 3 dizaines.[/cadre]
[page]
[titre]Multiplier par 20, 30, 200…[/titre]
20, c'est 2 x 10. Pour multiplier par 20, je multiplie [b]par 2, puis par 10[/b].
[center][font_size=26][b]79 x 20 = 79 x 2 x 10[/b][/font_size][/center]
[cadre]79 x 2 = 158, puis 158 x 10 = [b]1580[/b].[/cadre]
[cadre=astuce]Pareil pour 300 : 12 x 300 = 12 x 3 x 100 = 36 x 100 = [b]3600[/b].[/cadre]
[page]
[titre]Décomposer pour calculer de tête[/titre]
[cadre]• [b]18 x 11[/b] = 18 x 10 + 18 x 1 = 180 + 18 = [b]198[/b]
• [b]19 x 9[/b] = 19 x 10 - 19 = 190 - 19 = [b]171[/b]
• [b]22 x 6[/b] = 20 x 6 + 2 x 6 = 120 + 12 = [b]132[/b][/cadre]
[cadre=astuce]Je coupe un nombre en morceaux faciles, je multiplie chaque morceau, puis j'ajoute.[/cadre]
[page]
[titre]Poser une multiplication[/titre]
Je multiplie chaque chiffre du haut par 4, [b]en commençant par les unités[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]x[/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
Unités : 3 x 4 = [b]12[/b], j'écris 2 et je retiens 1.
[cadre]Dizaines : 7 x 4 = 28, plus la retenue : 28 + 1 = [b]29[/b]. 73 x 4 = [b]292[/b].[/cadre]
[page]
[titre]Multiplier par un nombre à 2 chiffres[/titre]
Pour [b]49 x 13[/b] : 13 = 3 + 10. Je fais [b]deux lignes[/b], puis je les additionne.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][b]x[/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]1re ligne : 49 x 3 = [b]147[/b]. 2e ligne : 49 x 10 = [b]490[/b] (je commence par écrire le [color=#C62828]0[/color]).
147 + 490 = [b]637[/b].[/cadre]
[page]
[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]85 x 18[/b], j'arrondis : 90 x 20 = [b]1800[/b].
[cadre]Je trouve 1530 : c'est le même ordre de grandeur, mon résultat est possible.
Si je trouve 765, j'ai sûrement oublié le 0 de la 2e ligne ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Fois 10, 100, 1000 : j'écris un, deux ou trois 0 à droite.
• Fois 20 : fois 2, puis fois 10.
• Je décompose : 18 x 11 = 180 + 18. 19 x 9 = 190 - 19.
• Pour poser, je commence par les unités et je n'oublie pas [b]les retenues[/b].
• Par un nombre à 2 chiffres : 2 lignes, la 2e commence par un 0, puis j'additionne.
• Je vérifie avec un ordre de grandeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
