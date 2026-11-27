extends Control

signal room_selected(id: String)

## The world map exposes only rooms Aster has visited.  Its sixteen regions are
## grouped into a stable 4x4 atlas; each region's four rooms use a 2x2 layout.
## This keeps the map legible in the small pixel-art viewport while preserving
## the campaign graph's real connections.
const REGION_COLUMNS := 4
const ROOM_SIZE := Vector2(39.0, 20.0)
const ROOM_GAP := Vector2(7.0, 5.0)
const GROUP_GAP := Vector2(13.0, 12.0)
const MAP_TOP := 43.0
const FOOTER_HEIGHT := 47.0

var rooms: Array = []
var edges: Array = []
var visited: Dictionary = {}
var current: String = ""
var selected: String = ""
var flags: Dictionary = {}
var positions: Dictionary = {}
var room_data: Dictionary = {}
var region_data: Array[String] = []
var zoom: float = 1.0
var pan := Vector2.ZERO
var dragging := false
var drag_origin := Vector2.ZERO
var pan_origin := Vector2.ZERO
var touch_origins: Dictionary = {}
var world_bounds := Rect2()

func configure(room_data_in: Array, connections: Array, explored: Dictionary, at: String, progress: Dictionary) -> void:
	rooms = room_data_in
	edges = connections
	visited = explored
	current = at
	flags = progress
	selected = current
	positions.clear()
	room_data.clear()
	region_data.clear()
	for item: Dictionary in rooms:
		room_data[item.id] = item
		if not region_data.has(str(item.region)):
			region_data.append(str(item.region))
	_build_positions()
	zoom = 1.0
	pan = Vector2.ZERO
	queue_redraw()

func _build_positions() -> void:
	var group_size := Vector2(ROOM_SIZE.x * 2.0 + ROOM_GAP.x, ROOM_SIZE.y * 2.0 + ROOM_GAP.y)
	var cell_size := group_size + GROUP_GAP
	for item: Dictionary in rooms:
		var region_index: int = region_data.find(str(item.region))
		var local_index: int = int(str(item.id).right(2)) - 1
		var region_origin := Vector2((region_index % REGION_COLUMNS) * cell_size.x, floori(float(region_index) / REGION_COLUMNS) * cell_size.y)
		var local := Vector2((local_index % 2) * (ROOM_SIZE.x + ROOM_GAP.x), floori(float(local_index) / 2) * (ROOM_SIZE.y + ROOM_GAP.y))
		positions[item.id] = region_origin + local
	world_bounds = Rect2(Vector2.ZERO, Vector2(REGION_COLUMNS * cell_size.x - GROUP_GAP.x, ceilf(float(region_data.size()) / REGION_COLUMNS) * cell_size.y - GROUP_GAP.y))

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_set_zoom(zoom * 1.15, event.position)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_set_zoom(zoom / 1.15, event.position)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
			drag_origin = event.position
			pan_origin = pan
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if dragging and event.position.distance_to(drag_origin) < 7.0:
				_select_room_at(event.position)
			dragging = false
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			_set_zoom(1.0, event.position, true)
			accept_event()
	elif event is InputEventMouseMotion and dragging:
		pan = pan_origin + event.position - drag_origin
		_clamp_pan()
		queue_redraw()
	elif event is InputEventScreenTouch:
		if event.pressed:
			touch_origins[event.index] = event.position
			if touch_origins.size() == 1:
				dragging = true
				drag_origin = event.position
				pan_origin = pan
		else:
			var origin: Vector2 = touch_origins.get(event.index, event.position)
			if touch_origins.size() == 1 and event.position.distance_to(origin) < 10.0:
				_select_room_at(event.position)
			touch_origins.erase(event.index)
			if touch_origins.is_empty():
				dragging = false
	elif event is InputEventScreenDrag and dragging and touch_origins.size() == 1:
		pan = pan_origin + event.position - drag_origin
		_clamp_pan()
		queue_redraw()

func _select_room_at(screen_point: Vector2) -> void:
	var p := _to_map(screen_point)
	for id: String in positions:
		if not visited.has(id):
			continue
		if Rect2(positions[id], ROOM_SIZE).has_point(p):
			selected = id
			room_selected.emit(id)
			queue_redraw()
			return

func _set_zoom(value: float, focus: Vector2, reset_pan: bool = false) -> void:
	var old_zoom := zoom
	zoom = clampf(value, 0.7, 2.5)
	if reset_pan:
		pan = Vector2.ZERO
	else:
		var content_focus := _to_map(focus)
		pan = focus - content_focus * zoom
	_clamp_pan()
	queue_redraw()

func _to_map(screen_point: Vector2) -> Vector2:
	var origin := Vector2(12.0, MAP_TOP) + pan
	return (screen_point - origin) / zoom + Vector2.ZERO

func _clamp_pan() -> void:
	var content_size := world_bounds.size * zoom
	var viewport := Rect2(Vector2(8.0, MAP_TOP), Vector2(maxf(1.0, size.x - 16.0), maxf(1.0, size.y - MAP_TOP - FOOTER_HEIGHT)))
	if content_size.x <= viewport.size.x:
		pan.x = (viewport.size.x - content_size.x) * 0.5
	else:
		pan.x = clampf(pan.x, viewport.position.x + viewport.size.x - content_size.x - 12.0, 0.0)
	if content_size.y <= viewport.size.y:
		pan.y = (viewport.size.y - content_size.y) * 0.5
	else:
		pan.y = clampf(pan.y, viewport.position.y + viewport.size.y - content_size.y - 42.0, 0.0)

func _flag_condition_met(raw: String) -> bool:
	var condition := raw.strip_edges()
	if condition == "" or condition == "—" or condition == "-":
		return true
	for term_raw: String in condition.split("&", false):
		var term := term_raw.strip_edges()
		var wanted := true
		if term.begins_with("!"):
			wanted = false
			term = term.substr(1).strip_edges()
		if bool(flags.get(term, false)) != wanted:
			return false
	return true

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color("101824"))
	draw_rect(Rect2(Vector2(0, 0), Vector2(size.x, 34)), Color("172536"))
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(12, 22), "ELDARA · FIELD ATLAS", HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("e3cf9c"))
	draw_string(font, Vector2(size.x - 12, 22), "M close · wheel zoom · drag pan · right-click reset", HORIZONTAL_ALIGNMENT_RIGHT, -1, 9, Color("a8b7c2"))
	draw_rect(Rect2(Vector2(7, MAP_TOP - 3), Vector2(size.x - 14, size.y - MAP_TOP - FOOTER_HEIGHT + 6)), Color("0c131d"), false, 1.0)
	draw_set_transform(Vector2(12.0, MAP_TOP) + pan, 0.0, Vector2(zoom, zoom))
	_draw_connections(font)
	_draw_regions(font)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	_draw_footer(font)

func _draw_regions(font: Font) -> void:
	var group_size := Vector2(ROOM_SIZE.x * 2.0 + ROOM_GAP.x, ROOM_SIZE.y * 2.0 + ROOM_GAP.y)
	var cell_size := group_size + GROUP_GAP
	for region_index: int in range(region_data.size()):
		var region_known := false
		for item: Dictionary in rooms:
			if str(item.region) == region_data[region_index] and visited.has(str(item.id)):
				region_known = true
				break
		if not region_known:
			continue
		var origin := Vector2((region_index % REGION_COLUMNS) * cell_size.x, floori(float(region_index) / REGION_COLUMNS) * cell_size.y)
		var region_name := region_data[region_index]
		draw_string(font, origin + Vector2(0, -5), _short_region(region_name), HORIZONTAL_ALIGNMENT_LEFT, group_size.x, 8, Color("9cb0bf"))
		draw_rect(Rect2(origin - Vector2(3, 1), group_size + Vector2(6, 3)), Color("324354"), false, 0.8)
	for item: Dictionary in rooms:
		var id := str(item.id)
		if not visited.has(id):
			continue
		var at: Vector2 = positions[id]
		var bounds := Rect2(at, ROOM_SIZE)
		var fill := Color("b98f53") if id == current else Color("426970")
		if id == selected and id != current:
			fill = Color("5f8990")
		draw_rect(bounds, fill)
		draw_rect(bounds, Color("e8d7ad") if id == current else Color("78949b"), false, 1.0)
		var room_label := id
		if id == current:
			room_label = "▶" + id.right(5)
		var fg := Color("fff1c9") if id == current else Color("e4eef0")
		draw_string(font, at + Vector2(2, 14), room_label, HORIZONTAL_ALIGNMENT_LEFT, ROOM_SIZE.x - 4, 8, fg)
		if "Rest" in str(item.services):
			draw_circle(at + Vector2(ROOM_SIZE.x - 4, 4), 2.1, Color("aff5dc"))
		elif "Workbench" in str(item.services):
			draw_circle(at + Vector2(ROOM_SIZE.x - 4, 4), 2.1, Color("e6c977"))
		if id == selected:
			draw_rect(bounds.grow(2.0), Color("f3e8c2"), false, 1.0)

func _draw_connections(font: Font) -> void:
	for edge: Dictionary in edges:
		var a := str(edge.room_a)
		var b := str(edge.room_b)
		if not visited.has(a) or not visited.has(b):
			continue
		var pa: Vector2 = positions[a] + ROOM_SIZE * 0.5
		var pb: Vector2 = positions[b] + ROOM_SIZE * 0.5
		var required := str(edge.required_flags)
		var unlocked := _flag_condition_met(required)
		var col := Color("62a89c") if unlocked else Color("d47869")
		if str(edge.type) == "shortcut":
			_draw_dashed_line(pa, pb, col, 1.15)
		else:
			draw_line(pa, pb, col, 1.15, true)
		if not unlocked:
			var midpoint := (pa + pb) * 0.5
			draw_rect(Rect2(midpoint - Vector2(2.0, 2.0), Vector2(4.0, 4.0)), Color("f1b2a0"))

func _draw_dashed_line(a: Vector2, b: Vector2, color: Color, width: float) -> void:
	var distance := a.distance_to(b)
	if distance <= 0.0:
		return
	var direction := (b - a) / distance
	var step := 7.0
	var cursor := 0.0
	while cursor < distance:
		var finish := minf(cursor + 3.5, distance)
		draw_line(a + direction * cursor, a + direction * finish, color, width, true)
		cursor += step

func _draw_footer(font: Font) -> void:
	var top := size.y - FOOTER_HEIGHT
	draw_rect(Rect2(Vector2(0, top), Vector2(size.x, FOOTER_HEIGHT)), Color("172536"))
	draw_line(Vector2(0, top), Vector2(size.x, top), Color("405365"), 1.0)
	var details := "Select a visited room to inspect its field notes."
	if room_data.has(selected) and visited.has(selected):
		var data: Dictionary = room_data[selected]
		details = "%s  ·  %s  ·  Chapter %s" % [data.region, data.room, data.chapter]
		if "Rest" in str(data.services):
			details += "  ·  Rest station"
		elif "Workbench" in str(data.services):
			details += "  ·  Workbench"
	var pct := int(roundf(100.0 * float(visited.size()) / maxf(1.0, float(rooms.size()))))
	draw_string(font, Vector2(12, top + 17), details, HORIZONTAL_ALIGNMENT_LEFT, size.x - 24, 10, Color("e6edf0"))
	draw_string(font, Vector2(12, top + 34), "Mapped rooms: %d / %d (%d%%)     Green path: open · red mark: sealed · dashed: shortcut" % [visited.size(), rooms.size(), pct], HORIZONTAL_ALIGNMENT_LEFT, size.x - 24, 9, Color("a8b7c2"))

func _short_region(region: String) -> String:
	var replacements := {
		"Guild Town": "GUILD TOWN", "Outer Wilds": "OUTER WILDS", "Hunter’s Reach": "HUNTER'S REACH",
		"Old Survey Camp": "SURVEY CAMP", "Echo Sluice": "ECHO SLUICE", "Rootspan": "ROOTSPAN",
		"Survey Vault": "SURVEY VAULT", "Warped Verge": "WARPED VERGE", "Veraya Fold": "VERAYA FOLD",
		"Echo Reservoir": "ECHO RESERVOIR", "Rewind Sanctuary": "REWIND SANCTUARY", "Silent Gallery": "SILENT GALLERY",
		"Reliquary Works": "RELIQUARY WORKS", "Folded Depths": "FOLDED DEPTHS", "Final Approach": "FINAL APPROACH",
		"Warp-Broken Gate": "WARP-BROKEN GATE"
	}
	return str(replacements.get(region, region.to_upper()))
