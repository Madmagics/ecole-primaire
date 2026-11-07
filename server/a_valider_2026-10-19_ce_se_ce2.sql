-- A LANCER APRES VALIDATION DE STEVE : publie ce/se, c'est/s'est, fiche 90, et ajoute "Ca"/"ca" (sans cédille) dans les choix ça/sa.
begin;
update contenu_questions set statut='publie', modifie_le=now() where id between 122372 and 122398 and statut='brouillon';
update contenu_cours set contenu=(select contenu from contenu_cours where id=209), modifie_le=now() where id=90;
update contenu_cours set statut='archive' where id=209;
update contenu_questions set mauvais_choix=array_replace(mauvais_choix,'Cas','Ca'), modifie_le=now() where bonne_reponse='Ça' and 'Cas'=any(mauvais_choix) and statut='publie';
update contenu_questions set mauvais_choix=array_replace(mauvais_choix,'cas','ca'), modifie_le=now() where bonne_reponse='sa' and 'cas'=any(mauvais_choix) and statut='publie';
commit;
select fn_publier();
