-- Fiche Pair et impair (CE1) - notion 'pair_impair'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Pair et impair', $fiche$
[titre]Pair, impair : rappel[/titre]
Je range les objets [b]par 2[/b].
[paires n=8]
[cadre]Tous ont un copain : [b]8 est pair[/b].[/cadre]
[paires n=9]
[cadre]Il en reste un tout seul : [b]9 est impair[/b].[/cadre]
[page]
[titre]Pair, c'est partager en deux[/titre]
Un nombre pair se partage en [b]2 parts égales[/b], sans reste.
[billes groupes=6,6 couleurs=bleu,rouge signes=non]
[cadre]12 billes : 6 pour moi et 6 pour toi. [b]12 est pair[/b].
13 billes : 6 et 6, et il en reste une. 13 est impair.[/cadre]
[page]
[titre]Le chiffre des unités décide[/titre]
Pour savoir si un nombre est pair, je regarde [b]seulement le chiffre des unités[/b] :
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]pairs[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]2[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]6[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][b]impairs[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]1[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]3[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]5[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]7[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]9[/b][/cell][/table]
[cadre]Même pour un très grand nombre, seul le dernier chiffre compte.[/cadre]
[page]
[titre]Avec des nombres à 3 chiffres[/titre]
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
957 finit par 7 : [b]impair[/b]. 340 finit par 0 : [b]pair[/b]. 12 finit par 2 : [b]pair[/b].
[cadre=astuce]Peu importe les centaines et les dizaines : 900 ou 50 ne changent rien.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Pair[/b] : je peux ranger par 2, ou partager en 2 parts égales, sans reste.
• [b]Impair[/b] : il en reste un tout seul.
• Je regarde seulement le [b]chiffre des unités[/b].
• Pairs : 0, 2, 4, 6, 8. Impairs : 1, 3, 5, 7, 9.
• 957 est impair, 340 est pair.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pair_impair'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
