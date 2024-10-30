extends Node2D

@onready var enemy_spawn_pivot: Marker2D = %EnemySpawnPoint

# Properties
@export var radius : int = 500
 
var item_scene = load("res://temp.tscn") 

func _ready():
	var spawn_point_position = enemy_spawn_pivot.global_position

	# Spawn enemies randomly around the spawn point
	for _i in range(10):
		# Generate a random angle between 0 and -π radians
		var angle = randf_range(-0.34, -PI + 0.34)

		# Calculate x and y coordinates
		var x = cos(angle) * radius
		var y = sin(angle) * radius

		var start_position = Vector2(x, y)

		var item = item_scene.instantiate() 
		item.position = start_position
		add_child(item)
