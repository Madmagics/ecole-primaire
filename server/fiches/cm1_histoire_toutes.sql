-- Toutes les fiches de cours Histoire et Geographie CM1 (2026-11-07) : histoire seulement, une seule transaction.
begin;
-- Fiche La vie quotidienne au Moyen Âge (CM1) - histoire, notion 'vie_moyen_age'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'histoire', 'La vie quotidienne au Moyen Âge', $fiche$
[titre]Le Moyen Âge[/titre]
[periodes marque=3]
Le Moyen Âge dure environ 1 000 ans, de [b]476[/b] à [b]1492[/b]. On étudie ici les [b]XIe, XIIe et XIIIe siècles[/b] (de l'an 1001 à l'an 1300).
[cadre]À cette époque, presque tout le monde vit à la campagne. La vie est organisée par deux cadres : la [b]seigneurie[/b] et la [b]paroisse[/b].[/cadre]
[page]
[titre]La seigneurie[/titre]
[center][font_size=50]🏰 🌾 🏘️[/font_size][/center]
Une [b]seigneurie[/b], c'est un territoire dominé par un [b]seigneur[/b] : ses terres et les gens qui y vivent.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]château[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]où vit le seigneur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la [b]réserve[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les terres que le seigneur garde pour lui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]tenures[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les terres que le seigneur prête aux paysans[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le moulin, le four[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]appartiennent au seigneur[/font_size][/center][/cell][/table]
[page]
[titre]Le château fort[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🛡️ un [b]lieu de protection[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]remparts, tours, fossés, pont-levis :
les habitants s'y réfugient en cas d'attaque[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍖 un [b]lieu de vie[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le seigneur y vit avec sa famille,
ses chevaliers et ses serviteurs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]👑 un [b]symbole de puissance[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]visible de loin, il montre la force
du seigneur[/font_size][/center][/cell][/table]
[cadre=astuce]Le [b]donjon[/b] est la plus haute tour du château, la plus solide.[/cadre]
[page]
[titre]La vie du seigneur[/titre]
[center][font_size=50]⚔️ 🐎 🦌[/font_size][/center]
Le seigneur est un [b]chevalier[/b] : il s'entraîne au combat, fait la guerre, participe à des tournois et chasse dans ses forêts.
[cadre]Il protège les habitants de sa seigneurie, mais il les commande aussi : il rend la [b]justice[/b] et leur fait payer des taxes.[/cadre]
[page]
[titre]Les obligations des paysans[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]corvée[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]travailler gratuitement quelques jours
sur les terres du seigneur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les [b]taxes[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]donner au seigneur une partie des récoltes
ou de l'argent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]banalités[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]payer pour utiliser le moulin, le four
ou le pressoir du seigneur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la [b]dîme[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]donner à l'Église environ 1/10
de ses récoltes[/font_size][/center][/cell][/table]
[cadre]Certains paysans, les [b]serfs[/b], ne sont pas libres : ils ne peuvent pas quitter la seigneurie.[/cadre]
[page]
[titre]L'année des paysans[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]❄️ hiver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]réparer les outils, couper le bois, tuer le cochon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🌱 printemps[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]labourer et semer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]☀️ été[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]faucher le foin, puis la [b]moisson[/b] (couper les blés)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍂 automne[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les [b]vendanges[/b], semer le blé d'hiver,
mener les cochons manger les glands en forêt[/font_size][/center][/cell][/table]
[cadre]Les paysannes et les paysans travaillent dur du lever au coucher du soleil. Ils vivent dans des maisons simples en bois et en torchis.[/cadre]
[page]
[titre]La paroisse[/titre]
[center][font_size=50]⛪ 🔔[/font_size][/center]
La [b]paroisse[/b] est le territoire qui dépend d'une même église, avec son [b]curé[/b].
[cadre]L'Église accompagne la vie de chacun, de la naissance à la mort : le [b]baptême[/b], le [b]mariage[/b], l'enterrement au cimetière. Les cloches rythment la journée ; le dimanche et les jours de fête, on ne travaille pas.[/cadre]
[page]
[titre]Le clergé et les abbayes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]clergé[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les hommes et les femmes au service de Dieu :
prêtres, évêques, moines, religieuses[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]une [b]abbaye[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un monastère où vivent des moines
ou des religieuses : ils prient et travaillent[/font_size][/center][/cell][/table]
[cadre=astuce]L'abbaye de [b]Cluny[/b], en Bourgogne, fondée en 910, est l'une des plus puissantes d'Europe.[/cadre]
[page]
[titre]Le rôle de l'Église[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🙏 prier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les messes, les fêtes religieuses, les pèlerinages[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🛏️ soigner[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les malades sont accueillis à l'[b]Hôtel-Dieu[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🍞 aider[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on donne à manger aux pauvres[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]📖 enseigner[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les moines apprennent à lire et à écrire ;
ils recopient les livres à la main[/font_size][/center][/cell][/table]
[page]
[titre]Art roman et art gothique[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]l'art roman[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]l'art gothique[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]XIe - XIIe siècles[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]à partir du XIIe siècle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]murs épais, petites fenêtres[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]murs plus fins, grandes fenêtres
avec des [b]vitraux[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]arcs arrondis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]arcs brisés (pointus)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]église plutôt sombre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]église haute et lumineuse,
tenue par des arcs-boutants[/font_size][/center][/cell][/table]
[cadre=astuce][b]Notre-Dame de Paris[/b] est une cathédrale gothique. Une [b]cathédrale[/b] est l'église d'un évêque.[/cadre]
[page]
[titre]La vie en ville[/titre]
[center][font_size=50]🧱 🛒 🔨[/font_size][/center]
Aux XIIe et XIIIe siècles, les villes grandissent. Elles sont entourées de [b]remparts[/b], avec des rues étroites.
[cadre]Les [b]artisans[/b] (boulangers, forgerons, tisserands…) travaillent dans leur atelier, regroupés par métier. Les [b]marchands[/b] vendent au [b]marché[/b] chaque semaine, et aux grandes [b]foires[/b], comme celles de Champagne, où viennent des marchands de toute l'Europe.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Du XIe au XIIIe siècle, la vie est organisée par la [b]seigneurie[/b] et la [b]paroisse[/b].
• Le château protège, sert de logement et montre la puissance du seigneur.
• Les paysans doivent la [b]corvée[/b], des taxes, les banalités et la [b]dîme[/b].
• L'Église prie, soigne, aide les pauvres et enseigne. Cluny, Notre-Dame de Paris.
• Art [b]roman[/b] : épais et sombre. Art [b]gothique[/b] : haut et lumineux.
• En ville : artisans, marchés et foires.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'vie_moyen_age'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La monarchie en France (XVIe-XVIIe siècles) (CM1) - histoire, notion 'monarchie_absolue'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'histoire', 'La monarchie en France (XVIe-XVIIe siècles)', $fiche$
[titre]Trois rois à connaître[/titre]
[frise points=1515,1547,1589,1610,1643,1715 debut=XVIe_siècle fin=XVIIe_siècle]
[cadre]• [b]François Ier[/b] : roi de 1515 à 1547.
• [b]Henri IV[/b] : roi de 1589 à 1610.
• [b]Louis XIV[/b] : roi de 1643 à 1715.[/cadre]
[page]
[titre]La Renaissance[/titre]
[center][font_size=50]🎨 📚 🏛️[/font_size][/center]
Au XVIe siècle, des artistes et des savants redécouvrent les œuvres de l'Antiquité. C'est la [b]Renaissance[/b] : elle commence en Italie.
[cadre]Grâce à l'[b]imprimerie[/b], inventée vers 1450 par Gutenberg, les livres et les idées circulent beaucoup plus vite.[/cadre]
[page]
[titre]François Ier, roi mécène[/titre]
[center][font_size=50]👑 🎨[/font_size][/center]
[b]François Ier[/b] est un [b]mécène[/b] : il protège et paie des artistes.
[cadre]Il invite en France le grand artiste italien [b]Léonard de Vinci[/b], qui s'installe près d'Amboise, au Clos Lucé, et y meurt en [b]1519[/b]. Léonard apporte avec lui la [b]Joconde[/b], aujourd'hui au musée du Louvre.[/cadre]
[cadre=astuce]François Ier fait construire le château de [b]Chambord[/b], et impose le français dans les actes officiels (1539).[/cadre]
[page]
[titre]Les guerres de religion[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les [b]catholiques[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ils obéissent au pape[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]les [b]protestants[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]des chrétiens qui ont quitté l'Église catholique
au XVIe siècle[/font_size][/center][/cell][/table]
[cadre]De 1562 à 1598, catholiques et protestants s'affrontent en France : ce sont les [b]guerres de religion[/b]. En 1572, des milliers de protestants sont tués lors du massacre de la Saint-Barthélemy.[/cadre]
[page]
[titre]Henri IV, roi pacificateur[/titre]
[center][font_size=50]🕊️ 📜[/font_size][/center]
[b]Henri IV[/b] est protestant. Pour être accepté comme roi par tous, il devient catholique en 1593.
[cadre]En [b]1598[/b], il signe l'[b]édit de Nantes[/b] : les protestants peuvent pratiquer leur religion dans certains lieux et ont les mêmes droits que les catholiques. La paix revient. Henri IV est assassiné en 1610.[/cadre]
[page]
[titre]Louis XIV, le Roi-Soleil[/titre]
[center][font_size=50]☀️ 👑[/font_size][/center]
[b]Louis XIV[/b] devient roi à 4 ans et règne [b]72 ans[/b], de [b]1643 à 1715[/b]. Il a choisi le Soleil comme emblème.
[cadre]Il gouverne seul et a tous les pouvoirs : il fait les lois, rend la justice, commande l'armée, décide des impôts. C'est la [b]monarchie absolue[/b]. Il pense tenir son pouvoir de Dieu.[/cadre]
[page]
[titre]Le château de Versailles[/titre]
[center][font_size=50]🏰 ⛲ 🌳[/font_size][/center]
Louis XIV fait de [b]Versailles[/b] un immense château, avec la galerie des Glaces et des jardins magnifiques. Il s'y installe avec la [b]Cour[/b] en 1682.
[cadre]Versailles montre la puissance du roi. Les nobles vivent près de lui et le servent à chaque moment de la journée, de son lever à son coucher : ainsi, il les surveille.[/cadre]
[page]
[titre]Les femmes à la Cour[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la [b]reine[/b] et les princesses[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]elles participent aux fêtes
et aux cérémonies de la Cour[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]les [b]dames d'honneur[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]elles servent la reine et organisent la vie
de la Cour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Madame de Maintenon[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]épouse du roi en secret, elle fonde à Saint-Cyr
une école pour les jeunes filles nobles[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]Madame de Sévigné[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]elle raconte la vie de la Cour
dans ses lettres[/font_size][/center][/cell][/table]
[page]
[titre]La société d'ordres[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]⛪ le [b]clergé[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ceux qui prient[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]⚔️ la [b]noblesse[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]ceux qui combattent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌾 le [b]tiers état[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ceux qui travaillent : paysans, artisans,
marchands, bourgeois[/font_size][/center][/cell][/table]
[cadre]Le clergé et la noblesse ont des [b]privilèges[/b] : ils ne paient pas certains impôts. Le tiers état, c'est presque toute la population ; la plupart sont des [b]paysans[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]François Ier[/b] (1515-1547) : roi mécène de la Renaissance, il accueille Léonard de Vinci (mort en France en 1519).
• [b]Henri IV[/b] (1589-1610) ramène la paix : [b]1598, édit de Nantes[/b].
• [b]Louis XIV[/b] (1643-1715) : la monarchie absolue, Versailles.
• La société est divisée en 3 ordres : clergé, noblesse, tiers état.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'monarchie_absolue'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Explorations et conquêtes (XVe-XVIIe siècles) (CM1) - histoire, notion 'explorations'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'histoire', 'Explorations et conquêtes (XVe-XVIIe siècles)', $fiche$
[titre]Pourquoi partir ?[/titre]
[center][font_size=50]🧭 ⛵ 🌶️[/font_size][/center]
Au XVe siècle, les Européens veulent atteindre l'[b]Asie[/b] par la mer pour rapporter des [b]épices[/b] (poivre, cannelle), de la soie et de l'or.
[cadre]Ils sont aussi poussés par la curiosité, le désir de devenir riches et puissants, et la volonté de répandre la religion chrétienne.[/cadre]
[page]
[titre]Les inventions pour naviguer[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]⛵ la [b]caravelle[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un navire léger et rapide,
qui avance même contre le vent[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🧭 la [b]boussole[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]son aiguille montre toujours le nord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]✨ l'[b]astrolabe[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]il mesure la hauteur des étoiles
pour savoir où l'on est[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🗺️ les [b]cartes[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]de plus en plus précises[/font_size][/center][/cell][/table]
[page]
[titre]Christophe Colomb[/titre]
[center][font_size=50]⛵ 🏝️[/font_size][/center]
En [b]1492[/b], [b]Christophe Colomb[/b], payé par les rois d'Espagne, traverse l'océan Atlantique vers l'ouest pour rejoindre l'Asie. Il débarque sur une île des Bahamas : il vient d'arriver en [b]Amérique[/b] sans le savoir.
[cadre]Il croit être aux Indes : c'est pour cela qu'on a appelé « Indiens » les habitants de l'Amérique. On dit aujourd'hui les [b]Amérindiens[/b].[/cadre]
[page]
[titre]Le premier tour du monde[/titre]
[planisphere pale=oui voyages=oui largeur=700]
[cadre]De [b]1519 à 1522[/b], l'expédition de [b]Magellan[/b] fait le premier tour du monde. Magellan meurt en route ; un seul des 5 navires revient.[/cadre]
[page]
[titre]La conquête de l'Amérique[/titre]
[center][font_size=50]⚔️ 🐎[/font_size][/center]
Les [b]conquistadors[/b] espagnols, avec des chevaux et des armes à feu, conquièrent les grands empires amérindiens : les [b]Aztèques[/b] au Mexique, les [b]Incas[/b] au Pérou.
[cadre]Les Amérindiens sont massacrés, forcés de travailler, et surtout tués par des maladies venues d'Europe, comme la variole. La plus grande partie d'entre eux meurt.[/cadre]
[page]
[titre]Les premiers empires coloniaux[/titre]
[planisphere pale=oui empires=oui cadre=-125,-58,-25,62 largeur=400]
[page]
[titre]Des empires en Amérique[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Espagne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Amérique centrale, une grande partie
de l'Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le Portugal[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le Brésil[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la Nouvelle-France (Canada) et des îles
des Antilles[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Angleterre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la côte est de l'Amérique du Nord[/font_size][/center][/cell][/table]
[cadre=astuce]Un [b]empire colonial[/b] : des territoires lointains, les [b]colonies[/b], conquis et dirigés par un pays d'Europe.[/cadre]
[page]
[titre]La traite des esclaves[/titre]
[planisphere pale=oui triangulaire=oui cadre=-100,-12,25,58 largeur=600]
[cadre]C'est le [b]commerce triangulaire[/b]. Des millions d'Africains sont vendus comme [b]esclaves[/b] et emmenés de force en Amérique : c'est la [b]traite[/b].[/cadre]
[page]
[titre]La vie dans les plantations[/titre]
[center][font_size=50]🌿 ⛓️[/font_size][/center]
Dans les colonies d'Amérique, les esclaves travaillent dans d'immenses [b]plantations[/b] de canne à sucre, de café, de coton ou de tabac.
[cadre]Ils travaillent du matin au soir, sans salaire et sans liberté. Ils sont punis très durement. Les enfants d'esclaves naissent esclaves. Certains résistent : ils s'enfuient ou se révoltent.[/cadre]
[page]
[titre]Le « Code noir »[/titre]
[center][font_size=56]📜[/font_size][/center]
En [b]1685[/b], Louis XIV signe un édit appelé « [b]Code noir[/b] ». Il fixe les règles de l'[b]esclavage[/b] dans les colonies françaises.
[cadre]Ce texte considère les esclaves comme des [b]biens[/b] qui appartiennent à leur maître, comme un objet. Il autorise des punitions terribles.[/cadre]
[page]
[titre]Les produits venus d'Amérique[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🍅 la tomate[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🥔 la pomme de terre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🌽 le maïs[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🫘 le haricot[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🍫 le cacao (chocolat)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🦃 la dinde[/font_size][/center][/cell][/table]
[cadre]Les colonies envoient aussi en Europe du [b]sucre de canne[/b], du café, du coton et du tabac, produits par les esclaves.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Grâce à la caravelle, la boussole, l'astrolabe et les cartes, les Européens explorent le monde.
• [b]1492[/b] : Christophe Colomb arrive en Amérique. [b]1519-1522[/b] : l'expédition de Magellan fait le tour du monde.
• L'Espagne, le Portugal, la France et l'Angleterre créent des empires coloniaux en Amérique.
• Les Amérindiens meurent en grand nombre. Des millions d'Africains sont déportés comme esclaves (traite, commerce triangulaire).
• [b]1685[/b] : le « Code noir ».[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'explorations'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche 1789, une année révolutionnaire (CM1) - histoire, notion 'revolution_1789'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'histoire', '1789, une année révolutionnaire', $fiche$
[titre]Le royaume en 1789[/titre]
[center][font_size=50]👑 🍞 💸[/font_size][/center]
Le roi est [b]Louis XVI[/b], marié à Marie-Antoinette. Le royaume va mal :
[cadre]• Les caisses de l'État sont vides : le roi a besoin d'argent.
• En 1788, les récoltes sont mauvaises : le [b]pain[/b] devient très cher et le peuple a faim.
• Le tiers état paie presque tous les impôts et trouve les privilèges injustes.[/cadre]
[page]
[titre]Les Lumières[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Voltaire[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il défend la tolérance et dénonce les injustices[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]Montesquieu[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]les pouvoirs doivent être séparés,
pas tous dans les mains du roi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Rousseau[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le pouvoir doit venir du peuple[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18][b]Diderot[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]il dirige l'[b]Encyclopédie[/b], qui rassemble
toutes les connaissances[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][b]Émilie du Châtelet[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]une savante, qui fait connaître
les découvertes de Newton[/font_size][/center][/cell][/table]
[cadre]Au XVIIIe siècle, ces philosophes défendent la [b]raison[/b], la [b]liberté[/b] et l'[b]égalité[/b].[/cadre]
[page]
[titre]Printemps 1789 : les États généraux[/titre]
[center][font_size=50]📝 🏛️[/font_size][/center]
Au printemps 1789, les Français écrivent leurs plaintes et leurs demandes dans des [b]cahiers de doléances[/b].
[cadre]Le 5 mai, le roi réunit à Versailles les [b]États généraux[/b] : des députés du clergé, de la noblesse et du tiers état. En juin, les députés du tiers état se proclament [b]Assemblée nationale[/b] et jurent de donner une [b]constitution[/b] au pays.[/cadre]
[page]
[titre]14 juillet : la prise de la Bastille[/titre]
[center][font_size=50]🏰 🔥[/font_size][/center]
Le [b]14 juillet 1789[/b], des Parisiens en colère attaquent la [b]Bastille[/b], une forteresse-prison où ils cherchent de la poudre et des armes.
[cadre]La Bastille était le symbole du pouvoir absolu du roi. Sa prise est devenue le symbole de la Révolution : le 14 juillet est aujourd'hui notre fête nationale.[/cadre]
[page]
[titre]La nuit du 4 août[/titre]
[center][font_size=56]⚖️[/font_size][/center]
Dans les campagnes, les paysans se révoltent contre les seigneurs.
[cadre]Dans la nuit du [b]4 août 1789[/b], les députés votent l'[b]abolition des privilèges[/b] : les droits des seigneurs et la dîme sont supprimés. Tous les Français doivent payer l'impôt. C'est la fin de la société d'ordres.[/cadre]
[page]
[titre]La Déclaration des droits de l'homme[/titre]
[center][font_size=56]📜[/font_size][/center]
Le [b]26 août 1789[/b], les députés adoptent la [b]Déclaration des droits de l'homme et du citoyen[/b].
[cadre]Article 1 : « Les hommes naissent et demeurent [b]libres[/b] et [b]égaux[/b] en droits. »[/cadre]
[page]
[titre]Les droits de la Déclaration[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]liberté[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]de penser, de parler, d'écrire, de croire[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'[b]égalité[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]tous égaux devant la loi et l'impôt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]sûreté[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on ne peut pas être arrêté sans raison ;
on est innocent tant qu'on n'est pas jugé coupable[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la [b]souveraineté nationale[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le pouvoir vient de la nation,
plus seulement du roi[/font_size][/center][/cell][/table]
[page]
[titre]5 et 6 octobre : la marche des femmes[/titre]
[center][font_size=50]👩 🍞 🏰[/font_size][/center]
Les [b]5 et 6 octobre 1789[/b], des milliers de femmes de Paris marchent jusqu'à [b]Versailles[/b] pour réclamer du pain.
[cadre]Elles ramènent le roi et sa famille à Paris. Désormais, le roi vit sous la surveillance du peuple.[/cadre]
[cadre=astuce]Olympe de Gouges écrit pour défendre les droits des femmes : en 1791, elle rédige la Déclaration des droits de la femme et de la citoyenne.[/cadre]
[page]
[titre]Les grandes dates de 1789[/titre]
[frise points=5_mai,20_juin,14_juillet,4_août,26_août,5-6_octobre]
[cadre]5 mai : États généraux • 20 juin : serment de l'Assemblée • 14 juillet : prise de la Bastille • 4 août : abolition des privilèges • 26 août : Déclaration des droits de l'homme • 5-6 octobre : marche des femmes.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• En 1789, le royaume est en crise et les idées des [b]Lumières[/b] se répandent.
• Printemps 1789 : cahiers de doléances et États généraux.
• [b]14 juillet[/b] : prise de la Bastille. [b]Nuit du 4 août[/b] : abolition des privilèges.
• [b]26 août[/b] : Déclaration des droits de l'homme et du citoyen.
• [b]5-6 octobre[/b] : marche des femmes à Versailles.
• C'est la fin de la monarchie absolue et de l'[b]Ancien Régime[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'revolution_1789'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
