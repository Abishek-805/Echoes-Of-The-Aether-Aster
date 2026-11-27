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
	Input.action_press("map")
	for index in range(3):
		await get_tree().process_frame
	check(game.map_view.visible and get_tree().paused, "M action should open and pause the explored-room map")
	check(game.map_view.visited.size() == 1, "Map should show only the starting room before exploration")
	Input.action_release("map")
	game.close_panel()
	Input.action_press("jump")
	for index in range(2):
		await get_tree().physics_frame
	Input.action_release("jump")
	for index in range(8):
		await get_tree().physics_frame
	check(not game.player.is_on_floor(), "Ground jump should lift Aster in the campaign room")
	Input.action_press("jump")
	for index in range(2):
		await get_tree().physics_frame
	Input.action_release("jump")
	check(game.player.air_jumps == 0 and game.player.velocity.y < 0.0, "Second jump input should perform the campaign double jump")
	var energy_before_shot: float = game.player.energy
	Input.action_press("fire")
	await get_tree().physics_frame
	Input.action_release("fire")
	check(game.player.energy < energy_before_shot, "Ranged fire should spend Echo Energy in the campaign scene")
	for index in range(110):
		await get_tree().physics_frame
	check(game.player.is_on_floor(), "Player should land before beginning doorway traversal")
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
	Input.action_press("right")
	for index in range(300):
		await get_tree().physics_frame
		if game.current == "TOW03":
			break
	Input.action_release("right")
	check(game.current == "TOW03", "The second open doorway should physically lead to the Guild Hall")
	Input.action_press("right")
	for index in range(140):
		await get_tree().physics_frame
		if game.player.position.x >= 300.0:
			break
	Input.action_release("right")
	Input.action_press("interact")
	for index in range(2):
		await get_tree().physics_frame
	Input.action_release("interact")
	check(game.state.flags.get("BRIEFED", false), "Using the Guild Hall console should unlock the Artificer Yard")
	Input.action_press("right")
	for index in range(300):
		await get_tree().physics_frame
		if game.current == "TOW04":
			break
	Input.action_release("right")
	check(game.current == "TOW04", "The Guild briefing should unlock a physical route into the Artificer Yard")
	Input.action_press("right")
	for index in range(140):
		await get_tree().physics_frame
		if game.player.position.x >= 300.0:
			break
	Input.action_release("right")
	Input.action_press("interact")
	for index in range(2):
		await get_tree().physics_frame
	Input.action_release("interact")
	check(game.state.flags.get("TUTORIAL_DONE", false), "Using the Artificer console should complete the Echo-energy tutorial")
	Input.action_press("right")
	for index in range(300):
		await get_tree().physics_frame
		if game.current == "OUT01":
			break
	Input.action_release("right")
	check(game.current == "OUT01", "Completing the tutorial should open the physical route to the dungeon approach")
	Input.action_press("right")
	for index in range(300):
		await get_tree().physics_frame
		if game.current == "OUT02":
			break
	Input.action_release("right")
	check(game.current == "OUT02", "The approach route should physically lead to the first Forager encounter")
	var forager: Node2D
	for actor: CharacterBody2D in game.actors:
		if str(actor.get("archetype")) == "E01":
			forager = actor
			break
	check(is_instance_valid(forager), "The first dungeon encounter should spawn its Echo Forager")
	if is_instance_valid(forager):
		PlatformInput.pointer_aim = false
		Input.action_press("fire")
		for index in range(240):
			await get_tree().physics_frame
			if not is_instance_valid(forager):
				break
		Input.action_release("fire")
		check(not is_instance_valid(forager), "Ranged combat should defeat the first Forager through its live hitbox")
		check(game.state.flags.get("FIRST_RELEASE", false), "Defeating the Forager should release Echo Energy and progress the route")
	print("PHYSICAL_ROUTE_INTEGRATION failures=", failures, " room=", game.current, " position=", game.player.position)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
