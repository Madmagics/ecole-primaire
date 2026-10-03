-- Fiche Trouver l'intrus (CE1) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'logique', 'Trouver l''intrus', $fiche$
[titre]Bien lire la question[/titre]
Au CE1, la question dit [b]quelle famille[/b] chercher.
[cadre]« Quel nombre [b]n'est pas[/b] un multiple de 10 ? »
Je cherche le seul nombre qui [b]n'est pas[/b] dans la famille des multiples de 10.[/cadre]
[cadre=astuce]Le mot [b]« pas »[/b] est très important : je cherche celui qui ne va pas.[/cadre]
[page]
[titre]Les multiples de 10 et de 5[/titre]
Un multiple de 10 se termine par [b]0[/b]. Un multiple de 5 se termine par [b]0 ou 5[/b].
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]140[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]190[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=26][b][color=white]116[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]170[/b][/font_size][/center][/cell][/table]
[cadre]140, 190 et 170 se terminent par 0. 116 se termine par 6 : c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Je regarde seulement le [b]dernier chiffre[/b] (le chiffre des unités).[/cadre]
[page]
[titre]Pair ou impair ?[/titre]
Pairs : se terminent par [b]0, 2, 4, 6, 8[/b]. Impairs : par [b]1, 3, 5, 7, 9[/b].
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]65[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=26][b][color=white]92[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]41[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=26][b]23[/b][/font_size][/center][/cell][/table]
[cadre]« Quel nombre n'est pas impair ? » 65, 41, 23 sont impairs.
92 se termine par 2 : il est pair, c'est [b]l'intrus[/b].[/cadre]
[page]
[titre]Le nombre de pattes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐭 🐰 🐶 🐸 🐷[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]4 pattes[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐔 🦆 🐦[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]2 pattes (les oiseaux)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🐝 🦋 🐞[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]6 pattes (les insectes)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🐟 🐍[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]pas de pattes[/font_size][/center][/cell][/table]
[cadre]« Lequel n'a pas 4 pattes ? 🐔 🐭 🐰 🐸 » → la poule 🐔 n'a que 2 pattes.[/cadre]
[page]
[titre]Animal, objet ou fruit ?[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🔑[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=32][color=white]🍊[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🎁[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=32]🎈[/font_size][/center][/cell][/table]
[cadre]« Quel élément n'est pas un objet ? » La clé, le cadeau et le ballon sont des objets.
L'orange 🍊 est un fruit : c'est l'intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis la famille demandée et le mot [b]« pas »[/b].
• Multiple de 10 : finit par [b]0[/b]. Multiple de 5 : finit par [b]0 ou 5[/b].
• Pair : finit par 0, 2, 4, 6, 8. Impair : par 1, 3, 5, 7, 9.
• Oiseaux : 2 pattes. Insectes : 6 pattes.
• Je vérifie chaque élément un par un.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
