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
	check(_collect(game,"AR01"), "First field record should be physically collectible")
	check(game.state.collected.has("AR01"), "Collected field record was not saved to state")
	check(not _collect(game,"AR01"), "Collected item spawned or granted twice")
	game.state.flags.GARDEN_RESTORED = true
	game.load_room("ROT03")
	game.player.max_hp = 100.0
	game.player.hp = 60.0
	check(_collect(game,"HP01"), "Health shard was not collectible")
	check(is_equal_approx(game.player.max_hp,110.0), "Health shard did not increase maximum health")
	check(is_equal_approx(game.player.hp,70.0), "Health shard did not restore its health amount")
	game.load_room("REL04")
	check(not _collect(game,"BP03") and not _collect(game,"WPN01"), "Storage Loft rewards should remain hidden before M08")
	game.open_minor_puzzle("REL04")
	game.answer_minor_puzzle(0)
	game.answer_minor_puzzle(1)
	check(_collect(game,"BP03"), "Blueprint was not collectible")
	check(game.state.materials.alloy==4 and game.state.materials.relic==1, "Blueprint materials were not awarded")
	check(_collect(game,"WPN01"), "Weapon was not collectible")
	check(game.state.owned.has("WPN01"), "Weapon pickup did not unlock its weapon")
	print("PICKUP_CONTRACT failures=", failures)
	quit(1 if failures else 0)

func _collect(game: Node2D, id: String) -> bool:
	for pickup: Dictionary in game.pickups:
		if pickup.id == id:
			game.player.position = pickup.at
			return game.collect_nearby_pickup()
	return false
