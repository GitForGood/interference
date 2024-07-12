extends Payload
class_name PayloadPushConstant

@export var force: float

func deliver(origin: Vector2, onto: Area2D):
	var parent = onto.get_parent()
	var pushable_component: PushableComponent = parent.get_node("ComponentPushable")
	if pushable_component:
		pushable_component.push((parent.global_position - origin).normalized() * force)
