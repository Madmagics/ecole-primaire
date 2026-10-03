-- Fiche Les fractions (CM2) - notion 'fractions'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Les fractions', $fiche$
[titre]Rappel[/titre]
[tarte parts=8 colorees=3]
[cadre][b]3/8[/b] : on coupe en [b]8[/b] parts égales (le dénominateur) et on en prend [b]3[/b] (le numérateur).
On lit « trois huitièmes ».[/cadre]
[page]
[titre]Additionner des fractions[/titre]
Même dénominateur : j'additionne les numérateurs, [b]je garde le dénominateur[/b].
[cadre]• 2/7 + 3/7 = [b]5/7[/b]
• 3/10 + 1/10 = [b]4/10[/b]
• 6/11 + 5/11 = [b]11/11 = 1[/b][/cadre]
[cadre=astuce]Jamais 2/7 + 3/7 = 5/14 : les parts restent des septièmes ![/cadre]
[page]
[titre]Plus grand que 1[/titre]
[droite de=0 a=2 parts=8 points=4,7 noms=fraction]
[cadre][b]7/4[/b] : 4 quarts font 1 unité, il reste 3 quarts.
7/4 = 4/4 + 3/4 = [b]1 + 3/4[/b].[/cadre]
[page]
[titre]Les fractions décimales[/titre]
Une fraction de dénominateur 10, 100 ou 1000 s'écrit facilement avec une virgule :
[table=3][cell bg=#dixiemes_clair border=#dixiemes padding=14,6,14,6][center][b]3/10 = 0,3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=14,6,14,6][center][b]75/100 = 0,75[/b][/center][/cell][cell bg=#milliemes_clair border=#milliemes padding=14,6,14,6][center][b]8/1000 = 0,008[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]3 dixièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center]75 centièmes[/center][/cell][cell border=#classe padding=14,6,14,6][center]8 millièmes[/center][/cell][/table]
[cadre=astuce]Le nombre de 0 du dénominateur = le nombre de chiffres après la virgule.[/cadre]
[page]
[titre]Sur la droite graduée[/titre]
Entre 0 et 1, la droite est coupée en [b]10 dixièmes[/b] :
[droite de=0 a=1 parts=10 points=3,9 noms=decimal]
[cadre]0,3 est au même endroit que [b]3/10[/b], et 0,9 au même endroit que [b]9/10[/b].[/cadre]
[page]
[titre]Des fractions égales[/titre]
[tarte parts=2,4 colorees=1,2 noms=oui]
[cadre]1/2 = 2/4 = 5/10 = 50/100 = [b]0,5[/b]
1/4 = 25/100 = [b]0,25[/b] · 3/4 = 75/100 = [b]0,75[/b][/cadre]
[cadre=astuce]Je multiplie le numérateur et le dénominateur par le même nombre : la fraction ne change pas.[/cadre]
[page]
[titre]Écrire une fraction en décimal[/titre]
Pour [b]8/25[/b] : je cherche par combien multiplier 25 pour obtenir [b]100[/b]. 25 x 4 = 100.
[cadre]8/25 = (8 x 4)/(25 x 4) = 32/100 = [b]0,32[/b]
1/20 = 5/100 = [b]0,05[/b] (car 20 x 5 = 100)
2/5 = 4/10 = [b]0,4[/b] (car 5 x 2 = 10)[/cadre]
[page]
[titre]Comparer fractions et décimaux[/titre]
Qui est le plus grand : [b]3/5[/b] ou [b]0,7[/b] ?
[cadre]J'écris 3/5 en décimal : 3/5 = 6/10 = [b]0,6[/b].
0,6 < 0,7, donc [b]3/5 < 0,7[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Même dénominateur : j'additionne les numérateurs, je garde le dénominateur.
• 7/4 = 1 + 3/4 : une fraction peut dépasser 1.
• 3/10 = 0,3 · 75/100 = 0,75 · 8/1000 = 0,008.
• 1/2 = 0,5 · 1/4 = 0,25 · 3/4 = 0,75.
• Pour écrire en décimal, j'obtiens 10, 100 ou 1000 en bas : 8/25 = 32/100 = 0,32.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'fractions'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
