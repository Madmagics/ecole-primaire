-- Fiche Les suites logiques (CM1) - logique, notion 'suites_logiques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les suites logiques', $fiche$
[titre]Une multiplication, puis une addition[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]5[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]15[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]17[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]51[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 3[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]x 3[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 2[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]L'écart change sans arrêt (+10, +2, +34) : ce n'est pas une addition simple.
Je teste : 5 [b]x 3[/b] = 15, 15 [b]+ 2[/b] = 17, 17 [b]x 3[/b] = 51. Ensuite : 51 + 2 = [b]53[/b].[/cadre]
[page]
[titre]Monter, descendre[/titre]
[table=9][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]19[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]25[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]17[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][b]23[/b][/font_size][/center][/cell][cell padding=4,4,4,4][/cell][cell bg=#unites_clair border=#unites padding=10,4,10,4][center][font_size=26][b]?[/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]- 8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]+ 6[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][cell padding=4,2,4,2][center][font_size=20][b][color=#unites]- 8[/color][/b][/font_size][/center][/cell][cell padding=4,2,4,2][/cell][/table]
[cadre]La suite monte, puis descend : [b]+6 puis -8[/b], et ainsi de suite.
23 - 8 = [b]15[/b].[/cadre]
[cadre=astuce]Je vérifie ma règle sur [b]tous[/b] les nombres de la suite, pas seulement les deux premiers.[/cadre]
[page]
[titre]Une lettre et un nombre[/titre]
[center][font_size=28][b]E5, G7, I9, K11, …[/b][/font_size][/center]
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]E[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]G[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]I[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]K[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]5[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]7[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]9[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]11[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[cadre]Je sépare la suite en [b]deux suites[/b] : les lettres E, G, I, K (je saute une lettre) → [b]M[/b] ; les nombres +2 → [b]13[/b].
La réponse est [b]M13[/b].[/cadre]
[page]
[titre]Les nombres carrés[/titre]
Le [b]carré[/b] d'un nombre, c'est ce nombre multiplié [b]par lui-même[/b].
[grille lignes=3 colonnes=3]
[cadre]Le carré de 3 = 3 x 3 = [b]9[/b] : un carré de 3 cases sur 3 cases.
Les carrés : 1, 4, 9, 16, 25, 36, 49, 64, [b]81[/b] (9 x 9), 100.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. J'écris les écarts. Ils sont pareils ? C'est une addition ou une soustraction.
2. Ils alternent ? [b]Deux règles[/b] (+6 puis -8).
3. Ils grandissent vite ? Je teste une [b]multiplication[/b] (x 2, x 3…).
4. Lettres et nombres mélangés ? Je fais [b]deux suites séparées[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Une suite peut avoir [b]deux opérations[/b] qui alternent : x 3 puis + 2.
• Pour « E5, G7… », je traite les [b]lettres[/b] et les [b]nombres[/b] séparément.
• Le carré d'un nombre : ce nombre [b]x lui-même[/b] (9 x 9 = 81).
• Je vérifie ma règle sur toute la suite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_logiques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
