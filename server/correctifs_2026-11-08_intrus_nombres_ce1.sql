begin;
update contenu_questions set enonce = regexp_replace(enonce, '^Quel nombre n''est pas un multiple de (5|10) \? ', 'En comptant de \1 en \1 à partir de 0, quel nombre ne dit-on pas ? '), modifie_le=now()
 where classe='ce1' and matiere='logique' and statut='publie' and enonce ~ '^Quel nombre n''est pas un multiple de (5|10) \? ';
update contenu_questions set enonce = replace(enonce, 'Quel nombre n''est pas un nombre impair ?', 'Quel nombre est pair ?'), modifie_le=now()
 where classe='ce1' and matiere='logique' and statut='publie' and enonce like 'Quel nombre n''est pas un nombre impair ?%';
update contenu_questions set enonce = replace(enonce, 'Quel nombre n''est pas un nombre pair ?', 'Quel nombre est impair ?'), modifie_le=now()
 where classe='ce1' and matiere='logique' and statut='publie' and enonce like 'Quel nombre n''est pas un nombre pair ?%';
commit;
