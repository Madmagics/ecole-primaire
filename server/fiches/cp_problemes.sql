-- Fiche Petits problèmes (CP) - notion 'problemes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'math', 'Petits problèmes', $fiche$
[titre]Lire un problème[/titre]
Un problème, c'est une petite histoire avec des nombres et [b]une question[/b].
[cadre]Mia a 5 crayons. Elle en reçoit 7 de plus.
[b]Combien Mia a-t-elle de crayons maintenant ?[/b][/cadre]
1. Je lis l'histoire [b]deux fois[/b].
2. Je trouve [b]la question[/b] : elle finit par « ? ».
3. Je cherche [b]les nombres[/b] : 5 et 7.
4. Je choisis [b]+ ou -[/b] : « elle en reçoit », elle en a plus. J'ajoute.
5. Je [b]calcule[/b] : 5 + 7 = 12.
6. Je [b]réponds par une phrase[/b] : Mia a 12 crayons.
[page]
[titre]Plus ou moins ?[/titre]
Des mots de l'histoire me disent s'il faut ajouter ou enlever :
[table=2][cell bg=#classe border=#classe padding=14,6,14,6][b]+  J'ajoute[/b][/cell][cell bg=#unites border=#unites padding=14,6,14,6][b]-  J'enlève[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6]reçoit, gagne, achète, trouve, [b]de plus[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6]donne, perd, mange, casse, [b]il reste[/b][/cell][/table]
[cadre=astuce]Je me demande : à la fin, est-ce qu'il y en a [b]plus[/b] ou [b]moins[/b] qu'au début ?[/cadre]
[page]
[titre]Un problème avec +[/titre]
Alice a 5 ballons. Elle en reçoit 7 de plus. Combien Alice a-t-elle de ballons maintenant ?
« Elle en [b]reçoit[/b] » : elle en a plus qu'avant. J'ajoute.
[billes groupes=5,7 couleurs=bleu,rouge total=oui]
[center][font_size=30][b]5 + 7 = 12[/b][/font_size][/center]
[cadre]Je réponds par une phrase : [b]Alice a 12 ballons.[/b][/cadre]
[page]
[titre]Un problème avec -[/titre]
Iris a 11 billes. Elle en donne 3. Combien lui reste-t-il de billes ?
« Elle en [b]donne[/b] » : il lui en reste moins. J'enlève.
[billes groupes=11 couleurs=bleu barrees=3 total=oui]
[center][font_size=30][b]11 - 3 = 8[/b][/font_size][/center]
[cadre]Je réponds par une phrase : [b]Il reste 8 billes à Iris.[/b][/cadre]
[page]
[titre]Avec de plus grands nombres[/titre]
Chloé a 16 cartes. Elle en donne 12. Combien lui reste-t-il de cartes ?
Elle donne : c'est une soustraction, [b]16 - 12[/b].
Les deux nombres sont proches : j'avance de 12 jusqu'à 16.
[file de=10 a=18 bonds=12:16]
[cadre][b]16 - 12 = 4[/b]. Il reste 4 cartes à Chloé.[/cadre]
[page]
[titre]Ma réponse a-t-elle du sens ?[/titre]
Avant de répondre, je vérifie :
[cadre]• Si on [b]reçoit[/b], la réponse est [b]plus grande[/b] que le nombre du début.
• Si on [b]donne[/b], la réponse est [b]plus petite[/b] que le nombre du début.[/cadre]
Iris avait 11 billes et elle en donne 3. Si je trouve 14, c'est faux : elle ne peut pas en avoir plus qu'avant !
[page]
[titre]Je retiens[/titre]
[cadre]• Je lis l'histoire deux fois et je trouve la question.
• Je cherche les nombres.
• [b]Reçoit, gagne, de plus[/b] : j'ajoute avec +.
• [b]Donne, perd, il reste[/b] : j'enlève avec -.
• Je calcule, puis je réponds par une phrase.
• Je vérifie que ma réponse a du sens.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'problemes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
