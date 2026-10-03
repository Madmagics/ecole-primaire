# Extraction du "mot essentiel" des phrases-cadres anglaises (AUDITS_LOG #35, 2026-10-03).
import re
N = r"(?:un|une|deux|trois|quatre|cinq|six|sept|huit|neuf|dix|onze|douze|treize|quatorze|quinze|seize|dix-sept|dix-huit|dix-neuf|vingt|\d+)"
NE = r"(?:a|an|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|\d+)"
ART = r"(?:les |le |la |l')?"
FAMILLES = [
    # (cle, regex francais, regex anglais) : le groupe nomme "w" est le mot essentiel
    ('jai_n', rf"^j'ai (?P<n>{N}) (?P<w>.+)$", rf"^I have (?P<n>{NE}) (?P<w>.+)$"),
    ('animal', r"^j'ai un animal, c'est (?P<w>une? .+)$", r"^I've got a pet, it's (?P<w>an? .+)$"),
    ('je_vois', rf"^je vois (?P<n>{N}) (?P<w>.+)$", rf"^I see (?P<n>{NE}) (?P<w>.+)$"),
    ('il_y_a', rf"^(?:(?:à droite|à gauche|en haut|en bas|au milieu), )?il y a (?P<n>{N}) (?P<w>.+)$",
               rf"^(?:(?:On the right|On the left|At the top|At the bottom|In the middle), )?[Tt]here (?:is|are) (?P<n>{NE}) (?P<w>.+)$"),
    ('jaime', r"^j'aime (?P<w>.+)$", r"^I like (?P<w>.+)$"),
    ('jaime_pas', r"^je n'aime pas (?P<w>.+)$", r"^I don't like (?P<w>.+)$"),
    ('prefere', r"^je préfère (?P<w>.+)$", r"^I prefer (?P<w>.+)$"),
    ('elle_aime', r"^elle aime (?P<w>.+)$", r"^She likes (?P<w>.+)$"),
    ('couleur', rf"^[Mm]a couleur préférée est {ART}(?P<w>.+)$", r"^My favourite colour is (?P<w>.+)$"),
    ('passe_temps', r"^[Mm]on passe-temps est (?:de )?(?P<w>.+)$", r"^My hobby is (?P<w>.+)$"),
    ('sport', r"^[Mm]on sport préféré est (?P<w>.+)$", r"^My favourite sport is (?P<w>.+)$"),
    ('lundi', r"^le lundi, nous avons (?P<w>.+)$", r"^On Mondays we have (?P<w>.+)$"),
]


def noyau(fr, en):
    """(famille, mot_fr, mot_en) si la paire est une phrase-cadre, sinon None."""
    for cle, rf_, re_ in FAMILLES:
        a, b = re.match(rf_, fr), re.match(re_, en)
        if a and b:
            wf, we = a.group('w').strip(), b.group('w').strip()
            if 'n' in a.groupdict():
                nf, ne = a.group('n'), b.group('n')
                if nf in ('un', 'une'):
                    wf = nf + ' ' + wf
                    we = ('an ' if we[0] in 'aeiou' else 'a ') + we
                else:
                    wf = 'des ' + wf
            if cle == 'couleur':
                wf = re.sub(r"^(le|la|l')\s?", '', wf)
            if cle == 'animal':
                we = re.sub(r'^a ([aeiou])', r'an \1', we)
            return cle, wf, we
    return None
