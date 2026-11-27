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
