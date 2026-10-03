# Fiches de cours Anglais CP -> CM2 (2026-10-03) : une fiche par couple notion + classe (85 fiches).
# Le vocabulaire de chaque fiche est extrait des questions de la classe (paires francais / anglais),
# les explications sont ecrites a la main par notion (avec variantes par classe).
# Usage : python3 gen_anglais.py <questions.tsv> <dossier sql> [dossier txt]
import collections
import os
import re
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt
from noyau import noyau
from vocab_ordre import range_vocab

r_ = lambda x: f'[b][color=#C62828]{x}[/color][/b]'
en = lambda x: f'[b]{x}[/b]'
CLASSES = ['cp', 'ce1', 'ce2', 'cm1', 'cm2']

# ------------------------------------------------------------------ paires extraites des questions
rows = [l.rstrip('\n').split('\t') for l in open(sys.argv[1], encoding='utf-8')]
PAIRES = collections.defaultdict(list)
AUTRES = collections.defaultdict(list)
for _id, cl, code, e, b, d in rows:
    e = re.sub(r'\bce (chaise|table|porte|fenêtre)-', r'cette \1-', e)
    b = re.sub(r'\bce (chaise|table|porte|fenêtre)-', r'cette \1-', b)
    m1 = re.match(r'Comment dit-on "(.+)" en anglais \?$', e)
    m2 = re.match(r'Que veut dire "(.+)" en français \?$', e)
    if m1:
        p = (m1.group(1), b)
    elif m2:
        p = (b, m2.group(1))
    else:
        AUTRES[(cl, code)].append((e, b))
        continue
    n = noyau(p[0], p[1])
    if n:
        p = (n[1], n[2])        # phrase-cadre : on ne garde que le mot essentiel
    if p not in PAIRES[(cl, code)] and (p[0].lower(), p[1].lower()) not in [(a.lower(), c.lower()) for a, c in PAIRES[(cl, code)]]:
        PAIRES[(cl, code)].append(p)


def echantillon(L, n):
    if len(L) <= n:
        return L
    pas = len(L) / n
    return [L[int(i * pas)] for i in range(n)]


CAP_MOTS = 36       # au-dela, on echantillonne dans les plus gros groupes
BUDGET = 11        # lignes de tableau par page (sous-titre et ligne d en-tete comptent pour une ligne)


def _court(L):
    return all(max(len(a), len(b)) <= 18 for a, b in L)


def _bloc(st, lot, court):
    s = f'[center][font_size=22][b][color=#classe]{st}[/color][/b][/font_size][/center]\n'
    if court:
        lot = lot + [(' ', ' ')] * (len(lot) % 2)
        cells = [x for a, b in lot for x in (a, en(b))]
        return s + tableau(4, cells, entete=['français', 'anglais', 'français', 'anglais'], size=18, paires=True)
    cells = [x for a, b in lot for x in (a, en(b))]
    return s + tableau(2, cells, entete=['français', 'anglais'], size=18, paires=True)


def pages_vocab(paires, titre='Les mots à connaître'):
    """Vocabulaire range par theme (vocab_ordre.py) : un sous-titre et un tableau par groupe."""
    if not paires:
        return []
    groupes = [[t, list(L)] for t, L in range_vocab(paires)]
    while sum(len(L) for _t, L in groupes) > CAP_MOTS:
        g = max(groupes, key=lambda x: len(x[1]))
        g[1] = echantillon(g[1], len(g[1]) - 1)
    # decoupe en blocs qui tiennent dans une page
    blocs = []
    for t, L in groupes:
        court = _court(L) and t != 'Des phrases modèles'
        par_ligne = 2 if court else 1
        place = (BUDGET - 2) * par_ligne
        morceaux = [L[k:k + place] for k in range(0, len(L), place)]
        if len(morceaux) > 1:          # morceaux equilibres
            taille = -(-len(L) // len(morceaux))
            taille += taille % 2 if court else 0
            morceaux = [L[k:k + taille] for k in range(0, len(L), taille)]
        for i, m in enumerate(morceaux):
            st = t + (' (suite)' if i else '')
            blocs.append((2 + -(-len(m) // par_ligne), _bloc(st, m, court)))
    pages, cour, used = [], [], 0
    for h, b in blocs:
        if cour and used + h > BUDGET:
            pages.append(cour)
            cour, used = [], 0
        cour.append(b)
        used += h
    if cour:
        pages.append(cour)
    out = []
    for k, p in enumerate(pages):
        suite = f' ({k + 1})' if len(pages) > 1 else ''
        out.append(f'[titre]{titre}{suite}[/titre]\n' + '\n'.join(p))
    return out


# ------------------------------------------------------------------ explications par notion
def regle(code, cl):
    """Liste de pages d'explication (avant le vocabulaire)."""
    R = {
        'en_couleurs': {
            'cp': ["""[titre]Les couleurs[/titre]
En anglais, la couleur se place [b]avant[/b] le nom.
[cadre]une balle [b]rouge[/b] → a [b]red[/b] ball
une voiture [b]bleue[/b] → a [b]blue[/b] car[/cadre]
[cadre=astuce]On dit d'abord la couleur, puis l'objet : a [b]red[/b] ball, c'est comme « une rouge balle ».[/cadre]"""],
            None: ["""[titre]Les couleurs[/titre]
En anglais, la couleur se place [b]avant[/b] le nom.
[cadre]une balle [b]rouge[/b] → a [b]red[/b] ball
une voiture [b]bleue[/b] → a [b]blue[/b] car[/cadre]
[cadre=astuce]La couleur ne change jamais : two [b]red[/b] balls (pas de s).[/cadre]"""]},
        'en_animaux': {
            'cp': [f"""[titre]Un, une : a[/titre]
[cadre]un chat = {en('a')} cat · une vache = {en('a')} cow
un cochon = {en('a')} pig · une souris = {en('a')} mouse[/cadre]
[cadre=astuce]En anglais, [b]a[/b] veut dire « un » et aussi « une ».[/cadre]"""],
            None: [f"""[titre]a ou an ?[/titre]
[cadre][b]a[/b] devant une consonne : a cat, a dog, a pig
[b]an[/b] devant une voyelle : an elephant, an owl[/cadre]
[cadre=astuce]Au pluriel, on ajoute [b]s[/b] : two cat{r_('s')}. Mais certains ne changent pas : two {en('fish')}, two {en('sheep')}.[/cadre]"""]},
        'en_corps': {
            'cp': [f"""[titre]Mon corps[/titre]
[cadre]my head = ma tête · my nose = mon nez
On dit [b]my[/b] pour « mon, ma, mes ».[/cadre]
[cadre=astuce]Chante en montrant chaque partie : head, shoulders, knees and toes ![/cadre]"""],
            None: [f"""[titre]Mon corps[/titre]
[cadre]my head = ma tête · my hands = mes mains
On dit [b]my[/b] pour « mon, ma, mes ».[/cadre]
[cadre=astuce]Pluriels spéciaux : a foot → two {en('feet')} ; a tooth → two {en('teeth')}.[/cadre]"""]},
        'en_ecole': ["""[titre]À l'école[/titre]
[cadre]a pen = un stylo · a pencil = un crayon · a ruler = une règle[/cadre]
[cadre=astuce]Les langues prennent une [b]majuscule[/b] en anglais : English, French.[/cadre]"""],
        'en_emotions': ["""[titre]Dire comment je me sens[/titre]
[cadre][b]I'm[/b] happy = je suis content(e).
[b]I'm[/b] est la forme courte de [b]I am[/b].[/cadre]
[cadre=astuce]En anglais, l'adjectif ne change pas pour une fille : I'm happy (garçon ou fille).[/cadre]"""],
        'en_maison_famille': ["""[titre]La maison et la famille[/titre]
[cadre]my mum = ma maman · my dad = mon papa · my brother = mon frère · my sister = ma sœur[/cadre]
[cadre=astuce]« the » = le, la, les : the kitchen = la cuisine, the garden = le jardin.[/cadre]"""],
        'en_meteo_nature': ["""[titre]Le temps qu'il fait[/titre]
[cadre]It's sunny = il fait beau · It's raining = il pleut · It's cold = il fait froid[/cadre]
[cadre=astuce]Pour parler du temps, on commence par [b]It's[/b] (it is).[/cadre]"""],
        'en_nourriture': ["""[titre]La nourriture[/titre]
[cadre]I like chocolate = j'aime le chocolat.
I'm hungry = j'ai faim · I'm thirsty = j'ai soif[/cadre]
[cadre=astuce]On dit « I'm hungry » (je suis affamé) et pas « I have hungry ».[/cadre]"""],
        'en_vetements': [f"""[titre]Les vêtements[/titre]
[cadre]I'm wearing a hat = je porte un chapeau.[/cadre]
[cadre=astuce]Certains vêtements sont toujours au pluriel : {en('trousers')} (un pantalon), {en('jeans')}, {en('shorts')}.[/cadre]"""],
        'en_ville_transports': [f"""[titre]Se déplacer[/titre]
[cadre]by bus = en bus · by car = en voiture · by train = en train
on foot = à pied[/cadre]
[cadre=astuce]Avec un moyen de transport, on dit {en('by')} : I go to school by bike.[/cadre]"""],
        'en_loisirs_metiers': [f"""[titre]Loisirs et métiers[/titre]
[cadre]Les activités finissent souvent par [b]-ing[/b] : swimm{r_('ing')}, danc{r_('ing')}, read{r_('ing')}.[/cadre]
[cadre=astuce]Pour un métier, on met {en('a')} ou {en('an')} : She is {en('a')} doctor. He is {en('an')} artist.[/cadre]"""],
        'en_pays': {
            'cm1': [f"""[titre]Pays et nationalités[/titre]
[cadre]I come from France = je viens de France.
He comes from Canada = il vient du Canada.
In Italy, they speak Italian = en Italie, on parle italien.[/cadre]
[cadre=astuce]Avec he / she, le verbe prend un [b]s[/b] : he come{r_('s')}. Les pays et les langues prennent une [b]majuscule[/b].[/cadre]"""],
            None: ["""[titre]Les nationalités[/titre]
[cadre]français = French · anglais = English · espagnol = Spanish[/cadre]
[cadre=astuce]En anglais, les nationalités prennent toujours une [b]majuscule[/b] : French, Chinese.[/cadre]"""]},
        'en_calendrier': {
            'ce2': [f"""[titre]Dire l'heure[/titre]
[cadre]il est trois heures → It's 3 {en("o'clock")}
il est huit heures → It's 8 {en("o'clock")}[/cadre]
[cadre=astuce]Les jours et les mois prennent une [b]majuscule[/b] : Monday, March.[/cadre]"""],
            'cm2': ["""[titre]Le temps qui passe[/titre]
[cadre]yesterday = hier · today = aujourd'hui · tomorrow = demain[/cadre]
[cadre]Les saisons : spring, summer, autumn, winter.[/cadre]"""],
            None: [f"""[titre]Jours et mois[/titre]
En anglais, les jours et les mois prennent une [b]majuscule[/b].
[cadre]lundi = {en('Monday')} · janvier = {en('January')}[/cadre]
[cadre=astuce]Les jours finissent tous par [b]-day[/b] : Mon{r_('day')}, Tues{r_('day')}, Sun{r_('day')}.[/cadre]"""]},
        'en_nombres': {
            'cp': ["""[titre]Compter jusqu'à 10[/titre]
[cadre]one, two, three, four, five, six, seven, eight, nine, ten[/cadre]
[cadre=astuce]zéro = zero.[/cadre]"""],
            'ce1': [f"""[titre]Les nombres jusqu'à 31[/titre]
[cadre]De 13 à 19 : [b]-teen[/b] → thir{r_('teen')}, four{r_('teen')}, fif{r_('teen')}.
Les dizaines : [b]-ty[/b] → twen{r_('ty')}, thir{r_('ty')}.
21 = twenty{r_('-')}one : un [b]tiret[/b] entre les deux.[/cadre]
[cadre=astuce]11 = eleven et 12 = twelve sont à apprendre par cœur.[/cadre]"""],
            'ce2': [f"""[titre]Les dizaines et les rangs[/titre]
[cadre]forty (40, sans u !) · fifty · sixty · seventy · eighty · ninety[/cadre]
[cadre]Pour dire le rang : first (1er), second (2e), third (3e), four{r_('th')} (4e)…[/cadre]"""],
            'cm1': [f"""[titre]Les nombres ordinaux[/titre]
[cadre]1er = first · 2e = second · 3e = third
Ensuite, on ajoute [b]-th[/b] : four{r_('th')}, six{r_('th')}, seven{r_('th')}.[/cadre]
[cadre=astuce]Pièges : five → fif{r_('th')}, nine → nin{r_('th')}, twelve → twelf{r_('th')}.[/cadre]"""]},
        'en_verbes': {
            'cp': ["""[titre]Bouger en anglais[/titre]
[cadre]Run! = Cours ! · Jump! = Saute ! · Dance! = Danse ![/cadre]
[cadre=astuce]Pour donner un ordre, on dit juste le verbe.[/cadre]"""],
            'cm2': [f"""[titre]L'infinitif anglais[/titre]
[cadre]En anglais, l'infinitif se forme avec {en('to')} + verbe :
lire = {en('to read')} · nager = {en('to swim')}[/cadre]
[cadre=astuce]En français, l'infinitif finit par -er, -ir, -re ; en anglais, c'est le petit mot « to » devant.[/cadre]"""],
            None: [f"""[titre]Les verbes[/titre]
[cadre]je lis = {en('I read')} · je nage = {en('I swim')}[/cadre]
[cadre=astuce]Avec I, le verbe ne change pas : I read, I swim, I sing.[/cadre]"""]},
        'en_adjectifs': [f"""[titre]Les adjectifs[/titre]
L'adjectif se place [b]avant[/b] le nom, et il ne change jamais.
[cadre]un grand chien → a {en('big')} dog
deux grands chiens → two {en('big')} dogs (pas de s à big)[/cadre]"""],
        'en_avoir_etre': {
            'cm1': [f"""[titre]I have et I am[/titre]
[cadre]j'ai une tante = I {en('have')} an aunt
je suis anglais(e) = I {en('am')} English[/cadre]
[cadre=astuce]La nationalité prend une majuscule : English, Spanish.[/cadre]"""],
            None: [f"""[titre]Être : I am[/titre]
{tableau(2, ['je suis', en("I am") + ' / ' + en("I'm"), 'tu es', en('you are'), 'il est', en('he is'), 'elle est', en('she is')], size=20, paires=True)}""",
                   f"""[titre]Avoir : I have[/titre]
[cadre]j'ai un chat = I {en('have')} a cat
j'ai un animal = I{en("'ve got")} a pet (I have got)[/cadre]
[cadre=astuce]Attention : j'ai faim = I'm hungry ; j'ai six ans = I'm six. En anglais, on utilise [b]be[/b] (être) !
Avec un animal : it's a pig = c'est un cochon.[/cadre]"""]},
        'en_gouts': {
            'cp': [f"""[titre]J'aime, je n'aime pas[/titre]
[cadre]j'aime = {en('I like')} · je n'aime pas = {en("I don't like")}
Ma couleur préférée est… = {en('My favourite colour is')}…[/cadre]
[cadre=astuce]I like black (pas de « le » en anglais devant la couleur).[/cadre]"""],
            'ce1': [f"""[titre]Ce que j'aime faire[/titre]
[cadre]j'aime la danse = I like danc{r_('ing')} · j'aime le vélo = I like cycl{r_('ing')}[/cadre]
[cadre=astuce]Pour une activité, on met le verbe en [b]-ing[/b] après like.[/cadre]"""],
            'ce2': [f"""[titre]Préférer, aimer[/titre]
[cadre]je préfère = {en('I prefer')} · elle aime = {en('she likes')}[/cadre]
[cadre=astuce]Avec he, she, it, le verbe prend un [b]s[/b] : she like{r_('s')}, he prefer{r_('s')}.[/cadre]"""],
            'cm1': [f"""[titre]Mon préféré, mon passe-temps[/titre]
[cadre]mon sport préféré est le ski = {en('My favourite sport is')} skiing
mon passe-temps est le chant = {en('My hobby is')} singing[/cadre]
[cadre=astuce]Les sports et les activités se terminent souvent par -ing.[/cadre]"""]},
        'en_decrire_position': {
            'ce2': [f"""[titre]Il y a…[/titre]
[cadre]il y a un serpent = {en('There is')} a snake (un seul)
il y a trois poissons = {en('There are')} 3 fish (plusieurs)[/cadre]
[cadre=astuce][b]There is[/b] + un seul ; [b]There are[/b] + plusieurs.[/cadre]""",
                    f"""[titre]Où ?[/titre]
{tableau(2, ['à gauche', en('on the left'), 'à droite', en('on the right'), 'en haut', en('at the top'), 'en bas', en('at the bottom'), 'au milieu', en('in the middle')], size=20, paires=True)}"""],
            'ce1': [f"""[titre]Je vois, où est-il ?[/titre]
[cadre]je vois deux oiseaux = {en('I see')} two birds
le chat est sur la table = The cat is {en('on')} the table[/cadre]
{tableau(4, ['sur', en('on'), 'sous', en('under'), 'dans', en('in'), 'à côté de', en('next to')], size=20, paires=True)}"""],
            None: [f"""[titre]Je vois[/titre]
[cadre]je vois une grenouille = {en('I see')} a frog
je vois un canard = {en('I see')} a duck[/cadre]
[cadre=astuce]{en('I see')} = je vois. Puis on dit l'animal avec [b]a[/b] : a cow, a pig.[/cadre]"""]},
        'en_politesse_consignes': {
            'cm1': [f"""[titre]Interdire poliment[/titre]
[cadre]ne cours pas = {en("Don't")} run · ne touche pas = {en("Don't")} touch[/cadre]
[cadre=astuce]Pour interdire : [b]Don't[/b] + verbe. Et toujours : please, thank you, sorry.[/cadre]"""],
            None: [f"""[titre]Être poli[/titre]
{tableau(4, ["s'il te plaît", en('please'), 'merci', en('thank you'), 'oui', en('yes'), 'non', en('no')], size=20, paires=True)}
[cadre=astuce]Une consigne commence par le verbe : {en('Touch')} your head = touche ta tête.[/cadre]"""]},
        'en_se_presenter': [f"""[titre]Me présenter[/titre]
[cadre]je m'appelle Léo = {en('My name is')} Léo
j'ai six ans = {en("I'm six years old")}
quel âge as-tu ? = {en('How old are you?')}[/cadre]
[cadre=astuce]Pour l'âge, on dit « I'm » (je suis) et pas « I have ».[/cadre]"""],
        'en_consignes_obligation': {
            'ce1': [f"""[titre]Je sais, je ne sais pas[/titre]
[cadre]je sais nager = {en('I can')} swim
je ne sais pas grimper = {en("I can't")} climb[/cadre]
[cadre=astuce]Après can, le verbe ne change pas : I can run, she can run.[/cadre]"""],
            'cm1': [f"""[titre]Tu dois, tu ne dois pas[/titre]
[cadre]tu dois écouter = {en('You must')} listen
tu ne dois pas courir = {en("You mustn't")} run[/cadre]"""],
            'cm2': [f"""[titre]Règles et conseils[/titre]
{tableau(2, ['tu dois', en('you must'), 'tu ne dois pas', en("you mustn't"), 'tu ne peux pas', en("you can't"), 'tu ne devrais pas', en("you shouldn't")], size=20, lignes=True)}
[cadre=astuce]« shouldn't » est un conseil, « mustn't » une interdiction.[/cadre]"""]},
        'en_questions_lieux': {
            'cm1': [f"""[titre]Les mots des questions[/titre]
{tableau(4, ['quoi', en('what'), 'où', en('where'), 'quand', en('when'), 'qui', en('who'), 'pourquoi', en('why'), 'comment', en('how')], size=20, paires=True)}
[cadre]je suis dans la cuisine = I am {en('in')} the kitchen[/cadre]"""],
            None: [f"""[titre]Questions et positions[/titre]
{tableau(4, ['quoi', en('what'), 'où', en('where'), 'quand', en('when'), 'qui', en('who')], size=20, paires=True)}
[cadre]sur = on · sous = under · dans = in
The ball is {en('under')} the box.[/cadre]"""]},
        'en_comparer': {
            'cm1': [f"""[titre]Plus… que[/titre]
[cadre]Adjectif court + [b]-er[/b] + [b]than[/b] :
un chien est plus rapide qu'une tortue = A dog is fast{r_('er')} {en('than')} a turtle.[/cadre]
[cadre=astuce]tall : pour une personne, un immeuble ; high : pour une montagne, un mur.[/cadre]""",
                    f"""[titre]Le plus[/titre]
[cadre][b]the[/b] + adjectif + [b]-est[/b] : the fast{r_('est')}, the tall{r_('est')}.[/cadre]
{tableau(3, ['big', 'big' + r_('ger'), 'the big' + r_('gest'), 'heavy', 'heav' + r_('ier'), 'the heav' + r_('iest'), 'hot', 'hot' + r_('ter'), 'the hot' + r_('test')], entete=['adjectif', 'plus', 'le plus'], size=19, lignes=True)}
[cadre]On double la consonne (big → bigger) ; y devient i (heavy → heavier).[/cadre]"""],
            'cm2': [f"""[titre]Comparer : plus, aussi, moins[/titre]
{tableau(2, ['plus grand que', 'bigg' + r_('er than'), 'aussi grand que', r_('as') + ' big ' + r_('as'), 'moins grand que', r_('less') + ' big ' + r_('than')], size=20, lignes=True)}""",
                    f"""[titre]Les adjectifs longs[/titre]
[cadre]Avec un adjectif long, on ne met pas -er : on dit [b]more[/b] et [b]the most[/b].
plus cher que = {en('more expensive than')}
le plus cher = {en('the most expensive')}[/cadre]
[cadre=astuce]big → bigger, heavy → heavier, mais expensive → more expensive.[/cadre]"""]},
        'en_demonstratifs': [f"""[titre]Ce, cette, ces[/titre]
{tableau(3, ['', 'ici (-ci)', 'là-bas (-là)', 'un seul', en('this') + ' book', en('that') + ' book', 'plusieurs', en('these') + ' books', en('those') + ' books'], size=20, lignes=True)}
[cadre=astuce]this / that : un seul. these / those : plusieurs.[/cadre]"""],
        'en_passe': [f"""[titre]Le passé : -ed[/titre]
Pour raconter ce qui s'est passé, on ajoute [b]-ed[/b] au verbe.
[cadre]j'ai joué = I play{r_('ed')} · j'ai regardé = I watch{r_('ed')}[/cadre]
[cadre=astuce]dance → danc{r_('ed')} (juste -d) · cry → cr{r_('ied')} (y → ied). La forme est la même pour toutes les personnes.[/cadre]""",
                     f"""[titre]Les verbes irréguliers (1)[/titre]
{tableau(4, ['voir', en('saw'), 'aller', en('went'), 'manger', en('ate'), 'boire', en('drank'), 'écrire', en('wrote'), 'faire', en('made / did'), 'prendre', en('took'), 'venir', en('came'), 'avoir', en('had'), 'donner', en('gave')], size=19, paires=True)}""",
                     f"""[titre]Les verbes irréguliers (2)[/titre]
{tableau(4, ['rencontrer', en('met'), 'acheter', en('bought'), 'trouver', en('found'), 'perdre', en('lost'), 'courir', en('ran'), 'nager', en('swam'), 'chanter', en('sang'), 'dormir', en('slept'), 'gagner', en('won'), 'tomber', en('fell'), 'oublier', en('forgot'), 'comprendre', en('understood')], size=18, paires=True)}"""],
        'en_habitudes': [f"""[titre]Souvent, jamais…[/titre]
{tableau(4, ['toujours', en('always'), "d'habitude", en('usually'), 'souvent', en('often'), 'parfois', en('sometimes'), 'jamais', en('never'), ' ', ' '], size=20, paires=True)}
[cadre]Ces mots se placent [b]entre[/b] I et le verbe : I {en('often')} watch TV.[/cadre]"""],
        'en_futur': [f"""[titre]Je vais…[/titre]
[cadre]je vais nager = {en("I'm going to")} swim
je vais lire = {en("I'm going to")} read[/cadre]
[cadre=astuce]I'm going to + verbe : c'est comme « je vais + verbe » en français.[/cadre]"""],
        'en_present_continu': [f"""[titre]Je suis en train de…[/titre]
[cadre]je suis en train de lire = {en("I'm")} read{r_('ing')}
je suis en train de manger = {en("I'm")} eat{r_('ing')}[/cadre]
[cadre=astuce]write → writ{r_('ing')} (le e disparaît) · swim → swimm{r_('ing')} (on double le m).[/cadre]"""],
        'en_contraires_synonymes': [],
    }
    v = R.get(code, [])
    if isinstance(v, dict):
        v = v.get(cl, v.get(None, []))
    return v


RET = {
    'en_couleurs': 'La couleur se place avant le nom : a red ball. Elle ne prend jamais de s.',
    'en_animaux': 'a devant une consonne, an devant une voyelle. Pluriel : + s (sauf fish, sheep).',
    'en_corps': 'my = mon, ma, mes. foot → feet, tooth → teeth.',
    'en_ecole': 'Les langues prennent une majuscule : English, French.',
    'en_emotions': "I'm = I am. L'adjectif ne change pas au féminin.",
    'en_maison_famille': 'my = mon, ma, mes ; the = le, la, les.',
    'en_meteo_nature': "Pour le temps qu'il fait : It's sunny, It's raining.",
    'en_nourriture': "I like… / I don't like… ; I'm hungry = j'ai faim.",
    'en_vetements': "I'm wearing… = je porte… ; trousers, jeans, shorts : toujours au pluriel.",
    'en_ville_transports': 'by bus, by car, by bike ; on foot = à pied.',
    'en_loisirs_metiers': 'Activités en -ing (swimming). Métier : a / an (She is a doctor).',
    'en_pays': 'Pays, langues et nationalités prennent une majuscule.',
    'en_calendrier': 'Jours et mois avec une majuscule ; l\'heure : It\'s 3 o\'clock.',
    'en_nombres': '13-19 : -teen ; dizaines : -ty ; rangs : first, second, third, puis -th.',
    'en_verbes': 'Avec I, le verbe ne change pas. Infinitif : to + verbe.',
    'en_adjectifs': "L'adjectif se place avant le nom et ne prend jamais de s.",
    'en_avoir_etre': "I am / I'm = je suis ; I have / I've got = j'ai. Mais j'ai faim = I'm hungry.",
    'en_gouts': "I like / I don't like / I prefer ; she likes (+ s) ; activités en -ing.",
    'en_decrire_position': 'I see… ; There is (un seul) / There are (plusieurs) ; on, under, in, next to.',
    'en_politesse_consignes': "please, thank you, sorry ; consigne = verbe en premier ; Don't + verbe pour interdire.",
    'en_se_presenter': "My name is… ; I'm six years old ; How old are you?",
    'en_consignes_obligation': "I can / I can't ; You must / You mustn't ; You shouldn't.",
    'en_questions_lieux': 'what, where, when, who, why, how ; in, on, under.',
    'en_comparer': 'fast → faster than → the fastest ; as… as ; less… than ; more expensive.',
    'en_demonstratifs': 'this / these : ici ; that / those : là-bas.',
    'en_contraires_synonymes': 'Contraire : big ≠ small. Synonyme : big = large.',
    'en_passe': 'Passé : verbe + -ed (I played) ; verbes irréguliers à apprendre (I saw, I went).',
    'en_habitudes': 'always, usually, often, sometimes, never : entre I et le verbe.',
    'en_futur': "I'm going to + verbe = je vais + verbe.",
    'en_present_continu': "I'm + verbe-ing = je suis en train de…",
}


RET_CL = {
    'en_couleurs': {'cp': 'La couleur se place avant le nom : a red ball.'},
    'en_animaux': {'cp': 'a = un, une : a cat, a cow.'},
    'en_corps': {'cp': 'my = mon, ma, mes : my head, my hands.'},
    'en_gouts': {'cp': "I like… / I don't like… ; My favourite colour is…", 'ce1': "I like / I don't like + activité en -ing : I like dancing.",
                 'ce2': "I prefer… ; avec he / she, le verbe prend un s : she likes.", 'cm1': "My favourite sport is… ; My hobby is… (activités en -ing)."},
    'en_comparer': {'cm1': 'fast → faster than → the fastest ; big → bigger ; heavy → heavier.',
                    'cm2': 'faster than, as fast as, less fast than ; more expensive, the most expensive.'},
    'en_consignes_obligation': {'ce1': "I can = je sais ; I can't = je ne sais pas.", 'cm1': "You must = tu dois ; You mustn't = tu ne dois pas.",
                                'cm2': "You must / mustn't ; You can't ; You shouldn't (conseil)."},
    'en_nombres': {'cp': 'one, two, three… ten ; zero = zéro.', 'ce1': '13-19 : -teen ; dizaines : -ty ; 21 = twenty-one.',
                   'ce2': 'forty, fifty, sixty… ; first, second, third, fourth.', 'cm1': 'first, second, third, puis -th : fourth, fifth, ninth, twelfth.'},
    'en_calendrier': {'ce2': "Jours et mois avec une majuscule ; l'heure : It's 3 o'clock.", 'cm2': 'yesterday, today, tomorrow ; spring, summer, autumn, winter.',
                      None: 'Jours et mois prennent une majuscule ; les jours finissent par -day.'},
    'en_verbes': {'cp': 'Pour donner un ordre, on dit juste le verbe : Run! Jump!', 'cm2': 'Infinitif anglais : to + verbe (to read).',
                  None: 'Avec I, le verbe ne change pas : I read, I swim.'},
    'en_avoir_etre': {'cm1': 'I have an aunt ; I am English (majuscule).', None: "I am / I'm = je suis ; I have / I've got = j'ai. Mais j'ai faim = I'm hungry."},
    'en_decrire_position': {'cp': 'I see a frog = je vois une grenouille.', 'ce1': 'I see… ; on, under, in, next to.',
                            'ce2': 'There is (un seul) / There are (plusieurs) ; on the left, on the right, at the top, at the bottom.'},
    'en_politesse_consignes': {'cm1': "Don't + verbe pour interdire ; please, thank you, sorry.", None: 'please, thank you, yes, no ; une consigne commence par le verbe.'},
    'en_questions_lieux': {'cm1': 'what, where, when, who, why, how ; I am in the kitchen.', None: 'what, where, when, who ; in, on, under.'},
    'en_pays': {'cm1': 'I come from France ; he comes from… ; majuscule aux pays et aux langues.', None: 'Les nationalités prennent une majuscule : French, English.'},
}

TITRES = {'en_couleurs': 'Les couleurs', 'en_animaux': 'Les animaux', 'en_corps': 'Le corps', 'en_ecole': "L'école",
          'en_emotions': 'Les émotions', 'en_maison_famille': 'La maison et la famille', 'en_meteo_nature': 'La météo et la nature',
          'en_nourriture': 'La nourriture', 'en_vetements': 'Les vêtements', 'en_ville_transports': 'La ville et les transports',
          'en_loisirs_metiers': 'Loisirs et métiers', 'en_pays': 'Pays et nationalités', 'en_calendrier': 'Jours, mois, heure',
          'en_nombres': 'Les nombres', 'en_verbes': "Les verbes d'action", 'en_adjectifs': 'Les adjectifs',
          'en_avoir_etre': 'Avoir et être', 'en_gouts': 'Mes goûts', 'en_decrire_position': 'Décrire une image',
          'en_politesse_consignes': 'Politesse et consignes', 'en_se_presenter': 'Se présenter',
          'en_consignes_obligation': 'Pouvoir, devoir', 'en_questions_lieux': 'Questions et lieux', 'en_comparer': 'Comparer',
          'en_demonstratifs': 'This, that, these, those', 'en_contraires_synonymes': 'Contraires et synonymes',
          'en_passe': 'Le passé', 'en_habitudes': 'Mes habitudes', 'en_futur': 'Le futur proche',
          'en_present_continu': 'Le présent continu'}


def fiche(cl, code):
    pages = list(regle(code, cl))
    if code == 'en_contraires_synonymes':
        con, syn, spe = [], [], []
        for e, b in AUTRES[(cl, code)]:
            m = re.search(r'"(.+)"', e).group(1)
            if 'contraire' in e:
                if (b, m) not in con: con.append((m, b))
            elif 'synonyme' in e:
                if (b, m) not in syn: syn.append((m, b))
            else:
                spe.append((m, b))
        if con:
            cells = [x for a, b in con for x in (en(a), en(b))]
            if len(con) % 2: cells += [' ', ' ']
            pages.append(f'[titre]Les contraires[/titre]\n{tableau(4, cells, entete=["mot", "contraire", "mot", "contraire"], size=18, paires=True)}')
        if syn:
            cells = [x for a, b in syn for x in (en(a), en(b))]
            if len(syn) % 2: cells += [' ', ' ']
            pages.append(f'[titre]Les synonymes[/titre]\n{tableau(4, cells, entete=["mot", "synonyme", "mot", "synonyme"], size=18, paires=True)}')
        if spe:
            pages.append("""[titre]Grand et petit pour une personne[/titre]
[cadre]Pour la taille d'une personne : grand = [b]tall[/b], petit = [b]short[/b].
Pour un objet : grand = [b]big[/b], petit = [b]small[/b].[/cadre]""")
    pages += pages_vocab(PAIRES.get((cl, code), []))
    rc = RET_CL.get(code, {})
    texte = rc.get(cl, rc.get(None, RET[code]))
    pages.append(f'[titre]Je retiens[/titre]\n[cadre]{texte}[/cadre]')
    return [couleur_alt(cl, p) for p in pages]


SQL = """-- Fiche {titre} ({CL}) - anglais, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'english', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

OUT = sys.argv[2]
TXT = sys.argv[3] if len(sys.argv) > 3 else None
couples = sorted(set((cl, code) for _i, cl, code, *_ in rows), key=lambda x: (CLASSES.index(x[0]), x[1]))
toutes = ['-- Toutes les fiches de cours Anglais CP -> CM2 (2026-10-03), une seule transaction.', 'begin;']
total = 0
for cl, code in couples:
    pages = fiche(cl, code)
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    assert '[s]' not in contenu and '[i]' not in contenu and '[u]' not in contenu
    titre = TITRES[code]
    sql = SQL.format(CL=cl.upper(), cl=cl, titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
    with open(os.path.join(OUT, f'en_{cl}_{code[3:]}.sql'), 'w', encoding='utf-8') as fh:
        fh.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{cl}_{code}.txt'), 'w', encoding='utf-8') as fh:
            fh.write(contenu)
    total += len(pages)
    print(cl, code, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'anglais_toutes.sql'), 'w', encoding='utf-8') as fh:
    fh.write('\n'.join(toutes) + '\n')
print(len(couples), 'fiches,', total, 'pages')
