# AUDITS_LOG #36 (2026-10-03) : anglais CP, pas de pluriel au programme -> noms comptables au singulier avec article.
# Les pluriels lexicaux (yeux, mains, ciseaux...) restent : ce sont des mots appris tels quels.
import re, random, collections

rows = [l.rstrip('\n').split('\t') for l in open('q.tsv', encoding='utf-8')]
# fr singulier, genre, fr pluriel, en singulier, en pluriel
NOMS = [('pomme', 'f', 'pommes', 'apple', 'apples'), ('banane', 'f', 'bananes', 'banana', 'bananas'),
        ('oeuf', 'm', 'oeufs', 'egg', 'eggs'), ('gâteau', 'm', 'gâteaux', 'cake', 'cakes'),
        ('crayon', 'm', 'crayons', 'pencil', 'pencils'), ('gomme', 'f', 'gommes', 'rubber', 'rubbers'),
        ('règle', 'f', 'règles', 'ruler', 'rulers'), ('livre', 'm', 'livres', 'book', 'books'),
        ('stylo', 'm', 'stylos', 'pen', 'pens'), ('chat', 'm', 'chats', 'cat', 'cats'),
        ('chien', 'm', 'chiens', 'dog', 'dogs'), ('lapin', 'm', 'lapins', 'rabbit', 'rabbits'),
        ('oiseau', 'm', 'oiseaux', 'bird', 'birds'), ('vache', 'f', 'vaches', 'cow', 'cows'),
        ('cochon', 'm', 'cochons', 'pig', 'pigs'), ('canard', 'm', 'canards', 'duck', 'ducks'),
        ('grenouille', 'f', 'grenouilles', 'frog', 'frogs'), ('souris', 'f', 'souris', 'mouse', 'mice'),
        ('poisson', 'm', 'poissons', 'fish', 'fish'), ('cheval', 'm', 'chevaux', 'horse', 'horses'),
        ('mouton', 'm', 'moutons', 'sheep', 'sheep')]
FRP = {n[2]: n for n in NOMS}
ENP = {n[4]: n for n in NOMS}
un = lambda n: ('une ' if n[1] == 'f' else 'un ') + n[0]
a = lambda n: ('an ' if n[3][0] in 'aeiou' else 'a ') + n[3]
PL_EN = '|'.join(sorted({n[4] for n in NOMS if n[4] != n[3]}, key=len, reverse=True))   # pluriels visibles


def conv(s):
    """Version singuliere d'un texte (enonce, reponse ou choix), ou None si rien a convertir."""
    m = re.fullmatch(r'des (.+)', s)
    if m and m.group(1) in FRP: return un(FRP[m.group(1)])
    if s in ENP and s not in ('fish', 'sheep'): return a(ENP[s])
    m = re.fullmatch(r"j'ai deux (.+)", s)
    if m and m.group(1) in FRP: return "j'ai " + un(FRP[m.group(1)])
    m = re.fullmatch(r"I have two (.+)", s)
    if m and m.group(1) in ENP: return 'I have ' + a(ENP[m.group(1)])
    m = re.fullmatch(r"je vois deux (.+)", s)
    if m and m.group(1) in FRP: return 'je vois ' + un(FRP[m.group(1)])
    m = re.fullmatch(r"I see two (.+)", s)
    if m and m.group(1) in ENP: return 'I see ' + a(ENP[m.group(1)])
    return None


def pluriel_comptable(s):
    """Vrai si le texte contient un pluriel de nom comptable (y compris fish/sheep apres les/des)."""
    if re.search(rf'\b({PL_EN})\b', s): return True
    if re.search(r'\b(les|des|deux) (' + '|'.join(FRP) + r')\b', s): return True
    if re.search(r'\b(like|two) (fish|sheep)\b', s): return True
    return False


q = lambda s: s.replace("'", "''")
enon_q = lambda sens, x: f'Comment dit-on "{x}" en anglais ?' if sens == 'fr' else f'Que veut dire "{x}" en français ?'
sql = ['-- AUDITS_LOG #36 (2026-10-03) : anglais CP, noms comptables ramenes au singulier (pas de pluriel au programme du CP).', 'begin;']
stats = collections.Counter(); ex = []
cp = [r for r in rows if r[1] == 'cp']
vus = {(r[2], r[3], r[4]) for r in cp}
for i, cl, code, e, b, d in cp:
    d = d.split('|')
    m1 = re.match(r'Comment dit-on "(.+)" en anglais \?$', e); m2 = re.match(r'Que veut dire "(.+)" en français \?$', e)
    if not (m1 or m2): continue
    cible = (m1 or m2).group(1)
    tout = [cible, b] + d
    if not any(pluriel_comptable(x) for x in tout):
        continue
    nc, nb = conv(cible), conv(b)
    if nc and nb:
        # les choix : convertis un par un ; un choix non convertible et pluriel est remplace plus bas
        nd = [conv(x) or x for x in d]
    elif not pluriel_comptable(cible) and not pluriel_comptable(b):
        nc, nb, nd = cible, b, list(d)          # seule une mauvaise reponse est au pluriel (ex. "I like rabbits")
    else:
        sql.append(f"update contenu_questions set statut = 'archive', modifie_le = now() where id = {i};")
        stats['archivees (pluriel generique : j\'aime les pommes...)'] += 1; ex.append(('ARCH', code, e, b)); continue
    sens = 'fr' if m1 else 'en'
    enon = enon_q(sens, nc)
    # remplacement des choix encore au pluriel ou en double, par des choix de meme forme pris dans la meme notion
    pool = []
    for r in cp:
        if r[2] != code: continue
        for x in [r[4]] + r[5].split('|'):
            y = conv(x) or x
            if not pluriel_comptable(y) and y not in pool: pool.append(y)
    forme = lambda x: (x.split()[0] if ' ' in x else '', len(x.split()))
    rnd = random.Random(int(i))
    out = []
    for x in nd:
        if pluriel_comptable(x) or x == nb or x in out:
            cands = [y for y in pool if y != nb and y not in out and y not in nd and forme(y) == forme(nb)]
            if not cands:
                cands = [y for y in pool if y != nb and y not in out and y not in nd]
            x = rnd.choice(cands)
        out.append(x)
    cle = (code, enon, nb)
    if cle in vus and (code, e, b) != cle:
        sql.append(f"update contenu_questions set statut = 'archive', modifie_le = now() where id = {i};")
        stats['archivees (doublon apres conversion)'] += 1; continue
    vus.add(cle)
    sql.append(f"update contenu_questions set enonce = '{q(enon)}', bonne_reponse = '{q(nb)}', mauvais_choix = array[{','.join(chr(39) + q(x) + chr(39) for x in out)}], modifie_le = now() where id = {i};")
    stats['converties'] += 1
    ex.append((code, e, b, d, '=>', enon, nb, out))
# Petites anomalies vues en rangeant le vocabulaire des fiches
sql.append("update contenu_questions set statut = 'archive', modifie_le = now() where id = 20021;")   # "des souriss", doublon de 20303
for i in (19297, 19298, 22327, 22328):   # "voler" range dans les animaux, "forêt" range dans comparer
    sql.append(f"update contenu_questions set statut = 'archive', modifie_le = now() where id = {i};")
stats['anomalies hors CP'] = 5
sql += ['commit;', 'select fn_publier();']
open('correctifs_2026-10-03_anglais_cp_singulier.sql', 'w', encoding='utf-8').write('\n'.join(sql) + '\n')
for k, v in stats.items(): print(v, k)
for x in ex: print(*x)
