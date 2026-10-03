-- Fiche Les verbes d'action (CE2) - anglais, notion 'en_verbes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'english', 'Les verbes d''action', $fiche$
[titre]Les verbes[/titre]
[cadre]je lis = [b]I read[/b] · je nage = [b]I swim[/b][/cadre]
[cadre=astuce]Avec I, le verbe ne change pas : I read, I swim, I sing.[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je commence[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I start[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]je trouve[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]I find[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]Avec I, le verbe ne change pas : I read, I swim.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_verbes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
