# Fiches de cours Maths CM1 (2026-10-03). Genere un script SQL par fiche + un script global.
# Les calculs des operations posees sont verifies par des assert.
import sys
from lib import grid, grid2, RED
from cm_lib import *

CL = 'cm1'
FICHES = []


def add(code, titre, pages):
    FICHES.append((code, titre, pages))


DU2 = cols(2, 2)   # D U , 1/10 1/100

# ---------------------------------------------------------------- 1. Addition
assert round(11.68 + 4.11, 2) == 15.79 and round(8.25 + 15.80, 2) == 24.05 and round(9.6 + 3.71, 2) == 13.31
assert round(19.57 + 23.75, 2) == 43.32 and round(3.46 + 0.1, 2) == 3.56 and round(2.75 + 0.25, 2) == 3
add('addition', "L'addition", [
f"""[titre]Les nombres décimaux[/titre]
Un nombre décimal a une [b]partie entière[/b] et une [b]partie décimale[/b], séparées par [b]la virgule[/b].
{dec_op(DU2, [('', '12,75')])}
[cadre]Dans [b]12,75[/b] : 12 unités, [b]7 dixièmes[/b] et [b]5 centièmes[/b].
La virgule se place toujours [b]juste après le chiffre des unités[/b].[/cadre]""",
f"""[titre]Dixièmes et centièmes[/titre]
Je coupe une unité en [b]10 parts égales[/b] : chaque part est [b]un dixième[/b] (0,1).
[cases n=10 bleu=7]
[cadre]7 parts sur 10 : [b]7 dixièmes = 0,7[/b]. Et 10 dixièmes font 1 unité.
Si je coupe un dixième en 10, j'obtiens [b]un centième[/b] (0,01).[/cadre]
[cadre=astuce]Pense à l'argent : 1 euro = 100 centimes. 0,75 euro = [b]75 centimes[/b].[/cadre]""",
f"""[titre]Poser une addition[/titre]
Je place [b]la virgule sous la virgule[/b] : les unités sont alors sous les unités, les dixièmes sous les dixièmes…
{dec_op(DU2, [('', '11,68'), ('+', '4,11')], '15,79')}
[cadre]Je calcule comme avec des nombres entiers, en commençant [b]par la droite[/b].
Puis je recopie la virgule [b]au même endroit[/b] dans le résultat : [b]15,79[/b].[/cadre]""",
f"""[titre]La retenue saute la virgule[/titre]
{dec_op(DU2, [('', '8,25'), ('+', '15,80')], '24,05', top=['1', '1', '', '', ''])}
Centièmes : 5 + 0 = 5. Dixièmes : 2 + 8 = [b]10[/b] : j'écris 0 et je retiens 1 [b]dans les unités[/b].
Unités : 1 + 8 + 5 = 14 : j'écris 4, je retiens 1. Dizaines : 1 + 1 = 2.
[cadre]10 dixièmes font 1 unité : la retenue passe par-dessus la virgule. [b]8,25 + 15,80 = 24,05[/b][/cadre]""",
f"""[titre]Pas le même nombre de chiffres[/titre]
Pour [b]9,6 + 3,71[/b] : 9,6 n'a pas de centièmes. J'ajoute [b]un 0[/b] pour bien aligner.
{dec_op(DU2, [('', ['', '9', ',', '6', '!' + bclr('0')]), ('+', '3,71')], '13,31', top=['1', '1', '', '', ''])}
[cadre]9,6 = [b]9,60[/b] : 6 dixièmes, c'est 60 centièmes. Le 0 ne change pas le nombre.
Un nombre entier aussi : 7 = [b]7,00[/b].[/cadre]""",
"""[titre]Calculer de tête[/titre]
[cadre]• Ajouter [b]0,1[/b], c'est ajouter 1 dixième : 3,46 + 0,1 = [b]3,56[/b].
• Ajouter [b]0,01[/b], c'est ajouter 1 centième : 3,46 + 0,01 = [b]3,47[/b].
• 4,5 + 0,5 = [b]5[/b] : 5 dixièmes + 5 dixièmes = 1 unité.
• 2,75 + 0,25 = [b]3[/b] : 75 centièmes + 25 centièmes = 1 unité.[/cadre]
[cadre=astuce]Cherche les nombres qui « font 1 » ensemble, comme 0,75 et 0,25 (75 + 25 = 100).[/cadre]""",
"""[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]19,57 + 23,75[/b], j'arrondis à l'unité : [b]20 + 24 = 44[/b].
[cadre]Je trouve 43,32 : c'est tout près de 44, mon résultat est possible.
Si je trouve 4,332 ou 433,2, je sais que [b]ma virgule est mal placée[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• 12,75 : partie entière 12, puis 7 [b]dixièmes[/b] et 5 [b]centièmes[/b].
• 10 centièmes = 1 dixième. 10 dixièmes = 1 unité.
• Pour poser : [b]virgule sous virgule[/b]. Je complète avec des 0 : 9,6 = 9,60.
• Je calcule de droite à gauche ; la retenue peut passer la virgule.
• Je replace la virgule dans le résultat, puis je vérifie avec un ordre de grandeur.[/cadre]""",
])

# ---------------------------------------------------------------- 2. Soustraction
assert round(17.87 - 14.77, 2) == 3.10 and round(15.28 - 8.94, 2) == 6.34 and round(10 - 3.46, 2) == 6.54
assert round(3.46 + 0.54, 2) == 4 and round(6.54 + 3.46, 2) == 10
add('soustraction', 'La soustraction', [
f"""[titre]Soustraire des décimaux[/titre]
Comme pour l'addition : [b]virgule sous virgule[/b], et je commence par la droite.
{dec_op(DU2, [('', '17,87'), ('-', '14,77')], ['', '3', ',', '1', '0'])}
[cadre]17,87 - 14,77 = [b]3,10[/b]. Le 0 à la fin ne sert à rien : 3,10 = [b]3,1[/b].[/cadre]""",
f"""[titre]Pas assez dans une colonne ?[/titre]
Pour [b]15,28 - 8,94[/b] : dixièmes, 2 - 9, impossible ! Puis unités, 5 - 8, impossible aussi.
Tu connais [b]deux méthodes[/b], elles marchent aussi avec la virgule :
{grid2(2, [('[center][b]Le cassage[/b][/center]', 'classe'), ('[center][b]La compensation[/b][/center]', 'unites'), ("je casse 1 unité en 10 dixièmes", '+classe'), ("10 dixièmes en haut, 1 unité en bas", '+unites')])}
[cadre]Garde [b]la méthode de ta classe[/b] : les deux donnent le même résultat.[/cadre]""",
f"""[titre]Méthode 1 : le cassage[/titre]
{dec_op(DU2, [('', ['~1', '~5', ',', '~2', '8']), ('-', '8,94')], '6,34', top=['0', '14', '', '12', ''])}
Centièmes : 8 - 4 = 4. Dixièmes : je casse 1 unité, 2 devient [b]12[/b] : 12 - 9 = 3.
Unités : il reste 4, je casse 1 dizaine, 4 devient [b]14[/b] : 14 - 8 = 6. Dizaines : 0.
[cadre][b]15,28 - 8,94 = 6,34[/b][/cadre]""",
f"""[titre]Méthode 2 : la compensation[/titre]
{dec_op(DU2, [('', ['1', '!' + comp_top(1) + '5', ',', '!' + comp_top(1) + '2', '8']), ('-', ['!' + comp_top('+1'), '!8' + comp_top('+1'), ',', '9', '4'])], '6,34')}
Centièmes : 8 - 4 = 4. Dixièmes : 10 dixièmes en haut (12) et 1 unité en bas (8 + 1 = 9) : 12 - 9 = 3.
Unités : 10 unités en haut (15) et 1 dizaine en bas : 15 - 9 = 6. Dizaines : 1 - 1 = 0.
[cadre]Même résultat : [b]6,34[/b].[/cadre]""",
f"""[titre]Soustraire d'un nombre rond[/titre]
Pour [b]10 - 3,46[/b], je peux poser 10,00 - 3,46. Ou j'avance [b]par bonds[/b] de 3,46 jusqu'à 10 :
{grid2(3, [('[center]3,46 → 4[/center]', 'classe'), ('[center]4 → 10[/center]', 'unites'), ('[center][b]En tout[/b][/center]', 'centaines'), ('[center][b]+ 0,54[/b][/center]', '+classe'), ('[center][b]+ 6[/b][/center]', '+unites'), ('[center][b]6 + 0,54 = 6,54[/b][/center]', '+centaines')])}
[cadre][b]10 - 3,46 = 6,54[/b]. Pour aller à 4, il manque 54 centièmes : 46 + 54 = 100.[/cadre]""",
f"""[titre]Vérifier avec une addition[/titre]
J'ajoute ce que j'ai enlevé : je dois retrouver le nombre du départ.
{dec_op(DU2, [('', '6,54'), ('+', '3,46')], '10,00', top=['1', '1', '', '1', ''])}
[cadre]6,54 + 3,46 = 10 : ma soustraction est juste.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• [b]Virgule sous virgule[/b], et je complète avec des 0 : 10 = 10,00.
• Je commence par la droite. Pas assez ? Cassage ou compensation : [b]la méthode de ma classe[/b].
• 3,10 = 3,1 : un 0 tout à la fin de la partie décimale ne change rien.
• Pour un nombre rond, j'avance par bonds : 3,46 → 4 → 10.
• Je vérifie avec une addition.[/cadre]""",
])

# ---------------------------------------------------------------- 3. Multiplication
assert 73 * 10 == 730 and 73 * 100 == 7300 and 73 * 1000 == 73000 and 79 * 20 == 1580 and 79 * 2 == 158
assert 18 * 11 == 198 and 19 * 9 == 171 and 73 * 4 == 292 and 49 * 13 == 637 and 49 * 3 == 147 and 85 * 18 == 1530
add('multiplication', 'La multiplication', [
f"""[titre]Multiplier par 10, 100, 1000[/titre]
{grid2(2, [Cc('[b]73 x 10 = 730[/b]', 'classe'), Cc("j'écris [b]un 0[/b] à droite"), Cc('[b]73 x 100 = 7300[/b]', 'classe'), Cc("j'écris [b]deux 0[/b]"), Cc('[b]73 x 1000 = 73000[/b]', 'classe'), Cc("j'écris [b]trois 0[/b]")])}
[cadre]Fois 10, chaque chiffre prend une valeur [b]10 fois plus grande[/b] : les 3 unités deviennent 3 dizaines.[/cadre]""",
"""[titre]Multiplier par 20, 30, 200…[/titre]
20, c'est 2 x 10. Pour multiplier par 20, je multiplie [b]par 2, puis par 10[/b].
[center][font_size=26][b]79 x 20 = 79 x 2 x 10[/b][/font_size][/center]
[cadre]79 x 2 = 158, puis 158 x 10 = [b]1580[/b].[/cadre]
[cadre=astuce]Pareil pour 300 : 12 x 300 = 12 x 3 x 100 = 36 x 100 = [b]3600[/b].[/cadre]""",
"""[titre]Décomposer pour calculer de tête[/titre]
[cadre]• [b]18 x 11[/b] = 18 x 10 + 18 x 1 = 180 + 18 = [b]198[/b]
• [b]19 x 9[/b] = 19 x 10 - 19 = 190 - 19 = [b]171[/b]
• [b]22 x 6[/b] = 20 x 6 + 2 x 6 = 120 + 12 = [b]132[/b][/cadre]
[cadre=astuce]Je coupe un nombre en morceaux faciles, je multiplie chaque morceau, puis j'ajoute.[/cadre]""",
f"""[titre]Poser une multiplication[/titre]
Je multiplie chaque chiffre du haut par 4, [b]en commençant par les unités[/b].
{entier_op(list('cdu'), [('', 73), ('x', 4)], 292, top=['', '1', ''])}
Unités : 3 x 4 = [b]12[/b], j'écris 2 et je retiens 1.
[cadre]Dizaines : 7 x 4 = 28, plus la retenue : 28 + 1 = [b]29[/b]. 73 x 4 = [b]292[/b].[/cadre]""",
f"""[titre]Multiplier par un nombre à 2 chiffres[/titre]
Pour [b]49 x 13[/b] : 13 = 3 + 10. Je fais [b]deux lignes[/b], puis je les additionne.
{entier_op(list('cdu'), [('', 49), ('x', 13), ('', 147), ('+', ['4', '9', '!' + bclr('0')])], 637)}
[cadre]1re ligne : 49 x 3 = [b]147[/b]. 2e ligne : 49 x 10 = [b]490[/b] (je commence par écrire le [color=#C62828]0[/color]).
147 + 490 = [b]637[/b].[/cadre]""",
"""[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]85 x 18[/b], j'arrondis : 90 x 20 = [b]1800[/b].
[cadre]Je trouve 1530 : c'est le même ordre de grandeur, mon résultat est possible.
Si je trouve 765, j'ai sûrement oublié le 0 de la 2e ligne ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Fois 10, 100, 1000 : j'écris un, deux ou trois 0 à droite.
• Fois 20 : fois 2, puis fois 10.
• Je décompose : 18 x 11 = 180 + 18. 19 x 9 = 190 - 19.
• Pour poser, je commence par les unités et je n'oublie pas [b]les retenues[/b].
• Par un nombre à 2 chiffres : 2 lignes, la 2e commence par un 0, puis j'additionne.
• Je vérifie avec un ordre de grandeur.[/cadre]""",
])

# ---------------------------------------------------------------- 4. Division
assert divmod(14, 3) == (4, 2) and divmod(80, 9) == (8, 8) and divmod(293, 6) == (48, 5) and divmod(416, 3) == (138, 2)
assert divmod(125, 6) == (20, 5) and 3 * 138 + 2 == 416
add('division', 'La division', [
"""[titre]Quand le partage ne tombe pas juste[/titre]
Je partage [b]14 billes[/b] entre [b]3 enfants[/b] : chacun en a 4, et il en reste 2.
[billes groupes=4,4,4,2 couleurs=bleu,rouge,vert,jaune signes=non]
[cadre]14 divisé par 3 : le [b]quotient[/b] est 4 (la part de chacun), le [b]reste[/b] est 2.[/cadre]""",
f"""[titre]Les mots de la division[/titre]
{grid2(4, [Cc('[b]dividende[/b]', 'classe'), Cc('[b]diviseur[/b]', 'classe'), Cc('[b]quotient[/b]', 'classe'), Cc('[b]reste[/b]', 'unites'), Cc('14'), Cc('3'), Cc('4'), Cc('2')])}
[center][font_size=28][b]14 = (3 x 4) + 2[/b][/font_size][/center]
[cadre]Le reste est toujours [b]plus petit que le diviseur[/b] : 2 < 3.
Sinon, je pourrais encore donner une bille à chacun ![/cadre]""",
"""[titre]Diviser avec les tables[/titre]
Pour [b]80 : 9[/b], je cherche dans la table de 9 le résultat le plus proche, [b]sans dépasser 80[/b].
[cadre]9 x 8 = 72 et 9 x 9 = 81 : 81 dépasse 80, je prends [b]9 x 8 = 72[/b].
Quotient : [b]8[/b]. Reste : 80 - 72 = [b]8[/b]. Et 8 < 9 : c'est bon ![/cadre]""",
"""[titre]Poser une division[/titre]
[potence dividende=293 diviseur=6]
[cadre]• Dans [b]2[/b], pas de 6. Je prends [b]29[/b] : 6 x 4 = 24, j'écris 4. 29 - 24 = 5.
• J'abaisse le 3 : [b]53[/b]. 6 x 8 = 48, j'écris 8. 53 - 48 = 5.
293 : 6 → quotient [b]48[/b], reste [b]5[/b].[/cadre]""",
"""[titre]Combien de chiffres au quotient ?[/titre]
Avant de poser [b]293 : 6[/b], j'encadre le quotient avec 10 et 100 :
[cadre]6 x 10 = 60 et 6 x 100 = 600. 293 est entre 60 et 600.
Le quotient est donc entre 10 et 100 : il a [b]2 chiffres[/b].[/cadre]
[cadre=astuce]Si je trouve un quotient à 1 ou 3 chiffres, je me suis trompé quelque part.[/cadre]""",
"""[titre]Un quotient à 3 chiffres[/titre]
[potence dividende=416 diviseur=3]
[cadre]Dans 4 : 1 fois 3, reste 1. J'abaisse le 1 → 11 : 3 x 3 = 9, reste 2. J'abaisse le 6 → 26 : 3 x 8 = 24, reste 2.
416 : 3 → quotient [b]138[/b], reste [b]2[/b].[/cadre]""",
"""[titre]Vérifier[/titre]
Je multiplie le quotient par le diviseur, puis j'ajoute le reste : je dois retrouver le dividende.
[center][font_size=26][b](3 x 138) + 2 = 414 + 2 = 416[/b][/font_size][/center]
[cadre]C'est bien 416 : ma division est juste. Et le reste 2 est plus petit que 3.[/cadre]""",
"""[titre]Que faire du reste ?[/titre]
On range [b]125 œufs[/b] dans des boîtes de [b]6[/b]. 125 : 6 → quotient 20, reste 5.
[cadre]• Combien de boîtes [b]pleines[/b] ? [b]20[/b] boîtes.
• Combien d'œufs restent hors des boîtes pleines ? [b]5[/b] œufs.
• Combien de boîtes pour [b]tout[/b] ranger ? 20 + 1 = [b]21[/b] boîtes.[/cadre]
[cadre=astuce]Je relis la question pour savoir si je garde le quotient, le reste… ou le quotient + 1.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Dividende = (diviseur x quotient) + reste. 14 = (3 x 4) + 2.
• Le reste est toujours [b]plus petit que le diviseur[/b].
• J'utilise les tables : le plus grand résultat [b]sans dépasser[/b].
• Pour poser : je prends assez de chiffres, je soustrais, j'abaisse le chiffre suivant.
• J'encadre le quotient (x 10, x 100) pour savoir combien il a de chiffres.
• Je vérifie : (diviseur x quotient) + reste = dividende.[/cadre]""",
])

# ---------------------------------------------------------------- 5. Numération
assert 538721 == 538000 + 721 and 130368 == 100000 + 30000 + 300 + 60 + 8 and 999999 + 1 == 1000000
add('numeration', 'Les grands nombres', [
f"""[titre]Les classes[/titre]
Pour lire un grand nombre, je fais des paquets de 3 chiffres en partant de la droite : [b]les classes[/b].
{classes_table('538 721', ['mille', 'unités'])}
[cadre]On lit classe par classe : [b]cinq cent trente-huit mille sept cent vingt et un[/b].
On laisse [b]un espace[/b] entre les classes : 538 721.[/cadre]""",
f"""[titre]Le nom de chaque chiffre[/titre]
{grid2(2, [Cc('[b]5[/b]', 'classe'), Cc('chiffre des [b]centaines de mille[/b]'), Cc('[b]3[/b]', 'classe'), Cc('chiffre des [b]dizaines de mille[/b]'), Cc('[b]8[/b]', 'classe'), Cc('chiffre des [b]unités de mille[/b] (les milliers)'), Cc('[b]7[/b]', 'unites'), Cc('chiffre des [b]centaines[/b]'), Cc('[b]2[/b]', 'unites'), Cc('chiffre des [b]dizaines[/b]'), Cc('[b]1[/b]', 'unites'), Cc('chiffre des [b]unités[/b]')], pad='12,3,12,3')}
[cadre]Dans la classe des mille, on retrouve [b]centaines, dizaines, unités[/b], comme dans la classe des unités.[/cadre]""",
"""[titre]Chiffre des… ou nombre de… ?[/titre]
Dans [b]538 721[/b] :
[cadre]• le [b]chiffre[/b] des milliers, c'est [b]8[/b] : un seul chiffre ;
• le [b]nombre[/b] de milliers, c'est [b]538[/b] : tout ce qui est à gauche, chiffre des milliers compris.[/cadre]
[cadre=astuce]538 721, c'est 538 paquets de mille, plus 721. Lis bien la question : « chiffre » ou « nombre » ?[/cadre]""",
"""[titre]Décomposer un grand nombre[/titre]
[center][font_size=26][b]130 368 = 100 000 + 30 000 + 300 + 60 + 8[/b][/font_size][/center]
[cadre]Le chiffre des milliers est [b]0[/b] : il n'y a aucun millier en plus, mais il garde sa place.
Sans ce 0, j'écrirais 13 368 : un tout autre nombre ![/cadre]""",
"""[titre]Le million[/titre]
[center][font_size=30][b]999 999 + 1 = 1 000 000[/b][/font_size][/center]
[cadre]Après 999 999, on arrive à [b]un million[/b] : 1 000 000, avec six 0.
Un million, c'est [b]mille milliers[/b]. Il ouvre une nouvelle classe : la classe des millions.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je sépare les classes par paquets de 3 chiffres, en partant de la droite : 538 721.
• Classe des mille : centaines de mille, dizaines de mille, unités de mille.
• « Chiffre des milliers » : 8. « Nombre de milliers » : 538.
• Un 0 garde la place d'un chiffre : 130 368.
• 1 000 000 = un million = mille milliers.[/cadre]""",
])

# ---------------------------------------------------------------- 6. Comparer
add('comparer_nombres', 'Comparer des nombres décimaux', [
"""[titre]D'abord la partie entière[/titre]
Pour comparer deux nombres décimaux, je regarde d'abord [b]ce qui est avant la virgule[/b].
[center][font_size=30][b]20,87 > 15,06[/b][/font_size][/center]
[cadre]20 est plus grand que 15, donc [b]20,87 > 15,06[/b]. Pas besoin de regarder après la virgule.[/cadre]""",
f"""[titre]Même partie entière[/titre]
Je compare chiffre par chiffre après la virgule : [b]les dixièmes d'abord[/b], puis les centièmes.
{dec_op(cols(1, 2), [('', '8,64'), ('', '8,78')])}
[cadre]Unités : 8 et 8, égales. Dixièmes : [b]6 < 7[/b]. Donc [b]8,64 < 8,78[/b].[/cadre]""",
f"""[titre]Attention au piège ![/titre]
Qui est le plus grand : [b]8,5[/b] ou [b]8,47[/b] ? Le nombre le plus long n'est pas forcément le plus grand.
{dec_op(cols(1, 2), [('', ['8', ',', '5', '!' + bclr('0')]), ('', '8,47')])}
[cadre]J'ajoute un 0 : 8,5 = 8,50. Dixièmes : [b]5 > 4[/b]. Donc [b]8,5 > 8,47[/b].[/cadre]
[cadre=astuce]Avec des euros : 8,50 euros, c'est plus que 8,47 euros ![/cadre]""",
"""[titre]Les zéros utiles et inutiles[/titre]
[cadre]• Un 0 [b]tout à la fin[/b] de la partie décimale ne change rien : 6,20 = [b]6,2[/b] et 15,10 = [b]15,1[/b].
• Un 0 [b]juste après la virgule[/b] compte : 6,02 n'est pas 6,2 ![/cadre]
[droite de=6 a=7 parts=10 points=2 noms=decimal]
[cadre=astuce]6,2 = 6 unités et 2 dixièmes. 6,02 = 6 unités et 2 centièmes : c'est bien plus petit.[/cadre]""",
"""[titre]Sur une droite graduée[/titre]
Entre 0 et 1, je compte de dixième en dixième. [b]Plus un nombre est à droite, plus il est grand[/b].
[droite de=0 a=1 parts=10 points=3,7 noms=decimal]
[cadre]0,3 est à gauche de 0,7 : [b]0,3 < 0,7[/b].[/cadre]""",
"""[titre]Ranger des nombres décimaux[/titre]
Ranger du plus petit au plus grand : 1,43 · 1,22 · 1,4 · 1,3
[cadre]Même partie entière : 1. J'écris tout avec 2 chiffres après la virgule :
1,43 · 1,22 · 1,40 · 1,30. Je compare les dixièmes, puis les centièmes.
[b]1,22 < 1,3 < 1,4 < 1,43[/b][/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je compare d'abord [b]la partie entière[/b] : 20,87 > 15,06.
• Si elle est égale : les [b]dixièmes[/b], puis les [b]centièmes[/b].
• Le plus long n'est pas toujours le plus grand : 8,5 > 8,47.
• J'ajoute des 0 à la fin pour avoir autant de chiffres : 8,5 = 8,50.
• 6,2 = 6,20 mais 6,2 ≠ 6,02.[/cadre]""",
])

# ---------------------------------------------------------------- 7. Proportionnalité
assert 30 // 6 == 5 and 18 * 5 == 90 and 3 * 30 == 90 and 12 * 5 == 60 and 12 + 60 == 72
PT = lambda a, b: grid2(len(a) + 1, [Cc('[b]Nombre de stylos[/b]', 'classe!')] + [Cc(x, 'classe') for x in a] + [Cc('[b]Prix en euros[/b]', 'unites!')] + [Cc(f'[b]{x}[/b]', 'unites') for x in b])
add('proportionnalite', 'La proportionnalité', [
"""[titre]Deux fois plus, deux fois plus cher[/titre]
Un stylo coûte [b]2 euros[/b]. Deux stylos coûtent 4 euros, trois stylos 6 euros…
[cadre]Si j'achète [b]2 fois plus[/b] de stylos, je paie [b]2 fois plus[/b].
Si j'en achète 3 fois plus, je paie 3 fois plus. Le prix est [b]proportionnel[/b] au nombre de stylos.[/cadre]""",
f"""[titre]Le tableau de proportionnalité[/titre]
{PT(['1', '2', '3', '6'], ['2', '4', '6', '12'])}
[cadre]Pour passer de la 1re ligne à la 2e, je multiplie [b]toujours par le même nombre[/b] : ici, [b]x 2[/b].
1 x 2 = 2 · 3 x 2 = 6 · 6 x 2 = 12.[/cadre]""",
"""[titre]Méthode 1 : passer par 1[/titre]
Pour [b]6 billes[/b], on paie [b]30 euros[/b]. Combien paie-t-on pour [b]18 billes[/b] ?
[cadre]• Je cherche le prix d'[b]une[/b] bille : 30 : 6 = [b]5 euros[/b].
• Puis pour 18 billes : 18 x 5 = [b]90 euros[/b].[/cadre]
On paie [b]90 euros[/b] pour 18 billes.""",
"""[titre]Méthode 2 : multiplier la quantité[/titre]
Même problème : 6 billes coûtent 30 euros. Et 18 billes ?
[cadre]18, c'est [b]3 fois[/b] 6 (6 x 3 = 18). Donc le prix est aussi 3 fois plus grand :
30 x 3 = [b]90 euros[/b].[/cadre]
[cadre=astuce]Les deux méthodes donnent le même résultat. Choisis la plus facile selon les nombres.[/cadre]""",
f"""[titre]Méthode 3 : additionner[/titre]
2 cahiers coûtent [b]12 euros[/b]. Combien coûtent [b]12 cahiers[/b] ?
{grid2(4, [Cc('[b]Cahiers[/b]', 'classe!'), Cc('2', 'classe'), Cc('10', 'classe'), Cc('[b]12 = 2 + 10[/b]', 'classe'), Cc('[b]Prix[/b]', 'unites!'), Cc('12', 'unites'), Cc('60', 'unites'), Cc('[b]12 + 60 = 72[/b]', 'unites')])}
[cadre]10 cahiers = 5 fois 2 cahiers : 12 x 5 = 60 euros. Puis 2 + 10 cahiers : 12 + 60 = [b]72 euros[/b].[/cadre]""",
"""[titre]Ce n'est pas toujours proportionnel[/titre]
[cadre]• À 5 ans, Léa mesure 1 m 10. À 10 ans, elle ne mesurera pas 2 m 20 !
• Un paquet de 1 kg de pâtes coûte 2 euros, mais un paquet de 5 kg peut coûter moins de 10 euros.[/cadre]
[cadre=astuce]Avant de calculer, je me demande : « 2 fois plus de… donne-t-il vraiment 2 fois plus de… ? »[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Proportionnel : 2 fois plus de stylos → 2 fois plus cher.
• Dans un tableau, on passe d'une ligne à l'autre en multipliant [b]toujours par le même nombre[/b].
• Méthode 1 : je cherche le prix d'[b]un seul[/b] objet.
• Méthode 2 : je cherche [b]combien de fois[/b] plus d'objets.
• Méthode 3 : j'[b]additionne[/b] deux colonnes.
• Je vérifie que la situation est vraiment proportionnelle.[/cadre]""",
])

# ---------------------------------------------------------------- 8. Fractions
assert 36 // 3 == 12 and 12 * 2 == 24 and 36 // 6 == 6 and 6 * 5 == 30 and 12 // 3 == 4
add('fractions', 'Les fractions', [
"""[titre]Lire une fraction[/titre]
[tarte parts=4 colorees=3]
[center][font_size=34][b]3/4[/b][/font_size][/center]
[cadre]• Le nombre du bas, le [b]dénominateur[/b], dit en combien de parts égales on coupe : 4.
• Le nombre du haut, le [b]numérateur[/b], dit combien de parts on prend : 3.
On lit « [b]trois quarts[/b] ».[/cadre]""",
f"""[titre]Les noms des fractions[/titre]
{grid2(3, [Cc('[b]1/2[/b] un demi', 'classe'), Cc('[b]1/3[/b] un tiers', 'classe'), Cc('[b]3/4[/b] trois quarts', 'classe'), Cc('[b]2/5[/b] deux cinquièmes'), Cc('[b]5/6[/b] cinq sixièmes'), Cc('[b]3/7[/b] trois septièmes'), Cc('[b]1/8[/b] un huitième'), Cc('[b]4/9[/b] quatre neuvièmes'), Cc('[b]7/10[/b] sept dixièmes')])}
[cadre]À partir de 5 parts, le dénominateur se lit avec [b]-ième[/b] : cinquième, sixième…[/cadre]""",
"""[titre]Une fraction sur une bande[/titre]
La bande est coupée en [b]8 parts égales[/b]. J'en colorie 3 :
[cases n=8 bleu=3]
[cadre]La partie coloriée représente [b]3/8[/b] de la bande.
Si je colorie les 8 parts : [b]8/8 = 1[/b], toute la bande.[/cadre]""",
"""[titre]Plus petit ou plus grand que 1 ?[/titre]
[droite de=0 a=2 parts=8 points=3,4,5 noms=fraction]
[cadre]• Numérateur [b]plus petit[/b] que le dénominateur : moins que 1. 3/4 < 1.
• Numérateur [b]égal[/b] au dénominateur : 4/4 = 1.
• Numérateur [b]plus grand[/b] : plus que 1. 5/4 > 1.[/cadre]""",
"""[titre]Comparer : même dénominateur[/titre]
Si les parts sont de [b]la même taille[/b], celui qui en prend le plus a le plus grand morceau.
[tarte parts=7,7 colorees=2,4]
[cadre][b]2/7 < 4/7[/b] : je compare les numérateurs, 2 < 4.[/cadre]""",
"""[titre]Comparer : même numérateur[/titre]
Plus on coupe en [b]beaucoup de parts[/b], plus les parts sont [b]petites[/b].
[tarte parts=5,7 colorees=4,4]
[cadre]4/5 et 4/7 : on prend 4 parts, mais les cinquièmes sont plus gros que les septièmes.
Donc [b]4/5 > 4/7[/b].[/cadre]""",
"""[titre]Des fractions égales[/titre]
[tarte parts=3,6 colorees=1,2 noms=oui]
[cadre]1 part sur 3, c'est autant que 2 parts sur 6 : [b]1/3 = 2/6[/b].
Je multiplie le numérateur et le dénominateur [b]par le même nombre[/b] : la fraction ne change pas.[/cadre]
[cadre=astuce]1/3 ou 2/7 ? 1/3 = 2/6, et 2/6 > 2/7. Donc [b]1/3 > 2/7[/b].[/cadre]""",
"""[titre]Additionner des fractions[/titre]
Avec le [b]même dénominateur[/b], j'additionne les numérateurs. Le dénominateur ne change pas.
[center][font_size=30][b]2/5 + 2/5 = 4/5[/b][/font_size][/center]
[cadre]2 cinquièmes + 2 cinquièmes = 4 cinquièmes. [b]Attention[/b] : ce n'est pas 4/10 !
6/8 + 2/8 = 8/8 = [b]1[/b].[/cadre]""",
"""[titre]La fraction d'une quantité[/titre]
Les [b]2/3 de 12 billes[/b] : je partage 12 en 3, puis j'en prends 2 parts.
[billes groupes=4,4,4 couleurs=bleu,bleu,jaune signes=non]
[cadre]1/3 de 12 = 12 : 3 = 4. Donc 2/3 de 12 = 4 x 2 = [b]8 billes[/b].[/cadre]""",
"""[titre]Avec des grands nombres[/titre]
[cadre]• Les [b]2/3 de 36[/b] : 36 : 3 = 12, puis 12 x 2 = [b]24[/b].
• Les [b]5/6 de 36[/b] : 36 : 6 = 6, puis 6 x 5 = [b]30[/b].[/cadre]
[cadre=astuce]Je divise par le nombre du [b]bas[/b], puis je multiplie par le nombre du [b]haut[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• 3/4 : 4 = dénominateur (parts égales), 3 = numérateur (parts prises).
• 4/4 = 1. Numérateur plus petit : moins que 1.
• Même dénominateur : le plus grand numérateur gagne. Même numérateur : le plus petit dénominateur gagne.
• 1/3 = 2/6 : je multiplie en haut et en bas par le même nombre.
• 2/5 + 2/5 = 4/5 : le dénominateur ne change pas.
• 2/3 de 36 : 36 : 3 = 12, puis 12 x 2 = 24.[/cadre]""",
])

# ---------------------------------------------------------------- 9. Mesures
assert 13 * 1000 == 13000 and 11 * 100 == 1100 and 9 * 60 + 45 == 585
add('mesures', 'Mesures et conversions', [
f"""[titre]Les préfixes[/titre]
Les unités de mesure se construisent avec les mêmes [b]préfixes[/b] :
{grid2(6, [H('kilo'), H('hecto'), H('déca'), H('déci'), H('centi'), H('milli'), Cc('1000', 'classe'), Cc('100', 'classe'), Cc('10', 'classe'), Cc('1/10', 'unites'), Cc('1/100', 'unites'), Cc('1/1000', 'unites')], pad='12,4,12,4')}
[cadre][b]kilo[/b]mètre = 1000 mètres. [b]centi[/b]litre = 1/100 de litre. [b]milli[/b]gramme = 1/1000 de gramme.[/cadre]""",
f"""[titre]Le tableau des longueurs[/titre]
{conv_table(LONG, 'unites', ['', '', '', '8', '0', '0', ''])}
Chaque unité vaut [b]10 fois[/b] celle qui est à sa droite. Pour convertir 8 m en cm :
[cadre]J'écris 8 dans la colonne des [b]m[/b], puis je complète avec des 0 jusqu'aux [b]cm[/b] :
8 m = [b]800 cm[/b].[/cadre]""",
f"""[titre]Petites longueurs[/titre]
{conv_table(LONG, 'unites', ['', '', '', '', '', '4', '0'])}
[cadre]4 cm = [b]40 mm[/b] (1 cm = 10 mm).
1 m = 100 cm = [b]1000 mm[/b].[/cadre]
[cadre=astuce]Vers une unité plus petite, le nombre devient [b]plus grand[/b] : j'ajoute des 0.[/cadre]""",
f"""[titre]Les masses[/titre]
{conv_table(['kg', 'hg', 'dag', 'g'], 'unites', ['13', '0', '0', '0'])}
[cadre]J'écris 13 dans la colonne des [b]kg[/b], puis je complète avec des 0 jusqu'aux [b]g[/b] :
13 kg = [b]13 000 g[/b] (1 kg = 1000 g).[/cadre]""",
f"""[titre]Les contenances[/titre]
{conv_table(['L', 'dL', 'cL', 'mL'], 'unites', ['11', '0', '0', ''])}
[cadre]11 L = [b]1100 cL[/b] (1 L = 100 cL).
Et 1 L = 10 dL = 100 cL = [b]1000 mL[/b].[/cadre]
[cadre=astuce]Une cuillère à café : environ 5 mL. Une canette : 33 cL.[/cadre]""",
f"""[titre]Avec un nombre décimal[/titre]
Pour [b]1,5 m[/b] en cm, je place [b]le chiffre des unités dans la colonne de l'unité[/b] (m).
{conv_table(LONG, 'unites', ['', '', '', '1', '5', '0', ''])}
[cadre]Le 5 (dixièmes) va dans la colonne suivante, puis je complète avec un 0 jusqu'aux cm.
1,5 m = [b]150 cm[/b]. Et 2,25 kg = [b]2250 g[/b].[/cadre]""",
f"""[titre]Les durées[/titre]
{grid2(2, [Cc('[b]1 h = 60 min[/b]', 'classe'), Cc('[b]10 h = 600 min[/b]', 'classe'), Cc('une demi-heure = [b]30 min[/b]', 'unites'), Cc('un quart d\'heure = [b]15 min[/b]', 'unites'), Cc('trois quarts d\'heure = [b]45 min[/b]', 'unites'), Cc('1 min = [b]60 s[/b]', 'unites')])}
[cadre]Les durées ne vont pas de 10 en 10 mais de [b]60 en 60[/b] : pas de tableau avec des 0 ![/cadre]""",
"""[titre]Calculer une durée[/titre]
Le car part à [b]9 h 45[/b] et arrive à [b]11 h 20[/b]. Combien de temps dure le trajet ?
J'avance par étapes, en passant par les heures rondes :
[cadre]9 h 45 → 10 h : [b]15 min[/b]. 10 h → 11 h : [b]1 h[/b]. 11 h → 11 h 20 : [b]20 min[/b].
En tout : 1 h + 15 min + 20 min = [b]1 h 35 min[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• kilo = 1000 · hecto = 100 · déca = 10 · déci = 1/10 · centi = 1/100 · milli = 1/1000.
• Dans le tableau, le chiffre des unités va dans la colonne de l'unité, puis je complète avec des 0.
• 1 km = 1000 m · 1 m = 100 cm · 1 kg = 1000 g · 1 L = 100 cL = 1000 mL.
• 1,5 m = 150 cm.
• 1 h = 60 min. Un quart d'heure = 15 min.
• Pour une durée, j'avance par étapes jusqu'aux heures rondes.[/cadre]""",
])

# ---------------------------------------------------------------- 10. Périmètre
assert (29 + 12) * 2 == 82 and 29 * 2 + 12 * 2 == 82 and 5 + 7 + 9 == 21 and 36 // 4 == 9 and 30 // 2 - 10 == 5 and (100 + 40) * 2 == 280
add('perimetre', 'Le périmètre', [
"""[titre]Le périmètre du rectangle[/titre]
Le [b]périmètre[/b], c'est la longueur du [b]tour[/b] de la figure.
[rect long=29 larg=12 unite=cm]
[cadre](longueur + largeur) x 2 = (29 + 12) x 2 = 41 x 2 = [b]82 cm[/b].[/cadre]""",
"""[titre]Une autre façon de calculer[/titre]
Il y a [b]2 longueurs[/b] et [b]2 largeurs[/b] :
[center][font_size=26][b]29 x 2 + 12 x 2 = 58 + 24 = 82 cm[/b][/font_size][/center]
[cadre]Les deux façons donnent [b]le même périmètre[/b] : choisis celle qui te paraît la plus simple.[/cadre]""",
"""[titre]N'importe quel polygone[/titre]
Pour faire le tour d'une figure, j'[b]additionne tous ses côtés[/b].
[formes liste=triangle,pentagone]
[cadre]• Un triangle de côtés 5 cm, 7 cm et 9 cm : 5 + 7 + 9 = [b]21 cm[/b].
• Un pentagone de 5 côtés égaux de 6 cm : 5 x 6 = [b]30 cm[/b].[/cadre]""",
"""[titre]Retrouver un côté[/titre]
[cadre]• Un carré a un périmètre de [b]36 cm[/b]. Ses 4 côtés sont égaux : 36 : 4 = [b]9 cm[/b].
• Un rectangle a un périmètre de [b]30 cm[/b] et une longueur de [b]10 cm[/b].
Une longueur + une largeur = la moitié du tour : 30 : 2 = 15. Largeur : 15 - 10 = [b]5 cm[/b].[/cadre]""",
"""[titre]La même unité partout[/titre]
Un rectangle mesure [b]1 m[/b] de long et [b]40 cm[/b] de large.
[cadre]Je convertis d'abord : 1 m = [b]100 cm[/b].
Puis (100 + 40) x 2 = 140 x 2 = [b]280 cm[/b].[/cadre]
[cadre=astuce](1 + 40) x 2 = 82 : c'est faux, j'ai mélangé les mètres et les centimètres ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le périmètre est la longueur du tour.
• Rectangle : (longueur + largeur) x 2. Carré : côté x 4.
• Autre polygone : j'additionne tous les côtés.
• Côté d'un carré = périmètre : 4.
• Toutes les longueurs dans [b]la même unité[/b] avant de calculer.[/cadre]""",
])

# ---------------------------------------------------------------- 11. Aire
assert 3 * 5 == 15 and 20 * 18 == 360 and 8 * 8 == 64 and 24 * 16 == 384 and 24 * 10 + 24 * 6 == 384 and 6 * 2 == 12
add('aire', "L'aire", [
"""[titre]Qu'est-ce que l'aire ?[/titre]
L'[b]aire[/b], c'est la [b]place à l'intérieur[/b] d'une figure : ce qu'on colorie.
[grille lignes=3 colonnes=5]
[cadre]Ce rectangle est fait de [b]15 carreaux[/b] : 3 rangées de 5. Son aire est de 15 carreaux.
Le [b]périmètre[/b], lui, c'est le tour : la clôture autour du jardin.[/cadre]""",
"""[titre]Le centimètre carré[/titre]
Un carré de [b]1 cm de côté[/b] a une aire de [b]1 centimètre carré[/b]. On écrit [b]1 cm²[/b] (ou cm2).
[grille lignes=3 colonnes=5]
[cadre]Si chaque carreau mesure 1 cm de côté, ce rectangle a une aire de [b]15 cm²[/b].[/cadre]
[cadre=astuce]Pour une grande surface, on utilise le [b]m²[/b] : un carré de 1 m de côté.[/cadre]""",
"""[titre]L'aire du rectangle[/titre]
Plutôt que de compter les carreaux, je multiplie :
[center][font_size=26][b]Aire = longueur x largeur[/b][/font_size][/center]
[rect long=20 larg=18 unite=cm]
[cadre]20 x 18 = [b]360 cm²[/b].[/cadre]""",
"""[titre]L'aire du carré[/titre]
Le carré a sa longueur égale à sa largeur :
[center][font_size=26][b]Aire = côté x côté[/b][/font_size][/center]
[rect long=8 larg=8 unite=cm]
[cadre]8 x 8 = [b]64 cm²[/b].[/cadre]""",
"""[titre]Avec des grands nombres[/titre]
Pour un rectangle de [b]24 cm sur 16 cm[/b], je décompose la multiplication :
[cadre]24 x 16 = 24 x 10 + 24 x 6 = 240 + 144 = [b]384 cm²[/b].[/cadre]
[cadre=astuce]Ordre de grandeur : 25 x 15 ≈ 375. 384 est possible ![/cadre]""",
"""[titre]Aire ou périmètre ?[/titre]
Un rectangle de [b]6 cm sur 2 cm[/b] :
[cadre]• Son [b]périmètre[/b] : (6 + 2) x 2 = 16 [b]cm[/b] : une longueur.
• Son [b]aire[/b] : 6 x 2 = 12 [b]cm²[/b] : une surface.[/cadre]
[cadre=astuce]Ce ne sont pas les mêmes calculs ni les mêmes unités : cm pour le tour, [b]cm²[/b] pour l'intérieur.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• L'aire est la surface à l'intérieur d'une figure.
• 1 cm² = l'aire d'un carré de 1 cm de côté.
• Rectangle : longueur x largeur. 20 x 18 = 360 cm².
• Carré : côté x côté. 8 x 8 = 64 cm².
• Aire en [b]cm²[/b], périmètre en [b]cm[/b] : ne les confonds pas ![/cadre]""",
])

if __name__ == '__main__':
    # Usage : python3 gen_cmX_maths.py <dossier des .sql> [dossier apercu .txt]
    ecrire(CL, FICHES, sys.argv[1] if len(sys.argv) > 1 else '..', sys.argv[2] if len(sys.argv) > 2 else None)
