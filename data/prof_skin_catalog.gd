## Catalogue des skins de "prof" achetables en boutique (voir autoload/prof_skins.gd pour l'etat
## possede/actif par compte, et ui/shop/prof_skin_item.gd pour la case d'achat). 10 skins par
## classe, deja presents sur le disque (assets/classe2.0/profs/prof<N>.<index>.webp, N = 1 pour
## CP ... 5 pour CM2, index 0-9) - le skin <N>.0 est celui deja porte par chaque enseignant depuis
## la mise en place de ProfVisual (voir school.tscn), reste gratuit et debloque par defaut pour
## tout compte (voir ProfSkins.reset()).
##
## Classe utilitaire statique sans etat, meme principe que GradeLevel - la correspondance grade ->
## fichier est une simple formule plutot qu'un dictionnaire de 50 entrees a maintenir a la main
## (retour utilisateur : "prefere du code leger"). (2026-08-30 : la comparaison se faisait a
## l'origine avec PlayerAvatars, classe retiree depuis avec tout le systeme d'avatar joueur - voir
## welcome_panel.gd.)
class_name ProfSkinCatalog
extends RefCounted

const SKINS_PER_GRADE := 10
const _PATH_FORMAT := "res://assets/classe2.0/profs/prof%d.%d.webp"

## [skin_index] attendu dans [0, SKINS_PER_GRADE[ - pas de validation ici (voir les appelants,
## ProfSkins/ProfSkinItem, qui bornent deja leurs boucles sur SKINS_PER_GRADE).
static func get_texture_path(grade: GradeLevel.Grade, skin_index: int) -> String:
	return _PATH_FORMAT % [int(grade) + 1, skin_index]

static func get_texture(grade: GradeLevel.Grade, skin_index: int) -> Texture2D:
	return load(get_texture_path(grade, skin_index)) as Texture2D
