extends "res://actors/enemies/warden.gd"

signal marked_attack(at: Vector2, kind: String, delay: float, damage: float)

var boss_id: String = "B01"
var max_health: float = 320.0
var attack_count: int = 0
var phase: int = 1
var committed: float = 1.0
var current_attack: String = ""

func _physics_process(dt: float) -> void:
	if boss_id == "B01":
		super._physics_process(dt)
		return
	if not is_instance_valid(target):
		return

	_update_phase()
	timer -= dt
	velocity.y = minf(650.0, velocity.y + 900.0 * dt)
	velocity.x = 0.0
	match state:
		"guard":
			if timer <= 0.0:
				_begin_attack()
		"tell":
			if timer <= 0.0:
				if current_attack == "charge":
					state = "charge"
					timer = 0.34
				else:
					_enter_recovery()
		"charge":
			velocity.x = committed * 350.0
			if timer <= 0.0:
				_enter_recovery()
		"recover":
			if timer <= 0.0:
				state = "guard"
				timer = 0.6 if boss_id != "B06" else 0.55
	move_and_slide()
	queue_redraw()

func _update_phase() -> void:
	if boss_id != "B06" or max_health <= 0.0:
		return
	if hp <= max_health * 0.35:
		phase = 3
	elif hp <= max_health * 0.70:
		phase = 2

func _begin_attack() -> void:
	attack_count += 1
	current_attack = _select_attack()
	state = "tell"
	timer = 1.0
	var damage: float = 24.0 if boss_id == "B06" else 20.0
	var delay: float = 1.0
	if boss_id == "B04":
		delay = 0.9
	elif boss_id == "B06" and phase == 3:
		delay = 2.0

	var target_position: Vector2 = target.position
	if current_attack == "charge":
		committed = signf(target_position.x - position.x)
		if is_zero_approx(committed):
			committed = 1.0
	marked_attack.emit(target_position, current_attack, delay, damage)

	# The final phase adds one offset marker so players must read the arena and
	# move between two known danger lanes. The attacks remain sequentially timed.
	if boss_id == "B06" and phase == 3 and attack_count % 2 == 0:
		var offset: float = -90.0 if target_position.x > 320.0 else 90.0
		marked_attack.emit(target_position + Vector2(offset, 0.0), "fold", 2.25, damage)

func _select_attack() -> String:
	match boss_id:
		"B02":
			if hp < max_health * 0.40 and attack_count % 2 == 0:
				return "ceiling"
			return "wave" if attack_count % 2 == 1 else "ceiling"
		"B03":
			var colossus_attacks: Array[String] = ["fold", "ceiling", "beam", "charge"]
			return colossus_attacks[(attack_count - 1) % colossus_attacks.size()]
		"B04":
			return "charge" if attack_count % 2 == 1 else "ceiling"
		"B05":
			var devourer_attacks: Array[String] = ["pool", "charge", "ceiling"]
			return devourer_attacks[(attack_count - 1) % devourer_attacks.size()]
		"B06":
			if phase == 1:
				var containment_attacks: Array[String] = ["beam", "ceiling"]
				return containment_attacks[(attack_count - 1) % containment_attacks.size()]
			if phase == 2:
				var fold_attacks: Array[String] = ["fold", "charge"]
				return fold_attacks[(attack_count - 1) % fold_attacks.size()]
			var last_phase_attacks: Array[String] = ["pool", "beam", "ceiling"]
			return last_phase_attacks[(attack_count - 1) % last_phase_attacks.size()]
	return "ceiling"

func _enter_recovery() -> void:
	state = "recover"
	timer = 1.6 if boss_id in ["B03", "B04", "B06"] else (1.5 if boss_id == "B05" else 1.3)
	velocity.x = 0.0
