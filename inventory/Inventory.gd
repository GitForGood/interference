extends Resource
class_name Inventory

signal update

@export var width: int = 1
@export var height: int = 1
@export var item_slots: Array[InventorySlot]

func insert(item: InventoryItem):
	var index = first_valid_insert_index(item)
	if (index == -1):
		return
	var points = points_for_item(item)
	var origin = points[0]
	for point in points:
		var slot = item_slots[coordinate_to_index(point)]
		slot.item = item
		slot.head = origin - point
	update.emit()

func first_valid_insert_index(item: InventoryItem) -> int:
	for index in item_slots.size():
		if is_valid_location_for_item(item, index_to_coordinate(index)):
			return index
	return -1

func points_for_item(item: InventoryItem) -> Array[Vector2]:
	var points: Array[Vector2] = []
	points.resize(item.horizontal_slots * item.vertical_slots)
	var horizontal
	var vertical
	if item.flipped:
		horizontal = item.vertical_slots
		vertical = item.horizontal_slots
	else:
		horizontal = item.horizontal_slots
		vertical = item.vertical_slots
	for x in horizontal:
		for y in vertical:
			points.append(Vector2(x,y))
	return points


func is_valid_location_for_item(item: InventoryItem, coordinate: Vector2) -> bool:
	var points = points_for_item(item).map(func(vec): return vec + coordinate)
	return points\
		.map(func(it): return item_slots[coordinate_to_index(it)])\
		.all(func(it): it.item == null)
	pass

func coordinates_to_index(x: int, y: int) -> int:
	if x < 0 or x >= width:
		return -1
	if y < 0 or y >= height:
		return -1
	return int(height*y + x)

func coordinate_to_index(coordinate: Vector2) -> int:
	if coordinate.x < 0 or coordinate.x >= width:
		return -1
	if coordinate.y < 0 or coordinate.y >= height:
		return -1
	return int(height*coordinate.y + coordinate.x)

func index_to_coordinate(index: int) -> Vector2:
	if index < 0 or index >= item_slots.size():
		return Vector2.INF
	return Vector2(index % width, index / height)
	pass
