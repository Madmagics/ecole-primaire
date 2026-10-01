-- Fiche La multiplication (CE1) - notion 'multiplication'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'La multiplication', $fiche$
[titre]Des groupes égaux[/titre]
J'ai 3 sacs. Dans chaque sac, il y a 5 billes. Combien de billes en tout ?
[billes groupes=5,5,5 couleurs=bleu,bleu,bleu total=oui]
[cadre]5 + 5 + 5 = [b]15[/b]. Quand on ajoute plusieurs fois [b]le même nombre[/b], on peut multiplier.[/cadre]
[page]
[titre]Le signe x[/titre]
[center][font_size=34][b]3 x 5 = 15[/b][/font_size][/center]
[center]« trois fois cinq égale quinze »[/center]
3 x 5, c'est [b]3 fois le nombre 5[/b] : 5 + 5 + 5.
[cadre]Le signe [b]x[/b] se lit « fois ». Le résultat d'une multiplication s'appelle [b]le produit[/b].[/cadre]
[page]
[titre]L'ordre ne change rien[/titre]
3 lignes de 5 cases, ou 5 lignes de 3 cases : c'est le même nombre de cases.
[grille lignes=3 colonnes=5]
[grille lignes=5 colonnes=3]
[cadre][b]3 x 5 = 15[/b] et [b]5 x 3 = 15[/b]. Je peux choisir le calcul le plus facile.[/cadre]
[page]
[titre]Fois 1 et fois 0[/titre]
[cadre]• Multiplier [b]par 1[/b] : une seule fois le nombre. Il ne change pas. [b]7 x 1 = 7[/b]
• Multiplier [b]par 0[/b] : zéro fois le nombre, c'est rien du tout. [b]7 x 0 = 0[/b][/cadre]
[cadre=astuce]0 sac de 7 billes, ça fait 0 bille. 7 sacs vides, ça fait aussi 0 bille : [b]0 x 7 = 0[/b].[/cadre]
[page]
[titre]La table de 2[/titre]
Multiplier par 2, c'est faire [b]le double[/b] : 6 x 2 = 6 + 6 = 12.
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]0 x 2 = 0[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 2 = 2[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 2 = 4[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 2 = 6[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 2 = 8[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 2 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 2 = 12[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 2 = 14[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 2 = 16[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 2 = 18[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 2 = 20[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]11 x 2 = 22[/b][/cell][/table]
[cadre=astuce]Les résultats de la table de 2 sont tous des nombres [b]pairs[/b].[/cadre]
[page]
[titre]La table de 5[/titre]
On compte de 5 en 5 : 5, 10, 15, 20…
[table=4][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]0 x 5 = 0[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]1 x 5 = 5[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]2 x 5 = 10[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]3 x 5 = 15[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]4 x 5 = 20[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]5 x 5 = 25[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]6 x 5 = 30[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]7 x 5 = 35[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]8 x 5 = 40[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]9 x 5 = 45[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]10 x 5 = 50[/b][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][b]11 x 5 = 55[/b][/cell][/table]
[cadre=astuce]Les résultats de la table de 5 finissent toujours par [b]0[/b] ou par [b]5[/b].[/cadre]
[page]
[titre]La table de 10[/titre]
7 x 10, c'est 7 paquets de 10 : [b]7 dizaines[/b].
[cubes d=7 u=0]
[center][font_size=30][b]7 x 10 = 70[/b][/font_size][/center]
[cadre=astuce]Pour multiplier par 10, j'écris un [b]0[/b] à droite du nombre : 4 x 10 = 40, 11 x 10 = 110.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Multiplier, c'est ajouter plusieurs fois le même nombre : 3 x 5 = 5 + 5 + 5.
• Le résultat s'appelle [b]le produit[/b].
• L'ordre ne change rien : 9 x 5 = 5 x 9 = 45.
• Multiplier par 1 : le nombre ne change pas. Par 0 : le résultat est 0.
• Table de 2 : les doubles. Table de 5 : finit par 0 ou 5.
• Table de 10 : j'écris un 0 à droite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'multiplication'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
