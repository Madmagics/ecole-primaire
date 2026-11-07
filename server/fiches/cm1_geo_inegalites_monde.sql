-- Fiche Les inégalités dans le monde (CM1) - geographie, notion 'inegalites_monde'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Les inégalités dans le monde', $fiche$
[titre]Des niveaux de vie différents[/titre]
[center][font_size=50]🏠 🏚️[/font_size][/center]
Le [b]niveau de vie[/b], c'est la façon dont les gens peuvent vivre : se loger, se nourrir, se soigner, aller à l'école.
[cadre]Dans le monde, les niveaux de vie sont très différents d'un pays à l'autre, et même à l'intérieur d'un même pays : ce sont les [b]inégalités[/b].[/cadre]
[page]
[titre]Les grandes aires du monde[/titre]
[planisphere pale=oui aires=oui largeur=720]
[page]
[titre]L'accès à l'eau[/titre]
[center][font_size=50]🚰 🪣[/font_size][/center]
Dans les pays riches, l'eau potable arrive au robinet. Ailleurs, des millions de personnes, souvent des femmes et des enfants, marchent longtemps chaque jour pour aller chercher de l'eau.
[cadre]Dans le monde, plus de [b]2 milliards[/b] de personnes n'ont pas d'eau potable sûre chez elles. Boire une eau sale rend malade.[/cadre]
[page]
[titre]L'accès à la santé[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]en Europe, en Amérique du Nord[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans les pays les plus pauvres[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup de médecins et d'hôpitaux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]peu de médecins, des hôpitaux loin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des vaccins et des médicaments[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des maladies que l'on sait soigner
tuent encore[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on vit en moyenne plus de 80 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on vit beaucoup moins longtemps[/font_size][/center][/cell][/table]
[page]
[titre]L'accès à l'éducation[/titre]
[center][font_size=50]🎒 📚[/font_size][/center]
En France, l'école est obligatoire et gratuite. Mais dans le monde, environ [b]250 millions[/b] d'enfants ne vont pas à l'école.
[cadre]Certains doivent travailler pour aider leur famille, d'autres vivent trop loin d'une école ou dans un pays en guerre. Les filles sont souvent les plus touchées.[/cadre]
[page]
[titre]Où sont les inégalités ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]niveau de vie élevé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Amérique du Nord, Europe, Océanie
(Australie), Asie de l'Est (Japon)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]niveau de vie plus faible[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Afrique subsaharienne,
une partie de l'Asie du Sud-Est
et de l'Amérique du Sud[/font_size][/center][/cell][/table]
[cadre]Même dans un pays riche, il y a des personnes pauvres ; et dans un pays pauvre, des personnes très riches.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le niveau de vie n'est pas le même partout : ce sont les [b]inégalités[/b].
• Elles se voient dans l'accès à l'[b]eau[/b], à la [b]santé[/b] et à l'[b]éducation[/b].
• Les aires du monde : Amérique du Nord, Amérique du Sud, Europe, Maghreb, Afrique subsaharienne, Asie de l'Est, Asie du Sud-Est, Océanie.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'inegalites_monde'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
