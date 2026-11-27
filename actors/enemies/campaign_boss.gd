extends "res://actors/enemies/warden.gd"
signal marked_attack(at: Vector2, kind: String, delay: float, damage: float)
var boss_id: String = "B01"
var max_health: float = 320
var attack_count: int = 0
func _physics_process(dt: float) -> void:
    if boss_id=="B01":
        super._physics_process(dt)
        return
    if not is_instance_valid(target):
        return
    timer -= dt
    velocity.y = minf(650,velocity.y+900*dt)
    velocity.x = 0
    if state=="guard" and timer<=0:
        state = "tell"
        timer = 1.0
        attack_count += 1
        var kind: String = "beam" if attack_count%2==0 else "ceiling"
        if boss_id=="B02":
            kind = "ceiling" if attack_count%2==0 else "wave"
        elif boss_id=="B04":
            kind = "charge"
        elif boss_id=="B05":
            kind = "pool" if attack_count%2==0 else "ceiling"
        if boss_id=="B06" and hp<max_health*0.35:
            marked_attack.emit(target.position+Vector2(75,0),"ceiling",2.0,24.0)
        marked_attack.emit(target.position,kind,1.0,20.0)
    elif state=="tell" and timer<=0:
        state = "recover"
        timer = 1.6
    elif state=="recover" and timer<=0:
        state = "guard"
        timer = 0.7
    move_and_slide()
    queue_redraw()
