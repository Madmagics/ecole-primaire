import re, random, collections, sys
from noyau import noyau
rows = [l.rstrip('\n').split('\t') for l in open('q.tsv', encoding='utf-8')]
GARDE = 5
def paire(e, b):
    m1 = re.match(r'Comment dit-on "(.+)" en anglais \?$', e); m2 = re.match(r'Que veut dire "(.+)" en français \?$', e)
    if m1: return 'fr2en', m1.group(1), b
    if m2: return 'en2fr', b, m2.group(1)
    return None
groupes = collections.defaultdict(list)
for r in rows:
    i, cl, code, e, b, d = r
    p = paire(e, b)
    if not p: continue
    n = noyau(p[1], p[2])
    if n: groupes[(cl, code, n[0])].append((r, p[0], n[1], n[2]))
q = lambda s: s.replace("'", "''")
sql = ['-- AUDITS_LOG #35 (2026-10-03) : anglais, phrases-cadres ramenees au mot essentiel ("j\'ai un animal, c\'est un chien" -> "un chien").', 'begin;']
stats = collections.Counter(); exemples = []
for (cl, code, fam), L in sorted(groupes.items()):
    # 1. on garde GARDE phrases entieres, de mots differents
    vus, gardes = set(), []
    for x in L:
        if len(gardes) < GARDE and x[2] not in vus:
            gardes.append(x[0][0]); vus.add(x[2])
    mots_fr = sorted(set(x[2] for x in L)); mots_en = sorted(set(x[3] for x in L))
    slots = set()
    for (r, sens, wf, we) in L:
        i = r[0]
        if i in gardes:
            stats['gardees'] += 1; continue
        cle = (wf, we, sens)
        if cle in slots:
            sql.append(f"update contenu_questions set statut = 'archive', modifie_le = now() where id = {i};"); stats['archivees'] += 1; continue
        slots.add(cle)
        rnd = random.Random(i)
        if sens == 'fr2en':
            enon, bonne = f'Comment dit-on "{wf}" en anglais ?', we
            pool = [w for w in mots_en if w != we]
        else:
            enon, bonne = f'Que veut dire "{we}" en français ?', wf
            pool = [w for w in mots_fr if w != wf]
        if len(pool) < 3:
            sql.append(f"update contenu_questions set statut = 'archive', modifie_le = now() where id = {i};"); stats['archivees'] += 1; continue
        pl = lambda w: (w.endswith('s'), w.split()[0] in ('le', 'la', "l'", 'les', 'des', 'un', 'une', 'a', 'an') or w.startswith("l'"))
        proches = [w for w in pool if pl(w) == pl(bonne)]
        dist = rnd.sample(proches, 3) if len(proches) >= 3 else rnd.sample(pool, 3)
        sql.append(f"update contenu_questions set enonce = '{q(enon)}', bonne_reponse = '{q(bonne)}', mauvais_choix = array[{','.join(chr(39)+q(x)+chr(39) for x in dist)}], modifie_le = now() where id = {i};")
        stats['converties'] += 1
        if len(exemples) < 400: exemples.append((cl, code, fam, r[3], '=>', enon, bonne, dist))
    stats[f'{cl} {code} {fam}'] = len(L)
sql += ['commit;', 'select fn_publier();']
open('correctifs_2026-10-03_anglais_mots.sql', 'w', encoding='utf-8').write('\n'.join(sql) + '\n')
for k, v in stats.items(): print(v, k)
for x in exemples[::25]: print(*x)
