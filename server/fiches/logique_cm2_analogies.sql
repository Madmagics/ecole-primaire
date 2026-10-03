-- Fiche Les analogies : à quoi ça sert ? (CM2) - logique, notion 'analogies'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'logique', 'Les analogies : à quoi ça sert ?', $fiche$
[titre]Le lien : ce qu'on en fait[/titre]
[center][font_size=24][b]Le stylo est à écrire ce que le livre est… à lire.[/b][/font_size][/center]
[cadre]Le lien entre « stylo » et « écrire » : le stylo [b]sert à[/b] écrire.
Je cherche à quoi sert le livre : [b]à lire[/b].[/cadre]
[page]
[titre]Des objets et leur action[/titre]
[table=4][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le nom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]L'action[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Le nom[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]L'action[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le vélo[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]pédaler[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la voiture[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]conduire[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la porte[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]ouvrir[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la valise[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]porter[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le feu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]éteindre[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]la graine[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]planter[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le puzzle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]assembler[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]le linge[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]laver[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]la musique[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=19]écouter[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]le film[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=19]regarder[/font_size][/center][/cell][/table]
[page]
[titre]Choisir la meilleure action[/titre]
Un objet peut servir à plusieurs choses. Je choisis l'action [b]la plus naturelle[/b], celle qu'on dit en premier.
[cadre]« La voiture est à conduire ce que le stylo est… »
à écrire ✓   à chanter ✗   à porter ✗   à prendre ✗[/cadre]
[cadre=astuce]Je fais une phrase : « On [b]conduit[/b] une voiture, on [b]écrit[/b] avec un stylo. »[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• Je trouve le [b]lien[/b] entre le 1er et le 2e mot : ici, ce à quoi sert l'objet.
• J'applique le même lien au 3e mot.
• Je choisis l'action la plus [b]naturelle[/b] et je vérifie avec une phrase.
• Au CM1, le lien était « une partie de » ; au CM2, c'est souvent « [b]sert à[/b] ».[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'analogies'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
