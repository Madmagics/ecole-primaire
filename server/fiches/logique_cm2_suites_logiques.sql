-- Fiche Les suites logiques (CM2) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les suites logiques', $fiche$
[titre]La somme des deux précédents[/titre]
[table=11][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]2[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]6[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]8[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]14[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]22[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+4[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites][/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les écarts ne suivent pas de règle simple. Je regarde autrement :
2 + 6 = [b]8[/b], 6 + 8 = [b]14[/b], 8 + 14 = [b]22[/b]. Chaque nombre est la [b]somme des deux d'avant[/b].
14 + 22 = [b]36[/b].[/cadre]
[page]
[titre]Multiplier puis ajouter[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]4[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]13[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]31[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]67[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=24][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 2 + 5[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]Les nombres font un peu plus que [b]doubler[/b]. Je teste x 2 : 4 x 2 = 8, et il reste [b]5[/b] pour arriver à 13.
Je vérifie : 13 x 2 + 5 = 31 ✓, 31 x 2 + 5 = 67 ✓. Donc 67 x 2 + 5 = [b]139[/b].[/cadre]
[page]
[titre]Une règle cachée : x 3 + 3[/titre]
[center][font_size=28][b]1, 6, 21, 66, …[/b][/font_size][/center]
[cadre]Ça grandit d'environ [b]3 fois[/b] : je teste x 3.
1 x 3 = 3 → il manque 3 pour faire 6. 6 x 3 = 18 → il manque 3 pour 21. La règle : [b]x 3 + 3[/b].
66 x 3 + 3 = [b]201[/b].[/cadre]
[cadre=astuce]Je divise un nombre par le précédent (66 ÷ 21 ≈ 3) pour deviner le « x ».[/cadre]
[page]
[titre]Deux suites mélangées[/titre]
[center][font_size=28][b]4, 22, 6, 21, 8, …[/b][/font_size][/center]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]1re, 3e, 5e place[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]4[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]6[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]8[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]2e, 4e, 6e place[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]22[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]21[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[cadre]Un nombre sur deux forme une suite : 4, 6, 8 (+2) et 22, 21 (-1).
La 6e place continue la 2e suite : 21 - 1 = [b]20[/b].[/cadre]
[page]
[titre]Ma méthode, dans l'ordre[/titre]
[cadre]1. J'écris les écarts : sont-ils pareils ou alternés ?
2. Les nombres sautent (petit, grand, petit…) ? → [b]deux suites mélangées[/b].
3. Chaque nombre = les deux précédents additionnés ?
4. Ça grandit très vite ? → je teste [b]x 2[/b] ou [b]x 3[/b], puis je regarde ce qu'il faut ajouter.
5. Je vérifie la règle sur [b]tous[/b] les nombres.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Somme des deux précédents : 2, 6, 8, 14, 22, 36…
• Règle « [b]x k + c[/b] » : je devine le x en comparant deux nombres, puis je trouve ce qu'il faut ajouter.
• Deux suites mélangées : je regarde [b]un nombre sur deux[/b].
• Une règle n'est bonne que si elle marche pour [b]toute[/b] la suite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
