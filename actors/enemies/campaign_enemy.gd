extends "res://actors/enemies/forager.gd"

signal marked_attack(at: Vector2, kind: String, delay: float, damage: float)

var archetype: String = "E01"
var variant_id: String = ""
var attack_damage: float = 12.0
var special_timer: float = 1.5
var locked_target: Vector2 = Vector2.ZERO
var fold_destination: Vector2 = Vector2.ZERO

func _physics_process(dt: float) -> void:
	contact_damage = attack_damage
	if archetype == "E01":
		super._physics_process(dt)
		return
	if not is_instance_valid(target):
		return
	match archetype:
		"E02", "E06":
			_tick_guard_construct(dt)
		"E03":
			_tick_skitter(dt)
		"E04":
			_tick_prism_turret(dt)
		"E05":
			_tick_sentinel(dt)
		"E07":
			_tick_leech(dt)
		"E08":
			_tick_fold_stalker(dt)
		_:
			super._physics_process(dt)
	_update_visual()

func _tick_guard_construct(dt: float) -> void:
	timer -= dt
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var delta_to_target: Vector2 = target.position - position
	var distance: float = delta_to_target.length()
	var attack_range: float = 90.0 if archetype == "E02" else 112.0
	var approach_speed: float = 35.0 if archetype == "E02" else 25.0
	match state:
		"patrol":
			velocity.x = 0.0
			if distance < 240.0:
				state = "approach"
		"approach":
			velocity.x = signf(delta_to_target.x) * approach_speed
			if absf(delta_to_target.x) < attack_range and absf(delta_to_target.y) < 55.0:
				committed = signf(delta_to_target.x)
				if is_zero_approx(committed):
					committed = 1.0
				state = "tell"
				timer = 0.8 if archetype == "E02" else 1.0
				marked_attack.emit(target.position, "wave", timer, attack_damage)
			elif distance > 300.0:
				state = "patrol"
				velocity.x = 0.0
		"tell":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "recover"
				timer = 1.35 if variant_id == "V01" else (1.1 if archetype == "E02" else 1.3)
		"recover":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "approach" if distance < 220.0 else "patrol"
	move_and_slide()

func _tick_skitter(dt: float) -> void:
	timer -= dt
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var delta_to_target: Vector2 = target.position - position
	var distance: float = delta_to_target.length()
	match state:
		"patrol":
			velocity.x = 0.0
			if distance < 220.0:
				state = "approach"
		"approach":
			velocity.x = signf(delta_to_target.x) * 55.0
			if distance < 145.0:
				locked_target = target.position
				committed = signf(delta_to_target.x)
				if is_zero_approx(committed):
					committed = 1.0
				state = "tell"
				timer = 0.75
				marked_attack.emit(locked_target, "pool", timer, attack_damage)
			elif distance > 270.0:
				state = "patrol"
		"tell":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "leap"
				timer = 0.38
				velocity.y = -235.0
		"leap":
			velocity.x = committed * 245.0
			if timer <= 0.0:
				state = "retreat"
				timer = 0.4
		"retreat":
			velocity.x = -committed * 75.0
			if timer <= 0.0:
				state = "recover"
				timer = 0.7
		"recover":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "patrol"
	move_and_slide()

func _tick_prism_turret(dt: float) -> void:
	timer -= dt
	special_timer = maxf(0.0, special_timer - dt)
	velocity.x = 0.0
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var distance: float = target.position.distance_to(position)
	match state:
		"patrol", "guard":
			state = "guard"
			if special_timer <= 0.0 and distance < 380.0:
				special_timer = 2.8
				locked_target = target.position
				state = "tell"
				timer = 0.9
				marked_attack.emit(Vector2(locked_target.x, locked_target.y), "beam", timer, attack_damage)
				if variant_id == "V03":
					var second_y: float = clampf(locked_target.y + (62.0 if locked_target.y < 240.0 else -62.0), 150.0, 295.0)
					marked_attack.emit(Vector2(locked_target.x, second_y), "beam", timer + 0.75, attack_damage)
		"tell":
			if timer <= 0.0:
				state = "recover"
				timer = 1.0
		"recover":
			if timer <= 0.0:
				state = "guard"
	move_and_slide()

func _tick_sentinel(dt: float) -> void:
	timer -= dt
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var delta_to_target: Vector2 = target.position - position
	var distance: float = delta_to_target.length()
	match state:
		"patrol":
			velocity.x = 0.0
			if distance < 240.0:
				state = "approach"
		"approach":
			velocity.x = signf(delta_to_target.x) * 35.0
			if absf(delta_to_target.x) < 135.0 and absf(delta_to_target.y) < 55.0:
				committed = signf(delta_to_target.x)
				if is_zero_approx(committed):
					committed = 1.0
				state = "tell"
				timer = 0.65
				marked_attack.emit(target.position, "charge", timer, attack_damage)
			elif distance > 300.0:
				state = "patrol"
				velocity.x = 0.0
		"tell":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "lunge"
				timer = 0.34
		"lunge":
			velocity.x = committed * 350.0
			if timer <= 0.0:
				state = "recover"
				timer = 1.1
				velocity.x = 0.0
		"recover":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "approach" if distance < 220.0 else "patrol"
	move_and_slide()

func _tick_leech(dt: float) -> void:
	timer -= dt
	special_timer = maxf(0.0, special_timer - dt)
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var delta_to_target: Vector2 = target.position - position
	var distance: float = delta_to_target.length()
	match state:
		"patrol", "approach":
			state = "approach"
			velocity = delta_to_target.normalized() * 28.0
			if distance < 100.0 and special_timer <= 0.0:
				state = "tell"
				timer = 0.8
				special_timer = 2.8
				velocity = Vector2.ZERO
				marked_attack.emit(target.position, "drain", timer, 8.0)
		"tell":
			velocity = Vector2.ZERO
			if timer <= 0.0:
				state = "recover"
				timer = 0.7
		"recover":
			velocity = Vector2.ZERO
			if timer <= 0.0:
				state = "approach"
	move_and_slide()

func _tick_fold_stalker(dt: float) -> void:
	timer -= dt
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	var delta_to_target: Vector2 = target.position - position
	var distance: float = delta_to_target.length()
	match state:
		"patrol":
			velocity.x = 0.0
			if distance < 270.0:
				state = "approach"
		"approach":
			velocity.x = signf(delta_to_target.x) * 38.0
			if distance < 185.0:
				locked_target = target.position
				committed = signf(delta_to_target.x)
				if is_zero_approx(committed):
					committed = 1.0
				fold_destination = Vector2(clampf(locked_target.x - committed * 90.0, 80.0, 560.0), locked_target.y)
				state = "tell"
				timer = 0.9
				marked_attack.emit(locked_target, "fold", timer, attack_damage)
			elif distance > 320.0:
				state = "patrol"
		"tell":
			velocity.x = 0.0
			if timer <= 0.0:
				position = fold_destination
				state = "lunge"
				timer = 0.3
				hit_in_lunge = false
		"lunge":
			velocity.x = committed * 300.0
			if not hit_in_lunge and absf(target.position.x - position.x) < 28.0 and absf(target.position.y - position.y) < 40.0:
				target.damage(attack_damage)
				hit_in_lunge = true
			if timer <= 0.0:
				state = "recover"
				timer = 1.0
		"recover":
			velocity.x = 0.0
			if timer <= 0.0:
				state = "patrol"
	move_and_slide()

func _update_visual() -> void:
	if is_instance_valid(art):
		art.flip_h = velocity.x < 0.0
		art.modulate = Color(1.5, 1.5, 0.8) if state == "tell" else (Color("aff5dc") if state == "recover" else Color.WHITE)
	queue_redraw()

func hit(amount: float) -> void:
	if archetype == "E05" and state in ["tell", "lunge"]:
		return
	if archetype in ["E02", "E06"] and state != "recover":
		return
	super.hit(amount)
