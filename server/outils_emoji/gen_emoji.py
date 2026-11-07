# Pack d'emoji du jeu (2026-11-07, demande Steve) : fabrique 2 petites polices qui ne contiennent
# QUE les emoji reellement utilises par le jeu (questions, fiches, textes de lecture, notions en
# base + textes ecrits dans le code), au lieu d'embarquer une police emoji complete (~10 Mo).
#
#   ui/theme/fonts/TwemojiJeu.ttf   emoji EN COULEUR (Twemoji, format COLR, lu par Godot sur
#                                   toutes les plateformes, navigateur compris)
#   ui/theme/fonts/NotoEmojiJeu.ttf emoji NOIR ET BLANC : seulement les symboles absents de Twemoji
#
# Utilisation (depuis la racine du projet) :
#   bash server/outils_emoji/extraire_contenu.sh          -> server/outils_emoji/contenu_texte.tsv
#   python3 server/outils_emoji/gen_emoji.py               -> regenere les 2 polices
#   python3 server/outils_emoji/gen_emoji.py --verifier    -> signale seulement les emoji manquants
# A relancer apres tout ajout de contenu contenant un emoji nouveau (sinon il s'afficherait en
# noir et blanc ou en carre vide). Necessite : pip install fonttools
#
# Licences : Twemoji (graphismes) CC-BY 4.0, Twitter Inc. et contributeurs - a citer dans le jeu ;
# Noto Emoji : SIL Open Font License 1.1.
import os, re, sys
from fontTools.ttLib import TTFont
from fontTools import subset

ICI = os.path.dirname(os.path.abspath(__file__))
RACINE = os.path.abspath(os.path.join(ICI, '..', '..'))
SRC_COULEUR = os.path.join(ICI, 'Twemoji.Mozilla.ttf')
SRC_NB = os.path.join(ICI, 'NotoEmoji-complet.ttf')
OUT_COULEUR = os.path.join(RACINE, 'ui', 'theme', 'fonts', 'TwemojiJeu.ttf')
OUT_NB = os.path.join(RACINE, 'ui', 'theme', 'fonts', 'NotoEmojiJeu.ttf')
CONTENU = os.path.join(ICI, 'contenu_texte.tsv')
# Glyphes a forcer en noir et blanc (aucun depuis que COLOR_EMOJIS de question_panel.gd est vide)
TOUJOURS_NB = set()
# Seuil des symboles (meme valeur que EMOJI_CODEPOINT_THRESHOLD dans question_panel.gd) : en
# dessous, c'est du texte, servi par Baloo.
SEUIL = 0x2190
LIAISONS = {0x200D, 0xFE0F, 0x20E3}  # ZWJ, selecteur emoji, keycap

def lire_textes():
    textes = []
    if os.path.exists(CONTENU):
        textes.append(open(CONTENU, encoding='utf-8').read())
    else:
        print('ATTENTION : %s absent, lancer extraire_contenu.sh (contenu en base non pris en compte)' % CONTENU)
    for racine, dossiers, fichiers in os.walk(RACINE):
        dossiers[:] = [d for d in dossiers if d not in ('.godot', '.git', 'server', 'Claude outputs', '.acces_claude', 'addons')]
        for f in fichiers:
            if f.endswith(('.gd', '.tscn', '.tres', '.json')):
                try:
                    textes.append(open(os.path.join(racine, f), encoding='utf-8').read())
                except (UnicodeDecodeError, OSError):
                    pass
    return '\n'.join(textes)

def main():
    verifier = '--verifier' in sys.argv
    texte = lire_textes()
    utilises = {ord(c) for c in texte if ord(c) >= SEUIL and not (0xE000 <= ord(c) <= 0xF8FF)}
    utilises |= {ord(c) for c in texte if 0x1F1E6 <= ord(c) <= 0x1F1FF}
    utilises -= LIAISONS
    cmap_c = TTFont(SRC_COULEUR).getBestCmap()
    cmap_nb = TTFont(SRC_NB).getBestCmap()
    base = TTFont(os.path.join(RACINE, 'ui', 'theme', 'fonts', 'Baloo2-SemiBold.ttf')).getBestCmap()
    sym = TTFont(os.path.join(RACINE, 'ui', 'theme', 'fonts', 'NotoSansSymbols2.ttf')).getBestCmap()
    couleur = {u for u in utilises if u in cmap_c and u not in TOUJOURS_NB and u not in base}
    nb = {u for u in utilises if u not in couleur and u in cmap_nb and u not in base}
    nb |= TOUJOURS_NB
    manquants = sorted(u for u in utilises if u not in couleur and u not in nb and u not in base and u not in sym)
    print('Symboles/emoji utilises : %d  -> couleur : %d, noir et blanc : %d' % (len(utilises), len(couleur), len(nb)))
    print('Noir et blanc : ' + ' '.join(chr(u) for u in sorted(nb)))
    if manquants:
        print('INTROUVABLES dans les polices (s\'afficheraient en carre vide) : ' + ' '.join(chr(u) for u in manquants))
    if verifier:
        return
    for src, out, codes in ((SRC_COULEUR, OUT_COULEUR, couleur), (SRC_NB, OUT_NB, nb)):
        opts = subset.Options()
        opts.layout_features = ['*']      # drapeaux et emoji composes (ZWJ) = ligatures
        opts.name_IDs = ['*']
        opts.notdef_outline = True
        opts.glyph_names = False
        opts.drop_tables += ['FFTM']
        police = TTFont(src)
        s = subset.Subsetter(opts)
        s.populate(unicodes=sorted((codes | LIAISONS) & set(police.getBestCmap())))
        s.subset(police)
        police.save(out)
        print('%s : %d glyphes, %d Ko' % (os.path.relpath(out, RACINE), len(police.getGlyphOrder()), os.path.getsize(out) // 1024))

main()
