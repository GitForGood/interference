extends Node
class_name WeaponRanged

var _is_reloading: bool
var current_ammo: int
var reload_timer: SceneTreeTimer

signal reload_finished
signal reload_started
signal attacked(accuracy: float, damage: int, speed: float, salvo: int)

@export var weapon_stats: RangedWeaponStats:
	set(stat):
		weapon_stats = stat

func attack():
	push_error("attack function not implemented in child")

func can_attack() -> bool:
	push_error("attack check not implemented in child")
	return false

func reload():
	if not _is_reloading:
		_is_reloading = true
		reload_started.emit()
		reload_timer = get_tree().create_timer(weapon_stats.reload_speed_in_sec)
		reload_timer.timeout.connect(func(): reload_finished.emit())
		
func _ready():
	current_ammo = weapon_stats.ammo_capacity
	_is_reloading = false
