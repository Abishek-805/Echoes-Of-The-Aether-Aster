extends Node

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _ready() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var game: Node2D = load("res://world/campaign.tscn").instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	get_tree().root.add_child(game)
	for index in range(60):
		await get_tree().physics_frame
	check(game.current == "TOW01", "Physical route test should start in Memorial Street")
	check(game.player.is_on_floor(), "Player should settle on the authored room floor before moving")
	var max_x: float = game.player.position.x
	Input.action_press("right")
	for index in range(300):
		await get_tree().physics_frame
		max_x = maxf(max_x, game.player.position.x)
		if game.current == "TOW02":
			break
	Input.action_release("right")
	check(game.current == "TOW02", "Holding right should physically cross the open Memorial Street doorway")
	check(game.state.visited.has("TOW02"), "Physical doorway crossing should reveal the destination on the map")
	check(game.player.position.x < 120.0, "Room transition should preserve the destination's left-side entry")
	check(max_x > 600.0, "Player movement should physically reach the doorway trigger")
	for index in range(15):
		await get_tree().physics_frame
	check(game.player.is_on_floor(), "Player should remain grounded after entering the connected room")
	print("PHYSICAL_ROUTE_INTEGRATION failures=", failures, " room=", game.current, " position=", game.player.position)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
