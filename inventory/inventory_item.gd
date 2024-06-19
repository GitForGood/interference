extends Resource
class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var vertical_slots: int = 1
@export var horizontal_slots: int = 1
@export var flipped: bool = false

func flip():
	flipped =! flipped
	emit_changed()