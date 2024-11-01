extends CharacterBody2D

const ZOOM_IN_TARGET = Vector2(2.0, 2.0)  # Target zoom level
const ZOOM_OUT_TARGET = Vector2(1.0, 1.0)  # Initial zoom level
const ZOOM_SPEED = 10.0      # Zoom speed factor

var speed = 400# Maximum speed in pixels/sec
var acceleration = 1000# How quickly to reach max speed
var friction = 500# How quickly to slow down

var is_zooming = false
var target_zoom = ZOOM_OUT_TARGET

func _ready():
	pass

func _physics_process(delta):
	# Character movement logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()
	look_at(get_global_mouse_position())
	# Zooming logic
	
	$Camera2D.zoom = lerp($Camera2D.zoom, target_zoom, ZOOM_SPEED * delta)

func _input(event):
	if event.is_action_pressed("right_click"):
		target_zoom = ZOOM_IN_TARGET
	elif event.is_action_released("right_click"):
		target_zoom = ZOOM_OUT_TARGET
