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
