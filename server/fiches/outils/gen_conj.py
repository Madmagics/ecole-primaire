# Fiches de cours Conjugaison CE1 -> CM2 (2026-10-03) : une fiche par couple notion (temps) + classe.
# Genere server/fiches/conj_<cl>_<code>.sql + conj_toutes.sql + .txt de rendu.
import os
import sys
from logique_lib import tableau, sans_gras_emoji, couleur_alt

FICHES = []
PR = ['je', 'tu', 'il, elle', 'nous', 'vous', 'ils, elles']


def add(cl, code, titre, pages):
    FICHES.append((cl, code, titre, [couleur_alt(cl, p) for p in pages]))


def r(x):
    return f'[b][color=#C62828]{x}[/color][/b]'


def f(s):
    """'dans|e' -> dans + terminaison en rouge ; sans | : forme entiere en noir."""
    if '|' in s:
        a, b = s.split('|', 1)
        return a + r(b)
    return s


def tab(verbes, colonnes, pron=PR, size=19):
    """verbes : en-tetes ; colonnes : une liste de 6 formes 'radical|terminaison' par verbe."""
    cells = []
    for i, p in enumerate(pron):
        cells.append(f'[b]{p}[/b]')
        for col in colonnes:
            cells.append(f(col[i]))
    return tableau(len(verbes) + 1, cells, entete=[''] + verbes, size=size, lignes=True)


def er(rad, terms=('e', 'es', 'e', 'ons', 'ez', 'ent')):
    return [f'{rad}|{t}' for t in terms]


IMP = ('ais', 'ais', 'ait', 'ions', 'iez', 'aient')
FUT = ('ai', 'as', 'a', 'ons', 'ez', 'ont')

# ========================================================================================  CE1
add('ce1', 'present', 'Le présent des verbes en -er', [
f"""[titre]Conjuguer un verbe[/titre]
Le verbe change selon [b]qui[/b] fait l'action. Il a deux parties :
{tableau(3, ['nous', 'dans', r('ons')], entete=['pronom', 'radical', 'terminaison'], size=26)}
[cadre]Le [b]radical[/b] ne bouge pas (dans-), la [b]terminaison[/b] change (-e, -es, -ons…).
L'[b]infinitif[/b], c'est le verbe « tout nu » : danser, chanter, parler.[/cadre]""",
f"""[titre]Les verbes en -er au présent[/titre]
{tab(['danser', 'parler'], [er('dans'), er('parl')], size=21)}
[cadre]Les terminaisons : [b]e, es, e, ons, ez, ent[/b].[/cadre]""",
"""[titre]Les lettres qu'on n'entend pas[/titre]
[cadre]je danse, tu danses, il danse, ils dansent : [b]ça se dit pareil[/b] !
Mais ça ne s'écrit pas pareil :
• avec [b]tu[/b], toujours un [b]s[/b] : tu danse[b]s[/b]
• avec [b]ils / elles[/b], toujours [b]ent[/b] : ils danse[b]nt[/b][/cadre]
[cadre=astuce]Le [b]-ent[/b] de « ils dansent » ne se prononce jamais.[/cadre]""",
f"""[titre]Être et avoir[/titre]
Ces deux verbes sont spéciaux : il faut les apprendre par cœur.
{tab(['être', 'avoir'], [['suis', 'es', 'est', 'sommes', 'êtes', 'sont'], ["j'ai", 'as', 'a', 'avons', 'avez', 'ont']], pron=['je (j\')', 'tu', 'il, elle', 'nous', 'vous', 'ils, elles'], size=20)}""",
"""[titre]Je ou j' ?[/titre]
Devant une voyelle ou un h muet, [b]je[/b] devient [b]j'[/b].
[cadre]j'habite · j'essuie · j'écoute · j'ai
mais : je danse · je cache · je tombe[/cadre]""",
f"""[titre]-ger et -cer avec nous[/titre]
{tableau(2, ['nous plong' + r('e') + 'ons', 'nous ran' + r('ge') + 'ons, nous parta' + r('ge') + 'ons', 'nous lan' + r('ç') + 'ons', 'nous avan' + r('ç') + 'ons'], entete=['-ger : on garde le e', '-cer : c devient ç'], size=20)}
[cadre=astuce]Sans ce e ou ce ç, on lirait « plongons » (g dur) ou « lancons » (k).[/cadre]""",
f"""[titre]-yer : y devient i[/titre]
Les verbes en [b]-oyer[/b] et [b]-uyer[/b] changent le y en [b]i[/b] devant un e muet.
{tableau(2, ["j'essu" + r('ie'), 'nous essu' + r('y') + 'ons', 'je netto' + r('ie'), 'vous netto' + r('y') + 'ez'], size=21, lignes=True)}
[cadre=astuce]Avec balayer, on peut écrire [b]il balaye[/b] ou [b]il balaie[/b] : les deux sont justes.[/cadre]""",
"""[titre]Les verbes en -ier[/titre]
[cadre]colorier, trier, skier, planifier : je garde le [b]i[/b] du radical, puis la terminaison.
je colori[b]e[/b] · tu tri[b]es[/b] · nous ski[b]ons[/b] · ils planifi[b]ent[/b][/cadre]
[cadre=astuce]On entend à peine la terminaison, mais elle est bien là : je trie, nous trions.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Verbes en -er : [b]e, es, e, ons, ez, ent[/b].
• tu → s ; ils, elles → ent (muet).
• être : suis, es, est, sommes, êtes, sont. avoir : ai, as, a, avons, avez, ont.
• nous plongeons, nous lançons. j'essuie, je nettoie.[/cadre]""",
])

# ========================================================================================  CE2
add('ce2', 'present', 'Le présent : verbes en -ir et verbes irréguliers', [
f"""[titre]Les verbes comme finir[/titre]
Beaucoup de verbes en [b]-ir[/b] se conjuguent comme [b]finir[/b] (2e groupe).
{tab(['finir', 'grandir'], [['fin|is', 'fin|is', 'fin|it', 'fin|issons', 'fin|issez', 'fin|issent'], ['grand|is', 'grand|is', 'grand|it', 'grand|issons', 'grand|issez', 'grand|issent']], size=20)}""",
"""[titre]Le reconnaître[/titre]
[cadre]Un verbe se conjugue comme finir si on dit « nous [b]…issons[/b] ».
nous chois[b]issons[/b] · nous roug[b]issons[/b] · nous applaud[b]issons[/b] ✓[/cadre]
[cadre=astuce]Pièges : il fini[b]t[/b] (et pas « il finis »), nous finissons (avec ss).[/cadre]""",
f"""[titre]Aller et venir[/titre]
{tab(['aller', 'venir'], [['vais', 'vas', 'va', 'allons', 'allez', 'vont'], ['viens', 'viens', 'vient', 'venons', 'venez', 'viennent']], size=20)}
[cadre]Ce ne sont pas des verbes comme finir : il faut les apprendre.[/cadre]""",
f"""[titre]Faire et dire[/titre]
{tab(['faire', 'dire'], [['fais', 'fais', 'fait', 'faisons', 'faites', 'font'], ['dis', 'dis', 'dit', 'disons', 'dites', 'disent']], size=20)}
[cadre=astuce]Attention : vous fai[b]tes[/b], vous di[b]tes[/b] (et pas « vous faisez »).[/cadre]""",
"""[titre]Rappel : les verbes en -er[/titre]
[cadre]je danse, tu danses, il danse, nous dansons, vous dansez, ils dansent.[/cadre]
[cadre=astuce]Ne pas confondre : « il fleuri[b]t[/b] » (finir) et « il danse » (-er) : les verbes en -ir prennent [b]-t[/b] avec il.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Comme finir : is, is, it, issons, issez, issent.
• aller : vais, vas, va, allons, allez, vont.
• venir : viens, viens, vient, venons, venez, viennent.
• faire : fais, fais, fait, faisons, faites, font. dire : vous dites.[/cadre]""",
])

add('ce2', 'imparfait', "L'imparfait", [
"""[titre]À quoi sert l'imparfait ?[/titre]
L'imparfait raconte ce qui se passait [b]avant[/b], ce qui [b]durait[/b] ou se [b]répétait[/b].
[cadre]Autrefois, mon grand-père [b]habitait[/b] à la campagne.
Chaque soir, il [b]rangeait[/b] ses outils.[/cadre]""",
f"""[titre]Les terminaisons[/titre]
Pour [b]tous[/b] les verbes, les terminaisons sont les mêmes :
{tab(['parler', 'finir'], [er('parl', IMP), er('finiss', IMP)], size=20)}
[cadre][b]ais, ais, ait, ions, iez, aient[/b][/cadre]""",
"""[titre]Trouver le radical[/titre]
Je prends le verbe au présent avec [b]nous[/b], j'enlève -ons, et j'ajoute la terminaison.
[cadre]nous parl[b]ons[/b] → je parl[b]ais[/b]
nous finiss[b]ons[/b] → je finiss[b]ais[/b]
nous fais[b]ons[/b] → je fais[b]ais[/b][/cadre]""",
f"""[titre]Être et avoir[/titre]
{tab(['être', 'avoir'], [["j'ét|ais", 'ét|ais', 'ét|ait', 'ét|ions', 'ét|iez', 'ét|aient'], ["j'av|ais", 'av|ais', 'av|ait', 'av|ions', 'av|iez', 'av|aient']], size=20)}
[cadre=astuce]Être est la seule exception : on dit « nous sommes » mais « j'[b]ét[/b]ais ».[/cadre]""",
f"""[titre]-cer et -ger[/titre]
{tableau(2, ['je lan' + r('ç') + 'ais, il pla' + r('ç') + 'ait', 'nous lan' + r('c') + 'ions, vous pla' + r('c') + 'iez', 'je plon' + r('ge') + 'ais, ils ran' + r('ge') + 'aient', 'nous plon' + r('g') + 'ions, vous plon' + r('g') + 'iez'], entete=['devant a : ç / ge', 'devant i : c / g'], size=19)}
[cadre=astuce]Devant [b]a[/b] : ç et ge. Devant [b]i[/b] : c et g suffisent.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Imparfait : [b]ais, ais, ait, ions, iez, aient[/b] pour tous les verbes.
• Radical = présent avec nous, sans -ons : nous faisons → je faisais.
• Être : j'étais. Avoir : j'avais.
• je lançais, il plongeait ; nous lancions, nous plongions.[/cadre]""",
])

add('ce2', 'futur', 'Le futur simple', [
"""[titre]À quoi sert le futur ?[/titre]
Le futur dit ce qui [b]va se passer[/b] plus tard.
[cadre]Demain, je [b]visiterai[/b] le musée. L'an prochain, nous [b]camperons[/b] à la mer.[/cadre]""",
f"""[titre]Infinitif + terminaison[/titre]
Pour les verbes en -er, je garde [b]tout l'infinitif[/b] et j'ajoute la terminaison.
{tab(['donner'], [er('donner', FUT)], size=22)}
[cadre][b]ai, as, a, ons, ez, ont[/b] (comme le verbe avoir !)[/cadre]""",
"""[titre]Le e qu'on n'entend pas[/titre]
On ne l'entend presque pas, mais le [b]e[/b] de l'infinitif reste écrit.
[cadre]je compt[b]e[/b]rai · tu jou[b]e[/b]ras · nous colori[b]e[/b]rons · ils ski[b]e[/b]ront[/cadre]
[cadre=astuce]Je pense à l'infinitif entier : compter → compter + ai = je compterai.[/cadre]""",
f"""[titre]Les verbes en -yer[/titre]
{tableau(2, ['nettoyer', 'je netto' + r('i') + 'erai, ils netto' + r('i') + 'eront', 'essuyer', 'tu essu' + r('i') + 'eras', 'balayer', 'il balayera ou il balaiera (les deux sont justes)'], size=19, lignes=True)}""",
"""[titre]Futur ou conditionnel ?[/titre]
[cadre]Au futur, avec je : [b]-ai[/b] → je donnerai.
Avec un [b]s[/b] (je donnerais), ce n'est plus le futur : c'est le conditionnel.[/cadre]
[cadre=astuce]Je remplace par « nous » : nous donnerons (futur) ✓.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Futur des verbes en -er : infinitif + [b]ai, as, a, ons, ez, ont[/b].
• Le e de l'infinitif reste écrit : je jouerai, nous colorierons.
• -oyer / -uyer : i → je nettoierai, tu essuieras.
• Je : -ai (futur), pas -ais.[/cadre]""",
])

# ========================================================================================  CM1
add('cm1', 'present', 'Le présent : pouvoir, vouloir, savoir, voir, prendre', [
f"""[titre]Pouvoir et vouloir[/titre]
{tab(['pouvoir', 'vouloir'], [['peux', 'peux', 'peut', 'pouvons', 'pouvez', 'peuvent'], ['veux', 'veux', 'veut', 'voulons', 'voulez', 'veulent']], size=20)}
[cadre=astuce]Avec je et tu : [b]x[/b] (je peux, tu veux). Avec il : [b]t[/b].[/cadre]""",
f"""[titre]Savoir et voir[/titre]
{tab(['savoir', 'voir'], [['sais', 'sais', 'sait', 'savons', 'savez', 'savent'], ['vois', 'vois', 'voit', 'voyons', 'voyez', 'voient']], size=20)}
[cadre=astuce]nous vo[b]y[/b]ons, vous vo[b]y[/b]ez, mais ils vo[b]i[/b]ent.[/cadre]""",
f"""[titre]Prendre[/titre]
{tab(['prendre'], [['prends', 'prends', 'prend', 'prenons', 'prenez', 'prennent']], size=22)}
[cadre=astuce]il pren[b]d[/b] (pas de t) ; ils pre[b]nn[/b]ent avec deux n. Pareil : apprendre, comprendre.[/cadre]""",
"""[titre]Ce qui revient souvent[/titre]
[cadre]• je, tu : terminaisons en [b]-s[/b] ou [b]-x[/b] : je sais, tu peux.
• il, elle : [b]-t[/b] ou [b]-d[/b] : il veut, il prend.
• ils, elles : [b]-ent[/b], souvent avec un radical qui change : ils peuvent, ils veulent.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• pouvoir : peux, peux, peut, pouvons, pouvez, peuvent.
• vouloir : veux, veux, veut, voulons, voulez, veulent.
• savoir : sais, sais, sait… ils savent. voir : vois… nous voyons, ils voient.
• prendre : prends, prends, prend, prenons, prenez, prennent.[/cadre]""",
])

add('cm1', 'imparfait', "L'imparfait des verbes irréguliers", [
"""[titre]Rappel[/titre]
[cadre]Terminaisons pour tous les verbes : [b]ais, ais, ait, ions, iez, aient[/b].
Radical : le présent avec [b]nous[/b], sans -ons.[/cadre]
[cadre=astuce]Seule exception : être → j'étais.[/cadre]""",
f"""[titre]Des radicaux surprenants[/titre]
{tableau(3, ['faire', 'nous faisons', 'je fais' + r('ais'), 'dire', 'nous disons', 'je dis' + r('ais'), 'lire', 'nous lisons', 'je lis' + r('ais'), 'écrire', 'nous écrivons', "j'écriv" + r('ais'), 'boire', 'nous buvons', 'je buv' + r('ais'), 'connaître', 'nous connaissons', 'je connaiss' + r('ais'), 'prendre', 'nous prenons', 'je pren' + r('ais')], entete=['verbe', 'présent', 'imparfait'], size=18, lignes=True)}""",
f"""[titre]voir, croire : y et i[/titre]
{tab(['voir', 'croire'], [['voy|ais', 'voy|ais', 'voy|ait', 'voy|ions', 'voy|iez', 'voy|aient'], ['croy|ais', 'croy|ais', 'croy|ait', 'croy|ions', 'croy|iez', 'croy|aient']], size=19)}
[cadre=astuce]nous vo[b]yi[/b]ons : on écrit y [b]et[/b] i, même si on ne l'entend pas bien.[/cadre]""",
f"""[titre]-cer et -ger[/titre]
{tableau(2, ['je commen' + r('ç') + 'ais, il pla' + r('ç') + 'ait', 'nous commen' + r('c') + 'ions', 'je man' + r('ge') + 'ais, ils ran' + r('ge') + 'aient', 'nous man' + r('g') + 'ions'], entete=['devant a', 'devant i'], size=20)}""",
"""[titre]Je retiens[/titre]
[cadre]• Imparfait = radical de « nous » au présent + ais, ais, ait, ions, iez, aient.
• je faisais, je disais, je lisais, j'écrivais, je buvais, je prenais.
• nous voyions, nous croyions (y + i).
• je commençais, je mangeais.[/cadre]""",
])

add('cm1', 'futur', 'Le futur simple des verbes irréguliers', [
f"""[titre]Rappel : les verbes réguliers[/titre]
Infinitif + [b]ai, as, a, ons, ez, ont[/b].
{tableau(3, ['chanter', 'finir', 'attendre', 'je chanter' + r('ai'), 'je finir' + r('ai'), "j'attendr" + r('ai')], size=21)}
[cadre=astuce]Verbes en -re : j'enlève le [b]e[/b] final : attendre → j'attendrai, vendre → je vendrai.[/cadre]""",
f"""[titre]Des radicaux à connaître (1)[/titre]
{tableau(4, ['être', 'je ser' + r('ai'), 'avoir', "j'aur" + r('ai'), 'aller', "j'ir" + r('ai'), 'faire', 'je fer' + r('ai'), 'venir', 'je viendr' + r('ai'), 'tenir', 'je tiendr' + r('ai'), 'voir', 'je verr' + r('ai'), 'envoyer', "j'enverr" + r('ai')], size=19, paires=True)}""",
f"""[titre]Des radicaux à connaître (2)[/titre]
{tableau(4, ['pouvoir', 'je pourr' + r('ai'), 'vouloir', 'je voudr' + r('ai'), 'devoir', 'je devr' + r('ai'), 'savoir', 'je saur' + r('ai'), 'courir', 'je courr' + r('ai'), 'mourir', 'je mourr' + r('ai'), 'prendre', 'je prendr' + r('ai'), 'recevoir', 'je recevr' + r('ai')], size=19, paires=True)}""",
"""[titre]Les deux r[/titre]
[cadre]Avec [b]deux r[/b] : je cou[b]rr[/b]ai, je mou[b]rr[/b]ai, je pou[b]rr[/b]ai, je ve[b]rr[/b]ai, j'enve[b]rr[/b]ai.[/cadre]
[cadre=astuce]On entend bien le r prolongé : « je cour-rai ». À l'imparfait, un seul r : je courais.[/cadre]""",
"""[titre]Le radical change, pas les terminaisons[/titre]
[cadre]Même pour les verbes irréguliers, les terminaisons restent [b]ai, as, a, ons, ez, ont[/b] :
je ferai, tu feras, il fera, nous ferons, vous ferez, ils feront.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Futur : radical + ai, as, a, ons, ez, ont.
• Radicaux spéciaux : ser-, aur-, ir-, fer-, viendr-, verr-, pourr-, voudr-, devr-, saur-.
• Deux r : courrai, mourrai, pourrai, verrai, enverrai.
• Verbes en -re : attendre → j'attendrai.[/cadre]""",
])

add('cm1', 'passe_compose', 'Le passé composé', [
"""[titre]Un temps en deux mots[/titre]
Le passé composé raconte une action [b]terminée[/b]. Il a deux parties :
[cadre]tu [b]as[/b] [b]fermé[/b]
auxiliaire avoir au présent + participe passé[/cadre]""",
f"""[titre]L'auxiliaire avoir[/titre]
{tab(['avoir + participe'], [["j'ai chanté", 'as chanté', 'a chanté', 'avons chanté', 'avez chanté', 'ont chanté']], size=21)}
[cadre=astuce]Avec avoir, le participe ne s'accorde pas avec le sujet : elles ont chant[b]é[/b].[/cadre]""",
f"""[titre]Les participes réguliers[/titre]
{tableau(2, ['verbes en -er → ' + r('é'), 'chanter → chant' + r('é') + ', fermer → ferm' + r('é'), 'verbes comme finir → ' + r('i'), 'finir → fin' + r('i') + ', choisir → chois' + r('i'), 'beaucoup de verbes en -re → ' + r('u'), 'attendre → attend' + r('u') + ', perdre → perd' + r('u')], size=19, lignes=True)}""",
f"""[titre]Les participes à connaître[/titre]
{tableau(4, ['voir', 'vu', 'lire', 'lu', 'croire', 'cru', 'boire', 'bu', 'pouvoir', 'pu', 'vouloir', 'voulu', 'savoir', 'su', 'devoir', 'dû', 'courir', 'couru', 'vivre', 'vécu', 'connaître', 'connu', 'être', 'été', 'avoir', 'eu', 'prendre', 'pris', 'mettre', 'mis', 'faire', 'fait', 'dire', 'dit', 'écrire', 'écrit'], size=17, paires=True)}""",
"""[titre]é ou er ?[/titre]
[cadre]Après avoir, c'est le participe : tu as ferm[b]é[/b] (et pas « tu as fermer »).[/cadre]
[cadre=astuce]Je remplace par un verbe en -re : « tu as [b]vendu[/b] » ✓ → participe → é.
« il va vendre » → infinitif → er.[/cadre]""",
"""[titre]La lettre muette du participe[/titre]
Pour savoir comment finit un participe, je le mets au [b]féminin[/b] :
[cadre]pri[b]s[/b] → prise · mi[b]s[/b] → mise · fai[b]t[/b] → faite · écri[b]t[/b] → écrite · di[b]t[/b] → dite[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Passé composé = avoir au présent + participe passé.
• -er → é ; comme finir → i ; attendre, perdre → u.
• À connaître : vu, lu, cru, bu, pu, voulu, su, dû, pris, mis, fait, dit, écrit, été, eu.
• Avec avoir, pas d'accord avec le sujet.[/cadre]""",
])

# ========================================================================================  CM2
add('cm2', 'passe_compose', 'Le passé composé : avoir ou être ?', [
"""[titre]Deux auxiliaires[/titre]
[cadre]Le passé composé = auxiliaire [b]avoir[/b] ou [b]être[/b] au présent + participe passé.
il [b]a[/b] vendu · tu [b]es[/b] resté[/cadre]""",
f"""[titre]Les verbes avec être[/titre]
{tableau(4, ['aller', 'venir', 'arriver', 'partir', 'entrer', 'sortir', 'monter', 'descendre', 'naître', 'mourir', 'rester', 'tomber', 'devenir', 'revenir', 'retourner', 'passer (par)'], size=19)}
[cadre=astuce]Tous les verbes pronominaux aussi : il [b]s'est[/b] levé.[/cadre]""",
f"""[titre]Avec être, on accorde[/titre]
{tableau(2, ['Il est resté.', 'Elle est resté' + r('e') + '.', 'Ils sont resté' + r('s') + '.', 'Elles sont resté' + r('es') + '.'], size=21, paires=True)}
[cadre]Avec avoir, jamais d'accord avec le sujet : elles ont vend[b]u[/b].[/cadre]""",
f"""[titre]Des participes à connaître[/titre]
{tableau(4, ['construire', 'construit', 'conduire', 'conduit', 'recevoir', 'reçu', 'apercevoir', 'aperçu', 'acquérir', 'acquis', 'ouvrir', 'ouvert', 'naître', 'né', 'mourir', 'mort'], size=19, paires=True)}
[cadre=astuce]Lettre muette : je mets au féminin → construi[b]t[/b]e, ouver[b]t[/b]e.[/cadre]""",
"""[titre]Les pièges[/titre]
[cadre]• tu [b]as[/b] resté ✗ → tu [b]es[/b] resté ✓ (rester prend être)
• nous avons condui[b]s[/b] ✗ → nous avons condui[b]t[/b] ✓
• il a vendu[b]s[/b] ✗ → il a vendu ✓ (pas d'accord avec avoir)[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Avoir pour la plupart des verbes ; être pour aller, venir, rester, tomber… et les verbes pronominaux.
• Avec être : accord avec le sujet (elles sont restées).
• Avec avoir : pas d'accord avec le sujet.
• construit, conduit, reçu, ouvert : je vérifie la lettre muette au féminin.[/cadre]""",
])

add('cm2', 'plus_que_parfait', 'Le plus-que-parfait', [
"""[titre]Avant le passé[/titre]
Le plus-que-parfait raconte une action qui s'est passée [b]avant[/b] une autre action passée.
[cadre]Quand je suis arrivé, le train [b]était parti[/b].
→ le train est parti [b]d'abord[/b], puis je suis arrivé.[/cadre]""",
f"""[titre]Comment le former[/titre]
Auxiliaire [b]avoir[/b] ou [b]être[/b] à l'[b]imparfait[/b] + participe passé.
{tab(['avoir', 'être'], [["j'avais joué", 'avais joué', 'avait joué', 'avions joué', 'aviez joué', 'avaient joué'], ["j'étais parti(e)", 'étais parti(e)', 'était parti(e)', 'étions parti(e)s', 'étiez parti(e)s', 'étaient parti(e)s']], size=18)}""",
"""[titre]Passé composé ou plus-que-parfait ?[/titre]
[cadre]Passé composé : auxiliaire au [b]présent[/b] → elles [b]ont[/b] joué.
Plus-que-parfait : auxiliaire à l'[b]imparfait[/b] → elles [b]avaient[/b] joué.[/cadre]
[cadre=astuce]Le participe ne change pas : seul l'auxiliaire change de temps.[/cadre]""",
"""[titre]Avec être, on accorde[/titre]
[cadre]Elle était arrivé[b]e[/b]. · Ils étaient venu[b]s[/b]. · Elles étaient né[b]es[/b] en mai.[/cadre]
[cadre=astuce]Les mêmes verbes qu'au passé composé prennent être : aller, venir, partir, naître, tomber, rester…[/cadre]""",
"""[titre]Le participe, pas l'infinitif[/titre]
[cadre]elles avaient pouss[b]é[/b] ✓ · elles avaient pousser ✗[/cadre]
[cadre=astuce]Je remplace par un verbe en -re : « elles avaient [b]vendu[/b] » → c'est un participe → é.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Plus-que-parfait = avoir ou être à l'[b]imparfait[/b] + participe passé.
• Il dit ce qui s'est passé avant une autre action passée.
• Avec être : accord avec le sujet.
• Participe en -é, pas -er.[/cadre]""",
])

add('cm2', 'conditionnel', 'Le conditionnel présent', [
"""[titre]À quoi sert le conditionnel ?[/titre]
[cadre]• Un [b]souhait[/b] : J'aimerais voyager.
• Une demande [b]polie[/b] : Pourrais-tu m'aider ?
• Une action qui dépend d'une [b]condition[/b] : Si j'avais le temps, je [b]viendrais[/b].[/cadre]""",
f"""[titre]Comment le former[/titre]
Radical du [b]futur[/b] + terminaisons de l'[b]imparfait[/b].
{tab(['chanter', 'faire'], [er('chanter', IMP), er('fer', IMP)], size=20)}""",
f"""[titre]Les radicaux du futur[/titre]
{tableau(4, ['être', 'je ser' + r('ais'), 'avoir', "j'aur" + r('ais'), 'aller', "j'ir" + r('ais'), 'venir', 'je viendr' + r('ais'), 'pouvoir', 'je pourr' + r('ais'), 'vouloir', 'je voudr' + r('ais'), 'savoir', 'je saur' + r('ais'), 'devoir', 'je devr' + r('ais'), 'voir', 'je verr' + r('ais'), 'courir', 'je courr' + r('ais'), 'mourir', 'je mourr' + r('ais'), 'recevoir', 'je recevr' + r('ais')], size=18, paires=True)}""",
f"""[titre]Futur ou conditionnel ?[/titre]
{tableau(2, ['je ferai', 'je fer' + r('ais'), 'nous ferons', 'nous fer' + r('ions'), 'ils seront', 'ils ser' + r('aient')], entete=['futur', 'conditionnel'], size=21, paires=True)}
[cadre=astuce]Je remplace par « il » : il fera (futur) / il ferait (conditionnel). On entend la différence.[/cadre]""",
"""[titre]Conditionnel ou imparfait ?[/titre]
[cadre]imparfait : nous mour[b]i[/b]ons (un seul r)
conditionnel : nous mou[b]rr[/b]ions (radical du futur : mourr-)[/cadre]
[cadre=astuce]Le conditionnel a toujours le [b]r[/b] du futur avant la terminaison : chante[b]r[/b]ais, fe[b]r[/b]ais.[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• Conditionnel = radical du futur + ais, ais, ait, ions, iez, aient.
• Il exprime un souhait, la politesse ou une condition (si…).
• je ferai (futur) ≠ je ferais (conditionnel).
• nous mourrions, nous courrions : deux r.[/cadre]""",
])

add('cm2', 'passe_simple', 'Le passé simple', [
"""[titre]Le temps des récits[/titre]
Le passé simple sert à raconter des [b]histoires[/b] et des faits passés, surtout à l'écrit.
[cadre]Le prince [b]monta[/b] sur son cheval et [b]partit[/b] au galop.[/cadre]
[cadre=astuce]On l'utilise surtout avec [b]il, elle, ils, elles[/b].[/cadre]""",
f"""[titre]Les verbes en -er : a, èrent[/titre]
{tableau(2, ['il chant' + r('a'), 'ils chant' + r('èrent'), 'elle mange' + r('a'), 'elles mang' + r('èrent'), 'il all' + r('a'), 'ils all' + r('èrent')], entete=['il, elle', 'ils, elles'], size=21, paires=True)}
[cadre=astuce]-ger : il mang[b]e[/b]a (on garde le e devant a).[/cadre]""",
f"""[titre]it, irent[/titre]
Les verbes comme finir et beaucoup de verbes en -re :
{tableau(2, ['il fin' + r('it'), 'ils fin' + r('irent'), 'il rend' + r('it'), 'ils rend' + r('irent'), 'il f' + r('it') + ' (faire)', 'ils f' + r('irent'), 'il pr' + r('it') + ' (prendre)', 'ils pr' + r('irent'), 'il v' + r('it') + ' (voir)', 'ils v' + r('irent')], entete=['il, elle', 'ils, elles'], size=19, paires=True)}""",
f"""[titre]ut, urent[/titre]
Beaucoup de verbes en -oir et quelques autres :
{tableau(4, ['avoir', 'il eut', 'être', 'il fut', 'pouvoir', 'il put', 'vouloir', 'il voulut', 'devoir', 'il dut', 'savoir', 'il sut', 'boire', 'il but', 'lire', 'il lut', 'croire', 'il crut', 'connaître', 'il connut', 'recevoir', 'il reçut', 'courir', 'il courut'], size=18, paires=True)}
[cadre]Avec ils : ils eurent, ils furent, ils purent…[/cadre]""",
f"""[titre]venir et tenir : int, inrent[/titre]
{tableau(2, ['il v' + r('int'), 'ils v' + r('inrent'), 'il t' + r('int'), 'ils t' + r('inrent')], entete=['il, elle', 'ils, elles'], size=22, paires=True)}
[cadre=astuce]Pas d'accent : il vint, ils vinrent.[/cadre]""",
"""[titre]Les pièges[/titre]
[cadre]• il regard[b]a[/b] (passé simple) ≠ il regard[b]ait[/b] (imparfait)
• il entend[b]it[/b] avec [b]t[/b] (pas « il entendis »)
• ils pass[b]èrent[/b] avec un accent grave[/cadre]""",
"""[titre]Je retiens[/titre]
[cadre]• -er : il chanta, ils chantèrent.
• finir, rendre, faire, prendre, voir : il finit, ils finirent.
• avoir, être, pouvoir, vouloir… : il eut, il fut, il put, ils purent.
• venir, tenir : il vint, ils vinrent.[/cadre]""",
])

# ---------------------------------------------------------------------------------- sortie
SQL = """-- Fiche {titre} ({CL}) - conjugaison, notion '{code}'. Relancer ce script remplace le contenu de la fiche.
insert into contenu_cours (classe, matiere, titre, contenu, statut, notion_id)
select '{cl}', 'conjugaison', '{titre_sql}', $fiche$
{contenu}
$fiche$, 'publie', n.id from contenu_notions n where n.code = '{code}'
on conflict (notion_id, classe) where statut <> 'archive'
do update set titre = excluded.titre, contenu = excluded.contenu, matiere = excluded.matiere, statut = 'publie', modifie_le = now()
returning id, classe, titre, statut;
"""

OUT = sys.argv[1] if len(sys.argv) > 1 else '.'
TXT = sys.argv[2] if len(sys.argv) > 2 else None
toutes = ['-- Toutes les fiches de cours Conjugaison CE1 -> CM2 (2026-10-03), une seule transaction.', 'begin;']
for cl, code, titre, pages in FICHES:
    contenu = sans_gras_emoji('\n[page]\n'.join(p.strip('\n') for p in pages))
    assert '[s]' not in contenu and '[i]' not in contenu
    sql = SQL.format(CL=cl.upper(), cl=cl, titre=titre, titre_sql=titre.replace("'", "''"), code=code, contenu=contenu)
    with open(os.path.join(OUT, f'conj_{cl}_{code}.sql'), 'w', encoding='utf-8') as fh:
        fh.write(sql)
    toutes.append(sql)
    if TXT:
        with open(os.path.join(TXT, f'{cl}_{code}.txt'), 'w', encoding='utf-8') as fh:
            fh.write(contenu)
    print(cl, code, titre, len(pages), 'p.')
toutes += ['commit;', 'select fn_publier();']
with open(os.path.join(OUT, 'conj_toutes.sql'), 'w', encoding='utf-8') as fh:
    fh.write('\n'.join(toutes) + '\n')
print(len(FICHES), 'fiches')
