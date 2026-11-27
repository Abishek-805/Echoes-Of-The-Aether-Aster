extends Node

const CampaignScene = preload("res://world/campaign.tscn")

var failures: int = 0
var game: Node2D

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func has_pickup(id: String) -> bool:
	for pickup: Dictionary in game.pickups:
		if str(pickup.id) == id:
			return true
	return false

func find_edge(room_a: String, room_b: String) -> Dictionary:
	for edge: Dictionary in game.db.edges:
		if (str(edge.room_a) == room_a and str(edge.room_b) == room_b) or (str(edge.room_a) == room_b and str(edge.room_b) == room_a):
			return edge
	return {}

func _ready() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	game = CampaignScene.instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	add_child(game)
	await get_tree().physics_frame
	game.player.set_physics_process(false)

	game.load_room("OUT04")
	check(not has_pickup("MAP01") and not has_pickup("BP01"),"M02 rewards should stay hidden before solving the cache clue")
	game.open_minor_puzzle("OUT04")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(1)
	check(game.state.flags.get("M02_CACHE_OPEN",false),"Correct M02 evidence should open the Hunter Cache")
	check(has_pickup("MAP01") and has_pickup("BP01"),"M02 map and blueprint should appear after solving")

	game.load_room("HUN04")
	game.open_minor_puzzle("HUN04")
	game.answer_minor_puzzle(2)
	check(game.minor_puzzle_stage == 0 and not game.state.flags.get("M03_BLIND_FOUND",false),"Wrong M03 choice should reset the local trail")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(1)
	game.answer_minor_puzzle(0)
	check(game.state.flags.get("M03_BLIND_FOUND",false),"Correct M03 trail should identify the blind")
	check(has_pickup("DAWN02") and has_pickup("MAP02"),"M03 rewards should appear when its trail is completed")

	game.load_room("SLU04")
	game.state.flags.SLUICE_OPEN = true
	var spillway_edge: Dictionary = find_edge("SLU04","HUN02")
	check(not game.route_is_open(spillway_edge),"M05 spillway shortcut should remain closed until its valve is set")
	game.open_minor_puzzle("SLU04")
	game.answer_minor_puzzle(0)
	check(game.route_is_open(spillway_edge),"Solving M05 should open its Hunter's Reach return shortcut")

	game.load_room("SUR04")
	game.state.flags.REWIND_TRAINED = true
	var archive_edge: Dictionary = find_edge("FOL01","SUR04")
	check(not game.route_is_open(archive_edge),"The late archive return seam should require the custody index")
	game.open_minor_puzzle("SUR04")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(0)
	check(game.state.flags.get("ARCHIVE_INDEX_READ",false),"M09 should record its custody lore")
	check(game.route_is_open(archive_edge),"Solving M09 should open its late return seam after Rewind mastery")

	game.load_room("RES04")
	game.state.flags.RESERVOIR_STABLE = true
	var overflow_edge: Dictionary = find_edge("RES04","WAR02")
	check(not game.route_is_open(overflow_edge),"M13 return sluice should require overflow isolation")
	game.open_minor_puzzle("RES04")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(0)
	check(game.route_is_open(overflow_edge),"Solving M13 should open its safe return sluice")

	game.state.flags.PREDATOR_LATCH_SOLVED = true
	game.load_room("FOL04")
	check(not game.state.flags.get("DEVOURER_DOWN",false) and has_pickup("HP04") and has_pickup("MAP06"),"M14 latch caches should appear before the optional Devourer fight")
	game.load_room("FIN04")
	var receiver_found: bool = false
	for landmark: Dictionary in game.room_landmarks:
		if str(landmark.id) == "service_receiver":
			receiver_found = true
	check(receiver_found,"M15 service receiver should be visible and inspectable in FIN04")

	game.load_room("ROT04")
	game.state.flags.WARDEN_DOWN = true
	game.open_titan_marker()
	game.modal_box.get_child(2).emit_signal("pressed")
	check(game.state.flags.get("M07_MARKER_SEEN",false),"M07 marker should record the Warden pulse")
	game.enemy_defeated("B02",Vector2.ZERO)
	check(game.state.flags.get("M07_MARKER_COMPLETE",false),"M07 should complete after marker plus Titan defeat")
	check(has_pickup("MAP04"),"M07 map reward should appear only after both steps")

	game.load_room("FOL02",615.0)
	game.player.rewind_unlocked = true
	game.player.energy = 100.0
	game.player.rewind.cooldown = 0.0
	game.player.rewind.clear_history(game.player)
	for index in range(20):
		game.player.rewind.history.append({"at":Vector2(100.0+float(index)*21.3,120.0),"velocity":Vector2.ZERO,"hp":100.0,"time":float(index)/60.0})
	game.player.position = Vector2(505.0,120.0)
	game._process(0.016)
	check(not game.m16_gate_activated,"Entering FOL02 from the east should not activate a west-to-east Rewind latch")
	game.player.position = Vector2(100.0,120.0)
	game._process(0.016)
	check(game.m16_latch_armed,"Returning west should arm the M16 latch for a future crossing")
	game.player.position = Vector2(505.0,120.0)
	game._process(0.016)
	check(game.m16_gate_activated and game.player.get_collision_mask_value(5),"Crossing the ready M16 latch should close its physical shutter")
	check(game.player.rewind.begin(game.player),"The M16 recorded path should permit real Rewind playback")
	for index in range(30):
		game.player.rewind.tick(game.player,0.05)
		game._process(0.05)
		if not game.player.rewind.playing:
			break
	game._process(0.016)
	check(game.player.position.x < 140.0,"Real Rewind playback should cross the physical M16 shutter back to the west")
	check(game.state.flags.get("REWIND_RETURN_OPEN",false),"Returning through M16 with Rewind should open its shortcut")
	check(not game.player.get_collision_mask_value(5),"Completed M16 should clear the temporary shutter collision mask")

	print("OPTIONAL_PUZZLE_INTEGRATION failures=",failures)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
