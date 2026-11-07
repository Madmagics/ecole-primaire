-- Fiche Communiquer avec Internet (CM1) - geographie, notion 'internet'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Communiquer avec Internet', $fiche$
[titre]À quoi sert Internet ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🔎 chercher des informations[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]💬 envoyer des messages[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]🎬 regarder des vidéos[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]🎮 jouer en ligne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🛒 acheter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]💼 travailler, apprendre[/font_size][/center][/cell][/table]
[cadre][b]Internet[/b] est un immense [b]réseau[/b] qui relie des milliards d'ordinateurs, de téléphones et de tablettes dans le monde.[/cadre]
[page]
[titre]Comment ça marche ?[/titre]
[center][font_size=46]📱 ➡️ 🏢 ➡️ 🌍[/font_size][/center]
Quand j'envoie un message, il part sous forme d'informations numériques. Il voyage par des câbles et arrive dans de grands bâtiments remplis d'ordinateurs, les [b]centres de données[/b], puis jusqu'à l'appareil de mon correspondant.
[cadre]Tout cela prend moins d'une seconde, même à l'autre bout du monde ![/cadre]
[page]
[titre]Les câbles sous-marins[/titre]
[planisphere pale=oui cables=oui largeur=720]
[cadre]Des câbles posés au fond des océans relient les continents. Ils sont très nombreux dans l'[b]Atlantique Nord[/b], le [b]Pacifique Nord[/b] et entre l'Europe et l'Asie.[/cadre]
[page]
[titre]Câbles et satellites[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]câbles[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]sur les continents et sous les mers :
presque toutes les informations passent par eux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les [b]satellites[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]tournent autour de la Terre : ils relient
les endroits isolés (montagnes, déserts, bateaux)[/font_size][/center][/cell][/table]
[page]
[titre]Un accès inégal dans le monde[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Europe, Amérique du Nord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]très bien reliées :
plus de 9 personnes sur 10 utilisent Internet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Afrique subsaharienne[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]faiblement reliée :
moins de 4 personnes sur 10[/font_size][/center][/cell][/table]
[cadre]Dans le monde, environ 2 personnes sur 3 utilisent Internet. Plus de 2 milliards de personnes n'y ont pas accès.[/cadre]
[page]
[titre]Et en France ?[/titre]
[center][font_size=50]📶 🏙️ 🏔️[/font_size][/center]
Presque tous les Français peuvent utiliser Internet. Mais la [b]5G[/b], le réseau mobile le plus rapide, est surtout installée dans les [b]villes[/b].
[cadre]Dans certaines campagnes et montagnes, le réseau est faible, voire absent : on parle de « zones blanches ».[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Internet est un [b]réseau[/b] mondial qui sert à s'informer, communiquer, se divertir, travailler.
• Il repose sur des [b]câbles[/b] (dont des [b]câbles sous-marins[/b]) et des [b]satellites[/b].
• L'accès est inégal : l'Europe et l'Amérique du Nord sont très bien reliées, l'Afrique subsaharienne beaucoup moins.
• En France, la 5G est surtout présente dans les villes.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'internet'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
