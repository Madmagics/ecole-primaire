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
select fn_publier();
