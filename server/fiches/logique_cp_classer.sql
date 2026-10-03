-- Fiche Classer : le plus grand, le plus petit (CP) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'logique', 'Classer : le plus grand, le plus petit', $fiche$
[titre]Du plus petit au plus grand[/titre]
Je range les animaux selon leur taille [b]dans la vraie vie[/b].
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐝[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐶[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐴[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=30]🐘[/font_size][/center][/cell][/table]
[center][b]le plus petit  ———————→  le plus grand[/b][/center]
[cadre]L'abeille 🐝 est [b]la plus petite[/b]. L'éléphant 🐘 est [b]le plus grand[/b].[/cadre]
[page]
[titre]Attention aux dessins ![/titre]
Sur l'écran, tous les dessins ont [b]la même taille[/b].
[table=2][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐘[/font_size][/center][/cell][/table]
[cadre]Je ne regarde pas la taille du dessin.
J'imagine [b]le vrai animal[/b] : une souris tient dans la main, un éléphant est plus haut qu'une maison ![/cadre]
[page]
[titre]Trouver le plus grand[/titre]
[center]Quel est l'animal le plus grand ?[/center]
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐔[/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=34][color=white]🐻[/color][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐭[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=34]🐸[/font_size][/center][/cell][/table]
[cadre]1. J'imagine chaque animal pour de vrai.
2. Je les compare deux par deux : l'ours est plus grand que la poule.
3. Le plus grand, c'est [b]l'ours [/b]🐻.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je pense à la taille des animaux [b]dans la vraie vie[/b].
• Le [b]plus petit[/b] est au début du rang, le [b]plus grand[/b] à la fin.
• Je relis la question : le plus grand ou le plus petit ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
