extends Node2D
class_name BulletBase

@export var bullet_stats: BulletStats
@export var hit_box: HitBox
@export var sprite: Sprite2D

var velocity: Vector2
var penetrations: int = 0

func _ready():
	hit_box.payloads = bullet_stats.payloads
	hit_box.hit.connect(handle_hit)

func handle_hit(area: HurtBox):
	penetrations +=1
	if penetrations > bullet_stats.projectile_stats.projectile_penetrations:
		queue_free()

func _physics_process(delta):
	position += velocity * delta
