extends Area2D
class_name HitBox

@export var payloads: Array[Payload]

signal hit(target: HurtBox)

func deliver_onto_hurt_box(hurt_box: HurtBox):
	for payload in payloads:
		payload.deliver(position, hurt_box)

func _on_area_entered(area):
	if area is HurtBox:
		deliver_onto_hurt_box(area)
		hit.emit(area)
