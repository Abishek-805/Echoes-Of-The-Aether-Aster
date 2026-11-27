extends SceneTree

var failures: int = 0

func check(value: bool, message: String) -> void:
	if not value:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_contract")

func run_contract() -> void:
	var game: Node2D = load("res://world/campaign.tscn").instantiate()
	game.persistence_enabled = false
	root.add_child(game)
	await process_frame
	check(game.story_sequence.busy, "A fresh TOW01 campaign should show its opening scene")
	check(paused, "The opening story should pause world simulation")
	check(game.current_objective_text().contains("Guild Town"), "The fresh journal should orient the player in town")
	for _i in 4:
		game.story_sequence.advance()
	check(game.state.flags.get("INTRO_DONE", false), "Finishing the opening should save INTRO_DONE")
	check(game.current_objective_text().contains("Guild Hall"), "The journal should point to the Guild Hall after the opening")
	check(not paused, "Finishing the opening should restore unpaused gameplay")
	game.load_room("TOW03")
	game.open_console()
	check(game.story_sequence.active_scene_id == "GUILD_BRIEFING", "Guild console should play the briefing")
	game.story_sequence.finish_scene()
	check(game.state.flags.get("BRIEFED", false), "Skipping dialogue should still apply BRIEFED")
	check(not game.story_sequence.busy, "Briefing presenter should close after skip")
	game.load_room("TOW04")
	game.open_console()
	check(game.story_sequence.active_scene_id == "ARTIFICER_TUTORIAL", "Artificer console should play the energy tutorial")
	_finish(game, "TUTORIAL_DONE")
	game.load_room("HUN03")
	_finish(game, "WARP_SCENE_SEEN")
	check(game.state.flags.get("WARP", false), "Warp scene should open warped routes")
	game.load_room("CAM02")
	game.inspect_record()
	_finish(game, "CAMP_RECORD_SEEN")
	game.state.flags.ARCHIVE_ALIGNED = true
	game.load_room("SUR03")
	game.inspect_record()
	_finish(game, "VAULT_SCENE_SEEN")
	game.load_room("VER02")
	game.inspect_record()
	_finish(game, "VERAYAN_RECORD_SEEN")
	game.load_room("SIL02")
	game.inspect_record()
	_finish(game, "MEMORIAL_SEEN")
	game.state.flags.RESERVOIR_STABLE = true
	game.load_room("RES02")
	game.inspect_record()
	_finish(game, "RESERVOIR_RECORD_SEEN")
	game.state.flags.SLUICE_OPEN = true
	game.state.flags.KEEPER_DOWN = true
	game.load_room("REW03")
	game.open_console()
	var rewind_steps: Array = game.PUZZLE_STEPS["P08"]
	for index: int in range(1, rewind_steps.size(), 2):
		game.puzzle_input(rewind_steps[index][0])
	_finish(game, "REWIND_SCENE_SEEN")
	check(game.player.rewind_unlocked, "Rewind scene trigger must enable Aster's Rewind")
	game.state.flags.FOLDS_ALIGNED = true
	game.load_room("FOL03")
	game.inspect_record()
	_finish(game, "NALORA_FRAGMENT_SEEN")
	game.load_room("FIN03")
	game.inspect_record()
	_finish(game, "FINAL_WARNING_SEEN")
	game.state.flags.ANCHORS_STABLE = true
	game.state.flags.GUARDIAN_DOWN = true
	game.load_room("GAT01")
	var guardian: Dictionary = game.db.bosses.filter(func(row: Dictionary) -> bool: return row.id == "B06")[0]
	game.encounters["B06"] = {"boss":guardian,"energy":40,"material":"alloy"}
	game.enemy_defeated("B06", Vector2.ZERO)
	_finish(game, "GUARDIAN_SCENE_SEEN")
	game.load_room("GAT02")
	game.open_console()
	_finish(game, "GATE_DIAGNOSED")
	game.state.flags.SIGNAL_SENT = true
	game.load_room("GAT04")
	_finish(game, "ENDING_SEEN")
	check(game.state.flags.get("END_COMPLETE", false), "Final scene should complete Aster's game")
	for key: String in ["MAP_ALIGNED", "WORKS_POWER", "TOPOLOGY_ALIGNED", "REWIND_TRAINED", "FOLDS_ALIGNED", "ANCHORS_STABLE", "GUARDIAN_DOWN", "GATE_DIAGNOSED", "SIGNAL_SENT"]:
		game.state.flags[key] = true
	check(game.current_objective_text().contains("gate remains broken"), "Ending journal should keep Aster's rescue unresolved")
	print("STORY_INTEGRATION_CONTRACT failures=", failures)
	quit(1 if failures else 0)

func _finish(game: Node2D, flag: String) -> void:
	check(game.story_sequence.busy, "Expected story did not start for " + flag)
	if game.story_sequence.busy:
		game.story_sequence.finish_scene()
	check(game.state.flags.get(flag, false), "Story did not persist completion flag " + flag)
