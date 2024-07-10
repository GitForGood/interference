extends Payload
class_name PayloadDamageDissipated

@export var damage: float
@export var range: float

func deliver(origin: Vector2, onto: Area2D):
	var parent = onto.get_parent()
	if parent.has_node("ComponentHealth"):
		var percent_of_range = 1.0 - (origin - parent.global_position).length() / range
		parent.damage(damage * (percent_of_range**2))
