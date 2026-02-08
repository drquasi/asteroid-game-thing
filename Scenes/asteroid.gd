class_name Asteroid extends Area2D

@onready var cshape = $CollisionShape2D

var movement = Vector2(0, -1)
var speed = 150

func _ready():
	# set a random rotation when spawned
	rotation = randf_range(0, 2*PI)
	
func _physics_process(delta):
	global_position += movement.rotated(rotation) * speed * delta
	
	# looping around screen bounds
	var screen_size = get_viewport_rect().size
	var shape_size = cshape.shape.radius + 1
	if (global_position.y + shape_size) < 0:
		global_position.y = screen_size.y + shape_size
	elif (global_position.y - shape_size) > screen_size.y:
		global_position.y = -shape_size
	if (global_position.x + shape_size) < 0:
		global_position.x = screen_size.x + shape_size
	elif (global_position.x - shape_size) > screen_size.x:
		global_position.x = -shape_size

# function for the bullet to tell the asteroid to destroy itself
func destroy_asteroid():
	queue_free()
	
