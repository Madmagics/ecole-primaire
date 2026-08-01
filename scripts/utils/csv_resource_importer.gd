## Utilitaire reutilisable : lit un fichier CSV ligne par ligne et delegue la
## construction de chaque Resource a un Callable fourni par l'appelant, puis
## sauvegarde le resultat en .tres. Sert de base a tous les importeurs CSV du
## projet (cartes, et plus tard tout autre contenu en gros volume : objets,
## lots, etc.) sans dupliquer la logique de lecture/ecriture a chaque fois.
class_name CsvResourceImporter
extends RefCounted

## Importe [csv_path] vers des fichiers .tres dans [output_dir].
## [build_resource] recoit (headers: PackedStringArray, row: PackedStringArray)
## et doit renvoyer soit une Resource prete a sauvegarder, soit null pour
## ignorer la ligne (ex: ligne vide, id manquant).
## Le nom de fichier de sortie est "<output_dir>/<premiere colonne>.tres".
## [delimiter] : separateur de colonnes (";" par defaut, celui qu'utilise Excel
## en français ; mettre "," si le CSV vient d'un Excel/Sheets en anglais).
## Renvoie le nombre de fichiers ecrits avec succes.
static func import(csv_path: String, output_dir: String, build_resource: Callable, delimiter: String = ";") -> int:
	var file := FileAccess.open(csv_path, FileAccess.READ)
	if file == null:
		push_error("CsvResourceImporter: impossible d'ouvrir %s (erreur %s)" % [csv_path, FileAccess.get_open_error()])
		return 0

	var headers: PackedStringArray = file.get_csv_line(delimiter)
	var written := 0

	while not file.eof_reached():
		var row: PackedStringArray = file.get_csv_line(delimiter)
		if row.is_empty() or (row.size() == 1 and row[0].strip_edges() == ""):
			continue

		var resource: Resource = build_resource.call(headers, row)
		if resource == null:
			continue

		var id := row[0].strip_edges()
		if id == "":
			push_warning("CsvResourceImporter: ligne ignoree (premiere colonne/id vide).")
			continue

		## [output_dir] peut ne pas encore exister (ex: nouvelle classe/matiere jamais
		## importee) : ResourceSaver.save echoue silencieusement sans dossier existant, donc on
		## le cree au besoin plutot que d'imposer a chaque appelant de le faire lui-meme.
		DirAccess.make_dir_recursive_absolute(output_dir)

		var out_path := "%s/%s.tres" % [output_dir, id]
		var err := ResourceSaver.save(resource, out_path)
		if err != OK:
			push_error("CsvResourceImporter: echec sauvegarde %s (code %d)" % [out_path, err])
			continue
		written += 1

	if Engine.is_editor_hint():
		EditorInterface.get_resource_filesystem().scan()

	return written

## Convertit une ligne CSV en dictionnaire {nom_colonne: valeur}, pratique pour
## que les Callables de build_resource n'aient pas a manipuler des index.
static func row_to_dict(headers: PackedStringArray, row: PackedStringArray) -> Dictionary:
	var values := {}
	for i in headers.size():
		values[headers[i].strip_edges()] = row[i].strip_edges() if i < row.size() else ""
	return values
