extends WeaponRanged
class_name Shotgun

@onready var fire_sound = $Fire
@onready var out_of_ammo_sound = $OutOfAmmoFiring
@onready var reload_sound = $Reload

func _ready():
	current_ammo = weapon_stats.ammo_capacity
	reload_started.connect(_on_reload_started)
	reload_finished.connect(_on_reload_finished)
	
func can_attack():
	return current_ammo > 0 and not _is_reloading

func attack():
	if not can_attack():
		out_of_ammo_sound.play()
		return
	if weapon_stats.consumes_ammo:
		current_ammo -= 1
	fire_sound.play()
	attacked.emit(weapon_stats.accuracy, weapon_stats.bullet_damage, weapon_stats.bullet_speed, weapon_stats.salvo_size)

func _on_reload_started():
	reload_sound.play()

func _on_reload_finished():
	_is_reloading = false
	current_ammo = weapon_stats.ammo_capacity
