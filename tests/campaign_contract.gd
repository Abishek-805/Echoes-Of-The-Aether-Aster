extends SceneTree
const Boss = preload("res://actors/enemies/campaign_boss.gd")
var failures: int = 0
var visited_rooms: Dictionary = {}
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
	await physics_frame
	game.player.set_physics_process(false)
	check(game.rooms.size()==64,"Full room manifest missing")
	check(game.state.visited.size()==1,"Map reveals unvisited world")
	game.toggle_map()
	check(paused and game.map_view.visible,"M map must open and pause")
	check(game.map_view.known_points.size()==1 and game.map_view.known_points.has("TOW-MEM"),"Geographic map must reveal only the discovered V4 landmark")
	game.close_panel()
	var clock: float = game.state.day_seconds
	game._process(5.0)
	check(game.state.day_seconds==clock+5,"Day/night clock not advancing")
	game.open_pause()
	game._process(5.0)
	check(game.state.day_seconds==clock+5,"Clock advanced during pause")
	game.close_panel()
	# Walk the condition graph from the reachable side. Only execute actions in rooms
	# that the currently earned flags allow; no debug flag grants or optional rewards.
	for round_index in range(100):
		var reachable: Dictionary = {game.current:true}
		var queue: Array[String] = [game.current]
		while not queue.is_empty():
			var at: String = queue.pop_front()
			for edge: Dictionary in game.connections(at):
				if game.state.allowed(edge.condition) and not reachable.has(edge.to):
					reachable[edge.to]=true
					queue.append(edge.to)
		var previous: int = game.state.flags.size()
		for id: String in reachable:
			var before_room: int = game.state.flags.size()
			game.load_room(id)
			game.close_panel()
			game.player.set_physics_process(false)
			visited_rooms[id]=true
			if id in ["TOW03","TOW04","GAT02","FIN01"]:
				game.open_console()
				game.close_panel()
				if id=="FIN01":
					for index in range(3):
						game.state.flags["STABILIZER_%d" % index]=true
			if id in ["OUT02","SIL02","SUR03"]:
				game.inspect_record()
				game.close_panel()
			for actor: CharacterBody2D in game.actors.duplicate():
				if is_instance_valid(actor) and actor is Boss:
					actor.state="recover"
					actor.hit(actor.hp)
			for puzzle: Dictionary in game.db.puzzles:
				if puzzle.room!=id or game.state.flags.get(puzzle.flag,false):
					continue
				if puzzle.id=="P09":
					game.close_panel()
					game.player.rewind_unlocked=true
					game.player.energy=100
					game.player.position=Vector2(80,282)
					game.player.rewind.cooldown=0
					game.player.rewind.clear_history()
					for index in range(180):
						game.player.position=Vector2(80+float(index)*2.1,282)
						game.player.rewind.record(game.player,1.0/60.0)
					game._process(0.016)
					check(game.rewind_switch,"Rewind trial switch not activated")
					check(game.player.rewind.begin(game.player),"Rewind could not start")
					for index in range(50):
						game.player.rewind.tick(game.player,1.0/60.0)
					game._process(0.016)
					check(game.state.flags.get("REWIND_TRAINED",false),"Rewind trial cannot be completed")
					continue
				game.open_console()
				if game.active_puzzle.is_empty():
					continue
				var steps: Array = game.PUZZLE_STEPS[puzzle.id]
				var answers: Array = steps[1].duplicate() if puzzle.id in ["P01","P04"] else []
				if answers.is_empty():
					for index in range(1,steps.size(),2):
						answers.append(steps[index][0])
				for answer: int in answers:
					game.puzzle_input(answer)
				game.close_panel()
			game.close_panel()
			if game.state.flags.size()!=before_room:
				break
		if game.state.flags.get("END_COMPLETE",false):
			break
		if game.state.flags.size()==previous:
			break
	print("FLAGS ",game.state.flags," ROOMS ",visited_rooms.keys()," CURRENT ",game.current)
	check(game.state.flags.get("END_COMPLETE",false),"Critical route did not reach the distress/refuge ending")
	check(game.state.flags.get("WARP",false),"Warp story event missing")
	check(not game.state.allowed("TUTORIAL_DONE & !WARP"),"Surface route reopened after Warp")
	check(game.player.rewind_unlocked,"Rewind acquisition missing")
	check(game.state.owned==["RIF01"],"Critical route unexpectedly needed optional weapon")
	print("CAMPAIGN_CONTRACT failures=",failures," reachable_rooms_tested=",visited_rooms.size()," ending=",game.state.flags.get("END_COMPLETE",false))
	game.close_panel()
	quit(1 if failures else 0)
