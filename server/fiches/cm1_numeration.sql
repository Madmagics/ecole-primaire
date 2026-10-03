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
select fn_publier();
