extends SceneTree

const Warden = preload("res://actors/enemies/warden.gd")
var failures: int = 0
var shockwaves: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var target := CharacterBody2D.new()
	root.add_child(target)
	var boss: CharacterBody2D = Warden.new()
	boss.target = target
	root.add_child(boss)
	await process_frame
	boss.set_physics_process(false)
	boss.shockwave.connect(_on_shockwave)
	boss.hp = 150.0
	boss.state = "guard"
	boss.timer = 0.0

	boss._physics_process(0.01)
	check(boss.state == "tell", "Warden did not telegraph its first slam")
	boss._physics_process(1.01)
	check(boss.state == "slam", "First Warden slam did not follow its tell")
	check(shockwaves == 2, "First slam should create two directional shockwaves")
	boss._physics_process(0.19)
	check(boss.state == "chain_pause", "Warden chain pause missing")
	boss._physics_process(0.75)
	check(boss.state == "second_tell", "Warden did not enter second-slam tell")
	check(boss.timer >= 0.99, "Second slam warning should last one second")
	boss._physics_process(0.99)
	check(boss.state == "second_tell", "Second slam fired before its warning ended")
	check(shockwaves == 2, "Second slam emitted shockwaves before its tell completed")
	boss._physics_process(0.02)
	check(boss.state == "slam", "Second slam did not follow its tell")
	check(shockwaves == 4, "Second slam should create two directional shockwaves")
	print("BOSS_BEHAVIOR_CONTRACT failures=", failures, " shockwaves=", shockwaves)
	quit(1 if failures else 0)

func _on_shockwave(_at: Vector2, _direction: float) -> void:
	shockwaves += 1
