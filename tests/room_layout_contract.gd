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
	game.state.flags["TITAN_DOWN"] = true
	game.state.flags["DEVOURER_DOWN"] = true
	game.state.flags["GARDEN_RESTORED"] = true
	game.state.flags["KEEPER_PROMISE_SOLVED"] = true
	game.state.flags["PREDATOR_LATCH_SOLVED"] = true
	root.add_child(game)
	await process_frame
	game.player.set_physics_process(false)
	check(game.room_layouts.size() == game.db.rooms.size(), "Every campaign room should have an authored layout spec")
	var checked: Dictionary = {}
	for layout: Dictionary in game.layout_db.rooms:
		var id: String = str(layout.id)
		checked[id] = true
		check(not layout.get("platforms", []).is_empty(), "Room needs an authored traversal landmark: "+id)
		game.load_room(id)
		var static_bodies: int = 0
		for child: Node in game.room.get_children():
			if child is StaticBody2D:
				static_bodies += 1
		var expected_static_bodies: int = layout.platforms.size()+1
		if id == "FOL02" and not game.state.flags.get("REWIND_RETURN_OPEN",false):
			expected_static_bodies += 1
			check(is_instance_valid(game.m16_shutter),"FOL02 should build its special Rewind shutter")
		check(static_bodies == expected_static_bodies,"Unexpected floor/platform/shutter count in "+id)
		for platform: Dictionary in layout.platforms:
			check(float(platform.x) > 45 and float(platform.x) < 595,"Platform blocks an exit approach in "+id)
			check(float(platform.y) >= 100 and float(platform.y) <= 300, "Platform is outside reachable room height in "+id)
			check(float(platform.width) >= 24 and float(platform.width) <= 240, "Platform width is outside graybox limits in "+id)
		for landmark: Dictionary in layout.get("landmarks", []):
			check(float(landmark.x) >= 0 and float(landmark.x) <= 640, "Landmark is outside the room in "+id)
			check(float(landmark.y) >= 0 and float(landmark.y) <= 320, "Landmark is below the playfield in "+id)
		for side: String in ["left", "right"]:
			var clearance: Variant = layout.get("entry_clearance", {}).get(side)
			if not clearance is Dictionary:
				continue
			var raw_targets: Variant = clearance.get("connects_to", [])
			var targets: Array = raw_targets if raw_targets is Array else [raw_targets]
			for target: Variant in targets:
				var route_found: bool = false
				for edge: Dictionary in game.db.edges:
					if (str(edge.room_a) == id and str(edge.room_b) == str(target)) or (str(edge.room_b) == id and str(edge.room_a) == str(target)):
						route_found = true
				check(route_found, "Doorway references no campaign connection: "+id+" -> "+str(target))
		for item: Dictionary in game.db.collectibles:
			if item.room != id or game.state.collected.has(item.id):
				continue
			var matching_landmark: bool = false
			var pickup_found: bool = false
			for landmark: Dictionary in layout.landmarks:
				if landmark.id != item.id:
					continue
				matching_landmark = true
				for pickup: Dictionary in game.pickups:
					if pickup.id == item.id and pickup.at == Vector2(float(landmark.x),float(landmark.y)):
						pickup_found = true
			check(matching_landmark, "Collectible has no authored landmark: "+str(item.id))
			var puzzle_id: String = game.minor_puzzle_for_reward(str(item.id))
			var should_spawn: bool = puzzle_id.is_empty() or bool(game.state.flags.get(str(game.MINOR_PUZZLE_FLAGS.get(puzzle_id,"")),false))
			check(pickup_found == should_spawn,"Collectible availability does not match its authored puzzle gate: "+str(item.id))
	for room: Dictionary in game.db.rooms:
		check(checked.has(str(room.id)), "Campaign room has no layout: "+str(room.id))
	check(checked.size() == game.db.rooms.size(),"Layout iteration missed a room")
	print("ROOM_LAYOUT_CONTRACT failures=", failures, " rooms=", checked.size())
	quit(1 if failures else 0)
