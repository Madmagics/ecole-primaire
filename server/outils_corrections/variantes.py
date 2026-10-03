# Generateur de fautes d'orthographe realistes pour un mot francais (QCM "Quelle est la bonne orthographe ?").
# Chaque regle produit des variantes ; on rejette toute variante qui est un vrai mot du dictionnaire.
import random
import re
from spellchecker import SpellChecker

DICO = SpellChecker(language='fr')
V = 'aeiouyéèêëàâîïôûù'
CONS_DOUBLE = 'lmnprtfsc'


def est_mot(w):
    return all(p in DICO for p in re.split(r"[ '-]", w) if p) if (' ' in w or '-' in w or "'" in w) else w in DICO


def regles(w):
    """Liste de (categorie, variante)."""
    out = []
    n = len(w)
    # double -> simple
    for i in range(n - 1):
        if w[i] == w[i + 1] and w[i] in 'bcdfglmnprst':
            out.append(('double', w[:i] + w[i + 1:]))
    # simple -> double (consonne entre deux voyelles)
    for i in range(1, n - 1):
        c = w[i]
        if c in CONS_DOUBLE and w[i - 1] in V and w[i + 1] in V and w[i - 1] != c and w[i + 1] != c:
            if c == 'c' and w[i + 1] in 'eéèêiy':
                continue
            out.append(('double', w[:i] + c + w[i:]))
    # m devant b, p
    for a, b in (('mb', 'nb'), ('mp', 'np'), ('mm', 'nm')):
        if a in w:
            out.append(('m', w.replace(a, b, 1)))
    # accents
    for a, bs in (('é', 'eè'), ('è', 'éeê'), ('ê', 'èe'), ('à', 'a'), ('â', 'a'), ('î', 'i'), ('ô', 'o'), ('û', 'u'), ('ï', 'i')):
        for m in re.finditer(a, w):
            for b in bs:
                out.append(('accent', w[:m.start()] + b + w[m.end():]))
    for m in re.finditer('e', w):
        i = m.start()
        nxt = w[i + 1:i + 3]
        if i < n - 1 and len(nxt) == 2 and (nxt[0] == nxt[1] or nxt[0] == 'x') and nxt[0] not in V:
            out.append(('accent', w[:i] + 'é' + w[i + 1:]))   # dentelle -> déntelle, exemple -> éxemple
        if 0 < i < n - 2 and w[i + 1] not in V and w[i + 2] in V and w[i - 1] not in 'gq':
            out.append(('accent', w[:i] + 'é' + w[i + 1:]))
    # fins de mots et graphies d'un meme son
    subs = [('tion', ['ssion', 'sion', 'cion']), ('ssion', ['tion', 'sion']), ('sion', ['tion', 'ssion']), ('xion', ['ction', 'ksion']),
            ('ance', ['ence']), ('ence', ['ance']), ('ment', ['mant']), ('ant', ['ent']), ('ent', ['ant']),
            ('eau', ['au', 'o']), ('au', ['o']), ('ph', ['f']), ('ique', ['ic', 'ike']), ('que', ['c', 'k']),
            ('ge', ['je']), ('gi', ['ji']), ('y', ['i']),
            ('aille', ['aie', 'ail']), ('ill', ['y']),
            ('ai', ['è', 'é']), ('è', ['ai']), ('oi', ['oa']),
            ('qu', ['k']), ('ç', ['ss', 's']), ('ss', ['s']), ('gu', ['g']), ('x', ['ks']), ('th', ['t']),
            ('té', ['tée']), ('et', ['ait', 'é']), ('ette', ['ète']),
            ('ole', ['olle']), ('elle', ['èle']), ('z', ['s'])]
    for a, bs in subs:
        for m in re.finditer(re.escape(a), w):
            if a in ('tion', 'sion', 'ssion') and m.start() > 0 and w[m.start() - 1] == 'c':
                if a == 'tion':
                    out.append(('son', w[:m.start() - 1] + 'xion' + w[m.end():]))
                continue
            for b in bs:
                out.append(('son', w[:m.start()] + b + w[m.end():]))
    # s entre deux voyelles (son z) / c devant e,i
    for i in range(1, n - 1):
        if w[i] == 's' and w[i - 1] in V and w[i + 1] in V:
            out.append(('son', w[:i] + 'z' + w[i + 1:]))
            out.append(('son', w[:i] + 'ss' + w[i + 1:]))
        if w[i] == 'c' and w[i + 1] in 'eéèêi' and w[i - 1] in V:
            out.append(('son', w[:i] + 'ss' + w[i + 1:]))
    # nasales : seulement devant une consonne (pas n/m) ou en fin de mot
    for a, bs in (('an', ['en']), ('en', ['an']), ('am', ['em']), ('em', ['am']), ('ain', ['ein', 'in']), ('ein', ['ain', 'in']), ('in', ['ain'])):
        for m in re.finditer(a, w):
            j = m.end()
            if m.start() == 0 or (j < n and (w[j] in V or w[j] in 'nm')):
                continue
            if a == 'en' and w[m.start() - 1] in 'iy':
                continue
            if a == 'in' and w[m.start() - 1] in 'ae':
                continue
            for b in bs:
                out.append(('son', w[:m.start()] + b + w[j:]))
    # c dur -> k ; ss devant e,i -> c ; e devant deux consonnes -> é
    for i in range(n - 1):
        if w[i] == 'c' and w[i + 1] in 'aoulr' and (i == 0 or w[i - 1] != 'c'):
            out.append(('son', w[:i] + 'k' + w[i + 1:]))
        if w[i:i + 2] == 'ss' and i + 2 < n and w[i + 2] in 'eéi':
            out.append(('son', w[:i] + 'c' + w[i + 2:]))
        if w[i] == 'e' and i + 2 < n and w[i + 1] not in V and w[i + 2] not in V and w[i + 1:i + 3] not in ('ch', 'nt', 'nd', 'ns', 'mb', 'mp', 'nc', 'ng') and (i == 0 or w[i - 1] not in 'gqo'):
            out.append(('accent', w[:i] + 'é' + w[i + 1:]))
    # fins de mot seulement
    for a, bs in (('eille', ['eil', 'eye']), ('al', ['alle']), ('ier', ['ié']), ('on', ['ont']), ('ien', ['ient']), ('che', ['ch', 'sh'])):
        if w.endswith(a) and len(w) > len(a) + 1 and not (a == 'on' and w.endswith('ion')):
            for b in bs:
                out.append(('fin', w[:-len(a)] + b))
    for i in range(1, n - 1):   # f -> ph au milieu, devant une voyelle
        if w[i] == 'f' and w[i + 1] in V and w[i - 1] != 'f':
            out.append(('son', w[:i] + 'ph' + w[i + 1:]))
    # doublement de secours (b, d, g, z)
    for i in range(1, n - 1):
        if w[i] in 'bdgz' and w[i - 1] in V and w[i + 1] in V:
            out.append(('secours', w[:i] + w[i] + w[i:]))
    # lettres muettes
    if w[-1] in 'tdspx' and len(w) > 4 and w[-2] in V + 'rn':
        out.append(('muette', w[:-1]))
    if w[-1] == 'e' and len(w) > 5 and w[-2] not in V and w[-3] in V and w[-2] not in 'gc':
        out.append(('muette', w[:-1]))
    if re.search(r'(oir|al|ar|our|eur|el|il|ol)$', w) and len(w) > 4:
        out.append(('muette', w + 'e'))
    if w.startswith('h'):
        out.append(('muette', w[1:]))
    return out


def fautes(w, k=3, seed=0):
    """k fautes realistes et distinctes, si possible de categories differentes."""
    rnd = random.Random(f'{w}-{seed}')
    vus, par_cat = set(), {}
    for cat, v in regles(w):
        if v == w or v in vus or not v or v[0] in "-'" or est_mot(v):
            continue
        if re.search(r'([a-z])\1\1', v):
            continue
        vus.add(v)
        par_cat.setdefault(cat, []).append(v)
    cats = list(par_cat)
    rnd.shuffle(cats)
    choix = []
    while len(choix) < k and any(par_cat.values()):
        for c in cats:
            if par_cat[c] and len(choix) < k:
                v = rnd.choice(par_cat[c])
                par_cat[c].remove(v)
                choix.append(v)
    return choix
