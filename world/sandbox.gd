extends Node2D
const PlayerScript = preload("res://actors/player/player.gd")
const ForagerScript = preload("res://actors/enemies/forager.gd")
var player: CharacterBody2D
var enemy: CharacterBody2D
var hud: Label
var message: Label
var puzzle: Array[int] = []
var solved: bool = false
var bridge: StaticBody2D
var pickup_position := Vector2.ZERO
var pickup_token: String = ""
var flash: float = 0.0
var beam_from := Vector2.ZERO
var beam_to := Vector2.ZERO
func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    RenderingServer.set_default_clear_color(Color("111b29"))
    platform(Vector2(130,310),Vector2(260,24))
    platform(Vector2(460,310),Vector2(360,24))
    platform(Vector2(210,260),Vector2(70,12))
    bridge = platform(Vector2(270,300),Vector2(24,12))
    bridge.position.y = 390
    player = PlayerScript.new()
    player.process_mode = Node.PROCESS_MODE_PAUSABLE
    player.position = Vector2(60,270)
    add_child(player)
    player.shot.connect(on_shot)
    player.blade.connect(on_blade)
    player.changed.connect(update_hud)
    enemy = ForagerScript.new()
    enemy.process_mode = Node.PROCESS_MODE_PAUSABLE
    enemy.position = Vector2(390,280)
    enemy.target = player
    enemy.defeated.connect(on_defeated)
    add_child(enemy)
    var layer := CanvasLayer.new()
    add_child(layer)
    hud = Label.new()
    hud.position = Vector2(14,10)
    hud.add_theme_font_size_override("font_size",16)
    layer.add_child(hud)
    message = Label.new()
    message.position = Vector2(14,42)
    message.add_theme_font_size_override("font_size",12)
    message.text = "OUT01 / PRODUCTION SANDBOX · temporary art\nA/D move · Space jump · Shift dodge · Mouse fire/blade\nE near cyan rest station · 1/2/3 near conductors · Esc pause\nRelief: ROOT precedes BELL. Plinth: STONE is last."
    layer.add_child(message)
    add_child(load("res://ui/touch_controls.gd").new())
    add_pause_menu()
    update_hud()
func platform(at: Vector2, size: Vector2) -> StaticBody2D:
    var body := StaticBody2D.new()
    body.position = at
    body.collision_layer = 1
    var collider := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = size
    collider.shape = shape
    body.add_child(collider)
    var visual := Polygon2D.new()
    visual.polygon = PackedVector2Array([-size/2,Vector2(size.x/2,-size.y/2),size/2,Vector2(-size.x/2,size.y/2)])
    visual.color = Color("344951")
    body.add_child(visual)
    add_child(body)
    return body
func handle_interactions() -> void:
    if Input.is_action_just_pressed("interact") and player.position.distance_to(Vector2(90,285)) < 45:
        player.hp = 100
        player.energy = maxf(player.energy,50)
        player.heat = 0
        player.overheated = false
        player.spawn = Vector2(90,270)
        message.text = "Rested. Health restored, cell at least 50 EE, rifle cooled."
    for i in range(3):
        if Input.is_action_just_pressed(["first","second","third"][i]) and player.position.x < 250:
            puzzle.append(i+1)
            if puzzle.size() == 3:
                solved = puzzle == [1,2,3]
                bridge.position.y = 300 if solved else 390
                message.text = "Echo Sluice restored. Bridge open." if solved else "Sequence rejected. ROOT → BELL → STONE. Try again locally."
                puzzle.clear()
func _process(dt: float) -> void:
    if Input.is_action_just_pressed("pause"):
        toggle_pause()
    if get_tree().paused:
        return
    handle_interactions()
    flash = maxf(0,flash-dt)
    if pickup_token != "" and player.position.distance_to(pickup_position) < 32:
        player.collect(pickup_token,12)
        pickup_token = ""
        message.text = "Echo safely released to Aether · +12 Echo Energy (capacity 100)"
    queue_redraw()
func update_hud() -> void:
    if is_instance_valid(hud):
        hud.text = "ASTER   HP %d   Echo Energy %d/100   Heat %d%% %s" % [player.hp,player.energy,player.heat,"OVERHEATED" if player.overheated else ""]
func on_shot(origin: Vector2, direction: Vector2) -> void:
    var query := PhysicsRayQueryParameters2D.create(origin,origin+direction*420,5)
    var result: Dictionary = get_world_2d().direct_space_state.intersect_ray(query)
    beam_from = origin
    beam_to = origin+direction*420
    if not result.is_empty():
        beam_to = result.position
        if result.collider.has_method("hit"):
            result.collider.hit(12)
    flash = 0.06
func on_blade(origin: Vector2, direction: float) -> void:
    if is_instance_valid(enemy) and enemy.position.distance_to(origin) < 62 and (enemy.position.x-origin.x)*direction >= 0:
        enemy.hit(18)
func on_defeated(token: String, at: Vector2) -> void:
    pickup_token = token
    pickup_position = at
func _draw() -> void:
    for x in range(15,640,64):
        draw_rect(Rect2(x,145,10,150),Color("20313c"))
        draw_circle(Vector2(x+5,155),32,Color("1b303a"))
    draw_circle(Vector2(90,286),8,Color("69ddce"))
    for i in range(3):
        draw_rect(Rect2(155+i*25,286,12,12),Color("dfbd77") if puzzle.has(i+1) else Color("477b81"))
    if pickup_token != "":
        draw_circle(pickup_position,5,Color("a7ffec"))
    if flash > 0:
        draw_line(beam_from,beam_to,Color("9af8e1"),2)

var pause_panel: PanelContainer
func add_pause_menu() -> void:
    var canvas := CanvasLayer.new()
    canvas.layer = 20
    add_child(canvas)
    pause_panel = PanelContainer.new()
    pause_panel.position = Vector2(205,95)
    pause_panel.size = Vector2(230,160)
    canvas.add_child(pause_panel)
    var box := VBoxContainer.new()
    pause_panel.add_child(box)
    for caption: String in ["Resume", "Title screen"]:
        var button := Button.new()
        button.text = caption
        button.custom_minimum_size.y = 50
        if caption == "Resume":
            button.pressed.connect(toggle_pause)
        else:
            button.pressed.connect(func() -> void:
                get_tree().paused = false
                PlatformInput.release_actions()
                get_tree().change_scene_to_file("res://ui/title.tscn"))
        box.add_child(button)
    pause_panel.hide()
    var pause_button := Button.new()
    pause_button.text = "II"
    pause_button.position = Vector2(598,8)
    pause_button.size = Vector2(34,30)
    pause_button.pressed.connect(toggle_pause)
    canvas.add_child(pause_button)
func toggle_pause() -> void:
    get_tree().paused = not get_tree().paused
    pause_panel.visible = get_tree().paused
    PlatformInput.release_actions()
    if get_tree().paused:
        var box: VBoxContainer = pause_panel.get_child(0)
        var button: Button = box.get_child(0)
        button.grab_focus()
