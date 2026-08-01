## Detection plateforme tactile vs desktop, pour adapter l'UI de reponse aux questions
## (boutons QCM sur tactile, clavier sur desktop). Classe utilitaire statique.
class_name PlatformUtils
extends RefCounted

## true si l'appareil doit utiliser une interface tactile (boutons) plutot que le clavier.
static func is_touch_platform() -> bool:
	if OS.has_feature("android") or OS.has_feature("ios"):
		return true
	if OS.has_feature("windows") or OS.has_feature("macos") or OS.has_feature("linuxbsd"):
		# DisplayServer.is_touchscreen_available() renvoie parfois "true" a tort sur Windows
		# meme sans ecran tactile (bug connu : github.com/godotengine/godot/issues/84235).
		# On ignore donc le signal tactile sur les plateformes desktop confirmees.
		return false
	# Cas restant (web notamment) : pas de bug connu, on peut se fier au signal live.
	return DisplayServer.is_touchscreen_available()
