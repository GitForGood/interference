extends Node
class_name WeaponRanged

var _is_reloading: bool
var current_ammo: int

signal reload_finished
signal reload_started
signal reload_partial_started
signal attacked(accuracy: float, damage: int)

var weapon_stats: RangedWeaponStats

func attack():
	push_error("attack function not implemented in child")

func can_attack() -> bool:
	push_error("attack check not implemented in child")
	return false

func reload():
	if _is_reloading or current_ammo == weapon_stats.ammo_capacity:
		return
	_is_reloading = true
	if current_ammo > 0:
		reload_partial_started.emit()
		await get_tree().create_timer(weapon_stats.reload_speed_partial).timeout
		reload_finished.emit()
	else:
		reload_started.emit()
		await get_tree().create_timer(weapon_stats.reload_speed_in_sec).timeout
		reload_finished.emit()
func _ready():
	current_ammo = weapon_stats.ammo_capacity
	_is_reloading = false
