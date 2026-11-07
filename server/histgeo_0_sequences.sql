-- 2026-11-07 : remet les compteurs d'identifiants des tables de contenu au niveau des lignes existantes.
-- Des lignes ont été insérées par le passé avec un id choisi à la main : le compteur automatique de
-- contenu_cours était resté en arrière (nouvelle fiche refusée : "duplicate key ... contenu_cours_pkey").
-- Ne modifie AUCUNE ligne : seulement la valeur du prochain identifiant. Tables joueurs non concernées.
--   sudo docker exec -i supabase-db psql -U postgres -d postgres -v ON_ERROR_STOP=1 < ~/histgeo_0_sequences.sql
select setval(pg_get_serial_sequence('contenu_cours', 'id'), (select max(id) from contenu_cours)) as cours;
select setval(pg_get_serial_sequence('contenu_notions', 'id'), (select max(id) from contenu_notions)) as notions;
select setval(pg_get_serial_sequence('contenu_questions', 'id'), (select max(id) from contenu_questions)) as questions;
