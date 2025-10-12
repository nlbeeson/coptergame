extends CharacterBody2D

@export var speed = 10000
@export var gravity = 1000
@export var thrust_force = 400
@export var fuel = 100.0


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta # simple gravity
		
		velocity.x = speed * delta # simple movement to the right
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("thrust"):
		velocity.y = -thrust_force
		use_fuel(1)
	# Todo: Add left / right thrust movement
		
	# Rotate sprite with direction
	# Todo: smooth the rotation transition with slerp function
	if velocity.y < 0:
		rotation_degrees = -20
	if velocity.y > 0:
		rotation_degrees = 45         
	if velocity.y == 0:
		rotation_degrees = 0
	move_and_slide()

func use_fuel(fuel_used):
	fuel -= fuel_used
