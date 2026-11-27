extends SceneTree
var failures: int = 0
func check(ok: bool, message: String) -> void:
    if not ok:
        failures += 1
        push_error(message)
func _initialize() -> void:
    call_deferred("run_checks")
func run_checks() -> void:
    var controls: Node = root.get_node("PlatformInput")
    controls.pointer_aim = false
    check(controls.aim(Vector2.ZERO,Vector2(50,50),-1.0)==Vector2.LEFT,"Touch/controller fallback aim")
    for action: String in ["left","right","jump","dodge","fire","melee","pause"]:
        var has_pad: bool = false
        for event: InputEvent in InputMap.action_get_events(action):
            if event is InputEventJoypadButton or event is InputEventJoypadMotion:
                has_pad = true
        check(has_pad, "Missing gamepad action: "+action)
    controls.touch_override = true
    var scene := load("res://world/sandbox.tscn") as PackedScene
    var game: Node2D = scene.instantiate()
    root.add_child(game)
    await process_frame
    var overlay: CanvasLayer
    for child: Node in game.get_children():
        if child.get_script() == load("res://ui/touch_controls.gd"):
            overlay = child
    check(overlay != null,"Touch overlay missing")
    check(overlay.buttons.size() == 10,"Touch action coverage")
    var first_button: TouchScreenButton = overlay.buttons[0]
    check(first_button.visible,"Forced touch preview visibility")
    game.toggle_pause()
    await process_frame
    check(paused,"Pause did not stop tree")
    check(not first_button.visible,"Touch controls remain active while paused")
    game.toggle_pause()
    check(not paused,"Resume failed")
    var config := ConfigFile.new()
    check(config.load("res://export_presets.cfg")==OK,"Export presets parse")
    check(not config.get_value("preset.3.options","variant/thread_support",true),"Web must be single threaded")
    print("PLATFORM_CONTRACT failures=", failures)
    quit(1 if failures else 0)
