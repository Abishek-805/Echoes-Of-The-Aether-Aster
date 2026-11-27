extends RefCounted

const STORIES: Array[Dictionary] = [
	{"id":"LAST_SURVEY", "title":"The Last Survey", "flag":"SIDE_LAST_SURVEY_DONE",
		"start_rooms":["TOW03"], "records":["DAWN01","DAWN02","DAWN03","DAWN04","DAWN05","DAWN06","DAWN07","DAWN08"],
		"summary":"Riven's team reached the vault before the Warp shifted its route. The records preserve how the expedition failed."},
	{"id":"KEEPERS_PROMISE", "title":"A Keeper's Promise", "flag":"SIDE_KEEPERS_PROMISE_DONE",
		"start_rooms":["SIL04"], "records":["AR14","AR16","MEM03"], "flags":["KEEPER_PROMISE_SOLVED"],
		"summary":"Seren's imprint and memorial agree: the Keeper protected a safe release, not a sealed Echo."},
	{"id":"FORGOTTEN_GARDEN", "title":"The Forgotten Garden", "flag":"SIDE_GARDEN_DONE",
		"start_rooms":["ROT03"], "records":["HP01","MEM02"], "flags":["GARDEN_RESTORED"],
		"summary":"Restoring the old water route revives the sanctuary garden and opens its return shortcut."},
	{"id":"HUNTERS_RETURN", "title":"A Hunter's Return", "flag":"SIDE_HUNTERS_RETURN_DONE",
		"start_rooms":["HUN04","CAM04"], "records":["DAWN02","DAWN04"],
		"summary":"The recovered tag and lost-pack report keep the missing hunter's account with the expedition records.",
		"materials":{"alloy":2,"biological":2}},
	{"id":"FIRST_WARNING", "title":"The First Warning", "flag":"SIDE_FIRST_WARNING_DONE",
		"start_rooms":["SIL04","FOL01","FOL03"], "records":["AR16","AR20","AR21"],
		"summary":"Three records warn that concentrating Echoes destabilized the network; they hint at the Vaelari failure without resolving it."},
	{"id":"UNMARKED_PREDATOR", "title":"The Unmarked Predator", "flag":"SIDE_PREDATOR_DONE",
		"start_rooms":["FOL04"], "records":["HP04","MAP06","MEM05"], "flags":["PREDATOR_LATCH_SOLVED","DEVOURER_DOWN"],
		"summary":"The latch trail and the Devourer's feeding ground show how the creature consumes Echoes to survive."},
	{"id":"ENGINEERS_TRACE", "title":"The Engineer's Trace", "flag":"SIDE_ENGINEERS_TRACE_DONE",
		"start_rooms":["VER02","VER04"], "records":["AR12","AR13"],
		"summary":"The anonymous researcher documented a distant engineer's repair interface. It is a clue for Orion, not a usable repair part for Aster."}
]

static func refresh(state: RefCounted) -> Array[String]:
	var completed_now: Array[String] = []
	for story: Dictionary in STORIES:
		var completion_flag: String = story.flag
		if state.flags.get(completion_flag, false) or not is_started(story, state):
			continue
		var requirements: Array[Dictionary] = _requirements(story)
		var all_complete: bool = true
		for requirement: Dictionary in requirements:
			if not _satisfied(requirement, state):
				all_complete = false
				break
		if not all_complete:
			continue
		state.flags[completion_flag] = true
		for material: String in story.get("materials", {}):
			state.materials[material] = int(state.materials.get(material, 0)) + int(story.materials[material])
		completed_now.append(str(story.title))
	return completed_now

static func journal_text(state: RefCounted) -> String:
	var lines: Array[String] = []
	for story: Dictionary in STORIES:
		var title: String = str(story.title)
		if state.flags.get(story.flag, false):
			lines.append("✓ %s — COMPLETE\n  %s" % [title, story.summary])
		elif is_started(story, state):
			var requirements: Array[Dictionary] = _requirements(story)
			var found: int = 0
			for requirement: Dictionary in requirements:
				if _satisfied(requirement, state):
					found += 1
			lines.append("◌ %s — %d/%d evidence\n  %s" % [title, found, requirements.size(), _next_clue(story, state)])
		else:
			lines.append("? %s — undiscovered" % title)
	return "OPTIONAL STORIES\n" + "\n\n".join(lines)

static func is_started(story: Dictionary, state: RefCounted) -> bool:
	for room_id: String in story.get("start_rooms", []):
		if state.visited.has(room_id):
			return true
	for record_id: String in story.get("records", []):
		if state.collected.has(record_id):
			return true
	return false

static func _requirements(story: Dictionary) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for record_id: String in story.get("records", []):
		result.append({"type":"record", "id":record_id})
	for flag_id: String in story.get("flags", []):
		result.append({"type":"flag", "id":flag_id})
	return result

static func _satisfied(requirement: Dictionary, state: RefCounted) -> bool:
	if requirement.type == "record":
		return state.collected.has(requirement.id)
	return bool(state.flags.get(requirement.id, false))

static func _next_clue(story: Dictionary, state: RefCounted) -> String:
	for requirement: Dictionary in _requirements(story):
		if _satisfied(requirement, state):
			continue
		if requirement.type == "record":
			return "Record still missing: %s." % requirement.id
		return "Complete the local world action: %s." % requirement.id
	return "All evidence found. Reopen the journal to confirm the story entry."
