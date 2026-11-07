-- Toutes les fiches de cours Histoire-Geographie CP (2026-11-06), une seule transaction.
begin;
-- Fiche Le jour, la nuit et les saisons (CP) - histoire, notion 'temps_nature'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Le jour, la nuit et les saisons', $fiche$
[titre]Le jour et la nuit[/titre]
Le matin, le Soleil se lève. Le soir, il se couche. Puis vient la nuit.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le jour[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la nuit[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][font_size=40]☀️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][font_size=40]🌙[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Il fait [b]clair[/b].
Le Soleil brille.
On travaille, on joue.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Il fait [b]noir[/b].
On voit la Lune et les étoiles.
On dort.[/font_size][/center][/cell][/table]
[cadre]Le jour et la nuit reviennent toujours, l'un après l'autre.[/cadre]
[page]
[titre]Pourquoi le jour et la nuit ?[/titre]
[terre]
La Terre est une grosse boule qui [b]tourne sur elle-même[/b].
Le côté tourné vers le Soleil est éclairé : c'est le [b]jour[/b]. L'autre côté est dans le noir : c'est la [b]nuit[/b].
[page]
[titre]Un tour en une journée[/titre]
La Terre fait [b]un tour complet[/b] sur elle-même en [b]24 heures[/b].
[cadre]Une journée de 24 heures = un jour + une nuit.[/cadre]
Quand c'est le jour en France, c'est la nuit de l'autre côté de la Terre.
[cadre=astuce]Ce n'est pas le Soleil qui tourne autour de nous : c'est la Terre qui tourne ! En classe, on peut le voir avec un [b]globe terrestre[/b] et une lampe.[/cadre]
[page]
[titre]Les moments de la journée[/titre]
Une journée a plusieurs moments, toujours dans le même ordre.
[frise points=le_matin,midi,l'après-midi,le_soir,la_nuit]
[cadre]Le [b]matin[/b], je me lève, je prends mon [b]petit-déjeuner[/b] et je vais à l'école.
À [b]midi[/b], je déjeune.
L'[b]après-midi[/b], je travaille ou je joue.
Le [b]soir[/b], je dîne. La [b]nuit[/b], je dors.[/cadre]
[page]
[titre]Les quatre saisons[/titre]
Une année a [b]4 saisons[/b]. Elles reviennent toujours dans le même ordre.
[roue liste=le_printemps,l'été,l'automne,l'hiver]
[cadre]printemps → été → automne → hiver → et de nouveau le printemps…[/cadre]
[page]
[titre]Le printemps et l'été[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le printemps[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]l'été[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🌸[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]☀️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]commence vers le [b]20 mars[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]commence vers le [b]21 juin[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il fait plus doux.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il fait [b]chaud[/b].[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les fleurs poussent.
Les arbres font des feuilles.
Les oiseaux font leur nid.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les journées sont très longues.
On récolte les fruits.
C'est le temps des grandes vacances.[/font_size][/center][/cell][/table]
[page]
[titre]L'automne et l'hiver[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]l'automne[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]l'hiver[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]🍂[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=40]❄️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]commence vers le [b]22 septembre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]commence vers le [b]21 décembre[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il fait frais.
Il pleut souvent.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il fait [b]froid[/b].
Il gèle, parfois il neige.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les feuilles jaunissent et tombent.
On ramasse les châtaignes.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les journées sont courtes.
Les arbres n'ont plus de feuilles.[/font_size][/center][/cell][/table]
[page]
[titre]Je m'habille selon la saison[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la saison[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le temps[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]je porte[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]printemps[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]doux, parfois de la pluie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une veste légère[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]été[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]chaud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un short, une casquette[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]automne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]frais, de la pluie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un imperméable, des bottes[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]hiver[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]froid[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un manteau, un bonnet, une écharpe, des gants[/font_size][/center][/cell][/table]
[page]
[titre]Partout pareil ?[/titre]
En France [b]métropolitaine[/b] (la partie de la France qui est en Europe), on a [b]4 saisons[/b] bien différentes.
[cadre]En Guadeloupe, en Martinique, en Guyane, à La Réunion ou à Mayotte, il fait chaud presque toute l'année.
On parle plutôt d'une [b]saison sèche[/b] et d'une [b]saison des pluies[/b].[/cadre]
[cadre=astuce]Les saisons ne sont pas les mêmes partout : elles dépendent de l'endroit où l'on vit.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• La Terre [b]tourne sur elle-même[/b] en [b]24 heures[/b].
• Le côté éclairé par le Soleil a le [b]jour[/b], l'autre côté a la [b]nuit[/b].
• La journée : le matin, midi, l'après-midi, le soir, la nuit.
• L'année a [b]4 saisons[/b] : printemps, été, automne, hiver.
• Elles reviennent toujours dans le même ordre.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'temps_nature'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Mesurer le temps (CP) - histoire, notion 'mesurer_temps'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Mesurer le temps', $fiche$
[titre]Du plus long au plus court[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]1 année[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]12[/b] mois[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1 mois[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]un peu plus de [b]4[/b] semaines[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]1 semaine[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]7[/b] jours[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]1 jour[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24][b]24[/b] heures[/font_size][/center][/cell][/table]
[cadre]L'année est le plus long. Puis le mois, la semaine, le jour et l'heure.[/cadre]
[page]
[titre]Les 7 jours de la semaine[/titre]
[roue liste=lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche marque=1]
[cadre]La semaine commence le [b]lundi[/b] et finit le [b]dimanche[/b]. Puis elle recommence.
Le samedi et le dimanche forment le [b]week-end[/b].[/cadre]
[page]
[titre]Hier, aujourd'hui, demain[/titre]
Si aujourd'hui, c'est [b]mercredi[/b] :
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]avant-hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]aujourd'hui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]demain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]après-demain[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]lundi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]mardi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]mercredi[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]jeudi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]vendredi[/font_size][/center][/cell][/table]
[cadre=astuce][b]Hier[/b], c'est le jour d'avant. [b]Demain[/b], c'est le jour d'après.[/cadre]
[page]
[titre]Les 12 mois de l'année[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]1. janvier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]2. février[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]3. mars[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]4. avril[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]5. mai[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]6. juin[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]7. juillet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]8. août[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]9. septembre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]10. octobre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]11. novembre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]12. décembre[/font_size][/center][/cell][/table]
[cadre]L'année commence le [b]1er janvier[/b] et finit le [b]31 décembre[/b].[/cadre]
[page]
[titre]Combien de jours dans un mois ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]31 jours[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]janvier, mars, mai, juillet, août, octobre, décembre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]30 jours[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]avril, juin, septembre, novembre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]28 ou 29 jours[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]février, le plus court[/font_size][/center][/cell][/table]
[cadre=astuce]Je ferme mes poings. Je dis les mois sur les bosses et les creux : une bosse = 31 jours, un creux = 30 jours (ou février).[/cadre]
[cadre]Une année a [b]365 jours[/b] (366 quand février a 29 jours).[/cadre]
[page]
[titre]Calendrier, éphéméride, emploi du temps[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=34]📅[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le calendrier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Tous les jours de l'année, mois par mois.
On y note les anniversaires, les vacances.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=34]📆[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'éphéméride[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Un bloc avec [b]une feuille par jour[/b].
Chaque matin, on enlève la feuille d'hier.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=34]📋[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'emploi du temps[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Ce qu'on fait en classe,
jour après jour, heure après heure.[/font_size][/center][/cell][/table]
[page]
[titre]Lire l'heure[/titre]
Une horloge a deux aiguilles :
[cadre]La [b]petite aiguille[/b] montre les [b]heures[/b].
La [b]grande aiguille[/b] montre les [b]minutes[/b].[/cadre]
[horloge heures=8h,12h,4h]
[cadre=astuce]Quand la grande aiguille est sur le [b]12[/b], c'est une heure pile : 8 heures, midi, 4 heures.[/cadre]
[page]
[titre]Montre à aiguilles, montre à chiffres[/titre]
La montre [b]à aiguilles[/b] s'appelle aussi [b]analogique[/b]. La montre [b]à chiffres[/b] s'appelle [b]numérique[/b].
[horloge heures=3h,7h30 numerique=oui]
[cadre]Sur l'écran, le nombre avant les deux points ( : ) donne les [b]heures[/b], le nombre après donne les [b]minutes[/b].
7:30 se lit [b]sept heures trente[/b] (ou sept heures et demie).[/cadre]
[page]
[titre]Les objets pour mesurer le temps[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]⏳[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le sablier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Le sable coule : il mesure un temps court.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][font_size=30]⌚[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la montre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Au poignet, elle donne l'heure.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]⏰[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le réveil[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il sonne pour nous réveiller.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][font_size=30]🕰️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la pendule[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Posée ou accrochée au mur, elle donne l'heure.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]⏱️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le chronomètre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Il mesure le temps d'une course.[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• 1 année = [b]12 mois[/b] (365 jours).
• 1 semaine = [b]7 jours[/b], du lundi au dimanche.
• 1 jour = [b]24 heures[/b].
• Petite aiguille → les heures. Grande aiguille → les minutes.
• Le calendrier montre les jours de l'année, l'éphéméride un jour à la fois.
• Le sablier, la montre, le réveil, la pendule mesurent le temps.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mesurer_temps'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Avant, maintenant, après (CP) - histoire, notion 'situer_temps'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Avant, maintenant, après', $fiche$
[titre]Avant, pendant, après[/titre]
[frise points=avant,pendant,après]
[cadre][b]Avant[/b] le repas, je me lave les mains.
[b]Pendant[/b] le repas, je mange.
[b]Après[/b] le repas, je débarrasse la table.[/cadre]
[cadre=astuce]Deux choses qui arrivent au même moment se passent [b]en même temps[/b] : je mange [b]pendant que[/b] ma sœur boit.[/cadre]
[page]
[titre]Passé, présent, futur[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le passé[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le présent[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le futur[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]c'est fini[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]c'est maintenant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]ça n'est pas encore arrivé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]aujourd'hui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]demain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]j'ai joué[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]je joue[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]je jouerai[/font_size][/center][/cell][/table]
[cadre]Les verbes et les petits mots du temps me disent si c'est [b]passé[/b], [b]présent[/b] ou [b]futur[/b].[/cadre]
[page]
[titre]Les mots du temps[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le passé[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le présent[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le futur[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]aujourd'hui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]demain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]avant-hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]maintenant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]après-demain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]autrefois[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en ce moment[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]bientôt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]il y a longtemps[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ce matin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]plus tard[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'an dernier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]cette année[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'an prochain[/font_size][/center][/cell][/table]
[page]
[titre]Le temps passé ne revient pas[/titre]
[frise points=bébé,2_ans,4_ans,6_ans,plus_tard marque=4 debut=passé fin=futur]
[cadre]Je grandis. Je ne peux pas redevenir un bébé. Le temps avance toujours dans le même sens : du [b]passé[/b] vers le [b]futur[/b].[/cadre]
[cadre=astuce]Les jours et les saisons reviennent chaque année, mais un moment passé ne revient [b]jamais[/b].[/cadre]
[page]
[titre]La frise chronologique[/titre]
Une [b]frise chronologique[/b] est une ligne sur laquelle on range les événements [b]dans l'ordre[/b].
[frise points=8_h_30_arrivée,10_h_récréation,12_h_cantine,16_h_30_sortie]
[cadre]On la lit de [b]gauche à droite[/b] : à gauche, ce qui arrive en premier ; à droite, ce qui arrive en dernier.[/cadre]
[page]
[titre]Les générations[/titre]
Une [b]génération[/b], ce sont les personnes nées à peu près à la même époque.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][font_size=34]👵👴[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]les [b]grands-parents[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][font_size=34]👩👨[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]les [b]parents[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][font_size=34]🧒👧[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]les [b]enfants[/b] : moi, mes frères et sœurs,
mes cousins et mes cousines[/font_size][/center][/cell][/table]
[cadre]Les parents de mes grands-parents sont mes [b]arrière-grands-parents[/b].[/cadre]
[page]
[titre]L'arbre généalogique[/titre]
L'[b]arbre généalogique[/b] montre les personnes d'une famille et leurs liens.
[arbre]
[cadre=astuce]Les plus âgés sont en haut, les plus jeunes en bas. Le papa de mon papa est mon [b]grand-père[/b]. Chaque famille est différente.[/cadre]
[page]
[titre]Les dates qu'on fête[/titre]
Mon [b]anniversaire[/b] revient chaque année, le jour de ma naissance.
Une [b]commémoration[/b], c'est un jour où l'on se souvient ensemble d'un événement important du passé.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1er janvier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le jour de l'An[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]8 mai[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la fin d'une grande guerre, en 1945[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]14 juillet[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]fête nationale[/b] de la France[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]11 novembre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la fin d'une grande guerre, en 1918[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Avant[/b], [b]pendant[/b], [b]après[/b] : je range les moments dans l'ordre.
• Le [b]passé[/b] est fini, le [b]présent[/b] c'est maintenant, le [b]futur[/b] n'est pas encore arrivé.
• Le temps passé ne revient jamais.
• Une frise se lit de gauche (avant) à droite (après).
• Grands-parents, parents, enfants : trois [b]générations[/b].
• Une commémoration : on se souvient ensemble du passé.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'situer_temps'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Se repérer autour de l'école (CP) - geographie, notion 'se_reperer'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Se repérer autour de l''école', $fiche$
[titre]Les mots pour dire où[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]sur, au-dessus[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Le chat est [b]sur[/b] le mur.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]sous, en dessous[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Le ballon est [b]sous[/b] la table.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]devant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Le maître est [b]devant[/b] le tableau.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]derrière[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Le vélo est [b]derrière[/b] l'arbre.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]à côté de[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Je suis assis [b]à côté de[/b] Léa.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]entre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Le livre est [b]entre[/b] les deux cahiers.[/font_size][/center][/cell][/table]
[page]
[titre]À gauche, à droite[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][font_size=48]⬅️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26][font_size=48]➡️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]à [b]gauche[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]à [b]droite[/b][/font_size][/center][/cell][/table]
[cadre]Je tends le bras du côté de ma main gauche : c'est [b]à gauche[/b]. Du côté de ma main droite : c'est [b]à droite[/b].[/cadre]
[cadre=astuce]Attention : si un ami est en face de moi, sa droite est de [b]mon côté gauche[/b] ![/cadre]
[page]
[titre]Les lieux de l'école[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la classe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]On y apprend.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la cour[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]On y joue pendant la récréation.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le préau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Une partie de la cour avec un toit, pour la pluie.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le couloir[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Il permet d'aller d'une salle à l'autre.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les sanitaires[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Les toilettes et les lavabos.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le réfectoire[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]La cantine : on y déjeune à midi.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le portail[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]On entre et on sort de l'école par là.[/font_size][/center][/cell][/table]
[page]
[titre]Un plan, c'est quoi ?[/titre]
Un [b]plan[/b] est un dessin d'un lieu [b]vu de dessus[/b], comme le voit un oiseau qui vole au-dessus.
[plan]
[cadre]Vue de dessus, une table devient un rectangle et une chaise un petit rond.[/cadre]
[page]
[titre]La légende[/titre]
La [b]légende[/b] explique ce que veulent dire les couleurs et les dessins d'un plan.
[table=2][cell bg=#C9E3FA border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une table d'élève[/cell][cell bg=#F2A541 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une chaise[/cell][cell bg=#2E7D32 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]le tableau[/cell][cell bg=#6EC6F0 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]une fenêtre[/cell][cell bg=#8D5524 border=#classe padding=40,6,40,6] [/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6]la porte[/cell][/table]
[cadre=astuce]Avec un plan, je peux trouver mon chemin dans un lieu que je ne connais pas.[/cadre]
[page]
[titre]Le chemin de la maison à l'école[/titre]
Le [b]trajet[/b], c'est le chemin pour aller d'un endroit à un autre.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]1[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Je sors de chez moi et je tourne [b]à droite[/b].[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]2[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Je passe [b]devant[/b] la boulangerie.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]3[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Je traverse sur le [b]passage piéton[/b].[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]4[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]J'arrive au [b]portail[/b] de l'école.[/font_size][/center][/cell][/table]
[cadre=astuce]Les [b]repères[/b] sont des endroits faciles à reconnaître : une boulangerie, un parc, un rond-point.[/cadre]
[page]
[titre]Mon quartier, mon village[/titre]
En ville, l'école est dans un [b]quartier[/b]. À la campagne, elle est dans un [b]village[/b].
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🛣️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les rues[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Un [b]carrefour[/b] : là où des rues se croisent.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🏛️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les bâtiments publics[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la mairie, l'école, la poste, la bibliothèque[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🥖[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les commerces[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la boulangerie, la pharmacie, le supermarché[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]⚽[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les équipements sportifs[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le stade, le gymnase, la piscine[/font_size][/center][/cell][/table]
[page]
[titre]Les panneaux de la rue[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🛑[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le stop[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Les voitures doivent s'arrêter.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🚸[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]attention, enfants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Une école est proche : les voitures ralentissent.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][font_size=30]🚦[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le feu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Rouge : on s'arrête. Vert : on peut passer.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19][font_size=30]🦓[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le passage piéton[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Des bandes blanches : c'est là que l'on traverse.[/font_size][/center][/cell][/table]
[cadre=astuce]Pour les piétons, le feu montre un [b]petit bonhomme[/b] : rouge, j'attends ; vert, je traverse.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Pour dire où : sur, sous, devant, derrière, à côté de, entre, à gauche, à droite.
• L'école a une classe, une cour, un préau, des couloirs, des sanitaires, un réfectoire, un portail.
• Un [b]plan[/b] montre un lieu [b]vu de dessus[/b]. La [b]légende[/b] explique ses couleurs.
• Le [b]trajet[/b] est le chemin d'un endroit à un autre.
• Les [b]repères[/b] m'aident à trouver mon chemin.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'se_reperer'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les continents et les océans (CP) - geographie, notion 'monde_carte'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'histoire_geo', 'Les continents et les océans', $fiche$
[titre]La Terre, notre planète[/titre]
[center][font_size=70]🌍[/font_size][/center]
La Terre est une [b]planète[/b]. Elle est ronde comme une boule.
Elle est couverte de [b]terres[/b] et de beaucoup d'[b]eau[/b] : les mers et les océans.
[cadre]Il y a beaucoup plus d'eau que de terre. Vue de l'espace, la Terre est bleue.[/cadre]
[page]
[titre]Le globe et le planisphère[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le globe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le planisphère[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=48]🌐[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=48]🗺️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une boule qui représente la Terre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une carte de toute la Terre, mise à plat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On le fait tourner : on voit une moitié à la fois.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]On voit toute la Terre d'un seul coup.[/font_size][/center][/cell][/table]
[cadre=astuce]Pour faire un planisphère, on « déplie » la Terre comme la peau d'une orange qu'on aplatit.[/cadre]
[page]
[titre]Le planisphère[/titre]
[planisphere]
[cadre]Les [b]terres[/b] sont en couleur. L'[b]eau[/b] est en bleu. Chaque couleur est un [b]continent[/b].[/cadre]
[page]
[titre]Les continents[/titre]
Un [b]continent[/b] est une très grande étendue de terre.
[planisphere noms=oui largeur=660]
[page]
[titre]Les continents à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Europe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Le continent de la France.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Asie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Le plus grand continent. Le plus peuplé.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Afrique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]On y trouve le Sahara, un immense désert.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Amérique du Nord, l'Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Deux parties reliées par une bande de terre.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'Océanie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Avec l'Australie et beaucoup d'îles.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'Antarctique[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Au pôle Sud, couvert de glace. Presque personne n'y vit.[/font_size][/center][/cell][/table]
[cadre=astuce]On dit parfois « l'Amérique » pour l'Amérique du Nord et l'Amérique du Sud ensemble.[/cadre]
[page]
[titre]Les océans[/titre]
Un [b]océan[/b] est une immense étendue d'eau salée.
[planisphere oceans=tous largeur=640]
[cadre]Les 3 grands océans : l'océan [b]Pacifique[/b] (le plus grand), l'océan [b]Atlantique[/b] et l'océan [b]Indien[/b]. Près des pôles : l'océan Arctique et l'océan Austral.[/cadre]
[page]
[titre]Tous les océans se touchent[/titre]
Les océans ne sont pas séparés : ils se rejoignent tous. Un bateau peut aller d'un océan à l'autre.
[cadre]Sur le planisphère, l'océan Pacifique est coupé en deux : on le voit à gauche [b]et[/b] à droite. C'est le même océan qui fait le tour de la Terre.[/cadre]
[cadre=astuce]L'océan Atlantique est entre l'Amérique, à l'ouest, et l'Europe et l'Afrique, à l'est.[/cadre]
[page]
[titre]Les points cardinaux[/titre]
[planisphere noms=oui cardinaux=oui largeur=600]
[cadre]Sur une carte : le [b]Nord[/b] est en haut, le [b]Sud[/b] en bas, l'[b]Est[/b] à droite et l'[b]Ouest[/b] à gauche.
L'Afrique est au sud de l'Europe. L'Asie est à l'est de l'Europe.[/cadre]
[page]
[titre]Où est la France ?[/titre]
[planisphere seul=europe noms=oui france=oui largeur=620]
[cadre]La France est en [b]Europe[/b], à l'ouest du continent.
Des territoires français sont très loin, au milieu des océans : la Guadeloupe, la Martinique, La Réunion, Mayotte… et la Guyane, en Amérique du Sud.[/cadre]
[page]
[titre]Où vivent les êtres humains ?[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]🏙️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'Asie (la Chine, l'Inde) et l'Europe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][font_size=30]🏜️[/font_size][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]très peu d'habitants[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]les grands déserts, les hautes montagnes,
les grandes forêts[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][font_size=30]❄️[/font_size][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]presque personne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'Antarctique, très froid[/font_size][/center][/cell][/table]
[cadre]Les endroits où vivent beaucoup de personnes s'appellent des [b]foyers de peuplement[/b]. Le plus grand est en [b]Asie[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le [b]globe[/b] est une boule, le [b]planisphère[/b] une carte à plat de la Terre.
• Les continents : Europe, Asie, Afrique, Amérique du Nord, Amérique du Sud, Océanie, Antarctique.
• Les 3 grands océans : [b]Pacifique[/b], [b]Atlantique[/b], [b]Indien[/b]. Ils se touchent tous.
• Nord en haut, Sud en bas, Est à droite, Ouest à gauche.
• La France est en [b]Europe[/b]. L'Asie est le continent le plus peuplé.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'monde_carte'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
