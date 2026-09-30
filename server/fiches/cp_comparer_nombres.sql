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
select fn_publier();
