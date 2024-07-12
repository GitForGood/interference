extends Entity
class_name Player

@export var inventory: Inventory
@onready var equipment_slot: Weapon
@onready var flashlight = $Lantern
@onready var raycast = $LineOfSight
@onready var vision_cone = $ComponentLos
@onready var vision_cone_shape = $ComponentLos/Arc
@onready var sprite = $AnimatedSprite2D
@onready var hitscan: RayCast2D = $Hitscan

# vision stuff
var current_state: State = State.alert
var current_bodies_in_scope: Array[PhysicsBody2D]
var look_at_goal: Vector2

# movement related stuff
var movement_speed: float = 150.0
var movement_speed_modifier: float = 0.8
var movement_smoothness: float = 8.0
const HIT_MARKER_DURATION = 2.5

enum State{
	alert,
	hands_tied,
	incapacitated,
	interacting,
	attacking
}

func equip(weapon_or_tool):
	if equipment_slot:
		#TODO DO STUFF, either unequip or throw error
		pass
	equipment_slot = weapon_or_tool
	weapon_or_tool.add_listener(self)

func unequip():
	equipment_slot.remove_listener(self)

func _ready():
	#vision_cone.get_child(0).queue_free()
	#vision_cone.remove_child(vision_cone.get_child(0))
	vision_cone.add_child(Arc.new(12,200.0,TAU/3))
	equipment_slot = $Hand.get_child(0)
	pass

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


func input_check_if_attack(delta):
	if not equipment_slot:
		return
	if Input.is_action_just_pressed("primary_fire"):
		equipment_slot.fire_primary()
	elif Input.is_action_pressed("primary_fire"):
		equipment_slot.continuous_fire_primary(delta)
	if Input.is_action_just_pressed("secondary_fire"):
		equipment_slot.fire_secondary()
	elif Input.is_action_pressed("secondary_fire"):
		equipment_slot.continuous_fire_secondary(delta)
	if Input.is_action_just_released("primary_fire"):
		equipment_slot.release_primary()
	if Input.is_action_just_released("secondary_fire"):
		equipment_slot.release_secondary()

func switch_state(state: State):
	if state == current_state:
		return
	# handle exiting the current state
	match current_state:
		State.alert:
			pass
		State.hands_tied:
			pass
		State.interacting:
			pass
		State.attacking:
			pass
		State.incapacitated:
			pass
	# handle entering the desired state
	match state:
		State.alert:
			pass
		State.hands_tied:
			pass
		State.interacting:
			pass
		State.attacking:
			pass
		State.incapacitated:
			pass

func input_reload_check():
	if equipment_slot:
		if Input.is_action_just_pressed("reload"):
			equipment_slot.reload()

func input_check_if_toggle_flashlight():
	if Input.is_action_just_pressed("flashlight"):
		flashlight.enabled = !flashlight.enabled


func check_inputs_for_state(state: State, delta: float):
	look_at_goal = get_global_mouse_position()
	match state:
		State.alert:
			var move_direction = input_calculate_movement_direction()
			velocity = lerp(velocity, move_direction * movement_speed, delta * movement_smoothness)
			input_check_if_attack(delta)
			input_reload_check()
			look_at(look_at_goal)
		State.hands_tied:
			pass
		State.interacting:
			pass
		State.attacking:
			var move_direction = input_calculate_movement_direction() * 0.8
			pass
		State.incapacitated:
			return

func check_state_change_conditions(state: State):
	match state:
		State.alert:
			pass
		State.hands_tied:
			pass
		State.interacting:
			pass
		State.attacking:
			pass
		State.incapacitated:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# inputs for current state
	check_inputs_for_state(current_state, delta)
	# inputs for changing state
	check_state_change_conditions(current_state)
	# physics
	move_and_slide()

func inflict_damage(damage: float):
	print("I: " + str(self) + " took: " + str(damage) + " damage!")

func _on_body_entered(body):
	# handle being hit by projectile
	pass

func _on_component_los_target_entered_los(target: Area2D):
	var target_sprite = target.get_parent().get_node("ComponentSpottableSprite")
	if target_sprite:
		target_sprite.enter_sight()

func _on_component_los_target_exited_los(target):
	var target_sprite = target.get_parent().get_node("ComponentSpottableSprite")
	if target_sprite:
		target_sprite.leave_sight()
