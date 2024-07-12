extends CharacterBody2D
class_name Entity


func _ready():
	pass

func _kill():
	queue_free()
