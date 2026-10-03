-- Fiche Classer et ranger (CM1) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Classer et ranger', $fiche$
[titre]Plus âgé, plus jeune[/titre]
[cadre]Plus [b]âgé[/b] = plus vieux, né [b]avant[/b].
Plus [b]jeune[/b] = moins vieux, né [b]après[/b].[/cadre]
Ce sont des [b]contraires[/b] : si Emma est plus âgée que Sarah, alors Sarah est plus jeune qu'Emma.
[page]
[titre]Tout dire dans le même sens[/titre]
[center]Camille est plus âgée que Sarah. Emma est plus jeune que Sarah.[/center]
[cadre]Les deux phrases ne vont pas dans le même sens. Je retourne la 2e :
« Emma est plus jeune que Sarah » = « Sarah est [b]plus âgée[/b] qu'Emma ».
Donc : [b]Camille[/b] > Sarah > Emma.[/cadre]
[page]
[titre]Je range sur une frise[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la plus âgée[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]au milieu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la plus jeune[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Camille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Sarah[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Emma[/font_size][/center][/cell][/table]
[cadre]Qui est le plus âgé ? [b]Camille[/b]. Qui est le plus jeune ? [b]Emma[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]dans les deux phrases[/b] est toujours au milieu.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus âgé et plus jeune sont des [b]contraires[/b].
• Je retourne une phrase pour que les deux disent [b]la même chose[/b] (plus âgé que…).
• Je range les prénoms sur une frise, du plus âgé au plus jeune.
• Le prénom qui revient deux fois est [b]au milieu[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
