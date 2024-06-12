extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_drag_data(at_position):
	var previous_texture = TextureRect.new()
	return get_parent().displaying
	pass
func _can_drop_data(at_position, data):
	return data is Texture2D
	pass
func _drop_data(at_position, data):
	texture = data
	pass
