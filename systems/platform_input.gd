extends Node
var pointer_aim: bool = true
var touch_override: bool = false
var new_run_requested: bool = false
func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    var keys: Dictionary = {"left": KEY_A, "right": KEY_D, "jump": KEY_SPACE, "dodge": KEY_SHIFT, "interact": KEY_E, "first": KEY_1, "second": KEY_2, "third": KEY_3, "pause": KEY_ESCAPE, "map": KEY_M, "journal": KEY_J, "inventory": KEY_I, "heal": KEY_Q, "rewind": KEY_F, "down": KEY_S}
    for action: String in keys:
        InputMap.add_action(action, 0.22)
        var event := InputEventKey.new()
        event.physical_keycode = keys[action]
        InputMap.action_add_event(action, event)
    for action: String in ["fire", "melee", "aim_left", "aim_right", "aim_up", "aim_down"]:
        InputMap.add_action(action, 0.22)
    for pair: Array in [["fire", MOUSE_BUTTON_LEFT], ["melee", MOUSE_BUTTON_RIGHT]]:
        var event := InputEventMouseButton.new()
        event.button_index = pair[1]
        InputMap.action_add_event(pair[0], event)
    for pair: Array in [["jump", JOY_BUTTON_A], ["dodge", JOY_BUTTON_B], ["interact", JOY_BUTTON_X], ["melee", JOY_BUTTON_RIGHT_SHOULDER], ["pause", JOY_BUTTON_START], ["map", JOY_BUTTON_BACK], ["heal", JOY_BUTTON_LEFT_SHOULDER], ["rewind", JOY_BUTTON_LEFT_STICK], ["first", JOY_BUTTON_DPAD_LEFT], ["second", JOY_BUTTON_DPAD_UP], ["third", JOY_BUTTON_DPAD_RIGHT]]:
        var event := InputEventJoypadButton.new()
        event.button_index = pair[1]
        InputMap.action_add_event(pair[0], event)
    for pair: Array in [["left", JOY_AXIS_LEFT_X, -1.0], ["right", JOY_AXIS_LEFT_X, 1.0], ["fire", JOY_AXIS_TRIGGER_RIGHT, 1.0], ["aim_left", JOY_AXIS_RIGHT_X, -1.0], ["aim_right", JOY_AXIS_RIGHT_X, 1.0], ["aim_up", JOY_AXIS_RIGHT_Y, -1.0], ["aim_down", JOY_AXIS_RIGHT_Y, 1.0]]:
        var event := InputEventJoypadMotion.new()
        event.axis = pair[1]
        event.axis_value = pair[2]
        InputMap.action_add_event(pair[0], event)
    Input.emulate_mouse_from_touch = false
func _input(event: InputEvent) -> void:
    if event is InputEventJoypadButton or event is InputEventJoypadMotion or event is InputEventScreenTouch:
        pointer_aim = false
    elif event is InputEventMouseMotion and event.relative.length() > 1.0:
        pointer_aim = true
func uses_touch() -> bool:
    return touch_override or DisplayServer.is_touchscreen_available() or OS.has_feature("web_android") or OS.has_feature("web_ios")
func aim(origin: Vector2, cursor: Vector2, facing: float) -> Vector2:
    var stick := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down", 0.22)
    if stick.length() > 0.1:
        return stick.normalized()
    if pointer_aim and not uses_touch() and cursor.distance_to(origin) > 2.0:
        return (cursor-origin).normalized()
    return Vector2(facing, 0)
func release_actions() -> void:
    for action: StringName in InputMap.get_actions():
        Input.action_release(action)
