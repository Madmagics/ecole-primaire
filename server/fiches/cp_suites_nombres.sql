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
select fn_publier();
