extends CharacterBody2D
class_name PrimaryInputComponent ## Use in all classes. Make secondary input components for unique attacks and abilities. 
#region Variables
@export var Cbody: CharacterBody2D ## Set the characterbody here. Usually the parent.
@export var Camera: Camera2D ## Set the camera here. 
#Movement variables.
#V--------------------V
const FRICTION: float = 3200
const ACCEL_SPEED: float = 1600.0
const JUMP_VELOCITY: float = -800.0
var jump_over: bool = false
const MAX_RUN_SPEED: float = 900.0
var max_speed: float =  MAX_RUN_SPEED
#----------------------

#Camera Variables
#V--------------------V
const  CAM_MOVE_SPEED: float = 400
const CAM_LIMIT: float = 300
#----------------------

#Charm Variables
#V--------------------V
var current_charm: String
#----------------------

#----------------------

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#endregion
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("Left","Right")		
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") && is_on_floor() == true:
		jump_over = false
		velocity.y =  JUMP_VELOCITY
	if Input.is_action_pressed("Jump"):
		print(velocity.y)
		if velocity.y >= -700:
			if jump_over == false:
				print("jover")
				velocity.y -= velocity.y / 6
				jump_over = true
		else:
			velocity.y += JUMP_VELOCITY * delta
	if Input.is_action_just_released("Jump"):
		if jump_over == false:
			velocity.y -= velocity.y / 6		
		jump_over = true
	if direction:
		if velocity.x * sign(direction) >= max_speed:
			velocity.x = max_speed * sign(direction)
		else:
			if sign(velocity.x) != direction:
				velocity.x += direction * ACCEL_SPEED * delta * 3
			else:
				velocity.x += direction * ACCEL_SPEED * delta
		#$Camera2D.offset.x += sign(direction) * delta * CAM_MOVE_SPEED * (max_speed/MAX_RUN_SPEED)
		#if $Camera2D.offset.x * sign($Camera2D.offset.x) >= (CAM_LIMIT/ $Camera2D.zoom.x):
		#	$Camera2D.offset.x = CAM_LIMIT/ $Camera2D.zoom.x * sign($Camera2D.offset.x)
		#Adds delta to make sure variable frame rates do not change movement speed.

	else:
		if velocity.x * sign(velocity.x)> (FRICTION * delta) :
			velocity.x -= FRICTION * delta * sign(velocity.x)
		else:
			velocity.x = 0
	
	
		
	#print(other)
	move_and_slide()
