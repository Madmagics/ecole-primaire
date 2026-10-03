-- Fiche Se repérer dans l'espace (CE2) - logique, notion 'reperage_espace'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Se repérer dans l''espace', $fiche$
[titre]Les 9 cases de la grille[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en haut à droite[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au milieu à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]au milieu à droite[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas à gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas au centre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,10,8,10][center][font_size=16][b]en bas à droite[/b][/font_size][/center][/cell][/table]
[cadre]Je dis d'abord la [b]ligne[/b] (en haut, au milieu, en bas), puis la [b]colonne[/b] (à gauche, au centre, à droite).
La case du milieu s'appelle simplement [b]au centre[/b].[/cadre]
[page]
[titre]Déplacer vers le bas[/titre]
[center]Un objet est [b]en haut à droite[/b]. On le déplace de [b]2 cases vers le bas[/b].[/center]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]↓[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=26][b][color=white]●[/color][/b][/font_size][/center][/cell][/table]
[cadre]Il descend dans [b]la même colonne[/b] : en haut → au milieu → en bas.
Il arrive [b]en bas à droite[/b].[/cadre]
[page]
[titre]Déplacer vers la gauche[/titre]
[center]Un objet est [b]au milieu à droite[/b]. On le déplace de [b]1 case vers la gauche[/b].[/center]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=26][b][color=white]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b]● ←[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=26][b][color=#00000000]●[/color][/b][/font_size][/center][/cell][/table]
[cadre]Il reste sur [b]la même ligne[/b] et recule d'une case : il arrive [b]au centre[/b].[/cadre]
[cadre=astuce]La [b]gauche[/b], c'est le côté où l'on commence à lire une ligne.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je pose mon doigt sur la case de départ.
2. Je compte les cases [b]une par une[/b] dans la bonne direction.
3. Haut ou bas : je change de [b]ligne[/b]. Gauche ou droite : je change de [b]colonne[/b].
4. Je dis la nouvelle position : la ligne, puis la colonne.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une position = une [b]ligne[/b] + une [b]colonne[/b] : « en bas à gauche ».
• La case du milieu, c'est [b]au centre[/b].
• Vers le haut ou le bas : je reste dans la même colonne.
• Vers la gauche ou la droite : je reste sur la même ligne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'reperage_espace'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
