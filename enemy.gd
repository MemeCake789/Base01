extends CharacterBody2D

var speed			: int = 300
var player			: CharacterBody2D = null
var player_chase 	: bool = false

func _physics_process(delta):
	if player_chase:
		var direction = (player.position - position).normalized()
		rotation = atan2(direction.y, direction.x)
		position += direction * speed * delta

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		player_chase = false
