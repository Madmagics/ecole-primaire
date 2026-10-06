import random, collections
from load import rows, G
from norm import key
EXIST=set(key(r) for r in rows)
OUT=[]
def add(classe,matiere,code,enonce,bonne,choix,grille=''):
    choix=[c for c in choix]
    assert bonne not in choix, (enonce,bonne,choix)
    assert len(set(choix))==len(choix) and 1<=len(choix)<=3, (enonce,choix)
    r=dict(classe=classe,matiere=matiere,code=code,enonce=enonce,bonne_reponse=bonne,choix=choix,grille=grille)
    k=key(r)
    if k in EXIST: return False
    EXIST.add(k); OUT.append(r); return True
def need(classe,matiere,code,target=50):
    have=len(G[(classe,matiere,code)]) - ARCH_COUNT.get((classe,matiere,code),0)
    have+=sum(1 for r in OUT if (r['classe'],r['matiere'],r['code'])==(classe,matiere,code))
    return max(0,target-have)
from dedup import ARCH_COUNT
