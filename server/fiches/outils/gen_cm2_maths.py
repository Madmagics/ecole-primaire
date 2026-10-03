# Fiches de cours Maths CM2 (2026-10-03). Genere un script SQL par fiche + un script global.
# Les calculs sont verifies par des assert.
import sys
from lib import grid, grid2, RED
from cm_lib import *

CL = 'cm2'
FICHES = []


def add(code, titre, pages):
    FICHES.append((code, titre, pages))


Z = '!' + bclr('0')   # 0 ajoute en rouge pour aligner
DU2 = cols(2, 2)

# ---------------------------------------------------------------- 1. Addition
assert round(12.5 + 3.875, 3) == 16.375 and round(4.75 + 12.6 + 0.85, 2) == 18.2 and round(1.85 + 26.99, 2) == 28.84
assert round(5.46 + 0.9, 2) == 6.36 and round(7.3 + 1.99, 2) == 9.29 and round(2.6 + 5.8 + 0.4, 1) == 8.8
add('addition', "L'addition", [
f"""[titre]Jusqu'aux millièmes[/titre]
Au CM2, la partie décimale va jusqu'aux [b]millièmes[/b] : 1 unité coupée en 1000.
{dec_op(cols(1, 3), [('', '3,875')])}
[cadre]3,875 = 3 unités, 8 dixièmes, 7 centièmes et 5 [b]millièmes[/b].
3,875 = 3 + 8/10 + 7/100 + 5/1000.[/cadre]""",
f"""[titre]Des nombres de longueurs différentes[/titre]
Pour [b]12,5 + 3,875[/b], je mets [b]la virgule sous la virgule[/b] et je complète avec des 0.
{dec_op(cols(2, 3), [('', ['1', '2', ',', '5', Z, Z]), ('+', '3,875')], '16,375', top=['', '1', '', '', '', ''])}
[cadre]12,5 = 12,500. Dixièmes : 5 + 8 = 13, j'écris 3 et je retiens 1. [b]12,5 + 3,875 = 16,375[/b][/cadre]""",
f"""[titre]Trois nombres[/titre]
{dec_op(DU2, [('', '4,75'), ('+', ['1', '2', ',', '6', Z]), ('+', '0,85')], '18,20', top=['', '2', '', '1', ''])}
Centièmes : 5 + 0 + 5 = 10, je retiens 1. Dixièmes : 1 + 7 + 6 + 8 = [b]22[/b] : j'écris 2 et je retiens [b]2[/b] !
[cadre]Unités : 2 + 4 + 2 + 0 = 8. Dizaines : 1. [b]4,75 + 12,6 + 0,85 = 18,2[/b][/cadre]""",
"""[titre]Calculer de tête, malin[/titre]
[cadre]• Ajouter [b]0,9[/b], c'est ajouter 1 puis enlever 0,1 : 5,46 + 0,9 = 6,46 - 0,1 = [b]6,36[/b].
• Ajouter [b]1,99[/b], c'est ajouter 2 puis enlever 0,01 : 7,3 + 1,99 = 9,3 - 0,01 = [b]9,29[/b].
• Je regroupe les nombres qui font un entier : 2,6 + 5,8 + 0,4 = (2,6 + 0,4) + 5,8 = 3 + 5,8 = [b]8,8[/b].[/cadre]
[cadre=astuce]Dans une addition, je peux changer l'ordre des nombres : le résultat ne change pas.[/cadre]""",
"""[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]1,85 + 26,99[/b], j'arrondis à l'unité : 2 + 27 = [b]29[/b].
[cadre]Je trouve 28,84 : c'est proche de 29, c'est possible.
Si je trouve 2,884 ou 288,4, ma [b]virgule est mal placée[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• 3,875 : 8 dixièmes, 7 centièmes, 5 [b]millièmes[/b].
• Virgule sous virgule, et des 0 pour compléter : 12,5 = 12,500.
• La retenue peut être 2 (ou plus) quand j'additionne plusieurs nombres.
• + 0,9 = + 1 - 0,1. + 1,99 = + 2 - 0,01.
• Je regroupe les nombres qui font un entier.
• Je vérifie avec un ordre de grandeur.[/cadre]""",
])

# ---------------------------------------------------------------- 2. Soustraction
assert round(11.32 - 5.53, 2) == 5.79 and round(25 - 7.36, 2) == 17.64 and round(1 - 0.35, 2) == 0.65 and round(1 - 0.125, 3) == 0.875
assert round(8.45 - 0.99, 2) == 7.46 and round(5.79 + 5.53, 2) == 11.32
add('soustraction', 'La soustraction', [
f"""[titre]Le cassage, avec la virgule[/titre]
Pour [b]11,32 - 5,53[/b], il manque dans [b]chaque colonne[/b] : je casse à chaque fois.
{dec_op(DU2, [('', ['~1', '~1', ',', '~3', '~2']), ('-', '5,53')], ['', '5', ',', '7', '9'], top=['0', '10', '', '12', '12'])}
Centièmes : 12 - 3 = 9. Dixièmes : 12 - 5 = 7. Unités : 10 - 5 = 5. Dizaines : 0.
[cadre][b]11,32 - 5,53 = 5,79[/b][/cadre]""",
f"""[titre]La compensation, avec la virgule[/titre]
{dec_op(DU2, [('', ['1', '!' + comp_top(1) + '1', ',', '!' + comp_top(1) + '3', '!' + comp_top(1) + '2']), ('-', ['!' + comp_top('+1'), '!5' + comp_top('+1'), ',', '!5' + comp_top('+1'), '3'])], ['', '5', ',', '7', '9'])}
À chaque colonne : 10 en haut, et 1 de plus en bas dans la colonne de gauche.
[cadre]12 - 3 = 9 · 13 - 6 = 7 · 11 - 6 = 5 · 1 - 1 = 0. Même résultat : [b]5,79[/b].
Utilise toujours [b]la méthode de ta classe[/b].[/cadre]""",
f"""[titre]Soustraire d'un nombre entier[/titre]
Pour [b]25 - 7,36[/b], j'écris 25 avec une virgule et des 0 : [b]25,00[/b].
{dec_op(DU2, [('', ['2', '5', ',', Z, Z]), ('-', '7,36')], '17,64')}
[cadre]Puis je calcule avec la méthode de ma classe : [b]25 - 7,36 = 17,64[/b].[/cadre]""",
f"""[titre]Le complément à 1[/titre]
Combien faut-il ajouter à [b]0,35[/b] pour avoir 1 ? 35 centièmes + 65 centièmes = 100 centièmes.
{grid2(3, [Cc('[b]1 - 0,35 = 0,65[/b]', 'classe'), Cc('[b]1 - 0,8 = 0,2[/b]', 'classe'), Cc('[b]1 - 0,125 = 0,875[/b]', 'classe')])}
[cadre=astuce]Chiffre par chiffre, je complète à [b]9[/b], et le dernier chiffre à [b]10[/b] :
0,1[b]2[/b]5 → 1 + 8 = 9, 2 + 7 = 9, 5 + 5 = 10 → [b]0,875[/b].[/cadre]""",
"""[titre]Calculer de tête, malin[/titre]
[cadre]• Enlever [b]0,99[/b], c'est enlever 1 puis rajouter 0,01 : 8,45 - 0,99 = 7,45 + 0,01 = [b]7,46[/b].
• Enlever [b]0,9[/b], c'est enlever 1 puis rajouter 0,1 : 6,3 - 0,9 = 5,3 + 0,1 = [b]5,4[/b].[/cadre]
[cadre=astuce]J'ai enlevé un peu trop : je rends ce que j'ai pris en trop.[/cadre]""",
f"""[titre]Vérifier avec une addition[/titre]
{dec_op(DU2, [('', '5,79'), ('+', '5,53')], '11,32', top=['1', '1', '', '1', ''])}
[cadre]5,79 + 5,53 = 11,32 : je retrouve le nombre du départ, ma soustraction est juste.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Virgule sous virgule ; un entier s'écrit avec des 0 : 25 = 25,00.
• Pas assez ? Cassage ou compensation : [b]la méthode de ma classe[/b], dans chaque colonne.
• Complément à 1 : 1 - 0,35 = 0,65 (chiffres complétés à 9, le dernier à 10).
• - 0,99 = - 1 + 0,01.
• Je vérifie avec une addition.[/cadre]""",
])

# ---------------------------------------------------------------- 3. Multiplication
assert 53 * 7 == 371 and 53 * 80 == 4240 and 53 * 87 == 4611 and 235 * 4 == 940 and round(2.35 * 4, 2) == 9.4
assert round(3.75 * 10, 2) == 37.5 and round(3.75 * 100) == 375 and round(3.75 * 1000) == 3750
assert 46 * 5 == 230 and 36 * 25 == 900 and 45 * 99 == 4455 and 70 * 50 == 3500 and 4 * 17 * 25 == 1700 and 99 * 85 == 8415
add('multiplication', 'La multiplication', [
f"""[titre]Poser 53 x 87[/titre]
87 = 7 + 80. Je fais [b]deux lignes[/b] puis je les additionne.
{entier_op(list('mcdu'), [('', 53), ('x', 87), ('', 371), ('+', ['4', '2', '4', Z])], 4611)}
[cadre]1re ligne : 53 x 7 = [b]371[/b]. 2e ligne : 53 x 80 = [b]4240[/b]. 371 + 4240 = [b]4611[/b].[/cadre]""",
"""[titre]Pourquoi le 0 de la 2e ligne ?[/titre]
Dans 87, le 8 est le chiffre des [b]dizaines[/b] : il vaut 80, pas 8.
[cadre]53 x 80 = 53 x 8 x 10 = 424 x 10 = [b]4240[/b].
J'écris d'abord le [b]0[/b] dans les unités, puis 53 x 8 à sa gauche.[/cadre]
[cadre=astuce]Pour un nombre à 3 chiffres (x 245), la 3e ligne commence par [b]deux 0[/b] (x 200).[/cadre]""",
"""[titre]Un nombre décimal fois un entier[/titre]
Pour [b]2,35 x 4[/b], je calcule sans la virgule, puis je la replace.
[cadre]235 x 4 = 940. 2,35 a [b]2 chiffres après la virgule[/b] : le résultat aussi.
2,35 x 4 = [b]9,40[/b] = 9,4.[/cadre]
[cadre=astuce]Ordre de grandeur : 2 x 4 = 8. 9,4 est possible, 94 ou 0,94 non ![/cadre]""",
f"""[titre]Un décimal fois 10, 100, 1000[/titre]
Chaque chiffre prend une valeur 10, 100 ou 1000 fois plus grande : la virgule [b]se déplace vers la droite[/b].
{grid2(2, [Cc('[b]3,75 x 10 = 37,5[/b]', 'classe'), Cc('1 rang vers la droite'), Cc('[b]3,75 x 100 = 375[/b]', 'classe'), Cc('2 rangs'), Cc('[b]3,75 x 1000 = 3750[/b]', 'classe'), Cc("3 rangs : j'ajoute un 0")])}
[cadre]Attention : 3,75 x 10 ne fait pas 3,750 ! Ajouter un 0 ne marche que pour les entiers.[/cadre]""",
"""[titre]Les astuces de calcul[/titre]
[cadre]• Fois [b]5[/b] = fois 10, puis divisé par 2 : 46 x 5 = 460 : 2 = [b]230[/b].
• Fois [b]50[/b] = fois 100, puis divisé par 2 : 70 x 50 = 7000 : 2 = [b]3500[/b].
• Fois [b]25[/b] = fois 100, puis divisé par 4 : 36 x 25 = 3600 : 4 = [b]900[/b].
• Fois [b]99[/b] = fois 100, moins une fois : 45 x 99 = 4500 - 45 = [b]4455[/b].[/cadre]""",
"""[titre]Changer l'ordre[/titre]
Dans une multiplication, je peux [b]changer l'ordre[/b] et regrouper les nombres comme je veux.
[center][font_size=26][b]4 x 17 x 25 = 17 x (4 x 25) = 17 x 100 = 1700[/b][/font_size][/center]
[cadre=astuce]Je cherche les paires qui font 10, 100 ou 1000 : 2 x 5, 4 x 25, 8 x 125.[/cadre]""",
"""[titre]Vérifier avec un ordre de grandeur[/titre]
Pour [b]99 x 85[/b], j'arrondis : 100 x 85 = [b]8500[/b].
[cadre]Je trouve 8415 : c'est un peu moins que 8500, normal car 99 < 100. C'est possible.
Avec l'astuce : 8500 - 85 = [b]8415[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Par un nombre à 2 chiffres : 2 lignes ; la 2e commence par un 0 (les dizaines).
• Décimal x entier : je calcule sans virgule, puis je remets autant de chiffres après la virgule.
• Décimal x 10, 100, 1000 : la virgule se déplace de 1, 2, 3 rangs vers la droite.
• x 5 = x 10 : 2 · x 25 = x 100 : 4 · x 99 = x 100 - 1 fois.
• Je change l'ordre pour faire 10, 100, 1000. Je vérifie avec un ordre de grandeur.[/cadre]""",
])

# ---------------------------------------------------------------- 4. Division
assert divmod(138, 8) == (17, 2) and divmod(300, 13) == (23, 1) and divmod(290, 12) == (24, 2) and divmod(59, 10) == (5, 9)
assert 30 / 4 == 7.5 and 138 // 3 == 46 and 288 // 9 == 32 and 175 % 7 == 0 and 350 / 100 == 3.5
T13 = ' · '.join(str(13 * k) for k in range(1, 10))
add('division', 'La division', [
f"""[titre]Rappel[/titre]
{grid2(4, [Cc('[b]dividende[/b]', 'classe'), Cc('[b]diviseur[/b]', 'classe'), Cc('[b]quotient[/b]', 'classe'), Cc('[b]reste[/b]', 'unites'), Cc('138'), Cc('8'), Cc('17'), Cc('2')])}
[center][font_size=28][b]138 = (8 x 17) + 2[/b][/font_size][/center]
[cadre]Le reste est toujours [b]plus petit que le diviseur[/b] : 2 < 8.[/cadre]""",
f"""[titre]Diviser par un nombre à 2 chiffres[/titre]
Pour [b]300 : 13[/b], j'écris d'abord le début de la table de 13 :
[center][b]{T13}[/b][/center]
[potence dividende=300 diviseur=13]
[cadre]Dans 30 : 2 fois (26), reste 4. J'abaisse 0 → 40 : 3 fois (39), reste 1. Quotient [b]23[/b], reste [b]1[/b].[/cadre]""",
"""[titre]Estimer chaque chiffre[/titre]
Dans [b]40[/b], combien de fois [b]13[/b] ? J'arrondis 13 à 10 : dans 40, 4 fois 10.
[cadre]J'essaie 4 : 13 x 4 = 52, c'est [b]trop grand[/b] (52 > 40). J'essaie 3 : 13 x 3 = 39. C'est bon !
Le reste 40 - 39 = 1 est bien plus petit que 13.[/cadre]
[cadre=astuce]Si le reste est plus grand que le diviseur, mon chiffre est [b]trop petit[/b] : j'ajoute 1.[/cadre]""",
"""[titre]Combien de chiffres au quotient ?[/titre]
Pour [b]290 : 12[/b], j'encadre avec 10 et 100 :
[cadre]12 x 10 = 120 et 12 x 100 = 1200. 290 est entre les deux : le quotient a [b]2 chiffres[/b].[/cadre]
[potence dividende=290 diviseur=12]
[cadre]290 : 12 → quotient [b]24[/b], reste [b]2[/b]. Vérification : (12 x 24) + 2 = 288 + 2 = 290.[/cadre]""",
f"""[titre]Diviser par 10, 100[/titre]
{grid2(2, [Cc('[b]59 : 10[/b]', 'classe'), Cc('quotient 5, reste 9'), Cc('[b]59 : 10 = 5,9[/b]', 'classe'), Cc('avec la virgule'), Cc('[b]350 : 100 = 3,5[/b]', 'classe'), Cc('la virgule recule de 2 rangs')])}
[cadre]Diviser par 10, 100, 1000 : chaque chiffre prend une valeur 10, 100, 1000 fois [b]plus petite[/b].
La virgule se déplace [b]vers la gauche[/b].[/cadre]""",
"""[titre]Continuer après la virgule[/titre]
On partage [b]30 euros[/b] entre [b]4 enfants[/b]. 30 : 4 → quotient 7, reste 2.
[cadre]Il reste 2 euros : je les transforme en [b]20 dixièmes[/b] (20 x 0,10 euro).
20 dixièmes : 4 = 5 dixièmes. Donc 30 : 4 = [b]7,5[/b]. Chaque enfant a [b]7,50 euros[/b].[/cadre]""",
"""[titre]Divisible ou pas ?[/titre]
Si le reste est 0, le nombre est [b]divisible[/b]. Des règles pour le voir sans calculer :
[cadre]• Par [b]2[/b] : il est pair. Par [b]5[/b] : il finit par 0 ou 5. Par [b]10[/b] : il finit par 0.
• Par [b]3[/b] : la somme de ses chiffres est dans la table de 3. 138 → 1 + 3 + 8 = 12 : oui ! 138 : 3 = 46.
• Par [b]9[/b] : la somme de ses chiffres est dans la table de 9. 288 → 2 + 8 + 8 = 18 : oui ! 288 : 9 = 32.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Dividende = (diviseur x quotient) + reste, avec reste < diviseur.
• Par un nombre à 2 chiffres : j'écris le début de sa table.
• J'estime chaque chiffre en arrondissant le diviseur, puis j'ajuste.
• J'encadre avec x 10 et x 100 pour connaître le nombre de chiffres du quotient.
• : 10, : 100 → la virgule recule. Le reste peut continuer après la virgule : 30 : 4 = 7,5.
• Divisible par 3 ou 9 : somme des chiffres dans la table de 3 ou 9.[/cadre]""",
])

# ---------------------------------------------------------------- 5. Numération
assert 162533433 // 1000000 == 162 and round(162533433 / 1e6) == 163 and round(4.256, 1) == 4.3
add('numeration', 'Les grands nombres', [
f"""[titre]Millions et milliards[/titre]
Je sépare les classes de 3 chiffres en partant de la droite :
{classes_table('162 533 433', ['millions', 'mille', 'unités'])}
[cadre]Après la classe des mille vient la classe des [b]millions[/b], puis celle des [b]milliards[/b].
1 milliard = 1 000 000 000 = [b]mille millions[/b].[/cadre]""",
f"""[titre]Le nom de chaque chiffre[/titre]
Dans [b]508 682 859[/b] :
{grid2(3, [Cc('[b]5[/b] centaines de millions', 'milliers'), Cc('[b]6[/b] centaines de mille', 'classe'), Cc('[b]8[/b] centaines', 'unites'), Cc('[b]0[/b] dizaine de millions', 'milliers'), Cc('[b]8[/b] dizaines de mille', 'classe'), Cc('[b]5[/b] dizaines', 'unites'), Cc('[b]8[/b] unités de millions', 'milliers'), Cc('[b]2[/b] unités de mille', 'classe'), Cc('[b]9[/b] unités', 'unites')], pad='12,4,12,4')}
[cadre]Chaque classe a ses centaines, dizaines et unités. Le chiffre des millions est [b]8[/b].[/cadre]""",
"""[titre]Lire un grand nombre[/titre]
Je lis [b]classe par classe[/b], en disant le nom de la classe :
[center][font_size=26][b]162 533 433[/b][/font_size][/center]
[cadre]cent soixante-deux [b]millions[/b] cinq cent trente-trois [b]mille[/b] quatre cent trente-trois.[/cadre]
[cadre=astuce]« Million » et « milliard » prennent un s : deux millions. « Mille » ne prend [b]jamais[/b] de s : deux mille.[/cadre]""",
"""[titre]Chiffre des… ou nombre de… ?[/titre]
Dans [b]162 533 433[/b] :
[cadre]• le [b]chiffre[/b] des millions est [b]2[/b] ;
• le [b]nombre[/b] de millions est [b]162[/b] : tout ce qui est à gauche, chiffre des millions compris.[/cadre]""",
f"""[titre]Les décimaux jusqu'aux millièmes[/titre]
{dec_op(cols(1, 3), [('', '4,256')])}
[cadre]4,256 : 4 unités, 2 [b]dixièmes[/b], 5 [b]centièmes[/b], 6 [b]millièmes[/b].
1 unité = 10 dixièmes = 100 centièmes = [b]1000 millièmes[/b].[/cadre]""",
"""[titre]Arrondir[/titre]
Pour arrondir, je regarde [b]le chiffre juste après[/b] : de 0 à 4, je garde ; de 5 à 9, j'arrondis au-dessus.
[cadre]• 162 533 433 arrondi au million : le chiffre suivant est 5 → [b]163 millions[/b].
• 4,256 arrondi au dixième : le chiffre suivant est 5 → [b]4,3[/b].
• 4,256 arrondi à l'unité : le chiffre suivant est 2 → [b]4[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Classes : unités, mille, millions, milliards. 1 milliard = mille millions.
• Chaque classe a ses centaines, dizaines, unités.
• Je lis classe par classe. Millions prend un s, mille jamais.
• « Chiffre des millions » : 2. « Nombre de millions » : 162.
• Après la virgule : dixièmes, centièmes, millièmes.
• Arrondir : je regarde le chiffre suivant (5 ou plus → au-dessus).[/cadre]""",
])

# ---------------------------------------------------------------- 6. Proportionnalité
assert 12 // 3 == 4 and 26 * 4 == 104 and 110 // 2 == 55 and 110 + 55 == 165 and 200 // 2 == 100 and 200 + 100 == 300
add('proportionnalite', 'La proportionnalité', [
f"""[titre]Le coefficient[/titre]
2 stylos coûtent 10 euros. Le prix est proportionnel au nombre de stylos :
{grid2(5, [Cc('[b]Stylos[/b]', 'classe!'), Cc('2', 'classe'), Cc('4', 'classe'), Cc('6', 'classe'), Cc('10', 'classe'), Cc('[b]Prix (euros)[/b]', 'unites!'), Cc('[b]10[/b]', 'unites'), Cc('[b]20[/b]', 'unites'), Cc('[b]30[/b]', 'unites'), Cc('[b]50[/b]', 'unites')])}
[cadre]Je passe de la 1re ligne à la 2e en multipliant toujours par [b]5[/b] : c'est le [b]coefficient de proportionnalité[/b].
Ici, il est égal au prix d'un stylo : 5 euros.[/cadre]""",
"""[titre]Trouver le coefficient[/titre]
Pour [b]3 billes[/b], on paie [b]12 euros[/b]. Combien paie-t-on pour [b]26 billes[/b] ?
[cadre]Coefficient : 12 : 3 = [b]4[/b] (le prix d'une bille).
26 billes : 26 x 4 = [b]104 euros[/b].[/cadre]
[cadre=astuce]Quand 26 n'est pas un multiple simple de 3, passer par 1 est la méthode la plus sûre.[/cadre]""",
f"""[titre]La vitesse[/titre]
Une voiture roule à [b]100 km/h[/b] : elle parcourt [b]100 km en 1 heure[/b].
{grid2(5, [Cc('[b]Durée (h)[/b]', 'classe!'), Cc('1', 'classe'), Cc('2', 'classe'), Cc('3', 'classe'), Cc('5', 'classe'), Cc('[b]Distance (km)[/b]', 'unites!'), Cc('[b]100[/b]', 'unites'), Cc('[b]200[/b]', 'unites'), Cc('[b]300[/b]', 'unites'), Cc('[b]500[/b]', 'unites')])}
[cadre]Distance = vitesse x durée. En 2 heures : 100 x 2 = [b]200 km[/b].[/cadre]""",
"""[titre]Avec des demi-heures[/titre]
Une voiture roule à [b]110 km/h[/b]. Quelle distance parcourt-elle en [b]1 h 30 min[/b] ?
[cadre]En 1 h : 110 km. En 30 min (une demi-heure) : la moitié, 110 : 2 = [b]55 km[/b].
En 1 h 30 : 110 + 55 = [b]165 km[/b].[/cadre]""",
"""[titre]Une recette[/titre]
Pour [b]4 personnes[/b], il faut [b]200 g[/b] de farine. Et pour [b]6 personnes[/b] ?
[cadre]Pour 2 personnes (la moitié de 4) : 200 : 2 = [b]100 g[/b].
6 personnes = 4 + 2 : 200 + 100 = [b]300 g[/b].[/cadre]
[cadre=astuce]Je peux additionner deux colonnes du tableau, ou passer par la moitié, le double…[/cadre]""",
"""[titre]Proportionnel ou pas ?[/titre]
Un taxi coûte [b]3 euros pour monter[/b], puis [b]2 euros par km[/b].
[cadre]1 km : 3 + 2 = 5 euros. 2 km : 3 + 4 = 7 euros.
Deux fois plus de kilomètres, mais pas deux fois plus cher (7 n'est pas 10) : ce n'est [b]pas proportionnel[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Proportionnel : on passe d'une ligne à l'autre en multipliant par le même nombre, le [b]coefficient[/b].
• Le coefficient = la valeur pour 1 : 12 : 3 = 4 euros par bille.
• Vitesse : distance = vitesse x durée. 30 min = la moitié d'une heure.
• Je peux aussi additionner des colonnes ou prendre la moitié, le double.
• Je vérifie que la situation est vraiment proportionnelle.[/cadre]""",
])

# ---------------------------------------------------------------- 7. Fractions
assert 25 * 4 == 100 and 8 * 4 == 32 and 20 * 5 == 100 and 3 / 5 == 0.6
add('fractions', 'Les fractions', [
"""[titre]Rappel[/titre]
[tarte parts=8 colorees=3]
[cadre][b]3/8[/b] : on coupe en [b]8[/b] parts égales (le dénominateur) et on en prend [b]3[/b] (le numérateur).
On lit « trois huitièmes ».[/cadre]""",
"""[titre]Additionner des fractions[/titre]
Même dénominateur : j'additionne les numérateurs, [b]je garde le dénominateur[/b].
[cadre]• 2/7 + 3/7 = [b]5/7[/b]
• 3/10 + 1/10 = [b]4/10[/b]
• 6/11 + 5/11 = [b]11/11 = 1[/b][/cadre]
[cadre=astuce]Jamais 2/7 + 3/7 = 5/14 : les parts restent des septièmes ![/cadre]""",
"""[titre]Plus grand que 1[/titre]
[droite de=0 a=2 parts=8 points=4,7 noms=fraction]
[cadre][b]7/4[/b] : 4 quarts font 1 unité, il reste 3 quarts.
7/4 = 4/4 + 3/4 = [b]1 + 3/4[/b].[/cadre]""",
f"""[titre]Les fractions décimales[/titre]
Une fraction de dénominateur 10, 100 ou 1000 s'écrit facilement avec une virgule :
{grid2(3, [Cc('[b]3/10 = 0,3[/b]', 'dixiemes'), Cc('[b]75/100 = 0,75[/b]', 'centiemes'), Cc('[b]8/1000 = 0,008[/b]', 'milliemes'), Cc('3 dixièmes'), Cc('75 centièmes'), Cc('8 millièmes')])}
[cadre=astuce]Le nombre de 0 du dénominateur = le nombre de chiffres après la virgule.[/cadre]""",
"""[titre]Sur la droite graduée[/titre]
Entre 0 et 1, la droite est coupée en [b]10 dixièmes[/b] :
[droite de=0 a=1 parts=10 points=3,9 noms=decimal]
[cadre]0,3 est au même endroit que [b]3/10[/b], et 0,9 au même endroit que [b]9/10[/b].[/cadre]""",
"""[titre]Des fractions égales[/titre]
[tarte parts=2,4 colorees=1,2 noms=oui]
[cadre]1/2 = 2/4 = 5/10 = 50/100 = [b]0,5[/b]
1/4 = 25/100 = [b]0,25[/b] · 3/4 = 75/100 = [b]0,75[/b][/cadre]
[cadre=astuce]Je multiplie le numérateur et le dénominateur par le même nombre : la fraction ne change pas.[/cadre]""",
"""[titre]Écrire une fraction en décimal[/titre]
Pour [b]8/25[/b] : je cherche par combien multiplier 25 pour obtenir [b]100[/b]. 25 x 4 = 100.
[cadre]8/25 = (8 x 4)/(25 x 4) = 32/100 = [b]0,32[/b]
1/20 = 5/100 = [b]0,05[/b] (car 20 x 5 = 100)
2/5 = 4/10 = [b]0,4[/b] (car 5 x 2 = 10)[/cadre]""",
"""[titre]Comparer fractions et décimaux[/titre]
Qui est le plus grand : [b]3/5[/b] ou [b]0,7[/b] ?
[cadre]J'écris 3/5 en décimal : 3/5 = 6/10 = [b]0,6[/b].
0,6 < 0,7, donc [b]3/5 < 0,7[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Même dénominateur : j'additionne les numérateurs, je garde le dénominateur.
• 7/4 = 1 + 3/4 : une fraction peut dépasser 1.
• 3/10 = 0,3 · 75/100 = 0,75 · 8/1000 = 0,008.
• 1/2 = 0,5 · 1/4 = 0,25 · 3/4 = 0,75.
• Pour écrire en décimal, j'obtiens 10, 100 ou 1000 en bas : 8/25 = 32/100 = 0,32.[/cadre]""",
])

# ---------------------------------------------------------------- 8. Pourcentages
assert 376 // 2 == 188 and 280 // 4 == 70 and 420 // 10 == 42 and 296 // 4 * 3 == 222 and 148 + 74 == 222 and 60 // 4 == 15 and 60 - 15 == 45
add('pourcentages', 'Les pourcentages', [
"""[titre]Que veut dire « % » ?[/titre]
[b]25 %[/b] se lit « 25 pour cent » : [b]25 sur 100[/b], c'est-à-dire 25/100.
[grille lignes=10 colonnes=10 case=17 colorees=25]
[cadre]Sur 100 cases, 25 sont coloriées : [b]25 %[/b] des cases.[/cadre]""",
f"""[titre]Les pourcentages à connaître[/titre]
{grid2(3, [H('Pourcentage'), H('Fraction'), H('Je calcule'), Cc('[b]100 %[/b]', 'classe'), Cc('tout'), Cc('le nombre entier'), Cc('[b]50 %[/b]', 'classe'), Cc('1/2, la moitié'), Cc(': 2'), Cc('[b]25 %[/b]', 'classe'), Cc('1/4, le quart'), Cc(': 4'), Cc('[b]75 %[/b]', 'classe'), Cc('3/4, trois quarts'), Cc(': 4, puis x 3'), Cc('[b]10 %[/b]', 'classe'), Cc('1/10, un dixième'), Cc(': 10')], pad='14,3,14,3')}""",
"""[titre]50 % et 25 %[/titre]
[cadre]• [b]50 % de 376[/b], c'est la moitié : 376 : 2 = [b]188[/b].
• [b]25 % de 280[/b], c'est le quart : 280 : 4 = [b]70[/b].[/cadre]
[cadre=astuce]Le quart, c'est la moitié de la moitié : 280 → 140 → [b]70[/b].[/cadre]""",
"""[titre]10 % et 20 %[/titre]
[cadre]• [b]10 % de 420[/b] : je divise par 10. 420 : 10 = [b]42[/b].
• [b]20 % de 420[/b] : deux fois 10 %. 42 x 2 = [b]84[/b].[/cadre]
[cadre=astuce]Avec 10 %, je peux trouver 20 %, 30 %, 40 %… en multipliant.[/cadre]""",
"""[titre]75 %[/titre]
[b]75 % de 296[/b] : 75 %, ce sont [b]3 quarts[/b].
[cadre]Méthode 1 : un quart de 296 = 296 : 4 = 74. Trois quarts : 74 x 3 = [b]222[/b].
Méthode 2 : 50 % + 25 % = 148 + 74 = [b]222[/b].[/cadre]""",
"""[titre]Les soldes[/titre]
Un manteau coûte [b]60 euros[/b]. Il est soldé à [b]- 25 %[/b]. Combien coûte-t-il maintenant ?
[cadre]Étape 1, la réduction : 25 % de 60 = 60 : 4 = [b]15 euros[/b].
Étape 2, le nouveau prix : 60 - 15 = [b]45 euros[/b].[/cadre]
[cadre=astuce]Attention : - 25 % ne veut pas dire « 25 euros de moins » ![/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• 25 % = 25 sur 100 = 25/100.
• 50 % : la moitié (: 2). 25 % : le quart (: 4). 75 % : trois quarts.
• 10 % : je divise par 10. 20 % = 2 fois 10 %.
• Une réduction de 25 % : je calcule la réduction, puis je l'enlève du prix.[/cadre]""",
])

# ---------------------------------------------------------------- 9. Mesures
assert 2.5 * 1000 == 2500 and 750 / 1000 == 0.75 and 1250 / 1000 == 1.25 and 4 * 60 == 240 and 3 * 60 == 180 and 2 * 60 + 45 + 60 + 30 == 4 * 60 + 15
add('mesures', 'Mesures et conversions', [
f"""[titre]Un seul tableau à retenir[/titre]
{grid2(7, [H('kilo'), H('hecto'), H('déca'), H('unité'), H('déci'), H('centi'), H('milli'), Cc('km', 'classe'), Cc('hm', 'classe'), Cc('dam', 'classe'), Cc('[b]m[/b]', 'unites'), Cc('dm', 'classe'), Cc('cm', 'classe'), Cc('mm', 'classe'), Cc('kg', 'classe'), Cc('hg', 'classe'), Cc('dag', 'classe'), Cc('[b]g[/b]', 'unites'), Cc('dg', 'classe'), Cc('cg', 'classe'), Cc('mg', 'classe'), Cc('kL', 'classe'), Cc('hL', 'classe'), Cc('daL', 'classe'), Cc('[b]L[/b]', 'unites'), Cc('dL', 'classe'), Cc('cL', 'classe'), Cc('mL', 'classe')], pad='10,3,10,3')}
[cadre]Longueurs, masses et contenances utilisent [b]les mêmes préfixes[/b] : chaque colonne vaut 10 fois celle de droite.[/cadre]""",
f"""[titre]Convertir un nombre décimal[/titre]
Pour [b]2,5 km[/b] en m : le chiffre des [b]unités[/b] (2) va dans la colonne [b]km[/b].
{conv_table(['km', 'hm', 'dam', 'm'], 'unites', ['2,', '5', '0', '0'])}
[cadre]Puis je complète avec des 0 jusqu'aux m : 2,5 km = [b]2500 m[/b].
Et 14 kg = [b]14 000 g[/b] · 3 L = [b]300 cL[/b].[/cadre]""",
f"""[titre]Dans l'autre sens[/titre]
Pour [b]750 g[/b] en kg : le 0 des unités va dans la colonne [b]g[/b], puis je lis en kg.
{conv_table(['kg', 'hg', 'dag', 'g'], 'unites', ['0,', '7', '5', '0'])}
[cadre]750 g = [b]0,75 kg[/b]. Et 1250 m = [b]1,25 km[/b].[/cadre]
[cadre=astuce]Vers une unité plus grande, le nombre devient [b]plus petit[/b].[/cadre]""",
"""[titre]La tonne[/titre]
Pour les objets très lourds, on utilise la [b]tonne[/b] (t) : [b]1 t = 1000 kg[/b].
[cadre]• 5 t = 5 x 1000 = [b]5000 kg[/b].
• Une voiture pèse environ 1 t. Un éléphant, environ 5 t.[/cadre]""",
f"""[titre]Les durées ne comptent pas par 10 ![/titre]
{grid2(3, [Cc('[b]1 h = 60 min[/b]', 'classe'), Cc('[b]1 min = 60 s[/b]', 'classe'), Cc('[b]1 jour = 24 h[/b]', 'classe'), Cc('3 h = [b]180 min[/b]'), Cc('4 min = [b]240 s[/b]'), Cc('2 jours = [b]48 h[/b]')])}
[cadre]Piège : [b]1,5 h[/b], c'est 1 h et une demi-heure : 1 h [b]30[/b] min, soit 90 min.
Ce n'est pas 1 h 50 min ![/cadre]""",
"""[titre]Calculer avec des durées[/titre]
Un film de [b]2 h 45 min[/b], puis un autre de [b]1 h 30 min[/b]. Combien de temps en tout ?
[cadre]Heures : 2 + 1 = 3 h. Minutes : 45 + 30 = [b]75 min[/b].
75 min = 60 min + 15 min = 1 h 15 min. Total : 3 h + 1 h 15 min = [b]4 h 15 min[/b].[/cadre]""",
f"""[titre]Choisir la bonne unité[/titre]
{grid2(2, [Cc("l'épaisseur d'une pièce"), Cc('2 mm', 'classe'), Cc("la hauteur d'une porte"), Cc('2 m', 'classe'), Cc('la distance Paris - Lyon'), Cc('465 km', 'classe'), Cc("la masse d'un camion"), Cc('10 t', 'classe'), Cc("une bouteille d'eau"), Cc('1,5 L', 'classe'), Cc('une cuillère de sirop'), Cc('5 mL', 'classe')], pad='12,3,12,3')}""",
"""[titre]Je retiens[/titre]
[cadre]• Mêmes préfixes pour m, g et L : kilo, hecto, déca, déci, centi, milli.
• Le chiffre des unités va dans la colonne de l'unité, puis je complète avec des 0.
• 2,5 km = 2500 m · 750 g = 0,75 kg · 1 t = 1000 kg.
• Durées : 1 h = 60 min, 1 min = 60 s. 1,5 h = 1 h 30 min.
• 75 min = 1 h 15 min.[/cadre]""",
])

# ---------------------------------------------------------------- 10. Aire
assert 25 * 13 == 325 and 250 + 75 == 325 and 100 * 100 == 10000 and 6 * 2 + 3 * 2 == 18 and 6 * 4 - 3 * 2 == 18
assert 54 // 6 == 9 and 7 * 7 == 49
add('aire', "L'aire", [
"""[titre]Rappel[/titre]
[rect long=25 larg=13 unite=cm]
[cadre]Aire du rectangle = longueur x largeur : 25 x 13 = 250 + 75 = [b]325 cm²[/b].
Aire du carré = côté x côté.[/cadre]""",
"""[titre]Les unités d'aire[/titre]
[cadre]• [b]1 cm²[/b] : un carré de 1 cm de côté (un timbre fait quelques cm²).
• [b]1 m²[/b] : un carré de 1 m de côté (une chambre fait environ 10 m²).
• [b]1 km²[/b] : un carré de 1 km de côté (pour une ville).[/cadre]
[cadre=astuce]1 m² = 100 cm x 100 cm = [b]10 000 cm²[/b], et pas 100 cm² ![/cadre]""",
"""[titre]Une figure en plusieurs morceaux[/titre]
Chaque carreau mesure 1 cm de côté. Pour l'aire de cette figure en L :
[grille lignes=4 colonnes=6 forme=6,6,3,3]
[cadre]Méthode 1, j'additionne : rectangle du haut 6 x 2 = 12, du bas 3 x 2 = 6. 12 + 6 = [b]18 cm²[/b].
Méthode 2, j'enlève : grand rectangle 6 x 4 = 24, moins le coin vide 3 x 2 = 6. 24 - 6 = [b]18 cm²[/b].[/cadre]""",
"""[titre]Même aire, autre périmètre[/titre]
[cadre]• Rectangle de 6 cm sur 2 cm : aire 6 x 2 = [b]12 cm²[/b], périmètre (6 + 2) x 2 = [b]16 cm[/b].
• Rectangle de 4 cm sur 3 cm : aire 4 x 3 = [b]12 cm²[/b], périmètre (4 + 3) x 2 = [b]14 cm[/b].[/cadre]
[cadre=astuce]Deux figures peuvent avoir la même aire et des périmètres différents.[/cadre]""",
"""[titre]Retrouver une longueur[/titre]
[cadre]• Un rectangle a une aire de [b]54 cm²[/b] et une largeur de [b]6 cm[/b].
Longueur : 54 : 6 = [b]9 cm[/b], car 9 x 6 = 54.
• Un carré a une aire de [b]49 cm²[/b]. Quel nombre fois lui-même fait 49 ? 7 x 7 = 49 : côté [b]7 cm[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Rectangle : longueur x largeur. Carré : côté x côté.
• Unités : cm², m², km². 1 m² = 10 000 cm².
• Figure en morceaux : j'additionne les rectangles, ou j'enlève ce qui manque.
• Même aire ne veut pas dire même périmètre.
• Longueur = aire : largeur.[/cadre]""",
])

# ---------------------------------------------------------------- 11. Volume
assert 4 * 3 * 2 == 24 and 11 * 7 * 2 == 154 and 14 * 5 * 10 == 700 and 3 ** 3 == 27 and 5 ** 3 == 125 and 10 ** 3 == 1000
add('volume', 'Le volume', [
"""[titre]Qu'est-ce que le volume ?[/titre]
Le [b]volume[/b], c'est la [b]place occupée[/b] par un objet. Je peux le mesurer en comptant des petits cubes.
[pave long=4 larg=3 haut=2]
[cadre]Ce pavé est fait de [b]24 petits cubes[/b].[/cadre]""",
"""[titre]Le centimètre cube[/titre]
Un cube de [b]1 cm d'arête[/b] a un volume de [b]1 centimètre cube[/b] : [b]1 cm³[/b] (ou cm3).
[pave long=4 larg=3 haut=2 unite=cm]
[cadre]Chaque petit cube fait 1 cm³ : le volume du pavé est de [b]24 cm³[/b].[/cadre]""",
"""[titre]Compter par couches[/titre]
Une couche du pavé : 4 cubes de long, 3 de large : 4 x 3 = [b]12 cubes[/b]. Il y a 2 couches : 12 x 2 = [b]24[/b].
[center][font_size=26][b]Volume = longueur x largeur x hauteur[/b][/font_size][/center]
[cadre]4 x 3 x 2 = [b]24 cm³[/b].[/cadre]""",
"""[titre]Un exemple[/titre]
Un pavé droit de [b]11 cm[/b] de long, [b]7 cm[/b] de large et [b]2 cm[/b] de haut :
[cadre]11 x 7 = 77, puis 77 x 2 = [b]154 cm³[/b].[/cadre]
[cadre=astuce]Je choisis l'ordre le plus facile : 14 x 5 x 10 → 14 x 5 = 70, puis 70 x 10 = [b]700 cm³[/b].[/cadre]""",
"""[titre]Le cube[/titre]
Un cube a ses 3 dimensions égales : [b]Volume = arête x arête x arête[/b].
[pave long=3 larg=3 haut=3 unite=cm]
[cadre]3 x 3 x 3 = [b]27 cm³[/b]. Un cube de 5 cm d'arête : 5 x 5 x 5 = [b]125 cm³[/b].[/cadre]""",
"""[titre]Volume et litres[/titre]
Un cube de [b]10 cm d'arête[/b] (1 dm) a un volume de 10 x 10 x 10 = [b]1000 cm³[/b].
[cadre]Il contient exactement [b]1 litre[/b] d'eau : 1 L = 1 dm³ = [b]1000 cm³[/b].
Une brique de lait de 1 L a donc un volume d'environ 1000 cm³.[/cadre]""",
f"""[titre]Longueur, aire ou volume ?[/titre]
{grid2(3, [H('Je mesure'), H('Unité'), H('Exemple'), Cc('une longueur'), Cc('[b]cm[/b]', 'classe'), Cc('le tour d\'un cahier'), Cc('une aire'), Cc('[b]cm²[/b]', 'classe'), Cc('la couverture du cahier'), Cc('un volume'), Cc('[b]cm³[/b]', 'classe'), Cc('une boîte à chaussures')])}
[cadre=astuce]cm : 1 dimension. cm² : 2 dimensions (longueur x largeur). cm³ : 3 dimensions.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le volume est la place occupée par un objet.
• 1 cm³ = le volume d'un cube de 1 cm d'arête.
• Pavé droit : longueur x largeur x hauteur. Cube : arête x arête x arête.
• Je multiplie dans l'ordre le plus facile.
• 1 L = 1 dm³ = 1000 cm³.[/cadre]""",
])

if __name__ == '__main__':
    # Usage : python3 gen_cmX_maths.py <dossier des .sql> [dossier apercu .txt]
    ecrire(CL, FICHES, sys.argv[1] if len(sys.argv) > 1 else '..', sys.argv[2] if len(sys.argv) > 2 else None)
