-- Fiche Les analogies : la partie et le tout (CM1) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'logique', 'Les analogies : la partie et le tout', $fiche$
[titre]Lire une analogie[/titre]
[center][font_size=24][b]Le pétale est à la fleur ce que la feuille est… à l'arbre.[/b][/font_size][/center]
[cadre]Je trouve le lien entre les deux premiers mots : le pétale est [b]une partie[/b] de la fleur.
Je cherche de quoi la feuille est une partie : [b]de l'arbre[/b].[/cadre]
[page]
[titre]Des parties et leur tout[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]La partie[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le tout[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]La partie[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le tout[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la page[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le livre[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la touche[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le piano[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le wagon[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le train[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le maillon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la chaîne[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la perle[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le collier[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la note[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]la mélodie[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le pixel[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'écran[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la voile[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le bateau[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le rayon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la roue[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]l'orteil[/font_size][/center][/cell][cell bg=#FFD49A border=#F2A541 padding=10,4,10,4][center][font_size=19]le pied[/font_size][/center][/cell][/table]
[page]
[titre]Faire une phrase pour vérifier[/titre]
[cadre]« La touche est au piano ce que la voile est… »
Je dis : « La touche est [b]une partie du[/b] piano. La voile est [b]une partie du[/b]… [b]bateau[/b]. »
La phrase marche : la réponse est [b]au bateau[/b].[/cadre]
[cadre=astuce]Piège : une réponse peut reprendre un mot du début (« à la fleur »). Elle est fausse : il faut le tout du [b]troisième[/b] mot.[/cadre]
[page]
[titre]au, à la, à l'[/titre]
La réponse commence par [b]à[/b] + le nom :
[cadre]à + le bateau → [b]au[/b] bateau
à + la chaîne → [b]à la[/b] chaîne
à + l'écran → [b]à l'[/b]écran[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• « A est à B ce que C est à … » : je trouve le [b]lien entre A et B[/b], puis je l'applique à C.
• Ici, le lien est souvent : A est [b]une partie[/b] de B.
• Je vérifie avec une phrase : « La page est une partie du livre. »
• au = à + le.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
