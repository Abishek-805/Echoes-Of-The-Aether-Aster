extends SceneTree

const CampaignEnemy = preload("res://actors/enemies/campaign_enemy.gd")
var failures: int = 0
var marked: Array[Dictionary] = []

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var expected_marks: Dictionary = {
		"E02": "wave", "E03": "pool", "E04": "beam", "E05": "charge",
		"E06": "wave", "E07": "drain", "E08": "fold"
	}
	for id: String in expected_marks:
		var target := CharacterBody2D.new()
		target.position = Vector2(250.0, 280.0)
		target.set_physics_process(false)
		root.add_child(target)
		var enemy: CharacterBody2D = CampaignEnemy.new()
		enemy.archetype = id
		enemy.attack_damage = 15.0
		enemy.hp = 100.0
		enemy.position = Vector2(330.0, 280.0)
		enemy.target = target
		enemy.marked_attack.connect(_on_marked_attack)
		root.add_child(enemy)
		await process_frame
		enemy.set_physics_process(false)
		marked.clear()
		enemy.state = "guard" if id == "E04" else "approach"
		enemy.special_timer = 0.0
		enemy._physics_process(0.01)
		check(enemy.state == "tell", id+" should use a visible attack tell")
		check(not marked.is_empty(), id+" should emit a telegraphed attack")
		if not marked.is_empty():
			check(str(marked[0].kind) == str(expected_marks[id]), id+" should use its authored attack type")
			check(float(marked[0].delay) >= 0.65, id+" should leave time to react")
		if id in ["E02", "E06"]:
			var initial_hp: float = enemy.hp
			enemy.hit(10.0)
			check(is_equal_approx(enemy.hp, initial_hp), id+" armor should block damage outside recovery")
			enemy.timer = 0.01
			enemy._physics_process(0.02)
			enemy.hit(10.0)
			check(is_equal_approx(enemy.hp, initial_hp-10.0), id+" should expose its core during recovery")
		if id == "E05":
			var direction: float = enemy.committed
			target.position.x = 600.0
			enemy.timer = 0.01
			enemy._physics_process(0.02)
			enemy._physics_process(0.1)
			check(enemy.state == "lunge", "Sentinel should lunge after its warning")
			check(is_equal_approx(enemy.velocity.x, direction*350.0), "Sentinel should keep its locked charge direction")
		if id == "E08":
			enemy.timer = 0.01
			enemy._physics_process(0.02)
			check(enemy.state == "lunge", "Fold Stalker should cross its marked fold after the warning")
			enemy._physics_process(0.1)
			check(signf(enemy.velocity.x) == enemy.committed, "Fold Stalker should attack from its marked fold")
		enemy.queue_free()
		target.queue_free()
		await process_frame

	# V02 is two separately warned lunges; V03 produces two distinct beam lanes.
	var target := CharacterBody2D.new()
	target.position = Vector2(250.0,280.0)
	root.add_child(target)
	var saturated: CharacterBody2D = CampaignEnemy.new()
	saturated.archetype = "E01"
	saturated.variant_id = "V02"
	saturated.double_lunge = true
	saturated.target = target
	saturated.position = Vector2(320.0,280.0)
	root.add_child(saturated)
	await process_frame
	saturated.set_physics_process(false)
	saturated.state = "approach"
	saturated._physics_process(0.01)
	check(saturated.state == "tell", "V02 should begin with a warning")
	saturated._physics_process(0.66)
	saturated._physics_process(0.29)
	check(saturated.state == "tell" and saturated.lunge_chain == 1, "V02 should warn again before its second lunge")
	saturated.queue_free()
	var turret: CharacterBody2D = CampaignEnemy.new()
	turret.archetype = "E04"
	turret.variant_id = "V03"
	turret.target = target
	turret.position = Vector2(420.0,280.0)
	turret.marked_attack.connect(_on_marked_attack)
	root.add_child(turret)
	await process_frame
	turret.set_physics_process(false)
	marked.clear()
	turret.special_timer = 0.0
	turret._physics_process(0.01)
	check(marked.size() == 2, "V03 should fire two separately marked beams")
	if marked.size() == 2:
		check(float(marked[1].delay) > float(marked[0].delay), "V03 beams should arrive sequentially")
	turret.queue_free()
	target.queue_free()
	await process_frame

	var campaign: Node2D = load("res://world/campaign.tscn").instantiate()
	campaign.persistence_enabled = false
	campaign.stories_enabled = false
	root.add_child(campaign)
	await process_frame
	campaign.player.set_physics_process(false)
	campaign.player.energy = 50.0
	campaign.load_room("FOL04")
	var scout_found: bool = false
	for actor: CharacterBody2D in campaign.actors:
		if actor is CampaignEnemy and actor.variant_id == "V04":
			scout_found = true
	check(scout_found, "V04 should spawn alongside its optional Devourer encounter")
	campaign.load_room("HUN01")
	var forager_count: int = 0
	var forager_rewards: Dictionary = {}
	for actor: CharacterBody2D in campaign.actors:
		if actor is CampaignEnemy and actor.archetype == "E01":
			forager_count += 1
			var reward_id: String = str(campaign.encounters[actor.token].reward_token)
			forager_rewards[reward_id] = true
	check(forager_count == 2, "HUN01 should use the authored two-enemy encounter group")
	check(forager_rewards.size() == forager_count, "Each member of a group should have a stable unique reward token")
	campaign.load_room("REL03")
	var guard_count: int = 0
	var variant_count: int = 0
	for actor: CharacterBody2D in campaign.actors:
		if actor is CampaignEnemy and actor.archetype == "E02":
			guard_count += 1
			if actor.variant_id == "V01":
				variant_count += 1
	check(guard_count == 2 and variant_count == 1, "REL03 should replace one group guard with its Metalbound variant")
	campaign.load_room("SIL02")
	check(campaign.actors.is_empty(), "The Silent Gallery memory theatre must remain enemy-free")
	campaign.load_room("FOL04")
	campaign.hazards.clear()
	campaign.add_mark(campaign.player.position, "drain", 0.0, 8.0)
	campaign.update_hazards(0.01)
	check(is_equal_approx(campaign.player.energy, 42.0), "Leech mark should drain stored EE once")
	campaign.update_hazards(0.01)
	check(is_equal_approx(campaign.player.energy, 42.0), "One drain mark must not duplicate its EE loss")
	print("ENEMY_BEHAVIOR_CONTRACT failures=", failures, " archetypes=7 variants=4 group_spawns=true")
	quit(1 if failures else 0)

func _on_marked_attack(at: Vector2, kind: String, delay: float, damage: float) -> void:
	marked.append({"at": at, "kind": kind, "delay": delay, "damage": damage})
