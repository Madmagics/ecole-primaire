-- Toutes les fiches Maths CE2 en une transaction (2026-10-01).
begin;
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

-- Fiche La soustraction (CE2) - notion 'soustraction'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'La soustraction', $fiche$
[titre]Soustraire, rappel[/titre]
Soustraire, c'est [b]enlever[/b] ou chercher [b]l'écart[/b]. Le résultat s'appelle [b]la différence[/b].
Enlever des centaines ou des milliers se fait de tête :
[table=2][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][b]5676 - 300 = 5376[/b][/cell][cell border=#centaines padding=14,6,14,6]le chiffre des [b]centaines[/b] passe de 6 à 3[/cell][cell bg=#milliers_clair border=#milliers padding=14,6,14,6][b]5676 - 2000 = 3676[/b][/cell][cell border=#milliers padding=14,6,14,6]le chiffre des [b]milliers[/b] passe de 5 à 3[/cell][/table]
[page]
[titre]Poser une soustraction[/titre]
J'aligne les nombres [b]à droite[/b] et je commence par [b]les unités[/b].
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][/table]
[cadre]Unités : 6 - 3 = 3. Dizaines : 7 - 4 = 3. Centaines : 6 - 1 = 5. Milliers : 5.
[b]5676 - 143 = 5533[/b][/cadre]
[page]
[titre]Pas assez dans une colonne ?[/titre]
Pour [b]4352 - 1236[/b] : dans les unités, 2 - 6, c'est impossible.
Comme au CE1, il existe [b]deux méthodes[/b] :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]Méthode 1 : le cassage[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]Méthode 2 : la compensation[/b][/center][/cell][cell border=#classe padding=14,6,14,6]je casse une dizaine du nombre du haut[/cell][cell border=#unites padding=14,6,14,6]j'ajoute 10 en haut et 1 dizaine en bas[/cell][/table]
[cadre]Les deux méthodes donnent [b]le même résultat[/b].
C'est [b]ton école[/b] qui choisit : utilise toujours [b]la méthode de ta classe[/b].[/cadre]
[page]
[titre]Méthode 1 : le cassage[/titre]
Je casse une dizaine de 4352 : le 5 des dizaines devient 4, et le 2 des unités devient 12.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]4[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]5[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]2[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
Unités : 12 - 6 = 6. Dizaines : 4 - 3 = 1. Centaines : 3 - 2 = 1. Milliers : 4 - 1 = 3.
[cadre][b]4352 - 1236 = 3116[/b][/cadre]
[page]
[titre]Méthode 2 : la compensation[/titre]
J'ajoute 10 unités en haut (2 devient 12) et 1 dizaine en bas (3 devient 4) : l'écart ne change pas.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]2[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
Unités : 12 - 6 = 6. Dizaines : 5 - (3 + 1) = 5 - 4 = 1. Centaines : 3 - 2 = 1. Milliers : 4 - 1 = 3.
[cadre][b]4352 - 1236 = 3116[/b] : le même résultat qu'avec le cassage ![/cadre]
[page]
[titre]Avec un zéro[/titre]
Pour [b]7088 - 1868[/b] : centaines, 0 - 8, impossible ! Je travaille avec [b]les milliers[/b].
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]6[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b][color=#C62828][s]7[/s][/color][/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828][s]0[/s][/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
Cassage : je casse un millier. 7 milliers 0 centaine → 6 milliers 10 centaines. 10 - 8 = 2, puis 6 - 1 = 5.
[cadre=astuce]Compensation : j'ajoute 10 centaines en haut (0 → 10) et 1 millier en bas (1 → 2).
10 - 8 = 2, puis 7 - 2 = 5. Même résultat : [b]5220[/b].[/cadre]
[page]
[titre]Plusieurs fois dans la même opération[/titre]
Pour [b]6733 - 3957[/b], il manque dans [b]chaque colonne[/b] : je recommence à chaque fois.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]5[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]16[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]13[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b][color=#C62828][s]6[/s][/color][/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828][s]7[/s][/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]3[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]3[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
Unités : 13 - 7 = 6. Dizaines : 12 - 5 = 7. Centaines : 16 - 9 = 7. Milliers : 5 - 3 = 2.
[cadre=astuce]Avec la compensation, c'est pareil : colonne après colonne, 10 en haut et 1 de plus en bas.[/cadre]
[page]
[titre]Vérifier avec une addition[/titre]
J'ajoute ce que j'ai enlevé : je dois retrouver le nombre du départ.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][/table]
[cadre]2776 + 3957 = 6733 : c'est bien le nombre du départ, ma soustraction est juste.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Soustraire, c'est enlever ou chercher l'écart. Le résultat est [b]la différence[/b].
• Pour poser : j'aligne à droite et je commence par les [b]unités[/b].
• Pas assez dans une colonne ? Le [b]cassage[/b] ou la [b]compensation[/b] : j'utilise [b]la méthode de ma classe[/b].
• Avec un 0 en haut, je passe par la colonne d'à côté : 1 millier = 10 centaines.
• Il peut manquer dans plusieurs colonnes : je recommence à chaque fois.
• Je vérifie avec une addition.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'soustraction'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La multiplication (CE2) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'La multiplication', $fiche$
[titre]Multiplier, rappel[/titre]
4 lignes de 6 cases : 6 + 6 + 6 + 6, c'est [b]4 fois 6[/b].
[grille lignes=4 colonnes=6]
[cadre][b]4 x 6 = 24[/b]. Le résultat s'appelle [b]le produit[/b].
L'ordre ne change rien : 4 x 6 = 6 x 4 = 24.[/cadre]
[page]
[titre]Les tables que je connais déjà[/titre]
[cadre]• Fois [b]1[/b] : le nombre ne change pas. 8 x 1 = 8
• Fois [b]0[/b] : le résultat est 0. 8 x 0 = 0
• Fois [b]2[/b] : c'est le double. 8 x 2 = 16
• Fois [b]5[/b] : le résultat finit par 0 ou 5. 8 x 5 = 40
• Fois [b]10[/b] : j'écris un 0 à droite. 8 x 10 = 80[/cadre]
Au CE2, j'apprends [b]toutes les tables jusqu'à 10[/b] : 3, 4, 6, 7, 8 et 9.
[page]
[titre]La table de 3[/titre]
On compte de 3 en 3 : 3, 6, 9, 12…
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 3 = 3[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 3 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 3 = 9[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 3 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 3 = 15[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 3 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 3 = 21[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 3 = 24[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 3 = 27[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 3 = 30[/b][/cell][/table]
[cadre=astuce]3 x 7, c'est 7 + 7 + 7 : le double de 7 (14), plus 7 = [b]21[/b].[/cadre]
[page]
[titre]La table de 4[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 4 = 4[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 4 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 4 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 4 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 4 = 20[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 4 = 24[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 4 = 28[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 4 = 32[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 4 = 36[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 4 = 40[/b][/cell][/table]
[cadre=astuce]Fois 4, c'est [b]le double du double[/b].
4 x 7 : le double de 7 = 14, puis le double de 14 = [b]28[/b].[/cadre]
[page]
[titre]La table de 6[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 6 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 6 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 6 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 6 = 24[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 6 = 30[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 6 = 36[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 6 = 42[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 6 = 48[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 6 = 54[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 6 = 60[/b][/cell][/table]
[cadre=astuce]Fois 6, c'est fois 5, plus une fois le nombre.
6 x 7 : 5 x 7 = 35, plus 7 = [b]42[/b].[/cadre]
[page]
[titre]La table de 7[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 7 = 7[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 7 = 14[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 7 = 21[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 7 = 28[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 7 = 35[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 7 = 42[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 7 = 49[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 7 = 56[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 7 = 63[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 7 = 70[/b][/cell][/table]
[cadre=astuce]Pour [b]7 x 8 = 56[/b], les chiffres se suivent : [b]5, 6, 7, 8[/b] → 56 = 7 x 8.
Je connais déjà beaucoup de cette table : 7 x 2, 7 x 5, 7 x 10…[/cadre]
[page]
[titre]La table de 8[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 8 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 8 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 8 = 24[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 8 = 32[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 8 = 40[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 8 = 48[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 8 = 56[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 8 = 64[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 8 = 72[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 8 = 80[/b][/cell][/table]
[cadre=astuce]Fois 8, c'est [b]le double de fois 4[/b].
8 x 6 : 4 x 6 = 24, puis le double de 24 = [b]48[/b].[/cadre]
[page]
[titre]La table de 9[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 9 = 9[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 9 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 9 = 27[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 9 = 36[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 9 = 45[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 9 = 54[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 9 = 63[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 9 = 72[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 9 = 81[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 9 = 90[/b][/cell][/table]
[cadre=astuce]Fois 9, c'est fois 10, moins une fois le nombre.
9 x 6 : 10 x 6 = 60, moins 6 = [b]54[/b]. Et 5 + 4 = 9 : ça marche jusqu'à 9 x 10 ![/cadre]
[page]
[titre]Toutes les tables[/titre]
Je cherche la ligne du premier nombre et la colonne du deuxième.
[table=11][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]x[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]1[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]2[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]3[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]4[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]5[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]6[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]7[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]8[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]9[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]10[/b][/color][/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]1[/b][/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]1[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]2[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]3[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]4[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]5[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]6[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]7[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]8[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]9[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]10[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]2[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]2[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]4[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]6[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]8[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]10[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]12[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]14[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]16[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]18[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]20[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]3[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]3[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]6[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]9[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]12[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]15[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]18[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]21[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]24[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]27[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]30[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]4[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]4[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]8[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]12[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]16[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]20[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]24[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]28[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]32[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]36[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]40[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]5[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]5[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]10[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]15[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]20[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]25[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]30[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]35[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]40[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]45[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]50[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]6[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]6[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]12[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]18[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]24[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]30[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]36[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]42[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]48[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]54[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]60[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]7[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]7[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]14[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]21[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]28[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]35[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]42[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]49[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]56[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]63[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]70[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]8[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]8[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]16[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]24[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]32[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]40[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]48[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]56[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]64[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]72[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]80[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]9[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]9[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]18[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]27[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]36[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]45[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]54[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]63[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]72[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]81[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]90[/font_size][/center][/cell][cell bg=#classe border=#classe padding=8,1,8,1][center][font_size=18][color=white][b]10[/b][/color][/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]10[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]20[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]30[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]40[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]50[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]60[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]70[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]80[/font_size][/center][/cell][cell border=#classe padding=8,1,8,1][center][font_size=18]90[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=8,1,8,1][center][font_size=18]100[/font_size][/center][/cell][/table]
[cadre=astuce]Ligne 7, colonne 8 : [b]7 x 8 = 56[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Multiplier, c'est ajouter plusieurs fois le même nombre. Le résultat est [b]le produit[/b].
• L'ordre ne change rien : 7 x 9 = 9 x 7 = 63.
• Fois 4 : le double du double. Fois 8 : le double de fois 4.
• Fois 6 : fois 5, plus le nombre. Fois 9 : fois 10, moins le nombre.
• 7 x 8 = 56 : 5, 6, 7, 8.
• Je récite mes tables souvent pour les savoir par cœur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La division (CE2) - notion 'division'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'La division', $fiche$
[titre]Partager en parts égales[/titre]
J'ai 12 billes. Je les partage [b]en 3 parts égales[/b], entre 3 enfants :
[billes groupes=4,4,4 couleurs=bleu,rouge,vert signes=non]
[cadre]Chaque enfant a [b]4 billes[/b]. Partager en parts égales, c'est faire [b]une division[/b].[/cadre]
[page]
[titre]Le signe :[/titre]
[center][font_size=34][b]12 : 3 = 4[/b][/font_size][/center]
[center]« douze divisé par trois égale quatre »[/center]
[cadre]Le signe [b]:[/b] se lit « divisé par ». Le résultat d'une division s'appelle [b]le quotient[/b].[/cadre]
[cadre=astuce]Dans un partage, toutes les parts sont [b]égales[/b] : personne n'en a plus que les autres.[/cadre]
[page]
[titre]Faire des groupes[/titre]
Une division répond aussi à : « combien de groupes de 5 puis-je faire avec 15 ? »
[billes groupes=5,5,5 couleurs=bleu,bleu,bleu signes=non]
[cadre]Avec 15 billes, je fais [b]3 groupes de 5[/b]. 15 : 5 = 3.[/cadre]
[page]
[titre]Division et multiplication[/titre]
3 lignes de 4 cases : 12 cases.
[grille lignes=3 colonnes=4]
[cadre]3 x 4 = 12, donc [b]12 : 3 = 4[/b] et [b]12 : 4 = 3[/b].
La division, c'est la multiplication [b]à l'envers[/b].[/cadre]
[page]
[titre]Diviser avec les tables[/titre]
Pour [b]42 : 7[/b], je me demande : « 7 fois combien font 42 ? »
Je récite la table de 7 : 7, 14, 21, 28, 35, [b]42[/b].
[table=6][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]7[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]14[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]21[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]28[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]35[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][b]42[/b][/center][/cell][/table]
[cadre]42, c'est [b]6 fois 7[/b] : 7 x 6 = 42, donc [b]42 : 7 = 6[/b].[/cadre]
[page]
[titre]Les divisions faciles[/titre]
[cadre]• Diviser [b]par 1[/b] : le nombre ne change pas. 9 : 1 = 9
• Un nombre divisé [b]par lui-même[/b] donne 1. 7 : 7 = 1
• Diviser [b]par 2[/b], c'est prendre la moitié. 18 : 2 = 9
• Diviser [b]par 10[/b] un nombre qui finit par 0 : j'enlève le 0. 80 : 10 = 8 ; 120 : 10 = 12[/cadre]
[page]
[titre]Plus grand que la table[/titre]
Pour [b]72 : 6[/b], je découpe 72 en deux morceaux faciles : 60 et 12.
[cadre]60 : 6 = [b]10[/b]. 12 : 6 = [b]2[/b]. Donc 72 : 6 = 10 + 2 = [b]12[/b].[/cadre]
[cadre=astuce]Je vérifie avec une multiplication : 12 x 6 = 60 + 12 = 72. C'est juste ![/cadre]
[page]
[titre]Un problème de partage[/titre]
On partage [b]48 autocollants[/b] en [b]8 groupes égaux[/b]. Combien y a-t-il d'autocollants par groupe ?
Partager en groupes égaux : c'est une division, [b]48 : 8[/b].
Table de 8 : 8 x 6 = 48, donc 48 : 8 = 6.
[cadre]Il y a [b]6 autocollants[/b] par groupe.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Diviser, c'est [b]partager en parts égales[/b] ou faire des groupes égaux.
• Le signe [b]:[/b] se lit « divisé par ». Le résultat est [b]le quotient[/b].
• La division, c'est la multiplication à l'envers : 7 x 6 = 42, donc 42 : 7 = 6.
• Par 1 : rien ne change. Par lui-même : 1. Par 2 : la moitié. Par 10 : j'enlève le 0.
• Grand nombre : je le découpe. 72 : 6 → 60 : 6 = 10 et 12 : 6 = 2, donc 12.
• Je vérifie avec une multiplication.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'division'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Comparer des nombres (CE2) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Comparer des nombres', $fiche$
[titre]Compter les chiffres[/titre]
Pour comparer deux nombres, je regarde d'abord [b]combien ils ont de chiffres[/b].
[center][font_size=30][b]1013[/b] > [b]987[/b][/font_size][/center]
[cadre]1013 a 4 chiffres, 987 n'en a que 3 : [b]le nombre qui a le plus de chiffres est le plus grand[/b].[/cadre]
[page]
[titre]Le même nombre de chiffres[/titre]
Je compare chiffre par chiffre, [b]en commençant par la gauche[/b] : les milliers d'abord.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]Milliers : 7 est plus grand que 6. Donc [b]7931 > 6129[/b]. Pas besoin de regarder la suite.[/cadre]
[page]
[titre]Les premiers chiffres sont égaux[/titre]
Si les milliers sont égaux, je regarde les centaines. Si elles sont égales aussi, les dizaines…
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
[cadre]Milliers : 5 et 5, égaux. Centaines : 3 et 3, égales. Dizaines : [b]3 > 0[/b].
Donc [b]5338 > 5308[/b].[/cadre]
[page]
[titre]Les signes < et >[/titre]
[center][font_size=30][b]4567 < 5049[/b]          [b]9966 > 4695[/b][/font_size][/center]
[cadre]• [b]<[/b] se lit « est plus petit que ».
• [b]>[/b] se lit « est plus grand que ».[/cadre]
[cadre=astuce]La pointe du signe montre toujours le [b]plus petit[/b] nombre.[/cadre]
[page]
[titre]Ranger des nombres[/titre]
Ranger du plus petit au plus grand : 3691 · 2194 · 3611 · 2987
[cadre]Je compare d'abord les milliers : les 2 avant les 3.
2194 < 2987, puis 3611 < 3691 (centaines égales, dizaines 1 < 9).
[b]2194 < 2987 < 3611 < 3691[/b][/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le nombre qui a le plus de chiffres est le plus grand : 1013 > 987.
• Même nombre de chiffres : je compare [b]de gauche à droite[/b], les milliers d'abord.
• Si deux chiffres sont égaux, je passe au chiffre suivant.
• < : plus petit que. > : plus grand que. La pointe montre le plus petit.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Moitié, tiers et quart (CE2) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Moitié, tiers et quart', $fiche$
[titre]Rappel[/titre]
[tarte parts=2,3,4 colorees=1 noms=oui]
[cadre]• La [b]moitié[/b] : je partage en 2 parts égales.
• Le [b]tiers[/b] : je partage en 3 parts égales.
• Le [b]quart[/b] : je partage en 4 parts égales.[/cadre]
[page]
[titre]Avec la division[/titre]
Au CE2, je sais diviser : c'est le même partage !
[cadre]• La moitié de 18, c'est [b]18 : 2 = 9[/b].
• Le tiers de 27, c'est [b]27 : 3 = 9[/b], car 3 x 9 = 27.
• Le quart de 32, c'est [b]32 : 4 = 8[/b], car 4 x 8 = 32.[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]316[/b], je découpe 316 en morceaux faciles : 300 et 16.
[cadre]Moitié de 300 = [b]150[/b]. Moitié de 16 = [b]8[/b]. Donc la moitié de 316, c'est [b]158[/b].[/cadre]
[cadre=astuce]Pour 184, je découpe en 180 et 4 : 90 + 2 = [b]92[/b].
Je vérifie avec le double : 92 + 92 = 184.[/cadre]
[page]
[titre]Le tiers d'un grand nombre[/titre]
Pour le tiers de [b]279[/b], je découpe en morceaux faciles à partager en 3 : 270 et 9.
[cadre]Tiers de 270 = [b]90[/b] (car 3 x 90 = 270). Tiers de 9 = [b]3[/b]. Donc le tiers de 279, c'est [b]93[/b].[/cadre]
[cadre=astuce]Pour 135 : 120 et 15. Tiers de 120 = 40, tiers de 15 = 5 → [b]45[/b].
Je vérifie : 45 + 45 + 45 = 135.[/cadre]
[page]
[titre]Le quart[/titre]
8 billes partagées en 4 parts égales : 2 billes par part. Le quart de 8, c'est [b]2[/b].
[billes groupes=2,2,2,2 couleurs=bleu,rouge,vert,orange signes=non]
Pour un grand nombre, le quart, c'est [b]la moitié de la moitié[/b].
[cadre]Quart de 300 : moitié de 300 = 150, puis moitié de 150 = [b]75[/b].
Je vérifie : 75 + 75 + 75 + 75 = 300.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Moitié = partager en 2 = diviser par 2.
• Tiers = partager en 3 = diviser par 3.
• Quart = partager en 4 = la moitié de la moitié.
• Pour un grand nombre, je le découpe en morceaux faciles : 316 = 300 + 16.
• Je vérifie en rassemblant les parts.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Petits problèmes (CE2) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Petits problèmes', $fiche$
[titre]Résoudre un problème, rappel[/titre]
[cadre]1. Je lis l'histoire [b]deux fois[/b] et je trouve [b]la question[/b].
2. Je cherche [b]les nombres[/b].
3. Je choisis l'opération : [b]+[/b] on reçoit, on achète ; [b]-[/b] on donne, on dépense ; [b]x[/b] plusieurs fois le même nombre.
4. Je [b]calcule[/b].
5. Je [b]réponds par une phrase[/b] et je vérifie que ma réponse a du sens.[/cadre]
[page]
[titre]Les problèmes d'argent[/titre]
Tu as [b]350 euros[/b] et tu achètes un objet à [b]98 euros[/b]. Combien te reste-t-il ?
Quand on paie, il reste moins d'argent : c'est une soustraction, [b]350 - 98[/b].
[cadre=astuce]98, c'est presque 100 : 350 - 100 = 250, puis je rends les 2 en trop : 250 + 2 = 252.[/cadre]
[cadre]Il te reste [b]252 euros[/b].[/cadre]
[page]
[titre]Des paquets : la multiplication[/titre]
Il y a [b]4 paquets de 6 jouets[/b]. Combien cela fait-il au total ?
Chaque ligne est un paquet de 6 :
[grille lignes=4 colonnes=6]
[cadre]4 fois le même nombre : [b]4 x 6 = 24[/b]. Il y a [b]24 jouets[/b] au total.[/cadre]
[page]
[titre]Un problème en deux étapes[/titre]
Léon a [b]138[/b] livres. Il en achète [b]101[/b] de plus, puis il en donne [b]65[/b]. Combien lui en reste-t-il ?
[cadre]Étape 1 : il achète. 138 + 101 = [b]239[/b]. Il a maintenant 239 livres.
Étape 2 : il donne. 239 - 65 = [b]174[/b].[/cadre]
Il reste [b]174 livres[/b] à Léon.
[page]
[titre]Garder l'ordre de l'histoire[/titre]
Noah a 123 pommes. Il en achète 116, puis il en donne 232.
[cadre]Étape 1 : 123 + 116 = [b]239[/b]. Étape 2 : 239 - 232 = [b]7[/b]. Il reste 7 pommes à Noah.[/cadre]
[cadre=astuce]Attention : 123 - 232, c'est impossible ! Il faut d'abord ajouter les pommes achetées.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
[cadre]• Si on [b]achète[/b] ou on [b]reçoit[/b], il y en a [b]plus[/b] qu'au début.
• Si on [b]paie[/b] ou on [b]donne[/b], il y en a [b]moins[/b].
• Avec de l'argent, il ne peut pas rester plus que ce qu'on avait.[/cadre]
Tu as 350 euros et tu paies 98 euros. Si je trouve 448 euros, c'est faux : j'ai ajouté au lieu d'enlever !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis deux fois, je trouve la question et les nombres.
• [b]Achète, reçoit[/b] : +. [b]Donne, paie[/b] : -. [b]Des paquets pareils[/b] : x.
• Ce qui reste = ce que j'avais - ce que je paie.
• Deux étapes : je calcule [b]dans l'ordre de l'histoire[/b].
• Je réponds par une phrase et je vérifie que c'est possible.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Mesures et conversions (CE2) - notion 'mesures'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Mesures et conversions', $fiche$
[titre]Mesurer[/titre]
Pour chaque chose qu'on mesure, il y a des [b]unités[/b] :
[table=3][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]On mesure[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]Unités[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell border=#classe padding=12,4,12,4][center]une longueur[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]km, m, cm, mm[/center][/cell][cell border=#classe padding=12,4,12,4][center]un crayon : 15 cm[/center][/cell][cell border=#classe padding=12,4,12,4][center]une masse[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]kg, g[/center][/cell][cell border=#classe padding=12,4,12,4][center]une pomme : 150 g[/center][/cell][cell border=#classe padding=12,4,12,4][center]une contenance[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]L, dL, cL[/center][/cell][cell border=#classe padding=12,4,12,4][center]un verre : 20 cL[/center][/cell][cell border=#classe padding=12,4,12,4][center]une durée[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]h, min, s, jours…[/center][/cell][cell border=#classe padding=12,4,12,4][center]une récréation : 15 min[/center][/cell][cell border=#classe padding=12,4,12,4][center]un prix[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]euros, centimes[/center][/cell][cell border=#classe padding=12,4,12,4][center]un livre : 5 euros[/center][/cell][/table]
[page]
[titre]Les longueurs[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 km = 1000 m[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]la distance entre deux villes[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 m = 100 cm[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]un lit : 2 m[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 cm = 10 mm[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]une fourmi : quelques mm[/center][/cell][/table]
[cadre]km : kilomètre. m : mètre. cm : centimètre. mm : millimètre.[/cadre]
[page]
[titre]Convertir des longueurs[/titre]
Pour passer à une unité [b]plus petite[/b], le nombre devient [b]plus grand[/b] : je multiplie.
[cadre]• 3 m = 3 x 100 = [b]300 cm[/b]
• 2 km = 2 x 1000 = [b]2000 m[/b]
• 4 cm = 4 x 10 = [b]40 mm[/b][/cadre]
[cadre=astuce]Dans l'autre sens, je cherche combien de fois : 700 cm = [b]7 m[/b], car 7 x 100 = 700.[/cadre]
[page]
[titre]Deux unités ensemble[/titre]
Pour [b]1 m 35 cm[/b] en centimètres : 1 m = 100 cm, plus 35 cm.
[cadre]1 m 35 cm = 100 + 35 = [b]135 cm[/b].
1 cm 1 mm = 10 + 1 = [b]11 mm[/b].[/cadre]
[cadre=astuce]Attention : 2 m 5 cm = 200 + 5 = [b]205 cm[/b], pas 25 cm ![/cadre]
[page]
[titre]Comparer des mesures[/titre]
Qu'est-ce qui est le plus long : [b]150 cm ou 2 m[/b] ?
Je mets les deux dans [b]la même unité[/b] : 2 m = 200 cm.
[cadre]200 cm est plus grand que 150 cm : [b]2 m est le plus long[/b].[/cadre]
[cadre=astuce]5 cm ou 40 mm ? 5 cm = 50 mm, donc [b]5 cm[/b] est le plus long.[/cadre]
[page]
[titre]Les masses[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 kg = 1000 g[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]kg : kilogramme, g : gramme[/center][/cell][/table]
[cadre]• 4 kg = 4 x 1000 = [b]4000 g[/b]. Et 2000 g = [b]2 kg[/b].
• 5 kg 900 g = 5000 + 900 = [b]5900 g[/b].
• 1 kg ou 950 g ? 1 kg = 1000 g : [b]1 kg[/b] est le plus lourd.[/cadre]
[cadre=astuce]Une fraise ou une pomme se pèse en g. Un chat (4 kg) ou un camion, en kg.[/cadre]
[page]
[titre]Les contenances[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 L = 10 dL[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 L = 100 cL[/b][/center][/cell][/table]
[cadre]L : litre. dL : décilitre. cL : centilitre.
• 3 L = 3 x 100 = [b]300 cL[/b]. Un demi-litre = [b]50 cL[/b].[/cadre]
[cadre=astuce]Un verre : environ 20 cL. Une bouteille d'eau : 1 L. Un seau : environ 10 L.[/cadre]
[page]
[titre]Les durées[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 jour = 24 heures[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]1 semaine = 7 jours[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 heure = 60 minutes[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]1 an = 12 mois[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 minute = 60 secondes[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]1 siècle = 100 ans[/b][/center][/cell][/table]
[cadre]Une demi-heure = [b]30 minutes[/b]. Une demi-minute = [b]30 secondes[/b].
Les mois ont 30 ou 31 jours, sauf février (28 ou 29 jours).[/cadre]
[page]
[titre]Heures et minutes[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][b]1 h = 60 min[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][b]2 h = 120 min[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][b]3 h = 180 min[/b][/center][/cell][/table]
Pour [b]3 h 10 min[/b] en minutes : 3 h = 180 min, plus 10 min.
[cadre]3 h 10 min = 180 + 10 = [b]190 min[/b].
1 h 45 min = 60 + 45 = [b]105 min[/b].[/cadre]
[cadre=astuce]Dans l'autre sens : 120 min = [b]2 h[/b], car 2 x 60 = 120.[/cadre]
[page]
[titre]Les autres durées[/titre]
Pour passer à une unité plus petite, je multiplie, comme pour les longueurs :
[cadre]• 2 jours = 2 x 24 = [b]48 heures[/b]
• 10 semaines = 10 x 7 = [b]70 jours[/b]
• 2 minutes = 2 x 60 = [b]120 secondes[/b]
• 2 ans = 2 x 12 = [b]24 mois[/b][/cadre]
[cadre=astuce]90 minutes ou 1 heure ? 1 h = 60 min : [b]90 minutes[/b] durent plus longtemps.[/cadre]
[page]
[titre]La monnaie[/titre]
[table=1][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 euro = 100 centimes[/b][/center][/cell][/table]
[cadre]• 2 euros = 2 x 100 = [b]200 centimes[/b]. Et 500 centimes = [b]5 euros[/b].
• 3 euros et 75 centimes = 300 + 75 = [b]375 centimes[/b].[/cadre]
[page]
[titre]Choisir la bonne unité[/titre]
Je me demande : est-ce que c'est tout petit, moyen ou très grand ?
[table=2][cell border=#classe padding=12,3,12,3][center]une fourmi, une pièce de monnaie[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]le millimètre[/center][/cell][cell border=#classe padding=12,3,12,3][center]un stylo, un livre[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]le centimètre[/center][/cell][cell border=#classe padding=12,3,12,3][center]une porte, la cour[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]le mètre[/center][/cell][cell border=#classe padding=12,3,12,3][center]la route entre deux villes[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]le kilomètre[/center][/cell][cell border=#classe padding=12,3,12,3][center]un film[/center][/cell][cell bg=#unites_clair border=#unites padding=12,3,12,3][center]l'heure[/center][/cell][cell border=#classe padding=12,3,12,3][center]une course de 50 mètres[/center][/cell][cell bg=#unites_clair border=#unites padding=12,3,12,3][center]la seconde[/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• 1 km = 1000 m · 1 m = 100 cm · 1 cm = 10 mm
• 1 kg = 1000 g · 1 L = 10 dL = 100 cL · 1 euro = 100 centimes
• 1 jour = 24 h · 1 h = 60 min · 1 min = 60 s · 1 an = 12 mois
• Vers une unité plus petite : je multiplie. 3 m = 300 cm.
• Deux unités ensemble : je convertis puis j'ajoute. 1 h 45 min = 105 min.
• Pour comparer, je mets tout dans [b]la même unité[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mesures'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Le périmètre (CE2) - notion 'perimetre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Le périmètre', $fiche$
[titre]Le périmètre, rappel[/titre]
Le [b]périmètre[/b], c'est [b]la longueur du tour[/b] d'une figure.
[rect long=16 larg=10 unite=cm]
[cadre]Pour faire le tour, j'additionne les 4 côtés : 16 + 10 + 16 + 10 = [b]52 cm[/b].[/cadre]
[page]
[titre]Une formule plus rapide[/titre]
Une longueur + une largeur, c'est [b]la moitié du tour[/b]. Le tour complet, c'est le double :
[center][font_size=26][b]Périmètre = (longueur + largeur) x 2[/b][/font_size][/center]
[cadre](16 + 10) x 2 = 26 x 2 = [b]52 cm[/b]. Je calcule d'abord ce qui est entre parenthèses.[/cadre]
[page]
[titre]Avec des grands nombres[/titre]
Un rectangle de longueur [b]75 cm[/b] et de largeur [b]71 cm[/b] :
[rect long=75 larg=71 unite=cm]
[cadre]75 + 71 = 146. Puis 146 x 2 = 146 + 146 = [b]292 cm[/b].[/cadre]
[page]
[titre]Le carré[/titre]
Un carré a [b]4 côtés égaux[/b]. Un rectangle de longueur 7 cm et de largeur 7 cm, c'est un carré !
[rect long=7 larg=7 unite=cm]
[cadre]Périmètre : 4 fois le côté. 4 x 7 = [b]28 cm[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]périmètre[/b], c'est la longueur du tour d'une figure.
• Rectangle : (longueur + largeur) x 2. (16 + 10) x 2 = 52 cm.
• Carré : 4 x le côté. 4 x 7 = 28 cm.
• Si la longueur et la largeur sont égales, c'est un carré.
• J'écris toujours l'[b]unité[/b] : cm, m…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'perimetre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

commit;
select fn_publier();
