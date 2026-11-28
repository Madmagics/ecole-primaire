## Fenetre explicative ouverte par le badge discret DailyLimitBadge (voir son commentaire) - meme
## moule que QuitOverlay/ParentalGateOverlay (BlurBG plein ecran + Card centree), mais purement
## informative : un seul bouton "Fermer", rien a confirmer ni a saisir. Depuis le 2026-11-28 elle
## detaille les limites d'une classe (voir open).
class_name DailyLimitPopup
extends Control

@onready var title_label: Label = $Card/Margin/Content/TitleLabel
@onready var lines_box: VBoxContainer = $Card/Margin/Content/Lines
@onready var close_button: Button = $Card/Margin/Content/CloseButton

func _ready() -> void:
	## Applique le theme d'interface choisi (et reagit a un changement) : ce panneau est un enfant
	## direct du CanvasLayer "UI", qui coupe la propagation automatique de Theme depuis
	## get_tree().root - voir EventBus.ui_theme_changed.
	theme = SaveManager.THEMES[SaveManager.ui_theme]
	EventBus.ui_theme_changed.connect(func(new_theme: Theme) -> void: theme = new_theme)
	close_button.pressed.connect(close)
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		PlayerInputLock.lock()
	else:
		PlayerInputLock.unlock()

## Detail des limites d'UNE classe (2026-11-28) : appelee par DailyLimitBadge quand l'enfant touche
## l'etiquette de cette classe. Reconstruit a chaque ouverture (compteurs et reglages peuvent avoir
## change). En mode "par matiere", seules les matieres limitees ou bloquees sont listees ; les
## matieres illimitees ne sont pas detaillees pour garder la fenetre courte.
func open(grade: GradeLevel.Grade) -> void:
	title_label.text = "Limites du jour (%s)" % GradeLevel.get_label(grade)
	for child in lines_box.get_children():
		child.queue_free()
	var limits := SaveManager.get_grade_limits(grade)
	var mode := String(limits.get("mode"))
	var available := ContentLibrary.get_available_subjects(grade)
	if not SaveManager.is_grade_available(grade, available):
		_add_line(TeacherIdentity.get_unavailable_message(grade).get_slice("\n", 0), true)
	if mode == SaveManager.PARENTAL_MODE_BLOCKED:
		_add_line("Toute la classe est fermée par le contrôle parental.")
	elif mode == SaveManager.PARENTAL_MODE_FREE:
		var played := SaveManager.get_grade_play_count(grade)
		var maximum := int(limits.get("max"))
		if played >= maximum:
			_add_line("Limite libre : terminé pour aujourd'hui (%d / %d parties)." % [played, maximum])
		else:
			_add_line("Limite libre : %d / %d parties aujourd'hui, matières au choix." % [played, maximum])
	elif mode == SaveManager.PARENTAL_MODE_BY_SUBJECT:
		var listed := 0
		var subjects: Dictionary = limits.get("matieres", {})
		for subject in available:
			var rule: Dictionary = subjects.get(str(int(subject)), {})
			var state := String(rule.get("etat", SaveManager.SUBJECT_STATE_UNLIMITED))
			var subject_name := SubjectType.get_label(subject)
			if state == SaveManager.SUBJECT_STATE_BLOCKED:
				_add_line("%s : fermée" % subject_name)
				listed += 1
			elif state == SaveManager.SUBJECT_STATE_LIMITED:
				var played := SaveManager.get_subject_play_count(grade, subject)
				var maximum := int(rule.get("max"))
				if played >= maximum:
					_add_line("%s : terminé (%d / %d)" % [subject_name, played, maximum])
				else:
					_add_line("%s : %d / %d parties" % [subject_name, played, maximum])
				listed += 1
		if listed < available.size():
			_add_line("Les autres matières ne sont pas limitées.")
	_add_line("Les compteurs repartent à zéro à minuit.")
	show()

func _add_line(text: String, emphasized: bool = false) -> void:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if emphasized:
		label.theme_type_variation = &"TitleLabel"
	lines_box.add_child(label)

func close() -> void:
	hide()
