extends Payload
class_name PayloadDamageConstant

@export var damage: float

func deliver(origin: Vector2, onto: Area2D):
	var health_component: HealthComponent = onto.get_parent().get_node("ComponentHealth")
	if health_component:
		health_component.damage(damage, origin)
