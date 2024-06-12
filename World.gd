extends Node2D

@onready var player = $Player
@onready var floor = $Floor
@onready var walls = $Walls
@onready var lantern = $Player/Lantern

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#light position on the grid
	if not lantern.cone:
		var light_pos = floor.to_local(lantern.global_position) / floor.tile_set.tile_size.x
	
		floor.material.set_shader_parameter("light_position", light_pos)
		floor.material.set_shader_parameter("light_radius", lantern.radial.texture.get_size().x / 2.0)
		#floor.material.set_shader_parameter("update_threshold", 0.1)
