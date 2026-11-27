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
	var ids: Dictionary = {}
	for puzzle: Dictionary in game.db.puzzles:
		var id: String = str(puzzle.id)
		ids[id] = true
		game.active_puzzle = puzzle
		var nudge: String = game.puzzle_hint_text(1)
		var clues: String = game.puzzle_hint_text(2)
		var solution: String = game.puzzle_hint_text(3)
		check(not nudge.is_empty() and not clues.is_empty() and not solution.is_empty(),"Missing hint tier for "+id)
		check(solution == str(puzzle.solution),"Explicit hint tier disagrees with puzzle data for "+id)
		check(nudge != solution,"First hint reveals full answer for "+id)
		check(clues != solution,"Second hint reveals explicit answer for "+id)
	check(ids.size() == 12, "Hint content does not cover all 12 major puzzles")
	var first: Dictionary = game.db.puzzles[0]
	game.active_puzzle = first
	game.current = first.room
	game.show_puzzle()
	var opening_text: String = str(game.modal_box.get_child(1).text)
	check(not opening_text.contains(str(first.solution)),"Puzzle panel reveals the answer before a hint is requested")
	game.advance_puzzle_hint()
	check(game.puzzle_hint_stage == 1,"First hint request did not advance to tier one")
	check(str(game.modal_box.get_child(1).text) == game.puzzle_hint_text(1),"Tier one hint text was not shown")
	game.advance_puzzle_hint()
	check(game.puzzle_hint_stage == 2,"Second hint request did not advance to tier two")
	game.advance_puzzle_hint()
	check(game.puzzle_hint_stage == 3,"Third hint request did not advance to tier three")
	check(str(game.modal_box.get_child(1).text) == str(first.solution),"Third hint did not reveal the explicit solution")
	game.close_panel()
	print("PUZZLE_HINT_CONTRACT failures=", failures, " puzzles=", ids.size())
	quit(1 if failures else 0)
