extends SceneTree

var failures := 0

func _initialize() -> void:
	call_deferred("run_checks")

func check(condition: bool, message: String) -> void:
	if not condition:
		failures += 1
		push_error(message)

func run_checks() -> void:
	var world: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/continuous_world_v4.json"))
	check(world.get("regions", []).size() == 16, "V4 geography must expose sixteen regions")
	check(world.get("edges", []).size() == 105, "V4 geography must expose all authored path links")
	var map = load("res://ui/continuous_world_map.gd").new()
	root.add_child(map)
	map.configure(world, {"TOW01": true}, "TOW01", {})
	check(map.known_points.size() == 1 and map.known_points.has("TOW-MEM"), "Atlas should reveal only landmarks linked to explored rooms")
	check(not map.known_points.has("OUT-TRAIL"), "Atlas must keep unexplored landmarks hidden")
	map.configure(world, {"TOW01": true, "TOW02": true, "TOW03": true}, "TOW03", {"BRIEFED": true})
	check(map.known_points.size() == 3, "Exploring more town rooms should reveal their corresponding landmarks")
	check(map._current_landmark_name() == "Guild Hall", "Current landmark should follow the active legacy mapping")
	check(map._requirements_met({"requires": ["BRIEFED"], "blocked": []}), "Satisfied path prerequisite should render as open")
	map.flags["WARP"] = true
	check(not map._requirements_met({"requires": [], "blocked": ["WARP"]}), "Blocked path should render as sealed after its flag")
	map.configure(world, {"TOW01": true}, "TOW01", {"WARP": true})
	check(not map.known_points.has("OUT-TRAIL"), "Warp flags must not reveal another planet or unexplored routes")
	map.zoom = 1.0
	var finger_a := InputEventScreenTouch.new()
	finger_a.index = 0
	finger_a.position = Vector2(100, 100)
	finger_a.pressed = true
	map._gui_input(finger_a)
	var finger_b := InputEventScreenTouch.new()
	finger_b.index = 1
	finger_b.position = Vector2(200, 100)
	finger_b.pressed = true
	map._gui_input(finger_b)
	var pinch := InputEventScreenDrag.new()
	pinch.index = 1
	pinch.position = Vector2(250, 100)
	map._gui_input(pinch)
	check(is_equal_approx(map.zoom, 1.5), "Touch pinch should zoom the world atlas")
	print("CONTINUOUS_WORLD_MAP_CONTRACT failures=", failures)
	quit(1 if failures else 0)
