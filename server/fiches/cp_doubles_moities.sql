-- Fiche Doubles et moitiés (CP) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Doubles et moitiés', $fiche$
[titre]Le double[/titre]
Le [b]double[/b] d'un nombre, c'est ce nombre [b]deux fois[/b].
Le double de 4, c'est 4 + 4 :
[billes groupes=4,4 couleurs=bleu,bleu total=oui]
[cadre]Le double de 4, c'est [b]8[/b].[/cadre]
[page]
[titre]Les doubles à connaître[/titre]
Il faut connaître ces doubles par cœur :
[table=5][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]1 + 1 = 2[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]2 + 2 = 4[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]3 + 3 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]4 + 4 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]5 + 5 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]6 + 6 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]7 + 7 = 14[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]8 + 8 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]9 + 9 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=10,6,10,6][b]10 + 10 = 20[/b][/cell][/table]
[cadre=astuce]Les doubles sont toujours des nombres [b]pairs[/b].[/cadre]
[page]
[titre]Le double d'une dizaine[/titre]
Le double de [b]40[/b] : 4 dizaines et encore 4 dizaines.
[cubes d=4 u=0 vers=8:0 fleche=double]
[cadre]4 dizaines + 4 dizaines = 8 dizaines.
Le double de 40, c'est [b]80[/b], comme le double de 4, c'est 8.[/cadre]
[page]
[titre]Le double d'un grand nombre[/titre]
Pour le double de [b]13[/b], je fais le double des dizaines et le double des unités.
[cubes d=1 u=3 vers=2:6 fleche=double]
Double de 10 = [b]20[/b]. Double de 3 = [b]6[/b].
[cadre]20 + 6 = [b]26[/b]. Le double de 13, c'est 26.[/cadre]
[page]
[titre]La moitié[/titre]
Prendre la [b]moitié[/b], c'est partager en [b]2 parts égales[/b].
J'ai 8 billes. Je les partage avec mon copain, pareil pour chacun :
[billes groupes=4,4 couleurs=bleu,rouge]
[cadre]Chacun a 4 billes. La moitié de 8, c'est [b]4[/b].[/cadre]
[page]
[titre]Double et moitié vont ensemble[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 4, c'est 8.[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 8, c'est 4.[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]Le double de 7, c'est 14.[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]La moitié de 14, c'est 7.[/b][/cell][/table]
[cadre=astuce]Pour trouver une moitié, je cherche quel nombre a ce [b]double[/b].
La moitié de 10 ? Le double de 5 fait 10, donc c'est [b]5[/b].[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]26[/b], je partage les dizaines et je partage les unités.
[cubes d=2 u=6 vers=1:3 fleche=moitié]
Moitié de 20 = [b]10[/b]. Moitié de 6 = [b]3[/b]. Donc la moitié de 26, c'est [b]13[/b].
[cadre=astuce]Pour la moitié de [b]34[/b], je coupe 34 en 20 et 14 :
moitié de 20 = 10, moitié de 14 = 7, et 10 + 7 = [b]17[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]double[/b] : le nombre deux fois. Double de 4 = 4 + 4 = 8.
• La [b]moitié[/b] : partager en 2 parts égales. Moitié de 8 = 4.
• Double et moitié vont ensemble : double de 7 = 14, moitié de 14 = 7.
• Pour un grand nombre, je m'occupe des dizaines puis des unités.
• Double de 13 = 20 + 6 = 26. Moitié de 26 = 10 + 3 = 13.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
