extends SceneTree

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var game: Node2D = load("res://world/campaign.tscn").instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	root.add_child(game)
	await process_frame
	game.player.set_physics_process(false)
	check(game.current == "TOW01", "Campaign should begin in the Guild Town")
	game.player.position.x = 630.0
	game._process(1.0 / 60.0)
	check(game.current == "TOW02", "Crossing an open right doorway did not load the connected room")
	check(game.current == "TOW02", "Travel did not load the connected room")
	check(is_equal_approx(game.player.position.x, 25.0), "Right-side exit should enter at the destination's left doorway")
	check(game.state.visited.has("TOW02"), "Entered room was not revealed on the world map")
	check(game.travel_to("TOW01"), "Reverse edge did not allow return travel")
	check(is_equal_approx(game.player.position.x, 615.0), "Left-side exit should enter at the destination's right doorway")
	check(game.travel_to("TOW02"), "Could not revisit the Guild Hall approach")
	check(game.travel_to("TOW03"), "Could not enter the Guild Hall")
	check(not game.travel_to("TOW04"), "Locked Artificer Yard route bypassed its briefing flag")
	check(game.current == "TOW03", "Failed route attempt changed the active room")
	game.state.flags["BRIEFED"] = true
	check(game.travel_to("TOW04"), "Briefed route remained locked")
	check(game.current == "TOW04", "Unlocked room edge did not load its destination")
	print("ROOM_TRANSITION_CONTRACT failures=", failures)
	quit(1 if failures else 0)
