-- Fiche Le futur simple (CE2) - conjugaison, notion 'futur'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'conjugaison', 'Le futur simple', $fiche$
[titre]À quoi sert le futur ?[/titre]
Le futur dit ce qui [b]va se passer[/b] plus tard.
[cadre]Demain, je [b]visiterai[/b] le musée. L'an prochain, nous [b]camperons[/b] à la mer.[/cadre]
[page]
[titre]Infinitif + terminaison[/titre]
Pour les verbes en -er, je garde [b]tout l'infinitif[/b] et j'ajoute la terminaison.
[table=2][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]donner[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]je[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]ai[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22][b]tu[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]as[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]il, elle[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]a[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22][b]nous[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]ons[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22][b]vous[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]ez[/color][/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22][b]ils, elles[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]donner[b][color=#C62828]ont[/color][/b][/font_size][/center][/cell][/table]
[cadre][b]ai, as, a, ons, ez, ont[/b] (comme le verbe avoir !)[/cadre]
[page]
[titre]Le e qu'on n'entend pas[/titre]
On ne l'entend presque pas, mais le [b]e[/b] de l'infinitif reste écrit.
[cadre]je compt[b]e[/b]rai · tu jou[b]e[/b]ras · nous colori[b]e[/b]rons · ils ski[b]e[/b]ront[/cadre]
[cadre=astuce]Je pense à l'infinitif entier : compter → compter + ai = je compterai.[/cadre]
[page]
[titre]Les verbes en -yer[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]nettoyer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]je netto[b][color=#C62828]i[/color][/b]erai, ils netto[b][color=#C62828]i[/color][/b]eront[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]essuyer[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]tu essu[b][color=#C62828]i[/color][/b]eras[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]balayer[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]il balayera ou il balaiera (les deux sont justes)[/font_size][/center][/cell][/table]
[page]
[titre]Futur ou conditionnel ?[/titre]
[cadre]Au futur, avec je : [b]-ai[/b] → je donnerai.
Avec un [b]s[/b] (je donnerais), ce n'est plus le futur : c'est le conditionnel.[/cadre]
[cadre=astuce]Je remplace par « nous » : nous donnerons (futur) ✓.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Futur des verbes en -er : infinitif + [b]ai, as, a, ons, ez, ont[/b].
• Le e de l'infinitif reste écrit : je jouerai, nous colorierons.
• -oyer / -uyer : i → je nettoierai, tu essuieras.
• Je : -ai (futur), pas -ais.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'futur'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
