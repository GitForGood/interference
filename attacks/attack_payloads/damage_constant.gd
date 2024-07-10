extends Payload
class_name PayloadDamageConstant

@export var damage: float

func deliver(origin: Vector2, onto: Area2D):
	var parent = onto.get_parent()
	if parent.has_node("ComponentHealth"):
		parent.damage(damage)
