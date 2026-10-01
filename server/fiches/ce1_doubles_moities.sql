-- Fiche Doubles, moitiés, tiers, quarts (CE1) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Doubles, moitiés, tiers, quarts', $fiche$
[titre]Double et moitié, rappel[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 12[/b], c'est 12 + 12 = 24.[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 24[/b], c'est 12 : 12 + 12 = 24.[/cell][/table]
[billes groupes=4,4 couleurs=bleu,rouge signes=non]
[cadre]Prendre la moitié, c'est partager en [b]2 parts égales[/b]. La moitié de 8, c'est 4.[/cadre]
[page]
[titre]Partager en parts égales[/titre]
Une tarte coupée en 2, en 3 ou en 4 parts égales :
[tarte parts=2,3,4 colorees=1 noms=oui]
[cadre]• Partager en [b]2[/b] : chaque part est [b]une moitié[/b].
• Partager en [b]3[/b] : chaque part est [b]un tiers[/b].
• Partager en [b]4[/b] : chaque part est [b]un quart[/b].[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]98[/b], je coupe 98 en deux nombres faciles : 80 et 18.
[cubes d=9 u=8 vers=4:9 fleche=moitié]
Moitié de 80 = [b]40[/b]. Moitié de 18 = [b]9[/b]. Donc la moitié de 98, c'est [b]49[/b].
[cadre=astuce]Je vérifie avec le double : 49 + 49 = 98. La moitié de 100, c'est 50.[/cadre]
[page]
[titre]Le tiers[/titre]
Prendre le tiers, c'est partager en [b]3 parts égales[/b].
J'ai 12 billes. Je les partage entre 3 enfants :
[billes groupes=4,4,4 couleurs=bleu,rouge,vert signes=non]
[cadre]Chacun a 4 billes. Le tiers de 12, c'est [b]4[/b] : 4 + 4 + 4 = 12.[/cadre]
[page]
[titre]Le tiers d'un grand nombre[/titre]
Pour le tiers de [b]93[/b], je partage les dizaines, puis les unités.
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6]Tiers de 90[/cell][cell border=#classe padding=14,6,14,6][b]30[/b], car 30 + 30 + 30 = 90[/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]Tiers de 3[/cell][cell border=#unites padding=14,6,14,6][b]1[/b], car 1 + 1 + 1 = 3[/cell][/table]
[cadre]Le tiers de 93, c'est 30 + 1 = [b]31[/b]. Je vérifie : 31 + 31 + 31 = 93.[/cadre]
[page]
[titre]Le quart[/titre]
Prendre le quart, c'est partager en [b]4 parts égales[/b].
J'ai 8 billes. Je les partage entre 4 enfants :
[billes groupes=2,2,2,2 couleurs=bleu,rouge,vert,orange signes=non]
Le quart de 8, c'est [b]2[/b] : 2 + 2 + 2 + 2 = 8.
[cadre=astuce]Le quart, c'est [b]la moitié de la moitié[/b] !
Quart de 96 : moitié de 96 = 48, puis moitié de 48 = [b]24[/b].
Quart de 100 : moitié de 100 = 50, puis moitié de 50 = [b]25[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]double[/b] : le nombre deux fois. Double de 12 = 24.
• La [b]moitié[/b] : 2 parts égales. Moitié de 98 = 40 + 9 = 49.
• Le [b]tiers[/b] : 3 parts égales. Tiers de 12 = 4, car 4 + 4 + 4 = 12.
• Le [b]quart[/b] : 4 parts égales, c'est la moitié de la moitié. Quart de 100 = 25.
• Pour un grand nombre, je partage les dizaines puis les unités.
• Je vérifie toujours en rassemblant les parts.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
