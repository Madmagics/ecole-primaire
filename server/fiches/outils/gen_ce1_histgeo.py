# Fiches de cours Histoire et Geographie CE1 (2026-11-06), programme du BO n° 22 du 28 mai 2026
# (cycle 2, annexe 3). Histoire : 3 themes du CE1. Geographie : theme 1 + theme 2 coupe en deux
# fiches (climats et paysages / reliefs et cours d'eau), trop dense pour une seule fiche.
# Sorties : server/fiches/ce1_hg_<code>.sql, ce1_histgeo_toutes.sql, un .txt par fiche (rendu).
# Les fiches sont la source des futures questions (decision de Steve).
import os
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt
from gen_cp_histgeo import emo, gros, SQL, MATIERE

CL = 'ce1'
FICHES = []


def add(code, titre, domaine, pages):
    FICHES.append((CL, code, titre, domaine, [couleur_alt(CL, p) for p in pages]))


# =====================================================================  HISTOIRE 1
add('passe_proche_lointain', 'Du passé proche au passé lointain', 'histoire', [
f"""[titre]Passé proche, passé lointain[/titre]
{tableau(2, ['il y a [b]peu de temps[/b]', 'il y a [b]très longtemps[/b]', 'hier, la semaine dernière, l\'an dernier', 'il y a 100 ans, il y a 1 000 ans', 'On s\'en souvient.', 'Personne de vivant ne s\'en souvient.'], entete=['le passé proche', 'le passé lointain'], size=20)}
[cadre]Le passé lointain, on le connaît grâce aux [b]traces[/b] qu'il a laissées : des objets, des monuments, des écrits.[/cadre]""",
f"""[titre]Les mots pour dire quand[/titre]
Du plus proche au plus lointain :
{tableau(2, ['hier', 'la semaine dernière', 'le mois dernier', "l'an dernier", 'il y a 10 ans', 'autrefois', 'il y a 100 ans', 'il y a très longtemps'], size=21, lignes=True)}
[cadre=astuce][b]Autrefois[/b] veut dire « il y a longtemps », à une époque passée.[/cadre]""",
f"""[titre]Compter le temps long[/titre]
{tableau(2, ['1 année', '12 mois', '1 [b]décennie[/b]', '10 ans', '1 [b]siècle[/b]', '100 ans', '1 [b]millénaire[/b]', '1 000 ans'], size=24, paires=True)}
[cadre=astuce][b]déc[/b]ennie → 10, comme « dix ».
[b]mill[/b]énaire → 1 000, comme « mille ».[/cadre]""",
f"""[titre]Je calcule avec les durées[/titre]
{tableau(2, ['2 décennies', '20 ans', '3 décennies', '30 ans', '1 siècle', '10 décennies', '2 siècles', '200 ans', '1 millénaire', '10 siècles'], size=22, paires=True)}
[cadre]Un siècle, c'est 10 décennies. Un millénaire, c'est 10 siècles.[/cadre]""",
"""[titre]Les siècles[/titre]
On range les années par paquets de 100 : les [b]siècles[/b].
[cadre]De l'an 1901 à l'an 2000 : le [b]20e siècle[/b].
Depuis l'an 2001 : le [b]21e siècle[/b]. C'est le siècle où nous vivons.[/cadre]
[cadre=astuce]On écrit souvent les siècles en chiffres romains : XXe siècle (20e), XXIe siècle (21e).[/cadre]""",
"""[titre]Ranger du plus ancien au plus récent[/titre]
Sur une frise, on place le plus ancien à [b]gauche[/b] et le plus récent à [b]droite[/b].
[frise points=il_y_a_1_000_ans,il_y_a_100_ans,il_y_a_10_ans,l'an_dernier,aujourd'hui marque=5 debut=passé_lointain fin=présent]
[cadre]Il y a 1 000 ans, c'est [b]plus ancien[/b] qu'il y a 100 ans.[/cadre]""",
f"""[titre]Autrefois et aujourd'hui[/titre]
{tableau(3, ['s\'éclairer', 'une bougie, une lampe à pétrole', 'une ampoule électrique', 'se déplacer', 'à pied, à cheval, en calèche', 'en voiture, en train, en avion', 'téléphoner', 'un téléphone fixe à cadran', 'un téléphone portable', 'écrire', 'une plume et de l\'encre', 'un stylo, un ordinateur', 'laver le linge', 'à la main, au lavoir', 'avec une machine à laver'], entete=['', 'autrefois', "aujourd'hui"], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• Le [b]passé proche[/b] : il y a peu de temps. Le [b]passé lointain[/b] : il y a très longtemps.
• 1 décennie = [b]10 ans[/b]. 1 siècle = [b]100 ans[/b]. 1 millénaire = [b]1 000 ans[/b].
• Nous vivons au [b]21e siècle[/b] (XXIe).
• Sur une frise : le plus ancien à gauche, le plus récent à droite.[/cadre]""",
])

# =====================================================================  HISTOIRE 2
add('grandes_periodes', "Les grandes périodes de l'histoire", 'histoire', [
"""[titre]Les 5 grandes périodes[/titre]
Pour s'y retrouver, on découpe l'histoire en [b]5 grandes périodes[/b].
[periodes]
[cadre]Préhistoire → Antiquité → Moyen Âge → Temps modernes → Époque contemporaine.[/cadre]""",
"""[titre]Avant et après Jésus-Christ[/titre]
Pour compter les années, on part de l'[b]an 1[/b], l'année de la naissance de Jésus-Christ dans notre calendrier.
[frise points=3000_av._J.-C.,52_av._J.-C.,an_1,476,1492,1789 marque=3 debut=avant fin=après]
[cadre]Avant l'an 1, on écrit « [b]av. J.-C.[/b] » : 3000 av. J.-C. Après l'an 1, on écrit simplement l'année : 1492.[/cadre]
[cadre=astuce]Avant J.-C., plus le nombre est grand, plus c'est ancien : 3000 av. J.-C. est plus ancien que 52 av. J.-C.[/cadre]""",
f"""[titre]La Préhistoire[/titre]
[periodes marque=1]
Elle commence avec les [b]premiers humains[/b], il y a environ 3 millions d'années. Elle finit avec l'invention de l'[b]écriture[/b], vers 3000 av. J.-C.
[cadre]Les humains chassent et cueillent, puis apprennent à cultiver et à élever des animaux. Ils taillent la pierre et peignent dans les grottes.[/cadre]
[cadre=astuce]Une figure : [b]Ötzi[/b], un homme qui vivait il y a plus de 5 000 ans, retrouvé dans la glace des Alpes.[/cadre]""",
f"""[titre]L'Antiquité[/titre]
[periodes marque=2]
De l'invention de l'écriture (vers 3000 av. J.-C.) à la fin de l'Empire romain d'Occident, en [b]476[/b].
{tableau(2, ['[b]Cléopâtre[/b]', 'une reine d\'Égypte', '[b]Jules César[/b]', 'un général romain', '[b]Vercingétorix[/b]', 'un chef gaulois, vaincu à Alésia en 52 av. J.-C.'], size=19, lignes=True)}
[cadre]C'est le temps des Égyptiens et de leurs pyramides, des Grecs, des Romains et des Gaulois.[/cadre]""",
f"""[titre]Le Moyen Âge[/titre]
[periodes marque=3]
De [b]476[/b] à [b]1492[/b]. C'est le temps des châteaux forts, des chevaliers, des seigneurs et des cathédrales.
{tableau(2, ['[b]Charlemagne[/b]', 'un empereur, couronné en l\'an 800', '[b]Aliénor d\'Aquitaine[/b]', 'une reine de France, puis d\'Angleterre', '[b]Jeanne d\'Arc[/b]', 'une jeune fille qui a combattu pendant la guerre de Cent Ans'], size=19, lignes=True)}""",
f"""[titre]Les Temps modernes[/titre]
[periodes marque=4]
De [b]1492[/b] à [b]1789[/b]. C'est le temps des grands voyages en bateau et des rois puissants.
{tableau(2, ['[b]Christophe Colomb[/b]', 'un navigateur, arrivé en Amérique en 1492', '[b]Léonard de Vinci[/b]', 'un peintre et inventeur, auteur de la Joconde', '[b]Louis XIV[/b]', 'le « Roi-Soleil », qui a fait construire Versailles'], size=19, lignes=True)}""",
f"""[titre]L'Époque contemporaine[/titre]
[periodes marque=5]
De [b]1789[/b] (la Révolution française) à [b]aujourd'hui[/b]. C'est le temps de l'électricité, des trains, des voitures, des avions et des ordinateurs.
{tableau(2, ['[b]Napoléon Ier[/b]', 'un empereur des Français', '[b]Louis Pasteur[/b]', 'un savant, inventeur du vaccin contre la rage', '[b]Marie Curie[/b]', 'une savante, deux fois prix Nobel'], size=19, lignes=True)}""",
f"""[titre]Les dates qui séparent les périodes[/titre]
{tableau(2, ['vers 3000 av. J.-C.', "l'invention de l'[b]écriture[/b]", '476', "la fin de l'[b]Empire romain[/b] d'Occident", '1492', 'Christophe Colomb arrive en [b]Amérique[/b]', '1789', 'la [b]Révolution[/b] française'], size=20, lignes=True)}
[cadre=astuce]Chaque période commence par un grand événement : je retiens ces 4 dates.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Préhistoire[/b] : jusqu'à l'écriture, vers 3000 av. J.-C.
• [b]Antiquité[/b] : jusqu'en 476. Cléopâtre, Jules César, Vercingétorix.
• [b]Moyen Âge[/b] : de 476 à 1492. Charlemagne, Jeanne d'Arc.
• [b]Temps modernes[/b] : de 1492 à 1789. Christophe Colomb, Louis XIV.
• [b]Époque contemporaine[/b] : depuis 1789. Napoléon, Marie Curie.[/cadre]""",
])

# =====================================================================  HISTOIRE 3
add('traces_passe', 'Les traces du passé', 'histoire', [
f"""[titre]Comment connaît-on le passé ?[/titre]
{gros('🔎', 60)}
Personne ne peut retourner dans le passé. Mais le passé laisse des [b]traces[/b].
[cadre]Une [b]trace[/b], c'est tout ce qui reste du passé et qui nous aide à le comprendre.[/cadre]""",
f"""[titre]Les sortes de traces[/titre]
{tableau(3, [emo('🦴', 30), 'les fossiles et les ossements', 'des os, des coquillages pris dans la pierre', emo('🏛️', 30), 'les monuments et les ruines', 'des temples, des châteaux, des églises', emo('🏺', 30), 'les objets', 'des outils, des poteries, des bijoux', emo('📜', 30), 'les écrits', 'des lettres, des livres, des registres', emo('🖼️', 30), 'les images', 'des peintures, des photos', emo('🗣️', 30), 'les témoignages', 'des souvenirs racontés par des personnes'], size=19, lignes=True)}""",
f"""[titre]Les fossiles[/titre]
{gros('🐚 🦴 🦖', 54)}
Un [b]fossile[/b] est la trace d'un animal ou d'une plante très ancienne, conservée dans la pierre : un os, un coquillage, une empreinte.
[cadre=astuce]Les dinosaures ont disparu il y a environ 66 millions d'années, bien avant les premiers humains. Aucun humain n'a vu de dinosaure vivant ![/cadre]""",
f"""[titre]Les traces de la Préhistoire[/titre]
{gros('🐎 🦌 🐂', 54)}
[cadre]Dans la grotte de [b]Lascaux[/b], en France, des humains ont peint des animaux il y a environ 18 000 ans.[/cadre]
Les archéologues retrouvent aussi des [b]outils en pierre taillée[/b], des ossements et les restes de foyers où l'on faisait du feu.""",
f"""[titre]Dater une trace[/titre]
{tableau(2, ['la grotte de Lascaux', '[b]Préhistoire[/b]', "les pyramides d'Égypte, le pont du Gard", '[b]Antiquité[/b]', 'un château fort, la cathédrale Notre-Dame de Paris', '[b]Moyen Âge[/b]', 'le château de Versailles', '[b]Temps modernes[/b]', 'la tour Eiffel, construite en 1889', '[b]Époque contemporaine[/b]'], entete=['la trace', 'la période'], size=19, lignes=True)}""",
f"""[titre]Les métiers du passé[/titre]
{tableau(2, ["l'[b]archéologue[/b]", 'Il fouille le sol pour retrouver des objets et des restes enfouis.', "l'[b]historien[/b], l'[b]historienne[/b]", 'Il ou elle étudie les traces et les documents\npour raconter ce qui s\'est passé.', "l'[b]archiviste[/b]", 'Il ou elle garde et range les vieux documents :\nles [b]archives[/b].'], size=19, lignes=True)}""",
"""[titre]Les témoignages[/titre]
Les personnes âgées peuvent raconter leurs [b]souvenirs[/b] : c'est un [b]témoignage[/b].
[cadre]Les photos de famille, les souvenirs de mes grands-parents sont des traces d'un passé proche.[/cadre]
[cadre=astuce]Pour un passé très lointain, il n'y a plus de témoins : on utilise les autres traces.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le passé laisse des [b]traces[/b] : fossiles, monuments, objets, écrits, images, témoignages.
• Les dinosaures ont disparu bien avant les premiers humains.
• Chaque trace appartient à une période : Lascaux → Préhistoire, la tour Eiffel → Époque contemporaine.
• L'[b]archéologue[/b] fouille, l'[b]historien[/b] étudie, l'[b]archiviste[/b] garde les documents.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 1
add('terre_peuplee', 'Où vivent les êtres humains ?', 'geographie', [
f"""[titre]La Terre est peuplée[/titre]
{gros('🌍 👨‍👩‍👧‍👦', 60)}
Plus de [b]8 milliards[/b] d'êtres humains vivent sur la Terre.
[cadre]Mais ils ne vivent pas partout : certains endroits ont beaucoup d'habitants, d'autres presque pas.[/cadre]""",
"""[titre]Les grands foyers de peuplement[/titre]
[planisphere pale=oui foyers=oui largeur=640]
[cadre]Un [b]foyer de peuplement[/b] est une région où vivent énormément de personnes. Les 3 plus grands : l'[b]Asie de l'Est[/b], l'[b]Asie du Sud[/b] et l'[b]Europe[/b].[/cadre]""",
f"""[titre]Beaucoup ou peu d'habitants[/titre]
{tableau(3, [emo('🏙️', 30), 'beaucoup d\'habitants', 'l\'Asie : presque 6 humains sur 10 y vivent', emo('🏜️', 30), 'très peu d\'habitants', 'les déserts chauds, comme le Sahara', emo('🏔️', 30), 'très peu d\'habitants', 'les hautes montagnes', emo('🌳', 30), 'très peu d\'habitants', 'les grandes forêts tropicales', emo('❄️', 30), 'presque personne', 'les régions glacées, l\'Antarctique'], size=19, lignes=True)}""",
"""[titre]Une grande ville sur chaque continent[/titre]
[planisphere pale=oui villes=oui largeur=660]""",
f"""[titre]Les grandes villes à connaître[/titre]
{tableau(2, ['Europe', '[b]Paris[/b]', 'Asie', '[b]Tokyo[/b]', 'Afrique', '[b]Lagos[/b]', 'Amérique du Nord', '[b]New York[/b]', 'Amérique du Sud', '[b]São Paulo[/b]', 'Océanie', '[b]Sydney[/b]'], entete=['le continent', 'une ville très peuplée'], size=20, lignes=True)}
[cadre=astuce]En Antarctique, il fait trop froid : il n'y a aucune ville.[/cadre]""",
f"""[titre]La ville[/titre]
{gros('🏙️', 50)}
La [b]ville[/b] a beaucoup d'habitants.
[cadre]On y trouve des immeubles, beaucoup de rues, des magasins, des écoles, un hôpital, et des transports : bus, tramway, métro.[/cadre]""",
f"""[titre]Le village et la campagne[/titre]
{tableau(2, ['beaucoup d\'habitants', 'peu d\'habitants', 'des immeubles', 'des maisons', 'beaucoup de magasins', 'peu de magasins'], entete=['la ville', 'le village'], size=20, paires=True)}
[cadre]Le village est entouré par la [b]campagne[/b] : des champs, des prés, des forêts et des fermes.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Plus de 8 milliards d'humains vivent sur la Terre, mais pas partout.
• Les 3 grands foyers de peuplement : Asie de l'Est, Asie du Sud, Europe.
• Peu d'habitants : déserts, hautes montagnes, grandes forêts, régions glacées.
• Paris, Tokyo, Lagos, New York, São Paulo, Sydney : des villes très peuplées.
• La ville a beaucoup d'habitants ; le village, peu, au milieu de la campagne.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 2
add('climats_paysages', 'Climats et paysages du monde', 'geographie', [
f"""[titre]Météo et climat[/titre]
{tableau(2, ['le temps qu\'il fait [b]un jour[/b] : soleil, pluie, vent', 'le temps [b]habituel[/b] d\'une région, année après année'], entete=['la météo', 'le climat'], size=20)}
[cadre]« Aujourd'hui il pleut » : c'est la [b]météo[/b].
« Ici, l'été est chaud et sec » : c'est le [b]climat[/b].[/cadre]""",
"""[titre]Les 3 zones climatiques[/titre]
[planisphere pale=oui zones=oui largeur=640]
[cadre]Près des pôles : la zone [b]froide[/b]. Autour de l'équateur : la zone [b]chaude[/b]. Entre les deux : la zone [b]tempérée[/b].[/cadre]""",
f"""[titre]Chaud, tempéré ou froid[/titre]
{tableau(3, [emo('❄️', 30), 'la zone froide', 'Il fait froid toute l\'année.\nIl y a de la glace et peu de plantes.', emo('🌳', 30), 'la zone tempérée', 'Ni trop chaud, ni trop froid.\nIl y a 4 saisons.', emo('🌴', 30), 'la zone chaude', 'Il fait chaud toute l\'année.\nIl y a une saison sèche et une saison des pluies,\nou de la pluie toute l\'année.'], size=19, lignes=True)}""",
f"""[titre]La France dans les 3 zones[/titre]
{tableau(2, ['zone tempérée', 'la France métropolitaine, en Europe', 'zone chaude', 'la Guadeloupe, la Martinique, la Guyane, La Réunion, Mayotte', 'zone froide', 'la Terre Adélie, en Antarctique'], size=20, lignes=True)}
[cadre]Grâce à ses territoires d'outre-mer, la France est présente dans les 3 zones climatiques.[/cadre]""",
f"""[titre]Les forêts[/titre]
{tableau(2, [emo('🌳'), emo('🌴'), 'Les arbres perdent leurs feuilles\nen automne : chênes, hêtres.', 'Toujours verte, très dense,\nchaude et humide.'], entete=['la forêt tempérée', 'la forêt tropicale'], size=20)}
[cadre=astuce]Les plus grandes forêts tropicales : la forêt [b]amazonienne[/b], la forêt du bassin du [b]Congo[/b] et la forêt d'[b]Indonésie[/b].[/cadre]""",
"""[titre]Les grandes forêts du monde[/titre]
[planisphere pale=oui forets=oui largeur=660]""",
f"""[titre]Prairie et savane[/titre]
{tableau(2, [emo('🐄'), emo('🦒'), 'de l\'herbe, dans la zone tempérée', 'de hautes herbes et quelques arbres, dans la zone chaude', 'On y élève des vaches et des moutons.', 'On y voit des lions, des zèbres, des girafes.'], entete=['la prairie', 'la savane'], size=20)}""",
f"""[titre]Les déserts[/titre]
Un [b]désert[/b] est un endroit où il ne pleut presque jamais.
{tableau(2, [emo('🏜️'), emo('🧊'), 'le [b]Sahara[/b], en Afrique', "l'[b]Antarctique[/b]", 'du sable, des cailloux, très chaud le jour', 'de la glace, très froid'], entete=['le désert chaud', 'le désert froid'], size=20)}""",
"""[titre]Décrire un paysage[/titre]
[paysage]
[cadre]Sur une photo, ce qui est devant, en bas, est au [b]premier plan[/b]. Ce qui est au fond est à l'[b]arrière-plan[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• La [b]météo[/b] : le temps d'un jour. Le [b]climat[/b] : le temps habituel d'une région.
• 3 zones : [b]froide[/b] (pôles), [b]tempérée[/b], [b]chaude[/b] (équateur). La France métropolitaine est tempérée.
• Forêt tempérée ou tropicale ; prairie ou savane ; désert chaud (Sahara) ou froid (Antarctique).
• Un paysage : le premier plan devant, l'arrière-plan au fond.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 3
add('reliefs_eau', 'Montagnes, plaines et fleuves', 'geographie', [
"""[titre]Les formes du relief[/titre]
[relief]
[cadre]La [b]montagne[/b] est haute, avec des sommets. La [b]plaine[/b] est plate et basse. Le [b]plateau[/b] est plat mais en hauteur. La [b]vallée[/b] est un creux entre des montagnes.[/cadre]""",
"""[titre]Les grandes chaînes de montagnes[/titre]
[planisphere pale=oui montagnes=oui largeur=660]""",
f"""[titre]Les montagnes à connaître[/titre]
{tableau(2, ['l\'[b]Himalaya[/b]', 'en Asie : les plus hautes montagnes du monde, avec l\'Everest', 'les [b]Alpes[/b]', 'en Europe : en France, le mont Blanc', 'les [b]Andes[/b]', 'en Amérique du Sud', 'les [b]Rocheuses[/b]', 'en Amérique du Nord', 'l\'[b]Atlas[/b]', 'en Afrique'], size=20, lignes=True)}
[cadre=astuce]Une suite de montagnes s'appelle une [b]chaîne de montagnes[/b].[/cadre]""",
"""[titre]Fleuve ou rivière ?[/titre]
[cours_eau]
[cadre]Un [b]fleuve[/b] se jette dans la mer ou l'océan. Une [b]rivière[/b] se jette dans un fleuve ou dans une autre rivière.
La [b]source[/b] est l'endroit où il naît, l'[b]embouchure[/b] l'endroit où il arrive dans la mer.[/cadre]""",
"""[titre]Les grands fleuves du monde[/titre]
[planisphere pale=oui fleuves=oui largeur=640]
[cadre]L'[b]Amazone[/b] (Amérique du Sud) porte plus d'eau que tous les autres. Le [b]Nil[/b] (Afrique) traverse le désert. Le [b]Mississippi[/b] coule en Amérique du Nord.[/cadre]""",
f"""[titre]Les humains et les fleuves[/titre]
{gros('🏞️ 🚢', 54)}
Depuis toujours, beaucoup de villes sont construites au bord des fleuves. Paris est au bord de la [b]Seine[/b].
[cadre]Le fleuve donne de l'eau pour boire et pour cultiver les champs. Les bateaux s'en servent pour transporter des marchandises.[/cadre]
[cadre=astuce]Cherche le fleuve ou la rivière le plus proche de chez toi ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Montagne (haute), plaine (plate et basse), plateau (plat et haut), vallée (creux).
• Les chaînes : Himalaya, Alpes, Andes, Rocheuses, Atlas.
• Un [b]fleuve[/b] va jusqu'à la mer ; une [b]rivière[/b] se jette dans un autre cours d'eau.
• Les grands fleuves : Amazone, Nil, Mississippi.[/cadre]""",
])

if __name__ == '__main__':
    OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
    TXT = sys.argv[2] if len(sys.argv) > 2 else None
    toutes = ['-- Toutes les fiches de cours Histoire-Geographie CE1 (2026-11-06), une seule transaction.', 'begin;']
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
