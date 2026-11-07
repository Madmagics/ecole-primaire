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
