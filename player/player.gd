extends CharacterBody2D

@export var speed = 10000
@export var gravity = 1000
@export var thrust_force = 400


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta # simple gravity
		
		velocity.x = speed * delta # simple movement to the right
		
	if Input.is_action_just_pressed("thrust"):
		velocity.y = -thrust_force
	if Input.is_action_pressed("left"): # apply force to the left when action is held
		velocity.x -= thrust_force
	if Input.is_action_pressed("right"): # apply force to the right when action is held
		velocity.x += thrust_force
	move_and_slide()
