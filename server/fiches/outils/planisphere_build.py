import json, sys
from shapely.geometry import shape, box, Polygon, MultiPolygon, mapping
from shapely.ops import unary_union
from shapely.validation import make_valid
d = json.load(open(sys.argv[1]))
KEYS = {'Africa': 'afrique', 'Antarctica': 'antarctique', 'Asia': 'asie', 'Europe': 'europe',
        'North America': 'amerique_nord', 'South America': 'amerique_sud', 'Oceania': 'oceanie'}
parts = {k: [] for k in KEYS.values()}
france = None
for f in d['features']:
    p = f['properties']; g = shape(f['geometry'])
    cont = p['CONTINENT']; name = p['ADMIN']
    if cont not in KEYS:
        continue
    polys = list(g.geoms) if g.geom_type == 'MultiPolygon' else [g]
    for poly in polys:
        c = poly.centroid
        k = KEYS[cont]
        if name == 'France':
            if c.x < 0 and c.y < 15:
                k = 'amerique_sud'
        if name == 'Russia':
            west = poly.intersection(box(0, -90, 60, 90)); east = poly.difference(box(0, -90, 60, 90))
            if not west.is_empty: parts['europe'].append(west)
            if not east.is_empty: parts['asie'].append(east)
            continue
        parts[k].append(poly)
    if name == 'France':
        france = [q for q in polys if q.centroid.x > -10][0].representative_point()
out = {'continents': {}, 'lacs': [], 'france': [round(france.x, 1), round(france.y, 1)]}
total = 0
for k, ps in parts.items():
    u = unary_union(ps).buffer(0).intersection(box(-180, -78, 180, 84))
    u = u.simplify(0.45, preserve_topology=True)
    geoms = list(u.geoms) if u.geom_type == 'MultiPolygon' else [u]
    rings = []
    for g in geoms:
        if g.area < 1.5:
            continue
        ext = Polygon(g.exterior).simplify(0.45, preserve_topology=True)
        if not ext.is_valid:
            ext = make_valid(ext)
            if ext.geom_type != 'Polygon':
                ext = max(ext.geoms, key=lambda q: q.area)
        def rd(poly, n):
            cs = []
            for x, y in list(poly.exterior.coords)[:-1]:
                q = (round(x, n), round(y, n))
                if not cs or cs[-1] != q:
                    cs.append(q)
            if cs[0] == cs[-1]:
                cs.pop()
            return cs
        coords = rd(ext, 1)
        if not Polygon(coords).is_valid:
            coords = rd(ext, 2)
        if not Polygon(coords).is_valid:
            fx = Polygon(coords).buffer(0)
            fx = max(fx.geoms, key=lambda q: q.area) if fx.geom_type == 'MultiPolygon' else fx
            coords = rd(fx, 2)
        assert Polygon(coords).is_valid, (k, len(coords))
        flat = [v for xy in coords for v in xy]
        rings.append(flat); total += len(coords)
        for h in g.interiors:
            hp = Polygon(h)
            if hp.area > 3:
                out['lacs'].append([round(v, 1) for xy in list(hp.exterior.coords)[:-1] for v in xy])
    out['continents'][k] = rings
    print(k, len(rings), sum(len(r)//2 for r in rings))
print('points', total, 'lacs', len(out['lacs']), 'france', out['france'])
json.dump(out, open(sys.argv[2], 'w'), separators=(',', ':'))
