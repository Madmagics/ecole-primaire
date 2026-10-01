-- Fiche Compléments et nombres manquants (CE1) - notion 'complements'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Compléments et nombres manquants', $fiche$
[titre]Le nombre qui manque, rappel[/titre]
Dans [b]8 + ___ = 11[/b], je cherche ce qu'il faut ajouter à 8 pour arriver à 11.
[file de=6 a=13 bonds=8:11]
[cadre]De 8 à 11, il y a 3 pas : il manque [b]3[/b]. C'est l'[b]écart[/b] entre 8 et 11.[/cadre]
[page]
[titre]Les compléments à 100[/titre]
Les dizaines qui font 100 ensemble, comme les paires qui font 10 :
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 + 90[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]20 + 80[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]30 + 70[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]40 + 60[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]50 + 50[/b][/cell][/table]
Pour [b]65 + ___ = 100[/b] : 65 + 5 = 70, puis 70 + 30 = 100.
[cadre]Il manque 5 + 30 = [b]35[/b]. Donc 65 + 35 = 100.[/cadre]
[page]
[titre]Avancer par grands bonds[/titre]
Combien faut-il ajouter à [b]90[/b] pour obtenir [b]180[/b] ?
[file de=80 a=190 pas=10 bonds=90:100,100:180]
D'abord de 90 à 100 : [b]+10[/b]. Puis de 100 à 180 : [b]+80[/b].
[cadre]En tout, j'ai ajouté 10 + 80 = [b]90[/b]. Donc 90 + 90 = 180.[/cadre]
[page]
[titre]Compléter chiffre par chiffre[/titre]
Pour [b]104 + ___ = 289[/b], je regarde chaque colonne :
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
Unités : de 4 à 9, il faut [b]5[/b]. Dizaines : de 0 à 8, il faut [b]8[/b]. Centaines : de 1 à 2, il faut [b]1[/b].
[cadre]Il manque [b]185[/b]. Je vérifie : 104 + 185 = 289.[/cadre]
[page]
[titre]Trouver avec une soustraction[/titre]
Quand c'est difficile, le nombre qui manque dans une addition se trouve avec une [b]soustraction[/b].
[center][b]86 + ___ = 415[/b]   →   [b]415 - 86[/b][/center]
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]3[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]15[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828][s]4[/s][/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]5[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]Il manque [b]329[/b]. Je vérifie : 86 + 329 = 415.[/cadre]
[page]
[titre]Le trou au début[/titre]
Pour [b]___ + 100 = 563[/b] : l'ordre ne change rien dans une addition.
C'est pareil que [b]100 + ___ = 563[/b]. Je calcule [b]563 - 100[/b].
[cadre]563 - 100 = [b]463[/b] : seul le chiffre des centaines change.
Je vérifie : 463 + 100 = 563.[/cadre]
[page]
[titre]Le trou dans une soustraction[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]890 - ___ = 471[/b][/cell][cell border=#classe padding=14,6,14,6]Combien ai-je enlevé ? L'écart entre 890 et 471 : [b]890 - 471 = 419[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___ - 106 = 440[/b][/cell][cell border=#unites padding=14,6,14,6]Combien avais-je au départ ? Je remets ce que j'ai enlevé : [b]440 + 106 = 546[/b][/cell][/table]
[cadre=astuce]Je remets toujours mon nombre dans le trou pour vérifier : 890 - 419 = 471 ; 546 - 106 = 440.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le nombre qui manque, c'est l'[b]écart[/b] entre deux nombres.
• Les compléments à 100 : 10 + 90, 20 + 80, 30 + 70, 40 + 60, 50 + 50.
• Pour un grand bond, j'avance d'abord jusqu'à la dizaine ou la centaine.
• Dans une addition, je peux trouver le trou avec une soustraction : 86 + ___ = 415 → 415 - 86.
• Pour ___ - 106 = 440, je remets ce que j'ai enlevé : 440 + 106.
• Je vérifie toujours en remettant le nombre dans le trou.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'complements'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
