extends CanvasLayer
@export var expanded: bool = false
var buttons: Array[TouchScreenButton] = []
func _ready() -> void:
    layer = 10
    var specs: Array = [["left","<",Vector2(35,320)], ["right",">",Vector2(87,320)], ["jump","JUMP",Vector2(600,320)], ["dodge","DODGE",Vector2(545,320)], ["fire","FIRE",Vector2(600,265)], ["melee","BLADE",Vector2(545,265)], ["interact","USE",Vector2(490,320)], ["first","ROOT",Vector2(175,320)], ["second","BELL",Vector2(230,320)], ["third","STONE",Vector2(285,320)]]
    if expanded:
        specs.append_array([["heal","HEAL",Vector2(490,265)],["rewind","REWIND",Vector2(435,265)],["down","DOWN",Vector2(140,320)],["journal","LOG",Vector2(335,265)],["inventory","GEAR",Vector2(385,265)],["pause","MENU",Vector2(385,320)]])
    for spec: Array in specs:
        var button := TouchScreenButton.new()
        button.action = spec[0]
        button.position = spec[2] - Vector2(23,21)
        var shape := RectangleShape2D.new()
        shape.size = Vector2(46,42)
        button.shape = shape
        button.shape_visible = false
        var image := Image.create(46,42,false,Image.FORMAT_RGBA8)
        image.fill(Color(0.12,0.23,0.29,0.78))
        button.texture_normal = ImageTexture.create_from_image(image)
        var label := Label.new()
        label.text = spec[1]
        label.position = Vector2(1,12)
        label.size.x = 44
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.add_theme_font_size_override("font_size",10)
        label.mouse_filter = Control.MOUSE_FILTER_IGNORE
        button.add_child(label)
        add_child(button)
        buttons.append(button)
    update_visibility()
func _process(_dt: float) -> void:
    update_visibility()
func update_visibility() -> void:
    var show_controls: bool = PlatformInput.uses_touch() and not get_tree().paused
    for button: TouchScreenButton in buttons:
        button.visible = show_controls
