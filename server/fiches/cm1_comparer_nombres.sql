-- Fiche Comparer des nombres décimaux (CM1) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Comparer des nombres décimaux', $fiche$
[titre]D'abord la partie entière[/titre]
Pour comparer deux nombres décimaux, je regarde d'abord [b]ce qui est avant la virgule[/b].
[center][font_size=30][b]20,87 > 15,06[/b][/font_size][/center]
[cadre]20 est plus grand que 15, donc [b]20,87 > 15,06[/b]. Pas besoin de regarder après la virgule.[/cadre]
[page]
[titre]Même partie entière[/titre]
Je compare chiffre par chiffre après la virgule : [b]les dixièmes d'abord[/b], puis les centièmes.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
[cadre]Unités : 8 et 8, égales. Dixièmes : [b]6 < 7[/b]. Donc [b]8,64 < 8,78[/b].[/cadre]
[page]
[titre]Attention au piège ![/titre]
Qui est le plus grand : [b]8,5[/b] ou [b]8,47[/b] ? Le nombre le plus long n'est pas forcément le plus grand.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]J'ajoute un 0 : 8,5 = 8,50. Dixièmes : [b]5 > 4[/b]. Donc [b]8,5 > 8,47[/b].[/cadre]
[cadre=astuce]Avec des euros : 8,50 euros, c'est plus que 8,47 euros ![/cadre]
[page]
[titre]Les zéros utiles et inutiles[/titre]
[cadre]• Un 0 [b]tout à la fin[/b] de la partie décimale ne change rien : 6,20 = [b]6,2[/b] et 15,10 = [b]15,1[/b].
• Un 0 [b]juste après la virgule[/b] compte : 6,02 n'est pas 6,2 ![/cadre]
[droite de=6 a=7 parts=10 points=2 noms=decimal]
[cadre=astuce]6,2 = 6 unités et 2 dixièmes. 6,02 = 6 unités et 2 centièmes : c'est bien plus petit.[/cadre]
[page]
[titre]Sur une droite graduée[/titre]
Entre 0 et 1, je compte de dixième en dixième. [b]Plus un nombre est à droite, plus il est grand[/b].
[droite de=0 a=1 parts=10 points=3,7 noms=decimal]
[cadre]0,3 est à gauche de 0,7 : [b]0,3 < 0,7[/b].[/cadre]
[page]
[titre]Ranger des nombres décimaux[/titre]
Ranger du plus petit au plus grand : 1,43 · 1,22 · 1,4 · 1,3
[cadre]Même partie entière : 1. J'écris tout avec 2 chiffres après la virgule :
1,43 · 1,22 · 1,40 · 1,30. Je compare les dixièmes, puis les centièmes.
[b]1,22 < 1,3 < 1,4 < 1,43[/b][/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je compare d'abord [b]la partie entière[/b] : 20,87 > 15,06.
• Si elle est égale : les [b]dixièmes[/b], puis les [b]centièmes[/b].
• Le plus long n'est pas toujours le plus grand : 8,5 > 8,47.
• J'ajoute des 0 à la fin pour avoir autant de chiffres : 8,5 = 8,50.
• 6,2 = 6,20 mais 6,2 ≠ 6,02.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
