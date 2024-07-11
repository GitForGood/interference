extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var gun_stats: StatsGun
@export var loaded_shell: ShellStats

var is_reloading: bool = false
var is_shooting: bool = false
var ammo_left: int

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
	if is_reloading or ammo_left == gun_stats.ammo_max or is_shooting:
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

func shoot():
	# makes it as so you can only buffer one attack at a time
	if is_reloading or is_shooting:
		return
	is_shooting = true
	if ammo_left > 0:
		animation_player.play("shotgun/shoot_live")
		ammo_left -= 1
		spawn_bullets()
	else:
		animation_player.play("shotgun/shoot_dud")

func fire_primary():
	shoot()

func spawn_bullets():
	var number_of_bullets = loaded_shell.number_of_bullets
	var relevant_bullet_scene = load("res://attacks/implemented/buckshot.tscn")
	for bullets in loaded_shell.number_of_bullets:
		var deviance = loaded_shell.accuracy_curve.sample(randf())*loaded_shell.max_deviancy_radians
		var spawn_pos = $EndPoint.position
		var new_bullet: BulletBase = relevant_bullet_scene.instantiate()
		new_bullet.translate(spawn_pos)
		new_bullet.deviance = deviance
		add_child(new_bullet)
