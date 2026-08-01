# Projet annexe — pistes explorées, non prioritaires

Ce document sert de mémoire pour des idées explorées en discussion mais **volontairement mises de
côté** tant que les chantiers en cours (cartes, pipeline ComfyUI) ne sont pas terminés. À reprendre
plus tard, une par une, quand Steve le demande.

## Modèle 3D des pets ("invocation" depuis une carte)

Objectif à terme : pouvoir "invoquer" en 3D un pet possédé depuis sa carte, dans Godot. Discuté le
2026-07-26, deux pistes envisagées.

### Option A — Génération IA image-vers-3D (ComfyUI)

Des nodes ComfyUI dédiés existent pour ça : **Hunyuan3D** ("Image to Model", node
`TencentImageToModelNode` + `SaveGLB`), **Microsoft TRELLIS 2** (4 milliards de paramètres, haute
fidélité), ou le pack **Pixal3D-ComfyUI** (combine Pixal3D/Trellis/Direct3D-S2). Tous exportent en
**GLB**, importable nativement dans Godot 4.x (glTF 2.0).

Limites réelles identifiées :
- Reconstruction à partir d'une seule vue (la carte de face) → le dos/les côtés sont **hallucinés**,
  résultat imprévisible une fois qu'on tourne autour du modèle.
- Textures générées en **PBR réaliste** (rugosité/métallique) alors que toute la charte graphique
  du jeu est en aplat/cartoon sans dégradé — risque de rendu incohérent avec le reste du jeu, sauf
  à repasser dessus (shader toon Godot, ou retexturer à la main).
- Maillage brut généralement dense, pas optimisé jeu → passage Blender (décimation/retopologie)
  nécessaire avant intégration, pas un pipeline automatique de bout en bout.
- Modèles lourds en VRAM (TRELLIS 2 notamment) — à surveiller sur la RTX 3080 10 Go de Steve, déjà
  tendue avec SDXL+ControlNet ([[project_card_art_spec]]).

### Option B — Squelette générique + projection de texture 2D (recommandée)

Idée : puisque tous les pets partagent la même silhouette de base (grosse tête, petit corps, gros
yeux — le design chibi établi dans `CHARTE_GRAPHIQUE.md`), pas besoin de reconstruire une géométrie
différente par espèce.

1. Modéliser **une seule fois** dans Blender un mesh chibi générique (tête ronde, corps arrondi,
   moignons de pattes/queue) aux proportions de la charte graphique, avec un bon UV unwrap (gros de
   l'espace texture donné à la vue de face).
2. Le rigger avec un **Skeleton3D** basique (tête, corps, queue/pattes) — réutilisable tel quel pour
   toutes les espèces.
3. Pour chaque espèce/variante : projeter directement l'art de carte 2D déjà généré (le WebP
   512×612 transparent, cf. [[project_card_art_spec]]) sur la face avant du mesh via "Project from
   View" dans Blender. UVs fixes et partagées → scriptable en Python/bpy pour traiter les 23
   espèces × variantes en lot ([[project_species_variant_names]]), sans reprojection manuelle à
   chaque fois.
4. Dos/côtés (rarement vus) : aplat de la couleur dominante ou copie miroir simplifiée de la face
   avant — pas besoin de détail, ce n'est pas un mode d'inspection à 360°.
5. Export glTF/GLB → import Godot → matériau **unlit/flat** (pas de PBR) pour rester cohérent avec
   le "pas de dégradé, pas de flou" du reste du jeu.

Avantage sur l'option A : cohérence de style garantie (c'est littéralement l'art 2D déjà validé, pas
une réinterprétation IA), pas de PBR qui jure, coût qui reste faible même à 23 espèces (le plus gros
du travail — mesh + rig + script de projection — ne se fait qu'une fois). Contrepartie : plus
d'investissement manuel initial de modélisation qu'un simple clic sur un node ComfyUI.

**Statut : en pause.** Ne pas commencer avant que Steve referme les chantiers cartes/ComfyUI en
cours. Reproposer ce document quand il signale que ces tâches sont terminées.
