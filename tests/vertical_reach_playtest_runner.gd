extends Node

const CampaignScene = preload("res://world/campaign.tscn")

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _ready() -> void:
	call_deferred("run_playtest")

func test_platform(game: Node2D, room_id: String, x: float) -> void:
	game.load_room(room_id, x)
	game.player.position = Vector2(x, 282.0)
	game.player.velocity = Vector2.ZERO
	for frame in range(45):
		await get_tree().physics_frame
	check(game.player.is_on_floor(), room_id+" test should start from the shared floor")
	Input.action_press("jump")
	for frame in range(18):
		await get_tree().physics_frame
	Input.action_release("jump")
	await get_tree().physics_frame
	Input.action_press("jump")
	for frame in range(2):
		await get_tree().physics_frame
	Input.action_release("jump")
	var landed_on_perch: bool = false
	for frame in range(120):
		await get_tree().physics_frame
		if game.player.is_on_floor() and game.player.position.y < 240.0:
			landed_on_perch = true
			break
	check(landed_on_perch, room_id+" double jump should land on its high platform; position=%s" % game.player.position)
	if room_id == "WAR02" and landed_on_perch:
		Input.action_press("interact")
		for frame in range(2):
			await get_tree().physics_frame
		Input.action_release("interact")
		check(game.state.collected.has("AR11"), "Landing on the Anchor Junction ledge should let Aster claim its nearby warning record")

func run_playtest() -> void:
	var game: Node2D = CampaignScene.instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	get_tree().root.add_child(game)
	await get_tree().physics_frame
	await test_platform(game, "ROT02", 352.0)
	await test_platform(game, "WAR02", 330.0)
	await test_platform(game, "REW03", 320.0)
	print("VERTICAL_REACH_PLAYTEST failures=", failures)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
