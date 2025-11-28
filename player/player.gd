extends CharacterBody2D

@export var gravity = 1000
@export var thrust_force = 2500
@export var side_thrust_force = 600
@export var auto_advance_speed = 200 # Base speed the player moves right
@export var max_relative_speed = 400 # Max extra speed from thrust
@export var fuel = 100.0
@export var fuel_consumption_rate = 10.0


func _physics_process(delta):
	# Apply Gravity
	velocity.y += gravity * delta

	# Handle Input & Thrust
	var is_thrusting = false
	
	# Vertical Thrust
	if Input.is_action_pressed("thrust") and fuel > 0:
		velocity.y -= thrust_force * delta
		is_thrusting = true
	
	# Horizontal Movement
	var side_input = Input.get_axis("left", "right")
	if side_input != 0 and fuel > 0:
		velocity.x += side_input * side_thrust_force * delta
		is_thrusting = true
		

	if is_thrusting:
		use_fuel(fuel_consumption_rate * delta)

	# Passive forward acceleration to maintain pace
	if velocity.x < auto_advance_speed:
		velocity.x += 100 * delta # Slow acceleration to base speed
		
	# Rotation / Visuals
	
	# Flip sprite based on input
	#if side_input < 0:
	#	$Sprite.flip_h = true
	#elif side_input > 0:
	#	$Sprite.flip_h = false
	
	# Tilt based on horizontal velocity relative to base speed
	var target_rotation = 0.0
	if velocity.x > auto_advance_speed + 50:
		target_rotation = 15.0 # Tilt forward
	elif velocity.x < auto_advance_speed - 50:
		target_rotation = -10.0 # Tilt back
	else:
		target_rotation = 0.0
		
	# Smooth rotation
	rotation_degrees = lerp(rotation_degrees, target_rotation, 5 * delta)

	move_and_slide()

func use_fuel(amount):
	fuel -= amount
	# print("Fuel: " + str(fuel)) # Debug
