extends Area2D

@export var speed = 500
var movement = Vector2(1,0)

# runs every fixed frame
func _physics_process(delta: float) -> void:
	global_position += movement.rotated(rotation) * speed * delta

# if VisibleOnScreenNotifier node exits screen	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # destroy itself

# if CollisionShape2D detects another Area2D inside itself
func _on_area_entered(area):
	if area is Asteroid:
		area.destroy_asteroid() # call the asteroid's destroy function
		queue_free()
