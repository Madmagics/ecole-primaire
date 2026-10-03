# Correction AUDITS_LOG #32 (2026-10-03) : mauvaises reponses trop faciles a ecarter.
#  A. orthographe_mots CM1/CM2 : vraies fautes d'orthographe + mots en double remplaces par de nouveaux mots
#  B. formation_mots CM2 : questions "Que signifie le prefixe..." refaites avec des sens courts
#  C. masculin_feminin CE1 (orthographe + grammaire) : fautes realistes au lieu de "louveee"
#  D. homophones CM2 : "Kan" remplace
import random
import re
from variantes import fautes, est_mot
from mots_nouveaux import MOTS

rows = [l.rstrip('\n').split('\t') for l in open('avant.tsv', encoding='utf-8')]
UPD = {}   # id -> (enonce, bonne, [mauvais])
rnd = random.Random(32)

# ---------------------------------------------------------------- A. orthographe_mots
pool_txt = MOTS.split('abondance')
basiques = pool_txt[0].split()
avances = ('abondance ' + pool_txt[1]).split()
utilises_global = set()
for cl in ('cm1', 'cm2'):
    lignes = [r for r in rows if r[3] == 'orthographe_mots' and r[1] == cl and r[4] == 'Quelle est la bonne orthographe ?']
    deja = set(r[5] for r in lignes)
    if cl == 'cm1':
        cands = basiques + avances
    else:
        cands = avances + sorted(basiques, key=len, reverse=True)
    cands = [m for m in cands if m in __import__('variantes').DICO and m not in deja]
    vus = set()
    utilises_global = set()
    for r in lignes:
        w = r[5]
        f = fautes(w)
        if w in vus or len(f) < 3:
            while True:
                nw = cands.pop(0)
                if nw in vus or nw in utilises_global:
                    continue
                f = fautes(nw)
                if len(f) == 3:
                    break
            w = nw
            utilises_global.add(w)
        vus.add(w)
        UPD[r[0]] = (r[4], w, f)

# verbes et mots a definition : faites a la main (1990 : j'etiquete / j'epele sont admis -> jamais proposes)
UPD['11107'] = ('Comment écrit-on le verbe "appeler" avec "je" au présent ?', "j'appelle", ["j'apelle", "j'appèle", "j'appel"])
UPD['11108'] = ('Comment écrit-on le verbe "jeter" avec "je" au présent ?', 'je jette', ['je jète', 'je jete', 'je jet'])
UPD['36073'] = ('Comment écrit-on le verbe "étiqueter" avec "je" au présent ?', "j'étiquette", ["j'étiquete", "je étiquette", "j'étiquètte"])
UPD['36074'] = ('Comment écrit-on le verbe "épeler" avec "je" au présent ?', "j'épelle", ["j'épele", "je épelle", "j'épel"])

# ---------------------------------------------------------------- B. formation_mots (prefixes)
SENS = {'re-': 'de nouveau', 'dé-': 'le contraire de', 'de-': 'le contraire de', 'in-': 'le contraire de', 'im-': 'le contraire de',
        'il-': 'le contraire de', 'ir-': 'le contraire de', 'mé-': 'le contraire de', 'sous-': 'en dessous de',
        'anti-': 'contre', 'pré-': 'avant', 'post-': 'après', 'trans-': 'à travers', 'multi-': 'plusieurs',
        'mono-': 'un seul', 'bi-': 'deux'}
TOUS = ['de nouveau', 'le contraire de', 'avant', 'après', 'contre', 'à travers', 'en dessous de', 'au-dessus de',
        'plusieurs', 'un seul', 'deux', 'en trop']
for r in rows:
    if r[3] != 'formation_mots':
        continue
    m = re.match(r'Que signifie le préfixe "([^"]+)" dans "([^"]+)" \?', r[4])
    if m:
        pre, mot = m.groups()
        if pre == 'de-':
            pre = 'dé-'
        sens = SENS.get(pre) or ('au-dessus de' if mot == 'survoler' else 'en trop')
        exclus = {sens, 'au-dessus de', 'en trop'} if pre == 'sur-' else {sens}
        dist = random.Random(r[0]).sample([x for x in TOUS if x not in exclus], 3)
        UPD[r[0]] = (f'Que signifie le préfixe "{pre}" dans "{mot}" ?', sens, dist)
    elif 'mecfaire' in r[6]:
        UPD[r[0]] = (r[4], r[5], ['refaire', 'infaire', 'préfaire'])
    elif 'complier' in r[6]:
        UPD[r[0]] = (r[4], r[5], ['déplier', 'surplier', 'préplier'])

# ---------------------------------------------------------------- C. masculin_feminin CE1
GROUPES = [['taureau', 'bœuf', 'cheval', 'âne', 'bouc', 'bélier', 'cochon'],
           ['coq', 'jars', 'canard', 'dindon', 'paon', 'faisan', 'pigeon'],
           ['cerf', 'sanglier', 'lièvre', 'lapin', 'renard', 'loup', 'ours', 'lion', 'tigre', 'singe', 'éléphant', 'chameau', 'chat', 'chien']]
FEM = {'taureau': 'vache', 'bœuf': 'vache', 'cheval': 'jument', 'âne': 'ânesse', 'bouc': 'chèvre', 'bélier': 'brebis', 'cochon': 'truie',
       'coq': 'poule', 'jars': 'oie', 'canard': 'cane', 'dindon': 'dinde', 'paon': 'paonne', 'faisan': 'faisane', 'pigeon': 'pigeonne',
       'cerf': 'biche', 'sanglier': 'laie', 'lièvre': 'hase', 'lapin': 'lapine', 'renard': 'renarde', 'loup': 'louve', 'ours': 'ourse',
       'lion': 'lionne', 'tigre': 'tigresse', 'singe': 'guenon', 'éléphant': 'éléphante', 'chameau': 'chamelle', 'chat': 'chatte', 'chien': 'chienne'}
FAUTE_FEM = {'chienne': 'chiene', 'lionne': 'lione', 'paonne': 'paone', 'pigeonne': 'pigeone', 'chatte': 'chate', 'ânesse': 'anesse',
             'tigresse': 'tigrèsse', 'chamelle': 'chamèle', 'louve': 'loupe', 'lapine': 'lapinne', 'éléphante': 'éléfante',
             'faisane': 'faisanne', 'cane': 'canne', 'jument': 'jumente', 'brebis': 'brebie', 'poule': 'poulle', 'hase': 'hasse',
             'guenon': 'guenonne', 'chèvre': 'chêvre', 'renarde': 'renardde', 'ourse': 'oursse'}


def groupe(m):
    return next(g for g in GROUPES if m in g)


def autres_males(m, k, seed):
    g = [x for x in groupe(m) if x != m and FEM[x] != FEM[m]]
    return random.Random(seed).sample(g, k)


def adj_fem(m, f):
    c = [m]
    if f == m:   # adjectif deja en -e
        c += [m + 'e', m + 's', m[:-1]]
    elif f.endswith('euse'):
        c += [m + 'e', f[:-3] + 'usse']
    elif f.endswith('ive'):
        c += [m + 'e', f[:-1]]
    elif f.endswith('elle'):
        c += [f[:-4] + 'ele', f[:-4] + 'èle']
    elif f.endswith('ienne'):
        c += [f[:-5] + 'iene']
    elif f.endswith('onne'):
        c += [f[:-4] + 'one']
    elif f.endswith('ette'):
        c += [f[:-4] + 'ete', f[:-4] + 'ète']
    elif f.endswith('lle'):
        c += [f[:-3] + 'le']
    elif f.endswith('sse'):
        c += [f[:-3] + 'se', m + 'e']
    elif f.endswith('che'):
        c += [m + 'e', f[:-1]]
    elif f.endswith('ce'):
        c += [f[:-2] + 'se', m + 'e']
    elif f.endswith('gue'):
        c += [f[:-1], f[:-2] + 'e']
    elif f.endswith('se'):
        c += [f[:-2] + 'sse', m + 'e']
    elif f.endswith('ve'):
        c += [m + 'e', f[:-1]]
    elif f.endswith('ée'):
        c += [m + 's', m[:-1] + 'er']
    elif f.endswith('nte'):
        c += [f[:-4] + ('a' if f[-4] == 'e' else 'e') + 'nte', f[:-1] + 'te']
    elif f.endswith('te'):
        c += [f[:-1] + 'te', m + 'es']
    elif f.endswith('de'):
        c += [f[:-2] + 'te', m + 'es']
    elif f.endswith('ue'):
        c += [m + 's', m + 'x']
    else:
        c += [m + m[-1] + 'e', m + 'es']
    c.append(f + 's')
    return c


def adj_masc(m, f):
    c = [f]
    if f == m:
        c += [m + 'e', m + 's', m[:-1]]
    elif m.endswith('eux'):
        c += [m[:-1] + 's', m + 'e']
    elif m.endswith('if'):
        c += [m[:-1] + 'v', m + 'e']
    elif m.endswith('eau'):
        c += [m + 'x', m[:-3] + 'au']
    elif m.endswith(('el', 'ien', 'on', 'et', 'l')):
        c += [m + m[-1], m + 'e']
    elif m.endswith('c'):
        c += [f[:-1], m + 'k']
    elif m.endswith('x'):
        c += [m[:-1] + 's', m + 'e']
    elif m.endswith('s'):
        c += [m + 's', m[:-1]]
    elif m.endswith('f'):
        c += [m[:-1] + 'v', m + 'e']
    elif m.endswith('é'):
        c += [m + 's', m[:-1] + 'er']
    elif m.endswith(('ant', 'ent')):
        c += [m[:-3] + ('e' if m[-3] == 'a' else 'a') + 'nt', m[:-1]]
    elif m.endswith(('t', 'd')):
        c += [m[:-1], m[:-1] + ('d' if m[-1] == 't' else 't')]
    elif m.endswith('g'):
        c += [m[:-1], m + 'ue']
    else:
        c += [m + 's', m + m[-1]]
    c.append(m + 's')
    return c


def trois(bonne, cands):
    out = []
    for x in cands:
        if x and x != bonne and x not in out:
            out.append(x)
    return out[:3]


for r in rows:
    if r[3] != 'masculin_feminin':
        continue
    e, b = r[4], r[5]
    m1 = re.match(r"Comment s'appelle la femelle (?:du |de l'|de la )(.+) \?", e)
    m2 = re.match(r"Comment s'appelle le mâle (?:du |de l'|de la )(.+) \?", e)
    m3 = re.match(r'Quel est le féminin de "(.+)" \?', e)
    m4 = re.match(r'Quel est le masculin de "(.+)" \?', e)
    if m1:
        male = m1.group(1)
        autres_f = [FEM[x] for x in groupe(male) if FEM[x] != b]
        rs = random.Random(r[0])
        c = [male, FAUTE_FEM.get(b) or rs.choice(autres_f)] + rs.sample(autres_f, 3)
        d = trois(b, c)
    elif m2:
        fem = m2.group(1)
        d = trois(b, [fem] + autres_males(b, 2, r[0]))
    elif m3:
        d = trois(b, adj_fem(m3.group(1), b))
    elif m4:
        d = trois(b, adj_masc(b, m4.group(1)))
    else:
        raise SystemExit('modele inconnu : ' + e)
    assert len(d) == 3, (e, d)
    UPD[r[0]] = (e, b, d)

# ---------------------------------------------------------------- D. homophones CM2
for r in rows:
    if r[3] == 'homophones' and 'Kan' in r[6].split('|'):
        UPD[r[0]] = (r[4], r[5], [x if x != 'Kan' else 'Quan' for x in r[6].split('|')])

# ---------------------------------------------------------------- controles + sortie
avant = {r[0]: r for r in rows}
for i, (e, b, d) in UPD.items():
    assert len(d) == 3 and len(set(d)) == 3 and b not in d, (i, b, d)


def q(s):
    return s.replace("'", "''")


sql = ['-- AUDITS_LOG #32 (2026-10-03) : mauvaises reponses refaites (orthographe CM1/CM2, prefixes CM2, masculin/feminin CE1, homophones CM2).', 'begin;']
change = 0
for i, (e, b, d) in sorted(UPD.items(), key=lambda x: int(x[0])):
    r = avant[i]
    if (e, b, '|'.join(d)) == (r[4], r[5], r[6]):
        continue
    change += 1
    arr = ','.join("'" + q(x) + "'" for x in d)
    sql.append(f"update contenu_questions set enonce = '{q(e)}', bonne_reponse = '{q(b)}', mauvais_choix = array[{arr}], modifie_le = now() where id = {i};")
sql += ['commit;', 'select fn_publier();']
open('correctifs_2026-10-03_mauvaises_reponses.sql', 'w', encoding='utf-8').write('\n'.join(sql) + '\n')
with open('apres.tsv', 'w', encoding='utf-8') as f:
    for i, (e, b, d) in sorted(UPD.items(), key=lambda x: int(x[0])):
        r = avant[i]
        f.write('\t'.join([i, r[1], r[3], r[5], r[6], b, '|'.join(d)]) + '\n')
nb_mots_remplaces = sum(1 for i, (e, b, d) in UPD.items() if avant[i][3] == 'orthographe_mots' and b != avant[i][5])
print('questions modifiees :', change, '| mots remplaces :', nb_mots_remplaces)
