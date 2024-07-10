extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_decor(decor: Node2D, global_position: Vector2, rotation: float):
	decor.global_position = global_position
	decor.rotation = rotation
	add_child(decor)
