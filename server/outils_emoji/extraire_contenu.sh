#!/bin/bash
# Exporte tout le texte du contenu en base (questions, fiches, textes de lecture, notions) dans
# server/outils_emoji/contenu_texte.tsv, lu par gen_emoji.py. A lancer depuis la racine du projet,
# avec l'acces .acces_claude/db.sh (conversation reliee au PC de Steve).
cd "$(dirname "$0")/../.." || exit 1
echo "\\copy (select enonce || ' ' || coalesce(bonne_reponse,'') || ' ' || coalesce(array_to_string(mauvais_choix,' '),'') || ' ' || coalesce(array_to_string(grille,' '),'') from contenu_questions where statut <> 'archive' union all select titre || ' ' || contenu from contenu_cours where statut <> 'archive' union all select texte from contenu_passages where statut <> 'archive' union all select libelle from contenu_notions) to stdout" \
  | bash .acces_claude/db.sh > server/outils_emoji/contenu_texte.tsv && wc -c server/outils_emoji/contenu_texte.tsv
