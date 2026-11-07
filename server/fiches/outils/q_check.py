# Verification des questions HG : 30 par notion, 3 mauvais choix distincts, pas de reponse visible,
# pas de parentheses, pas de doublon d'enonce.
import importlib, sys, re
def check(mod):
    m = importlib.import_module(mod); pb = 0
    for code, qs in m.Q.items():
        if len(qs) != 30: print(mod, code, 'nb =', len(qs)); pb += 1
        vus = set()
        for q in qs:
            if len(q) != 5: print('format', q); pb += 1; continue
            e, b, *w = q
            if e in vus: print('doublon', code, e); pb += 1
            vus.add(e)
            if len(set([b] + w)) != 4: print('choix en double', code, q); pb += 1
            if '(' in e or ')' in e: print('parenthese', code, e); pb += 1
            if len(b) > 3 and re.search(r'\b' + re.escape(b.lower()) + r'\b', e.lower()): print('reponse visible', code, e, '->', b); pb += 1
    print(mod, sum(len(v) for v in m.Q.values()), 'questions,', pb, 'probleme(s)')
for a in sys.argv[1:]: check(a)
