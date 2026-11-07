# Fiches de cours Histoire et Geographie CP (2026-11-06), programme du BO n° 22 du 28 mai 2026
# (cycle 2, annexe 3). Histoire : 3 themes du CP ; Geographie : 2 themes du CP. Une fiche par theme.
# Genere un script SQL par fiche (server/fiches/cp_hg_<code>.sql), un script global
# (server/fiches/cp_histgeo_toutes.sql) et un .txt par fiche pour la verification du rendu.
# Dessins utilises (FicheDessin, 2026-11-06) : [terre] [roue] [frise] [horloge] [plan] [planisphere].
# Les fiches deviennent la source des questions (decision de Steve) : tout fait interrogeable doit y etre.
import os
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt

MATIERE = 'histoire_geo'   # CP-CE2 : une seule matiere Histoire-Geo (5 questions de chaque par serie)
FICHES = []


def add(code, titre, domaine, pages):
    FICHES.append(('cp', code, titre, domaine, [couleur_alt('cp', p) for p in pages]))


def emo(x, size=40):
    return f'[font_size={size}]{x}[/font_size]'


def gros(t, size=56):
    return f'[center][font_size={size}]{t}[/font_size][/center]'


# =====================================================================  HISTOIRE 1
add('temps_nature', 'Le jour, la nuit et les saisons', 'histoire', [
f"""[titre]Le jour et la nuit[/titre]
Le matin, le Soleil se lève. Le soir, il se couche. Puis vient la nuit.
{tableau(2, [emo('☀️'), emo('🌙'), 'Il fait [b]clair[/b].\nLe Soleil brille.\nOn travaille, on joue.', 'Il fait [b]noir[/b].\nOn voit la Lune et les étoiles.\nOn dort.'], entete=['le jour', 'la nuit'], size=22)}
[cadre]Le jour et la nuit reviennent toujours, l'un après l'autre.[/cadre]""",
"""[titre]Pourquoi le jour et la nuit ?[/titre]
[terre]
La Terre est une grosse boule qui [b]tourne sur elle-même[/b].
Le côté tourné vers le Soleil est éclairé : c'est le [b]jour[/b]. L'autre côté est dans le noir : c'est la [b]nuit[/b].""",
"""[titre]Un tour en une journée[/titre]
La Terre fait [b]un tour complet[/b] sur elle-même en [b]24 heures[/b].
[cadre]Une journée de 24 heures = un jour + une nuit.[/cadre]
Quand c'est le jour en France, c'est la nuit de l'autre côté de la Terre.
[cadre=astuce]Ce n'est pas le Soleil qui tourne autour de nous : c'est la Terre qui tourne ! En classe, on peut le voir avec un [b]globe terrestre[/b] et une lampe.[/cadre]""",
"""[titre]Les moments de la journée[/titre]
Une journée a plusieurs moments, toujours dans le même ordre.
[frise points=le_matin,midi,l'après-midi,le_soir,la_nuit]
[cadre]Le [b]matin[/b], je me lève, je prends mon [b]petit-déjeuner[/b] et je vais à l'école.
À [b]midi[/b], je déjeune.
L'[b]après-midi[/b], je travaille ou je joue.
Le [b]soir[/b], je dîne. La [b]nuit[/b], je dors.[/cadre]""",
"""[titre]Les quatre saisons[/titre]
Une année a [b]4 saisons[/b]. Elles reviennent toujours dans le même ordre.
[roue liste=le_printemps,l'été,l'automne,l'hiver]
[cadre]printemps → été → automne → hiver → et de nouveau le printemps…[/cadre]""",
f"""[titre]Le printemps et l'été[/titre]
{tableau(2, [emo('🌸'), emo('☀️'), 'commence vers le [b]20 mars[/b]', 'commence vers le [b]21 juin[/b]', 'Il fait plus doux.', 'Il fait [b]chaud[/b].', 'Les fleurs poussent.\nLes arbres font des feuilles.\nLes oiseaux font leur nid.', 'Les journées sont très longues.\nOn récolte les fruits.\nC\'est le temps des grandes vacances.'], entete=['le printemps', "l'été"], size=20)}""",
f"""[titre]L'automne et l'hiver[/titre]
{tableau(2, [emo('🍂'), emo('❄️'), 'commence vers le [b]22 septembre[/b]', 'commence vers le [b]21 décembre[/b]', 'Il fait frais.\nIl pleut souvent.', 'Il fait [b]froid[/b].\nIl gèle, parfois il neige.', 'Les feuilles jaunissent et tombent.\nOn ramasse les châtaignes.', 'Les journées sont courtes.\nLes arbres n\'ont plus de feuilles.'], entete=["l'automne", "l'hiver"], size=20)}""",
f"""[titre]Je m'habille selon la saison[/titre]
{tableau(3, ['printemps', 'doux, parfois de la pluie', 'une veste légère', 'été', 'chaud', 'un short, une casquette', 'automne', 'frais, de la pluie', 'un imperméable, des bottes', 'hiver', 'froid', 'un manteau, un bonnet, une écharpe, des gants'], entete=['la saison', 'le temps', 'je porte'], size=19, lignes=True)}""",
"""[titre]Partout pareil ?[/titre]
En France [b]métropolitaine[/b] (la partie de la France qui est en Europe), on a [b]4 saisons[/b] bien différentes.
[cadre]En Guadeloupe, en Martinique, en Guyane, à La Réunion ou à Mayotte, il fait chaud presque toute l'année.
On parle plutôt d'une [b]saison sèche[/b] et d'une [b]saison des pluies[/b].[/cadre]
[cadre=astuce]Les saisons ne sont pas les mêmes partout : elles dépendent de l'endroit où l'on vit.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• La Terre [b]tourne sur elle-même[/b] en [b]24 heures[/b].
• Le côté éclairé par le Soleil a le [b]jour[/b], l'autre côté a la [b]nuit[/b].
• La journée : le matin, midi, l'après-midi, le soir, la nuit.
• L'année a [b]4 saisons[/b] : printemps, été, automne, hiver.
• Elles reviennent toujours dans le même ordre.[/cadre]""",
])

# =====================================================================  HISTOIRE 2
add('mesurer_temps', 'Mesurer le temps', 'histoire', [
f"""[titre]Du plus long au plus court[/titre]
{tableau(2, ['1 année', '[b]12[/b] mois', '1 mois', 'un peu plus de [b]4[/b] semaines', '1 semaine', '[b]7[/b] jours', '1 jour', '[b]24[/b] heures'], size=24, paires=True)}
[cadre]L'année est le plus long. Puis le mois, la semaine, le jour et l'heure.[/cadre]""",
"""[titre]Les 7 jours de la semaine[/titre]
[roue liste=lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche marque=1]
[cadre]La semaine commence le [b]lundi[/b] et finit le [b]dimanche[/b]. Puis elle recommence.
Le samedi et le dimanche forment le [b]week-end[/b].[/cadre]""",
f"""[titre]Hier, aujourd'hui, demain[/titre]
Si aujourd'hui, c'est [b]mercredi[/b] :
{tableau(5, ['avant-hier', 'hier', "aujourd'hui", 'demain', 'après-demain', 'lundi', 'mardi', '[b]mercredi[/b]', 'jeudi', 'vendredi'], size=21, lignes=True)}
[cadre=astuce][b]Hier[/b], c'est le jour d'avant. [b]Demain[/b], c'est le jour d'après.[/cadre]""",
f"""[titre]Les 12 mois de l'année[/titre]
{tableau(4, ['1. janvier', '2. février', '3. mars', '4. avril', '5. mai', '6. juin', '7. juillet', '8. août', '9. septembre', '10. octobre', '11. novembre', '12. décembre'], size=21, lignes=True)}
[cadre]L'année commence le [b]1er janvier[/b] et finit le [b]31 décembre[/b].[/cadre]""",
f"""[titre]Combien de jours dans un mois ?[/titre]
{tableau(2, ['[b]31 jours[/b]', 'janvier, mars, mai, juillet, août, octobre, décembre', '[b]30 jours[/b]', 'avril, juin, septembre, novembre', '[b]28 ou 29 jours[/b]', 'février, le plus court'], size=20, lignes=True)}
[cadre=astuce]Je ferme mes poings. Je dis les mois sur les bosses et les creux : une bosse = 31 jours, un creux = 30 jours (ou février).[/cadre]
[cadre]Une année a [b]365 jours[/b] (366 quand février a 29 jours).[/cadre]""",
f"""[titre]Calendrier, éphéméride, emploi du temps[/titre]
{tableau(3, [emo('📅', 34), 'le calendrier', 'Tous les jours de l\'année, mois par mois.\nOn y note les anniversaires, les vacances.', emo('📆', 34), 'l\'éphéméride', 'Un bloc avec [b]une feuille par jour[/b].\nChaque matin, on enlève la feuille d\'hier.', emo('📋', 34), 'l\'emploi du temps', 'Ce qu\'on fait en classe,\njour après jour, heure après heure.'], size=19, lignes=True)}""",
"""[titre]Lire l'heure[/titre]
Une horloge a deux aiguilles :
[cadre]La [b]petite aiguille[/b] montre les [b]heures[/b].
La [b]grande aiguille[/b] montre les [b]minutes[/b].[/cadre]
[horloge heures=8h,12h,4h]
[cadre=astuce]Quand la grande aiguille est sur le [b]12[/b], c'est une heure pile : 8 heures, midi, 4 heures.[/cadre]""",
"""[titre]Montre à aiguilles, montre à chiffres[/titre]
La montre [b]à aiguilles[/b] s'appelle aussi [b]analogique[/b]. La montre [b]à chiffres[/b] s'appelle [b]numérique[/b].
[horloge heures=3h,7h30 numerique=oui]
[cadre]Sur l'écran, le nombre avant les deux points ( : ) donne les [b]heures[/b], le nombre après donne les [b]minutes[/b].
7:30 se lit [b]sept heures trente[/b] (ou sept heures et demie).[/cadre]""",
f"""[titre]Les objets pour mesurer le temps[/titre]
{tableau(3, [emo('⏳', 30), 'le sablier', 'Le sable coule : il mesure un temps court.', emo('⌚', 30), 'la montre', 'Au poignet, elle donne l\'heure.', emo('⏰', 30), 'le réveil', 'Il sonne pour nous réveiller.', emo('🕰️', 30), 'la pendule', 'Posée ou accrochée au mur, elle donne l\'heure.', emo('⏱️', 30), 'le chronomètre', 'Il mesure le temps d\'une course.'], size=20, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• 1 année = [b]12 mois[/b] (365 jours).
• 1 semaine = [b]7 jours[/b], du lundi au dimanche.
• 1 jour = [b]24 heures[/b].
• Petite aiguille → les heures. Grande aiguille → les minutes.
• Le calendrier montre les jours de l'année, l'éphéméride un jour à la fois.
• Le sablier, la montre, le réveil, la pendule mesurent le temps.[/cadre]""",
])

# =====================================================================  HISTOIRE 3
add('situer_temps', 'Avant, maintenant, après', 'histoire', [
"""[titre]Avant, pendant, après[/titre]
[frise points=avant,pendant,après]
[cadre][b]Avant[/b] le repas, je me lave les mains.
[b]Pendant[/b] le repas, je mange.
[b]Après[/b] le repas, je débarrasse la table.[/cadre]
[cadre=astuce]Deux choses qui arrivent au même moment se passent [b]en même temps[/b] : je mange [b]pendant que[/b] ma sœur boit.[/cadre]""",
f"""[titre]Passé, présent, futur[/titre]
{tableau(3, ["c'est fini", "c'est maintenant", "ça n'est pas encore arrivé", 'hier', "aujourd'hui", 'demain', "j'ai joué", 'je joue', 'je jouerai'], entete=['le passé', 'le présent', 'le futur'], size=21)}
[cadre]Les verbes et les petits mots du temps me disent si c'est [b]passé[/b], [b]présent[/b] ou [b]futur[/b].[/cadre]""",
f"""[titre]Les mots du temps[/titre]
{tableau(3, ['hier', "aujourd'hui", 'demain', 'avant-hier', 'maintenant', 'après-demain', 'autrefois', 'en ce moment', 'bientôt', 'il y a longtemps', 'ce matin', 'plus tard', "l'an dernier", 'cette année', "l'an prochain"], entete=['le passé', 'le présent', 'le futur'], size=20)}""",
"""[titre]Le temps passé ne revient pas[/titre]
[frise points=bébé,2_ans,4_ans,6_ans,plus_tard marque=4 debut=passé fin=futur]
[cadre]Je grandis. Je ne peux pas redevenir un bébé. Le temps avance toujours dans le même sens : du [b]passé[/b] vers le [b]futur[/b].[/cadre]
[cadre=astuce]Les jours et les saisons reviennent chaque année, mais un moment passé ne revient [b]jamais[/b].[/cadre]""",
"""[titre]La frise chronologique[/titre]
Une [b]frise chronologique[/b] est une ligne sur laquelle on range les événements [b]dans l'ordre[/b].
[frise points=8_h_30_arrivée,10_h_récréation,12_h_cantine,16_h_30_sortie]
[cadre]On la lit de [b]gauche à droite[/b] : à gauche, ce qui arrive en premier ; à droite, ce qui arrive en dernier.[/cadre]""",
f"""[titre]Les générations[/titre]
Une [b]génération[/b], ce sont les personnes nées à peu près à la même époque.
{tableau(2, [emo('👵👴', 34), 'les [b]grands-parents[/b]', emo('👩👨', 34), 'les [b]parents[/b]', emo('🧒👧', 34), 'les [b]enfants[/b] : moi, mes frères et sœurs,\nmes cousins et mes cousines'], size=21, lignes=True)}
[cadre]Les parents de mes grands-parents sont mes [b]arrière-grands-parents[/b].[/cadre]""",
f"""[titre]L'arbre généalogique[/titre]
L'[b]arbre généalogique[/b] montre les personnes d'une famille et leurs liens.
[arbre]
[cadre=astuce]Les plus âgés sont en haut, les plus jeunes en bas. Le papa de mon papa est mon [b]grand-père[/b]. Chaque famille est différente.[/cadre]""",
f"""[titre]Les dates qu'on fête[/titre]
Mon [b]anniversaire[/b] revient chaque année, le jour de ma naissance.
Une [b]commémoration[/b], c'est un jour où l'on se souvient ensemble d'un événement important du passé.
{tableau(2, ['1er janvier', 'le jour de l\'An', '8 mai', 'la fin d\'une grande guerre, en 1945', '14 juillet', 'la [b]fête nationale[/b] de la France', '11 novembre', 'la fin d\'une grande guerre, en 1918'], size=20, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Avant[/b], [b]pendant[/b], [b]après[/b] : je range les moments dans l'ordre.
• Le [b]passé[/b] est fini, le [b]présent[/b] c'est maintenant, le [b]futur[/b] n'est pas encore arrivé.
• Le temps passé ne revient jamais.
• Une frise se lit de gauche (avant) à droite (après).
• Grands-parents, parents, enfants : trois [b]générations[/b].
• Une commémoration : on se souvient ensemble du passé.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 1
add('se_reperer', "Se repérer autour de l'école", 'geographie', [
f"""[titre]Les mots pour dire où[/titre]
{tableau(2, ['sur, au-dessus', 'Le chat est [b]sur[/b] le mur.', 'sous, en dessous', 'Le ballon est [b]sous[/b] la table.', 'devant', 'Le maître est [b]devant[/b] le tableau.', 'derrière', 'Le vélo est [b]derrière[/b] l\'arbre.', 'à côté de', 'Je suis assis [b]à côté de[/b] Léa.', 'entre', 'Le livre est [b]entre[/b] les deux cahiers.'], size=20, lignes=True)}""",
f"""[titre]À gauche, à droite[/titre]
{tableau(2, [emo('⬅️', 48), emo('➡️', 48), 'à [b]gauche[/b]', 'à [b]droite[/b]'], size=26)}
[cadre]Je tends le bras du côté de ma main gauche : c'est [b]à gauche[/b]. Du côté de ma main droite : c'est [b]à droite[/b].[/cadre]
[cadre=astuce]Attention : si un ami est en face de moi, sa droite est de [b]mon côté gauche[/b] ![/cadre]""",
f"""[titre]Les lieux de l'école[/titre]
{tableau(2, ['la classe', 'On y apprend.', 'la cour', 'On y joue pendant la récréation.', 'le préau', 'Une partie de la cour avec un toit, pour la pluie.', 'le couloir', 'Il permet d\'aller d\'une salle à l\'autre.', 'les sanitaires', 'Les toilettes et les lavabos.', 'le réfectoire', 'La cantine : on y déjeune à midi.', 'le portail', 'On entre et on sort de l\'école par là.'], size=19, lignes=True)}""",
"""[titre]Un plan, c'est quoi ?[/titre]
Un [b]plan[/b] est un dessin d'un lieu [b]vu de dessus[/b], comme le voit un oiseau qui vole au-dessus.
[plan]
[cadre]Vue de dessus, une table devient un rectangle et une chaise un petit rond.[/cadre]""",
f"""[titre]La légende[/titre]
La [b]légende[/b] explique ce que veulent dire les couleurs et les dessins d'un plan.
[table=2][cell bg=#C9E3FA border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une table d'élève[/cell][cell bg=#F2A541 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une chaise[/cell][cell bg=#2E7D32 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]le tableau[/cell][cell bg=#6EC6F0 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une fenêtre[/cell][cell bg=#8D5524 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]la porte[/cell][/table]
[cadre=astuce]Avec un plan, je peux trouver mon chemin dans un lieu que je ne connais pas.[/cadre]""",
f"""[titre]Le chemin de la maison à l'école[/titre]
Le [b]trajet[/b], c'est le chemin pour aller d'un endroit à un autre.
{tableau(2, ['1', 'Je sors de chez moi et je tourne [b]à droite[/b].', '2', 'Je passe [b]devant[/b] la boulangerie.', '3', 'Je traverse sur le [b]passage piéton[/b].', '4', "J'arrive au [b]portail[/b] de l'école."], size=20, lignes=True)}
[cadre=astuce]Les [b]repères[/b] sont des endroits faciles à reconnaître : une boulangerie, un parc, un rond-point.[/cadre]""",
f"""[titre]Mon quartier, mon village[/titre]
En ville, l'école est dans un [b]quartier[/b]. À la campagne, elle est dans un [b]village[/b].
{tableau(3, [emo('🛣️', 30), 'les rues', 'Un [b]carrefour[/b] : là où des rues se croisent.', emo('🏛️', 30), 'les bâtiments publics', 'la mairie, l\'école, la poste, la bibliothèque', emo('🥖', 30), 'les commerces', 'la boulangerie, la pharmacie, le supermarché', emo('⚽', 30), 'les équipements sportifs', 'le stade, le gymnase, la piscine'], size=19, lignes=True)}""",
f"""[titre]Les panneaux de la rue[/titre]
{tableau(3, [emo('🛑', 30), 'le stop', 'Les voitures doivent s\'arrêter.', emo('🚸', 30), 'attention, enfants', 'Une école est proche : les voitures ralentissent.', emo('🚦', 30), 'le feu', 'Rouge : on s\'arrête. Vert : on peut passer.', emo('🦓', 30), 'le passage piéton', 'Des bandes blanches : c\'est là que l\'on traverse.'], size=19, lignes=True)}
[cadre=astuce]Pour les piétons, le feu montre un [b]petit bonhomme[/b] : rouge, j'attends ; vert, je traverse.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Pour dire où : sur, sous, devant, derrière, à côté de, entre, à gauche, à droite.
• L'école a une classe, une cour, un préau, des couloirs, des sanitaires, un réfectoire, un portail.
• Un [b]plan[/b] montre un lieu [b]vu de dessus[/b]. La [b]légende[/b] explique ses couleurs.
• Le [b]trajet[/b] est le chemin d'un endroit à un autre.
• Les [b]repères[/b] m'aident à trouver mon chemin.[/cadre]""",
])

# =====================================================================  GEOGRAPHIE 2
add('monde_carte', 'Les continents et les océans', 'geographie', [
f"""[titre]La Terre, notre planète[/titre]
{gros('🌍', 70)}
La Terre est une [b]planète[/b]. Elle est ronde comme une boule.
Elle est couverte de [b]terres[/b] et de beaucoup d'[b]eau[/b] : les mers et les océans.
[cadre]Il y a beaucoup plus d'eau que de terre. Vue de l'espace, la Terre est bleue.[/cadre]""",
f"""[titre]Le globe et le planisphère[/titre]
{tableau(2, [emo('🌐', 48), emo('🗺️', 48), 'une boule qui représente la Terre', 'une carte de toute la Terre, mise à plat', 'On le fait tourner : on voit une moitié à la fois.', "On voit toute la Terre d'un seul coup."], entete=['le globe', 'le planisphère'], size=20)}
[cadre=astuce]Pour faire un planisphère, on « déplie » la Terre comme la peau d'une orange qu'on aplatit.[/cadre]""",
"""[titre]Le planisphère[/titre]
[planisphere]
[cadre]Les [b]terres[/b] sont en couleur. L'[b]eau[/b] est en bleu. Chaque couleur est un [b]continent[/b].[/cadre]""",
"""[titre]Les continents[/titre]
Un [b]continent[/b] est une très grande étendue de terre.
[planisphere noms=oui largeur=660]""",
f"""[titre]Les continents à connaître[/titre]
{tableau(2, ['l\'Europe', 'Le continent de la France.', 'l\'Asie', 'Le plus grand continent. Le plus peuplé.', 'l\'Afrique', 'On y trouve le Sahara, un immense désert.', 'l\'Amérique du Nord, l\'Amérique du Sud', 'Deux parties reliées par une bande de terre.', 'l\'Océanie', 'Avec l\'Australie et beaucoup d\'îles.', 'l\'Antarctique', 'Au pôle Sud, couvert de glace. Presque personne n\'y vit.'], size=19, lignes=True)}
[cadre=astuce]On dit parfois « l'Amérique » pour l'Amérique du Nord et l'Amérique du Sud ensemble.[/cadre]""",
"""[titre]Les océans[/titre]
Un [b]océan[/b] est une immense étendue d'eau salée.
[planisphere oceans=tous largeur=640]
[cadre]Les 3 grands océans : l'océan [b]Pacifique[/b] (le plus grand), l'océan [b]Atlantique[/b] et l'océan [b]Indien[/b]. Près des pôles : l'océan Arctique et l'océan Austral.[/cadre]""",
"""[titre]Tous les océans se touchent[/titre]
Les océans ne sont pas séparés : ils se rejoignent tous. Un bateau peut aller d'un océan à l'autre.
[cadre]Sur le planisphère, l'océan Pacifique est coupé en deux : on le voit à gauche [b]et[/b] à droite. C'est le même océan qui fait le tour de la Terre.[/cadre]
[cadre=astuce]L'océan Atlantique est entre l'Amérique, à l'ouest, et l'Europe et l'Afrique, à l'est.[/cadre]""",
"""[titre]Les points cardinaux[/titre]
[planisphere noms=oui cardinaux=oui largeur=600]
[cadre]Sur une carte : le [b]Nord[/b] est en haut, le [b]Sud[/b] en bas, l'[b]Est[/b] à droite et l'[b]Ouest[/b] à gauche.
L'Afrique est au sud de l'Europe. L'Asie est à l'est de l'Europe.[/cadre]""",
"""[titre]Où est la France ?[/titre]
[planisphere seul=europe noms=oui france=oui largeur=620]
[cadre]La France est en [b]Europe[/b], à l'ouest du continent.
Des territoires français sont très loin, au milieu des océans : la Guadeloupe, la Martinique, La Réunion, Mayotte… et la Guyane, en Amérique du Sud.[/cadre]""",
f"""[titre]Où vivent les êtres humains ?[/titre]
{tableau(3, [emo('🏙️', 30), 'beaucoup d\'habitants', 'l\'Asie (la Chine, l\'Inde) et l\'Europe', emo('🏜️', 30), 'très peu d\'habitants', 'les grands déserts, les hautes montagnes,\nles grandes forêts', emo('❄️', 30), 'presque personne', 'l\'Antarctique, très froid'], size=20, lignes=True)}
[cadre]Les endroits où vivent beaucoup de personnes s'appellent des [b]foyers de peuplement[/b]. Le plus grand est en [b]Asie[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le [b]globe[/b] est une boule, le [b]planisphère[/b] une carte à plat de la Terre.
• Les continents : Europe, Asie, Afrique, Amérique du Nord, Amérique du Sud, Océanie, Antarctique.
• Les 3 grands océans : [b]Pacifique[/b], [b]Atlantique[/b], [b]Indien[/b]. Ils se touchent tous.
• Nord en haut, Sud en bas, Est à droite, Ouest à gauche.
• La France est en [b]Europe[/b]. L'Asie est le continent le plus peuplé.[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
SQL = """-- Fiche {titre} (CP) - {domaine}, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', '{matiere}', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

if __name__ == '__main__':
    OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
    TXT = sys.argv[2] if len(sys.argv) > 2 else None
    toutes = ['-- Toutes les fiches de cours Histoire-Geographie CP (2026-11-06), une seule transaction.', 'begin;']
    for cl, code, titre, domaine, pages in FICHES:
        contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
        sql = SQL.format(titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu,
                         domaine=domaine, matiere=MATIERE)
        with open(os.path.join(OUT, f'cp_hg_{code}.sql'), 'w', encoding='utf-8') as f:
            f.write(sql)
        toutes.append(sql)
        if TXT:
            with open(os.path.join(TXT, f'{code}.txt'), 'w', encoding='utf-8') as f:
                f.write(contenu)
        print(code, titre, len(pages), 'p.')
    toutes += ['commit;', 'select fn_publier();']
    with open(os.path.join(OUT, 'cp_histgeo_toutes.sql'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(toutes) + '\n')
    print(len(FICHES), 'fiches')
