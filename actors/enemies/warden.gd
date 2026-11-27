extends CharacterBody2D
signal defeated(token: String, at: Vector2)
signal shockwave(at: Vector2, direction: float)
var target: CharacterBody2D
var hp: float = 320.0
var state: String = "guard"
var timer: float = 1.0
var token: String = "B01"
var chain: int = 0
func _ready() -> void:
    collision_layer = 4
    collision_mask = 1
    var shape := CollisionShape2D.new()
    var rectangle := RectangleShape2D.new()
    rectangle.size = Vector2(56, 80)
    shape.shape = rectangle
    add_child(shape)
func _physics_process(dt: float) -> void:
    if not is_instance_valid(target):
        return
    timer -= dt
    velocity.y = minf(650, velocity.y + dt * 900)
    velocity.x = 0
    match state:
        "guard":
            if timer <= 0:
                state = "tell"
                timer = 1.0
                chain = 2 if hp < 160 else 1
        "tell":
            if timer <= 0:
                state = "slam"
                timer = 0.18
                shockwave.emit(position + Vector2(0, 35), -1.0)
                shockwave.emit(position + Vector2(0, 35), 1.0)
        "slam":
            if timer <= 0:
                chain -= 1
                state = "chain_pause" if chain > 0 else "recover"
                timer = 0.75 if chain > 0 else 1.4
        "chain_pause":
            if timer <= 0:
                state = "second_tell"
                timer = 1.0
        "second_tell":
            if timer <= 0:
                chain = 1
                state = "slam"
                timer = 0.18
                shockwave.emit(position + Vector2(0, 35), -1.0)
                shockwave.emit(position + Vector2(0, 35), 1.0)
        "recover":
            if timer <= 0:
                state = "guard"
                timer = 0.6
    move_and_slide()
    queue_redraw()
func hit(amount: float) -> void:
    if state != "recover":
        return
    hp = maxf(0, hp - amount)
    if hp <= 0:
        defeated.emit(token, position)
        queue_free()
func _draw() -> void:
    var outline := Color("152632")
    var stone := Color("638291")
    draw_rect(Rect2(-28,-40,56,80), outline)
    draw_rect(Rect2(-23,-35,46,64), stone)
    draw_rect(Rect2(-18,-30,7,53),Color("a6b8ad"))
    var core := Color("aff5dc") if state == "recover" else Color("91704f")
    draw_rect(Rect2(-8,-12,16,22),core)
    var lift: float = -34 if state in ["tell","second_tell"] else 0
    for x: float in [-38.0, 26.0]:
        draw_rect(Rect2(x,-10+lift,15,42),outline)
        draw_rect(Rect2(x+2,-6+lift,11,30),stone)
    draw_rect(Rect2(-16,-40,32,12),outline)
    draw_line(Vector2(-10,-34),Vector2(10,-34),Color("56cdc4"),3)
