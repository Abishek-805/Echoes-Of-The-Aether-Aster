extends Node

const CampaignScene = preload("res://world/campaign.tscn")

var failures: int = 0
var tell_count: int = 0
var recovery_hits: int = 0

func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)

func _ready() -> void:
	call_deferred("run_playtest")

func run_playtest() -> void:
	var game: Node2D = CampaignScene.instantiate()
	game.persistence_enabled = false
	game.stories_enabled = false
	get_tree().root.add_child(game)
	game.load_room("SLU03")
	game.player.position = Vector2(90.0, 282.0)
	game.player.hp = 100.0
	game.player.max_hp = 100.0
	game.player.heal_charges = 3
	game.player.energy = 100.0
	PlatformInput.pointer_aim = false
	await get_tree().physics_frame
	var boss: CharacterBody2D
	for actor: CharacterBody2D in game.actors:
		if str(actor.token) == "B01":
			boss = actor
			break
	check(is_instance_valid(boss), "Sluice Warden should spawn in the SLU03 arena")
	if not is_instance_valid(boss):
		get_tree().quit(1)
		return
	var prior_state: String = str(boss.state)
	var fire_held: bool = false
	var heal_held: bool = false
	var heal_release_frames: int = 0
	var jump_frames: int = 0
	for frame in range(3000):
		if not is_instance_valid(boss):
			break
		if str(boss.state) == "tell" and prior_state != "tell":
			tell_count += 1
		if str(boss.state) == "recover" and prior_state != "recover":
			recovery_hits += 1
		if str(boss.state) == "recover":
			if not fire_held:
				Input.action_press("fire")
				fire_held = true
		else:
			if fire_held:
				Input.action_release("fire")
				fire_held = false
		if not heal_held and game.player.hp <= 70.0 and game.player.heal_charges > 0 and game.player.heal_timer <= 0.0 and str(boss.state) in ["recover", "guard"]:
			Input.action_press("heal")
			heal_held = true
			heal_release_frames = 2
		elif heal_held:
			heal_release_frames -= 1
			if heal_release_frames <= 0:
				Input.action_release("heal")
				heal_held = false
		for hazard: Dictionary in game.hazards:
			if str(hazard.get("kind", "")) == "wave" and float(hazard.get("dir", 0.0)) < 0.0 and float(hazard.at.x) - game.player.position.x < 130.0 and float(hazard.at.x) > game.player.position.x:
				if game.player.is_on_floor() and jump_frames == 0:
					Input.action_press("jump")
					jump_frames = 2
				break
		if jump_frames > 0:
			jump_frames -= 1
			if jump_frames == 0:
				Input.action_release("jump")
		prior_state = str(boss.state)
		if not is_instance_valid(boss):
			break
		await get_tree().physics_frame
	if fire_held:
		Input.action_release("fire")
	if heal_held:
		Input.action_release("heal")
	if jump_frames > 0:
		Input.action_release("jump")
	check(not is_instance_valid(boss) and game.state.flags.get("WARDEN_DOWN", false), "Live recovery-window attacks should defeat the Sluice Warden and advance the route")
	check(tell_count >= 3 and recovery_hits >= 3, "The Warden playtest should exercise repeated tells and punish windows")
	check(game.player.hp > 0.0, "Reading and jumping the shockwave tells should keep the player alive through the fight")
	print("WARDEN_PLAYTEST failures=", failures, " tells=", tell_count, " recovery_windows=", recovery_hits, " boss_hp=", boss.hp if is_instance_valid(boss) else 0.0, " player_hp=", game.player.hp, " heals_left=", game.player.heal_charges)
	game.queue_free()
	get_tree().quit(1 if failures else 0)
