from en_common import *
from banks import BANKS
R=random.Random(11)
def pick(pool,ans,k=3,excl=()):
    p=[x for x in pool if x!=ans and x not in excl]
    p=list(dict.fromkeys(p))
    return R.sample(p,k) if len(p)>=k else None
def vocab_cands(cl,code):
    g=GR[cl]
    words=[w for w in BANKS[code] if w[3]<=g]
    ens=[w[1] for w in words]; frs=[w[0] for w in words]; ems=[w[2] for w in words if w[2]]
    out=[]
    import unicodedata
    def sa(x): return ''.join(c for c in unicodedata.normalize('NFD',x.lower()) if unicodedata.category(c)!='Mn').replace('-',' ')
    def cognate(a,b):
        a,b=sa(a),sa(b)
        if a==b or a.startswith(b) or b.startswith(a): return True
        import difflib
        return difflib.SequenceMatcher(None,a,b).ratio()>=0.8
    from banks import category
    for fr,en,em,wg in words:
        cat=category(code,en)
        ens=[w[1] for w in words if category(code,w[1])==cat]; frs=[w[0] for w in words if category(code,w[1])==cat]
        ems=[w[2] for w in words if w[2] and category(code,w[1])==cat]
        pr=abs(g-wg) if g>=2 else 0
        cog=cognate(fr,en)
        same_fr=[w[0] for w in words if w[1]==en]; same_en=[w[1] for w in words if w[0]==fr]
        c=None if cog else pick(ens,en,excl=same_en)
        if c: out.append((pr,R.random(),(f'Comment dit-on "{fr}" en anglais ?',en,c)))
        c=None if cog else pick(frs,fr,excl=same_fr)
        if c: out.append((pr,R.random(),(f'Que veut dire "{en}" en français ?',fr,c)))
        if em:
            c=pick([w[1] for w in words if w[2] and category(code,w[1])==cat] or ens,en)
            if c: out.append((pr+0.5,R.random(),(f'Comment dit-on {em} en anglais ?',en,c)))
            c=pick(ems,em)
            if c: out.append((pr+0.5,R.random(),(f'Quel dessin correspond à "{en}" ?',em,c)))
    out.sort(key=lambda t:(t[0],t[1]))
    return [t[2] for t in out]
REST={}
for k in sorted(G):
    cl,mat,code=k
    if mat=='english' and code in BANKS:
        r=run(cl,code,vocab_cands(cl,code))
        if r: REST[k]=r
