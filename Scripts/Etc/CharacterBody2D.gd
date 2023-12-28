extends CharacterBody2D


signal activate_charm_1
signal activate_charm_2
signal activate_charm_3

signal deactivate_charm_1
signal deactivate_charm_2
signal deactivate_charm_3

var speedcharm = preload("res://Scenes/Charms/Charm Set 1/SpeedCharm.tscn")

#region Variables
@export var Cbody: CharacterBody2D ## Set the characterbody here. Usually the parent.
@export var Camera: Camera2D ## Set the camera here. 
#Movement variables.
#V--------------------V
const FRICTION: float = 3200
var ACCEL_SPEED: float = 1600.0
var JUMP_VELOCITY: float = -800.0
var jump_over: bool = false
var max_jump_vel: float = -700
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
var current_charm: int = 0
#----------------------

#----------------------

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#endregion
func _physics_process(delta):
	if Input.is_action_just_pressed("Switch Charm") && is_on_floor():
		current_charm += 1
		$Label.text= str(current_charm)
		if current_charm == 1:
			deactivate_charm_3.emit()
			activate_charm_1.emit() #Might change this to be numbered later on.
		elif current_charm == 2:
			activate_charm_2.emit()
			deactivate_charm_1.emit()
		elif current_charm == 3:
			activate_charm_3.emit()
			deactivate_charm_2.emit()
			current_charm = 0
		#var charm = speedcharm.instantiate()
		#add_child(charm)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("Left","Right")		
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") && is_on_floor() == true:
		jump_over = false
		velocity.y =  JUMP_VELOCITY
	if Input.is_action_pressed("Jump"):
		if velocity.y >= max_jump_vel:
			if jump_over == false:
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


