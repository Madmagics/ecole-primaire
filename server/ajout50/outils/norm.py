import re,unicodedata
ART=r"^(le |la |les |l'|un |une |des |du |de la |de l'|the |a |an )"
def nw(s):
    s=s.strip().lower().replace('œ','oe').replace('’',"'")
    s=re.sub(r'\s+',' ',s)
    s=re.sub(ART,'',s)
    s=s.rstrip(' .?!')
    return s
def key(r):
    e=r['enonce'].strip().lower().replace('œ','oe').replace('’',"'")
    e=re.sub(r'\s+',' ',e)
    e=re.sub(r'"([^"]*)"',lambda m:'"'+nw(m.group(1))+'"',e)
    e=re.sub(r'«\s*([^»]*?)\s*»',lambda m:'"'+nw(m.group(1))+'"',e)
    return (r['classe'],r['matiere'],e,nw(r['bonne_reponse']),r.get('grille',''))
