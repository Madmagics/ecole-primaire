-- Fiche Le plus-que-parfait (CM2) - conjugaison, notion 'plus_que_parfait'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'conjugaison', 'Le plus-que-parfait', $fiche$
[titre]Avant le passé[/titre]
Le plus-que-parfait raconte une action qui s'est passée [b]avant[/b] une autre action passée.
[cadre]Quand je suis arrivé, le train [b]était parti[/b].
→ le train est parti [b]d'abord[/b], puis je suis arrivé.[/cadre]
[page]
[titre]Comment le former[/titre]
Auxiliaire [b]avoir[/b] ou [b]être[/b] à l'[b]imparfait[/b] + participe passé.
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]avoir[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]être[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]je[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]j'avais joué[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]j'étais parti(e)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]tu[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]avais joué[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]étais parti(e)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]il, elle[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]avait joué[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]était parti(e)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]nous[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]avions joué[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]étions parti(e)s[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]vous[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]aviez joué[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]étiez parti(e)s[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]ils, elles[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]avaient joué[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]étaient parti(e)s[/font_size][/center][/cell][/table]
[page]
[titre]Passé composé ou plus-que-parfait ?[/titre]
[cadre]Passé composé : auxiliaire au [b]présent[/b] → elles [b]ont[/b] joué.
Plus-que-parfait : auxiliaire à l'[b]imparfait[/b] → elles [b]avaient[/b] joué.[/cadre]
[cadre=astuce]Le participe ne change pas : seul l'auxiliaire change de temps.[/cadre]
[page]
[titre]Avec être, on accorde[/titre]
[cadre]Elle était arrivé[b]e[/b]. · Ils étaient venu[b]s[/b]. · Elles étaient né[b]es[/b] en mai.[/cadre]
[cadre=astuce]Les mêmes verbes qu'au passé composé prennent être : aller, venir, partir, naître, tomber, rester…[/cadre]
[page]
[titre]Le participe, pas l'infinitif[/titre]
[cadre]elles avaient pouss[b]é[/b] ✓ · elles avaient pousser ✗[/cadre]
[cadre=astuce]Je remplace par un verbe en -re : « elles avaient [b]vendu[/b] » → c'est un participe → é.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus-que-parfait = avoir ou être à l'[b]imparfait[/b] + participe passé.
• Il dit ce qui s'est passé avant une autre action passée.
• Avec être : accord avec le sujet.
• Participe en -é, pas -er.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'plus_que_parfait'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
