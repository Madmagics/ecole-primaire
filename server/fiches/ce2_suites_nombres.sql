-- Fiche Suites de nombres (CE2) - notion 'suites_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Suites de nombres', $fiche$
[titre]Trouver la règle[/titre]
Dans une suite, on avance toujours [b]du même bond[/b]. Je regarde quel chiffre change.
[center][font_size=30][b]1348, 1448, 1548, 1648[/b][/font_size][/center]
[cadre]Seul le chiffre des [b]centaines[/b] change : 3, 4, 5, 6. On avance de [b]100[/b] en 100.[/cadre]
[page]
[titre]Des bonds de 100[/titre]
[file de=1300 a=1800 pas=100 bonds=1400:1500,1500:1600,1600:1700]
[cadre]1400, 1500, [b]1600[/b], 1700 : à chaque bond, j'ajoute 100.[/cadre]
[page]
[titre]Des bonds de 1000[/titre]
[center][font_size=30][b]2923, 3923, 4923, 5923[/b][/font_size][/center]
[cadre]Seul le chiffre des [b]milliers[/b] change : 2, 3, 4, 5. On avance de [b]1000[/b] en 1000.[/cadre]
[page]
[titre]Attention au passage[/titre]
[center][font_size=30][b]1854, 1954, 2054, 2154[/b][/font_size][/center]
Après 1954, j'ajoute 100 : 9 centaines + 1 centaine = [b]10 centaines[/b], c'est [b]1 millier[/b] !
[cadre]Le chiffre des centaines repasse à 0 et celui des milliers avance : 1954 + 100 = [b]2054[/b].[/cadre]
[page]
[titre]Le nombre qui manque[/titre]
Pour [b]726, ___, 2726, 3726[/b] : de 2726 à 3726, on avance de 1000.
[cadre]Avant 2726, il y a 2726 - 1000 = [b]1726[/b]. Et 726 + 1000 = 1726 : ça marche ![/cadre]
[cadre=astuce]Je trouve le bond avec deux nombres qui se suivent, puis je vérifie avec les autres.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Dans une suite, on avance toujours du même bond.
• Si seul le chiffre des centaines change : bonds de [b]100[/b].
• Si seul le chiffre des milliers change : bonds de [b]1000[/b].
• Attention au passage : 1954 + 100 = 2054.
• Je vérifie le bond avec tous les nombres de la suite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
