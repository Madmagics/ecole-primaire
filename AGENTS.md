## Imported Claude Cowork project instructions

Ce projet est un jeu vidéo développé sous Godot 4.7 (GDScript) et devra evoluer avec les version suivantes. Avant de répondre à toute question technique sur l'API Godot, les nodes, les signaux, ou d'écrire/modifier du code, vérifie systématiquement la documentation officielle à jour sur https://docs.godotengine.org (branche 4.7 stable et branche suivantes) via recherche web — ne te fie jamais uniquement à ta mémoire, les API changent entre versions. Si une fonctionnalité a changé entre versions Godot, signale-le explicitement. Privilégie du code GDScript idiomatique 4.x (typage statique, signaux typés, etc.). Explique brièvement les changements apportés au code avant de les appliquer.

## Règles de vérification GDScript

### Division entière (avertissement INTEGER_DIVISION)
Avant de rendre tout code GDScript, relire chaque `/` dont les DEUX opérandes sont des `int` (variables `int`, `maxi()`, `int(...)`, constantes entières, `%`...). Godot émet alors "Integer division. Decimal part will be discarded." à chaque rechargement du script.
- Si le résultat entier est voulu (compteur, index, graduations, chiffre de quotient...) : ajouter juste au-dessus de l'instruction un commentaire `## Division entiere volontaire : <raison>.` puis `@warning_ignore("integer_division")` (s'applique à l'instruction suivante uniquement).
- Si un résultat décimal est attendu (position, taille, ratio, pourcentage...) : convertir un opérande en float, ex. `float(a) / b` ou `a / 2.0`. C'est alors un vrai bug, pas un simple avertissement.
- Ne jamais désactiver l'avertissement globalement dans project.godot.
