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
