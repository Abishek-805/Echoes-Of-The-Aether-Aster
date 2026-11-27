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
	game.stories_enabled = false
	root.add_child(game)
	await process_frame
	game.player.set_physics_process(false)
	check(game.room_layouts.size() == 24, "The first 24 rooms should use authored layout specs")
	var checked: Dictionary = {}
	for layout: Dictionary in game.layout_db.rooms:
		var id: String = str(layout.id)
		checked[id] = true
		game.load_room(id)
		var static_bodies: int = 0
		for child: Node in game.room.get_children():
			if child is StaticBody2D:
				static_bodies += 1
		check(static_bodies == layout.platforms.size()+1,"Unexpected floor/platform count in "+id)
		for platform: Dictionary in layout.platforms:
			check(float(platform.x) > 45 and float(platform.x) < 595,"Platform blocks an exit approach in "+id)
		for item: Dictionary in game.db.collectibles:
			if item.room != id or game.state.collected.has(item.id):
				continue
			if id == "ROT04" and not game.state.flags.get("TITAN_DOWN",false):
				continue
			for landmark: Dictionary in layout.landmarks:
				if landmark.id != item.id:
					continue
				var pickup_found: bool = false
				for pickup: Dictionary in game.pickups:
					if pickup.id == item.id and pickup.at == Vector2(float(landmark.x),float(landmark.y)):
						pickup_found = true
				check(pickup_found,"Collectible is not anchored to its authored landmark: "+str(item.id))
	check(checked.size() == 24,"Layout iteration missed a room")
	print("ROOM_LAYOUT_CONTRACT failures=", failures, " rooms=", checked.size())
	quit(1 if failures else 0)
