# Rangement du vocabulaire des fiches d'anglais (2026-10-03, demande de Steve) :
# mots regroupes par theme (jours, mois, nombres...), series dans l'ordre naturel,
# phrases modeles a part, une seule ou deux par structure (pas 7 fois "Today is ...").
import re
import unicodedata

VERBES = ("i i'm it's it he she we they you there today on my what how where when who why touch take "
          "stand sit clap turn come be listen look stop let's what's can can't don't do does is are was were"
          ).split()


def est_phrase(fr, en):
    w = en.split()
    if not w:
        return False
    if w[0].lower() in VERBES and len(w) >= 2 and not (w[0].lower() == 'on' and w[1] == 'foot'):
        return True
    return len(w) >= 4


def sans_accent(s):
    return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')


def cle_alpha(fr):
    s = re.sub(r"^(le |la |les |l'|un |une |des )", '', fr.lower())
    return sans_accent(s)


def regroupe_phrases(paires, garde=2):
    """Phrases d'une meme structure (ne different que d'un mot) -> on n'en garde que `garde`."""
    n = len(paires)
    parent = list(range(n))

    def f(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i
    tok = [p[1].lower().replace(',', '').replace('?', '').split() for p in paires]
    for i in range(n):
        for j in range(i + 1, n):
            a, b = tok[i], tok[j]
            if len(a) == len(b) and sum(x != y for x, y in zip(a, b)) == 1:
                parent[f(i)] = f(j)
    vus, out = {}, []
    for i in range(n):
        r = f(i)
        vus[r] = vus.get(r, 0) + 1
        if vus[r] <= garde:
            out.append(paires[i])
    return out


# ------------------------------------------------------------------ series ordonnees
JOURS = 'monday tuesday wednesday thursday friday saturday sunday'.split()
MOIS = 'january february march april may june july august september october november december'.split()
SAISONS = 'spring summer autumn winter'.split()
MOMENTS = ('morning afternoon evening night midnight noon midday day week weekend month year today tomorrow '
           'yesterday').split()
CARD = ('zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen '
        'seventeen eighteen nineteen twenty').split()
DIZ = {'thirty': 30, 'forty': 40, 'fifty': 50, 'sixty': 60, 'seventy': 70, 'eighty': 80, 'ninety': 90}
ORD = ('first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth thirteenth fourteenth '
       'fifteenth sixteenth seventeenth eighteenth nineteenth twentieth').split()
COUL = ('red blue green yellow orange pink purple brown black white grey gold golden silver beige turquoise indigo '
        'khaki maroon coral lavender navy rainbow').split()
FAMILLE = ('mum mom mother dad father parents sister brother baby twin grandma grandmother grandpa grandfather '
           'grandparents aunt uncle cousin niece nephew wife husband stepmother stepfather friend').split()
CORPS = ('head hair face forehead eye eyes eyebrow ear ears nose cheek mouth lips tooth teeth tongue chin neck '
         'shoulder shoulders back chest tummy stomach arm arms elbow wrist hand hands finger fingers thumb nail leg '
         'legs knee knees ankle foot feet toe toes heel skin bone heart').split()


def nombre(w):
    w = w.lower().replace('one hundred', 'hundred')
    if w in CARD:
        return CARD.index(w)
    if w in DIZ:
        return DIZ[w]
    if w == 'hundred':
        return 100
    m = re.fullmatch(r'(\w+) hundred', w)
    if m and m.group(1) in CARD:
        return 100 * CARD.index(m.group(1))
    if w == 'a thousand' or w == 'one thousand' or w == 'thousand':
        return 1000
    m = re.fullmatch(r'(\w+)-(\w+)', w)
    if m and m.group(1) in DIZ and m.group(2) in CARD:
        return DIZ[m.group(1)] + CARD.index(m.group(2))
    if m and m.group(1) == 'twenty' and m.group(2) in CARD:
        return 20 + CARD.index(m.group(2))
    return None


def base(en):
    return re.sub(r'^(a|an|the) ', '', en.lower()).strip()


# theme -> (titre, liste de mots anglais dans l'ordre, ou None = ordre alphabetique francais)
THEMES = [
    ('jours', 'Les jours de la semaine', JOURS),
    ('mois', "Les mois de l'année", MOIS),
    ('saisons', 'Les saisons', SAISONS),
    ('moments', 'Les moments de la journée', MOMENTS),
    ('nombres', 'Les nombres', None),
    ('ordinaux', 'Premier, deuxième...', ORD),
    ('couleurs', 'Les couleurs', COUL),
    ('famille', 'La famille', FAMILLE),
    ('corps', 'Le corps', CORPS),
]
from vocab_themes import THEMES_LIBRES     # themes sans ordre naturel (liste de mots anglais par theme)


VERBES_MOTS = set('climb dance draw eat jump read run sing sleep swim walk write drink play fly listen look stop'.split())


def candidats(fr, en):
    b = base(en)
    if nombre(b) is not None:
        return ['nombres']
    w = b.split()
    if w and w[0] in ('this', 'that', 'these', 'those'):
        return ['demonstratifs']
    if b.startswith('as ') and b.endswith(' as'):
        return ['comp_aussi']
    if b.startswith('less '):
        return ['comp_moins']
    if b.endswith(' than'):
        return ['comp_plus']
    if re.fullmatch(r'(the )?\w+est', b) and fr.startswith('le plus'):
        return ['superlatifs']
    if re.fullmatch(r'\w+er', b) and fr.startswith('plus'):
        return ['comparatifs']
    if b.startswith('to ') or (b in VERBES_MOTS and re.search(r'(er|ir|re)$', fr) and not re.match(r"(le|la|les|l'|un|une) ", fr)):
        return ['verbes']
    out = [code for code, _t, L in THEMES if L and b in L]
    out += [code for code, _t, L in THEMES_LIBRES if b in L]
    return out


MAX_PHRASES = 8
FAMILLES = {
    'f_animaux': ('Les animaux', ['animaux_ferme', 'animaux_sauvages', 'animaux_mer', 'petites_betes']),
    'f_nourriture': ('La nourriture', ['fruits', 'legumes', 'repas', 'aliments']),
    'f_ecole': ("L'école", ['ecole_objets', 'ecole_classe', 'ecole_matieres']),
    'f_maison': ('La maison', ['pieces', 'maison', 'meubles']),
    'f_nature': ('La nature et le temps', ['meteo', 'ciel', 'paysages', 'plantes']),
    'f_ville': ('La ville et les transports', ['lieux', 'transports', 'voyage']),
    'f_loisirs': ('Les loisirs', ['sports', 'instruments', 'jouets']),
    'f_emotions': ('Les émotions et le caractère', ['emotions', 'caractere']),
    'f_adjectifs': ('Les adjectifs', ['adj_taille', 'adj_etat']),
    'f_temps': ('Le temps', ['jours', 'mois', 'saisons', 'moments']),
    'f_comparer': ('Comparer', ['comp_plus', 'comp_moins', 'comp_aussi', 'comparatifs', 'superlatifs']),
}
TITRES = {c: t for c, t, _ in THEMES + THEMES_LIBRES}
ORDRE_THEMES = [c for c, _, _ in THEMES + THEMES_LIBRES]


def range_vocab(paires):
    """[(titre du groupe, [paires dans l'ordre])], mots d'abord, phrases modeles a la fin."""
    mots = [p for p in paires if not est_phrase(*p)]
    phrases, vus_ph = [], set()
    for p in regroupe_phrases([p for p in paires if est_phrase(*p)]):
        if p[1].lower() not in vus_ph:
            vus_ph.add(p[1].lower())
            phrases.append(p)
    phrases = phrases[:MAX_PHRASES]
    cands = [candidats(*p) for p in mots]
    poids = {}
    for c in cands:
        for x in c:
            poids[x] = poids.get(x, 0) + 1
    groupes = {}
    vus_en = set()
    for p, c in zip(mots, cands):
        if base(p[1]) in vus_en:          # meme mot anglais deja present (le rouge / rouge, first / the first)
            continue
        vus_en.add(base(p[1]))
        t = max(c, key=lambda x: poids[x]) if c else 'autres'
        groupes.setdefault(t, []).append(p)
    def trie(c, L):
        serie = next((x[2] for x in THEMES if x[0] == c), None)
        if c == 'nombres':
            return sorted(L, key=lambda p: nombre(base(p[1])))
        if serie:
            return sorted(L, key=lambda p: serie.index(base(p[1])))
        return sorted(L, key=lambda p: cle_alpha(p[0]))
    groupes = {c: trie(c, L) for c, L in groupes.items()}
    rang = {c: i for i, c in enumerate(ORDRE_THEMES)}
    # une famille dont un theme est trop petit (1 ou 2 mots) est regroupee sous un seul titre,
    # chaque theme gardant son ordre (jours puis mois...)
    for fam, (_titre, membres) in FAMILLES.items():
        pres = [c for c in membres if c in groupes]
        if len(pres) > 1 and any(len(groupes[c]) <= 2 for c in pres) and sum(len(groupes[c]) for c in pres) <= 14:
            pres.sort(key=lambda c: rang[c])
            rang[fam] = rang[pres[0]]
            groupes[fam] = [p for c in pres for p in groupes.pop(c)]
    # un theme isole d'un seul mot rejoint les autres mots
    if len(groupes) > 1:
        for c in list(groupes):
            if c != 'autres' and len(groupes[c]) == 1 and not any(c in m and len([x for x in m if x in groupes]) > 1 for _t, m in FAMILLES.values()):
                groupes.setdefault('autres', []).extend(groupes.pop(c))
    if 'autres' in groupes:
        groupes['autres'] = trie('autres', groupes['autres'])
    out = []
    for c in sorted(groupes, key=lambda c: rang.get(c, 999)):
        titre = 'Les aliments' if c == 'aliments' and not ({'fruits', 'legumes'} & set(groupes)) else None
        titre = titre or TITRES.get(c) or FAMILLES.get(c, (None,))[0] or ('Autres mots' if len(groupes) > 1 else 'Les mots')
        out.append((titre, groupes[c]))
    if phrases:
        out.append(('Des phrases modèles', phrases))
    return out
