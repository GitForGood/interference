extends Payload
class_name PayloadPushDissipated

@export var force: float
@export var range: float

func deliver(origin: Vector2, onto: Area2D):
	var parent = onto.get_parent()
	var pushable_component: PushableComponent = parent.get_node("ComponentPushable")
	if pushable_component:
		var percent_of_range = 1.0 - (origin - parent.global_position).length() / range
		var force_relative = force * (percent_of_range**2)
		pushable_component.push((parent.global_position - origin).normalized() * force_relative)
