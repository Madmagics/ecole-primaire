-- Fiche Moitié, tiers et quart (CE2) - notion 'doubles_moities'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', 'Moitié, tiers et quart', $fiche$
[titre]Rappel[/titre]
[tarte parts=2,3,4 colorees=1 noms=oui]
[cadre]• La [b]moitié[/b] : je partage en 2 parts égales.
• Le [b]tiers[/b] : je partage en 3 parts égales.
• Le [b]quart[/b] : je partage en 4 parts égales.[/cadre]
[page]
[titre]Avec la division[/titre]
Au CE2, je sais diviser : c'est le même partage !
[cadre]• La moitié de 18, c'est [b]18 : 2 = 9[/b].
• Le tiers de 27, c'est [b]27 : 3 = 9[/b], car 3 x 9 = 27.
• Le quart de 32, c'est [b]32 : 4 = 8[/b], car 4 x 8 = 32.[/cadre]
[page]
[titre]La moitié d'un grand nombre[/titre]
Pour la moitié de [b]316[/b], je découpe 316 en morceaux faciles : 300 et 16.
[cadre]Moitié de 300 = [b]150[/b]. Moitié de 16 = [b]8[/b]. Donc la moitié de 316, c'est [b]158[/b].[/cadre]
[cadre=astuce]Pour 184, je découpe en 180 et 4 : 90 + 2 = [b]92[/b].
Je vérifie avec le double : 92 + 92 = 184.[/cadre]
[page]
[titre]Le tiers d'un grand nombre[/titre]
Pour le tiers de [b]279[/b], je découpe en morceaux faciles à partager en 3 : 270 et 9.
[cadre]Tiers de 270 = [b]90[/b] (car 3 x 90 = 270). Tiers de 9 = [b]3[/b]. Donc le tiers de 279, c'est [b]93[/b].[/cadre]
[cadre=astuce]Pour 135 : 120 et 15. Tiers de 120 = 40, tiers de 15 = 5 → [b]45[/b].
Je vérifie : 45 + 45 + 45 = 135.[/cadre]
[page]
[titre]Le quart[/titre]
8 billes partagées en 4 parts égales : 2 billes par part. Le quart de 8, c'est [b]2[/b].
[billes groupes=2,2,2,2 couleurs=bleu,rouge,vert,orange signes=non]
Pour un grand nombre, le quart, c'est [b]la moitié de la moitié[/b].
[cadre]Quart de 300 : moitié de 300 = 150, puis moitié de 150 = [b]75[/b].
Je vérifie : 75 + 75 + 75 + 75 = 300.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Moitié = partager en 2 = diviser par 2.
• Tiers = partager en 3 = diviser par 3.
• Quart = partager en 4 = la moitié de la moitié.
• Pour un grand nombre, je le découpe en morceaux faciles : 316 = 300 + 16.
• Je vérifie en rassemblant les parts.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'doubles_moities'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
select fn_publier();
