from common import *
R=random.Random(7)
def fill(cl,mat,code,items):
    n=need(cl,mat,code)
    for it in items:
        if n<=0: break
        if add(cl,mat,code,*it): n-=1
    return n

# --- CP formes géométriques
F=[("Combien de côtés a un hexagone ?","6",["5","4","8"]),
("Combien de coins a un losange ?","4",["3","5","0"]),
("Combien de coins a un pentagone ?","5",["4","6","3"]),
("Combien de coins a un hexagone ?","6",["5","4","8"]),
("Quelle forme a 6 côtés ?","hexagone",["pentagone","carré","triangle"]),
("Quelle forme a 3 coins ?","triangle",["carré","cercle","rectangle"]),
("Quelle forme a 5 coins ?","pentagone",["hexagone","carré","triangle"]),
("Quelle forme n'a aucun coin ?","cercle",["carré","triangle","rectangle"]),
("Quelle forme a 4 côtés : 2 longs et 2 courts ?","rectangle",["carré","triangle","cercle"]),
("Quelle forme a une assiette ?","cercle",["carré","triangle","rectangle"]),
("Quelle forme a un ballon vu de face ?","cercle",["carré","triangle","losange"]),
("Quelle forme a une porte ?","rectangle",["cercle","triangle","losange"]),
("Quelle forme a un billet de banque ?","rectangle",["cercle","triangle","pentagone"]),
("Quelle forme a le panneau « attention » sur la route ?","triangle",["carré","cercle","rectangle"]),
("Quelle forme a le toit d'une maison dessinée ?","triangle",["cercle","carré","losange"]),
("Quelle forme a une case d'un jeu de dames ?","carré",["triangle","cercle","pentagone"]),
("Quelle forme a souvent un cerf-volant ?","losange",["cercle","rectangle","hexagone"]),
("Combien de côtés ont 2 carrés en tout ?","8",["4","6","10"]),
("Combien de côtés ont 3 triangles en tout ?","9",["6","3","12"]),
("Combien de côtés ont un carré et un triangle en tout ?","7",["6","8","5"]),
("Combien de coins ont 2 triangles en tout ?","6",["3","4","5"]),
("Combien de coins ont 2 carrés en tout ?","8",["4","6","10"]),
("Quelle forme a le plus de côtés ?","hexagone",["triangle","carré","pentagone"]),
("Quelle forme a le moins de côtés ?","triangle",["carré","pentagone","hexagone"]),
("Combien de côtés a la moitié d'un carré coupé d'un coin à l'autre ?","3",["4","2","5"]),
("Quelle forme a une pizza entière ?","cercle",["carré","triangle","rectangle"]),
("Quelle forme a l'écran d'une télévision ?","rectangle",["cercle","triangle","losange"]),
("Combien de côtés a un carré de plus qu'un triangle ?","1",["2","0","3"]),
("Combien de côtés ont un rectangle et un pentagone en tout ?","9",["8","10","7"]),
("Combien de coins a un rond ?","0",["1","4","3"]),
]
fill('cp','math','formes_geometriques',F)

# --- CE2 logique comparer
n=need('ce2','logique','comparer_nombres')
while n>0:
    xs=R.sample(range(10,1000),4)
    if R.random()<0.5:
        base=R.randint(1,9)*100; xs=[base+R.randint(0,99) for _ in range(3)]+[R.randint(10,999)]
        if len(set(xs))<4: continue
    R.shuffle(xs); mot=R.choice(['petit','grand'])
    g=min(xs) if mot=='petit' else max(xs)
    if add('ce2','logique','comparer_nombres',f"Parmi {', '.join(map(str,xs))} : quel est le plus {mot} nombre ?",str(g),[str(x) for x in xs if x!=g]): n-=1

# --- CE2 intrus
I=[("Lequel de ces animaux ne vit pas à la ferme ? 🐄 🐖 🐑 🦁","🦁",["🐄","🐖","🐑"]),
("Lequel de ces objets n'est pas un instrument de musique ? 🎸 🎺 🥁 📚","📚",["🎸","🎺","🥁"]),
("Lequel de ces animaux n'est pas un insecte ? 🐝 🐞 🦋 🐟","🐟",["🐝","🐞","🦋"]),
("Lequel de ces animaux n'est pas un oiseau ? 🦆 🦉 🐦 🐸","🐸",["🦆","🦉","🐦"]),
("Lequel de ces objets n'est pas un vêtement ? 🧢 👗 🧥 ⚽","⚽",["🧢","👗","🧥"]),
("Lequel de ces animaux ne vit pas dans l'eau ? 🐟 🐬 🐙 🐘","🐘",["🐟","🐬","🐙"]),
("Lequel de ces objets ne sert pas à écrire ou dessiner ? ✏️ 🖍️ 🖊️ 🍴","🍴",["✏️","🖍️","🖊️"]),
("Lequel de ces aliments n'est pas un fruit ? 🍓 🍌 🍇 🧀","🧀",["🍓","🍌","🍇"]),
("Lequel de ces aliments n'est pas un légume ? 🥕 🥦 🥬 🍩","🍩",["🥕","🥦","🥬"]),
("Lequel de ces objets n'est pas un moyen de transport ? 🚗 🚌 🚲 🏠","🏠",["🚗","🚌","🚲"]),
("Lequel de ces animaux n'est pas un insecte ? 🐜 🐝 🦋 🐌","🐌",["🐜","🐝","🦋"]),
]
fill('ce2','logique','intrus',I)

# --- CE2 repérage
POS={(0,0):"en haut à gauche",(0,1):"en haut au centre",(0,2):"en haut à droite",(1,0):"au milieu à gauche",(1,1):"au centre",(1,2):"au milieu à droite",(2,0):"en bas à gauche",(2,1):"en bas au centre",(2,2):"en bas à droite"}
D={"vers le haut":(-1,0),"vers le bas":(1,0),"vers la gauche":(0,-1),"vers la droite":(0,1)}
items=[]
def ok(p): return 0<=p[0]<=2 and 0<=p[1]<=2
for p in POS:
    for d1,v1 in D.items():
        for s1 in (1,2):
            q=(p[0]+v1[0]*s1,p[1]+v1[1]*s1)
            if ok(q): items.append((p,[(d1,s1)],q))
            for d2,v2 in D.items():
                if v2[0]*v1[0]!=0 or v2[1]*v1[1]!=0 or v1==v2: continue
                if (v1[0]==0)==(v2[0]==0): continue
                r=(q[0]+v2[0],q[1]+v2[1])
                if ok(q) and ok(r) and s1==1: items.append((p,[(d1,1),(d2,1)],r))
R.shuffle(items)
items.sort(key=lambda t:len(t[1]))   # d'abord les déplacements simples restants
n=need('ce2','logique','reperage_espace')
for p,mv,q in items:
    if n<=0: break
    if len(mv)==1:
        d,s=mv[0]; e=f"Dans une grille de 3 cases sur 3, un objet est {POS[p]}. On le déplace de {s} case{'s' if s>1 else ''} {d}. Où est-il maintenant ?"
    else:
        e=f"Dans une grille de 3 cases sur 3, un objet est {POS[p]}. On le déplace de 1 case {mv[0][0]}, puis de 1 case {mv[1][0]}. Où est-il maintenant ?"
    others=[POS[x] for x in POS if x!=q]
    near=[POS[x] for x in POS if x!=q and abs(x[0]-q[0])+abs(x[1]-q[1])==1]
    ch=R.sample(near,min(2,len(near)))
    ch+=R.sample([o for o in others if o not in ch],3-len(ch))
    if add('ce2','logique','reperage_espace',e,POS[q],ch): n-=1

# --- CM1 analogies (partie / tout)
A=[("La marche est à l'escalier","le barreau","à l'échelle"),("La brique est au mur","la tuile","au toit"),
("La lettre est au mot","le mot","à la phrase"),("Le joueur est à l'équipe","le soldat","à l'armée"),
("Le mouton est au troupeau","l'arbre","à la forêt"),("La goutte est à la pluie","le flocon","à la neige"),
("Le chapitre est au livre","l'épisode","à la série"),("La touche est au clavier","la corde","à la guitare"),
("La pièce est au puzzle","la case","au damier"),("L'élève est à la classe","le musicien","à l'orchestre"),
("La maison est au village","l'étoile","à la constellation")]
WH=["à l'échelle","au toit","à la phrase","à l'armée","à la forêt","à la neige","à la série","à la guitare","au damier","à l'orchestre","à la constellation","au train","à la fleur","au bateau"]
n=need('cm1','logique','analogies')
for a,b,ans in A:
    if n<=0: break
    ch=R.sample([w for w in WH if w!=ans],3)
    if add('cm1','logique','analogies',f"{a} ce que {b} est…",ans,ch): n-=1

# --- CM2 analogies
B=[("Les ciseaux sont au coiffeur ce que le scalpel est…","au chirurgien",["au cuisinier","à l'hôpital","au facteur"]),
("La scie est au menuisier ce que l'aiguille est…","à la couturière",["au fil","au médecin","au maçon"]),
("La jument est au poulain ce que la truie est…","au porcelet",["à la porcherie","au veau","au chevreau"]),
("La chèvre est au chevreau ce que la vache est…","au veau",["à l'étable","au lait","au poulain"]),
("La fourmi est à la fourmilière ce que le renard est…","au terrier",["à la ruche","au nid","à l'étable"]),
("Le lait est au beurre ce que le raisin est…","au vin",["à la vigne","au pain","au chocolat"]),
("Le coton est au tee-shirt ce que le papier est…","au cahier",["à l'arbre","à la robe","au verre"]),
("Le cinéma est au film ce que la salle de concert est…","à la musique",["au théâtre","au livre","au tableau"]),
("L'ourse est à l'ourson ce que la louve est…","au louveteau",["à la tanière","au chiot","au faon"]),
("Le tableau est au musée ce que le livre est…","à la bibliothèque",["à l'écrivain","au papier","à la piscine"]),
("La plume est à l'oiseau ce que l'écaille est…","au poisson",["à l'eau","au chat","au chien"]),
]
fill('cm2','logique','analogies',B)

# --- CM1 contraires
C=[("fragile","solide"),("solide","fragile"),("obéissant","désobéissant"),("calme","agité"),("agité","calme"),("large","étroit"),("étroit","large"),
("lisse","rugueux"),("rugueux","lisse"),("humide","sec"),("maladroit","adroit"),("heureux","malheureux"),("permanent","temporaire"),("lourd","léger")]
POOL=[c[0] for c in C]+["précis","complet","utile","ancien","patient"]
n=need('cm1','logique','vocabulaire_sens')
for w,a in C:
    if n<=0: break
    ch=R.sample([p for p in POOL if p not in (w,a)],3)
    if add('cm1','logique','vocabulaire_sens',f"Quel est le contraire de « {w} » ?",a,ch): n-=1

# --- CP classer
K=[("Quel est l'animal le plus grand ? 🦒 🐱 🐰 🐔","🦒",["🐱","🐰","🐔"]),
("Quel est l'animal le plus petit ? 🦒 🐘 🐄 🐜","🐜",["🦒","🐘","🐄"]),
("Quel est l'animal le plus grand ? 🐳 🐟 🐸 🦀","🐳",["🐟","🐸","🦀"]),
("Quel est le fruit le plus gros ? 🍉 🍓 🍒 🍋","🍉",["🍓","🍒","🍋"]),
("Quel est le fruit le plus petit ? 🍉 🍍 🍎 🍒","🍒",["🍉","🍍","🍎"]),
("Quel est l'animal le plus petit ? 🐄 🐖 🐭 🐴","🐭",["🐄","🐖","🐴"]),
("Quel est l'animal le plus grand ? 🐘 🐶 🐔 🐭","🐘",["🐶","🐔","🐭"]),
("Quel est l'animal le plus petit ? 🐘 🦒 🐻 🐞","🐞",["🐘","🦒","🐻"]),
("Quel est l'animal le plus grand ? 🐌 🐞 🐜 🐄","🐄",["🐌","🐞","🐜"]),
("Quel est l'animal le plus petit ? 🐳 🐬 🦈 🦐","🦐",["🐳","🐬","🦈"]),
]
fill('cp','logique','classer',K)

# --- CM1 conjugaison présent
V={'apprendre':(['apprends','apprends','apprend','apprend','apprenons','apprenez','apprennent','apprennent'],'apprenais apprenais apprenait apprenait apprenions appreniez apprenaient apprenaient','apprendrai apprendras apprendra apprendra apprendrons apprendrez apprendront apprendront','apprend apprend apprends apprends apprenont apprené apprenent apprenent'),
'comprendre':(['comprends','comprends','comprend','comprend','comprenons','comprenez','comprennent','comprennent'],'comprenais comprenais comprenait comprenait comprenions compreniez comprenaient comprenaient','comprendrai comprendras comprendra comprendra comprendrons comprendrez comprendront comprendront','comprend comprend comprends comprends comprenont comprené comprenent comprenent'),
'devoir':(['dois','dois','doit','doit','devons','devez','doivent','doivent'],'devais devais devait devait devions deviez devaient devaient','devrai devras devra devra devrons devrez devront devront','doit doit dois dois devont devé doive doive'),
'revoir':(['revois','revois','revoit','revoit','revoyons','revoyez','revoient','revoient'],'revoyais revoyais revoyait revoyait revoyions revoyiez revoyaient revoyaient','reverrai reverras reverra reverra reverrons reverrez reverront reverront','revoit revoit revois revois revoyont revoyé revoie revoie')}
P=['je','tu','il','elle','nous','vous','ils','elles']
items=[]
for v,(pr,imp,fut,f) in V.items():
    imp=imp.split();fut=fut.split();f=f.split()
    for i,p in enumerate(P):
        def j(x): return (("j'" if x[0] in 'aeiou' else 'je ')+x) if p=='je' else p+' '+x
        items.append((f'Comment conjugue-t-on le verbe "{v}" avec "{p}" au présent ?',j(pr[i]),[j(imp[i]),j(fut[i]),j(f[i])]))
R.shuffle(items)
fill('cm1','conjugaison','present',items)

# --- CP masculin/féminin
M=[('Quel est le féminin de "roi" ?','reine',['roie','reinne','roine']),('Quel est le masculin de "reine" ?','roi',['rei','roie','reinet']),
('Comment s\'appelle la femelle du chameau ?','chamelle',['chameau','chamelle'.replace('lle','le'),'chamote']),('Quel est le masculin de "chamelle" ?','chameau',['chamelle','chamo','chamel']),
('Quel est le féminin de "maître" ?','maîtresse',['maître','maîtrice','maîtrese'])]
fill('cp','french','masculin_feminin',M)
