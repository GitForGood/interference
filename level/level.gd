extends Node2D

@onready var player = $EntitiyHandler/Player
@onready var level_floor = $Floor
@onready var lantern = $EntitiyHandler/Player/Lantern
@onready var camera = $PlayerCamera

# handlers
@onready var decor_handler = $DecorHandler
@onready var entity_handler = $EntitiyHandler
@onready var hitscan_handler = $HitscanHandler
@onready var projectile_handler = $ProjectileHandler

const CAMERA_SENSITIVITY = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#camera handling
	if Input.is_action_pressed("camera_move"):
		camera.position = lerp(camera.position, get_global_mouse_position(), CAMERA_SENSITIVITY*delta/10.0)
	else:
		camera.position = lerp(camera.position, player.position, CAMERA_SENSITIVITY*delta)
	pass

