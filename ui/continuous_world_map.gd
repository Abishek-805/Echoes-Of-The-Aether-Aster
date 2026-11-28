extends Control
## Explored-only V4 geography atlas. V4 is a navigation blueprint, not collision geometry.

signal landmark_selected(id: String)

const MAP_TOP := 34.0
const FOOTER_HEIGHT := 43.0
const INSET := Vector2(12.0, 8.0)
const BASE_ZOOM := 1.0

var world: Dictionary = {}
var visited_rooms: Dictionary = {}
var flags: Dictionary = {}
var current_room := ""
var current_region := ""
var zoom := BASE_ZOOM
var pan := Vector2.ZERO
var dragging := false
var drag_origin := Vector2.ZERO
var pan_origin := Vector2.ZERO
var touch_positions: Dictionary = {}
var pinch_distance := 0.0
var point_by_id: Dictionary = {}
var point_by_legacy: Dictionary = {}
var region_by_id: Dictionary = {}
var known_points: Dictionary = {}
var bounds := Rect2(0, 0, 126, 149)

func configure(world_data: Dictionary, explored: Dictionary, at: String, progress: Dictionary) -> void:
	world = world_data
	visited_rooms = explored
	flags = progress
	current_room = at
	point_by_id.clear()
	point_by_legacy.clear()
	region_by_id.clear()
	known_points.clear()
	var min_x := INF
	var min_y := INF
	var max_x := -INF
	var max_y := -INF
	for region: Dictionary in world.get("regions", []):
		var region_id := str(region.get("id", ""))
		region_by_id[region_id] = region
		for point: Dictionary in region.get("points", []):
			var point_id := str(point.get("id", ""))
			point_by_id[point_id] = point
			var legacy := str(point.get("legacy", ""))
			if not legacy.is_empty():
				point_by_legacy[legacy] = point_id
				if explored.has(legacy):
					known_points[point_id] = true
					if legacy == at:
						current_region = region_id
			var point_x := float(point.get("x", 0))
			var point_y := float(point.get("y", 0))
			min_x = minf(min_x, point_x)
			min_y = minf(min_y, point_y)
			max_x = maxf(max_x, point_x)
			max_y = maxf(max_y, point_y)
		var region_bounds: Array = region.get("bounds", [])
		if region_bounds.size() >= 4:
			min_x = minf(min_x, float(region_bounds[0]))
			min_y = minf(min_y, float(region_bounds[1]))
			max_x = maxf(max_x, float(region_bounds[2]))
			max_y = maxf(max_y, float(region_bounds[3]))
	if is_finite(min_x) and is_finite(max_x):
		bounds = Rect2(min_x, min_y, max_x - min_x, max_y - min_y)
	zoom = BASE_ZOOM
	pan = Vector2.ZERO
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color("101824"))
	draw_rect(Rect2(Vector2(0, 0), Vector2(size.x, 29)), Color("172536"))
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(12, 20), "FRACTURED SANCTUARY · FIELD ATLAS", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("e3cf9c"))
	draw_string(font, Vector2(size.x - 12, 20), "M close · wheel/pinch zoom · drag pan", HORIZONTAL_ALIGNMENT_RIGHT, -1, 9, Color("a8b7c2"))
	draw_rect(Rect2(Vector2(7, MAP_TOP - 2), Vector2(size.x - 14, size.y - MAP_TOP - FOOTER_HEIGHT + 4)), Color("0c131d"), true)
	var map_rect := Rect2(Vector2(INSET.x, MAP_TOP + INSET.y), Vector2(size.x - INSET.x * 2, size.y - MAP_TOP - FOOTER_HEIGHT - INSET.y * 2))
	var scale := minf(map_rect.size.x / bounds.size.x, map_rect.size.y / bounds.size.y) * zoom
	var origin := map_rect.position + (map_rect.size - bounds.size * scale) * 0.5 + pan
	draw_set_transform(origin - bounds.position * scale, 0.0, Vector2(scale, scale))
	_draw_region_hints()
	_draw_edges()
	_draw_points()
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	_draw_footer(font)

func _draw_region_hints() -> void:
	for region: Dictionary in world.get("regions", []):
		var region_id := str(region.get("id", ""))
		if not _region_known(region_id):
			continue
		var raw: Array = region.get("bounds", [])
		if raw.size() < 4:
			continue
		var rect := Rect2(float(raw[0]), float(raw[1]), float(raw[2]) - float(raw[0]), float(raw[3]) - float(raw[1]))
		var tint := Color(str(region.get("color", "#c29b6c")))
		draw_rect(rect, Color(tint.r, tint.g, tint.b, 0.10), true)
		draw_rect(rect, Color(tint.r, tint.g, tint.b, 0.35), false, 0.35)
		draw_string(ThemeDB.fallback_font, rect.position + Vector2(1.2, 2.3), str(region.get("name", region_id)).to_upper(), HORIZONTAL_ALIGNMENT_LEFT, rect.size.x - 2.0, 1.6, Color(tint.r, tint.g, tint.b, 0.85))

func _draw_edges() -> void:
	for edge: Dictionary in world.get("edges", []):
		var from_id := str(edge.get("a", ""))
		var to_id := str(edge.get("b", ""))
		if not known_points.has(from_id) or not known_points.has(to_id):
			continue
		var a: Vector2 = _point_position(point_by_id[from_id])
		var b: Vector2 = _point_position(point_by_id[to_id])
		var open := _requirements_met(edge)
		var color := Color("61c4a1") if open else Color("dc876f")
		if str(edge.get("kind", "")) == "shortcut":
			_draw_dashes(a, b, color)
		else:
			draw_line(a, b, color, 0.42, true)

func _draw_dashes(a: Vector2, b: Vector2, color: Color) -> void:
	var length := a.distance_to(b)
	if length <= 0.0:
		return
	var direction := (b - a) / length
	var offset := 0.0
	while offset < length:
		draw_line(a + direction * offset, a + direction * minf(offset + 1.2, length), color, 0.45, true)
		offset += 2.1

func _draw_points() -> void:
	for point_id: Variant in known_points:
		var point: Dictionary = point_by_id[point_id]
		var at := _point_position(point)
		var is_current := str(point.get("legacy", "")) == current_room
		var color := Color("f2d28e") if is_current else Color("9fd6c5")
		draw_circle(at, 1.05 if is_current else 0.72, color)
		if is_current:
			draw_arc(at, 1.8, 0, TAU, 16, Color("fff0bd"), 0.38, true)

func _point_position(point: Dictionary) -> Vector2:
	return Vector2(float(point.get("x", 0)), float(point.get("y", 0)))

func _region_known(region_id: String) -> bool:
	for point_id: Variant in known_points:
		if str(point_by_id[point_id].get("region", "")) == region_id:
			return true
	return false

func _requirements_met(edge: Dictionary) -> bool:
	for flag: Variant in edge.get("requires", []):
		if not bool(flags.get(str(flag), false)):
			return false
	for flag: Variant in edge.get("blocked", []):
		if bool(flags.get(str(flag), false)):
			return false
	return true

func _draw_footer(font: Font) -> void:
	var top := size.y - FOOTER_HEIGHT
	draw_rect(Rect2(Vector2(0, top), Vector2(size.x, FOOTER_HEIGHT)), Color("172536"))
	draw_line(Vector2(0, top), Vector2(size.x, top), Color("405365"), 1.0)
	var region_name := str(region_by_id.get(current_region, {}).get("name", "Unknown region"))
	draw_string(font, Vector2(12, top + 16), "Current landmark: %s" % _current_landmark_name(), HORIZONTAL_ALIGNMENT_LEFT, size.x - 24, 10, Color("e6edf0"))
	draw_string(font, Vector2(12, top + 32), "%s · %d landmarks discovered · unlabeled paths remain unexplored" % [region_name, known_points.size()], HORIZONTAL_ALIGNMENT_LEFT, size.x - 24, 9, Color("a8b7c2"))

func _current_landmark_name() -> String:
	if point_by_legacy.has(current_room):
		return str(point_by_id[point_by_legacy[current_room]].get("name", current_room))
	return current_room

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom = clampf(zoom * 1.2, 0.8, 4.0)
			queue_redraw()
			accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom = clampf(zoom / 1.2, 0.8, 4.0)
			queue_redraw()
			accept_event()
		elif event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			drag_origin = event.position
			pan_origin = pan
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			zoom = BASE_ZOOM
			pan = Vector2.ZERO
			queue_redraw()
			accept_event()
	elif event is InputEventMouseMotion and dragging:
		pan = pan_origin + event.position - drag_origin
		queue_redraw()
	elif event is InputEventScreenTouch:
		if event.pressed:
			touch_positions[event.index] = event.position
			if touch_positions.size() == 2:
				var touches: Array = touch_positions.values()
				pinch_distance = (touches[0] as Vector2).distance_to(touches[1] as Vector2)
				dragging = false
			elif touch_positions.size() == 1:
				dragging = true
				drag_origin = event.position
				pan_origin = pan
		else:
			touch_positions.erase(event.index)
			pinch_distance = 0.0
			dragging = touch_positions.size() == 1
			if dragging:
				var remaining: Vector2 = touch_positions.values()[0]
				drag_origin = remaining
				pan_origin = pan
	elif event is InputEventScreenDrag and touch_positions.has(event.index):
		touch_positions[event.index] = event.position
		if touch_positions.size() >= 2:
			var touches: Array = touch_positions.values()
			var distance := (touches[0] as Vector2).distance_to(touches[1] as Vector2)
			if pinch_distance > 1.0:
				zoom = clampf(zoom * distance / pinch_distance, 0.8, 4.0)
			pinch_distance = distance
			queue_redraw()
		elif dragging:
			pan = pan_origin + event.position - drag_origin
			queue_redraw()

