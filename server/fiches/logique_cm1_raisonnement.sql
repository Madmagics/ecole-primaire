-- Fiche Raisonner et déduire (CM1) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Raisonner et déduire', $fiche$
[titre]Avant, après[/titre]
[cadre]Dans une course, arriver [b]avant[/b] quelqu'un, c'est arriver [b]plus tôt[/b] : on est devant lui au classement.[/cadre]
[center]Inès arrive avant Hugo. Hugo arrive avant Lucas.[/center]
Inès est devant Hugo, et Hugo est devant Lucas.
[page]
[titre]Je fais le podium[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]1er[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]2e[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]3e (dernier)[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Inès[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Hugo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Lucas[/font_size][/center][/cell][/table]
[cadre]Qui arrive en premier ? [b]Inès[/b]. En 2e position ? [b]Hugo[/b]. En dernier ? [b]Lucas[/b].[/cadre]
[page]
[titre]Si l'ordre est mélangé[/titre]
[center]Hugo arrive avant Lucas. Inès arrive avant Hugo.[/center]
[cadre]Les phrases ne sont pas dans l'ordre, mais je fais pareil :
je place d'abord Hugo devant Lucas, puis Inès devant Hugo : [b]Inès, Hugo, Lucas[/b].[/cadre]
[cadre=astuce]Je commence toujours par le prénom qui apparaît [b]deux fois[/b] : il est 2e.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Arriver [b]avant[/b] = être devant au classement.
• J'écris le classement : 1er, 2e, 3e.
• Le prénom cité dans [b]les deux phrases[/b] est en 2e position.
• Je relis la question : premier, 2e ou dernier ?[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
