-- Fiche Mesures et conversions (CM2) - notion 'mesures'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Mesures et conversions', $fiche$
[titre]Un seul tableau à retenir[/titre]
[table=7][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]kilo[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]hecto[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]déca[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]unité[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]déci[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]centi[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]milli[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]km[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dam[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]m[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]kg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dag[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]g[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]kL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]daL[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]L[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mL[/center][/cell][/table]
[cadre]Longueurs, masses et contenances utilisent [b]les mêmes préfixes[/b] : chaque colonne vaut 10 fois celle de droite.[/cadre]
[page]
[titre]Convertir un nombre décimal[/titre]
Pour [b]2,5 km[/b] en m : le chiffre des [b]unités[/b] (2) va dans la colonne [b]km[/b].
[table=4][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]km[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dam[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]m[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]2,[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]5[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]Puis je complète avec des 0 jusqu'aux m : 2,5 km = [b]2500 m[/b].
Et 14 kg = [b]14 000 g[/b] · 3 L = [b]300 cL[/b].[/cadre]
[page]
[titre]Dans l'autre sens[/titre]
Pour [b]750 g[/b] en kg : le 0 des unités va dans la colonne [b]g[/b], puis je lis en kg.
[table=4][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]kg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dag[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]g[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0,[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]7[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]5[/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]750 g = [b]0,75 kg[/b]. Et 1250 m = [b]1,25 km[/b].[/cadre]
[cadre=astuce]Vers une unité plus grande, le nombre devient [b]plus petit[/b].[/cadre]
[page]
[titre]La tonne[/titre]
Pour les objets très lourds, on utilise la [b]tonne[/b] (t) : [b]1 t = 1000 kg[/b].
[cadre]• 5 t = 5 x 1000 = [b]5000 kg[/b].
• Une voiture pèse environ 1 t. Un éléphant, environ 5 t.[/cadre]
[page]
[titre]Les durées ne comptent pas par 10 ![/titre]
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 h = 60 min[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 min = 60 s[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 jour = 24 h[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]3 h = [b]180 min[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]4 min = [b]240 s[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]2 jours = [b]48 h[/b][/center][/cell][/table]
[cadre]Piège : [b]1,5 h[/b], c'est 1 h et une demi-heure : 1 h [b]30[/b] min, soit 90 min.
Ce n'est pas 1 h 50 min ![/cadre]
[page]
[titre]Calculer avec des durées[/titre]
Un film de [b]2 h 45 min[/b], puis un autre de [b]1 h 30 min[/b]. Combien de temps en tout ?
[cadre]Heures : 2 + 1 = 3 h. Minutes : 45 + 30 = [b]75 min[/b].
75 min = 60 min + 15 min = 1 h 15 min. Total : 3 h + 1 h 15 min = [b]4 h 15 min[/b].[/cadre]
[page]
[titre]Choisir la bonne unité[/titre]
[table=2][cell border=#classe padding=12,3,12,3][center]l'épaisseur d'une pièce[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]2 mm[/center][/cell][cell border=#classe padding=12,3,12,3][center]la hauteur d'une porte[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]2 m[/center][/cell][cell border=#classe padding=12,3,12,3][center]la distance Paris - Lyon[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]465 km[/center][/cell][cell border=#classe padding=12,3,12,3][center]la masse d'un camion[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]10 t[/center][/cell][cell border=#classe padding=12,3,12,3][center]une bouteille d'eau[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]1,5 L[/center][/cell][cell border=#classe padding=12,3,12,3][center]une cuillère de sirop[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]5 mL[/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Mêmes préfixes pour m, g et L : kilo, hecto, déca, déci, centi, milli.
• Le chiffre des unités va dans la colonne de l'unité, puis je complète avec des 0.
• 2,5 km = 2500 m · 750 g = 0,75 kg · 1 t = 1000 kg.
• Durées : 1 h = 60 min, 1 min = 60 s. 1,5 h = 1 h 30 min.
• 75 min = 1 h 15 min.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mesures'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
