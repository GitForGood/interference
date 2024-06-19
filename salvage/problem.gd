extends Resource
class_name Problem

@export var solutions: Array[Solution]
@export var next_problem: Problem
@export_category("success")
@export var successful_loot_table: WeightedLootTable
@export var successful_loot_rolls: int
@export_category("fail")
@export var failed_loot_table: WeightedLootTable
@export var failed_loot_rolls: int


#returns possible solutions with item. null if 
func can_solve(item) -> Array[Solution]:
	return solutions.filter(func(sol): return item.solutions.has(sol))
