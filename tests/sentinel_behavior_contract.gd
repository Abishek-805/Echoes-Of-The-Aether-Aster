extends SceneTree

const CampaignEnemy = preload("res://actors/enemies/campaign_enemy.gd")
var failures: int = 0
var marks: int = 0
var marked_position := Vector2.ZERO

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _initialize() -> void:
	call_deferred("run_checks")

func run_checks() -> void:
	var floor_body := StaticBody2D.new()
	floor_body.collision_layer = 1
	floor_body.position = Vector2(320,320)
	var floor_shape := CollisionShape2D.new()
	var floor_rect := RectangleShape2D.new()
	floor_rect.size = Vector2(640,40)
	floor_shape.shape = floor_rect
	floor_body.add_child(floor_shape)
	root.add_child(floor_body)

	var target := CharacterBody2D.new()
	target.position = Vector2(330,280)
	target.set_physics_process(false)
	root.add_child(target)
	var sentinel: CharacterBody2D = CampaignEnemy.new()
	sentinel.archetype = "E05"
	sentinel.hp = 100.0
	sentinel.attack_damage = 20.0
	sentinel.position = Vector2(200,280)
	sentinel.target = target
	sentinel.marked_attack.connect(_on_marked_attack)
	sentinel.set_physics_process(false)
	root.add_child(sentinel)
	await process_frame
	sentinel.set_physics_process(false)
	marks = 0
	sentinel.state = "approach"
	sentinel._physics_process(0.01)
	check(sentinel.state == "tell", "Sentinel should enter a visible charge warning at close range")
	check(marks == 1, "Sentinel should emit one marked attack per charge")
	check(marked_position.distance_to(Vector2(330,280)) < 12.0, "Sentinel mark should preserve the target's telegraphed position")
	var initial_hp: float = sentinel.hp
	sentinel.hit(10.0)
	check(is_equal_approx(sentinel.hp,initial_hp), "Shielded Sentinel should reject hits during its tell")
	var tell_position: float = sentinel.position.x
	target.position = Vector2(100,280)
	sentinel._physics_process(0.65)
	sentinel._physics_process(0.1)
	check(sentinel.state == "lunge", "Sentinel should commit to a lunge after its warning")
	check(sentinel.position.x > tell_position+20.0, "Sentinel should charge along its locked direction, not track the moved target")
	sentinel._physics_process(0.25)
	check(sentinel.state == "recover", "Sentinel should expose a recovery window after charging")
	sentinel.hit(10.0)
	check(is_equal_approx(sentinel.hp,initial_hp-10.0), "Sentinel should take damage during its exposed recovery")
	var campaign: Node2D = load("res://world/campaign.tscn").instantiate()
	campaign.persistence_enabled = false
	campaign.stories_enabled = false
	root.add_child(campaign)
	await process_frame
	campaign.player.set_physics_process(false)
	campaign.player.hp = campaign.player.max_hp
	campaign.hazards.clear()
	campaign.add_mark(Vector2(320,280),"charge",0.0,20.0)
	campaign.update_hazards(0.05)
	check(is_equal_approx(campaign.player.hp,campaign.player.max_hp),"Sentinel's charge lane marker must not deal repeated beam damage")
	print("SENTINEL_BEHAVIOR_CONTRACT failures=", failures, " marks=", marks)
	quit(1 if failures else 0)

func _on_marked_attack(at: Vector2, _kind: String, _delay: float, _damage: float) -> void:
	marks += 1
	marked_position = at
