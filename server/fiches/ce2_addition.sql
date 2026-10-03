-- Fiche L'addition (CE2) - notion 'addition'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'L''addition', $fiche$
[titre]Les nombres jusqu'à 9999[/titre]
Au CE2, les nombres ont jusqu'à [b]4 chiffres[/b]. Dix centaines font [b]un millier[/b] : 1000.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
[cadre]Dans [b]3452[/b] : 3 milliers, 4 centaines, 5 dizaines et 2 unités.
3452 = 3000 + 400 + 50 + 2.[/cadre]
[page]
[titre]Ajouter des centaines ou des milliers[/titre]
Ces calculs se font de tête, sans poser l'opération :
[table=2][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][b]4568 + 300 = 4868[/b][/cell][cell border=#centaines padding=14,6,14,6]le chiffre des [b]centaines[/b] passe de 5 à 8[/cell][cell bg=#milliers_clair border=#milliers padding=14,6,14,6][b]4568 + 2000 = 6568[/b][/cell][cell border=#milliers padding=14,6,14,6]le chiffre des [b]milliers[/b] passe de 4 à 6[/cell][/table]
[cadre]Les autres chiffres ne bougent pas.[/cadre]
[page]
[titre]Poser une addition[/titre]
Je range [b]les unités sous les unités[/b], les dizaines sous les dizaines, et ainsi de suite.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]526 n'a que 3 chiffres : je l'aligne [b]à droite[/b], sous les unités. Sa case des milliers reste vide.[/cadre]
[page]
[titre]La retenue[/titre]
Je commence toujours par [b]les unités[/b], à droite.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]8[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][/table]
Unités : 3 + 8 = [b]11[/b]. J'écris 1 et je [b]retiens 1[/b] en haut des dizaines.
[cadre]Dizaines : 1 + 5 + 3 = 9. Centaines : 2 + 6 = 8. Milliers : 1. [b]1253 + 638 = 1891[/b][/cadre]
[page]
[titre]Plusieurs retenues[/titre]
Quand une colonne fait 10 ou plus, je retiens 1 dans la colonne suivante, [b]à chaque fois[/b].
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
Unités : 8 + 7 = 15, j'écris 5. Dizaines : 1 + 6 + 3 = [b]10[/b], j'écris [b]0[/b].
Centaines : 1 + 8 + 5 = 14, j'écris 4. Milliers : 1 + 4 = 5.
[cadre][b]4868 + 537 = 5405[/b][/cadre]
[page]
[titre]Vérifier avec un calcul approché[/titre]
Avant de valider, je regarde si mon résultat est possible.
[b]4868 + 537[/b], c'est à peu près [b]4900 + 500 = 5400[/b].
[cadre]Je trouve 5405 : c'est tout près de 5400, mon résultat est possible.
Si j'avais trouvé 4305 ou 9238, je saurais qu'il y a une erreur.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 3452 = 3 milliers, 4 centaines, 5 dizaines et 2 unités.
• Ajouter 300 : le chiffre des centaines change. Ajouter 2000 : le chiffre des milliers change.
• Pour poser : j'aligne les nombres [b]à droite[/b], unités sous les unités.
• Je commence toujours par la colonne des [b]unités[/b].
• Si une colonne fait 10 ou plus, j'écris le chiffre des unités et je [b]retiens 1[/b].
• Je vérifie avec un calcul approché.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'addition'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
