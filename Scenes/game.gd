extends Node2D

# asteroid spawning variables
@onready var asteroids = $AsteroidParent

var asteroidScene = preload("res://Scenes/asteroid.tscn")
var startAsteroids = 5 # start with 10 asteroids

# runs at the start
func _ready():
	for i in range(startAsteroids):
		spawnRandomAsteroid()

# spawn 1 random asteroid
func spawnRandomAsteroid():
	# Instantiate (create) 1 asteroid node
	var a = asteroidScene.instantiate() 
	
	# set a random spawn position from the edge of the screen
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = randf_range(0, width)
	a.global_position = Vector2(random_x, 0)
	
	# add child to actually create it
	asteroids.add_child(a)
