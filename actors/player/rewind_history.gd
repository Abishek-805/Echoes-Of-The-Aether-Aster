extends RefCounted
var history: Array[Dictionary] = []
var damage_log: Array[Dictionary] = []
var cooldown: float = 0
var elapsed: float = 0
var playback: Array[Dictionary] = []
var playing: bool = false
var cursor: float = 0
var origin := Vector2.ZERO
var recovered: bool = false
var saved_shutter_collision: bool = false
func clear_history(body: CharacterBody2D = null) -> void:
    if body != null:
        body.set_collision_mask_value(5,saved_shutter_collision)
    saved_shutter_collision = false
    history.clear()
    damage_log.clear()
    playback.clear()
    playing = false
func record(body: CharacterBody2D, dt: float) -> void:
    elapsed += dt
    damage_log = damage_log.filter(func(event: Dictionary) -> bool: return elapsed-float(event.time)<6.0)
    if playing:
        return
    history.append({"at":body.position,"velocity":body.velocity,"hp":body.hp,"time":elapsed})
    while history.size()>360 or (not history.is_empty() and elapsed-float(history[0].time)>6.0):
        history.pop_front()
func damage(amount: float) -> void:
    damage_log.append({"time":elapsed,"amount":amount,"used":false})
func safe(body: CharacterBody2D, at: Vector2) -> bool:
    if at.y>330 or at.x<12 or at.x>628:
        return false
    var query := PhysicsShapeQueryParameters2D.new()
    var shape := RectangleShape2D.new()
    shape.size = Vector2(17,35)
    query.shape = shape
    query.transform = Transform2D(0,at)
    query.collision_mask = 1
    query.exclude = [body.get_rid()]
    return body.get_world_2d().direct_space_state.intersect_shape(query).is_empty()
func begin(body: CharacterBody2D) -> bool:
    if playing or cooldown>0 or body.energy<body.rewind_cost or history.size()<15 or not body.rewind_unlocked:
        return false
    var valid: int = -1
    for i in range(history.size()):
        if safe(body,history[i].at):
            valid = i
            break
    if valid<0:
        return false
    origin = body.position
    playback = history.slice(valid)
    cursor = float(playback.size()-1)
    body.energy -= body.rewind_cost
    saved_shutter_collision = body.get_collision_mask_value(5)
    body.set_collision_mask_value(5,false)
    playing = true
    recovered = false
    return true
func tick(body: CharacterBody2D, dt: float) -> bool:
    cooldown = maxf(0,cooldown-dt)
    if not playing:
        return false
    var next: float = maxf(0,cursor-dt*float(playback.size())/0.75)
    var index: int = int(cursor)
    var blocked: bool = false
    var moved: bool = false
    while index>=int(next):
        var at: Vector2 = playback[index].at
        # Move physically along the recorded path; never teleport through an ordinary wall.
        if not safe(body,at) or body.test_move(body.transform, at-body.position):
            blocked = true
            break
        moved = moved or body.position.distance_squared_to(at)>0.01
        body.position = at
        index -= 1
    cursor = next
    if cursor<=0 or blocked:
        if blocked and not moved:
            # A newly closed route can invalidate the path before playback moves.
            # Keep Aster where he is and refund the activation cost exactly once.
            body.energy = minf(body.capacity,body.energy+body.rewind_cost)
            body.velocity = Vector2.ZERO
            playing = false
            cooldown = 0.0
            body.set_collision_mask_value(5,saved_shutter_collision)
            saved_shutter_collision = false
            history.clear()
            playback.clear()
            return true
        var destination: Dictionary = playback[maxi(0,index+1)] if blocked else playback[0]
        var eligible: float = 0
        for event: Dictionary in damage_log:
            if not event.used and event.time>=destination.time:
                eligible += event.amount
                event.used = true
        body.hp = minf(body.max_hp,body.hp+minf(floorf(eligible*0.5),maxf(0,float(destination.hp)-body.hp)))
        body.velocity = Vector2.ZERO
        playing = false
        cooldown = body.rewind_delay
        body.set_collision_mask_value(5,saved_shutter_collision)
        saved_shutter_collision = false
        history.clear()
        playback.clear()
    return true
