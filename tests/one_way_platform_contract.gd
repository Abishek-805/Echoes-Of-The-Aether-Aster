extends SceneTree

const Player = preload("res://actors/player/player.gd")
const InputHelper = preload("res://systems/platform_input.gd")
var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	if root.get_node_or_null("PlatformInput") == null:
		var input_helper: Node = InputHelper.new()
		input_helper.name = "PlatformInput"
		root.add_child(input_helper)
	var platform := StaticBody2D.new()
	platform.position = Vector2(180, 200)
	platform.collision_layer = 8
	platform.collision_mask = 0
	var platform_shape := CollisionShape2D.new()
	var platform_rect := RectangleShape2D.new()
	platform_rect.size = Vector2(260, 8)
	platform_shape.shape = platform_rect
	platform_shape.one_way_collision = true
	platform.add_child(platform_shape)
	root.add_child(platform)

	var player: CharacterBody2D = Player.new()
	player.position = Vector2(180, 80)
	root.add_child(player)
	await process_frame
	check(player.get_collision_mask_value(1), "Player must collide with solid world geometry")
	check(player.get_collision_mask_value(4), "Player must collide with one-way platforms on collision layer 4")
	check(not player.get_collision_mask_value(3), "Player collision mask must not include enemy bodies on collision layer 3")
	for _frame in range(80):
		await physics_frame
	check(player.is_on_floor(), "Player did not land on the one-way platform")
	var landed_y: float = player.position.y
	player.begin_drop_through()
	for _frame in range(36):
		await physics_frame
	check(player.position.y > landed_y + 30.0, "Down+jump did not drop through the one-way platform")
	check(player.get_collision_mask_value(4), "One-way platform collision was not restored after drop-through")

	# If a route closes after Rewind starts but before a valid sample is played,
	# activation must cancel safely and refund its one-time EE cost.
	player.position = Vector2(100, 100)
	player.rewind_unlocked = true
	player.energy = 60.0
	player.rewind.clear_history()
	for _sample in range(20):
		player.rewind.record(player, 1.0 / 60.0)
	check(player.rewind.begin(player), "Rewind did not begin with sufficient safe history")
	var blocker := StaticBody2D.new()
	blocker.collision_layer = 1
	var blocker_shape := CollisionShape2D.new()
	var blocker_rect := RectangleShape2D.new()
	blocker_rect.size = Vector2(32, 48)
	blocker_shape.shape = blocker_rect
	blocker.add_child(blocker_shape)
	blocker.position = player.position
	root.add_child(blocker)
	player.rewind.tick(player, 1.0 / 60.0)
	check(not player.rewind.playing, "Rewind remained active after its route became invalid")
	check(is_equal_approx(player.energy, 60.0), "Invalidated Rewind did not refund its EE cost exactly")
	blocker.queue_free()
	await physics_frame
	player.position = Vector2(130, 100)
	player.energy = 60.0
	player.rewind.clear_history()
	for sample: int in range(20):
		player.position = Vector2(100.0 + float(sample), 100.0)
		player.rewind.record(player, 1.0 / 60.0)
	player.position = Vector2(130, 100)
	check(player.rewind.begin(player), "Rewind should start with a recorded moving route")
	player.rewind.tick(player, 1.0 / 60.0)
	check(player.global_position.x < 130.0, "First Rewind tick should move along its recorded route")
	var late_blocker := StaticBody2D.new()
	late_blocker.collision_layer = 1
	var late_shape := CollisionShape2D.new()
	var late_rect := RectangleShape2D.new()
	late_rect.size = Vector2(32, 48)
	late_shape.shape = late_rect
	late_blocker.add_child(late_shape)
	late_blocker.position = Vector2(118, 100)
	root.add_child(late_blocker)
	player.rewind.tick(player, 1.0 / 60.0)
	check(not player.rewind.playing, "Rewind should stop when a later sample becomes blocked")
	check(is_equal_approx(player.energy, 35.0), "Rewind must not refund after an earlier playback tick moved Aster")
	late_blocker.queue_free()
	print("ONE_WAY_PLATFORM_CONTRACT failures=", failures)
	quit(1 if failures else 0)
 
