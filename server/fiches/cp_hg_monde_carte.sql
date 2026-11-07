-- Fiche Les continents et les océans (CP) - geographie, notion 'monde_carte'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Les continents et les océans', $fiche$
[titre]La Terre, notre planète[/titre]
[center][font_size=70]🌍[/font_size][/center]
La Terre est une [b]planète[/b]. Elle est ronde comme une boule.
Elle est couverte de [b]terres[/b] et de beaucoup d'[b]eau[/b] : les mers et les océans.
[cadre]Il y a beaucoup plus d'eau que de terre. Vue de l'espace, la Terre est bleue.[/cadre]
[page]
[titre]Le globe et le planisphère[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le globe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le planisphère[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=48]🌐[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=48]🗺️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une boule qui représente la Terre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une carte de toute la Terre, mise à plat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On le fait tourner : on voit une moitié à la fois.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On voit toute la Terre d'un seul coup.[/font_size][/center][/cell][/table]
[cadre=astuce]Pour faire un planisphère, on « déplie » la Terre comme la peau d'une orange qu'on aplatit.[/cadre]
[page]
[titre]Le planisphère[/titre]
[planisphere]
[cadre]Les [b]terres[/b] sont en couleur. L'[b]eau[/b] est en bleu. Chaque couleur est un [b]continent[/b].[/cadre]
[page]
[titre]Les continents[/titre]
Un [b]continent[/b] est une très grande étendue de terre.
[planisphere noms=oui largeur=660]
[page]
[titre]Les continents à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Europe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Le continent de la France.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Asie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Le plus grand continent. Le plus peuplé.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Afrique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]On y trouve le Sahara, un immense désert.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Amérique du Nord, l'Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Deux parties reliées par une bande de terre.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Océanie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Avec l'Australie et beaucoup d'îles.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Antarctique[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Au pôle Sud, couvert de glace. Presque personne n'y vit.[/font_size][/center][/cell][/table]
[cadre=astuce]On dit parfois « l'Amérique » pour l'Amérique du Nord et l'Amérique du Sud ensemble.[/cadre]
[page]
[titre]Les océans[/titre]
Un [b]océan[/b] est une immense étendue d'eau salée.
[planisphere oceans=tous largeur=640]
[cadre]Les 3 grands océans : l'océan [b]Pacifique[/b] (le plus grand), l'océan [b]Atlantique[/b] et l'océan [b]Indien[/b]. Près des pôles : l'océan Arctique et l'océan Austral.[/cadre]
[page]
[titre]Tous les océans se touchent[/titre]
Les océans ne sont pas séparés : ils se rejoignent tous. Un bateau peut aller d'un océan à l'autre.
[cadre]Sur le planisphère, l'océan Pacifique est coupé en deux : on le voit à gauche [b]et[/b] à droite. C'est le même océan qui fait le tour de la Terre.[/cadre]
[cadre=astuce]L'océan Atlantique est entre l'Amérique, à l'ouest, et l'Europe et l'Afrique, à l'est.[/cadre]
[page]
[titre]Les points cardinaux[/titre]
[planisphere noms=oui cardinaux=oui largeur=600]
[cadre]Sur une carte : le [b]Nord[/b] est en haut, le [b]Sud[/b] en bas, l'[b]Est[/b] à droite et l'[b]Ouest[/b] à gauche.
L'Afrique est au sud de l'Europe. L'Asie est à l'est de l'Europe.[/cadre]
[page]
[titre]Où est la France ?[/titre]
[planisphere seul=europe noms=oui france=oui largeur=620]
[cadre]La France est en [b]Europe[/b], à l'ouest du continent.
Des territoires français sont très loin, au milieu des océans : la Guadeloupe, la Martinique, La Réunion, Mayotte… et la Guyane, en Amérique du Sud.[/cadre]
[page]
[titre]Où vivent les êtres humains ?[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]🏙️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'Asie (la Chine, l'Inde) et l'Europe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][font_size=30]🏜️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]très peu d'habitants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]les grands déserts, les hautes montagnes,
les grandes forêts[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]❄️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]presque personne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'Antarctique, très froid[/font_size][/center][/cell][/table]
[cadre]Les endroits où vivent beaucoup de personnes s'appellent des [b]foyers de peuplement[/b]. Le plus grand est en [b]Asie[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]globe[/b] est une boule, le [b]planisphère[/b] une carte à plat de la Terre.
• Les continents : Europe, Asie, Afrique, Amérique du Nord, Amérique du Sud, Océanie, Antarctique.
• Les 3 grands océans : [b]Pacifique[/b], [b]Atlantique[/b], [b]Indien[/b]. Ils se touchent tous.
• Nord en haut, Sud en bas, Est à droite, Ouest à gauche.
• La France est en [b]Europe[/b]. L'Asie est le continent le plus peuplé.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'monde_carte'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
