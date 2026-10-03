-- Fiche Petits problèmes (CE2) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Petits problèmes', $fiche$
[titre]Résoudre un problème, rappel[/titre]
[cadre]1. Je lis l'histoire [b]deux fois[/b] et je trouve [b]la question[/b].
2. Je cherche [b]les nombres[/b].
3. Je choisis l'opération : [b]+[/b] on reçoit, on achète ; [b]-[/b] on donne, on dépense ; [b]x[/b] plusieurs fois le même nombre.
4. Je [b]calcule[/b].
5. Je [b]réponds par une phrase[/b] et je vérifie que ma réponse a du sens.[/cadre]
[page]
[titre]Les problèmes d'argent[/titre]
Tu as [b]350 euros[/b] et tu achètes un objet à [b]98 euros[/b]. Combien te reste-t-il ?
Quand on paie, il reste moins d'argent : c'est une soustraction, [b]350 - 98[/b].
[cadre=astuce]98, c'est presque 100 : 350 - 100 = 250, puis je rends les 2 en trop : 250 + 2 = 252.[/cadre]
[cadre]Il te reste [b]252 euros[/b].[/cadre]
[page]
[titre]Des paquets : la multiplication[/titre]
Il y a [b]4 paquets de 6 jouets[/b]. Combien cela fait-il au total ?
Chaque ligne est un paquet de 6 :
[grille lignes=4 colonnes=6]
[cadre]4 fois le même nombre : [b]4 x 6 = 24[/b]. Il y a [b]24 jouets[/b] au total.[/cadre]
[page]
[titre]Un problème en deux étapes[/titre]
Léon a [b]138[/b] livres. Il en achète [b]101[/b] de plus, puis il en donne [b]65[/b]. Combien lui en reste-t-il ?
[cadre]Étape 1 : il achète. 138 + 101 = [b]239[/b]. Il a maintenant 239 livres.
Étape 2 : il donne. 239 - 65 = [b]174[/b].[/cadre]
Il reste [b]174 livres[/b] à Léon.
[page]
[titre]Garder l'ordre de l'histoire[/titre]
Noah a 123 pommes. Il en achète 116, puis il en donne 232.
[cadre]Étape 1 : 123 + 116 = [b]239[/b]. Étape 2 : 239 - 232 = [b]7[/b]. Il reste 7 pommes à Noah.[/cadre]
[cadre=astuce]Attention : 123 - 232, c'est impossible ! Il faut d'abord ajouter les pommes achetées.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
[cadre]• Si on [b]achète[/b] ou on [b]reçoit[/b], il y en a [b]plus[/b] qu'au début.
• Si on [b]paie[/b] ou on [b]donne[/b], il y en a [b]moins[/b].
• Avec de l'argent, il ne peut pas rester plus que ce qu'on avait.[/cadre]
Tu as 350 euros et tu paies 98 euros. Si je trouve 448 euros, c'est faux : j'ai ajouté au lieu d'enlever !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis deux fois, je trouve la question et les nombres.
• [b]Achète, reçoit[/b] : +. [b]Donne, paie[/b] : -. [b]Des paquets pareils[/b] : x.
• Ce qui reste = ce que j'avais - ce que je paie.
• Deux étapes : je calcule [b]dans l'ordre de l'histoire[/b].
• Je réponds par une phrase et je vérifie que c'est possible.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
