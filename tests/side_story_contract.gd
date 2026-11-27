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
	var Tracker = load("res://systems/side_story_tracker.gd")
	var survey = State.new()
	survey.visited["TOW03"] = true
	for index: int in range(1, 8):
		survey.collected["DAWN%02d" % index] = "survey record"
	Tracker.refresh(survey)
	check(not survey.flags.get("SIDE_LAST_SURVEY_DONE", false), "The Last Survey completed before all eight records")
	survey.collected["DAWN08"] = "survey record"
	var completed: Array[String] = Tracker.refresh(survey)
	check(completed.has("The Last Survey") and survey.flags.get("SIDE_LAST_SURVEY_DONE", false), "The Last Survey did not complete on its eighth record")
	check(Tracker.refresh(survey).is_empty(), "A completed story awarded completion repeatedly")
	check(Tracker.journal_text(survey).contains("The Last Survey — COMPLETE"), "Completed story missing from journal")

	var hunters = State.new()
	hunters.visited["HUN04"] = true
	hunters.collected["DAWN02"] = "departure tag"
	check(Tracker.refresh(hunters).is_empty(), "Hunter's Return completed without its report")
	hunters.collected["DAWN04"] = "lost pack report"
	Tracker.refresh(hunters)
	check(hunters.flags.get("SIDE_HUNTERS_RETURN_DONE", false), "Hunter's Return did not complete")
	check(hunters.materials.alloy == 2 and hunters.materials.biological == 2, "Hunter's Return material reward missing")
	Tracker.refresh(hunters)
	check(hunters.materials.alloy == 2 and hunters.materials.biological == 2, "Hunter's Return reward duplicated")

	var all_stories = State.new()
	for room_id: String in ["TOW03","SIL04","ROT03","HUN04","FOL01","FOL04","VER02"]:
		all_stories.visited[room_id] = true
	for record_id: String in ["DAWN01","DAWN02","DAWN03","DAWN04","DAWN05","DAWN06","DAWN07","DAWN08",
			"AR14","AR16","MEM03","HP01","MEM02","AR20","AR21","HP04","MAP06","MEM05","AR12","AR13"]:
		all_stories.collected[record_id] = "evidence"
	for flag_id: String in ["KEEPER_PROMISE_SOLVED","GARDEN_RESTORED","PREDATOR_LATCH_SOLVED","DEVOURER_DOWN"]:
		all_stories.flags[flag_id] = true
	completed = Tracker.refresh(all_stories)
	check(completed.size() == 7, "All seven completed side stories were not recognized")
	check(Tracker.journal_text(all_stories).count("— COMPLETE") == 7, "Journal does not show all seven completed side stories")
	print("SIDE_STORY_CONTRACT failures=", failures)
	quit(1 if failures else 0)
