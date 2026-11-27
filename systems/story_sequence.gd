extends CanvasLayer
## Lightweight, data-driven cinematic/dialogue presenter. Campaign code owns the
## event triggers and saves the supplied campaign flags after `sequence_finished`.
signal sequence_finished(scene_id: String, set_flags: Dictionary)

const DATA_PATH := "res://data/story_scenes.json"
const DATA := preload("res://data/story_scenes.json")

var scenes: Dictionary = {}
var active_scene_id: String = ""
var active_lines: Array = []
var line_index: int = 0
var busy: bool = false
var prior_paused: bool = false
var backdrop: ColorRect
var title_label: Label
var speaker_label: Label
var body_label: RichTextLabel
var continue_button: Button
var skip_button: Button

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(DATA_PATH))
	if parsed is Dictionary:
		scenes = parsed.get("scenes", {})
	else:
		push_error("Could not load story scene data from %s" % DATA_PATH)
	_build_ui()
	hide()

func _build_ui() -> void:
	backdrop = ColorRect.new()
	backdrop.color = Color(0.015, 0.025, 0.04, 0.92)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(backdrop)
	var panel := PanelContainer.new()
	panel.anchor_left = 0.06
	panel.anchor_right = 0.94
	panel.anchor_top = 0.62
	panel.anchor_bottom = 0.96
	add_child(panel)
	var stack := VBoxContainer.new()
	stack.add_theme_constant_override("separation", 8)
	panel.add_child(stack)
	title_label = Label.new()
	title_label.add_theme_font_size_override("font_size", 18)
	stack.add_child(title_label)
	speaker_label = Label.new()
	speaker_label.add_theme_color_override("font_color", Color("7de0df"))
	speaker_label.add_theme_font_size_override("font_size", 15)
	stack.add_child(speaker_label)
	body_label = RichTextLabel.new()
	body_label.bbcode_enabled = false
	body_label.fit_content = true
	body_label.scroll_active = false
	body_label.add_theme_font_size_override("normal_font_size", 15)
	stack.add_child(body_label)
	var buttons := HBoxContainer.new()
	buttons.alignment = BoxContainer.ALIGNMENT_END
	stack.add_child(buttons)
	skip_button = Button.new()
	skip_button.text = "Skip scene"
	skip_button.pressed.connect(finish_scene)
	buttons.add_child(skip_button)
	continue_button = Button.new()
	continue_button.text = "Continue"
	continue_button.pressed.connect(advance)
	buttons.add_child(continue_button)

func play(scene_id: String) -> bool:
	if busy or not scenes.has(scene_id):
		return false
	active_scene_id = scene_id
	var scene_data: Dictionary = scenes[scene_id]
	active_lines = scene_data.get("lines", [])
	if active_lines.is_empty():
		sequence_finished.emit(scene_id, scene_data.get("set_flags", {}))
		return true
	line_index = 0
	prior_paused = get_tree().paused
	get_tree().paused = true
	busy = true
	show()
	_show_line()
	continue_button.grab_focus()
	return true

func _show_line() -> void:
	var scene_data: Dictionary = scenes[active_scene_id]
	var line: Dictionary = active_lines[line_index]
	title_label.text = scene_data.get("title", "")
	speaker_label.text = line.get("speaker", "")
	body_label.text = line.get("text", "")
	continue_button.text = "Continue" if line_index < active_lines.size() - 1 else "Finish"

func advance() -> void:
	if not busy:
		return
	line_index += 1
	if line_index >= active_lines.size():
		finish_scene()
	else:
		_show_line()

func finish_scene() -> void:
	if not busy:
		return
	var scene_id := active_scene_id
	var scene_data: Dictionary = scenes[scene_id]
	var flags: Dictionary = scene_data.get("set_flags", {}).duplicate()
	var complete_flag: String = scene_data.get("complete_flag", "")
	if not complete_flag.is_empty():
		flags[complete_flag] = true
	busy = false
	active_scene_id = ""
	hide()
	get_tree().paused = prior_paused
	sequence_finished.emit(scene_id, flags)

func _unhandled_input(event: InputEvent) -> void:
	if not busy:
		return
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton and event.pressed:
		advance()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_cancel"):
		finish_scene()
		get_viewport().set_input_as_handled()
