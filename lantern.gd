extends Node2D

@export var cone: bool = false

func flip():
	cone = !cone

func turn_off():
	self.enabled = false
func turn_on():
	self.enabled = true

func update():
	$cone.enabled = cone
	$cone_end.enabled = cone
	$radial.enabled = !cone

func _ready():
	update()

func _process(delta):
	var mouse_position = get_global_mouse_position()
	if cone:
		var width = (mouse_position - global_position).distance_to(Vector2.ZERO)
		var offset = width / 2
		var ray: RayCast2D = $cone_end_check
		ray.target_position.x = (mouse_position - global_position).distance_to(Vector2.ZERO)
		if ray.is_colliding():
			$cone.offset = Vector2(offset + 128, 0)
			$cone.texture.width = width + 256
			$cone_end.visible = false
		else:
			$cone.offset = Vector2(offset, 0)
			$cone.texture.width = width
			$cone_end.visible = true
			$cone_end.offset = Vector2(width+31, 0)
	look_at(mouse_position)
