extends CharacterBody2D

var speed = 		400		# Maximum speed in pixels/sec
var acceleration = 1000		# How quickly to reach max speed
var friction = 		500		# How quickly to slow down

const ZOOM_IN_TARGET = 	Vector2(2.0, 2.0)  	# Target zoom level
const ZOOM_OUT_TARGET = Vector2(1.0, 1.0)  	# Initial zoom level
const ZOOM_SPEED = 10.0      				# Zoom speed factor

@onready var foci_points = 			[%Shoot_Range.polygon[1],		 %Shoot_Range.polygon[2]]			# End points of Shoot_Range
@onready var foci_hitbox_points = 	[%Shoot_Range_Hitbox.polygon[1], %Shoot_Range_Hitbox.polygon[2]] 	# End points of Shoot_Range_Hitbox
const FOCI_ZOOM_IN_TARGET = 		[Vector2(1800,-200),			 Vector2(1800,200)]
const FOCI_ZOOM_OUT_TARGET = 		[Vector2(1800,-400),			 Vector2(1800,400)]

var target_zoom =				ZOOM_OUT_TARGET
var target_foci_zoom = 			FOCI_ZOOM_OUT_TARGET
var target_foci_hitbox_zoom = 	FOCI_ZOOM_OUT_TARGET



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
	
	# Zooming & Shoot Range logic
	%Shoot_Range_Hitbox.polygon[1] = 	lerp(%Shoot_Range_Hitbox.polygon[1], 	target_foci_hitbox_zoom[0], ZOOM_SPEED * delta)
	%Shoot_Range_Hitbox.polygon[2] = 	lerp(%Shoot_Range_Hitbox.polygon[2], 	target_foci_hitbox_zoom[1], ZOOM_SPEED * delta)
	
	%Shoot_Range.polygon[1] = 			lerp(%Shoot_Range.polygon[1], 			target_foci_zoom[0], 		ZOOM_SPEED * delta)
	%Shoot_Range.polygon[2] = 			lerp(%Shoot_Range.polygon[2], 			target_foci_zoom[1], 		ZOOM_SPEED * delta)
		
	$Camera2D.zoom = lerp($Camera2D.zoom, target_zoom, ZOOM_SPEED * delta)

func _input(event):
	if event.is_action_pressed("right_click"):
		target_zoom = ZOOM_IN_TARGET
		target_foci_zoom = FOCI_ZOOM_IN_TARGET
		target_foci_hitbox_zoom = FOCI_ZOOM_IN_TARGET
	elif event.is_action_released("right_click"):
		target_zoom = ZOOM_OUT_TARGET
		target_foci_zoom = FOCI_ZOOM_OUT_TARGET
		target_foci_hitbox_zoom = FOCI_ZOOM_OUT_TARGET
