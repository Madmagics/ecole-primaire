-- Fiche La division (CM2) - notion 'division'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'La division', $fiche$
[titre]Rappel[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]dividende[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]diviseur[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]quotient[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]reste[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]138[/center][/cell][cell border=#classe padding=14,6,14,6][center]8[/center][/cell][cell border=#classe padding=14,6,14,6][center]17[/center][/cell][cell border=#classe padding=14,6,14,6][center]2[/center][/cell][/table]
[center][font_size=28][b]138 = (8 x 17) + 2[/b][/font_size][/center]
[cadre]Le reste est toujours [b]plus petit que le diviseur[/b] : 2 < 8.[/cadre]
[page]
[titre]Diviser par un nombre à 2 chiffres[/titre]
Pour [b]300 : 13[/b], j'écris d'abord le début de la table de 13 :
[center][b]13 · 26 · 39 · 52 · 65 · 78 · 91 · 104 · 117[/b][/center]
[potence dividende=300 diviseur=13]
[cadre]Dans 30 : 2 fois (26), reste 4. J'abaisse 0 → 40 : 3 fois (39), reste 1. Quotient [b]23[/b], reste [b]1[/b].[/cadre]
[page]
[titre]Estimer chaque chiffre[/titre]
Dans [b]40[/b], combien de fois [b]13[/b] ? J'arrondis 13 à 10 : dans 40, 4 fois 10.
[cadre]J'essaie 4 : 13 x 4 = 52, c'est [b]trop grand[/b] (52 > 40). J'essaie 3 : 13 x 3 = 39. C'est bon !
Le reste 40 - 39 = 1 est bien plus petit que 13.[/cadre]
[cadre=astuce]Si le reste est plus grand que le diviseur, mon chiffre est [b]trop petit[/b] : j'ajoute 1.[/cadre]
[page]
[titre]Combien de chiffres au quotient ?[/titre]
Pour [b]290 : 12[/b], j'encadre avec 10 et 100 :
[cadre]12 x 10 = 120 et 12 x 100 = 1200. 290 est entre les deux : le quotient a [b]2 chiffres[/b].[/cadre]
[potence dividende=290 diviseur=12]
[cadre]290 : 12 → quotient [b]24[/b], reste [b]2[/b]. Vérification : (12 x 24) + 2 = 288 + 2 = 290.[/cadre]
[page]
[titre]Diviser par 10, 100[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]59 : 10[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]quotient 5, reste 9[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]59 : 10 = 5,9[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]avec la virgule[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]350 : 100 = 3,5[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]la virgule recule de 2 rangs[/center][/cell][/table]
[cadre]Diviser par 10, 100, 1000 : chaque chiffre prend une valeur 10, 100, 1000 fois [b]plus petite[/b].
La virgule se déplace [b]vers la gauche[/b].[/cadre]
[page]
[titre]Continuer après la virgule[/titre]
On partage [b]30 euros[/b] entre [b]4 enfants[/b]. 30 : 4 → quotient 7, reste 2.
[cadre]Il reste 2 euros : je les transforme en [b]20 dixièmes[/b] (20 x 0,10 euro).
20 dixièmes : 4 = 5 dixièmes. Donc 30 : 4 = [b]7,5[/b]. Chaque enfant a [b]7,50 euros[/b].[/cadre]
[page]
[titre]Divisible ou pas ?[/titre]
Si le reste est 0, le nombre est [b]divisible[/b]. Des règles pour le voir sans calculer :
[cadre]• Par [b]2[/b] : il est pair. Par [b]5[/b] : il finit par 0 ou 5. Par [b]10[/b] : il finit par 0.
• Par [b]3[/b] : la somme de ses chiffres est dans la table de 3. 138 → 1 + 3 + 8 = 12 : oui ! 138 : 3 = 46.
• Par [b]9[/b] : la somme de ses chiffres est dans la table de 9. 288 → 2 + 8 + 8 = 18 : oui ! 288 : 9 = 32.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Dividende = (diviseur x quotient) + reste, avec reste < diviseur.
• Par un nombre à 2 chiffres : j'écris le début de sa table.
• J'estime chaque chiffre en arrondissant le diviseur, puis j'ajuste.
• J'encadre avec x 10 et x 100 pour connaître le nombre de chiffres du quotient.
• : 10, : 100 → la virgule recule. Le reste peut continuer après la virgule : 30 : 4 = 7,5.
• Divisible par 3 ou 9 : somme des chiffres dans la table de 3 ou 9.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'division'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
