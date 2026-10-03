-- Fiche La division (CE2) - notion 'division'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'La division', $fiche$
[titre]Partager en parts égales[/titre]
J'ai 12 billes. Je les partage [b]en 3 parts égales[/b], entre 3 enfants :
[billes groupes=4,4,4 couleurs=bleu,rouge,vert signes=non]
[cadre]Chaque enfant a [b]4 billes[/b]. Partager en parts égales, c'est faire [b]une division[/b].[/cadre]
[page]
[titre]Le signe :[/titre]
[center][font_size=34][b]12 : 3 = 4[/b][/font_size][/center]
[center]« douze divisé par trois égale quatre »[/center]
[cadre]Le signe [b]:[/b] se lit « divisé par ». Le résultat d'une division s'appelle [b]le quotient[/b].[/cadre]
[cadre=astuce]Dans un partage, toutes les parts sont [b]égales[/b] : personne n'en a plus que les autres.[/cadre]
[page]
[titre]Faire des groupes[/titre]
Une division répond aussi à : « combien de groupes de 5 puis-je faire avec 15 ? »
[billes groupes=5,5,5 couleurs=bleu,bleu,bleu signes=non]
[cadre]Avec 15 billes, je fais [b]3 groupes de 5[/b]. 15 : 5 = 3.[/cadre]
[page]
[titre]Division et multiplication[/titre]
3 lignes de 4 cases : 12 cases.
[grille lignes=3 colonnes=4]
[cadre]3 x 4 = 12, donc [b]12 : 3 = 4[/b] et [b]12 : 4 = 3[/b].
La division, c'est la multiplication [b]à l'envers[/b].[/cadre]
[page]
[titre]Diviser avec les tables[/titre]
Pour [b]42 : 7[/b], je me demande : « 7 fois combien font 42 ? »
Je récite la table de 7 : 7, 14, 21, 28, 35, [b]42[/b].
[table=6][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]7[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]14[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]21[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]28[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center]35[/center][/cell][cell bg=#unites_clair border=#unites padding=12,6,12,6][center][b]42[/b][/center][/cell][/table]
[cadre]42, c'est [b]6 fois 7[/b] : 7 x 6 = 42, donc [b]42 : 7 = 6[/b].[/cadre]
[page]
[titre]Les divisions faciles[/titre]
[cadre]• Diviser [b]par 1[/b] : le nombre ne change pas. 9 : 1 = 9
• Un nombre divisé [b]par lui-même[/b] donne 1. 7 : 7 = 1
• Diviser [b]par 2[/b], c'est prendre la moitié. 18 : 2 = 9
• Diviser [b]par 10[/b] un nombre qui finit par 0 : j'enlève le 0. 80 : 10 = 8 ; 120 : 10 = 12[/cadre]
[page]
[titre]Plus grand que la table[/titre]
Pour [b]72 : 6[/b], je découpe 72 en deux morceaux faciles : 60 et 12.
[cadre]60 : 6 = [b]10[/b]. 12 : 6 = [b]2[/b]. Donc 72 : 6 = 10 + 2 = [b]12[/b].[/cadre]
[cadre=astuce]Je vérifie avec une multiplication : 12 x 6 = 60 + 12 = 72. C'est juste ![/cadre]
[page]
[titre]Un problème de partage[/titre]
On partage [b]48 autocollants[/b] en [b]8 groupes égaux[/b]. Combien y a-t-il d'autocollants par groupe ?
Partager en groupes égaux : c'est une division, [b]48 : 8[/b].
Table de 8 : 8 x 6 = 48, donc 48 : 8 = 6.
[cadre]Il y a [b]6 autocollants[/b] par groupe.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Diviser, c'est [b]partager en parts égales[/b] ou faire des groupes égaux.
• Le signe [b]:[/b] se lit « divisé par ». Le résultat est [b]le quotient[/b].
• La division, c'est la multiplication à l'envers : 7 x 6 = 42, donc 42 : 7 = 6.
• Par 1 : rien ne change. Par lui-même : 1. Par 2 : la moitié. Par 10 : j'enlève le 0.
• Grand nombre : je le découpe. 72 : 6 → 60 : 6 = 10 et 12 : 6 = 2, donc 12.
• Je vérifie avec une multiplication.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'division'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
