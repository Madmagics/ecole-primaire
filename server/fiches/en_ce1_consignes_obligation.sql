-- Fiche Pouvoir, devoir (CE1) - anglais, notion 'en_consignes_obligation'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'english', 'Pouvoir, devoir', $fiche$
[titre]Je sais, je ne sais pas[/titre]
[cadre]je sais nager = [b]I can[/b] swim
je ne sais pas grimper = [b]I can't[/b] climb[/cadre]
[cadre=astuce]Après can, le verbe ne change pas : I can run, she can run.[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je sais nager[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I can swim[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]je ne sais pas nager[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]I can't swim[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]I can = je sais ; I can't = je ne sais pas.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_consignes_obligation'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
