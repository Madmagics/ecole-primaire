begin;
update contenu_questions set enonce=$e$Comment dit-on "jus" en anglais ?$e$, modifie_le=now() where id=18112;
update contenu_questions set enonce=$e$Quel nombre n'est pas un résultat de la table de 5 ? 45, 37, 35, 50$e$, bonne_reponse='37', mauvais_choix=array['45','35','50'], modifie_le=now() where id=41490;
update contenu_questions set enonce=$e$Quel nombre est pair ? 65, 92, 41, 23$e$, modifie_le=now() where id=41494;
update contenu_questions set enonce=$e$Laquelle de ces utilisations de l'eau est industrielle ?$e$, bonne_reponse=$e$laver et refroidir les pièces dans une usine$e$, mauvais_choix=array[$e$arroser un champ de maïs$e$,$e$remplir une piscine municipale$e$,$e$préparer le repas à la maison$e$], modifie_le=now() where id=123405;
update signalements set statut='corrige', traite_le=now(), note=note || $n$ — APPLIQUÉ 2026-11-08 (validé par Steve).$n$ where question_id in (18112,41490,41494) and statut='analyse';
update signalements set statut='corrige', traite_le=now(), note=note || $n$ — APPLIQUÉ 2026-11-08 autrement, à la demande de Steve (loisirs jugé inutile) : « Laquelle de ces utilisations de l'eau est industrielle ? » → laver et refroidir les pièces dans une usine / arroser un champ de maïs / remplir une piscine municipale / préparer le repas à la maison.$n$ where question_id=123405 and statut='analyse';
commit;
select fn_publier();
