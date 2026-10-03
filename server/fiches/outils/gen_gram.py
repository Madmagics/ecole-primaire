# Fiches de cours Grammaire CE1 -> CM2 (2026-10-03) : une fiche par couple notion + classe ayant des
# questions de grammaire publiees et pas encore de fiche (ce1 masculin_feminin et cm1 homophones ont deja
# leur fiche via l'orthographe). Genere server/fiches/gram_<cl>_<code>.sql + gram_toutes.sql + .txt de rendu.
import os
import sys
from logique_lib import rangee, tableau, sans_gras_emoji, couleur_alt

FICHES = []


def add(cl, code, titre, pages):
    FICHES.append((cl, code, titre, [couleur_alt(cl, p) for p in pages]))


def r(x):
    return f'[b][color=#C62828]{x}[/color][/b]'


def gros(t, size=26):
    return f'[center][font_size={size}][b]{t}[/b][/font_size][/center]'


# ========================================================================================  CE1
add('ce1', 'nature_mots', 'La nature des mots', [
f"""[titre]Chaque mot a une nature[/titre]
Les mots sont rangés en [b]familles[/b] : c'est leur [b]nature[/b].
{tableau(4, ['nom', 'verbe', 'adjectif', 'adverbe', 'fleur', 'cuisiner', 'généreux', 'soudainement'], size=21, lignes=True)}
[cadre]Pour trouver la nature d'un mot, je fais des [b]tests[/b].[/cadre]""",
f"""[titre]Le nom[/titre]
Le [b]nom[/b] désigne une personne, un animal, une chose ou une idée.
[cadre]un fantôme · une fleur · le laboratoire · des ciseaux[/cadre]
[cadre=astuce]Test : je peux mettre [b]le[/b], [b]la[/b], [b]un[/b] ou [b]une[/b] devant.
« un fantôme » ✓ → c'est un [b]nom[/b].[/cadre]""",
f"""[titre]Le verbe[/titre]
Le [b]verbe[/b] dit ce qu'on [b]fait[/b] (une action) ou comment on [b]est[/b].
[cadre]montrer · répondre · cuisiner · grandir[/cadre]
[cadre=astuce]Test : je peux le [b]conjuguer[/b] avec je, tu, il…
répondre → [b]je[/b] réponds, [b]il[/b] répond ✓ → c'est un [b]verbe[/b].
À l'infinitif, il finit souvent par [b]-er[/b], [b]-ir[/b] ou [b]-re[/b].[/cadre]""",
f"""[titre]L'adjectif[/titre]
L'[b]adjectif[/b] dit [b]comment est[/b] le nom.
[cadre]un garçon [b]généreux[/b] · une histoire [b]incroyable[/b][/cadre]
[cadre=astuce]Test : je peux le mettre à côté d'un nom et dire « [b]très[/b] » devant.
un enfant très généreux ✓ → c'est un [b]adjectif[/b].
Il change au féminin : généreux → généreu[b]se[/b].[/cadre]""",
f"""[titre]L'adverbe[/titre]
L'[b]adverbe[/b] dit [b]comment[/b], [b]quand[/b] ou [b]où[/b]. Il ne change [b]jamais[/b].
[cadre]Il court [b]vite[/b]. Elle arrive [b]soudainement[/b]. Il pleut [b]souvent[/b].[/cadre]
[cadre=astuce]Beaucoup d'adverbes finissent par [b]-ment[/b] : naturelle[b]ment[/b], soudaine[b]ment[/b].[/cadre]""",
f"""[titre]Mes tests[/titre]
{tableau(2, ['nom', 'je peux dire un, une, le, la devant', 'verbe', 'je peux dire je, tu, il devant', 'adjectif', 'je peux dire « très » devant et le mettre à côté d\'un nom', 'adverbe', 'il ne change jamais, souvent en -ment'], size=19, lignes=True)}""",
"""[titre]Un mot, deux natures[/titre]
Certains mots changent de nature selon la [b]phrase[/b].
[cadre]Ma [b]montre[/b] indique huit heures. → [b]ma[/b] montre : c'est un [b]nom[/b].
Il [b]montre[/b] le chemin. → [b]il[/b] montre : c'est un [b]verbe[/b].[/cadre]
[cadre=astuce]Je regarde le petit mot juste devant : un déterminant (ma, la) → nom ; un pronom (il, je) → verbe.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Nom[/b] : personne, animal, chose → un fantôme.
• [b]Verbe[/b] : action, se conjugue → il répond.
• [b]Adjectif[/b] : dit comment est le nom → généreux.
• [b]Adverbe[/b] : ne change pas, souvent en -ment → soudainement.
• Dans une phrase, je regarde le mot devant pour vérifier.[/cadre]""",
])

add('ce1', 'singulier_pluriel', 'Le pluriel des noms', [
f"""[titre]Singulier et pluriel[/titre]
{tableau(2, ['un robot', 'des robot' + r('s'), 'une trousse', 'des trousse' + r('s'), 'un canapé', 'des canapé' + r('s')], entete=['singulier : un seul', 'pluriel : plusieurs'], size=21, paires=True)}
[cadre]En général, au pluriel, j'ajoute un [b]s[/b]. Il ne s'entend pas.[/cadre]""",
f"""[titre]-eau → x[/titre]
Les noms en [b]-eau[/b] prennent un [b]x[/b] au pluriel.
{tableau(4, ['un drapeau', 'des drapeau' + r('x'), 'un morceau', 'des morceau' + r('x'), 'un panneau', 'des panneau' + r('x'), 'un roseau', 'des roseau' + r('x'), 'un réseau', 'des réseau' + r('x'), 'un niveau', 'des niveau' + r('x')], size=19, paires=True)}""",
f"""[titre]-al → -aux[/titre]
Les noms en [b]-al[/b] deviennent [b]-aux[/b].
{tableau(4, ['un chev' + r('al'), 'des chev' + r('aux'), 'un journ' + r('al'), 'des journ' + r('aux'), 'un hôpit' + r('al'), 'des hôpit' + r('aux'), 'un can' + r('al'), 'des can' + r('aux'), 'un boc' + r('al'), 'des boc' + r('aux'), 'un m' + r('al'), 'des m' + r('aux')], size=19, paires=True)}""",
f"""[titre]Quelques mots en -ail → -aux[/titre]
La plupart des noms en -ail prennent un s : un éventail → des éventail{r('s')}.
Mais quelques-uns deviennent [b]-aux[/b] :
{tableau(2, ['un trav' + r('ail'), 'des trav' + r('aux'), 'un cor' + r('ail'), 'des cor' + r('aux')], entete=['singulier', 'pluriel'], size=22, paires=True)}""",
f"""[titre]Les noms qui ne changent pas[/titre]
Un nom qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] reste pareil au pluriel.
{tableau(4, ['un radis', 'des radis', 'un repas', 'des repas', 'une voix', 'des voix', 'un prix', 'des prix', 'un nez', 'des nez', 'un gaz', 'des gaz'], size=19, paires=True)}
[cadre=astuce]C'est le petit mot devant (un / des) qui montre le pluriel.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• En général : [b]+ s[/b] (un robot, des robots).
• -eau → [b]x[/b] : des drapeaux.
• -al → [b]-aux[/b] : des chevaux. Aussi : travail → travaux, corail → coraux.
• Déjà fini par s, x, z : [b]pas de changement[/b].[/cadre]""",
])

# ========================================================================================  CE2
add('ce2', 'pronoms', 'Les pronoms personnels', [
f"""[titre]Le pronom remplace un nom[/titre]
Le [b]pronom[/b] remplace un groupe de mots pour ne pas le répéter.
[cadre][b]La maîtresse[/b] écrit au tableau. → [b]Elle[/b] écrit au tableau.[/cadre]
{tableau(4, ['je', 'tu', 'il', 'elle', 'nous', 'vous', 'ils', 'elles'], size=24, lignes=True)}""",
f"""[titre]Masculin ou féminin ?[/titre]
{tableau(2, ['le sentier, le livre', r('il'), 'la carte, la voisine', r('elle'), 'les marins, les crabes', r('ils'), 'les mouettes, les chaises', r('elles')], entete=['groupe de mots', 'pronom'], size=21, lignes=True)}
[cadre=astuce]Avec « l' », je cherche si le nom est masculin ou féminin : [b]une[/b] échelle → l'échelle → [b]elle[/b].[/cadre]""",
"""[titre]Garçons et filles ensemble[/titre]
[cadre]Léo et Tom → [b]ils[/b]
Jade et Naomi → [b]elles[/b]
Léo et Zoé → [b]ils[/b][/cadre]
[cadre=astuce]Dès qu'il y a [b]au moins un masculin[/b] dans le groupe, on dit [b]ils[/b].[/cadre]""",
"""[titre]Avec moi, avec toi[/titre]
[cadre]Yasmine [b]et moi[/b] → [b]nous[/b] (je fais partie du groupe)
Léo [b]et toi[/b] → [b]vous[/b] (tu fais partie du groupe)[/cadre]
[cadre=astuce]« moi » dans le groupe → nous. « toi » dans le groupe (sans moi) → vous.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Masculin singulier → [b]il[/b] ; féminin singulier → [b]elle[/b].
• Masculin pluriel ou groupe mélangé → [b]ils[/b] ; féminin pluriel → [b]elles[/b].
• Avec « moi » → [b]nous[/b] ; avec « toi » → [b]vous[/b].
• Devant l', je cherche le genre avec un / une.[/cadre]""",
])

add('ce2', 'types_phrases', 'Types et formes de phrases', [
f"""[titre]Les 4 types de phrases[/titre]
{tableau(3, ['déclarative', 'elle raconte, elle informe', 'Le bus arrive bientôt.', 'interrogative', 'elle pose une question', 'As-tu un chat ?', 'exclamative', 'elle montre une émotion', 'Quelle belle étoile !', 'impérative', 'elle donne un ordre, un conseil', 'Mets ton bonnet.'], entete=['type', 'à quoi elle sert', 'exemple'], size=18, lignes=True)}""",
f"""[titre]Le point à la fin[/titre]
{tableau(2, ['déclarative', r('.') + ' point', 'interrogative', r('?') + " point d'interrogation", 'exclamative', r('!') + " point d'exclamation", 'impérative', r('.') + ' ou ' + r('!')], size=21, lignes=True)}
[cadre=astuce]« Comme… ! », « Quel… ! », « Que… ! » annoncent souvent une phrase [b]exclamative[/b].[/cadre]""",
"""[titre]La phrase impérative[/titre]
La phrase impérative donne un [b]ordre[/b] : elle n'a [b]pas de sujet[/b] devant le verbe.
[cadre][b]Prends[/b] ton goûter. · [b]Écrivez[/b] la date. · [b]Rangeons[/b] la classe.[/cadre]
[cadre=astuce]Tu prends ton goûter. (déclarative) → [b]Prends[/b] ton goûter. (impérative) : le « tu » disparaît.[/cadre]""",
"""[titre]Poser une question[/titre]
Il y a plusieurs façons de transformer une phrase en question :
[cadre]Vous habitez près de l'école.
→ [b]Est-ce que[/b] vous habitez près de l'école ?
→ [b]Habitez-vous[/b] près de l'école ? (on inverse le sujet et le verbe, avec un trait d'union)[/cadre]
[cadre=astuce]Les mots qui, quand, où, pourquoi, comment commencent souvent une question.[/cadre]""",
f"""[titre]Forme affirmative ou négative[/titre]
La forme [b]négative[/b] dit le contraire. Elle a [b]deux[/b] petits mots autour du verbe.
{tableau(2, ['Tom aime les épinards.', 'Tom ' + r('n\'') + 'aime ' + r('pas') + ' les épinards.', 'Il pleut encore.', 'Il ' + r('ne') + ' pleut ' + r('plus') + '.', 'Nous avons vu quelque chose.', 'Nous ' + r('n\'') + 'avons ' + r('rien') + ' vu.'], entete=['affirmative', 'négative'], size=19, paires=True)}
[cadre]ne… pas · ne… plus · ne… jamais · ne… rien · ne… personne[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Déclarative ( . ) : je raconte. Interrogative ( ? ) : je pose une question.
• Exclamative ( ! ) : je m'exclame. Impérative : je donne un ordre, sans sujet.
• Question : « Est-ce que… ? » ou inversion « Habitez-vous… ? ».
• Négative : ne… pas, ne… plus, ne… jamais, ne… rien, ne… personne.[/cadre]""",
])

add('ce2', 'accord_sujet_verbe', 'L\'accord du sujet et du verbe', [
"""[titre]Le verbe s'accorde avec le sujet[/titre]
Le verbe change sa terminaison selon [b]qui[/b] fait l'action : c'est le [b]sujet[/b].
[cadre]Le poisson nag[b]e[/b]. → Les poissons nag[b]ent[/b].[/cadre]
[cadre=astuce]Pour trouver le sujet, je pose la question « [b]Qui est-ce qui[/b] nage ? » → les poissons.[/cadre]""",
f"""[titre]Je remplace le sujet par un pronom[/titre]
{tableau(2, ['mon frère, la secrétaire', r('il / elle') + ' porte', 'les voisins, les randonneurs', r('ils / elles') + ' observent', 'ma sœur et moi', r('nous') + ' regardons', 'toi et Léo', r('vous') + ' regardez'], entete=['sujet', 'pronom + verbe'], size=20, lignes=True)}""",
f"""[titre]Les verbes en -er au présent[/titre]
{tableau(6, ['je', 'tu', 'il, elle', 'nous', 'vous', 'ils, elles', 'arros' + r('e'), 'arros' + r('es'), 'arros' + r('e'), 'arros' + r('ons'), 'arros' + r('ez'), 'arros' + r('ent')], size=18, lignes=True)}
[cadre=astuce]Avec ils / elles : [b]-ent[/b], qui ne s'entend pas ! Les poissons nag[b]ent[/b].[/cadre]""",
f"""[titre]Les verbes comme finir[/titre]
{tableau(6, ['je', 'tu', 'il, elle', 'nous', 'vous', 'ils, elles', 'pun' + r('is'), 'pun' + r('is'), 'pun' + r('it'), 'pun' + r('issons'), 'pun' + r('issez'), 'pun' + r('issent')], size=18, lignes=True)}
[cadre]Pareil : nourrir, vieillir, grandir, choisir…[/cadre]""",
f"""[titre]Des verbes à connaître[/titre]
{tableau(4, ['', 'être', 'prendre', 'courir', 'je', 'suis', 'prends', 'cours', 'tu', 'es', 'prends', 'cours', 'il, elle', 'est', 'prend', 'court', 'nous', 'sommes', 'prenons', 'courons', 'vous', 'êtes', 'prenez', 'courez', 'ils, elles', 'sont', 'prennent', 'courent'], size=17, lignes=True)}""",
"""[titre]Attention au sujet éloigné[/titre]
Le sujet n'est pas toujours juste avant le verbe.
[cadre][b]Chaque jour[/b], la secrétaire arrose les plantes.
« Chaque jour » n'est pas le sujet : qui est-ce qui arrose ? → [b]la secrétaire[/b] → arros[b]e[/b].[/cadre]
[cadre=astuce]Je cache les mots qui disent quand ou où : il reste le sujet et le verbe.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je trouve le sujet : « Qui est-ce qui… ? ».
• Je le remplace par un pronom : il, elle, ils, elles…
• -er : e, es, e, ons, ez, [b]ent[/b]. Comme finir : is, is, it, issons, issez, issent.
• Ce qui dit quand ou où n'est pas le sujet.[/cadre]""",
])

add('ce2', 'fonctions', 'Le sujet du verbe', [
"""[titre]Qui fait l'action ?[/titre]
Le [b]sujet[/b] est le groupe de mots qui [b]fait l'action[/b] du verbe.
[cadre][b]Le pompier[/b] éteint l'incendie.
Qui est-ce qui éteint ? → [b]le pompier[/b] : c'est le sujet.[/cadre]""",
f"""[titre]Ma méthode[/titre]
[cadre]1. Je trouve le [b]verbe[/b] (le mot qui se conjugue).
2. Je pose la question « [b]Qui est-ce qui[/b] + verbe ? ».
3. La réponse est le [b]sujet[/b].[/cadre]
{tableau(3, ['Les lapins creusent un terrier.', 'Qui est-ce qui creuse ?', r('Les lapins')], size=19)}""",
"""[titre]Le truc de « C'est… qui »[/titre]
Je peux encadrer le sujet avec « [b]C'est… qui[/b] » ou « [b]Ce sont… qui[/b] ».
[cadre][b]Ce sont[/b] les fourmis [b]qui[/b] transportent une feuille. ✓
→ « Les fourmis » est le sujet.[/cadre]""",
"""[titre]Le sujet est un groupe[/titre]
Le sujet n'est souvent pas un seul mot : c'est un [b]groupe nominal[/b] (un petit mot + un nom).
[cadre][b]La sorcière[/b] prépare une potion. → la + sorcière
[b]Le coureur[/b] gagne la course. → le + coureur[/cadre]
[cadre=astuce]Je peux remplacer le sujet par [b]il, elle, ils[/b] ou [b]elles[/b] : Elle prépare une potion ✓[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le sujet fait l'action du verbe.
• Question : « Qui est-ce qui + verbe ? ».
• Truc : « C'est… qui » / « Ce sont… qui ».
• Le sujet peut être remplacé par il, elle, ils, elles.[/cadre]""",
])

# ========================================================================================  CM1
add('cm1', 'participe_passe', 'Le participe passé avec être', [
"""[titre]Le participe passé[/titre]
Au passé composé, le verbe a deux parties : l'[b]auxiliaire[/b] et le [b]participe passé[/b].
[cadre]Marie [b]est[/b] [b]arrivée[/b] en retard.
« est » = auxiliaire être · « arrivée » = participe passé[/cadre]""",
f"""[titre]Les verbes avec être[/titre]
Certains verbes se conjuguent avec [b]être[/b] au passé composé :
{tableau(4, ['aller', 'venir', 'arriver', 'partir', 'entrer', 'sortir', 'monter', 'descendre', 'naître', 'mourir', 'devenir', 'revenir', 'rester', 'tomber', 'passer', 'retourner'], size=19)}
[cadre=astuce]Ce sont surtout des verbes de [b]mouvement[/b] ou de [b]changement[/b].[/cadre]""",
f"""[titre]Avec être, il s'accorde avec le sujet[/titre]
{tableau(2, ['Tom est arrivé.', 'masculin singulier', 'Marie est arrivé' + r('e') + '.', 'féminin singulier', 'Les garçons sont arrivé' + r('s') + '.', 'masculin pluriel', 'Jade et Naomi sont arrivé' + r('es') + '.', 'féminin pluriel'], size=20, lignes=True)}
[cadre]Comme un adjectif : [b]e[/b] au féminin, [b]s[/b] au pluriel.[/cadre]""",
f"""[titre]Les terminaisons[/titre]
{tableau(5, ['', 'masc. sing.', 'fém. sing.', 'masc. plur.', 'fém. plur.', 'arriver', 'arrivé', 'arrivé' + r('e'), 'arrivé' + r('s'), 'arrivé' + r('es'), 'sortir', 'sorti', 'sorti' + r('e'), 'sorti' + r('s'), 'sorti' + r('es'), 'devenir', 'devenu', 'devenu' + r('e'), 'devenu' + r('s'), 'devenu' + r('es'), 'naître', 'né', 'né' + r('e'), 'né' + r('s'), 'né' + r('es')], size=17, lignes=True)}""",
"""[titre]Ma méthode[/titre]
[cadre]1. Je vérifie que l'auxiliaire est [b]être[/b] (est, sont, suis…).
2. Je trouve le [b]sujet[/b] : qui est-ce qui est arrivé ?
3. Masculin ou féminin ? Singulier ou pluriel ?
4. J'ajoute [b]e[/b], [b]s[/b] ou [b]es[/b].[/cadre]
[cadre=astuce]Un groupe avec un garçon et une fille → masculin pluriel : Léo et Zoé sont parti[b]s[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Passé composé = auxiliaire + participe passé.
• Avec [b]être[/b], le participe passé s'accorde avec le [b]sujet[/b].
• Féminin → e · pluriel → s · féminin pluriel → es.
• Verbes avec être : aller, venir, arriver, partir, naître, devenir, sortir, monter…[/cadre]""",
])

add('cm1', 'fonctions', 'COD, COI et attribut du sujet', [
"""[titre]Les compléments du verbe[/titre]
Après le verbe, on trouve souvent un groupe de mots qui le [b]complète[/b].
[cadre]Le pêcheur attrape [b]un poisson[/b]. → COD
Elle succède [b]à son père[/b]. → COI
Ce jeu semble [b]amusant[/b]. → attribut du sujet[/cadre]""",
"""[titre]Le COD[/titre]
Le [b]COD[/b] (complément d'objet direct) se trouve en posant la question [b]qui ?[/b] ou [b]quoi ?[/b] juste après le verbe.
[cadre]Le fermier cultive [b]son champ[/b]. → Il cultive quoi ? son champ
Nous préparons [b]le dîner[/b]. → Nous préparons quoi ? le dîner[/cadre]
[cadre=astuce]« Direct » : il n'y a [b]pas de petit mot[/b] (à, de) entre le verbe et le COD.[/cadre]""",
"""[titre]Le COI[/titre]
Le [b]COI[/b] (complément d'objet indirect) répond à [b]à qui ? à quoi ? de qui ? de quoi ?[/b]
[cadre]Le public sourit [b]aux artistes[/b]. → sourit à qui ? aux artistes
Elle parle [b]de son voyage[/b]. → parle de quoi ? de son voyage[/cadre]
[cadre=astuce]« Indirect » : il commence par [b]à, au, aux, de, du, des[/b].[/cadre]""",
f"""[titre]L'attribut du sujet[/titre]
Après [b]être, sembler, paraître, devenir, rester, avoir l'air[/b], le mot qui suit dit [b]comment est le sujet[/b] : c'est l'[b]attribut du sujet[/b].
[cadre]La soupe [b]semble[/b] trop salée. → la soupe = trop salée
Mon père [b]est[/b] pompier. → mon père = pompier[/cadre]
[cadre=astuce]Test : je peux mettre « [b]=[/b] » entre le sujet et l'attribut. Il s'accorde avec le sujet : la météo semble incertain[b]e[/b].[/cadre]""",
f"""[titre]Ma méthode[/titre]
{tableau(3, ['être, sembler, paraître… ?', 'oui', 'attribut du sujet', 'Verbe + qui ? quoi ?', 'sans à / de', 'COD', 'Verbe + à qui ? de quoi ?', 'avec à / de', 'COI'], entete=['Je me demande', '', 'Fonction'], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• [b]COD[/b] : verbe + qui ? / quoi ? sans préposition → il range [b]ses affaires[/b].
• [b]COI[/b] : verbe + à qui ? / de quoi ? avec à, de → il sourit [b]aux artistes[/b].
• [b]Attribut du sujet[/b] : après être, sembler, paraître… → ce jeu semble [b]amusant[/b].[/cadre]""",
])

add('cm1', 'determinants', 'Les déterminants démonstratifs et possessifs', [
f"""[titre]Montrer : ce, cet, cette, ces[/titre]
Les déterminants [b]démonstratifs[/b] servent à montrer.
{tableau(2, ['ce', 'masculin, devant une consonne : ce chapeau', 'cet', 'masculin, devant une voyelle ou un h muet : cet arbre, cet hôtel', 'cette', 'féminin : cette classe', 'ces', 'pluriel : ces étoiles'], size=19, lignes=True)}""",
"""[titre]ce ou cet ?[/titre]
[cadre]Les deux sont pour un nom [b]masculin singulier[/b].
• [b]ce[/b] devant une consonne : ce classeur, ce chapeau
• [b]cet[/b] devant une voyelle ou un h muet : cet oiseau, cet homme[/cadre]
[cadre=astuce]« cet » et « cette » se disent pareil. Je dis « un » ou « une » : [b]un[/b] arbre → cet arbre ; [b]une[/b] classe → cette classe.[/cadre]""",
f"""[titre]Dire à qui c'est[/titre]
Les déterminants [b]possessifs[/b] disent à qui appartient la chose.
{tableau(4, ['', 'masc. sing.', 'fém. sing.', 'pluriel', 'à moi', 'mon', 'ma', 'mes', 'à toi', 'ton', 'ta', 'tes', 'à lui, à elle', 'son', 'sa', 'ses', 'à nous', 'notre', 'notre', 'nos', 'à vous', 'votre', 'votre', 'vos', 'à eux, à elles', 'leur', 'leur', 'leurs'], size=18, lignes=True)}""",
"""[titre]Le piège : mon écharpe[/titre]
Devant un nom féminin qui commence par une [b]voyelle[/b], on dit [b]mon, ton, son[/b] pour que ce soit plus facile à prononcer.
[cadre]une écharpe → [b]mon[/b] écharpe (et pas « ma écharpe »)
une amie → [b]ton[/b] amie · une histoire → [b]son[/b] histoire[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. À qui est la chose ? (à moi, à toi, à nous, à eux…)
2. Le nom est-il masculin, féminin, singulier ou pluriel ?
3. Il commence par une voyelle ? Attention à cet / mon.[/cadre]
[cadre=astuce]C'est à eux : [b]leur[/b] gourde (une seule), [b]leurs[/b] affaires (plusieurs).[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Montrer : ce (masc.), cet (masc. + voyelle), cette (fém.), ces (plur.).
• À qui ? mon/ma/mes, ton/ta/tes, son/sa/ses, notre/nos, votre/vos, leur/leurs.
• Devant une voyelle : cet arbre, mon écharpe.[/cadre]""",
])

# ========================================================================================  CM2
add('cm2', 'participe_passe', 'L\'accord du participe passé', [
"""[titre]Rappel : avec être[/titre]
Avec l'auxiliaire [b]être[/b], le participe passé s'accorde avec le [b]sujet[/b].
[cadre]Elles sont parti[b]es[/b]. · Les garçons sont venu[b]s[/b].[/cadre]""",
"""[titre]Avec avoir : pas d'accord avec le sujet[/titre]
Avec l'auxiliaire [b]avoir[/b], le participe passé [b]ne s'accorde jamais avec le sujet[/b].
[cadre]La couturière a [b]préparé[/b] le colis.
Les musiciens ont [b]enregistré[/b] une mélodie.[/cadre]
[cadre=astuce]Même si le sujet est féminin ou pluriel : elles ont [b]mangé[/b].[/cadre]""",
f"""[titre]Avec avoir : le COD placé avant[/titre]
Le participe passé avec avoir s'accorde avec le [b]COD[/b] seulement s'il est placé [b]avant[/b] le verbe.
{tableau(2, ['COD après : pas d\'accord', 'Elle a acheté [b]la pomme[/b].', 'COD avant : accord', '[b]La pomme[/b] qu\'elle a acheté' + r('e') + '.'], size=20, lignes=True)}""",
"""[titre]Où se cache le COD placé avant ?[/titre]
[cadre]• Après [b]que / qu'[/b] : les gâteaux [b]que[/b] tu as offert[b]s[/b].
• Dans un pronom [b]l', la, les[/b] : ces photos, je [b]les[/b] ai perdu[b]es[/b].[/cadre]
[cadre=astuce]« que » remplace le nom juste avant : les livres que nous avons fini[b]s[/b] → que = les livres (masc. plur.).[/cadre]""",
f"""[titre]Ma méthode[/titre]
{tableau(2, ['Auxiliaire être ?', 'accord avec le [b]sujet[/b]', 'Auxiliaire avoir, COD après ou pas de COD ?', '[b]pas d\'accord[/b]', 'Auxiliaire avoir, COD avant (que, l\', les) ?', 'accord avec le [b]COD[/b]'], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• Être → accord avec le sujet : elles sont venues.
• Avoir → pas d'accord avec le sujet : elles ont chanté.
• Avoir + COD avant → accord avec le COD : la photo que nous avons perdue.
• Le COD avant se cache dans que, l', la, les.[/cadre]""",
])

add('cm2', 'pronoms_relatifs', 'Les pronoms relatifs', [
"""[titre]Relier deux phrases[/titre]
Le [b]pronom relatif[/b] relie deux phrases en évitant de répéter un nom.
[cadre]L'oiseau chante. L'oiseau est un rossignol.
→ L'oiseau [b]qui[/b] chante est un rossignol.[/cadre]
Les pronoms relatifs : [b]qui, que, dont, où[/b].""",
"""[titre]qui : le sujet[/titre]
[b]qui[/b] remplace le [b]sujet[/b] du verbe qui suit.
[cadre]L'oiseau [b]qui[/b] chante… → l'oiseau chante.[/cadre]
[cadre=astuce]Après « qui », il y a directement un [b]verbe[/b] : qui chante, qui dort.[/cadre]""",
"""[titre]que : le COD[/titre]
[b]que[/b] remplace le [b]COD[/b] du verbe qui suit.
[cadre]L'exercice [b]que[/b] nous avons fait… → nous avons fait l'exercice.
Le jouet [b]qu'[/b]il préfère… → il préfère le jouet.[/cadre]
[cadre=astuce]Après « que », il y a un [b]sujet[/b] puis le verbe : que nous avons fait.[/cadre]""",
"""[titre]dont : remplace « de… »[/titre]
[b]dont[/b] remplace un complément introduit par [b]de[/b].
[cadre]L'objet [b]dont[/b] tu as besoin… → tu as besoin [b]de[/b] l'objet.
L'histoire [b]dont[/b] elle se souvient… → elle se souvient [b]de[/b] l'histoire.[/cadre]
[cadre=astuce]Verbes avec « de » : avoir besoin de, se souvenir de, parler de, discuter de…[/cadre]""",
"""[titre]où : le lieu ou le temps[/titre]
[b]où[/b] remplace un [b]lieu[/b] ou un [b]moment[/b].
[cadre]Le quartier [b]où[/b] j'ai grandi… → j'ai grandi dans ce quartier.
Le jour [b]où[/b] elle est née… → elle est née ce jour-là.[/cadre]""",
f"""[titre]Ma méthode[/titre]
[cadre]Je refais la phrase avec le nom à la place du pronom :[/cadre]
{tableau(2, ['le nom fait l\'action', r('qui'), 'le nom est le COD', r('que'), '« de » + le nom', r('dont'), 'un lieu ou un moment', r('où')], size=21, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• [b]qui[/b] : sujet → l'oiseau qui chante.
• [b]que[/b] : COD → le dessin que tu as fait.
• [b]dont[/b] : remplace « de… » → l'objet dont tu as besoin.
• [b]où[/b] : lieu ou temps → la forêt où ils marchent.[/cadre]""",
])

add('cm2', 'complements_circonstanciels', 'Les compléments circonstanciels', [
"""[titre]Les circonstances de l'action[/titre]
Le [b]complément circonstanciel[/b] (CC) donne des précisions : [b]où[/b], [b]quand[/b], [b]comment[/b], [b]pourquoi[/b].
[cadre]Le train part [b]à huit heures[/b]. → quand ?
L'oiseau vole [b]au-dessus des toits[/b]. → où ?[/cadre]""",
f"""[titre]Les types de CC[/titre]
{tableau(3, ['lieu', 'où ?', 'dans l\'armoire, au-dessus des toits', 'temps', 'quand ?', 'à neuf heures, dans une semaine, après le dîner', 'manière', 'comment ?', 'avec douceur, attentivement', 'cause', 'pourquoi ?', 'à cause de la pluie, de peur'], entete=['type', 'question', 'exemples'], size=18, lignes=True)}""",
"""[titre]On peut le déplacer ou le supprimer[/titre]
[cadre]Le magasin ouvre [b]à neuf heures[/b].
→ [b]À neuf heures[/b], le magasin ouvre. (déplacé ✓)
→ Le magasin ouvre. (supprimé ✓)[/cadre]
[cadre=astuce]C'est ce qui le distingue du COD : « Il range ses affaires » → « Il range » ne veut plus rien dire.[/cadre]""",
"""[titre]Les adverbes de manière[/titre]
Un [b]adverbe en -ment[/b] est souvent un CC de [b]manière[/b] : il répond à « comment ? ».
[cadre]Il conduit [b]dangereusement[/b]. → comment conduit-il ? dangereusement
Les élèves écoutent [b]attentivement[/b]. → comment ? attentivement[/cadre]""",
"""[titre]Attention aux pièges[/titre]
[cadre]« [b]dans[/b] » peut annoncer un lieu ou un temps :
dans l'armoire → [b]lieu[/b] · dans une semaine → [b]temps[/b][/cadre]
[cadre=astuce]Je ne me fie pas au premier mot : je pose la bonne question (où ? quand ?).[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Lieu → où ? · Temps → quand ? · Manière → comment ? · Cause → pourquoi ?
• Le CC peut être déplacé ou supprimé.
• Un adverbe en -ment est souvent un CC de manière.
• Je pose la question, sans me fier au premier mot.[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
SQL = """-- Fiche {titre} ({CL}) - grammaire, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'grammaire', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
TXT = sys.argv[2] if len(sys.argv) > 2 else None
toutes = ['-- Toutes les fiches de cours Grammaire CE1 -> CM2 (2026-10-03), une seule transaction.', 'begin;']
for cl, code, titre, pages in FICHES:
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    assert '[s]' not in contenu
    sql = SQL.format(CL=cl.upper(), cl=cl, titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
    with open(os.path.join(OUT, f'gram_{cl}_{code}.sql'), 'w', encoding='utf-8') as f:
        f.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{cl}_{code}.txt'), 'w', encoding='utf-8') as f:
            f.write(contenu)
    print(cl, code, titre, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'gram_toutes.sql'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(toutes) + '\n')
print(len(FICHES), 'fiches')
