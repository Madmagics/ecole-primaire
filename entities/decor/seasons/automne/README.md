# Skins "automne"

Dépose ici un `.tscn` avec le **même nom de fichier** qu'un décor de base (`entities/decor/*.tscn`
dont la racine porte le script `seasonal_skin.gd`, ex : `tree.tscn`, `flower_bed.tscn`) pour que
ce décor affiche automatiquement cette version pendant la saison "automne" (septembre, octobre,
novembre, voir `data/decor/season.gd`).

Aucune structure interne imposée : la scène peut être entièrement différente du décor de base
(mesh, matériaux, collision...), elle remplace tout son contenu.

Exemple : `entities/decor/seasons/automne/tree.tscn` habille chaque arbre du jeu en feuillage
orangé pendant cette saison, sans toucher à `park.tscn`.
