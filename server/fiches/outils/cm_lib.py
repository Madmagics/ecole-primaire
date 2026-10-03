# Aides pour les fiches CM1 / CM2 (2026-10-03) : nombres decimaux, grands nombres, SQL par classe.
from lib import RED, grid, grid2, P

TOKD = {'m': 'milliers', 'c': 'centaines', 'd': 'classe', 'u': 'unites',
        'x': 'dixiemes', 'y': 'centiemes', 'z': 'milliemes'}
LABD = {'m': 'M', 'c': 'C', 'd': 'D', 'u': 'U', 'x': '1/10', 'y': '1/100', 'z': '1/1000'}
PC = 'padding=6,4,6,4'


def cols(nint, ndec):
    return ['m', 'c', 'd', 'u'][-nint:] + [','] + ['x', 'y', 'z'][:ndec]


def _content(x):
    if x == '':
        return ''
    if x.startswith('!'):
        return f'[center][b]{x[1:]}[/b][/center]'
    if x.startswith('~'):
        return f'[center][b][color={RED}][s]{x[1:]}[/s][/color][/b][/center]'
    return f'[center][b]{x}[/b][/center]'


def split_dec(v, cs):
    """'11,68' -> liste de cellules alignees sur la virgule."""
    if isinstance(v, list):
        return v
    ip, _, dp = v.partition(',')
    ni = cs.index(',')
    nd = len(cs) - ni - 1
    assert len(ip) <= ni and len(dp) <= nd, (v, cs)
    return [''] * (ni - len(ip)) + list(ip) + [','] + list(dp) + [''] * (nd - len(dp))


def dec_op(cs, rows, result=None, top=None):
    """Operation posee avec virgule. rows = [(signe, '12,75' ou liste de cellules)]."""
    s = f'[table={len(cs) + 1}][cell padding=10,4,10,4][/cell]'
    for c in cs:
        if c == ',':
            s += f'[cell {PC}][/cell]'
        else:
            t = TOKD[c]
            s += f'[cell bg=#{t} border=#{t} {P}][center][color=white][b]{LABD[c]}[/b][/color][/center][/cell]'
    if top:
        s += '[cell padding=10,0,10,0][/cell]'
        for c, x in zip(cs, top):
            if x and c != ',':
                s += f'[cell padding=18,0,18,0][center][font_size=18][color={RED}][b]{x}[/b][/color][/font_size][/center][/cell]'
            else:
                s += '[cell padding=6,0,6,0][/cell]'
    for sign, v in rows:
        s += f'[cell padding=10,4,10,4][b]{sign}[/b][/cell]'
        for c, x in zip(cs, split_dec(v, cs)):
            if c == ',':
                s += f'[cell {PC}][center][b]{x}[/b][/center][/cell]'
            else:
                s += f'[cell border=#{TOKD[c]} {P}]{_content(x)}[/cell]'
    if result is not None:
        s += '[cell padding=10,4,10,4][b]=[/b][/cell]'
        for c, x in zip(cs, split_dec(result, cs)):
            if c == ',':
                s += f'[cell {PC}][center][b]{x}[/b][/center][/cell]'
            else:
                t = TOKD[c]
                s += f'[cell bg=#{t}_clair border=#{t} {P}]{_content(x)}[/cell]'
    return s + '[/table]'


def entier_op(cs, rows, result=None, top=None):
    """Operation posee sans virgule (cs = lettres m/c/d/u). Les valeurs sont des chaines ou listes."""
    def cells(v):
        if isinstance(v, list):
            return v
        v = str(v)
        return [''] * (len(cs) - len(v)) + list(v)
    s = f'[table={len(cs) + 1}][cell padding=10,4,10,4][/cell]'
    for c in cs:
        t = TOKD[c]
        s += f'[cell bg=#{t} border=#{t} {P}][center][color=white][b]{LABD[c]}[/b][/color][/center][/cell]'
    if top:
        s += '[cell padding=10,0,10,0][/cell]'
        for x in top:
            if x:
                s += f'[cell padding=18,0,18,0][center][font_size=18][color={RED}][b]{x}[/b][/color][/font_size][/center][/cell]'
            else:
                s += '[cell padding=18,0,18,0][/cell]'
    for sign, v in rows:
        s += f'[cell padding=10,4,10,4][b]{sign}[/b][/cell]'
        for c, x in zip(cs, cells(v)):
            s += f'[cell border=#{TOKD[c]} {P}]{_content(x)}[/cell]'
    if result is not None:
        s += '[cell padding=10,4,10,4][b]=[/b][/cell]'
        for c, x in zip(cs, cells(result)):
            t = TOKD[c]
            s += f'[cell bg=#{t}_clair border=#{t} {P}]{_content(x)}[/cell]'
    return s + '[/table]'


CLASSES = {'milliards': 'centaines', 'millions': 'milliers', 'mille': 'classe', 'unités': 'unites'}


def classes_table(nombre, classes):
    """Tableau de numeration par classes : 2 lignes d'en-tete (nom de la classe, puis C D U)."""
    digits = nombre.replace(' ', '')
    n = 3 * len(classes)
    assert len(digits) <= n
    cells = [''] * (n - len(digits)) + list(digits)
    pad = 'padding=14,3,14,3'
    s = f'[table={n}]'
    for cl in classes:
        t = CLASSES[cl]
        for k in range(3):
            txt = f'[font_size=18]{cl}[/font_size]' if k == 1 else ''
            s += f'[cell bg=#{t} border=#{t} {pad}][center][color=white][b]{txt}[/b][/color][/center][/cell]'
    for cl in classes:
        t = CLASSES[cl]
        for lab in 'CDU':
            s += f'[cell bg=#{t}_clair border=#{t} {pad}][center][b]{lab}[/b][/center][/cell]'
    for i, x in enumerate(cells):
        t = CLASSES[classes[i // 3]]
        s += f'[cell border=#{t} {pad}]{_content(x)}[/cell]'
    return s + '[/table]'


def comp_top(n):
    """Petit chiffre rouge colle devant un chiffre (methode par compensation)."""
    return f'[color={RED}][font_size=18]{n}[/font_size][/color]'


def bclr(x):
    return f'[b][color={RED}]{x}[/color][/b]'


H = lambda x: (f'[center][b]{x}[/b][/center]', 'classe!')
Cc = lambda x, st=None: (f'[center]{x}[/center]', st)

SQL = """-- Fiche {titre} ({CL}) - notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'math', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
"""


def fiche_sql(cl, code, titre, pages):
    contenu = '\n[page]\n'.join(p.strip('\n') for p in pages)
    return SQL.format(cl=cl, CL=cl.upper(), titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)


def ecrire(cl, fiches, out, apercu=None, date='2026-10-03'):
    """apercu = dossier ou ecrire aussi le texte brut de chaque fiche (captures de verification)."""
    import os
    os.makedirs(out, exist_ok=True)
    toutes = [f'-- Toutes les fiches Maths {cl.upper()} en une transaction ({date}).', 'begin;']
    for code, titre, pages in fiches:
        sql = fiche_sql(cl, code, titre, pages)
        open(f'{out}/{cl}_{code}.sql', 'w').write(sql + 'select fn_publier();\n')
        if apercu:
            os.makedirs(apercu, exist_ok=True)
            open(f'{apercu}/{cl}_{code}.txt', 'w').write('\n[page]\n'.join(p.strip('\n') for p in pages))
        toutes.append(sql)
        print(cl, code, len(pages), 'pages')
    toutes += ['commit;', 'select fn_publier();']
    open(f'{out}/{cl}_maths_toutes.sql', 'w').write('\n'.join(toutes) + '\n')


def conv_table(units, tok_main, vals):
    """units = ['km','hm',...] ; vals = liste de cellules (meme longueur)."""
    s = f'[table={len(units)}]'
    for u in units:
        t = tok_main if u in ('m', 'g', 'L') else 'classe'
        s += f'[cell bg=#{t} border=#{t} padding=14,4,14,4][center][color=white][b]{u}[/b][/color][/center][/cell]'
    for u, v in zip(units, vals):
        t = tok_main if u in ('m', 'g', 'L') else 'classe'
        s += f'[cell border=#{t} padding=14,4,14,4][center][b]{v}[/b][/center][/cell]'
    return s + '[/table]'


LONG = ['km', 'hm', 'dam', 'm', 'dm', 'cm', 'mm']
