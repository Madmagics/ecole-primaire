## Dialogues des enfants de la cour de recre (2026-11-25). Les deux enfants d'une meme classe
## discutent entre eux : de tout et de rien, et de leurs jeux (pour donner envie d'y jouer).
##
## Format : classe -> liste de conversations ; une conversation = liste de repliques
## [qui parle, texte], ou 1 = enfant n°1 de la classe (fille) et 2 = enfant n°2 (garcon).
## Prenoms actuels (voir playground.tscn, champ first_name) :
##   CP : Vanessa (Pluie de biscuits) / Will (Tap taupe)
##   CE1 : Julie / Jean - CE2 : Clementine / Carlos - CM1 : Valerie / John - CM2 : Sophie / Edouard
## Si un prenom ou un jeu change, penser a mettre a jour les repliques qui le citent.
## Ajouter une conversation = ajouter un bloc [ ... ] dans la liste de la classe, rien d'autre.
class_name PlaygroundDialogues
extends RefCounted

const CONVERSATIONS := {
	GradeLevel.Grade.CP: [
		[
			[1, "Salut Will ! Tu veux jouer à Pluie de biscuits ?"],
			[2, "C'est quoi, comme jeu ?"],
			[1, "Des biscuits tombent du ciel et ton animal doit les attraper !"],
			[2, "Miam ! Et s'il tombe autre chose ?"],
			[1, "Des cailloux ! Il faut les éviter, sinon tu perds une vie."],
		],
		[
			[2, "Vanessa, tu connais Tap taupe ?"],
			[1, "Non, ça se joue comment ?"],
			[2, "Des taupes sortent des trous et il faut taper dessus très vite !"],
			[1, "Et si on en rate une ?"],
			[2, "Tu perds une vie. Et surtout, ne touche jamais les serpents !"],
		],
		[
			[1, "Dans mon jeu, les étoiles valent trois points !"],
			[2, "Dans le mien, ce sont les taupes en or qui valent trois points."],
			[1, "On fait un concours ?"],
			[2, "D'accord, le meilleur score a gagné !"],
		],
		[
			[2, "Il fait beau aujourd'hui, c'est parfait pour la récré."],
			[1, "Oui ! Après, on a maths avec la maîtresse."],
			[2, "J'adore compter jusqu'à cent."],
			[1, "Moi, je préfère compter les biscuits !"],
		],
		[
			[1, "Quel est ton animal préféré dans ta collection ?"],
			[2, "Le dragon, il est trop fort ! Et toi ?"],
			[1, "La licorne, elle est tellement jolie."],
			[2, "J'ai mis du temps à avoir toutes les cartes du CP."],
		],
		[
			[2, "Regarde le classement, je suis dans le top !"],
			[1, "Je vais battre ton record, tu vas voir."],
			[2, "Pour Tap taupe, il faut être très rapide."],
			[1, "Et pour Pluie de biscuits, il faut bien regarder le ciel !"],
		],
		[
			[2, "Tu as déjà attrapé une étoile ?"],
			[1, "Oui ! Elle tombe moins souvent que les biscuits."],
			[2, "Il faut bien la guetter, alors !"],
		],
		[
			[1, "Will, comment tu fais pour taper aussi vite ?"],
			[2, "Je garde le doigt juste au-dessus des trous."],
			[1, "Bonne idée, je vais essayer !"],
		],
		[
			[2, "Tu as mangé à la cantine aujourd'hui ?"],
			[1, "Oui, il y avait des frites !"],
			[2, "Alors c'est une très bonne journée."],
		],
		[
			[1, "Au début, mon animal allait trop lentement."],
			[2, "Et maintenant ?"],
			[1, "Je bouge la souris doucement et j'attrape presque tout."],
			[2, "Sur la tablette, il suffit de glisser le doigt !"],
		],
		[
			[2, "Les serpents de Tap taupe me font un peu peur."],
			[1, "Ils ne mordent pas pour de vrai, tu sais."],
			[2, "Je sais, mais ils me font perdre la partie !"],
		],
		[
			[1, "J'ai gagné des pièces en lisant une histoire."],
			[2, "Moi, j'en ai gagné en faisant des additions."],
			[1, "Comme ça, on peut rejouer à nos jeux !"],
		],
		[
			[2, "Tu sais écrire ton prénom en attaché ?"],
			[1, "Oui, la maîtresse m'a montré."],
			[2, "Moi, je m'entraîne tous les soirs."],
		],
		[
			[1, "Regarde, il y a un oiseau sur la barrière !"],
			[2, "C'est un moineau, je crois."],
			[1, "Il cherche peut-être des miettes de biscuit !"],
		],
	],
	GradeLevel.Grade.CE1: [
		[
			[1, "Jean, tu as fini tes devoirs ?"],
			[2, "Presque, il me reste la conjugaison."],
			[1, "Le présent, c'est facile !"],
			[2, "Pour toi, peut-être !"],
		],
		[
			[2, "On prépare des jeux pour la cour, tu savais ?"],
			[1, "Génial ! Tu sais ce que ce sera ?"],
			[2, "Non, c'est encore une surprise."],
			[1, "Vivement qu'ils soient prêts !"],
		],
		[
			[1, "Tu préfères les chats ou les chiens ?"],
			[2, "Les chiens, ils jouent à la balle avec moi !"],
			[1, "Moi les chats, ils sont tout doux."],
		],
		[
			[2, "J'ai enfin toutes les cartes du CE1 !"],
			[1, "Bravo ! Il t'en manquait beaucoup ?"],
			[2, "Une seule, j'ai cru que je ne l'aurais jamais."],
		],
		[
			[1, "J'ai appris à lire l'heure sur une horloge."],
			[2, "Alors, il est quelle heure ?"],
			[1, "L'heure de jouer, bien sûr !"],
		],
		[
			[2, "Tu fais un sport après l'école ?"],
			[1, "Oui, de la danse le mercredi."],
			[2, "Moi, je fais du foot avec mon cousin."],
		],
		[
			[1, "Combien font huit plus sept ?"],
			[2, "Quinze !"],
			[1, "Bravo, tu calcules vite."],
		],
		[
			[2, "La maîtresse nous a lu une histoire de pirates."],
			[1, "J'adore les histoires de trésors cachés."],
			[2, "Un jour, je trouverai un vrai trésor !"],
		],
		[
			[1, "Tu crois que notre jeu sera difficile ?"],
			[2, "Un peu plus que ceux du CP, normalement."],
			[1, "Tant mieux, j'aime les défis !"],
		],
		[
			[2, "Il pleuvait ce matin."],
			[1, "Oui, j'ai mis mes bottes jaunes."],
			[2, "Moi, j'ai sauté dans toutes les flaques !"],
		],
	],
	GradeLevel.Grade.CE2: [
		[
			[1, "Carlos, tu connais la table de sept ?"],
			[2, "Sept fois huit... cinquante-six !"],
			[1, "Bravo, tu la connais vraiment bien !"],
		],
		[
			[2, "Clémentine, tu as vu le nouveau décor de la classe ?"],
			[1, "Oui ! Je l'ai débloqué avec mes défis."],
			[2, "Moi, je préfère changer la musique."],
		],
		[
			[1, "Bientôt, on aura nos propres jeux dans la cour."],
			[2, "J'espère qu'il y aura un jeu de course !"],
			[1, "Moi, j'aimerais un jeu de construction."],
		],
		[
			[2, "Ce week-end, je vais à la piscine."],
			[1, "Super ! Tu sais nager sous l'eau ?"],
			[2, "Oui, je retiens ma respiration très longtemps !"],
		],
		[
			[2, "Tu as déjà vu une éclipse ?"],
			[1, "Non, mais on en a parlé en sciences."],
			[2, "La Lune passe devant le Soleil, c'est incroyable !"],
		],
		[
			[1, "J'ai fini un livre de deux cents pages."],
			[2, "Waouh, ça parle de quoi ?"],
			[1, "D'une fille qui parle avec les animaux."],
			[2, "Un peu comme nous avec nos cartes !"],
		],
		[
			[2, "Clémentine, tu connais les verbes du troisième groupe ?"],
			[1, "Prendre, faire, aller... ils sont un peu bizarres."],
			[2, "Oui, mais on finit par les retenir."],
		],
		[
			[1, "On aura bientôt notre jeu dans la cour."],
			[2, "Il faudra plein de pièces pour s'entraîner."],
			[1, "Alors on répond bien aux questions !"],
		],
		[
			[2, "Mon chat dort toute la journée."],
			[1, "Le mien aussi, sauf quand il a faim."],
			[2, "Les chats sont les rois de la sieste !"],
		],
		[
			[1, "En maths, on apprend les mesures."],
			[2, "Je sais qu'un mètre fait cent centimètres."],
			[1, "Et un kilomètre fait mille mètres !"],
		],
	],
	GradeLevel.Grade.CM1: [
		[
			[2, "Hello Valérie! How are you?"],
			[1, "I'm fine, thank you! Tu révises ton anglais, John ?"],
			[2, "Oui, on a une évaluation demain."],
		],
		[
			[1, "En histoire, on étudie les châteaux forts."],
			[2, "J'aimerais vivre dans un château avec un pont-levis !"],
			[1, "Moi aussi, mais sans les fantômes."],
		],
		[
			[2, "Valérie, tu sais quel jeu on va proposer ?"],
			[1, "Pas encore, mais il faudra être malin pour gagner."],
			[2, "J'ai hâte de voir le classement !"],
		],
		[
			[1, "J'ai lu un livre génial sur les dauphins."],
			[2, "Ils sont super intelligents, non ?"],
			[1, "Oui, ils se parlent avec des sifflements !"],
		],
		[
			[2, "What's your favourite colour, Valérie?"],
			[1, "Blue! And yours?"],
			[2, "Green, like the playground!"],
		],
		[
			[1, "Tu sais ce qu'est un volcan ?"],
			[2, "Une montagne qui crache de la lave !"],
			[1, "On va en fabriquer une maquette en classe."],
		],
		[
			[2, "J'ai battu mon record de calcul mental."],
			[1, "Combien de bonnes réponses ?"],
			[2, "Vingt sur vingt, sans me presser !"],
		],
		[
			[1, "On devrait écrire un journal de l'école."],
			[2, "Je m'occuperais de la page des sports !"],
			[1, "Et moi, de la page des animaux."],
		],
		[
			[2, "Le jeu du CM1 arrive bientôt, paraît-il."],
			[1, "J'espère qu'il y aura des énigmes."],
			[2, "Moi, j'aimerais un jeu de vitesse."],
		],
		[
			[1, "Tu as déjà visité un musée ?"],
			[2, "Oui, celui des dinosaures !"],
			[1, "Il y avait un vrai squelette de dinosaure ?"],
			[2, "Oui, et il était immense !"],
		],
	],
	GradeLevel.Grade.CM2: [
		[
			[1, "Edouard, tu es prêt pour la sixième ?"],
			[2, "Un peu stressé, mais oui !"],
			[1, "On sera peut-être dans la même classe."],
		],
		[
			[2, "Les fractions, au début, je trouvais ça dur."],
			[1, "Et maintenant ?"],
			[2, "C'est comme partager une pizza, c'est facile !"],
		],
		[
			[1, "Notre jeu de la cour sera le plus difficile de tous."],
			[2, "Normal, on est les plus grands de l'école !"],
			[1, "Il faudra s'entraîner pour être dans le top."],
		],
		[
			[2, "Tu as toutes les cartes de la collection ?"],
			[1, "Toutes celles du CM2, et il me manque quelques CP !"],
			[2, "Ce sont les plus faciles à avoir, pourtant."],
		],
		[
			[2, "On a appris les pays d'Europe."],
			[1, "Tu connais la capitale de l'Espagne ?"],
			[2, "Madrid ! Et celle de l'Italie, c'est Rome."],
		],
		[
			[1, "Je prépare un exposé sur les planètes."],
			[2, "Tu vas parler de Saturne et de ses anneaux ?"],
			[1, "Bien sûr, c'est ma préférée !"],
		],
		[
			[2, "Tu crois qu'il y aura une cour de récré au collège ?"],
			[1, "Oui, mais elle sera beaucoup plus grande."],
			[2, "Et sans les petits du CP !"],
		],
		[
			[1, "Les pourcentages, ce n'est pas si compliqué."],
			[2, "Cinquante pour cent, c'est la moitié."],
			[1, "Et vingt-cinq pour cent, c'est le quart !"],
		],
		[
			[2, "Notre jeu sera prêt avant les vacances ?"],
			[1, "J'espère, je veux battre tout le monde !"],
			[2, "Il faudra d'abord gagner des pièces en classe."],
		],
		[
			[1, "Edouard, tu lis quoi en ce moment ?"],
			[2, "Un roman d'aventure dans la jungle."],
			[1, "Tu me le prêteras quand tu l'auras fini ?"],
			[2, "Promis !"],
		],
	],
}

## Une phrase par ligne dans les bulles (2026-11-25, retour utilisateur) : retour a la ligne apres
## chaque fin de phrase (. ! ?) suivie d'un espace puis d'une majuscule. Les repliques s'ecrivent
## donc normalement ci-dessus, sans \n. Les "..." suivis d'une minuscule ne coupent pas la ligne.
static func one_sentence_per_line(text: String) -> String:
	var result := ""
	var i := 0
	while i < text.length():
		var c := text[i]
		result += c
		if c in [".", "!", "?"] and i + 1 < text.length() and text[i + 1] == " ":
			var j := i + 1
			while j < text.length() and text[j] == " ":
				j += 1
			if j < text.length() and text[j] != text[j].to_lower():
				result += "\n"
				i = j
				continue
		i += 1
	return result
