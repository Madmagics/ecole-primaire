# Décor école à la campagne — assets à générer avec ComfyUI

Objectif : remplacer le panorama ChatGPT (composition figée, damier au lieu de vraie transparence,
neige perdue) par des assets générés via ComfyUI, recomposés ensuite dans `park_2d.tscn`.

## Deux pipelines (important, ne pas mélanger les styles)

Constat du 2026-08-08 : demander à un modèle "Studio Ghibli style" de peindre un objet isolé sur
fond uni échoue souvent — le style est indissociable d'une composition "paysage complet" dans les
données d'entraînement, surtout si le prompt contient "background art". On sépare donc en deux
pipelines avec deux styles différents.

- **Pipeline A — Bandeaux de fond** (Calque 5 Ciel, Calque 4 Campagne lointaine, Calque 3 Campagne
  environnante) : une seule image peinte, pleine, en style Ghibli. **Pas de détourage** : ce sont
  des fonds opaques qui remplacent directement le PNG/WebP actuel du calque
  (`assets/backgrounds/park_2d/*.png`). Pipeline : `VAE Decode → Upscale Image → Save Image`, pas
  besoin du groupe RMBG.
- **Pipeline B — Éléments isolés à disperser** (Calque 2 Monde physique, Calque 1 Premier plan,
  plus les mascottes soleil/école/personnages) : chaque élément généré seul sur fond vert, détouré
  via RMBG, placé comme `Sprite2D` indépendant dans `assets/decor_2d/<element>/` (voir
  `park_2d.tscn`). Deux sous-styles selon la nature de l'élément :
  - **B1 — Icône/mascotte** (soleil, école, futurs personnages) : le style "flat kawaii" d'origine,
    visages et proportions chibi assumés, c'est voulu pour ces assets-là.
  - **B2 — Nature isolée** (arbres, buissons, fleurs, rochers, clôtures) : style peint façon Ghibli
    mais SANS "background art" et SANS "chibi kawaii" dans le prompt (voir plus bas pourquoi), pour
    éviter à la fois le paysage complet et l'effet "minion" sur un objet inanimé.

## Réglages communs aux deux pipelines

- **Fond de génération** : blanc ou vert pur (`#00FF00`) pour le pipeline B, peu importe pour le
  pipeline A puisqu'il n'y a pas de détourage. Jamais "transparent"/"damier" dans le prompt.
- **RMBG (pipeline B uniquement)** : nœud `Remove Background (RMBG)` (comfyui-rmbg, modèle
  `RMBG-2.0`) juste après `VAE Decode`, sortie `IMAGE` → `Save Image`. Background sur `Alpha` pour
  le rendu final. Sensitivity 1.0, Mask Blur 1, Mask Offset -1, **Refine Foreground: true** (un
  bord légèrement doux est normal et cohérent avec un style peint, ce n'est plus un défaut à
  corriger comme avec l'ancien style flat).
- **Sampler validé (les deux pipelines)** : `dpmpp_2m_sde` + scheduler `karras`,
  `control_after_generate: randomize` pour varier les seeds. CFG **7-7.5** pour les deux styles
  peints (A et B2) ; CFG **6.5-7** pour le style icône/mascotte B1 (plus de CFG = plus de détail,
  contraire à l'effet "simple" recherché sur les icônes).

### Style A — Bandeaux de fond peints (Ciel / Campagne lointaine / Campagne environnante)

⚠️ **Composition latérale obligatoire** (2026-08-08) : le jeu est un side-scroller, la caméra se
déplace horizontalement, jamais vers l'horizon. Un mot comme "path"/"trail" dans le prompt pousse
le modèle vers une composition classique de paysage peint (chemin qui s'enfonce vers un point de
fuite), inutilisable ici — un joueur qui avance latéralement ne "rentre" jamais dans l'image.
Ajouter systématiquement au positif : `flat side-scrolling game background, horizontal
composition, consistent depth throughout, no vanishing point`. Ajouter systématiquement au
négatif : `path leading into distance, road receding into horizon, one-point perspective,
vanishing point, winding trail, diagonal path, aerial view, top-down view, bird's eye view`.

Prompt à adapter par calque (exemples ci-dessous), négatif commun :

`photo, realistic 3d render, blurry, watermark, text, signature, people, characters, animals,
sticker, white border, die cut, vignette, frame border, portrait, extreme closeup, path leading
into distance, road receding into horizon, one-point perspective, vanishing point, winding trail,
diagonal path, aerial view, top-down view, bird's eye view`

Résolution : `Empty Latent Image` en **1344×768** (bucket natif SDXL, proche du ratio écran du jeu)
plutôt que 1024×1024 carré. Sur `Upscale Image`, ne pas descendre à 512 (ça c'est pour les icônes
du pipeline B) : remonter plutôt vers **1536-1920 de large**, ces images sont étirées en
`stretch_mode = 6` (Keep Aspect Covered) sur toute la largeur du calque.

### Style B1 — Icône/mascotte (soleil, école, personnages)

Positif : `flat 2D kawaii illustration, cute icon style, simple shapes, bold clean outline, flat
solid colors, minimal shading, no gradient, cute chibi style, centered, plain background`

Négatif : `photo, realistic, 3d render, blurry, watermark, text, signature, cropped, extra limbs,
multiple objects, collage, grid, checkerboard, creature, mascot, standing character, ground, rocks,
terrain, scene, environment, detailed, intricate, complex shading, gradient, realistic lighting,
textured, ornate, elaborate, highly detailed, hyper detailed, painterly, soft shading, 3d shading,
glossy, white outline, sticker border, die cut, white border, outlined edge`

⚠️ **Ne jamais mettre "sticker"** dans le prompt : le modèle peint une vraie bordure blanche de
découpe (comme un autocollant physique), ce n'est pas un artefact RMBG, aucun réglage de sampler ne
corrige ça, seul le prompt le peut. Ne pas confondre avec `bold clean outline` : ça c'est le
contour encre normal du dessin, à garder.

### Style B2 — Nature isolée (arbres, buissons, fleurs, rochers, clôtures)

Positif : `Ghibli-inspired painterly illustration, single [tree/bush/rock] study, soft brushwork,
warm natural colors, delicate clean outline, isolated object on plain background, studio icon
composition, no scenery`

Négatif : `photo, realistic 3d render, blurry, watermark, text, signature, multiple objects,
collage, grid, checkerboard, scene, environment, background art, landscape, horizon, ground plane,
sky, cluttered composition, sticker, white outline, sticker border, die cut, white border, outlined
edge, face, eyes, smiling, cute character, mascot, anthropomorphic object, extra limbs`

Deux points qui contrent spécifiquement les ratés observés : pas de "hand-painted background art"
(c'est ce qui invite le paysage complet), et `face, eyes, smiling, cute character, mascot,
anthropomorphic object` en négatif (c'est ce qui a donné un visage au soleil — un objet nature n'a
pas de visage).

- Génère **2-3 seeds par élément répétable** (arbre, buisson, fleur, rocher) pour varier
  l'apparence quand je les disperse plusieurs fois — évite l'effet "copié-collé".
- Repères de résolution par complexité (pipeline B) :

| Type d'élément | Résolution |
|---|---|
| Simple (fleur, caillou, touffe d'herbe, panneau vide) | 512×512 |
| Moyen (arbre, buisson, moulin, segment de clôture, ferme) | 768×768 |
| École (asset hero, le plus détaillé) | 1024×1024 ou 1024×1280 |

## Calque 5 — Ciel (Pipeline A, un seul bandeau)

`Studio Ghibli style anime background art, hand-painted sky, soft painterly brushwork, warm sunset
light, fluffy clouds, gentle color gradient, wide panoramic landscape, no foreground objects`

Le soleil reste un élément à part (Pipeline B1, mascotte), déjà en place dans `ParallaxSky` en
`Sprite2D` indépendant, superposé au bandeau.

## Calque 4 — Campagne lointaine (Pipeline A, un seul bandeau)

`Studio Ghibli style anime background art, hand-painted distant countryside landscape, rolling
hills and distant mountains with soft atmospheric haze, warm natural light, wide panoramic
composition, painterly brushwork`

## Calque 3 — Campagne environnante (Pipeline A, un seul bandeau)

`Studio Ghibli style anime background art, hand-painted countryside landscape, flat side-scrolling
game background, lush green fields, scattered trees and hedges spread left to right, horizontal
composition, consistent depth throughout, no vanishing point, warm natural lighting, painterly
brushwork`

Le "small dirt path" de la version précédente est retiré du prompt : c'est lui qui provoquait la
fuite en profondeur (chemin qui s'enfonce vers l'horizon). Si tu veux un chemin, il devra être
horizontal (longer la base de l'image de gauche à droite) — je peux tester `a straight horizontal
dirt path along the bottom edge, running left to right` si tu en as besoin, mais ce n'est pas
indispensable.

(ajouter `no buildings` en négatif si l'école apparaît dedans par erreur — elle est gérée à part,
Calque 2)

## Calque 2 — Monde physique (Pipeline B, éléments isolés)

| Élément | Style | Prompt (ajouter au style de base) | Notes |
|---|---|---|---|
| **École (bâtiment complet)** | B1 | `cute countryside school building, warm cream walls, terracotta tiled roof, round clock tower with bell, oversized chibi proportions, rounded wooden door, round windows` | Asset hero — plusieurs seeds, choisir la meilleure |
| Panneau "École" | B1 | `small wooden sign board, blank or simple plaque, cartoon style` | Texte ajouté dans Godot (Label), pas dans l'image |
| Tableau noir "Bienvenue" | B1 | `small chalkboard sign on wooden legs, cartoon style, blank surface` | idem |
| Lampadaire | B1 | `cute cartoon street lamp post, round lamp head` | 1 |
| Toboggan / jeu | B1 | `small cartoon playground slide, colorful, chibi proportions` | 1 |
| Arbre proche (grand/détaillé) | B2 | `large tree, close-up, lush foliage clusters` | 2 variantes |
| Cabane à outils | B1 | `small wooden garden shed, cartoon style, sloped roof` | 1 |

## Calque 1 — Premier plan (Pipeline B2, nature isolée)

| Élément | Prompt (ajouter au style B2) | Notes |
|---|---|---|
| Touffe d'herbe | `tall grass tuft cluster, vibrant green` | 3-4 variantes |
| Fleur | `single flower, [pink/yellow/purple/red] petals` | 1 par couleur (4 couleurs) |
| Rocher | `small rounded rock, gray shading` | 2 variantes |
| Clôture (segment) | `short wooden fence segment, weathered brown wood` | 1 segment, réutilisé |
| Champignon | `mushroom, red cap with white spots` | 1-2 |
| Papillon | `small butterfly, pastel colored wings` | 1-2 |

## Une fois généré

Envoie-moi les images (bandeaux pipeline A en PNG/WebP direct, éléments pipeline B détourés si RMBG
marche, sinon fond blanc/vert net). Je m'occupe ensuite de :
- convertir en WebP q90 et ranger dans `assets/backgrounds/park_2d/` (bandeaux) ou
  `assets/decor_2d/<element>/` (éléments isolés),
- câbler les bandeaux dans les `TextureRect` existants des `Parallax2D`,
- instancier les éléments isolés en `Sprite2D` avec variété (rotation/flip/échelle).
