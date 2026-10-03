-- Fiche Le futur proche (CM2) - anglais, notion 'en_futur'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'english', 'Le futur proche', $fiche$
[titre]Je vais…[/titre]
[cadre]je vais nager = [b]I'm going to[/b] swim
je vais lire = [b]I'm going to[/b] read[/cadre]
[cadre=astuce]I'm going to + verbe : c'est comme « je vais + verbe » en français.[/cadre]
[page]
[titre]Les mots à connaître[/titre]
[center][font_size=22][b][color=#classe]Des phrases modèles[/color][/b][/font_size][/center]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]français[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]anglais[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je vais jouer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]I'm going to play[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]je vais regarder[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]I'm going to watch[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]I'm going to + verbe = je vais + verbe.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'en_futur'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
