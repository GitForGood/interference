extends Payload
class_name PayloadPushConstant

@export var force: float

func deliver(origin: Vector2, onto: Area2D):
	if onto.get_parent().has_node("ComponentPushable"):
		onto.get_parent().push((onto.get_parent().global_position - origin).normalized() * force)
