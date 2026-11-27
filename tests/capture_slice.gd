extends SceneTree
func _initialize() -> void:
    call_deferred("capture")
func capture() -> void:
    var scene: Node2D = load("res://world/expedition.tscn").instantiate()
    scene.persistence_enabled = false
    root.add_child(scene)
    await process_frame
    scene.load_room(2)
    scene.player.position = Vector2(290,270)
    for i in range(6):
        await process_frame
    await RenderingServer.frame_post_draw
    root.get_texture().get_image().save_png("res://art/previews/in_game_camp.png")
    quit()
