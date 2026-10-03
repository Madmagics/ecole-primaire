-- Fiche La météo et la nature (CP) - anglais, notion 'en_meteo_nature'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'english', 'La météo et la nature', $fiche$
[titre]Le temps qu'il fait[/titre]
[cadre]It's sunny = il fait beau · It's raining = il pleut · It's cold = il fait froid[/cadre]
[cadre=astuce]Pour parler du temps, on commence par [b]It's[/b] (it is).[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Le temps qu'il fait[/color][/b][/font_size][/center]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ensoleillé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]sunny[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]neigeux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]snowy[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]nuageux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]cloudy[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]pluvieux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]rainy[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]venteux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]windy[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b] [/b][/font_size][/center][/cell][/table]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il y a du soleil[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]It's sunny[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]il pleut[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]It's rainy[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]Pour le temps qu'il fait : It's sunny, It's raining.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_meteo_nature'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
