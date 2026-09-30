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
select fn_publier();
