# Fiches de cours Histoire et Geographie CM1 (2026-11-07), programme du BO n° 22 du 28 mai 2026
# (cycle 3). Histoire : 4 themes ; Geographie « la diversite des modes de vie dans le monde » : 4 themes.
# Au CM1 et au CM2, Histoire et Geographie sont deux matieres separees (decision de Steve, 2026-11-06) :
# matiere = 'histoire' ou 'geographie'.
# Sorties : server/fiches/cm1_<hist|geo>_<code>.sql, cm1_histgeo_toutes.sql, un .txt par fiche (rendu).
import os
import re
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt
from gen_cp_histgeo import emo, gros, SQL

CL = 'cm1'
FICHES = []


def add(code, titre, domaine, pages):
    FICHES.append((CL, code, titre, domaine, [couleur_alt(CL, p) for p in pages]))


def sortie(fiches, cl, out, txt, entete):
    toutes = [f'-- {entete}, une seule transaction.', 'begin;']
    for c, code, titre, domaine, pages in fiches:
        contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
        contenu = re.sub(r'(\d) (\d{3})', '\\1\u00a0\\2', contenu)   # 13 000 : pas de retour a la ligne
        sql = SQL.replace("'cp'", f"'{c}'").replace('(CP)', f'({c.upper()})').format(
            titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu, domaine=domaine,
            matiere=domaine)
        court = 'hist' if domaine == 'histoire' else 'geo'
        with open(os.path.join(out, f'{c}_{court}_{code}.sql'), 'w', encoding='utf-8') as f:
            f.write(sql)
        toutes.append(sql)
        if txt:
            with open(os.path.join(txt, f'{code}.txt'), 'w', encoding='utf-8') as f:
                f.write(contenu)
        print(code, titre, len(pages), 'p.')
    toutes += ['commit;', 'select fn_publier();']
    with open(os.path.join(out, f'{cl}_histgeo_toutes.sql'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(toutes) + '\n')
    # Au CM1/CM2, Histoire et Geographie sont 2 matieres distinctes (pools de questions separes) :
    # un script par matiere en plus du script global.
    for dom in ('histoire', 'geographie'):
        part = [t for t in toutes[2:-2] if f"- {dom}, notion" in t.split('\n')[0]]
        with open(os.path.join(out, f'{cl}_{dom}_toutes.sql'), 'w', encoding='utf-8') as f:
            f.write('\n'.join([f'-- {entete} : {dom} seulement, une seule transaction.', 'begin;'] + part
                               + ['commit;', 'select fn_publier();']) + '\n')
    print(len(fiches), 'fiches')


# =====================================================================  HISTOIRE 1
add('vie_moyen_age', 'La vie quotidienne au Moyen Âge', 'histoire', [
"""[titre]Le Moyen Âge[/titre]
[periodes marque=3]
Le Moyen Âge dure environ 1 000 ans, de [b]476[/b] à [b]1492[/b]. On étudie ici les [b]XIe, XIIe et XIIIe siècles[/b] (de l'an 1001 à l'an 1300).
[cadre]À cette époque, presque tout le monde vit à la campagne. La vie est organisée par deux cadres : la [b]seigneurie[/b] et la [b]paroisse[/b].[/cadre]""",
f"""[titre]La seigneurie[/titre]
{gros('🏰 🌾 🏘️', 50)}
Une [b]seigneurie[/b], c'est un territoire dominé par un [b]seigneur[/b] : ses terres et les gens qui y vivent.
{tableau(2, ['le [b]château[/b]', 'où vit le seigneur', 'la [b]réserve[/b]', 'les terres que le seigneur garde pour lui', 'les [b]tenures[/b]', 'les terres que le seigneur prête aux paysans', 'le moulin, le four', 'appartiennent au seigneur'], size=19, lignes=True)}""",
f"""[titre]Le château fort[/titre]
{tableau(2, ['🛡️ un [b]lieu de protection[/b]', 'remparts, tours, fossés, pont-levis :\nles habitants s\'y réfugient en cas d\'attaque', '🍖 un [b]lieu de vie[/b]', 'le seigneur y vit avec sa famille,\nses chevaliers et ses serviteurs', '👑 un [b]symbole de puissance[/b]', 'visible de loin, il montre la force\ndu seigneur'], size=19, lignes=True)}
[cadre=astuce]Le [b]donjon[/b] est la plus haute tour du château, la plus solide.[/cadre]""",
f"""[titre]La vie du seigneur[/titre]
{gros('⚔️ 🐎 🦌', 50)}
Le seigneur est un [b]chevalier[/b] : il s'entraîne au combat, fait la guerre, participe à des tournois et chasse dans ses forêts.
[cadre]Il protège les habitants de sa seigneurie, mais il les commande aussi : il rend la [b]justice[/b] et leur fait payer des taxes.[/cadre]""",
f"""[titre]Les obligations des paysans[/titre]
{tableau(2, ['la [b]corvée[/b]', 'travailler gratuitement quelques jours\nsur les terres du seigneur', 'les [b]taxes[/b]', 'donner au seigneur une partie des récoltes\nou de l\'argent', 'les [b]banalités[/b]', 'payer pour utiliser le moulin, le four\nou le pressoir du seigneur', 'la [b]dîme[/b]', 'donner à l\'Église environ 1/10\nde ses récoltes'], size=19, lignes=True)}
[cadre]Certains paysans, les [b]serfs[/b], ne sont pas libres : ils ne peuvent pas quitter la seigneurie.[/cadre]""",
f"""[titre]L'année des paysans[/titre]
{tableau(2, ['❄️ hiver', 'réparer les outils, couper le bois, tuer le cochon', '🌱 printemps', 'labourer et semer', '☀️ été', 'faucher le foin, puis la [b]moisson[/b] (couper les blés)', '🍂 automne', 'les [b]vendanges[/b], semer le blé d\'hiver,\nmener les cochons manger les glands en forêt'], size=19, lignes=True)}
[cadre]Les paysannes et les paysans travaillent dur du lever au coucher du soleil. Ils vivent dans des maisons simples en bois et en torchis.[/cadre]""",
f"""[titre]La paroisse[/titre]
{gros('⛪ 🔔', 50)}
La [b]paroisse[/b] est le territoire qui dépend d'une même église, avec son [b]curé[/b].
[cadre]L'Église accompagne la vie de chacun, de la naissance à la mort : le [b]baptême[/b], le [b]mariage[/b], l'enterrement au cimetière. Les cloches rythment la journée ; le dimanche et les jours de fête, on ne travaille pas.[/cadre]""",
f"""[titre]Le clergé et les abbayes[/titre]
{tableau(2, ['le [b]clergé[/b]', 'les hommes et les femmes au service de Dieu :\nprêtres, évêques, moines, religieuses', 'une [b]abbaye[/b]', 'un monastère où vivent des moines\nou des religieuses : ils prient et travaillent'], size=19, lignes=True)}
[cadre=astuce]L'abbaye de [b]Cluny[/b], en Bourgogne, fondée en 910, est l'une des plus puissantes d'Europe.[/cadre]""",
f"""[titre]Le rôle de l'Église[/titre]
{tableau(2, ['🙏 prier', 'les messes, les fêtes religieuses, les pèlerinages', '🛏️ soigner', 'les malades sont accueillis à l\'[b]Hôtel-Dieu[/b]', '🍞 aider', 'on donne à manger aux pauvres', '📖 enseigner', 'les moines apprennent à lire et à écrire ;\nils recopient les livres à la main'], size=19, lignes=True)}""",
f"""[titre]Art roman et art gothique[/titre]
{tableau(2, ['XIe - XIIe siècles', 'à partir du XIIe siècle', 'murs épais, petites fenêtres', 'murs plus fins, grandes fenêtres\navec des [b]vitraux[/b]', 'arcs arrondis', 'arcs brisés (pointus)', 'église plutôt sombre', 'église haute et lumineuse,\ntenue par des arcs-boutants'], entete=['l\'art roman', 'l\'art gothique'], size=19)}
[cadre=astuce][b]Notre-Dame de Paris[/b] est une cathédrale gothique. Une [b]cathédrale[/b] est l'église d'un évêque.[/cadre]""",
f"""[titre]La vie en ville[/titre]
{gros('🧱 🛒 🔨', 50)}
Aux XIIe et XIIIe siècles, les villes grandissent. Elles sont entourées de [b]remparts[/b], avec des rues étroites.
[cadre]Les [b]artisans[/b] (boulangers, forgerons, tisserands…) travaillent dans leur atelier, regroupés par métier. Les [b]marchands[/b] vendent au [b]marché[/b] chaque semaine, et aux grandes [b]foires[/b], comme celles de Champagne, où viennent des marchands de toute l'Europe.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Du XIe au XIIIe siècle, la vie est organisée par la [b]seigneurie[/b] et la [b]paroisse[/b].
• Le château protège, sert de logement et montre la puissance du seigneur.
• Les paysans doivent la [b]corvée[/b], des taxes, les banalités et la [b]dîme[/b].
• L'Église prie, soigne, aide les pauvres et enseigne. Cluny, Notre-Dame de Paris.
• Art [b]roman[/b] : épais et sombre. Art [b]gothique[/b] : haut et lumineux.
• En ville : artisans, marchés et foires.[/cadre]""",
])

# =====================================================================  HISTOIRE 2
add('monarchie_absolue', 'La monarchie en France (XVIe-XVIIe siècles)', 'histoire', [
"""[titre]Trois rois à connaître[/titre]
[frise points=1515,1547,1589,1610,1643,1715 debut=XVIe_siècle fin=XVIIe_siècle]
[cadre]• [b]François Ier[/b] : roi de 1515 à 1547.
• [b]Henri IV[/b] : roi de 1589 à 1610.
• [b]Louis XIV[/b] : roi de 1643 à 1715.[/cadre]""",
f"""[titre]La Renaissance[/titre]
{gros('🎨 📚 🏛️', 50)}
Au XVIe siècle, des artistes et des savants redécouvrent les œuvres de l'Antiquité. C'est la [b]Renaissance[/b] : elle commence en Italie.
[cadre]Grâce à l'[b]imprimerie[/b], inventée vers 1450 par Gutenberg, les livres et les idées circulent beaucoup plus vite.[/cadre]""",
f"""[titre]François Ier, roi mécène[/titre]
{gros('👑 🎨', 50)}
[b]François Ier[/b] est un [b]mécène[/b] : il protège et paie des artistes.
[cadre]Il invite en France le grand artiste italien [b]Léonard de Vinci[/b], qui s'installe près d'Amboise, au Clos Lucé, et y meurt en [b]1519[/b]. Léonard apporte avec lui la [b]Joconde[/b], aujourd'hui au musée du Louvre.[/cadre]
[cadre=astuce]François Ier fait construire le château de [b]Chambord[/b], et impose le français dans les actes officiels (1539).[/cadre]""",
f"""[titre]Les guerres de religion[/titre]
{tableau(2, ['les [b]catholiques[/b]', 'ils obéissent au pape', 'les [b]protestants[/b]', 'des chrétiens qui ont quitté l\'Église catholique\nau XVIe siècle'], size=20, lignes=True)}
[cadre]De 1562 à 1598, catholiques et protestants s'affrontent en France : ce sont les [b]guerres de religion[/b]. En 1572, des milliers de protestants sont tués lors du massacre de la Saint-Barthélemy.[/cadre]""",
f"""[titre]Henri IV, roi pacificateur[/titre]
{gros('🕊️ 📜', 50)}
[b]Henri IV[/b] est protestant. Pour être accepté comme roi par tous, il devient catholique en 1593.
[cadre]En [b]1598[/b], il signe l'[b]édit de Nantes[/b] : les protestants peuvent pratiquer leur religion dans certains lieux et ont les mêmes droits que les catholiques. La paix revient. Henri IV est assassiné en 1610.[/cadre]""",
f"""[titre]Louis XIV, le Roi-Soleil[/titre]
{gros('☀️ 👑', 50)}
[b]Louis XIV[/b] devient roi à 4 ans et règne [b]72 ans[/b], de [b]1643 à 1715[/b]. Il a choisi le Soleil comme emblème.
[cadre]Il gouverne seul et a tous les pouvoirs : il fait les lois, rend la justice, commande l'armée, décide des impôts. C'est la [b]monarchie absolue[/b]. Il pense tenir son pouvoir de Dieu.[/cadre]""",
f"""[titre]Le château de Versailles[/titre]
{gros('🏰 ⛲ 🌳', 50)}
Louis XIV fait de [b]Versailles[/b] un immense château, avec la galerie des Glaces et des jardins magnifiques. Il s'y installe avec la [b]Cour[/b] en 1682.
[cadre]Versailles montre la puissance du roi. Les nobles vivent près de lui et le servent à chaque moment de la journée, de son lever à son coucher : ainsi, il les surveille.[/cadre]""",
f"""[titre]Les femmes à la Cour[/titre]
{tableau(2, ['la [b]reine[/b] et les princesses', 'elles participent aux fêtes\net aux cérémonies de la Cour', 'les [b]dames d\'honneur[/b]', 'elles servent la reine et organisent la vie\nde la Cour', '[b]Madame de Maintenon[/b]', 'épouse du roi en secret, elle fonde à Saint-Cyr\nune école pour les jeunes filles nobles', '[b]Madame de Sévigné[/b]', 'elle raconte la vie de la Cour\ndans ses lettres'], size=18, lignes=True)}""",
f"""[titre]La société d'ordres[/titre]
{tableau(2, ['⛪ le [b]clergé[/b]', 'ceux qui prient', '⚔️ la [b]noblesse[/b]', 'ceux qui combattent', '🌾 le [b]tiers état[/b]', 'ceux qui travaillent : paysans, artisans,\nmarchands, bourgeois'], size=20, lignes=True)}
[cadre]Le clergé et la noblesse ont des [b]privilèges[/b] : ils ne paient pas certains impôts. Le tiers état, c'est presque toute la population ; la plupart sont des [b]paysans[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]François Ier[/b] (1515-1547) : roi mécène de la Renaissance, il accueille Léonard de Vinci (mort en France en 1519).
• [b]Henri IV[/b] (1589-1610) ramène la paix : [b]1598, édit de Nantes[/b].
• [b]Louis XIV[/b] (1643-1715) : la monarchie absolue, Versailles.
• La société est divisée en 3 ordres : clergé, noblesse, tiers état.[/cadre]""",
])

# =====================================================================  HISTOIRE 3
add('explorations', 'Explorations et conquêtes (XVe-XVIIe siècles)', 'histoire', [
f"""[titre]Pourquoi partir ?[/titre]
{gros('🧭 ⛵ 🌶️', 50)}
Au XVe siècle, les Européens veulent atteindre l'[b]Asie[/b] par la mer pour rapporter des [b]épices[/b] (poivre, cannelle), de la soie et de l'or.
[cadre]Ils sont aussi poussés par la curiosité, le désir de devenir riches et puissants, et la volonté de répandre la religion chrétienne.[/cadre]""",
f"""[titre]Les inventions pour naviguer[/titre]
{tableau(2, ['⛵ la [b]caravelle[/b]', 'un navire léger et rapide,\nqui avance même contre le vent', '🧭 la [b]boussole[/b]', 'son aiguille montre toujours le nord', '✨ l\'[b]astrolabe[/b]', 'il mesure la hauteur des étoiles\npour savoir où l\'on est', '🗺️ les [b]cartes[/b]', 'de plus en plus précises'], size=19, lignes=True)}""",
f"""[titre]Christophe Colomb[/titre]
{gros('⛵ 🏝️', 50)}
En [b]1492[/b], [b]Christophe Colomb[/b], payé par les rois d'Espagne, traverse l'océan Atlantique vers l'ouest pour rejoindre l'Asie. Il débarque sur une île des Bahamas : il vient d'arriver en [b]Amérique[/b] sans le savoir.
[cadre]Il croit être aux Indes : c'est pour cela qu'on a appelé « Indiens » les habitants de l'Amérique. On dit aujourd'hui les [b]Amérindiens[/b].[/cadre]""",
"""[titre]Le premier tour du monde[/titre]
[planisphere pale=oui voyages=oui largeur=700]
[cadre]De [b]1519 à 1522[/b], l'expédition de [b]Magellan[/b] fait le premier tour du monde. Magellan meurt en route ; un seul des 5 navires revient.[/cadre]""",
f"""[titre]La conquête de l'Amérique[/titre]
{gros('⚔️ 🐎', 50)}
Les [b]conquistadors[/b] espagnols, avec des chevaux et des armes à feu, conquièrent les grands empires amérindiens : les [b]Aztèques[/b] au Mexique, les [b]Incas[/b] au Pérou.
[cadre]Les Amérindiens sont massacrés, forcés de travailler, et surtout tués par des maladies venues d'Europe, comme la variole. La plus grande partie d'entre eux meurt.[/cadre]""",
"""[titre]Les premiers empires coloniaux[/titre]
[planisphere pale=oui empires=oui cadre=-125,-58,-25,62 largeur=400]""",
f"""[titre]Des empires en Amérique[/titre]
{tableau(2, ['l\'Espagne', 'Amérique centrale, une grande partie\nde l\'Amérique du Sud', 'le Portugal', 'le Brésil', 'la France', 'la Nouvelle-France (Canada) et des îles\ndes Antilles', 'l\'Angleterre', 'la côte est de l\'Amérique du Nord'], size=19, lignes=True)}
[cadre=astuce]Un [b]empire colonial[/b] : des territoires lointains, les [b]colonies[/b], conquis et dirigés par un pays d'Europe.[/cadre]""",
"""[titre]La traite des esclaves[/titre]
[planisphere pale=oui triangulaire=oui cadre=-100,-12,25,58 largeur=600]
[cadre]C'est le [b]commerce triangulaire[/b]. Des millions d'Africains sont vendus comme [b]esclaves[/b] et emmenés de force en Amérique : c'est la [b]traite[/b].[/cadre]""",
f"""[titre]La vie dans les plantations[/titre]
{gros('🌿 ⛓️', 50)}
Dans les colonies d'Amérique, les esclaves travaillent dans d'immenses [b]plantations[/b] de canne à sucre, de café, de coton ou de tabac.
[cadre]Ils travaillent du matin au soir, sans salaire et sans liberté. Ils sont punis très durement. Les enfants d'esclaves naissent esclaves. Certains résistent : ils s'enfuient ou se révoltent.[/cadre]""",
f"""[titre]Le « Code noir »[/titre]
{gros('📜', 56)}
En [b]1685[/b], Louis XIV signe un édit appelé « [b]Code noir[/b] ». Il fixe les règles de l'[b]esclavage[/b] dans les colonies françaises.
[cadre]Ce texte considère les esclaves comme des [b]biens[/b] qui appartiennent à leur maître, comme un objet. Il autorise des punitions terribles.[/cadre]""",
f"""[titre]Les produits venus d'Amérique[/titre]
{tableau(2, ['🍅 la tomate', '🥔 la pomme de terre', '🌽 le maïs', '🫘 le haricot', '🍫 le cacao (chocolat)', '🦃 la dinde'], size=22, paires=True)}
[cadre]Les colonies envoient aussi en Europe du [b]sucre de canne[/b], du café, du coton et du tabac, produits par les esclaves.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Grâce à la caravelle, la boussole, l'astrolabe et les cartes, les Européens explorent le monde.
• [b]1492[/b] : Christophe Colomb arrive en Amérique. [b]1519-1522[/b] : l'expédition de Magellan fait le tour du monde.
• L'Espagne, le Portugal, la France et l'Angleterre créent des empires coloniaux en Amérique.
• Les Amérindiens meurent en grand nombre. Des millions d'Africains sont déportés comme esclaves (traite, commerce triangulaire).
• [b]1685[/b] : le « Code noir ».[/cadre]""",
])

# =====================================================================  HISTOIRE 4
add('revolution_1789', '1789, une année révolutionnaire', 'histoire', [
f"""[titre]Le royaume en 1789[/titre]
{gros('👑 🍞 💸', 50)}
Le roi est [b]Louis XVI[/b], marié à Marie-Antoinette. Le royaume va mal :
[cadre]• Les caisses de l'État sont vides : le roi a besoin d'argent.
• En 1788, les récoltes sont mauvaises : le [b]pain[/b] devient très cher et le peuple a faim.
• Le tiers état paie presque tous les impôts et trouve les privilèges injustes.[/cadre]""",
f"""[titre]Les Lumières[/titre]
{tableau(2, ['[b]Voltaire[/b]', 'il défend la tolérance et dénonce les injustices', '[b]Montesquieu[/b]', 'les pouvoirs doivent être séparés,\npas tous dans les mains du roi', '[b]Rousseau[/b]', 'le pouvoir doit venir du peuple', '[b]Diderot[/b]', 'il dirige l\'[b]Encyclopédie[/b], qui rassemble\ntoutes les connaissances', '[b]Émilie du Châtelet[/b]', 'une savante, qui fait connaître\nles découvertes de Newton'], size=18, lignes=True)}
[cadre]Au XVIIIe siècle, ces philosophes défendent la [b]raison[/b], la [b]liberté[/b] et l'[b]égalité[/b].[/cadre]""",
f"""[titre]Printemps 1789 : les États généraux[/titre]
{gros('📝 🏛️', 50)}
Au printemps 1789, les Français écrivent leurs plaintes et leurs demandes dans des [b]cahiers de doléances[/b].
[cadre]Le 5 mai, le roi réunit à Versailles les [b]États généraux[/b] : des députés du clergé, de la noblesse et du tiers état. En juin, les députés du tiers état se proclament [b]Assemblée nationale[/b] et jurent de donner une [b]constitution[/b] au pays.[/cadre]""",
f"""[titre]14 juillet : la prise de la Bastille[/titre]
{gros('🏰 🔥', 50)}
Le [b]14 juillet 1789[/b], des Parisiens en colère attaquent la [b]Bastille[/b], une forteresse-prison où ils cherchent de la poudre et des armes.
[cadre]La Bastille était le symbole du pouvoir absolu du roi. Sa prise est devenue le symbole de la Révolution : le 14 juillet est aujourd'hui notre fête nationale.[/cadre]""",
f"""[titre]La nuit du 4 août[/titre]
{gros('⚖️', 56)}
Dans les campagnes, les paysans se révoltent contre les seigneurs.
[cadre]Dans la nuit du [b]4 août 1789[/b], les députés votent l'[b]abolition des privilèges[/b] : les droits des seigneurs et la dîme sont supprimés. Tous les Français doivent payer l'impôt. C'est la fin de la société d'ordres.[/cadre]""",
f"""[titre]La Déclaration des droits de l'homme[/titre]
{gros('📜', 56)}
Le [b]26 août 1789[/b], les députés adoptent la [b]Déclaration des droits de l'homme et du citoyen[/b].
[cadre]Article 1 : « Les hommes naissent et demeurent [b]libres[/b] et [b]égaux[/b] en droits. »[/cadre]""",
f"""[titre]Les droits de la Déclaration[/titre]
{tableau(2, ['la [b]liberté[/b]', 'de penser, de parler, d\'écrire, de croire', 'l\'[b]égalité[/b]', 'tous égaux devant la loi et l\'impôt', 'la [b]sûreté[/b]', 'on ne peut pas être arrêté sans raison ;\non est innocent tant qu\'on n\'est pas jugé coupable', 'la [b]souveraineté nationale[/b]', 'le pouvoir vient de la nation,\nplus seulement du roi'], size=19, lignes=True)}""",
f"""[titre]5 et 6 octobre : la marche des femmes[/titre]
{gros('👩 🍞 🏰', 50)}
Les [b]5 et 6 octobre 1789[/b], des milliers de femmes de Paris marchent jusqu'à [b]Versailles[/b] pour réclamer du pain.
[cadre]Elles ramènent le roi et sa famille à Paris. Désormais, le roi vit sous la surveillance du peuple.[/cadre]
[cadre=astuce]Olympe de Gouges écrit pour défendre les droits des femmes : en 1791, elle rédige la Déclaration des droits de la femme et de la citoyenne.[/cadre]""",
"""[titre]Les grandes dates de 1789[/titre]
[frise points=5_mai,20_juin,14_juillet,4_août,26_août,5-6_octobre]
[cadre]5 mai : États généraux • 20 juin : serment de l'Assemblée • 14 juillet : prise de la Bastille • 4 août : abolition des privilèges • 26 août : Déclaration des droits de l'homme • 5-6 octobre : marche des femmes.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• En 1789, le royaume est en crise et les idées des [b]Lumières[/b] se répandent.
• Printemps 1789 : cahiers de doléances et États généraux.
• [b]14 juillet[/b] : prise de la Bastille. [b]Nuit du 4 août[/b] : abolition des privilèges.
• [b]26 août[/b] : Déclaration des droits de l'homme et du citoyen.
• [b]5-6 octobre[/b] : marche des femmes à Versailles.
• C'est la fin de la monarchie absolue et de l'[b]Ancien Régime[/b].[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 1
add('se_nourrir', 'Se nourrir dans le monde', 'geographie', [
f"""[titre]Manger, un besoin vital[/titre]
{gros('🍚 🍞 🌽', 50)}
Partout dans le monde, les humains ont besoin de manger. Mais on ne mange pas la même chose ni la même quantité partout.
[cadre]La [b]ration alimentaire[/b], c'est la quantité de nourriture qu'une personne mange en moyenne chaque jour.[/cadre]""",
f"""[titre]Des façons de manger différentes[/titre]
{tableau(2, ['🍚 le riz', 'en Asie', '🍞 le blé (pain, pâtes)', 'en Europe, au Maghreb', '🌽 le maïs', 'en Amérique', '🥔 le manioc, le mil', 'en Afrique'], size=20, lignes=True)}
[cadre]On mange avec des couverts, des baguettes ou avec la main. Les religions et les traditions influencent aussi ce que l'on mange.[/cadre]""",
f"""[titre]Trop ou pas assez[/titre]
{tableau(2, ['[b]États-Unis[/b] (Amérique)\n[b]France[/b] (Europe)', 'une ration alimentaire [b]très riche[/b]', '[b]Madagascar[/b] (Afrique)\n[b]Haïti[/b] (Amérique)', 'une ration alimentaire [b]insuffisante[/b]'], size=20, lignes=True)}
[cadre]Dans le monde, environ [b]1 personne sur 12[/b] ne mange pas assez.[/cadre]""",
f"""[titre]Sous-nutrition et malnutrition[/titre]
{tableau(2, ['la [b]sous-nutrition[/b]', 'ne pas manger [b]assez[/b] : on a faim', 'la [b]malnutrition[/b]', 'manger [b]mal[/b] : il manque certains aliments,\nou on mange trop gras, trop sucré'], size=20, lignes=True)}
[cadre]La malnutrition existe aussi dans les pays riches : trop de sucre et de gras peut rendre malade.[/cadre]""",
f"""[titre]Pays riche, pays en développement[/titre]
{tableau(2, ['beaucoup de choix, de la viande\net des produits transformés', 'surtout des céréales et des légumes,\npeu de viande', 'on achète au supermarché', 'beaucoup cultivent ce qu\'ils mangent\nou achètent au marché', 'on jette beaucoup de nourriture', 'en cas de sécheresse, la nourriture\npeut manquer'], entete=['dans un pays riche', 'dans un pays en développement'], size=18)}""",
f"""[titre]Produit agricole ou transformé ?[/titre]
{tableau(2, ['🥛 le lait', '🍦 le yaourt', '🌾 le blé', '🥖 le pain, les biscuits', '🍎 la pomme', '🥫 la compote', '🍫 la fève de cacao', '🍫 la tablette de chocolat'], entete=['produit agricole', 'produit transformé'], size=21)}
[cadre]Un [b]produit agricole[/b] sort de la ferme. Un [b]produit transformé[/b] a été fabriqué à partir de lui, souvent dans une usine.[/cadre]""",
f"""[titre]Du pré au frigo : le yaourt[/titre]
{tableau(2, ['1. 🐄 la ferme', 'l\'éleveur trait les vaches', '2. 🚛 le camion', 'le lait part à l\'usine', '3. 🏭 la laiterie', 'on transforme le lait en yaourts\net on les met en pots', '4. 🚚 l\'entrepôt', 'les yaourts sont stockés au froid', '5. 🛒 le magasin', 'on achète les yaourts'], size=19, lignes=True)}""",
f"""[titre]D'où vient ce que je mange ?[/titre]
{tableau(2, ['🍌 la banane', 'des Antilles, d\'Afrique, d\'Amérique du Sud', '🍫 le cacao', 'de Côte d\'Ivoire, du Ghana (Afrique)', '☕ le café', 'du Brésil, du Viêt Nam', '🍚 le riz', 'd\'Asie', '🍎 la pomme', 'de France'], size=19, lignes=True)}
[cadre]Beaucoup d'aliments voyagent en bateau, en camion ou en avion avant d'arriver dans notre assiette.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• On ne mange pas la même chose ni la même quantité partout dans le monde.
• Ration très riche : États-Unis, France. Ration insuffisante : Madagascar, Haïti.
• [b]Sous-nutrition[/b] : pas assez manger. [b]Malnutrition[/b] : mal manger.
• Un [b]produit agricole[/b] (lait) devient un [b]produit transformé[/b] (yaourt).
• Un aliment passe par une chaîne : ferme, usine, transport, magasin.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 2
add('inegalites_monde', 'Les inégalités dans le monde', 'geographie', [
f"""[titre]Des niveaux de vie différents[/titre]
{gros('🏠 🏚️', 50)}
Le [b]niveau de vie[/b], c'est la façon dont les gens peuvent vivre : se loger, se nourrir, se soigner, aller à l'école.
[cadre]Dans le monde, les niveaux de vie sont très différents d'un pays à l'autre, et même à l'intérieur d'un même pays : ce sont les [b]inégalités[/b].[/cadre]""",
"""[titre]Les grandes aires du monde[/titre]
[planisphere pale=oui aires=oui largeur=720]""",
f"""[titre]L'accès à l'eau[/titre]
{gros('🚰 🪣', 50)}
Dans les pays riches, l'eau potable arrive au robinet. Ailleurs, des millions de personnes, souvent des femmes et des enfants, marchent longtemps chaque jour pour aller chercher de l'eau.
[cadre]Dans le monde, plus de [b]2 milliards[/b] de personnes n'ont pas d'eau potable sûre chez elles. Boire une eau sale rend malade.[/cadre]""",
f"""[titre]L'accès à la santé[/titre]
{tableau(2, ['beaucoup de médecins et d\'hôpitaux', 'peu de médecins, des hôpitaux loin', 'des vaccins et des médicaments', 'des maladies que l\'on sait soigner\ntuent encore', 'on vit en moyenne plus de 80 ans', 'on vit beaucoup moins longtemps'], entete=['en Europe, en Amérique du Nord', 'dans les pays les plus pauvres'], size=18)}""",
f"""[titre]L'accès à l'éducation[/titre]
{gros('🎒 📚', 50)}
En France, l'école est obligatoire et gratuite. Mais dans le monde, environ [b]250 millions[/b] d'enfants ne vont pas à l'école.
[cadre]Certains doivent travailler pour aider leur famille, d'autres vivent trop loin d'une école ou dans un pays en guerre. Les filles sont souvent les plus touchées.[/cadre]""",
f"""[titre]Où sont les inégalités ?[/titre]
{tableau(2, ['niveau de vie élevé', 'Amérique du Nord, Europe, Océanie\n(Australie), Asie de l\'Est (Japon)', 'niveau de vie plus faible', 'Afrique subsaharienne,\nune partie de l\'Asie du Sud-Est\net de l\'Amérique du Sud'], size=20, lignes=True)}
[cadre]Même dans un pays riche, il y a des personnes pauvres ; et dans un pays pauvre, des personnes très riches.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le niveau de vie n'est pas le même partout : ce sont les [b]inégalités[/b].
• Elles se voient dans l'accès à l'[b]eau[/b], à la [b]santé[/b] et à l'[b]éducation[/b].
• Les aires du monde : Amérique du Nord, Amérique du Sud, Europe, Maghreb, Afrique subsaharienne, Asie de l'Est, Asie du Sud-Est, Océanie.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 3
add('se_deplacer', 'Se déplacer', 'geographie', [
f"""[titre]Je me déplace[/titre]
{tableau(2, ['chaque jour', 'aller à l\'école : à pied, à vélo, en bus,\nen voiture', 'chaque semaine', 'aller au sport, faire les courses', 'pendant les vacances', 'partir loin : en train, en voiture,\nen avion, en bateau'], size=20, lignes=True)}
[cadre]Plus la distance est grande, plus on choisit un moyen de transport rapide.[/cadre]""",
f"""[titre]Moyens de transport et infrastructures[/titre]
{tableau(2, ['🚶 la marche', 'le trottoir', '🚲 le vélo', 'la voie cyclable (piste cyclable)', '🚗 la voiture', 'la route, l\'autoroute', '🚇 le métro', 'la station', '🚆 le train', 'la gare', '⛴️ le bateau', 'le port', '✈️ l\'avion', 'l\'aéroport'], entete=['je me déplace en…', 'j\'utilise…'], size=19)}""",
f"""[titre]Mesurer un déplacement[/titre]
{tableau(2, ['la [b]distance en kilomètres[/b]', 'la longueur du trajet\n(Paris → Marseille : environ 750 km)', 'la [b]distance en temps[/b]', 'la durée du trajet\n(en TGV : un peu plus de 3 heures)'], size=20, lignes=True)}
[cadre=astuce]Deux lieux peuvent être éloignés en kilomètres mais proches en temps, si un moyen de transport rapide les relie.[/cadre]""",
f"""[titre]Paris → Marseille[/titre]
{tableau(2, ['🚗 en voiture', 'environ 7 heures 30', '🚆 en TGV', 'un peu plus de 3 heures', '✈️ en avion', 'environ 1 heure 20 de vol'], entete=['moyen de transport', 'durée'], size=21)}
[cadre]La distance en kilomètres ne change pas, mais la distance en temps dépend du moyen de transport.[/cadre]""",
f"""[titre]Se déplacer dans le monde[/titre]
{gros('✈️ 🚢 🌍', 50)}
L'[b]avion[/b] permet de relier les continents en quelques heures. Les grands [b]aéroports[/b] accueillent des millions de voyageurs.
[cadre]Les [b]bateaux[/b] transportent surtout des marchandises, dans de grands conteneurs : la plupart des objets que nous achetons ont voyagé par la mer.[/cadre]""",
f"""[titre]Tout le monde ne voyage pas pareil[/titre]
{gros('🚶 🚌 ✈️', 50)}
Dans les pays riches, beaucoup de personnes ont une voiture et prennent l'avion. Dans les pays pauvres, beaucoup se déplacent à pied, à vélo ou en bus.
[cadre]Les transports polluent : on encourage la marche, le vélo, les transports en commun et le train.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• On se déplace chaque jour, chaque semaine, pendant les vacances, avec des moyens de transport différents.
• À chaque moyen de transport son infrastructure : avion/aéroport, bateau/port, train/gare, voiture/route, métro/station, vélo/voie cyclable.
• On mesure un déplacement en [b]kilomètres[/b] ou en [b]temps[/b].[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 4
add('internet', 'Communiquer avec Internet', 'geographie', [
f"""[titre]À quoi sert Internet ?[/titre]
{tableau(2, ['🔎 chercher des informations', '💬 envoyer des messages', '🎬 regarder des vidéos', '🎮 jouer en ligne', '🛒 acheter', '💼 travailler, apprendre'], size=21, paires=True)}
[cadre][b]Internet[/b] est un immense [b]réseau[/b] qui relie des milliards d'ordinateurs, de téléphones et de tablettes dans le monde.[/cadre]""",
f"""[titre]Comment ça marche ?[/titre]
{gros('📱 ➡️ 🏢 ➡️ 🌍', 46)}
Quand j'envoie un message, il part sous forme d'informations numériques. Il voyage par des câbles et arrive dans de grands bâtiments remplis d'ordinateurs, les [b]centres de données[/b], puis jusqu'à l'appareil de mon correspondant.
[cadre]Tout cela prend moins d'une seconde, même à l'autre bout du monde ![/cadre]""",
"""[titre]Les câbles sous-marins[/titre]
[planisphere pale=oui cables=oui largeur=720]
[cadre]Des câbles posés au fond des océans relient les continents. Ils sont très nombreux dans l'[b]Atlantique Nord[/b], le [b]Pacifique Nord[/b] et entre l'Europe et l'Asie.[/cadre]""",
f"""[titre]Câbles et satellites[/titre]
{tableau(2, ['les [b]câbles[/b]', 'sur les continents et sous les mers :\npresque toutes les informations passent par eux', 'les [b]satellites[/b]', 'tournent autour de la Terre : ils relient\nles endroits isolés (montagnes, déserts, bateaux)'], size=19, lignes=True)}""",
f"""[titre]Un accès inégal dans le monde[/titre]
{tableau(2, ['Europe, Amérique du Nord', 'très bien reliées :\nplus de 9 personnes sur 10 utilisent Internet', 'Afrique subsaharienne', 'faiblement reliée :\nmoins de 4 personnes sur 10'], size=20, lignes=True)}
[cadre]Dans le monde, environ 2 personnes sur 3 utilisent Internet. Plus de 2 milliards de personnes n'y ont pas accès.[/cadre]""",
f"""[titre]Et en France ?[/titre]
{gros('📶 🏙️ 🏔️', 50)}
Presque tous les Français peuvent utiliser Internet. Mais la [b]5G[/b], le réseau mobile le plus rapide, est surtout installée dans les [b]villes[/b].
[cadre]Dans certaines campagnes et montagnes, le réseau est faible, voire absent : on parle de « zones blanches ».[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Internet est un [b]réseau[/b] mondial qui sert à s'informer, communiquer, se divertir, travailler.
• Il repose sur des [b]câbles[/b] (dont des [b]câbles sous-marins[/b]) et des [b]satellites[/b].
• L'accès est inégal : l'Europe et l'Amérique du Nord sont très bien reliées, l'Afrique subsaharienne beaucoup moins.
• En France, la 5G est surtout présente dans les villes.[/cadre]""",
])

if __name__ == '__main__':
    sortie(FICHES, CL, sys.argv[1] if len(sys.argv) > 1 else '.', sys.argv[2] if len(sys.argv) > 2 else None,
           'Toutes les fiches de cours Histoire et Geographie CM1 (2026-11-07)')
