extends Node2D
signal CharmSwitched
var Parent: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if Parent == null:
		print("Parent not defined!")
		Parent = get_parent()



func _on_activate_charm():
	#Switch sprite here.	
	Parent.ACCEL_SPEED *= 2
	Parent.max_speed *= 2
	Parent.JUMP_VELOCITY /= 1.075
	Parent.max_jump_vel /= 1.075

func _on_deactivate_charm():
	Parent.ACCEL_SPEED /= 2
	Parent.max_speed /= 2
	Parent.JUMP_VELOCITY *= 1.075
	Parent.max_jump_vel *= 1.075

