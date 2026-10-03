-- Fiche Raisonner et déduire (CM2) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Raisonner et déduire', $fiche$
[titre]Vérité ou mensonge ?[/titre]
Sur une île, [b]Léa dit toujours la vérité[/b] et [b]Kim ment toujours[/b].
[cadre]Quelqu'un dit : « La porte est ouverte. » Mais la porte est [b]fermée[/b].
La phrase est [b]fausse[/b] : seul un menteur peut la dire. C'est [b]Kim[/b].[/cadre]
[cadre=astuce]Phrase [b]vraie[/b] → celui qui dit la vérité. Phrase [b]fausse[/b] → le menteur.[/cadre]
[page]
[titre]Le tableau de déduction[/titre]
[center]Manon, Léo et Emma aiment chacun une couleur différente : bleu, rouge, vert.
Manon aime le bleu. Léo n'aime pas le vert.[/center]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]bleu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]rouge[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]vert[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Manon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Emma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]?[/font_size][/center][/cell][/table]
[page]
[titre]Je complète le tableau[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]bleu[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]rouge[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]vert[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Manon[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Léo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]Emma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✗[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]✓[/font_size][/center][/cell][/table]
[cadre]1. Manon a le bleu : personne d'autre ne l'a.
2. Léo n'a ni le bleu ni le vert : il a forcément [b]le rouge[/b].
3. Il ne reste que le vert : c'est [b]Emma[/b] qui aime le vert.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Vérité/mensonge : je regarde si la phrase est [b]vraie ou fausse[/b] dans la réalité.
• Pour répartir des choses, je fais un [b]tableau[/b] avec ✓ et ✗.
• Un ✓ dans une case → des ✗ dans le reste de sa ligne et de sa colonne.
• Quand il ne reste qu'une case possible, c'est la réponse.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
