-- Fiche Les grilles à compléter (CM2) - logique, notion 'grilles'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les grilles à compléter', $fiche$
[titre]Regarder les lignes[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]3[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]11[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]4[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]12[/b][/font_size][/center][/cell][/table]
[cadre]1re ligne : 2, 6, 10 → [b]+4[/b] à chaque case. 3e ligne : 4, 8, 12 → [b]+4[/b] aussi.
La 2e ligne suit la même règle : 3 + 4 = [b]7[/b], et 7 + 4 = 11 ✓.[/cadre]
[page]
[titre]Vérifier avec les colonnes[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]3[/b][/font_size][/center][/cell][cell bg=#unites border=#unites padding=16,8,16,8][center][font_size=30][b][color=white]7[/color][/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]11[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]4[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]12[/b][/font_size][/center][/cell][/table]
[cadre]Colonne du milieu : 6, [b]7[/b], 8 → +1 à chaque case. ✓
Les lignes et les colonnes sont d'accord : la réponse est [b]7[/b].[/cadre]
[page]
[titre]Un autre exemple[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]2[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]5[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]8[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]6[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]9[/b][/font_size][/center][/cell][cell bg=#unites_clair border=#unites padding=16,8,16,8][center][font_size=30][b]?[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]10[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]13[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=16,8,16,8][center][font_size=30][b]16[/b][/font_size][/center][/cell][/table]
[cadre]Lignes : [b]+3[/b] (2, 5, 8). Colonnes : [b]+4[/b] (2, 6, 10).
Ligne : 9 + 3 = 12. Colonne : 8 + 4 = 12. La réponse est [b]12[/b].[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je cherche la règle d'une [b]ligne complète[/b] (+3, +4…).
• Je l'applique à la ligne de la case vide.
• Je vérifie avec la [b]colonne[/b] : les deux calculs doivent donner le même nombre.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'grilles'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
