extends RefCounted

const PATH := "user://aster_campaign_v1.json"
const Store = preload("res://systems/slice_save.gd")
const WEAPONS := ["RIF01", "WPN01", "WPN02", "WPN03"]
const MATERIALS := ["alloy", "biological", "relic"]

var generation: int = 0
var equipped: String = "RIF01"
var thermal: Dictionary = {}
var defeated: Dictionary = {}
var flags: Dictionary = {}
var visited: Dictionary = {}
var collected: Dictionary = {}
var released: Dictionary = {}
var pending: Dictionary = {}
var checkpoint: String = "TOW01"
var day_seconds: float = 360.0
var owned: Array = ["RIF01"]
var upgrades: Dictionary = {}
var materials: Dictionary = {"alloy": 0, "biological": 0, "relic": 0}
var energy: float = 60
var max_hp: float = 100
var hp: float = 100
var heal_charges: int = 3
var capacity: float = 100
var rewind_cooldown: float = 0

func allowed(expression: String) -> bool:
	if expression.strip_edges() in ["", "—", "-", "–"]:
		return true
	for term: String in expression.split("&"):
		term = term.strip_edges()
		if term.begins_with("!"):
			if flags.get(term.substr(1), false):
				return false
		elif not flags.get(term, false):
			return false
	return true

func serialize() -> Dictionary:
	return {"schema_version": 2, "generation": generation, "equipped": equipped, "thermal": thermal,
		"defeated": defeated, "flags": flags, "visited": visited, "collected": collected,
		"released": released, "pending": pending, "checkpoint": checkpoint,
		"day_seconds": day_seconds, "owned": owned, "upgrades": upgrades,
		"materials": materials, "energy": energy, "max_hp": max_hp, "hp": hp,
		"heal_charges": heal_charges, "capacity": capacity, "rewind_cooldown": rewind_cooldown}

func restore(data: Dictionary, room_ids: Array) -> bool:
	if data.is_empty():
		return false
	data = _normalize_legacy_fields(data)
	var saved_checkpoint: Variant = data.get("checkpoint", "TOW01")
	if not saved_checkpoint is String or not room_ids.has(saved_checkpoint):
		return false
	var saved_flags: Variant = data.get("flags", {})
	# V2 design examples used an array of flag names; migrate that representation safely.
	if saved_flags is Array:
		var migrated_flags: Dictionary = {}
		for flag: Variant in saved_flags:
			if not flag is String or flag.is_empty():
				return false
			migrated_flags[flag] = true
		saved_flags = migrated_flags
	if not _bool_map(saved_flags) or not _bool_map(data.get("visited", {})) \
			or not _bool_map(data.get("released", {})) or not _bool_map(data.get("defeated", {})) \
			or not _bool_map(data.get("upgrades", {})):
		return false
	var saved_collected: Variant = data.get("collected", {})
	if not saved_collected is Dictionary:
		return false
	for value: Variant in saved_collected.values():
		if not value is String:
			return false
	var saved_pending: Variant = data.get("pending", {})
	if not saved_pending is Dictionary:
		return false
	var saved_thermal: Variant = data.get("thermal", {})
	if not _valid_thermal(saved_thermal):
		return false
	var saved_materials: Variant = data.get("materials", {"alloy": 0, "biological": 0, "relic": 0})
	if not _valid_materials(saved_materials):
		return false
	var saved_owned: Variant = data.get("owned", ["RIF01"])
	if not saved_owned is Array:
		return false
	var owned_set: Dictionary = {}
	for weapon: Variant in saved_owned:
		if not weapon is String or not WEAPONS.has(weapon):
			return false
		owned_set[weapon] = true
	if not owned_set.has("RIF01"):
		return false
	var saved_equipped: Variant = data.get("equipped", "RIF01")
	if not saved_equipped is String or not owned_set.has(saved_equipped):
		return false
	var saved_generation: Variant = data.get("generation", 0)
	var saved_day: Variant = data.get("day_seconds", 360.0)
	var saved_energy: Variant = data.get("energy", 60.0)
	var saved_max_hp: Variant = data.get("max_hp", 100.0)
	var saved_hp: Variant = data.get("hp", data.get("max_hp", 100.0))
	var saved_heal_charges: Variant = data.get("heal_charges", 3)
	var saved_capacity: Variant = data.get("capacity", 100.0)
	var saved_rewind_cooldown: Variant = data.get("rewind_cooldown", 0.0)
	if not _number_in_range(saved_generation, 0, 1000000) \
			or not _number_in_range(saved_day, 0, 1000000000) \
			or not _number_in_range(saved_energy, 0, 120) \
			or not _number_in_range(saved_max_hp, 100, 140) \
			or not _number_in_range(saved_hp, 1, float(saved_max_hp)) \
			or not _number_in_range(saved_heal_charges, 0, 3) \
			or not _number_in_range(saved_capacity, 100, 120) \
			or not _number_in_range(saved_rewind_cooldown, 0, 60):
		return false
	if float(saved_energy) > float(saved_capacity):
		return false

	# Assign only after the whole save has passed validation, avoiding partial restore.
	generation = int(saved_generation)
	equipped = saved_equipped
	thermal = saved_thermal
	defeated = data.get("defeated", {})
	flags = saved_flags
	visited = data.get("visited", {})
	collected = saved_collected
	released = data.get("released", {})
	pending = saved_pending
	checkpoint = saved_checkpoint
	day_seconds = fposmod(float(saved_day), 1440.0)
	owned = saved_owned.duplicate()
	upgrades = data.get("upgrades", {})
	materials = saved_materials
	energy = float(saved_energy)
	max_hp = float(saved_max_hp)
	hp = float(saved_hp)
	heal_charges = int(saved_heal_charges)
	capacity = float(saved_capacity)
	rewind_cooldown = float(saved_rewind_cooldown)
	return true

func _bool_map(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for entry: Variant in value.values():
		if not entry is bool:
			return false
	return true

func _valid_materials(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for material: String in MATERIALS:
		if not _number_in_range(value.get(material, 0), 0, 1000000):
			return false
	return true

func _valid_thermal(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for weapon: Variant in value:
		if not weapon is String or not WEAPONS.has(weapon) or not value[weapon] is Dictionary:
			return false
		var state: Dictionary = value[weapon]
		if not _number_in_range(state.get("heat", 0.0), 0, 100) \
				or not _number_in_range(state.get("since", 10.0), 0, 100000) \
				or not _number_in_range(state.get("cooling", 25.0), 0, 1000):
			return false
		if state.get("locked", false) is not bool:
			return false
	return true

func _number_in_range(value: Variant, low: float, high: float) -> bool:
	if not value is int and not value is float:
		return false
	var numeric: float = float(value)
	return is_finite(numeric) and numeric >= low and numeric <= high

func _normalize_legacy_fields(source: Dictionary) -> Dictionary:
	var data: Dictionary = source.duplicate(true)
	for alias: Array in [
		["max_hp", "hp_max"], ["energy", "ee"], ["capacity", "ee_capacity"],
		["owned", "weapons_owned"], ["collected", "unique_collected"],
		["released", "released_echo_tokens"], ["visited", "maps_seen"],
		["thermal", "weapon_heat"]]:
		if not data.has(alias[0]) and data.has(alias[1]):
			data[alias[0]] = data[alias[1]]
	for key: String in ["collected", "released", "visited", "upgrades"]:
		if data.get(key) is Array:
			var migrated: Dictionary = {}
			for item: Variant in data[key]:
				if item is String and not item.is_empty():
					migrated[item] = "" if key == "collected" else true
			data[key] = migrated
	if data.get("thermal") is Dictionary:
		var thermal_map: Dictionary = {}
		for weapon: Variant in data.thermal:
			var weapon_state: Variant = data.thermal[weapon]
			if weapon_state is int or weapon_state is float:
				thermal_map[weapon] = {"heat": float(weapon_state), "locked": float(weapon_state) >= 100.0,
					"since": 10.0, "cooling": 25.0}
			else:
				thermal_map[weapon] = weapon_state
		data.thermal = thermal_map
	return data

func save() -> Error:
	return Store.write_state(serialize(), PATH)
