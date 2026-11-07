-- Toutes les fiches de cours Histoire et Geographie CM2 (2026-11-07) : histoire seulement, une seule transaction.
begin;
-- Fiche De la République à l'Empire (1792-1815) (CM2) - histoire, notion 'republique_empire'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'De la République à l''Empire (1792-1815)', $fiche$
[titre]Les Français font de la politique[/titre]
[center][font_size=50]🗣️ 📰 🎌[/font_size][/center]
Depuis 1789, les Français participent à la vie politique : ils lisent des journaux, se réunissent dans des clubs, votent, manifestent.
[cadre]Les femmes aussi s'engagent. En [b]mars 1792[/b], [b]Pauline Léon[/b] présente une pétition signée par 319 femmes qui demandent le droit de porter les armes pour défendre la Révolution.[/cadre]
[page]
[titre]La guerre et La Marseillaise[/titre]
[center][font_size=50]🥁 🎶[/font_size][/center]
En avril 1792, la France entre en guerre contre l'Autriche, puis contre d'autres rois d'Europe.
[cadre]En [b]avril 1792[/b], à Strasbourg, Rouget de Lisle compose un chant pour l'armée. Chanté par des soldats venus de Marseille, il prend le nom de [b]La Marseillaise[/b]. C'est aujourd'hui l'hymne national.[/cadre]
[page]
[titre]La naissance de la République[/titre]
[center][font_size=50]👑 ➡️ 🏛️[/font_size][/center]
Le roi Louis XVI est accusé de trahir la France. Le 10 août 1792, les Parisiens prennent son palais des Tuileries et le roi est arrêté.
[cadre]En [b]septembre 1792[/b], la royauté est abolie : la [b]République[/b] est proclamée. Louis XVI est jugé et exécuté en janvier 1793.[/cadre]
[page]
[titre]Le combat contre l'esclavage[/titre]
[center][font_size=50]⛓️ 💥[/font_size][/center]
En 1791, les esclaves de Saint-Domingue (aujourd'hui Haïti), une colonie française, se révoltent pour leur liberté, avec Toussaint Louverture.
[cadre]En [b]1794[/b], la République vote la [b]première abolition de l'esclavage[/b] dans les colonies françaises. Mais en [b]1802[/b], Bonaparte le [b]rétablit[/b].[/cadre]
[page]
[titre]Bonaparte prend le pouvoir[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1796-1799[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le général Bonaparte remporte des victoires
en Italie et part en Égypte[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]1799[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]par un coup d'État, il prend le pouvoir :
il devient Premier consul[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]2 décembre 1804[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]il est [b]sacré empereur[/b] à Notre-Dame de Paris :
il devient [b]Napoléon Ier[/b][/font_size][/center][/cell][/table]
[page]
[titre]L'Empire domine l'Europe[/titre]
[center][font_size=50]⚔️ 🦅[/font_size][/center]
Napoléon gagne de nombreuses batailles, comme [b]Austerlitz[/b] en 1805, et domine une grande partie de l'Europe.
[cadre]Mais la campagne de Russie, en 1812, est un désastre. Battu à [b]Waterloo[/b] en [b]1815[/b], Napoléon est envoyé en exil sur l'île de Sainte-Hélène, où il meurt en 1821.[/cadre]
[page]
[titre]Les réformes de Napoléon[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]📕 le [b]Code civil[/b] (1804)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les mêmes lois pour tous les Français[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏫 les [b]lycées[/b] (1802)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]pour former les futurs dirigeants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🏛️ les [b]préfets[/b] (1800)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un dans chaque département,
pour appliquer les ordres du gouvernement[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🎖️ la Légion d'honneur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]pour récompenser les meilleurs citoyens[/font_size][/center][/cell][/table]
[page]
[titre]Des acquis remis en cause[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]liberté de la presse[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]supprimée : les journaux sont surveillés[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'esclavage[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]rétabli dans les colonies en 1802[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le pouvoir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]aux mains d'un seul homme, l'empereur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les femmes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le Code civil les soumet à leur mari[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Mars 1792 : pétition des femmes (Pauline Léon). Avril 1792 : La Marseillaise.
• [b]Septembre 1792[/b] : naissance de la République.
• [b]1794[/b] : première abolition de l'esclavage ; [b]1802[/b] : rétablissement.
• [b]2 décembre 1804[/b] : sacre de Napoléon Ier.
• Réformes : Code civil, lycées, préfets. Mais moins de libertés.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'republique_empire'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Vers une France républicaine (1848-1914) (CM2) - histoire, notion 'france_republicaine'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'Vers une France républicaine (1848-1914)', $fiche$
[titre]Les régimes du XIXe siècle[/titre]
[frise points=1848,1852,1870,1882,1905,1914 debut=IIe_République fin=IIIe_République]
[cadre]• [b]1848-1852[/b] : la IIe République.
• 1852-1870 : le Second Empire de Napoléon III.
• [b]À partir de 1870[/b] : la IIIe République.[/cadre]
[page]
[titre]1848 : la IIe République[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🗳️ le [b]suffrage universel masculin[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]tous les hommes de plus de 21 ans
peuvent voter[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]⛓️ l'[b]abolition définitive
de l'esclavage[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]grâce à Victor Schœlcher,
dans toutes les colonies françaises[/font_size][/center][/cell][/table]
[cadre=astuce]Les femmes, elles, ne peuvent pas encore voter.[/cadre]
[page]
[titre]La IIIe République[/titre]
[center][img=84x56]res://ui/fiche/drapeaux/fr.svg[/img][/center]
En 1870, la France est battue par la Prusse. L'empereur Napoléon III est fait prisonnier et la [b]République[/b] est proclamée. Elle s'installe durablement.
[cadre]La [b]démocratie[/b] progresse : les citoyens choisissent leurs députés et leurs maires par le vote.[/cadre]
[page]
[titre]Les grandes lois de la République[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1881[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]liberté de la presse[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]1881-1882[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les [b]lois Ferry[/b] : l'école gratuite,
obligatoire et laïque[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1884[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la liberté de créer des syndicats[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]9 décembre 1905[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la [b]séparation des Églises et de l'État[/b][/font_size][/center][/cell][/table]
[page]
[titre]L'école de Jules Ferry[/titre]
[center][font_size=50]🏫 ✏️ 📖[/font_size][/center]
Avec les lois de [b]Jules Ferry[/b] (1882-1886), l'école primaire devient [b]gratuite[/b], [b]obligatoire[/b] de 6 à 13 ans pour les filles et les garçons, et [b]laïque[/b].
[cadre]On y apprend à lire, écrire, compter, mais aussi l'histoire de France et à devenir un bon citoyen.[/cadre]
[page]
[titre]La laïcité[/titre]
[center][font_size=56]⚖️[/font_size][/center]
La loi de [b]1905[/b] sépare les Églises et l'État : c'est la [b]laïcité[/b].
[cadre]L'État ne favorise aucune religion et n'en paie aucune. Chacun est libre de croire ou de ne pas croire, et de pratiquer sa religion en respectant la loi.[/cadre]
[page]
[titre]Les symboles de la République[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][img=30x20]res://ui/fiche/drapeaux/fr.svg[/img] le [b]drapeau tricolore[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]bleu, blanc, rouge[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🎶 [b]La Marseillaise[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'hymne national[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🎆 le [b]14 juillet[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la fête nationale[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]👩 [b]Marianne[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la femme qui représente la République[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]📜 la [b]devise[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]« Liberté, Égalité, Fraternité »[/font_size][/center][/cell][/table]
[cadre=astuce]Les lieux de la République : la mairie, l'école, l'Assemblée nationale…[/cadre]
[page]
[titre]L'empire colonial français[/titre]
[planisphere pale=oui colonies=oui france=oui largeur=720]
[page]
[titre]La colonisation[/titre]
[center][font_size=50]🌍 ⚓[/font_size][/center]
Au XIXe siècle, la France conquiert de nombreux territoires en Afrique et en Asie : l'Algérie, l'Afrique de l'Ouest, Madagascar, l'Indochine… En 1914, elle a le [b]2e empire colonial du monde[/b].
[cadre]Les peuples colonisés sont dominés : ils n'ont pas les mêmes droits que les Français, et les richesses de leurs pays sont exploitées.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]1848[/b] : suffrage universel masculin et abolition définitive de l'esclavage.
• [b]1882-1886[/b] : lois Ferry sur l'École. [b]1905[/b] : séparation des Églises et de l'État (laïcité).
• Les symboles : drapeau tricolore, Marseillaise, 14 juillet, Marianne, la devise.
• La France se constitue un grand empire colonial.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'france_republicaine'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche L'âge industriel en France au XIXe siècle (CM2) - histoire, notion 'age_industriel'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'L''âge industriel en France au XIXe siècle', $fiche$
[titre]Une nouvelle énergie : le charbon[/titre]
[center][font_size=50]⛏️ 🔥 ⚙️[/font_size][/center]
Au XIXe siècle, on brûle du [b]charbon[/b] pour faire fonctionner des [b]machines à vapeur[/b]. Elles remplacent la force des hommes et des animaux.
[cadre]Les mines de charbon se développent, surtout dans le Nord et en Lorraine. Puis, à la fin du siècle, on utilise l'[b]électricité[/b] et le [b]pétrole[/b].[/cadre]
[page]
[titre]Le chemin de fer[/titre]
[center][font_size=50]🚂 🛤️[/font_size][/center]
Au début du XIXe siècle, l'Anglais [b]Stephenson[/b] met au point la [b]locomotive[/b] à vapeur.
[cadre]Les voies ferrées couvrent bientôt toute la France. Le train transporte rapidement les voyageurs et les marchandises : on va de Paris à Marseille en un jour au lieu de deux semaines.[/cadre]
[page]
[titre]L'industrialisation[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'[b]atelier[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un petit lieu de travail
où l'on fabrique à la main[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'[b]usine[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un grand bâtiment où des machines
et des ouvriers produisent en grande quantité[/font_size][/center][/cell][/table]
[cadre]Les usines se multiplient : textiles, métallurgie (fer, acier). C'est l'[b]industrialisation[/b].[/cadre]
[page]
[titre]Des inventions qui changent la vie[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]📷 la photographie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]☎️ le téléphone[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]💡 l'ampoule électrique[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]🚗 l'automobile[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🎬 le cinéma (1895)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🚲 la bicyclette[/font_size][/center][/cell][/table]
[page]
[titre]Les progrès de la médecine[/titre]
[center][font_size=50]💉 🔬[/font_size][/center]
En [b]1885[/b], [b]Louis Pasteur[/b] met au point le [b]vaccin contre la rage[/b]. Il sauve un jeune garçon mordu par un chien enragé, Joseph Meister.
[cadre]Les médecins découvrent que les microbes causent des maladies. On apprend à se laver les mains, à stériliser les instruments : on soigne mieux et on vit plus longtemps.[/cadre]
[page]
[titre]La vie des ouvriers[/titre]
[center][font_size=50]🏭 ⛏️ 👷[/font_size][/center]
Les ouvrières et les ouvriers travaillent 12 à 15 heures par jour, 6 jours sur 7, pour un petit salaire. Des enfants travaillent aussi.
[cadre]À la [b]mine[/b], le travail est dangereux (éboulements, coups de grisou). Les familles ouvrières vivent dans des logements petits, sombres et sales.[/cadre]
[page]
[titre]La vie des bourgeois[/titre]
[center][font_size=50]🎩 🏛️ 🎹[/font_size][/center]
Les [b]bourgeois[/b] sont des patrons d'usine, des banquiers, des commerçants, des médecins…
[cadre]Ils vivent dans de beaux immeubles en ville, ont des domestiques, vont au théâtre. Leurs enfants vont au lycée.[/cadre]
[page]
[titre]Les luttes ouvrières[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]grève[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]arrêter de travailler ensemble
pour obtenir de meilleures conditions[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le [b]syndicat[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]une association qui défend
les travailleurs[/font_size][/center][/cell][/table]
[cadre]Dans la seconde moitié du XIXe siècle, les ouvriers obtiennent le [b]droit de grève[/b] (1864) et la [b]liberté syndicale[/b] (1884).[/cadre]
[page]
[titre]Une France encore rurale[/titre]
[center][font_size=50]🌾 ➡️ 🏙️[/font_size][/center]
Malgré les usines, la plupart des Français vivent encore à la [b]campagne[/b] en 1900 : environ 6 sur 10.
[cadre]Mais beaucoup partent travailler en ville : les villes grandissent, c'est l'[b]urbanisation[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Début du XIXe siècle : la [b]locomotive[/b] (Stephenson). Le charbon, puis l'électricité et le pétrole.
• Fin du XIXe siècle : le [b]vaccin contre la rage[/b] (Pasteur, 1885).
• Les ouvriers travaillent dur ; les bourgeois vivent dans l'aisance.
• [b]Droit de grève[/b] (1864) et [b]liberté syndicale[/b] (1884).
• La France reste surtout rurale, mais les villes grandissent.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'age_industriel'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La Première Guerre mondiale (1914-1918) (CM2) - histoire, notion 'premiere_guerre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'La Première Guerre mondiale (1914-1918)', $fiche$
[titre]Une guerre mondiale[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les [b]Alliés[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la France, le Royaume-Uni, la Russie,
puis l'Italie et les États-Unis[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]en face[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'Allemagne, l'Autriche-Hongrie,
l'Empire ottoman[/font_size][/center][/cell][/table]
[cadre]La guerre commence en août [b]1914[/b] et se termine en [b]1918[/b]. Des pays du monde entier y participent.[/cadre]
[page]
[titre]Le front en France[/titre]
[carte vue=france front=oui largeur=400]
[page]
[titre]Mouvement puis position[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]guerre de mouvement[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]en 1914, les armées avancent et reculent ;
les Allemands sont arrêtés sur la Marne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la [b]guerre de position[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]de 1915 à 1918, les soldats s'enterrent
dans des [b]tranchées[/b] face à face[/font_size][/center][/cell][/table]
[cadre]Le front traverse le [b]nord et l'est[/b] de la France, de la mer du Nord à la Suisse.[/cadre]
[page]
[titre]La vie des poilus[/titre]
[center][font_size=50]🪖 🌧️ 💣[/font_size][/center]
On appelle les soldats français les « [b]poilus[/b] ». Dans les tranchées, ils vivent dans la boue, le froid, avec les rats et les poux.
[cadre]Ils subissent les bombardements, les gaz, et doivent sortir pour attaquer sous les tirs. Leurs lettres à leur famille racontent cette vie terrible.[/cadre]
[page]
[titre]Verdun, 1916[/titre]
[center][font_size=56]⚔️[/font_size][/center]
La [b]bataille de Verdun[/b] dure presque toute l'année 1916. Les Allemands attaquent, les Français résistent.
[cadre]Elle fait environ 300 000 morts, français et allemands. Elle est devenue le symbole de la souffrance des soldats.[/cadre]
[page]
[titre]Tout le pays participe[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]👩 les [b]femmes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]elles remplacent les hommes aux champs,
dans les usines d'armes, soignent les blessés[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]🏭 les usines[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]fabriquent des obus, des canons, des avions[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]🌍 les colonies[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]envoient des soldats et des travailleurs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]📰 les journaux, les affiches[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]encouragent la population à soutenir l'effort[/font_size][/center][/cell][/table]
[page]
[titre]11 novembre 1918 : l'armistice[/titre]
[center][font_size=50]🕊️ 🔔[/font_size][/center]
Le [b]11 novembre 1918[/b], l'Allemagne signe l'[b]armistice[/b] : les combats s'arrêtent. Les cloches sonnent dans toute la France.
[cadre]Un [b]armistice[/b] est un accord pour arrêter les combats. Le 11 novembre est aujourd'hui un jour férié, où l'on se souvient des morts.[/cadre]
[page]
[titre]Le bilan de la guerre[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]10 millions[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]de soldats morts au combat[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]dont 1,4 million[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]de Français[/font_size][/center][/cell][/table]
[cadre]Des millions de blessés reviennent mutilés, comme les « gueules cassées ». Dans chaque commune, un [b]monument aux morts[/b] rappelle les noms des soldats tués.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]1914-1918[/b] : la Première Guerre mondiale.
• Guerre de mouvement, puis guerre de position dans les tranchées du nord et de l'est de la France.
• Les poilus vivent dans des conditions terribles. [b]Verdun[/b], 1916.
• Les femmes, les usines et les colonies participent à l'effort de guerre.
• [b]11 novembre 1918[/b] : l'armistice. 10 millions de soldats morts, dont 1,4 million de Français.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'premiere_guerre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La France dans la Seconde Guerre mondiale (1939-1945) (CM2) - histoire, notion 'seconde_guerre'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'La France dans la Seconde Guerre mondiale (1939-1945)', $fiche$
[titre]La guerre commence[/titre]
[center][font_size=56]⚠️[/font_size][/center]
En Allemagne, [b]Hitler[/b] et le parti nazi sont au pouvoir. Le [b]nazisme[/b] est une idéologie raciste qui veut dominer l'Europe.
[cadre]En septembre [b]1939[/b], l'Allemagne envahit la Pologne : la France et le Royaume-Uni lui déclarent la guerre. Pendant 8 mois, il n'y a presque pas de combats : c'est la « [b]drôle de guerre[/b] ».[/cadre]
[page]
[titre]Juin 1940 : la défaite[/titre]
[center][font_size=56]🏳️[/font_size][/center]
En mai 1940, l'armée allemande attaque. En quelques semaines, la France est battue. Le maréchal [b]Pétain[/b] signe l'armistice avec l'Allemagne.
[cadre]Le [b]18 juin 1940[/b], depuis Londres, le [b]général de Gaulle[/b] lance un appel à la radio : il demande aux Français de continuer le combat.[/cadre]
[page]
[titre]Une France coupée en deux[/titre]
[carte vue=france occupation=oui largeur=400]
[page]
[titre]Occupation et collaboration[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la [b]zone occupée[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le nord et l'ouest, occupés
par l'armée allemande[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la [b]zone libre[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le sud, gouverné depuis Vichy
par Pétain ; occupée à son tour en 1942[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]régime de Vichy[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Pétain supprime la République
et gouverne seul[/font_size][/center][/cell][/table]
[cadre]Le régime de Vichy choisit la [b]collaboration[/b] : il aide l'Allemagne nazie.[/cadre]
[page]
[titre]La vie sous l'Occupation[/titre]
[center][font_size=50]🎫 🥖 🌙[/font_size][/center]
La nourriture, le charbon et les vêtements manquent : ils sont [b]rationnés[/b] avec des tickets. On fait la queue pendant des heures.
[cadre]Il y a un couvre-feu le soir. Les journaux et la radio sont contrôlés. Des centaines de milliers de jeunes sont envoyés travailler de force en Allemagne.[/cadre]
[page]
[titre]La persécution des Juifs[/titre]
[center][font_size=56]✡️[/font_size][/center]
Le régime de Vichy mène une politique [b]antisémite[/b] : dès 1940, les Juifs sont exclus de nombreux métiers. En zone occupée, ils doivent porter une étoile jaune à partir de 1942.
[cadre]Les [b]16 et 17 juillet 1942[/b], la police française arrête à Paris environ 13 000 Juifs, dont plus de 4 000 enfants : c'est la [b]rafle du Vel d'Hiv'[/b]. Ils sont déportés vers les camps nazis.[/cadre]
[page]
[titre]L'extermination des Juifs[/titre]
[center][font_size=56]🕯️[/font_size][/center]
Les nazis organisent l'extermination des Juifs d'Europe dans des camps, comme [b]Auschwitz[/b]. [b]6 millions de Juifs[/b] sont assassinés, 60 % des Juifs d'Europe.
[cadre]En France, environ 75 000 Juifs sont déportés ; très peu reviennent. Les Tsiganes sont aussi persécutés et enfermés dans des camps.[/cadre]
[page]
[titre]Les Justes parmi les Nations[/titre]
[center][font_size=50]🤝 🏡[/font_size][/center]
Des Français ont caché et sauvé des Juifs, en risquant leur vie. On les appelle les « [b]Justes parmi les Nations[/b] ».
[cadre]Au [b]Chambon-sur-Lignon[/b], en Haute-Loire, les habitants ont caché des milliers de personnes, surtout des enfants. Plus de 4 000 Français ont reçu le titre de Juste.[/cadre]
[page]
[titre]La Résistance[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]agir en secret[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]journaux clandestins, renseignements,
sabotages de trains et d'usines[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]les [b]maquis[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des groupes de résistants cachés
dans les forêts et les montagnes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Jean Moulin[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]envoyé par de Gaulle, il unit les mouvements
de Résistance ; arrêté, il meurt en 1943[/font_size][/center][/cell][/table]
[cadre]Des femmes, comme Lucie Aubrac, jouent un grand rôle dans la Résistance.[/cadre]
[page]
[titre]La Libération[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]6 juin 1944[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les Alliés (Américains, Britanniques,
Canadiens…) débarquent en Normandie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]août 1944[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]débarquement en Provence ;
Paris est libéré le 25 août[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]8 mai 1945[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Allemagne nazie capitule :
la guerre est finie en Europe[/font_size][/center][/cell][/table]
[page]
[titre]Le bilan[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]60 à 70 millions[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]de morts dans le monde,
plus de civils que de soldats[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]6 millions[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]de Juifs assassinés[/font_size][/center][/cell][/table]
[cadre]C'est la guerre la plus meurtrière de l'histoire. Après elle, les pays veulent construire une paix durable.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]1939-1945[/b] : la Seconde Guerre mondiale. Drôle de guerre, puis défaite de juin 1940.
• [b]18 juin 1940[/b] : appel du général de Gaulle.
• Occupation, collaboration du régime de Vichy (Pétain), Résistance (Jean Moulin).
• [b]1942[/b] : rafle du Vel d'Hiv'. 6 millions de Juifs exterminés.
• [b]6 juin 1944[/b] : débarquement en Normandie. [b]8 mai 1945[/b] : capitulation de l'Allemagne nazie.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'seconde_guerre'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La France depuis 1945 (CM2) - histoire, notion 'france_depuis_1945'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'La France depuis 1945', $fiche$
[titre]Une République démocratique et sociale[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]1944[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les femmes obtiennent le [b]droit de vote[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]1945[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]création de la [b]Sécurité sociale[/b] :
on est aidé quand on est malade ou âgé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1946[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la Constitution affirme des droits sociaux
(travail, santé, éducation)[/font_size][/center][/cell][/table]
[page]
[titre]1958 : la Ve République[/titre]
[center][img=66x44]res://ui/fiche/drapeaux/fr.svg[/img] [font_size=50]📜[/font_size][/center]
En [b]1958[/b], une nouvelle Constitution fonde la [b]Ve République[/b], voulue par le [b]général de Gaulle[/b], qui devient président.
[cadre]Depuis 1962, le président de la République est élu directement par tous les citoyens. Nous vivons toujours sous la Ve République.[/cadre]
[page]
[titre]Des droits pour les femmes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1944[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le droit de vote[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]1965[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]travailler et ouvrir un compte en banque
sans l'autorisation de leur mari[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1972[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]à travail égal, salaire égal[/font_size][/center][/cell][/table]
[page]
[titre]Une société qui change[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚗 les transports[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la voiture pour tous, le TGV (1981), l'avion[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏠 la maison[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]réfrigérateur, machine à laver, télévision[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🏖️ les loisirs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des congés payés plus longs, des vacances,
du sport[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]💻 l'[b]innovation[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ordinateurs, Internet, téléphones portables[/font_size][/center][/cell][/table]
[cadre]On achète de plus en plus de produits : c'est la [b]société de consommation[/b].[/cadre]
[page]
[titre]La construction européenne[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]1957[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le [b]traité de Rome[/b] crée la CEE
(6 pays, dont la France)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]1992[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le traité de Maastricht crée
l'Union européenne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]2002[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les pièces et billets en [b]euros[/b]
remplacent le franc[/font_size][/center][/cell][/table]
[cadre]Après deux guerres terribles, la France et l'Allemagne se réconcilient et construisent l'Europe pour garantir la [b]paix[/b].[/cadre]
[page]
[titre]Les grandes dates[/titre]
[frise points=1944,1945,1957,1958,1965,2002 debut=après_la_guerre fin=aujourd'hui]
[cadre]1944 : vote des femmes • 1945 : Sécurité sociale • 1957 : traité de Rome • 1958 : Ve République • 1965 : nouveaux droits des femmes • 2002 : l'euro.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Depuis 1945, la France connaît la paix et de grandes transformations.
• [b]1944[/b] : droit de vote des femmes. 1945 : Sécurité sociale.
• [b]1958[/b] : fondation de la Ve République avec le général de Gaulle.
• [b]1965[/b] : les Françaises peuvent travailler et ouvrir un compte sans l'autorisation de leur mari.
• [b]1957[/b] : traité de Rome. L'euro remplace le franc.
• La société de consommation, les loisirs et l'innovation changent la vie.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'france_depuis_1945'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
