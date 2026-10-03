-- Toutes les fiches Maths CM1 en une transaction (2026-10-03).
begin;
-- Fiche L'addition (CM1) - notion 'addition'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'L''addition', $fiche$
[titre]Les nombres décimaux[/titre]
Un nombre décimal a une [b]partie entière[/b] et une [b]partie décimale[/b], séparées par [b]la virgule[/b].
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
[cadre]Dans [b]12,75[/b] : 12 unités, [b]7 dixièmes[/b] et [b]5 centièmes[/b].
La virgule se place toujours [b]juste après le chiffre des unités[/b].[/cadre]
[page]
[titre]Dixièmes et centièmes[/titre]
Je coupe une unité en [b]10 parts égales[/b] : chaque part est [b]un dixième[/b] (0,1).
[cases n=10 bleu=7]
[cadre]7 parts sur 10 : [b]7 dixièmes = 0,7[/b]. Et 10 dixièmes font 1 unité.
Si je coupe un dixième en 10, j'obtiens [b]un centième[/b] (0,01).[/cadre]
[cadre=astuce]Pense à l'argent : 1 euro = 100 centimes. 0,75 euro = [b]75 centimes[/b].[/cadre]
[page]
[titre]Poser une addition[/titre]
Je place [b]la virgule sous la virgule[/b] : les unités sont alors sous les unités, les dixièmes sous les dixièmes…
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
[cadre]Je calcule comme avec des nombres entiers, en commençant [b]par la droite[/b].
Puis je recopie la virgule [b]au même endroit[/b] dans le résultat : [b]15,79[/b].[/cadre]
[page]
[titre]La retenue saute la virgule[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
Centièmes : 5 + 0 = 5. Dixièmes : 2 + 8 = [b]10[/b] : j'écris 0 et je retiens 1 [b]dans les unités[/b].
Unités : 1 + 8 + 5 = 14 : j'écris 4, je retiens 1. Dizaines : 1 + 1 = 2.
[cadre]10 dixièmes font 1 unité : la retenue passe par-dessus la virgule. [b]8,25 + 15,80 = 24,05[/b][/cadre]
[page]
[titre]Pas le même nombre de chiffres[/titre]
Pour [b]9,6 + 3,71[/b] : 9,6 n'a pas de centièmes. J'ajoute [b]un 0[/b] pour bien aligner.
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]1[/b][/center][/cell][/table]
[cadre]9,6 = [b]9,60[/b] : 6 dixièmes, c'est 60 centièmes. Le 0 ne change pas le nombre.
Un nombre entier aussi : 7 = [b]7,00[/b].[/cadre]
[page]
[titre]Calculer de tête[/titre]
[cadre]• Ajouter [b]0,1[/b], c'est ajouter 1 dixième : 3,46 + 0,1 = [b]3,56[/b].
• Ajouter [b]0,01[/b], c'est ajouter 1 centième : 3,46 + 0,01 = [b]3,47[/b].
• 4,5 + 0,5 = [b]5[/b] : 5 dixièmes + 5 dixièmes = 1 unité.
• 2,75 + 0,25 = [b]3[/b] : 75 centièmes + 25 centièmes = 1 unité.[/cadre]
[cadre=astuce]Cherche les nombres qui « font 1 » ensemble, comme 0,75 et 0,25 (75 + 25 = 100).[/cadre]
[page]
[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]19,57 + 23,75[/b], j'arrondis à l'unité : [b]20 + 24 = 44[/b].
[cadre]Je trouve 43,32 : c'est tout près de 44, mon résultat est possible.
Si je trouve 4,332 ou 433,2, je sais que [b]ma virgule est mal placée[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 12,75 : partie entière 12, puis 7 [b]dixièmes[/b] et 5 [b]centièmes[/b].
• 10 centièmes = 1 dixième. 10 dixièmes = 1 unité.
• Pour poser : [b]virgule sous virgule[/b]. Je complète avec des 0 : 9,6 = 9,60.
• Je calcule de droite à gauche ; la retenue peut passer la virgule.
• Je replace la virgule dans le résultat, puis je vérifie avec un ordre de grandeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'addition'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La soustraction (CM1) - notion 'soustraction'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La soustraction', $fiche$
[titre]Soustraire des décimaux[/titre]
Comme pour l'addition : [b]virgule sous virgule[/b], et je commence par la droite.
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
[cadre]17,87 - 14,77 = [b]3,10[/b]. Le 0 à la fin ne sert à rien : 3,10 = [b]3,1[/b].[/cadre]
[page]
[titre]Pas assez dans une colonne ?[/titre]
Pour [b]15,28 - 8,94[/b] : dixièmes, 2 - 9, impossible ! Puis unités, 5 - 8, impossible aussi.
Tu connais [b]deux méthodes[/b], elles marchent aussi avec la virgule :
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]Le cassage[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]La compensation[/b][/center][/cell][cell border=#classe padding=14,6,14,6]je casse 1 unité en 10 dixièmes[/cell][cell border=#unites padding=14,6,14,6]10 dixièmes en haut, 1 unité en bas[/cell][/table]
[cadre]Garde [b]la méthode de ta classe[/b] : les deux donnent le même résultat.[/cadre]
[page]
[titre]Méthode 1 : le cassage[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]0[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]14[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]5[/s][/color][/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b][color=#C62828][s]2[/s][/color][/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
Centièmes : 8 - 4 = 4. Dixièmes : je casse 1 unité, 2 devient [b]12[/b] : 12 - 9 = 3.
Unités : il reste 4, je casse 1 dizaine, 4 devient [b]14[/b] : 14 - 8 = 6. Dizaines : 0.
[cadre][b]15,28 - 8,94 = 6,34[/b][/cadre]
[page]
[titre]Méthode 2 : la compensation[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]2[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]8[color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
Centièmes : 8 - 4 = 4. Dixièmes : 10 dixièmes en haut (12) et 1 unité en bas (8 + 1 = 9) : 12 - 9 = 3.
Unités : 10 unités en haut (15) et 1 dizaine en bas : 15 - 9 = 6. Dizaines : 1 - 1 = 0.
[cadre]Même résultat : [b]6,34[/b].[/cadre]
[page]
[titre]Soustraire d'un nombre rond[/titre]
Pour [b]10 - 3,46[/b], je peux poser 10,00 - 3,46. Ou j'avance [b]par bonds[/b] de 3,46 jusqu'à 10 :
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]3,46 → 4[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]4 → 10[/center][/cell][cell bg=#centaines_clair border=#centaines padding=14,6,14,6][center][b]En tout[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center][b]+ 0,54[/b][/center][/cell][cell border=#unites padding=14,6,14,6][center][b]+ 6[/b][/center][/cell][cell border=#centaines padding=14,6,14,6][center][b]6 + 0,54 = 6,54[/b][/center][/cell][/table]
[cadre][b]10 - 3,46 = 6,54[/b]. Pour aller à 4, il manque 54 centièmes : 46 + 54 = 100.[/cadre]
[page]
[titre]Vérifier avec une addition[/titre]
J'ajoute ce que j'ai enlevé : je dois retrouver le nombre du départ.
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
[cadre]6,54 + 3,46 = 10 : ma soustraction est juste.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Virgule sous virgule[/b], et je complète avec des 0 : 10 = 10,00.
• Je commence par la droite. Pas assez ? Cassage ou compensation : [b]la méthode de ma classe[/b].
• 3,10 = 3,1 : un 0 tout à la fin de la partie décimale ne change rien.
• Pour un nombre rond, j'avance par bonds : 3,46 → 4 → 10.
• Je vérifie avec une addition.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'soustraction'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La multiplication (CM1) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La multiplication', $fiche$
[titre]Multiplier par 10, 100, 1000[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 10 = 730[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]un 0[/b] à droite[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 100 = 7300[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]deux 0[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]73 x 1000 = 73000[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]j'écris [b]trois 0[/b][/center][/cell][/table]
[cadre]Fois 10, chaque chiffre prend une valeur [b]10 fois plus grande[/b] : les 3 unités deviennent 3 dizaines.[/cadre]
[page]
[titre]Multiplier par 20, 30, 200…[/titre]
20, c'est 2 x 10. Pour multiplier par 20, je multiplie [b]par 2, puis par 10[/b].
[center][font_size=26][b]79 x 20 = 79 x 2 x 10[/b][/font_size][/center]
[cadre]79 x 2 = 158, puis 158 x 10 = [b]1580[/b].[/cadre]
[cadre=astuce]Pareil pour 300 : 12 x 300 = 12 x 3 x 100 = 36 x 100 = [b]3600[/b].[/cadre]
[page]
[titre]Décomposer pour calculer de tête[/titre]
[cadre]• [b]18 x 11[/b] = 18 x 10 + 18 x 1 = 180 + 18 = [b]198[/b]
• [b]19 x 9[/b] = 19 x 10 - 19 = 190 - 19 = [b]171[/b]
• [b]22 x 6[/b] = 20 x 6 + 2 x 6 = 120 + 12 = [b]132[/b][/cadre]
[cadre=astuce]Je coupe un nombre en morceaux faciles, je multiplie chaque morceau, puis j'ajoute.[/cadre]
[page]
[titre]Poser une multiplication[/titre]
Je multiplie chaque chiffre du haut par 4, [b]en commençant par les unités[/b].
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]x[/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
Unités : 3 x 4 = [b]12[/b], j'écris 2 et je retiens 1.
[cadre]Dizaines : 7 x 4 = 28, plus la retenue : 28 + 1 = [b]29[/b]. 73 x 4 = [b]292[/b].[/cadre]
[page]
[titre]Multiplier par un nombre à 2 chiffres[/titre]
Pour [b]49 x 13[/b] : 13 = 3 + 10. Je fais [b]deux lignes[/b], puis je les additionne.
[table=4][cell padding=10,4,10,4][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][b]x[/b][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#centaines padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]9[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]1re ligne : 49 x 3 = [b]147[/b]. 2e ligne : 49 x 10 = [b]490[/b] (je commence par écrire le [color=#C62828]0[/color]).
147 + 490 = [b]637[/b].[/cadre]
[page]
[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]85 x 18[/b], j'arrondis : 90 x 20 = [b]1800[/b].
[cadre]Je trouve 1530 : c'est le même ordre de grandeur, mon résultat est possible.
Si je trouve 765, j'ai sûrement oublié le 0 de la 2e ligne ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Fois 10, 100, 1000 : j'écris un, deux ou trois 0 à droite.
• Fois 20 : fois 2, puis fois 10.
• Je décompose : 18 x 11 = 180 + 18. 19 x 9 = 190 - 19.
• Pour poser, je commence par les unités et je n'oublie pas [b]les retenues[/b].
• Par un nombre à 2 chiffres : 2 lignes, la 2e commence par un 0, puis j'additionne.
• Je vérifie avec un ordre de grandeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La division (CM1) - notion 'division'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La division', $fiche$
[titre]Quand le partage ne tombe pas juste[/titre]
Je partage [b]14 billes[/b] entre [b]3 enfants[/b] : chacun en a 4, et il en reste 2.
[billes groupes=4,4,4,2 couleurs=bleu,rouge,vert,jaune signes=non]
[cadre]14 divisé par 3 : le [b]quotient[/b] est 4 (la part de chacun), le [b]reste[/b] est 2.[/cadre]
[page]
[titre]Les mots de la division[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]dividende[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]diviseur[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]quotient[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]reste[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]14[/center][/cell][cell border=#classe padding=14,6,14,6][center]3[/center][/cell][cell border=#classe padding=14,6,14,6][center]4[/center][/cell][cell border=#classe padding=14,6,14,6][center]2[/center][/cell][/table]
[center][font_size=28][b]14 = (3 x 4) + 2[/b][/font_size][/center]
[cadre]Le reste est toujours [b]plus petit que le diviseur[/b] : 2 < 3.
Sinon, je pourrais encore donner une bille à chacun ![/cadre]
[page]
[titre]Diviser avec les tables[/titre]
Pour [b]80 : 9[/b], je cherche dans la table de 9 le résultat le plus proche, [b]sans dépasser 80[/b].
[cadre]9 x 8 = 72 et 9 x 9 = 81 : 81 dépasse 80, je prends [b]9 x 8 = 72[/b].
Quotient : [b]8[/b]. Reste : 80 - 72 = [b]8[/b]. Et 8 < 9 : c'est bon ![/cadre]
[page]
[titre]Poser une division[/titre]
[potence dividende=293 diviseur=6]
[cadre]• Dans [b]2[/b], pas de 6. Je prends [b]29[/b] : 6 x 4 = 24, j'écris 4. 29 - 24 = 5.
• J'abaisse le 3 : [b]53[/b]. 6 x 8 = 48, j'écris 8. 53 - 48 = 5.
293 : 6 → quotient [b]48[/b], reste [b]5[/b].[/cadre]
[page]
[titre]Combien de chiffres au quotient ?[/titre]
Avant de poser [b]293 : 6[/b], j'encadre le quotient avec 10 et 100 :
[cadre]6 x 10 = 60 et 6 x 100 = 600. 293 est entre 60 et 600.
Le quotient est donc entre 10 et 100 : il a [b]2 chiffres[/b].[/cadre]
[cadre=astuce]Si je trouve un quotient à 1 ou 3 chiffres, je me suis trompé quelque part.[/cadre]
[page]
[titre]Un quotient à 3 chiffres[/titre]
[potence dividende=416 diviseur=3]
[cadre]Dans 4 : 1 fois 3, reste 1. J'abaisse le 1 → 11 : 3 x 3 = 9, reste 2. J'abaisse le 6 → 26 : 3 x 8 = 24, reste 2.
416 : 3 → quotient [b]138[/b], reste [b]2[/b].[/cadre]
[page]
[titre]Vérifier[/titre]
Je multiplie le quotient par le diviseur, puis j'ajoute le reste : je dois retrouver le dividende.
[center][font_size=26][b](3 x 138) + 2 = 414 + 2 = 416[/b][/font_size][/center]
[cadre]C'est bien 416 : ma division est juste. Et le reste 2 est plus petit que 3.[/cadre]
[page]
[titre]Que faire du reste ?[/titre]
On range [b]125 œufs[/b] dans des boîtes de [b]6[/b]. 125 : 6 → quotient 20, reste 5.
[cadre]• Combien de boîtes [b]pleines[/b] ? [b]20[/b] boîtes.
• Combien d'œufs restent hors des boîtes pleines ? [b]5[/b] œufs.
• Combien de boîtes pour [b]tout[/b] ranger ? 20 + 1 = [b]21[/b] boîtes.[/cadre]
[cadre=astuce]Je relis la question pour savoir si je garde le quotient, le reste… ou le quotient + 1.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Dividende = (diviseur x quotient) + reste. 14 = (3 x 4) + 2.
• Le reste est toujours [b]plus petit que le diviseur[/b].
• J'utilise les tables : le plus grand résultat [b]sans dépasser[/b].
• Pour poser : je prends assez de chiffres, je soustrais, j'abaisse le chiffre suivant.
• J'encadre le quotient (x 10, x 100) pour savoir combien il a de chiffres.
• Je vérifie : (diviseur x quotient) + reste = dividende.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'division'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Les grands nombres (CM1) - notion 'numeration'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Les grands nombres', $fiche$
[titre]Les classes[/titre]
Pour lire un grand nombre, je fais des paquets de 3 chiffres en partant de la droite : [b]les classes[/b].
[table=6][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][font_size=18]mille[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][font_size=18]unités[/font_size][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]C[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]D[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]U[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]C[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]D[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]U[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]5[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]3[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]8[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]7[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]2[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]1[/b][/center][/cell][/table]
[cadre]On lit classe par classe : [b]cinq cent trente-huit mille sept cent vingt et un[/b].
On laisse [b]un espace[/b] entre les classes : 538 721.[/cadre]
[page]
[titre]Le nom de chaque chiffre[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=12,3,12,3][center][b]5[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]centaines de mille[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center][b]3[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]dizaines de mille[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center][b]8[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]unités de mille[/b] (les milliers)[/center][/cell][cell bg=#unites_clair border=#unites padding=12,3,12,3][center][b]7[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]centaines[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=12,3,12,3][center][b]2[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]dizaines[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=12,3,12,3][center][b]1[/b][/center][/cell][cell border=#classe padding=12,3,12,3][center]chiffre des [b]unités[/b][/center][/cell][/table]
[cadre]Dans la classe des mille, on retrouve [b]centaines, dizaines, unités[/b], comme dans la classe des unités.[/cadre]
[page]
[titre]Chiffre des… ou nombre de… ?[/titre]
Dans [b]538 721[/b] :
[cadre]• le [b]chiffre[/b] des milliers, c'est [b]8[/b] : un seul chiffre ;
• le [b]nombre[/b] de milliers, c'est [b]538[/b] : tout ce qui est à gauche, chiffre des milliers compris.[/cadre]
[cadre=astuce]538 721, c'est 538 paquets de mille, plus 721. Lis bien la question : « chiffre » ou « nombre » ?[/cadre]
[page]
[titre]Décomposer un grand nombre[/titre]
[center][font_size=26][b]130 368 = 100 000 + 30 000 + 300 + 60 + 8[/b][/font_size][/center]
[cadre]Le chiffre des milliers est [b]0[/b] : il n'y a aucun millier en plus, mais il garde sa place.
Sans ce 0, j'écrirais 13 368 : un tout autre nombre ![/cadre]
[page]
[titre]Le million[/titre]
[center][font_size=30][b]999 999 + 1 = 1 000 000[/b][/font_size][/center]
[cadre]Après 999 999, on arrive à [b]un million[/b] : 1 000 000, avec six 0.
Un million, c'est [b]mille milliers[/b]. Il ouvre une nouvelle classe : la classe des millions.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je sépare les classes par paquets de 3 chiffres, en partant de la droite : 538 721.
• Classe des mille : centaines de mille, dizaines de mille, unités de mille.
• « Chiffre des milliers » : 8. « Nombre de milliers » : 538.
• Un 0 garde la place d'un chiffre : 130 368.
• 1 000 000 = un million = mille milliers.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'numeration'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Comparer des nombres décimaux (CM1) - notion 'comparer_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Comparer des nombres décimaux', $fiche$
[titre]D'abord la partie entière[/titre]
Pour comparer deux nombres décimaux, je regarde d'abord [b]ce qui est avant la virgule[/b].
[center][font_size=30][b]20,87 > 15,06[/b][/font_size][/center]
[cadre]20 est plus grand que 15, donc [b]20,87 > 15,06[/b]. Pas besoin de regarder après la virgule.[/cadre]
[page]
[titre]Même partie entière[/titre]
Je compare chiffre par chiffre après la virgule : [b]les dixièmes d'abord[/b], puis les centièmes.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][/table]
[cadre]Unités : 8 et 8, égales. Dixièmes : [b]6 < 7[/b]. Donc [b]8,64 < 8,78[/b].[/cadre]
[page]
[titre]Attention au piège ![/titre]
Qui est le plus grand : [b]8,5[/b] ou [b]8,47[/b] ? Le nombre le plus long n'est pas forcément le plus grand.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]J'ajoute un 0 : 8,5 = 8,50. Dixièmes : [b]5 > 4[/b]. Donc [b]8,5 > 8,47[/b].[/cadre]
[cadre=astuce]Avec des euros : 8,50 euros, c'est plus que 8,47 euros ![/cadre]
[page]
[titre]Les zéros utiles et inutiles[/titre]
[cadre]• Un 0 [b]tout à la fin[/b] de la partie décimale ne change rien : 6,20 = [b]6,2[/b] et 15,10 = [b]15,1[/b].
• Un 0 [b]juste après la virgule[/b] compte : 6,02 n'est pas 6,2 ![/cadre]
[droite de=6 a=7 parts=10 points=2 noms=decimal]
[cadre=astuce]6,2 = 6 unités et 2 dixièmes. 6,02 = 6 unités et 2 centièmes : c'est bien plus petit.[/cadre]
[page]
[titre]Sur une droite graduée[/titre]
Entre 0 et 1, je compte de dixième en dixième. [b]Plus un nombre est à droite, plus il est grand[/b].
[droite de=0 a=1 parts=10 points=3,7 noms=decimal]
[cadre]0,3 est à gauche de 0,7 : [b]0,3 < 0,7[/b].[/cadre]
[page]
[titre]Ranger des nombres décimaux[/titre]
Ranger du plus petit au plus grand : 1,43 · 1,22 · 1,4 · 1,3
[cadre]Même partie entière : 1. J'écris tout avec 2 chiffres après la virgule :
1,43 · 1,22 · 1,40 · 1,30. Je compare les dixièmes, puis les centièmes.
[b]1,22 < 1,3 < 1,4 < 1,43[/b][/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je compare d'abord [b]la partie entière[/b] : 20,87 > 15,06.
• Si elle est égale : les [b]dixièmes[/b], puis les [b]centièmes[/b].
• Le plus long n'est pas toujours le plus grand : 8,5 > 8,47.
• J'ajoute des 0 à la fin pour avoir autant de chiffres : 8,5 = 8,50.
• 6,2 = 6,20 mais 6,2 ≠ 6,02.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'comparer_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La proportionnalité (CM1) - notion 'proportionnalite'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La proportionnalité', $fiche$
[titre]Deux fois plus, deux fois plus cher[/titre]
Un stylo coûte [b]2 euros[/b]. Deux stylos coûtent 4 euros, trois stylos 6 euros…
[cadre]Si j'achète [b]2 fois plus[/b] de stylos, je paie [b]2 fois plus[/b].
Si j'en achète 3 fois plus, je paie 3 fois plus. Le prix est [b]proportionnel[/b] au nombre de stylos.[/cadre]
[page]
[titre]Le tableau de proportionnalité[/titre]
[table=5][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Nombre de stylos[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]1[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]3[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]6[/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Prix en euros[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]6[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]12[/b][/center][/cell][/table]
[cadre]Pour passer de la 1re ligne à la 2e, je multiplie [b]toujours par le même nombre[/b] : ici, [b]x 2[/b].
1 x 2 = 2 · 3 x 2 = 6 · 6 x 2 = 12.[/cadre]
[page]
[titre]Méthode 1 : passer par 1[/titre]
Pour [b]6 billes[/b], on paie [b]30 euros[/b]. Combien paie-t-on pour [b]18 billes[/b] ?
[cadre]• Je cherche le prix d'[b]une[/b] bille : 30 : 6 = [b]5 euros[/b].
• Puis pour 18 billes : 18 x 5 = [b]90 euros[/b].[/cadre]
On paie [b]90 euros[/b] pour 18 billes.
[page]
[titre]Méthode 2 : multiplier la quantité[/titre]
Même problème : 6 billes coûtent 30 euros. Et 18 billes ?
[cadre]18, c'est [b]3 fois[/b] 6 (6 x 3 = 18). Donc le prix est aussi 3 fois plus grand :
30 x 3 = [b]90 euros[/b].[/cadre]
[cadre=astuce]Les deux méthodes donnent le même résultat. Choisis la plus facile selon les nombres.[/cadre]
[page]
[titre]Méthode 3 : additionner[/titre]
2 cahiers coûtent [b]12 euros[/b]. Combien coûtent [b]12 cahiers[/b] ?
[table=4][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Cahiers[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]10[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]12 = 2 + 10[/b][/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Prix[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]12[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]60[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]12 + 60 = 72[/b][/center][/cell][/table]
[cadre]10 cahiers = 5 fois 2 cahiers : 12 x 5 = 60 euros. Puis 2 + 10 cahiers : 12 + 60 = [b]72 euros[/b].[/cadre]
[page]
[titre]Ce n'est pas toujours proportionnel[/titre]
[cadre]• À 5 ans, Léa mesure 1 m 10. À 10 ans, elle ne mesurera pas 2 m 20 !
• Un paquet de 1 kg de pâtes coûte 2 euros, mais un paquet de 5 kg peut coûter moins de 10 euros.[/cadre]
[cadre=astuce]Avant de calculer, je me demande : « 2 fois plus de… donne-t-il vraiment 2 fois plus de… ? »[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Proportionnel : 2 fois plus de stylos → 2 fois plus cher.
• Dans un tableau, on passe d'une ligne à l'autre en multipliant [b]toujours par le même nombre[/b].
• Méthode 1 : je cherche le prix d'[b]un seul[/b] objet.
• Méthode 2 : je cherche [b]combien de fois[/b] plus d'objets.
• Méthode 3 : j'[b]additionne[/b] deux colonnes.
• Je vérifie que la situation est vraiment proportionnelle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'proportionnalite'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Mesures et conversions (CM1) - notion 'mesures'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'Mesures et conversions', $fiche$
[titre]Les préfixes[/titre]
Les unités de mesure se construisent avec les mêmes [b]préfixes[/b] :
[table=6][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]kilo[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]hecto[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]déca[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]déci[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]centi[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=12,4,12,4][center][color=white][b]milli[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]1000[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]100[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center]10[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center]1/10[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center]1/100[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center]1/1000[/center][/cell][/table]
[cadre][b]kilo[/b]mètre = 1000 mètres. [b]centi[/b]litre = 1/100 de litre. [b]milli[/b]gramme = 1/1000 de gramme.[/cadre]
[page]
[titre]Le tableau des longueurs[/titre]
[table=7][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]km[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dam[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]m[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]cm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]mm[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]8[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][/table]
Chaque unité vaut [b]10 fois[/b] celle qui est à sa droite. Pour convertir 8 m en cm :
[cadre]J'écris 8 dans la colonne des [b]m[/b], puis je complète avec des 0 jusqu'aux [b]cm[/b] :
8 m = [b]800 cm[/b].[/cadre]
[page]
[titre]Petites longueurs[/titre]
[table=7][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]km[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dam[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]m[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]cm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]mm[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]4[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]4 cm = [b]40 mm[/b] (1 cm = 10 mm).
1 m = 100 cm = [b]1000 mm[/b].[/cadre]
[cadre=astuce]Vers une unité plus petite, le nombre devient [b]plus grand[/b] : j'ajoute des 0.[/cadre]
[page]
[titre]Les masses[/titre]
[table=4][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]kg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dag[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]g[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]13[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]J'écris 13 dans la colonne des [b]kg[/b], puis je complète avec des 0 jusqu'aux [b]g[/b] :
13 kg = [b]13 000 g[/b] (1 kg = 1000 g).[/cadre]
[page]
[titre]Les contenances[/titre]
[table=4][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]L[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dL[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]cL[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]mL[/b][/color][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]11[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][/table]
[cadre]11 L = [b]1100 cL[/b] (1 L = 100 cL).
Et 1 L = 10 dL = 100 cL = [b]1000 mL[/b].[/cadre]
[cadre=astuce]Une cuillère à café : environ 5 mL. Une canette : 33 cL.[/cadre]
[page]
[titre]Avec un nombre décimal[/titre]
Pour [b]1,5 m[/b] en cm, je place [b]le chiffre des unités dans la colonne de l'unité[/b] (m).
[table=7][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]km[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dam[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]m[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]cm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]mm[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]1[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]5[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b][/b][/center][/cell][/table]
[cadre]Le 5 (dixièmes) va dans la colonne suivante, puis je complète avec un 0 jusqu'aux cm.
1,5 m = [b]150 cm[/b]. Et 2,25 kg = [b]2250 g[/b].[/cadre]
[page]
[titre]Les durées[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 h = 60 min[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]10 h = 600 min[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]une demi-heure = [b]30 min[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]un quart d'heure = [b]15 min[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]trois quarts d'heure = [b]45 min[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]1 min = [b]60 s[/b][/center][/cell][/table]
[cadre]Les durées ne vont pas de 10 en 10 mais de [b]60 en 60[/b] : pas de tableau avec des 0 ![/cadre]
[page]
[titre]Calculer une durée[/titre]
Le car part à [b]9 h 45[/b] et arrive à [b]11 h 20[/b]. Combien de temps dure le trajet ?
J'avance par étapes, en passant par les heures rondes :
[cadre]9 h 45 → 10 h : [b]15 min[/b]. 10 h → 11 h : [b]1 h[/b]. 11 h → 11 h 20 : [b]20 min[/b].
En tout : 1 h + 15 min + 20 min = [b]1 h 35 min[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• kilo = 1000 · hecto = 100 · déca = 10 · déci = 1/10 · centi = 1/100 · milli = 1/1000.
• Dans le tableau, le chiffre des unités va dans la colonne de l'unité, puis je complète avec des 0.
• 1 km = 1000 m · 1 m = 100 cm · 1 kg = 1000 g · 1 L = 100 cL = 1000 mL.
• 1,5 m = 150 cm.
• 1 h = 60 min. Un quart d'heure = 15 min.
• Pour une durée, j'avance par étapes jusqu'aux heures rondes.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mesures'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche L'aire (CM1) - notion 'aire'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'L''aire', $fiche$
[titre]Qu'est-ce que l'aire ?[/titre]
L'[b]aire[/b], c'est la [b]place à l'intérieur[/b] d'une figure : ce qu'on colorie.
[grille lignes=3 colonnes=5]
[cadre]Ce rectangle est fait de [b]15 carreaux[/b] : 3 rangées de 5. Son aire est de 15 carreaux.
Le [b]périmètre[/b], lui, c'est le tour : la clôture autour du jardin.[/cadre]
[page]
[titre]Le centimètre carré[/titre]
Un carré de [b]1 cm de côté[/b] a une aire de [b]1 centimètre carré[/b]. On écrit [b]1 cm²[/b] (ou cm2).
[grille lignes=3 colonnes=5]
[cadre]Si chaque carreau mesure 1 cm de côté, ce rectangle a une aire de [b]15 cm²[/b].[/cadre]
[cadre=astuce]Pour une grande surface, on utilise le [b]m²[/b] : un carré de 1 m de côté.[/cadre]
[page]
[titre]L'aire du rectangle[/titre]
Plutôt que de compter les carreaux, je multiplie :
[center][font_size=26][b]Aire = longueur x largeur[/b][/font_size][/center]
[rect long=20 larg=18 unite=cm]
[cadre]20 x 18 = [b]360 cm²[/b].[/cadre]
[page]
[titre]L'aire du carré[/titre]
Le carré a sa longueur égale à sa largeur :
[center][font_size=26][b]Aire = côté x côté[/b][/font_size][/center]
[rect long=8 larg=8 unite=cm]
[cadre]8 x 8 = [b]64 cm²[/b].[/cadre]
[page]
[titre]Avec des grands nombres[/titre]
Pour un rectangle de [b]24 cm sur 16 cm[/b], je décompose la multiplication :
[cadre]24 x 16 = 24 x 10 + 24 x 6 = 240 + 144 = [b]384 cm²[/b].[/cadre]
[cadre=astuce]Ordre de grandeur : 25 x 15 ≈ 375. 384 est possible ![/cadre]
[page]
[titre]Aire ou périmètre ?[/titre]
Un rectangle de [b]6 cm sur 2 cm[/b] :
[cadre]• Son [b]périmètre[/b] : (6 + 2) x 2 = 16 [b]cm[/b] : une longueur.
• Son [b]aire[/b] : 6 x 2 = 12 [b]cm²[/b] : une surface.[/cadre]
[cadre=astuce]Ce ne sont pas les mêmes calculs ni les mêmes unités : cm pour le tour, [b]cm²[/b] pour l'intérieur.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'aire est la surface à l'intérieur d'une figure.
• 1 cm² = l'aire d'un carré de 1 cm de côté.
• Rectangle : longueur x largeur. 20 x 18 = 360 cm².
• Carré : côté x côté. 8 x 8 = 64 cm².
• Aire en [b]cm²[/b], périmètre en [b]cm[/b] : ne les confonds pas ![/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'aire'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

commit;
select fn_publier();
