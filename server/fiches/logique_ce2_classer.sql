-- Fiche Classer et ranger (CE2) - logique, notion 'classer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Classer et ranger', $fiche$
[titre]Je fais une échelle[/titre]
[center]Tom est plus grand que Léo. Léo est plus grand que Nolan.[/center]
[table=1][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]↑ le plus grand[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Tom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]Nolan[/font_size][/center][/cell][/table]
[center][b]↓ le plus petit[/b][/center]
[cadre]Je place les enfants du plus grand (en haut) au plus petit (en bas).
Le plus grand est [b]Tom[/b], le plus petit est [b]Nolan[/b].[/cadre]
[page]
[titre]Le prénom qui revient[/titre]
[cadre]« Tom est plus grand que [b]Léo[/b]. [b]Léo[/b] est plus grand que Nolan. »
Léo est dans les deux phrases : il est plus petit que Tom mais plus grand que Nolan.
Léo est donc [b]au milieu[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]deux fois[/b] est toujours celui du milieu.[/cadre]
[page]
[titre]Ni le plus grand, ni le plus petit[/titre]
« Qui n'est ni le plus grand, ni le plus petit ? »
[cadre]On cherche celui qui est [b]au milieu[/b] de l'échelle.
Avec Tom, Léo et Nolan, c'est [b]Léo[/b].[/cadre]
[cadre=astuce]Ce n'est jamais « impossible à savoir » : les deux phrases suffisent toujours à ranger les trois enfants.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je dessine une [b]échelle[/b] : le plus grand en haut, le plus petit en bas.
• Le prénom qui revient dans [b]les deux phrases[/b] est au milieu.
• « Ni le plus grand, ni le plus petit » = celui [b]du milieu[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'classer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
