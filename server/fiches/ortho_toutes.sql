-- Toutes les fiches de cours Orthographe CE1 -> CM2 (2026-10-03), une seule transaction.
begin;
-- Fiche Les homophones : et, est, son, sont (CE1) - orthographe, notion 'homophones'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'orthographe', 'Les homophones : et, est, son, sont', $fiche$
[titre]Des mots qui se disent pareil[/titre]
Certains mots se [b]disent[/b] de la même façon, mais ne s'[b]écrivent[/b] pas pareil et ne veulent pas dire la même chose : ce sont des [b]homophones[/b].
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=30]et[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=30]est[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=30]son[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=30]sont[/font_size][/center][/cell][/table]
[cadre]Pour choisir, j'utilise un [b]truc[/b] : je remplace le mot par un autre.[/cadre]
[page]
[titre]« et » pour ajouter[/titre]
[b]et[/b] sert à [b]relier[/b] deux mots, comme un pont.
[cadre]Léon [b]et[/b] Faustine arrosent le potager.
Iris [b]et[/b] Paul mangent un yaourt.[/cadre]
[cadre=astuce]Je peux dire « [b]et puis[/b] » : Léon et puis Faustine… ✓
Alors j'écris [b]et[/b].[/cadre]
[page]
[titre]« est » : le verbe être[/titre]
[b]est[/b] est le verbe [b]être[/b] : il / elle [b]est[/b].
[cadre]Agathe [b]est[/b] énervée.
Le fermier [b]est[/b] distrait.[/cadre]
[cadre=astuce]Je peux dire « [b]était[/b] » : Agathe était énervée ✓
Alors j'écris [b]est[/b].[/cadre]
[page]
[titre]et ou est ?[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Phrase[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je remplace[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]J'écris[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Suzanne ___ la couturière[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]et puis ✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]et[/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Le chat ___ gourmand.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]était ✓[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b]est[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Louis ___ le chat jouent.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]et puis ✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b]et[/b][/font_size][/center][/cell][/table]
[cadre]Quand on parle de [b]deux personnes[/b] qui font quelque chose ensemble, c'est souvent [b]et[/b].[/cadre]
[page]
[titre]« son » : à lui, à elle[/titre]
[b]son[/b] veut dire [b]à lui[/b] ou [b]à elle[/b]. Il est toujours devant un nom.
[cadre]Il range [b]son[/b] album. → l'album est à lui.
Elle partage [b]son[/b] puzzle. → le puzzle est à elle.[/cadre]
[cadre=astuce]Je peux dire « [b]mon[/b] » : je range mon album ✓
Alors j'écris [b]son[/b].[/cadre]
[page]
[titre]« sont » : le verbe être[/titre]
[b]sont[/b] est le verbe [b]être[/b] avec [b]plusieurs[/b] : ils / elles [b]sont[/b].
[cadre]Les pingouins [b]sont[/b] affamés.
Les chevaux [b]sont[/b] fatigués.[/cadre]
[cadre=astuce]Je peux dire « [b]étaient[/b] » : les chevaux étaient fatigués ✓
Alors j'écris [b]sont[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Mot[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je remplace par[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]et[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]et puis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Léo et Lou[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]est[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]était[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Il est content.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]son[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]mon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]son vélo[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]sont[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]étaient[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Ils sont là.[/font_size][/center][/cell][/table]
[cadre]Si le remplacement marche, j'ai trouvé le bon mot ![/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'homophones'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Masculin et féminin des animaux (CE1) - orthographe, notion 'masculin_feminin'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'orthographe', 'Masculin et féminin des animaux', $fiche$
[titre]Le mâle et la femelle[/titre]
Chez les animaux, le [b]mâle[/b] est au masculin (le, un), la [b]femelle[/b] au féminin (la, une).
Souvent, j'ajoute simplement un [b]e[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le lapin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la lapin[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le renard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la renard[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'ours[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]l'ours[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le faisan[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la faisan[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'éléphant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'éléphant[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20] [/font_size][/center][/cell][/table]
[page]
[titre]Je double la consonne[/titre]
Avec certaines fins, je [b]double[/b] la dernière consonne avant le e.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]mâle[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]femelle[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]le chat[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la cha[b][color=#C62828]tte[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]le chien[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]la chie[b][color=#C62828]nne[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]le lion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la lio[b][color=#C62828]nne[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]le paon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]la pao[b][color=#C62828]nne[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]le pigeon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la pigeo[b][color=#C62828]nne[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]-on → -[b]onne[/b], -ien → -[b]ienne[/b].[/cadre]
[page]
[titre]La fin change[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]mâle[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]femelle[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]le lou[b][color=#C62828]p[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la lou[b][color=#C62828]ve[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]l'âne[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]l'ân[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]le tigre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la tigr[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]le chame[b][color=#C62828]au[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]la chame[b][color=#C62828]lle[/color][/b][/font_size][/center][/cell][/table]
[cadre]Le chameau et la chamelle : [b]-eau[/b] devient [b]-elle[/b], comme un beau / une belle.[/cadre]
[page]
[titre]Des noms différents (1)[/titre]
Pour beaucoup d'animaux de la ferme, la femelle a un [b]autre nom[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le coq[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la poule[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le cheval[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la jument[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le taureau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la vache[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le bouc[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la chèvre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le bélier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la brebis[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le cochon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la truie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le dindon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la dinde[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le canard[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la cane[/font_size][/center][/cell][/table]
[cadre=astuce]Le mâle de la brebis s'appelle le [b]bélier[/b]. Le mot « mouton » sert pour tout le troupeau.[/cadre]
[page]
[titre]Des noms différents (2)[/titre]
Et pour les animaux sauvages :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le cerf[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la biche[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le sanglier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la laie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]le lièvre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]la hase[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le singe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]la guenon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]le jars[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]l'oie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20] [/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20] [/font_size][/center][/cell][/table]
[cadre]Ces noms ne se devinent pas : il faut les [b]apprendre[/b].[/cadre]
[page]
[titre]Trouver le mâle[/titre]
On me donne la femelle, je cherche le mâle : je fais le chemin [b]à l'envers[/b].
[cadre]la lapin[b]e[/b] → j'enlève le e → le [b]lapin[/b]
la lio[b]nne[/b] → j'enlève -ne → le [b]lion[/b]
la lou[b]ve[/b] → le [b]loup[/b] (pas « louv » !)
la hase → le [b]lièvre[/b] (nom différent)[/cadre]
[cadre=astuce]Je dis « le » devant ma réponse : « le loup » sonne juste ✓[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Souvent, j'ajoute un [b]e[/b] : le renard, la renarde.
• -on, -ien : je double le n → lionne, chienne, pigeonne.
• Parfois, la fin change : loup → louve, âne → ânesse, chameau → chamelle.
• Parfois, le nom change : bélier → brebis, lièvre → hase, jars → oie.
• Pour trouver le mâle, je fais le chemin à l'envers.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'masculin_feminin'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Compter les lettres d'un mot (CE1) - orthographe, notion 'orthographe_mots'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'orthographe', 'Compter les lettres d''un mot', $fiche$
[titre]Les lettres de l'alphabet[/titre]
L'alphabet a [b]26 lettres[/b]. Il y a les [b]voyelles[/b] et les [b]consonnes[/b].
[center]Les 6 voyelles :[/center]
[table=6][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]a[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]e[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]i[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]o[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]u[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,6,12,6][center][font_size=28][b]y[/b][/font_size][/center][/cell][/table]
[cadre]Toutes les autres lettres sont des [b]consonnes[/b] : b, c, d, f, g…[/cadre]
[page]
[titre]Je compte lettre par lettre[/titre]
Je pose mon doigt sous [b]chaque lettre[/b] et je compte.
[table=5][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]a[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]r[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]b[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]r[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]e[/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]1[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]2[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]3[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]4[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]5[/color][/b][/font_size][/center][/cell][/table]
[center][font_size=28][b]arbre → 5 lettres[/b][/font_size][/center]
[cadre=astuce]Je ne compte pas les sons : je compte les [b]lettres écrites[/b].[/cadre]
[page]
[titre]Les lettres muettes comptent[/titre]
Certaines lettres ne s'entendent pas, mais elles sont [b]écrites[/b] : je les compte.
[table=6][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]g[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]r[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]o[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]t[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]t[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]e[/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]1[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]2[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]3[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]4[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]5[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]6[/color][/b][/font_size][/center][/cell][/table]
[cadre]Dans « grotte », on n'entend pas le [b]e[/b] à la fin, mais il est là : [b]6 lettres[/b].[/cadre]
[page]
[titre]Un son, plusieurs lettres[/titre]
[table=6][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]r[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]i[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]d[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]e[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]a[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]u[/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]1[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]2[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]3[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]4[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]5[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]6[/color][/b][/font_size][/center][/cell][/table]
[cadre]Dans « rideau », le son [b]o[/b] s'écrit avec [b]3 lettres[/b] : e, a, u.
« rideau » a donc [b]6 lettres[/b], même si on n'entend que 4 sons.[/cadre]
[page]
[titre]Les lettres doubles[/titre]
Quand une lettre est écrite [b]deux fois[/b], je la compte [b]deux fois[/b].
[table=5][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]f[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]i[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]l[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]l[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]e[/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]1[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]2[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]3[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]4[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]5[/color][/b][/font_size][/center][/cell][/table]
[cadre]f-i-l-l-e : le l est doublé. « fille » a [b]5 lettres[/b].
Pareil pour « classe » : c-l-a-s-s-e = [b]6 lettres[/b].[/cadre]
[page]
[titre]Les accents[/titre]
Une lettre avec un accent compte pour [b]une seule lettre[/b].
[table=6][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]m[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]a[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]r[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]c[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]h[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]é[/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]1[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]2[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]3[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]4[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]5[/color][/b][/font_size][/center][/cell][cell padding=12,2,12,2][center][font_size=18][b][color=#unites]6[/color][/b][/font_size][/center][/cell][/table]
[cadre]Le [b]é[/b] est une seule lettre. Le son « ch » s'écrit avec 2 lettres : c et h.
« marché » a [b]6 lettres[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je pose mon doigt sous [b]chaque lettre[/b] et je compte.
• Les lettres [b]muettes[/b] comptent : grotte = 6.
• Un son peut s'écrire avec plusieurs lettres : eau = 3 lettres.
• Une lettre [b]doublée[/b] compte deux fois : fille = 5.
• Une lettre avec accent compte [b]une fois[/b] : é = 1 lettre.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'orthographe_mots'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche L'accord de l'adjectif (CE2) - orthographe, notion 'accord_adjectif'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'orthographe', 'L''accord de l''adjectif', $fiche$
[titre]L'adjectif[/titre]
L'[b]adjectif[/b] dit [b]comment est[/b] le nom : sa couleur, sa taille, son caractère…
[cadre]une prairie [b]verte[/b] · des chats [b]gentils[/b] · une maison [b]grande[/b][/cadre]
L'adjectif s'[b]accorde[/b] avec le nom : il prend son [b]genre[/b] (masculin ou féminin) et son [b]nombre[/b] (singulier ou pluriel).
[page]
[titre]Les 4 formes de l'adjectif[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]masculin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]féminin[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]singulier[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un chapeau vert[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une robe vert[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22][b]pluriel[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des chapeaux vert[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des robes vert[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][/table]
[cadre]Féminin : j'ajoute [b]e[/b]. Pluriel : j'ajoute [b]s[/b]. Féminin pluriel : j'ajoute [b]es[/b].[/cadre]
[page]
[titre]Je trouve le nom[/titre]
Pour accorder, je cherche [b]de qui on parle[/b] : je pose la question « [b]qui est… ?[/b] ».
[cadre]Cette maison semble ___ . → Qui semble grande ? [b]la maison[/b]
→ féminin singulier → [b]grande[/b][/cadre]
Les petits mots devant le nom m'aident :
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]masc. singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]fém. singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ce, cet, mon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]cette, ma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ces, mes, les, des[/font_size][/center][/cell][/table]
[page]
[titre]L'adjectif après le verbe[/titre]
L'adjectif peut être [b]loin[/b] du nom, après un verbe : il s'accorde [b]quand même[/b].
[cadre]Ces chapeaux [b]paraissent[/b] neuf[b]s[/b].
Cette robe [b]semble[/b] bleu[b]e[/b].
Ces chaussures [b]sont[/b] neuve[b]s[/b].
On dirait que ces murs sont blanc[b]s[/b].[/cadre]
[cadre=astuce]Après est, sont, semble, paraît, a l'air… je remonte jusqu'au nom ![/cadre]
[page]
[titre]Les adjectifs déjà en -e, -s, -x[/titre]
Un adjectif qui finit déjà par [b]e[/b] ne change pas au féminin.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]masculin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]féminin[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un ballon jaune[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une fleur jaune[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un enfant calme[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]une biche calme[/font_size][/center][/cell][/table]
Un adjectif qui finit par [b]s[/b] ou [b]x[/b] ne change pas au masculin pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un mur gris[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]des murs gris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un chat curieux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]des chats curieux[/font_size][/center][/cell][/table]
[page]
[titre]Des féminins spéciaux[/titre]
Certains adjectifs changent davantage au féminin :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]neu[b][color=#C62828]f[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]neu[b][color=#C62828]ve[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]blanc[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]blanc[b][color=#C62828]he[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]dou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]dou[b][color=#C62828]ce[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]long[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]long[b][color=#C62828]ue[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]b[b][color=#C62828]eau[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]b[b][color=#C62828]elle[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]gentil[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]gentil[b][color=#C62828]le[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ancien[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ancien[b][color=#C62828]ne[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]curieu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]curieu[b][color=#C62828]se[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]lég[b][color=#C62828]er[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]lég[b][color=#C62828]ère[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]épais[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]épais[b][color=#C62828]se[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Ma méthode en 3 étapes[/titre]
[cadre]1. Je trouve le [b]nom[/b] : « Qui est… ? »
2. Je regarde s'il est [b]masculin ou féminin[/b], [b]singulier ou pluriel[/b].
3. J'écris l'adjectif avec les bonnes lettres : e, s ou es.[/cadre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Ces chats sont ___.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]masc. pluriel[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]gentil[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Cette cantine semble ___.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]fém. singulier[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]bruyant[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Ces écharpes sont ___.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]fém. pluriel[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]neuv[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• L'adjectif s'accorde avec le nom qu'il décrit.
• Féminin → [b]e[/b] · pluriel → [b]s[/b] · féminin pluriel → [b]es[/b].
• Même après un verbe (est, semble, paraît), l'adjectif s'accorde.
• Déjà fini par e : pas de e en plus. Fini par s ou x : pas de s en plus.
• Féminins spéciaux : neuve, blanche, douce, longue, belle, gentille…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'accord_adjectif'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les homophones grammaticaux (CE2) - orthographe, notion 'homophones'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'orthographe', 'Les homophones grammaticaux', $fiche$
[titre]« on » ou « ont » ?[/titre]
[cadre][b]ont[/b] = le verbe [b]avoir[/b] (ils ont). Je peux dire « [b]avaient[/b] ».
Les enfants [b]ont[/b] mangé leur soupe. → avaient mangé ✓[/cadre]
[cadre][b]on[/b] = quelqu'un. Je peux dire « [b]il[/b] ».
[b]On[/b] joue dans la cour. → il joue ✓[/cadre]
[page]
[titre]« ces » ou « ses » ?[/titre]
[cadre][b]ces[/b] sert à [b]montrer[/b] : ces livres-là. Au singulier : « [b]ce[/b] livre ».
Regarde [b]ces[/b] vestes-là. → cette veste-là ✓[/cadre]
[cadre][b]ses[/b] veut dire [b]à lui / à elle[/b]. Au singulier : « [b]son[/b], [b]sa[/b] ».
Il range [b]ses[/b] sacs. → son sac ✓[/cadre]
[cadre=astuce]Attention : [b]c'est[/b] (cela est) et [b]sait[/b] (verbe savoir) se disent pareil aussi ![/cadre]
[page]
[titre]« sa » ou « ça » ?[/titre]
[cadre][b]sa[/b] veut dire [b]à lui / à elle[/b], devant un nom féminin. Je peux dire « [b]ma[/b] ».
Il a perdu [b]sa[/b] clé. → ma clé ✓[/cadre]
[cadre][b]ça[/b] veut dire [b]cela[/b].
[b]Ça[/b] me plaît beaucoup. → cela me plaît ✓[/cadre]
[page]
[titre]« leur » ou « leurs » ?[/titre]
[cadre]Devant un [b]verbe[/b], [b]leur[/b] veut dire « à eux » : il ne prend [b]jamais de s[/b].
Je [b]leur[/b] donne un dessin.[/cadre]
[cadre]Devant un [b]nom[/b], il s'accorde :
[b]leur[/b] vélo (un seul) · [b]leurs[/b] vélos (plusieurs).[/cadre]
[cadre=astuce]Devant un verbe, je peux dire « [b]lui[/b] » : je lui donne ✓ → leur, sans s.[/cadre]
[page]
[titre]quel, quelle ou qu'elle ?[/titre]
[cadre][b]quel[/b] / [b]quelle[/b] : devant un nom, pour poser une question.
[b]Quel[/b] gâteau ? (masculin) · [b]Quelle[/b] robe ? (féminin)[/cadre]
[cadre][b]qu'elle[/b] = que + elle. Je peux dire « [b]qu'il[/b] ».
J'aimerais [b]qu'elle[/b] chante avec moi. → qu'il chante ✓[/cadre]
[page]
[titre]Je retiens[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Mot[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je remplace par[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ont[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]avaient[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Ils ont faim.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]on[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]il[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]On part.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ces[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ce / cette[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ces livres-là[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ses[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]son / sa[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ses sacs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]sa[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]sa clé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ça[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]cela[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ça va[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]leur (+ verbe)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]lui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je leur dis[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu'elle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu'il[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu'elle vienne[/font_size][/center][/cell][/table]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'homophones'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Synonymes, contraires et sens des mots (CE2) - orthographe, notion 'vocabulaire_sens'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'orthographe', 'Synonymes, contraires et sens des mots', $fiche$
[titre]Rappel[/titre]
[cadre]Les [b]synonymes[/b] veulent dire presque la même chose : finir → terminer.
Les [b]contraires[/b] veulent dire l'inverse : facile → difficile.[/cadre]
[cadre=astuce]Un verbe a pour synonyme ou contraire un [b]verbe[/b] ; un adjectif, un [b]adjectif[/b].
gagner → perdre (verbe) · rapide → lent (adjectif)[/cadre]
[page]
[titre]Fabriquer un contraire[/titre]
On ajoute un [b]préfixe[/b] devant le mot :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]patient[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]im[/color][/b]patient[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]possible[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]im[/color][/b]possible[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]juste[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]in[/color][/b]juste[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]prudent[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]im[/color][/b]prudent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]honnête[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]mal[/color][/b]honnête[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]poli[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]im[/color][/b]poli[/font_size][/center][/cell][/table]
[cadre=astuce]Devant [b]p[/b], [b]b[/b] ou [b]m[/b], « in » devient « [b]im[/b] » : impatient, impoli.[/cadre]
[page]
[titre]Des contraires à connaître[/titre]
Certains contraires sont des mots [b]tout différents[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]public[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]privé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]supérieur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]inférieur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]majeur[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]mineur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]précis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]vague[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]net[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]flou[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]uni[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]rayé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]généreux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]égoïste[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]timide[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]audacieux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]commun[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]rare[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]souriant[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]grognon[/font_size][/center][/cell][/table]
[page]
[titre]Des synonymes plus forts[/titre]
Deux synonymes ne veulent pas toujours dire [b]exactement[/b] pareil : l'un peut être [b]plus fort[/b].
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]normal[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]plus fort[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]petit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]→[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]minuscule[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]grand[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]→[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]immense[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]fatigué[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]→[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]épuisé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]effrayant[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]→[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]terrifiant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]beau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]→[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]magnifique[/font_size][/center][/cell][/table]
[page]
[titre]Un mot, plusieurs sens[/titre]
Un même mot peut avoir [b]plusieurs sens[/b]. C'est la phrase qui le dit.
[cadre]un fil [b]fin[/b] (pas épais) → contraire : [b]épais[/b]
la [b]fin[/b] du film → contraire : [b]le début[/b][/cadre]
[cadre]une route [b]droite[/b] (pas tordue) → contraire : [b]tordue[/b]
la main [b]droite[/b] → contraire : [b]gauche[/b][/cadre]
[cadre=astuce]Je mets le mot dans une phrase pour savoir de quel sens on parle.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Synonyme = même sens ; contraire = sens inverse.
• in-, im-, mal-, dé- fabriquent des contraires : impatient, malhonnête.
• Certains synonymes sont plus forts : grand → immense.
• Un mot peut avoir plusieurs sens : je regarde la phrase.
• Pour vérifier, je remplace le mot dans une phrase.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'vocabulaire_sens'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Le pluriel des noms (CE2) - orthographe, notion 'singulier_pluriel'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'orthographe', 'Le pluriel des noms', $fiche$
[titre]Rappel : j'ajoute un s[/titre]
En général, au pluriel, j'ajoute un [b]s[/b] qui ne s'entend pas.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un ballon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des ballon[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]une porte[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des porte[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][/table]
[cadre]Mais certaines fins de mots prennent un [b]x[/b]. Il faut bien regarder la fin du mot ![/cadre]
[page]
[titre]-eau et -au → x[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des bateau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un chapeau[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des chapeau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un ruisseau[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des ruisseau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un tuyau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des tuyau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un noyau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des noyau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un préau[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des préau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Une exception : un landau → des landau[b]s[/b].[/cadre]
[page]
[titre]-eu → x[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un feu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des feu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un jeu[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des jeu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un cheveu[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des cheveu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un neveu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des neveu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un lieu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des lieu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]un vœu[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]des vœu[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Exceptions : un pneu → des pneu[b]s[/b], bleu → bleu[b]s[/b].[/cadre]
[page]
[titre]-ou : s, sauf 7 mots[/titre]
Les mots en -ou prennent un [b]s[/b] : un trou → des trou[b][color=#C62828]s[/color][/b], un clou → des clou[b][color=#C62828]s[/color][/b].
Sauf [b]7 mots[/b] qui prennent un [b]x[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]bijou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]caillou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]chou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]genou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]hibou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]joujou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]pou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22] [/font_size][/center][/cell][/table]
[cadre]« Viens, mon chou, mon bijou, sur mes genoux, avec tes joujoux, et jette des cailloux à ce hibou plein de poux ! »[/cadre]
[page]
[titre]-al → -aux[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un chev[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des chev[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]un journ[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des journ[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un anim[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des anim[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Exceptions : un bal, un carnaval, un festival → des bal[b]s[/b], des carnaval[b]s[/b], des festival[b]s[/b].[/cadre]
[page]
[titre]Les noms qui ne changent pas[/titre]
Un nom qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] ne change pas au pluriel.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une souris[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des souris[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]un prix[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des prix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un nez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des nez[/font_size][/center][/cell][/table]
[page]
[titre]Retrouver le singulier[/titre]
Je fais le chemin [b]à l'envers[/b] : j'enlève le s ou le x.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des panneau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un panneau[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]des pou[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]un pou[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des chev[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un chev[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]chevaux → cheval, pas « chevau » ! Je dis « un » devant pour vérifier.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• En général : [b]+ s[/b].
• -eau, -au, -eu → [b]x[/b] (sauf landaus, pneus, bleus).
• -ou → s, sauf les 7 mots en [b]x[/b] : bijou, caillou, chou, genou, hibou, joujou, pou.
• -al → [b]-aux[/b] (sauf bals, carnavals, festivals).
• Déjà fini par s, x, z : [b]pas de changement[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'singulier_pluriel'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les homophones : la, l'a, là, peu, peut, plutôt… (CM1) - orthographe, notion 'homophones'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'orthographe', 'Les homophones : la, l''a, là, peu, peut, plutôt…', $fiche$
[titre]la, l'a ou là ?[/titre]
[cadre][b]la[/b] : petit mot devant un nom féminin. Je peux dire « [b]une[/b] ».
Je ferme [b]la[/b] porte. → une porte ✓[/cadre]
[cadre][b]l'a[/b] = l' + a (verbe avoir). Je peux dire « [b]l'avait[/b] ».
Maya [b]l'a[/b] trouvée hier. → l'avait trouvée ✓[/cadre]
[cadre][b]là[/b] = un lieu. Je peux dire « [b]ici[/b] ».
Pose ton sac [b]là[/b]. → ici ✓[/cadre]
[page]
[titre]Le piège de l'a[/titre]
« [b]l'a[/b] » est presque toujours suivi d'un [b]participe passé[/b] (trouvée, appelée, vue…).
[cadre]Léo [b]l'a[/b] vue au marché. → Léo l'avait vue ✓
Rose [b]l'a[/b] appelée hier soir. → Rose l'avait appelée ✓[/cadre]
[cadre=astuce]Avec « tu », on écrit [b]l'as[/b] : tu [b]l'as[/b] trouvée → tu l'avais trouvée.[/cadre]
[page]
[titre]peu, peut ou peux ?[/titre]
[cadre][b]peu[/b] = pas beaucoup. Il y a [b]peu[/b] de monde ici.[/cadre]
[cadre][b]peut[/b], [b]peux[/b] = le verbe [b]pouvoir[/b]. Je peux dire « [b]pouvait[/b] ».
Il [b]peut[/b] venir demain. → il pouvait venir ✓[/cadre]
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je peux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]tu peux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il peut[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nous pouvons[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]vous pouvez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ils peuvent[/font_size][/center][/cell][/table]
[page]
[titre]plus tôt ou plutôt ?[/titre]
[cadre][b]plus tôt[/b] (en deux mots) = le contraire de [b]plus tard[/b].
Elle est arrivée [b]plus tôt[/b] ce matin. → plus tard ✓[/cadre]
[cadre][b]plutôt[/b] (en un mot) = [b]de préférence[/b].
Elle préfère [b]plutôt[/b] lire que jouer. → de préférence ✓[/cadre]
[cadre=astuce]Si je peux dire « plus tard », c'est [b]plus tôt[/b] en deux mots.[/cadre]
[page]
[titre]Je retiens[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Mot[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je remplace par[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]une[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]la porte[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]l'a[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]l'avait[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]il l'a vue[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]là[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ici[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]pose-le là[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]peu[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]pas beaucoup[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]peu de monde[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]peut, peux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]pouvait[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il peut venir[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]plus tôt[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]plus tard[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]arriver plus tôt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]plutôt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]de préférence[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]plutôt lire[/font_size][/center][/cell][/table]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'homophones'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les mots invariables (CM1) - orthographe, notion 'mots_invariables'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'orthographe', 'Les mots invariables', $fiche$
[titre]Un mot qui ne change jamais[/titre]
Un mot [b]invariable[/b] ne change [b]jamais[/b] : ni e au féminin, ni s au pluriel.
[cadre]Le chien dort [b]dehors[/b].
Les chiens dorment [b]dehors[/b].[/cadre]
« chien » et « dort » changent, « [b]dehors[/b] » reste pareil : il est invariable.
[cadre=astuce]Il faut les apprendre par cœur, car on ne peut pas les accorder.[/cadre]
[page]
[titre]Les adverbes de temps[/titre]
Ils disent [b]quand[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]hier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]aujourd'hui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]demain[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]maintenant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]toujours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]souvent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]rarement[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]jamais[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]déjà[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]bientôt[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]encore[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ensuite[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]autrefois[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]jadis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]désormais[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]soudain[/font_size][/center][/cell][/table]
[page]
[titre]Les adverbes de lieu[/titre]
Ils disent [b]où[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ici[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]là-bas[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dehors[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dedans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]partout[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ailleurs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]loin[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]près[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dessus[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dessous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]quelque part[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]nulle part[/font_size][/center][/cell][/table]
[page]
[titre]Les adverbes de manière[/titre]
Ils disent [b]comment[/b]. Beaucoup finissent par [b]-ment[/b], fabriqués à partir du féminin de l'adjectif :
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]adjectif[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]féminin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]adverbe[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]lent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]lente[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]lente[b][color=#C62828]ment[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]doux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]douce[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]douce[b][color=#C62828]ment[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]soigneux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]soigneuse[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]soigneuse[b][color=#C62828]ment[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]rapide[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]rapide[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]rapide[b][color=#C62828]ment[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Quantité et intensité[/titre]
Ils disent [b]combien[/b] ou [b]à quel point[/b] :
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]très[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]trop[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]assez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]beaucoup[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]peu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]presque[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]tellement[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]environ[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]davantage[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]seulement[/font_size][/center][/cell][/table]
[cadre]Cette soupe est [b]trop[/b] salée. Le verre est [b]presque[/b] plein.[/cadre]
[page]
[titre]Les prépositions[/titre]
Elles sont devant un nom pour dire [b]où[/b], [b]avec quoi[/b]… Elles sont invariables aussi.
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]devant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]derrière[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]dans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]sur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]sous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]avec[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]sans[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]pour[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]chez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]vers[/font_size][/center][/cell][/table]
[cadre]Range tes affaires [b]devant[/b] la porte.[/cadre]
[page]
[titre]Les mots de liaison[/titre]
Ils relient deux idées :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]opposition[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pourtant, cependant, néanmoins[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]conséquence[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]donc, alors, ainsi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]ordre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]d'abord, puis, ensuite, enfin[/font_size][/center][/cell][/table]
[cadre]Le chemin semblait dangereux ; elle a [b]pourtant[/b] continué.
→ « pourtant » montre que c'est le contraire de ce qu'on attendait.[/cadre]
[page]
[titre]Trouver l'adverbe dans une phrase[/titre]
[cadre]« Il pleut [b]souvent[/b] en automne. »
• « pleut » est un verbe, « automne » un nom.
• « en » est invariable, mais c'est une [b]préposition[/b].
• « souvent » dit [b]quand[/b] : c'est l'[b]adverbe[/b] ✓[/cadre]
[cadre=astuce]Je lis bien la question : elle demande un [b]adverbe[/b] ou une [b]préposition[/b] ?[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Un mot invariable ne prend [b]jamais[/b] de e ni de s.
• Les adverbes disent [b]quand[/b], [b]où[/b], [b]comment[/b], [b]combien[/b].
• Adverbe en -ment = adjectif au féminin + ment : lente → lentement.
• Prépositions : devant, dans, avec, sans, pour…
• Mots de liaison : pourtant, donc, ensuite, enfin…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'mots_invariables'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Bien écrire les mots (CM1) - orthographe, notion 'orthographe_mots'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'orthographe', 'Bien écrire les mots', $fiche$
[titre]m devant m, b, p[/titre]
Devant [b]m[/b], [b]b[/b] ou [b]p[/b], on écrit [b]m[/b] au lieu de n.
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]i[b][color=#C62828]m[/color][/b]portant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]e[b][color=#C62828]m[/color][/b]porter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]co[b][color=#C62828]m[/color][/b]parer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]cha[b][color=#C62828]m[/color][/b]bre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]te[b][color=#C62828]m[/color][/b]pête[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]i[b][color=#C62828]m[/color][/b]mense[/font_size][/center][/cell][/table]
[cadre=astuce]Exceptions : bonbon, bonbonnière, embonpoint.[/cadre]
[page]
[titre]Les doubles consonnes au début[/titre]
Beaucoup de mots commencent par [b]acc-[/b], [b]app-[/b], [b]att-[/b], [b]arr-[/b], [b]eff-[/b], [b]off-[/b], [b]ill-[/b] :
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]acc[/color][/b]rocher[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]acc[/color][/b]ident[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]arr[/color][/b]ondir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]off[/color][/b]rir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]ill[/color][/b]ustration[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b][color=#C62828]att[/color][/b]aquer[/font_size][/center][/cell][/table]
[cadre]Une lettre doublée se voit mais ne s'entend pas : il faut [b]regarder[/b] le mot.[/cadre]
[page]
[titre]Les doubles consonnes à la fin[/titre]
Les fins en [b]-elle[/b], [b]-ette[/b], [b]-esse[/b], [b]-enne[/b], [b]-onne[/b] ont une consonne doublée :
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]fic[b][color=#C62828]elle[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]sauter[b][color=#C62828]elle[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]moqu[b][color=#C62828]ette[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]marionn[b][color=#C62828]ette[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]par[b][color=#C62828]esse[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]pers[b][color=#C62828]onne[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Le son « s » entre deux voyelles[/titre]
Entre deux voyelles, un seul [b]s[/b] se prononce [b]z[/b] : une vali[b]s[/b]e.
Pour entendre [b]s[/b], j'écris :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b][color=#C62828]ss[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]bro[b][color=#C62828]ss[/color][/b]er, de[b][color=#C62828]ss[/color][/b]in[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b][color=#C62828]c[/color][/b] devant e, i[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]fi[b][color=#C62828]c[/color][/b]elle, méde[b][color=#C62828]c[/color][/b]in[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b][color=#C62828]ç[/color][/b] devant a, o, u[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]gar[b][color=#C62828]ç[/color][/b]on, re[b][color=#C62828]ç[/color][/b]u[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20][b][color=#C62828]t[/color][/b] dans -tion[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]opéra[b][color=#C62828]t[/color][/b]ion[/font_size][/center][/cell][/table]
[page]
[titre]Les noms en -tion[/titre]
Beaucoup de noms finissent par [b]-tion[/b]. Ils viennent souvent d'un [b]verbe[/b] :
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]verbe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]nom[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]préparer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]prépara[b][color=#C62828]tion[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]opérer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]opéra[b][color=#C62828]tion[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]participer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]participa[b][color=#C62828]tion[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]indiquer[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]indica[b][color=#C62828]tion[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Mais : permettre → permi[b]ssion[/b].[/cadre]
[page]
[titre]-eil, -eille, -ail, -aille[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]nom masculin[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]nom féminin[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un sol[b][color=#C62828]eil[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une corb[b][color=#C62828]eille[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un trav[b][color=#C62828]ail[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]une méd[b][color=#C62828]aille[/color][/b][/font_size][/center][/cell][/table]
[cadre]Les noms [b]masculins[/b] finissent par -eil / -ail ; les [b]féminins[/b] par -eille / -aille.
Les verbes prennent -ill- : surv[b]eill[/b]er, cons[b]eill[/b]er.[/cadre]
[page]
[titre]Les verbes en -eler et -eter[/titre]
Au présent, beaucoup de ces verbes [b]doublent[/b] le l ou le t devant un e muet :
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]infinitif[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]présent[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]appeler[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]j'appe[b][color=#C62828]ll[/color][/b]e[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]jeter[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]je je[b][color=#C62828]tt[/color][/b]e[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]épeler[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]j'épe[b][color=#C62828]ll[/color][/b]e[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]étiqueter[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]j'étique[b][color=#C62828]tt[/color][/b]e[/font_size][/center][/cell][/table]
[cadre]Mais : nous appelons, nous jetons (pas de e muet après).[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je découpe le mot en [b]syllabes[/b] : a-ven-ture.
2. Je cherche un mot de la [b]même famille[/b] : dent → dentiste.
3. Je regarde les lettres [b]une par une[/b] : pas de lettre en trop, pas de lettre inversée.[/cadre]
[cadre=astuce]Les fautes de frappe se cachent souvent à la [b]fin[/b] du mot : « aventuer » au lieu de « aventure ».[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• m devant m, b, p : important, chambre.
• Doubles consonnes : acc-, att-, off-… et -elle, -ette, -esse, -onne.
• Le son « s » entre deux voyelles : ss, c, ç ou t (-tion).
• -eil / -ail au masculin, -eille / -aille au féminin.
• appeler → j'appelle, jeter → je jette.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'orthographe_mots'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les homophones : quand, sans, tout… (CM2) - orthographe, notion 'homophones'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'orthographe', 'Les homophones : quand, sans, tout…', $fiche$
[titre]quand, quant ou qu'en ?[/titre]
[cadre][b]quand[/b] = à quel moment. Je peux dire « [b]lorsque[/b] » ou poser une question.
[b]Quand[/b] pars-tu ? Je me demande [b]quand[/b] le train va arriver.[/cadre]
[cadre][b]quant[/b] est toujours suivi de [b]à, au, aux[/b] : [b]quant à[/b] moi = en ce qui me concerne.[/cadre]
[cadre][b]qu'en[/b] = que + en. Il ne s'exprime [b]qu'en[/b] français. → seulement en français ✓[/cadre]
[page]
[titre]sans, s'en, sens ou sang ?[/titre]
[cadre][b]sans[/b] = le contraire de [b]avec[/b]. Elle part [b]sans[/b] dire au revoir.[/cadre]
[cadre][b]s'en[/b] = se + en, devant un [b]verbe[/b]. Je peux dire « [b]je m'en[/b] ».
Elle [b]s'en[/b] souvient. → je m'en souviens ✓[/cadre]
[cadre][b]sens[/b] = la signification, ou le verbe sentir. Cette phrase n'a pas de [b]sens[/b].
[b]sang[/b] = le liquide rouge dans le corps.[/cadre]
[page]
[titre]tout, tous, toute, toutes[/titre]
Devant un nom, [b]tout[/b] s'accorde comme un adjectif :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]tout le monde[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]tout le journal[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]tous les enfants[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]tous les jours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]toute la classe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]toute la nuit[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]toutes les filles[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]toutes les fleurs[/font_size][/center][/cell][/table]
[cadre=astuce]Je regarde le nom : masculin ou féminin ? singulier ou pluriel ?[/cadre]
[page]
[titre]« tous » et « toutes » tout seuls[/titre]
Quand il [b]remplace[/b] un nom, « tous » ou « toutes » s'accorde avec ce nom.
[cadre]Les enfants sont [b]tous[/b] arrivés. → tous les enfants
Elles sont [b]toutes[/b] contentes. → toutes les filles[/cadre]
[cadre=astuce]« tous » se prononce souvent « tousse » quand il est tout seul : ils sont tous là.[/cadre]
[page]
[titre]Je retiens[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Mot[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je pense à[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]quand[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]lorsque[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]quand pars-tu ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]quant à[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]en ce qui concerne[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]quant à moi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]qu'en[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]que + en[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]qu'en français[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]sans[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]≠ avec[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]sans bruit[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]s'en[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je m'en[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]elle s'en va[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]sens[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]signification[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]le sens du mot[/font_size][/center][/cell][/table]
[cadre]tout / tous / toute / toutes s'accordent avec le nom.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'homophones'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les accents sur le e (CM2) - orthographe, notion 'accents'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'orthographe', 'Les accents sur le e', $fiche$
[titre]Trois accents sur le e[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]é[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]accent aigu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]bébé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]è[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]accent grave[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]père[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]ê[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]accent circonflexe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]fête[/font_size][/center][/cell][/table]
[cadre]é se prononce le son [b]« é »[/b]. è et ê se prononcent le son [b]« è »[/b].[/cadre]
[page]
[titre]L'accent aigu é[/titre]
Le [b]é[/b] se trouve souvent à la [b]fin d'une syllabe[/b] ou au [b]début du mot[/b].
[cadre]bé-bé · ré-ponse · thé-âtre · sé-vé-ri-té · é-quipe[/cadre]
[cadre=astuce]Je découpe le mot en syllabes : si la syllabe finit par le son « é », c'est souvent [b]é[/b].[/cadre]
[page]
[titre]L'accent grave è[/titre]
Le [b]è[/b] se trouve souvent devant une syllabe qui finit par un [b]e muet[/b], ou devant un [b]s final[/b].
[cadre]pè-re · zè-bre · cuil-lè-re · siè-cle[/cadre]
[cadre]accè[b]s[/b] · aprè[b]s[/b] · trè[b]s[/b] · procè[b]s[/b][/cadre]
[page]
[titre]L'accent circonflexe ê[/titre]
Le [b]ê[/b] remplace souvent un [b]s[/b] qui a disparu. On le retrouve dans les mots de la même famille !
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la f[b][color=#C62828]ê[/color][/b]te[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un fe[b][color=#C62828]s[/color][/b]tival[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]la for[b][color=#C62828]ê[/color][/b]t[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]un fore[b][color=#C62828]s[/color][/b]tier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la b[b][color=#C62828]ê[/color][/b]te[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une be[b][color=#C62828]s[/color][/b]tiole[/font_size][/center][/cell][/table]
[page]
[titre]Pas d'accent[/titre]
Le e n'a [b]pas d'accent[/b] quand il est suivi :
[cadre]• de [b]deux consonnes[/b] : pi[b]e[/b]rre, b[b]e[/b]lle, t[b]e[/b]rre
• d'un [b]x[/b] : [b]e[/b]xercice, [b]e[/b]xplorer
• d'une [b]consonne finale[/b] : m[b]e[/b]r, n[b]e[/b]z, ch[b]e[/b]f[/cadre]
[cadre=astuce]Un e muet en fin de mot n'a jamais d'accent : tabl[b]e[/b], pomm[b]e[/b].[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. J'[b]écoute[/b] le son : « é » ou « è » ?
2. Je [b]découpe[/b] le mot en syllabes.
3. Je regarde ce qui [b]suit[/b] le e : deux consonnes ou un x → pas d'accent.
4. Pour ê, je cherche un mot de la [b]même famille[/b] avec un s.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]é[/b] (aigu) : son fermé, souvent en fin de syllabe (bébé).
• [b]è[/b] (grave) : devant une syllabe avec e muet ou devant s final (père, très).
• [b]ê[/b] (circonflexe) : souvent un ancien s (fête → festival).
• [b]Pas d'accent[/b] devant deux consonnes, un x ou une consonne finale.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'accents'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche La formation des mots (CM2) - orthographe, notion 'formation_mots'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'orthographe', 'La formation des mots', $fiche$
[titre]Radical, préfixe, suffixe[/titre]
Un mot peut être fabriqué à partir d'un autre :
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b][color=#C62828]re[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]tourn[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24][b][color=#C62828]er[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]préfixe[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]radical[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]suffixe[/font_size][/center][/cell][/table]
[cadre]Le [b]radical[/b] est le cœur du mot. Le [b]préfixe[/b] se met [b]devant[/b], le [b]suffixe[/b] [b]derrière[/b].[/cadre]
[page]
[titre]Les préfixes (1)[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]préfixe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]sens[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]re-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]de nouveau, en arrière[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]relire, retourner[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]dé-, dés-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le contraire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]défaire, déboucher[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]in-, im-, il-, ir-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le contraire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]incapable, illisible[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]mé-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]mal[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]mécontent[/font_size][/center][/cell][/table]
[cadre=astuce]in- devient [b]im-[/b] devant m, b, p, [b]il-[/b] devant l, [b]ir-[/b] devant r : impossible, illisible, irrégulier.[/cadre]
[page]
[titre]Les préfixes (2)[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]préfixe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]sens[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pré-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]avant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]prévoir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]post-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]après[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]postscolaire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]sous-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]en dessous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]sous-marin[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]sur-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]au-dessus, trop[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]survoler, surchauffer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]anti-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]contre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]antivol, antigel[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]trans-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]à travers[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]transporter[/font_size][/center][/cell][/table]
[page]
[titre]Les préfixes de nombre[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]préfixe[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]sens[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]mono-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]un seul[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]monocolore[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]bi-[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]deux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]bicyclette[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]multi-[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]plusieurs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]multicolore[/font_size][/center][/cell][/table]
[cadre]Une bicyclette a [b]deux[/b] roues. Un objet multicolore a [b]plusieurs[/b] couleurs.[/cadre]
[page]
[titre]Les suffixes des noms[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-age[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nettoyage[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-tion[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]création[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-ment[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]rangement[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-eur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]voleur, laideur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-iste[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]dentiste[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-esse[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]gentillesse[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-té, -ité[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pureté, rapidité[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-isme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nationalisme[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-erie[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]boulangerie[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-ette[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]maisonnette[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]-oir, -oire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arrosoir, baignoire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]-ice[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]justice[/font_size][/center][/cell][/table]
[page]
[titre]Adjectifs et adverbes[/titre]
Des suffixes fabriquent des [b]adjectifs[/b] :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]-able[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]aimable[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]-eux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]courageux[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]-if[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]sportif[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]-al, -el[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]national, naturel[/font_size][/center][/cell][/table]
Le suffixe [b]-ment[/b] fabrique des [b]adverbes[/b] : rapide → rapide[b]ment[/b].
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je cherche le mot de [b]base[/b] caché dedans : gentillesse → [b]gentil[/b].
2. Je regarde ce qu'on a ajouté [b]devant[/b] (préfixe) ou [b]derrière[/b] (suffixe).
3. Je pense au [b]sens[/b] : anti + vol = qui protège [b]contre[/b] le vol.[/cadre]
[cadre=astuce]Le suffixe change souvent la nature du mot : laver (verbe) → lavage (nom).[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Préfixe [b]devant[/b] le radical, suffixe [b]derrière[/b].
• Préfixes : re- (de nouveau), dé- / in- (contraire), pré- (avant), anti- (contre), bi- (deux)…
• Suffixes de noms : -age, -tion, -eur, -iste, -esse, -té…
• Suffixes d'adjectifs : -able, -eux, -if. D'adverbes : -ment.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'formation_mots'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Bien écrire les mots (2) (CM2) - orthographe, notion 'orthographe_mots'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'orthographe', 'Bien écrire les mots (2)', $fiche$
[titre]Rappel[/titre]
[cadre]• [b]m[/b] devant m, b, p : instrument, température.
• Doubles consonnes : addition, attaquer, collection…
• -eil / -ail (masculin), -eille / -aille (féminin).
• Je découpe en syllabes et je regarde les lettres une par une.[/cadre]
[page]
[titre]-tion, -ssion ou -xion ?[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]-tion (le plus fréquent)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]destina[b][color=#C62828]tion[/color][/b], organisa[b][color=#C62828]tion[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]-ssion[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]impre[b][color=#C62828]ssion[/color][/b], succe[b][color=#C62828]ssion[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]-xion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]réfle[b][color=#C62828]xion[/color][/b], conne[b][color=#C62828]xion[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]-xion est rare : il suffit de retenir réfle[b]x[/b]ion, conne[b]x[/b]ion, fle[b]x[/b]ion.
Pour -ssion, je pense au mot de la même famille : perme[b]tt[/b]re → permi[b]ss[/b]ion.[/cadre]
[page]
[titre]Préfixe + même lettre = lettre doublée[/titre]
Quand un préfixe se colle à un mot qui commence par la même lettre, on [b]double[/b] la consonne.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ad + dition[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]a[b][color=#C62828]dd[/color][/b]ition[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]col + laboration[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]co[b][color=#C62828]ll[/color][/b]aboration[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ap + partenir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]a[b][color=#C62828]pp[/color][/b]artenir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]ir + régulier[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]i[b][color=#C62828]rr[/color][/b]égulier[/font_size][/center][/cell][/table]
[page]
[titre]Les accents dans les mots[/titre]
[cadre]• Pas d'accent devant une consonne doublée : d[b]e[/b]ntelle, [b]e[/b]ssayer.
• [b]ex-[/b] ne prend jamais d'accent : [b]ex[/b]ploration, [b]ex[/b]traction.
• Au début d'un mot, on entend souvent [b]dé-[/b], [b]ré-[/b], [b]pré-[/b] : découverte, répétition.[/cadre]
[cadre=astuce]Pas d'accent sur a, i, o au milieu d'un mot courant : « magicien », pas « màgicien ».[/cadre]
[page]
[titre]Les lettres muettes[/titre]
Je cherche un mot de la [b]même famille[/b] pour entendre la lettre muette :
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un crapau[b][color=#C62828]d[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]une crapau[b][color=#C62828]d[/color][/b]ine[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un tapi[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]tapi[b][color=#C62828]ss[/color][/b]er[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]un bor[b][color=#C62828]d[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]bor[b][color=#C62828]d[/color][/b]er[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un lai[b][color=#C62828]t[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]un lai[b][color=#C62828]t[/color][/b]ier[/font_size][/center][/cell][/table]
[cadre][b]ph[/b] se prononce f : photographe, catastrophe.[/cadre]
[page]
[titre]Les fins de mots[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]-ance, -ence[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]assurance, vigilance, dépendance[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]-té (sans e)[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]solidarité, générosité, visibilité[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]-oir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]trottoir, couloir, miroir[/font_size][/center][/cell][/table]
[cadre=astuce]Les noms féminins en [b]-té[/b] ne prennent pas de e, sauf : la dictée, la jetée, la montée, la portée.
Les noms [b]masculins[/b] finissent souvent par [b]-oir[/b] (un trottoir), les [b]féminins[/b] par [b]-oire[/b] (une baignoire, une histoire).[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• -tion est le plus fréquent ; -xion est rare (réflexion, connexion).
• Préfixe + même lettre → consonne doublée : addition, collection.
• Pas d'accent devant une consonne doublée ni dans ex-.
• Lettres muettes : je cherche un mot de la même famille.
• Noms féminins en -té : pas de e (sauf dictée, jetée, montée, portée).[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'orthographe_mots'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
