-- Fiche Le périmètre (CM1) - notion 'perimetre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Le périmètre', $fiche$
[titre]Le périmètre du rectangle[/titre]
Le [b]périmètre[/b], c'est la longueur du [b]tour[/b] de la figure.
[rect long=29 larg=12 unite=cm]
[cadre](longueur + largeur) x 2 = (29 + 12) x 2 = 41 x 2 = [b]82 cm[/b].[/cadre]
[page]
[titre]Une autre façon de calculer[/titre]
Il y a [b]2 longueurs[/b] et [b]2 largeurs[/b] :
[center][font_size=26][b]29 x 2 + 12 x 2 = 58 + 24 = 82 cm[/b][/font_size][/center]
[cadre]Les deux façons donnent [b]le même périmètre[/b] : choisis celle qui te paraît la plus simple.[/cadre]
[page]
[titre]N'importe quel polygone[/titre]
Pour faire le tour d'une figure, j'[b]additionne tous ses côtés[/b].
[formes liste=triangle,pentagone]
[cadre]• Un triangle de côtés 5 cm, 7 cm et 9 cm : 5 + 7 + 9 = [b]21 cm[/b].
• Un pentagone de 5 côtés égaux de 6 cm : 5 x 6 = [b]30 cm[/b].[/cadre]
[page]
[titre]Retrouver un côté[/titre]
[cadre]• Un carré a un périmètre de [b]36 cm[/b]. Ses 4 côtés sont égaux : 36 : 4 = [b]9 cm[/b].
• Un rectangle a un périmètre de [b]30 cm[/b] et une longueur de [b]10 cm[/b].
Une longueur + une largeur = la moitié du tour : 30 : 2 = 15. Largeur : 15 - 10 = [b]5 cm[/b].[/cadre]
[page]
[titre]La même unité partout[/titre]
Un rectangle mesure [b]1 m[/b] de long et [b]40 cm[/b] de large.
[cadre]Je convertis d'abord : 1 m = [b]100 cm[/b].
Puis (100 + 40) x 2 = 140 x 2 = [b]280 cm[/b].[/cadre]
[cadre=astuce](1 + 40) x 2 = 82 : c'est faux, j'ai mélangé les mètres et les centimètres ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le périmètre est la longueur du tour.
• Rectangle : (longueur + largeur) x 2. Carré : côté x 4.
• Autre polygone : j'additionne tous les côtés.
• Côté d'un carré = périmètre : 4.
• Toutes les longueurs dans [b]la même unité[/b] avant de calculer.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'perimetre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
