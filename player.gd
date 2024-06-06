extends CharacterBody2D

@export var inventory: Inventory
var movement_speed: float = 400.0

var current_state: state = state.idle

enum state{
	idle,
	moving,
	inventory,
	interacting,
	attacking
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_movement_direction() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
	return direction.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = calculate_movement_direction() * movement_speed
	
	move_and_slide()
	pass
