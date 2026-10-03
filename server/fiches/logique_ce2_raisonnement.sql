-- Fiche Raisonner et déduire (CE2) - logique, notion 'raisonnement'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'logique', 'Raisonner et déduire', $fiche$
[titre]Si… alors…[/titre]
[cadre][b]Si[/b] le feu est vert, Nina avance.
Le feu [b]est[/b] vert.
[b]Donc[/b] Nina… [b]avance ![/b][/cadre]
La 1re phrase donne une [b]règle[/b]. La 2e dit que la condition est vraie.
Alors je peux en être sûr : la règle s'applique.
[page]
[titre]Recopier la règle[/titre]
[cadre]« S'il fait froid, Alice [b]met un manteau[/b]. Il fait froid. Donc Alice… »
La réponse est déjà écrite dans la règle : Alice [b]met un manteau[/b].[/cadre]
[cadre=astuce]Les autres réponses (« boit de l'eau fraîche », « ne fait rien ») sont peut-être possibles dans la vie, mais [b]la règle[/b] dit ce qui se passe.[/cadre]
[page]
[titre]Tous les… sont des…[/titre]
[cadre]« [b]Tous[/b] les chats sont des animaux. Félix est un chat. Donc Félix est… [b]un animal[/b]. »[/cadre]
[table=1][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]les animaux[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]🐱 les chats : Félix[/font_size][/center][/cell][/table]
[center]La famille des chats est [b]rangée dans[/b] la famille des animaux.[/center]
[page]
[titre]Je retiens[/titre]
[cadre]• « [b]Si[/b] … alors … » : quand la condition est vraie, la suite arrive toujours.
• La réponse se trouve [b]dans la règle[/b] : je la recopie.
• « [b]Tous[/b] les X sont des Y » : un X est forcément un Y.
• Je réponds avec ce que dit le texte, pas avec ce que j'imagine.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'raisonnement'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
