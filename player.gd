extends CharacterBody2D

var speed = 400  # Maximum speed in pixels/sec
var acceleration = 2000  # How quickly to reach max speed
var friction = 1000  # How quickly to slow down

func _physics_process(delta):
	# Get input direction vector
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# If there's input, accelerate in that direction
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	# If no input, slow down to a stop
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
