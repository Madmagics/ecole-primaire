# AUDITS_LOG #33 (2026-10-03) : sujet du verbe CE2 + pluriel des noms CE1 (grammaire)
import re, sys
rows = [l.rstrip('\n').split('\t') for l in open('avant.tsv', encoding='utf-8')]
UPD = {}
for i, cl, code, e, b, d in rows:
    if code == 'fonctions':
        phrase = re.search(r'"(.+)"', e).group(1).rstrip('.')
        assert phrase.startswith(b), (phrase, b)
        reste = phrase[len(b):].strip().split()
        n = 2 if reste[0] in ('se', "s'") or reste[0].startswith("s'") and len(reste[0]) == 2 else 1
        if reste[0].startswith("s'") and len(reste[0]) > 2:
            n = 1
        verbe = ' '.join(reste[:n]); suite = ' '.join(reste[n:])
        bonne = b[0].lower() + b[1:]
        d2 = [verbe, suite, verbe + ' ' + suite]
        assert suite and len(set(d2)) == 3 and bonne not in d2, (e, d2)
        UPD[i] = (e, bonne, d2)
    else:
        w = re.search(r'"(.+)"', e).group(1)
        if b == w:                      # invariable
            if w.endswith('x'):
                d2 = [w[:-1] + 's', w + 'es', w[:-1]]
            elif w.endswith('z'):
                d2 = [w + 's', w[:-1] + 's', w + 'es']
            else:
                d2 = [w[:-1] + 'x', w + 'es', w[:-1]]
        elif b.endswith('aux') and w.endswith(('al', 'ail')):
            base = w[:-2] if w.endswith('al') else w[:-3]
            d2 = [w + 's', base + 'aus', base + 'eaux']
        elif b.endswith('eaux'):
            d2 = [w + 's', w, w[:-3] + 'aux']
        elif w.endswith('é'):
            d2 = [w, w + 'x', w + 'es']
        elif w.endswith('e'):
            d2 = [w, w + 'x', w[:-1] + 's']
        else:
            d2 = [w, w + 'es', w + 'x']
        d2 = [x for x in d2 if x != b]
        assert len(set(d2)) == 3, (w, d2)
        UPD[i] = (e, b, d2)
q = lambda s: s.replace("'", "''")
sql = ['-- AUDITS_LOG #33 (2026-10-03) : mauvaises reponses refaites (sujet du verbe CE2, pluriel des noms CE1 grammaire).', 'begin;']
for i, (e, b, d) in UPD.items():
    sql.append(f"update contenu_questions set bonne_reponse = '{q(b)}', mauvais_choix = array[{','.join(chr(39)+q(x)+chr(39) for x in d)}], modifie_le = now() where id = {i};")
sql += ['commit;', 'select fn_publier();']
open('correctifs_2026-10-03_sujet_pluriel.sql', 'w', encoding='utf-8').write('\n'.join(sql) + '\n')
for i, (e, b, d) in list(UPD.items()):
    print(i, b, '|', ' / '.join(d))
print(len(UPD))
