-- Fiche Trouver l'intrus (CP) - logique, notion 'intrus'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Trouver l''intrus', $fiche$
[titre]L'intrus, c'est quoi ?[/titre]
L'intrus, c'est celui qui [b]n'est pas de la même famille[/b] que les autres.
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐶[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐰[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🍎[/color][/font_size][/center][/cell][/table]
[cadre]🐱 🐶 🐰 sont des [b]animaux[/b]. 🍎 est un [b]fruit[/b].
L'intrus, c'est 🍎.[/cadre]
[page]
[titre]Les formes et les dessins[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34][b]★[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🐟[/color][/font_size][/center][/cell][/table]
[cadre]■ ▲ ★ sont des [b]formes[/b] : un carré, un triangle, une étoile.
🐟 est un [b]animal[/b] : c'est l'intrus.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je [b]nomme[/b] chaque dessin dans ma tête.
2. Je cherche ce que [b]presque tous[/b] ont en commun : des animaux ? des formes ? des fruits ?
3. Celui qui n'est pas dans la famille, c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Il y a toujours [b]un seul[/b] intrus.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Les familles : les [b]animaux[/b], les [b]fruits[/b], les [b]formes[/b], les [b]objets[/b].
• L'intrus est celui qui n'est [b]pas de la même famille[/b].
• Je nomme chaque dessin avant de choisir.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'intrus'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
