# Fiches de cours Orthographe CE1 -> CM2 (2026-10-03) : une fiche par couple notion + classe
# ayant des questions d'orthographe publiees (14 fiches). Genere server/fiches/ortho_<cl>_<code>.sql,
# server/fiches/ortho_toutes.sql et un .txt par fiche pour la verification du rendu.
import os
import sys
from logique_lib import rangee, tableau, sans_gras_emoji, couleur_alt

FICHES = []


def add(cl, code, titre, pages):
    FICHES.append((cl, code, titre, [couleur_alt(cl, p) for p in pages]))


def r(x):  # lettres a remarquer : rouge fonce gras (lisible sur les deux couleurs de lignes)
    return f'[b][color=#C62828]{x}[/color][/b]'


def gros(t, size=28):
    return f'[center][font_size={size}][b]{t}[/b][/font_size][/center]'


def lettres(mot):
    """Un mot lettre par lettre avec le numero de chaque lettre en dessous."""
    ls = list(mot)
    s = f'[table={len(ls)}]'
    for l in ls:
        s += f'[cell bg=#classe_clair border=#classe padding=12,4,12,4][center][font_size=28][b]{l}[/b][/font_size][/center][/cell]'
    for i in range(len(ls)):
        s += f'[cell padding=12,2,12,2][center][font_size=18][b][color=#unites]{i + 1}[/color][/b][/font_size][/center][/cell]'
    return s + '[/table]'


# ========================================================================================  CE1
add('ce1', 'homophones', 'Les homophones : et, est, son, sont', [
f"""[titre]Des mots qui se disent pareil[/titre]
Certains mots se [b]disent[/b] de la même façon, mais ne s'[b]écrivent[/b] pas pareil et ne veulent pas dire la même chose : ce sont des [b]homophones[/b].
{tableau(2, ['et', 'est', 'son', 'sont'], size=30, paires=True)}
[cadre]Pour choisir, j'utilise un [b]truc[/b] : je remplace le mot par un autre.[/cadre]""",
"""[titre]« et » pour ajouter[/titre]
[b]et[/b] sert à [b]relier[/b] deux mots, comme un pont.
[cadre]Léon [b]et[/b] Faustine arrosent le potager.
Iris [b]et[/b] Paul mangent un yaourt.[/cadre]
[cadre=astuce]Je peux dire « [b]et puis[/b] » : Léon et puis Faustine… ✓
Alors j'écris [b]et[/b].[/cadre]""",
"""[titre]« est » : le verbe être[/titre]
[b]est[/b] est le verbe [b]être[/b] : il / elle [b]est[/b].
[cadre]Agathe [b]est[/b] énervée.
Le fermier [b]est[/b] distrait.[/cadre]
[cadre=astuce]Je peux dire « [b]était[/b] » : Agathe était énervée ✓
Alors j'écris [b]est[/b].[/cadre]""",
f"""[titre]et ou est ?[/titre]
{tableau(3, ['Suzanne ___ la couturière', 'et puis ✓', '[b]et[/b]', 'Le chat ___ gourmand.', 'était ✓', '[b]est[/b]', 'Louis ___ le chat jouent.', 'et puis ✓', '[b]et[/b]'], entete=['Phrase', 'Je remplace', "J'écris"], size=20, lignes=True)}
[cadre]Quand on parle de [b]deux personnes[/b] qui font quelque chose ensemble, c'est souvent [b]et[/b].[/cadre]""",
"""[titre]« son » : à lui, à elle[/titre]
[b]son[/b] veut dire [b]à lui[/b] ou [b]à elle[/b]. Il est toujours devant un nom.
[cadre]Il range [b]son[/b] album. → l'album est à lui.
Elle partage [b]son[/b] puzzle. → le puzzle est à elle.[/cadre]
[cadre=astuce]Je peux dire « [b]mon[/b] » : je range mon album ✓
Alors j'écris [b]son[/b].[/cadre]""",
"""[titre]« sont » : le verbe être[/titre]
[b]sont[/b] est le verbe [b]être[/b] avec [b]plusieurs[/b] : ils / elles [b]sont[/b].
[cadre]Les pingouins [b]sont[/b] affamés.
Les chevaux [b]sont[/b] fatigués.[/cadre]
[cadre=astuce]Je peux dire « [b]étaient[/b] » : les chevaux étaient fatigués ✓
Alors j'écris [b]sont[/b].[/cadre]""",
f"""[titre]Je retiens[/titre]
{tableau(3, ['et', 'et puis', 'Léo et Lou', 'est', 'était', 'Il est content.', 'son', 'mon', 'son vélo', 'sont', 'étaient', 'Ils sont là.'], entete=['Mot', 'Je remplace par', 'Exemple'], size=20, lignes=True)}
[cadre]Si le remplacement marche, j'ai trouvé le bon mot ![/cadre]""",
])

add('ce1', 'masculin_feminin', 'Masculin et féminin des animaux', [
f"""[titre]Le mâle et la femelle[/titre]
Chez les animaux, le [b]mâle[/b] est au masculin (le, un), la [b]femelle[/b] au féminin (la, une).
Souvent, j'ajoute simplement un [b]e[/b] :
{tableau(4, ['le lapin', 'la lapin' + r('e'), 'le renard', 'la renard' + r('e'), "l'ours", "l'ours" + r('e'), 'le faisan', 'la faisan' + r('e'), "l'éléphant", "l'éléphant" + r('e'), ' ', ' '], size=20, paires=True)}""",
f"""[titre]Je double la consonne[/titre]
Avec certaines fins, je [b]double[/b] la dernière consonne avant le e.
{tableau(2, ['le chat', 'la cha' + r('tte'), 'le chien', 'la chie' + r('nne'), 'le lion', 'la lio' + r('nne'), 'le paon', 'la pao' + r('nne'), 'le pigeon', 'la pigeo' + r('nne')], entete=['mâle', 'femelle'], size=22, paires=True)}
[cadre=astuce]-on → -[b]onne[/b], -ien → -[b]ienne[/b].[/cadre]""",
f"""[titre]La fin change[/titre]
{tableau(2, ['le lou' + r('p'), 'la lou' + r('ve'), "l'âne", "l'ân" + r('esse'), 'le tigre', 'la tigr' + r('esse'), 'le chame' + r('au'), 'la chame' + r('lle')], entete=['mâle', 'femelle'], size=22, paires=True)}
[cadre]Le chameau et la chamelle : [b]-eau[/b] devient [b]-elle[/b], comme un beau / une belle.[/cadre]""",
f"""[titre]Des noms différents (1)[/titre]
Pour beaucoup d'animaux de la ferme, la femelle a un [b]autre nom[/b] :
{tableau(4, ['le coq', 'la poule', 'le cheval', 'la jument', 'le taureau', 'la vache', 'le bouc', 'la chèvre', 'le bélier', 'la brebis', 'le cochon', 'la truie', 'le dindon', 'la dinde', 'le canard', 'la cane'], size=20, paires=True)}
[cadre=astuce]Le mâle de la brebis s'appelle le [b]bélier[/b]. Le mot « mouton » sert pour tout le troupeau.[/cadre]""",
f"""[titre]Des noms différents (2)[/titre]
Et pour les animaux sauvages :
{tableau(4, ['le cerf', 'la biche', 'le sanglier', 'la laie', 'le lièvre', 'la hase', 'le singe', 'la guenon', 'le jars', "l'oie", ' ', ' '], size=20, paires=True)}
[cadre]Ces noms ne se devinent pas : il faut les [b]apprendre[/b].[/cadre]""",
"""[titre]Trouver le mâle[/titre]
On me donne la femelle, je cherche le mâle : je fais le chemin [b]à l'envers[/b].
[cadre]la lapin[b]e[/b] → j'enlève le e → le [b]lapin[/b]
la lio[b]nne[/b] → j'enlève -ne → le [b]lion[/b]
la lou[b]ve[/b] → le [b]loup[/b] (pas « louv » !)
la hase → le [b]lièvre[/b] (nom différent)[/cadre]
[cadre=astuce]Je dis « le » devant ma réponse : « le loup » sonne juste ✓[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Souvent, j'ajoute un [b]e[/b] : le renard, la renarde.
• -on, -ien : je double le n → lionne, chienne, pigeonne.
• Parfois, la fin change : loup → louve, âne → ânesse, chameau → chamelle.
• Parfois, le nom change : bélier → brebis, lièvre → hase, jars → oie.
• Pour trouver le mâle, je fais le chemin à l'envers.[/cadre]""",
])

add('ce1', 'orthographe_mots', 'Compter les lettres d\'un mot', [
f"""[titre]Les lettres de l'alphabet[/titre]
L'alphabet a [b]26 lettres[/b]. Il y a les [b]voyelles[/b] et les [b]consonnes[/b].
[center]Les 6 voyelles :[/center]
{rangee(['a', 'e', 'i', 'o', 'u', 'y'], size=28)}
[cadre]Toutes les autres lettres sont des [b]consonnes[/b] : b, c, d, f, g…[/cadre]""",
f"""[titre]Je compte lettre par lettre[/titre]
Je pose mon doigt sous [b]chaque lettre[/b] et je compte.
{lettres('arbre')}
{gros('arbre → 5 lettres')}
[cadre=astuce]Je ne compte pas les sons : je compte les [b]lettres écrites[/b].[/cadre]""",
f"""[titre]Les lettres muettes comptent[/titre]
Certaines lettres ne s'entendent pas, mais elles sont [b]écrites[/b] : je les compte.
{lettres('grotte')}
[cadre]Dans « grotte », on n'entend pas le [b]e[/b] à la fin, mais il est là : [b]6 lettres[/b].[/cadre]""",
f"""[titre]Un son, plusieurs lettres[/titre]
{lettres('rideau')}
[cadre]Dans « rideau », le son [b]o[/b] s'écrit avec [b]3 lettres[/b] : e, a, u.
« rideau » a donc [b]6 lettres[/b], même si on n'entend que 4 sons.[/cadre]""",
f"""[titre]Les lettres doubles[/titre]
Quand une lettre est écrite [b]deux fois[/b], je la compte [b]deux fois[/b].
{lettres('fille')}
[cadre]f-i-l-l-e : le l est doublé. « fille » a [b]5 lettres[/b].
Pareil pour « classe » : c-l-a-s-s-e = [b]6 lettres[/b].[/cadre]""",
f"""[titre]Les accents[/titre]
Une lettre avec un accent compte pour [b]une seule lettre[/b].
{lettres('marché')}
[cadre]Le [b]é[/b] est une seule lettre. Le son « ch » s'écrit avec 2 lettres : c et h.
« marché » a [b]6 lettres[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je pose mon doigt sous [b]chaque lettre[/b] et je compte.
• Les lettres [b]muettes[/b] comptent : grotte = 6.
• Un son peut s'écrire avec plusieurs lettres : eau = 3 lettres.
• Une lettre [b]doublée[/b] compte deux fois : fille = 5.
• Une lettre avec accent compte [b]une fois[/b] : é = 1 lettre.[/cadre]""",
])

# ========================================================================================  CE2
add('ce2', 'accord_adjectif', "L'accord de l'adjectif", [
"""[titre]L'adjectif[/titre]
L'[b]adjectif[/b] dit [b]comment est[/b] le nom : sa couleur, sa taille, son caractère…
[cadre]une prairie [b]verte[/b] · des chats [b]gentils[/b] · une maison [b]grande[/b][/cadre]
L'adjectif s'[b]accorde[/b] avec le nom : il prend son [b]genre[/b] (masculin ou féminin) et son [b]nombre[/b] (singulier ou pluriel).""",
f"""[titre]Les 4 formes de l'adjectif[/titre]
{tableau(3, ['[b]singulier[/b]', 'un chapeau vert', 'une robe vert' + r('e'), '[b]pluriel[/b]', 'des chapeaux vert' + r('s'), 'des robes vert' + r('es')], entete=['', 'masculin', 'féminin'], size=22, lignes=True)}
[cadre]Féminin : j'ajoute [b]e[/b]. Pluriel : j'ajoute [b]s[/b]. Féminin pluriel : j'ajoute [b]es[/b].[/cadre]""",
f"""[titre]Je trouve le nom[/titre]
Pour accorder, je cherche [b]de qui on parle[/b] : je pose la question « [b]qui est… ?[/b] ».
[cadre]Cette maison semble ___ . → Qui semble grande ? [b]la maison[/b]
→ féminin singulier → [b]grande[/b][/cadre]
Les petits mots devant le nom m'aident :
{tableau(3, ['ce, cet, mon', 'cette, ma', 'ces, mes, les, des'], entete=['masc. singulier', 'fém. singulier', 'pluriel'], size=20)}""",
"""[titre]L'adjectif après le verbe[/titre]
L'adjectif peut être [b]loin[/b] du nom, après un verbe : il s'accorde [b]quand même[/b].
[cadre]Ces chapeaux [b]paraissent[/b] neuf[b]s[/b].
Cette robe [b]semble[/b] bleu[b]e[/b].
Ces chaussures [b]sont[/b] neuve[b]s[/b].
On dirait que ces murs sont blanc[b]s[/b].[/cadre]
[cadre=astuce]Après est, sont, semble, paraît, a l'air… je remonte jusqu'au nom ![/cadre]""",
f"""[titre]Les adjectifs déjà en -e, -s, -x[/titre]
Un adjectif qui finit déjà par [b]e[/b] ne change pas au féminin.
{tableau(2, ['un ballon jaune', 'une fleur jaune', 'un enfant calme', 'une biche calme'], entete=['masculin', 'féminin'], size=20, paires=True)}
Un adjectif qui finit par [b]s[/b] ou [b]x[/b] ne change pas au masculin pluriel.
{tableau(2, ['un mur gris', 'des murs gris', 'un chat curieux', 'des chats curieux'], entete=['singulier', 'pluriel'], size=20, paires=True)}""",
f"""[titre]Des féminins spéciaux[/titre]
Certains adjectifs changent davantage au féminin :
{tableau(4, ['neu' + r('f'), 'neu' + r('ve'), 'blanc', 'blanc' + r('he'), 'dou' + r('x'), 'dou' + r('ce'), 'long', 'long' + r('ue'), 'b' + r('eau'), 'b' + r('elle'), 'gentil', 'gentil' + r('le'), 'ancien', 'ancien' + r('ne'), 'curieu' + r('x'), 'curieu' + r('se'), 'lég' + r('er'), 'lég' + r('ère'), 'épais', 'épais' + r('se')], size=19, paires=True)}""",
f"""[titre]Ma méthode en 3 étapes[/titre]
[cadre]1. Je trouve le [b]nom[/b] : « Qui est… ? »
2. Je regarde s'il est [b]masculin ou féminin[/b], [b]singulier ou pluriel[/b].
3. J'écris l'adjectif avec les bonnes lettres : e, s ou es.[/cadre]
{tableau(3, ['Ces chats sont ___.', 'masc. pluriel', 'gentil' + r('s'), 'Cette cantine semble ___.', 'fém. singulier', 'bruyant' + r('e'), 'Ces écharpes sont ___.', 'fém. pluriel', 'neuv' + r('es')], size=19, lignes=True)}""",
"""[titre]Je retiens[/titre]
[cadre]• L'adjectif s'accorde avec le nom qu'il décrit.
• Féminin → [b]e[/b] · pluriel → [b]s[/b] · féminin pluriel → [b]es[/b].
• Même après un verbe (est, semble, paraît), l'adjectif s'accorde.
• Déjà fini par e : pas de e en plus. Fini par s ou x : pas de s en plus.
• Féminins spéciaux : neuve, blanche, douce, longue, belle, gentille…[/cadre]""",
])

add('ce2', 'homophones', 'Les homophones grammaticaux', [
"""[titre]« on » ou « ont » ?[/titre]
[cadre][b]ont[/b] = le verbe [b]avoir[/b] (ils ont). Je peux dire « [b]avaient[/b] ».
Les enfants [b]ont[/b] mangé leur soupe. → avaient mangé ✓[/cadre]
[cadre][b]on[/b] = quelqu'un. Je peux dire « [b]il[/b] ».
[b]On[/b] joue dans la cour. → il joue ✓[/cadre]""",
"""[titre]« ces » ou « ses » ?[/titre]
[cadre][b]ces[/b] sert à [b]montrer[/b] : ces livres-là. Au singulier : « [b]ce[/b] livre ».
Regarde [b]ces[/b] vestes-là. → cette veste-là ✓[/cadre]
[cadre][b]ses[/b] veut dire [b]à lui / à elle[/b]. Au singulier : « [b]son[/b], [b]sa[/b] ».
Il range [b]ses[/b] sacs. → son sac ✓[/cadre]
[cadre=astuce]Attention : [b]c'est[/b] (cela est) et [b]sait[/b] (verbe savoir) se disent pareil aussi ![/cadre]""",
"""[titre]« sa » ou « ça » ?[/titre]
[cadre][b]sa[/b] veut dire [b]à lui / à elle[/b], devant un nom féminin. Je peux dire « [b]ma[/b] ».
Il a perdu [b]sa[/b] clé. → ma clé ✓[/cadre]
[cadre][b]ça[/b] veut dire [b]cela[/b].
[b]Ça[/b] me plaît beaucoup. → cela me plaît ✓[/cadre]""",
"""[titre]« leur » ou « leurs » ?[/titre]
[cadre]Devant un [b]verbe[/b], [b]leur[/b] veut dire « à eux » : il ne prend [b]jamais de s[/b].
Je [b]leur[/b] donne un dessin.[/cadre]
[cadre]Devant un [b]nom[/b], il s'accorde :
[b]leur[/b] vélo (un seul) · [b]leurs[/b] vélos (plusieurs).[/cadre]
[cadre=astuce]Devant un verbe, je peux dire « [b]lui[/b] » : je lui donne ✓ → leur, sans s.[/cadre]""",
f"""[titre]quel, quelle ou qu'elle ?[/titre]
[cadre][b]quel[/b] / [b]quelle[/b] : devant un nom, pour poser une question.
[b]Quel[/b] gâteau ? (masculin) · [b]Quelle[/b] robe ? (féminin)[/cadre]
[cadre][b]qu'elle[/b] = que + elle. Je peux dire « [b]qu'il[/b] ».
J'aimerais [b]qu'elle[/b] chante avec moi. → qu'il chante ✓[/cadre]""",
f"""[titre]Je retiens[/titre]
{tableau(3, ['ont', 'avaient', 'Ils ont faim.', 'on', 'il', 'On part.', 'ces', 'ce / cette', 'ces livres-là', 'ses', 'son / sa', 'ses sacs', 'sa', 'ma', 'sa clé', 'ça', 'cela', 'ça va', 'leur (+ verbe)', 'lui', 'je leur dis', "qu'elle", "qu'il", "qu'elle vienne"], entete=['Mot', 'Je remplace par', 'Exemple'], size=18, lignes=True)}""",
])

add('ce2', 'vocabulaire_sens', 'Synonymes, contraires et sens des mots', [
"""[titre]Rappel[/titre]
[cadre]Les [b]synonymes[/b] veulent dire presque la même chose : finir → terminer.
Les [b]contraires[/b] veulent dire l'inverse : facile → difficile.[/cadre]
[cadre=astuce]Un verbe a pour synonyme ou contraire un [b]verbe[/b] ; un adjectif, un [b]adjectif[/b].
gagner → perdre (verbe) · rapide → lent (adjectif)[/cadre]""",
f"""[titre]Fabriquer un contraire[/titre]
On ajoute un [b]préfixe[/b] devant le mot :
{tableau(2, ['patient', r('im') + 'patient', 'possible', r('im') + 'possible', 'juste', r('in') + 'juste', 'prudent', r('im') + 'prudent', 'honnête', r('mal') + 'honnête', 'poli', r('im') + 'poli'], size=21, paires=True)}
[cadre=astuce]Devant [b]p[/b], [b]b[/b] ou [b]m[/b], « in » devient « [b]im[/b] » : impatient, impoli.[/cadre]""",
f"""[titre]Des contraires à connaître[/titre]
Certains contraires sont des mots [b]tout différents[/b] :
{tableau(4, ['public', 'privé', 'supérieur', 'inférieur', 'majeur', 'mineur', 'précis', 'vague', 'net', 'flou', 'uni', 'rayé', 'généreux', 'égoïste', 'timide', 'audacieux', 'commun', 'rare', 'souriant', 'grognon'], size=19, paires=True)}""",
f"""[titre]Des synonymes plus forts[/titre]
Deux synonymes ne veulent pas toujours dire [b]exactement[/b] pareil : l'un peut être [b]plus fort[/b].
{tableau(3, ['petit', '→', 'minuscule', 'grand', '→', 'immense', 'fatigué', '→', 'épuisé', 'effrayant', '→', 'terrifiant', 'beau', '→', 'magnifique'], entete=['normal', '', 'plus fort'], size=21, lignes=True)}""",
"""[titre]Un mot, plusieurs sens[/titre]
Un même mot peut avoir [b]plusieurs sens[/b]. C'est la phrase qui le dit.
[cadre]un fil [b]fin[/b] (pas épais) → contraire : [b]épais[/b]
la [b]fin[/b] du film → contraire : [b]le début[/b][/cadre]
[cadre]une route [b]droite[/b] (pas tordue) → contraire : [b]tordue[/b]
la main [b]droite[/b] → contraire : [b]gauche[/b][/cadre]
[cadre=astuce]Je mets le mot dans une phrase pour savoir de quel sens on parle.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Synonyme = même sens ; contraire = sens inverse.
• in-, im-, mal-, dé- fabriquent des contraires : impatient, malhonnête.
• Certains synonymes sont plus forts : grand → immense.
• Un mot peut avoir plusieurs sens : je regarde la phrase.
• Pour vérifier, je remplace le mot dans une phrase.[/cadre]""",
])

add('ce2', 'singulier_pluriel', 'Le pluriel des noms', [
f"""[titre]Rappel : j'ajoute un s[/titre]
En général, au pluriel, j'ajoute un [b]s[/b] qui ne s'entend pas.
{tableau(2, ['un ballon', 'des ballon' + r('s'), 'une porte', 'des porte' + r('s')], entete=['singulier', 'pluriel'], size=22, paires=True)}
[cadre]Mais certaines fins de mots prennent un [b]x[/b]. Il faut bien regarder la fin du mot ![/cadre]""",
f"""[titre]-eau et -au → x[/titre]
{tableau(4, ['un bateau', 'des bateau' + r('x'), 'un chapeau', 'des chapeau' + r('x'), 'un ruisseau', 'des ruisseau' + r('x'), 'un tuyau', 'des tuyau' + r('x'), 'un noyau', 'des noyau' + r('x'), 'un préau', 'des préau' + r('x')], size=19, paires=True)}
[cadre=astuce]Une exception : un landau → des landau[b]s[/b].[/cadre]""",
f"""[titre]-eu → x[/titre]
{tableau(4, ['un feu', 'des feu' + r('x'), 'un jeu', 'des jeu' + r('x'), 'un cheveu', 'des cheveu' + r('x'), 'un neveu', 'des neveu' + r('x'), 'un lieu', 'des lieu' + r('x'), 'un vœu', 'des vœu' + r('x')], size=19, paires=True)}
[cadre=astuce]Exceptions : un pneu → des pneu[b]s[/b], bleu → bleu[b]s[/b].[/cadre]""",
f"""[titre]-ou : s, sauf 7 mots[/titre]
Les mots en -ou prennent un [b]s[/b] : un trou → des trou{r('s')}, un clou → des clou{r('s')}.
Sauf [b]7 mots[/b] qui prennent un [b]x[/b] :
{tableau(4, ['bijou' + r('x'), 'caillou' + r('x'), 'chou' + r('x'), 'genou' + r('x'), 'hibou' + r('x'), 'joujou' + r('x'), 'pou' + r('x'), ' '], size=22)}
[cadre]« Viens, mon chou, mon bijou, sur mes genoux, avec tes joujoux, et jette des cailloux à ce hibou plein de poux ! »[/cadre]""",
f"""[titre]-al → -aux[/titre]
{tableau(2, ['un chev' + r('al'), 'des chev' + r('aux'), 'un journ' + r('al'), 'des journ' + r('aux'), 'un anim' + r('al'), 'des anim' + r('aux')], entete=['singulier', 'pluriel'], size=22, paires=True)}
[cadre=astuce]Exceptions : un bal, un carnaval, un festival → des bal[b]s[/b], des carnaval[b]s[/b], des festival[b]s[/b].[/cadre]""",
f"""[titre]Les noms qui ne changent pas[/titre]
Un nom qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] ne change pas au pluriel.
{tableau(2, ['une souris', 'des souris', 'un prix', 'des prix', 'un nez', 'des nez'], entete=['singulier', 'pluriel'], size=22, paires=True)}""",
f"""[titre]Retrouver le singulier[/titre]
Je fais le chemin [b]à l'envers[/b] : j'enlève le s ou le x.
{tableau(2, ['des panneau' + r('x'), 'un panneau', 'des pou' + r('x'), 'un pou', 'des chev' + r('aux'), 'un chev' + r('al')], entete=['pluriel', 'singulier'], size=22, paires=True)}
[cadre=astuce]chevaux → cheval, pas « chevau » ! Je dis « un » devant pour vérifier.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• En général : [b]+ s[/b].
• -eau, -au, -eu → [b]x[/b] (sauf landaus, pneus, bleus).
• -ou → s, sauf les 7 mots en [b]x[/b] : bijou, caillou, chou, genou, hibou, joujou, pou.
• -al → [b]-aux[/b] (sauf bals, carnavals, festivals).
• Déjà fini par s, x, z : [b]pas de changement[/b].[/cadre]""",
])

# ========================================================================================  CM1
add('cm1', 'homophones', 'Les homophones : la, l\'a, là, peu, peut, plutôt…', [
"""[titre]la, l'a ou là ?[/titre]
[cadre][b]la[/b] : petit mot devant un nom féminin. Je peux dire « [b]une[/b] ».
Je ferme [b]la[/b] porte. → une porte ✓[/cadre]
[cadre][b]l'a[/b] = l' + a (verbe avoir). Je peux dire « [b]l'avait[/b] ».
Maya [b]l'a[/b] trouvée hier. → l'avait trouvée ✓[/cadre]
[cadre][b]là[/b] = un lieu. Je peux dire « [b]ici[/b] ».
Pose ton sac [b]là[/b]. → ici ✓[/cadre]""",
"""[titre]Le piège de l'a[/titre]
« [b]l'a[/b] » est presque toujours suivi d'un [b]participe passé[/b] (trouvée, appelée, vue…).
[cadre]Léo [b]l'a[/b] vue au marché. → Léo l'avait vue ✓
Rose [b]l'a[/b] appelée hier soir. → Rose l'avait appelée ✓[/cadre]
[cadre=astuce]Avec « tu », on écrit [b]l'as[/b] : tu [b]l'as[/b] trouvée → tu l'avais trouvée.[/cadre]""",
f"""[titre]peu, peut ou peux ?[/titre]
[cadre][b]peu[/b] = pas beaucoup. Il y a [b]peu[/b] de monde ici.[/cadre]
[cadre][b]peut[/b], [b]peux[/b] = le verbe [b]pouvoir[/b]. Je peux dire « [b]pouvait[/b] ».
Il [b]peut[/b] venir demain. → il pouvait venir ✓[/cadre]
{tableau(6, ['je peux', 'tu peux', 'il peut', 'nous pouvons', 'vous pouvez', 'ils peuvent'], size=18)}""",
"""[titre]plus tôt ou plutôt ?[/titre]
[cadre][b]plus tôt[/b] (en deux mots) = le contraire de [b]plus tard[/b].
Elle est arrivée [b]plus tôt[/b] ce matin. → plus tard ✓[/cadre]
[cadre][b]plutôt[/b] (en un mot) = [b]de préférence[/b].
Elle préfère [b]plutôt[/b] lire que jouer. → de préférence ✓[/cadre]
[cadre=astuce]Si je peux dire « plus tard », c'est [b]plus tôt[/b] en deux mots.[/cadre]""",
f"""[titre]Je retiens[/titre]
{tableau(3, ['la', 'une', 'la porte', "l'a", "l'avait", "il l'a vue", 'là', 'ici', 'pose-le là', 'peu', 'pas beaucoup', 'peu de monde', 'peut, peux', 'pouvait', 'il peut venir', 'plus tôt', 'plus tard', 'arriver plus tôt', 'plutôt', 'de préférence', 'plutôt lire'], entete=['Mot', 'Je remplace par', 'Exemple'], size=18, lignes=True)}""",
])

add('cm1', 'mots_invariables', 'Les mots invariables', [
"""[titre]Un mot qui ne change jamais[/titre]
Un mot [b]invariable[/b] ne change [b]jamais[/b] : ni e au féminin, ni s au pluriel.
[cadre]Le chien dort [b]dehors[/b].
Les chiens dorment [b]dehors[/b].[/cadre]
« chien » et « dort » changent, « [b]dehors[/b] » reste pareil : il est invariable.
[cadre=astuce]Il faut les apprendre par cœur, car on ne peut pas les accorder.[/cadre]""",
f"""[titre]Les adverbes de temps[/titre]
Ils disent [b]quand[/b] :
{tableau(4, ['hier', "aujourd'hui", 'demain', 'maintenant', 'toujours', 'souvent', 'rarement', 'jamais', 'déjà', 'bientôt', 'encore', 'ensuite', 'autrefois', 'jadis', 'désormais', 'soudain'], size=20)}""",
f"""[titre]Les adverbes de lieu[/titre]
Ils disent [b]où[/b] :
{tableau(4, ['ici', 'là-bas', 'dehors', 'dedans', 'partout', 'ailleurs', 'loin', 'près', 'dessus', 'dessous', 'quelque part', 'nulle part'], size=20)}""",
f"""[titre]Les adverbes de manière[/titre]
Ils disent [b]comment[/b]. Beaucoup finissent par [b]-ment[/b], fabriqués à partir du féminin de l'adjectif :
{tableau(3, ['lent', 'lente', 'lente' + r('ment'), 'doux', 'douce', 'douce' + r('ment'), 'soigneux', 'soigneuse', 'soigneuse' + r('ment'), 'rapide', 'rapide', 'rapide' + r('ment')], entete=['adjectif', 'féminin', 'adverbe'], size=19, lignes=True)}""",
f"""[titre]Quantité et intensité[/titre]
Ils disent [b]combien[/b] ou [b]à quel point[/b] :
{tableau(5, ['très', 'trop', 'assez', 'beaucoup', 'peu', 'presque', 'tellement', 'environ', 'davantage', 'seulement'], size=20)}
[cadre]Cette soupe est [b]trop[/b] salée. Le verre est [b]presque[/b] plein.[/cadre]""",
f"""[titre]Les prépositions[/titre]
Elles sont devant un nom pour dire [b]où[/b], [b]avec quoi[/b]… Elles sont invariables aussi.
{tableau(5, ['devant', 'derrière', 'dans', 'sur', 'sous', 'avec', 'sans', 'pour', 'chez', 'vers'], size=20)}
[cadre]Range tes affaires [b]devant[/b] la porte.[/cadre]""",
f"""[titre]Les mots de liaison[/titre]
Ils relient deux idées :
{tableau(2, ['opposition', 'pourtant, cependant, néanmoins', 'conséquence', 'donc, alors, ainsi', 'ordre', "d'abord, puis, ensuite, enfin"], size=19, lignes=True)}
[cadre]Le chemin semblait dangereux ; elle a [b]pourtant[/b] continué.
→ « pourtant » montre que c'est le contraire de ce qu'on attendait.[/cadre]""",
"""[titre]Trouver l'adverbe dans une phrase[/titre]
[cadre]« Il pleut [b]souvent[/b] en automne. »
• « pleut » est un verbe, « automne » un nom.
• « en » est invariable, mais c'est une [b]préposition[/b].
• « souvent » dit [b]quand[/b] : c'est l'[b]adverbe[/b] ✓[/cadre]
[cadre=astuce]Je lis bien la question : elle demande un [b]adverbe[/b] ou une [b]préposition[/b] ?[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Un mot invariable ne prend [b]jamais[/b] de e ni de s.
• Les adverbes disent [b]quand[/b], [b]où[/b], [b]comment[/b], [b]combien[/b].
• Adverbe en -ment = adjectif au féminin + ment : lente → lentement.
• Prépositions : devant, dans, avec, sans, pour…
• Mots de liaison : pourtant, donc, ensuite, enfin…[/cadre]""",
])

add('cm1', 'orthographe_mots', 'Bien écrire les mots', [
f"""[titre]m devant m, b, p[/titre]
Devant [b]m[/b], [b]b[/b] ou [b]p[/b], on écrit [b]m[/b] au lieu de n.
{tableau(3, ['i' + r('m') + 'portant', 'e' + r('m') + 'porter', 'co' + r('m') + 'parer', 'cha' + r('m') + 'bre', 'te' + r('m') + 'pête', 'i' + r('m') + 'mense'], size=22)}
[cadre=astuce]Exceptions : bonbon, bonbonnière, embonpoint.[/cadre]""",
f"""[titre]Les doubles consonnes au début[/titre]
Beaucoup de mots commencent par [b]acc-[/b], [b]app-[/b], [b]att-[/b], [b]arr-[/b], [b]eff-[/b], [b]off-[/b], [b]ill-[/b] :
{tableau(3, [r('acc') + 'rocher', r('acc') + 'ident', r('arr') + 'ondir', r('off') + 'rir', r('ill') + 'ustration', r('att') + 'aquer'], size=22)}
[cadre]Une lettre doublée se voit mais ne s'entend pas : il faut [b]regarder[/b] le mot.[/cadre]""",
f"""[titre]Les doubles consonnes à la fin[/titre]
Les fins en [b]-elle[/b], [b]-ette[/b], [b]-esse[/b], [b]-enne[/b], [b]-onne[/b] ont une consonne doublée :
{tableau(3, ['fic' + r('elle'), 'sauter' + r('elle'), 'moqu' + r('ette'), 'marionn' + r('ette'), 'par' + r('esse'), 'pers' + r('onne')], size=22)}""",
f"""[titre]Le son « s » entre deux voyelles[/titre]
Entre deux voyelles, un seul [b]s[/b] se prononce [b]z[/b] : une vali[b]s[/b]e.
Pour entendre [b]s[/b], j'écris :
{tableau(2, [r('ss'), 'bro' + r('ss') + 'er, de' + r('ss') + 'in', r('c') + ' devant e, i', 'fi' + r('c') + 'elle, méde' + r('c') + 'in', r('ç') + ' devant a, o, u', 'gar' + r('ç') + 'on, re' + r('ç') + 'u', r('t') + ' dans -tion', 'opéra' + r('t') + 'ion'], size=20, lignes=True)}""",
f"""[titre]Les noms en -tion[/titre]
Beaucoup de noms finissent par [b]-tion[/b]. Ils viennent souvent d'un [b]verbe[/b] :
{tableau(2, ['préparer', 'prépara' + r('tion'), 'opérer', 'opéra' + r('tion'), 'participer', 'participa' + r('tion'), 'indiquer', 'indica' + r('tion')], entete=['verbe', 'nom'], size=21, paires=True)}
[cadre=astuce]Mais : permettre → permi[b]ssion[/b].[/cadre]""",
f"""[titre]-eil, -eille, -ail, -aille[/titre]
{tableau(2, ['un sol' + r('eil'), 'une corb' + r('eille'), 'un trav' + r('ail'), 'une méd' + r('aille')], entete=['nom masculin', 'nom féminin'], size=22, paires=True)}
[cadre]Les noms [b]masculins[/b] finissent par -eil / -ail ; les [b]féminins[/b] par -eille / -aille.
Les verbes prennent -ill- : surv[b]eill[/b]er, cons[b]eill[/b]er.[/cadre]""",
f"""[titre]Les verbes en -eler et -eter[/titre]
Au présent, beaucoup de ces verbes [b]doublent[/b] le l ou le t devant un e muet :
{tableau(2, ['appeler', "j'appe" + r('ll') + 'e', 'jeter', 'je je' + r('tt') + 'e', 'épeler', "j'épe" + r('ll') + 'e', 'étiqueter', "j'étique" + r('tt') + 'e'], entete=['infinitif', 'présent'], size=21, paires=True)}
[cadre]Mais : nous appelons, nous jetons (pas de e muet après).[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. Je découpe le mot en [b]syllabes[/b] : a-ven-ture.
2. Je cherche un mot de la [b]même famille[/b] : dent → dentiste.
3. Je regarde les lettres [b]une par une[/b] : pas de lettre en trop, pas de lettre inversée.[/cadre]
[cadre=astuce]Les fautes de frappe se cachent souvent à la [b]fin[/b] du mot : « aventuer » au lieu de « aventure ».[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• m devant m, b, p : important, chambre.
• Doubles consonnes : acc-, att-, off-… et -elle, -ette, -esse, -onne.
• Le son « s » entre deux voyelles : ss, c, ç ou t (-tion).
• -eil / -ail au masculin, -eille / -aille au féminin.
• appeler → j'appelle, jeter → je jette.[/cadre]""",
])

# ========================================================================================  CM2
add('cm2', 'homophones', 'Les homophones : quand, sans, tout…', [
"""[titre]quand, quant ou qu'en ?[/titre]
[cadre][b]quand[/b] = à quel moment. Je peux dire « [b]lorsque[/b] » ou poser une question.
[b]Quand[/b] pars-tu ? Je me demande [b]quand[/b] le train va arriver.[/cadre]
[cadre][b]quant[/b] est toujours suivi de [b]à, au, aux[/b] : [b]quant à[/b] moi = en ce qui me concerne.[/cadre]
[cadre][b]qu'en[/b] = que + en. Il ne s'exprime [b]qu'en[/b] français. → seulement en français ✓[/cadre]""",
"""[titre]sans, s'en, sens ou sang ?[/titre]
[cadre][b]sans[/b] = le contraire de [b]avec[/b]. Elle part [b]sans[/b] dire au revoir.[/cadre]
[cadre][b]s'en[/b] = se + en, devant un [b]verbe[/b]. Je peux dire « [b]je m'en[/b] ».
Elle [b]s'en[/b] souvient. → je m'en souviens ✓[/cadre]
[cadre][b]sens[/b] = la signification, ou le verbe sentir. Cette phrase n'a pas de [b]sens[/b].
[b]sang[/b] = le liquide rouge dans le corps.[/cadre]""",
f"""[titre]tout, tous, toute, toutes[/titre]
Devant un nom, [b]tout[/b] s'accorde comme un adjectif :
{tableau(2, ['tout le monde', 'tout le journal', 'tous les enfants', 'tous les jours', 'toute la classe', 'toute la nuit', 'toutes les filles', 'toutes les fleurs'], size=20, lignes=True)}
[cadre=astuce]Je regarde le nom : masculin ou féminin ? singulier ou pluriel ?[/cadre]""",
"""[titre]« tous » et « toutes » tout seuls[/titre]
Quand il [b]remplace[/b] un nom, « tous » ou « toutes » s'accorde avec ce nom.
[cadre]Les enfants sont [b]tous[/b] arrivés. → tous les enfants
Elles sont [b]toutes[/b] contentes. → toutes les filles[/cadre]
[cadre=astuce]« tous » se prononce souvent « tousse » quand il est tout seul : ils sont tous là.[/cadre]""",
f"""[titre]Je retiens[/titre]
{tableau(3, ['quand', 'lorsque', 'quand pars-tu ?', 'quant à', 'en ce qui concerne', 'quant à moi', "qu'en", 'que + en', "qu'en français", 'sans', '≠ avec', 'sans bruit', "s'en", "je m'en", "elle s'en va", 'sens', 'signification', 'le sens du mot'], entete=['Mot', 'Je pense à', 'Exemple'], size=18, lignes=True)}
[cadre]tout / tous / toute / toutes s'accordent avec le nom.[/cadre]""",
])

add('cm2', 'accents', 'Les accents sur le e', [
f"""[titre]Trois accents sur le e[/titre]
{tableau(3, ['é', 'accent aigu', 'bébé', 'è', 'accent grave', 'père', 'ê', 'accent circonflexe', 'fête'], size=24, lignes=True)}
[cadre]é se prononce le son [b]« é »[/b]. è et ê se prononcent le son [b]« è »[/b].[/cadre]""",
"""[titre]L'accent aigu é[/titre]
Le [b]é[/b] se trouve souvent à la [b]fin d'une syllabe[/b] ou au [b]début du mot[/b].
[cadre]bé-bé · ré-ponse · thé-âtre · sé-vé-ri-té · é-quipe[/cadre]
[cadre=astuce]Je découpe le mot en syllabes : si la syllabe finit par le son « é », c'est souvent [b]é[/b].[/cadre]""",
"""[titre]L'accent grave è[/titre]
Le [b]è[/b] se trouve souvent devant une syllabe qui finit par un [b]e muet[/b], ou devant un [b]s final[/b].
[cadre]pè-re · zè-bre · cuil-lè-re · siè-cle[/cadre]
[cadre]accè[b]s[/b] · aprè[b]s[/b] · trè[b]s[/b] · procè[b]s[/b][/cadre]""",
f"""[titre]L'accent circonflexe ê[/titre]
Le [b]ê[/b] remplace souvent un [b]s[/b] qui a disparu. On le retrouve dans les mots de la même famille !
{tableau(2, ['la f' + r('ê') + 'te', 'un fe' + r('s') + 'tival', 'la for' + r('ê') + 't', 'un fore' + r('s') + 'tier', 'la b' + r('ê') + 'te', 'une be' + r('s') + 'tiole'], size=22, paires=True)}""",
"""[titre]Pas d'accent[/titre]
Le e n'a [b]pas d'accent[/b] quand il est suivi :
[cadre]• de [b]deux consonnes[/b] : pi[b]e[/b]rre, b[b]e[/b]lle, t[b]e[/b]rre
• d'un [b]x[/b] : [b]e[/b]xercice, [b]e[/b]xplorer
• d'une [b]consonne finale[/b] : m[b]e[/b]r, n[b]e[/b]z, ch[b]e[/b]f[/cadre]
[cadre=astuce]Un e muet en fin de mot n'a jamais d'accent : tabl[b]e[/b], pomm[b]e[/b].[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. J'[b]écoute[/b] le son : « é » ou « è » ?
2. Je [b]découpe[/b] le mot en syllabes.
3. Je regarde ce qui [b]suit[/b] le e : deux consonnes ou un x → pas d'accent.
4. Pour ê, je cherche un mot de la [b]même famille[/b] avec un s.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]é[/b] (aigu) : son fermé, souvent en fin de syllabe (bébé).
• [b]è[/b] (grave) : devant une syllabe avec e muet ou devant s final (père, très).
• [b]ê[/b] (circonflexe) : souvent un ancien s (fête → festival).
• [b]Pas d'accent[/b] devant deux consonnes, un x ou une consonne finale.[/cadre]""",
])

add('cm2', 'formation_mots', 'La formation des mots', [
f"""[titre]Radical, préfixe, suffixe[/titre]
Un mot peut être fabriqué à partir d'un autre :
{tableau(3, [r('re'), 'tourn', r('er'), 'pré' + 'fixe', 'radical', 'suffixe'], size=24, lignes=True)}
[cadre]Le [b]radical[/b] est le cœur du mot. Le [b]préfixe[/b] se met [b]devant[/b], le [b]suffixe[/b] [b]derrière[/b].[/cadre]""",
f"""[titre]Les préfixes (1)[/titre]
{tableau(3, ['re-', 'de nouveau, en arrière', 'relire, retourner', 'dé-, dés-', 'le contraire', 'défaire, déboucher', 'in-, im-, il-, ir-', 'le contraire', 'incapable, illisible', 'mé-', 'mal', 'mécontent'], entete=['préfixe', 'sens', 'exemple'], size=19, lignes=True)}
[cadre=astuce]in- devient [b]im-[/b] devant m, b, p, [b]il-[/b] devant l, [b]ir-[/b] devant r : impossible, illisible, irrégulier.[/cadre]""",
f"""[titre]Les préfixes (2)[/titre]
{tableau(3, ['pré-', 'avant', 'prévoir', 'post-', 'après', 'postscolaire', 'sous-', 'en dessous', 'sous-marin', 'sur-', 'au-dessus, trop', 'survoler, surchauffer', 'anti-', 'contre', 'antivol, antigel', 'trans-', 'à travers', 'transporter'], entete=['préfixe', 'sens', 'exemple'], size=19, lignes=True)}""",
f"""[titre]Les préfixes de nombre[/titre]
{tableau(3, ['mono-', 'un seul', 'monocolore', 'bi-', 'deux', 'bicyclette', 'multi-', 'plusieurs', 'multicolore'], entete=['préfixe', 'sens', 'exemple'], size=21, lignes=True)}
[cadre]Une bicyclette a [b]deux[/b] roues. Un objet multicolore a [b]plusieurs[/b] couleurs.[/cadre]""",
f"""[titre]Les suffixes des noms[/titre]
{tableau(4, ['-age', 'nettoyage', '-tion', 'création', '-ment', 'rangement', '-eur', 'voleur, laideur', '-iste', 'dentiste', '-esse', 'gentillesse', '-té, -ité', 'pureté, rapidité', '-isme', 'nationalisme', '-erie', 'boulangerie', '-ette', 'maisonnette', '-oir, -oire', 'arrosoir, baignoire', '-ice', 'justice'], size=18, paires=True)}""",
f"""[titre]Adjectifs et adverbes[/titre]
Des suffixes fabriquent des [b]adjectifs[/b] :
{tableau(4, ['-able', 'aimable', '-eux', 'courageux', '-if', 'sportif', '-al, -el', 'national, naturel'], size=20, paires=True)}
Le suffixe [b]-ment[/b] fabrique des [b]adverbes[/b] : rapide → rapide[b]ment[/b].""",
"""[titre]Ma méthode[/titre]
[cadre]1. Je cherche le mot de [b]base[/b] caché dedans : gentillesse → [b]gentil[/b].
2. Je regarde ce qu'on a ajouté [b]devant[/b] (préfixe) ou [b]derrière[/b] (suffixe).
3. Je pense au [b]sens[/b] : anti + vol = qui protège [b]contre[/b] le vol.[/cadre]
[cadre=astuce]Le suffixe change souvent la nature du mot : laver (verbe) → lavage (nom).[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Préfixe [b]devant[/b] le radical, suffixe [b]derrière[/b].
• Préfixes : re- (de nouveau), dé- / in- (contraire), pré- (avant), anti- (contre), bi- (deux)…
• Suffixes de noms : -age, -tion, -eur, -iste, -esse, -té…
• Suffixes d'adjectifs : -able, -eux, -if. D'adverbes : -ment.[/cadre]""",
])

add('cm2', 'orthographe_mots', 'Bien écrire les mots (2)', [
"""[titre]Rappel[/titre]
[cadre]• [b]m[/b] devant m, b, p : instrument, température.
• Doubles consonnes : addition, attaquer, collection…
• -eil / -ail (masculin), -eille / -aille (féminin).
• Je découpe en syllabes et je regarde les lettres une par une.[/cadre]""",
f"""[titre]-tion, -ssion ou -xion ?[/titre]
{tableau(2, ['-tion (le plus fréquent)', 'destina' + r('tion') + ', organisa' + r('tion'), '-ssion', 'impre' + r('ssion') + ', succe' + r('ssion'), '-xion', 'réfle' + r('xion') + ', conne' + r('xion')], size=20, lignes=True)}
[cadre=astuce]-xion est rare : il suffit de retenir réfle[b]x[/b]ion, conne[b]x[/b]ion, fle[b]x[/b]ion.
Pour -ssion, je pense au mot de la même famille : perme[b]tt[/b]re → permi[b]ss[/b]ion.[/cadre]""",
f"""[titre]Préfixe + même lettre = lettre doublée[/titre]
Quand un préfixe se colle à un mot qui commence par la même lettre, on [b]double[/b] la consonne.
{tableau(2, ['ad + dition', 'a' + r('dd') + 'ition', 'col + laboration', 'co' + r('ll') + 'aboration', 'ap + partenir', 'a' + r('pp') + 'artenir', 'ir + régulier', 'i' + r('rr') + 'égulier'], size=20, paires=True)}""",
"""[titre]Les accents dans les mots[/titre]
[cadre]• Pas d'accent devant une consonne doublée : d[b]e[/b]ntelle, [b]e[/b]ssayer.
• [b]ex-[/b] ne prend jamais d'accent : [b]ex[/b]ploration, [b]ex[/b]traction.
• Au début d'un mot, on entend souvent [b]dé-[/b], [b]ré-[/b], [b]pré-[/b] : découverte, répétition.[/cadre]
[cadre=astuce]Pas d'accent sur a, i, o au milieu d'un mot courant : « magicien », pas « màgicien ».[/cadre]""",
f"""[titre]Les lettres muettes[/titre]
Je cherche un mot de la [b]même famille[/b] pour entendre la lettre muette :
{tableau(2, ['un crapau' + r('d'), 'une crapau' + r('d') + 'ine', 'un tapi' + r('s'), 'tapi' + r('ss') + 'er', 'un bor' + r('d'), 'bor' + r('d') + 'er', 'un lai' + r('t'), 'un lai' + r('t') + 'ier'], size=20, paires=True)}
[cadre][b]ph[/b] se prononce f : photographe, catastrophe.[/cadre]""",
f"""[titre]Les fins de mots[/titre]
{tableau(2, ['-ance, -ence', 'assurance, vigilance, dépendance', '-té (sans e)', 'solidarité, générosité, visibilité', '-oir', 'trottoir, couloir, miroir'], size=19, lignes=True)}
[cadre=astuce]Les noms féminins en [b]-té[/b] ne prennent pas de e, sauf : la dictée, la jetée, la montée, la portée.
Les noms [b]masculins[/b] finissent souvent par [b]-oir[/b] (un trottoir), les [b]féminins[/b] par [b]-oire[/b] (une baignoire, une histoire).[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• -tion est le plus fréquent ; -xion est rare (réflexion, connexion).
• Préfixe + même lettre → consonne doublée : addition, collection.
• Pas d'accent devant une consonne doublée ni dans ex-.
• Lettres muettes : je cherche un mot de la même famille.
• Noms féminins en -té : pas de e (sauf dictée, jetée, montée, portée).[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
SQL = """-- Fiche {titre} ({CL}) - orthographe, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'orthographe', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
TXT = sys.argv[2] if len(sys.argv) > 2 else None
toutes = ['-- Toutes les fiches de cours Orthographe CE1 -> CM2 (2026-10-03), une seule transaction.', 'begin;']
for cl, code, titre, pages in FICHES:
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    sql = SQL.format(CL=cl.upper(), cl=cl, titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
    with open(os.path.join(OUT, f'ortho_{cl}_{code}.sql'), 'w', encoding='utf-8') as f:
        f.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{cl}_{code}.txt'), 'w', encoding='utf-8') as f:
            f.write(contenu)
    print(cl, code, titre, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'ortho_toutes.sql'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(toutes) + '\n')
print(len(FICHES), 'fiches')
