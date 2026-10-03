-- Fiche La division (CM1) - notion 'division'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm1', 'math', 'La division', $fiche$
[titre]Quand le partage ne tombe pas juste[/titre]
Je partage [b]14 billes[/b] entre [b]3 enfants[/b] : chacun en a 4, et il en reste 2.
[billes groupes=4,4,4,2 couleurs=bleu,rouge,vert,jaune signes=non]
[cadre]14 divisé par 3 : le [b]quotient[/b] est 4 (la part de chacun), le [b]reste[/b] est 2.[/cadre]
[page]
[titre]Les mots de la division[/titre]
[table=4][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]dividende[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]diviseur[/b][/center][/cell][cell bg=#classe_clair border=#classe padding=14,6,14,6][center][b]quotient[/b][/center][/cell][cell bg=#unites_clair border=#unites padding=14,6,14,6][center][b]reste[/b][/center][/cell][cell border=#classe padding=14,6,14,6][center]14[/center][/cell][cell border=#classe padding=14,6,14,6][center]3[/center][/cell][cell border=#classe padding=14,6,14,6][center]4[/center][/cell][cell border=#classe padding=14,6,14,6][center]2[/center][/cell][/table]
[center][font_size=28][b]14 = (3 x 4) + 2[/b][/font_size][/center]
[cadre]Le reste est toujours [b]plus petit que le diviseur[/b] : 2 < 3.
Sinon, je pourrais encore donner une bille à chacun ![/cadre]
[page]
[titre]Diviser avec les tables[/titre]
Pour [b]80 : 9[/b], je cherche dans la table de 9 le résultat le plus proche, [b]sans dépasser 80[/b].
[cadre]9 x 8 = 72 et 9 x 9 = 81 : 81 dépasse 80, je prends [b]9 x 8 = 72[/b].
Quotient : [b]8[/b]. Reste : 80 - 72 = [b]8[/b]. Et 8 < 9 : c'est bon ![/cadre]
[page]
[titre]Poser une division[/titre]
[potence dividende=293 diviseur=6]
[cadre]• Dans [b]2[/b], pas de 6. Je prends [b]29[/b] : 6 x 4 = 24, j'écris 4. 29 - 24 = 5.
• J'abaisse le 3 : [b]53[/b]. 6 x 8 = 48, j'écris 8. 53 - 48 = 5.
293 : 6 → quotient [b]48[/b], reste [b]5[/b].[/cadre]
[page]
[titre]Combien de chiffres au quotient ?[/titre]
Avant de poser [b]293 : 6[/b], j'encadre le quotient avec 10 et 100 :
[cadre]6 x 10 = 60 et 6 x 100 = 600. 293 est entre 60 et 600.
Le quotient est donc entre 10 et 100 : il a [b]2 chiffres[/b].[/cadre]
[cadre=astuce]Si je trouve un quotient à 1 ou 3 chiffres, je me suis trompé quelque part.[/cadre]
[page]
[titre]Un quotient à 3 chiffres[/titre]
[potence dividende=416 diviseur=3]
[cadre]Dans 4 : 1 fois 3, reste 1. J'abaisse le 1 → 11 : 3 x 3 = 9, reste 2. J'abaisse le 6 → 26 : 3 x 8 = 24, reste 2.
416 : 3 → quotient [b]138[/b], reste [b]2[/b].[/cadre]
[page]
[titre]Vérifier[/titre]
Je multiplie le quotient par le diviseur, puis j'ajoute le reste : je dois retrouver le dividende.
[center][font_size=26][b](3 x 138) + 2 = 414 + 2 = 416[/b][/font_size][/center]
[cadre]C'est bien 416 : ma division est juste. Et le reste 2 est plus petit que 3.[/cadre]
[page]
[titre]Que faire du reste ?[/titre]
On range [b]125 œufs[/b] dans des boîtes de [b]6[/b]. 125 : 6 → quotient 20, reste 5.
[cadre]• Combien de boîtes [b]pleines[/b] ? [b]20[/b] boîtes.
• Combien d'œufs restent hors des boîtes pleines ? [b]5[/b] œufs.
• Combien de boîtes pour [b]tout[/b] ranger ? 20 + 1 = [b]21[/b] boîtes.[/cadre]
[cadre=astuce]Je relis la question pour savoir si je garde le quotient, le reste… ou le quotient + 1.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Dividende = (diviseur x quotient) + reste. 14 = (3 x 4) + 2.
• Le reste est toujours [b]plus petit que le diviseur[/b].
• J'utilise les tables : le plus grand résultat [b]sans dépasser[/b].
• Pour poser : je prends assez de chiffres, je soustrais, j'abaisse le chiffre suivant.
• J'encadre le quotient (x 10, x 100) pour savoir combien il a de chiffres.
• Je vérifie : (diviseur x quotient) + reste = dividende.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'division'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
