extends SceneTree

const STORY_PATH := "res://data/story_scenes.json"
const StorySequence = preload("res://systems/story_sequence.gd")
const REQUIRED := [
	"CIN01_TOWN", "GUILD_BRIEFING", "ARTIFICER_TUTORIAL", "ECHO_WARP",
	"SURVEY_CAMP", "SURVEY_VAULT", "VERAYAN_RECORD", "SILENT_GALLERY",
	"RESERVOIR_RECORD", "ECHO_REWIND", "NALORA_FRAGMENT", "FINAL_WARNING",
	"FOLD_GUARDIAN", "BROKEN_GATE", "DISTRESS_REFUGE"
]

func _initialize() -> void:
	await process_frame
	var errors: PackedStringArray = []
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(STORY_PATH))
	if not parsed is Dictionary:
		quit(1)
		return
	var scenes: Dictionary = parsed.get("scenes", {})
	var all_ids: Dictionary = {}
	for scene_id: String in REQUIRED:
		if not scenes.has(scene_id):
			errors.append("Missing required scene: %s" % scene_id)
	for scene_id: String in scenes:
		var scene_data: Dictionary = scenes[scene_id]
		if str(scene_data.get("title", "")).is_empty():
			errors.append("%s has no title" % scene_id)
		if str(scene_data.get("complete_flag", "")).is_empty():
			errors.append("%s has no completion flag" % scene_id)
		var lines: Array = scene_data.get("lines", [])
		if lines.is_empty():
			errors.append("%s has no lines" % scene_id)
		for line: Dictionary in lines:
			var line_id: String = str(line.get("id", ""))
			if line_id.is_empty() or all_ids.has(line_id):
				errors.append("Missing or duplicate line ID: %s" % line_id)
			all_ids[line_id] = true
			if str(line.get("speaker", "")).is_empty() or str(line.get("text", "")).is_empty():
				errors.append("%s contains an empty speaker or line (%s)" % [scene_id, line_id])
	for error: String in errors:
		push_error(error)
	var presenter = StorySequence.new()
	root.add_child(presenter)
	await process_frame
	if not presenter.play("CIN01_TOWN"):
		errors.append("Presenter refused a known scene")
	else:
		if not paused:
			errors.append("Presenter did not pause the game")
		for _i in 4:
			presenter.advance()
		if presenter.busy or paused:
			errors.append("Presenter did not finish/restore pause after advancing")
	print("STORY_CONTRACT scenes=%d lines=%d errors=%d" % [scenes.size(), all_ids.size(), errors.size()])
	for error: String in errors:
		print("STORY_ERROR ", error)
	quit(0 if errors.is_empty() else 1)
