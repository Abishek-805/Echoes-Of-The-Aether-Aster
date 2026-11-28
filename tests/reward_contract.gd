extends SceneTree

var failures: int = 0

func check(value: bool, message: String) -> void:
	if not value:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_contract")

func run_contract() -> void:
	var game: Node2D = load("res://world/campaign.tscn").instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	root.add_child(game)
	await process_frame
	game.load_room("OUT02")
	game.player.energy = 10.0
	game.encounters["OUT02:E01:0"] = {"energy":8.0,"material":"alloy","reward_token":"OUT02:E01"}
	game.enemy_defeated("OUT02:E01:0", Vector2.ZERO)
	check(is_equal_approx(game.player.energy,10.0), "Defeating an enemy should not automatically award Echo Energy")
	check(game.state.materials.alloy == 1, "First defeat should award its material once")
	check(game.state.pending.has("OUT02:E01"), "Enemy defeat should create a persistent pending Echo drop")
	var first_drop: Dictionary = _echo_pickup(game, "OUT02:E01")
	check(not first_drop.is_empty(), "Enemy Echo should appear as a world pickup")
	if not first_drop.is_empty():
		game.player.position = first_drop.at
		check(game.collect_nearby_pickup(), "Aster should collect the enemy Echo")
	check(is_equal_approx(game.player.energy,18.0), "Collecting the Echo should add its energy once")
	check(game.state.released.has("OUT02:E01"), "Stable enemy reward token should be recorded on release")
	game.generation = 1
	game.player.energy = 5.0
	game.encounters["OUT02:E01:1"] = {"energy":8.0,"material":"alloy","reward_token":"OUT02:E01"}
	game.enemy_defeated("OUT02:E01:1", Vector2.ZERO)
	check(is_equal_approx(game.player.energy,5.0), "Defeating a respawned enemy must not award Echo Energy automatically")
	check(game.state.materials.alloy == 1, "Rested enemy duplicated material")
	check(game.state.released.has("OUT02:E01"), "Reward ledger lost the stable token")
	print("REWARD_CONTRACT failures=", failures)
	quit(1 if failures else 0)

func _echo_pickup(game: Node2D, token: String) -> Dictionary:
	for pickup: Dictionary in game.pickups:
		if str(pickup.get("kind", "")) == "echo" and str(pickup.get("id", "")) == token:
			return pickup
	return {}
