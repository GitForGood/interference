extends Area2D
class_name HurtBox

var disabled: bool
var time_til_enabled: float

func temp_disable(seconds: float):
	time_til_enabled = seconds
	monitorable = false
	disabled = true

func _physics_process(delta):
	time_til_enabled -= delta
	if time_til_enabled < 0 and disabled:
		disabled = false
		monitorable = true
