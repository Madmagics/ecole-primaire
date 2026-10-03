-- Fiche Les suites logiques (CP) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Les suites logiques', $fiche$
[titre]Un motif qui se répète[/titre]
Dans une suite, un même [b]morceau[/b] revient toujours dans le même ordre : c'est le [b]motif[/b].
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=30][b]?[/b][/font_size][/center][/cell][/table]
[cadre]Le motif, c'est [b]■ ▲[/b]. Après ■ vient toujours ▲.
La réponse est [b]▲[/b].[/cadre]
[page]
[titre]Un motif de 3[/titre]
[table=6][cell bg=#42A5F5 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#F2A541 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#AB47BC border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#42A5F5 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#F2A541 border=#classe padding=18,8,18,8][center][font_size=26][b] [/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=18,8,18,8][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]bleu[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]orange[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]violet[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]bleu[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]orange[/font_size][/center][/cell][cell padding=4,2,4,2][center][font_size=18]?[/font_size][/center][/cell][/table]
Je lis à voix haute : « bleu, orange, violet… bleu, orange… »
[cadre]Le motif a [b]3 couleurs[/b] : bleu, orange, violet.
Après orange vient [b]violet[/b].[/cadre]
[cadre=astuce]Je cherche où le motif [b]recommence[/b] : ici, quand le bleu revient.[/cadre]
[page]
[titre]Des groupes qui grandissent[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26]🍐🍐🍐[/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][font_size=26][b]?[/b][/font_size][/center][/cell][/table]
Je compte chaque groupe : [b]1[/b], puis [b]2[/b], puis [b]3[/b].
[cadre]À chaque groupe, on ajoute [b]1[/b] poire.
Le prochain groupe a [b]4[/b] poires.[/cadre]
[page]
[titre]Des nombres qui montent[/titre]
[center][font_size=30][b]2, 3, 4, 5, …[/b][/font_size][/center]
[file de=1 a=7 bonds=2:3,3:4,4:5,5:6]
[cadre]À chaque fois, j'avance de [b]1[/b] : c'est la règle [b]+1[/b].
Après 5 vient [b]6[/b].[/cadre]
[page]
[titre]Des nombres qui descendent[/titre]
[center][font_size=30][b]40, 38, 36, 34, …[/b][/font_size][/center]
[file de=31 a=41 bonds=40:38,38:36,36:34,34:32]
Les nombres sont de plus en plus [b]petits[/b] : je recule.
[cadre]De 40 à 38, je recule de [b]2[/b]. La règle est [b]-2[/b].
Après 34 vient [b]32[/b].[/cadre]
[page]
[titre]Reculer de 5 en 5[/titre]
[center][font_size=30][b]20, 15, 10, 5, …[/b][/font_size][/center]
[file de=0 a=20 pas=5 bonds=20:15,15:10,10:5,5:0]
[cadre]La règle est [b]-5[/b]. Après 5 vient [b]0[/b].[/cadre]
[cadre=astuce]Je regarde d'abord si les nombres [b]montent[/b] ou [b]descendent[/b].
S'ils montent, la réponse est plus grande. S'ils descendent, elle est plus petite.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une suite suit toujours [b]une règle[/b].
• Avec des formes ou des couleurs, je cherche le [b]motif[/b] qui se répète.
• Avec des groupes, je [b]compte[/b] chaque groupe.
• Avec des nombres, je regarde de combien on avance ou on recule : [b]+1[/b], [b]+2[/b], [b]-2[/b], [b]-5[/b]…
• Je vérifie ma réponse avec la règle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
