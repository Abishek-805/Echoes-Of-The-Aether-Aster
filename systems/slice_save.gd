extends RefCounted
const PATH := "user://aster_slice_v1.json"
static func write_state(data: Dictionary, path: String = PATH) -> Error:
    var file := FileAccess.open(path + ".tmp", FileAccess.WRITE)
    if file == null:
        return FileAccess.get_open_error()
    file.store_string(JSON.stringify({"version": 1, "state": data}))
    file.flush()
    file.close()
    if FileAccess.file_exists(path):
        var backup_error: Error = DirAccess.copy_absolute(path, path + ".backup")
        if backup_error != OK:
            return backup_error
    return DirAccess.rename_absolute(path + ".tmp", path)
static func read_state(path: String = PATH) -> Dictionary:
    var candidates: Array[Dictionary] = read_candidates(path)
    return candidates[0] if not candidates.is_empty() else {}

static func read_candidates(path: String = PATH) -> Array[Dictionary]:
    var states: Array[Dictionary] = []
    for candidate: String in [path, path + ".backup"]:
        if not FileAccess.file_exists(candidate):
            continue
        var parser := JSON.new()
        if parser.parse(FileAccess.get_file_as_string(candidate)) != OK:
            continue
        var data: Variant = parser.data
        if data is Dictionary and data.get("version") == 1 and data.get("state") is Dictionary:
            states.append(data.state)
    return states
