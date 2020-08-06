extends Sprite

onready var playerSprite = get_node("/root/World/YSort/Player/CharacterSprite")

func _unhandled_input(event):
    if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
        var pos = position + offset - ( (texture.get_size() / 2.0) if centered else Vector2() ) # added this 2
        if Rect2(pos, texture.get_size()).has_point(event.position): # added this
            playerSprite.texture = load("res://Player/Maned Wolf.png")
            get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
