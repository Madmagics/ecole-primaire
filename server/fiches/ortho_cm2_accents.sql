-- Fiche Les accents sur le e (CM2) - orthographe, notion 'accents'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cm2', 'orthographe', 'Les accents sur le e', $fiche$
[titre]Trois accents sur le e[/titre]
[table=3][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]é[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]accent aigu[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]bébé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]è[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]accent grave[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=24]père[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]ê[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]accent circonflexe[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=24]fête[/font_size][/center][/cell][/table]
[cadre]é se prononce le son [b]« é »[/b]. è et ê se prononcent le son [b]« è »[/b].[/cadre]
[page]
[titre]L'accent aigu é[/titre]
Le [b]é[/b] se trouve souvent à la [b]fin d'une syllabe[/b] ou au [b]début du mot[/b].
[cadre]bé-bé · ré-ponse · thé-âtre · sé-vé-ri-té · é-quipe[/cadre]
[cadre=astuce]Je découpe le mot en syllabes : si la syllabe finit par le son « é », c'est souvent [b]é[/b].[/cadre]
[page]
[titre]L'accent grave è[/titre]
Le [b]è[/b] se trouve souvent devant une syllabe qui finit par un [b]e muet[/b], ou devant un [b]s final[/b].
[cadre]pè-re · zè-bre · cuil-lè-re · siè-cle[/cadre]
[cadre]accè[b]s[/b] · aprè[b]s[/b] · trè[b]s[/b] · procè[b]s[/b][/cadre]
[page]
[titre]L'accent circonflexe ê[/titre]
Le [b]ê[/b] remplace souvent un [b]s[/b] qui a disparu. On le retrouve dans les mots de la même famille !
[table=2][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la f[b][color=#C62828]ê[/color][/b]te[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]un fe[b][color=#C62828]s[/color][/b]tival[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]la for[b][color=#C62828]ê[/color][/b]t[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=22]un fore[b][color=#C62828]s[/color][/b]tier[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]la b[b][color=#C62828]ê[/color][/b]te[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=22]une be[b][color=#C62828]s[/color][/b]tiole[/font_size][/center][/cell][/table]
[page]
[titre]Pas d'accent[/titre]
Le e n'a [b]pas d'accent[/b] quand il est suivi :
[cadre]• de [b]deux consonnes[/b] : pi[b]e[/b]rre, b[b]e[/b]lle, t[b]e[/b]rre
• d'un [b]x[/b] : [b]e[/b]xercice, [b]e[/b]xplorer
• d'une [b]consonne finale[/b] : m[b]e[/b]r, n[b]e[/b]z, ch[b]e[/b]f[/cadre]
[cadre=astuce]Un e muet en fin de mot n'a jamais d'accent : tabl[b]e[/b], pomm[b]e[/b].[/cadre]
[page]
[titre]Ma méthode[/titre]
[cadre]1. J'[b]écoute[/b] le son : « é » ou « è » ?
2. Je [b]découpe[/b] le mot en syllabes.
3. Je regarde ce qui [b]suit[/b] le e : deux consonnes ou un x → pas d'accent.
4. Pour ê, je cherche un mot de la [b]même famille[/b] avec un s.[/cadre]
[page]
[titre]Je retiens[/titre]
[cadre]• [b]é[/b] (aigu) : son fermé, souvent en fin de syllabe (bébé).
• [b]è[/b] (grave) : devant une syllabe avec e muet ou devant s final (père, très).
• [b]ê[/b] (circonflexe) : souvent un ancien s (fête → festival).
• [b]Pas d'accent[/b] devant deux consonnes, un x ou une consonne finale.[/cadre]
$fiche$, 'publie', n.id from contenu_notions n where n.code = 'accents'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
