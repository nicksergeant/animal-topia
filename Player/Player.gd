extends KinematicBody2D

const ACCELERATION = 10
const FRICTION = 10
const MAX_SPEED = 80

var velocity = Vector2.ZERO

func move_by_keyboard():
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    return input_vector.normalized()

func move_by_mouse():
    var input_vector = Vector2.ZERO
    var mouse_position = get_global_mouse_position()
    
    var delta_x = mouse_position.x - position.x
    var delta_y = mouse_position.y - position.y
    
    var vector_x
    if (delta_x > 10):
        vector_x = 1
    elif (delta_x < -10):
        vector_x = -1
    else:
        vector_x = 0
    
    var vector_y
    if (delta_y > 10):
        vector_y = 1
    elif (delta_y < -10):
        vector_y = -1
    else:
        vector_y = 0
    
    input_vector.x = vector_x
    input_vector.y = vector_y
    
    return input_vector.normalized()

func _physics_process(delta):
    var input_vector = Vector2.ZERO
    
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        input_vector = move_by_mouse()
    else:
        input_vector = move_by_keyboard()
    
    if input_vector != Vector2.ZERO:
        velocity += input_vector * ACCELERATION * delta
        velocity = velocity.clamped(MAX_SPEED * delta)
    else:
        velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
        
    move_and_collide(velocity)
