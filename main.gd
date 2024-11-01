extends Node2D

@export var mob_scene: PackedScene
@export var radius : int = 700


func _on_enemy_spawn_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
# Generate a random angle between 0 and -Ï radians
	var angle = randf_range(0,360)
	# Calculate x and y coordinates
	var x = cos(angle) * radius
	var y = sin(angle) * radius
	var start_position = Vector2(x, y)

	mob.position = %Player.position + start_position
	add_child(mob)
