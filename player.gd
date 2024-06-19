extends CharacterBody2D

@export var inventory: Inventory
@export var equipment_slot: InventoryItem
@onready var inventory_ui = $InventoryUi
@onready var flashlight = $Lantern
@onready var raycast = $RayCast2D

var movement_speed: float = 300.0

var current_state: state = state.alert

var current_bodies_in_scope: Array[CharacterBody2D]

enum state{
	alert,
	inventory,
	interacting
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var bag: InventoryContainer = load("res://inventory/containers/pouch_nixie.tres")
	var tube: InventoryItem = load("res://inventory/items/electrical_base_components/nixie_tube.tres")
	var wrench: InventoryItem = load("res://inventory/items/equipment/abittaboth/wrench.tres")
	var tmpTube = tube.duplicate()
	bag.flipped = true
	inventory.insert(tmpTube)
	tmpTube = tube.duplicate()
	inventory.insert(tmpTube)
	tmpTube = tube.duplicate()
	tmpTube.flipped = true
	inventory.insert(tmpTube)
	inventory.insert(bag)
	inventory.insert(wrench)

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
		flashlight.enabled = !flashlight.enabled

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
	$VisionCone.look_at(get_global_mouse_position())
	update_vision()
	pass

func collect(item: InventoryItem):
	inventory.insert(item)

func equip_item(item: InventoryItem):
	if equipment_slot:
		(equipment_slot)
	equipment_slot = item

func unequip_item():
	collect(equipment_slot)
	equipment_slot = null
	
func _on_vision_cone_area_entered(area: Area2D):
	if current_bodies_in_scope.has(area.get_parent()):
		return
	current_bodies_in_scope.append(area.get_parent())

func _on_vision_cone_area_exited(area):
	var body = area.get_parent()
	if current_bodies_in_scope.has(body):
		current_bodies_in_scope.erase(body)
		body.visible = false

func update_vision():
	for body in current_bodies_in_scope:
		raycast.target_position = to_local(body.global_position)
		raycast.force_raycast_update()
		if not raycast.get_collider():
			body.visible = true
		else:
			body.visible = false
