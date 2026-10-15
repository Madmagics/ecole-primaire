-- correctifs_2026-10-12_syllabes_ambigus.sql
-- Validé par Steve (2026-10-12) : mots à syllabation ambiguë (diérèse possible ou e muet final) remplacés par des mots sans ambiguïté.
begin;
update contenu_questions set enonce = 'Combien de syllabes y a-t-il dans le mot "pantalon" ?', bonne_reponse = '3', mauvais_choix = array['1','2','4'], modifie_le = now() where id = 30884 and classe = 'ce1' and enonce like '%"musicien"%';
update contenu_questions set enonce = 'Combien de syllabes y a-t-il dans le mot "robinet" ?', bonne_reponse = '3', mauvais_choix = array['1','2','4'], modifie_le = now() where id = 30950 and classe = 'ce1' and enonce like '%"parapluie"%';
update contenu_questions set enonce = 'Combien de syllabes y a-t-il dans le mot "tabouret" ?', bonne_reponse = '3', mauvais_choix = array['1','2','4'], modifie_le = now() where id = 100198 and classe = 'ce1' and enonce like '%"galaxie"%';
commit;
select fn_publier();
