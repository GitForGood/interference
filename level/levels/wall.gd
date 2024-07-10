extends Node2D
class_name Wall

func _ready():
	pass

func _on_hurt_box_area_entered(area):
	var hit_box_parent = area.get_parent()
	if hit_box_parent.is_in_group("projectile"):
		hit_box_parent.hit_wall.emit(self)
	elif hit_box_parent.is_in_group("melee"):
		hit_box_parent.hit_wall.emit(self)
