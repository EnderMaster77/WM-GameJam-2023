extends Node2D
signal CharmSwitched
var On: bool = false
const MAX_JUMPS =1
var jumps = MAX_JUMPS
var air_jumping: bool = false
var Parent: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if Parent == null:
		print("Parent not defined!")
		Parent = get_parent()
	On = false



func _on_activate_charm():
	On = true

func _on_deactivate_charm():
	On = false
func _physics_process(delta):
	if Parent.is_on_floor() == false && On == true :
		if Input.is_action_just_pressed("Jump") && jumps >  0 && Parent.jump_over == true:
			jumps -= 1
			print("Air jump")	
			Parent.jump_over = false
			Parent.velocity.y =  Parent.JUMP_VELOCITY / 1.25
		if Input.is_action_pressed("Jump") && air_jumping == true:
			if Parent.velocity.y >= Parent.max_jump_vel / 1.5:
				if Parent.jump_over == false:
					Parent.velocity.y -= Parent.velocity.y / 6
					Parent.jump_over = true
					air_jumping = false
			else:
				Parent.velocity.y += Parent.JUMP_VELOCITY * delta
		if Input.is_action_just_released("Jump"):
			if Parent.jump_over == false:
				Parent.velocity.y -= Parent.velocity.y / 6
			Parent.jump_over = true
			air_jumping = false
	else:
		jumps = MAX_JUMPS
	



