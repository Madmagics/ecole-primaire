-- Fiche L'aire (CM1) - notion 'aire'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'L''aire', $fiche$
[titre]Qu'est-ce que l'aire ?[/titre]
L'[b]aire[/b], c'est la [b]place à l'intérieur[/b] d'une figure : ce qu'on colorie.
[grille lignes=3 colonnes=5]
[cadre]Ce rectangle est fait de [b]15 carreaux[/b] : 3 rangées de 5. Son aire est de 15 carreaux.
Le [b]périmètre[/b], lui, c'est le tour : la clôture autour du jardin.[/cadre]
[page]
[titre]Le centimètre carré[/titre]
Un carré de [b]1 cm de côté[/b] a une aire de [b]1 centimètre carré[/b]. On écrit [b]1 cm²[/b] (ou cm2).
[grille lignes=3 colonnes=5]
[cadre]Si chaque carreau mesure 1 cm de côté, ce rectangle a une aire de [b]15 cm²[/b].[/cadre]
[cadre=astuce]Pour une grande surface, on utilise le [b]m²[/b] : un carré de 1 m de côté.[/cadre]
[page]
[titre]L'aire du rectangle[/titre]
Plutôt que de compter les carreaux, je multiplie :
[center][font_size=26][b]Aire = longueur x largeur[/b][/font_size][/center]
[rect long=20 larg=18 unite=cm]
[cadre]20 x 18 = [b]360 cm²[/b].[/cadre]
[page]
[titre]L'aire du carré[/titre]
Le carré a sa longueur égale à sa largeur :
[center][font_size=26][b]Aire = côté x côté[/b][/font_size][/center]
[rect long=8 larg=8 unite=cm]
[cadre]8 x 8 = [b]64 cm²[/b].[/cadre]
[page]
[titre]Avec des grands nombres[/titre]
Pour un rectangle de [b]24 cm sur 16 cm[/b], je décompose la multiplication :
[cadre]24 x 16 = 24 x 10 + 24 x 6 = 240 + 144 = [b]384 cm²[/b].[/cadre]
[cadre=astuce]Ordre de grandeur : 25 x 15 ≈ 375. 384 est possible ![/cadre]
[page]
[titre]Aire ou périmètre ?[/titre]
Un rectangle de [b]6 cm sur 2 cm[/b] :
[cadre]• Son [b]périmètre[/b] : (6 + 2) x 2 = 16 [b]cm[/b] : une longueur.
• Son [b]aire[/b] : 6 x 2 = 12 [b]cm²[/b] : une surface.[/cadre]
[cadre=astuce]Ce ne sont pas les mêmes calculs ni les mêmes unités : cm pour le tour, [b]cm²[/b] pour l'intérieur.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'aire est la surface à l'intérieur d'une figure.
• 1 cm² = l'aire d'un carré de 1 cm de côté.
• Rectangle : longueur x largeur. 20 x 18 = 360 cm².
• Carré : côté x côté. 8 x 8 = 64 cm².
• Aire en [b]cm²[/b], périmètre en [b]cm[/b] : ne les confonds pas ![/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'aire'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
