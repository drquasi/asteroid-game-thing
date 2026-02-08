extends CharacterBody2D

# movement variables
@export var acceleration = 10.0
@export var deceleration = 3.0
@export var maxVelocity = 400.0

# shooting variables
@onready var shootPoint = $ShootPoint
@onready var bulletParent = %BulletParent
var bulletScene = preload("res://Scenes/bullet.tscn")

@onready var cooldownTimer = $BulletCooldown
var shootCooldown = false	

# runs every fixed frame (for physics)
func _physics_process(delta: float) -> void:
	# Get input
	var movement = Vector2(Input.get_axis("left","right"), Input.get_axis("forward","backward"))
	
	# look at mouse
	look_at(get_global_mouse_position())
	
	# move player
	velocity += movement * acceleration
	velocity = velocity.limit_length(maxVelocity)
	
	if movement.y == 0: # if not pressing controls, decelerate
		velocity = velocity.move_toward(Vector2.ZERO, deceleration)
	
	move_and_slide()
	
	# loop around screen
	var screenSize = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screenSize.y
	elif global_position.y > screenSize.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screenSize.x
	elif global_position.x > screenSize.x:
		global_position.x = 0

# runs every frame
func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shootCooldown:
			shootCooldown = true
			shoot_bullet()
			cooldownTimer.start()
	
# shooting functions		
func shoot_bullet():
	var bullet = bulletScene.instantiate()
	bullet.global_position = shootPoint.global_position
	bullet.rotation = rotation
	bulletParent.add_child(bullet)
	
func _on_bullet_cooldown_timeout():
	shootCooldown = false
 
