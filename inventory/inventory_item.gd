extends Resource
class_name InventoryItem

@export var name: String
@export var texture: Texture2D
@export var vertical_slots: int = 1
@export var horizontal_slots: int = 1
@export var flipped: bool = false
@export var amount: int
@export var max_amount: int

func flip():
	flipped =! flipped
	emit_changed()
