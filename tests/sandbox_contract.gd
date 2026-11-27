extends SceneTree
var failures: int = 0
func check(value: bool, label: String) -> void:
    if not value:
        failures += 1
        push_error(label)
func _initialize() -> void:
    call_deferred("run_checks")
func run_checks() -> void:
    var packed := load("res://world/sandbox.tscn") as PackedScene
    var game: Node2D = packed.instantiate()
    root.add_child(game)
    await physics_frame
    var p: CharacterBody2D = game.player
    p.set_physics_process(false)
    p.energy = 100.0
    for i in range(8):
        p.shot_timer = 0.0
        check(p.try_fire(), "Rifle rejected valid shot %d" % i)
    check(p.overheated and p.heat == 100.0, "Eighth shot must overheat")
    var before: float = p.energy
    p.shot_timer = 0.0
    check(not p.try_fire() and p.energy == before, "Locked rifle consumed energy")
    p.energy = 90.0
    check(p.collect("unique-test",18.0), "Valid release rejected")
    check(p.energy == 100.0, "Collector overflow not clamped")
    check(not p.collect("unique-test",18.0), "Duplicate release accepted")
    p.overheated = false
    p.heat = 0.0
    p.energy = 0.0
    p.shot_timer = 0.0
    check(not p.try_fire() and p.energy == 0.0, "Empty energy cell fired")
    p.heat = 100.0
    p.overheated = true
    p.since_shot = 0.0
    for i in range(190):
        p._physics_process(1.0/60.0)
    check(not p.overheated and p.heat <= 35.0, "Rifle did not cool/unlock")
    p.set_physics_process(true)
    p.position = Vector2(60,270)
    p.velocity = Vector2.ZERO
    for i in range(60):
        await physics_frame
    check(p.is_on_floor(), "Player must land on sandbox floor")
    Input.action_press("jump")
    await physics_frame
    await physics_frame
    Input.action_release("jump")
    check(p.velocity.y < 0.0, "Grounded player must jump")
    var old_x: float = p.position.x
    Input.action_press("right")
    for i in range(20):
        await physics_frame
    Input.action_release("right")
    check(p.position.x > old_x+20, "Player must move right")
    for i in range(90):
        await physics_frame
    check(p.is_on_floor(), "Player must land before a fresh jump sequence")
    Input.action_press("jump")
    await physics_frame
    await physics_frame
    Input.action_release("jump")
    for i in range(8):
        await physics_frame
    check(not p.is_on_floor(), "First jump should leave the ground")
    Input.action_press("jump")
    await physics_frame
    await physics_frame
    Input.action_release("jump")
    check(p.velocity.y < -200 and p.air_jumps == 0, "Airborne jump input must trigger the double jump; velocity=%s remaining=%d grounded=%s" % [p.velocity, p.air_jumps, p.is_on_floor()])
    p.energy = p.capacity
    p.position.y = 120
    p.velocity.y = -40
    p.shot_timer = 0
    var airborne_shots: Array[int] = [0]
    p.shot.connect(func(_origin: Vector2, _direction: Vector2) -> void: airborne_shots[0] += 1)
    check(p.try_fire(), "Airborne player should be able to fire the equipped weapon")
    check(airborne_shots[0] == 1, "Airborne shot signal should be emitted")
    p.energy = 0.0
    var blade_swings: Array[int] = [0]
    p.blade.connect(func(_origin: Vector2, _facing: float) -> void: blade_swings[0] += 1)
    Input.action_press("melee")
    await physics_frame
    await physics_frame
    Input.action_release("melee")
    check(blade_swings[0] == 1 and p.energy == 0.0, "Melee should stay available with an empty Echo cell")
    print("SANDBOX_CONTRACT failures=",failures)
    quit(1 if failures else 0)
