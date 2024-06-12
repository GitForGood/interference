extends CharacterBody2D

@export var inventory: Inventory
@onready var inventory_ui = $InventoryUi
@onready var flashlight = $Lantern

var movement_speed: float = 400.0

var current_state: state = state.alert

enum state{
	alert,
	inventory,
	interacting
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var bag: InventoryContainer = load("res://inventory/containers/PouchNixie.tres")
	bag.flipped = true
	var tube: InventoryItem = load("res://inventory/items/NixieTube.tres")
	var tmpTube = tube.duplicate()
	inventory.insert(tmpTube)
	tmpTube = tube.duplicate()
	inventory.insert(tmpTube)
	tmpTube = tube.duplicate()
	tmpTube.flipped = true
	inventory.insert(tmpTube)
	inventory.insert(bag)


func input_check_if_toggle_inventory():
	if Input.is_action_just_pressed("inventory"):
		if current_state == state.inventory:
			switch_state(state.alert)
		else:
			switch_state(state.inventory)

func input_calculate_movement_direction() -> Vector2:
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

func check_if_toggle_flashlight():
	if Input.is_action_just_pressed("flashlight"):
		flashlight.flip()
		flashlight.update()

func input_check_if_moving():
	if Input.is_action_just_pressed("movement_keys"):
		switch_state(state.alert)

func switch_state(to: state):
	exit_state()
	enter_state(to)

func enter_state(to: state):
	match to:
		state.alert:
			current_state = state.alert
			pass
		state.inventory:
			current_state = state.inventory
			inventory_ui.open()
			pass
		state.interacting:
			current_state = state.interacting
			pass

func exit_state():
	match current_state:
		state.alert:
			velocity = Vector2.ZERO
			return
		state.inventory:
			inventory_ui.close()
			return
		state.interacting:
			return

func state_input_handler():
	match current_state:
		state.alert:
			velocity = input_calculate_movement_direction() * movement_speed
			input_check_if_toggle_inventory()
			check_if_toggle_flashlight()
			return
		state.inventory:
			input_check_if_moving()
			input_check_if_toggle_inventory()
			return
		state.interacting:
			input_check_if_moving()
			return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_input_handler()
	move_and_slide()
	pass

func collect(item: InventoryItem):
	inventory.insert(item)
