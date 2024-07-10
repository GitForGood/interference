extends Area2D

# only deals with areas

@export_flags_2d_physics var obstructor_layers: int
@export_flags_2d_physics var target_layers: int

signal target_entered_los(target: Area2D)
signal target_staying_los(target: Area2D, delta: float)
signal target_exited_los(target: Area2D)

@onready var obstruction_ray: RayCast2D = $ObstructionRay

var targets_within_range: Dictionary

func _ready():
	obstruction_ray.collision_mask = obstructor_layers
	self.collision_mask = target_layers

func _process(delta):
	for target in targets_within_range.keys():
		var is_in_los = check_line_of_sight(target)
		if is_in_los:
			if targets_within_range[target]:
				target_staying_los.emit(target, delta)
			else:
				target_entered_los.emit(target)
			targets_within_range[target] = true
		else:
			target_exited_los.emit(target)
			targets_within_range[target] = false
	pass

func check_line_of_sight(area: Area2D) -> bool:
	obstruction_ray.target_position = to_local(area.global_position)
	obstruction_ray.force_raycast_update()
	return not obstruction_ray.is_colliding()

func _on_area_entered(area: Area2D):
	var los = check_line_of_sight(area)
	targets_within_range[area] = false

func _on_area_exited(area: Area2D):
	targets_within_range.erase(area)
	target_exited_los.emit(area)
