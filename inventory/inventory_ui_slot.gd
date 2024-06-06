extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay

# Called when the node enters the scene tree for the first time.
func update(item: InventoryItem):
	pass # Replace with function body.
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
