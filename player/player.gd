extends CharacterBody2D

@export var gravity = 1000
@export var thrust_force = 400

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("thrust"):
		velocity.y = -thrust_force
	
	move_and_slide()
