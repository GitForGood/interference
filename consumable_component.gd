extends Node
class_name ConsumableComponent

var required_item: String
var required_amount: int
var consumes: bool = true

signal consumed(item, amount)
signal insufficient_consumables(required_item, required_amount, recieved_item, recieved_amount)

func consume(inventory: Inventory):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
