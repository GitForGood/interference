extends Resource
class_name WeightedLootTable

@export var weights: Array[int]
@export var items: Array[InventoryItem]
var max_weight: int

func poll(result: int):
	var index = 0
	var accumulator = 0
	for weight in weights:
		if result < accumulator:
			return items[index]
		index += 1
		accumulator+=weight
	return null

func get_max_weight() -> int:
	if not max_weight:
		max_weight = weights.reduce(func(acc, elem): return acc + elem, 0)
	return max_weight

func poll_random():
	return poll(randi()%get_max_weight())
