"""Genere server/contenu_migration.sql a partir des CSV de csv/questions/ (migration unique, 2026-09-26).
- Reprend les id des CSV ; en cas d'id deja pris, attribue un nouvel id a partir de 100000
  (liste des correspondances dans server/migration_ids_renumerotes.csv).
- Verifie chaque ligne contre les memes regles que les contraintes de la base avant d'ecrire.
Usage : python3 tools/migration/csv_vers_supabase.py (depuis la racine du projet)"""
import csv, glob, os, sys

RACINE = 'csv/questions'
fichiers = sorted(glob.glob(f'{RACINE}/*/*/*.csv'))
# cp/math traite en premier : c'est le proprietaire d'origine de la tranche 2000-2999
fichiers.sort(key=lambda f: (0 if f.endswith('cp/math/generated.csv') else 1, f))

def q(s):
    return "'" + s.replace("'", "''") + "'"

def arr(liste):
    return 'array[' + ','.join(q(x) for x in liste) + ']::text[]'

# Corrections appliquees pendant la migration (CSV geles, on ne les modifie pas) :
# bugs trouves par les garde-fous le 2026-09-26 - un mauvais choix en double.
CORRECTIONS_CHOIX = {
    19187: ['storm', 'snow', 'rainbow'],     # ce1/english "brouillard" : storm etait en double
    20103: ['baker', 'postman', 'farmer'],   # ce2/english "chauffeur" : baker etait en double
}

pris_q, pris_p = set(), set()
prochain = 100000
renum = []
passages, questions, erreurs = [], [], []

for f in fichiers:
    _, classe, matiere, nom = f.replace('\\', '/').split('/')[-4:] if False else [None] + f.replace('\\', '/').split('/')[-3:]
    with open(f, encoding='utf-8', newline='') as fh:
        for r in csv.DictReader(fh, delimiter=';'):
            cid = int(r['id'])
            if r.get('type') == 'passage':
                if cid in pris_p:
                    erreurs.append(f'{f}: passage {cid} en double'); continue
                pris_p.add(cid)
                passages.append((cid, classe, r['text']))
                continue
            nid = cid
            if cid in pris_q:
                nid = prochain; prochain += 1
                renum.append((f, cid, nid))
            pris_q.add(nid)
            enonce, rep = r['text'], r['correct_answer']
            choix = [r[k] for k in ('choice_2', 'choice_3', 'choice_4') if r.get(k, '').strip()]
            if cid in CORRECTIONS_CHOIX: choix = CORRECTIONS_CHOIX[cid]
            grille = r['grid'].split('|') if r.get('grid') else None
            pid = int(r['passage_id']) if r.get('passage_id') else None
            tl = r.get('qtype') or None
            ou = f'{f} id {cid}'
            if not enonce.strip() or not rep.strip(): erreurs.append(f'{ou}: enonce ou reponse vide')
            if not 1 <= len(choix) <= 3: erreurs.append(f'{ou}: {len(choix)} mauvais choix')
            if len(set(choix)) != len(choix): erreurs.append(f'{ou}: choix en double {choix}')
            if rep in choix: erreurs.append(f'{ou}: bonne reponse aussi dans les choix')
            if (matiere == 'lecture') != (pid is not None): erreurs.append(f'{ou}: lecture sans texte ou texte hors lecture')
            if grille is not None and (len(grille) != 9 or matiere != 'logique'): erreurs.append(f'{ou}: grille invalide ({len(grille)} cases)')
            questions.append((nid, classe, matiere, enonce, rep, choix, grille, pid, tl))

for (_, _, _, _, _, _, _, pid, _) in questions:
    if pid is not None and pid not in pris_p: erreurs.append(f'texte {pid} introuvable')

if erreurs:
    print(f'{len(erreurs)} ERREUR(S) - rien n a ete genere :'); print('\n'.join(erreurs[:50])); sys.exit(1)

with open('server/contenu_migration.sql', 'w', encoding='utf-8') as out:
    out.write('-- Genere par tools/migration/csv_vers_supabase.py - migration unique des CSV (2026-09-26)\n')
    out.write('-- Tout ou rien : en cas d erreur, rien n est insere.\nbegin;\n')
    for (pid, classe, texte) in passages:
        out.write(f"insert into contenu_passages (id, classe, texte, statut) values ({pid}, {q(classe)}, {q(texte)}, 'publie');\n")
    for (nid, classe, matiere, enonce, rep, choix, grille, pid, tl) in questions:
        out.write('insert into contenu_questions (id, classe, matiere, enonce, bonne_reponse, mauvais_choix, grille, passage_id, type_lecture, statut) values ('
                  f"{nid}, {q(classe)}, {q(matiere)}, {q(enonce)}, {q(rep)}, {arr(choix)}, {arr(grille) if grille else 'null'}, "
                  f"{pid if pid is not None else 'null'}, {q(tl) if tl else 'null'}, 'publie');\n")
    out.write("select setval(pg_get_serial_sequence('contenu_questions', 'id'), (select max(id) from contenu_questions));\n")
    out.write("select setval(pg_get_serial_sequence('contenu_passages', 'id'), (select max(id) from contenu_passages));\n")
    out.write('commit;\n')

with open('server/migration_ids_renumerotes.csv', 'w', encoding='utf-8', newline='') as out:
    w = csv.writer(out, delimiter=';'); w.writerow(['fichier', 'ancien_id', 'nouvel_id']); w.writerows(renum)

print(f'OK : {len(passages)} textes, {len(questions)} questions, {len(renum)} id renumerotes')
