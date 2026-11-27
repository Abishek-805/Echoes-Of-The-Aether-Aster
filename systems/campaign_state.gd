extends RefCounted
const PATH := "user://aster_campaign_v1.json"
const Store = preload("res://systems/slice_save.gd")
var generation: int = 0
var equipped: String = "RIF01"
var thermal: Dictionary = {}
var defeated: Dictionary = {}
var flags: Dictionary = {}
var visited: Dictionary = {}
var collected: Dictionary = {}
var released: Dictionary = {}
var pending: Dictionary = {}
var checkpoint: String = "TOW01"
var day_seconds: float = 360.0
var owned: Array = ["RIF01"]
var upgrades: Dictionary = {}
var materials: Dictionary = {"alloy": 0, "biological": 0, "relic": 0}
var energy: float = 60
var max_hp: float = 100
var capacity: float = 100
func allowed(expression: String) -> bool:
    if expression.strip_edges() in ["", "—", "-", "–"]:
        return true
    for term: String in expression.split("&"):
        term = term.strip_edges()
        if term.begins_with("!"):
            if flags.get(term.substr(1), false):
                return false
        elif not flags.get(term, false):
            return false
    return true
func serialize() -> Dictionary:
    return {"generation":generation,"equipped":equipped,"thermal":thermal,"defeated":defeated,"flags":flags,"visited":visited,"collected":collected,"released":released,
        "pending":pending,"checkpoint":checkpoint,"day_seconds":day_seconds,"owned":owned,
        "upgrades":upgrades,"materials":materials,"energy":energy,"max_hp":max_hp,"capacity":capacity}
func restore(data: Dictionary, room_ids: Array) -> bool:
    if data.is_empty() or not room_ids.has(data.get("checkpoint", "")):
        return false
    for key: String in ["flags","visited","collected","released","pending","upgrades","materials"]:
        if not data.get(key, {}) is Dictionary:
            return false
    generation = maxi(0,int(data.get("generation",0)))
    equipped = str(data.get("equipped","RIF01"))
    thermal = data.get("thermal",{}) if data.get("thermal",{}) is Dictionary else {}
    defeated = data.get("defeated",{}) if data.get("defeated",{}) is Dictionary else {}
    flags = data.get("flags", {})
    visited = data.get("visited", {})
    collected = data.get("collected", {})
    released = data.get("released", {})
    pending = data.get("pending", {})
    upgrades = data.get("upgrades", {})
    materials = data.get("materials", {"alloy":0,"biological":0,"relic":0})
    checkpoint = data.checkpoint
    day_seconds = fposmod(float(data.get("day_seconds",360)),1440.0)
    owned = data.get("owned",["RIF01"]) if data.get("owned",[]) is Array else ["RIF01"]
    if not owned.has("RIF01"):
        owned.append("RIF01")
    capacity = clampf(float(data.get("capacity",100)),100,120)
    max_hp = clampf(float(data.get("max_hp",100)),100,140)
    energy = clampf(float(data.get("energy",60)),0,capacity)
    return true
func save() -> Error:
    return Store.write_state(serialize(), PATH)
