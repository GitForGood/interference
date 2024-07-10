extends Node
class_name HealthComponent

@export var MAX_HEALTH = 10.0
var health: float

signal hurt(damage_amount:float, new_health:float)
signal died()

func _ready():
	health = MAX_HEALTH

func damage(damage: float):
	health -= damage
	hurt.emit(damage, health)
	if health <= 0.0:
		died.emit()
