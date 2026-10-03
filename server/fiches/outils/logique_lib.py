# Aides pour les fiches de cours Logique (2026-10-03) : rangees de symboles, grilles 3x3, SQL par classe.

COULEURS = {'bleu': '#42A5F5', 'rouge': '#EF5350', 'vert': '#66BB6A', 'jaune': '#FFD54F',
            'orange': '#F2A541', 'violet': '#AB47BC'}
PAD = 'padding=12,6,12,6'


def _c(x, size):
    if any(_emoji(ch) for ch in x):   # pas de gras autour des emoji (voir sans_gras_emoji)
        return f'[center][font_size={size}]{x}[/font_size][/center]'
    return f'[center][font_size={size}][b]{x}[/b][/font_size][/center]'


def rangee(items, size=30, trou='?', pad=PAD):
    """Une rangee de cases (suite, groupe d'objets...). La case egale a `trou` est en orange."""
    s = f'[table={len(items)}]'
    for x in items:
        if x == trou:
            s += f'[cell bg=#unites_clair border=#unites {pad}]{_c(x, size)}[/cell]'
        elif x.startswith('!'):   # case mise en valeur (reponse trouvee)
            s += f'[cell bg=#unites border=#unites {pad}]{_c("[color=white]" + x[1:] + "[/color]", size)}[/cell]'
        else:
            s += f'[cell bg=#classe_clair border=#classe {pad}]{_c(x, size)}[/cell]'
    return s + '[/table]'


def ecarts(nombres, sauts, size=26, fin='?'):
    """Suite de nombres avec les ecarts ecrits en dessous, entre deux nombres."""
    n = len(nombres)
    s = f'[table={2 * n - 1}]'
    for i, x in enumerate(nombres):
        if i:
            s += '[cell padding=4,4,4,4][/cell]'
        st = 'bg=#unites_clair border=#unites' if x == fin else 'bg=#classe_clair border=#classe'
        s += f'[cell {st} padding=10,4,10,4]{_c(x, size)}[/cell]'
    for i in range(n):
        if i:
            t = sauts[i - 1] if i - 1 < len(sauts) else ''
            s += f'[cell padding=4,2,4,2][center][font_size=20][b][color=#unites]{t}[/color][/b][/font_size][/center][/cell]'
        s += '[cell padding=4,2,4,2][/cell]'
    return s + '[/table]'


def couleurs(noms, trou_index=None):
    """Motif de couleurs : une case de couleur et son nom en dessous ; trou_index = case '?'."""
    s = f'[table={len(noms)}]'
    for i, n in enumerate(noms):
        if i == trou_index:
            s += f'[cell bg=#unites_clair border=#unites padding=18,8,18,8]{_c("?", 26)}[/cell]'
        else:
            s += f'[cell bg={COULEURS[n]} border=#classe padding=18,8,18,8]{_c(" ", 26)}[/cell]'
    for i, n in enumerate(noms):
        t = '?' if i == trou_index else n
        s += f'[cell padding=4,2,4,2][center][font_size=18]{t}[/font_size][/center][/cell]'
    return s + '[/table]'


def grille3(cells, size=30, marque=None, pad='padding=16,8,16,8'):
    """Grille 3 x 3. cells = 9 textes ; '?' = case a trouver ; marque = index mis en valeur."""
    s = '[table=3]'
    cells = [x if x != '' else '[color=#00000000]●[/color]' for x in cells]   # case vide de meme largeur
    for i, x in enumerate(cells):
        if x.startswith('!'):
            s += f'[cell bg=#unites border=#unites {pad}]{_c("[color=white]" + x[1:] + "[/color]", size)}[/cell]'
        elif x == '?' or i == marque:
            s += f'[cell bg=#unites_clair border=#unites {pad}]{_c(x, size)}[/cell]'
        else:
            s += f'[cell bg=#classe_clair border=#classe {pad}]{_c(x, size)}[/cell]'
    return s + '[/table]'


def tableau(ncols, cells, entete=None, pad='padding=10,4,10,4', size=None, paires=False, lignes=False):
    """Tableau simple : une premiere ligne d'en-tete (couleur de la classe) puis les cellules.
    paires=True (2026-10-03, demande de Steve) : les cellules vont par 2 (mot / son contraire...) ;
    chaque paire a son fond, en damier, pour que deux paires voisines ne se confondent pas."""
    s = f'[table={ncols}]'
    for h in entete or []:
        s += f'[cell bg=#classe border=#classe {pad}][center][color=white][b]{h}[/b][/color][/center][/cell]'
    for i, x in enumerate(cells):
        x2 = f'[font_size={size}]{x}[/font_size]' if size else x
        st = 'classe'
        if paires and ((i // ncols) + (i % ncols) // 2) % 2 == 1:
            st = 'alt'
        if lignes and (i // ncols) % 2 == 1:   # une ligne sur deux dans la 2e couleur (deux suites...)
            st = 'alt'
        s += f'[cell bg=#{st}_clair border=#{st} {pad}][center]{x2}[/center][/cell]'
    return s + '[/table]'


def alphabet(debut=0, fin=26, nombres=True, decale=None, size=18):
    """Bande de l'alphabet (lettres debut..fin-1), avec les nombres A=1... ou une 2e ligne decalee."""
    lettres = [chr(65 + i) for i in range(debut, fin)]
    s = f'[table={len(lettres)}]'
    for l in lettres:
        s += f'[cell bg=#classe border=#classe padding=3,2,3,2][center][color=white][b][font_size={size}]{l}[/font_size][/b][/color][/center][/cell]'
    for i, l in enumerate(lettres):
        if decale is not None:
            t = chr(65 + (debut + i + decale) % 26)
        elif nombres:
            t = str(debut + i + 1)
        else:
            continue
        s += f'[cell bg=#unites_clair border=#unites padding=3,2,3,2][center][b][font_size={size}]{t}[/font_size][/b][/center][/cell]'
    return s + '[/table]'


# 2e couleur des tableaux (paires / lignes alternees), choisie pour bien trancher avec la couleur
# de la classe : orange pour CP (bleu), CE1 (vert), CM1 (violet) ; bleu pour CE2 (jaune), CM2 (rouge).
ALT = {'cp': ('#FFD49A', '#F2A541'), 'ce1': ('#FFD49A', '#F2A541'), 'cm1': ('#FFD49A', '#F2A541'),
       'ce2': ('#C6E2F8', '#42A5F5'), 'cm2': ('#C6E2F8', '#42A5F5')}


def couleur_alt(cl, text):
    clair, fonce = ALT[cl]
    return text.replace('#alt_clair', clair).replace('#alt ', fonce + ' ')


SQL = """-- Fiche {titre} ({CL}) - logique, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'logique', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""


def _emoji(ch):
    o = ord(ch)
    return o >= 0x1F000 or 0x2B00 <= o <= 0x2BFF or o in (0xFE0F, 0x200D)


def sans_gras_emoji(text):
    """La police grasse des fiches n'affiche pas les emoji (2026-10-03) : on sort les emoji du gras."""
    out, gras, i = [], 0, 0
    while i < len(text):
        if text.startswith('[b]', i):
            gras += 1; out.append('[b]'); i += 3; continue
        if text.startswith('[/b]', i):
            gras -= 1; out.append('[/b]'); i += 4; continue
        ch = text[i]
        out.append(f'[/b]{ch}[b]' if gras > 0 and _emoji(ch) else ch)
        i += 1
    return ''.join(out).replace('[b][/b]', '')


def fiche_sql(cl, code, titre, pages):
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    return SQL.format(CL=cl.upper(), cl=cl, titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
