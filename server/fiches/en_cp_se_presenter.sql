-- Fiche Se présenter (CP) - anglais, notion 'en_se_presenter'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'english', 'Se présenter', $fiche$
[titre]Me présenter[/titre]
[cadre]je m'appelle Léo = [b]My name is[/b] Léo
j'ai six ans = [b]I'm six years old[/b]
quel âge as-tu ? = [b]How old are you?[/b][/cadre]
[cadre=astuce]Pour l'âge, on dit « I'm » (je suis) et pas « I have ».[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]j'ai quatre ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I'm four years old[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]j'ai cinq ans[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]I'm five years old[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je m'appelle Tom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]My name is Tom[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]comment tu t'appelles ?[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]What's your name?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]quel âge as-tu ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]How old are you?[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]je suis un garçon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]I'm a boy[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je suis une fille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I'm a girl[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]My name is… ; I'm six years old ; How old are you?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_se_presenter'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
