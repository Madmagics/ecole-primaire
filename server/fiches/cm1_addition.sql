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
select fn_publier();
