# Fiches de cours Histoire et Geographie CM2 (2026-11-07), programme du BO n° 22 du 28 mai 2026
# (cycle 3). Histoire : 6 themes ; Geographie « la France, l'Union europeenne » : 3 themes.
# Matieres separees : 'histoire' / 'geographie'. Sorties : cm2_<hist|geo>_<code>.sql, cm2_histgeo_toutes.sql.
import sys
from logique_lib import tableau, couleur_alt
from gen_cp_histgeo import gros
from gen_cm1_histgeo import sortie

CL = 'cm2'


def drapeau(pays, h=20):
    """Petit drapeau en image (ui/fiche/drapeaux/<pays>.svg, format 3:2). Les emoji drapeaux
    s'affichent en lettres (« FR ») : ni NotoEmoji ni la police emoji de Windows ne les
    assemblent (retour Steve 2026-11-07)."""
    return f'[img={h * 3 // 2}x{h}]res://ui/fiche/drapeaux/{pays}.svg[/img]'

FICHES = []


def add(code, titre, domaine, pages):
    FICHES.append((CL, code, titre, domaine, [couleur_alt(CL, p) for p in pages]))


# =====================================================================  HISTOIRE 1
add('republique_empire', 'De la République à l\'Empire (1792-1815)', 'histoire', [
f"""[titre]Les Français font de la politique[/titre]
{gros('🗣️ 📰 🎌', 50)}
Depuis 1789, les Français participent à la vie politique : ils lisent des journaux, se réunissent dans des clubs, votent, manifestent.
[cadre]Les femmes aussi s'engagent. En [b]mars 1792[/b], [b]Pauline Léon[/b] présente une pétition signée par 319 femmes qui demandent le droit de porter les armes pour défendre la Révolution.[/cadre]""",
f"""[titre]La guerre et La Marseillaise[/titre]
{gros('🥁 🎶', 50)}
En avril 1792, la France entre en guerre contre l'Autriche, puis contre d'autres rois d'Europe.
[cadre]En [b]avril 1792[/b], à Strasbourg, Rouget de Lisle compose un chant pour l'armée. Chanté par des soldats venus de Marseille, il prend le nom de [b]La Marseillaise[/b]. C'est aujourd'hui l'hymne national.[/cadre]""",
f"""[titre]La naissance de la République[/titre]
{gros('👑 ➡️ 🏛️', 50)}
Le roi Louis XVI est accusé de trahir la France. Le 10 août 1792, les Parisiens prennent son palais des Tuileries et le roi est arrêté.
[cadre]En [b]septembre 1792[/b], la royauté est abolie : la [b]République[/b] est proclamée. Louis XVI est jugé et exécuté en janvier 1793.[/cadre]""",
f"""[titre]Le combat contre l'esclavage[/titre]
{gros('⛓️ 💥', 50)}
En 1791, les esclaves de Saint-Domingue (aujourd'hui Haïti), une colonie française, se révoltent pour leur liberté, avec Toussaint Louverture.
[cadre]En [b]1794[/b], la République vote la [b]première abolition de l'esclavage[/b] dans les colonies françaises. Mais en [b]1802[/b], Bonaparte le [b]rétablit[/b].[/cadre]""",
f"""[titre]Bonaparte prend le pouvoir[/titre]
{tableau(2, ['1796-1799', 'le général Bonaparte remporte des victoires\nen Italie et part en Égypte', '1799', 'par un coup d\'État, il prend le pouvoir :\nil devient Premier consul', '[b]2 décembre 1804[/b]', 'il est [b]sacré empereur[/b] à Notre-Dame de Paris :\nil devient [b]Napoléon Ier[/b]'], size=19, lignes=True)}""",
f"""[titre]L'Empire domine l'Europe[/titre]
{gros('⚔️ 🦅', 50)}
Napoléon gagne de nombreuses batailles, comme [b]Austerlitz[/b] en 1805, et domine une grande partie de l'Europe.
[cadre]Mais la campagne de Russie, en 1812, est un désastre. Battu à [b]Waterloo[/b] en [b]1815[/b], Napoléon est envoyé en exil sur l'île de Sainte-Hélène, où il meurt en 1821.[/cadre]""",
f"""[titre]Les réformes de Napoléon[/titre]
{tableau(2, ['📕 le [b]Code civil[/b] (1804)', 'les mêmes lois pour tous les Français', '🏫 les [b]lycées[/b] (1802)', 'pour former les futurs dirigeants', '🏛️ les [b]préfets[/b] (1800)', 'un dans chaque département,\npour appliquer les ordres du gouvernement', '🎖️ la Légion d\'honneur', 'pour récompenser les meilleurs citoyens'], size=19, lignes=True)}""",
f"""[titre]Des acquis remis en cause[/titre]
{tableau(2, ['la [b]liberté de la presse[/b]', 'supprimée : les journaux sont surveillés', 'l\'esclavage', 'rétabli dans les colonies en 1802', 'le pouvoir', 'aux mains d\'un seul homme, l\'empereur', 'les femmes', 'le Code civil les soumet à leur mari'], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• Mars 1792 : pétition des femmes (Pauline Léon). Avril 1792 : La Marseillaise.
• [b]Septembre 1792[/b] : naissance de la République.
• [b]1794[/b] : première abolition de l'esclavage ; [b]1802[/b] : rétablissement.
• [b]2 décembre 1804[/b] : sacre de Napoléon Ier.
• Réformes : Code civil, lycées, préfets. Mais moins de libertés.[/cadre]""",
])

# =====================================================================  HISTOIRE 2
add('france_republicaine', 'Vers une France républicaine (1848-1914)', 'histoire', [
"""[titre]Les régimes du XIXe siècle[/titre]
[frise points=1848,1852,1870,1882,1905,1914 debut=IIe_République fin=IIIe_République]
[cadre]• [b]1848-1852[/b] : la IIe République.
• 1852-1870 : le Second Empire de Napoléon III.
• [b]À partir de 1870[/b] : la IIIe République.[/cadre]""",
f"""[titre]1848 : la IIe République[/titre]
{tableau(2, ['🗳️ le [b]suffrage universel masculin[/b]', 'tous les hommes de plus de 21 ans\npeuvent voter', '⛓️ l\'[b]abolition définitive\nde l\'esclavage[/b]', 'grâce à Victor Schœlcher,\ndans toutes les colonies françaises'], size=20, lignes=True)}
[cadre=astuce]Les femmes, elles, ne peuvent pas encore voter.[/cadre]""",
f"""[titre]La IIIe République[/titre]
[center]{drapeau('fr', 56)}[/center]
En 1870, la France est battue par la Prusse. L'empereur Napoléon III est fait prisonnier et la [b]République[/b] est proclamée. Elle s'installe durablement.
[cadre]La [b]démocratie[/b] progresse : les citoyens choisissent leurs députés et leurs maires par le vote.[/cadre]""",
f"""[titre]Les grandes lois de la République[/titre]
{tableau(2, ['1881', 'la [b]liberté de la presse[/b]', '1881-1882', 'les [b]lois Ferry[/b] : l\'école gratuite,\nobligatoire et laïque', '1884', 'la liberté de créer des syndicats', '[b]9 décembre 1905[/b]', 'la [b]séparation des Églises et de l\'État[/b]'], size=19, lignes=True)}""",
f"""[titre]L'école de Jules Ferry[/titre]
{gros('🏫 ✏️ 📖', 50)}
Avec les lois de [b]Jules Ferry[/b] (1882-1886), l'école primaire devient [b]gratuite[/b], [b]obligatoire[/b] de 6 à 13 ans pour les filles et les garçons, et [b]laïque[/b].
[cadre]On y apprend à lire, écrire, compter, mais aussi l'histoire de France et à devenir un bon citoyen.[/cadre]""",
f"""[titre]La laïcité[/titre]
{gros('⚖️', 56)}
La loi de [b]1905[/b] sépare les Églises et l'État : c'est la [b]laïcité[/b].
[cadre]L'État ne favorise aucune religion et n'en paie aucune. Chacun est libre de croire ou de ne pas croire, et de pratiquer sa religion en respectant la loi.[/cadre]""",
f"""[titre]Les symboles de la République[/titre]
{tableau(2, [drapeau('fr') + ' le [b]drapeau tricolore[/b]', 'bleu, blanc, rouge', '🎶 [b]La Marseillaise[/b]', 'l\'hymne national', '🎆 le [b]14 juillet[/b]', 'la fête nationale', '👩 [b]Marianne[/b]', 'la femme qui représente la République', '📜 la [b]devise[/b]', '« Liberté, Égalité, Fraternité »'], size=19, lignes=True)}
[cadre=astuce]Les lieux de la République : la mairie, l'école, l'Assemblée nationale…[/cadre]""",
"""[titre]L'empire colonial français[/titre]
[planisphere pale=oui colonies=oui france=oui largeur=720]""",
f"""[titre]La colonisation[/titre]
{gros('🌍 ⚓', 50)}
Au XIXe siècle, la France conquiert de nombreux territoires en Afrique et en Asie : l'Algérie, l'Afrique de l'Ouest, Madagascar, l'Indochine… En 1914, elle a le [b]2e empire colonial du monde[/b].
[cadre]Les peuples colonisés sont dominés : ils n'ont pas les mêmes droits que les Français, et les richesses de leurs pays sont exploitées.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]1848[/b] : suffrage universel masculin et abolition définitive de l'esclavage.
• [b]1882-1886[/b] : lois Ferry sur l'École. [b]1905[/b] : séparation des Églises et de l'État (laïcité).
• Les symboles : drapeau tricolore, Marseillaise, 14 juillet, Marianne, la devise.
• La France se constitue un grand empire colonial.[/cadre]""",
])

# =====================================================================  HISTOIRE 3
add('age_industriel', 'L\'âge industriel en France au XIXe siècle', 'histoire', [
f"""[titre]Une nouvelle énergie : le charbon[/titre]
{gros('⛏️ 🔥 ⚙️', 50)}
Au XIXe siècle, on brûle du [b]charbon[/b] pour faire fonctionner des [b]machines à vapeur[/b]. Elles remplacent la force des hommes et des animaux.
[cadre]Les mines de charbon se développent, surtout dans le Nord et en Lorraine. Puis, à la fin du siècle, on utilise l'[b]électricité[/b] et le [b]pétrole[/b].[/cadre]""",
f"""[titre]Le chemin de fer[/titre]
{gros('🚂 🛤️', 50)}
Au début du XIXe siècle, l'Anglais [b]Stephenson[/b] met au point la [b]locomotive[/b] à vapeur.
[cadre]Les voies ferrées couvrent bientôt toute la France. Le train transporte rapidement les voyageurs et les marchandises : on va de Paris à Marseille en un jour au lieu de deux semaines.[/cadre]""",
f"""[titre]L'industrialisation[/titre]
{tableau(2, ['l\'[b]atelier[/b]', 'un petit lieu de travail\noù l\'on fabrique à la main', 'l\'[b]usine[/b]', 'un grand bâtiment où des machines\net des ouvriers produisent en grande quantité'], size=20, lignes=True)}
[cadre]Les usines se multiplient : textiles, métallurgie (fer, acier). C'est l'[b]industrialisation[/b].[/cadre]""",
f"""[titre]Des inventions qui changent la vie[/titre]
{tableau(2, ['📷 la photographie', '☎️ le téléphone', '💡 l\'ampoule électrique', '🚗 l\'automobile', '🎬 le cinéma (1895)', '🚲 la bicyclette'], size=21, paires=True)}""",
f"""[titre]Les progrès de la médecine[/titre]
{gros('💉 🔬', 50)}
En [b]1885[/b], [b]Louis Pasteur[/b] met au point le [b]vaccin contre la rage[/b]. Il sauve un jeune garçon mordu par un chien enragé, Joseph Meister.
[cadre]Les médecins découvrent que les microbes causent des maladies. On apprend à se laver les mains, à stériliser les instruments : on soigne mieux et on vit plus longtemps.[/cadre]""",
f"""[titre]La vie des ouvriers[/titre]
{gros('🏭 ⛏️ 👷', 50)}
Les ouvrières et les ouvriers travaillent 12 à 15 heures par jour, 6 jours sur 7, pour un petit salaire. Des enfants travaillent aussi.
[cadre]À la [b]mine[/b], le travail est dangereux (éboulements, coups de grisou). Les familles ouvrières vivent dans des logements petits, sombres et sales.[/cadre]""",
f"""[titre]La vie des bourgeois[/titre]
{gros('🎩 🏛️ 🎹', 50)}
Les [b]bourgeois[/b] sont des patrons d'usine, des banquiers, des commerçants, des médecins…
[cadre]Ils vivent dans de beaux immeubles en ville, ont des domestiques, vont au théâtre. Leurs enfants vont au lycée.[/cadre]""",
f"""[titre]Les luttes ouvrières[/titre]
{tableau(2, ['la [b]grève[/b]', 'arrêter de travailler ensemble\npour obtenir de meilleures conditions', 'le [b]syndicat[/b]', 'une association qui défend\nles travailleurs'], size=20, lignes=True)}
[cadre]Dans la seconde moitié du XIXe siècle, les ouvriers obtiennent le [b]droit de grève[/b] (1864) et la [b]liberté syndicale[/b] (1884).[/cadre]""",
f"""[titre]Une France encore rurale[/titre]
{gros('🌾 ➡️ 🏙️', 50)}
Malgré les usines, la plupart des Français vivent encore à la [b]campagne[/b] en 1900 : environ 6 sur 10.
[cadre]Mais beaucoup partent travailler en ville : les villes grandissent, c'est l'[b]urbanisation[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Début du XIXe siècle : la [b]locomotive[/b] (Stephenson). Le charbon, puis l'électricité et le pétrole.
• Fin du XIXe siècle : le [b]vaccin contre la rage[/b] (Pasteur, 1885).
• Les ouvriers travaillent dur ; les bourgeois vivent dans l'aisance.
• [b]Droit de grève[/b] (1864) et [b]liberté syndicale[/b] (1884).
• La France reste surtout rurale, mais les villes grandissent.[/cadre]""",
])

# =====================================================================  HISTOIRE 4
add('premiere_guerre', 'La Première Guerre mondiale (1914-1918)', 'histoire', [
f"""[titre]Une guerre mondiale[/titre]
{tableau(2, ['les [b]Alliés[/b]', 'la France, le Royaume-Uni, la Russie,\npuis l\'Italie et les États-Unis', 'en face', 'l\'Allemagne, l\'Autriche-Hongrie,\nl\'Empire ottoman'], size=20, lignes=True)}
[cadre]La guerre commence en août [b]1914[/b] et se termine en [b]1918[/b]. Des pays du monde entier y participent.[/cadre]""",
"""[titre]Le front en France[/titre]
[carte vue=france front=oui largeur=400]""",
f"""[titre]Mouvement puis position[/titre]
{tableau(2, ['la [b]guerre de mouvement[/b]', 'en 1914, les armées avancent et reculent ;\nles Allemands sont arrêtés sur la Marne', 'la [b]guerre de position[/b]', 'de 1915 à 1918, les soldats s\'enterrent\ndans des [b]tranchées[/b] face à face'], size=19, lignes=True)}
[cadre]Le front traverse le [b]nord et l'est[/b] de la France, de la mer du Nord à la Suisse.[/cadre]""",
f"""[titre]La vie des poilus[/titre]
{gros('🪖 🌧️ 💣', 50)}
On appelle les soldats français les « [b]poilus[/b] ». Dans les tranchées, ils vivent dans la boue, le froid, avec les rats et les poux.
[cadre]Ils subissent les bombardements, les gaz, et doivent sortir pour attaquer sous les tirs. Leurs lettres à leur famille racontent cette vie terrible.[/cadre]""",
f"""[titre]Verdun, 1916[/titre]
{gros('⚔️', 56)}
La [b]bataille de Verdun[/b] dure presque toute l'année 1916. Les Allemands attaquent, les Français résistent.
[cadre]Elle fait environ 300 000 morts, français et allemands. Elle est devenue le symbole de la souffrance des soldats.[/cadre]""",
f"""[titre]Tout le pays participe[/titre]
{tableau(2, ['👩 les [b]femmes[/b]', 'elles remplacent les hommes aux champs,\ndans les usines d\'armes, soignent les blessés', '🏭 les usines', 'fabriquent des obus, des canons, des avions', '🌍 les colonies', 'envoient des soldats et des travailleurs', '📰 les journaux, les affiches', 'encouragent la population à soutenir l\'effort'], size=18, lignes=True)}""",
f"""[titre]11 novembre 1918 : l'armistice[/titre]
{gros('🕊️ 🔔', 50)}
Le [b]11 novembre 1918[/b], l'Allemagne signe l'[b]armistice[/b] : les combats s'arrêtent. Les cloches sonnent dans toute la France.
[cadre]Un [b]armistice[/b] est un accord pour arrêter les combats. Le 11 novembre est aujourd'hui un jour férié, où l'on se souvient des morts.[/cadre]""",
f"""[titre]Le bilan de la guerre[/titre]
{tableau(2, ['10 millions', 'de soldats morts au combat', 'dont 1,4 million', 'de Français'], size=22, lignes=True)}
[cadre]Des millions de blessés reviennent mutilés, comme les « gueules cassées ». Dans chaque commune, un [b]monument aux morts[/b] rappelle les noms des soldats tués.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]1914-1918[/b] : la Première Guerre mondiale.
• Guerre de mouvement, puis guerre de position dans les tranchées du nord et de l'est de la France.
• Les poilus vivent dans des conditions terribles. [b]Verdun[/b], 1916.
• Les femmes, les usines et les colonies participent à l'effort de guerre.
• [b]11 novembre 1918[/b] : l'armistice. 10 millions de soldats morts, dont 1,4 million de Français.[/cadre]""",
])

# =====================================================================  HISTOIRE 5
add('seconde_guerre', 'La France dans la Seconde Guerre mondiale (1939-1945)', 'histoire', [
f"""[titre]La guerre commence[/titre]
{gros('⚠️', 56)}
En Allemagne, [b]Hitler[/b] et le parti nazi sont au pouvoir. Le [b]nazisme[/b] est une idéologie raciste qui veut dominer l'Europe.
[cadre]En septembre [b]1939[/b], l'Allemagne envahit la Pologne : la France et le Royaume-Uni lui déclarent la guerre. Pendant 8 mois, il n'y a presque pas de combats : c'est la « [b]drôle de guerre[/b] ».[/cadre]""",
f"""[titre]Juin 1940 : la défaite[/titre]
{gros('🏳️', 56)}
En mai 1940, l'armée allemande attaque. En quelques semaines, la France est battue. Le maréchal [b]Pétain[/b] signe l'armistice avec l'Allemagne.
[cadre]Le [b]18 juin 1940[/b], depuis Londres, le [b]général de Gaulle[/b] lance un appel à la radio : il demande aux Français de continuer le combat.[/cadre]""",
"""[titre]Une France coupée en deux[/titre]
[carte vue=france occupation=oui largeur=400]""",
f"""[titre]Occupation et collaboration[/titre]
{tableau(2, ['la [b]zone occupée[/b]', 'le nord et l\'ouest, occupés\npar l\'armée allemande', 'la [b]zone libre[/b]', 'le sud, gouverné depuis Vichy\npar Pétain ; occupée à son tour en 1942', 'le [b]régime de Vichy[/b]', 'Pétain supprime la République\net gouverne seul'], size=19, lignes=True)}
[cadre]Le régime de Vichy choisit la [b]collaboration[/b] : il aide l'Allemagne nazie.[/cadre]""",
f"""[titre]La vie sous l'Occupation[/titre]
{gros('🎫 🥖 🌙', 50)}
La nourriture, le charbon et les vêtements manquent : ils sont [b]rationnés[/b] avec des tickets. On fait la queue pendant des heures.
[cadre]Il y a un couvre-feu le soir. Les journaux et la radio sont contrôlés. Des centaines de milliers de jeunes sont envoyés travailler de force en Allemagne.[/cadre]""",
f"""[titre]La persécution des Juifs[/titre]
{gros('✡️', 56)}
Le régime de Vichy mène une politique [b]antisémite[/b] : dès 1940, les Juifs sont exclus de nombreux métiers. En zone occupée, ils doivent porter une étoile jaune à partir de 1942.
[cadre]Les [b]16 et 17 juillet 1942[/b], la police française arrête à Paris environ 13 000 Juifs, dont plus de 4 000 enfants : c'est la [b]rafle du Vel d'Hiv'[/b]. Ils sont déportés vers les camps nazis.[/cadre]""",
f"""[titre]L'extermination des Juifs[/titre]
{gros('🕯️', 56)}
Les nazis organisent l'extermination des Juifs d'Europe dans des camps, comme [b]Auschwitz[/b]. [b]6 millions de Juifs[/b] sont assassinés, 60 % des Juifs d'Europe.
[cadre]En France, environ 75 000 Juifs sont déportés ; très peu reviennent. Les Tsiganes sont aussi persécutés et enfermés dans des camps.[/cadre]""",
f"""[titre]Les Justes parmi les Nations[/titre]
{gros('🤝 🏡', 50)}
Des Français ont caché et sauvé des Juifs, en risquant leur vie. On les appelle les « [b]Justes parmi les Nations[/b] ».
[cadre]Au [b]Chambon-sur-Lignon[/b], en Haute-Loire, les habitants ont caché des milliers de personnes, surtout des enfants. Plus de 4 000 Français ont reçu le titre de Juste.[/cadre]""",
f"""[titre]La Résistance[/titre]
{tableau(2, ['agir en secret', 'journaux clandestins, renseignements,\nsabotages de trains et d\'usines', 'les [b]maquis[/b]', 'des groupes de résistants cachés\ndans les forêts et les montagnes', '[b]Jean Moulin[/b]', 'envoyé par de Gaulle, il unit les mouvements\nde Résistance ; arrêté, il meurt en 1943'], size=19, lignes=True)}
[cadre]Des femmes, comme Lucie Aubrac, jouent un grand rôle dans la Résistance.[/cadre]""",
f"""[titre]La Libération[/titre]
{tableau(2, ['[b]6 juin 1944[/b]', 'les Alliés (Américains, Britanniques,\nCanadiens…) débarquent en Normandie', 'août 1944', 'débarquement en Provence ;\nParis est libéré le 25 août', '[b]8 mai 1945[/b]', 'l\'Allemagne nazie capitule :\nla guerre est finie en Europe'], size=19, lignes=True)}""",
f"""[titre]Le bilan[/titre]
{tableau(2, ['60 à 70 millions', 'de morts dans le monde,\nplus de civils que de soldats', '6 millions', 'de Juifs assassinés'], size=21, lignes=True)}
[cadre]C'est la guerre la plus meurtrière de l'histoire. Après elle, les pays veulent construire une paix durable.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]1939-1945[/b] : la Seconde Guerre mondiale. Drôle de guerre, puis défaite de juin 1940.
• [b]18 juin 1940[/b] : appel du général de Gaulle.
• Occupation, collaboration du régime de Vichy (Pétain), Résistance (Jean Moulin).
• [b]1942[/b] : rafle du Vel d'Hiv'. 6 millions de Juifs exterminés.
• [b]6 juin 1944[/b] : débarquement en Normandie. [b]8 mai 1945[/b] : capitulation de l'Allemagne nazie.[/cadre]""",
])

# =====================================================================  HISTOIRE 6
add('france_depuis_1945', 'La France depuis 1945', 'histoire', [
f"""[titre]Une République démocratique et sociale[/titre]
{tableau(2, ['[b]1944[/b]', 'les femmes obtiennent le [b]droit de vote[/b]', '1945', 'création de la [b]Sécurité sociale[/b] :\non est aidé quand on est malade ou âgé', '1946', 'la Constitution affirme des droits sociaux\n(travail, santé, éducation)'], size=19, lignes=True)}""",
f"""[titre]1958 : la Ve République[/titre]
[center]{drapeau('fr', 44)} [font_size=50]📜[/font_size][/center]
En [b]1958[/b], une nouvelle Constitution fonde la [b]Ve République[/b], voulue par le [b]général de Gaulle[/b], qui devient président.
[cadre]Depuis 1962, le président de la République est élu directement par tous les citoyens. Nous vivons toujours sous la Ve République.[/cadre]""",
f"""[titre]Des droits pour les femmes[/titre]
{tableau(2, ['1944', 'le droit de vote', '[b]1965[/b]', 'travailler et ouvrir un compte en banque\nsans l\'autorisation de leur mari', '1972', 'à travail égal, salaire égal'], size=20, lignes=True)}""",
f"""[titre]Une société qui change[/titre]
{tableau(2, ['🚗 les transports', 'la voiture pour tous, le TGV (1981), l\'avion', '🏠 la maison', 'réfrigérateur, machine à laver, télévision', '🏖️ les loisirs', 'des congés payés plus longs, des vacances,\ndu sport', '💻 l\'[b]innovation[/b]', 'ordinateurs, Internet, téléphones portables'], size=19, lignes=True)}
[cadre]On achète de plus en plus de produits : c'est la [b]société de consommation[/b].[/cadre]""",
f"""[titre]La construction européenne[/titre]
{tableau(2, ['[b]1957[/b]', 'le [b]traité de Rome[/b] crée la CEE\n(6 pays, dont la France)', '1992', 'le traité de Maastricht crée\nl\'Union européenne', '2002', 'les pièces et billets en [b]euros[/b]\nremplacent le franc'], size=19, lignes=True)}
[cadre]Après deux guerres terribles, la France et l'Allemagne se réconcilient et construisent l'Europe pour garantir la [b]paix[/b].[/cadre]""",
"""[titre]Les grandes dates[/titre]
[frise points=1944,1945,1957,1958,1965,2002 debut=après_la_guerre fin=aujourd'hui]
[cadre]1944 : vote des femmes • 1945 : Sécurité sociale • 1957 : traité de Rome • 1958 : Ve République • 1965 : nouveaux droits des femmes • 2002 : l'euro.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Depuis 1945, la France connaît la paix et de grandes transformations.
• [b]1944[/b] : droit de vote des femmes. 1945 : Sécurité sociale.
• [b]1958[/b] : fondation de la Ve République avec le général de Gaulle.
• [b]1965[/b] : les Françaises peuvent travailler et ouvrir un compte sans l'autorisation de leur mari.
• [b]1957[/b] : traité de Rome. L'euro remplace le franc.
• La société de consommation, les loisirs et l'innovation changent la vie.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 1
add('territoire_france', 'L\'organisation du territoire français', 'geographie', [
f"""[titre]Communes, départements, régions[/titre]
{tableau(3, ['🏘️ la [b]commune[/b]', 'environ 35 000', 'dirigée par le maire', '🗺️ le [b]département[/b]', '101', 'le conseil départemental', '🌍 la [b]région[/b]', '18', 'le conseil régional'], entete=['', 'combien ?', 'qui décide ?'], size=19)}
[cadre]La France est découpée en territoires emboîtés : une commune est dans un département, qui est dans une région.[/cadre]""",
"""[titre]Les régions de métropole[/titre]
[carte vue=france regions=oui largeur=420]""",
f"""[titre]Les 13 régions de métropole[/titre]
{tableau(2, ['Hauts-de-France', 'Lille', 'Normandie', 'Rouen', 'Île-de-France', 'Paris', 'Grand Est', 'Strasbourg', 'Bretagne', 'Rennes', 'Pays de la Loire', 'Nantes', 'Centre-Val de Loire', 'Orléans', 'Bourgogne-Franche-Comté', 'Dijon', 'Nouvelle-Aquitaine', 'Bordeaux', 'Auvergne-Rhône-Alpes', 'Lyon', 'Occitanie', 'Toulouse', 'Provence-Alpes-Côte d\'Azur', 'Marseille', 'Corse', 'Ajaccio'], entete=['région', 'capitale'], size=15, paires=True)}""",
f"""[titre]Les 5 régions d'outre-mer[/titre]
{tableau(2, ['la [b]Guadeloupe[/b]', 'Basse-Terre', 'la [b]Martinique[/b]', 'Fort-de-France', 'la [b]Guyane[/b]', 'Cayenne', '[b]La Réunion[/b]', 'Saint-Denis', '[b]Mayotte[/b]', 'Mamoudzou'], entete=['région', 'capitale'], size=20, paires=True)}
[cadre]13 régions en métropole + 5 en outre-mer = [b]18 régions[/b].[/cadre]""",
f"""[titre]Mon département[/titre]
{gros('📮', 56)}
Chaque département a un nom et un numéro. Les deux premiers chiffres du code postal donnent souvent le numéro du département.
[cadre=astuce]75 = Paris, 13 = Bouches-du-Rhône, 69 = Rhône, 59 = Nord. Et toi, dans quel département vis-tu ?[/cadre]""",
"""[titre]Les grands axes de transport[/titre]
[carte vue=france tgv=oui villes=oui largeur=400]""",
f"""[titre]Routes et voies ferrées[/titre]
{tableau(2, ['🚆 le [b]TGV[/b]', 'train à grande vitesse (plus de 300 km/h)\ndepuis 1981 ; les lignes partent de Paris', '🛣️ les [b]autoroutes[/b]', 'Paris-Lille, Paris-Lyon-Marseille\n(l\'autoroute du Soleil), Paris-Bordeaux…'], size=19, lignes=True)}
[cadre]Les grands axes forment une [b]étoile[/b] autour de Paris et relient les grandes agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.[/cadre]""",
f"""[titre]Deux régions à comparer[/titre]
{tableau(2, ['la région la plus peuplée :\nplus de 12 millions d\'habitants', 'des grandes villes (Lyon, Grenoble)\net des montagnes (Alpes, Massif central)', 'la capitale, des sièges d\'entreprises,\nde grands aéroports', 'de l\'industrie, des stations de ski,\nde l\'agriculture'], entete=['Île-de-France', 'Auvergne-Rhône-Alpes'], size=18)}
[cadre=astuce]Et ta région ? Cherche sa capitale, ses grandes villes et ses paysages.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• La France est organisée en [b]communes[/b], [b]départements[/b] (101) et [b]régions[/b] (18 : 13 en métropole, 5 en outre-mer).
• Les 5 premières agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.
• Les autoroutes et les lignes de [b]TGV[/b] forment une étoile autour de Paris.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 2
add('eau_douce', 'Les usages de l\'eau douce en France', 'geographie', [
f"""[titre]Une ressource limitée[/titre]
{tableau(2, ['💧 eau salée', 'presque toute l\'eau de la Terre :\nles mers et les océans', '🧊 eau douce', 'environ 3 % seulement,\nsurtout gelée dans les glaciers'], size=20, lignes=True)}
[cadre]L'eau douce que l'on peut utiliser est très rare : il faut l'économiser et la protéger.[/cadre]""",
f"""[titre]Où trouve-t-on l'eau douce ?[/titre]
{tableau(2, ['🏞️ les fleuves et les rivières', '🌊 les lacs', '🏔️ les glaciers et la neige des montagnes', '🪨 les [b]nappes phréatiques[/b]'], size=20, paires=True)}
[cadre]Une [b]nappe phréatique[/b] est de l'eau de pluie stockée sous la terre, dans les roches. On la pompe pour avoir de l'eau potable.[/cadre]""",
"""[titre]Fleuves et lacs[/titre]
[carte vue=france fleuves=oui lacs=oui largeur=420]""",
f"""[titre]Fleuves et lacs à connaître[/titre]
{tableau(2, ['les fleuves', 'Loire, Seine, Garonne, Rhône, Rhin\n(et le Maroni en Guyane)', 'les massifs', 'Alpes, Pyrénées, Massif central, Jura,\nVosges, Corse : de là partent les cours d\'eau', 'le [b]lac du Bourget[/b]', 'le plus grand lac [b]naturel[/b]\nentièrement français', 'le [b]lac de Serre-Ponçon[/b]', 'un lac [b]artificiel[/b], créé\npar un barrage sur la Durance'], size=18, lignes=True)}""",
f"""[titre]À quoi sert l'eau ?[/titre]
{tableau(2, ['🚰 boire, se laver', 'chaque Français utilise environ\n150 litres d\'eau par jour', '🌽 l\'agriculture', 'arroser les champs (l\'irrigation) :\nc\'est elle qui consomme le plus', '🏭 l\'industrie', 'fabriquer et refroidir', '⚡ l\'électricité', 'les barrages ; refroidir les centrales', '⛵ les loisirs, le transport', 'baignade, bateaux, péniches'], size=18, lignes=True)}""",
f"""[titre]Une eau menacée[/titre]
{gros('☀️ 🏜️ 🧪', 50)}
Pendant les [b]sécheresses[/b], les rivières et les nappes baissent : les préfets limitent alors l'usage de l'eau (arrosage interdit…).
[cadre]L'eau peut aussi être [b]polluée[/b] par les engrais, les pesticides, les usines. On la nettoie dans des stations d'épuration avant de la rendre à la nature.[/cadre]""",
f"""[titre]Les conflits d'usages[/titre]
{gros('⚡ 🌾 🏊', 50)}
Le lac de [b]Serre-Ponçon[/b] sert à produire de l'électricité, à arroser les cultures de Provence, à fournir de l'eau potable et à accueillir les touristes.
[cadre]Quand il fait sec, il n'y a pas assez d'eau pour tout le monde : chacun veut l'utiliser pour son activité. C'est un [b]conflit d'usages[/b]. Il faut alors partager l'eau.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• L'eau douce est une ressource [b]limitée[/b] : fleuves, lacs, glaciers, [b]nappes phréatiques[/b].
• On l'utilise pour boire, l'agriculture, l'industrie, l'électricité, les loisirs.
• Sécheresses et pollution la menacent.
• Plusieurs activités veulent la même eau : ce sont des [b]conflits d'usages[/b].
• Lac naturel : le lac du Bourget. Lac artificiel : Serre-Ponçon.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 3
add('union_europeenne', 'L\'Union européenne', 'geographie', [
f"""[titre]Europe et Union européenne[/titre]
{tableau(2, ['l\'[b]Europe[/b]', 'un [b]continent[/b] : de l\'océan Atlantique\naux monts Oural, environ 50 pays', 'l\'[b]Union européenne[/b] (UE)', 'une [b]union de pays[/b] qui ont choisi\nde travailler ensemble : 27 pays'], size=19, lignes=True)}
[cadre]Tous les pays d'Europe ne sont pas dans l'UE : par exemple la Suisse, la Norvège ou le Royaume-Uni, qui l'a quittée en 2020.[/cadre]""",
"""[titre]Les 27 pays de l'UE[/titre]
[carte vue=europe fondateurs=oui noms=oui largeur=380]""",
f"""[titre]Les 6 pays fondateurs[/titre]
{tableau(2, [drapeau('fr') + ' la France', drapeau('de') + ' l\'Allemagne', drapeau('it') + ' l\'Italie', drapeau('be') + ' la Belgique', drapeau('nl') + ' les Pays-Bas', drapeau('lu') + ' le Luxembourg'], size=21, paires=True)}
[cadre]En [b]1957[/b], ces 6 pays signent le [b]traité de Rome[/b] : ils créent la Communauté économique européenne. D'autres pays les rejoignent ensuite : l'Espagne, le Portugal, la Pologne, la Suède, la Grèce, l'Irlande…[/cadre]""",
f"""[titre]De la CEE à l'UE[/titre]
{tableau(2, ['[b]1957[/b]', 'traité de Rome : 6 pays', '[b]1992[/b]', '[b]traité de Maastricht[/b] :\nnaissance de l\'Union européenne', '2002', 'les pièces et billets en euros', '2020', 'le Royaume-Uni quitte l\'UE'], size=20, lignes=True)}""",
f"""[titre]Ce que l'UE apporte[/titre]
{tableau(2, ['🕊️ la paix', 'entre des pays autrefois en guerre', '🚶 la libre circulation', 'voyager, étudier, travailler\ndans les autres pays', '💶 l\'[b]euro[/b]', 'une monnaie commune\nà plus de 20 pays', '🏗️ des aides', 'pour construire des routes, des tramways,\nrénover des écoles…'], size=19, lignes=True)}""",
f"""[titre]Les symboles de l'UE[/titre]
{tableau(2, ['le drapeau', '12 étoiles d\'or sur fond bleu', 'l\'hymne', 'l\'« Ode à la joie » de Beethoven', 'la devise', '« Unie dans la diversité »', 'la fête', 'le 9 mai, journée de l\'Europe'], size=20, lignes=True)}
[cadre=astuce]Cherche près de ton école un panneau « projet financé par l'Union européenne » : c'est un aménagement aidé par l'UE.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• L'[b]Europe[/b] est un continent ; l'[b]Union européenne[/b] est une union de 27 pays.
• [b]1957[/b] : traité de Rome (6 pays fondateurs : France, Allemagne, Italie, Belgique, Pays-Bas, Luxembourg).
• [b]1992[/b] : traité de Maastricht, naissance de l'UE.
• L'UE apporte la paix, la libre circulation, l'euro et des aides pour des aménagements.[/cadre]""",
])

if __name__ == '__main__':
    sortie(FICHES, CL, sys.argv[1] if len(sys.argv) > 1 else '.', sys.argv[2] if len(sys.argv) > 2 else None,
           'Toutes les fiches de cours Histoire et Geographie CM2 (2026-11-07)')
