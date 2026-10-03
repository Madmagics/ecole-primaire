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
