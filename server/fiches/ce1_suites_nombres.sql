-- Fiche Les suites de nombres (CE1) - notion 'suites_nombres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'math', 'Les suites de nombres', $fiche$
[titre]Trouver la règle, rappel[/titre]
Une suite suit toujours [b]la même règle[/b]. Je la trouve avec deux nombres qui se suivent.
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]30[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]40[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]50[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]60[/b][/cell][/table]
[cadre]De 30 à 40 : +10. De 40 à 50 : +10. La règle est [b]+10[/b].[/cadre]
[page]
[titre]De 10 en 10, en passant 100[/titre]
[file de=80 a=140 pas=10 bonds=90:100,100:110]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]90[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]120[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]130[/b][/cell][/table]
Après 100 vient [b]110[/b] : 100 + 10 = 110.
[cadre=astuce]Après 9 dizaines, on passe à [b]1 centaine[/b] : 90, 100, 110… comme 9, 10, 11 !
Après 190 vient 200.[/cadre]
[page]
[titre]De 100 en 100[/titre]
[file de=0 a=500 pas=100 bonds=0:100,100:200,200:300,300:400]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]200[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]400[/b][/cell][/table]
[cadre]De 100 en 100, [b]seul le chiffre des centaines change[/b] : il manque [b]300[/b].[/cadre]
[page]
[titre]De 50 en 50[/titre]
[file de=0 a=250 pas=50 bonds=0:50,50:100,100:150,150:200]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]0[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]100[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]150[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]200[/b][/cell][/table]
[cadre]Il manque [b]50[/b]. Deux bonds de 50 font 100.[/cadre]
[cadre=astuce]De 50 en 50, les nombres finissent par 0, puis 50, puis 00, puis 50…[/cadre]
[page]
[titre]Trouver le nombre qui manque[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]190[/b][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][b]___[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]210[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]220[/b][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][b]230[/b][/cell][/table]
1. Je trouve la règle avec deux nombres côte à côte : de 210 à 220, [b]+10[/b].
2. J'applique la règle après le nombre d'avant : 190 + 10 = [b]200[/b].
[cadre]Il manque [b]200[/b]. Je vérifie : 200 + 10 = 210. C'est juste ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Pour trouver la règle, je regarde l'écart entre deux nombres qui se suivent.
• De 10 en 10 : après 90 vient 100, après 190 vient 200.
• De 100 en 100 : seul le chiffre des centaines change.
• De 50 en 50 : deux bonds de 50 font 100.
• Je vérifie avec la règle.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'suites_nombres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
