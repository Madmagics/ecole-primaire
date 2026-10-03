-- Fiche L'accord du participe passé (CM2) - grammaire, notion 'participe_passe'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'grammaire', 'L''accord du participe passé', $fiche$
[titre]Rappel : avec être[/titre]
Avec l'auxiliaire [b]être[/b], le participe passé s'accorde avec le [b]sujet[/b].
[cadre]Elles sont parti[b]es[/b]. · Les garçons sont venu[b]s[/b].[/cadre]
[page]
[titre]Avec avoir : pas d'accord avec le sujet[/titre]
Avec l'auxiliaire [b]avoir[/b], le participe passé [b]ne s'accorde jamais avec le sujet[/b].
[cadre]La couturière a [b]préparé[/b] le colis.
Les musiciens ont [b]enregistré[/b] une mélodie.[/cadre]
[cadre=astuce]Même si le sujet est féminin ou pluriel : elles ont [b]mangé[/b].[/cadre]
[page]
[titre]Avec avoir : le COD placé avant[/titre]
Le participe passé avec avoir s'accorde avec le [b]COD[/b] seulement s'il est placé [b]avant[/b] le verbe.
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]COD après : pas d'accord[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=20]Elle a acheté [b]la pomme[/b].[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20]COD avant : accord[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=20][b]La pomme[/b] qu'elle a acheté[b][color=#C62828]e[/color][/b].[/font_size][/center][/cell][/table]
[page]
[titre]Où se cache le COD placé avant ?[/titre]
[cadre]• Après [b]que / qu'[/b] : les gâteaux [b]que[/b] tu as offert[b]s[/b].
• Dans un pronom [b]l', la, les[/b] : ces photos, je [b]les[/b] ai perdu[b]es[/b].[/cadre]
[cadre=astuce]« que » remplace le nom juste avant : les livres que nous avons fini[b]s[/b] → que = les livres (masc. plur.).[/cadre]
[page]
[titre]Ma méthode[/titre]
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Auxiliaire être ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]accord avec le [b]sujet[/b][/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]Auxiliaire avoir, COD après ou pas de COD ?[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19][b]pas d'accord[/b][/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]Auxiliaire avoir, COD avant (que, l', les) ?[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]accord avec le [b]COD[/b][/font_size][/center][/cell][/table]
[page]
[titre]Je retiens[/titre]
[cadre]• Être → accord avec le sujet : elles sont venues.
• Avoir → pas d'accord avec le sujet : elles ont chanté.
• Avoir + COD avant → accord avec le COD : la photo que nous avons perdue.
• Le COD avant se cache dans que, l', la, les.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'participe_passe'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
