extends Node

@export var inertia: float = 1.0

var impact: Vector2

func _ready():
	impact = Vector2.ZERO

func _process(delta):
	impact = lerp(impact, Vector2.ZERO, inertia * delta)
	get_parent().translate(impact*delta)

func push(impact_vector: Vector2):
	impact += impact_vector
