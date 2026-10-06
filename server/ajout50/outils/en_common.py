from common import *
from norm import nw
import re
GR={'cp':0,'ce1':1,'ce2':2,'cm1':3,'cm2':4}
def ekey(cl,e):
    e=e.strip().lower().replace('œ','oe').replace('’',"'").replace('«','"').replace('»','"')
    e=re.sub(r'"\s*([^"]*?)\s*"',lambda m:'"'+nw(m.group(1))+'"',e)
    return (cl,re.sub(r'\s+',' ',e))
EN_ENONCES=set(ekey(r['classe'],r['enonce']) for r in rows if r['matiere']=='english')
def addq(cl,code,e,b,ch):
    k=ekey(cl,e)
    if k in EN_ENONCES: return False
    if add(cl,'english',code,e,b,ch):
        EN_ENONCES.add(k); return True
    return False
def run(cl,code,cands):
    n=need(cl,'english',code)
    for e,b,ch in cands:
        if n<=0: break
        if addq(cl,code,e,b,ch): n-=1
    return n
