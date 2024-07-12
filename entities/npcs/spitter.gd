extends Entity

var hearing_range: float
var hearing_range_modifiers: float
var shooting_timer = 4.0
var current_timer = 4.0

var projectile_stats = load("res://projectiles/implemented/spitter/spitter_projectile.tres")
var attack_stats = load("res://projectiles/implemented/spitter/spitter_attack.tres")
var projectile_shape = load("res://projectiles/implemented/spitter/spitter_projectile_shape.tres")
var projectile_sprite_path = "res://assets/sprites/ball.png"

func _process(delta):
	current_timer -= delta
	if current_timer < 0.0:
		var handler = get_parent().get_parent().projectile_handler
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = projectile_shape
		current_timer = shooting_timer
