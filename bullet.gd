extends RigidBody2D

var speed = 1000

func _physics_process(delta):
	linear_velocity = transform.x * speed
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
	queue_free()
