-- Fiche Comparer : le plus, le moins (CP) - logique, notion 'comparer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Comparer : le plus, le moins', $fiche$
[titre]Je compte chacun[/titre]
[center]Léo a 🍋🍋🍋, Nina a 🍋🍋🍋🍋🍋.[/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Prénom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Citrons[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Nina[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]5[/font_size][/center][/cell][/table]
[cadre]Nina a [b]5[/b] citrons, Léo en a [b]3[/b].
5 est plus grand que 3 : c'est [b]Nina qui en a le plus[/b].[/cadre]
[page]
[titre]Le plus ou le moins ?[/titre]
Je lis bien la question : elle demande [b]le plus[/b] ou [b]le moins[/b] ?
[cadre][b]Le plus[/b] : celui qui en a [b]beaucoup[/b], le plus grand nombre.
[b]Le moins[/b] : celui qui en a [b]peu[/b], le plus petit nombre.[/cadre]
[cadre=astuce]Léo a 3 citrons, Nina en a 5.
Qui a [b]le moins[/b] de citrons ? C'est [b]Léo[/b] ![/cadre]
[page]
[titre]Mettre en face[/titre]
Je peux aussi mettre les objets [b]face à face[/b], un par un.
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24] [/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]Nina[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]🍋[/font_size][/center][/cell][/table]
[cadre]Chez Léo, il reste des cases vides : il en a [b]moins[/b].
Nina a des citrons en plus : elle en a [b]plus[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je [b]compte[/b] les objets de chaque enfant.
• [b]Le plus[/b] = le plus grand nombre. [b]Le moins[/b] = le plus petit nombre.
• S'ils en ont autant, c'est [b]pareil[/b].
• Je relis la question avant de répondre : le plus ou le moins ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
