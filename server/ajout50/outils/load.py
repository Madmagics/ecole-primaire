import csv,collections
rows=[r for r in csv.DictReader(open('/home/claude/w/q.tsv'),delimiter='\t') if r['statut']=='publie']
G=collections.defaultdict(list)
for r in rows: G[(r['classe'],r['matiere'],r['code'])].append(r)
low=sorted(k for k,v in G.items() if len(v)<50)
