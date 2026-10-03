-- Fiche La proportionnalité (CM1) - notion 'proportionnalite'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La proportionnalité', $fiche$
[titre]Deux fois plus, deux fois plus cher[/titre]
Un stylo coûte [b]2 euros[/b]. Deux stylos coûtent 4 euros, trois stylos 6 euros…
[cadre]Si j'achète [b]2 fois plus[/b] de stylos, je paie [b]2 fois plus[/b].
Si j'en achète 3 fois plus, je paie 3 fois plus. Le prix est [b]proportionnel[/b] au nombre de stylos.[/cadre]
[page]
[titre]Le tableau de proportionnalité[/titre]
[table=5][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Nombre de stylos[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]1[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]3[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]6[/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Prix en euros[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]2[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]4[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]6[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]12[/b][/center][/cell][/table]
[cadre]Pour passer de la 1re ligne à la 2e, je multiplie [b]toujours par le même nombre[/b] : ici, [b]x 2[/b].
1 x 2 = 2 · 3 x 2 = 6 · 6 x 2 = 12.[/cadre]
[page]
[titre]Méthode 1 : passer par 1[/titre]
Pour [b]6 billes[/b], on paie [b]30 euros[/b]. Combien paie-t-on pour [b]18 billes[/b] ?
[cadre]• Je cherche le prix d'[b]une[/b] bille : 30 : 6 = [b]5 euros[/b].
• Puis pour 18 billes : 18 x 5 = [b]90 euros[/b].[/cadre]
On paie [b]90 euros[/b] pour 18 billes.
[page]
[titre]Méthode 2 : multiplier la quantité[/titre]
Même problème : 6 billes coûtent 30 euros. Et 18 billes ?
[cadre]18, c'est [b]3 fois[/b] 6 (6 x 3 = 18). Donc le prix est aussi 3 fois plus grand :
30 x 3 = [b]90 euros[/b].[/cadre]
[cadre=astuce]Les deux méthodes donnent le même résultat. Choisis la plus facile selon les nombres.[/cadre]
[page]
[titre]Méthode 3 : additionner[/titre]
2 cahiers coûtent [b]12 euros[/b]. Combien coûtent [b]12 cahiers[/b] ?
[table=4][cell bg=#classe border=#classe padding=14,6,14,6][center][color=white][b]Cahiers[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center]10[/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]12 = 2 + 10[/b][/center][/cell][cell bg=#unites border=#unites padding=14,6,14,6][center][color=white][b]Prix[/b][/color][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]12[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center]60[/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]12 + 60 = 72[/b][/center][/cell][/table]
[cadre]10 cahiers = 5 fois 2 cahiers : 12 x 5 = 60 euros. Puis 2 + 10 cahiers : 12 + 60 = [b]72 euros[/b].[/cadre]
[page]
[titre]Ce n'est pas toujours proportionnel[/titre]
[cadre]• À 5 ans, Léa mesure 1 m 10. À 10 ans, elle ne mesurera pas 2 m 20 !
• Un paquet de 1 kg de pâtes coûte 2 euros, mais un paquet de 5 kg peut coûter moins de 10 euros.[/cadre]
[cadre=astuce]Avant de calculer, je me demande : « 2 fois plus de… donne-t-il vraiment 2 fois plus de… ? »[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Proportionnel : 2 fois plus de stylos → 2 fois plus cher.
• Dans un tableau, on passe d'une ligne à l'autre en multipliant [b]toujours par le même nombre[/b].
• Méthode 1 : je cherche le prix d'[b]un seul[/b] objet.
• Méthode 2 : je cherche [b]combien de fois[/b] plus d'objets.
• Méthode 3 : j'[b]additionne[/b] deux colonnes.
• Je vérifie que la situation est vraiment proportionnelle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'proportionnalite'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
