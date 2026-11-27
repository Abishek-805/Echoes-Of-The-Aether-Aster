extends Control
func _ready() -> void:
    RenderingServer.set_default_clear_color(Color("111b29"))
    var stack := VBoxContainer.new()
    stack.position = Vector2(140,38)
    stack.size = Vector2(360,230)
    stack.add_theme_constant_override("separation",12)
    add_child(stack)
    var title := Label.new()
    title.text = "ECHOES OF THE AETHER\nASTER"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title.add_theme_font_size_override("font_size",24)
    stack.add_child(title)
    var subtitle := Label.new()
    subtitle.text = "Early production · full campaign graybox · placeholder art"
    subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    subtitle.add_theme_font_size_override("font_size",12)
    stack.add_child(subtitle)
    var play := Button.new()
    play.text = "Continue expedition" if not preload("res://systems/slice_save.gd").read_state("user://aster_campaign_v1.json").is_empty() else "Begin expedition"
    play.custom_minimum_size.y = 42
    play.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://world/campaign.tscn"))
    stack.add_child(play)
    var fresh := Button.new()
    fresh.text = "New expedition"
    fresh.pressed.connect(func() -> void:
        PlatformInput.new_run_requested = true
        get_tree().change_scene_to_file("res://world/campaign.tscn"))
    stack.add_child(fresh)
    var touch := CheckButton.new()
    touch.text = "Show touch controls (desktop preview)"
    touch.button_pressed = PlatformInput.touch_override
    touch.toggled.connect(func(enabled: bool) -> void: PlatformInput.touch_override = enabled)
    stack.add_child(touch)
    var note := Label.new()
    note.text = "Keyboard / mouse · Gamepad · Touch\nNo Rewind in the opening. No ammunition or reload."
    note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    note.add_theme_font_size_override("font_size",12)
    stack.add_child(note)
    play.grab_focus()
