-- Fiche Le périmètre (CE2) - notion 'perimetre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Le périmètre', $fiche$
[titre]Le périmètre, rappel[/titre]
Le [b]périmètre[/b], c'est [b]la longueur du tour[/b] d'une figure.
[rect long=16 larg=10 unite=cm]
[cadre]Pour faire le tour, j'additionne les 4 côtés : 16 + 10 + 16 + 10 = [b]52 cm[/b].[/cadre]
[page]
[titre]Une formule plus rapide[/titre]
Une longueur + une largeur, c'est [b]la moitié du tour[/b]. Le tour complet, c'est le double :
[center][font_size=26][b]Périmètre = (longueur + largeur) x 2[/b][/font_size][/center]
[cadre](16 + 10) x 2 = 26 x 2 = [b]52 cm[/b]. Je calcule d'abord ce qui est entre parenthèses.[/cadre]
[page]
[titre]Avec des grands nombres[/titre]
Un rectangle de longueur [b]75 cm[/b] et de largeur [b]71 cm[/b] :
[rect long=75 larg=71 unite=cm]
[cadre]75 + 71 = 146. Puis 146 x 2 = 146 + 146 = [b]292 cm[/b].[/cadre]
[page]
[titre]Le carré[/titre]
Un carré a [b]4 côtés égaux[/b]. Un rectangle de longueur 7 cm et de largeur 7 cm, c'est un carré !
[rect long=7 larg=7 unite=cm]
[cadre]Périmètre : 4 fois le côté. 4 x 7 = [b]28 cm[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]périmètre[/b], c'est la longueur du tour d'une figure.
• Rectangle : (longueur + largeur) x 2. (16 + 10) x 2 = 52 cm.
• Carré : 4 x le côté. 4 x 7 = 28 cm.
• Si la longueur et la largeur sont égales, c'est un carré.
• J'écris toujours l'[b]unité[/b] : cm, m…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'perimetre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
