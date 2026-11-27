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
	root.add_child(game)
	await process_frame
	if game.story_sequence.busy:
		game.story_sequence.finish_scene()
	game.load_room("ROT03")
	var main_objective: String = game.current_objective_text()
	game.state.flags.SLUICE_OPEN = true
	check(not _has_pickup(game, "HP01") and not _has_pickup(game, "MEM02"), "Garden rewards appeared before M06")
	game.open_console()
	var garden_option: Button = game.modal_box.get_child(2)
	garden_option.pressed.emit()
	check(game.state.flags.get("GARDEN_RESTORED", false), "M06 did not restore the garden")
	check(_has_pickup(game, "HP01") and _has_pickup(game, "MEM02"), "M06 rewards did not appear after water restoration")
	check(game.current_objective_text() == main_objective, "Optional Garden story changed the main objective")

	game.load_room("SIL04")
	check(not _has_pickup(game, "AR16") and not _has_pickup(game, "MEM03"), "Keeper shrine rewards appeared before M12")
	game.open_keeper_promise_puzzle()
	check(game.modal_box.get_child_count() == 3, "M12 allowed guessing before reading AR14")
	game.close_panel()
	game.state.collected["AR14"] = "Memorial inscriptions"
	game.open_keeper_promise_puzzle()
	var wrong_keeper_option: Button = game.modal_box.get_child(3)
	wrong_keeper_option.pressed.emit()
	check(not game.state.flags.get("KEEPER_PROMISE_SOLVED", false), "Incorrect M12 match completed the shrine story")
	game.modal_box.get_child(2).pressed.emit()
	var keeper_option: Button = game.modal_box.get_child(2)
	keeper_option.pressed.emit()
	check(game.state.flags.get("KEEPER_PROMISE_SOLVED", false), "M12 did not match the Seren imprint")
	check(_has_pickup(game, "AR16") and _has_pickup(game, "MEM03"), "M12 rewards did not appear after matching")

	game.state.flags.REWIND_ACQUIRED = true
	game.player.rewind_unlocked = true
	game.load_room("FOL04")
	game.player.rewind.cooldown = 1.0
	game.player.position.x = 520
	game._process(0.01)
	game.player.position.x = 100
	game._process(0.01)
	check(not game.state.flags.get("PREDATOR_LATCH_SOLVED", false), "Old Rewind cooldown bypassed the latch challenge")
	game.player.position.x = 520
	game._process(0.01)
	game.player.rewind.playing = true
	game._process(0.01)
	game.player.rewind.playing = false
	game.player.position.x = 100
	game._process(0.01)
	check(game.state.flags.get("PREDATOR_LATCH_SOLVED", false), "M14 did not remember the route after Rewind")
	check(_has_pickup(game, "HP04") and _has_pickup(game, "MAP06") and _has_pickup(game, "MEM05"), "M14 latch caches did not appear before the optional boss")
	check(not game.state.flags.get("SIDE_PREDATOR_DONE", false), "Predator story completed without its boss and evidence records")
	var energy_before_boss: float = game.player.energy
	game.enemy_defeated("B05", Vector2(200, 220))
	check(game.player.energy == minf(game.player.capacity, energy_before_boss + 40), "Boss Echo reward was not released once")
	check(_has_pickup(game, "HP04") and _has_pickup(game, "MAP06") and _has_pickup(game, "MEM05"), "M14 plus the boss did not expose the predator evidence caches")
	print("SIDE_STORY_INTEGRATION_CONTRACT failures=", failures)
	quit(1 if failures else 0)

func _has_pickup(game: Node2D, token: String) -> bool:
	for pickup: Dictionary in game.pickups:
		if str(pickup.id) == token:
			return true
	return false
