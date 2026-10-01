-- Fiches Maths CE1 (2026-10-01) : les 10 fiches d'un coup. Relancer ce script remplace le contenu des fiches.
begin;

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

-- Fiche La soustraction (CE1) - notion 'soustraction'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'La soustraction', $fiche$
[titre]Soustraire, rappel[/titre]
Soustraire, c'est [b]enlever[/b] ou chercher [b]l'écart[/b] entre deux nombres.
Le résultat s'appelle [b]la différence[/b]. Le plus grand nombre s'écrit toujours en premier.
[file de=0 a=10 bonds=9:5]
[cadre][b]9 - 4 = 5[/b] : je pars de 9 et je recule de 4.[/cadre]
[page]
[titre]Enlever des dizaines ou des centaines[/titre]
Comme pour l'addition, ces calculs se font de tête :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]568 - 40 = 528[/b][/cell][cell border=#classe padding=14,6,14,6]le chiffre des [b]dizaines[/b] passe de 6 à 2[/cell][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][b]568 - 200 = 368[/b][/cell][cell border=#centaines padding=14,6,14,6]le chiffre des [b]centaines[/b] passe de 5 à 3[/cell][/table]
[cadre]Les autres chiffres ne bougent pas.[/cadre]
[page]
[titre]Poser une soustraction[/titre]
Je range les chiffres en colonnes, et je commence par [b]les unités[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
Unités : 5 - 1 = [b]4[/b]. Dizaines : 8 - 4 = [b]4[/b]. Centaines : 6 - 2 = [b]4[/b].
[cadre][b]685 - 241 = 444[/b][/cadre]
[page]
[titre]Pas assez d'unités ?[/titre]
Pour [b]52 - 27[/b] : dans les unités, 2 - 7, c'est impossible.
Pour s'en sortir, il existe [b]deux méthodes[/b] :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]Méthode 1 : le cassage[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]Méthode 2 : la compensation[/b][/center][/cell][cell border=#classe padding=14,6,14,6]je casse une dizaine du nombre du haut[/cell][cell border=#unites padding=14,6,14,6]j'ajoute 10 en haut et 1 dizaine en bas[/cell][/table]
[cadre]Les deux méthodes marchent et donnent [b]le même résultat[/b].
C'est [b]ton école[/b] qui choisit celle que tu apprends : utilise toujours [b]la méthode de ta classe[/b].[/cadre]
[page]
[titre]Méthode 1 : le cassage[/titre]
Pour [b]52 - 27[/b], je [b]casse une dizaine[/b] de 52 : elle devient 10 unités.
[cubes d=5 u=2 vers=4:12 fleche=casser]
[cadre]52, c'est aussi [b]4 dizaines et 12 unités[/b]. Maintenant je peux enlever 7 unités.[/cadre]
[page]
[titre]Le cassage dans l'opération[/titre]
J'écris le cassage au-dessus : le 5 devient 4, et le 2 devient 12.
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]4[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]5[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]2[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
Unités : 12 - 7 = [b]5[/b]. Dizaines : 4 - 2 = [b]2[/b].
[cadre][b]52 - 27 = 25[/b][/cadre]
[page]
[titre]Méthode 2 : la compensation[/titre]
Pour [b]52 - 27[/b], j'ajoute [b]10 aux deux nombres[/b] : l'écart entre eux ne change pas.
[cadre=astuce]C'est comme l'âge : si toi et ta grande sœur avez chacun 10 ans de plus, vous avez toujours le même écart d'âge ![/cadre]
• En haut, j'ajoute [b]10 unités[/b] : le 2 devient [b]12[/b].
• En bas, j'ajoute [b]1 dizaine[/b], c'est-à-dire 10 aussi : le 2 de 27 devient [b]3[/b].
[cadre]52 - 27 devient 62 - 37 : la différence est la même.[/cadre]
[page]
[titre]La compensation dans l'opération[/titre]
J'écris un petit [b]1[/b] devant le 2 du haut, et un petit [b]+1[/b] à côté du 2 du bas.
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]2[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]2[color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
Unités : 12 - 7 = [b]5[/b]. Dizaines : 5 - (2 + 1) = 5 - 3 = [b]2[/b].
[cadre][b]52 - 27 = 25[/b] : le même résultat qu'avec le cassage ![/cadre]
[page]
[titre]Avec les centaines[/titre]
Pour [b]315 - 172[/b] : unités, 5 - 2 = 3. Dizaines, 1 - 7 : impossible !
Méthode 1 : je casse [b]une centaine[/b]. 3 centaines 1 dizaine → 2 centaines 11 dizaines.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]2[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]11[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828][s]3[/s][/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][/table]
[cadre=astuce]Méthode 2 : j'ajoute 10 dizaines en haut (1 → 11) et 1 centaine en bas (1 → 2).
11 - 7 = 4, puis 3 - 2 = 1. Même résultat : [b]143[/b].[/cadre]
[page]
[titre]Vérifier avec une addition[/titre]
J'ajoute ce que j'ai enlevé : je dois retrouver le nombre du départ.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
[cadre]143 + 172 = 315 : c'est bien le nombre du départ, ma soustraction est juste.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Soustraire, c'est enlever ou chercher l'écart. Le résultat est [b]la différence[/b].
• Enlever 40 : le chiffre des dizaines baisse. Enlever 200 : le chiffre des centaines baisse.
• Pour poser : les chiffres en colonnes, je commence par les [b]unités[/b].
• Pas assez d'unités ? Deux méthodes : le [b]cassage[/b] (52 = 4 dizaines et 12 unités) ou la [b]compensation[/b] (10 de plus en haut, 1 dizaine de plus en bas).
• Les deux méthodes marchent : j'utilise toujours [b]celle de ma classe[/b].
• Je vérifie avec une addition.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'soustraction'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La multiplication (CE1) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'La multiplication', $fiche$
[titre]Des groupes égaux[/titre]
J'ai 3 sacs. Dans chaque sac, il y a 5 billes. Combien de billes en tout ?
[billes groupes=5,5,5 couleurs=bleu,bleu,bleu total=oui]
[cadre]5 + 5 + 5 = [b]15[/b]. Quand on ajoute plusieurs fois [b]le même nombre[/b], on peut multiplier.[/cadre]
[page]
[titre]Le signe x[/titre]
[center][font_size=34][b]3 x 5 = 15[/b][/font_size][/center]
[center]« trois fois cinq égale quinze »[/center]
3 x 5, c'est [b]3 fois le nombre 5[/b] : 5 + 5 + 5.
[cadre]Le signe [b]x[/b] se lit « fois ». Le résultat d'une multiplication s'appelle [b]le produit[/b].[/cadre]
[page]
[titre]L'ordre ne change rien[/titre]
3 lignes de 5 cases, ou 5 lignes de 3 cases : c'est le même nombre de cases.
[grille lignes=3 colonnes=5]
[grille lignes=5 colonnes=3]
[cadre][b]3 x 5 = 15[/b] et [b]5 x 3 = 15[/b]. Je peux choisir le calcul le plus facile.[/cadre]
[page]
[titre]Fois 1 et fois 0[/titre]
[cadre]• Multiplier [b]par 1[/b] : une seule fois le nombre. Il ne change pas. [b]7 x 1 = 7[/b]
• Multiplier [b]par 0[/b] : zéro fois le nombre, c'est rien du tout. [b]7 x 0 = 0[/b][/cadre]
[cadre=astuce]0 sac de 7 billes, ça fait 0 bille. 7 sacs vides, ça fait aussi 0 bille : [b]0 x 7 = 0[/b].[/cadre]
[page]
[titre]La table de 2[/titre]
Multiplier par 2, c'est faire [b]le double[/b] : 6 x 2 = 6 + 6 = 12.
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]0 x 2 = 0[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 2 = 2[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 2 = 4[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 2 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 2 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 2 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 2 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 2 = 14[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 2 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 2 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 2 = 20[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]11 x 2 = 22[/b][/cell][/table]
[cadre=astuce]Les résultats de la table de 2 sont tous des nombres [b]pairs[/b].[/cadre]
[page]
[titre]La table de 5[/titre]
On compte de 5 en 5 : 5, 10, 15, 20…
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]0 x 5 = 0[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 5 = 5[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 5 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 5 = 15[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 5 = 20[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 5 = 25[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 5 = 30[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 5 = 35[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 5 = 40[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 5 = 45[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 5 = 50[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]11 x 5 = 55[/b][/cell][/table]
[cadre=astuce]Les résultats de la table de 5 finissent toujours par [b]0[/b] ou par [b]5[/b].[/cadre]
[page]
[titre]La table de 10[/titre]
7 x 10, c'est 7 paquets de 10 : [b]7 dizaines[/b].
[cubes d=7 u=0]
[center][font_size=30][b]7 x 10 = 70[/b][/font_size][/center]
[cadre=astuce]Pour multiplier par 10, j'écris un [b]0[/b] à droite du nombre : 4 x 10 = 40, 11 x 10 = 110.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Multiplier, c'est ajouter plusieurs fois le même nombre : 3 x 5 = 5 + 5 + 5.
• Le résultat s'appelle [b]le produit[/b].
• L'ordre ne change rien : 9 x 5 = 5 x 9 = 45.
• Multiplier par 1 : le nombre ne change pas. Par 0 : le résultat est 0.
• Table de 2 : les doubles. Table de 5 : finit par 0 ou 5.
• Table de 10 : j'écris un 0 à droite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Compléments et nombres manquants (CE1) - notion 'complements'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Compléments et nombres manquants', $fiche$
[titre]Le nombre qui manque, rappel[/titre]
Dans [b]8 + ___ = 11[/b], je cherche ce qu'il faut ajouter à 8 pour arriver à 11.
[file de=6 a=13 bonds=8:11]
[cadre]De 8 à 11, il y a 3 pas : il manque [b]3[/b]. C'est l'[b]écart[/b] entre 8 et 11.[/cadre]
[page]
[titre]Les compléments à 100[/titre]
Les dizaines qui font 100 ensemble, comme les paires qui font 10 :
[table=5][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 + 90[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]20 + 80[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]30 + 70[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]40 + 60[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]50 + 50[/b][/cell][/table]
Pour [b]65 + ___ = 100[/b] : 65 + 5 = 70, puis 70 + 30 = 100.
[cadre]Il manque 5 + 30 = [b]35[/b]. Donc 65 + 35 = 100.[/cadre]
[page]
[titre]Avancer par grands bonds[/titre]
Combien faut-il ajouter à [b]90[/b] pour obtenir [b]180[/b] ?
[file de=80 a=190 pas=10 bonds=90:100,100:180]
D'abord de 90 à 100 : [b]+10[/b]. Puis de 100 à 180 : [b]+80[/b].
[cadre]En tout, j'ai ajouté 10 + 80 = [b]90[/b]. Donc 90 + 90 = 180.[/cadre]
[page]
[titre]Compléter chiffre par chiffre[/titre]
Pour [b]104 + ___ = 289[/b], je regarde chaque colonne :
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828]?[/color][/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
Unités : de 4 à 9, il faut [b]5[/b]. Dizaines : de 0 à 8, il faut [b]8[/b]. Centaines : de 1 à 2, il faut [b]1[/b].
[cadre]Il manque [b]185[/b]. Je vérifie : 104 + 185 = 289.[/cadre]
[page]
[titre]Trouver avec une soustraction[/titre]
Quand c'est difficile, le nombre qui manque dans une addition se trouve avec une [b]soustraction[/b].
[center][b]86 + ___ = 415[/b]   →   [b]415 - 86[/b][/center]
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]3[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]15[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][color=#C62828][s]4[/s][/color][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]5[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]Il manque [b]329[/b]. Je vérifie : 86 + 329 = 415.[/cadre]
[page]
[titre]Le trou au début[/titre]
Pour [b]___ + 100 = 563[/b] : l'ordre ne change rien dans une addition.
C'est pareil que [b]100 + ___ = 563[/b]. Je calcule [b]563 - 100[/b].
[cadre]563 - 100 = [b]463[/b] : seul le chiffre des centaines change.
Je vérifie : 463 + 100 = 563.[/cadre]
[page]
[titre]Le trou dans une soustraction[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]890 - ___ = 471[/b][/cell][cell border=#classe padding=14,6,14,6]Combien ai-je enlevé ? L'écart entre 890 et 471 : [b]890 - 471 = 419[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___ - 106 = 440[/b][/cell][cell border=#unites padding=14,6,14,6]Combien avais-je au départ ? Je remets ce que j'ai enlevé : [b]440 + 106 = 546[/b][/cell][/table]
[cadre=astuce]Je remets toujours mon nombre dans le trou pour vérifier : 890 - 419 = 471 ; 546 - 106 = 440.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le nombre qui manque, c'est l'[b]écart[/b] entre deux nombres.
• Les compléments à 100 : 10 + 90, 20 + 80, 30 + 70, 40 + 60, 50 + 50.
• Pour un grand bond, j'avance d'abord jusqu'à la dizaine ou la centaine.
• Dans une addition, je peux trouver le trou avec une soustraction : 86 + ___ = 415 → 415 - 86.
• Pour ___ - 106 = 440, je remets ce que j'ai enlevé : 440 + 106.
• Je vérifie toujours en remettant le nombre dans le trou.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'complements'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Comparer des nombres (CE1) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Comparer des nombres', $fiche$
[titre]Des nombres à 3 chiffres[/titre]
Au CE1, on compare des nombres jusqu'à 999. Chaque chiffre a sa place :
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
[cadre]Dans [b]306[/b] : 3 centaines, 0 dizaine et 6 unités.[/cadre]
[page]
[titre]Le nombre de chiffres d'abord[/titre]
Compare [b]99[/b] et [b]104[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b][/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]0[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
99 n'a pas de centaine. 104 a une centaine.
[cadre]Un nombre à [b]3 chiffres[/b] est toujours plus grand qu'un nombre à 2 chiffres : [b]104 > 99[/b].[/cadre]
[page]
[titre]Je compare les centaines[/titre]
Compare [b]524[/b] et [b]996[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
524 a 5 centaines, 996 a 9 centaines.
[cadre]9 centaines, c'est plus que 5 centaines : [b]996 est plus grand que 524[/b].
Inutile de regarder les autres chiffres ![/cadre]
[page]
[titre]Mêmes centaines : les dizaines[/titre]
Compare [b]136[/b] et [b]163[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][/table]
Les centaines sont les mêmes : 1 et 1. Je regarde les dizaines : 3 et 6.
[cadre]6 dizaines, c'est plus que 3 dizaines : [b]163 est plus grand que 136[/b].[/cadre]
[page]
[titre]Mêmes centaines et mêmes dizaines[/titre]
Compare [b]345[/b] et [b]348[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
Centaines : 3 et 3. Dizaines : 4 et 4. Il reste les unités : 5 et 8.
[cadre][b]348 est plus grand que 345[/b] : 348 > 345.[/cadre]
[page]
[titre]Ranger des nombres[/titre]
Ranger dans l'[b]ordre croissant[/b], c'est du plus petit au plus grand :
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]136[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]163[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]300[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]524[/b][/cell][/table]
Ranger dans l'[b]ordre décroissant[/b], c'est du plus grand au plus petit :
[table=4][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]524[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]300[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]163[/b][/cell][cell bg=#unites_clair border=#classe padding=14,6,14,6][b]136[/b][/cell][/table]
[cadre=astuce]Rappel : la pointe des signes < et > montre toujours le plus petit nombre. 136 < 163.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus de chiffres = plus grand : 104 > 99.
• Je compare d'abord les [b]centaines[/b], puis les [b]dizaines[/b], puis les [b]unités[/b].
• Dès qu'un chiffre est plus grand, j'ai trouvé : inutile de regarder la suite.
• Ordre croissant : du plus petit au plus grand. Ordre décroissant : l'inverse.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Les suites de nombres (CE1) - notion 'suites_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Les suites de nombres', $fiche$
[titre]Trouver la règle, rappel[/titre]
Une suite suit toujours [b]la même règle[/b]. Je la trouve avec deux nombres qui se suivent.
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]30[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]40[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]50[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]60[/b][/cell][/table]
[cadre]De 30 à 40 : +10. De 40 à 50 : +10. La règle est [b]+10[/b].[/cadre]
[page]
[titre]De 10 en 10, en passant 100[/titre]
[file de=80 a=140 pas=10 bonds=90:100,100:110]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]90[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]120[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]130[/b][/cell][/table]
Après 100 vient [b]110[/b] : 100 + 10 = 110.
[cadre=astuce]Après 9 dizaines, on passe à [b]1 centaine[/b] : 90, 100, 110… comme 9, 10, 11 !
Après 190 vient 200.[/cadre]
[page]
[titre]De 100 en 100[/titre]
[file de=0 a=500 pas=100 bonds=0:100,100:200,200:300,300:400]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]200[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]400[/b][/cell][/table]
[cadre]De 100 en 100, [b]seul le chiffre des centaines change[/b] : il manque [b]300[/b].[/cadre]
[page]
[titre]De 50 en 50[/titre]
[file de=0 a=250 pas=50 bonds=0:50,50:100,100:150,150:200]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]150[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]200[/b][/cell][/table]
[cadre]Il manque [b]50[/b]. Deux bonds de 50 font 100.[/cadre]
[cadre=astuce]De 50 en 50, les nombres finissent par 0, puis 50, puis 00, puis 50…[/cadre]
[page]
[titre]Trouver le nombre qui manque[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]190[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]210[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]220[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]230[/b][/cell][/table]
1. Je trouve la règle avec deux nombres côte à côte : de 210 à 220, [b]+10[/b].
2. J'applique la règle après le nombre d'avant : 190 + 10 = [b]200[/b].
[cadre]Il manque [b]200[/b]. Je vérifie : 200 + 10 = 210. C'est juste ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Pour trouver la règle, je regarde l'écart entre deux nombres qui se suivent.
• De 10 en 10 : après 90 vient 100, après 190 vient 200.
• De 100 en 100 : seul le chiffre des centaines change.
• De 50 en 50 : deux bonds de 50 font 100.
• Je vérifie avec la règle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Doubles, moitiés, tiers, quarts (CE1) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Doubles, moitiés, tiers, quarts', $fiche$
[titre]Double et moitié, rappel[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 12[/b], c'est 12 + 12 = 24.[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 24[/b], c'est 12 : 12 + 12 = 24.[/cell][/table]
[billes groupes=4,4 couleurs=bleu,rouge signes=non]
[cadre]Prendre la moitié, c'est partager en [b]2 parts égales[/b]. La moitié de 8, c'est 4.[/cadre]
[page]
[titre]Partager en parts égales[/titre]
Une tarte coupée en 2, en 3 ou en 4 parts égales :
[tarte parts=2,3,4 colorees=1 noms=oui]
[cadre]• Partager en [b]2[/b] : chaque part est [b]une moitié[/b].
• Partager en [b]3[/b] : chaque part est [b]un tiers[/b].
• Partager en [b]4[/b] : chaque part est [b]un quart[/b].[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]98[/b], je coupe 98 en deux nombres faciles : 80 et 18.
[cubes d=9 u=8 vers=4:9 fleche=moitié]
Moitié de 80 = [b]40[/b]. Moitié de 18 = [b]9[/b]. Donc la moitié de 98, c'est [b]49[/b].
[cadre=astuce]Je vérifie avec le double : 49 + 49 = 98. La moitié de 100, c'est 50.[/cadre]
[page]
[titre]Le tiers[/titre]
Prendre le tiers, c'est partager en [b]3 parts égales[/b].
J'ai 12 billes. Je les partage entre 3 enfants :
[billes groupes=4,4,4 couleurs=bleu,rouge,vert signes=non]
[cadre]Chacun a 4 billes. Le tiers de 12, c'est [b]4[/b] : 4 + 4 + 4 = 12.[/cadre]
[page]
[titre]Le tiers d'un grand nombre[/titre]
Pour le tiers de [b]93[/b], je partage les dizaines, puis les unités.
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6]Tiers de 90[/cell][cell border=#classe padding=14,6,14,6][b]30[/b], car 30 + 30 + 30 = 90[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]Tiers de 3[/cell][cell border=#unites padding=14,6,14,6][b]1[/b], car 1 + 1 + 1 = 3[/cell][/table]
[cadre]Le tiers de 93, c'est 30 + 1 = [b]31[/b]. Je vérifie : 31 + 31 + 31 = 93.[/cadre]
[page]
[titre]Le quart[/titre]
Prendre le quart, c'est partager en [b]4 parts égales[/b].
J'ai 8 billes. Je les partage entre 4 enfants :
[billes groupes=2,2,2,2 couleurs=bleu,rouge,vert,orange signes=non]
Le quart de 8, c'est [b]2[/b] : 2 + 2 + 2 + 2 = 8.
[cadre=astuce]Le quart, c'est [b]la moitié de la moitié[/b] !
Quart de 96 : moitié de 96 = 48, puis moitié de 48 = [b]24[/b].
Quart de 100 : moitié de 100 = 50, puis moitié de 50 = [b]25[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]double[/b] : le nombre deux fois. Double de 12 = 24.
• La [b]moitié[/b] : 2 parts égales. Moitié de 98 = 40 + 9 = 49.
• Le [b]tiers[/b] : 3 parts égales. Tiers de 12 = 4, car 4 + 4 + 4 = 12.
• Le [b]quart[/b] : 4 parts égales, c'est la moitié de la moitié. Quart de 100 = 25.
• Pour un grand nombre, je partage les dizaines puis les unités.
• Je vérifie toujours en rassemblant les parts.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Petits problèmes (CE1) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Petits problèmes', $fiche$
[titre]Résoudre un problème, rappel[/titre]
[cadre]1. Je lis l'histoire [b]deux fois[/b] et je trouve [b]la question[/b].
2. Je cherche [b]les nombres[/b].
3. Je choisis l'opération : [b]+[/b] si on en reçoit, on en achète ; [b]-[/b] si on en donne, on en dépense.
4. Je [b]calcule[/b].
5. Je [b]réponds par une phrase[/b] et je vérifie que ma réponse a du sens.[/cadre]
[page]
[titre]Les problèmes d'argent[/titre]
Tu as [b]90 euros[/b] et tu achètes un objet à [b]43 euros[/b]. Combien te reste-t-il ?
Quand on paie, on [b]dépense[/b] : il reste moins d'argent. C'est une soustraction, [b]90 - 43[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]8[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]9[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]0[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]Il te reste [b]47 euros[/b].[/cadre]
[page]
[titre]Calculer de tête : l'écart[/titre]
Pour 90 - 43, je peux aussi chercher l'écart : j'avance de 43 jusqu'à 90.
[table=3][cell bg=#unites_clair border=#unites padding=14,6,14,6]43 → 50[/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6]50 → 90[/cell][cell border=#classe padding=14,6,14,6]en tout[/cell][cell border=#unites padding=14,6,14,6][b]+7[/b][/cell][cell border=#classe padding=14,6,14,6][b]+40[/b][/cell][cell border=#classe padding=14,6,14,6][b]7 + 40 = 47[/b][/cell][/table]
[cadre=astuce]Je vérifie : 47 + 43 = 90. C'est bien l'argent que j'avais.[/cadre]
[page]
[titre]Un problème en deux étapes[/titre]
Jules a [b]20[/b] autocollants. Il en achète [b]16[/b] de plus, puis il en donne [b]19[/b]. Combien lui en reste-t-il ?
Il se passe [b]deux choses[/b] : je calcule dans l'ordre de l'histoire.
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6]1. Il en achète 16 : [b]+[/b][/cell][cell border=#classe padding=14,6,14,6][b]20 + 16 = 36[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]2. Il en donne 19 : [b]-[/b][/cell][cell border=#unites padding=14,6,14,6][b]36 - 19 = 17[/b][/cell][/table]
[cadre]Il reste [b]17 autocollants[/b] à Jules.[/cadre]
[page]
[titre]Garder le résultat de l'étape 1[/titre]
Le résultat de la première étape devient [b]le nombre de départ[/b] de la deuxième.
Maya a 11 billes. Elle en achète 5, puis en donne 14.
[cadre]Étape 1 : 11 + 5 = [b]16[/b]. Elle a maintenant 16 billes.
Étape 2 : 16 - 14 = [b]2[/b]. Il lui reste 2 billes.[/cadre]
[cadre=astuce]Attention : ne pas faire 11 - 14, c'est impossible ! Il faut d'abord ajouter les 5 billes achetées.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
[cadre]• Si on [b]achète[/b] ou on [b]reçoit[/b], il y en a [b]plus[/b] qu'au début.
• Si on [b]paie[/b] ou on [b]donne[/b], il y en a [b]moins[/b].
• Avec de l'argent, il ne peut pas rester plus que ce qu'on avait.[/cadre]
Tu as 90 euros et tu dépenses 43 euros. Si je trouve 133 euros, c'est faux : j'ai ajouté au lieu d'enlever !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis deux fois, je trouve la question et les nombres.
• [b]Achète, reçoit[/b] : +. [b]Donne, paie, dépense[/b] : -.
• Un problème d'argent : ce qui reste = ce que j'avais - ce que je paie.
• Deux étapes : je calcule [b]dans l'ordre de l'histoire[/b].
• Le résultat de l'étape 1 sert pour l'étape 2.
• Je réponds par une phrase et je vérifie que c'est possible.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Le périmètre (CE1) - notion 'perimetre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Le périmètre', $fiche$
[titre]Le périmètre, c'est quoi ?[/titre]
Une fourmi fait le tour d'un jardin rectangulaire, en marchant sur le bord.
Le chemin qu'elle parcourt, c'est le [b]périmètre[/b] du jardin.
[rect long=10 larg=6 unite=m]
[cadre]Le périmètre, c'est [b]la longueur du tour[/b] d'une figure.[/cadre]
[page]
[titre]Le rectangle[/titre]
Un rectangle a [b]4 côtés[/b] : 2 longs côtés égaux, et 2 petits côtés égaux.
[rect long=10 larg=6 unite=cm]
[cadre]• Le grand côté s'appelle [b]la longueur[/b] : ici 10 cm.
• Le petit côté s'appelle [b]la largeur[/b] : ici 6 cm.[/cadre]
[page]
[titre]Calculer le périmètre[/titre]
Pour faire le tour, j'additionne [b]les 4 côtés[/b] :
[center][font_size=30][b]10 + 6 + 10 + 6 = 32[/b][/font_size][/center]
[rect long=10 larg=6 unite=cm]
[cadre]Le périmètre de ce rectangle est [b]32 cm[/b]. Je n'oublie pas l'unité : les cm.[/cadre]
[page]
[titre]Une astuce plus rapide[/titre]
Il y a 2 longueurs et 2 largeurs : je les regroupe.
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6]2 longueurs[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]2 largeurs[/cell][cell border=#classe padding=14,6,14,6]le tour[/cell][cell border=#classe padding=14,6,14,6][b]10 + 10 = 20[/b][/cell][cell border=#unites padding=14,6,14,6][b]6 + 6 = 12[/b][/cell][cell border=#classe padding=14,6,14,6][b]20 + 12 = 32 cm[/b][/cell][/table]
[cadre=astuce]Ou bien : une longueur + une largeur, c'est un demi-tour : 10 + 6 = 16.
Le tour complet, c'est le [b]double[/b] : 16 + 16 = 32 cm.[/cadre]
[page]
[titre]Le carré[/titre]
Un carré a [b]4 côtés de la même longueur[/b].
[rect long=5 larg=5 unite=cm]
[cadre]Périmètre : 5 + 5 + 5 + 5 = [b]20 cm[/b]. C'est aussi 4 fois 5 : 4 x 5 = 20.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]périmètre[/b], c'est la longueur du tour d'une figure.
• Rectangle : j'additionne les 4 côtés. 10 + 6 + 10 + 6 = 32 cm.
• Plus vite : 2 longueurs + 2 largeurs, ou le double de longueur + largeur.
• Carré : 4 côtés égaux. 5 + 5 + 5 + 5 = 20 cm.
• J'écris toujours l'[b]unité[/b] : cm, m…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'perimetre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

commit;
select fn_publier();
