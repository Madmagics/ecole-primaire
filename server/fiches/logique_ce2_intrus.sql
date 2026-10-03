-- Fiche Trouver l'intrus (CE2) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Trouver l''intrus', $fiche$
[titre]Fruit ou légume ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Famille[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🍎 🍐 🍊 🍋 🍌 🍇 🍓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des fruits[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]🍒 🍑 🍉 🍍 🥝 🥭 🍅[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des fruits[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🥕 🥔 🧅 🥦 🥬[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des légumes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]🥒 🍆 🌽[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des légumes[/font_size][/center][/cell][/table]
[cadre=astuce]La [b]tomate[/b] 🍅 est un fruit : elle pousse à partir de la fleur et elle a des pépins.[/cadre]
[page]
[titre]Trouver l'intrus[/titre]
[center]Lequel de ces aliments n'est pas un fruit ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍐[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍇[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🥦[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🍑[/font_size][/center][/cell][/table]
[cadre]1. Je nomme chaque aliment : poire, raisin, brocoli, pêche.
2. Je classe : poire → fruit, raisin → fruit, brocoli → [b]légume[/b], pêche → fruit.
3. L'intrus est le [b]brocoli [/b]🥦.[/cadre]
[page]
[titre]Attention à la question ![/titre]
[center]Lequel de ces aliments n'est pas un [b]légume[/b] ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🌽[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🥬[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🧅[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🍇[/color][/font_size][/center][/cell][/table]
[cadre]Cette fois, la famille, ce sont les [b]légumes[/b]. Le maïs, la salade et l'oignon en sont.
Le raisin 🍇 est un fruit : c'est lui l'intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis bien la famille demandée : [b]fruit[/b] ou [b]légume[/b] ?
• Je nomme chaque aliment avant de choisir.
• La tomate 🍅 est un fruit.
• Il n'y a qu'[b]un seul[/b] intrus : les trois autres sont de la même famille.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
