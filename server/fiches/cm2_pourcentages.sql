-- Fiche Les pourcentages (CM2) - notion 'pourcentages'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'math', 'Les pourcentages', $fiche$
[titre]Que veut dire « % » ?[/titre]
[b]25 %[/b] se lit « 25 pour cent » : [b]25 sur 100[/b], c'est-à-dire 25/100.
[grille lignes=10 colonnes=10 case=17 colorees=25]
[cadre]Sur 100 cases, 25 sont coloriées : [b]25 %[/b] des cases.[/cadre]
[page]
[titre]Les pourcentages à connaître[/titre]
[table=3][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Pourcentage[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Fraction[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=14,3,14,3][center][color=white][b]Je calcule[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]100 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]tout[/center][/cell][cell border=#classe padding=14,3,14,3][center]le nombre entier[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]50 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/2, la moitié[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 2[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]25 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/4, le quart[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 4[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]75 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]3/4, trois quarts[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 4, puis x 3[/center][/cell][cell bg=#classe_clair border=#classe padding=14,3,14,3][center][b]10 %[/b][/center][/cell][cell border=#classe padding=14,3,14,3][center]1/10, un dixième[/center][/cell][cell border=#classe padding=14,3,14,3][center]: 10[/center][/cell][/table]
[page]
[titre]50 % et 25 %[/titre]
[cadre]• [b]50 % de 376[/b], c'est la moitié : 376 : 2 = [b]188[/b].
• [b]25 % de 280[/b], c'est le quart : 280 : 4 = [b]70[/b].[/cadre]
[cadre=astuce]Le quart, c'est la moitié de la moitié : 280 → 140 → [b]70[/b].[/cadre]
[page]
[titre]10 % et 20 %[/titre]
[cadre]• [b]10 % de 420[/b] : je divise par 10. 420 : 10 = [b]42[/b].
• [b]20 % de 420[/b] : deux fois 10 %. 42 x 2 = [b]84[/b].[/cadre]
[cadre=astuce]Avec 10 %, je peux trouver 20 %, 30 %, 40 %… en multipliant.[/cadre]
[page]
[titre]75 %[/titre]
[b]75 % de 296[/b] : 75 %, ce sont [b]3 quarts[/b].
[cadre]Méthode 1 : un quart de 296 = 296 : 4 = 74. Trois quarts : 74 x 3 = [b]222[/b].
Méthode 2 : 50 % + 25 % = 148 + 74 = [b]222[/b].[/cadre]
[page]
[titre]Les soldes[/titre]
Un manteau coûte [b]60 euros[/b]. Il est soldé à [b]- 25 %[/b]. Combien coûte-t-il maintenant ?
[cadre]Étape 1, la réduction : 25 % de 60 = 60 : 4 = [b]15 euros[/b].
Étape 2, le nouveau prix : 60 - 15 = [b]45 euros[/b].[/cadre]
[cadre=astuce]Attention : - 25 % ne veut pas dire « 25 euros de moins » ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 25 % = 25 sur 100 = 25/100.
• 50 % : la moitié (: 2). 25 % : le quart (: 4). 75 % : trois quarts.
• 10 % : je divise par 10. 20 % = 2 fois 10 %.
• Une réduction de 25 % : je calcule la réduction, puis je l'enlève du prix.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pourcentages'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
