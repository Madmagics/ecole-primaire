-- Fiche Le volume (CM2) - notion 'volume'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Le volume', $fiche$
[titre]Qu'est-ce que le volume ?[/titre]
Le [b]volume[/b], c'est la [b]place occupée[/b] par un objet. Je peux le mesurer en comptant des petits cubes.
[pave long=4 larg=3 haut=2]
[cadre]Ce pavé est fait de [b]24 petits cubes[/b].[/cadre]
[page]
[titre]Le centimètre cube[/titre]
Un cube de [b]1 cm d'arête[/b] a un volume de [b]1 centimètre cube[/b] : [b]1 cm³[/b] (ou cm3).
[pave long=4 larg=3 haut=2 unite=cm]
[cadre]Chaque petit cube fait 1 cm³ : le volume du pavé est de [b]24 cm³[/b].[/cadre]
[page]
[titre]Compter par couches[/titre]
Une couche du pavé : 4 cubes de long, 3 de large : 4 x 3 = [b]12 cubes[/b]. Il y a 2 couches : 12 x 2 = [b]24[/b].
[center][font_size=26][b]Volume = longueur x largeur x hauteur[/b][/font_size][/center]
[cadre]4 x 3 x 2 = [b]24 cm³[/b].[/cadre]
[page]
[titre]Un exemple[/titre]
Un pavé droit de [b]11 cm[/b] de long, [b]7 cm[/b] de large et [b]2 cm[/b] de haut :
[cadre]11 x 7 = 77, puis 77 x 2 = [b]154 cm³[/b].[/cadre]
[cadre=astuce]Je choisis l'ordre le plus facile : 14 x 5 x 10 → 14 x 5 = 70, puis 70 x 10 = [b]700 cm³[/b].[/cadre]
[page]
[titre]Le cube[/titre]
Un cube a ses 3 dimensions égales : [b]Volume = arête x arête x arête[/b].
[pave long=3 larg=3 haut=3 unite=cm]
[cadre]3 x 3 x 3 = [b]27 cm³[/b]. Un cube de 5 cm d'arête : 5 x 5 x 5 = [b]125 cm³[/b].[/cadre]
[page]
[titre]Volume et litres[/titre]
Un cube de [b]10 cm d'arête[/b] (1 dm) a un volume de 10 x 10 x 10 = [b]1000 cm³[/b].
[cadre]Il contient exactement [b]1 litre[/b] d'eau : 1 L = 1 dm³ = [b]1000 cm³[/b].
Une brique de lait de 1 L a donc un volume d'environ 1000 cm³.[/cadre]
[page]
[titre]Longueur, aire ou volume ?[/titre]
[table=3][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Je mesure[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Unité[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Exemple[/b][/color][/center][/cell][cell border=#classe padding=14,6,14,6][center]une longueur[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]le tour d'un cahier[/center][/cell][cell border=#classe padding=14,6,14,6][center]une aire[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm²[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]la couverture du cahier[/center][/cell][cell border=#classe padding=14,6,14,6][center]un volume[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm³[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]une boîte à chaussures[/center][/cell][/table]
[cadre=astuce]cm : 1 dimension. cm² : 2 dimensions (longueur x largeur). cm³ : 3 dimensions.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le volume est la place occupée par un objet.
• 1 cm³ = le volume d'un cube de 1 cm d'arête.
• Pavé droit : longueur x largeur x hauteur. Cube : arête x arête x arête.
• Je multiplie dans l'ordre le plus facile.
• 1 L = 1 dm³ = 1000 cm³.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'volume'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
