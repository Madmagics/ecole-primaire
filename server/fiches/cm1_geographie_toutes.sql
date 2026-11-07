-- Toutes les fiches de cours Histoire et Geographie CM1 (2026-11-07) : geographie seulement, une seule transaction.
begin;
-- Fiche Se nourrir dans le monde (CM1) - geographie, notion 'se_nourrir'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Se nourrir dans le monde', $fiche$
[titre]Manger, un besoin vital[/titre]
[center][font_size=50]🍚 🍞 🌽[/font_size][/center]
Partout dans le monde, les humains ont besoin de manger. Mais on ne mange pas la même chose ni la même quantité partout.
[cadre]La [b]ration alimentaire[/b], c'est la quantité de nourriture qu'une personne mange en moyenne chaque jour.[/cadre]
[page]
[titre]Des façons de manger différentes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🍚 le riz[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Asie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🍞 le blé (pain, pâtes)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Europe, au Maghreb[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌽 le maïs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Amérique[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🥔 le manioc, le mil[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Afrique[/font_size][/center][/cell][/table]
[cadre]On mange avec des couverts, des baguettes ou avec la main. Les religions et les traditions influencent aussi ce que l'on mange.[/cadre]
[page]
[titre]Trop ou pas assez[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]États-Unis[/b] (Amérique)
[b]France[/b] (Europe)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une ration alimentaire [b]très riche[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]Madagascar[/b] (Afrique)
[b]Haïti[/b] (Amérique)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]une ration alimentaire [b]insuffisante[/b][/font_size][/center][/cell][/table]
[cadre]Dans le monde, environ [b]1 personne sur 12[/b] ne mange pas assez.[/cadre]
[page]
[titre]Sous-nutrition et malnutrition[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]sous-nutrition[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ne pas manger [b]assez[/b] : on a faim[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la [b]malnutrition[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]manger [b]mal[/b] : il manque certains aliments,
ou on mange trop gras, trop sucré[/font_size][/center][/cell][/table]
[cadre]La malnutrition existe aussi dans les pays riches : trop de sucre et de gras peut rendre malade.[/cadre]
[page]
[titre]Pays riche, pays en développement[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans un pays riche[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans un pays en développement[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup de choix, de la viande
et des produits transformés[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]surtout des céréales et des légumes,
peu de viande[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on achète au supermarché[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup cultivent ce qu'ils mangent
ou achètent au marché[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on jette beaucoup de nourriture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]en cas de sécheresse, la nourriture
peut manquer[/font_size][/center][/cell][/table]
[page]
[titre]Produit agricole ou transformé ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]produit agricole[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]produit transformé[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥛 le lait[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍦 le yaourt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🌾 le blé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥖 le pain, les biscuits[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍎 la pomme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥫 la compote[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍫 la fève de cacao[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍫 la tablette de chocolat[/font_size][/center][/cell][/table]
[cadre]Un [b]produit agricole[/b] sort de la ferme. Un [b]produit transformé[/b] a été fabriqué à partir de lui, souvent dans une usine.[/cadre]
[page]
[titre]Du pré au frigo : le yaourt[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1. 🐄 la ferme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'éleveur trait les vaches[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]2. 🚛 le camion[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le lait part à l'usine[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]3. 🏭 la laiterie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on transforme le lait en yaourts
et on les met en pots[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]4. 🚚 l'entrepôt[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les yaourts sont stockés au froid[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]5. 🛒 le magasin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on achète les yaourts[/font_size][/center][/cell][/table]
[page]
[titre]D'où vient ce que je mange ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🍌 la banane[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des Antilles, d'Afrique, d'Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍫 le cacao[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]de Côte d'Ivoire, du Ghana (Afrique)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]☕ le café[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]du Brésil, du Viêt Nam[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍚 le riz[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]d'Asie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🍎 la pomme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]de France[/font_size][/center][/cell][/table]
[cadre]Beaucoup d'aliments voyagent en bateau, en camion ou en avion avant d'arriver dans notre assiette.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• On ne mange pas la même chose ni la même quantité partout dans le monde.
• Ration très riche : États-Unis, France. Ration insuffisante : Madagascar, Haïti.
• [b]Sous-nutrition[/b] : pas assez manger. [b]Malnutrition[/b] : mal manger.
• Un [b]produit agricole[/b] (lait) devient un [b]produit transformé[/b] (yaourt).
• Un aliment passe par une chaîne : ferme, usine, transport, magasin.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'se_nourrir'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

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

-- Fiche Se déplacer (CM1) - geographie, notion 'se_deplacer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Se déplacer', $fiche$
[titre]Je me déplace[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]chaque jour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]aller à l'école : à pied, à vélo, en bus,
en voiture[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]chaque semaine[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]aller au sport, faire les courses[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]pendant les vacances[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]partir loin : en train, en voiture,
en avion, en bateau[/font_size][/center][/cell][/table]
[cadre]Plus la distance est grande, plus on choisit un moyen de transport rapide.[/cadre]
[page]
[titre]Moyens de transport et infrastructures[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]je me déplace en…[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]j'utilise…[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚶 la marche[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le trottoir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚲 le vélo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la voie cyclable (piste cyclable)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚗 la voiture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la route, l'autoroute[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚇 le métro[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la station[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚆 le train[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la gare[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]⛴️ le bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le port[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]✈️ l'avion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'aéroport[/font_size][/center][/cell][/table]
[page]
[titre]Mesurer un déplacement[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]distance en kilomètres[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la longueur du trajet
(Paris → Marseille : environ 750 km)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la [b]distance en temps[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la durée du trajet
(en TGV : un peu plus de 3 heures)[/font_size][/center][/cell][/table]
[cadre=astuce]Deux lieux peuvent être éloignés en kilomètres mais proches en temps, si un moyen de transport rapide les relie.[/cadre]
[page]
[titre]Paris → Marseille[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]moyen de transport[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]durée[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🚗 en voiture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]environ 7 heures 30[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🚆 en TGV[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]un peu plus de 3 heures[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]✈️ en avion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]environ 1 heure 20 de vol[/font_size][/center][/cell][/table]
[cadre]La distance en kilomètres ne change pas, mais la distance en temps dépend du moyen de transport.[/cadre]
[page]
[titre]Se déplacer dans le monde[/titre]
[center][font_size=50]✈️ 🚢 🌍[/font_size][/center]
L'[b]avion[/b] permet de relier les continents en quelques heures. Les grands [b]aéroports[/b] accueillent des millions de voyageurs.
[cadre]Les [b]bateaux[/b] transportent surtout des marchandises, dans de grands conteneurs : la plupart des objets que nous achetons ont voyagé par la mer.[/cadre]
[page]
[titre]Tout le monde ne voyage pas pareil[/titre]
[center][font_size=50]🚶 🚌 ✈️[/font_size][/center]
Dans les pays riches, beaucoup de personnes ont une voiture et prennent l'avion. Dans les pays pauvres, beaucoup se déplacent à pied, à vélo ou en bus.
[cadre]Les transports polluent : on encourage la marche, le vélo, les transports en commun et le train.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• On se déplace chaque jour, chaque semaine, pendant les vacances, avec des moyens de transport différents.
• À chaque moyen de transport son infrastructure : avion/aéroport, bateau/port, train/gare, voiture/route, métro/station, vélo/voie cyclable.
• On mesure un déplacement en [b]kilomètres[/b] ou en [b]temps[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'se_deplacer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

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

commit;
select fn_publier();
