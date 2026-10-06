from common import *
R=random.Random(42)

def parity(cl,lo,hi):
    code='pair_impair'
    n=need(cl,'math',code)
    tries=0
    while n>0 and tries<5000:
        tries+=1
        if n%3==0:
            # format choix multiple
            want=R.choice(['pair','impair'])
            par=0 if want=='pair' else 1
            good=R.choice([x for x in range(lo,hi) if x%2==par])
            bads=set()
            while len(bads)<3:
                b=R.randrange(lo,hi)
                if b%2!=par: bads.add(b)
            if add(cl,'math',code,f"Parmi ces nombres, lequel est {want} ?",str(good),[str(b) for b in bads]): n-=1
        else:
            x=R.randrange(lo,hi)
            b='pair' if x%2==0 else 'impair'
            if add(cl,'math',code,f"Le nombre {x} est-il pair ou impair ?",b,['impair' if b=='pair' else 'pair']): n-=1

def perimetre(cl,maxL,unit='cm'):
    code='perimetre'
    n=need(cl,'math',code); tries=0
    while n>0 and tries<5000:
        tries+=1
        kind=R.choice(['rect','rect','carre','tri'])
        if kind=='rect':
            L=R.randint(4,maxL); l=R.randint(2,L-1)
            p=2*(L+l); wrong={L+l,L*2+l,2*L+2*l+2, p-2, p+4}
            e=f"Quel est le périmètre, en {unit}, d'un rectangle de longueur {L} {unit} et de largeur {l} {unit} ?"
        elif kind=='carre':
            c=R.randint(2,maxL); p=4*c; wrong={2*c,3*c,4*c+4,c+4,5*c}
            e=f"Quel est le périmètre, en {unit}, d'un carré de côté {c} {unit} ?"
        else:
            a,b,c=sorted(R.sample(range(3,maxL),3))
            if a+b<=c: continue
            p=a+b+c; wrong={a+b,p+2,p-1,b+c,2*c}
            e=f"Quel est le périmètre, en {unit}, d'un triangle dont les côtés mesurent {a} {unit}, {b} {unit} et {c} {unit} ?"
        wrong.discard(p); w=R.sample(sorted(wrong),3)
        if add(cl,'math',code,e,str(p),[str(x) for x in w]): n-=1

def suites(cl,steps,lo,hi):
    code='suites_nombres'
    n=need(cl,'math',code); tries=0
    while n>0 and tries<20000:
        tries+=1
        s=R.choice(steps); start=R.randrange(lo,hi)
        down=R.random()<0.35
        seq=[start+i*s for i in range(5)]
        if down: seq=seq[::-1]
        if min(seq)<0 or (cl=='ce1' and max(seq)>999): continue
        pos=R.randint(1,3); ans=seq[pos]
        shown=[str(x) if i!=pos else '___' for i,x in enumerate(seq)]
        wrong={ans+s//2 if s>=2 else ans+2, ans-s//2 if s>=2 else ans-2, ans+s if not down else ans-s, ans+10 if s!=10 else ans+100, ans+1, ans-1}
        wrong={w for w in wrong if w>=0 and w!=ans and w not in seq}
        if len(wrong)<3: continue
        w=R.sample(sorted(wrong),3)
        if add(cl,'math',code,f"{', '.join(shown)}. Quel nombre manque ?",str(ans),[str(x) for x in w]): n-=1

def comparer_ce2():
    code='comparer_nombres'
    n=need('ce2','math',code); tries=0
    while n>0 and tries<5000:
        tries+=1
        a=R.randint(1000,9999)
        # nombres proches pour obliger à comparer chiffre par chiffre
        mode=R.random()
        if mode<0.4: b=int(str(a)[0]+''.join(R.sample(str(a)[1:],3)))
        elif mode<0.7: b=a+R.choice([-1,1])*R.randint(10,900)
        else: b=R.randint(1000,9999)
        if b==a or not 1000<=b<=9999: continue
        mot=R.choice(['petit','grand'])
        good=min(a,b) if mot=='petit' else max(a,b)
        bad=max(a,b) if mot=='petit' else min(a,b)
        if add('ce2','math',code,f"Quel nombre est le plus {mot} : {a} ou {b} ?",str(good),[str(bad)]): n-=1

def mesures_cm2():
    code='mesures'
    n=need('cm2','math',code)
    conv=[('grammes','kg',1000,'g'),('mètres','km',1000,'m'),('centilitres','L',100,'cL'),('millilitres','L',1000,'mL'),
          ('millimètres','cm',10,'mm'),('centimètres','m',100,'cm'),('millimètres','m',1000,'mm'),('minutes','h',60,'min'),
          ('secondes','min',60,'s'),('kilogrammes','t',1000,'kg'),('millilitres','cL',10,'mL'),('décimètres','m',10,'dm'),
          ('centimètres','dm',10,'cm'),('mètres','hm',100,'m'),('heures','jours',24,'h')]
    items=[]
    for mot,u,f,_ in conv:
        for v in range(2,13):
            items.append((mot,u,f,v))
    # quelques décimaux simples
    for mot,u,f,_ in conv[:7]:
        for v in ['1,5','2,5','3,5','0,5','4,2','1,25']:
            items.append((mot,u,f,v))
    R.shuffle(items)
    for mot,u,f,v in items:
        if n<=0: break
        if isinstance(v,str):
            if f==10 and v.count(',') and len(v.split(',')[1])>1: continue
            x=float(v.replace(',','.'))*f
            if abs(x-round(x))>1e-9: continue
            ans=int(round(x))
        else: ans=v*f
        if f in (60,24) and isinstance(v,str): continue
        if f in (60,24):
            vv=int(v); wrong={vv*100,vv*10,vv*f+f,vv+f, vv*f-f}
        else:
            vv=float(str(v).replace(',','.'))
            wrong={ans*10, ans*100 if ans<1000 else ans//100, ans+f}
            if ans%10==0: wrong.add(ans//10)
        wrong.discard(ans); wrong={w for w in wrong if w>0}
        if len(wrong)<3: continue
        w=R.sample(sorted(wrong),3)
        uu=u if u!='jours' else 'jours'
        de="d'" if mot[0] in "aeiouhé" else "de "
        e=f"Combien {de}{mot} y a-t-il dans {v} {uu} ?"
        if add('cm2','math',code,e,str(ans),[str(x) for x in w]): n-=1

parity('cp',1,100); parity('ce1',100,1000); parity('ce2',1000,10000)
perimetre('ce1',20); perimetre('cm1',40)
suites('ce1',[2,5,10,20,50,100],0,800)
suites('ce2',[25,50,100,200,500,1000],100,5000)
comparer_ce2(); mesures_cm2()
