extends "res://actors/enemies/forager.gd"
signal marked_attack(at: Vector2, kind: String, delay: float, damage: float)
var archetype: String = "E01"
var attack_damage: float = 12
var special_timer: float = 1.5
func _physics_process(dt: float) -> void:
    contact_damage = attack_damage
    if archetype == "E05":
        _tick_sentinel(dt)
        if is_instance_valid(art):
            art.flip_h = committed < 0.0 if state in ["tell","lunge"] else velocity.x < 0.0
            art.modulate = Color(1.5,1.5,0.8) if state == "tell" else (Color("aff5dc") if state == "recover" else Color.WHITE)
        queue_redraw()
        return
    if archetype in ["E01","E02","E03","E05","E06"]:
        super._physics_process(dt)
        return
    if not is_instance_valid(target):
        return
    special_timer -= dt
    if archetype=="E07":
        velocity = (target.position-position).normalized()*30
        move_and_slide()
    if special_timer<=0 and target.position.distance_to(position)<380:
        special_timer = 2.8
        state = "tell"
        marked_attack.emit(target.position,"beam" if archetype=="E04" else "ceiling",0.9,attack_damage)
    else:
        state = "recover" if special_timer>1.7 else "patrol"
    queue_redraw()

func _tick_sentinel(dt: float) -> void:
    if not is_instance_valid(target):
        return
    timer -= dt
    velocity.y = minf(650.0,velocity.y+900.0*dt)
    var delta_to_target: Vector2 = target.position-position
    var distance: float = delta_to_target.length()
    match state:
        "patrol":
            velocity.x = 0.0
            if distance < 240.0:
                state = "approach"
        "approach":
            velocity.x = signf(delta_to_target.x)*35.0
            if absf(delta_to_target.x) < 135.0 and absf(delta_to_target.y) < 55.0:
                committed = signf(delta_to_target.x)
                state = "tell"
                timer = 0.65
                marked_attack.emit(target.position,"charge",0.65,attack_damage)
            elif distance > 300.0:
                state = "patrol"
                velocity.x = 0.0
        "tell":
            velocity.x = 0.0
            if timer <= 0.0:
                state = "lunge"
                timer = 0.34
        "lunge":
            velocity.x = committed*350.0
            if absf(delta_to_target.x) < 30.0 and absf(delta_to_target.y) < 38.0 and target.has_method("damage"):
                target.call("damage",attack_damage)
            if timer <= 0.0:
                state = "recover"
                timer = 1.1
                velocity.x = 0.0
        "recover":
            velocity.x = 0.0
            if timer <= 0.0:
                state = "approach" if distance < 220.0 else "patrol"
    move_and_slide()
func hit(amount: float) -> void:
    if archetype == "E05" and state in ["tell","lunge"]:
        return
    if archetype in ["E02","E06"] and state!="recover":
        return
    super.hit(amount)
