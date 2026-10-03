-- AUDITS_LOG #34 (2026-10-03) : "ce chaise-ci" -> "cette chaise-ci" (noms feminins), anglais CM1 demonstratifs.
begin;
update contenu_questions set
  enonce = regexp_replace(enonce, '\mce (chaise|table|porte|fenêtre)-', 'cette \1-', 'g'),
  bonne_reponse = regexp_replace(bonne_reponse, '\mce (chaise|table|porte|fenêtre)-', 'cette \1-', 'g'),
  mauvais_choix = (select array_agg(regexp_replace(x, '\mce (chaise|table|porte|fenêtre)-', 'cette \1-', 'g')) from unnest(mauvais_choix) x),
  modifie_le = now()
where matiere = 'english' and statut = 'publie'
  and (enonce || bonne_reponse || array_to_string(mauvais_choix, '|')) ~ '\mce (chaise|table|porte|fenêtre)-';
commit;
select fn_publier();
select enonce, bonne_reponse, mauvais_choix from contenu_questions where matiere='english' and (enonce||bonne_reponse||array_to_string(mauvais_choix,'|')) ~ 'cette (chaise|table|porte|fenêtre)-' limit 4;
