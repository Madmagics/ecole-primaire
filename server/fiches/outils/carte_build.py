# Genere ui/fiche/carte_data.gd pour le dessin [carte] des fiches Histoire-Geographie CE2 (2026-11-07).
# Usage : python3 carte_build.py ne_50m_admin_0_countries.geojson ne_50m_land.geojson carte_data.gd regions.geojson
# (regions.geojson : github.com/gregoiredavid/france-geojson, regions-version-simplifiee, licence ouverte)
# Source des contours : Natural Earth 1:50m (domaine public). Les zones historiques (empire romain,
# Gaule, domaine royal) et les massifs sont des polygones dessines a la main, volontairement
# simplifies pour des enfants de CE2, puis decoupes sur les terres emergees.
import json
import sys
from shapely.geometry import shape, box, Polygon, MultiPolygon
from shapely.ops import unary_union

VUES = {
    'france': (-5.4, 41.2, 10.0, 52.2),
    'empire': (-11.0, 23.0, 50.0, 57.0),
    'europe': (-11.0, 34.5, 33.0, 68.0),
}
# ---- CM1-CM2 (2026-11-07)
UE = ['Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark', 'Estonia', 'Finland', 'Aland',
      'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta',
      'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden']
FONDATEURS = ['France', 'Germany', 'Italy', 'Belgium', 'Netherlands', 'Luxembourg']
# noms des pays sur la carte de l'UE : [nom, lon, lat, fondateur]
PAYS_NOMS = [['France', 2.4, 46.8, True], ['Allemagne', 10.2, 51.0, True], ['Italie', 12.6, 42.9, True],
             ['Belgique', 1.0, 50.9, True], ['Pays-Bas', 5.6, 53.3, True], ['Luxembourg', 6.3, 49.0, True],
             ['Espagne', -3.7, 40.2, False], ['Portugal', -8.0, 38.6, False], ['Pologne', 19.3, 52.1, False],
             ['Suède', 15.5, 62.0, False], ['Grèce', 22.0, 39.5, False], ['Irlande', -8.0, 53.2, False],
             ['Roumanie', 25.0, 45.8, False], ['Finlande', 26.5, 63.5, False]]
# Ligne de front a l'Ouest (1915-1917, simplifiee) : de la mer du Nord a la Suisse
FRONT_1418 = [2.75, 51.13, 2.88, 50.85, 2.78, 50.29, 2.65, 50.0, 3.0, 49.58, 3.32, 49.38, 4.03, 49.25, 4.9, 49.15,
              5.38, 49.16, 5.54, 48.9, 6.06, 48.9, 6.7, 48.6, 7.1, 48.3, 7.15, 47.5]
# Zone occupee en juin 1940 (au nord et a l'ouest de la ligne de demarcation, simplifiee)
LIGNE_DEMARCATION = [-1.24, 43.16, -0.5, 43.9, -0.25, 44.55, 0.16, 45.65, 0.6, 46.6, 1.2, 47.0, 2.07, 47.22,
                     2.6, 46.95, 3.33, 46.57, 4.2, 46.7, 4.85, 46.78, 5.5, 47.1, 6.0, 46.4]
ZONE_OCCUPEE = [(LIGNE_DEMARCATION + [9.0, 46.4, 9.0, 52.0, -6.0, 52.0, -6.0, 43.0])[i:i + 2] for i in range(0, len(LIGNE_DEMARCATION) + 8, 2)]
# Lignes a grande vitesse (TGV), simplifiees, passant par les grandes villes
TGV = [[2.35, 48.86, 4.83, 46.3, 4.84, 45.76, 4.89, 44.93, 4.8, 43.95, 5.37, 43.3],
       [2.35, 48.86, 2.8, 49.9, 3.06, 50.63],
       [2.35, 48.86, 0.69, 47.39, 0.33, 46.58, -0.57, 44.84],
       [2.35, 48.86, 0.2, 48.0, -1.68, 48.11],
       [2.35, 48.86, 4.03, 49.25, 6.18, 49.12, 7.75, 48.58],
       [4.84, 45.76, 5.04, 47.32, 6.02, 47.24, 7.34, 47.75],
       [-0.57, 44.84, 1.44, 43.6, 3.88, 43.61, 4.8, 43.95]]
# Capitales des 13 Regions de France metropolitaine : [ville, lon, lat, nom a gauche]
CAPITALES = [['Paris', 2.35, 48.86, False], ['Lille', 3.06, 50.63, False], ['Rouen', 1.09, 49.44, True],
             ['Rennes', -1.68, 48.11, False], ['Nantes', -1.55, 47.21, True], ['Orléans', 1.91, 47.9, False],
             ['Strasbourg', 7.75, 48.58, True], ['Dijon', 5.04, 47.32, False], ['Lyon', 4.84, 45.76, True],
             ['Bordeaux', -0.57, 44.84, True], ['Toulouse', 1.44, 43.6, True], ['Marseille', 5.37, 43.3, True],
             ['Ajaccio', 8.74, 41.93, True]]
# Lacs : [nom, lon, lat, nom a gauche]
LACS = [['lac Léman', 6.55, 46.42, False], ['lac du Bourget', 5.86, 45.73, True],
        ['Serre-Ponçon', 6.35, 44.53, True]]



def pts(flat):
    return [(flat[i], flat[i + 1]) for i in range(0, len(flat), 2)]


# ---- zones dessinees a la main (lon, lat)
EMPIRE = pts([-10, 36, -10, 44, -6.5, 50.5, -6.5, 55, -1.5, 55.2, 2.5, 53, 4.5, 52.3, 6.1, 51.85, 7.6, 50.4,
              8.8, 50.4, 9.6, 49.5, 9.8, 48.9, 12.1, 49.0, 13.5, 48.5, 16.4, 48.2, 18.8, 47.9, 19.0, 47.5,
              18.9, 45.9, 20.3, 45.0, 21.0, 46.3, 22.5, 47.6, 24.5, 47.7, 26.2, 47.0, 26.3, 45.8, 25.8, 45.2,
              27.5, 44.2, 28.7, 45.3, 30.0, 45.3, 32.0, 42.5, 41.5, 41.6, 43.5, 41.1, 45.5, 40.0, 45.8, 38.5,
              44.5, 37.0, 45.5, 34.5, 48.2, 30.2, 47.5, 29.0, 43.0, 30.5, 39.5, 31.0, 38.5, 29.5, 37.0, 27.0,
              38.0, 26.0, 37.2, 25.0, 34.0, 25.0, 33.0, 23.5, 31.0, 23.5, 28.0, 27.0, 25.0, 29.5, 20.0, 29.5,
              15.5, 30.5, 12.0, 30.5, 10.0, 31.5, 8.0, 33.0, 6.0, 34.3, 2.0, 34.6, -1.0, 34.4, -5.0, 34.0,
              -7.5, 33.5])
GAULE = pts([-6, 48, -2, 51, 4.1, 52.0, 6.1, 51.85, 6.96, 50.94, 7.6, 50.36, 8.27, 50.0, 8.3, 49.0, 7.6, 47.56,
             9.0, 47.6, 8.0, 46.3, 7.0, 45.3, 7.7, 44.0, 7.6, 43.6, 3.2, 42.4, -1.8, 43.4, -6, 44])
# Domaine royal : 987 (Hugues Capet), 1223 (mort de Philippe Auguste), 1483 (mort de Louis XI)
DOMAINES = {
    '987': [pts([2.5, 49.3, 3.0, 49.1, 2.9, 48.6, 2.6, 48.2, 2.4, 47.8, 1.7, 47.75, 1.5, 48.0, 1.7, 48.5,
                 1.9, 48.9, 2.2, 49.25])],
    '1223': [pts([1.6, 50.3, 2.0, 50.6, 2.9, 50.5, 3.3, 49.9, 3.4, 49.3, 3.2, 48.6, 2.9, 48.0, 2.9, 47.4,
                  2.8, 46.9, 2.4, 46.8, 1.8, 46.9, 1.0, 47.0, 0.0, 46.9, -0.8, 47.1, -1.2, 47.5, -1.2, 47.9,
                  -1.5, 48.4, -1.6, 48.65, -2.2, 49.7, -1.3, 49.9, 0.1, 49.6, 1.4, 50.1]),
             pts([2.6, 46.0, 3.6, 46.1, 3.7, 45.3, 2.8, 45.1, 2.4, 45.5])],
    '1483': [pts([-1.1, 50.5, 2.6, 51.2, 4.2, 50.2, 4.9, 49.8, 5.1, 49.3, 5.4, 48.6, 5.6, 47.9, 5.4, 47.3,
                  5.2, 46.5, 5.8, 45.8, 6.2, 45.45, 7.2, 45.15, 7.2, 44.3, 6.9, 44.1, 7.25, 43.65, 7.5, 42.0,
                  3.5, 41.5, -2.0, 42.8, -3.0, 43.5, -3.0, 46.9, -1.6, 46.95, -1.2, 47.4, -1.0, 48.0, -1.3, 48.6,
                  -1.6, 48.7, -2.5, 50.5])],
}
# Massifs montagneux francais (programme CE2), [nom, polygone, position du nom]
MASSIFS = [
    ['Alpes', pts([5.7, 46.3, 6.8, 46.4, 7.1, 45.9, 7.2, 45.2, 7.0, 44.7, 7.6, 44.1, 7.4, 43.8, 6.6, 43.9,
                   5.9, 44.2, 5.4, 44.6, 5.5, 45.2, 5.8, 45.6]), (6.45, 45.0)],
    ['Pyrénées', pts([-1.8, 43.3, -0.5, 43.0, 0.6, 42.95, 1.5, 42.75, 2.3, 42.6, 3.1, 42.45, 3.0, 42.3,
                      1.0, 42.4, -0.5, 42.7, -1.7, 43.0]), (0.6, 42.55)],
    ['Massif central', pts([2.0, 46.0, 3.2, 46.2, 4.4, 45.9, 4.7, 45.3, 4.5, 44.5, 4.1, 44.0, 3.4, 43.6,
                            2.6, 43.5, 2.0, 44.0, 1.5, 44.6, 1.4, 45.3, 1.6, 45.8]), (3.0, 45.0)],
    ['Jura', pts([5.5, 46.3, 6.1, 46.5, 6.6, 47.0, 7.0, 47.4, 6.8, 47.55, 6.2, 47.3, 5.6, 46.8, 5.4, 46.5]),
     (6.1, 46.85)],
    ['Vosges', pts([6.6, 48.0, 7.0, 47.75, 7.3, 47.85, 7.4, 48.3, 7.4, 48.8, 7.1, 48.85, 6.8, 48.5, 6.6, 48.2]),
     (7.0, 48.3)],
    ['Corse', pts([8.75, 42.45, 9.1, 42.5, 9.35, 42.3, 9.3, 41.9, 9.2, 41.6, 8.95, 41.7, 8.8, 42.0, 8.7, 42.2]),
     (9.05, 42.1)],
]
# Fleuves de France metropolitaine (le Maroni coule en Guyane), [nom, trace, position du nom]
FLEUVES = [
    ['Seine', [4.72, 47.49, 4.57, 47.86, 4.08, 48.3, 3.73, 48.52, 2.95, 48.38, 2.66, 48.54, 2.35, 48.85,
               1.72, 48.99, 1.09, 49.44, 0.15, 49.47], (3.4, 48.85)],
    ['Loire', [4.22, 44.84, 4.1, 45.2, 4.07, 46.04, 3.98, 46.48, 3.16, 46.99, 2.95, 47.4, 2.63, 47.69,
               1.91, 47.9, 1.33, 47.59, 0.69, 47.39, -0.08, 47.26, -0.55, 47.37, -1.55, 47.21, -2.2, 47.27],
     (0.5, 47.75)],
    ['Garonne', [0.95, 42.75, 0.72, 43.11, 1.33, 43.46, 1.44, 43.6, 1.1, 44.0, 0.62, 44.2, 0.17, 44.5,
                 -0.25, 44.55, -0.57, 44.84, -0.53, 45.04, -1.05, 45.6], (0.6, 44.6)],
    ['Rhône', [8.37, 46.58, 7.36, 46.23, 6.9, 46.4, 6.14, 46.2, 5.8, 45.95, 5.5, 45.75, 4.83, 45.76,
               4.87, 45.52, 4.89, 44.93, 4.73, 44.56, 4.8, 43.95, 4.63, 43.68, 4.85, 43.35], (4.05, 44.05)],
    ['Rhin', [9.5, 46.85, 9.5, 47.5, 8.6, 47.68, 7.59, 47.56, 7.8, 48.58, 8.3, 49.0, 8.45, 49.5, 8.27, 50.0,
              7.6, 50.36, 6.96, 50.94, 6.77, 51.23, 6.1, 51.85, 4.1, 51.95], (8.95, 49.4)],
]
# Les 5 premieres agglomerations (INSEE) : [nom, lon, lat, nom a gauche du point]
VILLES = [['Paris', 2.35, 48.86, False], ['Lyon', 4.84, 45.76, True], ['Marseille', 5.37, 43.3, True],
          ['Lille', 3.06, 50.63, False], ['Toulouse', 1.44, 43.6, True]]
# Espaces de fortes densites (simplifies) : region parisienne, Nord, Alsace, axe Lyon-Rhone,
# littoral mediterraneen, et les grandes villes de l'Ouest et du Sud-Ouest.
DENSES = [
    pts([1.5, 48.5, 1.9, 49.15, 2.6, 49.25, 3.1, 49.0, 3.0, 48.5, 2.5, 48.3, 1.9, 48.3]),
    pts([2.2, 50.4, 2.6, 50.9, 3.3, 50.9, 3.9, 50.5, 3.6, 50.2, 2.8, 50.2]),
    pts([7.2, 47.6, 7.6, 47.6, 7.9, 48.4, 8.1, 48.95, 7.6, 49.0, 7.4, 48.3]),
    pts([4.5, 45.4, 4.6, 46.0, 5.1, 46.0, 5.3, 45.6, 5.9, 45.4, 5.9, 45.0, 5.0, 44.9, 4.8, 44.5, 4.6, 44.5]),
    pts([4.4, 43.6, 4.8, 43.9, 5.5, 43.65, 6.2, 43.45, 7.0, 43.75, 7.5, 43.8, 7.4, 43.6, 6.9, 43.4,
         5.9, 43.05, 5.2, 43.25, 4.6, 43.35, 3.9, 43.45, 3.3, 43.25, 3.4, 43.55, 4.0, 43.75]),
    pts([1.1, 43.4, 1.2, 43.8, 1.75, 43.8, 1.8, 43.45]),
    pts([-0.9, 44.7, -0.8, 45.05, -0.35, 45.05, -0.3, 44.7]),
    pts([-1.9, 47.1, -1.8, 47.4, -1.3, 47.35, -1.35, 47.1]),
    pts([-1.9, 48.0, -1.85, 48.25, -1.5, 48.25, -1.5, 48.0]),
]


def rings(geom, tol):
    geom = geom.simplify(tol, preserve_topology=True)
    out = []
    for g in (geom.geoms if hasattr(geom, 'geoms') else [geom]):
        if g.geom_type != 'Polygon' or g.area < tol * tol * 4:
            continue
        out.append([round(v, 2) for xy in g.exterior.coords[:-1] for v in xy])
    return out


def gd(v):
    if isinstance(v, dict):
        return '{\n' + ''.join(f'\t"{k}": {gd(x)},\n' for k, x in v.items()) + '}'
    if isinstance(v, (list, tuple)):
        return '[' + ', '.join(gd(x) for x in v) + ']'
    if isinstance(v, bool):
        return 'true' if v else 'false'
    if isinstance(v, str):
        return '"' + v + '"'
    return repr(v)


def main():
    pays = json.load(open(sys.argv[1]))
    regions = json.load(open(sys.argv[4]))
    land = unary_union([shape(f['geometry']) for f in json.load(open(sys.argv[2]))['features']]).buffer(0)
    france = None
    for f in pays['features']:
        if f['properties']['ADMIN'] == 'France':
            g = shape(f['geometry'])
            france = unary_union([p for p in g.geoms if p.centroid.x > -10 and p.centroid.y > 40])
    vf = box(*VUES['france'])
    ve = box(*VUES['empire'])
    terre_f = land.intersection(vf)
    terre_e = land.intersection(ve)
    veu = box(*VUES['europe'])
    terre_eu = land.intersection(veu)
    ue = [unary_union([shape(f['geometry']) for f in pays['features'] if f['properties']['ADMIN'] == n]).intersection(veu)
          for n in UE]
    fond = [unary_union([shape(f['geometry']) for f in pays['features'] if f['properties']['ADMIN'] == n]).intersection(veu)
            for n in FONDATEURS]
    data = {
        'VUES': {k: list(v) for k, v in VUES.items()},
        'TERRE_FRANCE': rings(terre_f, 0.03),
        'FRANCE': rings(france, 0.03),
        'TERRE_EMPIRE': rings(terre_e, 0.12),
        'EMPIRE': rings(Polygon(EMPIRE).intersection(terre_e), 0.12),
        'GAULE': rings(Polygon(GAULE).intersection(terre_e), 0.12),
        'DOMAINES': {k: rings(unary_union([Polygon(p) for p in v]).intersection(france), 0.03)
                     for k, v in DOMAINES.items()},
        'MASSIFS': [[n, rings(Polygon(p).intersection(france), 0.02), list(c)] for n, p, c in MASSIFS],
        'FLEUVES': [[n, t, list(c)] for n, t, c in FLEUVES],
        'VILLES': VILLES,
        'DENSES': [rings(Polygon(p).intersection(france), 0.02) for p in DENSES],
        'TERRE_EUROPE': rings(terre_eu, 0.08),
        'UE': rings(unary_union(ue), 0.08),
        'FONDATEURS': rings(unary_union(fond), 0.08),
        'PAYS_NOMS': PAYS_NOMS,
        'FRONT_1418': FRONT_1418,
        'LIGNE_DEMARCATION': LIGNE_DEMARCATION,
        'ZONE_OCCUPEE': rings(Polygon(ZONE_OCCUPEE).intersection(france), 0.03),
        'TGV': TGV,
        'REGIONS': [rings(shape(f['geometry']).buffer(0).intersection(france.buffer(0.02)), 0.02)
                    for f in regions['features']],
        'CAPITALES': CAPITALES,
        'LACS': LACS,
    }
    lines = ['## Donnees du dessin [carte] des fiches de cours Histoire-Geographie CE2 (2026-11-07).',
             '## GENERE par server/fiches/outils/carte_build.py (contours Natural Earth 1:50m, domaine public ;',
             '## empire romain, Gaule, domaine royal, massifs, fortes densites dessines a la main et simplifies).',
             '## Anneaux = [lon, lat, lon, lat, ...] en degres. Ne pas modifier a la main.', '']
    for k, v in data.items():
        lines.append(f'const {k} := {gd(v)}')
        lines.append('')
    open(sys.argv[3], 'w', encoding='utf-8').write('\n'.join(lines))
    print({k: (len(v) if hasattr(v, '__len__') else v) for k, v in data.items()})


if __name__ == '__main__':
    main()
