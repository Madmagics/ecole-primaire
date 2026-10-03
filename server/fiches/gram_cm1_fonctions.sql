-- Fiche COD, COI et attribut du sujet (CM1) - grammaire, notion 'fonctions'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'grammaire', 'COD, COI et attribut du sujet', $fiche$
[titre]Les compléments du verbe[/titre]
Après le verbe, on trouve souvent un groupe de mots qui le [b]complète[/b].
[cadre]Le pêcheur attrape [b]un poisson[/b]. → COD
Elle succède [b]à son père[/b]. → COI
Ce jeu semble [b]amusant[/b]. → attribut du sujet[/cadre]
[page]
[titre]Le COD[/titre]
Le [b]COD[/b] (complément d'objet direct) se trouve en posant la question [b]qui ?[/b] ou [b]quoi ?[/b] juste après le verbe.
[cadre]Le fermier cultive [b]son champ[/b]. → Il cultive quoi ? son champ
Nous préparons [b]le dîner[/b]. → Nous préparons quoi ? le dîner[/cadre]
[cadre=astuce]« Direct » : il n'y a [b]pas de petit mot[/b] (à, de) entre le verbe et le COD.[/cadre]
[page]
[titre]Le COI[/titre]
Le [b]COI[/b] (complément d'objet indirect) répond à [b]à qui ? à quoi ? de qui ? de quoi ?[/b]
[cadre]Le public sourit [b]aux artistes[/b]. → sourit à qui ? aux artistes
Elle parle [b]de son voyage[/b]. → parle de quoi ? de son voyage[/cadre]
[cadre=astuce]« Indirect » : il commence par [b]à, au, aux, de, du, des[/b].[/cadre]
[page]
[titre]L'attribut du sujet[/titre]
Après [b]être, sembler, paraître, devenir, rester, avoir l'air[/b], le mot qui suit dit [b]comment est le sujet[/b] : c'est l'[b]attribut du sujet[/b].
[cadre]La soupe [b]semble[/b] trop salée. → la soupe = trop salée
Mon père [b]est[/b] pompier. → mon père = pompier[/cadre]
[cadre=astuce]Test : je peux mettre « [b]=[/b] » entre le sujet et l'attribut. Il s'accorde avec le sujet : la météo semble incertain[b]e[/b].[/cadre]
[page]
[titre]Ma méthode[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je me demande[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Fonction[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]être, sembler, paraître… ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]oui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]attribut du sujet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Verbe + qui ? quoi ?[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]sans à / de[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]COD[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Verbe + à qui ? de quoi ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]avec à / de[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]COI[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]COD[/b] : verbe + qui ? / quoi ? sans préposition → il range [b]ses affaires[/b].
• [b]COI[/b] : verbe + à qui ? / de quoi ? avec à, de → il sourit [b]aux artistes[/b].
• [b]Attribut du sujet[/b] : après être, sembler, paraître… → ce jeu semble [b]amusant[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'fonctions'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
