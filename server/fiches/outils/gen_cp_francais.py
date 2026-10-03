# Fiches de cours Francais CP (2026-10-03) : les 5 notions qui ont des questions de francais CP.
# Genere un script SQL par fiche (server/fiches/cp_fr_<code>.sql), un script global
# (server/fiches/cp_francais_toutes.sql) et un .txt par fiche pour la verification du rendu.
# Le contenu suit les reponses des questions en base (feminins, bebes, couleurs, nombres...).
import os
import sys
from logique_lib import rangee, tableau, sans_gras_emoji, couleur_alt

FICHES = []
PAD = 'padding=12,6,12,6'


def add(code, titre, pages):
    FICHES.append(('cp', code, titre, [couleur_alt('cp', p) for p in pages]))


def gros(t, size=30):
    return f'[center][font_size={size}][b]{t}[/b][/font_size][/center]'


def mot(x):           # lettre ajoutee / qui change, en orange
    return f'[b][color=#C62828]{x}[/color][/b]'


SWATCH = {'rouge': '#E53935', 'bleu': '#1E88E5', 'jaune': '#FDD835', 'vert': '#43A047', 'orange': '#FB8C00',
          'violet': '#8E24AA', 'rose': '#F48FB1', 'marron': '#8D5524', 'noir': '#212121', 'blanc': '#FFFFFF',
          'gris': '#9E9E9E'}


def nuancier(lignes):
    """Une ligne par couleur : pastille de couleur | nom | exemples."""
    s = '[table=3]'
    for nom, ex in lignes:
        s += f'[cell bg={SWATCH[nom]} border=#classe padding=22,4,22,4] [/cell]'
        s += f'[cell bg=#classe_clair border=#classe padding=10,4,10,4][b]{nom}[/b][/cell]'
        s += f'[cell bg=#classe_clair border=#classe padding=10,4,10,4]{ex}[/cell]'
    return s + '[/table]'


# =====================================================================  Singulier et pluriel
add('singulier_pluriel', 'Singulier et pluriel', [
f"""[titre]Un seul ou plusieurs ?[/titre]
{tableau(2, ['🐱', '🐱🐱🐱', 'un chat', 'des chat' + mot('s')], entete=['un seul', 'plusieurs'], size=26)}
[cadre]Quand il y en a [b]un seul[/b], le mot est au [b]singulier[/b].
Quand il y en a [b]plusieurs[/b], le mot est au [b]pluriel[/b].[/cadre]""",
f"""[titre]Les petits mots qui aident[/titre]
Le petit mot devant le nom me dit si c'est singulier ou pluriel.
{tableau(2, ['le, la, l\'', 'les', 'un, une', 'des'], entete=['singulier', 'pluriel'], size=24, paires=True)}
[cadre][b]la[/b] porte → une seule porte.
[b]les[/b] portes → plusieurs portes.[/cadre]""",
f"""[titre]La règle : j'ajoute un s[/titre]
Pour mettre un nom au pluriel, le plus souvent, j'ajoute un [b]s[/b] à la fin.
{tableau(2, ['un savon', 'des savon' + mot('s'), 'une porte', 'des porte' + mot('s'), 'une tomate', 'des tomate' + mot('s'), 'un facteur', 'des facteur' + mot('s')], entete=['singulier', 'pluriel'], size=24, paires=True)}
[cadre=astuce]Ce [b]s[/b] ne s'entend pas : « un zèbre », « des zèbres » se disent pareil. Il faut le penser en écrivant ![/cadre]""",
"""[titre]Seulement un s[/titre]
J'écris le mot [b]en entier[/b], puis j'ajoute [b]s[/b]. Rien d'autre.
[cadre]Une porte → des [b]portes[/b] ✓
Pas « porte[b]es[/b] » : je n'ajoute pas de e.
Pas « port[b]s[/b] » : je n'enlève pas de lettre.[/cadre]
[cadre=astuce]Je vérifie : si je cache le s, je dois retrouver le mot du singulier.[/cadre]""",
f"""[titre]Les mots en -eau : un x[/titre]
Les mots qui finissent par [b]-eau[/b] prennent un [b]x[/b] au pluriel.
{tableau(2, ['un bateau', 'des bateau' + mot('x'), 'un gâteau', 'des gâteau' + mot('x'), 'un oiseau', 'des oiseau' + mot('x'), 'un château', 'des château' + mot('x'), 'un seau', 'des seau' + mot('x')], entete=['singulier', 'pluriel'], size=22, paires=True)}
[cadre]Pareil pour les mots en [b]-eu[/b] : un feu → des feu{mot('x')}.[/cadre]""",
f"""[titre]Les mots en -al : -aux[/titre]
Les mots qui finissent par [b]-al[/b] deviennent [b]-aux[/b] au pluriel.
{tableau(2, ['un chev' + mot('al'), 'des chev' + mot('aux'), 'un journ' + mot('al'), 'des journ' + mot('aux')], entete=['singulier', 'pluriel'], size=26, paires=True)}
[cadre]Ici, on [b]entend[/b] la différence : un cheval, des chevaux.[/cadre]""",
f"""[titre]Les mots en -ou[/titre]
La plupart des mots en [b]-ou[/b] prennent un [b]s[/b] : un kangourou → des kangourou{mot('s')}.
Mais [b]7 mots[/b] prennent un [b]x[/b] :
{tableau(4, ['bijou' + mot('x'), 'caillou' + mot('x'), 'chou' + mot('x'), 'genou' + mot('x'), 'hibou' + mot('x'), 'joujou' + mot('x'), 'pou' + mot('x'), ' '], size=22)}
[cadre=astuce]Pour les retenir : « Viens, mon [b]chou[/b], mon [b]bijou[/b], sur mes [b]genoux[/b], avec tes [b]joujoux[/b], et jette des [b]cailloux[/b] à ce [b]hibou[/b] plein de [b]poux[/b] ! »[/cadre]""",
f"""[titre]Les mots qui ne changent pas[/titre]
Un mot qui finit déjà par [b]s[/b], [b]x[/b] ou [b]z[/b] ne change pas au pluriel.
{tableau(2, ['un ananas', 'des ananas', 'un tapis', 'des tapis', 'un ours', 'des ours', 'une noix', 'des noix', 'un nez', 'des nez'], entete=['singulier', 'pluriel'], size=22, paires=True)}
[cadre]C'est le petit mot devant (un / des) qui montre le pluriel.[/cadre]""",
f"""[titre]Du pluriel au singulier[/titre]
Pour retrouver le singulier, je fais le chemin [b]à l'envers[/b] : j'enlève le s.
{tableau(2, ['des balcon' + mot('s'), 'un balcon', 'des abricot' + mot('s'), 'un abricot', 'des bateau' + mot('x'), 'un bateau', 'des chev' + mot('aux'), 'un chev' + mot('al')], entete=['pluriel', 'singulier'], size=22, paires=True)}
[cadre=astuce]Je dis « un » devant le mot : « un balcon » sonne juste, c'est gagné ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Singulier[/b] = un seul. [b]Pluriel[/b] = plusieurs.
• le, la, un, une → singulier. les, des → pluriel.
• En général, j'ajoute un [b]s[/b] (il ne s'entend pas).
• Mots en -eau ou -eu → [b]x[/b]. Mots en -al → [b]-aux[/b].
• 7 mots en -ou prennent un [b]x[/b] : bijou, caillou, chou, genou, hibou, joujou, pou.
• Un mot fini par s, x ou z [b]ne change pas[/b].[/cadre]""",
])

# =====================================================================  Masculin et feminin
add('masculin_feminin', 'Masculin et féminin', [
f"""[titre]Un ou une ?[/titre]
Les noms sont [b]masculins[/b] ou [b]féminins[/b]. Le petit mot devant me le dit.
{tableau(2, ['le, un', 'la, une', 'le garçon', 'la fille', 'un papa', 'une maman'], entete=['masculin', 'féminin'], size=24, paires=True)}
[cadre]Je dis « [b]un[/b] » ou « [b]une[/b] » devant le nom pour savoir.[/cadre]""",
f"""[titre]Le mâle et la femelle[/titre]
Chez les animaux, le [b]mâle[/b] est au masculin, la [b]femelle[/b] au féminin.
{tableau(2, ['🐰 un lapin', 'une lapin' + mot('e'), '🦊 un renard', 'une renard' + mot('e'), '🐻 un ours', 'une ours' + mot('e'), '🐘 un éléphant', 'une éléphant' + mot('e')], entete=['le mâle', 'la femelle'], size=22, paires=True)}
[cadre]Souvent, j'ajoute simplement un [b]e[/b] à la fin.[/cadre]""",
f"""[titre]J'ajoute une lettre en plus[/titre]
Parfois, la dernière lettre est [b]doublée[/b] avant le e.
{tableau(2, ['🐱 un chat', 'une chat' + mot('te'), '🐶 un chien', 'une chien' + mot('ne'), '🦁 un lion', 'une lion' + mot('ne')], entete=['le mâle', 'la femelle'], size=22, paires=True)}
D'autres fois, la fin change davantage :
{tableau(2, ['🐺 un lou' + mot('p'), 'une lou' + mot('ve'), '🐯 un tigre', 'une tigr' + mot('esse'), '🫏 un âne', 'une ân' + mot('esse')], size=22, paires=True)}""",
f"""[titre]Des noms tout différents[/titre]
Pour certains animaux, la femelle a un [b]autre nom[/b]. Il faut les apprendre.
{tableau(4, ['🐓 le coq', 'la poule', '🐑 le mouton', 'la brebis', '🐴 le cheval', 'la jument', '🦌 le cerf', 'la biche', '🐂 le taureau', 'la vache', '🐐 le bouc', 'la chèvre', '🐷 le cochon', 'la truie', '🐒 le singe', 'la guenon'], size=19, paires=True)}""",
f"""[titre]D'autres noms à connaître[/titre]
{tableau(4, ['🐗 le sanglier', 'la laie', '🪿 le jars', "l'oie", '🐮 le bœuf', 'la vache', '🦆 le canard', 'la cane', '🦃 le dindon', 'la dinde', '🦚 le paon', 'la paonne'], size=19, paires=True)}
[cadre=astuce]Attention : la vache est la femelle du [b]taureau[/b] et du [b]bœuf[/b].
La femelle du canard est la [b]cane[/b] : un seul n.[/cadre]""",
f"""[titre]Les personnes aussi[/titre]
{tableau(2, ['un prince', 'une princ' + mot('esse'), 'un ami', 'une ami' + mot('e'), 'un roi', 'une reine'], entete=['masculin', 'féminin'], size=24, paires=True)}
[cadre]Les mêmes règles marchent : j'ajoute un e, ou la fin change, ou le mot change complètement.[/cadre]""",
"""[titre]Du féminin au masculin[/titre]
On me donne la femelle, je cherche le mâle : je fais le chemin [b]à l'envers[/b].
[cadre]une lapin[b]e[/b] → j'enlève le e → un [b]lapin[/b]
une lou[b]ve[/b] → un [b]loup[/b]
une brebis → un [b]mouton[/b] (nom différent)[/cadre]
[cadre=astuce]Je dis « [b]un[/b] » devant ma réponse pour vérifier qu'elle sonne juste.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• le, un → [b]masculin[/b]. la, une → [b]féminin[/b].
• Souvent, j'ajoute un [b]e[/b] : un renard, une renarde.
• Parfois, la lettre est doublée : chat → chatte, chien → chienne.
• Parfois, la fin change : loup → louve, tigre → tigresse.
• Parfois, le nom change : coq → poule, cheval → jument.[/cadre]""",
])

# =====================================================================  Synonymes, contraires
add('vocabulaire_sens', 'Synonymes et contraires', [
f"""[titre]Les contraires[/titre]
Le [b]contraire[/b], c'est le mot qui veut dire [b]tout l'inverse[/b].
{tableau(4, ['loin', 'près', 'plein', 'vide', 'chaud', 'froid', 'ami', 'ennemi', 'jour', 'nuit', 'gagner', 'perdre', 'rire', 'pleurer', 'commencer', 'finir'], size=22, paires=True)}
[cadre]Le contraire de [b]loin[/b], c'est [b]près[/b]. Et le contraire de près, c'est loin ![/cadre]""",
f"""[titre]Un petit morceau devant[/titre]
On fabrique souvent un contraire en ajoutant [b]in-[/b], [b]im-[/b] ou [b]dé-[/b] devant le mot.
{tableau(2, ['visible', mot('in') + 'visible', 'juste', mot('in') + 'juste', 'possible', mot('im') + 'possible', 'visser', mot('dé') + 'visser', 'faire', mot('dé') + 'faire'], size=22, paires=True)}
[cadre]« invisible » veut dire « [b]pas[/b] visible ».[/cadre]""",
"""[titre]Trouver le contraire[/titre]
Je me fais un [b]petit film dans la tête[/b].
[cadre]Je [b]sème[/b] des graines… elles poussent… je [b]récolte[/b] les légumes !
Le contraire de semer, c'est [b]récolter[/b].[/cadre]
[cadre=astuce]Attention aux pièges : le contraire de [b]creux[/b] n'est pas « vide » (ça veut presque dire pareil), c'est [b]plein[/b].[/cadre]""",
f"""[titre]Les synonymes[/titre]
Les [b]synonymes[/b] sont des mots qui veulent dire [b]presque la même chose[/b].
{tableau(4, ['content', 'heureux', 'beau', 'joli', 'chaud', 'brûlant', 'dire', 'raconter', 'chercher', 'rechercher', 'imaginer', 'supposer'], size=22, paires=True)}""",
"""[titre]Le truc de la phrase[/titre]
Je mets le mot dans une phrase, puis je le [b]remplace[/b].
[cadre]« Je suis [b]content[/b]. » → « Je suis [b]heureux[/b]. »
La phrase veut dire la même chose : ce sont des [b]synonymes[/b] ✓[/cadre]
[cadre]« Je suis [b]content[/b]. » → « Je suis [b]triste[/b]. »
Ça veut dire l'inverse : c'est un [b]contraire[/b], pas un synonyme ✗[/cadre]""",
"""[titre]Synonyme ou contraire ?[/titre]
Je lis bien la question avant de répondre.
[cadre][b]Synonyme[/b] → je cherche un mot qui veut dire [b]pareil[/b].
[b]Contraire[/b] → je cherche un mot qui veut dire [b]l'inverse[/b].[/cadre]
[cadre=astuce]Souvent, le contraire se cache dans les réponses d'une question « synonyme » (et l'inverse) : c'est un piège ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Contraire[/b] = le sens inverse : loin → près.
• in-, im-, dé- fabriquent des contraires : visible → invisible.
• [b]Synonyme[/b] = presque le même sens : content → heureux.
• Pour vérifier, je remplace le mot dans une phrase.[/cadre]""",
])

# =====================================================================  Vocabulaire du quotidien
add('vocabulaire_quotidien', 'Vocabulaire du quotidien', [
f"""[titre]Les couleurs (1)[/titre]
{nuancier([('rouge', 'fraise, cerise, tomate'), ('jaune', 'banane, citron, poussin'), ('vert', 'herbe, sapin, brocoli'), ('bleu', 'ciel, mer, myrtille'), ('orange', 'carotte, citrouille')])}""",
f"""[titre]Les couleurs (2)[/titre]
{nuancier([('violet', 'aubergine, prune'), ('rose', 'flamant rose'), ('marron', 'chocolat, café'), ('gris', 'éléphant, fumée'), ('noir', 'charbon, corbeau'), ('blanc', 'neige, lait, nuage')])}
[cadre]Le zèbre, le panda et le pingouin sont [b]noir et blanc[/b].[/cadre]""",
f"""[titre]Les jours de la semaine[/titre]
Une semaine a [b]7 jours[/b], toujours dans le même ordre :
{tableau(4, ['1. lundi', '2. mardi', '3. mercredi', '4. jeudi', '5. vendredi', '6. samedi', '7. dimanche', ' '], size=22, lignes=True)}
[cadre]Le [b]premier[/b] jour est [b]lundi[/b]. Le [b]dernier[/b] est [b]dimanche[/b].
Après dimanche, une nouvelle semaine recommence : [b]lundi[/b].[/cadre]""",
f"""[titre]Avant, après[/titre]
{rangee(['mardi', '!mercredi', 'jeudi'], size=24)}
[cadre]Juste [b]avant[/b] mercredi, c'est [b]mardi[/b].
Juste [b]après[/b] mercredi, c'est [b]jeudi[/b].[/cadre]
[cadre=astuce]Je récite les jours depuis lundi, et je m'arrête au bon jour. Avant = à gauche, après = à droite.[/cadre]""",
f"""[titre]Les 12 mois de l'année[/titre]
{tableau(4, ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'], size=20, lignes=True)}
[cadre]Une année a [b]12 mois[/b]. Elle commence en [b]janvier[/b] et finit en [b]décembre[/b].
Après décembre, on recommence : [b]janvier[/b].[/cadre]""",
f"""[titre]Les bébés des animaux (1)[/titre]
{tableau(4, ['🐱 le chat', 'le chaton', '🐶 le chien', 'le chiot', '🐮 la vache', 'le veau', '🐴 le cheval', 'le poulain', '🐑 le mouton', "l'agneau", '🐐 la chèvre', 'le chevreau', '🐔 la poule', 'le poussin', '🐸 la grenouille', 'le têtard'], size=19, paires=True)}""",
f"""[titre]Les bébés des animaux (2)[/titre]
{tableau(4, ['🦁 le lion', 'le lionceau', '🐻 l\'ours', "l'ourson", '🐰 le lapin', 'le lapereau', '🦊 le renard', 'le renardeau', '🐺 le loup', 'le louveteau', '🐭 la souris', 'le souriceau', '🦆 le canard', 'le caneton', '🐦 l\'oiseau', "l'oisillon"], size=19, paires=True)}
[cadre=astuce]On entend souvent le nom de l'animal : [b]renard[/b] → [b]renard[/b]eau, [b]éléphant[/b] → [b]éléphant[/b]eau, [b]pigeon[/b] → [b]pigeon[/b]neau, [b]cygne[/b] → [b]cygne[/b]au, [b]oie[/b] → [b]oi[/b]son.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je sais nommer les [b]couleurs[/b] des choses que je vois tous les jours.
• 7 jours : lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche.
• 12 mois : de [b]janvier[/b] à [b]décembre[/b].
• Chaque animal a son [b]bébé[/b] : le chat → le chaton, le lion → le lionceau.[/cadre]""",
])

# =====================================================================  Nombres en lettres
UNITES = ['zéro', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf', 'dix',
          'onze', 'douze', 'treize', 'quatorze', 'quinze', 'seize']
DIZ = {20: 'vingt', 30: 'trente', 40: 'quarante', 50: 'cinquante', 60: 'soixante', 80: 'quatre-vingt'}


def en_lettres(n):
    """Orthographe 1990 (traits d'union partout), comme les questions en base."""
    if n <= 16:
        return UNITES[n]
    if n < 20:
        return 'dix-' + UNITES[n - 10]
    if n == 100:
        return 'cent'
    if n == 80:
        return 'quatre-vingts'
    d, u = n // 10 * 10, n % 10
    if d in (70, 90):
        d, u = d - 10, u + 10
    base = DIZ[d]
    if u == 0:
        return base
    if u in (1, 11) and d != 80:
        return f'{base}-et-{UNITES[u]}'
    return f'{base}-{en_lettres(u)}'


# controle : les reponses des questions en base
for n, w in [(21, 'vingt-et-un'), (51, 'cinquante-et-un'), (61, 'soixante-et-un'), (70, 'soixante-dix'),
             (72, 'soixante-douze'), (75, 'soixante-quinze'), (80, 'quatre-vingts'), (81, 'quatre-vingt-un'),
             (90, 'quatre-vingt-dix'), (91, 'quatre-vingt-onze'), (93, 'quatre-vingt-treize'), (17, 'dix-sept'),
             (63, 'soixante-trois'), (71, 'soixante-et-onze'), (100, 'cent')]:
    assert en_lettres(n) == w, (n, en_lettres(n), w)


def liste_nombres(ns, cols=2, size=21):
    cells = []
    for n in ns:
        cells += [f'[b]{n}[/b]', en_lettres(n)]
    return tableau(cols * 2, cells, size=size, paires=True)


add('nombres_en_lettres', 'Écrire les nombres en lettres', [
f"""[titre]De zéro à dix[/titre]
Chaque nombre a un [b]nom[/b] qu'on peut écrire en lettres.
{liste_nombres(range(0, 11), cols=3, size=21)}
[cadre=astuce]Attention : [b]cinq[/b] finit par q, [b]sept[/b] a un p qui ne s'entend pas.[/cadre]""",
f"""[titre]De onze à seize[/titre]
Ces nombres ont un nom [b]à eux[/b]. Il faut les apprendre par cœur.
{liste_nombres(range(11, 17), cols=2, size=22)}
[cadre]On ne dit pas « dix-un », mais [b]onze[/b] !
On ne dit pas « dix-cinq », mais [b]quinze[/b] ![/cadre]""",
f"""[titre]Dix-sept, dix-huit, dix-neuf[/titre]
À partir de 17, on dit [b]dix[/b], puis le chiffre des unités.
{liste_nombres(range(17, 20), cols=1, size=24)}
[cadre]dix-sept = [b]10 + 7[/b]. Entre les deux mots, je mets un [b]trait d'union[/b] (-).[/cadre]""",
f"""[titre]Les dizaines[/titre]
{liste_nombres([10, 20, 30, 40, 50, 60], cols=2, size=22)}
[cadre=astuce][b]vingt[/b] s'écrit avec un g et un t qu'on n'entend pas : v-i-n-g-t.[/cadre]""",
f"""[titre]Fabriquer un nombre[/titre]
Pour 26, je dis la [b]dizaine[/b], puis l'[b]unité[/b] : 20 et 6.
[cubes d=2 u=6]
{gros('26 → vingt' + mot('-') + 'six')}
[cadre]Entre les mots d'un nombre, je mets des [b]traits d'union[/b] : trente-quatre, cinquante-deux.[/cadre]""",
f"""[titre]Le « et un »[/titre]
Avec un [b]1[/b] aux unités, on ajoute [b]et[/b] :
{liste_nombres([21, 31, 41, 51, 61], cols=1, size=22)}
[cadre]On ne dit pas « vingt-un », mais [b]vingt-et-un[/b].
Les traits d'union vont partout : vingt[b]-[/b]et[b]-[/b]un.[/cadre]""",
f"""[titre]De 70 à 79[/titre]
70, c'est [b]60 + 10[/b] : on dit [b]soixante-dix[/b].
Puis on continue avec onze, douze, treize…
{liste_nombres([70, 71, 72, 75, 79], cols=1, size=22)}
[cadre]soixante-quinze = [b]60 + 15[/b] = 75.[/cadre]""",
f"""[titre]De 80 à 100[/titre]
80, c'est [b]4 fois 20[/b] : on dit [b]quatre-vingts[/b].
{liste_nombres([80, 81, 85, 90, 91, 95], cols=2, size=20)}
[cadre=astuce][b]quatre-vingts[/b] prend un s, mais pas quatre-vingt-un.
81 : pas de « et » → quatre-vingt-un. Et 100 s'écrit [b]cent[/b].[/cadre]""",
f"""[titre]Lire un nombre écrit en lettres[/titre]
Je découpe le nombre en morceaux, puis j'additionne.
{tableau(3, ['vingt-neuf', '20 + 9', '[b]29[/b]', 'soixante-quinze', '60 + 15', '[b]75[/b]', 'quatre-vingt-onze', '80 + 11', '[b]91[/b]'], size=21, lignes=True)}
[cadre=astuce]quatre-vingt-onze : « quatre-vingt » = 80 et « onze » = 11. 80 + 11 = [b]91[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• 11 à 16 ont un nom à eux : onze, douze, treize, quatorze, quinze, seize.
• 17, 18, 19 : dix-sept, dix-huit, dix-neuf.
• Dizaine + unité avec un [b]trait d'union[/b] : vingt-six.
• Avec 1 : vingt-[b]et[/b]-un (mais quatre-vingt-un).
• 70 = soixante-dix, 80 = quatre-vingt[b]s[/b], 90 = quatre-vingt-dix.[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
SQL = """-- Fiche {titre} (CP) - francais, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'cp', 'french', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
TXT = sys.argv[2] if len(sys.argv) > 2 else None
toutes = ['-- Toutes les fiches de cours Francais CP (2026-10-03), une seule transaction.', 'begin;']
for cl, code, titre, pages in FICHES:
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    sql = SQL.format(titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
    with open(os.path.join(OUT, f'cp_fr_{code}.sql'), 'w', encoding='utf-8') as f:
        f.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{code}.txt'), 'w', encoding='utf-8') as f:
            f.write(contenu)
    print(code, titre, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'cp_francais_toutes.sql'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(toutes) + '\n')
print(len(FICHES), 'fiches')
