extends Node2D
const Player = preload("res://actors/player/player.gd")
const Forager = preload("res://actors/enemies/forager.gd")
const Warden = preload("res://actors/enemies/warden.gd")
const Save = preload("res://systems/slice_save.gd")
const ROOMS := ["OUT01", "OUT02", "CAM02", "SLU02", "SLU03", "ROT01"]
const NAMES := ["Outer Wilds / Trailhead", "Hunter's Trail", "Old Survey Camp", "Echo Sluice", "Relic Watch", "Rootspan"]
var room_index: int = 0
var room: Node2D
var player: CharacterBody2D
var enemies: Array[CharacterBody2D] = []
var pickups: Array[Dictionary] = []
var waves: Array[Dictionary] = []
var flags: Dictionary = {}
var released: Dictionary = {}
var visited: Dictionary = {}
var sequence: Array[int] = []
var bridge: StaticBody2D
var hud: Label
var hint: Label
var journal: Label
var pause_panel: VBoxContainer
var pulse_time: float = 0.0
var beam_time: float = 0.0
var beam_start := Vector2.ZERO
var beam_end := Vector2.ZERO
var checkpoint: int = 0
var restoring: bool = false
var persistence_enabled: bool = true
var pending_rewards: Dictionary = {}

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    RenderingServer.set_default_clear_color(Color("182d3b"))
    player = Player.new()
    player.process_mode = Node.PROCESS_MODE_PAUSABLE
    add_child(player)
    player.shot.connect(fire)
    player.blade.connect(melee)
    player.died.connect(on_death)
    var saved: Dictionary = Save.read_state() if persistence_enabled and not PlatformInput.new_run_requested else {}
    PlatformInput.new_run_requested = false
    if not saved.is_empty():
        flags = saved.get("flags", {})
        released = saved.get("released", {})
        visited = saved.get("visited", {})
        pending_rewards = saved.get("pending_rewards", {})
        checkpoint = clampi(int(saved.get("checkpoint", 0)), 0, ROOMS.size()-1)
        player.energy = clampf(float(saved.get("energy", 60)), 0, 100)
    player.released = released
    make_ui()
    load_room(checkpoint)

func make_ui() -> void:
    var layer := CanvasLayer.new()
    layer.layer = 5
    add_child(layer)
    var bar := ColorRect.new()
    bar.color = Color("111b2a")
    bar.size = Vector2(640, 42)
    layer.add_child(bar)
    hud = Label.new()
    hud.position = Vector2(12, 4)
    hud.add_theme_font_size_override("font_size", 13)
    layer.add_child(hud)
    hint = Label.new()
    hint.position = Vector2(12, 45)
    hint.size = Vector2(610, 70)
    hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    hint.add_theme_font_size_override("font_size", 13)
    layer.add_child(hint)
    journal = Label.new()
    journal.position = Vector2(35, 110)
    journal.size = Vector2(560, 170)
    journal.add_theme_font_size_override("font_size", 14)
    journal.hide()
    layer.add_child(journal)
    var button := Button.new()
    button.text = "Map / clues"
    button.position = Vector2(460, 8)
    button.pressed.connect(show_journal)
    layer.add_child(button)
    var pause := Button.new()
    pause.text = "II"
    pause.position = Vector2(594, 5)
    pause.pressed.connect(toggle_pause)
    layer.add_child(pause)
    pause_panel = VBoxContainer.new()
    pause_panel.position = Vector2(245, 150)
    for caption: String in ["Resume", "Title"]:
        var action := Button.new()
        action.text = caption
        action.custom_minimum_size = Vector2(150, 42)
        if caption == "Resume":
            action.pressed.connect(toggle_pause)
        else:
            action.pressed.connect(func() -> void:
                get_tree().paused = false
                PlatformInput.release_actions()
                get_tree().change_scene_to_file("res://ui/title.tscn"))
        pause_panel.add_child(action)
    pause_panel.hide()
    layer.add_child(pause_panel)
    add_child(load("res://ui/touch_controls.gd").new())

func floor_piece(at: Vector2, size: Vector2) -> StaticBody2D:
    var body := StaticBody2D.new()
    body.position = at
    var collision := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = size
    collision.shape = shape
    body.add_child(collision)
    var art := Sprite2D.new()
    art.texture = preload("res://art/runtime/terrain.png")
    art.region_enabled = true
    art.region_rect = Rect2(Vector2.ZERO, size)
    art.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
    body.add_child(art)
    room.add_child(body)
    return body

func load_room(index: int, from_right: bool = false) -> void:
    if is_instance_valid(room):
        remove_child(room)
        room.queue_free()
    enemies.clear()
    pickups.clear()
    waves.clear()
    sequence.clear()
    bridge = null
    room_index = clampi(index, 0, ROOMS.size()-1)
    visited[ROOMS[room_index]] = true
    room = Node2D.new()
    room.process_mode = Node.PROCESS_MODE_PAUSABLE
    add_child(room)
    move_child(room, 0)
    var background := Sprite2D.new()
    var family: String = ["frontier", "frontier", "camp", "sluice", "arena", "rootspan"][room_index]
    background.texture = load("res://art/runtime/bg_"+family+".png")
    background.centered = false
    room.add_child(background)
    if room_index == 3:
        floor_piece(Vector2(120, 312), Vector2(240, 32))
        floor_piece(Vector2(460, 312), Vector2(360, 32))
        bridge = floor_piece(Vector2(260, 304), Vector2(40, 16))
        bridge.position.y = 304 if flags.get("SLUICE_OPEN", false) else 430
    else:
        floor_piece(Vector2(320, 312), Vector2(640, 32))
    if room_index == 1:
        floor_piece(Vector2(235, 258), Vector2(65, 12))
        floor_piece(Vector2(330, 228), Vector2(55, 12))
        if not flags.get("OUT02_ENEMY", false):
            spawn_enemy(false)
    if room_index == 4 and not flags.get("WARDEN_DOWN", false):
        spawn_enemy(true)
    for token: String in pending_rewards:
        var reward: Dictionary = pending_rewards[token]
        if reward.room == ROOMS[room_index] and not released.has(token):
            pickups.append({"id":token,"at":Vector2(float(reward.x),float(reward.y)),"energy":reward.energy})
    player.position = Vector2(580 if from_right else 60, 270)
    player.spawn = player.position
    player.velocity = Vector2.ZERO
    hint.text = [
        "Aster's trail begins here. A/D or left stick: move. Space / South: jump. E at the cyan station: rest and save. Explore right.",
        "Something is feeding on the conduits. Watch the creature crouch before it lunges; punish its recovery. Blade needs no energy.",
        "Survey camp: E by the tent to inspect the expedition record. The bridge machinery ahead shares these landmarks.",
        "Sluice plinth: the CENTER conductor is LAST. Stand by a conductor and press E; 1/2/3 also select ROOT / BELL / STONE locally.",
        "Sluice Warden: jump the floor waves. Its core is exposed while its arm is stuck. Below half health, expect two slams.",
        "The restored waterway continues toward the Reliquary Works. First production slice complete; the full campaign is still being built. E at the station to save."
    ][room_index]
    queue_redraw()

func spawn_enemy(boss: bool) -> void:
    var actor: CharacterBody2D = Warden.new() if boss else Forager.new()
    actor.target = player
    actor.position = Vector2(440, 255 if boss else 280)
    actor.token = "B01" if boss else "OUT02:forager:1"
    actor.defeated.connect(defeated)
    if boss:
        actor.shockwave.connect(func(at: Vector2, direction: float) -> void: waves.append({"at": at, "direction": direction}))
    room.add_child(actor)
    enemies.append(actor)

func _process(dt: float) -> void:
    if Input.is_action_just_pressed("pause"):
        toggle_pause()
    if get_tree().paused:
        return
    if Input.is_action_just_pressed("journal"):
            show_journal()
    pulse_time += dt
    beam_time = maxf(0, beam_time-dt)
    for wave: Dictionary in waves:
        wave.at.x += wave.direction*180*dt
        if absf(wave.at.x-player.position.x)<18 and absf(wave.at.y-player.position.y)<24:
            player.damage(18)
    waves = waves.filter(func(wave: Dictionary) -> bool: return wave.at.x > -40 and wave.at.x < 680)
    for pickup: Dictionary in pickups:
        if not pickup.get("done",false) and player.position.distance_to(pickup.at)<30:
            player.collect(pickup.id, pickup.energy)
            pickup.done = true
            pending_rewards.erase(pickup.id)
            commit()
            hint.text = "Echo released safely to Aether. Energy stored in Collector; overflow dissipates."
    if Input.is_action_just_pressed("interact"):
        interact()
    if room_index == 3 and player.position.x<230:
        for i in range(3):
            if Input.is_action_just_pressed(["first","second","third"][i]):
                conductor(i+1)
    if player.position.x > 625:
        if can_advance():
            load_room(room_index+1)
        else:
            player.position.x = 620
            hint.text = "Restore the Sluice to open this route." if room_index==3 else "The guardian still blocks this passage."
    elif player.position.x < 15:
        if room_index>0 and (room_index!=4 or enemies.is_empty()):
            load_room(room_index-1, true)
        else:
            player.position.x = 15
    hud.text = "%s   HP %d   EE %d   HEAT %d%% %s" % [ROOMS[room_index],player.hp,player.energy,player.heat,"HOT" if player.overheated else ""]
    queue_redraw()

func can_advance() -> bool:
    if room_index>=ROOMS.size()-1:
        return false
    if room_index==3:
        return flags.get("SLUICE_OPEN",false)
    if room_index==4:
        return flags.get("WARDEN_DOWN",false)
    return true

func interact() -> void:
    if room_index in [0,2,5] and player.position.x<140:
        checkpoint = room_index
        player.hp = 100
        player.energy = maxf(50,player.energy)
        player.heat = 0
        player.overheated = false
        commit()
    elif room_index==2 and player.position.x>330:
        flags["CAMP_CLUE"] = true
        hint.text = "Dawn survey: ROOT ARCH precedes HANGING BELL. The SPLIT STONE marks the central conductor. Recorded in your journal."
    elif room_index==3:
        if player.position.x<230:
            var nearest: int = clampi(roundi((player.position.x-130)/35)+1,1,3)
            conductor(nearest)
        elif flags.get("SLUICE_OPEN",false) and player.position.x>540:
            load_room(0)
            hint.text = "Maintenance shortcut: restored Sluice connects back to the Trailhead."

func conductor(value: int) -> void:
    if flags.get("SLUICE_OPEN",false):
        hint.text = "The bridge is restored. Green maintenance marker on the far bank returns to the Trailhead."
        return
    sequence.append(value)
    var expected: Array[int] = [1,2,3]
    if value != expected[sequence.size()-1]:
        hint.text = "Conductor mismatch. The last input breaks the relief's order; the local mechanism has reset."
        sequence.clear()
    elif sequence.size()==3:
        flags["SLUICE_OPEN"] = true
        bridge.position.y = 304
        hint.text = "Water and Echo flow restored. Bridge lifted; the maintenance return route is now active."
        sequence.clear()
        commit()
    else:
        hint.text = "Conductor accepted · %d / 3. Follow the expedition record and the central-plinth rule." % sequence.size()

func fire(origin: Vector2, direction: Vector2) -> void:
    var result: Dictionary = get_world_2d().direct_space_state.intersect_ray(PhysicsRayQueryParameters2D.create(origin,origin+direction*420,5))
    beam_start = origin
    beam_end = origin+direction*420
    if not result.is_empty():
        beam_end = result.position
        if result.collider.has_method("hit"):
            result.collider.hit(12)
    beam_time = 0.07

func melee(origin: Vector2, direction: float) -> void:
    for actor: CharacterBody2D in enemies:
        if is_instance_valid(actor) and origin.distance_to(actor.position)<80 and (actor.position.x-origin.x)*direction>=0:
            actor.hit(18)

func defeated(token: String, at: Vector2) -> void:
    if token=="B01":
        flags["WARDEN_DOWN"] = true
        hint.text = "Warden safe mode engaged. The Rootspan passage is open."
    else:
        flags["OUT02_ENEMY"] = true
    pending_rewards[token] = {"room":ROOMS[room_index],"x":at.x,"y":at.y,"energy":40 if token=="B01" else 12}
    pickups.append({"id":token,"at":at,"energy":40 if token=="B01" else 12})
    commit()
    enemies = enemies.filter(func(actor: CharacterBody2D) -> bool: return is_instance_valid(actor) and actor.token!=token)

func on_death() -> void:
    if restoring:
        return
    restoring = true
    call_deferred("reset_attempt")
func reset_attempt() -> void:
    load_room(checkpoint)
    player.hp = 100
    player.immunity = 1.0
    player.energy = maxf(50,player.energy)
    restoring = false

func commit() -> void:
    if not persistence_enabled:
        return
    var error: Error = Save.write_state({"flags":flags,"released":released,"visited":visited,"checkpoint":checkpoint,"energy":player.energy,"pending_rewards":pending_rewards})
    if error != OK:
        hint.text = "Checkpoint could not be written; session progress is still in memory."
    else:
        hint.text += "  [Checkpoint saved]"

func toggle_pause() -> void:
    get_tree().paused = not get_tree().paused
    pause_panel.visible = get_tree().paused
    PlatformInput.release_actions()
    if get_tree().paused:
        var button: Button = pause_panel.get_child(0)
        button.grab_focus()

func show_journal() -> void:
    journal.visible = not journal.visible
    journal.text = "EXPEDITION JOURNAL\nTrailhead <-> Hunter trail <-> Camp <-> Sluice -> Warden -> Rootspan\n\n" + ("Dawn record: Root Arch before Hanging Bell. Split Stone = center.\n" if flags.get("CAMP_CLUE",false) else "Inspect the survey camp to record its landmark clue.\n") + "Sluice: " + ("restored; maintenance shortcut active" if flags.get("SLUICE_OPEN",false) else "inactive")

func _draw() -> void:
    if not is_instance_valid(player):
        return
    if room_index in [0,2,5]:
        draw_rect(Rect2(80,266,16,30), Color("344951"))
        draw_circle(Vector2(88,270),6,Color("56cdc4"))
    if room_index==3:
        for i in range(3):
            var x: float = 130+i*35
            draw_rect(Rect2(x-8,268,16,28),Color("243447"))
            draw_circle(Vector2(x,270),5,Color("aff5dc") if sequence.has(i+1) or flags.get("SLUICE_OPEN",false) else Color("91704f"))
        if flags.get("SLUICE_OPEN",false):
            draw_circle(Vector2(565,278),7,Color("829c6a"))
    for pickup: Dictionary in pickups:
        if not pickup.get("done",false):
            draw_circle(pickup.at+Vector2(0,sin(pulse_time*4)*3),5,Color("aff5dc"))
    for wave: Dictionary in waves:
        draw_arc(wave.at,14,PI,TAU,8,Color("56cdc4"),3)
    if beam_time>0:
        draw_line(beam_start,beam_end,Color("aff5dc"),2)
