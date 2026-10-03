-- Toutes les fiches de cours Francais CP (2026-10-03), une seule transaction.
begin;
-- Fiche Singulier et pluriel (CP) - francais, notion 'singulier_pluriel'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', 'Singulier et pluriel', $fiche$
[titre]Un seul ou plusieurs ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]un seul[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]plusieurs[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]🐱🐱🐱[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]un chat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]des chat[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][/table]
[cadre]Quand il y en a [b]un seul[/b], le mot est au [b]singulier[/b].
Quand il y en a [b]plusieurs[/b], le mot est au [b]pluriel[/b].[/cadre]
[page]
[titre]Les petits mots qui aident[/titre]
Le petit mot devant le nom me dit si c'est singulier ou pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]le, la, l'[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]les[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]un, une[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]des[/font_size][/center][/cell][/table]
[cadre][b]la[/b] porte → une seule porte.
[b]les[/b] portes → plusieurs portes.[/cadre]
[page]
[titre]La règle : j'ajoute un s[/titre]
Pour mettre un nom au pluriel, le plus souvent, j'ajoute un [b]s[/b] à la fin.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]un savon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]des savon[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]une porte[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]des porte[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]une tomate[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]des tomate[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]un facteur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]des facteur[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Ce [b]s[/b] ne s'entend pas : « un zèbre », « des zèbres » se disent pareil. Il faut le penser en écrivant ![/cadre]
[page]
[titre]Seulement un s[/titre]
J'écris le mot [b]en entier[/b], puis j'ajoute [b]s[/b]. Rien d'autre.
[cadre]Une porte → des [b]portes[/b] ✓
Pas « porte[b]es[/b] » : je n'ajoute pas de e.
Pas « port[b]s[/b] » : je n'enlève pas de lettre.[/cadre]
[cadre=astuce]Je vérifie : si je cache le s, je dois retrouver le mot du singulier.[/cadre]
[page]
[titre]Les mots en -eau : un x[/titre]
Les mots qui finissent par [b]-eau[/b] prennent un [b]x[/b] au pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des bateau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un gâteau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des gâteau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un oiseau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des oiseau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un château[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des château[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un seau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des seau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][/table]
[cadre]Pareil pour les mots en [b]-eu[/b] : un feu → des feu[b][color=#C62828]x[/color][/b].[/cadre]
[page]
[titre]Les mots en -al : -aux[/titre]
Les mots qui finissent par [b]-al[/b] deviennent [b]-aux[/b] au pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]un chev[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=26]des chev[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=26]un journ[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=26]des journ[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][/table]
[cadre]Ici, on [b]entend[/b] la différence : un cheval, des chevaux.[/cadre]
[page]
[titre]Les mots en -ou[/titre]
La plupart des mots en [b]-ou[/b] prennent un [b]s[/b] : un kangourou → des kangourou[b][color=#C62828]s[/color][/b].
Mais [b]7 mots[/b] prennent un [b]x[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]bijou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]caillou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]chou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]genou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]hibou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]joujou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]pou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22] [/font_size][/center][/cell][/table]
[cadre=astuce]Pour les retenir : « Viens, mon [b]chou[/b], mon [b]bijou[/b], sur mes [b]genoux[/b], avec tes [b]joujoux[/b], et jette des [b]cailloux[/b] à ce [b]hibou[/b] plein de [b]poux[/b] ! »[/cadre]
[page]
[titre]Les mots qui ne changent pas[/titre]
Un mot qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] ne change pas au pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un ananas[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des ananas[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un tapis[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des tapis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un ours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des ours[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une noix[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des noix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un nez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des nez[/font_size][/center][/cell][/table]
[cadre]C'est le petit mot devant (un / des) qui montre le pluriel.[/cadre]
[page]
[titre]Du pluriel au singulier[/titre]
Pour retrouver le singulier, je fais le chemin [b]à l'envers[/b] : j'enlève le s.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des balcon[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un balcon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des abricot[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un abricot[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des bateau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un bateau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des chev[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un chev[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Je dis « un » devant le mot : « un balcon » sonne juste, c'est gagné ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Singulier[/b] = un seul. [b]Pluriel[/b] = plusieurs.
• le, la, un, une → singulier. les, des → pluriel.
• En général, j'ajoute un [b]s[/b] (il ne s'entend pas).
• Mots en -eau ou -eu → [b]x[/b]. Mots en -al → [b]-aux[/b].
• 7 mots en -ou prennent un [b]x[/b] : bijou, caillou, chou, genou, hibou, joujou, pou.
• Un mot fini par s, x ou z [b]ne change pas[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'singulier_pluriel'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Masculin et féminin (CP) - francais, notion 'masculin_feminin'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', 'Masculin et féminin', $fiche$
[titre]Un ou une ?[/titre]
Les noms sont [b]masculins[/b] ou [b]féminins[/b]. Le petit mot devant me le dit.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]masculin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]féminin[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]le, un[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]la, une[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]le garçon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]la fille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]un papa[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]une maman[/font_size][/center][/cell][/table]
[cadre]Je dis « [b]un[/b] » ou « [b]une[/b] » devant le nom pour savoir.[/cadre]
[page]
[titre]Le mâle et la femelle[/titre]
Chez les animaux, le [b]mâle[/b] est au masculin, la [b]femelle[/b] au féminin.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le mâle[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la femelle[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐰 un lapin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une lapin[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🦊 un renard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une renard[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐻 un ours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une ours[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐘 un éléphant[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une éléphant[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][/table]
[cadre]Souvent, j'ajoute simplement un [b]e[/b] à la fin.[/cadre]
[page]
[titre]J'ajoute une lettre en plus[/titre]
Parfois, la dernière lettre est [b]doublée[/b] avant le e.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]le mâle[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]la femelle[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐱 un chat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une chat[b][color=#C62828]te[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐶 un chien[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une chien[b][color=#C62828]ne[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🦁 un lion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une lion[b][color=#C62828]ne[/color][/b][/font_size][/center][/cell][/table]
D'autres fois, la fin change davantage :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐺 un lou[b][color=#C62828]p[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une lou[b][color=#C62828]ve[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]🐯 un tigre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une tigr[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🫏 un âne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une ân[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Des noms tout différents[/titre]
Pour certains animaux, la femelle a un [b]autre nom[/b]. Il faut les apprendre.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐓 le coq[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la poule[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐑 le mouton[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la brebis[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐴 le cheval[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la jument[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🦌 le cerf[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la biche[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐂 le taureau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la vache[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐐 le bouc[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la chèvre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐷 le cochon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la truie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐒 le singe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la guenon[/font_size][/center][/cell][/table]
[page]
[titre]D'autres noms à connaître[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐗 le sanglier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la laie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🪿 le jars[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'oie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐮 le bœuf[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la vache[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🦆 le canard[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la cane[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🦃 le dindon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la dinde[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🦚 le paon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la paonne[/font_size][/center][/cell][/table]
[cadre=astuce]Attention : la vache est la femelle du [b]taureau[/b] et du [b]bœuf[/b].
La femelle du canard est la [b]cane[/b] : un seul n.[/cadre]
[page]
[titre]Les personnes aussi[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]masculin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]féminin[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]un prince[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]une princ[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]un ami[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]une ami[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]un roi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]une reine[/font_size][/center][/cell][/table]
[cadre]Les mêmes règles marchent : j'ajoute un e, ou la fin change, ou le mot change complètement.[/cadre]
[page]
[titre]Du féminin au masculin[/titre]
On me donne la femelle, je cherche le mâle : je fais le chemin [b]à l'envers[/b].
[cadre]une lapin[b]e[/b] → j'enlève le e → un [b]lapin[/b]
une lou[b]ve[/b] → un [b]loup[/b]
une brebis → un [b]mouton[/b] (nom différent)[/cadre]
[cadre=astuce]Je dis « [b]un[/b] » devant ma réponse pour vérifier qu'elle sonne juste.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• le, un → [b]masculin[/b]. la, une → [b]féminin[/b].
• Souvent, j'ajoute un [b]e[/b] : un renard, une renarde.
• Parfois, la lettre est doublée : chat → chatte, chien → chienne.
• Parfois, la fin change : loup → louve, tigre → tigresse.
• Parfois, le nom change : coq → poule, cheval → jument.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'masculin_feminin'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Synonymes et contraires (CP) - francais, notion 'vocabulaire_sens'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', 'Synonymes et contraires', $fiche$
[titre]Les contraires[/titre]
Le [b]contraire[/b], c'est le mot qui veut dire [b]tout l'inverse[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]loin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]près[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]plein[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]vide[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]chaud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]froid[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]ami[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]ennemi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]jour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]nuit[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]gagner[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]perdre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]rire[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]pleurer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]commencer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]finir[/font_size][/center][/cell][/table]
[cadre]Le contraire de [b]loin[/b], c'est [b]près[/b]. Et le contraire de près, c'est loin ![/cadre]
[page]
[titre]Un petit morceau devant[/titre]
On fabrique souvent un contraire en ajoutant [b]in-[/b], [b]im-[/b] ou [b]dé-[/b] devant le mot.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]visible[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]in[/color][/b]visible[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]juste[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b][color=#C62828]in[/color][/b]juste[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]possible[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]im[/color][/b]possible[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]visser[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b][color=#C62828]dé[/color][/b]visser[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]faire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]dé[/color][/b]faire[/font_size][/center][/cell][/table]
[cadre]« invisible » veut dire « [b]pas[/b] visible ».[/cadre]
[page]
[titre]Trouver le contraire[/titre]
Je me fais un [b]petit film dans la tête[/b].
[cadre]Je [b]sème[/b] des graines… elles poussent… je [b]récolte[/b] les légumes !
Le contraire de semer, c'est [b]récolter[/b].[/cadre]
[cadre=astuce]Attention aux pièges : le contraire de [b]creux[/b] n'est pas « vide » (ça veut presque dire pareil), c'est [b]plein[/b].[/cadre]
[page]
[titre]Les synonymes[/titre]
Les [b]synonymes[/b] sont des mots qui veulent dire [b]presque la même chose[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]content[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]heureux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]beau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]joli[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]chaud[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]brûlant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]dire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]raconter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]chercher[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]rechercher[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]imaginer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]supposer[/font_size][/center][/cell][/table]
[page]
[titre]Le truc de la phrase[/titre]
Je mets le mot dans une phrase, puis je le [b]remplace[/b].
[cadre]« Je suis [b]content[/b]. » → « Je suis [b]heureux[/b]. »
La phrase veut dire la même chose : ce sont des [b]synonymes[/b] ✓[/cadre]
[cadre]« Je suis [b]content[/b]. » → « Je suis [b]triste[/b]. »
Ça veut dire l'inverse : c'est un [b]contraire[/b], pas un synonyme ✗[/cadre]
[page]
[titre]Synonyme ou contraire ?[/titre]
Je lis bien la question avant de répondre.
[cadre][b]Synonyme[/b] → je cherche un mot qui veut dire [b]pareil[/b].
[b]Contraire[/b] → je cherche un mot qui veut dire [b]l'inverse[/b].[/cadre]
[cadre=astuce]Souvent, le contraire se cache dans les réponses d'une question « synonyme » (et l'inverse) : c'est un piège ![/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Contraire[/b] = le sens inverse : loin → près.
• in-, im-, dé- fabriquent des contraires : visible → invisible.
• [b]Synonyme[/b] = presque le même sens : content → heureux.
• Pour vérifier, je remplace le mot dans une phrase.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'vocabulaire_sens'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Vocabulaire du quotidien (CP) - francais, notion 'vocabulaire_quotidien'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', 'Vocabulaire du quotidien', $fiche$
[titre]Les couleurs (1)[/titre]
[table=3][cell bg=#E53935 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]rouge[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]fraise, cerise, tomate[/cell][cell bg=#FDD835 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]jaune[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]banane, citron, poussin[/cell][cell bg=#43A047 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]vert[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]herbe, sapin, brocoli[/cell][cell bg=#1E88E5 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]bleu[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]ciel, mer, myrtille[/cell][cell bg=#FB8C00 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]orange[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]carotte, citrouille[/cell][/table]
[page]
[titre]Les couleurs (2)[/titre]
[table=3][cell bg=#8E24AA border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]violet[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]aubergine, prune[/cell][cell bg=#F48FB1 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]rose[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]flamant rose[/cell][cell bg=#8D5524 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]marron[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]chocolat, café[/cell][cell bg=#9E9E9E border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]gris[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]éléphant, fumée[/cell][cell bg=#212121 border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]noir[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]charbon, corbeau[/cell][cell bg=#FFFFFF border=#classe padding=22,4,22,4] [/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][b]blanc[/b][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4]neige, lait, nuage[/cell][/table]
[cadre]Le zèbre, le panda et le pingouin sont [b]noir et blanc[/b].[/cadre]
[page]
[titre]Les jours de la semaine[/titre]
Une semaine a [b]7 jours[/b], toujours dans le même ordre :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]1. lundi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]2. mardi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]3. mercredi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]4. jeudi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]5. vendredi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]6. samedi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]7. dimanche[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22] [/font_size][/center][/cell][/table]
[cadre]Le [b]premier[/b] jour est [b]lundi[/b]. Le [b]dernier[/b] est [b]dimanche[/b].
Après dimanche, une nouvelle semaine recommence : [b]lundi[/b].[/cadre]
[page]
[titre]Avant, après[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=24][b]mardi[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=12,6,12,6][center][font_size=24][b][color=white]mercredi[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=24][b]jeudi[/b][/font_size][/center][/cell][/table]
[cadre]Juste [b]avant[/b] mercredi, c'est [b]mardi[/b].
Juste [b]après[/b] mercredi, c'est [b]jeudi[/b].[/cadre]
[cadre=astuce]Je récite les jours depuis lundi, et je m'arrête au bon jour. Avant = à gauche, après = à droite.[/cadre]
[page]
[titre]Les 12 mois de l'année[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]janvier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]février[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]mars[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]avril[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]mai[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]juin[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]juillet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]août[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]septembre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]octobre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]novembre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]décembre[/font_size][/center][/cell][/table]
[cadre]Une année a [b]12 mois[/b]. Elle commence en [b]janvier[/b] et finit en [b]décembre[/b].
Après décembre, on recommence : [b]janvier[/b].[/cadre]
[page]
[titre]Les bébés des animaux (1)[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐱 le chat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le chaton[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐶 le chien[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le chiot[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐮 la vache[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le veau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐴 le cheval[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le poulain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐑 le mouton[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'agneau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐐 la chèvre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le chevreau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐔 la poule[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le poussin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐸 la grenouille[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le têtard[/font_size][/center][/cell][/table]
[page]
[titre]Les bébés des animaux (2)[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🦁 le lion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le lionceau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐻 l'ours[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'ourson[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐰 le lapin[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le lapereau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🦊 le renard[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le renardeau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐺 le loup[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le louveteau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🐭 la souris[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le souriceau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]🦆 le canard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le caneton[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]🐦 l'oiseau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]l'oisillon[/font_size][/center][/cell][/table]
[cadre=astuce]On entend souvent le nom de l'animal : [b]renard[/b] → [b]renard[/b]eau, [b]éléphant[/b] → [b]éléphant[/b]eau, [b]pigeon[/b] → [b]pigeon[/b]neau, [b]cygne[/b] → [b]cygne[/b]au, [b]oie[/b] → [b]oi[/b]son.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je sais nommer les [b]couleurs[/b] des choses que je vois tous les jours.
• 7 jours : lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche.
• 12 mois : de [b]janvier[/b] à [b]décembre[/b].
• Chaque animal a son [b]bébé[/b] : le chat → le chaton, le lion → le lionceau.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'vocabulaire_quotidien'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Écrire les nombres en lettres (CP) - francais, notion 'nombres_en_lettres'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', 'Écrire les nombres en lettres', $fiche$
[titre]De zéro à dix[/titre]
Chaque nombre a un [b]nom[/b] qu'on peut écrire en lettres.
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]0[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]zéro[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]1[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]un[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]deux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]3[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]trois[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]4[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]quatre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]5[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]cinq[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]six[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]7[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]sept[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]huit[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]9[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]neuf[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]dix[/font_size][/center][/cell][/table]
[cadre=astuce]Attention : [b]cinq[/b] finit par q, [b]sept[/b] a un p qui ne s'entend pas.[/cadre]
[page]
[titre]De onze à seize[/titre]
Ces nombres ont un nom [b]à eux[/b]. Il faut les apprendre par cœur.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]11[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]onze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]12[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]douze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]13[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]treize[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]14[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]quatorze[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]15[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]quinze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]16[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]seize[/font_size][/center][/cell][/table]
[cadre]On ne dit pas « dix-un », mais [b]onze[/b] !
On ne dit pas « dix-cinq », mais [b]quinze[/b] ![/cadre]
[page]
[titre]Dix-sept, dix-huit, dix-neuf[/titre]
À partir de 17, on dit [b]dix[/b], puis le chiffre des unités.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]17[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]dix-sept[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24][b]18[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=24]dix-huit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b]19[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]dix-neuf[/font_size][/center][/cell][/table]
[cadre]dix-sept = [b]10 + 7[/b]. Entre les deux mots, je mets un [b]trait d'union[/b] (-).[/cadre]
[page]
[titre]Les dizaines[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]dix[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]20[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]vingt[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]30[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]trente[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]40[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]quarante[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]50[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]cinquante[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]60[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]soixante[/font_size][/center][/cell][/table]
[cadre=astuce][b]vingt[/b] s'écrit avec un g et un t qu'on n'entend pas : v-i-n-g-t.[/cadre]
[page]
[titre]Fabriquer un nombre[/titre]
Pour 26, je dis la [b]dizaine[/b], puis l'[b]unité[/b] : 20 et 6.
[cubes d=2 u=6]
[center][font_size=30][b]26 → vingt[b][color=#C62828]-[/color][/b]six[/b][/font_size][/center]
[cadre]Entre les mots d'un nombre, je mets des [b]traits d'union[/b] : trente-quatre, cinquante-deux.[/cadre]
[page]
[titre]Le « et un »[/titre]
Avec un [b]1[/b] aux unités, on ajoute [b]et[/b] :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]21[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]vingt-et-un[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]31[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]trente-et-un[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]41[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]quarante-et-un[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]51[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]cinquante-et-un[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]61[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]soixante-et-un[/font_size][/center][/cell][/table]
[cadre]On ne dit pas « vingt-un », mais [b]vingt-et-un[/b].
Les traits d'union vont partout : vingt[b]-[/b]et[b]-[/b]un.[/cadre]
[page]
[titre]De 70 à 79[/titre]
70, c'est [b]60 + 10[/b] : on dit [b]soixante-dix[/b].
Puis on continue avec onze, douze, treize…
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]70[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]soixante-dix[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]71[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]soixante-et-onze[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]72[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]soixante-douze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22][b]75[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]soixante-quinze[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]79[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]soixante-dix-neuf[/font_size][/center][/cell][/table]
[cadre]soixante-quinze = [b]60 + 15[/b] = 75.[/cadre]
[page]
[titre]De 80 à 100[/titre]
80, c'est [b]4 fois 20[/b] : on dit [b]quatre-vingts[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]80[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]quatre-vingts[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]81[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]quatre-vingt-un[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]85[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]quatre-vingt-cinq[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]90[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]quatre-vingt-dix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]91[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]quatre-vingt-onze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]95[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]quatre-vingt-quinze[/font_size][/center][/cell][/table]
[cadre=astuce][b]quatre-vingts[/b] prend un s, mais pas quatre-vingt-un.
81 : pas de « et » → quatre-vingt-un. Et 100 s'écrit [b]cent[/b].[/cadre]
[page]
[titre]Lire un nombre écrit en lettres[/titre]
Je découpe le nombre en morceaux, puis j'additionne.
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]vingt-neuf[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]20 + 9[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]29[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]soixante-quinze[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]60 + 15[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21][b]75[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]quatre-vingt-onze[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]80 + 11[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b]91[/b][/font_size][/center][/cell][/table]
[cadre=astuce]quatre-vingt-onze : « quatre-vingt » = 80 et « onze » = 11. 80 + 11 = [b]91[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• 11 à 16 ont un nom à eux : onze, douze, treize, quatorze, quinze, seize.
• 17, 18, 19 : dix-sept, dix-huit, dix-neuf.
• Dizaine + unité avec un [b]trait d'union[/b] : vingt-six.
• Avec 1 : vingt-[b]et[/b]-un (mais quatre-vingt-un).
• 70 = soixante-dix, 80 = quatre-vingt[b]s[/b], 90 = quatre-vingt-dix.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'nombres_en_lettres'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
