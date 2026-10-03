-- Toutes les fiches de cours Grammaire CE1 -> CM2 (2026-10-03), une seule transaction.
begin;
-- Fiche La nature des mots (CE1) - grammaire, notion 'nature_mots'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'grammaire', 'La nature des mots', $fiche$
[titre]Chaque mot a une nature[/titre]
Les mots sont rangés en [b]familles[/b] : c'est leur [b]nature[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]nom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]verbe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]adjectif[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]adverbe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]fleur[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]cuisiner[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]généreux[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]soudainement[/font_size][/center][/cell][/table]
[cadre]Pour trouver la nature d'un mot, je fais des [b]tests[/b].[/cadre]
[page]
[titre]Le nom[/titre]
Le [b]nom[/b] désigne une personne, un animal, une chose ou une idée.
[cadre]un fantôme · une fleur · le laboratoire · des ciseaux[/cadre]
[cadre=astuce]Test : je peux mettre [b]le[/b], [b]la[/b], [b]un[/b] ou [b]une[/b] devant.
« un fantôme » ✓ → c'est un [b]nom[/b].[/cadre]
[page]
[titre]Le verbe[/titre]
Le [b]verbe[/b] dit ce qu'on [b]fait[/b] (une action) ou comment on [b]est[/b].
[cadre]montrer · répondre · cuisiner · grandir[/cadre]
[cadre=astuce]Test : je peux le [b]conjuguer[/b] avec je, tu, il…
répondre → [b]je[/b] réponds, [b]il[/b] répond ✓ → c'est un [b]verbe[/b].
À l'infinitif, il finit souvent par [b]-er[/b], [b]-ir[/b] ou [b]-re[/b].[/cadre]
[page]
[titre]L'adjectif[/titre]
L'[b]adjectif[/b] dit [b]comment est[/b] le nom.
[cadre]un garçon [b]généreux[/b] · une histoire [b]incroyable[/b][/cadre]
[cadre=astuce]Test : je peux le mettre à côté d'un nom et dire « [b]très[/b] » devant.
un enfant très généreux ✓ → c'est un [b]adjectif[/b].
Il change au féminin : généreux → généreu[b]se[/b].[/cadre]
[page]
[titre]L'adverbe[/titre]
L'[b]adverbe[/b] dit [b]comment[/b], [b]quand[/b] ou [b]où[/b]. Il ne change [b]jamais[/b].
[cadre]Il court [b]vite[/b]. Elle arrive [b]soudainement[/b]. Il pleut [b]souvent[/b].[/cadre]
[cadre=astuce]Beaucoup d'adverbes finissent par [b]-ment[/b] : naturelle[b]ment[/b], soudaine[b]ment[/b].[/cadre]
[page]
[titre]Mes tests[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]nom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]je peux dire un, une, le, la devant[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]verbe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]je peux dire je, tu, il devant[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]adjectif[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]je peux dire « très » devant et le mettre à côté d'un nom[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]adverbe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]il ne change jamais, souvent en -ment[/font_size][/center][/cell][/table]
[page]
[titre]Un mot, deux natures[/titre]
Certains mots changent de nature selon la [b]phrase[/b].
[cadre]Ma [b]montre[/b] indique huit heures. → [b]ma[/b] montre : c'est un [b]nom[/b].
Il [b]montre[/b] le chemin. → [b]il[/b] montre : c'est un [b]verbe[/b].[/cadre]
[cadre=astuce]Je regarde le petit mot juste devant : un déterminant (ma, la) → nom ; un pronom (il, je) → verbe.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]Nom[/b] : personne, animal, chose → un fantôme.
• [b]Verbe[/b] : action, se conjugue → il répond.
• [b]Adjectif[/b] : dit comment est le nom → généreux.
• [b]Adverbe[/b] : ne change pas, souvent en -ment → soudainement.
• Dans une phrase, je regarde le mot devant pour vérifier.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'nature_mots'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Le pluriel des noms (CE1) - grammaire, notion 'singulier_pluriel'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce1', 'grammaire', 'Le pluriel des noms', $fiche$
[titre]Singulier et pluriel[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier : un seul[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel : plusieurs[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]un robot[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]des robot[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]une trousse[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=21]des trousse[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]un canapé[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]des canapé[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][/table]
[cadre]En général, au pluriel, j'ajoute un [b]s[/b]. Il ne s'entend pas.[/cadre]
[page]
[titre]-eau → x[/titre]
Les noms en [b]-eau[/b] prennent un [b]x[/b] au pluriel.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un drapeau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des drapeau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un morceau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des morceau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un panneau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des panneau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un roseau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des roseau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un réseau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des réseau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un niveau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des niveau[b][color=#C62828]x[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]-al → -aux[/titre]
Les noms en [b]-al[/b] deviennent [b]-aux[/b].
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un chev[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des chev[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un journ[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des journ[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un hôpit[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des hôpit[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un can[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des can[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un boc[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des boc[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un m[b][color=#C62828]al[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des m[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Quelques mots en -ail → -aux[/titre]
La plupart des noms en -ail prennent un s : un éventail → des éventail[b][color=#C62828]s[/color][/b].
Mais quelques-uns deviennent [b]-aux[/b] :
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]singulier[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pluriel[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un trav[b][color=#C62828]ail[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]des trav[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]un cor[b][color=#C62828]ail[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=22]des cor[b][color=#C62828]aux[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Les noms qui ne changent pas[/titre]
Un nom qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] reste pareil au pluriel.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un radis[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des radis[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un repas[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des repas[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]une voix[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des voix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un prix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des prix[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]un nez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]des nez[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]un gaz[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]des gaz[/font_size][/center][/cell][/table]
[cadre=astuce]C'est le petit mot devant (un / des) qui montre le pluriel.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• En général : [b]+ s[/b] (un robot, des robots).
• -eau → [b]x[/b] : des drapeaux.
• -al → [b]-aux[/b] : des chevaux. Aussi : travail → travaux, corail → coraux.
• Déjà fini par s, x, z : [b]pas de changement[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'singulier_pluriel'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les pronoms personnels (CE2) - grammaire, notion 'pronoms'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'grammaire', 'Les pronoms personnels', $fiche$
[titre]Le pronom remplace un nom[/titre]
Le [b]pronom[/b] remplace un groupe de mots pour ne pas le répéter.
[cadre][b]La maîtresse[/b] écrit au tableau. → [b]Elle[/b] écrit au tableau.[/cadre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]je[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]tu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]il[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]elle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]nous[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]vous[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]ils[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]elles[/font_size][/center][/cell][/table]
[page]
[titre]Masculin ou féminin ?[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]groupe de mots[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pronom[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]le sentier, le livre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]il[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]la carte, la voisine[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]elle[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]les marins, les crabes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]ils[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]les mouettes, les chaises[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]elles[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Avec « l' », je cherche si le nom est masculin ou féminin : [b]une[/b] échelle → l'échelle → [b]elle[/b].[/cadre]
[page]
[titre]Garçons et filles ensemble[/titre]
[cadre]Léo et Tom → [b]ils[/b]
Jade et Naomi → [b]elles[/b]
Léo et Zoé → [b]ils[/b][/cadre]
[cadre=astuce]Dès qu'il y a [b]au moins un masculin[/b] dans le groupe, on dit [b]ils[/b].[/cadre]
[page]
[titre]Avec moi, avec toi[/titre]
[cadre]Yasmine [b]et moi[/b] → [b]nous[/b] (je fais partie du groupe)
Léo [b]et toi[/b] → [b]vous[/b] (tu fais partie du groupe)[/cadre]
[cadre=astuce]« moi » dans le groupe → nous. « toi » dans le groupe (sans moi) → vous.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Masculin singulier → [b]il[/b] ; féminin singulier → [b]elle[/b].
• Masculin pluriel ou groupe mélangé → [b]ils[/b] ; féminin pluriel → [b]elles[/b].
• Avec « moi » → [b]nous[/b] ; avec « toi » → [b]vous[/b].
• Devant l', je cherche le genre avec un / une.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pronoms'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Types et formes de phrases (CE2) - grammaire, notion 'types_phrases'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'grammaire', 'Types et formes de phrases', $fiche$
[titre]Les 4 types de phrases[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]type[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]à quoi elle sert[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]déclarative[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]elle raconte, elle informe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Le bus arrive bientôt.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]interrogative[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]elle pose une question[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]As-tu un chat ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]exclamative[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]elle montre une émotion[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Quelle belle étoile ![/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]impérative[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]elle donne un ordre, un conseil[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]Mets ton bonnet.[/font_size][/center][/cell][/table]
[page]
[titre]Le point à la fin[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]déclarative[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828].[/color][/b] point[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]interrogative[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]?[/color][/b] point d'interrogation[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]exclamative[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]![/color][/b] point d'exclamation[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]impérative[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828].[/color][/b] ou [b][color=#C62828]![/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]« Comme… ! », « Quel… ! », « Que… ! » annoncent souvent une phrase [b]exclamative[/b].[/cadre]
[page]
[titre]La phrase impérative[/titre]
La phrase impérative donne un [b]ordre[/b] : elle n'a [b]pas de sujet[/b] devant le verbe.
[cadre][b]Prends[/b] ton goûter. · [b]Écrivez[/b] la date. · [b]Rangeons[/b] la classe.[/cadre]
[cadre=astuce]Tu prends ton goûter. (déclarative) → [b]Prends[/b] ton goûter. (impérative) : le « tu » disparaît.[/cadre]
[page]
[titre]Poser une question[/titre]
Il y a plusieurs façons de transformer une phrase en question :
[cadre]Vous habitez près de l'école.
→ [b]Est-ce que[/b] vous habitez près de l'école ?
→ [b]Habitez-vous[/b] près de l'école ? (on inverse le sujet et le verbe, avec un trait d'union)[/cadre]
[cadre=astuce]Les mots qui, quand, où, pourquoi, comment commencent souvent une question.[/cadre]
[page]
[titre]Forme affirmative ou négative[/titre]
La forme [b]négative[/b] dit le contraire. Elle a [b]deux[/b] petits mots autour du verbe.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]affirmative[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]négative[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Tom aime les épinards.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Tom [b][color=#C62828]n'[/color][/b]aime [b][color=#C62828]pas[/color][/b] les épinards.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Il pleut encore.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Il [b][color=#C62828]ne[/color][/b] pleut [b][color=#C62828]plus[/color][/b].[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Nous avons vu quelque chose.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Nous [b][color=#C62828]n'[/color][/b]avons [b][color=#C62828]rien[/color][/b] vu.[/font_size][/center][/cell][/table]
[cadre]ne… pas · ne… plus · ne… jamais · ne… rien · ne… personne[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Déclarative ( . ) : je raconte. Interrogative ( ? ) : je pose une question.
• Exclamative ( ! ) : je m'exclame. Impérative : je donne un ordre, sans sujet.
• Question : « Est-ce que… ? » ou inversion « Habitez-vous… ? ».
• Négative : ne… pas, ne… plus, ne… jamais, ne… rien, ne… personne.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'types_phrases'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche L'accord du sujet et du verbe (CE2) - grammaire, notion 'accord_sujet_verbe'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'grammaire', 'L''accord du sujet et du verbe', $fiche$
[titre]Le verbe s'accorde avec le sujet[/titre]
Le verbe change sa terminaison selon [b]qui[/b] fait l'action : c'est le [b]sujet[/b].
[cadre]Le poisson nag[b]e[/b]. → Les poissons nag[b]ent[/b].[/cadre]
[cadre=astuce]Pour trouver le sujet, je pose la question « [b]Qui est-ce qui[/b] nage ? » → les poissons.[/cadre]
[page]
[titre]Je remplace le sujet par un pronom[/titre]
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]sujet[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]pronom + verbe[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]mon frère, la secrétaire[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b][color=#C62828]il / elle[/color][/b] porte[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]les voisins, les randonneurs[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b][color=#C62828]ils / elles[/color][/b] observent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]ma sœur et moi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20][b][color=#C62828]nous[/color][/b] regardons[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]toi et Léo[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b][color=#C62828]vous[/color][/b] regardez[/font_size][/center][/cell][/table]
[page]
[titre]Les verbes en -er au présent[/titre]
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]tu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il, elle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]vous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ils, elles[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]ons[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]ez[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]arros[b][color=#C62828]ent[/color][/b][/font_size][/center][/cell][/table]
[cadre=astuce]Avec ils / elles : [b]-ent[/b], qui ne s'entend pas ! Les poissons nag[b]ent[/b].[/cadre]
[page]
[titre]Les verbes comme finir[/titre]
[table=6][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]tu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]il, elle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]vous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ils, elles[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]is[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]is[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]it[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]issons[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]issez[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pun[b][color=#C62828]issent[/color][/b][/font_size][/center][/cell][/table]
[cadre]Pareil : nourrir, vieillir, grandir, choisir…[/cadre]
[page]
[titre]Des verbes à connaître[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]être[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]prendre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]courir[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]je[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]suis[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]prends[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]cours[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]tu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]es[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]prends[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]cours[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]il, elle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]est[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]prend[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]court[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]nous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sommes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]prenons[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]courons[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]vous[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]êtes[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]prenez[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=17]courez[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]ils, elles[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sont[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]prennent[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]courent[/font_size][/center][/cell][/table]
[page]
[titre]Attention au sujet éloigné[/titre]
Le sujet n'est pas toujours juste avant le verbe.
[cadre][b]Chaque jour[/b], la secrétaire arrose les plantes.
« Chaque jour » n'est pas le sujet : qui est-ce qui arrose ? → [b]la secrétaire[/b] → arros[b]e[/b].[/cadre]
[cadre=astuce]Je cache les mots qui disent quand ou où : il reste le sujet et le verbe.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je trouve le sujet : « Qui est-ce qui… ? ».
• Je le remplace par un pronom : il, elle, ils, elles…
• -er : e, es, e, ons, ez, [b]ent[/b]. Comme finir : is, is, it, issons, issez, issent.
• Ce qui dit quand ou où n'est pas le sujet.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'accord_sujet_verbe'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Le sujet du verbe (CE2) - grammaire, notion 'fonctions'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'grammaire', 'Le sujet du verbe', $fiche$
[titre]Qui fait l'action ?[/titre]
Le [b]sujet[/b] est le groupe de mots qui [b]fait l'action[/b] du verbe.
[cadre][b]Le pompier[/b] éteint l'incendie.
Qui est-ce qui éteint ? → [b]le pompier[/b] : c'est le sujet.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je trouve le [b]verbe[/b] (le mot qui se conjugue).
2. Je pose la question « [b]Qui est-ce qui[/b] + verbe ? ».
3. La réponse est le [b]sujet[/b].[/cadre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Les lapins creusent un terrier.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Qui est-ce qui creuse ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19][b][color=#C62828]Les lapins[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Le truc de « C'est… qui »[/titre]
Je peux encadrer le sujet avec « [b]C'est… qui[/b] » ou « [b]Ce sont… qui[/b] ».
[cadre][b]Ce sont[/b] les fourmis [b]qui[/b] transportent une feuille. ✓
→ « Les fourmis » est le sujet.[/cadre]
[page]
[titre]Le sujet est un groupe[/titre]
Le sujet n'est souvent pas un seul mot : c'est un [b]groupe nominal[/b] (un petit mot + un nom).
[cadre][b]La sorcière[/b] prépare une potion. → la + sorcière
[b]Le coureur[/b] gagne la course. → le + coureur[/cadre]
[cadre=astuce]Je peux remplacer le sujet par [b]il, elle, ils[/b] ou [b]elles[/b] : Elle prépare une potion ✓[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Le sujet fait l'action du verbe.
• Question : « Qui est-ce qui + verbe ? ».
• Truc : « C'est… qui » / « Ce sont… qui ».
• Le sujet peut être remplacé par il, elle, ils, elles.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'fonctions'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Le participe passé avec être (CM1) - grammaire, notion 'participe_passe'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'grammaire', 'Le participe passé avec être', $fiche$
[titre]Le participe passé[/titre]
Au passé composé, le verbe a deux parties : l'[b]auxiliaire[/b] et le [b]participe passé[/b].
[cadre]Marie [b]est[/b] [b]arrivée[/b] en retard.
« est » = auxiliaire être · « arrivée » = participe passé[/cadre]
[page]
[titre]Les verbes avec être[/titre]
Certains verbes se conjuguent avec [b]être[/b] au passé composé :
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]aller[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]venir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]arriver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]partir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]entrer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]sortir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]monter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]descendre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]naître[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]mourir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]devenir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]revenir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]rester[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]tomber[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]passer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]retourner[/font_size][/center][/cell][/table]
[cadre=astuce]Ce sont surtout des verbes de [b]mouvement[/b] ou de [b]changement[/b].[/cadre]
[page]
[titre]Avec être, il s'accorde avec le sujet[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Tom est arrivé.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]masculin singulier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Marie est arrivé[b][color=#C62828]e[/color][/b].[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]féminin singulier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Les garçons sont arrivé[b][color=#C62828]s[/color][/b].[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]masculin pluriel[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]Jade et Naomi sont arrivé[b][color=#C62828]es[/color][/b].[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=20]féminin pluriel[/font_size][/center][/cell][/table]
[cadre]Comme un adjectif : [b]e[/b] au féminin, [b]s[/b] au pluriel.[/cadre]
[page]
[titre]Les terminaisons[/titre]
[table=5][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]masc. sing.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]fém. sing.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]masc. plur.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]fém. plur.[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]arriver[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]arrivé[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]arrivé[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]arrivé[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]arrivé[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sortir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sorti[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sorti[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sorti[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]sorti[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]devenir[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]devenu[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]devenu[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]devenu[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=17]devenu[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]naître[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]né[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]né[b][color=#C62828]e[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]né[b][color=#C62828]s[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=17]né[b][color=#C62828]es[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Ma méthode[/titre]
[cadre]1. Je vérifie que l'auxiliaire est [b]être[/b] (est, sont, suis…).
2. Je trouve le [b]sujet[/b] : qui est-ce qui est arrivé ?
3. Masculin ou féminin ? Singulier ou pluriel ?
4. J'ajoute [b]e[/b], [b]s[/b] ou [b]es[/b].[/cadre]
[cadre=astuce]Un groupe avec un garçon et une fille → masculin pluriel : Léo et Zoé sont parti[b]s[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Passé composé = auxiliaire + participe passé.
• Avec [b]être[/b], le participe passé s'accorde avec le [b]sujet[/b].
• Féminin → e · pluriel → s · féminin pluriel → es.
• Verbes avec être : aller, venir, arriver, partir, naître, devenir, sortir, monter…[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'participe_passe'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche COD, COI et attribut du sujet (CM1) - grammaire, notion 'fonctions'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'grammaire', 'COD, COI et attribut du sujet', $fiche$
[titre]Les compléments du verbe[/titre]
Après le verbe, on trouve souvent un groupe de mots qui le [b]complète[/b].
[cadre]Le pêcheur attrape [b]un poisson[/b]. → COD
Elle succède [b]à son père[/b]. → COI
Ce jeu semble [b]amusant[/b]. → attribut du sujet[/cadre]
[page]
[titre]Le COD[/titre]
Le [b]COD[/b] (complément d'objet direct) se trouve en posant la question [b]qui ?[/b] ou [b]quoi ?[/b] juste après le verbe.
[cadre]Le fermier cultive [b]son champ[/b]. → Il cultive quoi ? son champ
Nous préparons [b]le dîner[/b]. → Nous préparons quoi ? le dîner[/cadre]
[cadre=astuce]« Direct » : il n'y a [b]pas de petit mot[/b] (à, de) entre le verbe et le COD.[/cadre]
[page]
[titre]Le COI[/titre]
Le [b]COI[/b] (complément d'objet indirect) répond à [b]à qui ? à quoi ? de qui ? de quoi ?[/b]
[cadre]Le public sourit [b]aux artistes[/b]. → sourit à qui ? aux artistes
Elle parle [b]de son voyage[/b]. → parle de quoi ? de son voyage[/cadre]
[cadre=astuce]« Indirect » : il commence par [b]à, au, aux, de, du, des[/b].[/cadre]
[page]
[titre]L'attribut du sujet[/titre]
Après [b]être, sembler, paraître, devenir, rester, avoir l'air[/b], le mot qui suit dit [b]comment est le sujet[/b] : c'est l'[b]attribut du sujet[/b].
[cadre]La soupe [b]semble[/b] trop salée. → la soupe = trop salée
Mon père [b]est[/b] pompier. → mon père = pompier[/cadre]
[cadre=astuce]Test : je peux mettre « [b]=[/b] » entre le sujet et l'attribut. Il s'accorde avec le sujet : la météo semble incertain[b]e[/b].[/cadre]
[page]
[titre]Ma méthode[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je me demande[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Fonction[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]être, sembler, paraître… ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]oui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]attribut du sujet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]Verbe + qui ? quoi ?[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]sans à / de[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]COD[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Verbe + à qui ? de quoi ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]avec à / de[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]COI[/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]COD[/b] : verbe + qui ? / quoi ? sans préposition → il range [b]ses affaires[/b].
• [b]COI[/b] : verbe + à qui ? / de quoi ? avec à, de → il sourit [b]aux artistes[/b].
• [b]Attribut du sujet[/b] : après être, sembler, paraître… → ce jeu semble [b]amusant[/b].[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'fonctions'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les déterminants démonstratifs et possessifs (CM1) - grammaire, notion 'determinants'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'grammaire', 'Les déterminants démonstratifs et possessifs', $fiche$
[titre]Montrer : ce, cet, cette, ces[/titre]
Les déterminants [b]démonstratifs[/b] servent à montrer.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]ce[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]masculin, devant une consonne : ce chapeau[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]cet[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]masculin, devant une voyelle ou un h muet : cet arbre, cet hôtel[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]cette[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]féminin : cette classe[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]ces[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]pluriel : ces étoiles[/font_size][/center][/cell][/table]
[page]
[titre]ce ou cet ?[/titre]
[cadre]Les deux sont pour un nom [b]masculin singulier[/b].
• [b]ce[/b] devant une consonne : ce classeur, ce chapeau
• [b]cet[/b] devant une voyelle ou un h muet : cet oiseau, cet homme[/cadre]
[cadre=astuce]« cet » et « cette » se disent pareil. Je dis « un » ou « une » : [b]un[/b] arbre → cet arbre ; [b]une[/b] classe → cette classe.[/cadre]
[page]
[titre]Dire à qui c'est[/titre]
Les déterminants [b]possessifs[/b] disent à qui appartient la chose.
[table=4][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]masc. sing.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]fém. sing.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]pluriel[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]à moi[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]mon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]ma[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]mes[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]à toi[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ton[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ta[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]tes[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]à lui, à elle[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]son[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]sa[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]ses[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]à nous[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]notre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]notre[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]nos[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]à vous[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]votre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]votre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=18]vos[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]à eux, à elles[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]leur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]leur[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]leurs[/font_size][/center][/cell][/table]
[page]
[titre]Le piège : mon écharpe[/titre]
Devant un nom féminin qui commence par une [b]voyelle[/b], on dit [b]mon, ton, son[/b] pour que ce soit plus facile à prononcer.
[cadre]une écharpe → [b]mon[/b] écharpe (et pas « ma écharpe »)
une amie → [b]ton[/b] amie · une histoire → [b]son[/b] histoire[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. À qui est la chose ? (à moi, à toi, à nous, à eux…)
2. Le nom est-il masculin, féminin, singulier ou pluriel ?
3. Il commence par une voyelle ? Attention à cet / mon.[/cadre]
[cadre=astuce]C'est à eux : [b]leur[/b] gourde (une seule), [b]leurs[/b] affaires (plusieurs).[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Montrer : ce (masc.), cet (masc. + voyelle), cette (fém.), ces (plur.).
• À qui ? mon/ma/mes, ton/ta/tes, son/sa/ses, notre/nos, votre/vos, leur/leurs.
• Devant une voyelle : cet arbre, mon écharpe.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'determinants'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche L'accord du participe passé (CM2) - grammaire, notion 'participe_passe'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'grammaire', 'L''accord du participe passé', $fiche$
[titre]Rappel : avec être[/titre]
Avec l'auxiliaire [b]être[/b], le participe passé s'accorde avec le [b]sujet[/b].
[cadre]Elles sont parti[b]es[/b]. · Les garçons sont venu[b]s[/b].[/cadre]
[page]
[titre]Avec avoir : pas d'accord avec le sujet[/titre]
Avec l'auxiliaire [b]avoir[/b], le participe passé [b]ne s'accorde jamais avec le sujet[/b].
[cadre]La couturière a [b]préparé[/b] le colis.
Les musiciens ont [b]enregistré[/b] une mélodie.[/cadre]
[cadre=astuce]Même si le sujet est féminin ou pluriel : elles ont [b]mangé[/b].[/cadre]
[page]
[titre]Avec avoir : le COD placé avant[/titre]
Le participe passé avec avoir s'accorde avec le [b]COD[/b] seulement s'il est placé [b]avant[/b] le verbe.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]COD après : pas d'accord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Elle a acheté [b]la pomme[/b].[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]COD avant : accord[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]La pomme[/b] qu'elle a acheté[b][color=#C62828]e[/color][/b].[/font_size][/center][/cell][/table]
[page]
[titre]Où se cache le COD placé avant ?[/titre]
[cadre]• Après [b]que / qu'[/b] : les gâteaux [b]que[/b] tu as offert[b]s[/b].
• Dans un pronom [b]l', la, les[/b] : ces photos, je [b]les[/b] ai perdu[b]es[/b].[/cadre]
[cadre=astuce]« que » remplace le nom juste avant : les livres que nous avons fini[b]s[/b] → que = les livres (masc. plur.).[/cadre]
[page]
[titre]Ma méthode[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Auxiliaire être ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]accord avec le [b]sujet[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Auxiliaire avoir, COD après ou pas de COD ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]pas d'accord[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Auxiliaire avoir, COD avant (que, l', les) ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]accord avec le [b]COD[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Être → accord avec le sujet : elles sont venues.
• Avoir → pas d'accord avec le sujet : elles ont chanté.
• Avoir + COD avant → accord avec le COD : la photo que nous avons perdue.
• Le COD avant se cache dans que, l', la, les.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'participe_passe'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les pronoms relatifs (CM2) - grammaire, notion 'pronoms_relatifs'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'grammaire', 'Les pronoms relatifs', $fiche$
[titre]Relier deux phrases[/titre]
Le [b]pronom relatif[/b] relie deux phrases en évitant de répéter un nom.
[cadre]L'oiseau chante. L'oiseau est un rossignol.
→ L'oiseau [b]qui[/b] chante est un rossignol.[/cadre]
Les pronoms relatifs : [b]qui, que, dont, où[/b].
[page]
[titre]qui : le sujet[/titre]
[b]qui[/b] remplace le [b]sujet[/b] du verbe qui suit.
[cadre]L'oiseau [b]qui[/b] chante… → l'oiseau chante.[/cadre]
[cadre=astuce]Après « qui », il y a directement un [b]verbe[/b] : qui chante, qui dort.[/cadre]
[page]
[titre]que : le COD[/titre]
[b]que[/b] remplace le [b]COD[/b] du verbe qui suit.
[cadre]L'exercice [b]que[/b] nous avons fait… → nous avons fait l'exercice.
Le jouet [b]qu'[/b]il préfère… → il préfère le jouet.[/cadre]
[cadre=astuce]Après « que », il y a un [b]sujet[/b] puis le verbe : que nous avons fait.[/cadre]
[page]
[titre]dont : remplace « de… »[/titre]
[b]dont[/b] remplace un complément introduit par [b]de[/b].
[cadre]L'objet [b]dont[/b] tu as besoin… → tu as besoin [b]de[/b] l'objet.
L'histoire [b]dont[/b] elle se souvient… → elle se souvient [b]de[/b] l'histoire.[/cadre]
[cadre=astuce]Verbes avec « de » : avoir besoin de, se souvenir de, parler de, discuter de…[/cadre]
[page]
[titre]où : le lieu ou le temps[/titre]
[b]où[/b] remplace un [b]lieu[/b] ou un [b]moment[/b].
[cadre]Le quartier [b]où[/b] j'ai grandi… → j'ai grandi dans ce quartier.
Le jour [b]où[/b] elle est née… → elle est née ce jour-là.[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]Je refais la phrase avec le nom à la place du pronom :[/cadre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]le nom fait l'action[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]qui[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]le nom est le COD[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]que[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21]« de » + le nom[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=21][b][color=#C62828]dont[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21]un lieu ou un moment[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=21][b][color=#C62828]où[/color][/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]qui[/b] : sujet → l'oiseau qui chante.
• [b]que[/b] : COD → le dessin que tu as fait.
• [b]dont[/b] : remplace « de… » → l'objet dont tu as besoin.
• [b]où[/b] : lieu ou temps → la forêt où ils marchent.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'pronoms_relatifs'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

-- Fiche Les compléments circonstanciels (CM2) - grammaire, notion 'complements_circonstanciels'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'grammaire', 'Les compléments circonstanciels', $fiche$
[titre]Les circonstances de l'action[/titre]
Le [b]complément circonstanciel[/b] (CC) donne des précisions : [b]où[/b], [b]quand[/b], [b]comment[/b], [b]pourquoi[/b].
[cadre]Le train part [b]à huit heures[/b]. → quand ?
L'oiseau vole [b]au-dessus des toits[/b]. → où ?[/cadre]
[page]
[titre]Les types de CC[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]type[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]question[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]exemples[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]lieu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]où ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]dans l'armoire, au-dessus des toits[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]temps[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]quand ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]à neuf heures, dans une semaine, après le dîner[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]manière[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]comment ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]avec douceur, attentivement[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]cause[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]pourquoi ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]à cause de la pluie, de peur[/font_size][/center][/cell][/table]
[page]
[titre]On peut le déplacer ou le supprimer[/titre]
[cadre]Le magasin ouvre [b]à neuf heures[/b].
→ [b]À neuf heures[/b], le magasin ouvre. (déplacé ✓)
→ Le magasin ouvre. (supprimé ✓)[/cadre]
[cadre=astuce]C'est ce qui le distingue du COD : « Il range ses affaires » → « Il range » ne veut plus rien dire.[/cadre]
[page]
[titre]Les adverbes de manière[/titre]
Un [b]adverbe en -ment[/b] est souvent un CC de [b]manière[/b] : il répond à « comment ? ».
[cadre]Il conduit [b]dangereusement[/b]. → comment conduit-il ? dangereusement
Les élèves écoutent [b]attentivement[/b]. → comment ? attentivement[/cadre]
[page]
[titre]Attention aux pièges[/titre]
[cadre]« [b]dans[/b] » peut annoncer un lieu ou un temps :
dans l'armoire → [b]lieu[/b] · dans une semaine → [b]temps[/b][/cadre]
[cadre=astuce]Je ne me fie pas au premier mot : je pose la bonne question (où ? quand ?).[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Lieu → où ? · Temps → quand ? · Manière → comment ? · Cause → pourquoi ?
• Le CC peut être déplacé ou supprimé.
• Un adverbe en -ment est souvent un CC de manière.
• Je pose la question, sans me fier au premier mot.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'complements_circonstanciels'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;

commit;
select fn_publier();
