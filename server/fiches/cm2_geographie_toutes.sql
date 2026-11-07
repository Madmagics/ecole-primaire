-- Toutes les fiches de cours Histoire et Geographie CM2 (2026-11-07) : geographie seulement, une seule transaction.
begin;
-- Fiche L'organisation du territoire français (CM2) - geographie, notion 'territoire_france'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'L''organisation du territoire français', $fiche$
[titre]Communes, départements, régions[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]combien ?[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]qui décide ?[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🏘️ la [b]commune[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]environ 35 000[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]dirigée par le maire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🗺️ le [b]département[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]101[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le conseil départemental[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🌍 la [b]région[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]18[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le conseil régional[/font_size][/center][/cell][/table]
[cadre]La France est découpée en territoires emboîtés : une commune est dans un département, qui est dans une région.[/cadre]
[page]
[titre]Les régions de métropole[/titre]
[carte vue=france regions=oui largeur=420]
[page]
[titre]Les 13 régions de métropole[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]région[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]capitale[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Hauts-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Lille[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Normandie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Rouen[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Île-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Paris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Grand Est[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Strasbourg[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Bretagne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Rennes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Pays de la Loire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Nantes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Centre-Val de Loire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Orléans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Bourgogne-Franche-Comté[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Dijon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Nouvelle-Aquitaine[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Bordeaux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Auvergne-Rhône-Alpes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Lyon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Occitanie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Toulouse[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Provence-Alpes-Côte d'Azur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Marseille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Corse[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Ajaccio[/font_size][/center][/cell][/table]
[page]
[titre]Les 5 régions d'outre-mer[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]région[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]capitale[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Guadeloupe[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Basse-Terre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la [b]Martinique[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]Fort-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Guyane[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Cayenne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]La Réunion[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]Saint-Denis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]Mayotte[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Mamoudzou[/font_size][/center][/cell][/table]
[cadre]13 régions en métropole + 5 en outre-mer = [b]18 régions[/b].[/cadre]
[page]
[titre]Mon département[/titre]
[center][font_size=56]📮[/font_size][/center]
Chaque département a un nom et un numéro. Les deux premiers chiffres du code postal donnent souvent le numéro du département.
[cadre=astuce]75 = Paris, 13 = Bouches-du-Rhône, 69 = Rhône, 59 = Nord. Et toi, dans quel département vis-tu ?[/cadre]
[page]
[titre]Les grands axes de transport[/titre]
[carte vue=france tgv=oui villes=oui largeur=400]
[page]
[titre]Routes et voies ferrées[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚆 le [b]TGV[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]train à grande vitesse (plus de 300 km/h)
depuis 1981 ; les lignes partent de Paris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🛣️ les [b]autoroutes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Paris-Lille, Paris-Lyon-Marseille
(l'autoroute du Soleil), Paris-Bordeaux…[/font_size][/center][/cell][/table]
[cadre]Les grands axes forment une [b]étoile[/b] autour de Paris et relient les grandes agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.[/cadre]
[page]
[titre]Deux régions à comparer[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Île-de-France[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Auvergne-Rhône-Alpes[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la région la plus peuplée :
plus de 12 millions d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des grandes villes (Lyon, Grenoble)
et des montagnes (Alpes, Massif central)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la capitale, des sièges d'entreprises,
de grands aéroports[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]de l'industrie, des stations de ski,
de l'agriculture[/font_size][/center][/cell][/table]
[cadre=astuce]Et ta région ? Cherche sa capitale, ses grandes villes et ses paysages.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• La France est organisée en [b]communes[/b], [b]départements[/b] (101) et [b]régions[/b] (18 : 13 en métropole, 5 en outre-mer).
• Les 5 premières agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.
• Les autoroutes et les lignes de [b]TGV[/b] forment une étoile autour de Paris.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'territoire_france'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les usages de l'eau douce en France (CM2) - geographie, notion 'eau_douce'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'Les usages de l''eau douce en France', $fiche$
[titre]Une ressource limitée[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]💧 eau salée[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]presque toute l'eau de la Terre :
les mers et les océans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🧊 eau douce[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]environ 3 % seulement,
surtout gelée dans les glaciers[/font_size][/center][/cell][/table]
[cadre]L'eau douce que l'on peut utiliser est très rare : il faut l'économiser et la protéger.[/cadre]
[page]
[titre]Où trouve-t-on l'eau douce ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🏞️ les fleuves et les rivières[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌊 les lacs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🏔️ les glaciers et la neige des montagnes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🪨 les [b]nappes phréatiques[/b][/font_size][/center][/cell][/table]
[cadre]Une [b]nappe phréatique[/b] est de l'eau de pluie stockée sous la terre, dans les roches. On la pompe pour avoir de l'eau potable.[/cadre]
[page]
[titre]Fleuves et lacs[/titre]
[carte vue=france fleuves=oui lacs=oui largeur=420]
[page]
[titre]Fleuves et lacs à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]les fleuves[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Loire, Seine, Garonne, Rhône, Rhin
(et le Maroni en Guyane)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]les massifs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]Alpes, Pyrénées, Massif central, Jura,
Vosges, Corse : de là partent les cours d'eau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le [b]lac du Bourget[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le plus grand lac [b]naturel[/b]
entièrement français[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le [b]lac de Serre-Ponçon[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]un lac [b]artificiel[/b], créé
par un barrage sur la Durance[/font_size][/center][/cell][/table]
[page]
[titre]À quoi sert l'eau ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]🚰 boire, se laver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]chaque Français utilise environ
150 litres d'eau par jour[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]🌽 l'agriculture[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arroser les champs (l'irrigation) :
c'est elle qui consomme le plus[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]🏭 l'industrie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]fabriquer et refroidir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]⚡ l'électricité[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]les barrages ; refroidir les centrales[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]⛵ les loisirs, le transport[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]baignade, bateaux, péniches[/font_size][/center][/cell][/table]
[page]
[titre]Une eau menacée[/titre]
[center][font_size=50]☀️ 🏜️ 🧪[/font_size][/center]
Pendant les [b]sécheresses[/b], les rivières et les nappes baissent : les préfets limitent alors l'usage de l'eau (arrosage interdit…).
[cadre]L'eau peut aussi être [b]polluée[/b] par les engrais, les pesticides, les usines. On la nettoie dans des stations d'épuration avant de la rendre à la nature.[/cadre]
[page]
[titre]Les conflits d'usages[/titre]
[center][font_size=50]⚡ 🌾 🏊[/font_size][/center]
Le lac de [b]Serre-Ponçon[/b] sert à produire de l'électricité, à arroser les cultures de Provence, à fournir de l'eau potable et à accueillir les touristes.
[cadre]Quand il fait sec, il n'y a pas assez d'eau pour tout le monde : chacun veut l'utiliser pour son activité. C'est un [b]conflit d'usages[/b]. Il faut alors partager l'eau.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'eau douce est une ressource [b]limitée[/b] : fleuves, lacs, glaciers, [b]nappes phréatiques[/b].
• On l'utilise pour boire, l'agriculture, l'industrie, l'électricité, les loisirs.
• Sécheresses et pollution la menacent.
• Plusieurs activités veulent la même eau : ce sont des [b]conflits d'usages[/b].
• Lac naturel : le lac du Bourget. Lac artificiel : Serre-Ponçon.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'eau_douce'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche L'Union européenne (CM2) - geographie, notion 'union_europeenne'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'L''Union européenne', $fiche$
[titre]Europe et Union européenne[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'[b]Europe[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un [b]continent[/b] : de l'océan Atlantique
aux monts Oural, environ 50 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'[b]Union européenne[/b] (UE)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une [b]union de pays[/b] qui ont choisi
de travailler ensemble : 27 pays[/font_size][/center][/cell][/table]
[cadre]Tous les pays d'Europe ne sont pas dans l'UE : par exemple la Suisse, la Norvège ou le Royaume-Uni, qui l'a quittée en 2020.[/cadre]
[page]
[titre]Les 27 pays de l'UE[/titre]
[carte vue=europe fondateurs=oui noms=oui largeur=380]
[page]
[titre]Les 6 pays fondateurs[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/fr.svg[/img] la France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/de.svg[/img] l'Allemagne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/it.svg[/img] l'Italie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/be.svg[/img] la Belgique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/nl.svg[/img] les Pays-Bas[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][img=30x20]res://ui/fiche/drapeaux/lu.svg[/img] le Luxembourg[/font_size][/center][/cell][/table]
[cadre]En [b]1957[/b], ces 6 pays signent le [b]traité de Rome[/b] : ils créent la Communauté économique européenne. D'autres pays les rejoignent ensuite : l'Espagne, le Portugal, la Pologne, la Suède, la Grèce, l'Irlande…[/cadre]
[page]
[titre]De la CEE à l'UE[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]1957[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]traité de Rome : 6 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]1992[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]traité de Maastricht[/b] :
naissance de l'Union européenne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]2002[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les pièces et billets en euros[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]2020[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le Royaume-Uni quitte l'UE[/font_size][/center][/cell][/table]
[page]
[titre]Ce que l'UE apporte[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🕊️ la paix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]entre des pays autrefois en guerre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🚶 la libre circulation[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]voyager, étudier, travailler
dans les autres pays[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]💶 l'[b]euro[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une monnaie commune
à plus de 20 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏗️ des aides[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]pour construire des routes, des tramways,
rénover des écoles…[/font_size][/center][/cell][/table]
[page]
[titre]Les symboles de l'UE[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le drapeau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]12 étoiles d'or sur fond bleu[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'hymne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'« Ode à la joie » de Beethoven[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la devise[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]« Unie dans la diversité »[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la fête[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le 9 mai, journée de l'Europe[/font_size][/center][/cell][/table]
[cadre=astuce]Cherche près de ton école un panneau « projet financé par l'Union européenne » : c'est un aménagement aidé par l'UE.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'[b]Europe[/b] est un continent ; l'[b]Union européenne[/b] est une union de 27 pays.
• [b]1957[/b] : traité de Rome (6 pays fondateurs : France, Allemagne, Italie, Belgique, Pays-Bas, Luxembourg).
• [b]1992[/b] : traité de Maastricht, naissance de l'UE.
• L'UE apporte la paix, la libre circulation, l'euro et des aides pour des aménagements.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'union_europeenne'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
