extends SceneTree

const Player = preload("res://actors/player/player.gd")

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/campaign.json"))
	var collectible_ids: Dictionary = {}
	for collectible: Dictionary in data.collectibles:
		collectible_ids[str(collectible.id)] = true
	var campaign_source: String = FileAccess.get_file_as_string("res://world/campaign.gd")
	var expected_gates: Dictionary = {
		"M02":["MAP01","BP01"],"M03":["DAWN02","MAP02"],"M04":["DAWN04","MAP03"],
		"M05":["DAWN05","BP02"],"M07":["MAP04"],"M08":["AR08","DAWN06","HP02","BP03","WPN01"],
		"M10":["MAP05","MEM04"],"M11":["AR13","BP04","WPN02"],"M13":["HP03","BP05"],"M15":["BP06","WPN03"]}
	for puzzle_id: String in expected_gates:
		check(campaign_source.contains('"'+puzzle_id+'":['),"Missing optional reward gate: "+puzzle_id)
		for collectible_id: String in expected_gates[puzzle_id]:
			check(collectible_ids.has(collectible_id),"Reward gate references missing collectible: "+collectible_id)
	check(campaign_source.contains('func open_minor_puzzle('),"Optional clue puzzles are not wired to room interactions")
	check(campaign_source.contains('func answer_minor_puzzle('),"Optional puzzle answers are not evaluated")
	check(campaign_source.contains('M07_MARKER_COMPLETE'),"Moss Hollow Titan reward is missing its two-part completion gate")
	check(campaign_source.contains('m16_shutter'),"The M16 physical Rewind shutter is missing")

	var player: CharacterBody2D = Player.new()
	root.add_child(player)
	await process_frame
	player.rewind_unlocked = true
	player.energy = 100.0
	player.set_collision_mask_value(5,true)
	for index in range(20):
		player.rewind.history.append({"at":Vector2(100.0+float(index),275.0),"velocity":Vector2.ZERO,"hp":100.0,"time":float(index)/60.0})
	check(player.rewind.begin(player),"Rewind should start with a safe recorded path")
	check(not player.get_collision_mask_value(5),"Rewind should pass through the special Fold shutter")
	player.rewind.tick(player,1.0)
	check(not player.rewind.playing,"Recorded Rewind path should finish")
	check(player.get_collision_mask_value(5),"Rewind should restore special shutter collision after playback")
	player.set_collision_mask_value(5,false)
	player.rewind.cooldown = 0.0
	for index in range(20):
		player.rewind.history.append({"at":Vector2(100.0+float(index),275.0),"velocity":Vector2.ZERO,"hp":100.0,"time":1.0+float(index)/60.0})
	check(player.rewind.begin(player),"Second safe Rewind path should start")
	player.rewind.clear_history(player)
	check(not player.get_collision_mask_value(5),"Clearing history should restore the originally disabled shutter mask")
	print("MINOR_PUZZLE_CONTRACT failures=",failures," reward_groups=",expected_gates.size())
	quit(1 if failures else 0)
