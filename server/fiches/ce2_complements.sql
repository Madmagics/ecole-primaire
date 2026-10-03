-- Fiche Le nombre qui manque (CE2) - notion 'complements'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Le nombre qui manque', $fiche$
[titre]Le nombre qui manque, rappel[/titre]
Dans [b]1977 + ___ = 2657[/b], je cherche ce qu'il faut ajouter à 1977 pour arriver à 2657.
J'avance par [b]grands bonds[/b], en passant par un nombre rond :
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]1977 → 2000[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]2000 → 2657[/center][/cell][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][center][b]En tout[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center][b]+ 23[/b][/center][/cell][cell border=#unites padding=14,6,14,6][center][b]+ 657[/b][/center][/cell][cell border=#centaines padding=14,6,14,6][center][b]23 + 657 = 680[/b][/center][/cell][/table]
[cadre]Il manque [b]680[/b]. Je vérifie : 1977 + 680 = 2657.[/cadre]
[page]
[titre]Le trou dans une addition[/titre]
Avec des grands nombres, le nombre qui manque se trouve avec une [b]soustraction[/b].
[center][font_size=26][b]3227 + ___ = 4015[/b]   →   [b]4015 - 3227[/b][/font_size][/center]
Je pose ou je calcule 4015 - 3227 avec la méthode de ma classe.
[cadre]Il manque [b]788[/b]. Je vérifie : 3227 + 788 = 4015.[/cadre]
[page]
[titre]Le trou au début de l'addition[/titre]
Pour [b]___ + 2637 = 4025[/b] : l'ordre ne change rien dans une addition.
C'est pareil que [b]2637 + ___ = 4025[/b]. Je calcule donc [b]4025 - 2637[/b].
[cadre]4025 - 2637 = [b]1388[/b]. Je vérifie : 1388 + 2637 = 4025.[/cadre]
[page]
[titre]Le trou au début de la soustraction[/titre]
Pour [b]___ - 1804 = 642[/b] : j'avais un nombre, j'ai enlevé 1804, il m'en reste 642.
Pour retrouver le nombre du départ, je [b]remets ce que j'ai enlevé[/b] : 642 + 1804.
[cadre]642 + 1804 = [b]2446[/b]. Je vérifie : 2446 - 1804 = 642.[/cadre]
[page]
[titre]Le trou au milieu de la soustraction[/titre]
Pour [b]5421 - ___ = 374[/b] : j'avais 5421, il m'en reste 374. Combien ai-je enlevé ?
J'ai enlevé [b]l'écart[/b] entre 5421 et 374 : je calcule [b]5421 - 374[/b].
[cadre]5421 - 374 = [b]5047[/b]. Je vérifie : 5421 - 5047 = 374.[/cadre]
[page]
[titre]Les 4 cas[/titre]
[table=2][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Je lis[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Je calcule[/b][/color][/center][/cell][cell border=#classe padding=14,6,14,6][center]3227 + ___ = 4015[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]4015 - 3227[/center][/cell][cell border=#classe padding=14,6,14,6][center]___ + 2637 = 4025[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]4025 - 2637[/center][/cell][cell border=#classe padding=14,6,14,6][center]___ - 1804 = 642[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]642 + 1804[/center][/cell][cell border=#classe padding=14,6,14,6][center]5421 - ___ = 374[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]5421 - 374[/center][/cell][/table]
[cadre=astuce]Je remets toujours mon nombre dans le trou pour vérifier.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le nombre qui manque, c'est l'[b]écart[/b] entre deux nombres.
• Petit écart : j'avance par bonds jusqu'à un nombre rond.
• 3227 + ___ = 4015 : je fais une [b]soustraction[/b] → 4015 - 3227.
• ___ - 1804 = 642 : je [b]remets[/b] ce que j'ai enlevé → 642 + 1804.
• 5421 - ___ = 374 : je calcule l'[b]écart[/b] → 5421 - 374.
• Je vérifie toujours en remettant le nombre dans le trou.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'complements'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
