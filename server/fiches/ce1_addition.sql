-- Fiche L'addition (CE1) - notion 'addition'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'L''addition', $fiche$
[titre]Les nombres jusqu'à 999[/titre]
Au CE1, les nombres ont jusqu'à [b]3 chiffres[/b]. Dix dizaines font [b]une centaine[/b] : 100.
[cubes c=2 d=4 u=5]
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
[cadre]Dans [b]245[/b] : 2 centaines, 4 dizaines et 5 unités. 245 = 200 + 40 + 5.[/cadre]
[page]
[titre]Ajouter des dizaines ou des centaines[/titre]
Quand j'ajoute des dizaines, seul le chiffre des dizaines change. Pareil pour les centaines.
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]245 + 30 = 275[/b][/cell][cell border=#classe padding=14,6,14,6]le chiffre des [b]dizaines[/b] passe de 4 à 7[/cell][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][b]245 + 100 = 345[/b][/cell][cell border=#centaines padding=14,6,14,6]le chiffre des [b]centaines[/b] passe de 2 à 3[/cell][/table]
[cadre=astuce]Ces calculs se font de tête, sans poser l'opération.[/cadre]
[page]
[titre]Poser une addition[/titre]
Pour les grands nombres, je pose l'addition en colonnes.
Je range [b]les unités sous les unités[/b], les dizaines sous les dizaines, les centaines sous les centaines.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
[cadre]Attention : 70 n'a que 2 chiffres. Son 0 va dans la colonne des unités, son 7 dans les dizaines.[/cadre]
[page]
[titre]Calculer colonne par colonne[/titre]
Pour [b]324 + 152[/b], je commence toujours par [b]la colonne des unités[/b], à droite.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
Unités : 4 + 2 = [b]6[/b]. Dizaines : 2 + 5 = [b]7[/b]. Centaines : 3 + 1 = [b]4[/b].
[cadre][b]324 + 152 = 476[/b][/cadre]
[page]
[titre]La retenue[/titre]
Pour [b]47 + 38[/b] : dans les unités, 7 + 8 = [b]15[/b]. C'est trop pour une seule case !
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
15 = 1 dizaine et 5 unités. J'écris [b]5[/b] en bas et je [b]retiens 1[/b] en haut des dizaines.
[cadre]Dizaines : la retenue 1 + 4 + 3 = [b]8[/b]. Donc [b]47 + 38 = 85[/b].[/cadre]
[page]
[titre]Une retenue dans les dizaines[/titre]
Pour [b]165 + 172[/b] : unités, 5 + 2 = 7. Dizaines, 6 + 7 = [b]13[/b] dizaines.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
13 dizaines = 1 centaine et 3 dizaines : j'écris 3 et je retiens 1 en haut des centaines.
[cadre]Centaines : 1 + 1 + 1 = [b]3[/b]. Donc [b]165 + 172 = 337[/b].[/cadre]
[page]
[titre]Vérifier avec un calcul approché[/titre]
Avant de valider, je regarde si mon résultat est possible.
[b]165 + 172[/b], c'est à peu près [b]170 + 170 = 340[/b].
[cadre]Je trouve 337 : c'est tout près de 340, mon résultat est possible.
Si j'avais trouvé 237 ou 3307, je saurais qu'il y a une erreur.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 245 = 2 centaines, 4 dizaines et 5 unités.
• Ajouter 30 : le chiffre des dizaines change. Ajouter 100 : le chiffre des centaines change.
• Pour poser : unités sous les unités, dizaines sous les dizaines.
• Je commence toujours par la colonne des [b]unités[/b].
• Si une colonne fait 10 ou plus, j'écris les unités et je [b]retiens 1[/b] dans la colonne suivante.
• Je vérifie avec un calcul approché.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'addition'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
