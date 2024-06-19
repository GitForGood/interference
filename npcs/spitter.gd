extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var hearing_range: int
var hearing_range_modifiers: int

var sight_cone

func _physics_process(delta):
	move_and_slide()
