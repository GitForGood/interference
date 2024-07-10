extends CharacterBody2D
class_name Entity

var health_max: float
var health_current: float

func _ready():
	pass

func handle_impact(body):
	if body.is_in_group("projectile"):
		var stats: ProjectileStats = body.projectile_stats
		print("I got hit with " + str(stats))
	pass

func damage(damage: float):
	print("I: " + str(self) + " took " + str(damage) + " damage!")
	health_current -= damage
	if health_current <= 0.0:
		_kill()

func push(force_vector: Vector2):
	pass

func _kill():
	queue_free()
