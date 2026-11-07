-- 2026-10-19 : nouvelle série CM2 "accents" (notion 42), en BROUILLON, à valider par Steve.
-- Thèmes : accent qui change le sens, ê = ancien s, accent qui change dans la conjugaison/famille, mots difficiles.
begin;
insert into contenu_questions (id, classe, matiere, notion_id, enonce, bonne_reponse, mauvais_choix, statut) values
(122346,'cm2','orthographe',42,'Le fruit est ___ : on peut le manger.','mûr',array['mur','mûre','murs'],'brouillon'),
(122347,'cm2','orthographe',42,'Le ___ entoure tout le jardin.','mur',array['mûr','mûre','mure'],'brouillon'),
(122348,'cm2','orthographe',42,'Le chat dort ___ le canapé.','sur',array['sûr','sûre','surs'],'brouillon'),
(122349,'cm2','orthographe',42,'Paul est ___ de sa réponse.','sûr',array['sur','sûre','surs'],'brouillon'),
(122350,'cm2','orthographe',42,'Il a ___ partir plus tôt.','dû',array['du','due','dut'],'brouillon'),
(122351,'cm2','orthographe',42,'Je bois ___ lait chaud.','du',array['dû','due','dus'],'brouillon'),
(122352,'cm2','orthographe',42,'Il y a une ___ d''encre sur mon cahier.','tache',array['tâche','taches','tâches'],'brouillon'),
(122353,'cm2','orthographe',42,'Ranger sa chambre est une ___ difficile.','tâche',array['tache','tâches','taches'],'brouillon'),
(122354,'cm2','orthographe',42,'Ce garçon est encore très ___.','jeune',array['jeûne','jeunes','jeûnes'],'brouillon'),
(122355,'cm2','orthographe',42,'On a coupé le tronc du vieux ___.','chêne',array['chaîne','chène','chéne'],'brouillon'),
(122356,'cm2','orthographe',42,'Quelle lettre a disparu sous l''accent circonflexe de « forêt » ?','s',array['r','t','e'],'brouillon'),
(122357,'cm2','orthographe',42,'Quelle lettre a disparu sous l''accent circonflexe de « fête » ?','s',array['t','l','e'],'brouillon'),
(122358,'cm2','orthographe',42,'Quelle lettre a disparu sous l''accent circonflexe de « hôpital » ?','s',array['l','p','t'],'brouillon'),
(122359,'cm2','orthographe',42,'Quel mot de la famille de « forêt » garde le s ?','forestier',array['forain','forage','fortin'],'brouillon'),
(122360,'cm2','orthographe',42,'Quel mot de la famille de « hôpital » garde le s ?','hospitalier',array['hôtelier','hôpitaux','hôtel'],'brouillon'),
(122361,'cm2','orthographe',42,'Chaque matin, je me ___ tôt.','lève',array['léve','leve','lêve'],'brouillon'),
(122362,'cm2','orthographe',42,'Le maître ___ la consigne deux fois.','répète',array['répéte','repète','répête'],'brouillon'),
(122363,'cm2','orthographe',42,'Nous ___ la consigne ensemble.','répétons',array['répètons','repétons','répêtons'],'brouillon'),
(122364,'cm2','orthographe',42,'Maman ___ du pain à la boulangerie.','achète',array['achéte','achete','achête'],'brouillon'),
(122365,'cm2','orthographe',42,'Il ___ sa place à une dame âgée.','cède',array['céde','cede','cêde'],'brouillon'),
(122366,'cm2','orthographe',42,'Les ___ attendent le bus devant le collège.','collégiens',array['collègiens','collegiens','collêgiens'],'brouillon'),
(122367,'cm2','orthographe',42,'Quel mot est correctement écrit ?','élève',array['éléve','elève','êlève'],'brouillon'),
(122368,'cm2','orthographe',42,'Quel mot est correctement écrit ?','siècle',array['siécle','siêcle','siecle'],'brouillon'),
(122369,'cm2','orthographe',42,'Quel mot est correctement écrit ?','célèbre',array['cèlèbre','célébre','celèbre'],'brouillon'),
(122370,'cm2','orthographe',42,'Quel mot est correctement écrit ?','intérêt',array['intèrêt','intérét','interêt'],'brouillon'),
(122371,'cm2','orthographe',42,'Quel mot est correctement écrit ?','extrême',array['extréme','extrème','éxtrême'],'brouillon');
commit;
