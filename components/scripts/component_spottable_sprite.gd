extends AnimatedSprite2D
class_name SpottableSprite

@export var stay_visible_once_spotted: bool

func enter_sight():
	visible = true

func leave_sight():
	if stay_visible_once_spotted:
		return
	visible = false
