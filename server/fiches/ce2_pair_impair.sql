-- Fiche Pair et impair (CE2) - notion 'pair_impair'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Pair et impair', $fiche$
[titre]Pair et impair, rappel[/titre]
Un nombre est [b]pair[/b] si je peux faire des paires sans qu'il reste rien.
[paires n=7]
[cadre]Avec 7, il reste un objet tout seul : 7 est [b]impair[/b].[/cadre]
[page]
[titre]Le chiffre des unités[/titre]
Pour savoir si un nombre est pair, je regarde [b]seulement son dernier chiffre[/b] : les unités.
[table=2][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Pair[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Impair[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]finit par 0, 2, 4, 6, 8[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]finit par 1, 3, 5, 7, 9[/center][/cell][/table]
[page]
[titre]Avec les grands nombres[/titre]
[cadre]• 902[b]8[/b] finit par 8 : il est [b]pair[/b].
• 488[b]3[/b] finit par 3 : il est [b]impair[/b].
• 106[b]5[/b] finit par 5 : il est [b]impair[/b].[/cadre]
[cadre=astuce]Les autres chiffres ne comptent pas : 9028 et 1118 sont pairs tous les deux.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Pair : je peux faire des paires sans reste.
• Pour un grand nombre, je regarde seulement le [b]chiffre des unités[/b].
• 0, 2, 4, 6, 8 : pair. 1, 3, 5, 7, 9 : impair.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pair_impair'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
