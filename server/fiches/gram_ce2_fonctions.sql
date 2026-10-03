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
