-- correctifs_2026-10-12_signalement_30802.sql
-- Signalement joueur validé par Steve (2026-10-12) : "escalier" admet la diérèse es-ca-li-er (4) alors que 4 est un mauvais choix.
begin;
update contenu_questions set enonce = 'Combien de syllabes y a-t-il dans le mot "lavabo" ?', bonne_reponse = '3', mauvais_choix = array['1','2','4'], modifie_le = now() where id = 30802 and classe = 'ce1' and enonce like '%"escalier"%';
commit;
