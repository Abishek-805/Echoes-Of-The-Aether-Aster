extends SceneTree

var failures: int = 0

func check(value: bool, label: String) -> void:
	if not value:
		failures += 1
		push_error("CONTENT CONTRACT: " + label)

func _initialize() -> void:
	var raw: String = FileAccess.get_file_as_string("res://data/campaign.json")
	var parsed: Variant = JSON.parse_string(raw)
	check(parsed is Dictionary, "campaign data must parse as an object")
	if not parsed is Dictionary:
		quit(1)
		return
	var db: Dictionary = parsed
	var room_ids: Dictionary = {}
	for room: Dictionary in db.get("rooms", []):
		var id: String = str(room.get("id", ""))
		check(not id.is_empty(), "room ID cannot be empty")
		check(not room_ids.has(id), "duplicate room ID: " + id)
		room_ids[id] = true
		check(not str(room.get("room", "")).is_empty(), "room needs a display name: " + id)
	check(room_ids.size() == 64, "the campaign manifest must contain 64 rooms")
	var connected_pairs: Dictionary = {}
	for edge: Dictionary in db.get("edges", []):
		var a: String = str(edge.get("room_a", ""))
		var b: String = str(edge.get("room_b", ""))
		check(room_ids.has(a), "edge references missing room: " + a)
		check(room_ids.has(b), "edge references missing room: " + b)
		check(a != b, "route cannot connect a room to itself: " + a)
		var pair: String = [a, b].min() + "|" + [a, b].max()
		check(not connected_pairs.has(pair), "duplicate route: " + pair)
		connected_pairs[pair] = true
	for puzzle: Dictionary in db.get("puzzles", []):
		check(room_ids.has(str(puzzle.get("room", ""))), "puzzle references missing room")
		check(not str(puzzle.get("flag", "")).is_empty(), "puzzle needs a progress flag")
		check(not str(puzzle.get("solution", "")).is_empty(), "puzzle needs a documented solution")
	for item: Dictionary in db.get("collectibles", []):
		check(room_ids.has(str(item.get("room", ""))), "collectible references missing room")
	var layout_data: Variant = JSON.parse_string(FileAccess.get_file_as_string("res://data/room_layouts.json"))
	check(layout_data is Dictionary, "room layout data must parse as an object")
	var layout_ids: Dictionary = {}
	if layout_data is Dictionary:
		for layout: Dictionary in layout_data.get("rooms", []):
			var layout_id: String = str(layout.get("id", ""))
			check(room_ids.has(layout_id), "layout references missing campaign room: "+layout_id)
			check(not layout_ids.has(layout_id), "duplicate room layout: "+layout_id)
			layout_ids[layout_id] = true
			for zone: Dictionary in layout.get("encounter_zones", []):
				var enemy_id: String = str(zone.get("enemy", ""))
				var valid_encounter: bool = false
				for enemy: Dictionary in db.get("enemies", []):
					if enemy.id == enemy_id and layout_id in str(enemy.rooms).split(" "):
						valid_encounter = true
				for variant: Dictionary in db.get("enemy_variants", []):
					if variant.base == enemy_id and layout_id in str(variant.rooms).split(" "):
						valid_encounter = true
				for boss: Dictionary in db.get("bosses", []):
					if boss.id == enemy_id and boss.room == layout_id:
						valid_encounter = true
				check(valid_encounter, "layout encounter has no matching room roster: "+layout_id+"/"+enemy_id)
				check(int(zone.get("count", 1)) > 0, "encounter group count must be positive: "+layout_id+"/"+enemy_id)
		for room_id: String in room_ids:
			check(layout_ids.has(room_id), "campaign room is missing its layout: "+room_id)
	check(layout_ids.size() == 64, "room layout data must cover all 64 campaign rooms")
	var weapon_ids: Dictionary = {}
	for weapon: Dictionary in db.get("weapons", []):
		var weapon_id: String = str(weapon.get("id", ""))
		check(not weapon_ids.has(weapon_id), "duplicate weapon ID: " + weapon_id)
		weapon_ids[weapon_id] = true
	check(db.get("rooms", []).size() == 64, "room array count mismatch")
	check(db.get("puzzles", []).size() == 12, "major puzzle count mismatch")
	check(db.get("minor_puzzles", []).size() == 16, "minor puzzle count mismatch")
	check(db.get("collectibles", []).size() == 56, "collectible count mismatch")
	check(db.get("weapons", []).size() == 5, "weapon count mismatch")
	print("CONTENT_CONTRACT failures=", failures,
		" rooms=", room_ids.size(), " routes=", connected_pairs.size(),
		" puzzles=", db.get("puzzles", []).size(),
		" collectibles=", db.get("collectibles", []).size())
	quit(1 if failures else 0)
