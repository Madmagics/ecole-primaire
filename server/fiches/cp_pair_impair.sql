-- Fiche Pair et impair (CP) - notion 'pair_impair'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Pair et impair', $fiche$
[titre]Un nombre pair[/titre]
Je range mes billes [b]par 2[/b], comme des copains qui se donnent la main.
J'ai 6 billes :
[paires n=6]
[cadre]Chaque bille a un copain : il n'en reste aucune toute seule.
[b]6 est un nombre pair[/b].[/cadre]
[page]
[titre]Un nombre impair[/titre]
J'ai 7 billes. Je les range par 2 :
[paires n=7]
[cadre]Une bille reste [b]toute seule[/b], sans copain.
[b]7 est un nombre impair[/b].[/cadre]
[page]
[titre]Les nombres pairs et impairs[/titre]
[table=6][cell bg=#classe border=#classe padding=12,6,12,6][b]pairs[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]2[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]4[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]6[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]8[/b][/cell][cell bg=#unites border=#unites padding=12,6,12,6][b]impairs[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]1[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]3[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]5[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]7[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]9[/b][/cell][/table]
Sur la file des nombres, pair et impair [b]se suivent chacun leur tour[/b] :
[file de=0 a=10 points=0,2,4,6,8,10]
[cadre]0 est pair. 1 est impair, 2 est pair, 3 est impair…[/cadre]
[page]
[titre]Et les grands nombres ?[/titre]
Pour savoir si un grand nombre est pair, je regarde [b]seulement le chiffre des unités[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][color=white][b]D[/b][/color][/cell][cell bg=#unites border=#unites padding=18,4,18,4][color=white][b]U[/b][/color][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
Dans 74, les unités, c'est 4 : pair. Dans 59, les unités, c'est 9 : impair.
[cadre][b]74 est pair[/b], car 4 est pair.
[b]59 est impair[/b], car 9 est impair.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Pair[/b] : je range par 2, il ne reste aucune bille seule.
• [b]Impair[/b] : il reste une bille toute seule.
• Les chiffres pairs : 0, 2, 4, 6, 8.
• Les chiffres impairs : 1, 3, 5, 7, 9.
• Pour un grand nombre, je regarde le [b]chiffre des unités[/b] : 74 est pair, 59 est impair.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pair_impair'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
