extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.texture = slot.item.texture
		item_visual.visible = true
