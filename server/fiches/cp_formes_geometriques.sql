-- Fiche Les formes géométriques (CP) - notion 'formes_geometriques'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Les formes géométriques', $fiche$
[titre]Les formes[/titre]
Autour de nous, on trouve des formes : une fenêtre, un panneau, une roue…
[formes liste=carre,rectangle,triangle,rond]
[cadre]Chaque forme a un [b]nom[/b]. Pour les reconnaître, je compte leurs [b]côtés[/b].[/cadre]
[page]
[titre]Côtés et sommets[/titre]
[formes liste=triangle cotes=oui]
Un [b]côté[/b], c'est un trait bien droit. Un [b]sommet[/b], c'est un coin (les points orange).
[cadre]Le triangle a [b]3 côtés[/b] et 3 sommets.[/cadre]
[cadre=astuce]Pour compter les côtés, je pose le doigt sur un sommet et je fais le tour en comptant chaque trait.[/cadre]
[page]
[titre]Le carré et le rectangle[/titre]
[formes liste=carre,rectangle cotes=oui]
Les deux ont [b]4 côtés[/b] et 4 coins bien droits.
[cadre]• Le [b]carré[/b] : ses 4 côtés ont [b]la même longueur[/b].
• Le [b]rectangle[/b] : 2 côtés longs et 2 côtés courts.[/cadre]
[page]
[titre]Le losange[/titre]
[formes liste=losange,carre cotes=oui]
Le losange a [b]4 côtés de la même longueur[/b], comme le carré.
[cadre]Mais ses coins ne sont pas droits : il a l'air penché, comme un cerf-volant.[/cadre]
[page]
[titre]Le rond[/titre]
[formes liste=rond cotes=oui]
Le rond n'a [b]aucun trait droit[/b] : son bord est tout arrondi.
[cadre]Le rond a [b]0 côté[/b] et aucun sommet. On l'appelle aussi un [b]cercle[/b].[/cadre]
[page]
[titre]Plus de côtés[/titre]
[formes liste=pentagone,hexagone cotes=oui]
[cadre]• Le [b]pentagone[/b] a [b]5 côtés[/b].
• L'[b]hexagone[/b] a [b]6 côtés[/b].[/cadre]
Je compte toujours en faisant le tour avec le doigt, pour ne pas oublier de côté.
[page]
[titre]Je retiens[/titre]
[formes liste=triangle,carre,rectangle cotes=oui]
[formes liste=losange,pentagone,rond cotes=oui]
[cadre]Pour trouver le nombre de côtés, je fais le tour de la forme en comptant les traits droits.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'formes_geometriques'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
