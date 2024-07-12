extends Payload
class_name PayloadDamageDissipated

@export var damage: float
@export var range: float

func deliver(origin: Vector2, onto: Area2D):
	var parent = onto.get_parent()
	var health_component: HealthComponent = parent.get_node("ComponentHealth")
	if health_component:
		var percent_of_range = 1.0 - (origin - parent.global_position).length() / range
		health_component.damage(damage * (percent_of_range**2), origin)
