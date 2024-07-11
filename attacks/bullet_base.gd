extends Node2D
class_name BulletBase

@export var bullet_stats: BulletStats
@export var sprite: Sprite2D
@export var raycast: RayCast2D
@export var hit_particles: GPUParticles2D

var velocity: Vector2
var penetrations: int = 0
var deviance: float

const MAX_RANGE = 2000.0

func _init(deviance: float = 0.0):
	self.deviance = deviance

func _ready():
	raycast.collision_mask = bullet_stats.hitscan_stats.collision_mask
	raycast.target_position = Vector2.RIGHT * bullet_stats.hitscan_stats.hitscan_range
	raycast.rotate(deviance)
	raycast.force_raycast_update()
	var last_collision_point: Vector2
	while(raycast.is_colliding() and penetrations <= bullet_stats.hitscan_stats.hitscan_penetrations):
		var collider = raycast.get_collider()
		if collider is HurtBox:
			last_collision_point = raycast.get_collision_point()
			for payload in bullet_stats.payloads:
				payload.deliver(last_collision_point,collider)
			penetrations += 1
			if hit_particles:
				var hit_marker = HitMarker.new(sprite.texture, hit_particles.duplicate(), last_collision_point, global_rotation)
				collider.add_child(hit_marker)
		raycast.add_exception(collider)
		raycast.force_raycast_update()
	if not last_collision_point or penetrations <= bullet_stats.hitscan_stats.hitscan_penetrations:
		last_collision_point = raycast.target_position.rotated(deviance + global_rotation)
	var trail = Trail.new(global_position, last_collision_point, bullet_stats.hitscan_stats.trail_stats)
	get_tree().root.add_child(trail)
	queue_free()
