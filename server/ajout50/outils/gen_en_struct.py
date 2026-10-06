from en_common import *
R=random.Random(23)

def pairs_cands(pairs, both=True, fr_first=True):
    """pairs: list of (fr, en). Questions FR->EN et EN->FR, distracteurs pris dans la même liste."""
    out=[]
    for fr,en in pairs:
        oth_en=[e for f,e in pairs if e!=en]; oth_fr=[f for f,e in pairs if f!=fr]
        if len(set(oth_en))>=3:
            out.append((f'Comment dit-on "{fr}" en anglais ?',en,R.sample(sorted(set(oth_en)),3)))
        if both and len(set(oth_fr))>=3:
            out.append((f'Que veut dire "{en}" en français ?',fr,R.sample(sorted(set(oth_fr)),3)))
    R.shuffle(out)
    return out

def fill(items):
    """items: (phrase avec ___, bonne, [mauvaises]) -> 'Complète : ...'"""
    out=[(f'Complète : {p}',b,list(w)) for p,b,w in items]
    R.shuffle(out); return out

def mix(*lists):
    """entrelace plusieurs listes de candidats pour varier les formats"""
    out=[]; ls=[list(l) for l in lists]
    while any(ls):
        for l in ls:
            if l: out.append(l.pop(0))
    return out

DAYS=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']
JOURS=['lundi','mardi','mercredi','jeudi','vendredi','samedi','dimanche']
MONTHS=['January','February','March','April','May','June','July','August','September','October','November','December']
MOIS=['janvier','février','mars','avril','mai','juin','juillet','août','septembre','octobre','novembre','décembre']
SEASONS=['spring','summer','autumn','winter']; SAISONS=['printemps','été','automne','hiver']

def order_cands(seq, label, cyc=True):
    out=[]
    n=len(seq)
    for i,x in enumerate(seq):
        for rel,j in (('après',i+1),('avant',i-1)):
            if not cyc and not (0<=j<n): continue
            ans=seq[j%n]
            wrong=[seq[(i+d)%n] for d in (0,2,-2,3) if seq[(i+d)%n]!=ans]
            wrong=list(dict.fromkeys(wrong))[:3]
            q='Quelle' if label=='saison' else 'Quel'
            out.append((f'{q} {label} vient {rel} "{x}" ?',ans,wrong))
    R.shuffle(out); return out

NUM_EN=['zero','one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen','twenty']
def num_en(n):
    if n<=20: return NUM_EN[n]
    tens=['','','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety']
    if n<100: return tens[n//10]+('' if n%10==0 else '-'+NUM_EN[n%10])
    if n<1000:
        h=NUM_EN[n//100]+' hundred'; r=n%100
        return h if r==0 else h+' and '+num_en(r)
    if n==1000: return 'one thousand'
def num_cands(lo,hi,calc_max,R2):
    out=[]
    nums=list(range(lo,hi+1)); R2.shuffle(nums)
    for n in nums:
        near=[m for m in (n-1,n+1,n+10,n-10,n+2) if lo<=m<=hi and m!=n] or [m for m in range(lo,hi+1) if m!=n]
        w=R2.sample(near,min(3,len(near)))
        if len(w)<3: continue
        out.append((f'Comment écrit-on le nombre {n} en anglais ?',num_en(n),[num_en(x) for x in w]))
        out.append((f'Quel nombre s\'écrit "{num_en(n)}" ?',str(n),[str(x) for x in w]))
    calc=[]
    for _ in range(200):
        a=R2.randint(1,calc_max); b=R2.randint(1,calc_max)
        op=R2.choice('+-')
        if op=='-' and a<b: a,b=b,a
        r=a+b if op=='+' else a-b
        if r>max(hi,20) or r<0: continue
        w=[x for x in (r+1,r-1,r+2,r+10) if x>=0 and x!=r][:3]
        sym='plus' if op=='+' else 'minus'
        calc.append((f'Combien font "{num_en(a)} {sym} {num_en(b)}" ? Réponds en anglais.',num_en(r),[num_en(x) for x in w]))
    return mix(out,calc)

ORD=['first','second','third','fourth','fifth','sixth','seventh','eighth','ninth','tenth','eleventh','twelfth']
ORDFR=['premier','deuxième','troisième','quatrième','cinquième','sixième','septième','huitième','neuvième','dixième','onzième','douzième']

# =========================== CALENDRIER
cal_cp=mix(order_cands(DAYS,'jour'), pairs_cands(list(zip(JOURS,DAYS))+list(zip(MOIS,MONTHS))))
run('cp','en_calendrier',cal_cp)
cal_ce1=mix(order_cands(DAYS,'jour'),order_cands(MONTHS,'mois'),
    pairs_cands([('matin','morning'),('après-midi','afternoon'),('soir','evening'),('nuit','night'),('aujourd\'hui','today'),('demain','tomorrow'),('hier','yesterday'),('semaine','week'),('week-end','weekend'),('midi','noon'),('minuit','midnight')]),
    pairs_cands(list(zip(JOURS,DAYS))+list(zip(MOIS,MONTHS))))
run('ce1','en_calendrier',cal_ce1)
cal_ce2=mix(order_cands(MONTHS,'mois'),order_cands(SEASONS,'saison'),
    pairs_cands(list(zip(SAISONS,SEASONS))+[('mois','month'),('année','year'),('jour','day'),('semaine','week'),('anniversaire','birthday'),('heure','hour'),('minute','minute')]),
    [(f'En anglais, dans quelle saison se trouve le mois de "{m}" ?',s,[x for x in SEASONS if x!=s]) for m,s in [('January','winter'),('April','spring'),('July','summer'),('October','autumn'),('August','summer'),('December','winter'),('May','spring'),('November','autumn')]])
run('ce2','en_calendrier',cal_ce2)
dates=[]
for d,m in [(1,'May'),(3,'June'),(2,'March'),(5,'July'),(4,'October'),(8,'April'),(10,'December'),(12,'August'),(6,'January'),(9,'September'),(7,'November'),(11,'February')]:
    fr=f'le {"1er" if d==1 else d} {MOIS[MONTHS.index(m)]}'
    good=f'the {ORD[d-1]} of {m}'
    w=[f'the {num_en(d)} of {m}', f'the {ORD[(d)%12]} of {m}', f'the {ORD[d-1]} of {MONTHS[(MONTHS.index(m)+1)%12]}']
    dates.append((f'Comment dit-on "{fr}" en anglais ?',good,w))
R.shuffle(dates)
cal_cm2=mix(dates,order_cands(MONTHS,'mois'),order_cands(SEASONS,'saison'),
    pairs_cands([('la semaine prochaine','next week'),('la semaine dernière','last week'),('après-demain','the day after tomorrow'),('avant-hier','the day before yesterday'),('l\'année prochaine','next year'),('l\'année dernière','last year'),('ce soir','tonight'),('minuit','midnight'),('le week-end','the weekend'),('anniversaire','birthday'),('siècle','century')]))
run('cm2','en_calendrier',cal_cm2)

# =========================== NOMBRES
run('cp','en_nombres',num_cands(0,12,5,random.Random(1)))
run('ce1','en_nombres',mix(num_cands(13,31,10,random.Random(2)),pairs_cands(list(zip(ORDFR[:10],ORD[:10])))))
ce2n=[]
for n in [20,30,40,50,60,70,80,90,100,35,47,52,68,73,81,99,64,26,58,77]:
    w=[x for x in (n+10,n-10,n+1,n+5) if 0<x<=100][:3]
    ce2n.append((f'Comment écrit-on le nombre {n} en anglais ?',num_en(n),[num_en(x) for x in w]))
    ce2n.append((f'Quel nombre s\'écrit "{num_en(n)}" ?',str(n),[str(x) for x in w]))
R.shuffle(ce2n)
ce2c=[]
for a,b in [(10,20),(30,40),(50,20),(25,25),(60,30),(40,40),(70,20),(15,15),(45,5),(80,10)]:
    r=a+b; w=[r+10,r-10,r+1]
    ce2c.append((f'Combien font "{num_en(a)} plus {num_en(b)}" ? Réponds en anglais.',num_en(r),[num_en(x) for x in w]))
run('ce2','en_nombres',mix(ce2n,ce2c))
cm1n=[]
for n in [100,200,300,400,500,600,700,800,900,1000,150,250,120,310,505,999,640,875]:
    w=[x for x in (n+100,n-100,n+10,n+50) if 0<x<=1000][:3]
    cm1n.append((f'Comment écrit-on le nombre {n} en anglais ?',num_en(n),[num_en(x) for x in w]))
    cm1n.append((f'Quel nombre s\'écrit "{num_en(n)}" ?',str(n),[str(x) for x in w]))
R.shuffle(cm1n)
cm1o=[]
for i in range(10):
    w=[ORD[j] for j in (i+1,i-1 if i>0 else 11, i+2)]
    suf={1:'st',2:'nd',3:'rd'}.get(i+1,'th')
    cm1o.append((f'Comment écrit-on "{i+1}{suf}" en toutes lettres ?',ORD[i],w))
run('cm1','en_nombres',mix(cm1n,cm1o))

# =========================== VERBES
VCP=[('saute','jump','🦘'),('cours','run','🏃'),('nage','swim','🏊'),('danse','dance','💃'),('chante','sing','🎤'),('dessine','draw','🎨'),('lis','read','📖'),('écris','write','✍️'),('mange','eat','🍽️'),('bois','drink','🥤'),('dors','sleep','😴'),('marche','walk','🚶'),('joue','play',''),('grimpe','climb','🧗'),('vole','fly','🕊️'),('écoute','listen','👂'),('regarde','look','👀'),('assieds-toi','sit down',''),('lève-toi','stand up',''),('tape des mains','clap your hands','👏')]
def verb_cands(lst):
    out=pairs_cands([(f,e) for f,e,_ in lst])
    em=[(f'Quelle action montre {m} ? Réponds en anglais.',e,R.sample([x for _,x,mm in lst if x!=e and mm],3)) for _,e,m in lst if m]
    R.shuffle(em)
    return mix(out,em)
run('cp','en_verbes',verb_cands(VCP))
VCE1=[('nager','swim','🏊'),('courir','run','🏃'),('sauter','jump',''),('chanter','sing','🎤'),('danser','dance','💃'),('dessiner','draw','🎨'),('lire','read','📖'),('écrire','write','✍️'),('manger','eat','🍽️'),('boire','drink','🥤'),('dormir','sleep','😴'),('marcher','walk','🚶'),('jouer','play',''),('grimper','climb','🧗'),('voler','fly',''),('écouter','listen',''),('regarder','watch','📺'),('cuisiner','cook','🍳'),('pleurer','cry','😭'),('rire','laugh','😂'),('parler','speak','🗣️'),('ouvrir','open',''),('fermer','close',''),('laver','wash',''),('aider','help',''),('skier','ski','⛷️'),('pêcher','fish','🎣')]
run('ce1','en_verbes',verb_cands(VCE1))
VCE2=[('je commence','I start'),('je finis','I finish'),('je réponds','I answer'),('j\'attrape','I catch'),('je m\'assois','I sit'),('j\'enseigne','I teach'),('je nage','I swim'),('je trouve','I find'),('je chante','I sing'),('j\'écoute','I listen'),('j\'aide','I help'),('je cuisine','I cook'),('j\'attends','I wait'),('je joue','I play'),('je lis','I read'),('je marche','I walk'),('je parle','I speak'),('j\'ouvre','I open'),('je ferme','I close'),('je lave','I wash'),('je regarde','I watch'),('je pleure','I cry'),('je ris','I laugh'),('je cours','I run'),('je dors','I sleep'),('je bois','I drink'),('je mange','I eat'),('j\'écris','I write'),('je dessine','I draw'),('je danse','I dance'),('je saute','I jump'),('j\'apprends','I learn'),('je compte','I count'),('je porte','I carry'),('je pousse','I push'),('je tire','I pull')]
run('ce2','en_verbes',pairs_cands(VCE2))
VCM2=[('boire','to drink'),('lire','to read'),('écrire','to write'),('chanter','to sing'),('jouer','to play'),('dormir','to sleep'),('manger','to eat'),('nager','to swim'),('courir','to run'),('danser','to dance'),('acheter','to buy'),('vendre','to sell'),('construire','to build'),('apprendre','to learn'),('oublier','to forget'),('choisir','to choose'),('voyager','to travel'),('fermer','to close'),('ouvrir','to open'),('porter','to carry'),('envoyer','to send'),('gagner','to win'),('perdre','to lose'),('penser','to think'),('attraper','to catch'),('enseigner','to teach'),('conduire','to drive'),('comprendre','to understand'),('se souvenir','to remember'),('commencer','to begin'),('donner','to give'),('prendre','to take'),('trouver','to find'),('chercher','to look for'),('montrer','to show'),('raconter','to tell'),('demander','to ask'),('répondre','to answer'),('rencontrer','to meet'),('essayer','to try'),('partager','to share'),('nettoyer','to clean'),('réparer','to fix'),('cacher','to hide')]
run('cm2','en_verbes',pairs_cands(VCM2))

# =========================== AVOIR / ÊTRE
cp_ae=[]
for x,e in [('a dog','🐶'),('a cat','🐱'),('a ball','⚽'),('a book','📕'),('a bike','🚲'),('a sister',''),('a brother',''),('a pencil','✏️'),('an apple','🍎'),('a banana','🍌'),('a fish','🐟'),('a rabbit','🐰'),('a hat','🎩'),('a cake','🍰'),('a car','🚗')]:
    cp_ae.append((f'I ___ {x}{" "+e if e else ""}.','have',['am']))
for x,e in [('happy','😀'),('sad','😢'),('tired','😴'),('hungry',''),('angry','😠'),('scared','😨'),('a boy',''),('a girl',''),('six',''),('seven',''),('thirsty',''),('ill','🤒'),('surprised','😮')]:
    cp_ae.append((f'I ___ {x}{" "+e if e else ""}.','am',['have']))
cp_tr=pairs_cands([('je suis','I am'),('j\'ai','I have'),('tu es','you are'),('tu as','you have'),('il est','he is'),('elle est','she is')])
run('cp','en_avoir_etre',mix(fill(cp_ae),cp_tr))
run('ce1','en_avoir_etre',mix(fill([('He ___ a dog.','has',['have','is']),('She ___ happy.','is',['are','has']),('You ___ tired.','are',['is','has']),('They ___ a big house.','have',['has','are']),('I ___ eight.','am',['is','have']),('We ___ hungry.','are',['is','have'])])))
cm1_ae=[]
for s,v in [('He','has'),('She','has'),('My brother','has'),('I','have'),('You','have'),('We','have'),('They','have'),('Tom and Lucy','have')]:
    for obj in ['a red bike','two sisters','a new bag','blue eyes','a garden']:
        cm1_ae.append((f'{s} ___ {obj}.',v,['has' if v=='have' else 'have','is' if v=='has' else 'are']))
for s,v in [('He','is'),('She','is'),('I','am'),('You','are'),('We','are'),('They','are'),('My brother','is'),('My parents','are')]:
    for adj in ['tall','tired','at school','eleven','in the garden']:
        w=['am','is','are']; w.remove(v); cm1_ae.append((f'{s} ___ {adj}.',v,w+['has' if v=='is' else 'have']))
R.shuffle(cm1_ae)
cm1_tr=pairs_cands([('il a','he has'),('elle a','she has'),('nous avons','we have'),('ils ont','they have'),('vous êtes','you are'),('nous sommes','we are'),('ils sont','they are'),('je suis','I am'),('il est','he is'),('elle n\'a pas','she hasn\'t got'),('je n\'ai pas','I haven\'t got'),('il n\'est pas','he isn\'t')])
run('cm1','en_avoir_etre',mix(fill(cm1_ae[:60]),cm1_tr))

# =========================== DÉCRIRE / POSITION
POSI=[('sur','on'),('sous','under'),('dans','in'),('à côté de','next to'),('derrière','behind'),('devant','in front of'),('entre','between')]
OBJ=[('le chat','the cat'),('le chien','the dog'),('le ballon','the ball'),('le livre','the book'),('la souris','the mouse'),('le crayon','the pencil')]
PLACE=[('la table','the table'),('le lit','the bed'),('la boîte','the box'),('la chaise','the chair'),('le sac','the bag')]
def posphr(fo,eo,fp,ep,fl,el):
    fr=f'{fo} est {fp} {fl}'.replace('à côté de le ','à côté du ').replace('de le ','du ')
    return fr,f'{eo.capitalize()} is {ep} {el}'
pos_sent=[]
for fo,eo in OBJ:
    for fl,el in PLACE:
        for fp,ep in POSI[:6]:
            if ep=='in' and el not in ('the box','the bag'): continue
            if el=='the bag' and ep=='on' and eo in ('the dog',): continue
            pos_sent.append((fo,eo,fp,ep,fl,el))
R.shuffle(pos_sent)
def pos_cands(nb):
    out=[]
    for fo,eo,fp,ep,fl,el in pos_sent[:nb]:
        fr,en=posphr(fo,eo,fp,ep,fl,el)
        w=[posphr(fo,eo,fp,x,fl,el)[1] for _,x in R.sample([p for p in POSI[:6] if p[1]!=ep],3)]
        out.append((f'Comment dit-on "{fr}" en anglais ?',en,w))
    return out
OKCOL={'cat':['black','white'],'dog':['black','white'],'ball':['red','blue','green','yellow','black','white'],'car':['red','blue','green','yellow','black','white'],'hat':['red','blue','green','yellow','black','white'],'flower':['red','yellow','white','blue'],'bird':['blue','yellow','black','white'],'apple':['red','green','yellow']}
COL=[('rouge','red'),('bleu','blue'),('vert','green'),('jaune','yellow'),('noir','black'),('blanc','white')]
NOUNS=[('un chat','cat','une'),('un chien','dog',''),('un ballon','ball',''),('une voiture','car',''),('un chapeau','hat',''),('une fleur','flower',''),('un oiseau','bird',''),('une pomme','apple','')]
def adj_cands(sizes=False):
    out=[]
    for fn,en,_ in NOUNS:
        fem=fn.startswith('une')
        for fc,ec in COL:
            if ec not in OKCOL[en]: continue
            fca=fc+('e' if fem and not fc.endswith('e') else '')
            if fc=='blanc' and fem: fca='blanche'
            art='an' if ec[0] in 'aeiou' else 'a'
            good=f'{art} {ec} {en}'
            art2='an' if en[0] in 'aeiou' else 'a'
            c2=R.choice([c for c in OKCOL[en] if c!=ec]); art4='an' if c2[0] in 'aeiou' else 'a'
            wrong=[f'{art2} {en} {ec}', f'{art4} {c2} {en}']
            o=R.choice([n for _,n,_ in NOUNS if n!=en and ec in OKCOL[n]]); art3='an' if ec[0] in 'aeiou' else 'a'
            wrong.append(f'{art3} {ec} {o}')
            out.append((f'Comment dit-on "{fn} {fca}" en anglais ?',good,wrong))
    R.shuffle(out); return out
run('cp','en_decrire_position',mix(adj_cands(),pairs_cands(POSI[:6])))
run('ce1','en_decrire_position',mix(pos_cands(40),adj_cands()))
thereis=[]
for n,(fr,en,frp,enp) in zip([2,3,4,5,6,8,9,10],[('chat','cat','chats','cats'),('chien','dog','chiens','dogs'),('arbre','tree','arbres','trees'),('fleur','flower','fleurs','flowers'),('livre','book','livres','books'),('voiture','car','voitures','cars'),('maison','house','maisons','houses'),('vélo','bike','vélos','bikes')]):
    ne=num_en(n)
    thereis.append((f'There ___ {ne} {enp} in the picture.','are',['is','am']))
    thereis.append((f'There ___ a {en} in the picture.','is',['are','am']))
ce2_pos=[('en haut','at the top'),('en bas','at the bottom'),('au milieu','in the middle'),('à gauche','on the left'),('à droite','on the right')]
run('ce2','en_decrire_position',mix(fill(thereis),pairs_cands(ce2_pos)))

# =========================== CONSIGNES / OBLIGATION
ce1c=[]
for fr,en in [('faire du vélo','ride a bike'),('jouer au football','play football'),('patiner','skate'),('skier','ski'),('cuisiner','cook'),('siffler','whistle'),('compter jusqu\'à dix','count to ten'),('jouer du piano','play the piano'),('lire l\'heure','tell the time'),('faire du cheval','ride a horse')]:
    ce1c.append((f'je sais {fr}',f'I can {en}'))
    ce1c.append((f'je ne sais pas {fr}',f'I can\'t {en}'))
ce1q=[(f'Que veut dire "Can you {en}?" en français ?',f'sais-tu {fr} ?',[f'je sais {fr}',f'je ne sais pas {fr}',f'veux-tu {fr} ?']) for fr,en in [('nager','swim'),('danser','dance'),('chanter','sing'),('lire','read'),('courir vite','run fast'),('dessiner','draw')]]
run('ce1','en_consignes_obligation',mix(pairs_cands(ce1c,both=False),ce1q,fill([('I can swim. Yes, I ___ !','can',['can\'t','am']),('Can you fly? No, I ___ .','can\'t',['can','don\'t'])])))
must=[('tu dois fermer la porte','You must close the door'),('tu dois ranger ta chambre','You must tidy your room'),('tu dois te brosser les dents','You must brush your teeth'),('tu dois faire tes devoirs','You must do your homework'),('tu dois dire merci','You must say thank you'),('tu dois attendre ton tour','You must wait your turn'),('tu dois porter un casque','You must wear a helmet'),('tu ne dois pas parler','You mustn\'t talk'),('tu ne dois pas toucher le four','You mustn\'t touch the oven'),('tu ne dois pas jeter de papiers par terre','You mustn\'t drop litter'),('tu ne dois pas traverser au feu rouge','You mustn\'t cross at the red light'),('tu ne dois pas mentir','You mustn\'t lie'),('tu ne dois pas nager seul','You mustn\'t swim alone')]
mustf=[('✅ You ___ wear a seatbelt in the car.','must',['mustn\'t','can\'t']),('⛔ You ___ run in the corridor.','mustn\'t',['must','can']),('✅ You ___ listen to the teacher.','must',['mustn\'t','don\'t']),('⛔ You ___ eat in class.','mustn\'t',['must','are']),('✅ You ___ wash your hands before lunch.','must',['mustn\'t','can\'t']),('⛔ You ___ shout in the library.','mustn\'t',['must','is']),('✅ You ___ be kind to your friends.','must',['mustn\'t','can\'t']),('⛔ You ___ play with matches.','mustn\'t',['must','are']),('✅ We ___ recycle our bottles.','must',['mustn\'t','is']),('⛔ We ___ waste water.','mustn\'t',['must','are'])]
run('cm1','en_consignes_obligation',mix(pairs_cands(must),fill(mustf)))
should=[('tu devrais dormir','You should sleep'),('tu devrais boire de l\'eau','You should drink water'),('tu devrais manger des fruits','You should eat fruit'),('tu devrais aller chez le médecin','You should see a doctor'),('tu ne devrais pas manger trop de bonbons','You shouldn\'t eat too many sweets'),('tu ne devrais pas regarder la télé trop tard','You shouldn\'t watch TV too late'),('tu peux t\'asseoir ici','You can sit here'),('tu ne peux pas entrer','You can\'t come in'),('tu dois porter un manteau','You must wear a coat'),('tu ne dois pas ouvrir la fenêtre','You mustn\'t open the window'),('tu ne devrais pas oublier ton parapluie','You shouldn\'t forget your umbrella'),('tu devrais faire du sport','You should do sport')]
shouldf=[('💡 Conseil : You look tired. You ___ go to bed.','should',['shouldn\'t','mustn\'t']),('💡 Conseil : It\'s cold. You ___ go out without a coat.','shouldn\'t',['should','must']),('⛔ You ___ use your phone in class.','mustn\'t',['must','should']),('✅ You ___ show your ticket on the bus.','must',['mustn\'t','shouldn\'t']),('✅ Permission : You ___ use my pencil if you want.','can',['can\'t','mustn\'t']),('💡 Conseil : You ___ eat vegetables every day.','should',['shouldn\'t','can\'t']),('💡 Conseil : You ___ eat sweets before dinner.','shouldn\'t',['should','must']),('⛔ Sorry, you ___ park here.','can\'t',['can','should']),('✅ Drivers ___ stop at a red light.','must',['mustn\'t','can\'t']),('💡 Conseil : You have a cold. You ___ stay at home.','should',['shouldn\'t','mustn\'t'])]
run('cm2','en_consignes_obligation',mix(pairs_cands(should),fill(shouldf)))

# =========================== GOÛTS
cp_g=[]
for x,e in [('chocolate','😋'),('pizza','😋'),('cake','😋'),('ice cream','😋'),('football','😋')]:
    cp_g.append((f'{e} I ___ {x}.','like',['don\'t like']))
for x,e in [('juice','😋'),('music','😋'),('swimming','😋')]:
    cp_g.append((f'{e} I ___ {x}.','like',['don\'t like']))
for x,e in [('soup','🤢'),('broccoli','🤢'),('spinach','🤢'),('rain','😖'),('onions','🤢'),('fish','🤢'),('snakes','😖')]:
    cp_g.append((f'{e} I ___ {x}.','don\'t like',['like']))
cp_gt=pairs_cands([('j\'aime','I like'),('je n\'aime pas','I don\'t like'),('j\'adore','I love'),('est-ce que tu aimes ?','do you like?'),('oui, j\'aime','yes, I do'),('non, je n\'aime pas','no, I don\'t'),('ma couleur préférée','my favourite colour'),('mon animal préféré','my favourite animal')])
cp_yn=[('Réponds "oui" à "Do you like cats?"','Yes, I do',['Yes, I am','Yes, I like','Yes, I have']),('Réponds "non" à "Do you like milk?"','No, I don\'t',['No, I am not','No, I like','No, I haven\'t']),('Réponds "oui" à "Do you like pizza?"','Yes, I do',['Yes, I like','Yes, I can','Yes, I am']),('Réponds "non" à "Do you like spiders?"','No, I don\'t',['No, I like','No, I can\'t','No, I am'])]
run('cp','en_gouts',mix(fill(cp_g),cp_gt,cp_yn))
ce1_g=pairs_cands([('j\'adore','I love'),('je déteste','I hate'),('j\'aime','I like'),('je n\'aime pas','I don\'t like'),('est-ce que tu aimes ?','do you like?'),('oui, j\'aime ça','yes, I do'),('non, je n\'aime pas ça','no, I don\'t'),('mon sport préféré','my favourite sport'),('ma nourriture préférée','my favourite food'),('ma couleur préférée','my favourite colour'),('mon animal préféré','my favourite animal'),('ma matière préférée','my favourite subject')])
ce1_f=fill([('😍 I ___ chocolate.','love',['hate','don\'t']),('😖 I ___ spiders.','hate',['love','like']),('🙂 I ___ apples.','like',['don\'t like','hate']),('🙁 I ___ like carrots.','don\'t',['do','am']),('Do you like dogs? Yes, I ___ .','do',['am','like']),('Do you like rain? No, I ___ .','don\'t',['am not','doesn\'t']),('___ you like football?','Do',['Are','Does']),('😍 I ___ ice cream.','love',['hate','am']),('😖 I ___ homework.','hate',['love','am'])])
run('ce1','en_gouts',mix(ce1_g,ce1_f,cp_yn))
ce2_f=fill([('He ___ football.','likes',['like','liking']),('She ___ chocolate.','loves',['love','loving']),('My brother ___ like fish.','doesn\'t',['don\'t','isn\'t']),('___ she like cats?','Does',['Do','Is']),('Does he like pizza? Yes, he ___ .','does',['do','is']),('Does she like snakes? No, she ___ .','doesn\'t',['don\'t','isn\'t']),('I ___ like spiders.','don\'t',['doesn\'t','am not']),('They ___ dancing.','love',['loves','is']),('Tom ___ swimming.','likes',['like','are']),('We ___ like rain.','don\'t',['doesn\'t','aren\'t']),('My mum ___ reading.','loves',['love','is']),('___ you like music?','Do',['Does','Are']),('My sister ___ like spiders.','doesn\'t',['don\'t','isn\'t'])])
run('ce2','en_gouts',ce2_f)
cm1_f=fill([('She ___ playing tennis.','likes',['like','is']),('He ___ like skiing.','doesn\'t',['don\'t','isn\'t']),('___ your sister like judo?','Does',['Do','Is']),('My favourite sport ___ swimming.','is',['are','has']),('I prefer football ___ tennis.','to',['than','at']),('My friends ___ climbing.','love',['loves','is']),('Does he like fishing? No, he ___ .','doesn\'t',['don\'t','isn\'t']),('What ___ your favourite hobby?','is',['are','do']),('I\'m good ___ drawing.','at',['in','to']),('We ___ like horse riding.','don\'t',['doesn\'t','aren\'t'])])
cm1_g=pairs_cands([('je préfère','I prefer'),('mon passe-temps préféré','my favourite hobby'),('je suis doué pour','I\'m good at'),('je suis nul en','I\'m bad at'),('elle adore','she loves'),('il déteste','he hates'),('elle aime','she likes'),('il n\'aime pas','he doesn\'t like')])
run('cm1','en_gouts',mix(cm1_f,cm1_g))

# =========================== QUESTIONS / LIEUX
ce1_q=pairs_cands([('où est le chat ?','Where is the cat?'),('qu\'est-ce que c\'est ?','What is it?'),('qui est-ce ?','Who is it?'),('comment vas-tu ?','How are you?'),('de quelle couleur est-ce ?','What colour is it?'),('combien ?','How many?'),('quel âge as-tu ?','How old are you?'),('où habites-tu ?','Where do you live?'),('pourquoi es-tu triste ?','Why are you sad?'),('quand est ton anniversaire ?','When is your birthday?')])
run('ce1','en_questions_lieux',ce1_q)
cm1_qf=fill([('___ is my book? It\'s on the table.','Where',['What','Who']),('___ is your name? My name is Sam.','What',['Where','How']),('___ old are you? I\'m ten.','How',['What','Who']),('___ is your birthday? It\'s in May.','When',['Where','Who']),('___ is that boy? He\'s my brother.','Who',['What','Where']),('___ are you sad? Because I lost my cat.','Why',['When','How']),('___ do you live? I live in Lyon.','Where',['When','What']),('___ many pencils have you got? Five.','How',['What','Who']),('___ colour is your bag? It\'s blue.','What',['Where','How']),('___ is the bakery? It\'s next to the bank.','Where',['Who','When']),('___ do you go to school? At eight o\'clock.','When',['Who','Where']),('___ is your teacher? Mrs Brown.','Who',['Where','How'])])
cm1_ql=pairs_cands([('où est la boulangerie ?','Where is the bakery?'),('c\'est à côté de la banque','It\'s next to the bank'),('c\'est en face de l\'école','It\'s opposite the school'),('tourne à gauche','Turn left'),('tourne à droite','Turn right'),('va tout droit','Go straight on'),('j\'habite à Paris','I live in Paris'),('où habites-tu ?','Where do you live?'),('je suis dans le grenier','I am in the attic'),('je suis dans l\'escalier','I am on the stairs'),('c\'est loin','It\'s far'),('c\'est près d\'ici','It\'s near here')])
run('cm1','en_questions_lieux',mix(cm1_qf,cm1_ql))

# =========================== POLITESSE / CONSIGNES
run('cp','en_politesse_consignes',pairs_cands([('bonjour (le matin)','good morning'),('bonne nuit','good night'),('bon après-midi','good afternoon'),('merci','thank you'),('à bientôt','see you soon'),('salut','hi'),('ça va ?','How are you?'),('je vais bien','I\'m fine')]))
pol=[('ouvre ton livre','Open your book'),('ferme ton livre','Close your book'),('regarde le tableau','Look at the board'),('lève la main','Raise your hand'),('répète, s\'il te plaît','Repeat, please'),('écoute bien','Listen carefully'),('mettez-vous en rang','Line up'),('travaillez par deux','Work in pairs'),('sors ton crayon','Take out your pencil'),('range tes affaires','Put away your things'),('puis-je aller aux toilettes ?','Can I go to the toilet?'),('puis-je entrer ?','May I come in?'),('excuse-moi','Excuse me'),('merci beaucoup','Thank you very much'),('non, merci','No, thank you'),('bonne journée','Have a nice day'),('à demain','See you tomorrow'),('je ne comprends pas','I don\'t understand'),('peux-tu m\'aider ?','Can you help me?'),('bonsoir','Good evening'),('bienvenue','Welcome')]
run('cm1','en_politesse_consignes',pairs_cands(pol))

# =========================== SE PRÉSENTER (CP)
ages=[]
for n in [10,11,12]:
    fr=['','un','deux','trois','quatre','cinq','six','sept','huit','neuf','dix','onze','douze'][n]
    ages.append((f'j\'ai {fr} ans',f'I\'m {num_en(n)} years old'))
sp=pairs_cands(ages+[('je vais bien, merci','I\'m fine, thank you'),('enchanté','Nice to meet you'),('bonjour, je suis Léa','Hello, I\'m Léa'),('et toi ?','And you?'),('au revoir','goodbye'),('voici mon ami','This is my friend'),('je suis français','I\'m French'),('j\'habite en France','I live in France')])
spf=fill([('My ___ is Tom.','name',['age','old']),('I\'m seven years ___ .','old',['name','is']),('How ___ you?','are',['is','am']),('What\'s ___ name?','your',['you','my']),('How ___ are you? I\'m six.','old',['name','are']),('I ___ a girl.','am',['is','are']),('Hello! I ___ Max.','am',['is','have']),('I\'m ___ boy.','a',['an','the']),('Nice to ___ you.','meet',['see','name']),('What ___ your name?','is',['are','am']),('I ___ in France.','live',['am','have'])])
run('cp','en_se_presenter',mix(sp,spf))

# =========================== CONTRAIRES / SYNONYMES
ANT=[('early','late'),('rich','poor'),('wet','dry'),('soft','hard'),('loud','quiet'),('cheap','expensive'),('beautiful','ugly'),('high','low'),('thick','thin'),('near','far'),('first','last'),('inside','outside'),('up','down'),('left','right'),('push','pull'),('always','never'),('buy','sell'),('win','lose'),('remember','forget'),('give','take'),('light','dark'),('long','short'),('true','false'),('right','wrong'),('start','finish'),('love','hate'),('come','go'),('laugh','cry'),('good','bad'),('heavy','light')]
def ant_cands(pairs,lab='le contraire'):
    out=[]; allw=sorted({w for p in pairs for w in p})
    for a,b in pairs:
        for x,y in ((a,b),(b,a)):
            bad={y,x}|{q for p in pairs for q in p if x in p}
            w=R.sample([z for z in allw if z not in bad],3)
            out.append((f'Quel est {lab} de "{x}" en anglais ?',y,w))
    R.shuffle(out); return out
run('cm1','en_contraires_synonymes',ant_cands(ANT[:22]))
SYN=[('begin','start'),('finish','end'),('shut','close'),('clever','smart'),('scared','afraid'),('ill','sick'),('pretty','beautiful'),('simple','easy'),('silent','quiet'),('huge','enormous'),('shout','yell'),('rubbish','trash'),('present','gift')]
run('cm2','en_contraires_synonymes',mix(ant_cands(SYN,'un synonyme'),ant_cands(ANT[10:])))

# =========================== DÉMONSTRATIFS (CM1)
dem=[]
for fs,fp,es,ep,fem in [('stylo','stylos','pen','pens',False),('ballon','ballons','ball','balls',False),('maison','maisons','house','houses',True),('voiture','voitures','car','cars',True),('sac','sacs','bag','bags',False),('pomme','pommes','apple','apples',True),('chaussure','chaussures','shoe','shoes',True),('chien','chiens','dog','dogs',False)]:
    ce='cette' if fem else 'ce'
    forms=[(f'{ce} {fs}-ci',f'this {es}'),(f'{ce} {fs}-là',f'that {es}'),(f'ces {fp}-ci',f'these {ep}'),(f'ces {fp}-là',f'those {ep}')]
    for fr,en in forms:
        w=[e for f,e in forms if e!=en]
        dem.append((f'Comment dit-on "{fr}" en anglais ?',en,w))
R.shuffle(dem)
demf=fill([('Un seul gâteau, tout près : ___ cake is delicious.','This',['These','Those']),('Plusieurs oiseaux, loin : Look at ___ birds in the sky!','those',['this','these']),('Plusieurs chaussures, tout près : ___ shoes are too small.','These',['This','That']),('Une seule maison, loin : ___ house is very big.','That',['Those','These']),('Plusieurs pommes, tout près : ___ apples are green.','These',['This','That']),('Un seul bateau, loin : Can you see ___ boat?','that',['those','these'])])
run('cm1','en_demonstratifs',mix(dem,demf))

# =========================== FUTUR (CM2)
fut=[('je vais acheter un gâteau','I\'m going to buy a cake'),('je vais visiter Londres','I\'m going to visit London'),('il va pleuvoir','It\'s going to rain'),('nous allons jouer au football','We\'re going to play football'),('elle va apprendre l\'espagnol','She\'s going to learn Spanish'),('ils vont regarder un film','They\'re going to watch a film'),('demain','tomorrow'),('la semaine prochaine','next week'),('l\'année prochaine','next year'),('ce week-end','this weekend'),('je vais être pilote','I\'m going to be a pilot'),('il va faire du vélo','He\'s going to ride a bike')]
futf=fill([('I\'m going ___ swim.','to',['at','for']),('She ___ going to dance.','is',['are','am']),('They ___ going to travel.','are',['is','am']),('We are going to ___ a cake.','make',['making','makes']),('He is going ___ visit his grandma.','to',['for','at']),('I ___ going to read a book.','am',['is','are']),('Look at the clouds! It ___ going to rain.','is',['are','am']),('You are going to ___ the match.','win',['winning','wins']),('My parents ___ going to buy a car.','are',['is','am']),('Next year, I am going to ___ English.','learn',['learning','learns'])])
run('cm2','en_futur',mix(pairs_cands([p for p in fut if p[1][0].isupper()]),futf,pairs_cands([p for p in fut if not p[1][0].isupper()])))

# =========================== PRÉSENT CONTINU (CM2)
ING=[('swim','swimming',['swiming','swimmming']),('run','running',['runing','runeing']),('sit','sitting',['siting','sitteing']),('write','writing',['writeing','writting']),('dance','dancing',['danceing','dancting']),('make','making',['makeing','makking']),('ride','riding',['rideing','ridding']),('take','taking',['takeing','takking']),('come','coming',['comeing','comming']),('get','getting',['geting','getteing']),('stop','stopping',['stoping','stopeing']),('cut','cutting',['cuting','cuteing']),('play','playing',['plaing','playying']),('read','reading',['readding','readeing']),('lie','lying',['lieing','liing']),('shop','shopping',['shoping','shopeing'])]
ingq=[(f'Quelle est la forme en -ing du verbe "{v}" ?',g,w+[v+'s']) for v,g,w in ING]
R.shuffle(ingq)
pcf=fill([('She ___ reading a book.','is',['are','am']),('They ___ playing in the garden.','are',['is','am']),('I ___ eating an apple.','am',['is','are']),('Look! The dog ___ running.','is',['are','am']),('We are ___ TV.','watching',['watch','watches']),('He is ___ a letter.','writing',['write','writes']),('My parents ___ cooking dinner.','are',['is','am']),('Listen! The baby ___ crying.','is',['are','am'])])
pct=pairs_cands([('que fais-tu ?','What are you doing?'),('il est en train de pleuvoir','It\'s raining'),('elle est en train de cuisiner','She\'s cooking'),('nous sommes en train de marcher','We\'re walking'),('ils sont en train de rire','They\'re laughing'),('il est en train de neiger','It\'s snowing')])
run('cm2','en_present_continu',mix(ingq,pcf,pct))

# =========================== HABITUDES (CM2)
run('cm2','en_habitudes',fill([('Avec le sens de « jamais » : I ___ eat sweets at night.','never',['always','often'])]))

# =========================== COMPLÉMENTS VOCAB CP
colq=[]
for em,c in [('🍌','yellow'),('🍓','red'),('🐸','green'),('🥕','orange'),('🐘','grey'),('🍇','purple'),('🐷','pink'),('🍫','brown'),('❄️','white'),('🌽','yellow'),('🍅','red'),('🥦','green'),('🐻','brown'),('🍆','purple'),('💙','blue'),('🖤','black')]:
    colq.append((f'En anglais, de quelle couleur est {em} ?',c,R.sample([x for x in ['red','blue','green','yellow','orange','purple','brown','black','white','grey','pink'] if x!=c],3)))
mixq=[('blue','yellow','green'),('red','yellow','orange'),('red','blue','purple'),('red','white','pink'),('black','white','grey')]
colm=[(f'Quelle couleur obtient-on en mélangeant "{a}" et "{b}" ?',c,R.sample([x for x in ['red','blue','green','yellow','orange','purple','brown','black','white','grey','pink'] if x not in (a,b,c)],3)) for a,b,c in mixq]
run('cp','en_couleurs',mix(colq,colm))

run('cp','en_emotions',pairs_cands([('j\'ai froid','I\'m cold'),('j\'ai chaud','I\'m hot'),('je suis malade','I\'m ill'),('je suis surpris','I\'m surprised'),('je vais bien','I\'m fine'),('je suis content','I\'m happy'),('je suis fatigué','I\'m tired')]))
