-- Toutes les fiches de cours Histoire-Geographie CE1 (2026-11-06), une seule transaction.
begin;
-- Fiche Du passé proche au passé lointain (CE1) - histoire, notion 'passe_proche_lointain'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Du passé proche au passé lointain', $fiche$
[titre]Passé proche, passé lointain[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le passé proche[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le passé lointain[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]il y a [b]peu de temps[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]il y a [b]très longtemps[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]hier, la semaine dernière, l'an dernier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]il y a 100 ans, il y a 1 000 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On s'en souvient.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Personne de vivant ne s'en souvient.[/font_size][/center][/cell][/table]
[cadre]Le passé lointain, on le connaît grâce aux [b]traces[/b] qu'il a laissées : des objets, des monuments, des écrits.[/cadre]
[page]
[titre]Les mots pour dire quand[/titre]
Du plus proche au plus lointain :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]la semaine dernière[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]le mois dernier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]l'an dernier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]il y a 10 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]autrefois[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]il y a 100 ans[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]il y a très longtemps[/font_size][/center][/cell][/table]
[cadre=astuce][b]Autrefois[/b] veut dire « il y a longtemps », à une époque passée.[/cadre]
[page]
[titre]Compter le temps long[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]1 année[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]12 mois[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1 [b]décennie[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]10 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]1 [b]siècle[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]100 ans[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1 [b]millénaire[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1 000 ans[/font_size][/center][/cell][/table]
[cadre=astuce][b]déc[/b]ennie → 10, comme « dix ».
[b]mill[/b]énaire → 1 000, comme « mille ».[/cadre]
[page]
[titre]Je calcule avec les durées[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]2 décennies[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]20 ans[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]3 décennies[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]30 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]1 siècle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]10 décennies[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]2 siècles[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]200 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]1 millénaire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]10 siècles[/font_size][/center][/cell][/table]
[cadre]Un siècle, c'est 10 décennies. Un millénaire, c'est 10 siècles.[/cadre]
[page]
[titre]Les siècles[/titre]
On range les années par paquets de 100 : les [b]siècles[/b].
[cadre]De l'an 1901 à l'an 2000 : le [b]20e siècle[/b].
Depuis l'an 2001 : le [b]21e siècle[/b]. C'est le siècle où nous vivons.[/cadre]
[cadre=astuce]On écrit souvent les siècles en chiffres romains : XXe siècle (20e), XXIe siècle (21e).[/cadre]
[page]
[titre]Ranger du plus ancien au plus récent[/titre]
Sur une frise, on place le plus ancien à [b]gauche[/b] et le plus récent à [b]droite[/b].
[frise points=il_y_a_1_000_ans,il_y_a_100_ans,il_y_a_10_ans,l'an_dernier,aujourd'hui marque=5 debut=passé_lointain fin=présent]
[cadre]Il y a 1 000 ans, c'est [b]plus ancien[/b] qu'il y a 100 ans.[/cadre]
[page]
[titre]Autrefois et aujourd'hui[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]autrefois[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]aujourd'hui[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]s'éclairer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une bougie, une lampe à pétrole[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une ampoule électrique[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]se déplacer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]à pied, à cheval, en calèche[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]en voiture, en train, en avion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]téléphoner[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un téléphone fixe à cadran[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un téléphone portable[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]écrire[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]une plume et de l'encre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un stylo, un ordinateur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]laver le linge[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]à la main, au lavoir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]avec une machine à laver[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]passé proche[/b] : il y a peu de temps. Le [b]passé lointain[/b] : il y a très longtemps.
• 1 décennie = [b]10 ans[/b]. 1 siècle = [b]100 ans[/b]. 1 millénaire = [b]1 000 ans[/b].
• Nous vivons au [b]21e siècle[/b] (XXIe).
• Sur une frise : le plus ancien à gauche, le plus récent à droite.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'passe_proche_lointain'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les grandes périodes de l'histoire (CE1) - histoire, notion 'grandes_periodes'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Les grandes périodes de l''histoire', $fiche$
[titre]Les 5 grandes périodes[/titre]
Pour s'y retrouver, on découpe l'histoire en [b]5 grandes périodes[/b].
[periodes]
[cadre]Préhistoire → Antiquité → Moyen Âge → Temps modernes → Époque contemporaine.[/cadre]
[page]
[titre]Avant et après Jésus-Christ[/titre]
Pour compter les années, on part de l'[b]an 1[/b], l'année de la naissance de Jésus-Christ dans notre calendrier.
[frise points=3000_av._J.-C.,52_av._J.-C.,an_1,476,1492,1789 marque=3 debut=avant fin=après]
[cadre]Avant l'an 1, on écrit « [b]av. J.-C.[/b] » : 3000 av. J.-C. Après l'an 1, on écrit simplement l'année : 1492.[/cadre]
[cadre=astuce]Avant J.-C., plus le nombre est grand, plus c'est ancien : 3000 av. J.-C. est plus ancien que 52 av. J.-C.[/cadre]
[page]
[titre]La Préhistoire[/titre]
[periodes marque=1]
Elle commence avec les [b]premiers humains[/b], il y a environ 3 millions d'années. Elle finit avec l'invention de l'[b]écriture[/b], vers 3000 av. J.-C.
[cadre]Les humains chassent et cueillent, puis apprennent à cultiver et à élever des animaux. Ils taillent la pierre et peignent dans les grottes.[/cadre]
[cadre=astuce]Une figure : [b]Ötzi[/b], un homme qui vivait il y a plus de 5 000 ans, retrouvé dans la glace des Alpes.[/cadre]
[page]
[titre]L'Antiquité[/titre]
[periodes marque=2]
De l'invention de l'écriture (vers 3000 av. J.-C.) à la fin de l'Empire romain d'Occident, en [b]476[/b].
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Cléopâtre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une reine d'Égypte[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Jules César[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un général romain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Vercingétorix[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un chef gaulois, vaincu à Alésia en 52 av. J.-C.[/font_size][/center][/cell][/table]
[cadre]C'est le temps des Égyptiens et de leurs pyramides, des Grecs, des Romains et des Gaulois.[/cadre]
[page]
[titre]Le Moyen Âge[/titre]
[periodes marque=3]
De [b]476[/b] à [b]1492[/b]. C'est le temps des châteaux forts, des chevaliers, des seigneurs et des cathédrales.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Charlemagne[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un empereur, couronné en l'an 800[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Aliénor d'Aquitaine[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]une reine de France, puis d'Angleterre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Jeanne d'Arc[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une jeune fille qui a combattu pendant la guerre de Cent Ans[/font_size][/center][/cell][/table]
[page]
[titre]Les Temps modernes[/titre]
[periodes marque=4]
De [b]1492[/b] à [b]1789[/b]. C'est le temps des grands voyages en bateau et des rois puissants.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Christophe Colomb[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un navigateur, arrivé en Amérique en 1492[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Léonard de Vinci[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un peintre et inventeur, auteur de la Joconde[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Louis XIV[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le « Roi-Soleil », qui a fait construire Versailles[/font_size][/center][/cell][/table]
[page]
[titre]L'Époque contemporaine[/titre]
[periodes marque=5]
De [b]1789[/b] (la Révolution française) à [b]aujourd'hui[/b]. C'est le temps de l'électricité, des trains, des voitures, des avions et des ordinateurs.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Napoléon Ier[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un empereur des Français[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Louis Pasteur[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un savant, inventeur du vaccin contre la rage[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Marie Curie[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une savante, deux fois prix Nobel[/font_size][/center][/cell][/table]
[page]
[titre]Les dates qui séparent les périodes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]vers 3000 av. J.-C.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'invention de l'[b]écriture[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]476[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la fin de l'[b]Empire romain[/b] d'Occident[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1492[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Christophe Colomb arrive en [b]Amérique[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]1789[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la [b]Révolution[/b] française[/font_size][/center][/cell][/table]
[cadre=astuce]Chaque période commence par un grand événement : je retiens ces 4 dates.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Préhistoire[/b] : jusqu'à l'écriture, vers 3000 av. J.-C.
• [b]Antiquité[/b] : jusqu'en 476. Cléopâtre, Jules César, Vercingétorix.
• [b]Moyen Âge[/b] : de 476 à 1492. Charlemagne, Jeanne d'Arc.
• [b]Temps modernes[/b] : de 1492 à 1789. Christophe Colomb, Louis XIV.
• [b]Époque contemporaine[/b] : depuis 1789. Napoléon, Marie Curie.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'grandes_periodes'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les traces du passé (CE1) - histoire, notion 'traces_passe'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Les traces du passé', $fiche$
[titre]Comment connaît-on le passé ?[/titre]
[center][font_size=60]🔎[/font_size][/center]
Personne ne peut retourner dans le passé. Mais le passé laisse des [b]traces[/b].
[cadre]Une [b]trace[/b], c'est tout ce qui reste du passé et qui nous aide à le comprendre.[/cadre]
[page]
[titre]Les sortes de traces[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🦴[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les fossiles et les ossements[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des os, des coquillages pris dans la pierre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🏛️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les monuments et les ruines[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des temples, des châteaux, des églises[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🏺[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les objets[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des outils, des poteries, des bijoux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]📜[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les écrits[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des lettres, des livres, des registres[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🖼️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les images[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des peintures, des photos[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🗣️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les témoignages[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des souvenirs racontés par des personnes[/font_size][/center][/cell][/table]
[page]
[titre]Les fossiles[/titre]
[center][font_size=54]🐚 🦴 🦖[/font_size][/center]
Un [b]fossile[/b] est la trace d'un animal ou d'une plante très ancienne, conservée dans la pierre : un os, un coquillage, une empreinte.
[cadre=astuce]Les dinosaures ont disparu il y a environ 66 millions d'années, bien avant les premiers humains. Aucun humain n'a vu de dinosaure vivant ![/cadre]
[page]
[titre]Les traces de la Préhistoire[/titre]
[center][font_size=54]🐎 🦌 🐂[/font_size][/center]
[cadre]Dans la grotte de [b]Lascaux[/b], en France, des humains ont peint des animaux il y a environ 18 000 ans.[/cadre]
Les archéologues retrouvent aussi des [b]outils en pierre taillée[/b], des ossements et les restes de foyers où l'on faisait du feu.
[page]
[titre]Dater une trace[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la trace[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la période[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la grotte de Lascaux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Préhistoire[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les pyramides d'Égypte, le pont du Gard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Antiquité[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un château fort, la cathédrale Notre-Dame de Paris[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Moyen Âge[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le château de Versailles[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][b]Temps modernes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la tour Eiffel, construite en 1889[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]Époque contemporaine[/b][/font_size][/center][/cell][/table]
[page]
[titre]Les métiers du passé[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'[b]archéologue[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Il fouille le sol pour retrouver des objets et des restes enfouis.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'[b]historien[/b], l'[b]historienne[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Il ou elle étudie les traces et les documents
pour raconter ce qui s'est passé.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'[b]archiviste[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Il ou elle garde et range les vieux documents :
les [b]archives[/b].[/font_size][/center][/cell][/table]
[page]
[titre]Les témoignages[/titre]
Les personnes âgées peuvent raconter leurs [b]souvenirs[/b] : c'est un [b]témoignage[/b].
[cadre]Les photos de famille, les souvenirs de mes grands-parents sont des traces d'un passé proche.[/cadre]
[cadre=astuce]Pour un passé très lointain, il n'y a plus de témoins : on utilise les autres traces.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le passé laisse des [b]traces[/b] : fossiles, monuments, objets, écrits, images, témoignages.
• Les dinosaures ont disparu bien avant les premiers humains.
• Chaque trace appartient à une période : Lascaux → Préhistoire, la tour Eiffel → Époque contemporaine.
• L'[b]archéologue[/b] fouille, l'[b]historien[/b] étudie, l'[b]archiviste[/b] garde les documents.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'traces_passe'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Où vivent les êtres humains ? (CE1) - geographie, notion 'terre_peuplee'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Où vivent les êtres humains ?', $fiche$
[titre]La Terre est peuplée[/titre]
[center][font_size=60]🌍 👨‍👩‍👧‍👦[/font_size][/center]
Plus de [b]8 milliards[/b] d'êtres humains vivent sur la Terre.
[cadre]Mais ils ne vivent pas partout : certains endroits ont beaucoup d'habitants, d'autres presque pas.[/cadre]
[page]
[titre]Les grands foyers de peuplement[/titre]
[planisphere pale=oui foyers=oui largeur=640]
[cadre]Un [b]foyer de peuplement[/b] est une région où vivent énormément de personnes. Les 3 plus grands : l'[b]Asie de l'Est[/b], l'[b]Asie du Sud[/b] et l'[b]Europe[/b].[/cadre]
[page]
[titre]Beaucoup ou peu d'habitants[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🏙️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]beaucoup d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Asie : presque 6 humains sur 10 y vivent[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🏜️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]très peu d'habitants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les déserts chauds, comme le Sahara[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🏔️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]très peu d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les hautes montagnes[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🌳[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]très peu d'habitants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les grandes forêts tropicales[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]❄️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]presque personne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les régions glacées, l'Antarctique[/font_size][/center][/cell][/table]
[page]
[titre]Une grande ville sur chaque continent[/titre]
[planisphere pale=oui villes=oui largeur=660]
[page]
[titre]Les grandes villes à connaître[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le continent[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]une ville très peuplée[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Europe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]Paris[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Asie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]Tokyo[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Afrique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]Lagos[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Amérique du Nord[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]New York[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Amérique du Sud[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]São Paulo[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Océanie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]Sydney[/b][/font_size][/center][/cell][/table]
[cadre=astuce]En Antarctique, il fait trop froid : il n'y a aucune ville.[/cadre]
[page]
[titre]La ville[/titre]
[center][font_size=50]🏙️[/font_size][/center]
La [b]ville[/b] a beaucoup d'habitants.
[cadre]On y trouve des immeubles, beaucoup de rues, des magasins, des écoles, un hôpital, et des transports : bus, tramway, métro.[/cadre]
[page]
[titre]Le village et la campagne[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la ville[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le village[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]peu d'habitants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]des immeubles[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]des maisons[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup de magasins[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]peu de magasins[/font_size][/center][/cell][/table]
[cadre]Le village est entouré par la [b]campagne[/b] : des champs, des prés, des forêts et des fermes.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Plus de 8 milliards d'humains vivent sur la Terre, mais pas partout.
• Les 3 grands foyers de peuplement : Asie de l'Est, Asie du Sud, Europe.
• Peu d'habitants : déserts, hautes montagnes, grandes forêts, régions glacées.
• Paris, Tokyo, Lagos, New York, São Paulo, Sydney : des villes très peuplées.
• La ville a beaucoup d'habitants ; le village, peu, au milieu de la campagne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'terre_peuplee'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Climats et paysages du monde (CE1) - geographie, notion 'climats_paysages'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Climats et paysages du monde', $fiche$
[titre]Météo et climat[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la météo[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le climat[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le temps qu'il fait [b]un jour[/b] : soleil, pluie, vent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le temps [b]habituel[/b] d'une région, année après année[/font_size][/center][/cell][/table]
[cadre]« Aujourd'hui il pleut » : c'est la [b]météo[/b].
« Ici, l'été est chaud et sec » : c'est le [b]climat[/b].[/cadre]
[page]
[titre]Les 3 zones climatiques[/titre]
[planisphere pale=oui zones=oui largeur=640]
[cadre]Près des pôles : la zone [b]froide[/b]. Autour de l'équateur : la zone [b]chaude[/b]. Entre les deux : la zone [b]tempérée[/b].[/cadre]
[page]
[titre]Chaud, tempéré ou froid[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]❄️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la zone froide[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Il fait froid toute l'année.
Il y a de la glace et peu de plantes.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🌳[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la zone tempérée[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Ni trop chaud, ni trop froid.
Il y a 4 saisons.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🌴[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la zone chaude[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Il fait chaud toute l'année.
Il y a une saison sèche et une saison des pluies,
ou de la pluie toute l'année.[/font_size][/center][/cell][/table]
[page]
[titre]La France dans les 3 zones[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]zone tempérée[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la France métropolitaine, en Europe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]zone chaude[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la Guadeloupe, la Martinique, la Guyane, La Réunion, Mayotte[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]zone froide[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la Terre Adélie, en Antarctique[/font_size][/center][/cell][/table]
[cadre]Grâce à ses territoires d'outre-mer, la France est présente dans les 3 zones climatiques.[/cadre]
[page]
[titre]Les forêts[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la forêt tempérée[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la forêt tropicale[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🌳[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🌴[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les arbres perdent leurs feuilles
en automne : chênes, hêtres.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Toujours verte, très dense,
chaude et humide.[/font_size][/center][/cell][/table]
[cadre=astuce]Les plus grandes forêts tropicales : la forêt [b]amazonienne[/b], la forêt du bassin du [b]Congo[/b] et la forêt d'[b]Indonésie[/b].[/cadre]
[page]
[titre]Les grandes forêts du monde[/titre]
[planisphere pale=oui forets=oui largeur=660]
[page]
[titre]Prairie et savane[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la prairie[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la savane[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🐄[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🦒[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]de l'herbe, dans la zone tempérée[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]de hautes herbes et quelques arbres, dans la zone chaude[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On y élève des vaches et des moutons.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On y voit des lions, des zèbres, des girafes.[/font_size][/center][/cell][/table]
[page]
[titre]Les déserts[/titre]
Un [b]désert[/b] est un endroit où il ne pleut presque jamais.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le désert chaud[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le désert froid[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🏜️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🧊[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le [b]Sahara[/b], en Afrique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'[b]Antarctique[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]du sable, des cailloux, très chaud le jour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]de la glace, très froid[/font_size][/center][/cell][/table]
[page]
[titre]Décrire un paysage[/titre]
[paysage]
[cadre]Sur une photo, ce qui est devant, en bas, est au [b]premier plan[/b]. Ce qui est au fond est à l'[b]arrière-plan[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• La [b]météo[/b] : le temps d'un jour. Le [b]climat[/b] : le temps habituel d'une région.
• 3 zones : [b]froide[/b] (pôles), [b]tempérée[/b], [b]chaude[/b] (équateur). La France métropolitaine est tempérée.
• Forêt tempérée ou tropicale ; prairie ou savane ; désert chaud (Sahara) ou froid (Antarctique).
• Un paysage : le premier plan devant, l'arrière-plan au fond.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'climats_paysages'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Montagnes, plaines et fleuves (CE1) - geographie, notion 'reliefs_eau'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'histoire_geo', 'Montagnes, plaines et fleuves', $fiche$
[titre]Les formes du relief[/titre]
[relief]
[cadre]La [b]montagne[/b] est haute, avec des sommets. La [b]plaine[/b] est plate et basse. Le [b]plateau[/b] est plat mais en hauteur. La [b]vallée[/b] est un creux entre des montagnes.[/cadre]
[page]
[titre]Les grandes chaînes de montagnes[/titre]
[planisphere pale=oui montagnes=oui largeur=660]
[page]
[titre]Les montagnes à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'[b]Himalaya[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Asie : les plus hautes montagnes du monde, avec l'Everest[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]les [b]Alpes[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Europe : en France, le mont Blanc[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les [b]Andes[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]les [b]Rocheuses[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Amérique du Nord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'[b]Atlas[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Afrique[/font_size][/center][/cell][/table]
[cadre=astuce]Une suite de montagnes s'appelle une [b]chaîne de montagnes[/b].[/cadre]
[page]
[titre]Fleuve ou rivière ?[/titre]
[cours_eau]
[cadre]Un [b]fleuve[/b] se jette dans la mer ou l'océan. Une [b]rivière[/b] se jette dans un fleuve ou dans une autre rivière.
La [b]source[/b] est l'endroit où il naît, l'[b]embouchure[/b] l'endroit où il arrive dans la mer.[/cadre]
[page]
[titre]Les grands fleuves du monde[/titre]
[planisphere pale=oui fleuves=oui largeur=640]
[cadre]L'[b]Amazone[/b] (Amérique du Sud) porte plus d'eau que tous les autres. Le [b]Nil[/b] (Afrique) traverse le désert. Le [b]Mississippi[/b] coule en Amérique du Nord.[/cadre]
[page]
[titre]Les humains et les fleuves[/titre]
[center][font_size=54]🏞️ 🚢[/font_size][/center]
Depuis toujours, beaucoup de villes sont construites au bord des fleuves. Paris est au bord de la [b]Seine[/b].
[cadre]Le fleuve donne de l'eau pour boire et pour cultiver les champs. Les bateaux s'en servent pour transporter des marchandises.[/cadre]
[cadre=astuce]Cherche le fleuve ou la rivière le plus proche de chez toi ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Montagne (haute), plaine (plate et basse), plateau (plat et haut), vallée (creux).
• Les chaînes : Himalaya, Alpes, Andes, Rocheuses, Atlas.
• Un [b]fleuve[/b] va jusqu'à la mer ; une [b]rivière[/b] se jette dans un autre cours d'eau.
• Les grands fleuves : Amazone, Nil, Mississippi.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'reliefs_eau'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
