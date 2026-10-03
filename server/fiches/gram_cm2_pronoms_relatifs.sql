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
