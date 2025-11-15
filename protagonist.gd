extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25



func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	if(Input.is_action_pressed("move_down")):
		dir = 0;
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "crouch"
		$BaseCollision.disabled = true # disable base collision
		$CrouchCollision.disabled = false #enable crouch collision
		
	else:
		get_node("BaseCollision").disabled = false    
		get_node("CrouchCollision").disabled = true 
		
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	if velocity.length() > 0:
			$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		
		
	move_and_slide()
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_speed
