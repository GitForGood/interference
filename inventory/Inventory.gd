extends Resource
class_name Inventory

signal update

@export var width: int
@export var height: int
@export var item_slots: Array[InventorySlot]

func insert(item: InventoryItem):
	#calculate size of item and its offsets and store in array of points
	var offsets = []
	var dimensions = Vector2.ZERO
	if item.flipped:
		dimensions.x = item.vertical_slots
		dimensions.y = item.horizontal_slots
	else:
		dimensions.x = item.horizontal_slots
		dimensions.y = item.vertical_slots
	for x in dimensions.x:
		for y in dimensions.y:
			offsets.append(Vector2(x,y))
	# for each index of the inventory bounded by the item dimensions
	# check if all the slots confined by item are within the inventory
	# also check if they are empty
	for y in height - (dimensions.y-1):
		for x in width - (dimensions.x-1):
			var item_slot_position = Vector2(x,y)
			if item_slots[point_to_index(item_slot_position)].item:
				continue
			for offset in offsets:
				if not point_is_within_inventory(offset + item_slot_position):
					continue
				if item_slots[point_to_index(offset + item_slot_position)].item:
					continue
			# if all the slots are valid and empty, insert item into inventory and emit update signal
			for offset in offsets:
				var slot = item_slots[point_to_index(offset + item_slot_position)]
				slot.item = item
				slot.head = offset * -1
			update.emit()
			return

# lower is inclusive, upper is exclusive
func is_within_bounds(lower: int, upper: int, value: int):
	return value >= lower && upper > value

func point_can_fit_item(item: InventoryItem, coordinate: Vector2) -> bool:
	var offsets = []
	offsets.resize(item.vertical_slots * item.horizontal_slots)
	var dimensions = Vector2.ZERO
	if item.flipped:
		dimensions.x = item.vertical_slots
		dimensions.y = item.horizontal_slots
	else:
		dimensions.x = item.horizontal_slots
		dimensions.y = item.vertical_slots
	for x in dimensions.x:
		for y in dimensions.y:
			offsets.append(Vector2(x,y))
	for offset in offsets:
		var point = offset + coordinate
		if not point_is_within_inventory(point):
			return false
		if item_slots[point_to_index(point)].item:
			return false
	return true

func point_is_within_inventory(coordinate: Vector2) -> bool:
	return is_within_bounds(0,width, coordinate.x) && is_within_bounds(0,height, coordinate.y)

func get_slot(point: Vector2) -> InventorySlot:
	return item_slots[point_to_index(point)]

func point_to_index(coordinate: Vector2) -> int:
	if point_is_within_inventory(coordinate):
		return int(height*coordinate.y + coordinate.x)
	return -1

func index_to_point(index: int) -> Vector2:
	if index < 0 or index >= item_slots.size():
		return Vector2.INF
	return Vector2(index % width, index / height)
	pass
