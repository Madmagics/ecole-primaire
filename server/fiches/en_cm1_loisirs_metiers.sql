-- Fiche Loisirs et métiers (CM1) - anglais, notion 'en_loisirs_metiers'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'english', 'Loisirs et métiers', $fiche$
[titre]Loisirs et métiers[/titre]
[cadre]Les activités finissent souvent par [b]-ing[/b] : swimm[b][color=#C62828]ing[/color][/b], danc[b][color=#C62828]ing[/color][/b], read[b][color=#C62828]ing[/color][/b].[/cadre]
[cadre=astuce]Pour un métier, on met [b]a[/b] ou [b]an[/b] : She is [b]a[/b] doctor. He is [b]an[/b] artist.[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Les métiers[/color][/b][/font_size][/center]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]boulanger[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]baker[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]fermier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]farmer[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]infirmier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]nurse[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]médecin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]doctor[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]pompier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]firefighter[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b] [/b][/font_size][/center][/cell][/table]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je joue du tambour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I play the drum[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]je joue du violon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]I play the violin[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]Activités en -ing (swimming). Métier : a / an (She is a doctor).[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_loisirs_metiers'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
