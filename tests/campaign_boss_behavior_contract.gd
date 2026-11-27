extends SceneTree

const CampaignBoss = preload("res://actors/enemies/campaign_boss.gd")
var failures: int = 0
var attacks: Array[Dictionary] = []

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	for id: String in ["B02", "B03", "B04", "B05", "B06"]:
		var target := CharacterBody2D.new()
		target.position = Vector2(180, 280)
		target.set_physics_process(false)
		root.add_child(target)
		var boss: CharacterBody2D = CampaignBoss.new()
		boss.boss_id = id
		boss.hp = 100.0
		boss.max_health = 100.0
		boss.position = Vector2(450, 280)
		boss.target = target
		boss.marked_attack.connect(_on_marked_attack)
		root.add_child(boss)
		await process_frame
		boss.set_physics_process(false)
		attacks.clear()
		boss.state = "guard"
		boss.timer = 0.0
		boss.attack_count = 0
		boss._physics_process(0.01)
		check(boss.state == "tell", id+" should enter a visible attack tell")
		check(not attacks.is_empty(), id+" should show a marked hazard during its tell")
		if not attacks.is_empty():
			check(float(attacks[0].delay) >= 0.9, id+" tell should leave a fair response window")
			var expected: String = {"B02":"wave", "B03":"fold", "B04":"charge", "B05":"pool", "B06":"beam"}[id]
			check(str(attacks[0].kind) == expected, id+" should use its distinct first attack")
		if id == "B04":
			check(boss.committed < 0.0, "Keeper should lock its charge direction toward the telegraphed target")
			target.position.x = 610.0
			boss.timer = 0.01
			boss._physics_process(0.02)
			boss._physics_process(0.1)
			check(boss.state == "charge", "Keeper should execute its warned charge")
			check(is_equal_approx(boss.velocity.x, -350.0), "Keeper should not retarget after the warning")
			boss._physics_process(0.25)
		else:
			boss.timer = 0.01
			boss._physics_process(0.02)
			check(boss.state == "recover", id+" should open a recovery window after the marked attack")
		boss.hit(10.0)
		check(is_equal_approx(boss.hp, 90.0), id+" should be vulnerable during recovery")
		boss.queue_free()
		target.queue_free()
		await process_frame

	var guardian: CharacterBody2D = CampaignBoss.new()
	guardian.boss_id = "B06"
	guardian.max_health = 1000.0
	guardian.hp = 300.0
	var guardian_target := CharacterBody2D.new()
	guardian_target.position = Vector2(260, 280)
	root.add_child(guardian_target)
	guardian.target = guardian_target
	guardian.marked_attack.connect(_on_marked_attack)
	root.add_child(guardian)
	await process_frame
	guardian.set_physics_process(false)
	attacks.clear()
	guardian.state = "guard"
	guardian.timer = 0.0
	guardian.attack_count = 1
	guardian._physics_process(0.01)
	check(guardian.phase == 3, "Fold Guardian should enter phase three below 35 percent health")
	check(attacks.size() == 2, "Final phase should add a second, offset delayed lane")
	if attacks.size() == 2:
		check(float(attacks[1].delay) > float(attacks[0].delay), "Final phase lanes should be sequentially avoidable")
	guardian.queue_free()
	guardian_target.queue_free()
	await process_frame
	print("CAMPAIGN_BOSS_BEHAVIOR_CONTRACT failures=", failures, " bosses=5 final_phase_markers=2")
	quit(1 if failures else 0)

func _on_marked_attack(at: Vector2, kind: String, delay: float, damage: float) -> void:
	attacks.append({"at": at, "kind": kind, "delay": delay, "damage": damage})
