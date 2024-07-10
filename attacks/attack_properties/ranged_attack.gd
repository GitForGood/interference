extends Resource
class_name RangedAttackStats

@export var bullets_per_shot: int = 1
@export var cooldown_sec: float = 0.0
@export_range(0.0, 1.0, 0.01) var inaccuracy: float
