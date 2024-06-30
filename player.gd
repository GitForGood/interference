extends CharacterBody2D

@export var inventory: Inventory
@export var equipment_slot: InventoryItem
@onready var inventory_ui = $InventoryUi
@onready var flashlight = $Lantern
@onready var raycast = $RayCast2D
@onready var camera = $Camera2D
@onready var vision_cone = $VisionCone
@onready var sprite = $AnimatedSprite2D
@onready var shotgun = $Shotgun

var attack_cooldown_primary: float = 0.0
var attack_cooldown_secondary: float = 0.0
var movement_speed: float = 100.0
var current_state: state = state.alert
var current_bodies_in_scope: Array[PhysicsBody2D]
var walk_animtation_timer: SceneTreeTimer



signal changed_state(state: state)

var cancel_walk_animation: Callable = func(): sprite.stop()

enum state{
	alert,
	inventory,
	interacting
}

func _ready():
	pass

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

func input_check_if_attack():
	if Input.is_action_just_pressed("primary_fire"):
		if attack_cooldown_primary < 0.0:
			shotgun.attack()
	if Input.is_action_just_pressed("secondary_fire"):
		if attack_cooldown_primary < 0.0:
			pass

func input_reload_check():
	if Input.is_action_just_pressed("reload"):
		shotgun.reload()

func input_check_if_toggle_flashlight():
	if Input.is_action_just_pressed("flashlight"):
		flashlight.enabled = !flashlight.enabled

func input_check_if_moving():
	if Input.is_action_just_pressed("movement_keys"):
		switch_state(state.alert)
		
func input_check_if_move_camera():
	if Input.is_action_pressed("shift"):
		var pos = get_local_mouse_position() / 2
		camera.offset.x = lerp(camera.offset.x, pos.x, 0.005)
		camera.offset.y = lerp(camera.offset.y, pos.y, 0.005)
	else:
		if camera.offset.length() < 0.01:
			return
		else:
			camera.offset.x = lerp(camera.offset.x, 0.0, 0.005)
			camera.offset.y = lerp(camera.offset.y, 0.0, 0.005)

func switch_state(to: state):
	exit_state()
	enter_state(to)
	changed_state.emit(to)

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
			velocity = lerp(velocity, input_calculate_movement_direction() * movement_speed, 0.005)
			walk_animation_check()
			input_check_if_toggle_inventory()
			input_check_if_toggle_flashlight()
			input_check_if_move_camera()
			input_reload_check()
			input_check_if_attack()
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
	attack_cooldown_secondary -= delta
	attack_cooldown_primary -= delta
	state_input_handler()
	update_vision()
	rotate_sprite()
	move_and_slide()

func collect(item: InventoryItem):
	inventory.insert(item)

func equip_item(item: InventoryItem):
	if equipment_slot:
		(equipment_slot)
	equipment_slot = item

func unequip_item():
	collect(equipment_slot)
	equipment_slot = null

func update_vision():
	for body in current_bodies_in_scope:
		raycast.target_position = to_local(body.global_position)
		raycast.force_raycast_update()
		var sprite = body.get_parent().sprite
		if not raycast.get_collider():
			sprite.spot()
		else:
			sprite.unspot()

func rotate_sprite():
	sprite.look_at(get_global_mouse_position())
	sprite.rotate(PI/2)
	vision_cone.look_at(get_global_mouse_position())

func _on_vision_cone_body_entered(body: PhysicsBody2D):
	if not body.get_parent().has_node("HideableSprite"):
		return
	if not body in current_bodies_in_scope:
		current_bodies_in_scope.append(body)

func _on_vision_cone_body_exited(body):
	if current_bodies_in_scope.has(body):
		current_bodies_in_scope.erase(body)
		body.get_parent().sprite.unspot()

func walk_animation_check():
	if sprite.is_playing():
		if velocity.length() < 1.0:
			sprite.pause()
			if not walk_animtation_timer:
				walk_animtation_timer = get_tree().create_timer(0.5)
				walk_animtation_timer.timeout.connect(cancel_walk_animation)
	else:
		if velocity.length() > 1.0:
			sprite.play()
			if walk_animtation_timer:
				walk_animtation_timer.timeout.disconnect(cancel_walk_animation)
				walk_animtation_timer = null

func create_bullets(accuracy: float, damage: int, speed: float, salvo: int):
	var ray = get_local_mouse_position()-position
	for bullet in salvo:
		pass

func equip_ranged_weapon(weapon: WeaponRanged):
	shotgun = weapon
	weapon.attacked.connect(create_bullets)
