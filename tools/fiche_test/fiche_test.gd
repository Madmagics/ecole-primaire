## Scene de test des fiches de cours (2026-09-29) : ouvrir fiche_test.tscn dans l'editeur et
## lancer "Executer la scene actuelle" (F6). Affiche la premiere fiche publiee de TEST_GRADE /
## TEST_SUBJECT, telechargee depuis Supabase comme dans le jeu (ContentLibrary).
##
## Options en ligne de commande (apres "--"), utilisees par Claude pour verifier le rendu sans
## serveur :
##   --fiche-fichier=<chemin>  lit le texte de la fiche dans un fichier local au lieu du serveur
##   --capture=<dossier>       enregistre une image PNG de chaque page puis quitte
##   --classe=ce1              couleurs d'une autre classe que TEST_GRADE (avec --fiche-fichier)
extends Control

const TEST_GRADE := GradeLevel.Grade.CP
const TEST_SUBJECT := SubjectType.Subject.MATH

@onready var panel: FichePanel = $FichePanel
@onready var info: Label = $Info

func _ready() -> void:
	var args := _user_args()
	var fiche: Dictionary = {}
	if args.has("fiche-fichier"):
		var file := FileAccess.open(args["fiche-fichier"], FileAccess.READ)
		if file != null:
			fiche = {"titre": args.get("titre", "Fiche de test"), "contenu": file.get_as_text()}
	else:
		info.text = "Chargement des fiches..."
		if ContentLibrary.get_fiches(TEST_GRADE, TEST_SUBJECT).is_empty():
			await ContentLibrary.content_updated
		var fiches := ContentLibrary.get_fiches(TEST_GRADE, TEST_SUBJECT)
		if not fiches.is_empty():
			fiche = fiches[0]
	if fiche.is_empty():
		info.text = "Aucune fiche publiee pour cette classe et cette matiere."
		return
	info.text = ""
	var grade: GradeLevel.Grade = TEST_GRADE
	if args.has("classe"):
		grade = GradeLevel.Grade[str(args["classe"]).to_upper()]
	panel.open_fiche(grade, fiche)
	if args.has("capture"):
		await _capture_all(args["capture"])

func _capture_all(dir: String) -> void:
	DirAccess.make_dir_recursive_absolute(dir)
	var page := 0
	while true:
		for i: int in 6:
			await get_tree().process_frame
		var image := get_viewport().get_texture().get_image()
		image.save_png("%s/page_%02d.png" % [dir, page + 1])
		if panel.next_button.disabled:
			break
		panel.next_button.pressed.emit()
		page += 1
	get_tree().quit()

func _user_args() -> Dictionary:
	var result: Dictionary = {}
	for arg: String in OS.get_cmdline_user_args():
		if arg.begins_with("--"):
			var eq := arg.find("=")
			if eq > 0:
				result[arg.substr(2, eq - 2)] = arg.substr(eq + 1)
	return result
