-- Fiche Le périmètre (CE1) - notion 'perimetre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Le périmètre', $fiche$
[titre]Le périmètre, c'est quoi ?[/titre]
Une fourmi fait le tour d'un jardin rectangulaire, en marchant sur le bord.
Le chemin qu'elle parcourt, c'est le [b]périmètre[/b] du jardin.
[rect long=10 larg=6 unite=m]
[cadre]Le périmètre, c'est [b]la longueur du tour[/b] d'une figure.[/cadre]
[page]
[titre]Le rectangle[/titre]
Un rectangle a [b]4 côtés[/b] : 2 longs côtés égaux, et 2 petits côtés égaux.
[rect long=10 larg=6 unite=cm]
[cadre]• Le grand côté s'appelle [b]la longueur[/b] : ici 10 cm.
• Le petit côté s'appelle [b]la largeur[/b] : ici 6 cm.[/cadre]
[page]
[titre]Calculer le périmètre[/titre]
Pour faire le tour, j'additionne [b]les 4 côtés[/b] :
[center][font_size=30][b]10 + 6 + 10 + 6 = 32[/b][/font_size][/center]
[rect long=10 larg=6 unite=cm]
[cadre]Le périmètre de ce rectangle est [b]32 cm[/b]. Je n'oublie pas l'unité : les cm.[/cadre]
[page]
[titre]Une astuce plus rapide[/titre]
Il y a 2 longueurs et 2 largeurs : je les regroupe.
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6]2 longueurs[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]2 largeurs[/cell][cell border=#classe padding=14,6,14,6]le tour[/cell][cell border=#classe padding=14,6,14,6][b]10 + 10 = 20[/b][/cell][cell border=#unites padding=14,6,14,6][b]6 + 6 = 12[/b][/cell][cell border=#classe padding=14,6,14,6][b]20 + 12 = 32 cm[/b][/cell][/table]
[cadre=astuce]Ou bien : une longueur + une largeur, c'est un demi-tour : 10 + 6 = 16.
Le tour complet, c'est le [b]double[/b] : 16 + 16 = 32 cm.[/cadre]
[page]
[titre]Le carré[/titre]
Un carré a [b]4 côtés de la même longueur[/b].
[rect long=5 larg=5 unite=cm]
[cadre]Périmètre : 5 + 5 + 5 + 5 = [b]20 cm[/b]. C'est aussi 4 fois 5 : 4 x 5 = 20.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]périmètre[/b], c'est la longueur du tour d'une figure.
• Rectangle : j'additionne les 4 côtés. 10 + 6 + 10 + 6 = 32 cm.
• Plus vite : 2 longueurs + 2 largeurs, ou le double de longueur + largeur.
• Carré : 4 côtés égaux. 5 + 5 + 5 + 5 = 20 cm.
• J'écris toujours l'[b]unité[/b] : cm, m…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'perimetre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
