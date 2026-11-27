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
	game.load_room("HUN03")
	var warp_seam: Dictionary = {}
	for landmark: Dictionary in game.room_landmarks:
		if landmark.id == "warp_seam":
			warp_seam = landmark
	check(not warp_seam.is_empty(), "Warp landmark was not built in Fracture Crossing")
	game.player.position = warp_seam.at
	check(game.inspect_nearby_landmark(), "Nearby environmental evidence could not be inspected")
	check(game.state.flags.get("LANDMARK_SEEN_WARP_SEAM",false), "Inspection was not saved as a field note")
	check(str(game.modal_box.get_child(1).text).contains("space-time fault"), "Field note does not show the environmental clue")
	game.close_panel()
	game.open_records()
	check(str(game.modal_box.get_child(1).text).contains("warp seam"), "Inspected field evidence is missing from the journal")
	game.close_panel()
	print("LANDMARK_CLUE_CONTRACT failures=", failures)
	quit(1 if failures else 0)
