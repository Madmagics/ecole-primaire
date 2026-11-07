# Fiches de cours Histoire et Geographie CE2 (2026-11-07), programme du BO n° 22 du 28 mai 2026
# (cycle 2, annexe 3). Histoire : 3 themes du CE2, le theme 2 (Rome) coupe en deux fiches
# (Vivre a Rome / La Gaule romaine). Geographie « Vivre en France » : 3 themes, une fiche chacun.
# Nouveaux dessins (FicheDessin, 2026-11-07) : [carte ...] (France, domaine royal, empire romain), [quartiers].
# Sorties : server/fiches/ce2_hg_<code>.sql, ce2_histgeo_toutes.sql, un .txt par fiche (rendu).
# Les fiches sont la source des futures questions (decision de Steve).
import os
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt
from gen_cp_histgeo import emo, gros, SQL, MATIERE

CL = 'ce2'
FICHES = []


def add(code, titre, domaine, pages):
    FICHES.append((CL, code, titre, domaine, [couleur_alt(CL, p) for p in pages]))


# =====================================================================  HISTOIRE 1
add('prehistoire', 'La Préhistoire : Paléolithique et Néolithique', 'histoire', [
"""[titre]La Préhistoire[/titre]
[periodes marque=1]
La Préhistoire est la [b]plus longue période[/b] de l'histoire : elle commence avec les premiers humains, il y a environ [b]3 millions d'années[/b], et se termine vers [b]3000 av. J.-C.[/b], quand l'écriture apparaît.
[cadre]On la coupe en deux grandes parties : le [b]Paléolithique[/b], puis le [b]Néolithique[/b].[/cadre]""",
"""[titre]Paléolithique et Néolithique[/titre]
[frise points=il_y_a_3_millions_d'années,vers_10000_av._J.-C.,3200_av._J.-C.,vers_3000_av._J.-C. debut=Paléolithique fin=Néolithique]
[cadre]• Le [b]Paléolithique[/b] : des premiers humains jusqu'à la naissance de l'agriculture, [b]vers 10000 av. J.-C.[/b]
• Le [b]Néolithique[/b] : de la naissance de l'agriculture jusqu'à l'apparition de l'[b]écriture[/b], [b]vers 3000 av. J.-C.[/b][/cadre]
[cadre=astuce][b]Paléo[/b]lithique = « pierre ancienne ». [b]Néo[/b]lithique = « pierre nouvelle ».[/cadre]""",
f"""[titre]Au Paléolithique : des nomades[/titre]
{gros('🦣 🏹 🫐', 50)}
Les humains sont des [b]chasseurs-cueilleurs[/b] : ils chassent (mammouths, rennes, chevaux), pêchent et cueillent des fruits et des plantes.
[cadre]Quand il n'y a plus assez de nourriture, ils partent ailleurs : ils sont [b]nomades[/b]. Ils vivent sous des tentes en peaux, ou à l'entrée des grottes.[/cadre]""",
f"""[titre]Les outils et le feu[/titre]
{tableau(2, ['🪨 des outils en [b]pierre taillée[/b]', 'des bifaces, des pointes de flèche, des grattoirs', '🦴 des outils en os', 'des aiguilles, des harpons', '🔥 le [b]feu[/b]', 'maîtrisé il y a environ 400 000 ans :\nil éclaire, réchauffe, protège des animaux\net sert à cuire'], size=20, lignes=True)}
[cadre]Avec les peaux des animaux, ils fabriquent des vêtements.[/cadre]""",
"""[titre]L'art de la Préhistoire[/titre]
[cadre]• L'[b]art pariétal[/b] : des peintures et des gravures sur les parois des [b]grottes[/b].
• L'[b]art rupestre[/b] : des gravures ou des peintures sur des [b]rochers[/b], en plein air.[/cadre]
On y voit surtout des [b]animaux[/b] : chevaux, bisons, aurochs, mammouths, et parfois des mains.
[cadre=astuce]En France : la grotte [b]Chauvet[/b] (Ardèche), peinte il y a environ 36 000 ans, et la grotte de [b]Lascaux[/b] (Dordogne), peinte il y a environ 18 000 ans.[/cadre]""",
f"""[titre]Au Néolithique : des sédentaires[/titre]
{gros('🌾 🐑 🏠', 50)}
Vers [b]10000 / 9000 av. J.-C.[/b], au Proche-Orient, les humains inventent l'[b]agriculture[/b] : ils sèment des graines (blé, orge) et élèvent des animaux (moutons, chèvres, vaches, porcs).
[cadre]Pour surveiller leurs champs et leurs troupeaux, ils restent au même endroit : ils deviennent [b]sédentaires[/b]. Ils construisent des maisons et des [b]villages[/b].[/cadre]""",
f"""[titre]Les nouveautés du Néolithique[/titre]
{tableau(2, ['🪓 la [b]pierre polie[/b]', 'des haches pour couper les arbres et défricher', '🏺 la [b]poterie[/b]', 'des pots en terre cuite pour garder les récoltes', '🧶 le [b]tissage[/b]', 'des vêtements en laine ou en lin', '⚒️ les premiers [b]métaux[/b]', 'le cuivre, puis le bronze, pour des outils et des bijoux', '🗿 les [b]mégalithes[/b]', 'de grandes pierres dressées : menhirs et dolmens'], size=19, lignes=True)}
[cadre=astuce]À [b]Carnac[/b] (Bretagne), on peut voir des milliers de menhirs alignés.[/cadre]""",
f"""[titre]Ötzi, un homme du Néolithique[/titre]
{gros('🏔️ 🧊', 50)}
En 1991, des randonneurs ont retrouvé dans la glace des Alpes le corps d'un homme mort vers [b]3200 av. J.-C.[/b] : on l'a appelé [b]Ötzi[/b].
[cadre]Il portait des vêtements en cuir et en fourrure, un arc, des flèches et une [b]hache en cuivre[/b]. Grâce à lui, on sait comment vivaient les humains à la fin du Néolithique.[/cadre]""",
f"""[titre]Comparer les deux modes de vie[/titre]
{tableau(3, ['', 'Paléolithique', 'Néolithique', 'la nourriture', 'chasse, pêche, cueillette', 'agriculture et élevage', 'le mode de vie', '[b]nomade[/b]', '[b]sédentaire[/b]', "l'habitat", 'tentes, entrées de grottes', 'maisons, villages', 'les outils', 'pierre taillée, os', 'pierre polie, poterie, premiers métaux'], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• La Préhistoire : des premiers humains (il y a 3 millions d'années) à l'écriture (vers 3000 av. J.-C.).
• Au [b]Paléolithique[/b], les humains sont des chasseurs-cueilleurs [b]nomades[/b]. Ils maîtrisent le feu et peignent les grottes (art pariétal).
• Vers [b]10000 / 9000 av. J.-C.[/b], naissance de l'[b]agriculture[/b] : au [b]Néolithique[/b], les humains deviennent [b]sédentaires[/b].
• [b]3200 av. J.-C.[/b] : Ötzi. [b]Vers 3000 av. J.-C.[/b] : l'écriture apparaît.[/cadre]""",
])

# =====================================================================  HISTOIRE 2a
add('rome_antique', 'Vivre à Rome', 'histoire', [
"""[titre]Rome, une ville de l'Antiquité[/titre]
[periodes marque=2]
[b]Rome[/b] est une ville d'[b]Italie[/b]. Pendant l'Antiquité, elle devient la capitale d'un immense empire.
[cadre]Une [b]légende[/b] raconte que Rome a été fondée en 753 av. J.-C. par [b]Romulus[/b], qui avait été nourri avec son frère Rémus par une louve. C'est un récit inventé : les historiens savent seulement que Rome était d'abord un petit village.[/cadre]""",
"""[titre]L'empire romain à son apogée[/titre]
[carte vue=empire gaule=oui largeur=540]
[cadre]Au [b]IIe siècle[/b], il entoure toute la [b]mer Méditerranée[/b]. La [b]Gaule[/b] en fait partie.[/cadre]""",
f"""[titre]L'empereur Auguste[/titre]
{gros('👑 🏛️', 50)}
Rome est d'abord gouvernée par des rois, puis devient une république. En [b]27 av. J.-C.[/b], [b]Auguste[/b] devient le [b]premier empereur[/b] de Rome. Il règne jusqu'en [b]14 après J.-C.[/b]
[cadre]L'empereur a tous les pouvoirs : il commande l'armée, fait les lois et rend la justice. Il vit dans un [b]palais[/b], sur une colline de Rome.[/cadre]""",
f"""[titre]Se loger à Rome[/titre]
{tableau(2, ['la [b]domus[/b] 🏡', 'la grande maison d\'une famille riche, en ville,\navec une cour et un jardin', 'l\'[b]insula[/b] 🏢', 'un immeuble de plusieurs étages, où vivent\nles familles pauvres, dans de petits logements', 'la [b]villa[/b] 🌿', 'une grande maison à la campagne, entourée de terres cultivées'], size=19, lignes=True)}
[cadre]Rome compte environ [b]1 million[/b] d'habitants : c'est la plus grande ville du monde à cette époque.[/cadre]""",
f"""[titre]Se nourrir[/titre]
{tableau(2, ['les pauvres', 'du pain, de la bouillie de blé, des légumes ;\nils achètent des plats chauds dans la rue', 'les riches', 'de grands repas, les [b]banquets[/b], qu\'ils prennent\nallongés : viandes, poissons, fruits'], size=20, lignes=True)}
[cadre]L'eau arrive en ville par des [b]aqueducs[/b] : de longs canaux, parfois portés par des ponts, qui amènent l'eau des sources jusqu'aux fontaines.[/cadre]""",
f"""[titre]Se déplacer[/titre]
{gros('🛣️ 🐎', 50)}
Les Romains construisent des milliers de kilomètres de [b]voies romaines[/b] : des routes droites et pavées, avec des bornes qui indiquent la distance.
[cadre]On voyage à pied, à cheval ou en char. Les soldats, les marchands et les messagers circulent dans tout l'empire.[/cadre]
[cadre=astuce]« Tous les chemins mènent à Rome » : cette expression vient de là ![/cadre]""",
f"""[titre]Se divertir[/titre]
{tableau(2, ['l\'[b]amphithéâtre[/b]', 'des combats de [b]gladiateurs[/b] (le Colisée de Rome)', 'le [b]cirque[/b]', 'des courses de chars', 'le [b]théâtre[/b]', 'des pièces comiques ou tristes', 'les [b]thermes[/b]', 'des bains publics : on s\'y lave,\non fait du sport, on retrouve ses amis'], size=20, lignes=True)}""",
f"""[titre]Les monuments de la ville[/titre]
{tableau(2, ['le [b]forum[/b]', 'la grande place au centre de la ville : on y fait\ndu commerce, de la politique, on rend la justice', 'le [b]temple[/b]', 'la maison d\'un dieu : Jupiter, Junon, Mars…', 'le [b]palais[/b]', 'la demeure de l\'empereur', 'l\'[b]aqueduc[/b]', 'le canal qui amène l\'eau'], size=19, lignes=True)}""",
f"""[titre]Une société inégale[/titre]
{tableau(2, ['les [b]citoyens[/b]', 'des hommes libres : ils peuvent voter et devenir soldats', 'les [b]femmes[/b]', 'elles ne votent pas ; elles dirigent la maison', 'les [b]étrangers[/b]', 'des hommes libres, mais sans les droits des citoyens', 'les [b]esclaves[/b]', 'ils appartiennent à un maître\net travaillent pour lui, sans être payés'], size=19, lignes=True)}
[cadre]La société romaine est [b]hiérarchisée[/b] : tout le monde n'a pas les mêmes droits.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Au IIe siècle, l'empire romain entoure toute la mer Méditerranée.
• De [b]27 av. J.-C.[/b] à [b]14 apr. J.-C.[/b] : règne d'[b]Auguste[/b], le premier empereur.
• À Rome : la domus des riches, l'insula des pauvres ; le forum, les temples, les thermes, l'amphithéâtre, les aqueducs.
• La société est hiérarchisée : citoyens, femmes, étrangers, esclaves.[/cadre]""",
])

# =====================================================================  HISTOIRE 2b
add('gaule_romaine', 'La Gaule romaine', 'histoire', [
f"""[titre]Les Gaulois[/titre]
{gros('🛖 🐗 🛡️', 50)}
Avant les Romains, la [b]Gaule[/b] (à peu près la France d'aujourd'hui) est habitée par les [b]Gaulois[/b]. Ils forment de nombreux peuples, souvent en guerre entre eux.
[cadre]Ils vivent surtout de l'agriculture et de l'élevage. Ce sont d'habiles artisans : ils travaillent le fer et fabriquent des tonneaux en bois.[/cadre]""",
f"""[titre]Jules César conquiert la Gaule[/titre]
{tableau(2, ['[b]Jules César[/b]', 'un général romain : il attaque la Gaule à partir de 58 av. J.-C.', '[b]Vercingétorix[/b]', 'un chef gaulois : il rassemble les peuples gaulois contre César'], size=20, lignes=True)}
[cadre]En [b]52 av. J.-C.[/b], César fait le [b]siège d'Alésia[/b] : il entoure la ville où Vercingétorix s'est enfermé. Affamés, les Gaulois se rendent. C'est la [b]défaite de Vercingétorix[/b].[/cadre]""",
"""[titre]Où est Alésia ?[/titre]
[carte vue=france alesia=oui largeur=300]
[cadre]Alésia se trouvait en [b]Bourgogne[/b], près du village actuel d'Alise-Sainte-Reine. Après sa défaite, la Gaule fait partie de l'empire romain.[/cadre]""",
f"""[titre]Les Gallo-Romains[/titre]
{gros('🛡️ ➕ 🏛️', 50)}
Pendant plus de 400 ans, les Gaulois vivent dans l'empire romain : on les appelle les [b]Gallo-Romains[/b].
[cadre]Le monde [b]gallo-romain[/b] mélange les deux cultures : les Gaulois gardent certains dieux et certaines habitudes, et adoptent la langue, les lois, les routes et les monuments des Romains.[/cadre]""",
f"""[titre]Ce que les Romains apportent[/titre]
{tableau(2, ['🗣️ le [b]latin[/b]', 'la langue des Romains : le français vient du latin', '🏙️ des [b]villes[/b]', 'construites comme Rome, avec un forum, des thermes, un amphithéâtre', '🛣️ des [b]routes[/b]', 'les voies romaines relient les villes', '🍇 de nouvelles cultures', 'la vigne et l\'olivier se répandent'], size=19, lignes=True)}""",
f"""[titre]La vie à la campagne[/titre]
{gros('🏡 🌾 🐄', 50)}
À la campagne, les riches Gallo-Romains vivent dans des [b]villas[/b] : de grandes exploitations agricoles avec une belle maison, des ateliers et des champs.
[cadre]Des paysans et des esclaves y travaillent. Les archéologues retrouvent aujourd'hui les restes de ces villas, avec leurs mosaïques et leurs bains.[/cadre]""",
f"""[titre]Des traces gallo-romaines en France[/titre]
{tableau(2, ['le [b]pont du Gard[/b]', 'un aqueduc qui amenait l\'eau à Nîmes', 'les [b]arènes de Nîmes[/b]', 'un amphithéâtre', 'la [b]Maison carrée[/b] (Nîmes)', 'un temple', 'le [b]théâtre d\'Orange[/b]', 'un théâtre', '[b]Lyon[/b] (Lugdunum)', 'la capitale des Gaules, avec ses théâtres'], size=19, lignes=True)}
[cadre=astuce]Paris s'appelait [b]Lutèce[/b]. On peut y voir les restes de thermes et d'arènes.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Avant les Romains, la Gaule est habitée par les [b]Gaulois[/b].
• [b]52 av. J.-C.[/b] : siège d'[b]Alésia[/b], défaite de [b]Vercingétorix[/b] face à Jules César.
• La Gaule fait alors partie de l'empire romain : les [b]Gallo-Romains[/b] mélangent cultures gauloise et romaine.
• Des traces : le pont du Gard, les arènes et la Maison carrée de Nîmes, le théâtre d'Orange.[/cadre]""",
])

# =====================================================================  HISTOIRE 3
add('royaume_france', 'La construction du royaume de France', 'histoire', [
"""[titre]Le Moyen Âge[/titre]
[periodes marque=3]
Après Charlemagne, son empire est partagé. Dans la partie ouest naît le [b]royaume de France[/b].
[cadre]Au début, le roi est faible : de grands seigneurs (ducs, comtes) sont plus riches et plus puissants que lui sur leurs terres.[/cadre]""",
f"""[titre]987 : Hugues Capet[/titre]
{gros('👑', 56)}
En [b]987[/b], les grands seigneurs et les évêques [b]élisent Hugues Capet[/b] roi de France.
[cadre]Pour que la couronne reste dans sa famille, Hugues Capet fait sacrer son fils de son vivant. Ses descendants vont régner pendant des siècles : c'est la [b]dynastie[/b] des [b]Capétiens[/b].[/cadre]
[cadre=astuce]Une [b]dynastie[/b], c'est une famille de rois qui se succèdent : le père, puis le fils, puis le petit-fils…[/cadre]""",
"""[titre]Le sacre du roi[/titre]
Le roi est [b]sacré[/b] dans la cathédrale de [b]Reims[/b].
[cadre]Pendant la cérémonie du [b]sacre[/b], l'archevêque verse sur le roi quelques gouttes d'une huile sainte. Puis il lui remet la [b]couronne[/b], le [b]sceptre[/b] et la [b]main de justice[/b].[/cadre]
Le roi devient alors un personnage sacré : on pense qu'il a été [b]choisi par Dieu[/b]. Ses sujets doivent lui obéir.""",
f"""[titre]Domaine royal et royaume[/titre]
{tableau(2, ['le [b]domaine royal[/b]', 'les terres qui appartiennent directement au roi', 'le [b]royaume[/b]', 'toutes les terres dont les seigneurs doivent obéir au roi'], size=21, lignes=True)}
[cadre]Pour être plus puissant, le roi agrandit son domaine : par la [b]guerre[/b], par des [b]mariages[/b], par des [b]héritages[/b] ou en [b]achetant[/b] des terres.[/cadre]""",
"""[titre]Le domaine royal s'agrandit[/titre]
[carte vue=france domaines=987,1223,1483 largeur=230]
[cadre]En bleu : le domaine du roi (carte simplifiée). En 987, il est petit, autour de [b]Paris[/b] et d'[b]Orléans[/b]. En 1483, il couvre presque tout le royaume.[/cadre]""",
f"""[titre]Des rois et des reines[/titre]
{tableau(2, ['[b]Aliénor d\'Aquitaine[/b]', 'riche duchesse, reine de France puis d\'Angleterre :\nses terres passent au roi d\'Angleterre', '[b]Philippe Auguste[/b]', 'roi de 1180 à 1223 : il reprend la Normandie aux Anglais\net gagne la bataille de Bouvines (1214)', '[b]Blanche de Castille[/b]', 'mère de Louis IX : elle gouverne le royaume\nquand son fils est enfant', '[b]Louis IX[/b] (Saint Louis)', 'roi de 1226 à 1270, célèbre pour sa justice'], size=18, lignes=True)}""",
f"""[titre]Comment le roi se fait obéir[/titre]
{tableau(2, ['💰 l\'[b]impôt[/b]', 'les habitants paient de l\'argent au roi', '🪙 la [b]monnaie[/b]', 'la monnaie du roi est utilisée dans tout le royaume', '⚖️ la [b]justice[/b]', 'le roi juge les conflits ;\nses agents rendent la justice en son nom', '⚔️ l\'[b]armée[/b]', 'le roi fait la guerre et soumet les seigneurs révoltés', '🏰 les [b]châteaux[/b]', 'forteresses et remparts protègent le royaume'], size=19, lignes=True)}
[cadre]Peu à peu, la France devient une [b]monarchie[/b] forte : un pays gouverné par un roi.[/cadre]""",
f"""[titre]La guerre de Cent Ans[/titre]
{gros('⚔️ 🏰 🏹', 50)}
Aux [b]XIVe et XVe siècles[/b] (de 1337 à 1453), les rois d'[b]Angleterre[/b] réclament la couronne de France. C'est la [b]guerre de Cent Ans[/b] : elle dure en réalité plus de 100 ans.
[cadre]Depuis 1328, les rois de France sont des [b]Valois[/b], une nouvelle branche de la famille des Capétiens.[/cadre]""",
f"""[titre]Jeanne d'Arc[/titre]
{gros('🛡️ 🏳️', 50)}
[b]Jeanne d'Arc[/b] est une jeune paysanne de Lorraine. En [b]1429[/b], elle délivre la ville d'[b]Orléans[/b], assiégée par les Anglais, puis fait sacrer le roi [b]Charles VII[/b] à Reims.
[cadre]Capturée, elle est brûlée à Rouen en 1431. En 1453, les Anglais sont chassés du royaume : la guerre de Cent Ans est terminée.[/cadre]""",
f"""[titre]Les deux dynasties[/titre]
[frise points=987,1180,1226,1328,1429,1453 debut=Capétiens fin=Valois]
{tableau(2, ['[b]987[/b]', 'Hugues Capet, le premier Capétien', '[b]1180[/b]', 'Philippe Auguste devient roi', '[b]1226[/b]', 'Louis IX devient roi', '[b]1328[/b]', 'le premier roi Valois', '[b]1429[/b]', 'Jeanne d\'Arc délivre Orléans', '[b]1453[/b]', 'fin de la guerre de Cent Ans'], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• [b]987[/b] : élection d'[b]Hugues Capet[/b], début de la dynastie des [b]Capétiens[/b]. Puis viennent les [b]Valois[/b] (1328).
• Le roi est [b]sacré[/b] à Reims : il reçoit la couronne, le sceptre et la main de justice.
• Pour affirmer son autorité : impôts, monnaie, justice, armée, châteaux. Le domaine royal s'agrandit.
• Philippe Auguste, Louis IX, Aliénor d'Aquitaine, Blanche de Castille, Jeanne d'Arc.
• [b]1337-1453[/b] : la guerre de Cent Ans contre les rois d'Angleterre.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 1
add('population_france', 'Où vivent les habitants de la France ?', 'geographie', [
f"""[titre]La population de la France[/titre]
{gros('👨‍👩‍👧 🏙️ 🏡', 46)}
La France compte environ [b]69 millions d'habitants[/b] : c'est sa [b]population[/b].
[cadre]Les habitants ne sont pas répartis de la même façon partout : certains endroits sont très peuplés, d'autres presque vides. On dit que la population est [b]inégalement répartie[/b].[/cadre]""",
f"""[titre]Forte ou faible densité[/titre]
{tableau(2, [emo('🏙️'), emo('🏔️'), 'beaucoup d\'habitants au même endroit', 'peu d\'habitants au même endroit', 'les grandes villes et leurs alentours', 'les montagnes, les campagnes isolées'], entete=['forte densité', 'faible densité'], size=20)}
[cadre=astuce]La [b]densité[/b], c'est le nombre d'habitants qui vivent sur un même espace.[/cadre]""",
"""[titre]En rouge : les espaces de fortes densités[/titre]
[carte vue=france densites=oui villes=oui largeur=420]""",
f"""[titre]Où vit-on le plus ?[/titre]
{tableau(2, ['fortes densités', 'la région de [b]Paris[/b], le [b]Nord[/b], l\'[b]Alsace[/b],\nla vallée du [b]Rhône[/b] autour de Lyon,\nles bords de la [b]Méditerranée[/b], les grandes villes', 'faibles densités', 'les [b]montagnes[/b] (Alpes, Pyrénées, Massif central)\net une grande bande de [b]campagnes[/b]\nqui traverse la France du nord-est au sud-ouest'], size=20, lignes=True)}""",
f"""[titre]Les 5 plus grandes agglomérations[/titre]
{tableau(2, ['1. [b]Paris[/b]', 'plus de 10 millions d\'habitants', '2. [b]Lyon[/b]', 'environ 2 millions', '3. [b]Marseille[/b]', 'environ 2 millions', '4. [b]Lille[/b]', 'environ 1 million', '5. [b]Toulouse[/b]', 'environ 1 million'], size=20, lignes=True)}
[cadre=astuce]Une [b]agglomération[/b], c'est une ville et toutes les communes collées à elle (sa banlieue).[/cadre]""",
"""[titre]Les massifs de montagne[/titre]
[carte vue=france massifs=oui largeur=420]""",
f"""[titre]Les massifs à connaître[/titre]
{tableau(2, ['les [b]Alpes[/b]', 'les plus hautes : le [b]mont Blanc[/b] dépasse 4 800 m', 'les [b]Pyrénées[/b]', 'à la frontière avec l\'Espagne', 'le [b]Massif central[/b]', 'au centre, avec d\'anciens volcans', 'le [b]Jura[/b]', 'à la frontière avec la Suisse', 'les [b]Vosges[/b]', 'dans l\'Est, près de l\'Alsace', 'la [b]Corse[/b]', 'une île très montagneuse'], size=20, lignes=True)}""",
"""[titre]Les grands fleuves[/titre]
[carte vue=france fleuves=oui largeur=420]""",
f"""[titre]Les fleuves à connaître[/titre]
{tableau(2, ['la [b]Loire[/b]', 'le plus long fleuve de France', 'la [b]Seine[/b]', 'elle traverse Paris', 'la [b]Garonne[/b]', 'elle passe à Toulouse et à Bordeaux', 'le [b]Rhône[/b]', 'il passe à Lyon et va jusqu\'à la Méditerranée', 'le [b]Rhin[/b]', 'il sépare la France de l\'Allemagne'], size=20, lignes=True)}""",
f"""[titre]Et en outre-mer ?[/titre]
{tableau(2, ['🌋 le [b]piton des Neiges[/b]', 'le plus haut sommet de l\'île de [b]La Réunion[/b]\n(plus de 3 000 m), dans l\'océan Indien', '🏞️ le [b]Maroni[/b]', 'un grand fleuve de [b]Guyane[/b], en Amérique du Sud :\nil sépare la Guyane du Suriname'], size=20, lignes=True)}
[cadre]La France a aussi des montagnes et des fleuves loin de l'Europe, dans ses territoires d'outre-mer.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• La France compte environ 69 millions d'habitants, inégalement répartis.
• Fortes densités : grandes villes, région parisienne, Nord, vallée du Rhône, Méditerranée. Faibles densités : montagnes et campagnes.
• Les 5 premières agglomérations : [b]Paris, Lyon, Marseille, Lille, Toulouse[/b].
• Les massifs : Alpes, Pyrénées, Massif central, Jura, Vosges, Corse (et le piton des Neiges à La Réunion).
• Les fleuves : Loire, Seine, Garonne, Rhône, Rhin (et le Maroni en Guyane).[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 2
add('se_loger', 'Se loger en France', 'geographie', [
f"""[titre]Où habite-t-on ?[/titre]
{gros('🏢 🏠 🏘️', 50)}
Les habitants vivent dans des [b]logements[/b] : des [b]appartements[/b] dans des immeubles, ou des [b]maisons[/b].
[cadre]Les quartiers où l'on habite s'appellent des [b]espaces résidentiels[/b]. Ils ne se ressemblent pas : leur paysage dépend de l'époque où ils ont été construits et de l'endroit où ils se trouvent.[/cadre]""",
"""[titre]De la ville à la campagne[/titre]
[quartiers]
[cadre]Au cœur de la ville, le quartier le plus ancien ; autour, des quartiers plus récents ; à la périphérie, les maisons ; plus loin, la campagne et ses villages.[/cadre]""",
f"""[titre]Le centre-ville historique[/titre]
{gros('⛪ 🏛️ 🛍️', 50)}
C'est le quartier [b]le plus ancien[/b] de la ville.
[cadre]On y voit des immeubles anciens, des [b]rues étroites[/b], des places, une église ou une cathédrale, la mairie, des monuments et beaucoup de petits commerces.[/cadre]
[cadre=astuce]Souvent, une partie des rues est réservée aux piétons.[/cadre]""",
f"""[titre]Le grand ensemble[/titre]
{gros('🏢 🏢 🏢', 50)}
Un [b]grand ensemble[/b] est un quartier de [b]grands immeubles[/b] : des [b]tours[/b] (très hautes) et des [b]barres[/b] (très longues).
[cadre]Ils ont été construits vite, il y a 50 à 70 ans, à la périphérie des villes, pour loger beaucoup de familles. Entre les immeubles, il y a des parkings, des pelouses et des aires de jeux.[/cadre]""",
f"""[titre]Le lotissement pavillonnaire[/titre]
{gros('🏡 🏡 🏡', 50)}
Un [b]lotissement pavillonnaire[/b] est un ensemble de [b]maisons individuelles[/b] (des pavillons), construites en même temps, qui se ressemblent souvent.
[cadre]Chaque maison a son [b]jardin[/b] et son garage. Ces quartiers sont à la périphérie des villes ou près des villages. Pour aller travailler ou faire les courses, on prend souvent la voiture.[/cadre]""",
f"""[titre]Le quartier récent d'habitation[/titre]
{gros('🏘️ 🌳 🚋', 50)}
Ces quartiers ont été construits [b]ces dernières années[/b].
[cadre]On y trouve des immeubles modernes, moins hauts que les tours, avec des balcons, des espaces verts, des pistes cyclables, parfois le tramway. On essaie de construire des logements qui consomment moins d'énergie.[/cadre]""",
f"""[titre]Le village[/titre]
{gros('⛪ 🏠 🌾', 50)}
Un [b]village[/b] est un petit groupe de maisons, souvent serrées autour de l'[b]église[/b] et de la [b]mairie[/b].
[cadre]Autour, c'est la [b]campagne[/b] : des champs, des prés, des bois et des fermes. Il y a peu de commerces : on va souvent en ville pour faire certains achats.[/cadre]""",
f"""[titre]Comparer[/titre]
{tableau(3, ['', 'on y voit…', 'où ?', 'centre-ville historique', 'vieux immeubles, rues étroites, monuments', 'au centre de la ville', 'grand ensemble', 'tours et barres', 'à la périphérie', 'lotissement pavillonnaire', 'maisons avec jardin', 'à la périphérie, près des villages', 'quartier récent', 'immeubles modernes, espaces verts', 'en ville', 'village', 'maisons autour de l\'église', 'à la campagne'], size=18, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• Les espaces résidentiels sont les lieux où l'on habite.
• Le [b]centre-ville historique[/b] : le quartier le plus ancien.
• Le [b]grand ensemble[/b] : des tours et des barres d'immeubles.
• Le [b]lotissement pavillonnaire[/b] : des maisons individuelles avec jardin.
• Le [b]quartier récent[/b] : des immeubles modernes et des espaces verts.
• Le [b]village[/b] : des maisons autour de l'église, au milieu de la campagne.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 3
add('travailler', 'Travailler en France', 'geographie', [
f"""[titre]Des paysages pour travailler[/titre]
{gros('🚜 🏭 🛒 🏢 🏖️', 46)}
Les gens travaillent dans des lieux très différents. Chaque activité donne au paysage un aspect particulier.
[cadre]On va découvrir 5 paysages : [b]agricole[/b], [b]industriel[/b], [b]commercial[/b], de [b]quartier d'affaires[/b] et de [b]station touristique[/b].[/cadre]""",
f"""[titre]Le paysage agricole[/titre]
{gros('🌾 🚜 🐄', 50)}
On y voit des [b]champs[/b] (blé, maïs, tournesol), des [b]prés[/b] pour les animaux, des vignes, des vergers.
[cadre]Les agriculteurs travaillent dans une [b]exploitation agricole[/b] : une ferme avec ses bâtiments, ses machines (tracteurs, moissonneuses) et ses terres. Ils produisent notre nourriture.[/cadre]""",
f"""[titre]Le paysage industriel[/titre]
{gros('🏭 🚛 ⚙️', 50)}
Dans une [b]usine[/b], des ouvriers et des machines fabriquent des objets : des voitures, des avions, des aliments, des vêtements…
[cadre]Les usines sont souvent regroupées dans des [b]zones industrielles[/b] : de grands bâtiments, des entrepôts, des camions, près des autoroutes, des voies ferrées, des ports ou des fleuves.[/cadre]
[cadre=astuce]À Toulouse, on construit des avions.[/cadre]""",
f"""[titre]Le paysage commercial[/titre]
{gros('🛒 🅿️ 🏬', 50)}
À l'entrée des villes, on trouve des [b]zones commerciales[/b] : des supermarchés, de grands magasins, des restaurants rapides.
[cadre]Elles ont d'immenses [b]parkings[/b] et des ronds-points, car on y vient surtout en voiture. Des vendeurs, des caissiers, des livreurs y travaillent.[/cadre]""",
f"""[titre]Le quartier d'affaires[/titre]
{gros('🏢 💼 🚇', 50)}
Un [b]quartier d'affaires[/b] est un quartier de [b]tours de bureaux[/b] où travaillent des milliers d'employés : dans des banques, des entreprises, des assurances.
[cadre]Il est bien desservi par le métro, le train ou le tramway. Le plus grand de France est [b]La Défense[/b], près de Paris.[/cadre]""",
f"""[titre]La station touristique[/titre]
{tableau(2, [emo('🏖️'), emo('🎿'), 'au bord de la mer', 'à la montagne', 'des plages, des hôtels,\ndes campings, un port de plaisance', 'des pistes de ski,\ndes remontées mécaniques, des chalets'], entete=['station littorale', 'station de montagne'], size=20)}
[cadre]Une [b]station touristique[/b] accueille surtout des vacanciers. Beaucoup de gens y travaillent pour eux : dans les hôtels, les restaurants, les commerces.[/cadre]""",
f"""[titre]Reconnaître un paysage[/titre]
{tableau(2, ['des champs, des prés, des tracteurs', 'agricole', 'des usines, des entrepôts, des camions', 'industriel', 'des magasins et de grands parkings', 'commercial', 'des tours de bureaux', 'quartier d\'affaires', 'des hôtels, des plages ou des pistes de ski', 'station touristique'], entete=['je vois…', 'c\'est un paysage…'], size=19, paires=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• Paysage [b]agricole[/b] : champs, prés, [b]exploitation agricole[/b].
• Paysage [b]industriel[/b] : [b]usines[/b] et entrepôts, près des routes et des ports.
• Paysage [b]commercial[/b] : magasins et parkings à l'entrée des villes.
• [b]Quartier d'affaires[/b] : tours de bureaux (La Défense, près de Paris).
• [b]Station touristique[/b] : au bord de la mer ou à la montagne, pour les vacanciers.[/cadre]""",
])

if __name__ == '__main__':
    OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
    TXT = sys.argv[2] if len(sys.argv) > 2 else None
    toutes = ['-- Toutes les fiches de cours Histoire-Geographie CE2 (2026-11-07), une seule transaction.', 'begin;']
    for cl, code, titre, domaine, pages in FICHES:
        contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
        sql = SQL.replace("'cp'", f"'{cl}'").replace('(CP)', f'({cl.upper()})').format(
            titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu, domaine=domaine, matiere=MATIERE)
        with open(os.path.join(OUT, f'{cl}_hg_{code}.sql'), 'w', encoding='utf-8') as f:
            f.write(sql)
        toutes.append(sql)
        if TXT:
            with open(os.path.join(TXT, f'{code}.txt'), 'w', encoding='utf-8') as f:
                f.write(contenu)
        print(code, titre, len(pages), 'p.')
    toutes += ['commit;', 'select fn_publier();']
    with open(os.path.join(OUT, f'{CL}_histgeo_toutes.sql'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(toutes) + '\n')
    print(len(FICHES), 'fiches')
