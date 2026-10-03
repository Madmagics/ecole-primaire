-- Fiche L'aire (CM2) - notion 'aire'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'L''aire', $fiche$
[titre]Rappel[/titre]
[rect long=25 larg=13 unite=cm]
[cadre]Aire du rectangle = longueur x largeur : 25 x 13 = 250 + 75 = [b]325 cm²[/b].
Aire du carré = côté x côté.[/cadre]
[page]
[titre]Les unités d'aire[/titre]
[cadre]• [b]1 cm²[/b] : un carré de 1 cm de côté (un timbre fait quelques cm²).
• [b]1 m²[/b] : un carré de 1 m de côté (une chambre fait environ 10 m²).
• [b]1 km²[/b] : un carré de 1 km de côté (pour une ville).[/cadre]
[cadre=astuce]1 m² = 100 cm x 100 cm = [b]10 000 cm²[/b], et pas 100 cm² ![/cadre]
[page]
[titre]Une figure en plusieurs morceaux[/titre]
Chaque carreau mesure 1 cm de côté. Pour l'aire de cette figure en L :
[grille lignes=4 colonnes=6 forme=6,6,3,3]
[cadre]Méthode 1, j'additionne : rectangle du haut 6 x 2 = 12, du bas 3 x 2 = 6. 12 + 6 = [b]18 cm²[/b].
Méthode 2, j'enlève : grand rectangle 6 x 4 = 24, moins le coin vide 3 x 2 = 6. 24 - 6 = [b]18 cm²[/b].[/cadre]
[page]
[titre]Même aire, autre périmètre[/titre]
[cadre]• Rectangle de 6 cm sur 2 cm : aire 6 x 2 = [b]12 cm²[/b], périmètre (6 + 2) x 2 = [b]16 cm[/b].
• Rectangle de 4 cm sur 3 cm : aire 4 x 3 = [b]12 cm²[/b], périmètre (4 + 3) x 2 = [b]14 cm[/b].[/cadre]
[cadre=astuce]Deux figures peuvent avoir la même aire et des périmètres différents.[/cadre]
[page]
[titre]Retrouver une longueur[/titre]
[cadre]• Un rectangle a une aire de [b]54 cm²[/b] et une largeur de [b]6 cm[/b].
Longueur : 54 : 6 = [b]9 cm[/b], car 9 x 6 = 54.
• Un carré a une aire de [b]49 cm²[/b]. Quel nombre fois lui-même fait 49 ? 7 x 7 = 49 : côté [b]7 cm[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Rectangle : longueur x largeur. Carré : côté x côté.
• Unités : cm², m², km². 1 m² = 10 000 cm².
• Figure en morceaux : j'additionne les rectangles, ou j'enlève ce qui manque.
• Même aire ne veut pas dire même périmètre.
• Longueur = aire : largeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'aire'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
