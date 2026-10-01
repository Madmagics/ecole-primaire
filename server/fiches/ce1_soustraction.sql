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
select fn_publier();
