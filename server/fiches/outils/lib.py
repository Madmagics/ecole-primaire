# Aides pour generer les fiches de cours (BBCode + balises maison du jeu).
TOK = {'m': 'milliers', 'c': 'centaines', 'd': 'classe', 'u': 'unites'}
LET = {'m': 'M', 'c': 'C', 'd': 'D', 'u': 'U'}
P = 'padding=18,4,18,4'
RED = '#C62828'


def digits(n, cols):
    s = str(n)
    assert len(s) <= len(cols), (n, cols)
    return [''] * (len(cols) - len(s)) + list(s)


def _content(x):
    if x == '':
        return ''
    if x.startswith('!'):
        return f'[center][b]{x[1:]}[/b][/center]'
    if x.startswith('~'):  # chiffre barre en rouge
        return f'[center][b][color={RED}][s]{x[1:]}[/s][/color][/b][/center]'
    return f'[center][b]{x}[/b][/center]'


def head_cells(cols):
    s = ''
    for c in cols:
        t = TOK[c]
        s += f'[cell bg=#{t} border=#{t} {P}][center][color=white][b]{LET[c]}[/b][/color][/center][/cell]'
    return s


def op(cols, rows, result=None, top=None):
    """Operation posee. rows = [(signe, [cellules])] ; une cellule entiere = nombre a aligner.
    top = liste de petits chiffres rouges au-dessus (retenues / cassage)."""
    def norm(cells):
        if isinstance(cells, int):
            return digits(cells, cols)
        return cells
    s = f'[table={len(cols) + 1}][cell padding=10,4,10,4][/cell]' + head_cells(cols)
    if top:
        s += '[cell padding=10,0,10,0][/cell]'
        for x in top:
            if x:
                s += f'[cell padding=18,0,18,0][center][font_size=18][color={RED}][b]{x}[/b][/color][/font_size][/center][/cell]'
            else:
                s += '[cell padding=18,0,18,0][/cell]'
    for sign, cells in rows:
        s += f'[cell padding=10,4,10,4][b]{sign}[/b][/cell]'
        for c, x in zip(cols, norm(cells)):
            s += f'[cell border=#{TOK[c]} {P}]{_content(x)}[/cell]'
    if result is not None:
        s += '[cell padding=10,4,10,4][b]=[/b][/cell]'
        for c, x in zip(cols, norm(result)):
            t = TOK[c]
            s += f'[cell bg=#{t}_clair border=#{t} {P}]{_content(x)}[/cell]'
    return s + '[/table]'


def grid(ncols, cells, style='classe', pad='12,6,12,6'):
    """Tableau simple : cells = liste de textes (deja en BBCode)."""
    s = f'[table={ncols}]'
    for x in cells:
        s += f'[cell bg=#{style}_clair border=#{style} padding={pad}]{x}[/cell]'
    return s + '[/table]'


def grid2(ncols, cells, pad='14,6,14,6'):
    """cells = liste de (texte, style ou None pour cellule bordee sans fond)."""
    s = f'[table={ncols}]'
    for x, st in cells:
        if st and st.endswith('!'):
            st = st[:-1]
            for t in ('[center]', '[/center]', '[b]', '[/b]'):
                x = x.replace(t, '')
            s += f'[cell bg=#{st} border=#{st} padding={pad}][center][color=white][b]{x}[/b][/color][/center][/cell]'
        elif st and st.startswith('+'):
            st = st[1:]
            s += f'[cell border=#{st} padding={pad}]{x}[/cell]'
        elif st:
            s += f'[cell bg=#{st}_clair border=#{st} padding={pad}]{x}[/cell]'
        else:
            s += f'[cell border=#classe padding={pad}]{x}[/cell]'
    return s + '[/table]'


def table_mult(k):
    return grid(5, [f'[b]{n} x {k} = {n * k}[/b]' for n in range(1, 11)])


SQL = """-- Fiche {titre} (CE2) - notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select 'ce2', 'math', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, statut = 'publie', modifie_le = now()
returning id, titre, statut;
"""


def fiche_sql(code, titre, pages):
    contenu = '\n[page]\n'.join(p.strip('\n') for p in pages)
    return SQL.format(titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
