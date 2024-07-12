extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D
@onready var end_point: Marker2D = $AnimatedSprite2D/EndPoint
@onready var blocked_particles: GPUParticles2D = $AnimatedSprite2D/GPUParticles2D
@export var gun_stats: StatsGun
@export var loaded_shell: ShellStats

var is_reloading: bool = false
var is_shooting: bool = false
var is_blocked: bool = false
var ammo_left: int
var offset_x: float = 0.0

func _ready():
	animation_player.animation_finished.connect(finish_reloading_after_animation)
	animation_player.animation_finished.connect(finish_shooting_after_animation)
	ammo_left = gun_stats.ammo_max
	loaded_shell = load("res://equipment/ammo/shell_buckshot.tres")

func finish_reloading_after_animation(animation: String):
	if animation == "shotgun/close":
		ammo_left = gun_stats.ammo_max
		is_reloading = false

func finish_shooting_after_animation(animation: String):
	if animation == "shotgun/shoot_live" or animation == "shotgun/shoot_dud":
		is_shooting = false

func reload():
	if is_reloading or ammo_left == gun_stats.ammo_max or is_shooting or is_blocked:
		return
	is_reloading = true
	if ammo_left == 0:
		animation_player.play("shotgun/open")
		animation_player.queue("shotgun/eject_first")
		animation_player.queue("shotgun/eject_second")
		animation_player.queue("shotgun/insert_second")
		animation_player.queue("shotgun/insert_first")
		animation_player.queue("shotgun/close")
	else:
		animation_player.play("shotgun/open")
		animation_player.queue("shotgun/eject_first")
		animation_player.queue("shotgun/insert_first")
		animation_player.queue("shotgun/close")
	end_point.position.x = -1.5

func shoot():
	# makes it as so you can only buffer one attack at a time
	is_shooting = true
	if ammo_left > 0:
		slow_down()
		animation_player.play("shotgun/shoot_live")
		ammo_left -= 1
		spawn_bullets()
		end_point.position.x *= -1
	else:
		animation_player.play("shotgun/shoot_dud")

func fire_primary():
	if is_reloading or is_shooting or is_blocked:
		return
	shoot()

func slow_down():
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0.5, 0.1)
	tween.chain().tween_property(Engine, "time_scale", 1.0, 0.1).set_ease(Tween.EASE_IN)

func spawn_bullets():
	var number_of_bullets = loaded_shell.number_of_bullets
	var relevant_bullet_scene = load("res://attacks/implemented/buckshot.tscn")
	for bullets in loaded_shell.number_of_bullets:
		var deviance = loaded_shell.accuracy_curve.sample(randf())*loaded_shell.max_deviancy_radians
		var spawn_pos = to_local(end_point.global_position)
		var new_bullet: BulletBase = relevant_bullet_scene.instantiate()
		new_bullet.translate(spawn_pos)
		new_bullet.deviance = deviance
		add_child(new_bullet)

func handle_obstruction():
	if raycast.is_colliding():
		var obstruction_length = (to_local(raycast.get_collision_point())-raycast.target_position).length()
		is_blocked = obstruction_length > 10
		sprite.position.x = 9 - obstruction_length
	else:
		is_blocked = false
		sprite.position.x = 9

func _physics_process(delta):
	look_at(get_global_mouse_position())
	handle_obstruction()
	blocked_particles.emitting = is_blocked

