-- Fiche Les grilles à compléter (CM1) - logique, notion 'grilles'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les grilles à compléter', $fiche$
[titre]La règle de la grille[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Chaque symbole apparaît [b]une seule fois[/b] dans chaque ligne et [b]une seule fois[/b] dans chaque colonne.[/cadre]
[page]
[titre]Ce qui manque dans la ligne[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Dans la 3e ligne, il y a déjà ▲ et ●. Il manque [b]■[/b].[/cadre]
[page]
[titre]Je vérifie avec la colonne[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]■[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=30][b][color=white]■[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]▲[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]●[/b][/font_size][/center][/cell][/table]
[cadre]Dans la 1re colonne : ▲, ●, et ma réponse ■. Les trois sont différents : [b]c'est juste ![/b][/cadre]
[cadre=astuce]On voit aussi que chaque ligne est la ligne d'avant [b]décalée d'une case[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Chaque symbole : [b]une fois[/b] par ligne et [b]une fois[/b] par colonne.
• Je regarde la ligne de la case vide : quel symbole manque ?
• Je vérifie avec la colonne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'grilles'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
