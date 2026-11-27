extends SceneTree

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var State = load("res://systems/campaign_state.gd")
	var source = State.new()
	source.flags = {"INTRO_DONE": true, "WARP": true}
	source.visited = {"TOW01": true}
	source.collected = {"AR01": "Release house custom"}
	source.owned = ["RIF01", "WPN01"]
	source.equipped = "WPN01"
	source.energy = 84
	source.hp = 67
	source.heal_charges = 1
	source.rewind_cooldown = 9.5
	source.thermal = {"WPN01": {"heat": 31.0, "locked": false, "since": 2.0, "cooling": 30.0}}
	var valid_data: Dictionary = source.serialize()
	var restored = State.new()
	check(restored.restore(valid_data, ["TOW01", "OUT01"]), "Valid save did not restore")
	check(restored.equipped == "WPN01" and restored.owned.has("WPN01"), "Owned equipped weapon was not restored")
	check(restored.energy == 84 and restored.flags.get("WARP", false), "Progress or energy did not restore")
	check(restored.hp == 67 and restored.heal_charges == 1, "Health or heal charges did not restore")
	check(is_equal_approx(restored.rewind_cooldown, 9.5), "Rewind cooldown did not survive save/load")

	var documented_data: Dictionary = valid_data.duplicate(true)
	documented_data["flags"] = ["INTRO_DONE", "WARP"]
	var migrated = State.new()
	check(migrated.restore(documented_data, ["TOW01", "OUT01"]), "Documented flag-array save did not migrate")
	check(migrated.flags.get("WARP", false), "Migrated flag was lost")
	var v2_example: Dictionary = {
		"schema_version": 2, "checkpoint": "OUT01", "hp_max": 120, "hp": 73,
		"ee_capacity": 120, "ee": 82, "heal_charges": 2,
		"weapons_owned": ["RIF01", "WPN02"], "equipped": "WPN02",
		"weapon_heat": {"WPN02": 27.0}, "flags": ["BRIEFED", "WARP"],
		"unique_collected": ["AR01"], "released_echo_tokens": ["E01:OUT01"],
		"maps_seen": ["OUT01"], "archive_ids": [], "upgrades": ["BP01"],
		"materials": {"alloy": 2, "biological": 0, "relic": 1}}
	var v2_restored = State.new()
	check(v2_restored.restore(v2_example, ["TOW01", "OUT01"]), "Documented V2 save example did not migrate")
	check(v2_restored.hp == 73 and v2_restored.energy == 82 and v2_restored.owned.has("WPN02"), "Documented V2 player state was not migrated")
	check(v2_restored.collected.has("AR01") and v2_restored.released.has("E01:OUT01"), "Documented V2 durable IDs were not migrated")

	var invalid_cases: Array[Dictionary] = []
	var invalid_checkpoint: Dictionary = valid_data.duplicate(true)
	invalid_checkpoint.checkpoint = "NOT_A_ROOM"
	invalid_cases.append(invalid_checkpoint)
	var invalid_weapon: Dictionary = valid_data.duplicate(true)
	invalid_weapon.equipped = "WPN03"
	invalid_cases.append(invalid_weapon)
	var invalid_energy: Dictionary = valid_data.duplicate(true)
	invalid_energy.energy = 500
	invalid_cases.append(invalid_energy)
	var invalid_hp: Dictionary = valid_data.duplicate(true)
	invalid_hp.hp = 0
	invalid_cases.append(invalid_hp)
	var invalid_flags: Dictionary = valid_data.duplicate(true)
	invalid_flags.flags = {"WARP": "yes"}
	invalid_cases.append(invalid_flags)
	var invalid_thermal: Dictionary = valid_data.duplicate(true)
	invalid_thermal.thermal = {"WPN01": {"heat": 999.0, "locked": false, "since": 1.0, "cooling": 30.0}}
	invalid_cases.append(invalid_thermal)
	for index: int in range(invalid_cases.size()):
		var target = State.new()
		target.flags = {"KEEP": true}
		check(not target.restore(invalid_cases[index], ["TOW01", "OUT01"]), "Invalid save case %d was accepted" % index)
		check(target.flags.get("KEEP", false), "Rejected save partially mutated state in case %d" % index)

	var save_script = load("res://systems/slice_save.gd")
	var path: String = "user://campaign_state_fallback_contract.json"
	var bad_state: Dictionary = valid_data.duplicate(true)
	bad_state.checkpoint = "NO_SUCH_ROOM"
	check(save_script.write_state(valid_data, path) == OK, "Could not write valid backup candidate")
	check(save_script.write_state(bad_state, path) == OK, "Could not write invalid primary candidate")
	var candidates: Array[Dictionary] = save_script.read_candidates(path)
	var fallback = State.new()
	var recovered: bool = false
	for candidate: Dictionary in candidates:
		if fallback.restore(candidate, ["TOW01", "OUT01"]):
			recovered = true
			break
	check(recovered and fallback.flags.get("WARP", false), "Semantically invalid primary masked the valid backup")
	for suffix: String in ["", ".backup", ".tmp"]:
		if FileAccess.file_exists(path+suffix):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(path+suffix))

	print("CAMPAIGN_STATE_CONTRACT failures=", failures)
	quit(1 if failures else 0)
