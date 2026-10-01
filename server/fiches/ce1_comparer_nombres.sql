-- Fiche Comparer des nombres (CE1) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Comparer des nombres', $fiche$
[titre]Des nombres à 3 chiffres[/titre]
Au CE1, on compare des nombres jusqu'à 999. Chaque chiffre a sa place :
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
[cadre]Dans [b]306[/b] : 3 centaines, 0 dizaine et 6 unités.[/cadre]
[page]
[titre]Le nombre de chiffres d'abord[/titre]
Compare [b]99[/b] et [b]104[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
99 n'a pas de centaine. 104 a une centaine.
[cadre]Un nombre à [b]3 chiffres[/b] est toujours plus grand qu'un nombre à 2 chiffres : [b]104 > 99[/b].[/cadre]
[page]
[titre]Je compare les centaines[/titre]
Compare [b]524[/b] et [b]996[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
524 a 5 centaines, 996 a 9 centaines.
[cadre]9 centaines, c'est plus que 5 centaines : [b]996 est plus grand que 524[/b].
Inutile de regarder les autres chiffres ![/cadre]
[page]
[titre]Mêmes centaines : les dizaines[/titre]
Compare [b]136[/b] et [b]163[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][/table]
Les centaines sont les mêmes : 1 et 1. Je regarde les dizaines : 3 et 6.
[cadre]6 dizaines, c'est plus que 3 dizaines : [b]163 est plus grand que 136[/b].[/cadre]
[page]
[titre]Mêmes centaines et mêmes dizaines[/titre]
Compare [b]345[/b] et [b]348[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
Centaines : 3 et 3. Dizaines : 4 et 4. Il reste les unités : 5 et 8.
[cadre][b]348 est plus grand que 345[/b] : 348 > 345.[/cadre]
[page]
[titre]Ranger des nombres[/titre]
Ranger dans l'[b]ordre croissant[/b], c'est du plus petit au plus grand :
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]136[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]163[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]300[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]524[/b][/cell][/table]
Ranger dans l'[b]ordre décroissant[/b], c'est du plus grand au plus petit :
[table=4][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]524[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]300[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]163[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]136[/b][/cell][/table]
[cadre=astuce]Rappel : la pointe des signes < et > montre toujours le plus petit nombre. 136 < 163.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus de chiffres = plus grand : 104 > 99.
• Je compare d'abord les [b]centaines[/b], puis les [b]dizaines[/b], puis les [b]unités[/b].
• Dès qu'un chiffre est plus grand, j'ai trouvé : inutile de regarder la suite.
• Ordre croissant : du plus petit au plus grand. Ordre décroissant : l'inverse.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
