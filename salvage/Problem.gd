extends Resource
class_name Problem

@export var instant_solutions: Array[Solution]
@export var combinatory_solutions: Array[SolutionCluster]

func can_solve(item) -> bool:
	var instant = instant_solutions.any(func(sol): return item.solutions.has(sol))
	if instant:
		return true
	for array in combinatory_solutions:
		var combination = array.all(func(sol): return item.solutions.has(sol))
		if combination:
			return true
	return false
