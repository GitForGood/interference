extends AttackPropagation
class_name ProjectileStats

@export var projectile_speed: float
@export var projectile_max_speed: float
@export_range(-100.0, 100.0) var projectile_acceleration: float = 0.0
@export var projectile_destructable: bool = false
@export var projectile_lifespan_sec: float
@export var projectile_bounces: int = 0
@export var projectile_penetrations: int = 0
