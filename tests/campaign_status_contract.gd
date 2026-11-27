extends SceneTree

var failures: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var game: Node2D = load("res://world/campaign.tscn").instantiate()
	game.persistence_enabled = false
	root.add_child(game)
	await process_frame
	if game.story_sequence.busy:
		game.story_sequence.finish_scene()
	check(game.combat_status_hud != null, "Combat status HUD missing")
	check(game.rewind_status_text() == "REWIND: LOCKED", "Rewind lock state is not visible")
	game.player.rewind_unlocked = true
	game.player.energy = 60
	game.player.rewind.clear_history()
	check(game.rewind_status_text().begins_with("REWIND: RECORDING"), "Short history should show recording")
	game.player.rewind.history.resize(15)
	check(game.rewind_status_text() == "REWIND: READY · 25 EE", "Ready Rewind state/cost is not visible")
	game.player.energy = 20
	check(game.rewind_status_text() == "REWIND: NEED 25 EE", "Insufficient Rewind energy is not visible")
	game.player.energy = 60
	game.player.rewind.cooldown = 4.25
	check(game.rewind_status_text() == "REWIND: COOLING 4.3s", "Rewind cooldown is not visible")
	game.player.rewind.cooldown = 0
	game.player.rewind.playing = true
	check(game.rewind_status_text() == "REWIND: ACTIVE", "Active Rewind state is not visible")
	game.player.rewind.playing = false
	game.player.overheated = true
	check(game.weapon_status_text() == "WEAPON HOT · COOLING", "Overheat warning is not visible")
	game.player.overheated = false
	check(game.weapon_status_text() == "WEAPON READY", "Weapon cooling completion state is not visible")
	print("CAMPAIGN_STATUS_CONTRACT failures=", failures)
	quit(1 if failures else 0)
