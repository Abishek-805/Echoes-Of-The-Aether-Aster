extends Node2D
const State = preload("res://systems/campaign_state.gd")
const Player = preload("res://actors/player/player.gd")
const Enemy = preload("res://actors/enemies/campaign_enemy.gd")
const Boss = preload("res://actors/enemies/campaign_boss.gd")
const Map = preload("res://ui/exploration_map.gd")
var state = State.new()
var db: Dictionary
var layout_db: Dictionary = {}
var rooms: Dictionary = {}
var room_layouts: Dictionary = {}
var current: String = "TOW01"
var room: Node2D
var player: CharacterBody2D
var actors: Array[CharacterBody2D] = []
var encounters: Dictionary = {}
var hazards: Array[Dictionary] = []
var defeated_local: Dictionary = {}
var pickups: Array[Dictionary] = []
var room_landmarks: Array[Dictionary] = []
var generation: int = 0
var tint: CanvasModulate
var hud: Label
var hint: Label
var modal: PanelContainer
var modal_box: VBoxContainer
var map_view: Control
var ui_layer: CanvasLayer
var persistence_enabled: bool = true
var stage: int = 0
var active_puzzle: Dictionary = {}
var puzzle_hint_stage: int = 0
var story_sequence: CanvasLayer
var stories_enabled: bool = true
var sequence: Array[int] = []
var checkpoint: String = "TOW01"
var beam_start := Vector2.ZERO
var beam_end := Vector2.ZERO
var beam_time: float = 0
var status_timer: float = 0
var retrying: bool = false
var rewind_start_pad := Vector2.ZERO
var rewind_switch: bool = false
var settings_touch: bool = false

const PUZZLE_STEPS := {
"P01":[["Root Arch","Hanging Bell","Split Stone"],[0,1,2]],
"P02":[["Bell east","Bell west","Bell at camp"],[0], ["Rock east","Rock west","Rock at camp"],[1], ["Arch east","Arch west","Arch at camp"],[2]],
"P03":[["Source → dead archive","Source → service relay","Source → nowhere"],[1], ["Relay → receiver","Relay → dead archive","Disconnect relay"],[0]],
"P04":[["Receiver","Archive","Anchor"],[0,1,2]],
"P05":[["Flickering left anchor","Steady paired diamond","Broken right anchor"],[1]],
"P06":[["Vault power ON","Vault power OFF"],[0], ["Release OFF","Release ON"],[1], ["Full storage ON","Full storage OFF"],[1]],
"P07":[["Keep left conductor active","Isolate left conductor"],[1], ["Isolate right conductor","Restart right conductor"],[0]],
"P08":[["Sluice: Flow","Sluice: Stop"],[0], ["Survey: Anchor","Survey: Archive"],[1], ["Reservoir: Storage","Reservoir: Release"],[1]],
"P10":[["Diamond A → ring C","Diamond A → diamond A"],[1], ["Split B → split B","Split B → diamond A"],[0], ["Ring C → split B","Ring C → ring C"],[1]],
"P11":[["Open release line","Close release line"],[0], ["Power broken transit","Enable approach receiver"],[1]],
"P12":[["Isolate broken transit","Power broken transit"],[0], ["Connect reserve to beacon","Drain player's cell"],[0], ["Confirm distress packet","Rebuild gate with Rewind"],[0]]}

const PUZZLE_OBSERVATIONS := {
	"P01":"Three conductors bear different marks. The center plinth is damaged; the bell and arch still answer the pulse.",
	"P02":"A bell, a split rock and a camp arch are drawn on the survey map. Compare the drawing with the landmarks outside.",
	"P03":"The source feeds an empty branch and a service relay. Follow the path that reaches the maintenance receiver.",
	"P04":"The display has three plates around the powered receiver. Match their symbols to the service order.",
	"P05":"Three doors cross the fracture. Watch their anchor pulses and compare the stable shape with the field record.",
	"P06":"The vault has separate power, release and storage controls. Its storage indicator is already full.",
	"P07":"The Keeper's shield is fed by two conductors. Find and isolate both before attacking its core.",
	"P08":"The relic remains sealed until the Sluice, Survey and Reservoir systems report their verified states.",
	"P09":"The shutter retains Aster's path. Touch the far latch, then return to the starting pad with Rewind.",
	"P10":"Each anchor panel displays half a shape. Join matching halves and follow the stable corridor.",
	"P11":"The approach has three stabilizers. Keep the Echo release line open before routing power onward.",
	"P12":"The transit gate is fractured. Isolate that load and route reserve power to the diagnostic beacon."}
const PUZZLE_PROMPTS := {
	"P01":"Restore the Sluice bridge by activating conductors in an order supported by the room's evidence.",
	"P02":"Align the survey map with the landmarks and accept its maintenance route.",
	"P03":"Route source power to the maintenance receiver without feeding the dead archive branch.",
	"P04":"Set the archive plates into their verified sequence.",
	"P05":"Choose the stable anchor topology through the Fold.",
	"P06":"Stabilize the Reservoir while keeping Echo release safe.",
	"P07":"Disable both Keeper shield conductors.",
	"P08":"Synchronize the three verified systems to open the relic chamber.",
	"P09":"Touch the switch beyond the shutter, then return to the pad using Echo Rewind.",
	"P10":"Reconstruct the local anchor connections.",
	"P11":"Stabilize the final approach and preserve the safe release path.",
	"P12":"Route reserve power to the beacon without reconnecting the broken gate."}

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    db = JSON.parse_string(FileAccess.get_file_as_string("res://data/campaign.json"))
    for item: Dictionary in db.rooms:
        rooms[item.id] = item
    layout_db = JSON.parse_string(FileAccess.get_file_as_string("res://data/room_layouts.json"))
    for item: Dictionary in layout_db.get("rooms",[]):
        room_layouts[item.id] = item
    if persistence_enabled and not PlatformInput.new_run_requested:
        state.restore(preload("res://systems/slice_save.gd").read_state(State.PATH),rooms.keys())
    PlatformInput.new_run_requested = false
    checkpoint = state.checkpoint
    generation = state.generation
    defeated_local = state.defeated
    player = Player.new()
    player.process_mode = Node.PROCESS_MODE_PAUSABLE
    add_child(player)
    player.shot.connect(fire)
    player.blade.connect(melee)
    player.died.connect(on_death)
    player.energy = state.energy
    player.max_hp = state.max_hp
    player.capacity = state.capacity
    player.hp = state.max_hp
    player.released = state.released
    if state.owned.has(state.equipped):
        player.equip(state.equipped)
    player.weapon_states = state.thermal
    if state.thermal.has(state.equipped):
        var thermal: Dictionary = state.thermal[state.equipped]
        player.heat = clampf(float(thermal.get("heat",0)),0,100)
        player.overheated = bool(thermal.get("locked",false))
        player.since_shot = float(thermal.get("since",10))
    apply_upgrades()
    make_ui()
    load_room(state.checkpoint)

func make_ui() -> void:
    ui_layer = CanvasLayer.new()
    ui_layer.layer = 5
    add_child(ui_layer)
    var backdrop := ColorRect.new()
    backdrop.color = Color("111b2a")
    backdrop.size = Vector2(640,42)
    ui_layer.add_child(backdrop)
    hud = Label.new()
    hud.position = Vector2(8,4)
    hud.add_theme_font_size_override("font_size",12)
    ui_layer.add_child(hud)
    hint = Label.new()
    hint.position = Vector2(12,46)
    hint.size = Vector2(610,70)
    hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    hint.add_theme_font_size_override("font_size",12)
    ui_layer.add_child(hint)
    var map_button := Button.new()
    map_button.text = "M Map"
    map_button.position = Vector2(480,3)
    map_button.pressed.connect(toggle_map)
    ui_layer.add_child(map_button)
    var menu := Button.new()
    menu.text = "Menu"
    menu.position = Vector2(564,3)
    menu.pressed.connect(open_pause)
    ui_layer.add_child(menu)
    modal = PanelContainer.new()
    modal.position = Vector2(70,80)
    modal.size = Vector2(500,250)
    ui_layer.add_child(modal)
    modal_box = VBoxContainer.new()
    modal_box.add_theme_constant_override("separation",5)
    var scroll := ScrollContainer.new()
    scroll.custom_minimum_size = Vector2(500,230)
    scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
    modal.add_child(scroll)
    modal_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    scroll.add_child(modal_box)
    modal.hide()
    map_view = Map.new()
    map_view.position = Vector2(20,45)
    map_view.size = Vector2(600,305)
    map_view.hide()
    ui_layer.add_child(map_view)
    var touch: CanvasLayer = load("res://ui/touch_controls.gd").new()
    touch.expanded = true
    add_child(touch)
    story_sequence = load("res://systems/story_sequence.gd").new()
    story_sequence.layer = 20
    story_sequence.sequence_finished.connect(_on_story_finished)
    add_child(story_sequence)

func _on_story_finished(_scene_id: String, updates: Dictionary) -> void:
    for key: String in updates:
        state.flags[key] = updates[key]
    commit()

func play_story(scene_id: String) -> bool:
    if not stories_enabled or not is_instance_valid(story_sequence) or story_sequence.busy:
        return false
    if not story_sequence.scenes.has(scene_id):
        return false
    var data: Dictionary = story_sequence.scenes[scene_id]
    var complete_flag: String = str(data.get("complete_flag", ""))
    if not complete_flag.is_empty() and state.flags.get(complete_flag, false):
        return false
    return story_sequence.play(scene_id)

func panel(title: String, description: String) -> void:
    for child: Node in modal_box.get_children():
        modal_box.remove_child(child)
        child.queue_free()
    map_view.hide()
    modal.show()
    get_tree().paused = true
    PlatformInput.release_actions()
    var label := Label.new()
    label.text = title
    label.add_theme_font_size_override("font_size",17)
    modal_box.add_child(label)
    var text := Label.new()
    text.text = description
    text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    text.custom_minimum_size.x = 480
    text.add_theme_font_size_override("font_size",12)
    modal_box.add_child(text)
func choice(caption: String, callback: Callable, disabled: bool = false) -> void:
    var button := Button.new()
    button.text = caption
    button.disabled = disabled
    button.custom_minimum_size.y = 28
    button.add_theme_font_size_override("font_size",12)
    button.pressed.connect(callback)
    modal_box.add_child(button)
    if modal_box.get_child_count()==3 and not disabled:
        button.grab_focus()
func close_panel() -> void:
    modal.hide()
    map_view.hide()
    get_tree().paused = false
    PlatformInput.release_actions()
func toggle_map() -> void:
    if map_view.visible:
        close_panel()
        return
    modal.hide()
    map_view.configure(db.rooms,db.edges,state.visited,current,state.flags)
    map_view.show()
    get_tree().paused = true
    PlatformInput.release_actions()
func open_pause() -> void:
    if modal.visible or map_view.visible:
        close_panel()
        return
    panel("Expedition paused","Explore, read landmarks, open routes. M: map · J: records · I: gear\nSpace: double jump · Shift: dodge · Q: heal · F: Rewind after discovery")
    choice("Resume",close_panel)
    choice("Title",func() -> void:
        close_panel()
        get_tree().change_scene_to_file("res://ui/title.tscn"))

func make_floor(at: Vector2, size: Vector2, one_way: bool = false) -> void:
    var body := StaticBody2D.new()
    body.position = at
    body.collision_layer = 8 if one_way else 1
    var collider := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = size
    collider.shape = shape
    collider.one_way_collision = one_way
    body.add_child(collider)
    var visual := Polygon2D.new()
    visual.polygon = PackedVector2Array([-size/2,Vector2(size.x/2,-size.y/2),size/2,Vector2(-size.x/2,size.y/2)])
    visual.color = Color("527266") if one_way else Color("344951")
    body.add_child(visual)
    room.add_child(body)

func load_room(id: String, entry_x: float = 80.0) -> void:
    if not rooms.has(id):
        return
    close_panel()
    if is_instance_valid(room):
        remove_child(room)
        room.queue_free()
    current = id
    state.visited[id] = true
    actors.clear()
    encounters.clear()
    pickups.clear()
    room_landmarks.clear()
    hazards.clear()
    sequence.clear()
    player.rewind.clear_history()
    player.rewind_unlocked = state.flags.get("REWIND_ACQUIRED",false)
    room = Node2D.new()
    room.process_mode = Node.PROCESS_MODE_PAUSABLE
    add_child(room)
    move_child(room,0)
    tint = CanvasModulate.new()
    room.add_child(tint)
    var background := Sprite2D.new()
    var family: String = "frontier"
    if id.begins_with("CAM"):
        family = "camp"
    elif id.begins_with("SLU") or id.begins_with("RES"):
        family = "sluice"
    elif id.begins_with("ROT"):
        family = "rootspan"
    elif id.begins_with("GAT") or id.begins_with("REW"):
        family = "arena"
    background.texture = load("res://art/runtime/bg_"+family+".png")
    background.centered = false
    room.add_child(background)
    make_floor(Vector2(320,320),Vector2(640,40))
    if room_layouts.has(id):
        var layout: Dictionary = room_layouts[id]
        for platform: Dictionary in layout.get("platforms",[]):
            make_floor(Vector2(float(platform.x),float(platform.y)),Vector2(float(platform.width),float(platform.height)),true)
    else:
        var variant: int = int(id.right(2))%4
        if variant in [0,1]:
            make_floor(Vector2(220,246),Vector2(100,12),true)
            make_floor(Vector2(345,193),Vector2(90,12),true)
        elif variant==2:
            make_floor(Vector2(200,260),Vector2(70,12),true)
            make_floor(Vector2(415,237),Vector2(80,12),true)
        else:
            make_floor(Vector2(200,268),Vector2(95,12),true)
            make_floor(Vector2(410,210),Vector2(90,12),true)
    player.position = Vector2(entry_x,275)
    player.spawn = player.position
    player.velocity = Vector2.ZERO
    player.set_collision_mask_value(4,true)
    player.immunity = maxf(player.immunity,0.4)
    spawn_room_landmarks()
    spawn_collectibles()
    if not id.begins_with("TOW"):
        spawn_encounters()
    hint.text = "%s · %s\nE interact with nearby items, clues, stations and devices · M map · J journal · I gear." % [id,rooms[id].room]
    if id=="TOW01":
        play_story("CIN01_TOWN")
    if id=="HUN03" and not state.flags.get("WARP",false):
        hint.text = "A violet fracture crosses the trail. Inspect the beacon and route markers after the disturbance."
        if not play_story("ECHO_WARP"):
            state.flags.WARP = true
            commit()
    if id=="SUR03" and not state.flags.get("VAULT_MAP",false):
        hint.text = "An archive projection waits at the amber record. Compare its diagram with the field landmarks."
    if id=="GAT04" and state.flags.get("SIGNAL_SENT",false):
        if not play_story("DISTRESS_REFUGE"):
            state.flags.END_COMPLETE = true
            commit()
    queue_redraw()

func spawn_collectibles() -> void:
    var item_index: int = 0
    for item: Dictionary in db.collectibles:
        if item.room!=current or state.collected.has(item.id):
            continue
        if current=="ROT04" and not state.flags.get("TITAN_DOWN",false):
            continue
        if current=="FOL04" and not state.flags.get("DEVOURER_DOWN",false):
            continue
        var at := Vector2(155.0+float(item_index)*68.0,275.0-float(item_index%2)*45.0)
        for landmark: Dictionary in room_landmarks:
            if str(landmark.id) == str(item.id):
                at = landmark.at
                break
        var marker := Node2D.new()
        marker.position = at
        var color := Color("6fdad0")
        if str(item.id).begins_with("HP"):
            color = Color("e9bf6b")
        elif str(item.id).begins_with("WPN") or str(item.id).begins_with("BP"):
            color = Color("9ac4ed")
        elif str(item.id).begins_with("MEM") or str(item.id).begins_with("DAWN"):
            color = Color("c3a2e5")
        var glyph := Polygon2D.new()
        glyph.polygon = PackedVector2Array([Vector2(0,-9),Vector2(7,0),Vector2(0,9),Vector2(-7,0)])
        glyph.color = color
        marker.add_child(glyph)
        var label := Label.new()
        label.text = str(item.id)
        label.position = Vector2(-20,-25)
        label.size = Vector2(40,14)
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.add_theme_font_size_override("font_size",8)
        label.add_theme_color_override("font_color",Color("edf5ef"))
        marker.add_child(label)
        room.add_child(marker)
        pickups.append({"id":str(item.id),"description":str(item.description),"at":at,"marker":marker})
        item_index += 1

func spawn_room_landmarks() -> void:
    if not room_layouts.has(current):
        return
    var collectible_ids: Dictionary = {}
    for item: Dictionary in db.collectibles:
        collectible_ids[item.id] = true
    for landmark: Dictionary in room_layouts[current].get("landmarks",[]):
        if collectible_ids.has(landmark.id):
            room_landmarks.append({"id":str(landmark.id),"kind":str(landmark.kind),"at":Vector2(float(landmark.x),float(landmark.y)),"story":str(landmark.get("story",""))})
            continue
        var at := Vector2(float(landmark.x),float(landmark.y))
        var kind: String = str(landmark.kind)
        var marker := Node2D.new()
        marker.position = at
        if kind == "supporting_character":
            var body := Polygon2D.new()
            body.polygon = PackedVector2Array([Vector2(-8,-5),Vector2(8,-5),Vector2(7,13),Vector2(-7,13)])
            body.color = Color.from_hsv(float(abs(hash(landmark.id))%1000)/1000.0,0.38,0.78)
            marker.add_child(body)
            var head := Polygon2D.new()
            head.polygon = PackedVector2Array([Vector2(0,-21),Vector2(7,-17),Vector2(6,-8),Vector2(-6,-8),Vector2(-7,-17)])
            head.color = Color("d9b394")
            marker.add_child(head)
        else:
            var glyph := Polygon2D.new()
            glyph.polygon = PackedVector2Array([Vector2(0,-9),Vector2(7,0),Vector2(0,9),Vector2(-7,0)])
            glyph.color = Color("c5a572") if kind in ["map_landmark","distant_landmark","vista","warm_light_source"] else Color("a28dd0")
            marker.add_child(glyph)
            var stem := Line2D.new()
            stem.points = PackedVector2Array([Vector2(0,9),Vector2(0,22)])
            stem.width = 2.0
            stem.default_color = glyph.color.darkened(0.2)
            marker.add_child(stem)
        var label := Label.new()
        label.text = str(landmark.id).replace("_"," ")
        label.position = Vector2(-42,-36)
        label.size = Vector2(84,14)
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.add_theme_font_size_override("font_size",8)
        label.add_theme_color_override("font_color",Color("edf5ef"))
        marker.add_child(label)
        room.add_child(marker)
        room_landmarks.append({"id":str(landmark.id),"kind":kind,"at":at,"story":str(landmark.get("story",""))})

func collect_nearby_pickup() -> bool:
    for pickup: Dictionary in pickups:
        if player.position.distance_to(pickup.at)>43.0:
            continue
        var id: String = pickup.id
        if state.collected.has(id):
            continue
        state.collected[id] = pickup.description
        if id.begins_with("HP"):
            player.max_hp = minf(140.0,player.max_hp+10.0)
            player.hp = minf(player.max_hp,player.hp+10.0)
        elif id.begins_with("WPN") and not state.owned.has(id):
            state.owned.append(id)
        elif id.begins_with("BP"):
            state.materials.alloy += 4
            state.materials.relic += 1
        if is_instance_valid(pickup.marker):
            pickup.marker.queue_free()
        hint.text = "Collected %s · %s" % [id,pickup.description]
        commit()
        pickups = pickups.filter(func(value: Dictionary) -> bool: return value.id!=id)
        return true
    return false

func inspect_nearby_landmark() -> bool:
    var selected: Dictionary = {}
    var nearest: float = 44.0
    for landmark: Dictionary in room_landmarks:
        var kind: String = str(landmark.kind)
        if kind in ["record_pickup_anchor","collectible_anchor","hidden_memorial_anchor","rest_station","workbench","tutorial_console"]:
            continue
        if current == "TOW03" and kind == "supporting_character":
            continue
        if str(landmark.story).strip_edges().is_empty():
            continue
        var distance: float = player.position.distance_to(landmark.at)
        if distance < nearest:
            nearest = distance
            selected = landmark
    if selected.is_empty():
        return false
    var id: String = str(selected.id)
    var flag: String = "LANDMARK_SEEN_"+id.to_upper()
    state.flags[flag] = true
    panel("Field evidence · "+id.replace("_"," "),str(selected.story))
    choice("Return",close_panel)
    commit()
    return true

func spawn_encounters() -> void:
    for entry: Dictionary in db.bosses:
        if entry.room==current and not state.flags.get(entry.flag,false):
            var boss := Boss.new()
            boss.boss_id = entry.id
            boss.hp = float(entry.hp)
            boss.max_health = boss.hp
            boss.position = Vector2(465,255)
            boss.target = player
            boss.token = entry.id
            boss.defeated.connect(enemy_defeated)
            boss.shockwave.connect(func(at: Vector2,dir: float) -> void: hazards.append({"at":at,"kind":"wave","dir":dir,"delay":0.0,"life":4.0,"damage":18.0}))
            boss.marked_attack.connect(add_mark)
            room.add_child(boss)
            actors.append(boss)
            encounters[entry.id] = {"boss":entry,"energy":40,"material":"alloy"}
            return
    var slot: int = 0
    for entry: Dictionary in db.enemies:
        if not current in str(entry.rooms).split(" "):
            continue
        var token: String = "%s:%s:%d" % [current,entry.id,generation]
        if defeated_local.has(token):
            continue
        var enemy := Enemy.new()
        enemy.target = player
        enemy.hp = float(entry.hp)
        enemy.archetype = entry.id
        enemy.attack_damage = float(entry.damage)
        enemy.token = token
        enemy.position = Vector2(410+slot*90,278)
        enemy.defeated.connect(enemy_defeated)
        enemy.marked_attack.connect(add_mark)
        room.add_child(enemy)
        actors.append(enemy)
        encounters[token] = {"energy":float(entry.ee),"material":str(entry.material).to_lower(),"reward_token":"%s:%s" % [current,entry.id]}
        slot += 1

func _process(dt: float) -> void:
    if Input.is_action_just_pressed("map"):
        toggle_map()
    if Input.is_action_just_pressed("pause"):
        open_pause()
    if get_tree().paused:
        return
    state.day_seconds = fposmod(state.day_seconds+dt,1440.0)
    var sun: float = clampf(sin((state.day_seconds/1440.0-0.25)*TAU)*0.5+0.5,0,1)
    var outside: bool = str(rooms[current].biome) in ["Eldaran frontier","Rootspan waterways"]
    tint.color = Color("45566e").lerp(Color("ffffff"),sun) if outside else Color("a2b5ba")
    beam_time = maxf(0,beam_time-dt)
    update_hazards(dt)
    if player.position.x<15:
        if not try_boundary_transition("left"):
            player.position.x = 15
    elif player.position.x>625:
        if not try_boundary_transition("right"):
            player.position.x = 625
    if Input.is_action_just_pressed("interact") and not player.rewind.playing:
        interact()
    if Input.is_action_just_pressed("journal"):
        open_records()
    if Input.is_action_just_pressed("inventory"):
        open_inventory()
    if current=="REW04" and player.rewind_unlocked:
        if player.position.x>420:
            rewind_switch = true
        if rewind_switch and player.position.x<150 and player.rewind.cooldown>0:
            state.flags.REWIND_TRAINED = true
            commit()
    hud.text = "%s HP%d EE%d/%d HEAT%d Q:%d  %02d:%02d" % [current,player.hp,player.energy,player.capacity,player.heat,player.heal_charges,int(state.day_seconds/60),int(state.day_seconds)%60]
    queue_redraw()

func interact() -> void:
    if collect_nearby_pickup():
        return
    if inspect_nearby_landmark():
        return
    var x: float = player.position.x
    if x<50 or x>560:
        open_routes()
    elif x<150 and ("Rest" in rooms[current].services or current.begins_with("TOW") or current=="REW04"):
        rest()
    elif x>390:
        inspect_record()
    elif x>235 and x<380:
        open_console()
    else:
        hint.text = "Read the landmarks: cyan station, central console, amber record and edge doors each have a purpose."

func connections(id: String) -> Array[Dictionary]:
    var result: Array[Dictionary] = []
    for edge: Dictionary in db.edges:
        if edge.room_a==id or edge.room_b==id:
            result.append({"to":edge.room_b if edge.room_a==id else edge.room_a,"condition":edge.required_flags,"type":edge.type,"side":"right" if edge.room_a==id else "left"})
    return result

func route_is_open(edge: Dictionary) -> bool:
    var condition: String = str(edge.get("required_flags",edge.get("condition","—")))
    if not state.allowed(condition):
        return false
    for actor: CharacterBody2D in actors:
        if is_instance_valid(actor) and actor is Boss:
            return false
    return true

func travel_to(destination: String) -> bool:
    for edge: Dictionary in db.edges:
        var connects: bool = (edge.room_a == current and edge.room_b == destination) or (edge.room_b == current and edge.room_a == destination)
        if not connects:
            continue
        if not route_is_open(edge):
            return false
        # Data edges read from room_a toward room_b. Enter the destination on
        # the opposite side of the doorway Aster just crossed.
        var entry_x: float = 25.0 if edge.room_a == current else 615.0
        load_room(destination, entry_x)
        commit()
        return true
    return false

func try_boundary_transition(side: String) -> bool:
    var candidates: Array[String] = []
    var locked_target: String = ""
    for edge: Dictionary in db.edges:
        var on_side: bool = (side == "left" and edge.room_b == current) or (side == "right" and edge.room_a == current)
        if not on_side:
            continue
        var destination: String = str(edge.room_a if edge.room_b == current else edge.room_b)
        if route_is_open(edge):
            candidates.append(destination)
        elif locked_target.is_empty():
            locked_target = destination
    if candidates.size() == 1:
        return travel_to(candidates[0])
    if candidates.size() > 1:
        hint.text = "Several passages meet here. Press E to choose a route."
    elif not locked_target.is_empty():
        hint.text = "This passage is sealed: %s. Press E to inspect the route conditions." % locked_target
    else:
        hint.text = "The trail ends here. Check the M map for a known route."
    return false
func open_routes() -> void:
    var side: String = "left" if player.position.x<320 else "right"
    panel("Passage to the "+side,"Cross an open doorway to travel. Sealed passages list the system that is missing.")
    var route_count: int = 0
    for edge: Dictionary in connections(current):
        if edge.side != side:
            continue
        route_count += 1
        var unlocked: bool = route_is_open(edge)
        var caption: String = edge.to+" · "+rooms[edge.to].room
        if not unlocked:
            var reason: String = "guardian active" if state.allowed(edge.condition) else str(edge.condition)
            caption += " ["+reason+"]"
        var destination: String = edge.to
        choice(caption,func() -> void: travel_to(destination),not unlocked)
    if route_count == 0:
        var end_label := Label.new()
        end_label.text = "No mapped passage leaves this side of the room."
        modal_box.add_child(end_label)
    choice("Stay here",close_panel)

func open_console() -> void:
    if current=="TOW03":
        if not state.flags.get("BRIEFED",false) and play_story("GUILD_BRIEFING"):
            return
        state.flags.BRIEFED = true
        hint.text = "Garran recommends a team. Aster chooses a known-route survey after Riven's account of the time relic. Visit Bram's yard before departure."
        commit()
        return
    if current=="TOW04":
        if not state.flags.get("TUTORIAL_DONE",false) and play_story("ARTIFICER_TUTORIAL"):
            return
        state.flags.TUTORIAL_DONE = true
        hint.text = "Bram: Fire uses stored Echo Energy and builds heat. Release the trigger to cool. Blade remains available at zero energy."
        commit()
        return
    if current=="GAT02":
        if not state.flags.get("GUARDIAN_DOWN",false):
            hint.text = "The anchor controls are still protected by the Fold Guardian."
            return
        if not state.flags.get("GATE_DIAGNOSED",false) and play_story("BROKEN_GATE"):
            return
        state.flags.GATE_DIAGNOSED = true
        hint.text = "The gate remains fractured. Route reserve power to its separate diagnostic beacon; Rewind cannot repair the passage."
        commit()
        return
    if current=="FIN01":
        panel("Approach stabilizers","Activate all three maintenance stabilizers; the broken transit gate remains isolated.")
        for i in range(3):
            var key: String = "STABILIZER_%d" % i
            choice("Stabilizer %d: %s" % [i+1,"ON" if state.flags.get(key,false) else "OFF"],func() -> void:
                state.flags[key]=true
                open_console())
        choice("Return",close_panel)
        return
    for item: Dictionary in db.puzzles:
        if item.room!=current:
            continue
        if state.flags.get(item.flag,false):
            hint.text = item.result
            return
        active_puzzle = item
        stage = 0
        puzzle_hint_stage = 0
        sequence.clear()
        if item.id=="P09":
            player.energy = maxf(player.energy,25)
            player.rewind.cooldown = 0
            rewind_switch = false
            hint.text = "Rewind trial: start at the left pad; walk to the right switch (x>420), then F back toward the left pad. The switch stays active. E at station resets retry."
            return
        show_puzzle()
        return
    open_inventory()

func show_puzzle() -> void:
    var id: String = active_puzzle.id
    var steps: Array = PUZZLE_STEPS[id]
    var labels: Array = steps[stage*2] if id not in ["P01","P04"] else steps[0]
    panel(id+" · "+rooms[current].room,PUZZLE_PROMPTS.get(id,"Study the mechanism and use its local evidence.")+"\nProgress: %d" % sequence.size())
    for index in range(labels.size()):
        var selected: int = index
        choice(str(labels[index]),func() -> void: puzzle_input(selected))
    choice("Request hint (%d/3)" % mini(puzzle_hint_stage+1,3),advance_puzzle_hint)
    choice("Leave",close_panel)

func puzzle_hint_text(hint_number: int) -> String:
    if hint_number <= 1:
        return str(PUZZLE_OBSERVATIONS.get(active_puzzle.get("id",""),"Look for repeated marks, working signals and environmental evidence nearby."))
    if hint_number == 2:
        return str(active_puzzle.get("goal_clues","Compare the local symbols and signals."))
    return str(active_puzzle.get("solution","No recorded solution is available for this mechanism."))

func advance_puzzle_hint() -> void:
    puzzle_hint_stage = mini(puzzle_hint_stage+1,3)
    panel("Field hint · %d of 3" % puzzle_hint_stage,puzzle_hint_text(puzzle_hint_stage))
    choice("Back to mechanism",show_puzzle)
    if puzzle_hint_stage < 3:
        choice("Next hint",advance_puzzle_hint)
    choice("Leave",close_panel)

func puzzle_input(value: int) -> void:
    var id: String = active_puzzle.id
    var steps: Array = PUZZLE_STEPS[id]
    var expected: int
    var total: int
    if id in ["P01","P04"]:
        expected = steps[1][sequence.size()]
        total = steps[1].size()
    else:
        expected = steps[stage*2+1][0]
        total = steps.size()/2
    if value!=expected:
        stage=0
        sequence.clear()
        panel("Local reset","The last connection conflicts with the diagram. Progress elsewhere is unchanged. Review the clue and retry.")
        choice("Retry",show_puzzle)
        choice("Leave",close_panel)
        return
    sequence.append(value)
    stage += 1
    if sequence.size()<total:
        show_puzzle()
        return
    var prerequisites: String = ""
    if id=="P08":
        prerequisites="SLUICE_OPEN & ARCHIVE_ALIGNED & RESERVOIR_STABLE & KEEPER_DOWN"
    elif id=="P11":
        prerequisites="STABILIZER_0 & STABILIZER_1 & STABILIZER_2"
    elif id=="P12":
        prerequisites="GUARDIAN_DOWN & GATE_DIAGNOSED"
    if not state.allowed(prerequisites):
        panel("Required systems missing",prerequisites)
        choice("Return to the world",close_panel)
        return
    state.flags[active_puzzle.flag] = true
    player.rewind_unlocked = state.flags.get("REWIND_ACQUIRED",false)
    hint.text = active_puzzle.result
    commit()
    close_panel()
    if id=="P08":
        play_story("ECHO_REWIND")

func inspect_record() -> void:
    var story_id: String = ""
    if current=="CAM02":
        story_id = "SURVEY_CAMP"
    elif current=="SUR03" and state.flags.get("ARCHIVE_ALIGNED",false):
        story_id = "SURVEY_VAULT"
    elif current=="VER02":
        story_id = "VERAYAN_RECORD"
    elif current=="SIL02":
        story_id = "SILENT_GALLERY"
    elif current=="RES02" and state.flags.get("RESERVOIR_STABLE",false):
        story_id = "RESERVOIR_RECORD"
    elif current=="FOL03" and state.flags.get("FOLDS_ALIGNED",false):
        story_id = "NALORA_FRAGMENT"
    elif current=="FIN03":
        story_id = "FINAL_WARNING"
    if not story_id.is_empty() and play_story(story_id):
        return
    if current=="SIL02":
        state.flags.MEMORIAL_SEEN = true
    if current=="OUT02":
        var token: String = "WORLD:FIRST_RELEASE"
        if player.collect(token,8):
            state.flags.FIRST_RELEASE = true
    if current=="SLU04":
        state.flags.GARDEN_RESTORED = state.flags.get("SLUICE_OPEN",false)
    if current=="SUR03":
        state.flags.VAULT_MAP = state.flags.get("ARCHIVE_ALIGNED",false)
    if current=="ROT03":
        state.flags.GARDEN_RESTORED = state.flags.get("SLUICE_OPEN",false)
    if current=="REL04":
        state.flags.LOFT_RELAY = true
    if current=="WAR04":
        state.flags.LOOP_MARKED = true
    if current=="FOL02" and state.flags.get("REWIND_TRAINED",false):
        state.flags.REWIND_RETURN_OPEN = true
    var found: Array[String] = []
    for item: Dictionary in db.collectibles:
        if item.room==current and state.collected.has(item.id):
            found.append(item.id+": "+item.description)
    if found.is_empty():
        found.append(rooms[current].gameplay)
    panel("World record · "+current,"\n".join(found))
    choice("Return",close_panel)
    commit()

func open_records() -> void:
    var records: String = "Collected %d / 56 · explored %d / 64\n\nReleased Echo Energy remains yours; the Echoes themselves are freed." % [state.collected.size(),state.visited.size()]
    if not state.collected.is_empty():
        records += "\n\nRecent finds\n" + "\n".join(state.collected.keys()).left(260)
    var evidence: Array[String] = []
    for layout: Dictionary in layout_db.get("rooms",[]):
        for landmark: Dictionary in layout.get("landmarks",[]):
            var flag: String = "LANDMARK_SEEN_"+str(landmark.id).to_upper()
            if state.flags.get(flag,false):
                evidence.append(str(landmark.id).replace("_"," ")+": "+str(landmark.get("story","")))
    if not evidence.is_empty():
        records += "\n\nObserved world clues\n"+"\n".join(evidence).left(540)
    panel("Field journal", "Current objective\n" + current_objective_text() + "\n\n" + records)
    choice("Return",close_panel)

func current_objective_text() -> String:
    if not state.flags.get("INTRO_DONE",false):
        return "Look around the Guild Town and find out what the hunters are preparing for."
    if not state.flags.get("BRIEFED",false):
        return "Visit the Guild Hall at TOW03 and hear the survey team's account."
    if not state.flags.get("TUTORIAL_DONE",false):
        return "Visit Bram's Artificer Yard at TOW04 to review stored Echo Energy and weapon heat."
    if not state.flags.get("WARP",false):
        return "Follow the known hunter route into the dungeon and investigate the strange distortion."
    if not state.flags.get("MAP_ALIGNED",false):
        return "Find the Dawn survey records and align the field map with the three landmarks."
    if not state.flags.get("SLUICE_OPEN",false):
        return "Restore the Echo Sluice flow to reopen a safe route through the roots."
    if not state.flags.get("WORKS_POWER",false):
        return "Trace the old service conduits and route power to the maintenance receiver."
    if not state.flags.get("ARCHIVE_ALIGNED",false):
        return "Use the restored service route to align the Survey Archive."
    if not state.flags.get("VAULT_MAP",false):
        return "Inspect the Survey Vault projection for the route beyond the sanctuary."
    if not state.flags.get("TOPOLOGY_ALIGNED",false):
        return "Read the stable anchor marks and find the route across the Warped Verge."
    if not state.flags.get("RESERVOIR_STABLE",false):
        return "Stabilize the Reservoir while keeping the Echo release path safe."
    if not state.flags.get("KEEPER_DOWN",false):
        return "Reach the reliquary, isolate its paired conductors, and defeat the Keeper."
    if not state.flags.get("REWIND_ACQUIRED",false):
        return "Follow the verified sanctuary route to the Personal Continuity Device."
    if not state.flags.get("REWIND_TRAINED",false):
        return "Practice Echo Rewind at the safe shutter trial, then return to its starting pad."
    if not state.flags.get("FOLDS_ALIGNED",false):
        return "Read the paired anchor symbols and align the changing connections through the Fold."
    if not state.flags.get("ANCHORS_STABLE",false):
        return "Activate the three approach stabilizers without reconnecting the broken transit gate."
    if not state.flags.get("GUARDIAN_DOWN",false):
        return "Defeat the Fold Guardian and inspect the passage controls."
    if not state.flags.get("GATE_DIAGNOSED",false):
        return "Inspect the fractured gate. Rewind cannot repair its damaged anchor."
    if not state.flags.get("SIGNAL_SENT",false):
        return "Keep the release line open and route reserve power to the diagnostic beacon."
    if not state.flags.get("END_COMPLETE",false):
        return "Wait for the low-power distress packet to finish transmitting."
    return "Aster is sheltered, but the gate remains broken. Orion's story begins with the rescue."

func open_inventory() -> void:
    var safe_station: bool = player.position.x<150 and ("Rest" in rooms[current].services or "Workbench" in rooms[current].services or current.begins_with("TOW"))
    panel("Equipment and upgrades","Primary: %s · blade always available\nAlloy %d / biological %d / relic %d\nSwap/craft at a station. Heat persists on weapon swap." % [player.weapon_id,state.materials.get("alloy",0),state.materials.get("biological",0),state.materials.get("relic",0)])
    for id: String in state.owned:
        var selected: String = id
        choice("Equip "+id,func() -> void:
            player.equip(selected)
            apply_upgrades(false)
            open_inventory(),not safe_station)
    var recipes: Dictionary = {"BP01":[4,0,0],"BP02":[3,3,0],"BP03":[5,0,1],"BP04":[4,0,1],"BP05":[3,0,2],"BP06":[2,0,3]}
    for id: String in recipes:
        if not state.collected.has(id) or state.upgrades.has(id):
            continue
        var blueprint: String = id
        var cost: Array = recipes[id]
        choice("Craft %s (%d alloy / %d biological / %d relic)" % [id,cost[0],cost[1],cost[2]],func() -> void:
            if int(state.materials.get("alloy",0))>=cost[0] and int(state.materials.get("biological",0))>=cost[1] and int(state.materials.get("relic",0))>=cost[2]:
                state.materials.alloy -= cost[0]
                state.materials.biological -= cost[1]
                state.materials.relic -= cost[2]
                state.upgrades[blueprint] = true
                apply_upgrades()
                commit()
            open_inventory(),not safe_station)
    choice("Return",close_panel)
func apply_upgrades(reset_weapon: bool = true) -> void:
    if reset_weapon:
        player.equip(player.weapon_id)
    player.capacity = 120 if state.upgrades.has("BP05") else 100
    player.damage_multiplier = 0.9 if state.upgrades.has("BP02") else 1.0
    player.rewind_cost = 22 if state.upgrades.has("BP06") else 25
    player.rewind_delay = 12 if state.upgrades.has("BP06") else 14
    if state.upgrades.has("BP01"):
        player.weapon_cooling *= 1.15
    if state.upgrades.has("BP03"):
        player.weapon_damage = roundf(player.weapon_damage*1.15)
    if state.upgrades.has("BP04"):
        player.weapon_heat = roundf(player.weapon_heat*0.9)

func rest() -> void:
    checkpoint=current
    state.checkpoint=current
    player.hp=player.max_hp
    player.heal_charges=3
    player.energy=maxf(50,player.energy)
    player.heat=0
    player.overheated=false
    player.rewind.clear_history()
    player.rewind.cooldown=0
    player.weapon_states.clear()
    generation += 1
    state.generation=generation
    load_room(current)
    commit()
    hint.text="Rested and checkpoint saved. Health, charges and minimum EE restored; ordinary encounters reset."

func add_mark(at: Vector2, kind: String, delay: float, damage: float) -> void:
    hazards.append({"at":at,"kind":kind,"delay":delay,"life":0.3,"damage":damage,"dir":-1.0})
func update_hazards(dt: float) -> void:
    for hazard: Dictionary in hazards:
        if hazard.delay>0:
            hazard.delay -= dt
            continue
        hazard.life -= dt
        if hazard.kind=="wave":
            hazard.at.x += hazard.dir*180*dt
        var hit: bool = false
        if hazard.kind in ["ceiling","pool"]:
            hit = absf(player.position.x-hazard.at.x)<24
        elif hazard.kind=="beam":
            hit = absf(player.position.y-hazard.at.y)<15
        else:
            hit = player.position.distance_to(hazard.at)<25
        if hit and not player.rewind.playing:
            player.damage(hazard.damage)
    hazards = hazards.filter(func(item: Dictionary) -> bool: return item.life>0)

func fire(origin: Vector2, direction: Vector2) -> void:
    beam_start=origin
    beam_end=origin+direction*450
    var hit: Dictionary = get_world_2d().direct_space_state.intersect_ray(PhysicsRayQueryParameters2D.create(origin,beam_end,5))
    if not hit.is_empty():
        beam_end=hit.position
        if hit.collider.has_method("hit"):
            hit.collider.hit(player.weapon_damage)
    beam_time=0.06
func melee(origin: Vector2, facing: float) -> void:
    for actor: CharacterBody2D in actors.duplicate():
        if is_instance_valid(actor) and origin.distance_to(actor.position)<85 and (actor.position.x-origin.x)*facing>=0:
            actor.hit(18)
func enemy_defeated(token: String, _at: Vector2) -> void:
    var entry: Dictionary = encounters.get(token,{"energy":8,"material":"alloy"})
    defeated_local[token]=true
    var reward_token: String = str(entry.get("reward_token",token))
    var already_claimed: bool = player.released.has(reward_token)
    if entry.has("boss"):
        state.flags[entry.boss.flag]=true
        if not already_claimed:
            state.materials[entry.material]=int(state.materials.get(entry.material,0))+4
    elif not already_claimed:
        state.materials[entry.material]=int(state.materials.get(entry.material,0))+1
    player.collect(reward_token,float(entry.energy))
    state.flags.FIRST_RELEASE=true
    actors = actors.filter(func(actor: CharacterBody2D) -> bool: return is_instance_valid(actor) and actor.token!=token)
    commit()
    if token=="B06":
        play_story("FOLD_GUARDIAN")

func on_death() -> void:
    if retrying:
        return
    retrying=true
    call_deferred("reset_attempt")
func reset_attempt() -> void:
    player.hp=player.max_hp
    player.heal_charges=3
    player.rewind.clear_history()
    player.energy=maxf(50,player.energy)
    generation += 1
    state.generation=generation
    load_room(state.checkpoint)
    retrying=false
func commit() -> void:
    state.generation=generation
    state.equipped=player.weapon_id
    player.weapon_states[player.weapon_id]={"heat":player.heat,"locked":player.overheated,"since":player.since_shot,"cooling":player.weapon_cooling}
    state.thermal=player.weapon_states
    state.defeated=defeated_local
    state.released=player.released
    state.energy=player.energy
    state.max_hp=player.max_hp
    state.capacity=player.capacity
    if persistence_enabled:
        var error: Error = state.save()
        if error!=OK:
            hint.text="Save unavailable. Current session progress is retained in memory."

func _draw() -> void:
    if not is_instance_valid(player):
        return
    draw_rect(Rect2(290,265,30,35),Color("91704f"))
    draw_line(Vector2(293,270),Vector2(317,270),Color("56cdc4"),3)
    draw_circle(Vector2(440,280),8,Color("c5a572"))
    if rooms.has(current) and ("Rest" in rooms[current].services or current.begins_with("TOW")):
        draw_circle(Vector2(90,275),8,Color("56cdc4"))
    for side: String in ["left","right"]:
        var exists: bool = false
        var unlocked: bool = false
        for edge: Dictionary in connections(current):
            if edge.side == side:
                exists = true
                unlocked = unlocked or route_is_open(edge)
        var doorway_color := Color("56cdc4") if unlocked else (Color("c5a572") if exists else Color("40505b"))
        var x: float = 25.0 if side == "left" else 600.0
        draw_rect(Rect2(x-8,263,16,37),doorway_color,false,2)
        if exists:
            var direction: float = -1.0 if side == "left" else 1.0
            draw_line(Vector2(x+direction*4,277),Vector2(x-direction*3,277),doorway_color,2)
            draw_line(Vector2(x-direction*3,277),Vector2(x-direction,274),doorway_color,2)
            draw_line(Vector2(x-direction*3,277),Vector2(x-direction,280),doorway_color,2)
    if beam_time>0:
        draw_line(beam_start,beam_end,Color("aff5dc"),2)
    for item: Dictionary in hazards:
        var color := Color("c5a572") if item.delay>0 else Color("d56c6c")
        if item.kind in ["ceiling","pool"]:
            draw_line(Vector2(item.at.x,130),Vector2(item.at.x,300),color,3)
        else:
            draw_line(Vector2(20,item.at.y),Vector2(620,item.at.y),color,2)
    if player.rewind.playing:
        for sample: Dictionary in player.rewind.playback:
            draw_circle(sample.at,1,Color("56cdc4"))
