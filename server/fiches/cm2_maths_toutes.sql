-- Toutes les fiches Maths CM2 en une transaction (2026-10-03).
begin;
-- Fiche L'addition (CM2) - notion 'addition'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'L''addition', $fiche$
[titre]Jusqu'aux millièmes[/titre]
Au CM2, la partie décimale va jusqu'aux [b]millièmes[/b] : 1 unité coupée en 1000.
[table=6][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell bg=#milliemes border=#milliemes padding=18,4,18,4][center][color=white][b]1/1000[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#milliemes padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
[cadre]3,875 = 3 unités, 8 dixièmes, 7 centièmes et 5 [b]millièmes[/b].
3,875 = 3 + 8/10 + 7/100 + 5/1000.[/cadre]
[page]
[titre]Des nombres de longueurs différentes[/titre]
Pour [b]12,5 + 3,875[/b], je mets [b]la virgule sous la virgule[/b] et je complète avec des 0.
[table=7][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell bg=#milliemes border=#milliemes padding=18,4,18,4][center][color=white][b]1/1000[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell border=#milliemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#milliemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#milliemes_clair border=#milliemes padding=18,4,18,4][center][b]5[/b][/center][/cell][/table]
[cadre]12,5 = 12,500. Dixièmes : 5 + 8 = 13, j'écris 3 et je retiens 1. [b]12,5 + 3,875 = 16,375[/b][/cadre]
[page]
[titre]Trois nombres[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]2[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]2[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]0[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]8[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]2[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]0[/b][/center][/cell][/table]
Centièmes : 5 + 0 + 5 = 10, je retiens 1. Dixièmes : 1 + 7 + 6 + 8 = [b]22[/b] : j'écris 2 et je retiens [b]2[/b] !
[cadre]Unités : 2 + 4 + 2 + 0 = 8. Dizaines : 1. [b]4,75 + 12,6 + 0,85 = 18,2[/b][/cadre]
[page]
[titre]Calculer de tête, malin[/titre]
[cadre]• Ajouter [b]0,9[/b], c'est ajouter 1 puis enlever 0,1 : 5,46 + 0,9 = 6,46 - 0,1 = [b]6,36[/b].
• Ajouter [b]1,99[/b], c'est ajouter 2 puis enlever 0,01 : 7,3 + 1,99 = 9,3 - 0,01 = [b]9,29[/b].
• Je regroupe les nombres qui font un entier : 2,6 + 5,8 + 0,4 = (2,6 + 0,4) + 5,8 = 3 + 5,8 = [b]8,8[/b].[/cadre]
[cadre=astuce]Dans une addition, je peux changer l'ordre des nombres : le résultat ne change pas.[/cadre]
[page]
[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]1,85 + 26,99[/b], j'arrondis à l'unité : 2 + 27 = [b]29[/b].
[cadre]Je trouve 28,84 : c'est proche de 29, c'est possible.
Si je trouve 2,884 ou 288,4, ma [b]virgule est mal placée[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 3,875 : 8 dixièmes, 7 centièmes, 5 [b]millièmes[/b].
• Virgule sous virgule, et des 0 pour compléter : 12,5 = 12,500.
• La retenue peut être 2 (ou plus) quand j'additionne plusieurs nombres.
• + 0,9 = + 1 - 0,1. + 1,99 = + 2 - 0,01.
• Je regroupe les nombres qui font un entier.
• Je vérifie avec un ordre de grandeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'addition'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La soustraction (CM2) - notion 'soustraction'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'La soustraction', $fiche$
[titre]Le cassage, avec la virgule[/titre]
Pour [b]11,32 - 5,53[/b], il manque dans [b]chaque colonne[/b] : je casse à chaque fois.
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]0[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]12[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]1[/s][/color][/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b][color=#C62828][s]3[/s][/color][/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][color=#C62828][s]2[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
Centièmes : 12 - 3 = 9. Dixièmes : 12 - 5 = 7. Unités : 10 - 5 = 5. Dizaines : 0.
[cadre][b]11,32 - 5,53 = 5,79[/b][/cadre]
[page]
[titre]La compensation, avec la virgule[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]1[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]3[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][color=#C62828][font_size=18]1[/font_size][/color]2[/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[color=#C62828][font_size=18]+1[/font_size][/color][/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][/table]
À chaque colonne : 10 en haut, et 1 de plus en bas dans la colonne de gauche.
[cadre]12 - 3 = 9 · 13 - 6 = 7 · 11 - 6 = 5 · 1 - 1 = 0. Même résultat : [b]5,79[/b].
Utilise toujours [b]la méthode de ta classe[/b].[/cadre]
[page]
[titre]Soustraire d'un nombre entier[/titre]
Pour [b]25 - 7,36[/b], j'écris 25 avec une virgule et des 0 : [b]25,00[/b].
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]4[/b][/center][/cell][/table]
[cadre]Puis je calcule avec la méthode de ma classe : [b]25 - 7,36 = 17,64[/b].[/cadre]
[page]
[titre]Le complément à 1[/titre]
Combien faut-il ajouter à [b]0,35[/b] pour avoir 1 ? 35 centièmes + 65 centièmes = 100 centièmes.
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 - 0,35 = 0,65[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 - 0,8 = 0,2[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 - 0,125 = 0,875[/b][/center][/cell][/table]
[cadre=astuce]Chiffre par chiffre, je complète à [b]9[/b], et le dernier chiffre à [b]10[/b] :
0,1[b]2[/b]5 → 1 + 8 = 9, 2 + 7 = 9, 5 + 5 = 10 → [b]0,875[/b].[/cadre]
[page]
[titre]Calculer de tête, malin[/titre]
[cadre]• Enlever [b]0,99[/b], c'est enlever 1 puis rajouter 0,01 : 8,45 - 0,99 = 7,45 + 0,01 = [b]7,46[/b].
• Enlever [b]0,9[/b], c'est enlever 1 puis rajouter 0,1 : 6,3 - 0,9 = 5,3 + 0,1 = [b]5,4[/b].[/cadre]
[cadre=astuce]J'ai enlevé un peu trop : je rends ce que j'ai pris en trop.[/cadre]
[page]
[titre]Vérifier avec une addition[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]1[/b][/color][/font_size][/center][/cell][cell padding=6,0,6,0][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]9[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#classe padding=18,4,18,4][/cell][cell border=#unites padding=18,4,18,4][center][b]5[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell bg=#dixiemes_clair border=#dixiemes padding=18,4,18,4][center][b]3[/b][/center][/cell][cell bg=#centiemes_clair border=#centiemes padding=18,4,18,4][center][b]2[/b][/center][/cell][/table]
[cadre]5,79 + 5,53 = 11,32 : je retrouve le nombre du départ, ma soustraction est juste.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Virgule sous virgule ; un entier s'écrit avec des 0 : 25 = 25,00.
• Pas assez ? Cassage ou compensation : [b]la méthode de ma classe[/b], dans chaque colonne.
• Complément à 1 : 1 - 0,35 = 0,65 (chiffres complétés à 9, le dernier à 10).
• - 0,99 = - 1 + 0,01.
• Je vérifie avec une addition.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'soustraction'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La multiplication (CM2) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'La multiplication', $fiche$
[titre]Poser 53 x 87[/titre]
87 = 7 + 80. Je fais [b]deux lignes[/b] puis je les additionne.
[table=5][cell padding=10,4,10,4][/cell][cell bg=#milliers border=#milliers padding=18,4,18,4][center][color=white][b]M[/b][/color][/center][/cell][cell bg=#centaines border=#centaines padding=18,4,18,4][center][color=white][b]C[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]x[/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][/cell][cell border=#classe padding=18,4,18,4][center][b]8[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#milliers padding=18,4,18,4][/cell][cell border=#centaines padding=18,4,18,4][center][b]3[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]7[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][cell padding=10,4,10,4][b]+[/b][/cell][cell border=#milliers padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#centaines padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][b][color=#C62828]0[/color][/b][/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#milliers_clair border=#milliers padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#centaines_clair border=#centaines padding=18,4,18,4][center][b]6[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]1[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]1[/b][/center][/cell][/table]
[cadre]1re ligne : 53 x 7 = [b]371[/b]. 2e ligne : 53 x 80 = [b]4240[/b]. 371 + 4240 = [b]4611[/b].[/cadre]
[page]
[titre]Pourquoi le 0 de la 2e ligne ?[/titre]
Dans 87, le 8 est le chiffre des [b]dizaines[/b] : il vaut 80, pas 8.
[cadre]53 x 80 = 53 x 8 x 10 = 424 x 10 = [b]4240[/b].
J'écris d'abord le [b]0[/b] dans les unités, puis 53 x 8 à sa gauche.[/cadre]
[cadre=astuce]Pour un nombre à 3 chiffres (x 245), la 3e ligne commence par [b]deux 0[/b] (x 200).[/cadre]
[page]
[titre]Un nombre décimal fois un entier[/titre]
Pour [b]2,35 x 4[/b], je calcule sans la virgule, puis je la replace.
[cadre]235 x 4 = 940. 2,35 a [b]2 chiffres après la virgule[/b] : le résultat aussi.
2,35 x 4 = [b]9,40[/b] = 9,4.[/cadre]
[cadre=astuce]Ordre de grandeur : 2 x 4 = 8. 9,4 est possible, 94 ou 0,94 non ![/cadre]
[page]
[titre]Un décimal fois 10, 100, 1000[/titre]
Chaque chiffre prend une valeur 10, 100 ou 1000 fois plus grande : la virgule [b]se déplace vers la droite[/b].
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]3,75 x 10 = 37,5[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]1 rang vers la droite[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]3,75 x 100 = 375[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]2 rangs[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]3,75 x 1000 = 3750[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]3 rangs : j'ajoute un 0[/center][/cell][/table]
[cadre]Attention : 3,75 x 10 ne fait pas 3,750 ! Ajouter un 0 ne marche que pour les entiers.[/cadre]
[page]
[titre]Les astuces de calcul[/titre]
[cadre]• Fois [b]5[/b] = fois 10, puis divisé par 2 : 46 x 5 = 460 : 2 = [b]230[/b].
• Fois [b]50[/b] = fois 100, puis divisé par 2 : 70 x 50 = 7000 : 2 = [b]3500[/b].
• Fois [b]25[/b] = fois 100, puis divisé par 4 : 36 x 25 = 3600 : 4 = [b]900[/b].
• Fois [b]99[/b] = fois 100, moins une fois : 45 x 99 = 4500 - 45 = [b]4455[/b].[/cadre]
[page]
[titre]Changer l'ordre[/titre]
Dans une multiplication, je peux [b]changer l'ordre[/b] et regrouper les nombres comme je veux.
[center][font_size=26][b]4 x 17 x 25 = 17 x (4 x 25) = 17 x 100 = 1700[/b][/font_size][/center]
[cadre=astuce]Je cherche les paires qui font 10, 100 ou 1000 : 2 x 5, 4 x 25, 8 x 125.[/cadre]
[page]
[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]99 x 85[/b], j'arrondis : 100 x 85 = [b]8500[/b].
[cadre]Je trouve 8415 : c'est un peu moins que 8500, normal car 99 < 100. C'est possible.
Avec l'astuce : 8500 - 85 = [b]8415[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Par un nombre à 2 chiffres : 2 lignes ; la 2e commence par un 0 (les dizaines).
• Décimal x entier : je calcule sans virgule, puis je remets autant de chiffres après la virgule.
• Décimal x 10, 100, 1000 : la virgule se déplace de 1, 2, 3 rangs vers la droite.
• x 5 = x 10 : 2 · x 25 = x 100 : 4 · x 99 = x 100 - 1 fois.
• Je change l'ordre pour faire 10, 100, 1000. Je vérifie avec un ordre de grandeur.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Les grands nombres (CM2) - notion 'numeration'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Les grands nombres', $fiche$
[titre]Millions et milliards[/titre]
Je sépare les classes de 3 chiffres en partant de la droite :
[table=9][cell bg=#milliers border=#milliers padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#milliers border=#milliers padding=14,3,14,3][center][color=white][b][font_size=18]millions[/font_size][/b][/color][/center][/cell][cell bg=#milliers border=#milliers padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][font_size=18]mille[/font_size][/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][font_size=18]unités[/font_size][/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,3,14,3][center][color=white][b][/b][/color][/center][/cell][cell bg=#milliers_clair border=#milliers padding=14,3,14,3][center][b]C[/b][/center][/cell][cell bg=#milliers_clair border=#milliers padding=14,3,14,3][center][b]D[/b][/center][/cell][cell bg=#milliers_clair border=#milliers padding=14,3,14,3][center][b]U[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]C[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]D[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]U[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]C[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]D[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,3,14,3][center][b]U[/b][/center][/cell][cell border=#milliers padding=14,3,14,3][center][b]1[/b][/center][/cell][cell border=#milliers padding=14,3,14,3][center][b]6[/b][/center][/cell][cell border=#milliers padding=14,3,14,3][center][b]2[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]5[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]3[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center][b]3[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]4[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]3[/b][/center][/cell][cell border=#unites padding=14,3,14,3][center][b]3[/b][/center][/cell][/table]
[cadre]Après la classe des mille vient la classe des [b]millions[/b], puis celle des [b]milliards[/b].
1 milliard = 1 000 000 000 = [b]mille millions[/b].[/cadre]
[page]
[titre]Le nom de chaque chiffre[/titre]
Dans [b]508 682 859[/b] :
[table=3][cell bg=#milliers_clair border=#milliers padding=12,4,12,4][center][b]5[/b] centaines de millions[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][b]6[/b] centaines de mille[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center][b]8[/b] centaines[/center][/cell][cell bg=#milliers_clair border=#milliers padding=12,4,12,4][center][b]0[/b] dizaine de millions[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][b]8[/b] dizaines de mille[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center][b]5[/b] dizaines[/center][/cell][cell bg=#milliers_clair border=#milliers padding=12,4,12,4][center][b]8[/b] unités de millions[/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][b]2[/b] unités de mille[/center][/cell][cell bg=#unites_clair border=#unites padding=12,4,12,4][center][b]9[/b] unités[/center][/cell][/table]
[cadre]Chaque classe a ses centaines, dizaines et unités. Le chiffre des millions est [b]8[/b].[/cadre]
[page]
[titre]Lire un grand nombre[/titre]
Je lis [b]classe par classe[/b], en disant le nom de la classe :
[center][font_size=26][b]162 533 433[/b][/font_size][/center]
[cadre]cent soixante-deux [b]millions[/b] cinq cent trente-trois [b]mille[/b] quatre cent trente-trois.[/cadre]
[cadre=astuce]« Million » et « milliard » prennent un s : deux millions. « Mille » ne prend [b]jamais[/b] de s : deux mille.[/cadre]
[page]
[titre]Chiffre des… ou nombre de… ?[/titre]
Dans [b]162 533 433[/b] :
[cadre]• le [b]chiffre[/b] des millions est [b]2[/b] ;
• le [b]nombre[/b] de millions est [b]162[/b] : tout ce qui est à gauche, chiffre des millions compris.[/cadre]
[page]
[titre]Les décimaux jusqu'aux millièmes[/titre]
[table=6][cell padding=10,4,10,4][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=6,4,6,4][/cell][cell bg=#dixiemes border=#dixiemes padding=18,4,18,4][center][color=white][b]1/10[/b][/color][/center][/cell][cell bg=#centiemes border=#centiemes padding=18,4,18,4][center][color=white][b]1/100[/b][/color][/center][/cell][cell bg=#milliemes border=#milliemes padding=18,4,18,4][center][color=white][b]1/1000[/b][/color][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#unites padding=18,4,18,4][center][b]4[/b][/center][/cell][cell padding=6,4,6,4][center][b],[/b][/center][/cell][cell border=#dixiemes padding=18,4,18,4][center][b]2[/b][/center][/cell][cell border=#centiemes padding=18,4,18,4][center][b]5[/b][/center][/cell][cell border=#milliemes padding=18,4,18,4][center][b]6[/b][/center][/cell][/table]
[cadre]4,256 : 4 unités, 2 [b]dixièmes[/b], 5 [b]centièmes[/b], 6 [b]millièmes[/b].
1 unité = 10 dixièmes = 100 centièmes = [b]1000 millièmes[/b].[/cadre]
[page]
[titre]Arrondir[/titre]
Pour arrondir, je regarde [b]le chiffre juste après[/b] : de 0 à 4, je garde ; de 5 à 9, j'arrondis au-dessus.
[cadre]• 162 533 433 arrondi au million : le chiffre suivant est 5 → [b]163 millions[/b].
• 4,256 arrondi au dixième : le chiffre suivant est 5 → [b]4,3[/b].
• 4,256 arrondi à l'unité : le chiffre suivant est 2 → [b]4[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Classes : unités, mille, millions, milliards. 1 milliard = mille millions.
• Chaque classe a ses centaines, dizaines, unités.
• Je lis classe par classe. Millions prend un s, mille jamais.
• « Chiffre des millions » : 2. « Nombre de millions » : 162.
• Après la virgule : dixièmes, centièmes, millièmes.
• Arrondir : je regarde le chiffre suivant (5 ou plus → au-dessus).[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'numeration'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche La proportionnalité (CM2) - notion 'proportionnalite'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'La proportionnalité', $fiche$
[titre]Le coefficient[/titre]
2 stylos coûtent 10 euros. Le prix est proportionnel au nombre de stylos :
[table=5][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Stylos[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]4[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]6[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]10[/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Prix (euros)[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]10[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]20[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]30[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]50[/b][/center][/cell][/table]
[cadre]Je passe de la 1re ligne à la 2e en multipliant toujours par [b]5[/b] : c'est le [b]coefficient de proportionnalité[/b].
Ici, il est égal au prix d'un stylo : 5 euros.[/cadre]
[page]
[titre]Trouver le coefficient[/titre]
Pour [b]3 billes[/b], on paie [b]12 euros[/b]. Combien paie-t-on pour [b]26 billes[/b] ?
[cadre]Coefficient : 12 : 3 = [b]4[/b] (le prix d'une bille).
26 billes : 26 x 4 = [b]104 euros[/b].[/cadre]
[cadre=astuce]Quand 26 n'est pas un multiple simple de 3, passer par 1 est la méthode la plus sûre.[/cadre]
[page]
[titre]La vitesse[/titre]
Une voiture roule à [b]100 km/h[/b] : elle parcourt [b]100 km en 1 heure[/b].
[table=5][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Durée (h)[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]1[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]3[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]5[/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Distance (km)[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]100[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]200[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]300[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]500[/b][/center][/cell][/table]
[cadre]Distance = vitesse x durée. En 2 heures : 100 x 2 = [b]200 km[/b].[/cadre]
[page]
[titre]Avec des demi-heures[/titre]
Une voiture roule à [b]110 km/h[/b]. Quelle distance parcourt-elle en [b]1 h 30 min[/b] ?
[cadre]En 1 h : 110 km. En 30 min (une demi-heure) : la moitié, 110 : 2 = [b]55 km[/b].
En 1 h 30 : 110 + 55 = [b]165 km[/b].[/cadre]
[page]
[titre]Une recette[/titre]
Pour [b]4 personnes[/b], il faut [b]200 g[/b] de farine. Et pour [b]6 personnes[/b] ?
[cadre]Pour 2 personnes (la moitié de 4) : 200 : 2 = [b]100 g[/b].
6 personnes = 4 + 2 : 200 + 100 = [b]300 g[/b].[/cadre]
[cadre=astuce]Je peux additionner deux colonnes du tableau, ou passer par la moitié, le double…[/cadre]
[page]
[titre]Proportionnel ou pas ?[/titre]
Un taxi coûte [b]3 euros pour monter[/b], puis [b]2 euros par km[/b].
[cadre]1 km : 3 + 2 = 5 euros. 2 km : 3 + 4 = 7 euros.
Deux fois plus de kilomètres, mais pas deux fois plus cher (7 n'est pas 10) : ce n'est [b]pas proportionnel[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Proportionnel : on passe d'une ligne à l'autre en multipliant par le même nombre, le [b]coefficient[/b].
• Le coefficient = la valeur pour 1 : 12 : 3 = 4 euros par bille.
• Vitesse : distance = vitesse x durée. 30 min = la moitié d'une heure.
• Je peux aussi additionner des colonnes ou prendre la moitié, le double.
• Je vérifie que la situation est vraiment proportionnelle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'proportionnalite'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Les pourcentages (CM2) - notion 'pourcentages'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Les pourcentages', $fiche$
[titre]Que veut dire « % » ?[/titre]
[b]25 %[/b] se lit « 25 pour cent » : [b]25 sur 100[/b], c'est-à-dire 25/100.
[grille lignes=10 colonnes=10 case=17 colorees=25]
[cadre]Sur 100 cases, 25 sont coloriées : [b]25 %[/b] des cases.[/cadre]
[page]
[titre]Les pourcentages à connaître[/titre]
[table=3][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Pourcentage[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Fraction[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Je calcule[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]100 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]tout[/center][/cell][cell border=#classe padding=14,3,14,3][center]le nombre entier[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]50 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/2, la moitié[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]25 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/4, le quart[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 4[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]75 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]3/4, trois quarts[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 4, puis x 3[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]10 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/10, un dixième[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 10[/center][/cell][/table]
[page]
[titre]50 % et 25 %[/titre]
[cadre]• [b]50 % de 376[/b], c'est la moitié : 376 : 2 = [b]188[/b].
• [b]25 % de 280[/b], c'est le quart : 280 : 4 = [b]70[/b].[/cadre]
[cadre=astuce]Le quart, c'est la moitié de la moitié : 280 → 140 → [b]70[/b].[/cadre]
[page]
[titre]10 % et 20 %[/titre]
[cadre]• [b]10 % de 420[/b] : je divise par 10. 420 : 10 = [b]42[/b].
• [b]20 % de 420[/b] : deux fois 10 %. 42 x 2 = [b]84[/b].[/cadre]
[cadre=astuce]Avec 10 %, je peux trouver 20 %, 30 %, 40 %… en multipliant.[/cadre]
[page]
[titre]75 %[/titre]
[b]75 % de 296[/b] : 75 %, ce sont [b]3 quarts[/b].
[cadre]Méthode 1 : un quart de 296 = 296 : 4 = 74. Trois quarts : 74 x 3 = [b]222[/b].
Méthode 2 : 50 % + 25 % = 148 + 74 = [b]222[/b].[/cadre]
[page]
[titre]Les soldes[/titre]
Un manteau coûte [b]60 euros[/b]. Il est soldé à [b]- 25 %[/b]. Combien coûte-t-il maintenant ?
[cadre]Étape 1, la réduction : 25 % de 60 = 60 : 4 = [b]15 euros[/b].
Étape 2, le nouveau prix : 60 - 15 = [b]45 euros[/b].[/cadre]
[cadre=astuce]Attention : - 25 % ne veut pas dire « 25 euros de moins » ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 25 % = 25 sur 100 = 25/100.
• 50 % : la moitié (: 2). 25 % : le quart (: 4). 75 % : trois quarts.
• 10 % : je divise par 10. 20 % = 2 fois 10 %.
• Une réduction de 25 % : je calcule la réduction, puis je l'enlève du prix.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pourcentages'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

-- Fiche Mesures et conversions (CM2) - notion 'mesures'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Mesures et conversions', $fiche$
[titre]Un seul tableau à retenir[/titre]
[table=7][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]kilo[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]hecto[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]déca[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]unité[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]déci[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]centi[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,3,10,3][center][color=white][b]milli[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]km[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dam[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]m[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mm[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]kg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dag[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]g[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mg[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]kL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]hL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]daL[/center][/cell][cell bg=#unites_clair border=#unites padding=10,3,10,3][center][b]L[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]dL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]cL[/center][/cell][cell bg=#classe_clair border=#classe padding=10,3,10,3][center]mL[/center][/cell][/table]
[cadre]Longueurs, masses et contenances utilisent [b]les mêmes préfixes[/b] : chaque colonne vaut 10 fois celle de droite.[/cadre]
[page]
[titre]Convertir un nombre décimal[/titre]
Pour [b]2,5 km[/b] en m : le chiffre des [b]unités[/b] (2) va dans la colonne [b]km[/b].
[table=4][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]km[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hm[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dam[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]m[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]2,[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]5[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0[/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]Puis je complète avec des 0 jusqu'aux m : 2,5 km = [b]2500 m[/b].
Et 14 kg = [b]14 000 g[/b] · 3 L = [b]300 cL[/b].[/cadre]
[page]
[titre]Dans l'autre sens[/titre]
Pour [b]750 g[/b] en kg : le 0 des unités va dans la colonne [b]g[/b], puis je lis en kg.
[table=4][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]kg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]hg[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,4,14,4][center][color=white][b]dag[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=14,4,14,4][center][color=white][b]g[/b][/color][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]0,[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]7[/b][/center][/cell][cell border=#classe padding=14,4,14,4][center][b]5[/b][/center][/cell][cell border=#unites padding=14,4,14,4][center][b]0[/b][/center][/cell][/table]
[cadre]750 g = [b]0,75 kg[/b]. Et 1250 m = [b]1,25 km[/b].[/cadre]
[cadre=astuce]Vers une unité plus grande, le nombre devient [b]plus petit[/b].[/cadre]
[page]
[titre]La tonne[/titre]
Pour les objets très lourds, on utilise la [b]tonne[/b] (t) : [b]1 t = 1000 kg[/b].
[cadre]• 5 t = 5 x 1000 = [b]5000 kg[/b].
• Une voiture pèse environ 1 t. Un éléphant, environ 5 t.[/cadre]
[page]
[titre]Les durées ne comptent pas par 10 ![/titre]
[table=3][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 h = 60 min[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 min = 60 s[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]1 jour = 24 h[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]3 h = [b]180 min[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]4 min = [b]240 s[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]2 jours = [b]48 h[/b][/center][/cell][/table]
[cadre]Piège : [b]1,5 h[/b], c'est 1 h et une demi-heure : 1 h [b]30[/b] min, soit 90 min.
Ce n'est pas 1 h 50 min ![/cadre]
[page]
[titre]Calculer avec des durées[/titre]
Un film de [b]2 h 45 min[/b], puis un autre de [b]1 h 30 min[/b]. Combien de temps en tout ?
[cadre]Heures : 2 + 1 = 3 h. Minutes : 45 + 30 = [b]75 min[/b].
75 min = 60 min + 15 min = 1 h 15 min. Total : 3 h + 1 h 15 min = [b]4 h 15 min[/b].[/cadre]
[page]
[titre]Choisir la bonne unité[/titre]
[table=2][cell border=#classe padding=12,3,12,3][center]l'épaisseur d'une pièce[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]2 mm[/center][/cell][cell border=#classe padding=12,3,12,3][center]la hauteur d'une porte[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]2 m[/center][/cell][cell border=#classe padding=12,3,12,3][center]la distance Paris - Lyon[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]465 km[/center][/cell][cell border=#classe padding=12,3,12,3][center]la masse d'un camion[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]10 t[/center][/cell][cell border=#classe padding=12,3,12,3][center]une bouteille d'eau[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]1,5 L[/center][/cell][cell border=#classe padding=12,3,12,3][center]une cuillère de sirop[/center][/cell][cell bg=#classe_clair border=#classe padding=12,3,12,3][center]5 mL[/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Mêmes préfixes pour m, g et L : kilo, hecto, déca, déci, centi, milli.
• Le chiffre des unités va dans la colonne de l'unité, puis je complète avec des 0.
• 2,5 km = 2500 m · 750 g = 0,75 kg · 1 t = 1000 kg.
• Durées : 1 h = 60 min, 1 min = 60 s. 1,5 h = 1 h 30 min.
• 75 min = 1 h 15 min.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mesures'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

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

-- Fiche Le volume (CM2) - notion 'volume'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Le volume', $fiche$
[titre]Qu'est-ce que le volume ?[/titre]
Le [b]volume[/b], c'est la [b]place occupée[/b] par un objet. Je peux le mesurer en comptant des petits cubes.
[pave long=4 larg=3 haut=2]
[cadre]Ce pavé est fait de [b]24 petits cubes[/b].[/cadre]
[page]
[titre]Le centimètre cube[/titre]
Un cube de [b]1 cm d'arête[/b] a un volume de [b]1 centimètre cube[/b] : [b]1 cm³[/b] (ou cm3).
[pave long=4 larg=3 haut=2 unite=cm]
[cadre]Chaque petit cube fait 1 cm³ : le volume du pavé est de [b]24 cm³[/b].[/cadre]
[page]
[titre]Compter par couches[/titre]
Une couche du pavé : 4 cubes de long, 3 de large : 4 x 3 = [b]12 cubes[/b]. Il y a 2 couches : 12 x 2 = [b]24[/b].
[center][font_size=26][b]Volume = longueur x largeur x hauteur[/b][/font_size][/center]
[cadre]4 x 3 x 2 = [b]24 cm³[/b].[/cadre]
[page]
[titre]Un exemple[/titre]
Un pavé droit de [b]11 cm[/b] de long, [b]7 cm[/b] de large et [b]2 cm[/b] de haut :
[cadre]11 x 7 = 77, puis 77 x 2 = [b]154 cm³[/b].[/cadre]
[cadre=astuce]Je choisis l'ordre le plus facile : 14 x 5 x 10 → 14 x 5 = 70, puis 70 x 10 = [b]700 cm³[/b].[/cadre]
[page]
[titre]Le cube[/titre]
Un cube a ses 3 dimensions égales : [b]Volume = arête x arête x arête[/b].
[pave long=3 larg=3 haut=3 unite=cm]
[cadre]3 x 3 x 3 = [b]27 cm³[/b]. Un cube de 5 cm d'arête : 5 x 5 x 5 = [b]125 cm³[/b].[/cadre]
[page]
[titre]Volume et litres[/titre]
Un cube de [b]10 cm d'arête[/b] (1 dm) a un volume de 10 x 10 x 10 = [b]1000 cm³[/b].
[cadre]Il contient exactement [b]1 litre[/b] d'eau : 1 L = 1 dm³ = [b]1000 cm³[/b].
Une brique de lait de 1 L a donc un volume d'environ 1000 cm³.[/cadre]
[page]
[titre]Longueur, aire ou volume ?[/titre]
[table=3][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Je mesure[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Unité[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Exemple[/b][/color][/center][/cell][cell border=#classe padding=14,6,14,6][center]une longueur[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]le tour d'un cahier[/center][/cell][cell border=#classe padding=14,6,14,6][center]une aire[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm²[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]la couverture du cahier[/center][/cell][cell border=#classe padding=14,6,14,6][center]un volume[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]cm³[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]une boîte à chaussures[/center][/cell][/table]
[cadre=astuce]cm : 1 dimension. cm² : 2 dimensions (longueur x largeur). cm³ : 3 dimensions.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le volume est la place occupée par un objet.
• 1 cm³ = le volume d'un cube de 1 cm d'arête.
• Pavé droit : longueur x largeur x hauteur. Cube : arête x arête x arête.
• Je multiplie dans l'ordre le plus facile.
• 1 L = 1 dm³ = 1000 cm³.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'volume'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;

commit;
select fn_publier();
