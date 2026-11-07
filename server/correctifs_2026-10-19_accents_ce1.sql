-- 2026-10-19 : notion "accents" (42) déplacée de CM2 vers CE1 (programme CP/CE1),
-- reformulation sans ambiguïté (signalement 39114 : "lumière" contient aussi un e sans accent),
-- vocabulaire trop difficile remplacé. Choix inchangés.
begin;

-- 1) Reformulation : sans article, le e visé remplacé par _
with w as (
 select id, bonne_reponse, regexp_replace(substring(enonce from 'dans "([^"]+)"'), '^(le |la |l'')', '') as mot
 from contenu_questions where enonce ~* '^Quel accent porte le "e" dans' and notion_id = 42)
update contenu_questions q set enonce = 'Quel accent porte le "e" manquant dans "' ||
  regexp_replace(w.mot, case w.bonne_reponse when 'accent grave' then 'è' when 'accent aigu' then 'é' when 'accent circonflexe' then 'ê' else 'e' end, '_') || '" ?'
from w where q.id = w.id;

-- 2) Mots trop difficiles pour le CE1
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "r_cré" ?'  where id = 39691; -- référé
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "f_e" ?'    where id = 39132; -- générique
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "fus_e" ?'  where id = 39686; -- générosité
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "_té" ?'    where id = 39695; -- sévérité
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "m_téo" ?'  where id = 39133; -- mérite
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "m_me" ?'   where id = 39110; -- ancêtre
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "_tre" ?'   where id = 39106; -- prêtre
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "r_gle" ?'  where id = 39118; -- sphère
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "l_vre" ?'  where id = 39117; -- repère
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "ch_vre" ?' where id = 39115; -- carrière
update contenu_questions set enonce = 'Quel accent porte le "e" manquant dans "fl_che" ?' where id = 39112; -- système

-- 3) Passage en CE1 (questions + fiche)
update contenu_questions set classe = 'ce1', modifie_le = now() where notion_id = 42 and statut = 'publie' and classe = 'cm2';
update contenu_cours set classe = 'ce1',
  contenu = replace(replace(contenu, 'sé-vé-ri-té', 'é-té'), 'procè[b]s[/b]', 'prè[b]s[/b]'),
  modifie_le = now() where id = 97;

commit;
