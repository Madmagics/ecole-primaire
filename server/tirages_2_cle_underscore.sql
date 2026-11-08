-- ============================================================================
-- tirages_2_cle_underscore.sql (2026-11-08)
-- La cle d'historique de tirage "classe/matiere" refusait le caractere "_" : les cles
-- "cp/histoire_geo", "ce1/histoire_geo", "ce2/histoire_geo" etaient rejetees par fn_maj_tirage,
-- ce qui bloquait aussi l'envoi des autres cles du compte (dont cm1/histoire, cm2/geographie...).
-- Ne touche a aucune donnee joueur : seule la regle de verification de la colonne cle change.
-- A lancer avec le compte postgres.
-- ============================================================================
begin;
alter table tirages drop constraint if exists tirages_cle_check;
alter table tirages add constraint tirages_cle_check check (cle ~ '^[a-z0-9]+/[a-z_]+$');
commit;
