-- Fiche Petits problèmes (CE1) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Petits problèmes', $fiche$
[titre]Résoudre un problème, rappel[/titre]
[cadre]1. Je lis l'histoire [b]deux fois[/b] et je trouve [b]la question[/b].
2. Je cherche [b]les nombres[/b].
3. Je choisis l'opération : [b]+[/b] si on en reçoit, on en achète ; [b]-[/b] si on en donne, on en dépense.
4. Je [b]calcule[/b].
5. Je [b]réponds par une phrase[/b] et je vérifie que ma réponse a du sens.[/cadre]
[page]
[titre]Les problèmes d'argent[/titre]
Tu as [b]90 euros[/b] et tu achètes un objet à [b]43 euros[/b]. Combien te reste-t-il ?
Quand on paie, on [b]dépense[/b] : il reste moins d'argent. C'est une soustraction, [b]90 - 43[/b].
[table=3][cell padding=10,4,10,4][/cell][cell bg=#classe border=#classe padding=18,4,18,4][center][color=white][b]D[/b][/color][/center][/cell][cell bg=#unites border=#unites padding=18,4,18,4][center][color=white][b]U[/b][/color][/center][/cell][cell padding=10,0,10,0][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]8[/b][/color][/font_size][/center][/cell][cell padding=18,0,18,0][center][font_size=18][color=#C62828][b]10[/b][/color][/font_size][/center][/cell][cell padding=10,4,10,4][b][/b][/cell][cell border=#classe padding=18,4,18,4][center][b][color=#C62828][s]9[/s][/color][/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b][color=#C62828][s]0[/s][/color][/b][/center][/cell][cell padding=10,4,10,4][b]-[/b][/cell][cell border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell border=#unites padding=18,4,18,4][center][b]3[/b][/center][/cell][cell padding=10,4,10,4][b]=[/b][/cell][cell bg=#classe_clair border=#classe padding=18,4,18,4][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=18,4,18,4][center][b]7[/b][/center][/cell][/table]
[cadre]Il te reste [b]47 euros[/b].[/cadre]
[page]
[titre]Calculer de tête : l'écart[/titre]
Pour 90 - 43, je peux aussi chercher l'écart : j'avance de 43 jusqu'à 90.
[table=3][cell bg=#unites_clair border=#unites padding=14,6,14,6]43 → 50[/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6]50 → 90[/cell][cell border=#classe padding=14,6,14,6]en tout[/cell][cell border=#unites padding=14,6,14,6][b]+7[/b][/cell][cell border=#classe padding=14,6,14,6][b]+40[/b][/cell][cell border=#classe padding=14,6,14,6][b]7 + 40 = 47[/b][/cell][/table]
[cadre=astuce]Je vérifie : 47 + 43 = 90. C'est bien l'argent que j'avais.[/cadre]
[page]
[titre]Un problème en deux étapes[/titre]
Jules a [b]20[/b] autocollants. Il en achète [b]16[/b] de plus, puis il en donne [b]19[/b]. Combien lui en reste-t-il ?
Il se passe [b]deux choses[/b] : je calcule dans l'ordre de l'histoire.
[table=2][cell bg=#classe_clair border=#classe padding=14,6,14,6]1. Il en achète 16 : [b]+[/b][/cell][cell border=#classe padding=14,6,14,6][b]20 + 16 = 36[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]2. Il en donne 19 : [b]-[/b][/cell][cell border=#unites padding=14,6,14,6][b]36 - 19 = 17[/b][/cell][/table]
[cadre]Il reste [b]17 autocollants[/b] à Jules.[/cadre]
[page]
[titre]Garder le résultat de l'étape 1[/titre]
Le résultat de la première étape devient [b]le nombre de départ[/b] de la deuxième.
Maya a 11 billes. Elle en achète 5, puis en donne 14.
[cadre]Étape 1 : 11 + 5 = [b]16[/b]. Elle a maintenant 16 billes.
Étape 2 : 16 - 14 = [b]2[/b]. Il lui reste 2 billes.[/cadre]
[cadre=astuce]Attention : ne pas faire 11 - 14, c'est impossible ! Il faut d'abord ajouter les 5 billes achetées.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
[cadre]• Si on [b]achète[/b] ou on [b]reçoit[/b], il y en a [b]plus[/b] qu'au début.
• Si on [b]paie[/b] ou on [b]donne[/b], il y en a [b]moins[/b].
• Avec de l'argent, il ne peut pas rester plus que ce qu'on avait.[/cadre]
Tu as 90 euros et tu dépenses 43 euros. Si je trouve 133 euros, c'est faux : j'ai ajouté au lieu d'enlever !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis deux fois, je trouve la question et les nombres.
• [b]Achète, reçoit[/b] : +. [b]Donne, paie, dépense[/b] : -.
• Un problème d'argent : ce qui reste = ce que j'avais - ce que je paie.
• Deux étapes : je calcule [b]dans l'ordre de l'histoire[/b].
• Le résultat de l'étape 1 sert pour l'étape 2.
• Je réponds par une phrase et je vérifie que c'est possible.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
