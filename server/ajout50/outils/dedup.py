import collections
from load import rows
from norm import key
WEAK={'en_gouts':2,'en_avoir_etre':2,'en_decrire_position':2}
d=collections.defaultdict(list)
for r in rows: d[key(r)].append(r)
ARCH=[]
for k,v in d.items():
    if len(v)>1:
        v=sorted(v,key=lambda r:(WEAK.get(r['code'],0),int(r['id'])))
        ARCH+=v[1:]
ARCH_COUNT=collections.Counter((r['classe'],r['matiere'],r['code']) for r in ARCH)
