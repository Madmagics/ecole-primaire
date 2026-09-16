# TODO — Modifications d'interface à appliquer

Noté le 2026-09-15 (mis à jour le 2026-09-15), à appliquer lors d'une prochaine session. Cette liste est indépendante du chantier "création de compte en ligne" en cours (voir schema.sql / server_api.gd / save_manager.gd / welcome_panel).

## Mods interface

1. **Page de connexion** : ajouter un lien/bouton "mot de passe oublié".
2. **Contrôle parental** : ajouter une option "réinitialiser la progression" (déplacée depuis l'onglet Sauvegarde, cf. point 9).
3. **Profil** : l'enfant ne doit pas pouvoir modifier son profil — affiché grisé/lecture seule, à titre informatif uniquement, avec réaffichage de la limitation quotidienne si elle est utilisée.
4. **Profil** : supprimer "classe" (jugé sans utilité réelle).
5. **Création de compte** : rendre le contrôle parental systématique (obligatoire), plus optionnel.
6. **Onglet Contrôle parental** : ajouter la modification des infos personnelles (login/email/etc.) à cet onglet, en plus de son contenu actuel (case + mot de passe parental) — c'est aux parents de gérer ça, pas à l'enfant.
7. **Onglet Contrôle parental** : ajouter la possibilité de changer le mot de passe du compte.
8. **Onglet Contrôle parental** : ajouter la possibilité de supprimer le compte.
9. **Onglet Sauvegarde** : à supprimer entièrement — le jeu est sauvegardé en ligne, la réinitialisation est déplacée vers Contrôle parental (point 2), et le bouton "Charger" n'est de toute façon pas câblé.

## Bugs à corriger

- **Scroll tactile impossible** : sur smartphone/tablette, attraper la barre de défilement au doigt est quasi impossible. Ajouter le scroll au doigt (drag) depuis n'importe quel point de l'écran dès qu'une barre de défilement est présente, pas seulement en touchant la barre elle-même.
- **Accès au jeu possible avant confirmation d'email** : actuellement, `create_account_online()` attend bien la confirmation SERVEUR (captcha/insertion en base) avant de créer le compte, mais après la création rien ne bloque l'entrée dans le jeu si l'email n'a pas encore été confirmé via le lien reçu. Décision (2026-09-15) : **blocage dur immédiat** — le joueur ne doit pas pouvoir entrer dans le jeu tant que l'email n'est pas confirmé, vérifié à chaque connexion, pas seulement à la création.
  - À la création du compte : au lieu d'entrer dans le jeu, afficher un écran "Vérifie ta boîte mail" (avec bouton "renvoyer l'email" → `ServerApi.renvoyer_verification()`, déjà écrit côté serveur mais jamais câblé côté UI, et un bouton "j'ai confirmé, vérifier à nouveau").
  - À chaque connexion (pas seulement à la création) : interroger le serveur pour l'état réel de `email_verifie` (le client ne peut pas le savoir seul, la confirmation se fait en cliquant le lien sur `verifier-email.html`, hors du jeu) — nécessite une nouvelle fonction RPC còté serveur (ex: `fn_statut_email(p_id)` ou équivalent) si elle n'existe pas déjà, pour rafraîchir le statut local avant d'autoriser l'entrée en jeu.
  - Point à trancher demain : que faire si le joueur est hors ligne et que l'email n'a jamais été confirmé (impossible de vérifier auprès du serveur) ? Probable réponse : bloquer aussi dans ce cas puisque le blocage choisi est "dur immédiat", mais à confirmer.
