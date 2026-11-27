extends Node

const CampaignScene = preload("res://world/campaign.tscn")

var failures: int = 0
var game: Node2D

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func has_pickup(id: String) -> bool:
	for pickup: Dictionary in game.pickups:
		if str(pickup.id) == id:
			return true
	return false

func _ready() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	game = CampaignScene.instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	add_child(game)
	await get_tree().physics_frame
	game.player.set_physics_process(false)

	game.load_room("OUT04")
	check(not has_pickup("MAP01") and not has_pickup("BP01"),"M02 rewards should stay hidden before solving the cache clue")
	game.open_minor_puzzle("OUT04")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(1)
	check(game.state.flags.get("M02_CACHE_OPEN",false),"Correct M02 evidence should open the Hunter Cache")
	check(has_pickup("MAP01") and has_pickup("BP01"),"M02 map and blueprint should appear after solving")

	game.load_room("HUN04")
	game.open_minor_puzzle("HUN04")
	game.answer_minor_puzzle(2)
	check(game.minor_puzzle_stage == 0 and not game.state.flags.get("M03_BLIND_FOUND",false),"Wrong M03 choice should reset the local trail")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(1)
	game.answer_minor_puzzle(0)
	check(game.state.flags.get("M03_BLIND_FOUND",false),"Correct M03 trail should identify the blind")
	check(has_pickup("DAWN02") and has_pickup("MAP02"),"M03 rewards should appear when its trail is completed")

	game.load_room("ROT04")
	game.state.flags.WARDEN_DOWN = true
	game.open_titan_marker()
	game.modal_box.get_child(2).emit_signal("pressed")
	check(game.state.flags.get("M07_MARKER_SEEN",false),"M07 marker should record the Warden pulse")
	game.enemy_defeated("B02",Vector2.ZERO)
	check(game.state.flags.get("M07_MARKER_COMPLETE",false),"M07 should complete after marker plus Titan defeat")
	check(has_pickup("MAP04"),"M07 map reward should appear only after both steps")

	game.load_room("FOL02")
	game.player.rewind_unlocked = true
	game.player.energy = 100.0
	game.player.rewind.cooldown = 0.0
	game.player.position.x = 505.0
	for index in range(20):
		game.player.rewind.history.append({"at":Vector2(100.0+float(index),275.0),"velocity":Vector2.ZERO,"hp":100.0,"time":float(index)/60.0})
	game._process(0.016)
	check(game.m16_gate_activated and game.player.get_collision_mask_value(5),"Crossing the ready M16 latch should close its physical shutter")
	game.player.rewind.playing = true
	game._process(0.016)
	game.player.rewind.playing = false
	game.player.position.x = 100.0
	game._process(0.016)
	check(game.state.flags.get("REWIND_RETURN_OPEN",false),"Returning through M16 with Rewind should open its shortcut")
	check(not game.player.get_collision_mask_value(5),"Completed M16 should clear the temporary shutter collision mask")

	print("OPTIONAL_PUZZLE_INTEGRATION failures=",failures)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
