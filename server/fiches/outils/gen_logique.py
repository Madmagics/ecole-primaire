# Fiches de cours Logique CP -> CM2 (2026-10-03). Genere un script SQL par fiche + un script global
# (server/fiches/logique_toutes.sql) et un .txt par fiche pour la verification du rendu.
# Une fiche par couple notion + classe qui a des questions de logique publiees.
# Les exemples sont verifies par des assert.
import os
import sys
from logique_lib import rangee, ecarts, couleurs, grille3, tableau, alphabet, fiche_sql, sans_gras_emoji, couleur_alt

FICHES = []


def add(cl, code, titre, pages):
    FICHES.append((cl, code, titre, [couleur_alt(cl, p) for p in pages]))


def lettre(n):          # 1 -> A
    return chr(64 + n)


def rang(c):            # A -> 1
    return ord(c) - 64


def cesar(mot, k):
    return ''.join(chr(65 + (ord(c) - 65 + k) % 26) for c in mot)


# =====================================================================================  CP
add('cp', 'suites_logiques', 'Les suites logiques', [
f"""[titre]Un motif qui se répète[/titre]
Dans une suite, un même [b]morceau[/b] revient toujours dans le même ordre : c'est le [b]motif[/b].
{rangee(['■', '▲', '■', '▲', '■', '?'])}
[cadre]Le motif, c'est [b]■ ▲[/b]. Après ■ vient toujours ▲.
La réponse est [b]▲[/b].[/cadre]""",
f"""[titre]Un motif de 3[/titre]
{couleurs(['bleu', 'orange', 'violet', 'bleu', 'orange', 'violet'], trou_index=5)}
Je lis à voix haute : « bleu, orange, violet… bleu, orange… »
[cadre]Le motif a [b]3 couleurs[/b] : bleu, orange, violet.
Après orange vient [b]violet[/b].[/cadre]
[cadre=astuce]Je cherche où le motif [b]recommence[/b] : ici, quand le bleu revient.[/cadre]""",
f"""[titre]Des groupes qui grandissent[/titre]
{rangee(['🍐', '🍐🍐', '🍐🍐🍐', '?'], size=26)}
Je compte chaque groupe : [b]1[/b], puis [b]2[/b], puis [b]3[/b].
[cadre]À chaque groupe, on ajoute [b]1[/b] poire.
Le prochain groupe a [b]4[/b] poires.[/cadre]""",
"""[titre]Des nombres qui montent[/titre]
[center][font_size=30][b]2, 3, 4, 5, …[/b][/font_size][/center]
[file de=1 a=7 bonds=2:3,3:4,4:5,5:6]
[cadre]À chaque fois, j'avance de [b]1[/b] : c'est la règle [b]+1[/b].
Après 5 vient [b]6[/b].[/cadre]""",
"""[titre]Des nombres qui descendent[/titre]
[center][font_size=30][b]40, 38, 36, 34, …[/b][/font_size][/center]
[file de=31 a=41 bonds=40:38,38:36,36:34,34:32]
Les nombres sont de plus en plus [b]petits[/b] : je recule.
[cadre]De 40 à 38, je recule de [b]2[/b]. La règle est [b]-2[/b].
Après 34 vient [b]32[/b].[/cadre]""",
"""[titre]Reculer de 5 en 5[/titre]
[center][font_size=30][b]20, 15, 10, 5, …[/b][/font_size][/center]
[file de=0 a=20 pas=5 bonds=20:15,15:10,10:5,5:0]
[cadre]La règle est [b]-5[/b]. Après 5 vient [b]0[/b].[/cadre]
[cadre=astuce]Je regarde d'abord si les nombres [b]montent[/b] ou [b]descendent[/b].
S'ils montent, la réponse est plus grande. S'ils descendent, elle est plus petite.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Une suite suit toujours [b]une règle[/b].
• Avec des formes ou des couleurs, je cherche le [b]motif[/b] qui se répète.
• Avec des groupes, je [b]compte[/b] chaque groupe.
• Avec des nombres, je regarde de combien on avance ou on recule : [b]+1[/b], [b]+2[/b], [b]-2[/b], [b]-5[/b]…
• Je vérifie ma réponse avec la règle.[/cadre]""",
])

add('cp', 'analogies', 'Ce qui va ensemble', [
f"""[titre]Les contraires[/titre]
Le contraire, c'est le mot qui veut dire [b]tout l'inverse[/b].
{tableau(4, ['grand', 'petit', 'haut', 'bas', 'chaud', 'froid', 'plein', 'vide', 'content', 'triste', 'assis', 'debout', 'ouvert', 'fermé', 'rapide', 'lent'], size=22, paires=True)}
[cadre]Le contraire de [b]grand[/b], c'est [b]petit[/b]. Et le contraire de petit, c'est grand ![/cadre]""",
"""[titre]Trouver le contraire[/titre]
Pour trouver le contraire, je me fais un [b]petit film dans la tête[/b].
[cadre]Une boîte [b]pleine[/b] de bonbons… je mange tout… elle est [b]vide[/b] !
Le contraire de plein, c'est [b]vide[/b].[/cadre]
[cadre=astuce]Attention aux mots qui n'ont rien à voir : le contraire de [b]propre[/b] n'est pas « lourd », c'est [b]sale[/b].[/cadre]""",
f"""[titre]Les petits des animaux[/titre]
{tableau(4, ['🐱 le chat', 'le chaton', '🐶 le chien', 'le chiot', '🐮 la vache', 'le veau', '🐔 la poule', 'le poussin', '🐴 le cheval', 'le poulain', '🐑 le mouton', "l'agneau", '🐷 le cochon', 'le porcelet', '🐐 la chèvre', 'le chevreau'], size=20, paires=True)}
[cadre=astuce]Souvent, on entend le nom de l'animal : [b]lion[/b] → [b]lion[/b]ceau, [b]ours[/b] → [b]ours[/b]on, [b]lap[/b]in → [b]lap[/b]ereau.[/cadre]""",
f"""[titre]Les cris des animaux[/titre]
{tableau(4, ['🐶', 'ouaf', '🐱', 'miaou', '🐮', 'meuh', '🐔', 'cocorico', '🐑', 'bêê', '🦆', 'coincoin', '🐸', 'coa coa', '🐺', 'aouuuu'], size=22, paires=True)}
[cadre]Je fais le cri dans ma tête et j'imagine l'animal qui le fait.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le [b]contraire[/b], c'est le mot qui veut dire l'inverse : jour → nuit.
• Chaque animal a son [b]petit[/b] : le chat → le chaton.
• Chaque animal a son [b]cri[/b] : la vache fait « meuh ».
• Je cherche toujours ce qui [b]va ensemble[/b].[/cadre]""",
])

add('cp', 'intrus', "Trouver l'intrus", [
f"""[titre]L'intrus, c'est quoi ?[/titre]
L'intrus, c'est celui qui [b]n'est pas de la même famille[/b] que les autres.
{rangee(['🐱', '🐶', '🐰', '!🍎'], size=34)}
[cadre]🐱 🐶 🐰 sont des [b]animaux[/b]. 🍎 est un [b]fruit[/b].
L'intrus, c'est [b]🍎[/b].[/cadre]""",
f"""[titre]Les formes et les dessins[/titre]
{rangee(['■', '▲', '★', '!🐟'], size=34)}
[cadre]■ ▲ ★ sont des [b]formes[/b] : un carré, un triangle, une étoile.
🐟 est un [b]animal[/b] : c'est l'intrus.[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. Je [b]nomme[/b] chaque dessin dans ma tête.
2. Je cherche ce que [b]presque tous[/b] ont en commun : des animaux ? des formes ? des fruits ?
3. Celui qui n'est pas dans la famille, c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Il y a toujours [b]un seul[/b] intrus.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Les familles : les [b]animaux[/b], les [b]fruits[/b], les [b]formes[/b], les [b]objets[/b].
• L'intrus est celui qui n'est [b]pas de la même famille[/b].
• Je nomme chaque dessin avant de choisir.[/cadre]""",
])

add('cp', 'comparer', 'Comparer : le plus, le moins', [
f"""[titre]Je compte chacun[/titre]
[center]Léo a 🍋🍋🍋, Nina a 🍋🍋🍋🍋🍋.[/center]
{tableau(2, ['Léo', '3', 'Nina', '5'], entete=['Prénom', 'Citrons'], size=24)}
[cadre]Nina a [b]5[/b] citrons, Léo en a [b]3[/b].
5 est plus grand que 3 : c'est [b]Nina qui en a le plus[/b].[/cadre]""",
"""[titre]Le plus ou le moins ?[/titre]
Je lis bien la question : elle demande [b]le plus[/b] ou [b]le moins[/b] ?
[cadre][b]Le plus[/b] : celui qui en a [b]beaucoup[/b], le plus grand nombre.
[b]Le moins[/b] : celui qui en a [b]peu[/b], le plus petit nombre.[/cadre]
[cadre=astuce]Léo a 3 citrons, Nina en a 5.
Qui a [b]le moins[/b] de citrons ? C'est [b]Léo[/b] ![/cadre]""",
f"""[titre]Mettre en face[/titre]
Je peux aussi mettre les objets [b]face à face[/b], un par un.
{tableau(6, ['Léo', '🍋', '🍋', '🍋', ' ', ' ', 'Nina', '🍋', '🍋', '🍋', '🍋', '🍋'], size=24, lignes=True)}
[cadre]Chez Léo, il reste des cases vides : il en a [b]moins[/b].
Nina a des citrons en plus : elle en a [b]plus[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je [b]compte[/b] les objets de chaque enfant.
• [b]Le plus[/b] = le plus grand nombre. [b]Le moins[/b] = le plus petit nombre.
• S'ils en ont autant, c'est [b]pareil[/b].
• Je relis la question avant de répondre : le plus ou le moins ?[/cadre]""",
])

add('cp', 'classer', 'Classer : le plus grand, le plus petit', [
f"""[titre]Du plus petit au plus grand[/titre]
Je range les animaux selon leur taille [b]dans la vraie vie[/b].
{rangee(['🐝', '🐭', '🐱', '🐶', '🐴', '🐘'], size=30)}
[center][b]le plus petit  ———————→  le plus grand[/b][/center]
[cadre]L'abeille 🐝 est [b]la plus petite[/b]. L'éléphant 🐘 est [b]le plus grand[/b].[/cadre]""",
f"""[titre]Attention aux dessins ![/titre]
Sur l'écran, tous les dessins ont [b]la même taille[/b].
{rangee(['🐭', '🐘'], size=34)}
[cadre]Je ne regarde pas la taille du dessin.
J'imagine [b]le vrai animal[/b] : une souris tient dans la main, un éléphant est plus haut qu'une maison ![/cadre]""",
f"""[titre]Trouver le plus grand[/titre]
[center]Quel est l'animal le plus grand ?[/center]
{rangee(['🐔', '!🐻', '🐭', '🐸'], size=34)}
[cadre]1. J'imagine chaque animal pour de vrai.
2. Je les compare deux par deux : l'ours est plus grand que la poule.
3. Le plus grand, c'est [b]l'ours 🐻[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je pense à la taille des animaux [b]dans la vraie vie[/b].
• Le [b]plus petit[/b] est au début du rang, le [b]plus grand[/b] à la fin.
• Je relis la question : le plus grand ou le plus petit ?[/cadre]""",
])

# =====================================================================================  CE1
add('ce1', 'suites_logiques', 'Les suites logiques', [
f"""[titre]Trouver la longueur du motif[/titre]
{rangee(['🐝', '🐘', '🦊', '🐝', '🐘', '?'], size=30)}
Je cherche quand le [b]premier dessin revient[/b] : 🐝 revient en 4e position.
[cadre]Le motif a donc [b]3 dessins[/b] : 🐝 🐘 🦊.
Après 🐘 vient [b]🦊[/b].[/cadre]""",
f"""[titre]Couper la suite en morceaux[/titre]
{rangee(['♦', '★', '●', '♦', '★', '?'], size=30)}
[cadre]Je coupe : [b]♦ ★ ●[/b]  |  [b]♦ ★ ?[/b]
Les deux morceaux sont pareils : il manque [b]●[/b].[/cadre]
[cadre=astuce]Je vérifie que chaque morceau est [b]exactement le même[/b], dans le même ordre.[/cadre]""",
f"""[titre]Les suites de lettres[/titre]
{alphabet()}
[center][font_size=28][b]A, C, E, G, …[/b][/font_size][/center]
[cadre]De A à C, je [b]saute une lettre[/b] (B). De C à E, je saute D.
Après G, je saute H : la réponse est [b]I[/b].[/cadre]""",
"""[titre]Trouver l'écart[/titre]
Avec des nombres, je cherche [b]l'écart[/b] entre deux nombres qui se suivent.
[center][font_size=30][b]89, 85, 81, 77, …[/b][/font_size][/center]
[cadre]De 89 à 85, je recule de [b]4[/b]. De 85 à 81 : encore 4.
La règle est [b]-4[/b] : 77 - 4 = [b]73[/b].[/cadre]
[cadre=astuce]Je vérifie l'écart sur [b]deux paires[/b] de nombres, pas une seule.[/cadre]""",
f"""[titre]Des grands bonds[/titre]
{ecarts(['149', '169', '189', '209', '?'], ['+20', '+20', '+20', '+20'])}
[cadre]De 149 à 169, j'avance de [b]20[/b]. Seules les [b]dizaines[/b] changent : 4, 6, 8, puis 0 (et la centaine passe à 2).
209 + 20 = [b]229[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Formes et dessins : je trouve la [b]longueur du motif[/b] (quand le 1er revient).
• Lettres : je regarde combien de lettres on [b]saute[/b] dans l'alphabet.
• Nombres : je calcule [b]l'écart[/b] (+4, -4, +20…) et je le vérifie deux fois.
• Les nombres montent ? Ma réponse est plus grande. Ils descendent ? Elle est plus petite.[/cadre]""",
])

add('ce1', 'analogies', 'Ce qui va ensemble', [
f"""[titre]Les contraires[/titre]
{tableau(4, ['devant', 'derrière', 'acheter', 'vendre', 'ouvert', 'fermé', 'étroit', 'large', 'épais', 'mince', 'mouillé', 'sec', 'vieux', 'jeune', 'sombre', 'clair'], size=21, paires=True)}
[cadre]Le contraire veut dire [b]l'inverse[/b]. Je peux tester avec une phrase :
« La porte est [b]ouverte[/b]… non, elle est [b]fermée[/b]. »[/cadre]""",
f"""[titre]À quoi ça sert ?[/titre]
Chaque objet a une [b]utilité[/b] : il sert à faire quelque chose.
{tableau(4, ['la gomme', 'effacer', 'la règle', 'mesurer', 'la balance', 'peser', 'le marteau', 'clouer', 'la loupe', 'voir en plus gros', 'le sécateur', 'tailler les branches', 'le thermomètre', 'mesurer la température', 'la passoire', 'égoutter les pâtes'], size=19, paires=True)}""",
"""[titre]Trouver l'objet[/titre]
La question peut être posée [b]dans les deux sens[/b] :
[cadre]« La gomme sert à… » → [b]effacer[/b].
« Quel objet sert à effacer ? » → [b]la gomme[/b].[/cadre]
[cadre=astuce]Je m'imagine en train de faire l'action : pour [b]peser[/b] des pommes, je les pose sur… [b]la balance[/b] ![/cadre]""",
f"""[titre]Les petits des animaux[/titre]
{tableau(4, ["l'aigle", "l'aiglon", "l'âne", "l'ânon", 'le canard', 'le caneton', 'le cerf', 'le faon', 'le loup', 'le louveteau', 'la baleine', 'le baleineau', "l'oie", "l'oison", 'le lapin', 'le lapereau'], size=20, paires=True)}
[cadre]Le faon (petit du cerf) est un piège : on n'entend pas « cerf » dedans ![/cadre]""",
"""[titre]Dans l'autre sens[/titre]
[cadre]« Le petit de la vache est… » → [b]le veau[/b].
« Le veau est le petit de quel animal ? » → [b]la vache[/b].[/cadre]
[cadre=astuce]Je relis la question : on me demande [b]le petit[/b] ou [b]le parent[/b] ?[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Le [b]contraire[/b] dit l'inverse : acheter → vendre.
• Chaque objet [b]sert à[/b] quelque chose : le peigne sert à se coiffer.
• Chaque animal a son [b]petit[/b] : le loup → le louveteau.
• La question peut être posée dans les [b]deux sens[/b] : je relis bien.[/cadre]""",
])

add('ce1', 'intrus', "Trouver l'intrus", [
"""[titre]Bien lire la question[/titre]
Au CE1, la question dit [b]quelle famille[/b] chercher.
[cadre]« Quel nombre [b]n'est pas[/b] un multiple de 10 ? »
Je cherche le seul nombre qui [b]n'est pas[/b] dans la famille des multiples de 10.[/cadre]
[cadre=astuce]Le mot [b]« pas »[/b] est très important : je cherche celui qui ne va pas.[/cadre]""",
f"""[titre]Les multiples de 10 et de 5[/titre]
Un multiple de 10 se termine par [b]0[/b]. Un multiple de 5 se termine par [b]0 ou 5[/b].
{rangee(['140', '190', '!116', '170'], size=26)}
[cadre]140, 190 et 170 se terminent par 0. 116 se termine par 6 : c'est [b]l'intrus[/b].[/cadre]
[cadre=astuce]Je regarde seulement le [b]dernier chiffre[/b] (le chiffre des unités).[/cadre]""",
f"""[titre]Pair ou impair ?[/titre]
Pairs : se terminent par [b]0, 2, 4, 6, 8[/b]. Impairs : par [b]1, 3, 5, 7, 9[/b].
{rangee(['65', '!92', '41', '23'], size=26)}
[cadre]« Quel nombre n'est pas impair ? » 65, 41, 23 sont impairs.
92 se termine par 2 : il est pair, c'est [b]l'intrus[/b].[/cadre]""",
f"""[titre]Le nombre de pattes[/titre]
{tableau(2, ['🐭 🐰 🐶 🐸 🐷', '4 pattes', '🐔 🦆 🐦', '2 pattes (les oiseaux)', '🐝 🦋 🐞', '6 pattes (les insectes)', '🐟 🐍', 'pas de pattes'], size=20, paires=True)}
[cadre]« Lequel n'a pas 4 pattes ? 🐔 🐭 🐰 🐸 » → la poule [b]🐔[/b] n'a que 2 pattes.[/cadre]""",
f"""[titre]Animal, objet ou fruit ?[/titre]
{rangee(['🔑', '!🍊', '🎁', '🎈'], size=32)}
[cadre]« Quel élément n'est pas un objet ? » La clé, le cadeau et le ballon sont des objets.
L'orange [b]🍊[/b] est un fruit : c'est l'intrus.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je lis la famille demandée et le mot [b]« pas »[/b].
• Multiple de 10 : finit par [b]0[/b]. Multiple de 5 : finit par [b]0 ou 5[/b].
• Pair : finit par 0, 2, 4, 6, 8. Impair : par 1, 3, 5, 7, 9.
• Oiseaux : 2 pattes. Insectes : 6 pattes.
• Je vérifie chaque élément un par un.[/cadre]""",
])

# =====================================================================================  CE2
assert [14 + 10, 24 - 4, 20 + 10, 30 - 4, 26 + 10] == [24, 20, 30, 26, 36]
assert [79 + 3, 82 + 5, 87 + 3, 90 + 5, 95 + 3] == [82, 87, 90, 95, 98]
assert 144 * 2 == 288 and lettre(rang('J') + 3) == 'M' and lettre(rang('U') + 4) == 'Y'
add('ce2', 'suites_logiques', 'Les suites logiques', [
f"""[titre]J'écris les écarts[/titre]
Je note [b]sous la suite[/b] l'écart entre chaque nombre.
{ecarts(['12', '16', '18', '22', '24', '?'], ['+4', '+2', '+4', '+2', '+4'])}
[cadre]Les écarts ne sont pas toujours les mêmes : [b]+4, +2, +4, +2[/b]…
Ils [b]alternent[/b] ! Le prochain est +4 : 24 + 4 = [b]28[/b].[/cadre]""",
f"""[titre]Deux règles qui alternent[/titre]
{ecarts(['14', '24', '20', '30', '26', '?'], ['+10', '-4', '+10', '-4', '+10'])}
[cadre]On ajoute 10, puis on enlève 4, puis on ajoute 10… : 26 + 10 = [b]36[/b].[/cadre]
[cadre=astuce]Quand une suite monte puis descend, c'est souvent [b]deux règles qui alternent[/b].[/cadre]""",
f"""[titre]Doubler à chaque fois[/titre]
{ecarts(['18', '36', '72', '144', '?'], ['x 2', 'x 2', 'x 2', 'x 2'])}
[cadre]Les écarts grandissent très vite : 18, 36, 72… Chaque nombre est le [b]double[/b] du précédent.
144 x 2 = [b]288[/b].[/cadre]
[cadre=astuce]Dans l'autre sens (32, 16, 8, 4…), on prend la [b]moitié[/b] : la réponse est 2.[/cadre]""",
f"""[titre]Sauter des lettres[/titre]
{alphabet()}
[center][font_size=28][b]A, D, G, J, …[/b][/font_size][/center]
[cadre]Avec les nombres sous les lettres : A = 1, D = 4, G = 7, J = 10 : la règle est [b]+3[/b].
10 + 3 = 13, et la lettre n°13 est [b]M[/b].[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. Les nombres montent ? descendent ? montent [b]et[/b] descendent ?
2. J'écris tous les [b]écarts[/b] sous la suite.
3. Les écarts sont pareils → c'est la règle. Ils alternent → [b]deux règles[/b]. Ils grandissent très vite → peut-être [b]x 2[/b].
4. Je calcule la réponse et je vérifie.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• J'écris toujours les [b]écarts[/b] sous la suite.
• Des écarts qui reviennent (+10, -4, +10, -4) : [b]deux règles qui alternent[/b].
• Des nombres qui doublent : la règle est [b]x 2[/b] (ou la moitié s'ils diminuent).
• Lettres : je compte les lettres sautées, ou j'utilise A = 1, B = 2, C = 3…[/cadre]""",
])

add('ce2', 'analogies', 'Les analogies', [
"""[titre]Le même lien[/titre]
Une analogie, c'est retrouver [b]le même lien[/b] entre deux paires de mots.
[center][font_size=24][b]Le jour est à la nuit ce que le chaud est… au froid.[/b][/font_size][/center]
[cadre]Jour et nuit sont des [b]contraires[/b]. Il faut donc le contraire de chaud : [b]froid[/b].[/cadre]""",
f"""[titre]Où vivent les animaux ?[/titre]
{tableau(4, ["l'abeille", 'une ruche', 'la fourmi', 'une fourmilière', 'le castor', 'une hutte', 'le lapin', 'un terrier', "l'ours", 'une tanière', 'le cheval', 'une écurie', 'le mouton', 'une bergerie', 'le manchot', 'la banquise'], size=19, paires=True)}
[cadre=astuce]Le nom de la maison ressemble souvent au nom de l'animal : la [b]poule[/b] → le [b]poul[/b]ailler, le [b]pigeon[/b] → le [b]pigeon[/b]nier, la [b]guêpe[/b] → le [b]guêp[/b]ier.[/cadre]""",
f"""[titre]Comment se déplacent-ils ?[/titre]
{tableau(2, ["l'aigle, la mouche, la chauve-souris", 'vole', 'le dauphin, le requin, la truite', 'nage', 'le serpent, la chenille, le ver de terre', 'rampe', "l'escargot, la limace", 'glisse', 'la grenouille, la puce, la sauterelle', 'saute', 'le kangourou, le lièvre', 'bondit', 'le singe, le koala, la chèvre', 'grimpe', 'le cheval, le zèbre, le poney', 'galope'], size=18, paires=True)}""",
f"""[titre]D'autres contraires[/titre]
Les [b]verbes[/b] (entrer, allumer…) ont aussi des contraires, comme les mots qui décrivent (calme, ancien…).
{tableau(4, ['entrer', 'sortir', 'allumer', 'éteindre', 'attacher', 'détacher', 'accepter', 'refuser', 'avancer', 'reculer', 'calme', 'agité', 'ancien', 'moderne', 'épais', 'mince'], size=21, paires=True)}
[cadre=astuce]Parfois, il suffit d'ajouter [b]dé-[/b] : attacher → [b]dé[/b]tacher. Mais pas toujours : allumer → éteindre.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Une analogie : je trouve le [b]lien[/b] entre les deux premiers mots, puis je l'applique.
• Les liens possibles : [b]contraire[/b], [b]où il vit[/b], [b]comment il se déplace[/b]…
• La maison d'un animal ressemble souvent à son nom : la ruche, le poulailler.
• Je vérifie en faisant une phrase : « Le singe [b]grimpe[/b] aux arbres. »[/cadre]""",
])

add('ce2', 'intrus', "Trouver l'intrus", [
f"""[titre]Fruit ou légume ?[/titre]
{tableau(2, ['🍎 🍐 🍊 🍋 🍌 🍇 🍓', 'des fruits', '🍒 🍑 🍉 🍍 🥝 🥭 🍅', 'des fruits', '🥕 🥔 🧅 🥦 🥬', 'des légumes', '🥒 🍆 🌽', 'des légumes'], entete=['', 'Famille'], size=22, paires=True)}
[cadre=astuce]La [b]tomate[/b] 🍅 est un fruit : elle pousse à partir de la fleur et elle a des pépins.[/cadre]""",
f"""[titre]Trouver l'intrus[/titre]
[center]Lequel de ces aliments n'est pas un fruit ?[/center]
{rangee(['🍐', '🍇', '!🥦', '🍑'], size=34)}
[cadre]1. Je nomme chaque aliment : poire, raisin, brocoli, pêche.
2. Je classe : poire → fruit, raisin → fruit, brocoli → [b]légume[/b], pêche → fruit.
3. L'intrus est le [b]brocoli 🥦[/b].[/cadre]""",
f"""[titre]Attention à la question ![/titre]
[center]Lequel de ces aliments n'est pas un [b]légume[/b] ?[/center]
{rangee(['🌽', '🥬', '🧅', '!🍇'], size=34)}
[cadre]Cette fois, la famille, ce sont les [b]légumes[/b]. Le maïs, la salade et l'oignon en sont.
Le raisin [b]🍇[/b] est un fruit : c'est lui l'intrus.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je lis bien la famille demandée : [b]fruit[/b] ou [b]légume[/b] ?
• Je nomme chaque aliment avant de choisir.
• La tomate 🍅 est un fruit.
• Il n'y a qu'[b]un seul[/b] intrus : les trois autres sont de la même famille.[/cadre]""",
])

add('ce2', 'classer', 'Classer et ranger', [
f"""[titre]Je fais une échelle[/titre]
[center]Tom est plus grand que Léo. Léo est plus grand que Nolan.[/center]
{tableau(1, ['Tom', 'Léo', 'Nolan'], entete=['↑ le plus grand'], size=24)}
[center][b]↓ le plus petit[/b][/center]
[cadre]Je place les enfants du plus grand (en haut) au plus petit (en bas).
Le plus grand est [b]Tom[/b], le plus petit est [b]Nolan[/b].[/cadre]""",
"""[titre]Le prénom qui revient[/titre]
[cadre]« Tom est plus grand que [b]Léo[/b]. [b]Léo[/b] est plus grand que Nolan. »
Léo est dans les deux phrases : il est plus petit que Tom mais plus grand que Nolan.
Léo est donc [b]au milieu[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]deux fois[/b] est toujours celui du milieu.[/cadre]""",
"""[titre]Ni le plus grand, ni le plus petit[/titre]
« Qui n'est ni le plus grand, ni le plus petit ? »
[cadre]On cherche celui qui est [b]au milieu[/b] de l'échelle.
Avec Tom, Léo et Nolan, c'est [b]Léo[/b].[/cadre]
[cadre=astuce]Ce n'est jamais « impossible à savoir » : les deux phrases suffisent toujours à ranger les trois enfants.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je dessine une [b]échelle[/b] : le plus grand en haut, le plus petit en bas.
• Le prénom qui revient dans [b]les deux phrases[/b] est au milieu.
• « Ni le plus grand, ni le plus petit » = celui [b]du milieu[/b].[/cadre]""",
])

add('ce2', 'raisonnement', 'Raisonner et déduire', [
"""[titre]Si… alors…[/titre]
[cadre][b]Si[/b] le feu est vert, Nina avance.
Le feu [b]est[/b] vert.
[b]Donc[/b] Nina… [b]avance ![/b][/cadre]
La 1re phrase donne une [b]règle[/b]. La 2e dit que la condition est vraie.
Alors je peux en être sûr : la règle s'applique.""",
"""[titre]Recopier la règle[/titre]
[cadre]« S'il fait froid, Alice [b]met un manteau[/b]. Il fait froid. Donc Alice… »
La réponse est déjà écrite dans la règle : Alice [b]met un manteau[/b].[/cadre]
[cadre=astuce]Les autres réponses (« boit de l'eau fraîche », « ne fait rien ») sont peut-être possibles dans la vie, mais [b]la règle[/b] dit ce qui se passe.[/cadre]""",
f"""[titre]Tous les… sont des…[/titre]
[cadre]« [b]Tous[/b] les chats sont des animaux. Félix est un chat. Donc Félix est… [b]un animal[/b]. »[/cadre]
{tableau(1, ['les animaux', '🐱 les chats : Félix'], size=22)}
[center]La famille des chats est [b]rangée dans[/b] la famille des animaux.[/center]""",
"""[titre]Je retiens[/titre]
[cadre]• « [b]Si[/b] … alors … » : quand la condition est vraie, la suite arrive toujours.
• La réponse se trouve [b]dans la règle[/b] : je la recopie.
• « [b]Tous[/b] les X sont des Y » : un X est forcément un Y.
• Je réponds avec ce que dit le texte, pas avec ce que j'imagine.[/cadre]""",
])

POS = ['en haut à gauche', 'en haut au centre', 'en haut à droite',
       'au milieu à gauche', 'au centre', 'au milieu à droite',
       'en bas à gauche', 'en bas au centre', 'en bas à droite']
add('ce2', 'reperage_espace', "Se repérer dans l'espace", [
f"""[titre]Les 9 cases de la grille[/titre]
{grille3(POS, size=16, pad='padding=8,10,8,10')}
[cadre]Je dis d'abord la [b]ligne[/b] (en haut, au milieu, en bas), puis la [b]colonne[/b] (à gauche, au centre, à droite).
La case du milieu s'appelle simplement [b]au centre[/b].[/cadre]""",
f"""[titre]Déplacer vers le bas[/titre]
[center]Un objet est [b]en haut à droite[/b]. On le déplace de [b]2 cases vers le bas[/b].[/center]
{grille3(['', '', '●', '', '', '↓', '', '', '!●'], size=26)}
[cadre]Il descend dans [b]la même colonne[/b] : en haut → au milieu → en bas.
Il arrive [b]en bas à droite[/b].[/cadre]""",
f"""[titre]Déplacer vers la gauche[/titre]
[center]Un objet est [b]au milieu à droite[/b]. On le déplace de [b]1 case vers la gauche[/b].[/center]
{grille3(['', '', '', '', '!●', '● ←', '', '', ''], size=26)}
[cadre]Il reste sur [b]la même ligne[/b] et recule d'une case : il arrive [b]au centre[/b].[/cadre]
[cadre=astuce]La [b]gauche[/b], c'est le côté où l'on commence à lire une ligne.[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. Je pose mon doigt sur la case de départ.
2. Je compte les cases [b]une par une[/b] dans la bonne direction.
3. Haut ou bas : je change de [b]ligne[/b]. Gauche ou droite : je change de [b]colonne[/b].
4. Je dis la nouvelle position : la ligne, puis la colonne.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Une position = une [b]ligne[/b] + une [b]colonne[/b] : « en bas à gauche ».
• La case du milieu, c'est [b]au centre[/b].
• Vers le haut ou le bas : je reste dans la même colonne.
• Vers la gauche ou la droite : je reste sur la même ligne.[/cadre]""",
])

# =====================================================================================  CM1
assert [5 * 3, 15 + 2, 17 * 3, 51 + 2] == [15, 17, 51, 53]
assert [19 + 6, 25 - 8, 17 + 6, 23 - 8] == [25, 17, 23, 15]
assert [lettre(5 + 2 * i) + str(5 + 2 * i) for i in range(5)] == ['E5', 'G7', 'I9', 'K11', 'M13']
add('cm1', 'suites_logiques', 'Les suites logiques', [
f"""[titre]Une multiplication, puis une addition[/titre]
{ecarts(['5', '15', '17', '51', '?'], ['x 3', '+ 2', 'x 3', '+ 2'])}
[cadre]L'écart change sans arrêt (+10, +2, +34) : ce n'est pas une addition simple.
Je teste : 5 [b]x 3[/b] = 15, 15 [b]+ 2[/b] = 17, 17 [b]x 3[/b] = 51. Ensuite : 51 + 2 = [b]53[/b].[/cadre]""",
f"""[titre]Monter, descendre[/titre]
{ecarts(['19', '25', '17', '23', '?'], ['+ 6', '- 8', '+ 6', '- 8'])}
[cadre]La suite monte, puis descend : [b]+6 puis -8[/b], et ainsi de suite.
23 - 8 = [b]15[/b].[/cadre]
[cadre=astuce]Je vérifie ma règle sur [b]tous[/b] les nombres de la suite, pas seulement les deux premiers.[/cadre]""",
f"""[titre]Une lettre et un nombre[/titre]
[center][font_size=28][b]E5, G7, I9, K11, …[/b][/font_size][/center]
{tableau(5, ['E', 'G', 'I', 'K', '?', '5', '7', '9', '11', '?'], size=22, lignes=True)}
[cadre]Je sépare la suite en [b]deux suites[/b] : les lettres E, G, I, K (je saute une lettre) → [b]M[/b] ; les nombres +2 → [b]13[/b].
La réponse est [b]M13[/b].[/cadre]""",
"""[titre]Les nombres carrés[/titre]
Le [b]carré[/b] d'un nombre, c'est ce nombre multiplié [b]par lui-même[/b].
[grille lignes=3 colonnes=3]
[cadre]Le carré de 3 = 3 x 3 = [b]9[/b] : un carré de 3 cases sur 3 cases.
Les carrés : 1, 4, 9, 16, 25, 36, 49, 64, [b]81[/b] (9 x 9), 100.[/cadre]""",
"""[titre]Ma méthode[/titre]
[cadre]1. J'écris les écarts. Ils sont pareils ? C'est une addition ou une soustraction.
2. Ils alternent ? [b]Deux règles[/b] (+6 puis -8).
3. Ils grandissent vite ? Je teste une [b]multiplication[/b] (x 2, x 3…).
4. Lettres et nombres mélangés ? Je fais [b]deux suites séparées[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Une suite peut avoir [b]deux opérations[/b] qui alternent : x 3 puis + 2.
• Pour « E5, G7… », je traite les [b]lettres[/b] et les [b]nombres[/b] séparément.
• Le carré d'un nombre : ce nombre [b]x lui-même[/b] (9 x 9 = 81).
• Je vérifie ma règle sur toute la suite.[/cadre]""",
])

add('cm1', 'analogies', 'Les analogies : la partie et le tout', [
"""[titre]Lire une analogie[/titre]
[center][font_size=24][b]Le pétale est à la fleur ce que la feuille est… à l'arbre.[/b][/font_size][/center]
[cadre]Je trouve le lien entre les deux premiers mots : le pétale est [b]une partie[/b] de la fleur.
Je cherche de quoi la feuille est une partie : [b]de l'arbre[/b].[/cadre]""",
f"""[titre]Des parties et leur tout[/titre]
{tableau(4, ['la page', 'le livre', 'la touche', 'le piano', 'le wagon', 'le train', 'le maillon', 'la chaîne', 'la perle', 'le collier', 'la note', 'la mélodie', 'le pixel', "l'écran", 'la voile', 'le bateau', 'le rayon', 'la roue', "l'orteil", 'le pied'], entete=['La partie', 'Le tout', 'La partie', 'Le tout'], size=19, paires=True)}""",
"""[titre]Faire une phrase pour vérifier[/titre]
[cadre]« La touche est au piano ce que la voile est… »
Je dis : « La touche est [b]une partie du[/b] piano. La voile est [b]une partie du[/b]… [b]bateau[/b]. »
La phrase marche : la réponse est [b]au bateau[/b].[/cadre]
[cadre=astuce]Piège : une réponse peut reprendre un mot du début (« à la fleur »). Elle est fausse : il faut le tout du [b]troisième[/b] mot.[/cadre]""",
"""[titre]au, à la, à l'[/titre]
La réponse commence par [b]à[/b] + le nom :
[cadre]à + le bateau → [b]au[/b] bateau
à + la chaîne → [b]à la[/b] chaîne
à + l'écran → [b]à l'[/b]écran[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• « A est à B ce que C est à … » : je trouve le [b]lien entre A et B[/b], puis je l'applique à C.
• Ici, le lien est souvent : A est [b]une partie[/b] de B.
• Je vérifie avec une phrase : « La page est une partie du livre. »
• au = à + le.[/cadre]""",
])

add('cm1', 'classer', 'Classer et ranger', [
"""[titre]Plus âgé, plus jeune[/titre]
[cadre]Plus [b]âgé[/b] = plus vieux, né [b]avant[/b].
Plus [b]jeune[/b] = moins vieux, né [b]après[/b].[/cadre]
Ce sont des [b]contraires[/b] : si Emma est plus âgée que Sarah, alors Sarah est plus jeune qu'Emma.""",
"""[titre]Tout dire dans le même sens[/titre]
[center]Camille est plus âgée que Sarah. Emma est plus jeune que Sarah.[/center]
[cadre]Les deux phrases ne vont pas dans le même sens. Je retourne la 2e :
« Emma est plus jeune que Sarah » = « Sarah est [b]plus âgée[/b] qu'Emma ».
Donc : [b]Camille[/b] > Sarah > Emma.[/cadre]""",
f"""[titre]Je range sur une frise[/titre]
{tableau(3, ['Camille', 'Sarah', 'Emma'], entete=['la plus âgée', 'au milieu', 'la plus jeune'], size=24)}
[cadre]Qui est le plus âgé ? [b]Camille[/b]. Qui est le plus jeune ? [b]Emma[/b].[/cadre]
[cadre=astuce]Le prénom qui apparaît [b]dans les deux phrases[/b] est toujours au milieu.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Plus âgé et plus jeune sont des [b]contraires[/b].
• Je retourne une phrase pour que les deux disent [b]la même chose[/b] (plus âgé que…).
• Je range les prénoms sur une frise, du plus âgé au plus jeune.
• Le prénom qui revient deux fois est [b]au milieu[/b].[/cadre]""",
])

add('cm1', 'raisonnement', 'Raisonner et déduire', [
"""[titre]Avant, après[/titre]
[cadre]Dans une course, arriver [b]avant[/b] quelqu'un, c'est arriver [b]plus tôt[/b] : on est devant lui au classement.[/cadre]
[center]Inès arrive avant Hugo. Hugo arrive avant Lucas.[/center]
Inès est devant Hugo, et Hugo est devant Lucas.""",
f"""[titre]Je fais le podium[/titre]
{tableau(3, ['Inès', 'Hugo', 'Lucas'], entete=['1er', '2e', '3e (dernier)'], size=24)}
[cadre]Qui arrive en premier ? [b]Inès[/b]. En 2e position ? [b]Hugo[/b]. En dernier ? [b]Lucas[/b].[/cadre]""",
"""[titre]Si l'ordre est mélangé[/titre]
[center]Hugo arrive avant Lucas. Inès arrive avant Hugo.[/center]
[cadre]Les phrases ne sont pas dans l'ordre, mais je fais pareil :
je place d'abord Hugo devant Lucas, puis Inès devant Hugo : [b]Inès, Hugo, Lucas[/b].[/cadre]
[cadre=astuce]Je commence toujours par le prénom qui apparaît [b]deux fois[/b] : il est 2e.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Arriver [b]avant[/b] = être devant au classement.
• J'écris le classement : 1er, 2e, 3e.
• Le prénom cité dans [b]les deux phrases[/b] est en 2e position.
• Je relis la question : premier, 2e ou dernier ?[/cadre]""",
])

assert sum(rang(c) for c in 'PAIN') == 40 and sum(rang(c) for c in 'ROSE') == 57
add('cm1', 'codes', 'Les codes secrets', [
f"""[titre]Le code A = 1, B = 2…[/titre]
Chaque lettre a un numéro : [b]sa place dans l'alphabet[/b].
{alphabet(0, 13, size=20)}
{alphabet(13, 26, size=20)}""",
"""[titre]Des repères pour aller vite[/titre]
[cadre]Je retiens quelques lettres : [b]E = 5[/b], [b]J = 10[/b], [b]O = 15[/b], [b]T = 20[/b], [b]Y = 25[/b].
Puis je compte à partir du repère le plus proche.[/cadre]
[cadre=astuce]U = ? → T = 20, donc U = [b]21[/b].
22 = ? → 20 = T, 21 = U, 22 = [b]V[/b].[/cadre]""",
f"""[titre]La somme d'un mot[/titre]
[center][font_size=24][b]PAIN[/b][/font_size][/center]
{tableau(4, ['P', 'A', 'I', 'N', '16', '1', '9', '14'], size=24, lignes=True)}
[cadre]16 + 1 + 9 + 14 = [b]40[/b]. La somme des lettres de PAIN est [b]40[/b].[/cadre]
[cadre=astuce]J'additionne en regroupant : 16 + 14 = 30, puis 30 + 1 + 9 = 40.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Dans ce code, chaque lettre vaut [b]sa place dans l'alphabet[/b] : A = 1, Z = 26.
• Repères : E = 5, J = 10, O = 15, T = 20, Y = 25.
• Somme d'un mot : je remplace chaque lettre par son nombre, puis j'additionne.
• Je vérifie mon addition une deuxième fois.[/cadre]""",
])

add('cm1', 'grilles', 'Les grilles à compléter', [
f"""[titre]La règle de la grille[/titre]
{grille3(['▲', '●', '■', '●', '■', '▲', '■', '▲', '●'])}
[cadre]Chaque symbole apparaît [b]une seule fois[/b] dans chaque ligne et [b]une seule fois[/b] dans chaque colonne.[/cadre]""",
f"""[titre]Ce qui manque dans la ligne[/titre]
{grille3(['▲', '●', '■', '●', '■', '▲', '?', '▲', '●'])}
[cadre]Dans la 3e ligne, il y a déjà ▲ et ●. Il manque [b]■[/b].[/cadre]""",
f"""[titre]Je vérifie avec la colonne[/titre]
{grille3(['▲', '●', '■', '●', '■', '▲', '!■', '▲', '●'])}
[cadre]Dans la 1re colonne : ▲, ●, et ma réponse ■. Les trois sont différents : [b]c'est juste ![/b][/cadre]
[cadre=astuce]On voit aussi que chaque ligne est la ligne d'avant [b]décalée d'une case[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Chaque symbole : [b]une fois[/b] par ligne et [b]une fois[/b] par colonne.
• Je regarde la ligne de la case vide : quel symbole manque ?
• Je vérifie avec la colonne.[/cadre]""",
])

# =====================================================================================  CM2
assert [2 + 6, 6 + 8, 8 + 14, 14 + 22] == [8, 14, 22, 36]
assert [x * 3 + 3 for x in (1, 6, 21, 66)] == [6, 21, 66, 201]
assert [x * 2 + 5 for x in (4, 13, 31, 67)] == [13, 31, 67, 139]
add('cm2', 'suites_logiques', 'Les suites logiques', [
f"""[titre]La somme des deux précédents[/titre]
{ecarts(['2', '6', '8', '14', '22', '?'], ['+4', '+2', '+6', '+8'])}
[cadre]Les écarts ne suivent pas de règle simple. Je regarde autrement :
2 + 6 = [b]8[/b], 6 + 8 = [b]14[/b], 8 + 14 = [b]22[/b]. Chaque nombre est la [b]somme des deux d'avant[/b].
14 + 22 = [b]36[/b].[/cadre]""",
f"""[titre]Multiplier puis ajouter[/titre]
{ecarts(['4', '13', '31', '67', '?'], ['x 2 + 5', 'x 2 + 5', 'x 2 + 5', 'x 2 + 5'], size=24)}
[cadre]Les nombres font un peu plus que [b]doubler[/b]. Je teste x 2 : 4 x 2 = 8, et il reste [b]5[/b] pour arriver à 13.
Je vérifie : 13 x 2 + 5 = 31 ✓, 31 x 2 + 5 = 67 ✓. Donc 67 x 2 + 5 = [b]139[/b].[/cadre]""",
"""[titre]Une règle cachée : x 3 + 3[/titre]
[center][font_size=28][b]1, 6, 21, 66, …[/b][/font_size][/center]
[cadre]Ça grandit d'environ [b]3 fois[/b] : je teste x 3.
1 x 3 = 3 → il manque 3 pour faire 6. 6 x 3 = 18 → il manque 3 pour 21. La règle : [b]x 3 + 3[/b].
66 x 3 + 3 = [b]201[/b].[/cadre]
[cadre=astuce]Je divise un nombre par le précédent (66 ÷ 21 ≈ 3) pour deviner le « x ».[/cadre]""",
f"""[titre]Deux suites mélangées[/titre]
[center][font_size=28][b]4, 22, 6, 21, 8, …[/b][/font_size][/center]
{tableau(4, ['1re, 3e, 5e place', '4', '6', '8', '2e, 4e, 6e place', '22', '21', '?'], size=22, lignes=True)}
[cadre]Un nombre sur deux forme une suite : 4, 6, 8 (+2) et 22, 21 (-1).
La 6e place continue la 2e suite : 21 - 1 = [b]20[/b].[/cadre]""",
"""[titre]Ma méthode, dans l'ordre[/titre]
[cadre]1. J'écris les écarts : sont-ils pareils ou alternés ?
2. Les nombres sautent (petit, grand, petit…) ? → [b]deux suites mélangées[/b].
3. Chaque nombre = les deux précédents additionnés ?
4. Ça grandit très vite ? → je teste [b]x 2[/b] ou [b]x 3[/b], puis je regarde ce qu'il faut ajouter.
5. Je vérifie la règle sur [b]tous[/b] les nombres.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Somme des deux précédents : 2, 6, 8, 14, 22, 36…
• Règle « [b]x k + c[/b] » : je devine le x en comparant deux nombres, puis je trouve ce qu'il faut ajouter.
• Deux suites mélangées : je regarde [b]un nombre sur deux[/b].
• Une règle n'est bonne que si elle marche pour [b]toute[/b] la suite.[/cadre]""",
])

add('cm2', 'analogies', 'Les analogies : à quoi ça sert ?', [
"""[titre]Le lien : ce qu'on en fait[/titre]
[center][font_size=24][b]Le stylo est à écrire ce que le livre est… à lire.[/b][/font_size][/center]
[cadre]Le lien entre « stylo » et « écrire » : le stylo [b]sert à[/b] écrire.
Je cherche à quoi sert le livre : [b]à lire[/b].[/cadre]""",
f"""[titre]Des objets et leur action[/titre]
{tableau(4, ['le vélo', 'pédaler', 'la voiture', 'conduire', 'la porte', 'ouvrir', 'la valise', 'porter', 'le feu', 'éteindre', 'la graine', 'planter', 'le puzzle', 'assembler', 'le linge', 'laver', 'la musique', 'écouter', 'le film', 'regarder'], entete=['Le nom', "L'action", 'Le nom', "L'action"], size=19, paires=True)}""",
"""[titre]Choisir la meilleure action[/titre]
Un objet peut servir à plusieurs choses. Je choisis l'action [b]la plus naturelle[/b], celle qu'on dit en premier.
[cadre]« La voiture est à conduire ce que le stylo est… »
à écrire ✓   à chanter ✗   à porter ✗   à prendre ✗[/cadre]
[cadre=astuce]Je fais une phrase : « On [b]conduit[/b] une voiture, on [b]écrit[/b] avec un stylo. »[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je trouve le [b]lien[/b] entre le 1er et le 2e mot : ici, ce à quoi sert l'objet.
• J'applique le même lien au 3e mot.
• Je choisis l'action la plus [b]naturelle[/b] et je vérifie avec une phrase.
• Au CM1, le lien était « une partie de » ; au CM2, c'est souvent « [b]sert à[/b] ».[/cadre]""",
])

add('cm2', 'raisonnement', 'Raisonner et déduire', [
"""[titre]Vérité ou mensonge ?[/titre]
Sur une île, [b]Léa dit toujours la vérité[/b] et [b]Kim ment toujours[/b].
[cadre]Quelqu'un dit : « La porte est ouverte. » Mais la porte est [b]fermée[/b].
La phrase est [b]fausse[/b] : seul un menteur peut la dire. C'est [b]Kim[/b].[/cadre]
[cadre=astuce]Phrase [b]vraie[/b] → celui qui dit la vérité. Phrase [b]fausse[/b] → le menteur.[/cadre]""",
f"""[titre]Le tableau de déduction[/titre]
[center]Manon, Léo et Emma aiment chacun une couleur différente : bleu, rouge, vert.
Manon aime le bleu. Léo n'aime pas le vert.[/center]
{tableau(4, ['Manon', '✓', '✗', '✗', 'Léo', '✗', '?', '✗', 'Emma', '✗', '?', '?'], entete=['', 'bleu', 'rouge', 'vert'], size=22)}""",
f"""[titre]Je complète le tableau[/titre]
{tableau(4, ['Manon', '✓', '✗', '✗', 'Léo', '✗', '✓', '✗', 'Emma', '✗', '✗', '✓'], entete=['', 'bleu', 'rouge', 'vert'], size=22)}
[cadre]1. Manon a le bleu : personne d'autre ne l'a.
2. Léo n'a ni le bleu ni le vert : il a forcément [b]le rouge[/b].
3. Il ne reste que le vert : c'est [b]Emma[/b] qui aime le vert.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Vérité/mensonge : je regarde si la phrase est [b]vraie ou fausse[/b] dans la réalité.
• Pour répartir des choses, je fais un [b]tableau[/b] avec ✓ et ✗.
• Un ✓ dans une case → des ✗ dans le reste de sa ligne et de sa colonne.
• Quand il ne reste qu'une case possible, c'est la réponse.[/cadre]""",
])

assert cesar('LAC', 3) == 'ODF' and cesar('MAIN', 3) == 'PDLQ' and cesar('PAIN', 1) == 'QBJO'
add('cm2', 'codes', 'Les codes secrets', [
f"""[titre]Le code par décalage[/titre]
Avec un [b]décalage de +3[/b], chaque lettre est remplacée par celle qui est [b]3 places plus loin[/b].
{alphabet(0, 13, decale=3, size=20)}
{alphabet(13, 26, decale=3, size=20)}
[center]A devient D, B devient E, C devient F…[/center]""",
f"""[titre]Coder un mot[/titre]
[center][font_size=24][b]LAC avec +3[/b][/font_size][/center]
{tableau(3, ['L', 'A', 'C', '↓ +3', '↓ +3', '↓ +3', 'O', 'D', 'F'], size=24)}
[cadre]Je code [b]chaque lettre[/b], l'une après l'autre : L → M, N, [b]O[/b]. LAC devient [b]ODF[/b].[/cadre]""",
"""[titre]Éviter les pièges[/titre]
[cadre]• Je garde [b]l'ordre des lettres[/b] : FDO est le bon code à l'envers, donc faux !
• J'avance du [b]bon nombre[/b] de places : +2 et +3 donnent des codes différents.
• Après Z, on recommence à A : avec +3, X → A, Y → B, Z → C.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Décalage de +k : chaque lettre avance de [b]k places[/b] dans l'alphabet.
• Je code les lettres [b]une par une[/b], dans l'ordre.
• Pour décoder, je [b]recule[/b] du même nombre de places.
• Après Z, je repars à A.[/cadre]""",
])

add('cm2', 'grilles', 'Les grilles à compléter', [
f"""[titre]Regarder les lignes[/titre]
{grille3(['2', '6', '10', '3', '?', '11', '4', '8', '12'])}
[cadre]1re ligne : 2, 6, 10 → [b]+4[/b] à chaque case. 3e ligne : 4, 8, 12 → [b]+4[/b] aussi.
La 2e ligne suit la même règle : 3 + 4 = [b]7[/b], et 7 + 4 = 11 ✓.[/cadre]""",
f"""[titre]Vérifier avec les colonnes[/titre]
{grille3(['2', '6', '10', '3', '!7', '11', '4', '8', '12'])}
[cadre]Colonne du milieu : 6, [b]7[/b], 8 → +1 à chaque case. ✓
Les lignes et les colonnes sont d'accord : la réponse est [b]7[/b].[/cadre]""",
f"""[titre]Un autre exemple[/titre]
{grille3(['2', '5', '8', '6', '9', '?', '10', '13', '16'])}
[cadre]Lignes : [b]+3[/b] (2, 5, 8). Colonnes : [b]+4[/b] (2, 6, 10).
Ligne : 9 + 3 = 12. Colonne : 8 + 4 = 12. La réponse est [b]12[/b].[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Je cherche la règle d'une [b]ligne complète[/b] (+3, +4…).
• Je l'applique à la ligne de la case vide.
• Je vérifie avec la [b]colonne[/b] : les deux calculs doivent donner le même nombre.[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
TXT = sys.argv[2] if len(sys.argv) > 2 else None
toutes = ['-- Toutes les fiches de cours Logique CP -> CM2 (2026-10-03), une seule transaction.', 'begin;']
for cl, code, titre, pages in FICHES:
    sql = fiche_sql(cl, code, titre, pages)
    with open(os.path.join(OUT, f'logique_{cl}_{code}.sql'), 'w', encoding='utf-8') as f:
        f.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{cl}_{code}.txt'), 'w', encoding='utf-8') as f:
            f.write(sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages)))
    print(cl, code, titre, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'logique_toutes.sql'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(toutes) + '\n')
print(len(FICHES), 'fiches')
