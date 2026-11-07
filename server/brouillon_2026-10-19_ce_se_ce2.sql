-- 2026-10-19 : ce/se et c'est/s'est (CE2, notion 40) en BROUILLON + fiche 90 enrichie en brouillon (id 209).
begin;
insert into contenu_questions (id, classe, matiere, notion_id, enonce, bonne_reponse, mauvais_choix, statut) values
(122372,'ce2','orthographe',40,'Il ___ lave les mains avant de manger.','se',array['ce','ses','ces'],'brouillon'),
(122373,'ce2','orthographe',40,'Le chat ___ cache sous le lit.','se',array['ce','ces','ses'],'brouillon'),
(122374,'ce2','orthographe',40,'Elle ___ brosse les dents.','se',array['ce','ses','ces'],'brouillon'),
(122375,'ce2','orthographe',40,'Les enfants ___ dépêchent pour aller à l''école.','se',array['ce','ces','ses'],'brouillon'),
(122376,'ce2','orthographe',40,'Mon frère ___ réveille tôt.','se',array['ce','ses','ces'],'brouillon'),
(122377,'ce2','orthographe',40,'Le soleil ___ lève à l''est.','se',array['ce','ces','ses'],'brouillon'),
(122378,'ce2','orthographe',40,'Les oiseaux ___ posent sur la branche.','se',array['ce','ses','ces'],'brouillon'),
(122379,'ce2','orthographe',40,'Il ___ promène dans le parc.','se',array['ce','ces','ses'],'brouillon'),
(122380,'ce2','orthographe',40,'___ chien aboie très fort.','Ce',array['Se','Ces','Ses'],'brouillon'),
(122381,'ce2','orthographe',40,'Regarde ___ beau château !','ce',array['se','ces','ses'],'brouillon'),
(122382,'ce2','orthographe',40,'Je voudrais ___ livre, s''il te plaît.','ce',array['se','ses','ces'],'brouillon'),
(122383,'ce2','orthographe',40,'___ matin, il fait très froid.','Ce',array['Se','Ses','Ces'],'brouillon'),
(122384,'ce2','orthographe',40,'Tu entends ___ bruit bizarre ?','ce',array['se','ces','ses'],'brouillon'),
(122385,'ce2','orthographe',40,'Prends ___ crayon rouge.','ce',array['se','ses','ces'],'brouillon'),
(122386,'ce2','orthographe',40,'J''aime beaucoup ___ dessin animé.','ce',array['se','ces','ses'],'brouillon'),
(122387,'ce2','orthographe',40,'___ mon meilleur ami.','C''est',array['S''est','Ses','Ces'],'brouillon'),
(122388,'ce2','orthographe',40,'Il ___ coupé le doigt.','s''est',array['c''est','ses','ces'],'brouillon'),
(122389,'ce2','orthographe',40,'___ l''heure de manger.','C''est',array['S''est','Ces','Ses'],'brouillon'),
(122390,'ce2','orthographe',40,'Elle ___ trompée de route.','s''est',array['c''est','ces','ses'],'brouillon'),
(122391,'ce2','orthographe',40,'Le chat ___ caché sous le lit.','s''est',array['c''est','ses','ces'],'brouillon'),
(122392,'ce2','orthographe',40,'Regarde, ___ un arc-en-ciel !','c''est',array['s''est','ces','ses'],'brouillon'),
(122393,'ce2','orthographe',40,'Ma sœur ___ endormie très vite.','s''est',array['c''est','ces','ses'],'brouillon'),
(122394,'ce2','orthographe',40,'___ trop difficile pour moi.','C''est',array['S''est','Ses','Ces'],'brouillon'),
(122395,'ce2','orthographe',40,'Le vase ___ cassé en tombant.','s''est',array['c''est','ses','ces'],'brouillon'),
(122396,'ce2','orthographe',40,'Je crois que ___ ton tour.','c''est',array['s''est','ces','ses'],'brouillon'),
(122397,'ce2','orthographe',40,'Paul ___ levé tôt ce matin.','s''est',array['c''est','ces','ses'],'brouillon'),
(122398,'ce2','orthographe',40,'___ un très beau dessin.','C''est',array['S''est','Ces','Ses'],'brouillon');
insert into contenu_cours (id, classe, matiere, titre, contenu, statut, notion_id) select 209, classe, matiere, titre, 'Output format is unaligned.
Tuples only is on.

[titre]« on » ou « ont » ?[/titre]
[cadre][b]ont[/b] = le verbe [b]avoir[/b] (ils ont). Je peux dire « [b]avaient[/b] ».
Les enfants [b]ont[/b] mangé leur soupe. → avaient mangé ✓[/cadre]
[cadre][b]on[/b] = quelqu''un. Je peux dire « [b]il[/b] ».
[b]On[/b] joue dans la cour. → il joue ✓[/cadre]
[page]
[titre]« ces » ou « ses » ?[/titre]
[cadre][b]ces[/b] sert à [b]montrer[/b] : ces livres-là. Au singulier : « [b]ce[/b] livre ».
Regarde [b]ces[/b] vestes-là. → cette veste-là ✓[/cadre]
[cadre][b]ses[/b] veut dire [b]à lui / à elle[/b]. Au singulier : « [b]son[/b], [b]sa[/b] ».
Il range [b]ses[/b] sacs. → son sac ✓[/cadre]
[cadre=astuce]Attention : [b]c''est[/b] (cela est) et [b]sait[/b] (verbe savoir) se disent pareil aussi ![/cadre]
[page]
[titre]« sa » ou « ça » ?[/titre]
[cadre][b]sa[/b] veut dire [b]à lui / à elle[/b], devant un nom féminin. Je peux dire « [b]ma[/b] ».
Il a perdu [b]sa[/b] clé. → ma clé ✓[/cadre]
[cadre][b]ça[/b] veut dire [b]cela[/b].
[b]Ça[/b] me plaît beaucoup. → cela me plaît ✓[/cadre]
[page]
[titre]« ce » ou « se » ?[/titre]
[cadre][b]se[/b] est toujours [b]devant un verbe[/b]. Je peux dire « [b]me[/b] » ou « [b]te[/b] ».
Il [b]se[/b] lave les mains. → je [b]me[/b] lave ✓[/cadre]
[cadre][b]ce[/b] sert à [b]montrer[/b], devant un nom. Au pluriel : « [b]ces[/b] ».
[b]Ce[/b] chien aboie fort. → ces chiens ✓[/cadre]
[page]
[titre]« c''est » ou « s''est » ?[/titre]
[cadre][b]c''est[/b] veut dire [b]cela est[/b]. Je peux dire « [b]c''était[/b] ».
[b]C''est[/b] mon ami. → c''était mon ami ✓[/cadre]
[cadre][b]s''est[/b] est toujours suivi d''un [b]verbe au passé[/b]. Je peux dire « [b]je me suis[/b] ».
Il [b]s''est[/b] perdu. → je me suis perdu ✓[/cadre]
[page]
[titre]« leur » ou « leurs » ?[/titre]
[cadre]Devant un [b]verbe[/b], [b]leur[/b] veut dire « à eux » : il ne prend [b]jamais de s[/b].
Je [b]leur[/b] donne un dessin.[/cadre]
[cadre]Devant un [b]nom[/b], il s''accorde :
[b]leur[/b] vélo (un seul) · [b]leurs[/b] vélos (plusieurs).[/cadre]
[cadre=astuce]Devant un verbe, je peux dire « [b]lui[/b] » : je lui donne ✓ → leur, sans s.[/cadre]
[page]
[titre]quel, quelle ou qu''elle ?[/titre]
[cadre][b]quel[/b] / [b]quelle[/b] : devant un nom, pour poser une question.
[b]Quel[/b] gâteau ? (masculin) · [b]Quelle[/b] robe ? (féminin)[/cadre]
[cadre][b]qu''elle[/b] = que + elle. Je peux dire « [b]qu''il[/b] ».
J''aimerais [b]qu''elle[/b] chante avec moi. → qu''il chante ✓[/cadre]
[page]
[titre]Je retiens[/titre]
[table=3][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Mot[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Je remplace par[/b][/color][/center][/cell][cell bg=#classe border=#classe padding=10,4,10,4][center][color=white][b]Exemple[/b][/color][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ont[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]avaient[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]Ils ont faim.[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]on[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]il[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]On part.[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ces[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ce / cette[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ces livres-là[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ses[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]son / sa[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ses sacs[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]sa[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]ma[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]sa clé[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ça[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]cela[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]ça va[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]leur (+ verbe)[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]lui[/font_size][/center][/cell][cell bg=#classe_clair border=#classe padding=10,4,10,4][center][font_size=18]je leur dis[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu''elle[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu''il[/font_size][/center][/cell][cell bg=#C6E2F8 border=#42A5F5 padding=10,4,10,4][center][font_size=18]qu''elle vienne[/font_size][/center][/cell][/table]', 'brouillon', null from contenu_cours where id=90;
commit;
