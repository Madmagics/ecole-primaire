-- Histoire-Géographie (2026-11-07) : notions + fiches de cours CP à CM2, en BROUILLON.
-- Les fiches passeront en 'publie' quand leurs questions seront écrites et publiées (fn_publier refuse
-- une fiche publiée sans question publiée de sa notion). Lancé par Claude (compte claude_contenu).
-- Matière : 'histoire_geo' en CP-CE2, 'histoire' / 'geographie' en CM1-CM2.
begin;
insert into contenu_notions (code, libelle, domaine, ordre) values ('temps_nature', 'Le jour, la nuit, les saisons', 'Histoire', 905);
insert into contenu_notions (code, libelle, domaine, ordre) values ('mesurer_temps', 'Mesurer le temps', 'Histoire', 910);
insert into contenu_notions (code, libelle, domaine, ordre) values ('situer_temps', 'Situer dans le temps', 'Histoire', 915);
insert into contenu_notions (code, libelle, domaine, ordre) values ('se_reperer', 'Se repérer autour de l''école', 'Géographie', 1005);
insert into contenu_notions (code, libelle, domaine, ordre) values ('monde_carte', 'Le monde sur une carte', 'Géographie', 1010);
insert into contenu_notions (code, libelle, domaine, ordre) values ('passe_proche_lointain', 'Passé proche, passé lointain', 'Histoire', 920);
insert into contenu_notions (code, libelle, domaine, ordre) values ('grandes_periodes', 'Les grandes périodes de l''histoire', 'Histoire', 925);
insert into contenu_notions (code, libelle, domaine, ordre) values ('traces_passe', 'Les traces du passé', 'Histoire', 930);
insert into contenu_notions (code, libelle, domaine, ordre) values ('terre_peuplee', 'La Terre est peuplée', 'Géographie', 1015);
insert into contenu_notions (code, libelle, domaine, ordre) values ('climats_paysages', 'Climats et paysages du monde', 'Géographie', 1020);
insert into contenu_notions (code, libelle, domaine, ordre) values ('reliefs_eau', 'Montagnes, plaines et fleuves', 'Géographie', 1025);
insert into contenu_notions (code, libelle, domaine, ordre) values ('prehistoire', 'La Préhistoire', 'Histoire', 935);
insert into contenu_notions (code, libelle, domaine, ordre) values ('rome_antique', 'Vivre à Rome', 'Histoire', 940);
insert into contenu_notions (code, libelle, domaine, ordre) values ('gaule_romaine', 'La Gaule romaine', 'Histoire', 945);
insert into contenu_notions (code, libelle, domaine, ordre) values ('royaume_france', 'Le royaume de France', 'Histoire', 950);
insert into contenu_notions (code, libelle, domaine, ordre) values ('population_france', 'La population de la France', 'Géographie', 1030);
insert into contenu_notions (code, libelle, domaine, ordre) values ('se_loger', 'Se loger en France', 'Géographie', 1035);
insert into contenu_notions (code, libelle, domaine, ordre) values ('travailler', 'Travailler en France', 'Géographie', 1040);
insert into contenu_notions (code, libelle, domaine, ordre) values ('vie_moyen_age', 'La vie au Moyen Âge', 'Histoire', 955);
insert into contenu_notions (code, libelle, domaine, ordre) values ('monarchie_absolue', 'La monarchie (XVIe-XVIIe s.)', 'Histoire', 960);
insert into contenu_notions (code, libelle, domaine, ordre) values ('explorations', 'Explorations et conquêtes', 'Histoire', 965);
insert into contenu_notions (code, libelle, domaine, ordre) values ('revolution_1789', '1789, la Révolution', 'Histoire', 970);
insert into contenu_notions (code, libelle, domaine, ordre) values ('se_nourrir', 'Se nourrir', 'Géographie', 1045);
insert into contenu_notions (code, libelle, domaine, ordre) values ('inegalites_monde', 'Les inégalités dans le monde', 'Géographie', 1050);
insert into contenu_notions (code, libelle, domaine, ordre) values ('se_deplacer', 'Se déplacer', 'Géographie', 1055);
insert into contenu_notions (code, libelle, domaine, ordre) values ('internet', 'Communiquer avec Internet', 'Géographie', 1060);
insert into contenu_notions (code, libelle, domaine, ordre) values ('republique_empire', 'De la République à l''Empire', 'Histoire', 975);
insert into contenu_notions (code, libelle, domaine, ordre) values ('france_republicaine', 'Vers une France républicaine', 'Histoire', 980);
insert into contenu_notions (code, libelle, domaine, ordre) values ('age_industriel', 'L''âge industriel', 'Histoire', 985);
insert into contenu_notions (code, libelle, domaine, ordre) values ('premiere_guerre', 'La Première Guerre mondiale', 'Histoire', 990);
insert into contenu_notions (code, libelle, domaine, ordre) values ('seconde_guerre', 'La Seconde Guerre mondiale', 'Histoire', 995);
insert into contenu_notions (code, libelle, domaine, ordre) values ('france_depuis_1945', 'La France depuis 1945', 'Histoire', 1000);
insert into contenu_notions (code, libelle, domaine, ordre) values ('territoire_france', 'Le territoire français', 'Géographie', 1065);
insert into contenu_notions (code, libelle, domaine, ordre) values ('eau_douce', 'L''eau douce en France', 'Géographie', 1070);
insert into contenu_notions (code, libelle, domaine, ordre) values ('union_europeenne', 'L''Union européenne', 'Géographie', 1075);
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
[cadre]Le [b]matin[/b], je me lève et je vais à l'école.
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'temps_nature';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'mesurer_temps';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'situer_temps';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'se_reperer';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'monde_carte';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'passe_proche_lointain';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'grandes_periodes';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'traces_passe';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'terre_peuplee';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'climats_paysages';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'reliefs_eau';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'prehistoire';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'rome_antique';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'gaule_romaine';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'royaume_france';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'population_france';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'se_loger';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'travailler';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'vie_moyen_age';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'monarchie_absolue';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'explorations';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'revolution_1789';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Se nourrir dans le monde', $fiche$
[titre]Manger, un besoin vital[/titre]
[center][font_size=50]🍚 🍞 🌽[/font_size][/center]
Partout dans le monde, les humains ont besoin de manger. Mais on ne mange pas la même chose ni la même quantité partout.
[cadre]La [b]ration alimentaire[/b], c'est la quantité de nourriture qu'une personne mange en moyenne chaque jour.[/cadre]
[page]
[titre]Des façons de manger différentes[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🍚 le riz[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Asie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🍞 le blé (pain, pâtes)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Europe, au Maghreb[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌽 le maïs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]en Amérique[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]🥔 le manioc, le mil[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]en Afrique[/font_size][/center][/cell][/table]
[cadre]On mange avec des couverts, des baguettes ou avec la main. Les religions et les traditions influencent aussi ce que l'on mange.[/cadre]
[page]
[titre]Trop ou pas assez[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]États-Unis[/b] (Amérique)
[b]France[/b] (Europe)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une ration alimentaire [b]très riche[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]Madagascar[/b] (Afrique)
[b]Haïti[/b] (Amérique)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]une ration alimentaire [b]insuffisante[/b][/font_size][/center][/cell][/table]
[cadre]Dans le monde, environ [b]1 personne sur 12[/b] ne mange pas assez.[/cadre]
[page]
[titre]Sous-nutrition et malnutrition[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]sous-nutrition[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ne pas manger [b]assez[/b] : on a faim[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la [b]malnutrition[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]manger [b]mal[/b] : il manque certains aliments,
ou on mange trop gras, trop sucré[/font_size][/center][/cell][/table]
[cadre]La malnutrition existe aussi dans les pays riches : trop de sucre et de gras peut rendre malade.[/cadre]
[page]
[titre]Pays riche, pays en développement[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans un pays riche[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans un pays en développement[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup de choix, de la viande
et des produits transformés[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]surtout des céréales et des légumes,
peu de viande[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on achète au supermarché[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup cultivent ce qu'ils mangent
ou achètent au marché[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on jette beaucoup de nourriture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]en cas de sécheresse, la nourriture
peut manquer[/font_size][/center][/cell][/table]
[page]
[titre]Produit agricole ou transformé ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]produit agricole[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]produit transformé[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥛 le lait[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍦 le yaourt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🌾 le blé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥖 le pain, les biscuits[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍎 la pomme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🥫 la compote[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍫 la fève de cacao[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🍫 la tablette de chocolat[/font_size][/center][/cell][/table]
[cadre]Un [b]produit agricole[/b] sort de la ferme. Un [b]produit transformé[/b] a été fabriqué à partir de lui, souvent dans une usine.[/cadre]
[page]
[titre]Du pré au frigo : le yaourt[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1. 🐄 la ferme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'éleveur trait les vaches[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]2. 🚛 le camion[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le lait part à l'usine[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]3. 🏭 la laiterie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on transforme le lait en yaourts
et on les met en pots[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]4. 🚚 l'entrepôt[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les yaourts sont stockés au froid[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]5. 🛒 le magasin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]on achète les yaourts[/font_size][/center][/cell][/table]
[page]
[titre]D'où vient ce que je mange ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🍌 la banane[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des Antilles, d'Afrique, d'Amérique du Sud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍫 le cacao[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]de Côte d'Ivoire, du Ghana (Afrique)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]☕ le café[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]du Brésil, du Viêt Nam[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🍚 le riz[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]d'Asie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🍎 la pomme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]de France[/font_size][/center][/cell][/table]
[cadre]Beaucoup d'aliments voyagent en bateau, en camion ou en avion avant d'arriver dans notre assiette.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• On ne mange pas la même chose ni la même quantité partout dans le monde.
• Ration très riche : États-Unis, France. Ration insuffisante : Madagascar, Haïti.
• [b]Sous-nutrition[/b] : pas assez manger. [b]Malnutrition[/b] : mal manger.
• Un [b]produit agricole[/b] (lait) devient un [b]produit transformé[/b] (yaourt).
• Un aliment passe par une chaîne : ferme, usine, transport, magasin.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'se_nourrir';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Les inégalités dans le monde', $fiche$
[titre]Des niveaux de vie différents[/titre]
[center][font_size=50]🏠 🏚️[/font_size][/center]
Le [b]niveau de vie[/b], c'est la façon dont les gens peuvent vivre : se loger, se nourrir, se soigner, aller à l'école.
[cadre]Dans le monde, les niveaux de vie sont très différents d'un pays à l'autre, et même à l'intérieur d'un même pays : ce sont les [b]inégalités[/b].[/cadre]
[page]
[titre]Les grandes aires du monde[/titre]
[planisphere pale=oui aires=oui largeur=720]
[page]
[titre]L'accès à l'eau[/titre]
[center][font_size=50]🚰 🪣[/font_size][/center]
Dans les pays riches, l'eau potable arrive au robinet. Ailleurs, des millions de personnes, souvent des femmes et des enfants, marchent longtemps chaque jour pour aller chercher de l'eau.
[cadre]Dans le monde, plus de [b]2 milliards[/b] de personnes n'ont pas d'eau potable sûre chez elles. Boire une eau sale rend malade.[/cadre]
[page]
[titre]L'accès à la santé[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]en Europe, en Amérique du Nord[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]dans les pays les plus pauvres[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]beaucoup de médecins et d'hôpitaux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]peu de médecins, des hôpitaux loin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des vaccins et des médicaments[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des maladies que l'on sait soigner
tuent encore[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on vit en moyenne plus de 80 ans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]on vit beaucoup moins longtemps[/font_size][/center][/cell][/table]
[page]
[titre]L'accès à l'éducation[/titre]
[center][font_size=50]🎒 📚[/font_size][/center]
En France, l'école est obligatoire et gratuite. Mais dans le monde, environ [b]250 millions[/b] d'enfants ne vont pas à l'école.
[cadre]Certains doivent travailler pour aider leur famille, d'autres vivent trop loin d'une école ou dans un pays en guerre. Les filles sont souvent les plus touchées.[/cadre]
[page]
[titre]Où sont les inégalités ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]niveau de vie élevé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Amérique du Nord, Europe, Océanie
(Australie), Asie de l'Est (Japon)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]niveau de vie plus faible[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Afrique subsaharienne,
une partie de l'Asie du Sud-Est
et de l'Amérique du Sud[/font_size][/center][/cell][/table]
[cadre]Même dans un pays riche, il y a des personnes pauvres ; et dans un pays pauvre, des personnes très riches.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le niveau de vie n'est pas le même partout : ce sont les [b]inégalités[/b].
• Elles se voient dans l'accès à l'[b]eau[/b], à la [b]santé[/b] et à l'[b]éducation[/b].
• Les aires du monde : Amérique du Nord, Amérique du Sud, Europe, Maghreb, Afrique subsaharienne, Asie de l'Est, Asie du Sud-Est, Océanie.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'inegalites_monde';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Se déplacer', $fiche$
[titre]Je me déplace[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]chaque jour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]aller à l'école : à pied, à vélo, en bus,
en voiture[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]chaque semaine[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]aller au sport, faire les courses[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]pendant les vacances[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]partir loin : en train, en voiture,
en avion, en bateau[/font_size][/center][/cell][/table]
[cadre]Plus la distance est grande, plus on choisit un moyen de transport rapide.[/cadre]
[page]
[titre]Moyens de transport et infrastructures[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]je me déplace en…[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]j'utilise…[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚶 la marche[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le trottoir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚲 le vélo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la voie cyclable (piste cyclable)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚗 la voiture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la route, l'autoroute[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚇 le métro[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la station[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚆 le train[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la gare[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]⛴️ le bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le port[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]✈️ l'avion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'aéroport[/font_size][/center][/cell][/table]
[page]
[titre]Mesurer un déplacement[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]distance en kilomètres[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la longueur du trajet
(Paris → Marseille : environ 750 km)[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la [b]distance en temps[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la durée du trajet
(en TGV : un peu plus de 3 heures)[/font_size][/center][/cell][/table]
[cadre=astuce]Deux lieux peuvent être éloignés en kilomètres mais proches en temps, si un moyen de transport rapide les relie.[/cadre]
[page]
[titre]Paris → Marseille[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]moyen de transport[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]durée[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🚗 en voiture[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]environ 7 heures 30[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🚆 en TGV[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]un peu plus de 3 heures[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]✈️ en avion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]environ 1 heure 20 de vol[/font_size][/center][/cell][/table]
[cadre]La distance en kilomètres ne change pas, mais la distance en temps dépend du moyen de transport.[/cadre]
[page]
[titre]Se déplacer dans le monde[/titre]
[center][font_size=50]✈️ 🚢 🌍[/font_size][/center]
L'[b]avion[/b] permet de relier les continents en quelques heures. Les grands [b]aéroports[/b] accueillent des millions de voyageurs.
[cadre]Les [b]bateaux[/b] transportent surtout des marchandises, dans de grands conteneurs : la plupart des objets que nous achetons ont voyagé par la mer.[/cadre]
[page]
[titre]Tout le monde ne voyage pas pareil[/titre]
[center][font_size=50]🚶 🚌 ✈️[/font_size][/center]
Dans les pays riches, beaucoup de personnes ont une voiture et prennent l'avion. Dans les pays pauvres, beaucoup se déplacent à pied, à vélo ou en bus.
[cadre]Les transports polluent : on encourage la marche, le vélo, les transports en commun et le train.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• On se déplace chaque jour, chaque semaine, pendant les vacances, avec des moyens de transport différents.
• À chaque moyen de transport son infrastructure : avion/aéroport, bateau/port, train/gare, voiture/route, métro/station, vélo/voie cyclable.
• On mesure un déplacement en [b]kilomètres[/b] ou en [b]temps[/b].[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'se_deplacer';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'geographie', 'Communiquer avec Internet', $fiche$
[titre]À quoi sert Internet ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🔎 chercher des informations[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]💬 envoyer des messages[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]🎬 regarder des vidéos[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]🎮 jouer en ligne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🛒 acheter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]💼 travailler, apprendre[/font_size][/center][/cell][/table]
[cadre][b]Internet[/b] est un immense [b]réseau[/b] qui relie des milliards d'ordinateurs, de téléphones et de tablettes dans le monde.[/cadre]
[page]
[titre]Comment ça marche ?[/titre]
[center][font_size=46]📱 ➡️ 🏢 ➡️ 🌍[/font_size][/center]
Quand j'envoie un message, il part sous forme d'informations numériques. Il voyage par des câbles et arrive dans de grands bâtiments remplis d'ordinateurs, les [b]centres de données[/b], puis jusqu'à l'appareil de mon correspondant.
[cadre]Tout cela prend moins d'une seconde, même à l'autre bout du monde ![/cadre]
[page]
[titre]Les câbles sous-marins[/titre]
[planisphere pale=oui cables=oui largeur=720]
[cadre]Des câbles posés au fond des océans relient les continents. Ils sont très nombreux dans l'[b]Atlantique Nord[/b], le [b]Pacifique Nord[/b] et entre l'Europe et l'Asie.[/cadre]
[page]
[titre]Câbles et satellites[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les [b]câbles[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]sur les continents et sous les mers :
presque toutes les informations passent par eux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]les [b]satellites[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]tournent autour de la Terre : ils relient
les endroits isolés (montagnes, déserts, bateaux)[/font_size][/center][/cell][/table]
[page]
[titre]Un accès inégal dans le monde[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Europe, Amérique du Nord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]très bien reliées :
plus de 9 personnes sur 10 utilisent Internet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Afrique subsaharienne[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]faiblement reliée :
moins de 4 personnes sur 10[/font_size][/center][/cell][/table]
[cadre]Dans le monde, environ 2 personnes sur 3 utilisent Internet. Plus de 2 milliards de personnes n'y ont pas accès.[/cadre]
[page]
[titre]Et en France ?[/titre]
[center][font_size=50]📶 🏙️ 🏔️[/font_size][/center]
Presque tous les Français peuvent utiliser Internet. Mais la [b]5G[/b], le réseau mobile le plus rapide, est surtout installée dans les [b]villes[/b].
[cadre]Dans certaines campagnes et montagnes, le réseau est faible, voire absent : on parle de « zones blanches ».[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Internet est un [b]réseau[/b] mondial qui sert à s'informer, communiquer, se divertir, travailler.
• Il repose sur des [b]câbles[/b] (dont des [b]câbles sous-marins[/b]) et des [b]satellites[/b].
• L'accès est inégal : l'Europe et l'Amérique du Nord sont très bien reliées, l'Afrique subsaharienne beaucoup moins.
• En France, la 5G est surtout présente dans les villes.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'internet';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'republique_empire';
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
[center][font_size=56]🇫🇷[/font_size][/center]
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
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🇫🇷 le [b]drapeau tricolore[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]bleu, blanc, rouge[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🎶 [b]La Marseillaise[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'hymne national[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🎆 le [b]14 juillet[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la fête nationale[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]👩 [b]Marianne[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la femme qui représente la République[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]📜 la [b]devise[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]« Liberté, Égalité, Fraternité »[/font_size][/center][/cell][/table]
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'france_republicaine';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'age_industriel';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'premiere_guerre';
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'seconde_guerre';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'histoire', 'La France depuis 1945', $fiche$
[titre]Une République démocratique et sociale[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b]1944[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]les femmes obtiennent le [b]droit de vote[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]1945[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]création de la [b]Sécurité sociale[/b] :
on est aidé quand on est malade ou âgé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]1946[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la Constitution affirme des droits sociaux
(travail, santé, éducation)[/font_size][/center][/cell][/table]
[page]
[titre]1958 : la Ve République[/titre]
[center][font_size=50]🇫🇷 📜[/font_size][/center]
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
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'france_depuis_1945';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'L''organisation du territoire français', $fiche$
[titre]Communes, départements, régions[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]combien ?[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]qui décide ?[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🏘️ la [b]commune[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]environ 35 000[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]dirigée par le maire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🗺️ le [b]département[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]101[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le conseil départemental[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🌍 la [b]région[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]18[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le conseil régional[/font_size][/center][/cell][/table]
[cadre]La France est découpée en territoires emboîtés : une commune est dans un département, qui est dans une région.[/cadre]
[page]
[titre]Les régions de métropole[/titre]
[carte vue=france regions=oui largeur=420]
[page]
[titre]Les 13 régions de métropole[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]région[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]capitale[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Hauts-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Lille[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Normandie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Rouen[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Île-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Paris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Grand Est[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Strasbourg[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Bretagne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Rennes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Pays de la Loire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Nantes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Centre-Val de Loire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Orléans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Bourgogne-Franche-Comté[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Dijon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Nouvelle-Aquitaine[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Bordeaux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Auvergne-Rhône-Alpes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Lyon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Occitanie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Toulouse[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Provence-Alpes-Côte d'Azur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=15]Marseille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Corse[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=15]Ajaccio[/font_size][/center][/cell][/table]
[page]
[titre]Les 5 régions d'outre-mer[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]région[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]capitale[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Guadeloupe[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Basse-Terre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la [b]Martinique[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]Fort-de-France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la [b]Guyane[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Cayenne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]La Réunion[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]Saint-Denis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]Mayotte[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Mamoudzou[/font_size][/center][/cell][/table]
[cadre]13 régions en métropole + 5 en outre-mer = [b]18 régions[/b].[/cadre]
[page]
[titre]Mon département[/titre]
[center][font_size=56]📮[/font_size][/center]
Chaque département a un nom et un numéro. Les deux premiers chiffres du code postal donnent souvent le numéro du département.
[cadre=astuce]75 = Paris, 13 = Bouches-du-Rhône, 69 = Rhône, 59 = Nord. Et toi, dans quel département vis-tu ?[/cadre]
[page]
[titre]Les grands axes de transport[/titre]
[carte vue=france tgv=oui villes=oui largeur=400]
[page]
[titre]Routes et voies ferrées[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🚆 le [b]TGV[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]train à grande vitesse (plus de 300 km/h)
depuis 1981 ; les lignes partent de Paris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🛣️ les [b]autoroutes[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Paris-Lille, Paris-Lyon-Marseille
(l'autoroute du Soleil), Paris-Bordeaux…[/font_size][/center][/cell][/table]
[cadre]Les grands axes forment une [b]étoile[/b] autour de Paris et relient les grandes agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.[/cadre]
[page]
[titre]Deux régions à comparer[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Île-de-France[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Auvergne-Rhône-Alpes[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la région la plus peuplée :
plus de 12 millions d'habitants[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]des grandes villes (Lyon, Grenoble)
et des montagnes (Alpes, Massif central)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la capitale, des sièges d'entreprises,
de grands aéroports[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]de l'industrie, des stations de ski,
de l'agriculture[/font_size][/center][/cell][/table]
[cadre=astuce]Et ta région ? Cherche sa capitale, ses grandes villes et ses paysages.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• La France est organisée en [b]communes[/b], [b]départements[/b] (101) et [b]régions[/b] (18 : 13 en métropole, 5 en outre-mer).
• Les 5 premières agglomérations : Paris, Lyon, Marseille, Lille, Toulouse.
• Les autoroutes et les lignes de [b]TGV[/b] forment une étoile autour de Paris.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'territoire_france';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'Les usages de l''eau douce en France', $fiche$
[titre]Une ressource limitée[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]💧 eau salée[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]presque toute l'eau de la Terre :
les mers et les océans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🧊 eau douce[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]environ 3 % seulement,
surtout gelée dans les glaciers[/font_size][/center][/cell][/table]
[cadre]L'eau douce que l'on peut utiliser est très rare : il faut l'économiser et la protéger.[/cadre]
[page]
[titre]Où trouve-t-on l'eau douce ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🏞️ les fleuves et les rivières[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]🌊 les lacs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🏔️ les glaciers et la neige des montagnes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]🪨 les [b]nappes phréatiques[/b][/font_size][/center][/cell][/table]
[cadre]Une [b]nappe phréatique[/b] est de l'eau de pluie stockée sous la terre, dans les roches. On la pompe pour avoir de l'eau potable.[/cadre]
[page]
[titre]Fleuves et lacs[/titre]
[carte vue=france fleuves=oui lacs=oui largeur=420]
[page]
[titre]Fleuves et lacs à connaître[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]les fleuves[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Loire, Seine, Garonne, Rhône, Rhin
(et le Maroni en Guyane)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]les massifs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]Alpes, Pyrénées, Massif central, Jura,
Vosges, Corse : de là partent les cours d'eau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le [b]lac du Bourget[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]le plus grand lac [b]naturel[/b]
entièrement français[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le [b]lac de Serre-Ponçon[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]un lac [b]artificiel[/b], créé
par un barrage sur la Durance[/font_size][/center][/cell][/table]
[page]
[titre]À quoi sert l'eau ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]🚰 boire, se laver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]chaque Français utilise environ
150 litres d'eau par jour[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]🌽 l'agriculture[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arroser les champs (l'irrigation) :
c'est elle qui consomme le plus[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]🏭 l'industrie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]fabriquer et refroidir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]⚡ l'électricité[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]les barrages ; refroidir les centrales[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]⛵ les loisirs, le transport[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]baignade, bateaux, péniches[/font_size][/center][/cell][/table]
[page]
[titre]Une eau menacée[/titre]
[center][font_size=50]☀️ 🏜️ 🧪[/font_size][/center]
Pendant les [b]sécheresses[/b], les rivières et les nappes baissent : les préfets limitent alors l'usage de l'eau (arrosage interdit…).
[cadre]L'eau peut aussi être [b]polluée[/b] par les engrais, les pesticides, les usines. On la nettoie dans des stations d'épuration avant de la rendre à la nature.[/cadre]
[page]
[titre]Les conflits d'usages[/titre]
[center][font_size=50]⚡ 🌾 🏊[/font_size][/center]
Le lac de [b]Serre-Ponçon[/b] sert à produire de l'électricité, à arroser les cultures de Provence, à fournir de l'eau potable et à accueillir les touristes.
[cadre]Quand il fait sec, il n'y a pas assez d'eau pour tout le monde : chacun veut l'utiliser pour son activité. C'est un [b]conflit d'usages[/b]. Il faut alors partager l'eau.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'eau douce est une ressource [b]limitée[/b] : fleuves, lacs, glaciers, [b]nappes phréatiques[/b].
• On l'utilise pour boire, l'agriculture, l'industrie, l'électricité, les loisirs.
• Sécheresses et pollution la menacent.
• Plusieurs activités veulent la même eau : ce sont des [b]conflits d'usages[/b].
• Lac naturel : le lac du Bourget. Lac artificiel : Serre-Ponçon.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'eau_douce';
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'geographie', 'L''Union européenne', $fiche$
[titre]Europe et Union européenne[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'[b]Europe[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un [b]continent[/b] : de l'océan Atlantique
aux monts Oural, environ 50 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]l'[b]Union européenne[/b] (UE)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]une [b]union de pays[/b] qui ont choisi
de travailler ensemble : 27 pays[/font_size][/center][/cell][/table]
[cadre]Tous les pays d'Europe ne sont pas dans l'UE : par exemple la Suisse, la Norvège ou le Royaume-Uni, qui l'a quittée en 2020.[/cadre]
[page]
[titre]Les 27 pays de l'UE[/titre]
[carte vue=europe fondateurs=oui noms=oui largeur=380]
[page]
[titre]Les 6 pays fondateurs[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🇫🇷 la France[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🇩🇪 l'Allemagne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]🇮🇹 l'Italie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]🇧🇪 la Belgique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🇳🇱 les Pays-Bas[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]🇱🇺 le Luxembourg[/font_size][/center][/cell][/table]
[cadre]En [b]1957[/b], ces 6 pays signent le [b]traité de Rome[/b] : ils créent la Communauté économique européenne. D'autres pays les rejoignent ensuite : l'Espagne, le Portugal, la Pologne, la Suède, la Grèce, l'Irlande…[/cadre]
[page]
[titre]De la CEE à l'UE[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]1957[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]traité de Rome : 6 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]1992[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]traité de Maastricht[/b] :
naissance de l'Union européenne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]2002[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]les pièces et billets en euros[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]2020[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le Royaume-Uni quitte l'UE[/font_size][/center][/cell][/table]
[page]
[titre]Ce que l'UE apporte[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🕊️ la paix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]entre des pays autrefois en guerre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🚶 la libre circulation[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]voyager, étudier, travailler
dans les autres pays[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]💶 l'[b]euro[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]une monnaie commune
à plus de 20 pays[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]🏗️ des aides[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]pour construire des routes, des tramways,
rénover des écoles…[/font_size][/center][/cell][/table]
[page]
[titre]Les symboles de l'UE[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le drapeau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]12 étoiles d'or sur fond bleu[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'hymne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]l'« Ode à la joie » de Beethoven[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la devise[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]« Unie dans la diversité »[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]la fête[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]le 9 mai, journée de l'Europe[/font_size][/center][/cell][/table]
[cadre=astuce]Cherche près de ton école un panneau « projet financé par l'Union européenne » : c'est un aménagement aidé par l'UE.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• L'[b]Europe[/b] est un continent ; l'[b]Union européenne[/b] est une union de 27 pays.
• [b]1957[/b] : traité de Rome (6 pays fondateurs : France, Allemagne, Italie, Belgique, Pays-Bas, Luxembourg).
• [b]1992[/b] : traité de Maastricht, naissance de l'UE.
• L'UE apporte la paix, la libre circulation, l'euro et des aides pour des aménagements.[/cadre]
$fiche$, 'brouillon', n.id from contenu_notions n where n.code = 'union_europeenne';
commit;
select n.domaine, c.classe, c.matiere, count(*) from contenu_cours c join contenu_notions n on n.id = c.notion_id where n.domaine in ('Histoire','Géographie') group by 1,2,3 order by 2,1;
