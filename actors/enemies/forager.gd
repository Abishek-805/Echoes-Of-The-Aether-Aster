extends CharacterBody2D
signal defeated(token: String, at: Vector2)
var art: AnimatedSprite2D
var target: CharacterBody2D
var hp: float = 30.0
var contact_damage: float = 12.0
var state: String = "patrol"
var timer: float = 0.0
var committed: float = -1.0
var double_lunge: bool = false
var lunge_chain: int = 0
var hit_in_lunge: bool = false
var token: String = "forager-1"
func _ready() -> void:
    collision_layer = 4
    collision_mask = 1
    var shape := CollisionShape2D.new()
    var rect := RectangleShape2D.new()
    rect.size = Vector2(24,20)
    shape.shape = rect
    add_child(shape)
    if ResourceLoader.exists("res://art/runtime/forager.png"):
        art = AnimatedSprite2D.new()
        art.position.y = -2
        art.sprite_frames = SpriteFrames.new()
        art.sprite_frames.add_animation("move")
        var sheet: Texture2D = load("res://art/runtime/forager.png")
        for i in range(6):
            var texture := AtlasTexture.new()
            texture.atlas = sheet
            texture.region = Rect2(i*48,0,48,32)
            art.sprite_frames.add_frame("move",texture)
        art.sprite_frames.set_animation_speed("move",8)
        add_child(art)
        art.play("move")
func _physics_process(dt: float) -> void:
    if not is_instance_valid(target):
        return
    timer -= dt
    velocity.y = minf(650,velocity.y+900*dt)
    var distance: float = target.position.distance_to(position)
    match state:
        "patrol":
            velocity.x = 0
            if distance < 180:
                state = "approach"
        "approach":
            velocity.x = signf(target.position.x-position.x)*45
            if distance < 85:
                state = "tell"
                timer = 0.65
                committed = signf(target.position.x-position.x)
                lunge_chain = 0
            elif distance > 230:
                state = "patrol"
        "tell":
            velocity.x = 0
            if timer <= 0:
                state = "lunge"
                timer = 0.28
                hit_in_lunge = false
        "lunge":
            velocity.x = committed*210
            if distance < 28 and not hit_in_lunge:
                target.damage(contact_damage)
                hit_in_lunge = true
            if timer <= 0:
                if double_lunge and lunge_chain == 0:
                    state = "tell"
                    timer = 0.65
                    committed = signf(target.position.x-position.x)
                    lunge_chain = 1
                else:
                    state = "recover"
                    timer = 0.8
        "recover":
            velocity.x = 0
            if timer <= 0:
                state = "patrol"
    if is_instance_valid(art):
        art.flip_h = velocity.x < 0
        art.modulate = Color(1.5,1.5,0.8) if state=="tell" else Color.WHITE
    move_and_slide()
    queue_redraw()
func hit(amount: float) -> void:
    hp -= amount
    if hp <= 0:
        defeated.emit(token, position)
        queue_free()
func _draw() -> void:
    if is_instance_valid(art):
        return
    draw_rect(Rect2(-12,-10,24,20),Color("ba834e") if state!="tell" else Color("f8dc80"))
    draw_rect(Rect2(-10,-8,7,4),Color("7ef0db"))
    draw_rect(Rect2(3,-8,7,4),Color("7ef0db"))
