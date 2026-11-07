-- Toutes les fiches de cours Histoire-Geographie CE2 (2026-11-07), une seule transaction.
begin;
-- Fiche La Préhistoire : Paléolithique et Néolithique (CE2) - histoire, notion 'prehistoire'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'La Préhistoire : Paléolithique et Néolithique', $fiche$
[titre]La Préhistoire[/titre]
[periodes marque=1]
La Préhistoire est la [b]plus longue période[/b] de l'histoire : elle commence avec les premiers humains, il y a environ [b]3 millions d'années[/b], et se termine vers [b]3000 av. J.-C.[/b], quand l'écriture apparaît.
[cadre]On la coupe en deux grandes parties : le [b]Paléolithique[/b], puis le [b]Néolithique[/b].[/cadre]
[page]
[titre]Paléolithique et Néolithique[/titre]
[frise points=il_y_a_3_millions_d'années,vers_10000_av._J.-C.,3200_av._J.-C.,vers_3000_av._J.-C. debut=Paléolithique fin=Néolithique]
[cadre]• Le [b]Paléolithique[/b] : des premiers humains jusqu'à la naissance de l'agriculture, [b]vers 10000 av. J.-C.[/b]
• Le [b]Néolithique[/b] : de la naissance de l'agriculture jusqu'à l'apparition de l'[b]écriture[/b], [b]vers 3000 av. J.-C.[/b][/cadre]
[cadre=astuce][b]Paléo[/b]lithique = « pierre ancienne ». [b]Néo[/b]lithique = « pierre nouvelle ».[/cadre]
[page]
[titre]Au Paléolithique : des nomades[/titre]
[center][font_size=50]🦣 🏹 🫐[/font_size][/center]
Les humains sont des [b]chasseurs-cueilleurs[/b] : ils chassent (mammouths, rennes, chevaux), pêchent et cueillent des fruits et des plantes.
[cadre]Quand il n'y a plus assez de nourriture, ils partent ailleurs : ils sont [b]nomades[/b]. Ils vivent sous des tentes en peaux, ou à l'entrée des grottes.[/cadre]
[page]
[titre]Les outils et le feu[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🪨 des outils en [b]pierre taillée[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des bifaces, des pointes de flèche, des grattoirs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🦴 des outils en os[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]des aiguilles, des harpons[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🔥 le [b]feu[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]maîtrisé il y a environ 400 000 ans :
il éclaire, réchauffe, protège des animaux
et sert à cuire[/font_size][/center][/cell][/table]
[cadre]Avec les peaux des animaux, ils fabriquent des vêtements.[/cadre]
[page]
[titre]L'art de la Préhistoire[/titre]
[cadre]• L'[b]art pariétal[/b] : des peintures et des gravures sur les parois des [b]grottes[/b].
• L'[b]art rupestre[/b] : des gravures ou des peintures sur des [b]rochers[/b], en plein air.[/cadre]
On y voit surtout des [b]animaux[/b] : chevaux, bisons, aurochs, mammouths, et parfois des mains.
[cadre=astuce]En France : la grotte [b]Chauvet[/b] (Ardèche), peinte il y a environ 36 000 ans, et la grotte de [b]Lascaux[/b] (Dordogne), peinte il y a environ 18 000 ans.[/cadre]
[page]
[titre]Au Néolithique : des sédentaires[/titre]
[center][font_size=50]🌾 🐑 🏠[/font_size][/center]
Vers [b]10000 / 9000 av. J.-C.[/b], au Proche-Orient, les humains inventent l'[b]agriculture[/b] : ils sèment des graines (blé, orge) et élèvent des animaux (moutons, chèvres, vaches, porcs).
[cadre]Pour surveiller leurs champs et leurs troupeaux, ils restent au même endroit : ils deviennent [b]sédentaires[/b]. Ils construisent des maisons et des [b]villages[/b].[/cadre]
[page]
[titre]Les nouveautés du Néolithique[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🪓 la [b]pierre polie[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des haches pour couper les arbres et défricher[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏺 la [b]poterie[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des pots en terre cuite pour garder les récoltes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🧶 le [b]tissage[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des vêtements en laine ou en lin[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]⚒️ les premiers [b]métaux[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le cuivre, puis le bronze, pour des outils et des bijoux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🗿 les [b]mégalithes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]de grandes pierres dressées : menhirs et dolmens[/font_size][/center][/cell][/table]
[cadre=astuce]À [b]Carnac[/b] (Bretagne), on peut voir des milliers de menhirs alignés.[/cadre]
[page]
[titre]Ötzi, un homme du Néolithique[/titre]
[center][font_size=50]🏔️ 🧊[/font_size][/center]
En 1991, des randonneurs ont retrouvé dans la glace des Alpes le corps d'un homme mort vers [b]3200 av. J.-C.[/b] : on l'a appelé [b]Ötzi[/b].
[cadre]Il portait des vêtements en cuir et en fourrure, un arc, des flèches et une [b]hache en cuivre[/b]. Grâce à lui, on sait comment vivaient les humains à la fin du Néolithique.[/cadre]
[page]
[titre]Comparer les deux modes de vie[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Paléolithique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Néolithique[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la nourriture[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]chasse, pêche, cueillette[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]agriculture et élevage[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le mode de vie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]nomade[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]sédentaire[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'habitat[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]tentes, entrées de grottes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]maisons, villages[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les outils[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pierre taillée, os[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pierre polie, poterie, premiers métaux[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• La Préhistoire : des premiers humains (il y a 3 millions d'années) à l'écriture (vers 3000 av. J.-C.).
• Au [b]Paléolithique[/b], les humains sont des chasseurs-cueilleurs [b]nomades[/b]. Ils maîtrisent le feu et peignent les grottes (art pariétal).
• Vers [b]10000 / 9000 av. J.-C.[/b], naissance de l'[b]agriculture[/b] : au [b]Néolithique[/b], les humains deviennent [b]sédentaires[/b].
• [b]3200 av. J.-C.[/b] : Ötzi. [b]Vers 3000 av. J.-C.[/b] : l'écriture apparaît.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'prehistoire'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Vivre à Rome (CE2) - histoire, notion 'rome_antique'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'Vivre à Rome', $fiche$
[titre]Rome, une ville de l'Antiquité[/titre]
[periodes marque=2]
[b]Rome[/b] est une ville d'[b]Italie[/b]. Pendant l'Antiquité, elle devient la capitale d'un immense empire.
[cadre]Une [b]légende[/b] raconte que Rome a été fondée en 753 av. J.-C. par [b]Romulus[/b], qui avait été nourri avec son frère Rémus par une louve. C'est un récit inventé : les historiens savent seulement que Rome était d'abord un petit village.[/cadre]
[page]
[titre]L'empire romain à son apogée[/titre]
[carte vue=empire gaule=oui largeur=540]
[cadre]Au [b]IIe siècle[/b], il entoure toute la [b]mer Méditerranée[/b]. La [b]Gaule[/b] en fait partie.[/cadre]
[page]
[titre]L'empereur Auguste[/titre]
[center][font_size=50]👑 🏛️[/font_size][/center]
Rome est d'abord gouvernée par des rois, puis devient une république. En [b]27 av. J.-C.[/b], [b]Auguste[/b] devient le [b]premier empereur[/b] de Rome. Il règne jusqu'en [b]14 après J.-C.[/b]
[cadre]L'empereur a tous les pouvoirs : il commande l'armée, fait les lois et rend la justice. Il vit dans un [b]palais[/b], sur une colline de Rome.[/cadre]
[page]
[titre]Se loger à Rome[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]domus[/b] 🏡[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la grande maison d'une famille riche, en ville,
avec une cour et un jardin[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'[b]insula[/b] 🏢[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un immeuble de plusieurs étages, où vivent
les familles pauvres, dans de petits logements[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]villa[/b] 🌿[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une grande maison à la campagne, entourée de terres cultivées[/font_size][/center][/cell][/table]
[cadre]Rome compte environ [b]1 million[/b] d'habitants : c'est la plus grande ville du monde à cette époque.[/cadre]
[page]
[titre]Se nourrir[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les pauvres[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]du pain, de la bouillie de blé, des légumes ;
ils achètent des plats chauds dans la rue[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]les riches[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]de grands repas, les [b]banquets[/b], qu'ils prennent
allongés : viandes, poissons, fruits[/font_size][/center][/cell][/table]
[cadre]L'eau arrive en ville par des [b]aqueducs[/b] : de longs canaux, parfois portés par des ponts, qui amènent l'eau des sources jusqu'aux fontaines.[/cadre]
[page]
[titre]Se déplacer[/titre]
[center][font_size=50]🛣️ 🐎[/font_size][/center]
Les Romains construisent des milliers de kilomètres de [b]voies romaines[/b] : des routes droites et pavées, avec des bornes qui indiquent la distance.
[cadre]On voyage à pied, à cheval ou en char. Les soldats, les marchands et les messagers circulent dans tout l'empire.[/cadre]
[cadre=astuce]« Tous les chemins mènent à Rome » : cette expression vient de là ![/cadre]
[page]
[titre]Se divertir[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'[b]amphithéâtre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des combats de [b]gladiateurs[/b] (le Colisée de Rome)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le [b]cirque[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]des courses de chars[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le [b]théâtre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des pièces comiques ou tristes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]les [b]thermes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]des bains publics : on s'y lave,
on fait du sport, on retrouve ses amis[/font_size][/center][/cell][/table]
[page]
[titre]Les monuments de la ville[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]forum[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la grande place au centre de la ville : on y fait
du commerce, de la politique, on rend la justice[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le [b]temple[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la maison d'un dieu : Jupiter, Junon, Mars…[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]palais[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la demeure de l'empereur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'[b]aqueduc[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le canal qui amène l'eau[/font_size][/center][/cell][/table]
[page]
[titre]Une société inégale[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]citoyens[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des hommes libres : ils peuvent voter et devenir soldats[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les [b]femmes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]elles ne votent pas ; elles dirigent la maison[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]étrangers[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des hommes libres, mais sans les droits des citoyens[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les [b]esclaves[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ils appartiennent à un maître
et travaillent pour lui, sans être payés[/font_size][/center][/cell][/table]
[cadre]La société romaine est [b]hiérarchisée[/b] : tout le monde n'a pas les mêmes droits.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Au IIe siècle, l'empire romain entoure toute la mer Méditerranée.
• De [b]27 av. J.-C.[/b] à [b]14 apr. J.-C.[/b] : règne d'[b]Auguste[/b], le premier empereur.
• À Rome : la domus des riches, l'insula des pauvres ; le forum, les temples, les thermes, l'amphithéâtre, les aqueducs.
• La société est hiérarchisée : citoyens, femmes, étrangers, esclaves.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'rome_antique'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La Gaule romaine (CE2) - histoire, notion 'gaule_romaine'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'La Gaule romaine', $fiche$
[titre]Les Gaulois[/titre]
[center][font_size=50]🛖 🐗 🛡️[/font_size][/center]
Avant les Romains, la [b]Gaule[/b] (à peu près la France d'aujourd'hui) est habitée par les [b]Gaulois[/b]. Ils forment de nombreux peuples, souvent en guerre entre eux.
[cadre]Ils vivent surtout de l'agriculture et de l'élevage. Ce sont d'habiles artisans : ils travaillent le fer et fabriquent des tonneaux en bois.[/cadre]
[page]
[titre]Jules César conquiert la Gaule[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]Jules César[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un général romain : il attaque la Gaule à partir de 58 av. J.-C.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]Vercingétorix[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un chef gaulois : il rassemble les peuples gaulois contre César[/font_size][/center][/cell][/table]
[cadre]En [b]52 av. J.-C.[/b], César fait le [b]siège d'Alésia[/b] : il entoure la ville où Vercingétorix s'est enfermé. Affamés, les Gaulois se rendent. C'est la [b]défaite de Vercingétorix[/b].[/cadre]
[page]
[titre]Où est Alésia ?[/titre]
[carte vue=france alesia=oui largeur=300]
[cadre]Alésia se trouvait en [b]Bourgogne[/b], près du village actuel d'Alise-Sainte-Reine. Après sa défaite, la Gaule fait partie de l'empire romain.[/cadre]
[page]
[titre]Les Gallo-Romains[/titre]
[center][font_size=50]🛡️ ➕ 🏛️[/font_size][/center]
Pendant plus de 400 ans, les Gaulois vivent dans l'empire romain : on les appelle les [b]Gallo-Romains[/b].
[cadre]Le monde [b]gallo-romain[/b] mélange les deux cultures : les Gaulois gardent certains dieux et certaines habitudes, et adoptent la langue, les lois, les routes et les monuments des Romains.[/cadre]
[page]
[titre]Ce que les Romains apportent[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🗣️ le [b]latin[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la langue des Romains : le français vient du latin[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏙️ des [b]villes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]construites comme Rome, avec un forum, des thermes, un amphithéâtre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🛣️ des [b]routes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les voies romaines relient les villes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🍇 de nouvelles cultures[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la vigne et l'olivier se répandent[/font_size][/center][/cell][/table]
[page]
[titre]La vie à la campagne[/titre]
[center][font_size=50]🏡 🌾 🐄[/font_size][/center]
À la campagne, les riches Gallo-Romains vivent dans des [b]villas[/b] : de grandes exploitations agricoles avec une belle maison, des ateliers et des champs.
[cadre]Des paysans et des esclaves y travaillent. Les archéologues retrouvent aujourd'hui les restes de ces villas, avec leurs mosaïques et leurs bains.[/cadre]
[page]
[titre]Des traces gallo-romaines en France[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]pont du Gard[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un aqueduc qui amenait l'eau à Nîmes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les [b]arènes de Nîmes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un amphithéâtre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]Maison carrée[/b] (Nîmes)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un temple[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le [b]théâtre d'Orange[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un théâtre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Lyon[/b] (Lugdunum)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la capitale des Gaules, avec ses théâtres[/font_size][/center][/cell][/table]
[cadre=astuce]Paris s'appelait [b]Lutèce[/b]. On peut y voir les restes de thermes et d'arènes.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Avant les Romains, la Gaule est habitée par les [b]Gaulois[/b].
• [b]52 av. J.-C.[/b] : siège d'[b]Alésia[/b], défaite de [b]Vercingétorix[/b] face à Jules César.
• La Gaule fait alors partie de l'empire romain : les [b]Gallo-Romains[/b] mélangent cultures gauloise et romaine.
• Des traces : le pont du Gard, les arènes et la Maison carrée de Nîmes, le théâtre d'Orange.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'gaule_romaine'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La construction du royaume de France (CE2) - histoire, notion 'royaume_france'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'La construction du royaume de France', $fiche$
[titre]Le Moyen Âge[/titre]
[periodes marque=3]
Après Charlemagne, son empire est partagé. Dans la partie ouest naît le [b]royaume de France[/b].
[cadre]Au début, le roi est faible : de grands seigneurs (ducs, comtes) sont plus riches et plus puissants que lui sur leurs terres.[/cadre]
[page]
[titre]987 : Hugues Capet[/titre]
[center][font_size=56]👑[/font_size][/center]
En [b]987[/b], les grands seigneurs et les évêques [b]élisent Hugues Capet[/b] roi de France.
[cadre]Pour que la couronne reste dans sa famille, Hugues Capet fait sacrer son fils de son vivant. Ses descendants vont régner pendant des siècles : c'est la [b]dynastie[/b] des [b]Capétiens[/b].[/cadre]
[cadre=astuce]Une [b]dynastie[/b], c'est une famille de rois qui se succèdent : le père, puis le fils, puis le petit-fils…[/cadre]
[page]
[titre]Le sacre du roi[/titre]
Le roi est [b]sacré[/b] dans la cathédrale de [b]Reims[/b].
[cadre]Pendant la cérémonie du [b]sacre[/b], l'archevêque verse sur le roi quelques gouttes d'une huile sainte. Puis il lui remet la [b]couronne[/b], le [b]sceptre[/b] et la [b]main de justice[/b].[/cadre]
Le roi devient alors un personnage sacré : on pense qu'il a été [b]choisi par Dieu[/b]. Ses sujets doivent lui obéir.
[page]
[titre]Domaine royal et royaume[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]le [b]domaine royal[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]les terres qui appartiennent directement au roi[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]le [b]royaume[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]toutes les terres dont les seigneurs doivent obéir au roi[/font_size][/center][/cell][/table]
[cadre]Pour être plus puissant, le roi agrandit son domaine : par la [b]guerre[/b], par des [b]mariages[/b], par des [b]héritages[/b] ou en [b]achetant[/b] des terres.[/cadre]
[page]
[titre]Le domaine royal s'agrandit[/titre]
[carte vue=france domaines=987,1223,1483 largeur=230]
[cadre]En bleu : le domaine du roi (carte simplifiée). En 987, il est petit, autour de [b]Paris[/b] et d'[b]Orléans[/b]. En 1483, il couvre presque tout le royaume.[/cadre]
[page]
[titre]Des rois et des reines[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Aliénor d'Aquitaine[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]riche duchesse, reine de France puis d'Angleterre :
ses terres passent au roi d'Angleterre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]Philippe Auguste[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]roi de 1180 à 1223 : il reprend la Normandie aux Anglais
et gagne la bataille de Bouvines (1214)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Blanche de Castille[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]mère de Louis IX : elle gouverne le royaume
quand son fils est enfant[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18][b]Louis IX[/b] (Saint Louis)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]roi de 1226 à 1270, célèbre pour sa justice[/font_size][/center][/cell][/table]
[page]
[titre]Comment le roi se fait obéir[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]💰 l'[b]impôt[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les habitants paient de l'argent au roi[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🪙 la [b]monnaie[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la monnaie du roi est utilisée dans tout le royaume[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]⚖️ la [b]justice[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le roi juge les conflits ;
ses agents rendent la justice en son nom[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]⚔️ l'[b]armée[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le roi fait la guerre et soumet les seigneurs révoltés[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🏰 les [b]châteaux[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]forteresses et remparts protègent le royaume[/font_size][/center][/cell][/table]
[cadre]Peu à peu, la France devient une [b]monarchie[/b] forte : un pays gouverné par un roi.[/cadre]
[page]
[titre]La guerre de Cent Ans[/titre]
[center][font_size=50]⚔️ 🏰 🏹[/font_size][/center]
Aux [b]XIVe et XVe siècles[/b] (de 1337 à 1453), les rois d'[b]Angleterre[/b] réclament la couronne de France. C'est la [b]guerre de Cent Ans[/b] : elle dure en réalité plus de 100 ans.
[cadre]Depuis 1328, les rois de France sont des [b]Valois[/b], une nouvelle branche de la famille des Capétiens.[/cadre]
[page]
[titre]Jeanne d'Arc[/titre]
[center][font_size=50]🛡️ 🏳️[/font_size][/center]
[b]Jeanne d'Arc[/b] est une jeune paysanne de Lorraine. En [b]1429[/b], elle délivre la ville d'[b]Orléans[/b], assiégée par les Anglais, puis fait sacrer le roi [b]Charles VII[/b] à Reims.
[cadre]Capturée, elle est brûlée à Rouen en 1431. En 1453, les Anglais sont chassés du royaume : la guerre de Cent Ans est terminée.[/cadre]
[page]
[titre]Les deux dynasties[/titre]
[frise points=987,1180,1226,1328,1429,1453 debut=Capétiens fin=Valois]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]987[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Hugues Capet, le premier Capétien[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]1180[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Philippe Auguste devient roi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]1226[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Louis IX devient roi[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]1328[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le premier roi Valois[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]1429[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Jeanne d'Arc délivre Orléans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]1453[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]fin de la guerre de Cent Ans[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]987[/b] : élection d'[b]Hugues Capet[/b], début de la dynastie des [b]Capétiens[/b]. Puis viennent les [b]Valois[/b] (1328).
• Le roi est [b]sacré[/b] à Reims : il reçoit la couronne, le sceptre et la main de justice.
• Pour affirmer son autorité : impôts, monnaie, justice, armée, châteaux. Le domaine royal s'agrandit.
• Philippe Auguste, Louis IX, Aliénor d'Aquitaine, Blanche de Castille, Jeanne d'Arc.
• [b]1337-1453[/b] : la guerre de Cent Ans contre les rois d'Angleterre.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'royaume_france'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Où vivent les habitants de la France ? (CE2) - geographie, notion 'population_france'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'Où vivent les habitants de la France ?', $fiche$
[titre]La population de la France[/titre]
[center][font_size=46]👨‍👩‍👧 🏙️ 🏡[/font_size][/center]
La France compte environ [b]69 millions d'habitants[/b] : c'est sa [b]population[/b].
[cadre]Les habitants ne sont pas répartis de la même façon partout : certains endroits sont très peuplés, d'autres presque vides. On dit que la population est [b]inégalement répartie[/b].[/cadre]
[page]
[titre]Forte ou faible densité[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]forte densité[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]faible densité[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🏙️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🏔️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup d'habitants au même endroit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]peu d'habitants au même endroit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les grandes villes et leurs alentours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les montagnes, les campagnes isolées[/font_size][/center][/cell][/table]
[cadre=astuce]La [b]densité[/b], c'est le nombre d'habitants qui vivent sur un même espace.[/cadre]
[page]
[titre]En rouge : les espaces de fortes densités[/titre]
[carte vue=france densites=oui villes=oui largeur=420]
[page]
[titre]Où vit-on le plus ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]fortes densités[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la région de [b]Paris[/b], le [b]Nord[/b], l'[b]Alsace[/b],
la vallée du [b]Rhône[/b] autour de Lyon,
les bords de la [b]Méditerranée[/b], les grandes villes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]faibles densités[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]les [b]montagnes[/b] (Alpes, Pyrénées, Massif central)
et une grande bande de [b]campagnes[/b]
qui traverse la France du nord-est au sud-ouest[/font_size][/center][/cell][/table]
[page]
[titre]Les 5 plus grandes agglomérations[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1. [b]Paris[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]plus de 10 millions d'habitants[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]2. [b]Lyon[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]environ 2 millions[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]3. [b]Marseille[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]environ 2 millions[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]4. [b]Lille[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]environ 1 million[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]5. [b]Toulouse[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]environ 1 million[/font_size][/center][/cell][/table]
[cadre=astuce]Une [b]agglomération[/b], c'est une ville et toutes les communes collées à elle (sa banlieue).[/cadre]
[page]
[titre]Les massifs de montagne[/titre]
[carte vue=france massifs=oui largeur=420]
[page]
[titre]Les massifs à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les [b]Alpes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les plus hautes : le [b]mont Blanc[/b] dépasse 4 800 m[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]les [b]Pyrénées[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]à la frontière avec l'Espagne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le [b]Massif central[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]au centre, avec d'anciens volcans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le [b]Jura[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]à la frontière avec la Suisse[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les [b]Vosges[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dans l'Est, près de l'Alsace[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la [b]Corse[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]une île très montagneuse[/font_size][/center][/cell][/table]
[page]
[titre]Les grands fleuves[/titre]
[carte vue=france fleuves=oui largeur=420]
[page]
[titre]Les fleuves à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Loire[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le plus long fleuve de France[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la [b]Seine[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]elle traverse Paris[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Garonne[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]elle passe à Toulouse et à Bordeaux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le [b]Rhône[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]il passe à Lyon et va jusqu'à la Méditerranée[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le [b]Rhin[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]il sépare la France de l'Allemagne[/font_size][/center][/cell][/table]
[page]
[titre]Et en outre-mer ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌋 le [b]piton des Neiges[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le plus haut sommet de l'île de [b]La Réunion[/b]
(plus de 3 000 m), dans l'océan Indien[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🏞️ le [b]Maroni[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un grand fleuve de [b]Guyane[/b], en Amérique du Sud :
il sépare la Guyane du Suriname[/font_size][/center][/cell][/table]
[cadre]La France a aussi des montagnes et des fleuves loin de l'Europe, dans ses territoires d'outre-mer.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• La France compte environ 69 millions d'habitants, inégalement répartis.
• Fortes densités : grandes villes, région parisienne, Nord, vallée du Rhône, Méditerranée. Faibles densités : montagnes et campagnes.
• Les 5 premières agglomérations : [b]Paris, Lyon, Marseille, Lille, Toulouse[/b].
• Les massifs : Alpes, Pyrénées, Massif central, Jura, Vosges, Corse (et le piton des Neiges à La Réunion).
• Les fleuves : Loire, Seine, Garonne, Rhône, Rhin (et le Maroni en Guyane).[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'population_france'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Se loger en France (CE2) - geographie, notion 'se_loger'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'Se loger en France', $fiche$
[titre]Où habite-t-on ?[/titre]
[center][font_size=50]🏢 🏠 🏘️[/font_size][/center]
Les habitants vivent dans des [b]logements[/b] : des [b]appartements[/b] dans des immeubles, ou des [b]maisons[/b].
[cadre]Les quartiers où l'on habite s'appellent des [b]espaces résidentiels[/b]. Ils ne se ressemblent pas : leur paysage dépend de l'époque où ils ont été construits et de l'endroit où ils se trouvent.[/cadre]
[page]
[titre]De la ville à la campagne[/titre]
[quartiers]
[cadre]Au cœur de la ville, le quartier le plus ancien ; autour, des quartiers plus récents ; à la périphérie, les maisons ; plus loin, la campagne et ses villages.[/cadre]
[page]
[titre]Le centre-ville historique[/titre]
[center][font_size=50]⛪ 🏛️ 🛍️[/font_size][/center]
C'est le quartier [b]le plus ancien[/b] de la ville.
[cadre]On y voit des immeubles anciens, des [b]rues étroites[/b], des places, une église ou une cathédrale, la mairie, des monuments et beaucoup de petits commerces.[/cadre]
[cadre=astuce]Souvent, une partie des rues est réservée aux piétons.[/cadre]
[page]
[titre]Le grand ensemble[/titre]
[center][font_size=50]🏢 🏢 🏢[/font_size][/center]
Un [b]grand ensemble[/b] est un quartier de [b]grands immeubles[/b] : des [b]tours[/b] (très hautes) et des [b]barres[/b] (très longues).
[cadre]Ils ont été construits vite, il y a 50 à 70 ans, à la périphérie des villes, pour loger beaucoup de familles. Entre les immeubles, il y a des parkings, des pelouses et des aires de jeux.[/cadre]
[page]
[titre]Le lotissement pavillonnaire[/titre]
[center][font_size=50]🏡 🏡 🏡[/font_size][/center]
Un [b]lotissement pavillonnaire[/b] est un ensemble de [b]maisons individuelles[/b] (des pavillons), construites en même temps, qui se ressemblent souvent.
[cadre]Chaque maison a son [b]jardin[/b] et son garage. Ces quartiers sont à la périphérie des villes ou près des villages. Pour aller travailler ou faire les courses, on prend souvent la voiture.[/cadre]
[page]
[titre]Le quartier récent d'habitation[/titre]
[center][font_size=50]🏘️ 🌳 🚋[/font_size][/center]
Ces quartiers ont été construits [b]ces dernières années[/b].
[cadre]On y trouve des immeubles modernes, moins hauts que les tours, avec des balcons, des espaces verts, des pistes cyclables, parfois le tramway. On essaie de construire des logements qui consomment moins d'énergie.[/cadre]
[page]
[titre]Le village[/titre]
[center][font_size=50]⛪ 🏠 🌾[/font_size][/center]
Un [b]village[/b] est un petit groupe de maisons, souvent serrées autour de l'[b]église[/b] et de la [b]mairie[/b].
[cadre]Autour, c'est la [b]campagne[/b] : des champs, des prés, des bois et des fermes. Il y a peu de commerces : on va souvent en ville pour faire certains achats.[/cadre]
[page]
[titre]Comparer[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on y voit…[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]où ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]centre-ville historique[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]vieux immeubles, rues étroites, monuments[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]au centre de la ville[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]grand ensemble[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]tours et barres[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]à la périphérie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]lotissement pavillonnaire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]maisons avec jardin[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]à la périphérie, près des villages[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]quartier récent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]immeubles modernes, espaces verts[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]en ville[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]village[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]maisons autour de l'église[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]à la campagne[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Les espaces résidentiels sont les lieux où l'on habite.
• Le [b]centre-ville historique[/b] : le quartier le plus ancien.
• Le [b]grand ensemble[/b] : des tours et des barres d'immeubles.
• Le [b]lotissement pavillonnaire[/b] : des maisons individuelles avec jardin.
• Le [b]quartier récent[/b] : des immeubles modernes et des espaces verts.
• Le [b]village[/b] : des maisons autour de l'église, au milieu de la campagne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'se_loger'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Travailler en France (CE2) - geographie, notion 'travailler'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'histoire_geo', 'Travailler en France', $fiche$
[titre]Des paysages pour travailler[/titre]
[center][font_size=46]🚜 🏭 🛒 🏢 🏖️[/font_size][/center]
Les gens travaillent dans des lieux très différents. Chaque activité donne au paysage un aspect particulier.
[cadre]On va découvrir 5 paysages : [b]agricole[/b], [b]industriel[/b], [b]commercial[/b], de [b]quartier d'affaires[/b] et de [b]station touristique[/b].[/cadre]
[page]
[titre]Le paysage agricole[/titre]
[center][font_size=50]🌾 🚜 🐄[/font_size][/center]
On y voit des [b]champs[/b] (blé, maïs, tournesol), des [b]prés[/b] pour les animaux, des vignes, des vergers.
[cadre]Les agriculteurs travaillent dans une [b]exploitation agricole[/b] : une ferme avec ses bâtiments, ses machines (tracteurs, moissonneuses) et ses terres. Ils produisent notre nourriture.[/cadre]
[page]
[titre]Le paysage industriel[/titre]
[center][font_size=50]🏭 🚛 ⚙️[/font_size][/center]
Dans une [b]usine[/b], des ouvriers et des machines fabriquent des objets : des voitures, des avions, des aliments, des vêtements…
[cadre]Les usines sont souvent regroupées dans des [b]zones industrielles[/b] : de grands bâtiments, des entrepôts, des camions, près des autoroutes, des voies ferrées, des ports ou des fleuves.[/cadre]
[cadre=astuce]À Toulouse, on construit des avions.[/cadre]
[page]
[titre]Le paysage commercial[/titre]
[center][font_size=50]🛒 🅿️ 🏬[/font_size][/center]
À l'entrée des villes, on trouve des [b]zones commerciales[/b] : des supermarchés, de grands magasins, des restaurants rapides.
[cadre]Elles ont d'immenses [b]parkings[/b] et des ronds-points, car on y vient surtout en voiture. Des vendeurs, des caissiers, des livreurs y travaillent.[/cadre]
[page]
[titre]Le quartier d'affaires[/titre]
[center][font_size=50]🏢 💼 🚇[/font_size][/center]
Un [b]quartier d'affaires[/b] est un quartier de [b]tours de bureaux[/b] où travaillent des milliers d'employés : dans des banques, des entreprises, des assurances.
[cadre]Il est bien desservi par le métro, le train ou le tramway. Le plus grand de France est [b]La Défense[/b], près de Paris.[/cadre]
[page]
[titre]La station touristique[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]station littorale[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]station de montagne[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🏖️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🎿[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]au bord de la mer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]à la montagne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des plages, des hôtels,
des campings, un port de plaisance[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des pistes de ski,
des remontées mécaniques, des chalets[/font_size][/center][/cell][/table]
[cadre]Une [b]station touristique[/b] accueille surtout des vacanciers. Beaucoup de gens y travaillent pour eux : dans les hôtels, les restaurants, les commerces.[/cadre]
[page]
[titre]Reconnaître un paysage[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]je vois…[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]c'est un paysage…[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des champs, des prés, des tracteurs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]agricole[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des usines, des entrepôts, des camions[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]industriel[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des magasins et de grands parkings[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]commercial[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des tours de bureaux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]quartier d'affaires[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des hôtels, des plages ou des pistes de ski[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]station touristique[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Paysage [b]agricole[/b] : champs, prés, [b]exploitation agricole[/b].
• Paysage [b]industriel[/b] : [b]usines[/b] et entrepôts, près des routes et des ports.
• Paysage [b]commercial[/b] : magasins et parkings à l'entrée des villes.
• [b]Quartier d'affaires[/b] : tours de bureaux (La Défense, près de Paris).
• [b]Station touristique[/b] : au bord de la mer ou à la montagne, pour les vacanciers.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'travailler'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
