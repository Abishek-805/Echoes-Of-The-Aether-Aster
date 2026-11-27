extends CharacterBody2D
signal died
signal changed
signal shot(origin: Vector2, direction: Vector2)
signal blade(origin: Vector2, direction: float)
const Rewind = preload("res://actors/player/rewind_history.gd")
var rewind = Rewind.new()
var rewind_unlocked: bool = false
var damage_multiplier: float = 1.0
var rewind_cost: float = 25
var rewind_delay: float = 14
var max_hp: float = 100
var capacity: float = 100
var air_jumps: int = 1
var heal_charges: int = 3
var heal_timer: float = 0
var drop_timer: float = 0
var wall_lock: float = 0
var weapon_id: String = "RIF01"
var weapon_damage: float = 12
var weapon_cost: float = 2
var weapon_heat: float = 13
var weapon_interval: float = 0.25
var weapon_cooling: float = 25
var pellet_count: int = 1
var weapon_states: Dictionary = {}
var art: AnimatedSprite2D
var hp: float = 100.0
var energy: float = 60.0
var heat: float = 0.0
var overheated: bool = false
var shot_timer: float = 0.0
var since_shot: float = 10.0
var blade_timer: float = 0.0
var dodge_timer: float = 0.0
var dodge_cooldown: float = 0.0
var immunity: float = 0.0
var facing: float = 1.0
var coyote: float = 0.0
var buffer: float = 0.0
var spawn: Vector2 = Vector2(65, 270)
var released: Dictionary = {}
var hurt_flash: float = 0.0
func _ready() -> void:
	collision_layer = 2
	# World solids use collision layer 1; one-way platforms use collision layer
	# bitmask 8 (Godot layer number 4). Enemy bodies use layer bitmask 4.
	collision_mask = 9
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(18, 36)
	shape.shape = rect
	add_child(shape)
	if ResourceLoader.exists("res://art/runtime/aster_idle.png"):
		art = AnimatedSprite2D.new()
		art.position = Vector2(0,-5)
		art.sprite_frames = SpriteFrames.new()
		for spec: Array in [["idle",4,6.0],["run",8,10.0],["blade",6,12.0]]:
			var sheet: Texture2D = load("res://art/runtime/aster_"+spec[0]+".png")
			art.sprite_frames.add_animation(spec[0])
			art.sprite_frames.set_animation_speed(spec[0],spec[2])
			for frame: int in range(spec[1]):
				var texture := AtlasTexture.new()
				texture.atlas = sheet
				texture.region = Rect2(frame*48,0,48,56)
				art.sprite_frames.add_frame(spec[0],texture)
		add_child(art)
func _physics_process(dt: float) -> void:
	shot_timer = maxf(0.0, shot_timer-dt)
	blade_timer = maxf(0.0, blade_timer-dt)
	dodge_cooldown = maxf(0.0, dodge_cooldown-dt)
	dodge_timer = maxf(0.0, dodge_timer-dt)
	immunity = maxf(0.0, immunity-dt)
	hurt_flash = maxf(0.0, hurt_flash-dt)
	since_shot += dt
	if since_shot >= 0.5:
		heat = maxf(0.0, heat-weapon_cooling*dt)
	if overheated and heat <= 35.0:
		overheated = false
	for id: String in weapon_states:
		if id!=weapon_id:
			var stored: Dictionary = weapon_states[id]
			stored.since += dt
			if stored.since>0.5:
				stored.heat = maxf(0,stored.heat-stored.cooling*dt)
			if stored.heat<=35:
				stored.locked = false
	if rewind.tick(self,dt):
		return
	if Input.is_action_just_pressed("rewind") and rewind.begin(self):
		return
	if Input.is_action_just_pressed("heal") and heal_charges>0 and hp<max_hp:
		heal_timer = 0.8
	if heal_timer>0:
		heal_timer = maxf(0,heal_timer-dt)
		if heal_timer==0:
			heal_charges -= 1
			hp = minf(max_hp,hp+30)
	wall_lock = maxf(0,wall_lock-dt)
	if is_on_floor():
		air_jumps = 1
		coyote = 0.10
	else:
		coyote = maxf(0.0, coyote-dt)
	buffer = maxf(0.0, buffer-dt)
	drop_timer = maxf(0,drop_timer-dt)
	if drop_timer==0:
		set_collision_mask_value(4,true)
	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("down") and is_on_floor():
			begin_drop_through()
		else:
			buffer = 0.12
	var direction: float = Input.get_axis("left", "right")
	if direction != 0.0:
		facing = signf(direction)
	if Input.is_action_just_pressed("dodge") and dodge_cooldown <= 0.0:
		dodge_timer = 0.25
		dodge_cooldown = 0.60
		immunity = 0.15
	if wall_lock<=0:
		velocity.x = facing*300.0 if dodge_timer > 0.0 else direction*150.0
	if heal_timer>0:
		velocity.x = 0
	velocity.y = minf(velocity.y+900.0*dt, 650.0)
	if buffer > 0.0 and coyote > 0.0:
		velocity.y = -300.0
		buffer = 0.0
		coyote = 0.0
	elif buffer>0 and is_on_wall() and not is_on_floor():
		velocity = Vector2(get_wall_normal().x*210,-300)
		wall_lock = 0.18
		buffer = 0
	elif buffer>0 and air_jumps>0:
		velocity.y = -285
		air_jumps -= 1
		buffer = 0
	if is_on_wall() and velocity.y>75:
		velocity.y = 75
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.5
	move_and_slide()
	if rewind_unlocked:
		rewind.record(self,dt)
	if Input.is_action_pressed("fire") and heal_timer<=0:
		try_fire()
	if Input.is_action_just_pressed("melee") and blade_timer <= 0.0:
		blade_timer = 0.5
		blade.emit(global_position, facing)
	if position.y > 450:
		damage(100)
	if is_instance_valid(art):
		art.flip_h = facing < 0
		art.modulate = Color(1,0.6,0.6) if hurt_flash > 0 else Color.WHITE
		art.play("blade" if blade_timer>0 else ("run" if absf(velocity.x)>1 else "idle"))
	changed.emit()
	queue_redraw()

func begin_drop_through() -> void:
	if not is_on_floor():
		return
	drop_timer = 0.25
	set_collision_mask_value(4,false)
	velocity.y = 60.0
	buffer = 0.0
	coyote = 0.0

func try_fire() -> bool:
	if overheated or shot_timer > 0.0 or energy < weapon_cost:
		return false
	energy -= weapon_cost
	heat = minf(100.0, heat+weapon_heat)
	overheated = heat >= 100.0
	since_shot = 0.0
	shot_timer = weapon_interval
	var aim: Vector2 = Vector2(facing, 0.0)
	var platform_input: Node = get_node_or_null("/root/PlatformInput")
	if is_instance_valid(platform_input):
		aim = platform_input.call("aim", global_position, get_global_mouse_position(), facing)
	if aim == Vector2.ZERO:
		aim = Vector2(facing, 0)
	for pellet in range(pellet_count):
		shot.emit(global_position, aim.rotated((float(pellet)-float(pellet_count-1)/2.0)*0.07))
	return true
func collect(token: String, amount: float) -> bool:
	if released.has(token):
		return false
	released[token] = true
	energy = minf(capacity, energy+amount)
	changed.emit()
	return true
func damage(amount: float) -> void:
	if immunity > 0.0:
		return
	amount = maxf(1,roundf(amount*damage_multiplier))
	heal_timer = 0
	rewind.damage(minf(hp,amount))
	hp = maxf(0.0, hp-amount)
	immunity = 0.7
	hurt_flash = 0.15
	if hp <= 0.0:
		died.emit()
		position = spawn
		velocity = Vector2.ZERO
		rewind.clear_history(self)
		hp = max_hp
		energy = maxf(50.0, energy)
		heat = 0.0
		overheated = false
func _draw() -> void:
	if is_instance_valid(art):
		return
	var coat := Color("34495c") if hurt_flash <= 0.0 else Color.WHITE
	draw_rect(Rect2(-9,-8,18,26),coat)
	draw_rect(Rect2(-7,-18,14,12),Color("c99f79"))
	draw_rect(Rect2(-8,-20,16,5),Color("202b3c"))
	draw_rect(Rect2(-6,12,5,9),Color("1a2130"))
	draw_rect(Rect2(2,12,5,9),Color("1a2130"))
	draw_rect(Rect2(facing*8,-2, facing*13,4).abs(),Color("8fa8b3"))
	draw_circle(Vector2(0,-2),2,Color("69eddb"))
	if blade_timer > 0.35:
		draw_arc(Vector2(facing*12,0),27,-1.1 if facing>0 else 2.0,1.1 if facing>0 else 4.2,12,Color("b6f3e2"),3)

func equip(id: String) -> void:
	weapon_states[weapon_id] = {"heat":heat,"locked":overheated,"since":since_shot,"cooling":weapon_cooling}
	weapon_id = id
	var specs: Dictionary = {"RIF01":[12,2,13,0.25,25,1],"WPN01":[6,4,24,0.55,30,4],"WPN02":[32,5,30,0.85,22,1],"WPN03":[16,2,10,0.35,27,1]}
	var values: Array = specs.get(id,specs.RIF01)
	weapon_damage=values[0]; weapon_cost=values[1]; weapon_heat=values[2]
	weapon_interval=values[3]; weapon_cooling=values[4]; pellet_count=values[5]
	var saved: Dictionary = weapon_states.get(id,{"heat":0.0,"locked":false,"since":10.0})
	heat=saved.heat; overheated=saved.locked; since_shot=saved.since
	shot_timer = maxf(shot_timer,weapon_interval)
