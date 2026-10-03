-- Fiche Les fractions (CM1) - notion 'fractions'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Les fractions', $fiche$
[titre]Lire une fraction[/titre]
[tarte parts=4 colorees=3]
[center][font_size=34][b]3/4[/b][/font_size][/center]
[cadre]• Le nombre du bas, le [b]dénominateur[/b], dit en combien de parts égales on coupe : 4.
• Le nombre du haut, le [b]numérateur[/b], dit combien de parts on prend : 3.
On lit « [b]trois quarts[/b] ».[/cadre]
[page]
[titre]Les noms des fractions[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1/2[/b] un demi[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1/3[/b] un tiers[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]3/4[/b] trois quarts[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]2/5[/b] deux cinquièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]5/6[/b] cinq sixièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]3/7[/b] trois septièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]1/8[/b] un huitième[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]4/9[/b] quatre neuvièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center][b]7/10[/b] sept dixièmes[/center][/cell][/table]
[cadre]À partir de 5 parts, le dénominateur se lit avec [b]-ième[/b] : cinquième, sixième…[/cadre]
[page]
[titre]Une fraction sur une bande[/titre]
La bande est coupée en [b]8 parts égales[/b]. J'en colorie 3 :
[cases n=8 bleu=3]
[cadre]La partie coloriée représente [b]3/8[/b] de la bande.
Si je colorie les 8 parts : [b]8/8 = 1[/b], toute la bande.[/cadre]
[page]
[titre]Plus petit ou plus grand que 1 ?[/titre]
[droite de=0 a=2 parts=8 points=3,4,5 noms=fraction]
[cadre]• Numérateur [b]plus petit[/b] que le dénominateur : moins que 1. 3/4 < 1.
• Numérateur [b]égal[/b] au dénominateur : 4/4 = 1.
• Numérateur [b]plus grand[/b] : plus que 1. 5/4 > 1.[/cadre]
[page]
[titre]Comparer : même dénominateur[/titre]
Si les parts sont de [b]la même taille[/b], celui qui en prend le plus a le plus grand morceau.
[tarte parts=7,7 colorees=2,4]
[cadre][b]2/7 < 4/7[/b] : je compare les numérateurs, 2 < 4.[/cadre]
[page]
[titre]Comparer : même numérateur[/titre]
Plus on coupe en [b]beaucoup de parts[/b], plus les parts sont [b]petites[/b].
[tarte parts=5,7 colorees=4,4]
[cadre]4/5 et 4/7 : on prend 4 parts, mais les cinquièmes sont plus gros que les septièmes.
Donc [b]4/5 > 4/7[/b].[/cadre]
[page]
[titre]Des fractions égales[/titre]
[tarte parts=3,6 colorees=1,2 noms=oui]
[cadre]1 part sur 3, c'est autant que 2 parts sur 6 : [b]1/3 = 2/6[/b].
Je multiplie le numérateur et le dénominateur [b]par le même nombre[/b] : la fraction ne change pas.[/cadre]
[cadre=astuce]1/3 ou 2/7 ? 1/3 = 2/6, et 2/6 > 2/7. Donc [b]1/3 > 2/7[/b].[/cadre]
[page]
[titre]Additionner des fractions[/titre]
Avec le [b]même dénominateur[/b], j'additionne les numérateurs. Le dénominateur ne change pas.
[center][font_size=30][b]2/5 + 2/5 = 4/5[/b][/font_size][/center]
[cadre]2 cinquièmes + 2 cinquièmes = 4 cinquièmes. [b]Attention[/b] : ce n'est pas 4/10 !
6/8 + 2/8 = 8/8 = [b]1[/b].[/cadre]
[page]
[titre]La fraction d'une quantité[/titre]
Les [b]2/3 de 12 billes[/b] : je partage 12 en 3, puis j'en prends 2 parts.
[billes groupes=4,4,4 couleurs=bleu,bleu,jaune signes=non]
[cadre]1/3 de 12 = 12 : 3 = 4. Donc 2/3 de 12 = 4 x 2 = [b]8 billes[/b].[/cadre]
[page]
[titre]Avec des grands nombres[/titre]
[cadre]• Les [b]2/3 de 36[/b] : 36 : 3 = 12, puis 12 x 2 = [b]24[/b].
• Les [b]5/6 de 36[/b] : 36 : 6 = 6, puis 6 x 5 = [b]30[/b].[/cadre]
[cadre=astuce]Je divise par le nombre du [b]bas[/b], puis je multiplie par le nombre du [b]haut[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 3/4 : 4 = dénominateur (parts égales), 3 = numérateur (parts prises).
• 4/4 = 1. Numérateur plus petit : moins que 1.
• Même dénominateur : le plus grand numérateur gagne. Même numérateur : le plus petit dénominateur gagne.
• 1/3 = 2/6 : je multiplie en haut et en bas par le même nombre.
• 2/5 + 2/5 = 4/5 : le dénominateur ne change pas.
• 2/3 de 36 : 36 : 3 = 12, puis 12 x 2 = 24.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'fractions'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
