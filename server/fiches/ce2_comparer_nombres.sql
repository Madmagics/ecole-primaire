-- Fiche Comparer des nombres (CE2) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Comparer des nombres', $fiche$
[titre]Compter les chiffres[/titre]
Pour comparer deux nombres, je regarde d'abord [b]combien ils ont de chiffres[/b].
[center][font_size=30][b]1013[/b] > [b]987[/b][/font_size][/center]
[cadre]1013 a 4 chiffres, 987 n'en a que 3 : [b]le nombre qui a le plus de chiffres est le plus grand[/b].[/cadre]
[page]
[titre]Le même nombre de chiffres[/titre]
Je compare chiffre par chiffre, [b]en commençant par la gauche[/b] : les milliers d'abord.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]Milliers : 7 est plus grand que 6. Donc [b]7931 > 6129[/b]. Pas besoin de regarder la suite.[/cadre]
[page]
[titre]Les premiers chiffres sont égaux[/titre]
Si les milliers sont égaux, je regarde les centaines. Si elles sont égales aussi, les dizaines…
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
[cadre]Milliers : 5 et 5, égaux. Centaines : 3 et 3, égales. Dizaines : [b]3 > 0[/b].
Donc [b]5338 > 5308[/b].[/cadre]
[page]
[titre]Les signes < et >[/titre]
[center][font_size=30][b]4567 < 5049[/b]          [b]9966 > 4695[/b][/font_size][/center]
[cadre]• [b]<[/b] se lit « est plus petit que ».
• [b]>[/b] se lit « est plus grand que ».[/cadre]
[cadre=astuce]La pointe du signe montre toujours le [b]plus petit[/b] nombre.[/cadre]
[page]
[titre]Ranger des nombres[/titre]
Ranger du plus petit au plus grand : 3691 · 2194 · 3611 · 2987
[cadre]Je compare d'abord les milliers : les 2 avant les 3.
2194 < 2987, puis 3611 < 3691 (centaines égales, dizaines 1 < 9).
[b]2194 < 2987 < 3611 < 3691[/b][/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le nombre qui a le plus de chiffres est le plus grand : 1013 > 987.
• Même nombre de chiffres : je compare [b]de gauche à droite[/b], les milliers d'abord.
• Si deux chiffres sont égaux, je passe au chiffre suivant.
• < : plus petit que. > : plus grand que. La pointe montre le plus petit.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
