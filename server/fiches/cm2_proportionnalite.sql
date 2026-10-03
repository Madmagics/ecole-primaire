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
select fn_publier();
