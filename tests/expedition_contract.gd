extends SceneTree
var failures: int = 0
func check(ok: bool, message: String) -> void:
    if not ok:
        failures += 1
        push_error(message)
func _initialize() -> void:
    call_deferred("run_checks")
func run_checks() -> void:
    var game: Node2D = load("res://world/expedition.tscn").instantiate()
    game.persistence_enabled = false
    root.add_child(game)
    await physics_frame
    game.player.set_physics_process(false)
    game.load_room(3)
    check(not game.can_advance(),"Sluice bypass before solved")
    game.conductor(2)
    check(game.sequence.is_empty(),"Incorrect sequence must reset locally")
    game.conductor(1)
    game.conductor(2)
    game.conductor(3)
    check(game.flags.get("SLUICE_OPEN",false),"P01 exact solution")
    check(game.can_advance(),"Solved Sluice must unlock route")
    check(game.bridge.position.y==304,"Bridge did not move")
    game.load_room(4)
    check(not game.can_advance(),"Boss route opened before defeat")
    var boss: CharacterBody2D = game.enemies[0]
    boss.hit(320)
    check(boss.hp==320,"Boss armored outside recovery")
    boss.state = "recover"
    boss.hit(320)
    check(game.can_advance(),"Defeated boss must open Rootspan")
    check(game.pending_rewards.has("B01"),"Unclaimed boss reward must persist")
    game.load_room(3)
    game.load_room(4)
    check(game.enemies.is_empty(),"Defeated boss respawned")
    check(game.pickups.size()==1,"Unclaimed boss reward vanished on reentry")
    var ee: float = game.player.energy
    game.player.position = game.pickups[0].at
    game._process(0.016)
    check(game.player.energy==minf(100,ee+40),"Boss release credit")
    game._process(0.016)
    check(game.player.energy==minf(100,ee+40),"Duplicate reward credit")
    game.load_room(5)
    check(game.room_index==5,"Slice endpoint inaccessible")
    var save_script = load("res://systems/slice_save.gd")
    var path: String = "user://aster_automated_test.json"
    check(save_script.write_state({"probe":1},path)==OK,"First save write failed")
    check(save_script.write_state({"probe":2},path)==OK,"Save overwrite failed")
    check(save_script.read_state(path).get("probe")==2,"Save roundtrip")
    var broken := FileAccess.open(path,FileAccess.WRITE)
    broken.store_string("invalid test data")
    broken.close()
    check(save_script.read_state(path).get("probe")==1,"Backup save fallback")
    for suffix: String in ["", ".backup", ".tmp"]:
        if FileAccess.file_exists(path+suffix):
            DirAccess.remove_absolute(path+suffix)
    print("EXPEDITION_CONTRACT failures=",failures)
    quit(1 if failures else 0)
