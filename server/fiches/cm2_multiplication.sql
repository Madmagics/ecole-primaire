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
select fn_publier();
