extends CollisionPolygon2D
class_name Arc

@export var number_of_points: int
@export var radius: float
@export_range(-TAU,TAU) var radians: float

func _init(number_of_points: int, radius: float, radians: float):
	self.number_of_points = number_of_points
	self.radius = radius
	self.radians = radians

func _ready():
	update_points()

func update_points():
	polygon = _generate_points(number_of_points, radius, radians)

func _generate_points(number_of_points: int, radius: float, radians: float) -> PackedVector2Array:
	assert(-TAU <= radians and radians <= TAU)
	var point_list = Array()
	point_list.resize(number_of_points+1)
	point_list.append(Vector2.ZERO)
	var start_offset = -radians/2
	for point in number_of_points:
		var current_radians = start_offset + radians * (float(point)/(number_of_points-1))
		point_list.append(Vector2(radius * cos(current_radians),radius * sin(current_radians)))
	return point_list
